Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C811C44501
	for <kexec@archiver.kernel.org>; Wed,  8 Jul 2026 23:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q+S3FWpLmbV8ubn+1hh1NL45mx9rPGtnbGgWXMOw/Cc=; b=J3yMflsWDL78DKyGM76CZyV+M8
	LBqbzycPeBTKQHtXo80Ta08kN8gBTY2tY9Zrv7Xv2yZXIyDi2j6QESgKMmITyT1m9aApmo/E87r+6
	fsDnPwr1ueaOlceQ2ZU+oih684D4MUXfgvAwOaNzUlw+YG36NOMHICCZeDiamVwNVSwEurmMFuGLo
	2aLd0ZkORlHh3UmjdQC71I3/B6meRBSc1MSpQTG8/iLyHiKEah9PXJvA6EXKeJtyLByn+IWFB1Um5
	kH+BTZxXEr2G1W3mbnYquI3BjWkLgheNEnQx32PSSzbAg2YRxQBpYX/m8kRVTsNrSVO85aU9Qmu82
	Rb2Fg3Fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whc0m-00000000d1x-3Bhb;
	Wed, 08 Jul 2026 23:49:04 +0000
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whc0j-00000000cxc-3zQq
	for kexec@lists.infradead.org;
	Wed, 08 Jul 2026 23:49:03 +0000
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-8482fd61e83so1971694b3a.1
        for <kexec@lists.infradead.org>; Wed, 08 Jul 2026 16:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783554540; x=1784159340; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q+S3FWpLmbV8ubn+1hh1NL45mx9rPGtnbGgWXMOw/Cc=;
        b=kTrUhgBckJJ2rK0CpJEQAzpIdCqPA6h1NQUWCeUGa85ErUrsKRo86+UDfn0RYkufhy
         9v3mGSj7pJt7UI2pCOStlABT0g8qQR42Z+TT3RAA7+QtNIgAZcJiblYjOQS+ecnhqVaX
         nQeJwiITU9iUvaxrjYHXNLkP7Yh4pM83e5Tb3uJyZeA26nL/x7zG0oi58JNWB5GtzLft
         j4+Q+fsJCAFwDH4SM7Zxt+pB45aEzNAxROt4xE+l0cYeZ+ZxNey3Mrncg63B9oCvm0Dk
         XfoCV/l7BtzIL2cFhKs5tDN2wvtb2do13vRcOk+76YgqAacEjVM0NTrO9VZLM+i55ae0
         0nlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783554540; x=1784159340;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q+S3FWpLmbV8ubn+1hh1NL45mx9rPGtnbGgWXMOw/Cc=;
        b=SIrwZE3LPEV5vVV19nhy+vFp6z+mW/KBZipNrkKfdAS5rJuSp1W6Tr6GCQxozYMzCq
         K/OqiYnirzUhdJ5VHjR2aK1IHOZO87lHIr+fTGQB06wVwmzYDW9iuiuj+nV1AMDQLEuf
         yZxYQArjL3VQsMjnFczCkTNtlPyU0ZP0ZOMKk+N+N3NoEb47cyDD5RqGQoDJXyV8nhTj
         z1yFA+3iH9k1kFQn6/o/zOQTDiLf3xK5d9Orw6wDbTEGiaqartuqSqK41pjyJ5jm7K9M
         BMEJ+a4jFJ2Cy0rltTgqIBTyIHa/Dg+hMHMEP1ruj/dRU6rZu2PGigv2v+NCb4c1uwSS
         HMwA==
X-Forwarded-Encrypted: i=1; AHgh+RqFNoLNZG0CwjZt69hxpSVSpDaQxKNGCxBxZb2WnriP3enI0Zq5JN8dBJLrwj0pPDfcBk1SUw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwTp3HyRgBJC57KK6YOLCRsgRnstDR/FzSHaJ/i+hiwgOkccG1G
	wI1o0uQiB8FkOEk0bDlrFdqPqPcYkUSI0blbJJoF5Tdq1TjHev1jHwFL5nv8EHmRqe+rgRz9qfs
	NgirlDdW4nLK02g==
X-Received: from pfqp3.prod.google.com ([2002:aa7:9e83:0:b0:847:9570:daf0])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:8f0b:b0:842:708f:39be with SMTP id d2e1a72fcca58-84842fdf097mr4788740b3a.5.1783554540334;
 Wed, 08 Jul 2026 16:49:00 -0700 (PDT)
Date: Wed,  8 Jul 2026 23:48:50 +0000
In-Reply-To: <20260708234854.4044652-1-skhawaja@google.com>
Mime-Version: 1.0
References: <20260708234854.4044652-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260708234854.4044652-7-skhawaja@google.com>
Subject: [RFC PATCH v2 06/10] dma-mapping: Add API to preserve/restore DMA allocation
From: Samiullah Khawaja <skhawaja@google.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev, 
	kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_164901_997609_B6AA0F91 
