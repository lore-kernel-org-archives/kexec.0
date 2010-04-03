Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from sous-sol.org ([216.99.217.87] helo=x200.localdomain)
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1NxsA1-0003tH-16
	for kexec@lists.infradead.org; Sat, 03 Apr 2010 01:28:29 +0000
Message-Id: <20100403012823.099077735@sous-sol.org>
Date: Fri, 02 Apr 2010 18:27:55 -0700
From: Chris Wright <chrisw@sous-sol.org>
Subject: [PATCH 4/4] x86/amd-iommu: use for_each_pci_dev
References: <20100403012751.834020949@sous-sol.org>
Content-Disposition: inline; filename=amd-iommu-use-for_each_pci_dev.patch
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
To: Joerg Roedel <joerg.roedel@amd.com>
Cc: nhorman@redhat.com, nhorman@tuxdriver.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, iommu@lists.linux-foundation.org, ebiederm@xmission.com, vgoyal@redhat.com

Replace open coded version with for_each_pci_dev

Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/x86/kernel/amd_iommu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/amd_iommu.c
+++ b/arch/x86/kernel/amd_iommu.c
@@ -2187,7 +2187,7 @@ static void prealloc_protection_domains(
 	struct dma_ops_domain *dma_dom;
 	u16 devid;
 
-	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	for_each_pci_dev(dev) {
 
 		/* Do we handle this device? */
 		if (!check_device(&dev->dev))


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
