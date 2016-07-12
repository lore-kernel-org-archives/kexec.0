Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail9.hitachi.co.jp ([133.145.228.44])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bMoq2-0001qq-SX
 for kexec@lists.infradead.org; Tue, 12 Jul 2016 03:58:29 +0000
From: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
 <hidehiro.kawai.ez@hitachi.com>
Subject: RE: Re: [V3 PATCH 1/2] x86/panic: Replace smp_send_stop() with
 kdump friendly version
Date: Tue, 12 Jul 2016 03:56:50 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A84454C6F9CB@GSjpTKYDCembx31.service.hitachi.net>
References: <20160705113323.5864.66834.stgit@softrs>
 <20160705113325.5864.74840.stgit@softrs> <57845FFC.6050308@redhat.com>
In-Reply-To: <57845FFC.6050308@redhat.com>
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
To: "'xlpang@redhat.com'" <xlpang@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, "Eric W.
 Biederman" <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>, Toshi Kani <toshi.kani@hpe.com>, "Peter
 Zijlstra (Intel)" <peterz@infradead.org>, Minfei Huang <mnfhuang@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Daniel Walker <dwalker@fifo99.com>, Ingo Molnar <mingo@kernel.org>, Takao Indoh <indou.takao@jp.fujitsu.com>, "x86@kernel.org" <x86@kernel.org>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, Borislav Petkov <bp@suse.de>, Vivek Goyal <vgoyal@redhat.com>, Petr Mladek <pmladek@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Masami Hiramatsu <mhiramat@kernel.org>, Tejun Heo <tj@kernel.org>, Vitaly Kuznetsov <vkuznets@redhat.com>

Hi Xunlei,

Thanks for the review.

