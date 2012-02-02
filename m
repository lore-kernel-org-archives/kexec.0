Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1Rt5yh-0001Bh-GP
 for kexec@lists.infradead.org; Thu, 02 Feb 2012 23:22:09 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] x86, kdump: No need to disable ioapic in crash path
References: <1328206323-25580-1-git-send-email-dzickus@redhat.com>
Date: Thu, 02 Feb 2012 15:24:46 -0800
In-Reply-To: <1328206323-25580-1-git-send-email-dzickus@redhat.com> (Don
 Zickus's message of "Thu, 2 Feb 2012 13:12:03 -0500")
Message-ID: <m1r4ycsts1.fsf@fess.ebiederm.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Don Zickus <dzickus@redhat.com>
Cc: x86@kernel.org, kexec-list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Vivek Goyal <vgoyal@redhat.com>

Don Zickus <dzickus@redhat.com> writes:

> A customer of ours noticed when their machine crashed, kdump did not
> work but hung instead.  Using their firmware dumping solution they
> grabbed a vmcore and decoded the stacks on the cpus.  What they
> noticed seemed to be a rare deadlock with the ioapic_lock.
>
>  CPU4:
>  machine_crash_shutdown
>  -> machine_ops.crash_shutdown
>     -> native_machine_crash_shutdown
>        -> kdump_nmi_shootdown_cpus ------> Send NMI to other CPUs
>        -> disable_IO_APIC
>           -> clear_IO_APIC
>              -> clear_IO_APIC_pin
>                 -> ioapic_read_entry
>                    -> spin_lock_irqsave(&ioapic_lock, flags)
>                    ---Infinite loop here---
>
>  CPU0:
>  do_IRQ
>  -> handle_irq
>     -> handle_edge_irq
>         -> ack_apic_edge
>            -> move_native_irq
>                -> mask_IO_APIC_irq
>                   -> mask_IO_APIC_irq_desc
>                      -> spin_lock_irqsave(&ioapic_lock, flags)
>                      ---Receive NMI here after getting spinlock---
>                         -> nmi
>                            -> do_nmi
>                               -> crash_nmi_callback
>                               ---Infinite loop here---
>
> The problem is that although kdump tries to shutdown minimal hardware,
> it still needs to disable the IO APIC.  This requires spinlocks which
> may be held by another cpu.  This other cpu is being held infinitely in
> an NMI context by kdump in order to serialize the crashing path.  Instant
> deadlock.
>
> Eric, brought up a point that because the boot code was restructured we may
> not need to disable the io apic any more in the crash path.  The original
> concern that led to the development of disable_IO_APIC, was that the TSC
> calibration on boot up relied on the PIT timer for reference.  Access
> to the PIT required 8259 interrupts to be working.  This wouldn't work
> if the ioapic needed to be configured.  So on panic path, the ioapic was
> reconfigured to use virtual wire mode to allow the 8259 to passthrough.

A small clarification originally it was the jiffies calibration that
would fail if we could cause the PIT to generate interrupts through the
8259.  The boot would then hang at calibrating jiffies.

> Those concerns don't hold true now, thanks to the fast TSC calibration code
> not needing the PIT.  As a result, we can remove this call and simplify the
> locking needed in the panic path.
>
> I tested kdump on an Ivy Bridge platform, a Pentium4 and an old athlon that
> did not have an ioapic.  All three were successful.
>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Signed-off-by: Don Zickus <dzickus@redhat.com>
>
> ---
> I will probably need some help with my explaination as to why this line is not
> needed.  Any input is appreciated!

Can you test and verify that we also do not need the lapic_shutdown()
call and the disable_local_APIC call on the other processors.  The same
reasoning that supports us not needing to disable the IO_APIC also
supports us not needing to disable local apic.

Removing disable_IO_APIC in and of itself and then booting isn't quite
sufficient as a practical test to prove this code always works.
Sometimes the IOAPIC was not hooked up to interesting interrupt sources
like the 8259.

Eric

> ---
>  arch/x86/kernel/crash.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 13ad899..b053cf9 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -96,9 +96,6 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
>  	cpu_emergency_svm_disable();
>  
>  	lapic_shutdown();
> -#if defined(CONFIG_X86_IO_APIC)
> -	disable_IO_APIC();
> -#endif
>  #ifdef CONFIG_HPET_TIMER
>  	hpet_disable();
>  #endif

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
