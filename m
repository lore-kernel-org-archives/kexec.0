Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3714CD342C
	for <kexec@archiver.kernel.org>; Tue,  5 May 2026 00:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M2hjkJ1In2ag1iLE+KuZ3epwvTGInKsCURDrkdhtZDM=; b=ZbTTusc0RQfGmZuixHa3GqlEis
	jGvVY/8/rI3+G5uEOVa0GfdjcmqvpdS1Yo5sQDpWwSSiBetE0YWLyRf8XXBLVWVuTdsqbBMs7UYm2
	iV2N0WKAjf9U7lyFiYs13+/5rQv6VfROu0bFm2fHA6REYKXSufoT3YOiZxgFKTYNDOwT+Nl5vCTRP
	BRHePf7982sKYDlmKiPhgChYzGKxSSUT7HQJXuICvxDdz3qmmAR8gEu/dOVcOG3KlI9ntajIhclFS
	gAJ72NhN8b1RJQeQa8/5bt6mUJRZDe0cdVA28cklz6ustJBn5qG7Pb11Gl0MIEfzxf9Hpac/vNtSw
	UPQMVoww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wK3db-0000000EiUV-1tcp;
	Tue, 05 May 2026 00:27:47 +0000
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wK3dZ-0000000EiS7-0zyT
	for kexec@lists.infradead.org;
	Tue, 05 May 2026 00:27:46 +0000
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-c7977177675so1889236a12.0
        for <kexec@lists.infradead.org>; Mon, 04 May 2026 17:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777940864; x=1778545664; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M2hjkJ1In2ag1iLE+KuZ3epwvTGInKsCURDrkdhtZDM=;
        b=hvwT4YiBC2j7mBFKMJdBFoYBGjPwTz5EyIMY/aLssxZhxA3EWq74h2tph2u/D8p76r
         exjY7N2VduIMhvAhG6WvEpb7wpGumDfktcZ1cmyOfJCRuj58eJKGe1SML4mbNxP8UcHV
         QILHpi0xkDIIhDhpnhpvShlslbQ9efeg2eUOsBjb5JlbDCPWljj4beVsXb3x8MRjH7Qn
         3Nel0vs69Obyyi++lUsAplUddH3Kggme2yxnEP2cDoYsJf5AdQOKgzLiuitWdQdI/uwi
         vUrepIVagKvdNZCkl04KSDohYgO73bfp78mOj5Ff/5Lf8CV/zMcVGR5RF03ArgAYivND
         rqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777940864; x=1778545664;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M2hjkJ1In2ag1iLE+KuZ3epwvTGInKsCURDrkdhtZDM=;
        b=G4EBr5lLFoga9vE/iT3Kii0GZG3gIqT0zniK1goRDj+anOhmaUJjaWFfkiUsOmWNQE
         DrEBdyHRFd9gMNTEPBtRsaO9cdje3PsjsJ2YzbezCzOKr5LP9m2T4vO1sa1mrzPRGGEn
         u29b2y1RVBIFJT24znqboRrJjOLEUQkNwG1DEL8TkLwPWZI9VC0tTbHArkgAHDdz0L/H
         2oLJQZ+xTioGKM76wPh41umPFmqzHdMQaiIpn2M8wpHZtWOmbI7ZZIRcd04Qjmc2A5yp
         104msUm1Z8KNWuBfB7OsLFoCY+3r/7OvkjvSfiYRSDpad7HYpU5784NYpoQ4HWkGWaCt
         vMZw==
X-Forwarded-Encrypted: i=1; AFNElJ+fHaDVGUduDbBNK/BLpe/4BTzYoN6V2mROWnM6wqnUQRY/QizII8l+T2kXUAee+gHsGFhlrQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzeXzGvdCbWNHxr860B0GhUy9X/+ubRwIK4fMkqCwRr46pxfQtj
	0bKagm6ezhcIgf1BHt92MAXRbOBEfagySVLr7BUyBrZiRUTsmKFJKwp59qaAoNLJu+A0J0KYCih
	Z4tOLHBuVaVQabQ==
X-Received: from pfde22.prod.google.com ([2002:aa7:8c56:0:b0:82f:4abd:a354])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4fcd:b0:838:af72:fb35 with SMTP id d2e1a72fcca58-83921ef6ff6mr943516b3a.10.1777940863669;
 Mon, 04 May 2026 17:27:43 -0700 (PDT)
