Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v9 13/18] arm64: kexec: add expandable argument to
 relocation function
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
 <20200326032420.27220-14-pasha.tatashin@soleen.com>
From: James Morse <james.morse@arm.com>
Message-ID: <012e19d9-97d6-805a-bfec-8c6e7104f852@arm.com>
Date: Thu, 7 May 2020 17:22:17 +0100
MIME-Version: 1.0
In-Reply-To: <20200326032420.27220-14-pasha.tatashin@soleen.com>
Content-Language: en-GB
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
To: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: sashal@kernel.org, mark.rutland@arm.com, vladimir.murzin@arm.com, corbet@lwn.net, catalin.marinas@arm.com, bhsharma@redhat.com, steve.capper@arm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, jmorris@namei.org, linux-mm@kvack.org, rfontana@redhat.com, ebiederm@xmission.com, maz@kernel.org, matthias.bgg@gmail.com, tglx@linutronix.de, will@kernel.org, selindag@gmail.com, linux-arm-kernel@lists.infradead.org

Hi Pavel,

On 26/03/2020 03:24, Pavel Tatashin wrote:
> Currently, kexec relocation function (arm64_relocate_new_kernel) accepts
> the following arguments:
> 
> head:		start of array that contains relocation information.
> entry:		entry point for new kernel or purgatory.
> dtb_mem:	first and only argument to entry.

> The number of arguments cannot be easily expended, because this
> function is also called from HVC_SOFT_RESTART, which preserves only
> three arguments. And, also arm64_relocate_new_kernel is written in
> assembly but called without stack, thus no place to move extra
> arguments to free registers.
> 
> Soon, we will need to pass more arguments: once we enable MMU we
> will need to pass information about page tables.


> Another benefit of allowing this function to accept more arguments, is that
> kernel can actually accept up to 4 arguments (x0-x3), however currently
> only one is used, but if in the future we will need for more (for example,
> pass information about when previous kernel exited to have a precise
> measurement in time spent in purgatory), we won't be easilty do that
> if arm64_relocate_new_kernel can't accept more arguments.

This is a niche debug hack.
We really don't want an ABI with purgatory. I think the register values it gets were added
early for compatibility with kexec_file_load().


> So, add a new struct: kern_reloc_arg, and place it in kexec safe page (i.e
> memory that is not overwritten during relocation).
> Thus, make arm64_relocate_new_kernel to only take one argument, that
> contains all the needed information.

Do we really not have enough registers?

The PCS[0] gives you 8 arguments. In this patch you use 6.


If this is really about the hyp-stub abi, please state that.


> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index cee3be586384..b1122eea627e 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -59,13 +60,35 @@ void machine_kexec_cleanup(struct kimage *kimage)

>  int machine_kexec_post_load(struct kimage *kimage)
>  {
>  	void *reloc_code = page_to_virt(kimage->control_code_page);
> +	struct kern_reloc_arg *kern_reloc_arg = kexec_page_alloc(kimage);
> +
> +	if (!kern_reloc_arg)
> +		return -ENOMEM;
>  
>  	memcpy(reloc_code, arm64_relocate_new_kernel,
>  	       arm64_relocate_new_kernel_size);
>  	kimage->arch.kern_reloc = __pa(reloc_code);
> +	kimage->arch.kern_reloc_arg = __pa(kern_reloc_arg);
> +	kern_reloc_arg->head = kimage->head;
> +	kern_reloc_arg->entry_addr = kimage->start;
> +	kern_reloc_arg->kern_arg0 = kimage->arch.dtb_mem;

These kern_reloc_arg values are written via the cacheable linear map.
They are read in arm64_relocate_new_kernel() where the MMU is disabled an all memory
access are non-cacheable.

To ensure you read the values you wrote, you must clean kern_reloc_arg to the PoC.


>  	kexec_image_info(kimage);
>  
>  	return 0;Thanks,

James

[0]
https://developer.arm.com/docs/ihi0055/d/procedure-call-standard-for-the-arm-64-bit-architecture

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
