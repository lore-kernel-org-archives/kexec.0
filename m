Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gDDAx-0004gI-Hl
 for kexec@lists.infradead.org; Thu, 18 Oct 2018 18:37:41 +0000
Received: from mail-qk1-f199.google.com ([209.85.222.199])
 by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.76) (envelope-from <gpiccoli@canonical.com>)
 id 1gDDAp-0006e8-NQ
 for kexec@lists.infradead.org; Thu, 18 Oct 2018 18:37:31 +0000
Received: by mail-qk1-f199.google.com with SMTP id x75-v6so31759170qka.18
 for <kexec@lists.infradead.org>; Thu, 18 Oct 2018 11:37:31 -0700 (PDT)
From: "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Subject: [PATCH 3/3] x86/quirks: Add parameter to clear MSIs early on boot
Date: Thu, 18 Oct 2018 15:37:21 -0300
Message-Id: <20181018183721.27467-3-gpiccoli@canonical.com>
In-Reply-To: <20181018183721.27467-1-gpiccoli@canonical.com>
References: <20181018183721.27467-1-gpiccoli@canonical.com>
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
To: linux-pci@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org
Cc: cascardo@canonical.com, kernel@gpiccoli.net, andi@firstfloor.org, bhe@redhat.com, lukas@wunner.de, shan.gavin@linux.alibaba.com, gpiccoli@canonical.com, linux-kernel@vger.kernel.org, gavin.guo@canonical.com, ddstreet@canonical.com, mingo@redhat.com, bp@alien8.de, billy.olsen@canonical.com, mfo@canonical.com, hpa@zytor.com, bhelgaas@google.com, jay.vosburgh@canonical.com, tglx@linutronix.de, dyoung@redhat.com, fabiomirmar@canonical.com, vgoyal@redhat.com

We observed a kdump failure in x86 that was narrowed down to MSI irq
storm coming from a PCI network device. The bug manifests as a lack of
progress in the boot process of kdump kernel, and a flood of kernel
messages like:

[...]
[ 342.265294] do_IRQ: 0.155 No irq handler for vector
[ 342.266916] do_IRQ: 0.155 No irq handler for vector
[ 347.258422] do_IRQ: 14053260 callbacks suppressed
[...]

The root cause of the issue is that kexec process of the kdump kernel
doesn't ensure PCI devices are reset or MSI capabilities are disabled,
so a PCI adapter could produce a huge amount of irqs which would steal
all the processing time for the CPU (specially since we usually restrict
kdump kernel to use a single CPU only).

This patch implements the kernel parameter "pci=clearmsi" to clear the
MSI/MSI-X enable bits in the Message Control register for all PCI devices
during early boot time, thus preventing potential issues in the kexec'ed
kernel. PCI spec also supports/enforces this need (see PCI Local Bus
spec sections 6.8.1.3 and 6.8.2.3).

Suggested-by: Dan Streetman <ddstreet@canonical.com>
Suggested-by: Gavin Shan <shan.gavin@linux.alibaba.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
---
 .../admin-guide/kernel-parameters.txt         |  6 ++++
 arch/x86/include/asm/pci-direct.h             |  1 +
 arch/x86/kernel/early-quirks.c                | 32 +++++++++++++++++++
 arch/x86/pci/common.c                         |  4 +++
 4 files changed, 43 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 92eb1f42240d..aeb510e484d4 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3161,6 +3161,12 @@
 		nomsi		[MSI] If the PCI_MSI kernel config parameter is
 				enabled, this kernel boot option can be used to
 				disable the use of MSI interrupts system-wide.
+		clearmsi	[X86] Clears MSI/MSI-X enable bits early in boot
+				time in order to avoid issues like adapters
+				screaming irqs and preventing boot progress.
+				Also, it enforces the PCI Local Bus spec
+				rule that those bits should be 0 in system reset
+				events (useful for kexec/kdump cases).
 		noioapicquirk	[APIC] Disable all boot interrupt quirks.
 				Safety option to keep boot IRQs enabled. This
 				should never be necessary.
