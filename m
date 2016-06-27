Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <57715471.7020005@arm.com>
Date: Mon, 27 Jun 2016 17:29:37 +0100
From: James Morse <james.morse@arm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v20 04/14] arm64/kexec: Add core kexec support
References: <cover.1466702804.git.geoff@infradead.org>
 <018ac873d87fbfc45185cdab91ebc8731f64f94c.1466702804.git.geoff@infradead.org>
 <57710B92.2080603@arm.com>
 <20160627143939.GC6847@e104818-lin.cambridge.arm.com>
In-Reply-To: <20160627143939.GC6847@e104818-lin.cambridge.arm.com>
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
To: Catalin Marinas <catalin.marinas@arm.com>, Geoff Levand <geoff@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, marc.zyngier@arm.com, kexec@lists.infradead.org, Will Deacon <will.deacon@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, linux-arm-kernel@lists.infradead.org

Hi Catalin,

On 27/06/16 15:39, Catalin Marinas wrote:
> On Mon, Jun 27, 2016 at 12:18:42PM +0100, James Morse wrote:
>> This if() {} hunk isn't necessary with the version of cpus_are_stuck_in_kernel()
>> you have in patch 2. This logic is the '|| smp_spin_tables' part of that helper
>> function. (hibernate needed it too)
> 
> I can make the changes locally but just to be clear I understand what
> you meant, here's the diff on top of Geoff's patch:

Ah, I see my 'if() {}' comment is ambiguous as there are two ...

> 
> ----8<-------------------------
> 
> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index 945ce326654c..bc96c8a7fc79 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -68,24 +68,9 @@ int machine_kexec_prepare(struct kimage *kimage)
>  
>  	kexec_image_info(kimage);
>  
> -	if (kimage->type != KEXEC_TYPE_CRASH) {
> -		if (cpus_are_stuck_in_kernel()) {
> -			pr_err("Can't kexec: failed CPUs are stuck in the kernel.\n");
> -			return -EBUSY;
> -		}
> -
> -		if (num_online_cpus() > 1) {
> -			if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
> -				/* any_cpu as we don't mind being preempted */
> -				int any_cpu = raw_smp_processor_id();
> -
> -				if (cpu_ops[any_cpu]->cpu_die)
> -					return 0;
> -			}
> -
> -			pr_err("Can't kexec: no mechanism to offline secondary CPUs.\n");
> -			return -EBUSY;
> -		}
> +	if (kimage->type != KEXEC_TYPE_CRASH && cpus_are_stuck_in_kernel()) {
> +		pr_err("Can't kexec: CPUs are stuck in the kernel.\n");
> +		return -EBUSY;
>  	}
>  
>  	return 0;
> @@ -163,7 +148,7 @@ void machine_kexec(struct kimage *kimage)
>  	/*
>  	 * New cpus may have become stuck_in_kernel after we loaded the image.
>  	 */
> -	BUG_ON(cpus_are_stuck_in_kernel() && (num_online_cpus() > 1));
> +	BUG_ON(cpus_are_stuck_in_kernel() || (num_online_cpus() > 1));
>  
>  	reboot_code_buffer_phys = page_to_phys(kimage->control_code_page);
>  	reboot_code_buffer = phys_to_virt(reboot_code_buffer_phys);
> 

Yes, that's what I meant, thanks Catalin.

The 'num_online_cpus() > 1' is still needed as disable_nonboot_cpus() called via
machine_shutdown() may have failed and this is where we check. (we can't return
an error from either path).

Geoff, I assume you agree?


Thanks,

James



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
