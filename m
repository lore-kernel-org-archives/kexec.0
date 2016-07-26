Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bRteN-0005GK-7w
 for kexec@lists.infradead.org; Tue, 26 Jul 2016 04:07:24 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1469501995-2991-1-git-send-email-weijg.fnst@cn.fujitsu.com>
 <1469501995-2991-4-git-send-email-weijg.fnst@cn.fujitsu.com>
Date: Mon, 25 Jul 2016 22:53:52 -0500
In-Reply-To: <1469501995-2991-4-git-send-email-weijg.fnst@cn.fujitsu.com> (Wei
 Jiangang's message of "Tue, 26 Jul 2016 10:59:55 +0800")
Message-ID: <87k2g92gxb.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/3] x86/apic: Improved the setting of interrupt mode
 for bsp
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
To: Wei Jiangang <weijg.fnst@cn.fujitsu.com>
Cc: bhe@redhat.com, xpang@redhat.com, joro@8bytes.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Cao jin <caoj.fnst@cn.fujitsu.com>, mingo@redhat.com, kernel@kyup.com, hpa@zytor.com, tglx@linutronix.de

Wei Jiangang <weijg.fnst@cn.fujitsu.com> writes:

> If we specify the 'notsc' parameter for the dump-capture kernel,
> and then trigger a crash(panic) by using "ALT-SysRq-c" or
> "echo c > /proc/sysrq-trigger", the dump-capture kernel will
> hang in calibrate_delay_converge() and wait for jiffies changes.
> serial log as follows:
>
>     tsc: Fast TSC calibration using PIT
>     tsc: Detected 2099.947 MHz processor
>     Calibrating delay loop...
>
> The reason for jiffies not changes is there's no timer interrupt
> passed to dump-capture kernel.
>
> In fact, once kernel panic occurs, the local APIC is disabled
> by lapic_shutdown() in reboot path.
> generly speaking, local APIC state can be initialized by BIOS
> after Power-Up or Reset, which doesn't apply to kdump case.
> so the kernel has to be responsible for initialize the interrupt
> mode properly according the latest status of APIC in bootup path.
>
> An MP operating system is booted under either PIC mode or
> virtual wire mode. Later, the operating system switches to
> symmetric I/O mode as it enters multiprocessor mode.
> Two kinds of virtual wire mode are defined in Intel MP spec:
> virtual wire mode via local APIC or via I/O APIC.
>
> Now we determine the mode of APIC only through a SMP BIOS(MP table).
> That's not enough. It's better to do further check if APIC works
> with effective interrupt mode, and then, do some proper setting.

Reading through the code let me pause a moment and say:
"Yowzers the interrupt initialization code has gotten hard to follow.  It
is now full of indirection with ill defined semantics."  pre_vector_init
indeed.

I will argue this is the wrong fix.

We really should not have to worry about getting the system functional
in virtual wire mode on a modern system.  And looking at the code
someone has done half the work and made it conditional under
acpi_gbl_reduced_hardware.

Now reduced hardware implies a bit more than we ware talking about but
if there is ACPI apic information we should not need to worry about
external interrupts and can just enable the apics.

In fact I think having MPtable information is enough for that.

So I think what needs to happens is for the apic initialization to get
an overhaul that makes apic initialization the happy path and the other
irq controllers the odd backwards compatibility path.  And when we
are done we never run in anything except full apic mode unless the
hardware doesn't support it.

I think that will leave things more robust as we don't need to setup
and then reset up the interrupts during boot.

Eric


> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> Signed-off-by: Wei Jiangang <weijg.fnst@cn.fujitsu.com>
> ---
>  arch/x86/include/asm/io_apic.h |  5 ++++
>  arch/x86/kernel/apic/apic.c    | 60 +++++++++++++++++++++++++++++++++++++++++-
>  arch/x86/kernel/apic/io_apic.c | 28 ++++++++++++++++++++
>  3 files changed, 92 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/io_apic.h b/arch/x86/include/asm/io_apic.h
> index 6cbf2cfb3f8a..a3257366bf7f 100644
> --- a/arch/x86/include/asm/io_apic.h
> +++ b/arch/x86/include/asm/io_apic.h
> @@ -190,6 +190,7 @@ static inline unsigned int io_apic_read(unsigned int apic, unsigned int reg)
>  }
>  
>  extern void setup_IO_APIC(void);
> +extern bool virt_wire_through_ioapic(void);
>  extern void enable_IO_APIC(void);
>  extern void disable_IO_APIC(void);
>  extern void setup_ioapic_dest(void);
> @@ -231,6 +232,10 @@ static inline void io_apic_init_mappings(void) { }
>  #define native_disable_io_apic		NULL
>  
>  static inline void setup_IO_APIC(void) { }
> +static inline bool virt_wire_through_ioapic(void)
> +{
> +	return false;
> +}
>  static inline void enable_IO_APIC(void) { }
>  static inline void setup_ioapic_dest(void) { }
>  
> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index 8e25b9b2d351..a3939fb130cc 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -1124,6 +1124,58 @@ void __init sync_Arb_IDs(void)
>  }
>  
>  /*
> + * Check APIC enable/disable flag
> + */
> +static bool check_apic_enabled(void)
> +{
> +	unsigned int value;
> +
> +	/*
> +	 * If APIC is disabled globally (IA32_APIC_BASE[11] == 0)
> +	 * the boot cpu hasn't X86_FEATURE_APIC,
> +	 * and init_bsp_APIC() has already checked it before.
> +	 * so no need to check global enable/disable flag here
> +	 */
> +
> +	/* Check the software enable/disable flag */
> +	value = apic_read(APIC_SPIV);
> +	if (!(value & APIC_SPIV_APIC_ENABLED))
> +		return false;
> +
> +	return true;
> +}
> +
> +/*
> + * Return false means the through-local-APIC virtual wire mode is inactive
> + */
> +static bool virt_wire_through_lapic(void)
> +{
> +	unsigned int value;
> +
> +	/*
> +	 * The through-local-APIC virtual wire mode requests
> +	 * local APIC to enable LINT0 for ExtINT delivery mode
> +	 * and LINT1 for NMI delivery mode
> +	 */
> +	value = apic_read(APIC_LVT0);
> +	if (GET_APIC_DELIVERY_MODE(value) != APIC_MODE_EXTINT)
> +		return false;
> +
> +	value = apic_read(APIC_LVT1);
> +	if (GET_APIC_DELIVERY_MODE(value) != APIC_MODE_NMI)
> +		return false;
> +
> +	return true;
> +}
> +
> +static bool check_virt_wire_mode(void)
> +{
> +	/* If neither of virtual wire mode is active, return false */
> +	return (check_apic_enabled() && (virt_wire_through_lapic() ||
> +		virt_wire_through_ioapic()));
> +}
> +
> +/*
>   * An initial setup of the virtual wire mode.
>   */
>  void __init init_bsp_APIC(void)
> @@ -1133,8 +1185,14 @@ void __init init_bsp_APIC(void)
>  	/*
>  	 * Don't do the setup now if we have a SMP BIOS as the
>  	 * through-I/O-APIC virtual wire mode might be active.
> +	 *
> +	 * It's better to do further check if either through-I/O-APIC
> +	 * or through-local-APIC is active.
> +	 * the worst case is that both of them are inactive, If so,
> +	 * we need to enable the through-local-APIC virtual wire mode
>  	 */
> -	if (smp_found_config || !boot_cpu_has(X86_FEATURE_APIC))
> +	if (pic_mode || !boot_cpu_has(X86_FEATURE_APIC) ||
> +	    (smp_found_config && check_virt_wire_mode()))
>  		return;
>  
>  	/*
> diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
> index 446702ed99dc..f794d389ba85 100644
> --- a/arch/x86/kernel/apic/io_apic.c
> +++ b/arch/x86/kernel/apic/io_apic.c
> @@ -1379,6 +1379,34 @@ void __init print_IO_APICs(void)
>  /* Where if anywhere is the i8259 connect in external int mode */
>  static struct { int pin, apic; } ioapic_i8259 = { -1, -1 };
>  
> +/*
> + * Return false means the through-I/O-APIC virtual wire mode is inactive
> + */
> +bool virt_wire_through_ioapic(void)
> +{
> +	int apic, pin;
> +
> +	for_each_ioapic_pin(apic, pin) {
> +		/* See if any of the pins is in ExtINT mode */
> +		struct IO_APIC_route_entry entry = ioapic_read_entry(apic, pin);
> +
> +		/*
> +		 * If the interrupt line is enabled and in ExtInt mode
> +		 * I have found the pin where the i8259 is connected.
> +		 */
> +		if ((entry.mask == 0) && (entry.delivery_mode == dest_ExtINT))
> +			return true;
> +	}
> +
> +	/*
> +	 * The through-I/O-APIC virtual wire mode requests
> +	 * I/O APIC to be connected i8259 in chapter 3.6.2.2 of the MP v1.4 spec
> +	 * If no pin in ExtInt mode, the through-I/O-APIC virtual wire mode can
> +	 * be regarded as inactive
> +	 */
> +	return false;
> +}
> +
>  void __init enable_IO_APIC(void)
>  {
>  	int i8259_apic, i8259_pin;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
