Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D5EC48295
	for <kexec@archiver.kernel.org>; Mon,  5 Feb 2024 12:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cAWFjOjg1M+ZLZSIGzkEguvqE5Cy5QUxo8OoGoEB8QM=; b=GMLuX3ZbILO0Bp
	D/w256yxoaLbtXcZFxlG6nPcEtKvVbld4r/lLBrUCoZtk1g0aON8gx9/+/OYO437dbwddOvxzPRBs
	cNPvb28sFTmMf5P6fA2SphOm1gs2wr50M/p1HsEIMu085xjiRrOgVxQ69OK2nxzsFAOa92zkjrIwD
	v1C4pzg0U8baNNTk1A8SSgGELBt4a87p+G2NNBqRs9ASLlbBDgxjpf2sKLObuIl3x+KnyT5DhGf1J
	RztJW6U8SC230BfKPiCd0GENlBQstv4zuEAhwlXev31tDDarS1ua0HrgpQrxdiLBsX0IkoNhVjMaH
	Y7QSVCO5jDp0DJ7MZMiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWxiK-000000036j7-1TcI;
	Mon, 05 Feb 2024 12:04:40 +0000
Received: from smtp-fw-9105.amazon.com ([207.171.188.204])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWxiH-000000036gx-3Qdj
	for kexec@lists.infradead.org;
	Mon, 05 Feb 2024 12:04:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707134677; x=1738670677;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TxdyyN106bvAzVLll6ZOpOdKPjlViDjzUv1y30GOivQ=;
  b=sFIvUIFnEdWpiGkI1/UsWXOpLkXU7g6RWfMHFzM76ktFLYAe5QI6w2Fi
   6mcZnU57oKZT743TY0ZMC9YMhTdblsjs7hhFUA7oUPtqUjYTAKNxzeA6s
   qGCgqzw1LBLsDIQHm/y/YieML54Osl2cdhLcK1eOZgIsKGApWvc0cxDV0
   4=;
X-IronPort-AV: E=Sophos;i="6.05,245,1701129600"; 
   d="scan'208";a="702759804"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 12:04:26 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.10.100:58296]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.14.129:2525] with esmtp (Farcaster)
 id e132c2ad-2d34-4ccb-890d-621a7e0c08cd; Mon, 5 Feb 2024 12:04:25 +0000 (UTC)
X-Farcaster-Flow-ID: e132c2ad-2d34-4ccb-890d-621a7e0c08cd
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 12:04:23 +0000
Received: from dev-dsk-jgowans-1a-a3faec1f.eu-west-1.amazon.com
 (172.19.112.191) by EX19D014EUC004.ant.amazon.com (10.252.51.182) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 12:04:17 +0000
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
Subject: [RFC 09/18] intel-iommu: Use pkernfs for root/context pgtable pages
Date: Mon, 5 Feb 2024 12:01:54 +0000
Message-ID: <20240205120203.60312-10-jgowans@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240205120203.60312-1-jgowans@amazon.com>
References: <20240205120203.60312-1-jgowans@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [172.19.112.191]
X-ClientProxiedBy: EX19D041UWA001.ant.amazon.com (10.13.139.124) To
 EX19D014EUC004.ant.amazon.com (10.252.51.182)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_040437_924135_D4164674 
X-CRM114-Status: GOOD (  20.55  )
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

The previous commits were preparation for using pkernfs memory for IOMMU
pgtables: a file in the filesystem is available and an allocator to
allocate 4-KiB pages from that file is available.

Now use those to actually use pkernfs memory for root and context
pgtable pages. If pkernfs is enabled then a "region" (physical and
virtual memory chunk) is fetch from pkernfs and used to drive the
allocator. Should this rather just be a pointer to a pkernfs inode? That
abstraction seems leaky but without having the ability to store struct
files at this point it's probably the more accurate.

The freeing still needs to be hooked into the allocator...
---
 drivers/iommu/intel/iommu.c | 24 ++++++++++++++++++++----
 drivers/iommu/intel/iommu.h |  2 ++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 744e4e6b8d72..2dd3f055dbce 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -19,6 +19,7 @@
 #include <linux/memory.h>
 #include <linux/pci.h>
 #include <linux/pci-ats.h>
+#include <linux/pkernfs.h>
 #include <linux/spinlock.h>
 #include <linux/syscore_ops.h>
 #include <linux/tboot.h>
@@ -28,6 +29,7 @@
 #include "../dma-iommu.h"
 #include "../irq_remapping.h"
 #include "../iommu-sva.h"
+#include "../pgtable_alloc.h"
 #include "pasid.h"
 #include "cap_audit.h"
 #include "perfmon.h"
@@ -617,7 +619,12 @@ struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
 		if (!alloc)
 			return NULL;
 
-		context = alloc_pgtable_page(iommu->node, GFP_ATOMIC);
+		if (pkernfs_enabled())
+			iommu_alloc_page_from_region(
+				&iommu->pkernfs_region,
+				(void **) &context, NULL);
+		else
+			context = alloc_pgtable_page(iommu->node, GFP_ATOMIC);
 		if (!context)
 			return NULL;
 
@@ -1190,7 +1197,15 @@ static int iommu_alloc_root_entry(struct intel_iommu *iommu)
 {
 	struct root_entry *root;
 
-	root = alloc_pgtable_page(iommu->node, GFP_ATOMIC);
+	if (pkernfs_enabled()) {
+		pkernfs_alloc_iommu_root_pgtables(&iommu->pkernfs_region);
+		root = pgtable_get_root_page(
+				&iommu->pkernfs_region,
+				liveupdate);
+	} else {
+		root = alloc_pgtable_page(iommu->node, GFP_ATOMIC);
+	}
+
 	if (!root) {
 		pr_err("Allocating root entry for %s failed\n",
 			iommu->name);
@@ -2790,7 +2805,7 @@ static int __init init_dmars(void)
 
 		init_translation_status(iommu);
 
-		if (translation_pre_enabled(iommu) && !is_kdump_kernel()) {
+		if (translation_pre_enabled(iommu) && !is_kdump_kernel() && !liveupdate) {
 			iommu_disable_translation(iommu);
 			clear_translation_pre_enabled(iommu);
 			pr_warn("Translation was enabled for %s but we are not in kdump mode\n",
@@ -2806,7 +2821,8 @@ static int __init init_dmars(void)
 		if (ret)
 			goto free_iommu;
 
-		if (translation_pre_enabled(iommu)) {
+		/* For the live update case restore pgtables, don't copy */
+		if (translation_pre_enabled(iommu) && !liveupdate) {
 			pr_info("Translation already enabled - trying to copy translation structures\n");
 
 			ret = copy_translation_tables(iommu);
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index e6a3e7065616..a2338e398ba3 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -22,6 +22,7 @@
 #include <linux/bitfield.h>
 #include <linux/xarray.h>
 #include <linux/perf_event.h>
+#include <linux/pkernfs.h>
 
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
@@ -672,6 +673,7 @@ struct intel_iommu {
 	unsigned long	*copied_tables; /* bitmap of copied tables */
 	spinlock_t	lock; /* protect context, domain ids */
 	struct root_entry *root_entry; /* virtual address */
+	struct pkernfs_region pkernfs_region;
 
 	struct iommu_flush flush;
 #endif
-- 
2.40.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
