Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail7.hitachi.co.jp ([133.145.228.42])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bmJOW-0005PZ-WD
 for kexec@lists.infradead.org; Tue, 20 Sep 2016 11:39:27 +0000
From: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
 <hidehiro.kawai.ez@hitachi.com>
Subject: RE: Re: [V4 PATCH 2/2] mips/panic: Replace smp_send_stop() with
 kdump friendly version in panic path
Date: Tue, 20 Sep 2016 11:37:07 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A84454D101E6@GSjpTKYDCembx31.service.hitachi.net>
References: <20160810080946.11028.97686.stgit@sysi4-13.yrl.intra.hitachi.co.jp>
 <20160810080950.11028.28000.stgit@sysi4-13.yrl.intra.hitachi.co.jp>
 <bdfd7136-6b0e-3820-dbac-d72529a4f058@mvista.com>
In-Reply-To: <bdfd7136-6b0e-3820-dbac-d72529a4f058@mvista.com>
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
To: 'Corey Minyard' <cminyard@mvista.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, "Eric W.
 Biederman" <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, Ralf Baechle <ralf@linux-mips.org>
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, David Daney <david.daney@cavium.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Xunlei Pang <xpang@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Masami Hiramatsu <mhiramat@kernel.org>, "Steven
 J. Hill" <steven.hill@cavium.com>, Daniel Walker <dwalker@fifo99.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Vivek Goyal <vgoyal@redhat.com>

Dave Young suggested to me to explain the problem in more detail,
so here is the revised commit description.  The patch is now in -mm,
so I copied Cc list from -mm version.  Also I added Corey Minyard's
Tested-by and Reviewed-by.

From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Subject: mips/panic: replace smp_send_stop() with kdump friendly version in panic path

