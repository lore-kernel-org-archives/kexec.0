Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C524C48291
	for <kexec@archiver.kernel.org>; Mon,  5 Feb 2024 12:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IFcVqVAy64L4ymQbKl+ZAewbX0A8h7lvnKh8zcrlBRE=; b=coxrc0w37ykKeI
	vz7A5MyT/3KRRqsgqMvYP2JzKfPf1LZVCPe07iwlSTBloS1baJi1RUw27fWGuqH52BKmI+bc7Ly0H
	Yscl65ldQ48q5+GCumsc0UY5IpAn7ba7tv4vljYdHRYqt1DZh5SYwpdHWVREioyxppFX2aeauh7zX
	lFATTnAb6+GkaJ4qcSZr361ms06fndr/dlClTB0HQ/fVHDJUwhFDiWSwTd+Q+yosjDyeqncyjmggU
	N9wrDsqy7xGgSv62fnvp7fBfsLQzurua6O+gvQcaXD8da435RsNYQua5pV5NOn/71oDjRzTtcgNRx
	hBmMnU+nCy86k5q07Rlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWxhn-000000036WE-0IDQ;
	Mon, 05 Feb 2024 12:04:07 +0000
Received: from smtp-fw-80009.amazon.com ([99.78.197.220])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWxhi-000000036S0-37Lj
	for kexec@lists.infradead.org;
	Mon, 05 Feb 2024 12:04:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707134643; x=1738670643;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iY0J0IZ5qTqLG1CI5oIteOfffrC6hlfw7IE0MCx8M3k=;
  b=JS47LpaHLRTMs13Pk6YnBORpWmJ4YLiAUgugDQu7AK6UHYacO+X3SBao
   HCowJSOX9jI9I/MDSRbli2jOLFa4WxoYpMsm8at5v1lfQ6P0327TvNOnZ
   1aaDDqur2A+1m7QjYPaZenPhKInkgopSqz/4N6ZdcPjQkplYj17kEuC7c
   w=;
X-IronPort-AV: E=Sophos;i="6.05,245,1701129600"; 
   d="scan'208";a="63724432"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 12:03:55 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.10.100:51867]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.28.192:2525] with esmtp (Farcaster)
 id 0b48539d-2334-4d72-bccb-1f938dcbdb04; Mon, 5 Feb 2024 12:03:53 +0000 (UTC)
X-Farcaster-Flow-ID: 0b48539d-2334-4d72-bccb-1f938dcbdb04
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 12:03:53 +0000
Received: from dev-dsk-jgowans-1a-a3faec1f.eu-west-1.amazon.com
 (172.19.112.191) by EX19D014EUC004.ant.amazon.com (10.252.51.182) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 12:03:46 +0000
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
Subject: [RFC 08/18] iommu: Add allocator for pgtables from persistent region
Date: Mon, 5 Feb 2024 12:01:53 +0000
Message-ID: <20240205120203.60312-9-jgowans@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240205120203.60312-1-jgowans@amazon.com>
References: <20240205120203.60312-1-jgowans@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [172.19.112.191]
X-ClientProxiedBy: EX19D033UWC001.ant.amazon.com (10.13.139.218) To
 EX19D014EUC004.ant.amazon.com (10.252.51.182)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_040402_875405_31C8E22C 
X-CRM114-Status: GOOD (  20.89  )
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

The specific IOMMU drivers will need to ability to allocate pages from a
pkernfs IOMMU pgtable file for their pgtables. Also, the IOMMU drivers
will need to ability to consistent get the same page for the root PGD
page - add a specific function to get this PGD "root" page. This is
different to allocating regular pgtable pages because the exact same
page needs to be *restored* after kexec into the pgd pointer on the
IOMMU domain struct.

To support this sort of allocation the pkernfs region is treated as an
array of 512 4 KiB pages, the first of which is an allocation bitmap.
---
 drivers/iommu/Makefile        |  1 +
 drivers/iommu/pgtable_alloc.c | 36 +++++++++++++++++++++++++++++++++++
 drivers/iommu/pgtable_alloc.h |  9 +++++++++
 3 files changed, 46 insertions(+)
 create mode 100644 drivers/iommu/pgtable_alloc.c
 create mode 100644 drivers/iommu/pgtable_alloc.h

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 769e43d780ce..cadebabe9581 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y += amd/ intel/ arm/ iommufd/
+obj-y += pgtable_alloc.o
 obj-$(CONFIG_IOMMU_API) += iommu.o
 obj-$(CONFIG_IOMMU_API) += iommu-traces.o
 obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
diff --git a/drivers/iommu/pgtable_alloc.c b/drivers/iommu/pgtable_alloc.c
new file mode 100644
index 000000000000..f0c2e12f8a8b
--- /dev/null
+++ b/drivers/iommu/pgtable_alloc.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "pgtable_alloc.h"
+#include <linux/mm.h>
+
+/*
+ * The first 4 KiB is the bitmap - set the first bit in the bitmap.
+ * Scan bitmap to find next free bits - it's next free page.
+ */
+
+void iommu_alloc_page_from_region(struct pkernfs_region *region, void **vaddr, unsigned long *paddr)
+{
+	int page_idx;
+
+	page_idx = bitmap_find_free_region(region->vaddr, 512, 0);
+	*vaddr = region->vaddr + (page_idx << PAGE_SHIFT);
+	if (paddr)
+		*paddr = region->paddr + (page_idx << PAGE_SHIFT);
+}
+
+
+void *pgtable_get_root_page(struct pkernfs_region *region, bool liveupdate)
+{
+	/*
+	 * The page immediately after the bitmap is the root page.
+	 * It would be wrong for the page to be allocated if we're
+	 * NOT doing a liveupdate, or for a liveupdate to happen
+	 * with no allocated page. Detect this mismatch.
+	 */
+	if (test_bit(1, region->vaddr) ^ liveupdate) {
+		pr_err("%sdoing a liveupdate but root pg bit incorrect",
+				liveupdate ? "" : "NOT ");
+	}
+	set_bit(1, region->vaddr);
+	return region->vaddr + PAGE_SIZE;
+}
diff --git a/drivers/iommu/pgtable_alloc.h b/drivers/iommu/pgtable_alloc.h
new file mode 100644
index 000000000000..c1666a7be3d3
--- /dev/null
+++ b/drivers/iommu/pgtable_alloc.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#include <linux/types.h>
+#include <linux/pkernfs.h>
+
+void iommu_alloc_page_from_region(struct pkernfs_region *region,
+				  void **vaddr, unsigned long *paddr);
+
+void *pgtable_get_root_page(struct pkernfs_region *region, bool liveupdate);
-- 
2.40.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
