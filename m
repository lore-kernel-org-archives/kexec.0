Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TYCTy-00086M-9F
 for kexec@lists.infradead.org; Tue, 13 Nov 2012 09:08:35 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id DC5F33EE0C0
 for <kexec@lists.infradead.org>; Tue, 13 Nov 2012 18:08:32 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id C272945DE58
 for <kexec@lists.infradead.org>; Tue, 13 Nov 2012 18:08:32 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id A98B645DE56
 for <kexec@lists.infradead.org>; Tue, 13 Nov 2012 18:08:32 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 995F31DB8046
 for <kexec@lists.infradead.org>; Tue, 13 Nov 2012 18:08:32 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 50E741DB804C
 for <kexec@lists.infradead.org>; Tue, 13 Nov 2012 18:08:32 +0900 (JST)
From: Takao Indoh <indou.takao@jp.fujitsu.com>
Message-Id: <20121113090301.1180.93781.sendpatchset@indoh>
In-Reply-To: <20121113090212.1180.12233.sendpatchset@indoh>
References: <20121113090212.1180.12233.sendpatchset@indoh>
Subject: [PATCH v6 5/5] x86, pci: Enable PCI INTx when MSI is disabled
Date: Tue, 13 Nov 2012 18:08:32 +0900 (JST)
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

This patch enables INTx if MSI is disabled in pcibios_enable_device().
In normal case interrupt disable bit in command register is 0b on boot
time, but in case of kdump, this bit may be 1b. It causes problems of
some drivers. At leaset I confirmed mptsas driver does not work in such
a case. This patch fix this problem.

Signed-off-by: Takao Indoh <indou.takao@jp.fujitsu.com>
---
 arch/x86/pci/common.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 720e973..2bb7ecc 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -615,8 +615,10 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 	if ((err = pci_enable_resources(dev, mask)) < 0)
 		return err;
 
-	if (!pci_dev_msi_enabled(dev))
+	if (!pci_dev_msi_enabled(dev)) {
+		pci_intx(dev, true);
 		return pcibios_enable_irq(dev);
+	}
 	return 0;
 }
 
-- 
1.7.1



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