Date: Tue,  5 May 2026 00:27:36 +0000
In-Reply-To: <20260505002737.2213734-1-skhawaja@google.com>
Mime-Version: 1.0
References: <20260505002737.2213734-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260505002737.2213734-4-skhawaja@google.com>
Subject: [RFC PATCH 3/4] dma-direct: Add API to preserve/restore allocations
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
X-CRM114-CacheID: sfid-20260504_172745_294408_5EE216F4 
X-CRM114-Status: GOOD (  21.39  )
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

Add an API to preserve/restore the DMA direct allocation for liveupdate.
The underlying memory is preserved/restored using KHO. During restore
the memory is setup based on the device configuration, gfp flags and
allocation attributes. Once restored, the driver can use the usual
dma_free* API to deallocate the restored DMA allocation.

This API will be used to add support in dma_alloc* APIs to
preseve/restore the DMA allocations.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 include/linux/dma-direct.h |  29 +++++++
 kernel/dma/Kconfig         |   3 +
 kernel/dma/direct.c        | 163 +++++++++++++++++++++++++++++++++++++
 3 files changed, 195 insertions(+)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index c249912456f9..0efe2bc1a815 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -141,6 +141,35 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size,
 u64 dma_direct_get_required_mask(struct device *dev);
 void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t gfp, unsigned long attrs);
+
+#ifdef CONFIG_DMA_LIVEUPDATE
+int dma_direct_preserve_allocation(struct device *dev, void *cpu_addr,
+				   size_t size, dma_addr_t dma_handle,
+				   unsigned long attrs, u64 *state);
+void dma_direct_unpreserve_allocation(struct device *dev, u64 state);
+void *dma_direct_restore_allocation(struct device *dev, size_t size,
+				    dma_addr_t *dma_handle, gfp_t gfp,
+				    unsigned long attrs, u64 state);
+#else
+static inline int dma_direct_preserve_allocation(struct device *dev, void *cpu_addr,
+						 size_t size, dma_addr_t dma_handle,
+						 unsigned long attrs, u64 *state)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void dma_direct_unpreserve_allocation(struct device *dev, u64 state)
+{
+}
+
+static inline void *dma_direct_restore_allocation(struct device *dev, size_t size,
+						  dma_addr_t *dma_handle, gfp_t gfp,
+						  unsigned long attrs, u64 state)
+{
+	return NULL;
+}
+#endif
+
 void dma_direct_free(struct device *dev, size_t size, void *cpu_addr,
 		dma_addr_t dma_addr, unsigned long attrs);
 struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index bfef21b4a9ae..d92852942c6c 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -265,3 +265,6 @@ config DMA_MAP_BENCHMARK
 	  performance of dma_(un)map_page.
 
 	  See tools/testing/selftests/dma/dma_map_benchmark.c
+
+config DMA_LIVEUPDATE
+	bool "Enable preservation of DMA direct allocations"
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index ec887f443741..c2b98f91900a 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -6,6 +6,8 @@
  */
 #include <linux/memblock.h> /* for max_pfn */
 #include <linux/export.h>
+#include <linux/kexec_handover.h>
+#include <linux/kho/abi/dma_alloc.h>
 #include <linux/mm.h>
 #include <linux/dma-map-ops.h>
 #include <linux/scatterlist.h>
@@ -307,6 +309,167 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	return NULL;
 }
 