This patch fixes the problems reported by Daniel Walker
(https://lkml.org/lkml/2015/6/24/44).

When kernel panics with crash_kexec_post_notifiers kernel parameter
enabled, other CPUs are stopped by smp_send_stop() instead of
machine_crash_shutdown() in __crash_kexec() path.

  panic()
    if crash_kexec_post_notifiers == 1
      smp_send_stop()
      atomic_notifier_call_chain()
      kmsg_dump()
    __crash_kexec()
      machine_crash_shutdown()
        octeon_generic_shutdown() // shutdown watchdog for ONLINE CPUs

Different from smp_send_stop(), machine_crash_shutdown() stops other
CPUs with extra works for kdump.  So, if smp_send_stop() stops other
CPUs in advance, these extra works won't be done.  As the result,
kdump routines miss to save other CPUs' registers.  Additionally for
MIPS OCTEON, it misses to stop the watchdog timer.

To fix this problem, call a new kdump friendly function,
crash_smp_send_stop(), instead of the smp_send_stop() when
crash_kexec_post_notifiers is enabled.  crash_smp_send_stop() is a
weak function, and it just call smp_send_stop().  Architecture
codes should override it so that kdump can work appropriately.
This patch provides MIPS version.

Fixes: f06e5153f4ae (kernel/panic.c: add "crash_kexec_post_notifiers" option)
Link: http://lkml.kernel.org/r/20160810080950.11028.28000.stgit@sysi4-13.yrl.intra.hitachi.co.jp
Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Reported-by: Daniel Walker <dwalker@fifo99.com>
Tested-by: Corey Minyard <cminyard@mvista.com>
Reviewed-by: Corey Minyard <cminyard@mvista.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Daniel Walker <dwalker@fifo99.com>
Cc: Xunlei Pang <xpang@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: David Vrabel <david.vrabel@citrix.com>
Cc: Toshi Kani <toshi.kani@hpe.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: David Daney <david.daney@cavium.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: "Steven J. Hill" <steven.hill@cavium.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

> From: Corey Minyard [mailto:cminyard@mvista.com]
> Sent: Friday, August 19, 2016 6:18 AM
> Sorry this took so long, but I have finally tested this, it seems to
> work fine:
> 
> Tested-by: Corey Minyard <cminyard@mvista.com>
> Reviewed-by: Corey Minyard <cminyard@mvista.com>
> 
> On 08/10/2016 03:09 AM, Hidehiro Kawai wrote:
> > Daniel Walker reported problems which happens when
> > crash_kexec_post_notifiers kernel option is enabled
> > (https://lkml.org/lkml/2015/6/24/44).
> >
> > In that case, smp_send_stop() is called before entering kdump routines
> > which assume other CPUs are still online.  As the result, kdump
> > routines fail to save other CPUs' registers.  Additionally for MIPS
> > OCTEON, it misses to stop the watchdog timer.
> >
> > To fix this problem, call a new kdump friendly function,
> > crash_smp_send_stop(), instead of the smp_send_stop() when
> > crash_kexec_post_notifiers is enabled.  crash_smp_send_stop() is a
> > weak function, and it just call smp_send_stop().  Architecture
> > codes should override it so that kdump can work appropriately.
> > This patch provides MIPS version.
> >
> > Reported-by: Daniel Walker <dwalker@fifo99.com>
> > Fixes: f06e5153f4ae (kernel/panic.c: add "crash_kexec_post_notifiers" option)
> > Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: David Daney <david.daney@cavium.com>
> > Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> > Cc: "Steven J. Hill" <steven.hill@cavium.com>
> > Cc: Corey Minyard <cminyard@mvista.com>
> >
> > ---
> > I'm not familiar with MIPS, and I don't have a test environment and
> > just did build tests only.  Please don't apply this patch until
> > someone does enough tests, otherwise simply drop this patch.
> > ---
> >   arch/mips/cavium-octeon/setup.c  |   14 ++++++++++++++
> >   arch/mips/include/asm/kexec.h    |    1 +
> >   arch/mips/kernel/crash.c         |   18 +++++++++++++++++-
> >   arch/mips/kernel/machine_kexec.c |    1 +
> >   4 files changed, 33 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
> > index cb16fcc..5537f95 100644
> > --- a/arch/mips/cavium-octeon/setup.c
> > +++ b/arch/mips/cavium-octeon/setup.c
> > @@ -267,6 +267,17 @@ static void octeon_crash_shutdown(struct pt_regs *regs)
> >   	default_machine_crash_shutdown(regs);
> >   }
> >
> > +#ifdef CONFIG_SMP
> > +void octeon_crash_smp_send_stop(void)
> > +{
> > +	int cpu;
> > +
> > +	/* disable watchdogs */
> > +	for_each_online_cpu(cpu)
> > +		cvmx_write_csr(CVMX_CIU_WDOGX(cpu_logical_map(cpu)), 0);
> > +}
> > +#endif
> > +
> >   #endif /* CONFIG_KEXEC */
> >
> >   #ifdef CONFIG_CAVIUM_RESERVE32
> > @@ -911,6 +922,9 @@ void __init prom_init(void)
> >   	_machine_kexec_shutdown = octeon_shutdown;
> >   	_machine_crash_shutdown = octeon_crash_shutdown;
> >   	_machine_kexec_prepare = octeon_kexec_prepare;
> > +#ifdef CONFIG_SMP
> > +	_crash_smp_send_stop = octeon_crash_smp_send_stop;
> > +#endif
> >   #endif
> >
> >   	octeon_user_io_init();
> > diff --git a/arch/mips/include/asm/kexec.h b/arch/mips/include/asm/kexec.h
> > index ee25ebb..493a3cc 100644
> > --- a/arch/mips/include/asm/kexec.h
> > +++ b/arch/mips/include/asm/kexec.h
> > @@ -45,6 +45,7 @@ extern const unsigned char kexec_smp_wait[];
> >   extern unsigned long secondary_kexec_args[4];
> >   extern void (*relocated_kexec_smp_wait) (void *);
> >   extern atomic_t kexec_ready_to_reboot;
> > +extern void (*_crash_smp_send_stop)(void);
> >   #endif
> >   #endif
> >
> > diff --git a/arch/mips/kernel/crash.c b/arch/mips/kernel/crash.c
> > index 610f0f3..1723b17 100644
> > --- a/arch/mips/kernel/crash.c
> > +++ b/arch/mips/kernel/crash.c
> > @@ -47,9 +47,14 @@ static void crash_shutdown_secondary(void *passed_regs)
> >
> >   static void crash_kexec_prepare_cpus(void)
> >   {
> > +	static int cpus_stopped;
> >   	unsigned int msecs;
> > +	unsigned int ncpus;
> >
> > -	unsigned int ncpus = num_online_cpus() - 1;/* Excluding the panic cpu */
> > +	if (cpus_stopped)
> > +		return;
> > +
> > +	ncpus = num_online_cpus() - 1;/* Excluding the panic cpu */
> >
> >   	dump_send_ipi(crash_shutdown_secondary);
> >   	smp_wmb();
> > @@ -64,6 +69,17 @@ static void crash_kexec_prepare_cpus(void)
> >   		cpu_relax();
> >   		mdelay(1);
> >   	}
> > +
> > +	cpus_stopped = 1;
> > +}
> > +
> > +/* Override the weak function in kernel/panic.c */
> > +void crash_smp_send_stop(void)
> > +{
> > +	if (_crash_smp_send_stop)
> > +		_crash_smp_send_stop();
> > +
> > +	crash_kexec_prepare_cpus();
> >   }
> >
> >   #else /* !defined(CONFIG_SMP)  */
> > diff --git a/arch/mips/kernel/machine_kexec.c b/arch/mips/kernel/machine_kexec.c
> > index 50980bf3..5972520 100644
> > --- a/arch/mips/kernel/machine_kexec.c
> > +++ b/arch/mips/kernel/machine_kexec.c
> > @@ -25,6 +25,7 @@ void (*_machine_crash_shutdown)(struct pt_regs *regs) = NULL;
> >   #ifdef CONFIG_SMP
> >   void (*relocated_kexec_smp_wait) (void *);
> >   atomic_t kexec_ready_to_reboot = ATOMIC_INIT(0);
> > +void (*_crash_smp_send_stop)(void) = NULL;
> >   #endif
> >
> >   int
> >
> >

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
