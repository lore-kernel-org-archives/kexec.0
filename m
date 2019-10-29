Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iPK3t-000858-JL
 for kexec@lists.infradead.org; Tue, 29 Oct 2019 05:28:59 +0000
Date: Tue, 29 Oct 2019 13:28:42 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/2 v7] x86/kdump: always reserve the low 1MiB when the
 crashkernel option is specified
Message-ID: <20191029052842.GA7616@MiWiFi-R3L-srv>
References: <20191029021059.22070-1-lijiang@redhat.com>
 <20191029021059.22070-2-lijiang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191029021059.22070-2-lijiang@redhat.com>
Content-Disposition: inline
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
To: Lianbo Jiang <lijiang@redhat.com>
Cc: jgross@suse.com, Thomas.Lendacky@amd.com, horms@verge.net.au, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, mingo@redhat.com, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, d.hatayama@fujitsu.com, vgoyal@redhat.com

On 10/29/19 at 10:10am, Lianbo Jiang wrote:
> Kdump kernel will reuse the first 640k region because the real mode
> trampoline has to work in this area. When the vmcore is dumped, the
> old memory in this area may be accessed, therefore, kernel has to
> copy the contents of the first 640k area to a backup region so that
> kdump kernel can read the old memory from the backup area of the
> first 640k area, which is done in the purgatory().
> 
> But, the current handling of copying the first 640k area runs into
> problems when SME is enabled, kernel does not properly copy these
> old memory to the backup area in the purgatory(), thereby, kdump
> kernel reads out the encrypted contents, because the kdump kernel
> must access the first kernel's memory with the encryption bit set
> when SME is enabled in the first kernel. Please refer to this link:
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=204793
> 
> Finally, it causes the following errors, and the crash tool gets
> invalid pointers when parsing the vmcore.
> 
> crash> kmem -s|grep -i invalid
> kmem: dma-kmalloc-512: slab:ffffd77680001c00 invalid freepointer:a6086ac099f0c5a4
> kmem: dma-kmalloc-512: slab:ffffd77680001c00 invalid freepointer:a6086ac099f0c5a4
> crash>
> 
> To avoid the above errors, when the crashkernel option is specified,
> lets reserve the remaining low 1MiB memory(after reserving real mode
> memory) so that the allocated memory does not fall into the low 1MiB
> area, which makes us not to copy the first 640k content to a backup
> region in purgatory(). This indicates that it does not need to be
> included in crash dumps or used for anything except the processor
> trampolines that must live in the low 1MiB.
> 
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
>  arch/x86/include/asm/crash.h |  6 ++++++
>  arch/x86/kernel/crash.c      | 15 +++++++++++++++
>  arch/x86/realmode/init.c     |  2 ++
>  3 files changed, 23 insertions(+)
> 
> diff --git a/arch/x86/include/asm/crash.h b/arch/x86/include/asm/crash.h
> index 0acf5ee45a21..3e966a3dc823 100644
> --- a/arch/x86/include/asm/crash.h
> +++ b/arch/x86/include/asm/crash.h
> @@ -8,4 +8,10 @@ int crash_setup_memmap_entries(struct kimage *image,
>  		struct boot_params *params);
>  void crash_smp_send_stop(void);
>  
> +#ifdef CONFIG_KEXEC_CORE
> +void __init kexec_reserve_low_1MiB(void);
> +#else
> +static inline void __init kexec_reserve_low_1MiB(void) { }
> +#endif
> +
>  #endif /* _ASM_X86_CRASH_H */
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index eb651fbde92a..144f519aef29 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -24,6 +24,7 @@
>  #include <linux/export.h>
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
> +#include <linux/memblock.h>
>  
>  #include <asm/processor.h>
>  #include <asm/hardirq.h>
> @@ -39,6 +40,7 @@
>  #include <asm/virtext.h>
>  #include <asm/intel_pt.h>
>  #include <asm/crash.h>
> +#include <asm/cmdline.h>
>  
>  /* Used while preparing memory map entries for second kernel */
>  struct crash_memmap_data {
> @@ -68,6 +70,19 @@ static inline void cpu_crash_vmclear_loaded_vmcss(void)
>  	rcu_read_unlock();
>  }
>  
> +/*
> + * When the crashkernel option is specified, only use the low
> + * 1MiB for the real mode trampoline.
> + */
> +void __init kexec_reserve_low_1MiB(void)

Thanks for the effort, Lianbo. I believe everyone is confident with this
solution and fix.

I have a tiny concern, why the function name is
kexec_reserve_low_1MiB(), but not kexec_reserve_low_1M()?
I searched in kernel code with below filter, didn't see MiB appearing in
a function name. I am not sure about it either, just ask.

git grep "_[1-9]*M " arch/ kernel/ mm include/ drivers/ net/ init fs crypto/ certs/ ipc lib

Thanks
Baoquan

> +{
> +	if (cmdline_find_option(boot_command_line, "crashkernel",
> +				NULL, 0) > 0) {
> +		memblock_reserve(0, 1<<20);
> +		pr_info("Reserving the low 1MiB of memory for crashkernel\n");
> +	}
> +}
> +
>  #if defined(CONFIG_SMP) && defined(CONFIG_X86_LOCAL_APIC)
>  
>  static void kdump_nmi_callback(int cpu, struct pt_regs *regs)
> diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
> index 7dce39c8c034..b8bbd0017ca8 100644
> --- a/arch/x86/realmode/init.c
> +++ b/arch/x86/realmode/init.c
> @@ -8,6 +8,7 @@
>  #include <asm/pgtable.h>
>  #include <asm/realmode.h>
>  #include <asm/tlbflush.h>
> +#include <asm/crash.h>
>  
>  struct real_mode_header *real_mode_header;
>  u32 *trampoline_cr4_features;
> @@ -34,6 +35,7 @@ void __init reserve_real_mode(void)
>  
>  	memblock_reserve(mem, size);
>  	set_real_mode_mem(mem);
> +	kexec_reserve_low_1MiB();
>  }
>  
>  static void __init setup_real_mode(void)
> -- 
> 2.17.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