> From: Xunlei Pang [mailto:xpang@redhat.com]
> Sent: Tuesday, July 12, 2016 12:12 PM
> On 2016/07/05 at 19:33, Hidehiro Kawai wrote:
> > This patch fixes one of the problems reported by Daniel Walker
> > (https://lkml.org/lkml/2015/6/24/44).
> >
> > If crash_kexec_post_notifiers boot option is specified, other CPUs
> > are stopped by smp_send_stop() instead of machine_crash_shutdown()
> > in crash_kexec() path.  This behavior change leads two problems.
> >
> >  Problem 1:
> >  octeon_generic_shutdown() for MIPS OCTEON assumes that other CPUs are
> >  still online and try to stop their watchdog timer.  If
> >  smp_send_stop() is called before octeon_generic_shutdown(), stopping
> >  watchdog timer will fail because other CPUs have been offlined by
> >  smp_send_stop().
> >
> >    panic()
> >      if crash_kexec_post_notifiers == 1
> >        smp_send_stop()
> >        atomic_notifier_call_chain()
> >        kmsg_dump()
> >      crash_kexec()
> >        machine_crash_shutdown()
> >          octeon_generic_shutdown() // shutdown watchdog for ONLINE CPUs
> >
> >  Problem 2:
> >  Most of architectures stop other CPUs in machine_crash_shutdown()
> >  path, and they also do something needed for kdump.  For example,
> >  they save registers, disable virtualization extensions, and so on.
> >  However, if smp_send_stop() stops other CPUs before
> >  machine_crash_shutdown(), we miss those operations.
> >
> > How do we fix these problems?  In the first place, we should stop
> > other CPUs as soon as possible when panic() was called, otherwise
> > other CPUs may wipe out a clue to the cause of the failure.  So, we
> > replace smp_send_stop() with more suitable one for kdump.
> >
> > This patch solves Problem 2 by replacing smp_send_stop() in panic()
> > with panic_smp_send_stop().  This is a weak function which calls
> > smp_send_stop(), and architecture dependent code may override this
> > with appropriate one.  This patch only provides x86-specific version.
> >
> > Changes in V3:
> > - Revise comments, description, and symbol names
> >
> > Changes in V2:
> > - Replace smp_send_stop() call with crash_kexec version which
> >   saves cpu states and cleans up VMX/SVM
> > - Drop a fix for Problem 1 at this moment
> >
> > Reported-by: Daniel Walker <dwalker@fifo99.com>
> > Fixes: f06e5153f4ae (kernel/panic.c: add "crash_kexec_post_notifiers" option)
> > Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Vivek Goyal <vgoyal@redhat.com>
> > Cc: Eric Biederman <ebiederm@xmission.com>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Borislav Petkov <bp@suse.de>
> > Cc: Toshi Kani <toshi.kani@hpe.com>
> > Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> > Cc: Takao Indoh <indou.takao@jp.fujitsu.com>
> > Cc: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
> > Cc: Minfei Huang <mnfhuang@gmail.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> > Cc: Petr Mladek <pmladek@suse.com>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> > ---
> >  arch/x86/kernel/crash.c |   14 ++++++++++----
> >  kernel/panic.c          |   43 ++++++++++++++++++++++++++++++++-----------
> >  2 files changed, 42 insertions(+), 15 deletions(-)
> >
> > diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> > index 9ef978d..3305433 100644
> > --- a/arch/x86/kernel/crash.c
> > +++ b/arch/x86/kernel/crash.c
> > @@ -133,15 +133,21 @@ static void kdump_nmi_callback(int cpu, struct pt_regs *regs)
> >  	disable_local_APIC();
> >  }
> >
> > -static void kdump_nmi_shootdown_cpus(void)
> > +/* Override the weak function in kernel/panic.c */
> > +void panic_smp_send_stop(void)
> >  {
> > -	nmi_shootdown_cpus(kdump_nmi_callback);
> > +	static int cpus_stopped;
> 
> Should be atomic_t type?

panic_smp_send_stop() can be called by only one panicking CPU
(but can be called twice). It is sufficient to be normal variable.

> > +
> > +	if (cpus_stopped)
> > +		return;
> >
> > +	nmi_shootdown_cpus(kdump_nmi_callback);
> >  	disable_local_APIC();
> > +	cpus_stopped = 1;
> >  }
> >
> >  #else
> > -static void kdump_nmi_shootdown_cpus(void)
> > +void panic_smp_send_stop(void)
> >  {
> >  	/* There are no cpus to shootdown */
> >  }
> > @@ -160,7 +166,7 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
> >  	/* The kernel is broken so disable interrupts */
> >  	local_irq_disable();
> >
> > -	kdump_nmi_shootdown_cpus();
> > +	panic_smp_send_stop();
> >
> >  	/*
> >  	 * VMCLEAR VMCSs loaded on this cpu if needed.
> > diff --git a/kernel/panic.c b/kernel/panic.c
> > index 8aa7449..da8062d2 100644
> > --- a/kernel/panic.c
> > +++ b/kernel/panic.c
> > @@ -71,6 +71,32 @@ void __weak nmi_panic_self_stop(struct pt_regs *regs)
> >  	panic_smp_self_stop();
> >  }
> >
> > +/*
> > + * Stop other CPUs in panic.  Architecture dependent code may override this
> > + * with more suitable version.  For example, if the architecture supports
> > + * crash dump, it should save registers of each stopped CPU and disable
> > + * per-CPU features such as virtualization extensions.
> > + */
> > +void __weak panic_smp_send_stop(void)
> > +{
> > +	static int cpus_stopped;
> > +
> > +	/*
> > +	 * This function can be called twice in panic path, but obviously
> > +	 * we execute this only once.
> > +	 */
> > +	if (cpus_stopped)
> > +		return;
> > +
> > +	/*
> > +	 * Note smp_send_stop is the usual smp shutdown function, which
> > +	 * unfortunately means it may not be hardened to work in a panic
> > +	 * situation.
> > +	 */
> > +	smp_send_stop();
> > +	cpus_stopped = 1;
> > +}
> > +
> >  atomic_t panic_cpu = ATOMIC_INIT(PANIC_CPU_INVALID);
> >
> >  /*
> > @@ -125,7 +151,7 @@ void panic(const char *fmt, ...)
> >  	 * Only one CPU is allowed to execute the panic code from here. For
> >  	 * multiple parallel invocations of panic, all other CPUs either
> >  	 * stop themself or will wait until they are stopped by the 1st CPU
> > -	 * with smp_send_stop().
> > +	 * with panic_smp_send_stop().
> >  	 *
> >  	 * `old_cpu == PANIC_CPU_INVALID' means this is the 1st CPU which
> >  	 * comes here, so go ahead.
> > @@ -165,12 +191,7 @@ void panic(const char *fmt, ...)
> >  		__crash_kexec(NULL);
> >  	}
> >
> > -	/*
> > -	 * Note smp_send_stop is the usual smp shutdown function, which
> > -	 * unfortunately means it may not be hardened to work in a panic
> > -	 * situation.
> > -	 */
> > -	smp_send_stop();
> > +	panic_smp_send_stop();
> 
> If crash_kexec_post_notifiers and kdump both are not used, you actually changed the original behaviour,
> it would be better to make it conditionally like:
>     if (crash_kexec_post_notifiers)
>         panic_smp_send_stop(); // renaming it to crash_smp_send_stop() is better?
>     else
>         smp_send_stop();

Dave also pointed about this, and I'll fix it.

Best regards,

Hidehiro Kawai
Hitachi, Ltd. Research & Development Group

> >  	/*
> >  	 * Run any panic handlers, including those that might need to
> > @@ -198,10 +219,10 @@ void panic(const char *fmt, ...)
> >
> >  	/*
> >  	 * We may have ended up stopping the CPU holding the lock (in
> > -	 * smp_send_stop()) while still having some valuable data in the console
> > -	 * buffer.  Try to acquire the lock then release it regardless of the
> > -	 * result.  The release will also print the buffers out.  Locks debug
> > -	 * should be disabled to avoid reporting bad unlock balance when
> > +	 * panic_smp_send_stop()) while still having some valuable data in the
> > +	 * console buffer.  Try to acquire the lock then release it regardless
> > +	 * of the result.  The release will also print the buffers out.  Locks
> > +	 * debug should be disabled to avoid reporting bad unlock balance when
> >  	 * panic() is not being callled from OOPS.
> >  	 */
> >  	debug_locks_off();
> >
> >
> >
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
