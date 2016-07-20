Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bPhiU-0001Br-RV
 for kexec@lists.infradead.org; Wed, 20 Jul 2016 02:58:36 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH 1/3] x86/apic/kexec: Enable legacy irq mode before jump to
 kexec/kdump kernel
Date: Wed, 20 Jul 2016 10:58:01 +0800
Message-Id: <1468983483-3952-2-git-send-email-bhe@redhat.com>
In-Reply-To: <1468983483-3952-1-git-send-email-bhe@redhat.com>
References: <1468983483-3952-1-git-send-email-bhe@redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: fenghua.yu@intel.com, Baoquan He <bhe@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, mingo@redhat.com, ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de, weijg.fnst@cn.fujitsu.com, jiang.liu@linux.intel.com, vgoyal@redhat.com

It's reported that if kernel parameter "notsc" is specified kdump kernel
always hang after printing boot log as below:
    ---
    tsc: Fast TSC calibration using PIT
    tsc: Detected 2099.947 MHz processor
    Calibrating delay loop...
    ---

The reason is no timer interrupt during kdump kernel initialization.
With "notsc" specified the function tsc_init() will return early and won't
assign already calibrated value to lpj_fine, we have to rely on timer
interrupt to get cpu loops between jiffies. Then system hangs to wait for
the never coming timer interrupt.

This is caused by buggy 'commit 522e66464467 ("x86/apic: Disable I/O APIC
before shutdown of the local APIC")'. In normal kernel it defaults to be
PIC mode or Virtual Wire mode during system initialization before APIC
mode is enabled and this is done by BIOS initialization. With this timer
interrupt can be handled in legacy irq way. But kexec/kdump kernel won't
go through BIOS, so we have to set system as PIC or Virtual Wire mode
before jump to kdump kernel code directly. This is done in disable_IO_APIC
which includes two parts, firstly it calls clear_IO_APIC() to disable
IO-APIC, then it sets LAPIC and IO-APIC to make system be PIC or Virtual
Wire mode. In commit 522e66464 it put disable_IO_APIC earlier so that
local apic is completely disabled.

So in this patch take clear_IO_APIC out from disable_IO_APIC and rename
disable_IO_APIC as switch_to_legacy_irq_mode. Then only call clear_IO_APIC
when IO-APIC need be disabled. And call switch_to_legacy_irq_mode before
kexec/kdump jumping.

Reported-by: Wei Jiangang <weijg.fnst@cn.fujitsu.com>
Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/include/asm/io_apic.h     |  3 ++-
 arch/x86/kernel/apic/io_apic.c     | 12 ++++--------
 arch/x86/kernel/crash.c            |  2 +-
 arch/x86/kernel/machine_kexec_32.c | 15 +++++----------
 arch/x86/kernel/machine_kexec_64.c | 15 +++++----------
 arch/x86/kernel/reboot.c           |  2 +-
 6 files changed, 18 insertions(+), 31 deletions(-)

diff --git a/arch/x86/include/asm/io_apic.h b/arch/x86/include/asm/io_apic.h
index 6cbf2cf..d15192e 100644
--- a/arch/x86/include/asm/io_apic.h
+++ b/arch/x86/include/asm/io_apic.h
@@ -191,7 +191,8 @@ static inline unsigned int io_apic_read(unsigned int apic, unsigned int reg)
 
 extern void setup_IO_APIC(void);
 extern void enable_IO_APIC(void);
-extern void disable_IO_APIC(void);
+extern void clear_IO_APIC (void);
+extern void switch_to_legacy_irq_mode(void);
 extern void setup_ioapic_dest(void);
 extern int IO_APIC_get_PCI_irq_vector(int bus, int devfn, int pin);
 extern void print_IO_APICs(void);
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 446702e..d8f5cbe 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -587,7 +587,7 @@ static void clear_IO_APIC_pin(unsigned int apic, unsigned int pin)
 		       mpc_ioapic_id(apic), pin);
 }
 
-static void clear_IO_APIC (void)
+void clear_IO_APIC (void)
 {
 	int apic, pin;
 
@@ -1459,15 +1459,11 @@ void native_disable_io_apic(void)
 }
 
 /*
- * Not an __init, needed by the reboot code
+ * Not an __init, needed by kexec/kdump code.
+ * For safety IO-APIC and Local APIC need be cleared before this.
  */
-void disable_IO_APIC(void)
+void switch_to_legacy_irq_mode(void)
 {
-	/*
-	 * Clear the IO-APIC before rebooting:
-	 */
-	clear_IO_APIC();
-
 	if (!nr_legacy_irqs())
 		return;
 
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 9ef978d..236317b 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -182,7 +182,7 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 #ifdef CONFIG_X86_IO_APIC
 	/* Prevent crash_kexec() from deadlocking on ioapic_lock. */
 	ioapic_zap_locks();
-	disable_IO_APIC();
+	clear_IO_APIC();
 #endif
 	lapic_shutdown();
 #ifdef CONFIG_HPET_TIMER
diff --git a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_kexec_32.c
index 469b23d..26cacf6 100644
--- a/arch/x86/kernel/machine_kexec_32.c
+++ b/arch/x86/kernel/machine_kexec_32.c
@@ -202,18 +202,13 @@ void machine_kexec(struct kimage *image)
 	local_irq_disable();
 	hw_breakpoint_disable();
 
-	if (image->preserve_context) {
 #ifdef CONFIG_X86_IO_APIC
-		/*
-		 * We need to put APICs in legacy mode so that we can
-		 * get timer interrupts in second kernel. kexec/kdump
-		 * paths already have calls to disable_IO_APIC() in
-		 * one form or other. kexec jump path also need
-		 * one.
-		 */
-		disable_IO_APIC();
+	/*
+	 * We need to put APICs in legacy mode so that we can
+	 * get timer interrupts in second kernel.
+	 */
+	switch_to_legacy_irq_mode();
 #endif
-	}
 
 	control_page = page_address(image->control_code_page);
 	memcpy(control_page, relocate_kernel, KEXEC_CONTROL_CODE_MAX_SIZE);
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 5a294e4..a720716 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -269,18 +269,13 @@ void machine_kexec(struct kimage *image)
 	local_irq_disable();
 	hw_breakpoint_disable();
 
-	if (image->preserve_context) {
 #ifdef CONFIG_X86_IO_APIC
-		/*
-		 * We need to put APICs in legacy mode so that we can
-		 * get timer interrupts in second kernel. kexec/kdump
-		 * paths already have calls to disable_IO_APIC() in
-		 * one form or other. kexec jump path also need
-		 * one.
-		 */
-		disable_IO_APIC();
+	/*
+	 * We need to put APICs in legacy mode so that we can
+	 * get timer interrupts in second kernel.
+	 */
+	switch_to_legacy_irq_mode();
 #endif
-	}
 
 	control_page = page_address(image->control_code_page) + PAGE_SIZE;
 	memcpy(control_page, relocate_kernel, KEXEC_CONTROL_CODE_MAX_SIZE);
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index a9b31eb..466c860 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -624,7 +624,7 @@ void native_machine_shutdown(void)
 	 * Even without the erratum, it still makes sense to quiet IO APIC
 	 * before disabling Local APIC.
 	 */
-	disable_IO_APIC();
+	clear_IO_APIC();
 #endif
 
 #ifdef CONFIG_SMP
-- 
2.5.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