X-CRM114-Status: GOOD (  12.33  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Add new DMA APIs that allow preserving/restoring DMA allocations across
live update.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 include/linux/dma-mapping.h | 50 +++++++++++++++++++++++++++++++++++++
 kernel/dma/mapping.c        | 49 ++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index db8ab24a54f4..3756fc15467b 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -210,6 +210,15 @@ void *dma_vmap_noncontiguous(struct device *dev, size_t size,
 void dma_vunmap_noncontiguous(struct device *dev, void *vaddr);
 int dma_mmap_noncontiguous(struct device *dev, struct vm_area_struct *vma,
 		size_t size, struct sg_table *sgt);
+#ifdef CONFIG_DMA_LIVEUPDATE
+int dma_preserve_allocation_attrs(struct device *dev, void *cpu_addr,
+				  size_t size, dma_addr_t dma_handle,
+				  unsigned long attrs, u64 *state);
+void dma_unpreserve_allocation(struct device *dev, u64 state);
+void *dma_restore_allocation_attrs(struct device *dev, size_t size,
+				   dma_addr_t *dma_handle, gfp_t gfp,
+				   unsigned long attrs, u64 state);
+#endif
 #else /* CONFIG_HAS_DMA */
 static inline dma_addr_t dma_map_page_attrs(struct device *dev,
 		struct page *page, size_t offset, size_t size,
@@ -496,6 +505,26 @@ static inline bool dma_need_unmap(struct device *dev)
 }
 #endif /* !CONFIG_HAS_DMA || !CONFIG_DMA_NEED_SYNC */
 
+#if !defined(CONFIG_DMA_LIVEUPDATE) || !defined(CONFIG_HAS_DMA)
+static inline int dma_preserve_allocation_attrs(struct device *dev, void *cpu_addr,
+						size_t size, dma_addr_t dma_handle,
+						unsigned long attrs, u64 *state)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void dma_unpreserve_allocation(struct device *dev, u64 state)
+{
+}
+
+static inline void *dma_restore_allocation_attrs(struct device *dev, size_t size,
+						 dma_addr_t *dma_handle, gfp_t gfp,
+						 unsigned long attrs, u64 state)
+{
+	return NULL;
+}
+#endif
+
 struct page *dma_alloc_pages(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp);
 void dma_free_pages(struct device *dev, size_t size, struct page *page,
@@ -618,6 +647,27 @@ static inline void *dma_alloc_coherent(struct device *dev, size_t size,
 			(gfp & __GFP_NOWARN) ? DMA_ATTR_NO_WARN : 0);
 }
 
+static inline int dma_preserve_coherent_allocation(struct device *dev, void *cpu_addr,
+						   size_t size, dma_addr_t dma_handle, u64 *state)
+{
+	return dma_preserve_allocation_attrs(dev, cpu_addr, size,
+					     dma_handle, 0, state);
+}
+
+static inline void dma_unpreserve_coherent_allocation(struct device *dev, u64 state)
+{
+	dma_unpreserve_allocation(dev, state);
+}
+
+static inline void *dma_restore_coherent_allocation(struct device *dev, size_t size,
+						    dma_addr_t *dma_handle,
+						    gfp_t gfp, u64 state)
+{
+	return dma_restore_allocation_attrs(dev, size, dma_handle, gfp,
+					    (gfp & __GFP_NOWARN) ? DMA_ATTR_NO_WARN : 0,
+					    state);
+}
+
 static inline void dma_free_coherent(struct device *dev, size_t size,
 		void *cpu_addr, dma_addr_t dma_handle)
 {
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 23ed8eb9233e..3b07bf30722c 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -12,6 +12,8 @@
 #include <linux/gfp.h>
 #include <linux/iommu-dma.h>
 #include <linux/kmsan.h>
+#include <linux/kexec_handover.h>
+#include <linux/kho/abi/dma_alloc.h>
 #include <linux/of_device.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
@@ -628,6 +630,53 @@ u64 dma_get_required_mask(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dma_get_required_mask);
 
+#ifdef CONFIG_DMA_LIVEUPDATE
+int dma_preserve_allocation_attrs(struct device *dev, void *cpu_addr,
+				  size_t size, dma_addr_t dma_handle,
+				  unsigned long attrs, u64 *state)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	if (dma_is_from_dev_coherent(dev, cpu_addr))
+		return -EOPNOTSUPP;
+
+	if (dma_alloc_direct(dev, ops))
+		return dma_direct_preserve_allocation(dev, cpu_addr, size,
+						      dma_handle, attrs,
+						      state);
+
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(dma_preserve_allocation_attrs);
+
+void dma_unpreserve_allocation(struct device *dev, u64 state)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	if (dma_alloc_direct(dev, ops))
+		dma_direct_unpreserve_allocation(dev, state);
+}
+EXPORT_SYMBOL(dma_unpreserve_allocation);
+
+void *dma_restore_allocation_attrs(struct device *dev, size_t size,
+				   dma_addr_t *dma_handle, gfp_t gfp,
+				   unsigned long attrs, u64 state)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+	void *cpu_addr = NULL;
+
+	WARN_ON_ONCE(!dev->coherent_dma_mask);
+
+	if (dma_alloc_direct(dev, ops))
+		cpu_addr = dma_direct_restore_allocation(dev, size, dma_handle,
+							 gfp, attrs, state);
+
+	debug_dma_alloc_coherent(dev, size, *dma_handle, cpu_addr, attrs);
+	return cpu_addr;
+}
+EXPORT_SYMBOL(dma_restore_allocation_attrs);
+#endif
+
 void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t flag, unsigned long attrs)
 {
-- 
2.55.0.795.g602f6c329a-goog


