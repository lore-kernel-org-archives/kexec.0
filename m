Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RsLqG-0002XN-Qg
 for kexec@lists.infradead.org; Tue, 31 Jan 2012 22:06:21 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] x86, kdump, ioapic: Fix kdump race with migrating irq
References: <1328045114-4489-1-git-send-email-dzickus@redhat.com>
Date: Tue, 31 Jan 2012 14:08:29 -0800
In-Reply-To: <1328045114-4489-1-git-send-email-dzickus@redhat.com> (Don
 Zickus's message of "Tue, 31 Jan 2012 16:25:14 -0500")
Message-ID: <m1ipjr4jaa.fsf@fess.ebiederm.org>
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
Cc: x86@kernel.org, kexec-list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, vgoyal@redhat.com

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

Can you test to see if kexec on panic still needs to disable the IO
APIC.  Last I looked we were close if not all of the way there to not
needing to boot the kernel in pic mode?

If we can skip the ioapic disable entirely we should be much more
robust.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
