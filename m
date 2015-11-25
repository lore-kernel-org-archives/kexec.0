Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail7.hitachi.co.jp ([133.145.228.42])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a1T0C-0003Hq-LH
 for kexec@lists.infradead.org; Wed, 25 Nov 2015 05:52:26 +0000
From: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
 <hidehiro.kawai.ez@hitachi.com>
Subject: RE: [V5 PATCH 2/4] panic/x86: Allow cpus to save registers even if
 they are looping in NMI context
Date: Wed, 25 Nov 2015 05:51:59 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A84454A2A425@GSjpTKYDCembx31.service.hitachi.net>
References: <20151120093641.4285.97253.stgit@softrs>
 <20151120093646.4285.62259.stgit@softrs> <20151124104853.GC3785@pd.tnic>
In-Reply-To: <20151124104853.GC3785@pd.tnic>
Content-Language: ja-JP
MIME-Version: 1.0
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
To: 'Borislav Petkov' <bp@alien8.de>
Cc: "x86@kernel.org" <x86@kernel.org>, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

> On Fri, Nov 20, 2015 at 06:36:46PM +0900, Hidehiro Kawai wrote:
> > nmi_shootdown_cpus(), a subroutine of crash_kexec(), sends NMI IPI
> > to non-panic cpus to stop them while saving their register
> 
> 		 ...to stop them and save their register...

Thanks for the correction.

> > information and doing some cleanups for crash dumping.  So if a
> > non-panic cpus is infinitely looping in NMI context, we fail to
> 
> That should be CPU. Please use "CPU" instead of "cpu" in all your text
> in your next submission.

OK, I'll fix that.

> > save its register information and lose the information from the
> > crash dump.
> >
> > `Infinite loop in NMI context' can happen:
> >
> >   a. when a cpu panics on NMI while another cpu is processing panic
> >   b. when a cpu received an external or unknown NMI while another
> >      cpu is processing panic on NMI
> >
> > In the case of a, it loops in panic_smp_self_stop().  In the case
> > of b, it loops in raw_spin_lock() of nmi_reason_lock.
> 
> Please describe those two cases more verbosely - it takes slow people
> like me a while to figure out what exactly can happen.

  a. when a cpu panics on NMI while another cpu is processing panic
     Ex.
     CPU 0                     CPU 1
     =================         =================
     panic()
       panic_cpu <-- 0
       check panic_cpu
       crash_kexec()
                               receive an unknown NMI
                               unknown_nmi_error()
                                 nmi_panic()
                                   panic()
                                     check panic_cpu
                                     panic_smp_self_stop()
                                       infinite loop in NMI context

  b. when a cpu received an external or unknown NMI while another
     cpu is processing panic on NMI
     Ex.
     CPU 0                     CPU 1
     ======================    ==================
     receive an unknown NMI
     unknown_nmi_error()
       nmi_panic()             receive an unknown NMI
         panic_cpu <-- 0       unknown_nmi_error()
         panic()                 nmi_panic()
           check panic_cpu         panic
           crash_kexec()             check panic_cpu
                                     panic_smp_self_stop()
                                       infinite loop in NMI context
 
> > This can
> > happen on some servers which broadcasts NMIs to all CPUs when a dump
> > button is pushed.
> >
> > To save registers in these case too, this patch does following things:
> >
> > 1. Move the timing of `infinite loop in NMI context' (actually
> >    done by panic_smp_self_stop()) outside of panic() to enable us to
> >    refer pt_regs
> 
> I can't parse that sentence. And I really tried :-\
> panic_smp_self_stop() is still in panic().

panic_smp_self_stop() is still used when a CPU in normal context
should go into infinite loop.  Only when a CPU is in NMI context,
nmi_panic_self_stop() is called and the CPU loops infinitely
without entering panic().

I'll try to revise this sentense.

