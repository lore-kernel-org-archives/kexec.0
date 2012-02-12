Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-gy0-f177.google.com ([209.85.160.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RwNrW-00086s-MW
 for kexec@lists.infradead.org; Sun, 12 Feb 2012 01:04:19 +0000
Received: by ghbg20 with SMTP id g20so2164523ghb.36
 for <kexec@lists.infradead.org>; Sat, 11 Feb 2012 17:04:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <tip-d9bc9be89629445758670220787683e37c93f6c1@git.kernel.org>
References: <tip-d9bc9be89629445758670220787683e37c93f6c1@git.kernel.org>
Date: Sat, 11 Feb 2012 17:04:15 -0800
Message-ID: <CAE9FiQWRjvu_uNcx_bJXYHeg4D4k6YzHHmSudsq7EyubLi7+nw@mail.gmail.com>
Subject: Re: [tip:x86/debug] x86/kdump: No need to disable ioapic/ lapic in
 crash path
From: Yinghai Lu <yinghai@kernel.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, yinghai@kernel.org, torvalds@linux-foundation.org, kexec@lists.infradead.org, vgoyal@redhat.com, ebiederm@xmission.com, akpm@linux-foundation.org, tglx@linutronix.de, dzickus@redhat.com, mingo@elte.hu
Cc: linux-tip-commits@vger.kernel.org

On Sat, Feb 11, 2012 at 3:09 PM, tip-bot for Don Zickus
<dzickus@redhat.com> wrote:
> Commit-ID: =A0d9bc9be89629445758670220787683e37c93f6c1
> Gitweb: =A0 =A0 http://git.kernel.org/tip/d9bc9be89629445758670220787683e=
37c93f6c1
> Author: =A0 =A0 Don Zickus <dzickus@redhat.com>
> AuthorDate: Thu, 9 Feb 2012 16:53:41 -0500
> Committer: =A0Ingo Molnar <mingo@elte.hu>
> CommitDate: Sat, 11 Feb 2012 15:38:53 +0100
>
> x86/kdump: No need to disable ioapic/lapic in crash path
>
> A customer of ours noticed when their machine crashed, kdump did
> not work but hung instead. =A0Using their firmware dumping
> solution they grabbed a vmcore and decoded the stacks on the
> cpus. =A0What they noticed seemed to be a rare deadlock with the
> ioapic_lock.
>
> =A0CPU4:
> =A0machine_crash_shutdown
> =A0-> machine_ops.crash_shutdown
> =A0 =A0-> native_machine_crash_shutdown
> =A0 =A0 =A0 -> kdump_nmi_shootdown_cpus ------> Send NMI to other CPUs
> =A0 =A0 =A0 -> disable_IO_APIC
> =A0 =A0 =A0 =A0 =A0-> clear_IO_APIC
> =A0 =A0 =A0 =A0 =A0 =A0 -> clear_IO_APIC_pin
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-> ioapic_read_entry
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 -> spin_lock_irqsave(&ioapic_lock, fl=
ags)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ---Infinite loop here---
>
> =A0CPU0:
> =A0do_IRQ
> =A0-> handle_irq
> =A0 =A0-> handle_edge_irq
> =A0 =A0 =A0 =A0-> ack_apic_edge
> =A0 =A0 =A0 =A0 =A0 -> move_native_irq
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 -> mask_IO_APIC_irq
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-> mask_IO_APIC_irq_desc
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 -> spin_lock_irqsave(&ioapic_lock=
, flags)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ---Receive NMI here after getting=
 spinlock---
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-> nmi
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 -> do_nmi
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-> crash_nmi_c=
allback
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0---Infinite lo=
op here---
>
> The problem is that although kdump tries to shutdown minimal
> hardware, it still needs to disable the IO APIC. =A0This requires
> spinlocks which may be held by another cpu. =A0This other cpu is
> being held infinitely in an NMI context by kdump in order to
> serialize the crashing path. =A0Instant deadlock.
>
> Eric brought up a point that because the boot code was
> restructured we may not need to disable the io apic any more in
> the crash path. =A0The original concern that led to the
> development of disable_IO_APIC, was that the jiffies calibration
> on boot up relied on the PIT timer for reference. =A0Access to the
> PIT required 8259 interrupts to be working. =A0This wouldn't work
> if the ioapic needed to be configured. =A0So on panic path, the
> ioapic was reconfigured to use virtual wire mode to allow the 8259 to pas=
sthrough.
>
> Those concerns don't hold true now, thanks to the jiffies
> calibration code not needing the PIT. =A0As a result, we can
> remove this call and simplify the locking needed in the panic
> path.
>
> The same work allowed us to remove the need to disable the local
> apic on shutdown too. =A0This should allow us to jump to the
> second a little faster.
>
> I tested kdump on an Ivy Bridge platform, a Pentium4 and an old
> athlon that did not have an ioapic. =A0All three were successful.
>
> I also tested using lkdtm that would use jprobes to panic the
> system when entering do_IRQ. =A0The idea was to see how the system
> reacted with an interrupt pending in the second kernel. =A0My
> core2 quad successfully kdump'd 3 times in a row with no issues.
>
> v2: removed the disable lapic code too

with this commit, kdump is not working anymore on my setups with
Nehalem, Westmere, sandbridge.
these setup all have VT-d enabled.


After reverting this commit, kdump is working again.

So assume you need to drop this patch.

Thanks

Yinghai Lu

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
