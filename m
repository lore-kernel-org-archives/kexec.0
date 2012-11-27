Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Td9G5-0004Ln-CN
 for kexec@lists.infradead.org; Tue, 27 Nov 2012 00:42:43 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 1D72B3EE0BD
 for <kexec@lists.infradead.org>; Tue, 27 Nov 2012 09:42:35 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id E9CAC45DEBC
 for <kexec@lists.infradead.org>; Tue, 27 Nov 2012 09:42:34 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id C7AF945DEB7
 for <kexec@lists.infradead.org>; Tue, 27 Nov 2012 09:42:34 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id BABF7E08003
 for <kexec@lists.infradead.org>; Tue, 27 Nov 2012 09:42:34 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 6DB761DB8040
 for <kexec@lists.infradead.org>; Tue, 27 Nov 2012 09:42:34 +0900 (JST)
From: Takao Indoh <indou.takao@jp.fujitsu.com>
Message-Id: <20121127004154.3604.89729.sendpatchset@tindoh.g01.fujitsu.local>
In-Reply-To: <20121127004144.3604.61708.sendpatchset@tindoh.g01.fujitsu.local>
References: <20121127004144.3604.61708.sendpatchset@tindoh.g01.fujitsu.local>
Subject: [PATCH v7 1/5] x86, pci: add dummy pci device for early stage
Date: Tue, 27 Nov 2012 09:42:34 +0900 (JST)
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
To: linux-pci@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Takao Indoh <indou.takao@jp.fujitsu.com>, tokunaga.keiich@jp.fujitsu.com, kexec@lists.infradead.org, hbabu@us.ibm.com, andi@firstfloor.org, ddutile@redhat.com, ishii.hironobu@jp.fujitsu.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, yinghai@kernel.org, mingo@redhat.com, vgoyal@redhat.com, khalid@gonehiking.org

So we can pass pci_dev *dev to reuse some generic pci functions.

The original patch was written by Yinghai Lu.

Signed-off-by: Takao Indoh <indou.takao@jp.fujitsu.com>
---
 arch/x86/include/asm/pci-direct.h |    2 +
 arch/x86/pci/early.c              |   74 +++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/pci-direct.h b/arch/x86/include/asm/pci-direct.h
index b1e7a45..b6360d3 100644
--- a/arch/x86/include/asm/pci-direct.h
+++ b/arch/x86/include/asm/pci-direct.h
@@ -18,4 +18,6 @@ extern int early_pci_allowed(void);
 extern unsigned int pci_early_dump_regs;
 extern void early_dump_pci_device(u8 bus, u8 slot, u8 func);
 extern void early_dump_pci_devices(void);
+
+struct pci_dev *get_early_pci_dev(int num, int slot, int func);
 #endif /* _ASM_X86_PCI_DIRECT_H */
diff --git a/arch/x86/pci/early.c b/arch/x86/pci/early.c
index d1067d5..024def7 100644
--- a/arch/x86/pci/early.c
+++ b/arch/x86/pci/early.c
@@ -109,3 +109,77 @@ void early_dump_pci_devices(void)
 		}
 	}
 }
+
+static __init int
+early_pci_read(struct pci_bus *bus, unsigned int devfn, int where,
+			int size, u32 *value)
+{
+	int num, slot, func;
+
+	num = bus->number;
+	slot = PCI_SLOT(devfn);
+	func = PCI_FUNC(devfn);
+	switch (size) {
+	case 1:
+		*value = read_pci_config_byte(num, slot, func, where);
+		break;
+	case 2:
+		*value = read_pci_config_16(num, slot, func, where);
+		break;
+	case 4:
+		*value = read_pci_config(num, slot, func, where);
+		break;
+	}
+
+	return 0;
+}
+
+static __init int
+early_pci_write(struct pci_bus *bus, unsigned int devfn, int where,
+			int size, u32 value)
+{
+	int num, slot, func;
+
+	num = bus->number;
+	slot = PCI_SLOT(devfn);
+	func = PCI_FUNC(devfn);
+	switch (size) {
+	case 1:
+		write_pci_config_byte(num, slot, func, where, (u8)value);
+		break;
+	case 2:
+		write_pci_config_16(num, slot, func, where, (u16)value);
+		break;
+	case 4:
+		write_pci_config(num, slot, func, where, (u32)value);
+		break;
+	}
+
+	return 0;
+}
+
+static __initdata struct pci_ops pci_early_ops = {
+	.read  = early_pci_read,
+	.write = early_pci_write,
+};
+static __initdata struct pci_bus pci_early_bus = {
+	.ops = &pci_early_ops,
+};
+static __initdata char pci_early_init_name[8];
+static __initdata struct pci_dev pci_early_dev;
+
+__init struct pci_dev *get_early_pci_dev(int num, int slot, int func)
+{
+	struct pci_dev *pdev;
+
+	pdev = &pci_early_dev;
+	memset(pdev, 0, sizeof(*pdev));
+
+	pdev->bus = &pci_early_bus,
+	pdev->dev.init_name = pci_early_init_name;
+	pdev->bus->number = num;
+	pdev->devfn = PCI_DEVFN(slot, func);
+	sprintf((char *)pdev->dev.init_name, "%02x:%02x.%01x", num, slot, func);
+
+	return pdev;
+}
-- 
1.7.1



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
