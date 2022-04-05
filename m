From: Uladzislau Rezki <urezki@gmail.com>
Date: Tue, 5 Apr 2022 22:28:54 +0200
Subject: [PATCH] mm/vmalloc: fix spinning drain_vmap_work after reading
 from /proc/vmcore
In-Reply-To: <75014514645de97f2d9e087aa3df0880ea311b77.1649187356.git.osandov@fb.com>
References: <75014514645de97f2d9e087aa3df0880ea311b77.1649187356.git.osandov@fb.com>
Message-ID: <Ykymhp7W9GGMOwgf@pc638.lan>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Tue, Apr 05, 2022 at 12:40:31PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Commit 3ee48b6af49c ("mm, x86: Saving vmcore with non-lazy freeing of
> vmas") introduced set_iounmap_nonlazy(), which sets vmap_lazy_nr to
> lazy_max_pages() + 1, ensuring that any future vunmaps() immediately
> purges the vmap areas instead of doing it lazily.
> 
> Commit 690467c81b1a ("mm/vmalloc: Move draining areas out of caller
> context") moved the purging from the vunmap() caller to a worker thread.
> Unfortunately, set_iounmap_nonlazy() can cause the worker thread to spin
> (possibly forever). For example, consider the following scenario:
> 
> 1. Thread reads from /proc/vmcore. This eventually calls
>    __copy_oldmem_page() -> set_iounmap_nonlazy(), which sets
>    vmap_lazy_nr to lazy_max_pages() + 1.
> 2. Then it calls free_vmap_area_noflush() (via iounmap()), which adds 2
>    pages (one page plus the guard page) to the purge list and
>    vmap_lazy_nr. vmap_lazy_nr is now lazy_max_pages() + 3, so the
>    drain_vmap_work is scheduled.
> 3. Thread returns from the kernel and is scheduled out.
> 4. Worker thread is scheduled in and calls drain_vmap_area_work(). It
>    frees the 2 pages on the purge list. vmap_lazy_nr is now
>    lazy_max_pages() + 1.
> 5. This is still over the threshold, so it tries to purge areas again,
>    but doesn't find anything.
> 6. Repeat 5.
> 
> If the system is running with only one CPU (which is typicial for kdump)
> and preemption is disabled, then this will never make forward progress:
> there aren't any more pages to purge, so it hangs. If there is more than
> one CPU or preemption is enabled, then the worker thread will spin
> forever in the background. (Note that if there were already pages to be
> purged at the time that set_iounmap_nonlazy() was called, this bug is
> avoided.)
> 
> This can be reproduced with anything that reads from /proc/vmcore
> multiple times. E.g., vmcore-dmesg /proc/vmcore.
> 
> A simple way to "fix" this would be to make set_iounmap_nonlazy() set
> vmap_lazy_nr to lazy_max_pages() instead of lazy_max_pages() + 1. But, I
> think it'd be better to get rid of this hack of clobbering vmap_lazy_nr.
> Instead, this fix makes __copy_oldmem_page() explicitly drain the vmap
> areas itself.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  arch/x86/include/asm/io.h       |  2 +-
>  arch/x86/kernel/crash_dump_64.c |  2 +-
>  mm/vmalloc.c                    | 21 ++++++++++-----------
>  3 files changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
> index f6d91ecb8026..da466352f27c 100644
> --- a/arch/x86/include/asm/io.h
> +++ b/arch/x86/include/asm/io.h
> @@ -210,7 +210,7 @@ void __iomem *ioremap(resource_size_t offset, unsigned long size);
>  extern void iounmap(volatile void __iomem *addr);
>  #define iounmap iounmap
>  
> -extern void set_iounmap_nonlazy(void);
> +void iounmap_purge_vmap_area(void);
>  
>  #ifdef __KERNEL__
>  
> diff --git a/arch/x86/kernel/crash_dump_64.c b/arch/x86/kernel/crash_dump_64.c
> index a7f617a3981d..075dd36c502d 100644
> --- a/arch/x86/kernel/crash_dump_64.c
> +++ b/arch/x86/kernel/crash_dump_64.c
> @@ -37,8 +37,8 @@ static ssize_t __copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
>  	} else
>  		memcpy(buf, vaddr + offset, csize);
>  
> -	set_iounmap_nonlazy();
>  	iounmap((void __iomem *)vaddr);
> +	iounmap_purge_vmap_area();
>  	return csize;
>  }
>  
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index e163372d3967..48084d742688 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1671,17 +1671,6 @@ static DEFINE_MUTEX(vmap_purge_lock);
>  /* for per-CPU blocks */
>  static void purge_fragmented_blocks_allcpus(void);
>  
> -#ifdef CONFIG_X86_64
> -/*
> - * called before a call to iounmap() if the caller wants vm_area_struct's
> - * immediately freed.
> - */
> -void set_iounmap_nonlazy(void)
> -{
> -	atomic_long_set(&vmap_lazy_nr, lazy_max_pages()+1);
> -}
> -#endif /* CONFIG_X86_64 */
> -
>  /*
>   * Purges all lazily-freed vmap areas.
>   */
> @@ -1753,6 +1742,16 @@ static void purge_vmap_area_lazy(void)
>  	mutex_unlock(&vmap_purge_lock);
>  }
>  
> +#ifdef CONFIG_X86_64
> +/* Called after iounmap() to immediately free vm_area_struct's. */
> +void iounmap_purge_vmap_area(void)
> +{
> +	mutex_lock(&vmap_purge_lock);
> +	__purge_vmap_area_lazy(ULONG_MAX, 0);
> +	mutex_unlock(&vmap_purge_lock);
> +}
> +#endif /* CONFIG_X86_64 */
> +
>  static void drain_vmap_area_work(struct work_struct *work)
>  {
>  	unsigned long nr_lazy;
> -- 
> 2.35.1
> 
Indeed setting the vmap_lazy_nr to lazy_max_pages()+1 in order to
force the drain sounds like a hack.

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki

