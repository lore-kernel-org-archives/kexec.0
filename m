Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RwM5s-0006RK-PI
 for kexec@lists.infradead.org; Sat, 11 Feb 2012 23:11:03 +0000
Date: Sat, 11 Feb 2012 15:09:47 -0800
From: tip-bot for Don Zickus <dzickus@redhat.com>
Message-ID: <tip-d9bc9be89629445758670220787683e37c93f6c1@git.kernel.org>
Subject: [tip:x86/debug] x86/kdump: No need to disable ioapic/
 lapic in crash path
MIME-Version: 1.0
Content-Disposition: inline
Reply-To: linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com,
 yinghai@kernel.org, torvalds@linux-foundation.org, kexec@lists.infradead.org,
 vgoyal@redhat.com, ebiederm@xmission.com, akpm@linux-foundation.org,
 tglx@linutronix.de, dzickus@redhat.com, mingo@elte.hu
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
To: linux-tip-commits@vger.kernel.org
Cc: dzickus@redhat.com, yinghai@kernel.org, mingo@elte.hu, kexec@lists.infradead.org, mingo@redhat.com, ebiederm@xmission.com, hpa@zytor.com, akpm@linux-foundation.org, torvalds@linux-foundation.org, tglx@linutronix.de, vgoyal@redhat.com

Commit-ID:  d9bc9be89629445758670220787683e37c93f6c1
Gitweb:     http://git.kernel.org/tip/d9bc9be89629445758670220787683e37c93f6c1
Author:     Don Zickus <dzickus@redhat.com>
AuthorDate: Thu, 9 Feb 2012 16:53:41 -0500
Committer:  Ingo Molnar <mingo@elte.hu>
CommitDate: Sat, 11 Feb 2012 15:38:53 +0100

x86/kdump: No need to disable ioapic/lapic in crash path

A customer of ours noticed when their machine crashed, kdump did
not work but hung instead.  Using their firmware dumping
solution they grabbed a vmcore and decoded the stacks on the
cpus.  What they noticed seemed to be a rare deadlock with the
ioapic_lock.

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

The problem is that although kdump tries to shutdown minimal
hardware, it still needs to disable the IO APIC.  This requires
spinlocks which may be held by another cpu.  This other cpu is
being held infinitely in an NMI context by kdump in order to
serialize the crashing path.  Instant deadlock.

Eric brought up a point that because the boot code was
restructured we may not need to disable the io apic any more in
the crash path.  The original concern that led to the
development of disable_IO_APIC, was that the jiffies calibration
on boot up relied on the PIT timer for reference.  Access to the
PIT required 8259 interrupts to be working.  This wouldn't work
if the ioapic needed to be configured.  So on panic path, the
ioapic was reconfigured to use virtual wire mode to allow the 8259 to passthrough.

Those concerns don't hold true now, thanks to the jiffies
calibration code not needing the PIT.  As a result, we can
remove this call and simplify the locking needed in the panic
path.

The same work allowed us to remove the need to disable the local
apic on shutdown too.  This should allow us to jump to the
second a little faster.

I tested kdump on an Ivy Bridge platform, a Pentium4 and an old
athlon that did not have an ioapic.  All three were successful.

I also tested using lkdtm that would use jprobes to panic the
system when entering do_IRQ.  The idea was to see how the system
reacted with an interrupt pending in the second kernel.  My
core2 quad successfully kdump'd 3 times in a row with no issues.

v2: removed the disable lapic code too

Signed-off-by: Don Zickus <dzickus@redhat.com>
Acked-by: Eric W. Biederman <ebiederm@xmission.com>
Cc: kexec-list <kexec@lists.infradead.org>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Yinghai Lu <yinghai@kernel.org>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/x86/kernel/crash.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 13ad899..571f253 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -54,16 +54,12 @@ static void kdump_nmi_callback(int cpu, struct pt_regs *regs)
 	 */
 	cpu_emergency_vmxoff();
 	cpu_emergency_svm_disable();
-
-	disable_local_APIC();
 }
 
 static void kdump_nmi_shootdown_cpus(void)
 {
 	in_crash_kexec = 1;
 	nmi_shootdown_cpus(kdump_nmi_callback);
-
-	disable_local_APIC();
 }
 
 #else
@@ -95,10 +91,6 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 	cpu_emergency_vmxoff();
 	cpu_emergency_svm_disable();
 
-	lapic_shutdown();
-#if defined(CONFIG_X86_IO_APIC)
-	disable_IO_APIC();
-#endif
 #ifdef CONFIG_HPET_TIMER
 	hpet_disable();
 #endif

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
