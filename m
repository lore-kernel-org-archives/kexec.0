Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <57710B92.2080603@arm.com>
Date: Mon, 27 Jun 2016 12:18:42 +0100
From: James Morse <james.morse@arm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v20 04/14] arm64/kexec: Add core kexec support
References: <cover.1466702804.git.geoff@infradead.org>
 <018ac873d87fbfc45185cdab91ebc8731f64f94c.1466702804.git.geoff@infradead.org>
In-Reply-To: <018ac873d87fbfc45185cdab91ebc8731f64f94c.1466702804.git.geoff@infradead.org>
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

On 23/06/16 18:54, Geoff Levand wrote:
> Add three new files, kexec.h, machine_kexec.c and relocate_kernel.S to the
> arm64 architecture that add support for the kexec re-boot mechanism
> (CONFIG_KEXEC) on arm64 platforms.

> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> new file mode 100644
> index 0000000..e2904c4
> --- /dev/null
> +++ b/arch/arm64/kernel/machine_kexec.c
> +/**
> + * machine_kexec_prepare - Prepare for a kexec reboot.
> + *
> + * Called from the core kexec code when a kernel image is loaded.
> + * Forbid loading a kexec kernel if we have no way of hotplugging cpus or cpus
> + * are stuck in the kernel. This avoids a panic once we hit machine_kexec().
> + */
> +int machine_kexec_prepare(struct kimage *kimage)
> +{
> +	kimage_start = kimage->start;
> +
> +	if (kimage->type != KEXEC_TYPE_CRASH) {
> +		if (cpus_are_stuck_in_kernel()) {
> +			pr_err("Can't kexec: failed CPUs are stuck in the kernel.\n");

We may want to change the word 'failed' here, the helper function now also
covers systems that boot secondary processors with spin tables that are stuck in
the secondary_holding_pen:
> "Can't kexec: secondary CPUs are stuck in the kernel.\n"


> +			return -EBUSY;
> +		}
> +



> +		if (num_online_cpus() > 1) {
> +			if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
> +				/* any_cpu as we don't mind being preempted */
> +				int any_cpu = raw_smp_processor_id();
> +
> +				if (cpu_ops[any_cpu]->cpu_die)
> +					return 0;
> +			}
> +
> +			pr_err("Can't kexec: no mechanism to offline secondary CPUs.\n");
> +			return -EBUSY;
> +		}

This if() {} hunk isn't necessary with the version of cpus_are_stuck_in_kernel()
you have in patch 2. This logic is the '|| smp_spin_tables' part of that helper
function. (hibernate needed it too)



> +	}
> +
> +	return 0;
> +}
> +

[ ... ]

> +/**
> + * machine_kexec - Do the kexec reboot.
> + *
> + * Called from the core kexec code for a sys_reboot with LINUX_REBOOT_CMD_KEXEC.
> + */
> +void machine_kexec(struct kimage *kimage)
> +{
> +	phys_addr_t reboot_code_buffer_phys;
> +	void *reboot_code_buffer;
> +
> +	/*
> +	 * New cpus may have become stuck_in_kernel after we loaded the image.
> +	 */
> +	BUG_ON(cpus_are_stuck_in_kernel() && (num_online_cpus() > 1));

BUG_ON(cpus_are_stuck_in_kernel() || (num_online_cpus() > 1));


Thanks,

James


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
