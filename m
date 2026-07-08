Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C70C44506
	for <kexec@archiver.kernel.org>; Wed,  8 Jul 2026 23:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RZBzRoXH7VF0ByV3qQDpFWW6MWj2hI4S3QQKMPJnM4U=; b=jfgBsU+QvVDqMb9TBHIGG85nGr
	zpdGqPqfu6kOqWKhir8Mq8UJJ6M2PFxtGASluhqsPU15Hmk5Z6SisffMJWC7JwObF1g7dyvBrDY4u
	mAY66R3hUKub3IQgMti2nV4vQkupt1/P8BI8RVH7Wt2wa5HBIUxAXJ7TercZzrAUgCX/TAGxEVlnx
	DDPNJYOEXeIryJfjaVZencj6ySEH4HXlcfSimc/i4NuDCnRMHlkzv4fnu7yAQILzFRpan7i7B9J49
	jHybOz1irToiXmTu87/GTLLnXCYVyryl52aVNLxldlMFJQNC/UkrFLR3lVo+D55KkOXyDW4lxECW5
	VeDmQ6wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whc0k-00000000czI-297L;
	Wed, 08 Jul 2026 23:49:02 +0000
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whc0h-00000000cwx-3ncV
	for kexec@lists.infradead.org;
	Wed, 08 Jul 2026 23:49:01 +0000
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-848544a8496so490080b3a.0
        for <kexec@lists.infradead.org>; Wed, 08 Jul 2026 16:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783554538; x=1784159338; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RZBzRoXH7VF0ByV3qQDpFWW6MWj2hI4S3QQKMPJnM4U=;
        b=ZyIp7s01jvqi7ZPAs+ii9GL4Tjk+CPl0TKZAj06Ii/sH+q3QqTmNsAkkfRKfg9DwPE
         r3wdo4FuVPRK2XsNcC4FEZf0rEOAxa3cG5d7/DGUi6QKqBE3VpaqAw6LY9qKRmqTwv7w
         lm71TYYcgdYWhInHR1brfA4sFFhiexRbn50ohoX+gSQUxCXzwBW6LEYdwabpA8tkKoOI
         GBmdEGXNFDNVcGU/JH67YZEG7yuJxSL8WIv+2gx5+LcaRk3tyj4ZGazSq07g/rpAlpNP
         V0tVIzMIcbX73dXY0lRPIpY2+P+lMXSAPYP4eriatbtkiO5QFdw1JdBAMTh/G5wCSP6W
         oI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783554538; x=1784159338;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RZBzRoXH7VF0ByV3qQDpFWW6MWj2hI4S3QQKMPJnM4U=;
        b=XnLseB9w1TleIgxxx/I+SiATAZVVaHqzbll6kDPShcB8RN4BPyIjb3g5QbjM6k+2s2
         fx/YMDfYaBwcibdZYbmmB4abGZQHeljagsOg1luZPXe8HNKrTewLr4Z9tp7HB46cKkcM
         Wdhh7lvCisHB7RWsa98wAdcGmEC3Nxahzdo2D0N597lq8PAbuo5RA5dM5kTTXGkFMARG
         6yjDGO1lPUQFYp6Swas4kJJkUF9tn/C/+gp3qfAPF8Bqbb8v7kWz+ZA2LFrEIpQU1WcZ
         ZU2wan+7ghZRNWFf+wtQc7u3zK24yh3D9yvgcmX1LNb7S0jaibpZZCpRwQkp966sD2Tv
         9hyw==
X-Forwarded-Encrypted: i=1; AHgh+RplYmbMMKg2PUx8vEzTDvin9qIx6WliEfwMpUoCwMAmInQMIuLFyEhVsI+HYLn3fGVjSpOOFQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwLMtMqC8Dr4cUCLWKdcdCPGDZjTTRkD8uH4yaP/W7Px3jylHek
	0OdePo+9LboY/BAwIgR2ne0IU1j6sBlG6ksviDSijCfduUvLiMN66kNU+PgrSJEjFkRmFg0oeOS
	sKiD8fitgju6ccA==
X-Received: from pfbhh2.prod.google.com ([2002:a05:6a00:8682:b0:845:4da8:56a5])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:805:b0:848:3f83:de9b with SMTP id d2e1a72fcca58-84842fe47bcmr4585485b3a.9.1783554538155;
 Wed, 08 Jul 2026 16:48:58 -0700 (PDT)
Date: Wed,  8 Jul 2026 23:48:48 +0000
In-Reply-To: <20260708234854.4044652-1-skhawaja@google.com>
Mime-Version: 1.0
References: <20260708234854.4044652-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260708234854.4044652-5-skhawaja@google.com>
Subject: [RFC PATCH v2 04/10] dma-coherent: Allow checking if allocation is
 from dev coherent region
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
X-CRM114-CacheID: sfid-20260708_164859_956829_485A30FA 
X-CRM114-Status: GOOD (  10.71  )
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

Add an API that allows if a DMA allocation is from device coherent
region.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 include/linux/dma-map-ops.h |  3 +++
 kernel/dma/coherent.c       | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 9b91c839ceb5..b13e5eebe6d3 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -162,6 +162,7 @@ int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
 int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr);
 int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_struct *vma,
 		void *cpu_addr, size_t size, int *ret);
+bool dma_is_from_dev_coherent(struct device *dev, void *vaddr);
 #else
 static inline int dma_declare_coherent_memory(struct device *dev,
 		phys_addr_t phys_addr, dma_addr_t device_addr, size_t size)
@@ -172,6 +173,8 @@ static inline int dma_declare_coherent_memory(struct device *dev,
 #define dma_alloc_from_dev_coherent(dev, size, handle, ret) (0)
 #define dma_release_from_dev_coherent(dev, order, vaddr) (0)
 #define dma_mmap_from_dev_coherent(dev, vma, vaddr, order, ret) (0)
+#define dma_is_from_dev_coherent(dev, vaddr) (false)
+
 static inline void dma_release_coherent_memory(struct device *dev) { }
 #endif /* CONFIG_DMA_DECLARE_COHERENT */
 
diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index bcdc0f76d2e8..76cbe11e1f90 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -231,6 +231,17 @@ int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr)
 	return __dma_release_from_coherent(mem, order, vaddr);
 }
 
+bool dma_is_from_dev_coherent(struct device *dev, void *vaddr)
+{
+	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
+
+	if (mem && vaddr >= mem->virt_base && vaddr <
+		   (mem->virt_base + ((dma_addr_t)mem->size << PAGE_SHIFT)))
+		return true;
+
+	return false;
+}
+
 static int __dma_mmap_from_coherent(struct dma_coherent_mem *mem,
 		struct vm_area_struct *vma, void *vaddr, size_t size, int *ret)
 {
-- 
2.55.0.795.g602f6c329a-goog


