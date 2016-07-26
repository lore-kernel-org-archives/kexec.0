Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bRsf3-0000re-En
 for kexec@lists.infradead.org; Tue, 26 Jul 2016 03:04:02 +0000
From: Wei Jiangang <weijg.fnst@cn.fujitsu.com>
Subject: [PATCH v2 3/3] x86/apic: Improved the setting of interrupt mode for
 bsp
Date: Tue, 26 Jul 2016 10:59:55 +0800
Message-ID: <1469501995-2991-4-git-send-email-weijg.fnst@cn.fujitsu.com>
In-Reply-To: <1469501995-2991-1-git-send-email-weijg.fnst@cn.fujitsu.com>
References: <1469501995-2991-1-git-send-email-weijg.fnst@cn.fujitsu.com>
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
Cc: bhe@redhat.com, xpang@redhat.com, joro@8bytes.org, x86@kernel.org, kexec@lists.infradead.org, Cao jin <caoj.fnst@cn.fujitsu.com>, mingo@redhat.com, kernel@kyup.com, ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de, Wei Jiangang <weijg.fnst@cn.fujitsu.com>

If we specify the 'notsc' parameter for the dump-capture kernel,
and then trigger a crash(panic) by using "ALT-SysRq-c" or
"echo c > /proc/sysrq-trigger", the dump-capture kernel will
hang in calibrate_delay_converge() and wait for jiffies changes.
serial log as follows:

    tsc: Fast TSC calibration using PIT
    tsc: Detected 2099.947 MHz processor
    Calibrating delay loop...

The reason for jiffies not changes is there's no timer interrupt
passed to dump-capture kernel.

In fact, once kernel panic occurs, the local APIC is disabled
by lapic_shutdown() in reboot path.
generly speaking, local APIC state can be initialized by BIOS
after Power-Up or Reset, which doesn't apply to kdump case.
so the kernel has to be responsible for initialize the interrupt
mode properly according the latest status of APIC in bootup path.

An MP operating system is booted under either PIC mode or
virtual wire mode. Later, the operating system switches to
symmetric I/O mode as it enters multiprocessor mode.
Two kinds of virtual wire mode are defined in Intel MP spec:
virtual wire mode via local APIC or via I/O APIC.

Now we determine the mode of APIC only through a SMP BIOS(MP table).
That's not enough. It's better to do further check if APIC works
with effective interrupt mode, and then, do some proper setting.

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
Signed-off-by: Wei Jiangang <weijg.fnst@cn.fujitsu.com>
---
 arch/x86/include/asm/io_apic.h |  5 ++++
 arch/x86/kernel/apic/apic.c    | 60 +++++++++++++++++++++++++++++++++++++++++-
 arch/x86/kernel/apic/io_apic.c | 28 ++++++++++++++++++++
 3 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/io_apic.h b/arch/x86/include/asm/io_apic.h
index 6cbf2cfb3f8a..a3257366bf7f 100644
--- a/arch/x86/include/asm/io_apic.h
+++ b/arch/x86/include/asm/io_apic.h
@@ -190,6 +190,7 @@ static inline unsigned int io_apic_read(unsigned int apic, unsigned int reg)
 }
 
 extern void setup_IO_APIC(void);
+extern bool virt_wire_through_ioapic(void);
 extern void enable_IO_APIC(void);
 extern void disable_IO_APIC(void);
 extern void setup_ioapic_dest(void);
@@ -231,6 +232,10 @@ static inline void io_apic_init_mappings(void) { }
 #define native_disable_io_apic		NULL
 
 static inline void setup_IO_APIC(void) { }
