Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UFfQS-00067y-7e
 for kexec@lists.infradead.org; Wed, 13 Mar 2013 06:44:38 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1363156381-2881-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1363156381-2881-8-git-send-email-iamjoonsoo.kim@lge.com>
Date: Tue, 12 Mar 2013 23:43:48 -0700
In-Reply-To: <1363156381-2881-8-git-send-email-iamjoonsoo.kim@lge.com>
 (Joonsoo Kim's message of "Wed, 13 Mar 2013 15:32:59 +0900")
Message-ID: <87k3pbsst7.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 7/8] mm, vmalloc: export vmap_area_list,
 instead of vmlist
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Bob Liu <lliubbo@gmail.com>, Joonsoo Kim <js1304@gmail.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, Dave Anderson <anderson@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

Joonsoo Kim <iamjoonsoo.kim@lge.com> writes:

> From: Joonsoo Kim <js1304@gmail.com>
>
> Although our intention is to unexport internal structure entirely,
> but there is one exception for kexec. kexec dumps address of vmlist
> and makedumpfile uses this information.
>
> We are about to remove vmlist, then another way to retrieve information
> of vmalloc layer is needed for makedumpfile. For this purpose,
> we export vmap_area_list, instead of vmlist.

That seems entirely reasonable to me.  Usage by kexec should not limit
the evoluion of the kernel especially usage by makedumpfile.

Atsushi Kumagai can you make makedumpfile work with this change?

Eric

> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Dave Anderson <anderson@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
> Signed-off-by: Joonsoo Kim <js1304@gmail.com>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 698b1e5..8a25f90 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -130,8 +130,7 @@ extern long vwrite(char *buf, char *addr, unsigned long count);
>  /*
>   *	Internals.  Dont't use..
>   */
> -extern rwlock_t vmlist_lock;
> -extern struct vm_struct *vmlist;
> +extern struct list_head vmap_area_list;
>  extern __init void vm_area_add_early(struct vm_struct *vm);
>  extern __init void vm_area_register_early(struct vm_struct *vm, size_t align);
>  
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index bddd3d7..d9bfc6c 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -1489,7 +1489,7 @@ static int __init crash_save_vmcoreinfo_init(void)
>  	VMCOREINFO_SYMBOL(swapper_pg_dir);
>  #endif
>  	VMCOREINFO_SYMBOL(_stext);
> -	VMCOREINFO_SYMBOL(vmlist);
> +	VMCOREINFO_SYMBOL(vmap_area_list);
>  
>  #ifndef CONFIG_NEED_MULTIPLE_NODES
>  	VMCOREINFO_SYMBOL(mem_map);
> diff --git a/mm/nommu.c b/mm/nommu.c
> index e193280..ed82358 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -228,8 +228,7 @@ int follow_pfn(struct vm_area_struct *vma, unsigned long address,
>  }
>  EXPORT_SYMBOL(follow_pfn);
>  
> -DEFINE_RWLOCK(vmlist_lock);
> -struct vm_struct *vmlist;
> +LIST_HEAD(vmap_area_list);
>  
>  void vfree(const void *addr)
>  {
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index bda6cef..7e63984 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -261,7 +261,8 @@ struct vmap_area {
>  };
>  
>  static DEFINE_SPINLOCK(vmap_area_lock);
> -static LIST_HEAD(vmap_area_list);
> +/* Export for kexec only */
> +LIST_HEAD(vmap_area_list);
>  static struct rb_root vmap_area_root = RB_ROOT;
>  
>  /* The vmap cache globals are protected by vmap_area_lock */
> @@ -272,6 +273,10 @@ static unsigned long cached_align;
>  
>  static unsigned long vmap_area_pcpu_hole;
>  
> +/*** Old vmalloc interfaces ***/
> +static DEFINE_RWLOCK(vmlist_lock);
> +static struct vm_struct *vmlist;
> +
>  static struct vmap_area *__find_vmap_area(unsigned long addr)
>  {
>  	struct rb_node *n = vmap_area_root.rb_node;
> @@ -1283,10 +1288,6 @@ int map_vm_area(struct vm_struct *area, pgprot_t prot, struct page ***pages)
>  }
>  EXPORT_SYMBOL_GPL(map_vm_area);
>  
> -/*** Old vmalloc interfaces ***/
> -DEFINE_RWLOCK(vmlist_lock);
> -struct vm_struct *vmlist;
> -
>  static void setup_vmalloc_vm(struct vm_struct *vm, struct vmap_area *va,
>  			      unsigned long flags, const void *caller)
>  {

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
