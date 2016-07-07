Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bL3ej-0004v9-1G
 for kexec@lists.infradead.org; Thu, 07 Jul 2016 07:23:31 +0000
From: Wei Jiangang <weijg.fnst@cn.fujitsu.com>
Subject: [PATCH] kexec: Fix kdump failure with notsc
Date: Thu, 7 Jul 2016 15:20:05 +0800
Message-ID: <1467876005-17292-1-git-send-email-weijg.fnst@cn.fujitsu.com>
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
To: linux-kernel@vger.kernel.org
Cc: fenghua.yu@intel.com, x86@kernel.org, kexec@lists.infradead.org, mingo@redhat.com, ebiederm@xmission.com, hpa@zytor.com, izumi.taku@jp.fujitsu.com, tglx@linutronix.de, Wei Jiangang <weijg.fnst@cn.fujitsu.com>

If we specify the 'notsc' boot parameter for the dump-capture kernel,
and then trigger a crash(panic) by using "ALT-SysRq-c" or "echo c >
/proc/sysrq-trigger",
the dump-capture kernel will hang in calibrate_delay_converge():

    /* wait for "start of" clock tick */
    ticks = jiffies;
    while (ticks == jiffies)
        ; /* nothing */

serial log of the hang is as follows:

    tsc: Fast TSC calibration using PIT
    tsc: Detected 2099.947 MHz processor
    Calibrating delay loop...

The reason is that the dump-capture kernel hangs in while loops and
waits for jiffies to be updated, but no timer interrupts is passed
to BSP by APIC.

In fact, the local APIC was disabled in reboot and crash path by
lapic_shutdown(). We need to put APIC in legacy mode in kexec jump path
(put the system into PIT during the crash kernel),
so that the dump-capture kernel can get timer interrupts.

BTW,
I found the buggy commit 522e66464467 ("x86/apic: Disable I/O APIC
before shutdown of the local APIC") via bisection.

Originally, I want to revert it.
But Ingo Molnar comments that "By reverting the change can paper over
the bug, but re-introduce the bug that can result in certain CPUs hanging
if IO-APIC sends an APIC message if the lapic is disabled prematurely"
And I think it's pertinent.

Signed-off-by: Wei Jiangang <weijg.fnst@cn.fujitsu.com>
---
 arch/x86/include/asm/apic.h        | 5 +++++
 arch/x86/kernel/apic/apic.c        | 9 +++++++++
 arch/x86/kernel/machine_kexec_32.c | 5 ++---
 arch/x86/kernel/machine_kexec_64.c | 5 ++---
 4 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index bc27611fa58f..5d7e635e580a 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -128,6 +128,7 @@ extern void clear_local_APIC(void);
 extern void disconnect_bsp_APIC(int virt_wire_setup);
 extern void disable_local_APIC(void);
 extern void lapic_shutdown(void);
+extern int lapic_disabled(void);
 extern void sync_Arb_IDs(void);
 extern void init_bsp_APIC(void);
 extern void setup_local_APIC(void);
@@ -165,6 +166,10 @@ extern int setup_APIC_eilvt(u8 lvt_off, u8 vector, u8 msg_type, u8 mask);
 
 #else /* !CONFIG_X86_LOCAL_APIC */
 static inline void lapic_shutdown(void) { }
+static inline int lapic_disabled(void)
+{
+	return 0;
+}
 #define local_apic_timer_c2_ok		1
 static inline void init_apic_mappings(void) { }
 static inline void disable_local_APIC(void) { }
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 60078a67d7e3..d1df250994bb 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -133,6 +133,9 @@ static inline void imcr_apic_to_pic(void)
 }
 #endif
 
+/* Local APIC is disabled by the kernel for crash or reboot path */
+static int disabled_local_apic;
+
 /*
  * Knob to control our willingness to enable the local APIC.
  *
@@ -1097,10 +1100,16 @@ void lapic_shutdown(void)
 #endif
 		disable_local_APIC();
 
+	disabled_local_apic = 1;
 
 	local_irq_restore(flags);
 }
 
+int lapic_disabled(void)
+{
+	return disabled_local_apic;
+}
+
 /**
  * sync_Arb_IDs - synchronize APIC bus arbitration IDs
  */
diff --git a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_kexec_32.c
index 469b23d6acc2..c934a7868e6b 100644
--- a/arch/x86/kernel/machine_kexec_32.c
+++ b/arch/x86/kernel/machine_kexec_32.c
@@ -202,14 +202,13 @@ void machine_kexec(struct kimage *image)
 	local_irq_disable();
 	hw_breakpoint_disable();
 
-	if (image->preserve_context) {
+	if (image->preserve_context || lapic_disabled()) {
 #ifdef CONFIG_X86_IO_APIC
 		/*
 		 * We need to put APICs in legacy mode so that we can
 		 * get timer interrupts in second kernel. kexec/kdump
 		 * paths already have calls to disable_IO_APIC() in
-		 * one form or other. kexec jump path also need
-		 * one.
+		 * one form or other. kexec jump path also need one.
 		 */
 		disable_IO_APIC();
 #endif
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 5a294e48b185..4925a6bb932a 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -269,14 +269,13 @@ void machine_kexec(struct kimage *image)
 	local_irq_disable();
 	hw_breakpoint_disable();
 
-	if (image->preserve_context) {
+	if (image->preserve_context || lapic_disabled()) {
 #ifdef CONFIG_X86_IO_APIC
 		/*
 		 * We need to put APICs in legacy mode so that we can
 		 * get timer interrupts in second kernel. kexec/kdump
 		 * paths already have calls to disable_IO_APIC() in
-		 * one form or other. kexec jump path also need
-		 * one.
+		 * one form or other. kexec jump path also need one.
 		 */
 		disable_IO_APIC();
 #endif
-- 
1.9.3




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