+static inline bool virt_wire_through_ioapic(void)
+{
+	return false;
+}
 static inline void enable_IO_APIC(void) { }
 static inline void setup_ioapic_dest(void) { }
 
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 8e25b9b2d351..a3939fb130cc 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1124,6 +1124,58 @@ void __init sync_Arb_IDs(void)
 }
 
 /*
+ * Check APIC enable/disable flag
+ */
+static bool check_apic_enabled(void)
+{
+	unsigned int value;
+
+	/*
+	 * If APIC is disabled globally (IA32_APIC_BASE[11] == 0)
+	 * the boot cpu hasn't X86_FEATURE_APIC,
+	 * and init_bsp_APIC() has already checked it before.
+	 * so no need to check global enable/disable flag here
+	 */
+
+	/* Check the software enable/disable flag */
+	value = apic_read(APIC_SPIV);
+	if (!(value & APIC_SPIV_APIC_ENABLED))
+		return false;
+
+	return true;
+}
+
+/*
+ * Return false means the through-local-APIC virtual wire mode is inactive
+ */
+static bool virt_wire_through_lapic(void)
+{
+	unsigned int value;
+
+	/*
+	 * The through-local-APIC virtual wire mode requests
+	 * local APIC to enable LINT0 for ExtINT delivery mode
+	 * and LINT1 for NMI delivery mode
+	 */
+	value = apic_read(APIC_LVT0);
+	if (GET_APIC_DELIVERY_MODE(value) != APIC_MODE_EXTINT)
+		return false;
+
+	value = apic_read(APIC_LVT1);
+	if (GET_APIC_DELIVERY_MODE(value) != APIC_MODE_NMI)
+		return false;
+
+	return true;
+}
+
+static bool check_virt_wire_mode(void)
+{
+	/* If neither of virtual wire mode is active, return false */
+	return (check_apic_enabled() && (virt_wire_through_lapic() ||
+		virt_wire_through_ioapic()));
+}
+
+/*
  * An initial setup of the virtual wire mode.
  */
 void __init init_bsp_APIC(void)
@@ -1133,8 +1185,14 @@ void __init init_bsp_APIC(void)
 	/*
 	 * Don't do the setup now if we have a SMP BIOS as the
 	 * through-I/O-APIC virtual wire mode might be active.
+	 *
+	 * It's better to do further check if either through-I/O-APIC
+	 * or through-local-APIC is active.
+	 * the worst case is that both of them are inactive, If so,
+	 * we need to enable the through-local-APIC virtual wire mode
 	 */
-	if (smp_found_config || !boot_cpu_has(X86_FEATURE_APIC))
+	if (pic_mode || !boot_cpu_has(X86_FEATURE_APIC) ||
+	    (smp_found_config && check_virt_wire_mode()))
 		return;
 
 	/*
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 446702ed99dc..f794d389ba85 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1379,6 +1379,34 @@ void __init print_IO_APICs(void)
 /* Where if anywhere is the i8259 connect in external int mode */
 static struct { int pin, apic; } ioapic_i8259 = { -1, -1 };
 
+/*
+ * Return false means the through-I/O-APIC virtual wire mode is inactive
+ */
+bool virt_wire_through_ioapic(void)
+{
+	int apic, pin;
+
+	for_each_ioapic_pin(apic, pin) {
+		/* See if any of the pins is in ExtINT mode */
+		struct IO_APIC_route_entry entry = ioapic_read_entry(apic, pin);
+
+		/*
+		 * If the interrupt line is enabled and in ExtInt mode
+		 * I have found the pin where the i8259 is connected.
+		 */
+		if ((entry.mask == 0) && (entry.delivery_mode == dest_ExtINT))
+			return true;
+	}
+
+	/*
+	 * The through-I/O-APIC virtual wire mode requests
+	 * I/O APIC to be connected i8259 in chapter 3.6.2.2 of the MP v1.4 spec
+	 * If no pin in ExtInt mode, the through-I/O-APIC virtual wire mode can
+	 * be regarded as inactive
+	 */
+	return false;
+}
+
 void __init enable_IO_APIC(void)
 {
 	int i8259_apic, i8259_pin;
-- 
1.9.3




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