diff --git a/arch/x86/include/asm/pci-direct.h b/arch/x86/include/asm/pci-direct.h
index 813996305bf5..ebb3db2eee41 100644
--- a/arch/x86/include/asm/pci-direct.h
+++ b/arch/x86/include/asm/pci-direct.h
@@ -15,5 +15,6 @@ extern void write_pci_config(u8 bus, u8 slot, u8 func, u8 offset, u32 val);
 extern void write_pci_config_byte(u8 bus, u8 slot, u8 func, u8 offset, u8 val);
 extern void write_pci_config_16(u8 bus, u8 slot, u8 func, u8 offset, u16 val);
 
+extern unsigned int pci_early_clear_msi;
 extern int early_pci_allowed(void);
 #endif /* _ASM_X86_PCI_DIRECT_H */
diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
index fd50f9e21623..21060d80441e 100644
--- a/arch/x86/kernel/early-quirks.c
+++ b/arch/x86/kernel/early-quirks.c
@@ -28,6 +28,37 @@
 #include <asm/irq_remapping.h>
 #include <asm/early_ioremap.h>
 
+static void __init early_pci_clear_msi(int bus, int slot, int func)
+{
+	int pos;
+	u16 ctrl;
+
+	if (likely(!pci_early_clear_msi))
+		return;
+
+	pr_info_once("Clearing MSI/MSI-X enable bits early in boot (quirk)\n");
+
+	pos = pci_early_find_cap(bus, slot, func, PCI_CAP_ID_MSI);
+	if (pos) {
+		ctrl = read_pci_config_16(bus, slot, func, pos + PCI_MSI_FLAGS);
+		ctrl &= ~PCI_MSI_FLAGS_ENABLE;
+		write_pci_config_16(bus, slot, func, pos + PCI_MSI_FLAGS, ctrl);
+
+		/* Read again to flush previous write */
+		ctrl = read_pci_config_16(bus, slot, func, pos + PCI_MSI_FLAGS);
+	}
+
+	pos = pci_early_find_cap(bus, slot, func, PCI_CAP_ID_MSIX);
+	if (pos) {
+		ctrl = read_pci_config_16(bus, slot, func, pos + PCI_MSIX_FLAGS);
+		ctrl &= ~PCI_MSIX_FLAGS_ENABLE;
+		write_pci_config_16(bus, slot, func, pos + PCI_MSIX_FLAGS, ctrl);
+
+		/* Read again to flush previous write */
+		ctrl = read_pci_config_16(bus, slot, func, pos + PCI_MSIX_FLAGS);
+	}
+}
+
 static void __init fix_hypertransport_config(int num, int slot, int func)
 {
 	u32 htcfg;
@@ -709,6 +740,7 @@ static struct chipset early_qrk[] __initdata = {
 		PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, 0, force_disable_hpet},
 	{ PCI_VENDOR_ID_BROADCOM, 0x4331,
 	  PCI_CLASS_NETWORK_OTHER, PCI_ANY_ID, 0, apple_airport_reset},
+	{ PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, early_pci_clear_msi},
 	{}
 };
 
diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index d4ec117c1142..7f6f85bd47a3 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -32,6 +32,7 @@ int noioapicreroute = 1;
 #endif
 int pcibios_last_bus = -1;
 unsigned long pirq_table_addr;
+unsigned int pci_early_clear_msi;
 const struct pci_raw_ops *__read_mostly raw_pci_ops;
 const struct pci_raw_ops *__read_mostly raw_pci_ext_ops;
 
@@ -604,6 +605,9 @@ char *__init pcibios_setup(char *str)
 	} else if (!strcmp(str, "skip_isa_align")) {
 		pci_probe |= PCI_CAN_SKIP_ISA_ALIGN;
 		return NULL;
+	} else if (!strcmp(str, "clearmsi")) {
+		pci_early_clear_msi = 1;
+		return NULL;
 	} else if (!strcmp(str, "noioapicquirk")) {
 		noioapicquirk = 1;
 		return NULL;
-- 
2.19.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
