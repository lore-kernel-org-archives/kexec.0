Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD0B0C44507
	for <kexec@archiver.kernel.org>; Wed,  8 Jul 2026 23:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mg8HPDVADkikyFkQazKzK0at34W1Wn3VUkaO82xr5dA=; b=nBo2XxEPPyb/wBjW8qteNxzSIO
	LNDnHqA39SjAMjUPXvdmEOjpR+wcQZmD9f/nncYchAosxAPdL5JxJya+fMlOO2FkjVUNmtwXzXO8U
	OmFYSpuGOh7dzzPKIt4AWHi+J24FGNhRh8XT3/KvIf/aAmopJRK07AroiqfRFfdqMcMWyGwA3t+K8
	28VuY+s0s99DE4PRp2F/ptapb4i7qPsCGmDeQX8Z4vWqvEBTRT1qxQ5NvurWxXVq6dnvYnpfwr6Tc
	VT7spo9OPOsQyQrVqL2rfvXLQGU2tufNue1wZeiKWmakO6OCCQxw7RJIUjmCDPT1iRrWmORM4jsSp
	+NpjS94Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whc0m-00000000d2F-3Yi5;
	Wed, 08 Jul 2026 23:49:04 +0000
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whc0k-00000000cyK-1pNV
	for kexec@lists.infradead.org;
	Wed, 08 Jul 2026 23:49:03 +0000
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-84854c2f888so784770b3a.3
        for <kexec@lists.infradead.org>; Wed, 08 Jul 2026 16:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783554541; x=1784159341; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mg8HPDVADkikyFkQazKzK0at34W1Wn3VUkaO82xr5dA=;
        b=F17/4Hy+H7U/6H/xtuispJSVOCNSYOalhH3vmWbztCkJ5Jk8oj05rrfk5cA/B6xZq5
         m0OHbVkAgVxhgFz5fNnG/jRNT4G1n3+TDFaxEEd/q6zu5KTKB555A9oTZ4Et8pdOE5T2
         kJ1SOLEyFexCQSOzdjIc5zQs7wTZGy/xMkYjIm+2pUIZW2kSyjnNp0Zy/ABDmOARL87m
         N5NEBKZvx0IJERhEHpztf2LlhWYOnXs4fXai4a84014UX0dub3565WvSi4tnsR/L5VuR
         8eWNzStOQgVtRvf6DvEhHjxYBd4yNieaFv45w5LBpWEa6aCb0zlqzaXylj1+RmaxjLq8
         Ddug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783554541; x=1784159341;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mg8HPDVADkikyFkQazKzK0at34W1Wn3VUkaO82xr5dA=;
        b=ACsDKnZMbecA25Nh3xjJjljLmMUrYlwwKs+jFoTAiy4eGO9tBoam/npQVg/PUs5vxL
         wkQUJijnh+YaM6l9Uve4TSpl7O3ajymV5Et+JH1YZRpeWx6tqwcgHhm3ajslp7egtkSe
         7IxDEaYoTYGosrdDQho565DyHFDYxaN2ap63GahlHmUcFiCG1NzlNba42en5xrKfX4Yt
         iajHJwyUGecXvImwooQ4+p3jqHKBk1wduzAyYxLPiZoNEj8xaFRjQkXoA5qr4xhupNc+
         k2F0iT9+qf2wQVv0a+7IHXTnXBRAnc04JgekvQa3GioAUPcvShMiEEE1haF3qNi7cMXi
         7KhQ==
X-Forwarded-Encrypted: i=1; AHgh+RoB+8jK2wxO/3r0wbEmwoFXIiP57ca98V02yZjx9gFLpxn3L5Tw3ol/yshpfxkz5qMx4UjJfg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwtET3yVEH96IyhliyoDeYQmXcleYvAzgjR2nq+sTVIQlsUId5q
	LqjaaAAsIqsns0PbbnGkbjNF3ghCveTRlsjZvcCVuLIMvcl0piKqPCds4VRuc3smzyunOPxj52Y
	WO9tHPZfj+V4LJA==
