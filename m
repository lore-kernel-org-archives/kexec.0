Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED0C7C4828D
	for <kexec@archiver.kernel.org>; Mon,  5 Feb 2024 12:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ywCpEcA7xqi3aM9T8Q1B6mwmlbykMpYRCze6TVXL4TQ=; b=qS288BTexyPFHH
	xb0/vZfHDB93ToJZdaW9lrAzdtV/8bE+VHFKRY2Q+X8HGJfioLR7Eeib/l52E3SEikJqR6FaRIiZQ
	ZpORmVX+59HuV+3V9U5Ul3WoP2Er2O3N6n3e3vRBUhgdpCWX1UX21qhHI1sz6kQZylrJC0J9P+C0B
	IUr/uO9T0a9u/FqsBLxYdQBQ4DWiseaOLrPUD6MllKNYkM++7rAnOWXqkCqm9tIFvfkbhT9Gnzh9K
	ltNG/afIMvKgkIdCRwZrhceb6uQuUstVX4yhNPNbgH3pQolG8N6u2SwV0KUZWaS5Xee0eK88+ZAGc
	vQo1qkwEA0kBwJxH5QYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWxj3-0000000374y-2YGG;
	Mon, 05 Feb 2024 12:05:25 +0000
Received: from smtp-fw-80008.amazon.com ([99.78.197.219])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWxj0-0000000373W-3xBk
	for kexec@lists.infradead.org;
	Mon, 05 Feb 2024 12:05:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707134722; x=1738670722;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VONiUp37V5G8RKTN0EmhvHz4ErjJ4ifKDUQ6e8VlzjQ=;
  b=ldc/791qw6jJic1Uai0kv46k6X1Wfizk0tOGGdMAT7eR2d3YERm3mklH
   jHUZ6hCp3vTgh8dtRjl5+2zBoGEDDYu/mFZLH+Ewz+8PELZTA/YOMqNTh
   L/NuBZM/klXbZjUht1oy+3oiCT1mUrFu2AN4Uu9yLIhAo8xh3H6pCt9XV
   k=;
X-IronPort-AV: E=Sophos;i="6.05,245,1701129600"; 
   d="scan'208";a="63755776"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 12:05:21 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.10.100:40572]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.14.233:2525] with esmtp (Farcaster)
 id 27f4f8c6-d18d-45f7-aee0-af42d924df8a; Mon, 5 Feb 2024 12:05:19 +0000 (UTC)
X-Farcaster-Flow-ID: 27f4f8c6-d18d-45f7-aee0-af42d924df8a
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 12:05:19 +0000
Received: from dev-dsk-jgowans-1a-a3faec1f.eu-west-1.amazon.com
 (172.19.112.191) by EX19D014EUC004.ant.amazon.com (10.252.51.182) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 12:05:13 +0000
From: James Gowans <jgowans@amazon.com>
To: <linux-kernel@vger.kernel.org>
CC: Eric Biederman <ebiederm@xmission.com>, <kexec@lists.infradead.org>,
	"Joerg Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	<iommu@lists.linux.dev>, Alexander Viro <viro@zeniv.linux.org.uk>, "Christian
 Brauner" <brauner@kernel.org>, <linux-fsdevel@vger.kernel.org>, Paolo Bonzini
	<pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>,
	<kvm@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-mm@kvack.org>, Alexander Graf <graf@amazon.com>, David Woodhouse
	<dwmw@amazon.co.uk>, "Jan H . Schoenherr" <jschoenh@amazon.de>, Usama Arif
	<usama.arif@bytedance.com>, Anthony Yznaga <anthony.yznaga@oracle.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	<madvenka@linux.microsoft.com>, <steven.sistare@oracle.com>,
	<yuleixzhang@tencent.com>
Subject: [RFC 14/18] intel-iommu: Allocate domain pgtable pages from pkernfs
Date: Mon, 5 Feb 2024 12:01:59 +0000
Message-ID: <20240205120203.60312-15-jgowans@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240205120203.60312-1-jgowans@amazon.com>
References: <20240205120203.60312-1-jgowans@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [172.19.112.191]
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
 EX19D014EUC004.ant.amazon.com (10.252.51.182)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_040523_106279_A2ACAE3E 
