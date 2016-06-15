Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <57618CEB.6040807@arm.com>
Date: Wed, 15 Jun 2016 18:14:19 +0100
From: James Morse <james.morse@arm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v18 04/13] arm64/kexec: Add pr_debug output
References: <cover.1465502767.git.geoff@infradead.org>
 <cfd2d457d5f1991c82b641970ce20475bcc6c7dd.1465502767.git.geoff@infradead.org>
In-Reply-To: <cfd2d457d5f1991c82b641970ce20475bcc6c7dd.1465502767.git.geoff@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi Geoff,

On 09/06/16 21:08, Geoff Levand wrote:
> To aid in debugging kexec problems or when adding new functionality to kexec add
> a new routine kexec_image_info() and several inline pr_debug statements.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
>  arch/arm64/kernel/machine_kexec.c | 63 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index 05f7c21..0a8b04d 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -11,6 +11,7 @@
>  
>  #include <linux/highmem.h>
>  #include <linux/kexec.h>
> +#include <linux/libfdt_env.h>
>  #include <linux/of_fdt.h>
>  #include <linux/slab.h>
>  #include <linux/smp.h>
> @@ -29,6 +30,47 @@ extern const unsigned long arm64_relocate_new_kernel_size;
>  
>  static unsigned long kimage_start;
>  
> +/**
> + * kexec_is_dtb - Helper routine to check the device tree header signature.
> + */
> +static bool kexec_is_dtb(const void *dtb)
> +{
> +	__be32 magic;
> +
> +	if (get_user(magic, (__be32 *)dtb))
> +		return false;
> +

You pass this function 'kimage->segment[i].buf', this looks like the user space
memory that contained the dtb when kexec-tools first ran to load the image.

This will work when you call it from machine_kexec_prepare(), but by the time we
get to machine_kexec() that process is long gone, and this pointer should be
considered junk.

I don't think its possible to find this information from machine_kexec(), as the
DTB will be split up into page size chunks and scattered through memory.


> +	return fdt32_to_cpu(magic) == OF_DT_HEADER;
> +}
> +
> +/**
> + * kexec_image_info - For debugging output.
> + */
> +#define kexec_image_info(_i) _kexec_image_info(__func__, __LINE__, _i)
> +static void _kexec_image_info(const char *func, int line,
> +	const struct kimage *kimage)
> +{
> +	unsigned long i;
> +
> +	pr_debug("%s:%d:\n", func, line);
> +	pr_debug("  kexec kimage info:\n");
> +	pr_debug("    type:        %d\n", kimage->type);
> +	pr_debug("    start:       %lx\n", kimage->start);
> +	pr_debug("    head:        %lx\n", kimage->head);
> +	pr_debug("    nr_segments: %lu\n", kimage->nr_segments);
> +
> +	for (i = 0; i < kimage->nr_segments; i++) {
> +		pr_debug("      segment[%lu]: %016lx - %016lx, 0x%lx bytes, %lu pages%s\n",
> +			i,
> +			kimage->segment[i].mem,
> +			kimage->segment[i].mem + kimage->segment[i].memsz,
> +			kimage->segment[i].memsz,
> +			kimage->segment[i].memsz /  PAGE_SIZE,
> +			(kexec_is_dtb(kimage->segment[i].buf) ?
> +				", dtb segment" : ""));
> +	}
> +}
> +
>  void machine_kexec_cleanup(struct kimage *kimage)
>  {
>  	/* Empty routine needed to avoid build errors. */
> @@ -65,6 +107,8 @@ int machine_kexec_prepare(struct kimage *kimage)
>  		}
>  	}
>  
> +	kexec_image_info(kimage);
> +

You want to put this at the start of machine_kexec_prepare(), otherwise we may
return from:
> #ifdef CONFIG_HOTPLUG_CPU
> 	/* any_cpu as we don't mind being preempted */
> 	int any_cpu = raw_smp_processor_id();
>
> 	if (cpu_ops[any_cpu]->cpu_die)
> 		return 0;
> #endif /* CONFIG_HOTPLUG_CPU */

This maybe-return-an-error block needs to be the last thing in the function.


I'm not sure if the debug output is actually useful this early: kexec-tools
prints out exactly the same information shortly after this function returns.


>  	return 0;
>  }
>  
> @@ -140,6 +184,25 @@ void machine_kexec(struct kimage *kimage)
>  	reboot_code_buffer_phys = page_to_phys(kimage->control_code_page);
>  	reboot_code_buffer = kmap(kimage->control_code_page);
>  
> +	kexec_image_info(kimage);
> +
> +	pr_debug("%s:%d: control_code_page:        %p\n", __func__, __LINE__,
> +		kimage->control_code_page);
> +	pr_debug("%s:%d: reboot_code_buffer_phys:  %pa\n", __func__, __LINE__,
> +		&reboot_code_buffer_phys);
> +	pr_debug("%s:%d: reboot_code_buffer:       %p\n", __func__, __LINE__,
> +		reboot_code_buffer);
> +	pr_debug("%s:%d: relocate_new_kernel:      %p\n", __func__, __LINE__,
> +		arm64_relocate_new_kernel);
> +	pr_debug("%s:%d: relocate_new_kernel_size: 0x%lx(%lu) bytes\n",
> +		__func__, __LINE__, arm64_relocate_new_kernel_size,
> +		arm64_relocate_new_kernel_size);
> +
> +	pr_debug("%s:%d: kimage_head:              %lx\n", __func__, __LINE__,
> +		kimage->head);
> +	pr_debug("%s:%d: kimage_start:             %lx\n", __func__, __LINE__,
> +		kimage_start);
> +
>  	/*
>  	 * Copy arm64_relocate_new_kernel to the reboot_code_buffer for use
>  	 * after the kernel is shut down.
> 


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