X-Received: from pfoc15.prod.google.com ([2002:aa7:880f:0:b0:847:ada8:bf86])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1826:b0:842:706e:ad43 with SMTP id d2e1a72fcca58-8484324665bmr4017531b3a.33.1783554541070;
 Wed, 08 Jul 2026 16:49:01 -0700 (PDT)
Date: Wed,  8 Jul 2026 23:48:51 +0000
In-Reply-To: <20260708234854.4044652-1-skhawaja@google.com>
Mime-Version: 1.0
References: <20260708234854.4044652-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260708234854.4044652-8-skhawaja@google.com>
Subject: [RFC PATCH v2 07/10] dma-mapping: Add support of preserving dmam allocations
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
X-CRM114-CacheID: sfid-20260708_164902_500270_5E42AE14 
X-CRM114-Status: GOOD (  16.75  )
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

Device drivers use dmam_* allocation APIs for managed lifecycle of DMA
allocations. Add support of preserving managed DMA allocations so these
can be preserved and on restore these are managed again.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 include/linux/dma-mapping.h | 50 ++++++++++++++++++++++
 kernel/dma/mapping.c        | 83 +++++++++++++++++++++++++++++++++++++
 2 files changed, 133 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 3756fc15467b..4c0c428b6b1c 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -218,6 +218,14 @@ void dma_unpreserve_allocation(struct device *dev, u64 state);
 void *dma_restore_allocation_attrs(struct device *dev, size_t size,
 				   dma_addr_t *dma_handle, gfp_t gfp,
 				   unsigned long attrs, u64 state);
