Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F17C44507
	for <kexec@archiver.kernel.org>; Wed,  8 Jul 2026 23:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lkcC1WuBJfDnOUDpo4VCYaNuz/sum/AUORjsX5C4m/M=; b=QLbHmI+j0NM++qmb02mTl4hpyV
	6yBYHEMz8MIF2xFfCvjLe9ab5lIV1Nf68fHeayajZZiULcwAfCchB85TcaOcN+B0Dmpr1kdH/Bakm
	YVN1brFpiWW+TAsKCcCvye25/dXfOvpoq4HHbtj623j9EX7Ca7JrJWWFtU7WNd01S88akJ03lErMx
	3kYdoLPr3KbFiHfxck7COEA6yylKxR+jbkyYavfT8UzAUS0irINL/1wkMgd2vUPrANX9Vlt9qBI2n
	jFfkIbwnrbemSfEEGvz4d5tiMCxSEPy1QD7pWhcROA9mgRWtmnyRQqLimASz342ocrGO6Ro4nU+2x
	Zqhpjmmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whc0j-00000000cy3-1IQN;
	Wed, 08 Jul 2026 23:49:01 +0000
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whc0g-00000000cwI-39Hm
	for kexec@lists.infradead.org;
	Wed, 08 Jul 2026 23:49:00 +0000
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-847ad67cc51so1461019b3a.3
        for <kexec@lists.infradead.org>; Wed, 08 Jul 2026 16:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783554538; x=1784159338; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lkcC1WuBJfDnOUDpo4VCYaNuz/sum/AUORjsX5C4m/M=;
        b=HyfFwoybJg5A6cvLiyuu5OWwwKO5hEX02ukZOlkJdSm2a2rfmjwyY/Orobt9Y+ESvk
         LuqZKMC/kuDuiC7d1EL6Uui61bH+wJje/eQ/UElUNcC6QRL8eiKjHD8gjKFWJFt1besg
         7t8iVpxmjR1JPqQqzJXXXF+lPoae3Cs7L3jIR3xiohQSxi7Z/IjJs79efSeKlFT99/FT
         idQD/Y6OezJGlH8pQfrRZgfT0Mn6PbeTapJcqZFPyXjc4eX05M/wyEUGo4v7D1oc8QE+
         LiUQon+irdq7PT9qtnrsVXFct9DNf/EhMEA34WOap+fsATT9+2IC16nWKC3raQe3WD6M
         DjZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783554538; x=1784159338;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lkcC1WuBJfDnOUDpo4VCYaNuz/sum/AUORjsX5C4m/M=;
        b=byfUc78B8Qq+Daa3+sIQ0P/t1ZzGFoAshBuQ8TJOEGJgP0TEspVevsSF1AUu1exQEn
         OxMDSs6IDT9gshfjfH7OfIPC2XKNQNQ7o12CYNw7F1nTi/brVYifahv6tcaJ4/YAPsHs
         RbEs9KxHlvDORKYQ1Pt0iAaW7pdqTFCkCnYJLZO8hKvbYgmtePJKaEeVUkAfWbPm7Cob
         3C03NC8JJn5zOLZS2SAmYYzcQd7b98prBADm+oNjjQ04nX9v+FN8gzKLMIi4sz0pnXXk
         UaIRqCHcOspZSAZ+MQNKUqFSR9NTawEL8O73lTigkAZUBrYWNN0VOYFFuHnnDbpw58Ts
         L4sQ==
X-Forwarded-Encrypted: i=1; AHgh+RqDkNQl4xYHZPgi+oiMn6kbAGihUbkyb4M9H8fwsxVSy59g6F6xrM5BbNzRgdFJVe/kNxpZEg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyR4ZVD/pUbAIBjTLJH9Q4gc5hSMzsgPtnjdmy1613HwUgt+yDr
	NHZtzBauxbj4dj8wxX0J0SGIm3f+zARSY7RNZjt5GTViVXlVReGr+AcVODAhWRgWhSIY3VPIQQd
	TUWnhspVCp7poww==
X-Received: from pgbe38.prod.google.com ([2002:a63:5026:0:b0:c99:aff5:7092])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:e082:b0:3c0:9c19:659f with SMTP id adf61e73a8af0-3c0bd23427fmr5506792637.71.1783554537333;
 Wed, 08 Jul 2026 16:48:57 -0700 (PDT)
Date: Wed,  8 Jul 2026 23:48:47 +0000
In-Reply-To: <20260708234854.4044652-1-skhawaja@google.com>
Mime-Version: 1.0
References: <20260708234854.4044652-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260708234854.4044652-4-skhawaja@google.com>
Subject: [RFC PATCH v2 03/10] dma: contiguous: Add API to check if an
 allocation is from CMA
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
X-CRM114-CacheID: sfid-20260708_164858_791642_859FA538 
X-CRM114-Status: GOOD (  12.20  )
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

Add an API that uses cma_for_each() to check whether a DMA allocation is
from a CMA region.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 include/linux/dma-map-ops.h |  6 ++++++
 kernel/dma/contiguous.c     | 24 ++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 9382785a2faa..9b91c839ceb5 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -106,6 +106,7 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp);
 void dma_free_contiguous(struct device *dev, struct page *page, size_t size);
 
 void dma_contiguous_early_fixup(phys_addr_t base, unsigned long size);
+bool dma_is_from_cma(phys_addr_t phys, size_t size);
 #else /* CONFIG_DMA_CMA */
 static inline struct cma *dev_get_cma_area(struct device *dev)
 {
@@ -145,6 +146,11 @@ static inline void dma_free_contiguous(struct device *dev, struct page *page,
 {
 	__free_pages(page, get_order(size));
 }
+
+static inline bool dma_is_from_cma(phys_addr_t phys, size_t size)
+{
+	return false;
+}
 #endif /* CONFIG_DMA_CMA*/
 
 #ifdef CONFIG_DMA_DECLARE_COHERENT
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 03f52bd17120..0b1702bf39ca 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -130,6 +130,30 @@ struct cma *dev_get_cma_area(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_get_cma_area);
 
+struct dma_cma_check_data {
+	phys_addr_t start;
+	phys_addr_t end;
+};
+
+static int dma_cma_check_area(struct cma *cma, void *data)
+{
+	struct dma_cma_check_data *chk = data;
+
+	if (cma_intersects(cma, chk->start, chk->end))
+		return 1;
+	return 0;
+}
+
+bool dma_is_from_cma(phys_addr_t phys, size_t size)
+{
+	struct dma_cma_check_data chk = {
+		.start = phys,
+		.end = phys + size - 1,
+	};
+
+	return cma_for_each_area(dma_cma_check_area, &chk) != 0;
+}
+
 #ifdef CONFIG_DMA_NUMA_CMA
 
 static struct cma *dma_contiguous_numa_area[MAX_NUMNODES];
-- 
2.55.0.795.g602f6c329a-goog