X-CRM114-Status: GOOD (  31.57  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

In the previous commit VFIO was updated to be able to define persistent
pgtables on a container. Now the IOMMU driver is updated to accept the
file for persistent pgtables when the domain is allocated and use that
file as the source of pages for the pgtables.

The iommu_ops.domain_alloc callback is extended to page a struct file
for the pkernfs domain pgtables file. Most call sites are updated to
supply NULL here, indicating no persistent pgtables. VFIO's caller is
updated to plumb the pkernfs file through. When this file is supplied
the md_domain_init() function convers the file into a pkernfs region and
uses that region for pgtables.

Similarly to the root pgtables there are use after free issues with this
that need sorting out, and the free() functions also need to be updated
to free from the pkernfs region.

It may be better to store the struct file on the dmar_domain and map
file offset to addr every time rather than using a pkernfs region for
this.
---
 drivers/iommu/intel/iommu.c   | 35 +++++++++++++++++++++++++++--------
 drivers/iommu/intel/iommu.h   |  1 +
 drivers/iommu/iommu.c         | 22 ++++++++++++++--------
 drivers/iommu/pgtable_alloc.c |  7 +++++++
 drivers/iommu/pgtable_alloc.h |  1 +
 fs/pkernfs/iommu.c            |  2 +-
 include/linux/iommu.h         |  6 +++++-
 include/linux/pkernfs.h       |  1 +
 8 files changed, 57 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 315c6b7f901c..809ca9e93992 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -946,7 +946,13 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
 		if (!dma_pte_present(pte)) {
 			uint64_t pteval;
 
-			tmp_page = alloc_pgtable_page(domain->nid, gfp);
+			if (domain->pgtables_allocator.vaddr)
+				iommu_alloc_page_from_region(
+						&domain->pgtables_allocator,
+						&tmp_page,
+						NULL);
+			else
+				tmp_page = alloc_pgtable_page(domain->nid, gfp);
 
 			if (!tmp_page)
 				return NULL;
@@ -2399,7 +2405,7 @@ static int iommu_domain_identity_map(struct dmar_domain *domain,
 				DMA_PTE_READ|DMA_PTE_WRITE, GFP_KERNEL);
 }
 
-static int md_domain_init(struct dmar_domain *domain, int guest_width);
+static int md_domain_init(struct dmar_domain *domain, int guest_width, struct file *ppts);
 
 static int __init si_domain_init(int hw)
 {
@@ -2411,7 +2417,7 @@ static int __init si_domain_init(int hw)
 	if (!si_domain)
 		return -EFAULT;
 
-	if (md_domain_init(si_domain, DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
+	if (md_domain_init(si_domain, DEFAULT_DOMAIN_ADDRESS_WIDTH, NULL)) {
 		domain_exit(si_domain);
 		si_domain = NULL;
 		return -EFAULT;
@@ -4029,7 +4035,7 @@ static void device_block_translation(struct device *dev)
 	info->domain = NULL;
 }
 
-static int md_domain_init(struct dmar_domain *domain, int guest_width)
+static int md_domain_init(struct dmar_domain *domain, int guest_width, struct file *ppts)
 {
 	int adjust_width;
 
@@ -4042,8 +4048,21 @@ static int md_domain_init(struct dmar_domain *domain, int guest_width)
 	domain->iommu_superpage = 0;
 	domain->max_addr = 0;
 
-	/* always allocate the top pgd */
-	domain->pgd = alloc_pgtable_page(domain->nid, GFP_ATOMIC);
+	if (ppts) {
+		unsigned long pgd_phy;
+
+		pkernfs_get_region_for_ppts(
+				ppts,
+				&domain->pgtables_allocator);
+		iommu_get_pgd_page(
+				&domain->pgtables_allocator,
+				(void **) &domain->pgd,
+				&pgd_phy);
+
+	} else {
+		/* always allocate the top pgd */
+		domain->pgd = alloc_pgtable_page(domain->nid, GFP_ATOMIC);
+	}
 	if (!domain->pgd)
 		return -ENOMEM;
 	domain_flush_cache(domain, domain->pgd, PAGE_SIZE);
@@ -4064,7 +4083,7 @@ static struct iommu_domain blocking_domain = {
 	}
 };
 
-static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
+static struct iommu_domain *intel_iommu_domain_alloc(unsigned int type, struct file *ppts)
 {
 	struct dmar_domain *dmar_domain;
 	struct iommu_domain *domain;
@@ -4079,7 +4098,7 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 			pr_err("Can't allocate dmar_domain\n");
 			return NULL;
 		}
-		if (md_domain_init(dmar_domain, DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
+		if (md_domain_init(dmar_domain, DEFAULT_DOMAIN_ADDRESS_WIDTH, ppts)) {
 			pr_err("Domain initialization failed\n");
 			domain_exit(dmar_domain);
 			return NULL;
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 4a2f163a86f3..f772fdcf3828 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -602,6 +602,7 @@ struct dmar_domain {
 	struct list_head dev_pasids;	/* all attached pasids */
 	struct list_head domains;	/* all struct dmar_domains on this IOMMU */
 
+	struct pkernfs_region pgtables_allocator;
 	struct dma_pte	*pgd;		/* virtual address */
 	int		gaw;		/* max guest address width */
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3a67e636287a..f26e83d5b159 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -97,7 +97,7 @@ static int iommu_bus_notifier(struct notifier_block *nb,
 			      unsigned long action, void *data);
 static void iommu_release_device(struct device *dev);
 static struct iommu_domain *__iommu_domain_alloc(const struct bus_type *bus,
-						 unsigned type);
+						 unsigned int type, struct file *ppts);
 static int __iommu_attach_device(struct iommu_domain *domain,
 				 struct device *dev);
 static int __iommu_attach_group(struct iommu_domain *domain,
@@ -1734,7 +1734,7 @@ __iommu_group_alloc_default_domain(const struct bus_type *bus,
 {
 	if (group->default_domain && group->default_domain->type == req_type)
 		return group->default_domain;
-	return __iommu_domain_alloc(bus, req_type);
+	return __iommu_domain_alloc(bus, req_type, NULL);
 }
 
 /*
@@ -1971,7 +1971,7 @@ void iommu_set_fault_handler(struct iommu_domain *domain,
 EXPORT_SYMBOL_GPL(iommu_set_fault_handler);
 
 static struct iommu_domain *__iommu_domain_alloc(const struct bus_type *bus,
-						 unsigned type)
+						 unsigned int type, struct file *ppts)
 {
 	struct iommu_domain *domain;
 	unsigned int alloc_type = type & IOMMU_DOMAIN_ALLOC_FLAGS;
@@ -1979,7 +1979,7 @@ static struct iommu_domain *__iommu_domain_alloc(const struct bus_type *bus,
 	if (bus == NULL || bus->iommu_ops == NULL)
 		return NULL;
 
-	domain = bus->iommu_ops->domain_alloc(alloc_type);
+	domain = bus->iommu_ops->domain_alloc(alloc_type, ppts);
 	if (!domain)
 		return NULL;
 
@@ -2001,9 +2001,15 @@ static struct iommu_domain *__iommu_domain_alloc(const struct bus_type *bus,
 	return domain;
 }
 
+struct iommu_domain *iommu_domain_alloc_persistent(const struct bus_type *bus, struct file *ppts)
+{
+	return __iommu_domain_alloc(bus, IOMMU_DOMAIN_UNMANAGED, ppts);
+}
+EXPORT_SYMBOL_GPL(iommu_domain_alloc_persistent);
+
 struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus)
 {
-	return __iommu_domain_alloc(bus, IOMMU_DOMAIN_UNMANAGED);
+	return __iommu_domain_alloc(bus, IOMMU_DOMAIN_UNMANAGED, NULL);
 }
 EXPORT_SYMBOL_GPL(iommu_domain_alloc);
 
@@ -3198,14 +3204,14 @@ static int __iommu_group_alloc_blocking_domain(struct iommu_group *group)
 		return 0;
 
 	group->blocking_domain =
-		__iommu_domain_alloc(dev->dev->bus, IOMMU_DOMAIN_BLOCKED);
+		__iommu_domain_alloc(dev->dev->bus, IOMMU_DOMAIN_BLOCKED, NULL);
 	if (!group->blocking_domain) {
 		/*
 		 * For drivers that do not yet understand IOMMU_DOMAIN_BLOCKED
 		 * create an empty domain instead.
 		 */
 		group->blocking_domain = __iommu_domain_alloc(
-			dev->dev->bus, IOMMU_DOMAIN_UNMANAGED);
+			dev->dev->bus, IOMMU_DOMAIN_UNMANAGED, NULL);
 		if (!group->blocking_domain)
 			return -EINVAL;
 	}
@@ -3500,7 +3506,7 @@ struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
 	struct iommu_domain *domain;
 
-	domain = ops->domain_alloc(IOMMU_DOMAIN_SVA);
+	domain = ops->domain_alloc(IOMMU_DOMAIN_SVA, false);
 	if (!domain)
 		return NULL;
 
diff --git a/drivers/iommu/pgtable_alloc.c b/drivers/iommu/pgtable_alloc.c
index f0c2e12f8a8b..276db15932cc 100644
--- a/drivers/iommu/pgtable_alloc.c
+++ b/drivers/iommu/pgtable_alloc.c
@@ -7,6 +7,13 @@
  * The first 4 KiB is the bitmap - set the first bit in the bitmap.
  * Scan bitmap to find next free bits - it's next free page.
  */
+void iommu_get_pgd_page(struct pkernfs_region *region, void **vaddr, unsigned long *paddr)
+{
+	set_bit(1, region->vaddr);
+	*vaddr = region->vaddr + (1 << PAGE_SHIFT);
+	if (paddr)
+		*paddr = region->paddr + (1 << PAGE_SHIFT);
+}
 
 void iommu_alloc_page_from_region(struct pkernfs_region *region, void **vaddr, unsigned long *paddr)
 {
diff --git a/drivers/iommu/pgtable_alloc.h b/drivers/iommu/pgtable_alloc.h
index c1666a7be3d3..50c3abba922b 100644
--- a/drivers/iommu/pgtable_alloc.h
+++ b/drivers/iommu/pgtable_alloc.h
@@ -3,6 +3,7 @@
 #include <linux/types.h>
 #include <linux/pkernfs.h>
 
+void iommu_get_pgd_page(struct pkernfs_region *region, void **vaddr, unsigned long *paddr);
 void iommu_alloc_page_from_region(struct pkernfs_region *region,
 				  void **vaddr, unsigned long *paddr);
 
diff --git a/fs/pkernfs/iommu.c b/fs/pkernfs/iommu.c
index f14e76013e85..5d0b256e7dd8 100644
--- a/fs/pkernfs/iommu.c
+++ b/fs/pkernfs/iommu.c
@@ -4,7 +4,7 @@
 #include <linux/io.h>
 
 
-void pkernfs_alloc_iommu_domain_pgtables(struct file *ppts, struct pkernfs_region *pkernfs_region)
+void pkernfs_get_region_for_ppts(struct file *ppts, struct pkernfs_region *pkernfs_region)
 {
 	struct pkernfs_inode *pkernfs_inode;
 	unsigned long *mappings_block_vaddr;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 0225cf7445de..01bb89246ef7 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -101,6 +101,7 @@ struct iommu_domain {
 	enum iommu_page_response_code (*iopf_handler)(struct iommu_fault *fault,
 						      void *data);
 	void *fault_data;
+	struct file *persistent_pgtables;
 	union {
 		struct {
 			iommu_fault_handler_t handler;
@@ -266,7 +267,8 @@ struct iommu_ops {
 	void *(*hw_info)(struct device *dev, u32 *length, u32 *type);
 
 	/* Domain allocation and freeing by the iommu driver */
-	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
+	/* If ppts is not null it is a persistent domain; null is non-persistent */
+	struct iommu_domain *(*domain_alloc)(unsigned int tiommu_domain_type, struct file *ppts);
 
 	struct iommu_device *(*probe_device)(struct device *dev);
 	void (*release_device)(struct device *dev);
@@ -466,6 +468,8 @@ extern bool iommu_present(const struct bus_type *bus);
 extern bool device_iommu_capable(struct device *dev, enum iommu_cap cap);
 extern bool iommu_group_has_isolated_msi(struct iommu_group *group);
 extern struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus);
+extern struct iommu_domain *iommu_domain_alloc_persistent(const struct bus_type *bus,
+							  struct file *ppts);
 extern void iommu_domain_free(struct iommu_domain *domain);
 extern int iommu_attach_device(struct iommu_domain *domain,
 			       struct device *dev);
diff --git a/include/linux/pkernfs.h b/include/linux/pkernfs.h
index 4ca923ee0d82..8aa69ef5a2d8 100644
--- a/include/linux/pkernfs.h
+++ b/include/linux/pkernfs.h
@@ -31,6 +31,7 @@ struct pkernfs_region {
 void pkernfs_alloc_iommu_root_pgtables(struct pkernfs_region *pkernfs_region);
 void pkernfs_alloc_page_from_region(struct pkernfs_region *pkernfs_region,
 				    void **vaddr, unsigned long *paddr);
+void pkernfs_get_region_for_ppts(struct file *ppts, struct pkernfs_region *pkernfs_region);
 void *pkernfs_region_paddr_to_vaddr(struct pkernfs_region *region, unsigned long paddr);
 
 bool pkernfs_is_iommu_domain_pgtables(struct file *f);
-- 
2.40.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