+int dmam_preserve_allocation_attrs(struct device *dev, void *cpu_addr,
+				   size_t size, dma_addr_t dma_handle,
+				   unsigned long attrs, u64 *state);
+void dmam_unpreserve_allocation(struct device *dev, void *cpu_addr,
+				size_t size, dma_addr_t dma_handle, u64 state);
+void *dmam_restore_allocation_attrs(struct device *dev, size_t size,
+				    dma_addr_t *dma_handle, gfp_t gfp,
+				    unsigned long attrs, u64 state);
 #endif
 #else /* CONFIG_HAS_DMA */
 static inline dma_addr_t dma_map_page_attrs(struct device *dev,
@@ -523,6 +531,25 @@ static inline void *dma_restore_allocation_attrs(struct device *dev, size_t size
 {
 	return NULL;
 }
+
+static inline int dmam_preserve_allocation_attrs(struct device *dev, void *cpu_addr,
+						 size_t size, dma_addr_t dma_handle,
+						 unsigned long attrs, u64 *state)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void dmam_unpreserve_allocation(struct device *dev, void *cpu_addr,
+					      size_t size, dma_addr_t dma_handle, u64 state)
+{
+}
+
+static inline void *dmam_restore_allocation_attrs(struct device *dev, size_t size,
+						  dma_addr_t *dma_handle, gfp_t gfp,
+						  unsigned long attrs, u64 state)
+{
+	return NULL;
+}
 #endif
 
 struct page *dma_alloc_pages(struct device *dev, size_t size,
@@ -797,6 +824,29 @@ static inline void *dmam_alloc_coherent(struct device *dev, size_t size,
 			(gfp & __GFP_NOWARN) ? DMA_ATTR_NO_WARN : 0);
 }
 
+static inline int dmam_preserve_coherent_allocation(struct device *dev, void *cpu_addr,
+						    size_t size, dma_addr_t dma_handle, u64 *state)
+{
+	return dmam_preserve_allocation_attrs(dev, cpu_addr, size,
+					      dma_handle, 0, state);
+}
+
+static inline void dmam_unpreserve_coherent_allocation(struct device *dev, void *cpu_addr,
+						       size_t size, dma_addr_t dma_handle,
+						       u64 state)
+{
+	dmam_unpreserve_allocation(dev, cpu_addr, size, dma_handle, state);
+}
+
+static inline void *dmam_restore_coherent_allocation(struct device *dev, size_t size,
+						     dma_addr_t *dma_handle,
+						     gfp_t gfp, u64 state)
+{
+	return dmam_restore_allocation_attrs(dev, size, dma_handle, gfp,
+					     (gfp & __GFP_NOWARN) ? DMA_ATTR_NO_WARN : 0,
+					     state);
+}
+
 static inline void *dma_alloc_wc(struct device *dev, size_t size,
 				 dma_addr_t *dma_addr, gfp_t gfp)
 {
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 3b07bf30722c..aec1222ab5ae 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -37,12 +37,25 @@ struct dma_devres {
 	void		*vaddr;
 	dma_addr_t	dma_handle;
 	unsigned long	attrs;
+#ifdef CONFIG_DMA_LIVEUPDATE
+	bool is_preserved;
+#endif
 };
 
 static void dmam_release(struct device *dev, void *res)
 {
 	struct dma_devres *this = res;
 
+#ifdef CONFIG_DMA_LIVEUPDATE
+	/*
+	 * Freeing the preserved memory is dangerous as it can cause UAF in the
+	 * current or next kernel if the memory is still being used by the
+	 * device.
+	 */
+	if (WARN_ON(this->is_preserved))
+		return;
+#endif
+
 	dma_free_attrs(dev, this->size, this->vaddr, this->dma_handle,
 			this->attrs);
 }
@@ -675,6 +688,76 @@ void *dma_restore_allocation_attrs(struct device *dev, size_t size,
 	return cpu_addr;
 }
 EXPORT_SYMBOL(dma_restore_allocation_attrs);
+
+int dmam_preserve_allocation_attrs(struct device *dev, void *cpu_addr,
+				   size_t size, dma_addr_t dma_handle,
+				   unsigned long attrs, u64 *state)
+{
+	struct dma_devres match_data = { size, cpu_addr, dma_handle };
+	struct dma_devres *dr;
+	int ret;
+
+	dr = devres_find(dev, dmam_release, dmam_match, &match_data);
+	if (!dr)
+		return -EINVAL;
+
+	if (dr->is_preserved)
+		return -EINVAL;
+
+	ret = dma_preserve_allocation_attrs(dev, cpu_addr, size, dma_handle, attrs, state);
+	if (ret)
+		return ret;
+
+	dr->is_preserved = true;
+	return 0;
+}
+EXPORT_SYMBOL(dmam_preserve_allocation_attrs);
+
+void dmam_unpreserve_allocation(struct device *dev, void *cpu_addr,
+				size_t size, dma_addr_t dma_handle, u64 state)
+{
+	struct dma_devres match_data = { size, cpu_addr, dma_handle };
+	struct dma_devres *dr;
+
+	dr = devres_find(dev, dmam_release, dmam_match, &match_data);
+	if (!dr)
+		return;
+
+	if (!dr->is_preserved)
+		return;
+
+	dma_unpreserve_allocation(dev, state);
+	dr->is_preserved = false;
+}
+EXPORT_SYMBOL(dmam_unpreserve_allocation);
+
+void *dmam_restore_allocation_attrs(struct device *dev, size_t size,
+				    dma_addr_t *dma_handle, gfp_t gfp,
+				    unsigned long attrs, u64 state)
+{
+	struct dma_devres *dr;
+	void *vaddr;
+
+	dr = devres_alloc(dmam_release, sizeof(*dr), gfp);
+	if (!dr)
+		return NULL;
+
+	vaddr = dma_restore_allocation_attrs(dev, size, dma_handle, gfp, attrs, state);
+	if (!vaddr) {
+		devres_free(dr);
+		return NULL;
+	}
+
+	dr->vaddr = vaddr;
+	dr->dma_handle = *dma_handle;
+	dr->size = size;
+	dr->attrs = attrs;
+
+	devres_add(dev, dr);
+
+	return vaddr;
+}
+EXPORT_SYMBOL(dmam_restore_allocation_attrs);
 #endif
 
 void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
-- 
2.55.0.795.g602f6c329a-goog


