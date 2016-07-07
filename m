Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bLDk1-0004Z2-GB
 for kexec@lists.infradead.org; Thu, 07 Jul 2016 18:09:38 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1467886646-2638-1-git-send-email-weijg.fnst@cn.fujitsu.com>
Date: Thu, 07 Jul 2016 12:55:29 -0500
In-Reply-To: <1467886646-2638-1-git-send-email-weijg.fnst@cn.fujitsu.com> (Wei
 Jiangang's message of "Thu, 7 Jul 2016 18:17:26 +0800")
Message-ID: <87r3b5z626.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] kexec: Fix kdump failure with notsc
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
Cc: fenghua.yu@intel.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de

Wei Jiangang <weijg.fnst@cn.fujitsu.com> writes:

> If we specify the 'notsc' boot parameter for the dump-capture kernel,
> and then trigger a crash(panic) by using "ALT-SysRq-c" or "echo c >
> /proc/sysrq-trigger",
> the dump-capture kernel will hang in calibrate_delay_converge():
>
>     /* wait for "start of" clock tick */
>     ticks = jiffies;
>     while (ticks == jiffies)
>         ; /* nothing */
>
> serial log of the hang is as follows:
>
>     tsc: Fast TSC calibration using PIT
>     tsc: Detected 2099.947 MHz processor
>     Calibrating delay loop...
>
> The reason is that the dump-capture kernel hangs in while loops and
> waits for jiffies to be updated, but no timer interrupts is passed
> to BSP by APIC.
>
> In fact, the local APIC was disabled in reboot and crash path by
> lapic_shutdown(). We need to put APIC in legacy mode in kexec jump path
> (put the system into PIT during the crash kernel),
> so that the dump-capture kernel can get timer interrupts.
>
> BTW,
> I found the buggy commit 522e66464467 ("x86/apic: Disable I/O APIC
> before shutdown of the local APIC") via bisection.
>
> Originally, I want to revert it.
> But Ingo Molnar comments that "By reverting the change can paper over
> the bug, but re-introduce the bug that can result in certain CPUs hanging
> if IO-APIC sends an APIC message if the lapic is disabled prematurely"
> And I think it's pertinent.

Sigh.  Can we please just do the work to rip out the apic shutdown code
from the kexec on panic code path?

I forgetting details but the only reason we have do any apic shutdown
is bugs in older kernels that could not initialize a system properly
if we did not shut down the apics.

I certainly don't see an issue with goofy cases like notsc not working
on a crash capture kernel if we are not initializing the hardware
properly.

The strategy really needs to be to only do the absolutely essential
hardware shutdown in the crashing kernel, every adintional line of code
we execute in the crashing kernel increases our chances of hitting a
bug.

Under that policy things like requring we don't pass boot options that
inhibit the dump catpure kernel from initializing the hardware from a
random state are reasonable requirements.  AKA I don't see any
justification in this as to why we would even want to support notsc
on the dump capture kernel.  Especially when things clearly work when
that option is not specified.

Eric


> Signed-off-by: Wei Jiangang <weijg.fnst@cn.fujitsu.com>
> ---
>  arch/x86/include/asm/apic.h        | 5 +++++
>  arch/x86/kernel/apic/apic.c        | 9 +++++++++
>  arch/x86/kernel/machine_kexec_32.c | 5 ++---
>  arch/x86/kernel/machine_kexec_64.c | 6 +++---
>  4 files changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
> index bc27611fa58f..5d7e635e580a 100644
> --- a/arch/x86/include/asm/apic.h
> +++ b/arch/x86/include/asm/apic.h
> @@ -128,6 +128,7 @@ extern void clear_local_APIC(void);
>  extern void disconnect_bsp_APIC(int virt_wire_setup);
>  extern void disable_local_APIC(void);
>  extern void lapic_shutdown(void);
> +extern int lapic_disabled(void);
>  extern void sync_Arb_IDs(void);
>  extern void init_bsp_APIC(void);
>  extern void setup_local_APIC(void);
> @@ -165,6 +166,10 @@ extern int setup_APIC_eilvt(u8 lvt_off, u8 vector, u8 msg_type, u8 mask);
>  
>  #else /* !CONFIG_X86_LOCAL_APIC */
>  static inline void lapic_shutdown(void) { }
> +static inline int lapic_disabled(void)
> +{
> +	return 0;
> +}
>  #define local_apic_timer_c2_ok		1
>  static inline void init_apic_mappings(void) { }
>  static inline void disable_local_APIC(void) { }
> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index 60078a67d7e3..d1df250994bb 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -133,6 +133,9 @@ static inline void imcr_apic_to_pic(void)
>  }
>  #endif
>  
> +/* Local APIC is disabled by the kernel for crash or reboot path */
> +static int disabled_local_apic;
> +
>  /*
>   * Knob to control our willingness to enable the local APIC.
>   *
> @@ -1097,10 +1100,16 @@ void lapic_shutdown(void)
>  #endif
>  		disable_local_APIC();
>  
> +	disabled_local_apic = 1;
>  
>  	local_irq_restore(flags);
>  }
>  
> +int lapic_disabled(void)
> +{
> +	return disabled_local_apic;
> +}
> +
>  /**
>   * sync_Arb_IDs - synchronize APIC bus arbitration IDs
>   */
> diff --git a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_kexec_32.c
> index 469b23d6acc2..c934a7868e6b 100644
> --- a/arch/x86/kernel/machine_kexec_32.c
> +++ b/arch/x86/kernel/machine_kexec_32.c
> @@ -202,14 +202,13 @@ void machine_kexec(struct kimage *image)
>  	local_irq_disable();
>  	hw_breakpoint_disable();
>  
> -	if (image->preserve_context) {
> +	if (image->preserve_context || lapic_disabled()) {
>  #ifdef CONFIG_X86_IO_APIC
>  		/*
>  		 * We need to put APICs in legacy mode so that we can
>  		 * get timer interrupts in second kernel. kexec/kdump
>  		 * paths already have calls to disable_IO_APIC() in
> -		 * one form or other. kexec jump path also need
> -		 * one.
> +		 * one form or other. kexec jump path also need one.
>  		 */
>  		disable_IO_APIC();
>  #endif
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index 5a294e48b185..d3598cdd6437 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -23,6 +23,7 @@
>  #include <asm/pgtable.h>
>  #include <asm/tlbflush.h>
>  #include <asm/mmu_context.h>
> +#include <asm/apic.h>
>  #include <asm/io_apic.h>
>  #include <asm/debugreg.h>
>  #include <asm/kexec-bzimage64.h>
> @@ -269,14 +270,13 @@ void machine_kexec(struct kimage *image)
>  	local_irq_disable();
>  	hw_breakpoint_disable();
>  
> -	if (image->preserve_context) {
> +	if (image->preserve_context || lapic_disabled()) {
>  #ifdef CONFIG_X86_IO_APIC
>  		/*
>  		 * We need to put APICs in legacy mode so that we can
>  		 * get timer interrupts in second kernel. kexec/kdump
>  		 * paths already have calls to disable_IO_APIC() in
> -		 * one form or other. kexec jump path also need
> -		 * one.
> +		 * one form or other. kexec jump path also need one.
>  		 */
>  		disable_IO_APIC();
>  #endif

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
