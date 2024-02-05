Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5822C4828D
	for <kexec@archiver.kernel.org>; Mon,  5 Feb 2024 12:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mNQq7vv1XN366QK6J2tax7G6Wqr9RVaAIvyhffXKKvM=; b=bVetZaEezY3xZv
	pEWCVQAYe6IU/ojPf37aKR1oRUaNy+kFoEU0OHA61ONY+bjKJ84v3AF0P/Xufd1L0krs3lz4CYpmP
	Uz+uV78WHu2GoKEbLab4itb6g1pToNzdoO1v4eUqdA+Q9L6sZY+awBVQJ9dGIZvKvT6aWj9Sm1m19
	G6t2Qp6jlQAGrk/esCwbTTyiJz7XHLRxAyaPVEMFF5B7kKbd0fzFmP3DlO0E16H3rk7JuKLnZK78n
	BlJnS5R9NxX+qI9yru3dpjfmJksRACUr+vTVyrxbypBVcEyUXCL43JGK14IdsRrwk4KIWAOGGvR4K
	9t4mhjLrE5zrDjo8+8+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWxjc-000000037Iz-1frw;
	Mon, 05 Feb 2024 12:06:00 +0000
Received: from smtp-fw-80008.amazon.com ([99.78.197.219])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWxjZ-000000037I6-3QeW
	for kexec@lists.infradead.org;
	Mon, 05 Feb 2024 12:05:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707134757; x=1738670757;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2AUEdbvoftHMg2AkT8RS6u9G56Zx/z0Bmygk8dweA74=;
  b=i/klmtUXhQUrqDvb4qCuzopKWT/ra9S74iPzNL3XvyoyCKcwmf1zgN4T
   miLXyPqCx6UXRj23ocW5tiM35DErXD+aCBEoRp0jMNNqmiSaBol5bQGif
   ZC2YCfK6Dd3qeJdvGBv3PJgo97QbI+tWtNJLMnAJnqpGex+192NyLyvIn
   c=;
X-IronPort-AV: E=Sophos;i="6.05,245,1701129600"; 
   d="scan'208";a="63755948"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 12:05:57 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.17.79:13316]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.45.85:2525] with esmtp (Farcaster)
 id 596cc4dd-1066-4e32-b40f-00d6ab21896d; Mon, 5 Feb 2024 12:05:56 +0000 (UTC)
X-Farcaster-Flow-ID: 596cc4dd-1066-4e32-b40f-00d6ab21896d
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 12:05:56 +0000
Received: from dev-dsk-jgowans-1a-a3faec1f.eu-west-1.amazon.com
 (172.19.112.191) by EX19D014EUC004.ant.amazon.com (10.252.51.182) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 12:05:49 +0000
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
Subject: [RFC 16/18] vfio: support not mapping IOMMU pgtables on live-update
Date: Mon, 5 Feb 2024 12:02:01 +0000
Message-ID: <20240205120203.60312-17-jgowans@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240205120203.60312-1-jgowans@amazon.com>
References: <20240205120203.60312-1-jgowans@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [172.19.112.191]
X-ClientProxiedBy: EX19D042UWB002.ant.amazon.com (10.13.139.175) To
 EX19D014EUC004.ant.amazon.com (10.252.51.182)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_040557_928154_34C0A0A7 
X-CRM114-Status: GOOD (  17.99  )
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

When restoring VMs after live update kexec, the IOVAs for the guest VM
are already present in the persisted page tables. It is unnecessary to
clobber the existing pgtable entries and it may introduce races if
pgtable modifications happen concurrently with DMA.

Provide a new VFIO MAP_DMA flag which userspace can supply to inform
VFIO that the IOVAs are already mapped. In this case VFIO will skip over
the call to the IOMMU driver to do the mapping. VFIO still needs the
MAP_DMA ioctl to set up its internal data structures about the mapping.

It would probably be better to move the persistence one layer up and
persist the VFIO container in pkernfs. That way the whole container
could be picked up and re-used without needing to do any MAP_DMA ioctls
after kexec.
---
 drivers/vfio/vfio_iommu_type1.c | 24 +++++++++++++-----------
 include/uapi/linux/vfio.h       |  1 +
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index b36edfc5c9ef..dc2682fbda2e 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1456,7 +1456,7 @@ static int vfio_iommu_map(struct vfio_iommu *iommu, dma_addr_t iova,
 }
 
 static int vfio_pin_map_dma(struct vfio_iommu *iommu, struct vfio_dma *dma,
-			    size_t map_size)
+			    size_t map_size, unsigned int flags)
 {
 	dma_addr_t iova = dma->iova;
 	unsigned long vaddr = dma->vaddr;
@@ -1479,14 +1479,16 @@ static int vfio_pin_map_dma(struct vfio_iommu *iommu, struct vfio_dma *dma,
 			break;
 		}
 
-		/* Map it! */
-		ret = vfio_iommu_map(iommu, iova + dma->size, pfn, npage,
-				     dma->prot);
-		if (ret) {
-			vfio_unpin_pages_remote(dma, iova + dma->size, pfn,
-						npage, true);
-			vfio_batch_unpin(&batch, dma);
-			break;
+		if (!(flags & VFIO_DMA_MAP_FLAG_LIVE_UPDATE)) {
+			/* Map it! */
+			ret = vfio_iommu_map(iommu, iova + dma->size, pfn, npage,
+					     dma->prot);
+			if (ret) {
+				vfio_unpin_pages_remote(dma, iova + dma->size, pfn,
+							npage, true);
+				vfio_batch_unpin(&batch, dma);
+				break;
+			}
 		}
 
 		size -= npage << PAGE_SHIFT;
@@ -1662,7 +1664,7 @@ static int vfio_dma_do_map(struct vfio_iommu *iommu,
 	if (list_empty(&iommu->domain_list))
 		dma->size = size;
 	else
-		ret = vfio_pin_map_dma(iommu, dma, size);
+		ret = vfio_pin_map_dma(iommu, dma, size, map->flags);
 
 	if (!ret && iommu->dirty_page_tracking) {
 		ret = vfio_dma_bitmap_alloc(dma, pgsize);
@@ -2836,7 +2838,7 @@ static int vfio_iommu_type1_map_dma(struct vfio_iommu *iommu,
 	struct vfio_iommu_type1_dma_map map;
 	unsigned long minsz;
 	uint32_t mask = VFIO_DMA_MAP_FLAG_READ | VFIO_DMA_MAP_FLAG_WRITE |
-			VFIO_DMA_MAP_FLAG_VADDR;
+			VFIO_DMA_MAP_FLAG_VADDR | VFIO_DMA_MAP_FLAG_LIVE_UPDATE;
 
 	minsz = offsetofend(struct vfio_iommu_type1_dma_map, size);
 
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index fa9676bb4b26..d04d28e52110 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1536,6 +1536,7 @@ struct vfio_iommu_type1_dma_map {
 #define VFIO_DMA_MAP_FLAG_READ (1 << 0)		/* readable from device */
 #define VFIO_DMA_MAP_FLAG_WRITE (1 << 1)	/* writable from device */
 #define VFIO_DMA_MAP_FLAG_VADDR (1 << 2)
+#define VFIO_DMA_MAP_FLAG_LIVE_UPDATE  (1 << 3) /* IOVAs already mapped in IOMMU before LU */
 	__u64	vaddr;				/* Process virtual address */
 	__u64	iova;				/* IO virtual address */
 	__u64	size;				/* Size of mapping (bytes) */
-- 
2.40.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