> > 2. call a callback of nmi_shootdown_cpus() directly to save
> >    registers and do some cleanups after setting waiting_for_crash_ipi
> >    which is used for counting down the number of cpus which handled
> >    the callback
> >
> > V5:
> > - Use WRITE_ONCE() when setting crash_ipi_done to 1 so that the
> >   compiler doesn't change the instruction order
> > - Support the case of b in the above description
> > - Add poll_crash_ipi_and_callback()
> >
> > V4:
> > - Rewrite the patch description
> >
> > V3:
> > - Newly introduced
> >
> > Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Eric Biederman <ebiederm@xmission.com>
> > Cc: Vivek Goyal <vgoyal@redhat.com>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > ---
> >  arch/x86/include/asm/reboot.h |    1 +
> >  arch/x86/kernel/nmi.c         |   17 +++++++++++++----
> >  arch/x86/kernel/reboot.c      |   28 ++++++++++++++++++++++++++++
> >  include/linux/kernel.h        |   12 ++++++++++--
> >  kernel/panic.c                |   10 ++++++++++
> >  kernel/watchdog.c             |    2 +-
> >  6 files changed, 63 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/reboot.h b/arch/x86/include/asm/reboot.h
> > index a82c4f1..964e82f 100644
> > --- a/arch/x86/include/asm/reboot.h
> > +++ b/arch/x86/include/asm/reboot.h
> > @@ -25,5 +25,6 @@ void __noreturn machine_real_restart(unsigned int type);
> >
> >  typedef void (*nmi_shootdown_cb)(int, struct pt_regs*);
> >  void nmi_shootdown_cpus(nmi_shootdown_cb callback);
> > +void poll_crash_ipi_and_callback(struct pt_regs *regs);
> >
> >  #endif /* _ASM_X86_REBOOT_H */
> > diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
> > index 5131714..74a1434 100644
> > --- a/arch/x86/kernel/nmi.c
> > +++ b/arch/x86/kernel/nmi.c
> > @@ -29,6 +29,7 @@
> >  #include <asm/mach_traps.h>
> >  #include <asm/nmi.h>
> >  #include <asm/x86_init.h>
> > +#include <asm/reboot.h>
> >
> >  #define CREATE_TRACE_POINTS
> >  #include <trace/events/nmi.h>
> > @@ -231,7 +232,7 @@ pci_serr_error(unsigned char reason, struct pt_regs *regs)
> >  #endif
> >
> >  	if (panic_on_unrecovered_nmi)
> > -		nmi_panic("NMI: Not continuing");
> > +		nmi_panic(regs, "NMI: Not continuing");
> >
> >  	pr_emerg("Dazed and confused, but trying to continue\n");
> >
> > @@ -256,7 +257,7 @@ io_check_error(unsigned char reason, struct pt_regs *regs)
> >  	show_regs(regs);
> >
> >  	if (panic_on_io_nmi) {
> > -		nmi_panic("NMI IOCK error: Not continuing");
> > +		nmi_panic(regs, "NMI IOCK error: Not continuing");
> >
> >  		/*
> >  		 * If we return from nmi_panic(), it means we have received
> > @@ -305,7 +306,7 @@ unknown_nmi_error(unsigned char reason, struct pt_regs *regs)
> >
> >  	pr_emerg("Do you have a strange power saving mode enabled?\n");
> >  	if (unknown_nmi_panic || panic_on_unrecovered_nmi)
> > -		nmi_panic("NMI: Not continuing");
> > +		nmi_panic(regs, "NMI: Not continuing");
> >
> >  	pr_emerg("Dazed and confused, but trying to continue\n");
> >  }
> > @@ -357,7 +358,15 @@ static void default_do_nmi(struct pt_regs *regs)
> >  	}
> >
> >  	/* Non-CPU-specific NMI: NMI sources can be processed on any CPU */
> > -	raw_spin_lock(&nmi_reason_lock);
> > +
> > +	/*
> > +	 * Another CPU may be processing panic routines with holding
> 
> 							while

I'll fix it.

> > +	 * nmi_reason_lock.  Check IPI issuance from the panicking CPU
> > +	 * and call the callback directly.
> 
> This is one strange sentence. Does it mean something like:
> 
> "Check if the panicking CPU issued the IPI and, if so, call the crash
> callback directly."
> 
> ?

Yes.  Thanks for the suggestion.

> > +	 */
> > +	while (!raw_spin_trylock(&nmi_reason_lock))
> > +		poll_crash_ipi_and_callback(regs);
> 
> Waaait a minute: so if we're getting NMIs broadcasted on every core but
> we're *not* crash dumping, we will run into here too. This can't be
> right. :-\

As Steven commented, poll_crash_ipi_and_callback() does nothing
if we're not crash dumping.  But yes, this is confusing.  I'll add
more detailed comment, or change the logic a bit if I come up with
better one.

> > +
> >  	reason = x86_platform.get_nmi_reason();
> >
> >  	if (reason & NMI_REASON_MASK) {
> > diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
> > index 02693dd..44c5f5b 100644
> > --- a/arch/x86/kernel/reboot.c
> > +++ b/arch/x86/kernel/reboot.c
> > @@ -718,6 +718,7 @@ static int crashing_cpu;
> >  static nmi_shootdown_cb shootdown_callback;
> >
> >  static atomic_t waiting_for_crash_ipi;
> > +static int crash_ipi_done;
> >
> >  static int crash_nmi_callback(unsigned int val, struct pt_regs *regs)
> >  {
> > @@ -780,6 +781,9 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
> >
> >  	smp_send_nmi_allbutself();
> >
> > +	/* Kick cpus looping in nmi context. */
> > +	WRITE_ONCE(crash_ipi_done, 1);
> > +
> >  	msecs = 1000; /* Wait at most a second for the other cpus to stop */
> >  	while ((atomic_read(&waiting_for_crash_ipi) > 0) && msecs) {
> >  		mdelay(1);
> > @@ -788,9 +792,33 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
> >
> >  	/* Leave the nmi callback set */
> >  }
> > +
> > +/*
> > + * Wait for the timing of IPI for crash dumping, and then call its callback
> 
> "Wait for the crash dumping IPI to complete... "

So, I think "Wait for the crash dumping IPI to be issued..." is better.
"complete" would be ambiguous in this context.

> > + * directly.  This function is used when we have already been in NMI handler.
> > + */
> > +void poll_crash_ipi_and_callback(struct pt_regs *regs)
> 
> Why "poll"? We won't return from crash_nmi_callback() if we're not the
> crashing CPU.

This function polls that crash IPI has been issued by checking
crash_ipi_done, then invokes the callback.  This is different
from so-called "poll" functions.  Do you have some good name?

> > +{
> > +	if (crash_ipi_done)
> > +		crash_nmi_callback(0, regs); /* Shouldn't return */
> > +}
> > +
> > +/* Override the weak function in kernel/panic.c */
> > +void nmi_panic_self_stop(struct pt_regs *regs)
> > +{
> > +	while (1) {
> > +		poll_crash_ipi_and_callback(regs);
> > +		cpu_relax();
> > +	}
> > +}
> > +
> >  #else /* !CONFIG_SMP */
> >  void nmi_shootdown_cpus(nmi_shootdown_cb callback)
> >  {
> >  	/* No other CPUs to shoot down */
> >  }
> > +
> > +void poll_crash_ipi_and_callback(struct pt_regs *regs)
> > +{
> > +}
> >  #endif
> > diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> > index 480a4fd..728a31b 100644
> > --- a/include/linux/kernel.h
> > +++ b/include/linux/kernel.h
> > @@ -255,6 +255,7 @@ extern long (*panic_blink)(int state);
> >  __printf(1, 2)
> >  void panic(const char *fmt, ...)
> >  	__noreturn __cold;
> > +void nmi_panic_self_stop(struct pt_regs *);
> >  extern void oops_enter(void);
> >  extern void oops_exit(void);
> >  void print_oops_end_marker(void);
> > @@ -450,12 +451,19 @@ extern atomic_t panic_cpu;
> >  /*
> >   * A variant of panic() called from NMI context.
> >   * If we've already panicked on this cpu, return from here.
> > + * If another cpu already panicked, loop in nmi_panic_self_stop() which
> > + * can provide architecture dependent code such as saving register states
> > + * for crash dump.
> >   */
> > -#define nmi_panic(fmt, ...)						\
> > +#define nmi_panic(regs, fmt, ...)					\
> >  	do {								\
> > +		int old_cpu;						\
> >  		int this_cpu = raw_smp_processor_id();			\
> > -		if (atomic_cmpxchg(&panic_cpu, -1, this_cpu) != this_cpu) \
> > +		old_cpu = atomic_cmpxchg(&panic_cpu, -1, this_cpu);	\
> > +		if (old_cpu == -1)					\
> >  			panic(fmt, ##__VA_ARGS__);			\
> > +		else if (old_cpu != this_cpu)				\
> > +			nmi_panic_self_stop(regs);			\
> 
> Same here - this is assuming that broadcasting NMIs to all cores
> automatically means there's a crash dump in progress:
> 
> nmi_panic_self_stop() -> poll_crash_ipi_and_callback()
> 
> and this cannot be right.
> 
> >  	} while (0)
> >
> >  /*
> > diff --git a/kernel/panic.c b/kernel/panic.c
> > index 24ee2ea..4fce2be 100644
> > --- a/kernel/panic.c
> > +++ b/kernel/panic.c
> > @@ -61,6 +61,16 @@ void __weak panic_smp_self_stop(void)
> >  		cpu_relax();
> >  }
> >
> > +/*
> > + * Stop ourself in NMI context if another cpu has already panicked.
> 
> 	  "ourselves"

Thanks. I'll fix it.

Regards,

--
Hidehiro Kawai
Hitachi, Ltd. Research & Development Group



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
