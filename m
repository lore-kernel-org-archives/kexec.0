Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TNefW-0000PC-5V
 for kexec@lists.infradead.org; Mon, 15 Oct 2012 07:00:55 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id A88B23EE0CB
 for <kexec@lists.infradead.org>; Mon, 15 Oct 2012 16:00:46 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 8DD0845DE54
 for <kexec@lists.infradead.org>; Mon, 15 Oct 2012 16:00:46 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 72C7445DE4E
 for <kexec@lists.infradead.org>; Mon, 15 Oct 2012 16:00:46 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 6322B1DB8043
 for <kexec@lists.infradead.org>; Mon, 15 Oct 2012 16:00:46 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id CB3971DB803C
 for <kexec@lists.infradead.org>; Mon, 15 Oct 2012 16:00:45 +0900 (JST)
From: Takao Indoh <indou.takao@jp.fujitsu.com>
Message-Id: <20121015065535.2832.76673.sendpatchset@indoh>
In-Reply-To: <20121015065516.2832.42378.sendpatchset@indoh>
References: <20121015065516.2832.42378.sendpatchset@indoh>
Subject: [PATCH v4 2/2] x86, pci: Enable PCI INTx when MSI is disabled
Date: Mon, 15 Oct 2012 16:00:45 +0900 (JST)
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
Cc: martin.wilck@ts.fujitsu.com, Takao Indoh <indou.takao@jp.fujitsu.com>, kexec@lists.infradead.org, hbabu@us.ibm.com, andi@firstfloor.org, ddutile@redhat.com, ishii.hironobu@jp.fujitsu.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com, vgoyal@redhat.com, khalid@gonehiking.org

This patch enables INTx if MSI is disabled in pcibios_enable_device().
In normal case interrupt disable bit in command register is 0b on boot
time, but in case of kdump, this bit may be 1b. It causes problems of
some drivers. At leaset I confirmed mptsas driver does not work in such
a case. This patch fix this problem.

Signed-off-by: Takao Indoh <indou.takao@jp.fujitsu.com>
---
 arch/x86/pci/common.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

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
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