+#ifdef CONFIG_DMA_LIVEUPDATE
+int dma_direct_preserve_allocation(struct device *dev, void *cpu_addr,
+				   size_t size, dma_addr_t dma_handle,
+				   unsigned long attrs, u64 *state)
+{
+	struct dma_alloc_ser *ser;
+	int ret;
+
+	if (!kho_is_enabled())
+		return -EOPNOTSUPP;
+
+	if (IS_ENABLED(CONFIG_DMA_CMA))
+		return -EOPNOTSUPP;
+
+	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
+	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev))
+		return -EOPNOTSUPP;
+
+	if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_ALLOC) &&
+	    !dev_is_dma_coherent(dev) &&
+	    !is_swiotlb_for_alloc(dev))
+		return -EOPNOTSUPP;
+
+	if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
+	    !dev_is_dma_coherent(dev))
+		return -EOPNOTSUPP;
+
+	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
+	    dma_is_from_pool(dev, cpu_addr, PAGE_ALIGN(size)))
+		return -EOPNOTSUPP;
+
+	ser = kho_alloc_preserve(sizeof(*ser));
+	if (IS_ERR(ser))
+		return PTR_ERR(ser);
+
+	ser->page_phys = dma_to_phys(dev, dma_handle);
+	ser->force_decrypted = force_dma_unencrypted(dev);
+	ser->size = size;
+
+	ret = kho_preserve_pages(phys_to_page(ser->page_phys),
+				 size >> PAGE_SHIFT);
+	if (ret) {
+		kho_unpreserve_free(ser);
+		return ret;
+	}
+
+	*state = virt_to_phys(ser);
+	return 0;
+}
+
+void dma_direct_unpreserve_allocation(struct device *dev, u64 state)
+{
+	struct dma_alloc_ser *ser;
+
+	if (!kho_is_enabled())
+		return;
+
+	ser = phys_to_virt(state);
+	kho_unpreserve_pages(phys_to_page(ser->page_phys),
+			     ser->size >> PAGE_SHIFT);
+	kho_unpreserve_free(ser);
+}
+
+void *dma_direct_restore_allocation(struct device *dev, size_t size,
+				    dma_addr_t *dma_handle, gfp_t gfp,
+				    unsigned long attrs, u64 state)
+{
+	bool remap = false, set_uncached = false;
+	struct dma_alloc_ser *ser = NULL;
+	struct page *page;
+	void *cpu_addr;
+
+	if (!kho_is_enabled())
+		return NULL;
+
+	ser = phys_to_virt(state);
+	page = phys_to_page(ser->page_phys);
+
+	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
+	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev))
+		return NULL;
+
+	if (!dev_is_dma_coherent(dev)) {
+		if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_ALLOC) &&
+		    !is_swiotlb_for_alloc(dev))
+			return NULL;
+
+		if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL))
+			return NULL;
+
+		set_uncached = IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED);
+		remap = IS_ENABLED(CONFIG_DMA_DIRECT_REMAP);
+		if (!set_uncached && !remap)
+			return NULL;
+	}
+
+	if (PageHighMem(page)) {
+		remap = true;
+		set_uncached = false;
+	}
+
+	/*
+	 * Remapping will be blocking so return error. The preserved memory
+	 * might be already decrypted in the previous kernel, but the decryption
+	 * call is not guaranteed to be non-blocking so return error always if
+	 * decryption is required.
+	 */
+	if ((remap || force_dma_unencrypted(dev)) &&
+	    dma_direct_use_pool(dev, gfp))
+		return NULL;
+
+	/*
+	 * Encryption scheme changed between two kernels and this might cause
+	 * issues if device/driver is not handling it properly.
+	 */
+	WARN_ON_ONCE(ser->force_decrypted != force_dma_unencrypted(dev));
+
+	/*
+	 * arch_dma_prep_coherent() should make sure that any cache lines from
+	 * the previous kernel, if the device was coherent previously or cached
+	 * mapping in this kernel during init are not problamatic for
+	 * non-coherent allocations.
+	 */
+	if (remap) {
+		pgprot_t prot = dma_pgprot(dev, PAGE_KERNEL, attrs);
+
+		if (force_dma_unencrypted(dev))
+			prot = pgprot_decrypted(prot);
+
+		arch_dma_prep_coherent(page, size);
+
+		cpu_addr = dma_common_contiguous_remap(page, size, prot,
+						       __builtin_return_address(0));
+		if (!cpu_addr)
+			return NULL;
+	} else {
+		cpu_addr = page_address(page);
+		if (dma_set_decrypted(dev, cpu_addr, size))
+			return NULL;
+	}
+
+	if (set_uncached) {
+		arch_dma_prep_coherent(page, size);
+		cpu_addr = arch_dma_set_uncached(cpu_addr, size);
+		if (IS_ERR(cpu_addr))
+			return NULL;
+	}
+
+	*dma_handle = phys_to_dma_direct(dev, ser->page_phys);
+
+	/*
+	 * Cannot free the restored pages on error here as these might be in use
+	 * by a device with direct allocation in the previous kernel.
+	 */
+	WARN_ON(!kho_restore_pages(ser->page_phys,
+				   ser->size >> PAGE_SHIFT));
+	kho_restore_free(ser);
+	return cpu_addr;
+}
+#endif
+
 void dma_direct_free(struct device *dev, size_t size,
 		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
 {
-- 
2.54.0.545.g6539524ca2-goog


