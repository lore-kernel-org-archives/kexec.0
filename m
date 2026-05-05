Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A50FCD342C
	for <kexec@archiver.kernel.org>; Tue,  5 May 2026 00:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zufAZqrs7wE5NdNZHdqCW4lBwECX6d0FSow8KZpRsP8=; b=hrA8oukfa4j49rBq543C3eFl3H
	KHWktBIhrYfixmtCR1Z14XfQqjLtXViymBofqiwykAFFES6SFpTQhIOYu2zNV5MTeHyJ2kcvFw04/
	TCBUp/y4pgIOzwmwuIu99PVEmsv0LTa4M9ZHcn1mm1NDGTAHvBDR4D4ZiFevMIdbDAoVEAfX7y6+L
	wJvD9bPJ3bTI9wsxnMpExYtoPHJSPl29D3/AxQnv4+Ja/YZlWC6XvGZv3gR1suaxvared5xfG5gBI
	6qCTGU02vz9h42DC2rqMdAAemi1G7Vt7DT2/VScOjgUVMIOARkXLipvxSc7UM76v6/NLj9jmq+tr5
	59XLCPRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wK3de-0000000EiWz-3Ez4;
	Tue, 05 May 2026 00:27:50 +0000
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wK3db-0000000EiTY-3FZA
	for kexec@lists.infradead.org;
	Tue, 05 May 2026 00:27:48 +0000
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-82fa5ecd760so2048374b3a.0
        for <kexec@lists.infradead.org>; Mon, 04 May 2026 17:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777940866; x=1778545666; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zufAZqrs7wE5NdNZHdqCW4lBwECX6d0FSow8KZpRsP8=;
        b=wmR9A5AMNZt24wjpk8uGc8wcgHhtqrG7/Xpuhu5E9lsqrmYxOPVVsr16xtiyivtu/t
         KH1fTnt02ubpIo/32rF8IzbXdeH9zazkvctqdanxkOQvjb4qhpHqVbrxhcggUZ+cxGLo
         HNTzmvtSndaVfTG8IwbhfsZVOUXAVl1XQ1jwhl6yeaR4z+1gOIynTxCJEQOhuIMUH106
         1WuEuqiEzQ04/+1iwl52VnBneMH30TQQDYl9zTZPHkzemCefZyBQn7CSd3WqtbZIKp1P
         TJHOc7ak7wx5/DUR5uGu39pK164MYvN1AyGToh+3UdUDo9OPw/r/8SJmhbiIsyjbBJYl
         SqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777940866; x=1778545666;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zufAZqrs7wE5NdNZHdqCW4lBwECX6d0FSow8KZpRsP8=;
        b=ptZwb8zBrl38MSIqg9TcIqcGVK9mFuEJW+qnsXd30nkoRA8EHOw3IlYokQq9J+WSjC
         UCZjZVM38uVacSnYD1DBNj08dAZJDc1E73EYBkb4taXRQH2oF1FY109tULSVqdReMqVR
         1NYxutOaZj2M8krrRGT47F2phEeBEH7zBjPbKfYrTLni8xfasMm6r7WzrZGjQksE+syv
         hhQEgvbwyALjiPDQt1ef2kolYD1QZAxR6UkixmExTpKArqIUxOkZZ7FNSAPHpiUbs9Ck
         8Y0iRBjhDmbWb7YCVm/aUZ2y0SQ2hrLuaq3cSunGvX+42BtXkBfFe0bClkJ7OZllcHot
         r3dQ==
X-Forwarded-Encrypted: i=1; AFNElJ82yXWmZn+fF/ngVkR02kFlA+JrYy+3KrM7mHAQOSKWzePBAC3TGHN6yOGRaxn6XZHAHeNWcA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzAX2W+uMQ1QhgYZn/UrcztMNe140tL04soh6mvP5lNJMj9SocN
	MZMoNss9oL9oBfrMzRo+RDHNrC8C0MQ1e/K6wj7foHmyPsmKMnfkEfeQmVmIYFazl4N2Y51uYwb
	ZxxpCYZzkJB2I8Q==
X-Received: from pfbmb14.prod.google.com ([2002:a05:6a00:760e:b0:838:5125:b5e4])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3003:b0:835:42cf:1f7a with SMTP id d2e1a72fcca58-83921ef6cf1mr905533b3a.6.1777940865363;
 Mon, 04 May 2026 17:27:45 -0700 (PDT)
Date: Tue,  5 May 2026 00:27:37 +0000
In-Reply-To: <20260505002737.2213734-1-skhawaja@google.com>
Mime-Version: 1.0
References: <20260505002737.2213734-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260505002737.2213734-5-skhawaja@google.com>
Subject: [RFC PATCH 4/4] dma-mapping: Add API to preserve/restore DMA allocation
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
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260504_172747_820486_2F0E7A79 
X-CRM114-Status: GOOD (  11.26  )
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
 include/linux/dma-mapping.h | 50 +++++++++++++++++++++++++++++++++++
 kernel/dma/mapping.c        | 52 +++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+)

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
index 23ed8eb9233e..c315b74a0884 100644
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
@@ -628,6 +630,56 @@ u64 dma_get_required_mask(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dma_get_required_mask);
 
+#ifdef CONFIG_DMA_LIVEUPDATE
+int dma_preserve_allocation_attrs(struct device *dev, void *cpu_addr,
+				  size_t size, dma_addr_t dma_handle,
+				  unsigned long attrs, u64 *state)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+#ifdef CONFIG_DMA_DECLARE_COHERENT
+	return -EOPNOTSUPP;
+#endif
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
+
+	WARN_ON_ONCE(!dev->coherent_dma_mask);
+
+#ifdef CONFIG_DMA_DECLARE_COHERENT
+	return NULL;
+#endif
+
+	if (dma_alloc_direct(dev, ops))
+		return dma_direct_restore_allocation(dev, size, dma_handle,
+						     gfp, attrs, state);
+
+	return NULL;
+}
+EXPORT_SYMBOL(dma_restore_allocation_attrs);
+#endif
+
 void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t flag, unsigned long attrs)
 {
-- 
2.54.0.545.g6539524ca2-goog


