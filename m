Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aIcKy-0002PV-S2
 for kexec@lists.infradead.org; Mon, 11 Jan 2016 13:16:45 +0000
Date: Mon, 11 Jan 2016 21:19:10 +0800
From: Minfei Huang <mhuang@redhat.com>
Subject: Re: [PATCH v4 1/2] kexec: Introduce a protection mechanism for the
 crashkernel reserved memory
Message-ID: <20160111131910.GA17726@dhcp-128-25.nay.redhat.com>
References: <1452480929-3606-1-git-send-email-xlpang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1452480929-3606-1-git-send-email-xlpang@redhat.com>
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
To: Xunlei Pang <xlpang@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On 01/11/16 at 10:55am, Xunlei Pang wrote:
> For the cases that some kernel (module) path stamps the crash
> reserved memory(already mapped by the kernel) where has been
> loaded the second kernel data, the kdump kernel will probably
> fail to boot when panic happens (or even not happens) leaving
> the culprit at large, this is unacceptable.
> 
> The patch introduces a mechanism for detecting such cases:
> 1) After each crash kexec loading, it simply marks the reserved
> memory regions readonly since we no longer access it after that.
> When someone stamps the region, the first kernel will panic and
> trigger the kdump. The weak arch_kexec_protect_crashkres() is
> introduced to do the actual protection.
> 
> 2) To allow multiple loading, once 1) was done we also need to
> remark the reserved memory to readwrite each time a system call
> related to kdump is made. The weak arch_kexec_unprotect_crashkres()
> is introduced to undo the actual protection.
> 
> The architecture can make its specific implementation by overriding
> arch_kexec_protect_crashkres() and arch_kexec_unprotect_crashkres().
> 
> Signed-off-by: Xunlei Pang <xlpang@redhat.com>
> ---
> v3->v4:
> No changes.
> 
>  include/linux/kexec.h | 2 ++
>  kernel/kexec.c        | 9 ++++++++-
>  kernel/kexec_core.c   | 6 ++++++
>  kernel/kexec_file.c   | 8 +++++++-
>  4 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 7b68d27..ebd6950 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -329,6 +329,8 @@ int __weak arch_kexec_apply_relocations_add(const Elf_Ehdr *ehdr,
>  					Elf_Shdr *sechdrs, unsigned int relsec);
>  int __weak arch_kexec_apply_relocations(const Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
>  					unsigned int relsec);
> +void arch_kexec_protect_crashkres(void);
> +void arch_kexec_unprotect_crashkres(void);
>  
>  #else /* !CONFIG_KEXEC_CORE */
>  struct pt_regs;
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index d873b64..3680f9c 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -167,8 +167,12 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
>  		return -EBUSY;
>  
>  	dest_image = &kexec_image;
> -	if (flags & KEXEC_ON_CRASH)
> +	if (flags & KEXEC_ON_CRASH) {
>  		dest_image = &kexec_crash_image;
> +		if (kexec_crash_image)
> +			arch_kexec_unprotect_crashkres();
> +	}
> +
>  	if (nr_segments > 0) {
>  		unsigned long i;
>  
> @@ -211,6 +215,9 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
>  	image = xchg(dest_image, image);
>  
>  out:
> +	if ((flags & KEXEC_ON_CRASH) && kexec_crash_image)
> +		arch_kexec_protect_crashkres();
> +
>  	mutex_unlock(&kexec_mutex);
>  	kimage_free(image);
>  
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index c823f30..de4dd80 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1560,3 +1560,9 @@ void __weak crash_map_reserved_pages(void)
>  
>  void __weak crash_unmap_reserved_pages(void)
>  {}
> +
> +void __weak arch_kexec_protect_crashkres(void)
> +{}
> +
> +void __weak arch_kexec_unprotect_crashkres(void)
> +{}
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index b70ada0..5892d6a 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -327,8 +327,11 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>  		return -EBUSY;
>  
>  	dest_image = &kexec_image;
> -	if (flags & KEXEC_FILE_ON_CRASH)
> +	if (flags & KEXEC_FILE_ON_CRASH) {
>  		dest_image = &kexec_crash_image;
> +		if (kexec_crash_image)
> +			arch_kexec_unprotect_crashkres();
> +	}
>  
>  	if (flags & KEXEC_FILE_UNLOAD)
>  		goto exchange;
> @@ -377,6 +380,9 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>  exchange:
>  	image = xchg(dest_image, image);
>  out:
> +	if ((flags & KEXEC_FILE_ON_CRASH) && kexec_crash_image)
> +		arch_kexec_protect_crashkres();
> +
>  	mutex_unlock(&kexec_mutex);
>  	kimage_free(image);
>  	return ret;
> -- 
> 2.5.0
> 

Reviewed-by: Minfei Huang <mhuang@redhat.com>

Thanks
Minfei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
