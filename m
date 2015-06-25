Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z83ve-00083O-87
 for kexec@lists.infradead.org; Thu, 25 Jun 2015 09:58:43 +0000
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v3 5/5] Drivers: hv: vmbus: add special crash handler
Date: Thu, 25 Jun 2015 11:58:06 +0200
Message-Id: <1435226286-24842-6-git-send-email-vkuznets@redhat.com>
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

Full kernel hang is observed when kdump kernel starts after a crash. This
hang happens in vmbus_negotiate_version() function on
wait_for_completion() as Hyper-V host (Win2012R2 in my testing) never
responds to CHANNELMSG_INITIATE_CONTACT as it thinks the connection is
already established. We need to perform some mandatory minimalistic
cleanup before we start new kernel.

Reported-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/include/asm/mshyperv.h |  2 ++
 arch/x86/kernel/cpu/mshyperv.c  | 22 ++++++++++++++++++++++
 drivers/hv/vmbus_drv.c          | 14 ++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index d3db910..d02f9c9 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -22,4 +22,6 @@ void hv_remove_vmbus_irq(void);
 
 void hv_setup_kexec_handler(void (*handler)(void));
 void hv_remove_kexec_handler(void);
+void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs));
+void hv_remove_crash_handler(void);
 #endif
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 09911aa..1a6e742 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -35,6 +35,7 @@ struct ms_hyperv_info ms_hyperv;
 EXPORT_SYMBOL_GPL(ms_hyperv);
 
 static void (*hv_kexec_handler)(void);
+static void (*hv_crash_handler)(struct pt_regs *regs);
 
 #if IS_ENABLED(CONFIG_HYPERV)
 static void (*vmbus_handler)(void);
@@ -85,6 +86,18 @@ void hv_remove_kexec_handler(void)
 	hv_kexec_handler = NULL;
 }
 EXPORT_SYMBOL_GPL(hv_remove_kexec_handler);
+
+void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs))
+{
+	hv_crash_handler = handler;
+}
+EXPORT_SYMBOL_GPL(hv_setup_crash_handler);
+
+void hv_remove_crash_handler(void)
+{
+	hv_crash_handler = NULL;
+}
+EXPORT_SYMBOL_GPL(hv_remove_crash_handler);
 #endif
 
 static void hv_machine_shutdown(void)
@@ -94,6 +107,14 @@ static void hv_machine_shutdown(void)
 	native_machine_shutdown();
 }
 
+static void hv_machine_crash_shutdown(struct pt_regs *regs)
+{
+	if (hv_crash_handler)
+		hv_crash_handler(regs);
+	native_machine_crash_shutdown(regs);
+}
+
+
 static uint32_t  __init ms_hyperv_platform(void)
 {
 	u32 eax;
@@ -167,6 +188,7 @@ static void __init ms_hyperv_init_platform(void)
 #endif
 
 	machine_ops.shutdown = hv_machine_shutdown;
+	machine_ops.crash_shutdown = hv_machine_crash_shutdown;
 }
 
 const __refconst struct hypervisor_x86 x86_hyper_ms_hyperv = {
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 31748a2..1ed9b32 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1071,6 +1071,18 @@ static void hv_kexec_handler(void)
 	hv_cleanup();
 };
 
+static void hv_crash_handler(struct pt_regs *regs)
+{
+	vmbus_initiate_unload();
+	/*
+	 * In crash handler we can't schedule synic cleanup for all CPUs,
+	 * doing the cleanup for current CPU only. This should be sufficient
+	 * for kdump.
+	 */
+	hv_synic_cleanup(NULL);
+	hv_cleanup();
+};
+
 static int __init hv_acpi_init(void)
 {
 	int ret, t;
@@ -1104,6 +1116,7 @@ static int __init hv_acpi_init(void)
 		goto cleanup;
 
 	hv_setup_kexec_handler(hv_kexec_handler);
+	hv_setup_crash_handler(hv_crash_handler);
 
 	return 0;
 
@@ -1118,6 +1131,7 @@ static void __exit vmbus_exit(void)
 	int cpu;
 
 	hv_remove_kexec_handler();
+	hv_remove_crash_handler();
 	vmbus_connection.conn_state = DISCONNECTED;
 	hv_synic_clockevents_cleanup();
 	vmbus_disconnect();
-- 
2.4.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
