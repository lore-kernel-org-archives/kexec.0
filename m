Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z83vZ-000833-8G
 for kexec@lists.infradead.org; Thu, 25 Jun 2015 09:58:38 +0000
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v3 3/5] Drivers: hv: vmbus: add special kexec handler
Date: Thu, 25 Jun 2015 11:58:04 +0200
Message-Id: <1435226286-24842-4-git-send-email-vkuznets@redhat.com>
In-Reply-To: <1435226286-24842-1-git-send-email-vkuznets@redhat.com>
References: <1435226286-24842-1-git-send-email-vkuznets@redhat.com>
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
To: devel@linuxdriverproject.org
Cc: Olaf Hering <olaf@aepfle.de>, Greg KH <gregkh@linuxfoundation.org>, Haiyang Zhang <haiyangz@microsoft.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, "K. Y. Srinivasan" <kys@microsoft.com>

When general-purpose kexec (not kdump) is being performed in Hyper-V guest
the newly booted kernel fails with an MCE error coming from the host. It
is the same error which was fixed in the "Drivers: hv: vmbus: Implement
the protocol for tearing down vmbus state" commit - monitor pages remain
special and when they're being written to (as the new kernel doesn't know
these pages are special) bad things happen. We need to perform some
minimalistic cleanup before booting a new kernel on kexec. To do so we
need to register a special machine_ops.shutdown handler to be executed
before the native_machine_shutdown(). Registering a shutdown notification
handler via the register_reboot_notifier() call is not sufficient as it
happens to early for our purposes. machine_ops is not being exported to
modules (and I don't think we want to export it) so let's do this in
mshyperv.c

The minimalistic cleanup consists of cleaning up clockevents, synic MSRs,
guest os id MSR, and hypercall MSR.

Kdump doesn't require all this stuff as it lives in a separate memory
space.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/include/asm/mshyperv.h |  2 ++
 arch/x86/kernel/cpu/mshyperv.c  | 24 ++++++++++++++++++++++++
 drivers/hv/vmbus_drv.c          | 14 ++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index c163215..d3db910 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -20,4 +20,6 @@ void hyperv_vector_handler(struct pt_regs *regs);
 void hv_setup_vmbus_irq(void (*handler)(void));
 void hv_remove_vmbus_irq(void);
 
+void hv_setup_kexec_handler(void (*handler)(void));
+void hv_remove_kexec_handler(void);
 #endif
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 939155f..09911aa 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -18,6 +18,7 @@
 #include <linux/efi.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/kexec.h>
 #include <asm/processor.h>
 #include <asm/hypervisor.h>
 #include <asm/hyperv.h>
@@ -28,10 +29,13 @@
 #include <asm/i8259.h>
 #include <asm/apic.h>
 #include <asm/timer.h>
+#include <asm/reboot.h>
 
 struct ms_hyperv_info ms_hyperv;
 EXPORT_SYMBOL_GPL(ms_hyperv);
 
+static void (*hv_kexec_handler)(void);
+
 #if IS_ENABLED(CONFIG_HYPERV)
 static void (*vmbus_handler)(void);
 
@@ -69,8 +73,27 @@ void hv_remove_vmbus_irq(void)
 }
 EXPORT_SYMBOL_GPL(hv_setup_vmbus_irq);
 EXPORT_SYMBOL_GPL(hv_remove_vmbus_irq);
+
+void hv_setup_kexec_handler(void (*handler)(void))
+{
+	hv_kexec_handler = handler;
+}
+EXPORT_SYMBOL_GPL(hv_setup_kexec_handler);
+
+void hv_remove_kexec_handler(void)
+{
+	hv_kexec_handler = NULL;
+}
+EXPORT_SYMBOL_GPL(hv_remove_kexec_handler);
 #endif
 
+static void hv_machine_shutdown(void)
+{
+	if (kexec_in_progress && hv_kexec_handler)
+		hv_kexec_handler();
+	native_machine_shutdown();
+}
+
 static uint32_t  __init ms_hyperv_platform(void)
 {
 	u32 eax;
@@ -143,6 +166,7 @@ static void __init ms_hyperv_init_platform(void)
 	no_timer_check = 1;
 #endif
 
+	machine_ops.shutdown = hv_machine_shutdown;
 }
 
 const __refconst struct hypervisor_x86 x86_hyper_ms_hyperv = {
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 00d5158..31748a2 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1060,6 +1060,17 @@ static struct acpi_driver vmbus_acpi_driver = {
 	},
 };
 
+static void hv_kexec_handler(void)
+{
+	int cpu;
+
+	hv_synic_clockevents_cleanup();
+	vmbus_initiate_unload();
+	for_each_online_cpu(cpu)
+		smp_call_function_single(cpu, hv_synic_cleanup, NULL, 1);
+	hv_cleanup();
+};
+
 static int __init hv_acpi_init(void)
 {
 	int ret, t;
@@ -1092,6 +1103,8 @@ static int __init hv_acpi_init(void)
 	if (ret)
 		goto cleanup;
 
+	hv_setup_kexec_handler(hv_kexec_handler);
+
 	return 0;
 
 cleanup:
@@ -1104,6 +1117,7 @@ static void __exit vmbus_exit(void)
 {
 	int cpu;
 
+	hv_remove_kexec_handler();
 	vmbus_connection.conn_state = DISCONNECTED;
 	hv_synic_clockevents_cleanup();
 	vmbus_disconnect();
-- 
2.4.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
