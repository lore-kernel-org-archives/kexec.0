Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bsEzu-0003ki-2e
 for kexec@lists.infradead.org; Thu, 06 Oct 2016 20:10:31 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1475743561-23912-1-git-send-email-bhe@redhat.com>
Date: Thu, 06 Oct 2016 15:07:53 -0500
In-Reply-To: <1475743561-23912-1-git-send-email-bhe@redhat.com> (Baoquan He's
 message of "Thu, 6 Oct 2016 16:46:01 +0800")
Message-ID: <877f9lckbq.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec: Export memory sections virtual addresses to
 vmcoreinfo
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
To: Baoquan He <bhe@redhat.com>
Cc: keescook@chromium.org, ats-kumagai@wm.jp.nec.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, thgarnie@google.com, takahiro.akashi@linaro.org, mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org, tonli@redhat.com

Baoquan He <bhe@redhat.com> writes:

> KASLR memory randomization can randomize the base of the physical memory
> mapping (PAGE_OFFSET), vmalloc (VMALLOC_START) and vmemmap
> (VMEMMAP_START). These need be exported to VMCOREINFO so that user space
> utility, mainly makedumpfile can use them to identify the base of each
> memory section. Here using VMCOREINFO_NUMBER we can reuse the existing
> struct number_table in makedumpfile to import data easily.
>
> Since they are related to x86_64 only, put them into
> arch_crash_save_vmcoreinfo. And move the exportion of KERNEL_IMAGE_SIZE
> together since it's also for x86_64 only.

*Scratches my head*  I would have thought this information would have
better fit in the ELF header.  Where it actually has a field for virtual
address.  It also has a field for physical address, and a third field
for offset in the file (which is where the kdump finds these things in
memory aftewards).

Why do we need need more magic vmcoreinfo to handle this?

Eric

 
>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/x86/kernel/machine_kexec_64.c | 4 ++++
>  kernel/kexec_core.c                | 3 ---
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index 5a294e4..e150dd7 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -337,6 +337,10 @@ void arch_crash_save_vmcoreinfo(void)
>  #endif
>  	vmcoreinfo_append_str("KERNELOFFSET=%lx\n",
>  			      kaslr_offset());
> +	VMCOREINFO_NUMBER(KERNEL_IMAGE_SIZE);
> +	VMCOREINFO_NUMBER(PAGE_OFFSET);
> +	VMCOREINFO_NUMBER(VMALLOC_START);
> +	VMCOREINFO_NUMBER(VMEMMAP_START);
>  }
>  
>  /* arch-dependent functionality related to kexec file-based syscall */
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 5616755..8ad3a29e 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1467,9 +1467,6 @@ static int __init crash_save_vmcoreinfo_init(void)
>  #endif
>  	VMCOREINFO_NUMBER(PG_head_mask);
>  	VMCOREINFO_NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE);
> -#ifdef CONFIG_X86
> -	VMCOREINFO_NUMBER(KERNEL_IMAGE_SIZE);
> -#endif
>  #ifdef CONFIG_HUGETLB_PAGE
>  	VMCOREINFO_NUMBER(HUGETLB_PAGE_DTOR);
>  #endif

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
