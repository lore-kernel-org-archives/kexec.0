Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1Rt19E-0006rD-6K
 for kexec@lists.infradead.org; Thu, 02 Feb 2012 18:12:42 +0000
From: Don Zickus <dzickus@redhat.com>
Subject: [PATCH] x86, kdump: No need to disable ioapic in crash path
Date: Thu,  2 Feb 2012 13:12:03 -0500
Message-Id: <1328206323-25580-1-git-send-email-dzickus@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: x86@kernel.org
Cc: Don Zickus <dzickus@redhat.com>, kexec-list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Vivek Goyal <vgoyal@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>

A customer of ours noticed when their machine crashed, kdump did not
work but hung instead.  Using their firmware dumping solution they
grabbed a vmcore and decoded the stacks on the cpus.  What they
noticed seemed to be a rare deadlock with the ioapic_lock.

 CPU4:
 machine_crash_shutdown
 -> machine_ops.crash_shutdown
    -> native_machine_crash_shutdown
       -> kdump_nmi_shootdown_cpus ------> Send NMI to other CPUs
       -> disable_IO_APIC
          -> clear_IO_APIC
             -> clear_IO_APIC_pin
                -> ioapic_read_entry
                   -> spin_lock_irqsave(&ioapic_lock, flags)
                   ---Infinite loop here---

 CPU0:
 do_IRQ
 -> handle_irq
    -> handle_edge_irq
        -> ack_apic_edge
           -> move_native_irq
               -> mask_IO_APIC_irq
                  -> mask_IO_APIC_irq_desc
                     -> spin_lock_irqsave(&ioapic_lock, flags)
                     ---Receive NMI here after getting spinlock---
                        -> nmi
                           -> do_nmi
                              -> crash_nmi_callback
                              ---Infinite loop here---

The problem is that although kdump tries to shutdown minimal hardware,
it still needs to disable the IO APIC.  This requires spinlocks which
may be held by another cpu.  This other cpu is being held infinitely in
an NMI context by kdump in order to serialize the crashing path.  Instant
deadlock.

Eric, brought up a point that because the boot code was restructured we may
not need to disable the io apic any more in the crash path.  The original
concern that led to the development of disable_IO_APIC, was that the TSC
calibration on boot up relied on the PIT timer for reference.  Access
to the PIT required 8259 interrupts to be working.  This wouldn't work
if the ioapic needed to be configured.  So on panic path, the ioapic was
reconfigured to use virtual wire mode to allow the 8259 to passthrough.

Those concerns don't hold true now, thanks to the fast TSC calibration code
not needing the PIT.  As a result, we can remove this call and simplify the
locking needed in the panic path.

I tested kdump on an Ivy Bridge platform, a Pentium4 and an old athlon that
did not have an ioapic.  All three were successful.

Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Don Zickus <dzickus@redhat.com>

---
I will probably need some help with my explaination as to why this line is not
needed.  Any input is appreciated!
---
 arch/x86/kernel/crash.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 13ad899..b053cf9 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -96,9 +96,6 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 	cpu_emergency_svm_disable();
 
 	lapic_shutdown();
-#if defined(CONFIG_X86_IO_APIC)
-	disable_IO_APIC();
-#endif
 #ifdef CONFIG_HPET_TIMER
 	hpet_disable();
 #endif
-- 
1.7.7.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
