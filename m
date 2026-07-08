Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F4EC44508
	for <kexec@archiver.kernel.org>; Wed,  8 Jul 2026 23:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aFhl1KlUjTv27006fhIt6b3pOPGmn7+PIUCxNMQiXPw=; b=0zudlthxAqJ0tI7jKj6H6o1gq4
	5y99eoKETQmdHMeO+uiOFlm0tNh3A6wrCptpDVhDUTLchy5DF1kDf5nV2wsNhSWR9DokL5P6tLjGH
	P8R3bRil6OPjcQqJdt1Su5hTUxIrwsvaaAswUE4fu0H4sdIrCI/60GceGePm9vRL4PTnZdgl71UOl
	95PtJbKYUAK/E/GHyGf311G9yKEqq0vIccfjgFySLkLa7/dQ+qHX5iyNnK78IMis1W++n1ezV7duc
	V607+7KIdhYPXNfAPDQu6/4O0+NTg4BPmzTf5+f8idW0xVhmeMSMwIhd4GJ/UQjE382qFhedyn41Z
	+NJWcSQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whc0j-00000000cxw-0ofi;
	Wed, 08 Jul 2026 23:49:01 +0000
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whc0g-00000000cw2-2odk
	for kexec@lists.infradead.org;
	Wed, 08 Jul 2026 23:48:59 +0000
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-8482df30da4so523676b3a.2
        for <kexec@lists.infradead.org>; Wed, 08 Jul 2026 16:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783554537; x=1784159337; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aFhl1KlUjTv27006fhIt6b3pOPGmn7+PIUCxNMQiXPw=;
        b=Keyg5W9GfuANw8MnJfnLdaXvvqEcrdqnzDyMM/4sdNVcgUckwAj1IzX7gwaSxwCrJz
         Za2MxlRPAjLEV6xydI0B6AN1CHRDBZIDzP/S+W8g4wJ1r26qOrrayv5bfVeVMYam+Pp4
         AmnQ0k2vBCBi2FD1yPujOc2nZZMa3i11sUCAxnNxjTtivcKzGN4mhu9aIq1ZjNNFzZKf
         bfSdskcWP9dV4Yf8ywQR6W6wu3pTIji9Kb24jp4KTqwPVHVHfPODl/aM3QeqEa5RP8wP
         hWjh2sCwTQijdsp0LHdqw55lefUTnzRtRHSYccWri9mAwtVWRswNvfYPWngovXtQYGz6
         yaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783554537; x=1784159337;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aFhl1KlUjTv27006fhIt6b3pOPGmn7+PIUCxNMQiXPw=;
        b=gbb5C+lthKmPRfslhlSYUCYnT7zDZN0ZGrcjOjK8cb0zRIiVG8/+zYmC2zooLzZBNK
         r1P1qQr2q7Hbd1sBpyJDHoek/f6qr7ip/mNNJS9apF+AazjAqwd2HJYYph3gKKnim8ww
         hzHERidyicLmhw6bacozDc/259w6KFmXmNOU8KB69zGD8xikoOIi00yHmGl28pNr1FzF
         oFunvi/8LmGsax9del7jn585sjZl0FORX8Q/wKhkQiev5U9vAEuIV3Y5eqT4HcTFStdx
         /8I/X395GFuFxjeTds8JpMNye66Wdh+Y4ggXqr/rJtyw9W716xsgkNjedqk4Qp7LKY4f
         /+Jw==
X-Forwarded-Encrypted: i=1; AHgh+Rq9mDicQA3h5Q+zyU1CGWXWbJKv0iZfntAYM1DiYyWaZfNrOW9r+SaFI/nWDjXbbbnrpfmfjA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yya2wrncz8xCjLeiD+ydvAknD076yXuCwcLb2a8xe33A7WMi58v
	Z+mvpJTI/h0CXIy1L69CYTUv0obPRhovcVS9XlP7CeFElr6gQ6C5QFHRCF/1MN9ypPvppvz349D
	J3YkZcI8oP7uc1w==
X-Received: from pfcp8.prod.google.com ([2002:a05:6a00:a248:b0:848:4e44:7f19])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3e12:b0:848:411f:3969 with SMTP id d2e1a72fcca58-84842ee66f7mr4071344b3a.20.1783554536532;
 Wed, 08 Jul 2026 16:48:56 -0700 (PDT)
Date: Wed,  8 Jul 2026 23:48:46 +0000
In-Reply-To: <20260708234854.4044652-1-skhawaja@google.com>
Mime-Version: 1.0
References: <20260708234854.4044652-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260708234854.4044652-3-skhawaja@google.com>
Subject: [RFC PATCH v2 02/10] dma/pool: Add an API to check if DMA allocation
 is from pool
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
X-CRM114-CacheID: sfid-20260708_164858_767484_79273914 
X-CRM114-Status: GOOD (  11.76  )
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

DMA allocations can be done through DMA pools, add an API that can be
used to check if an allocation is done from a pool. This will be used in
the later commit during preservation of DMA allocation.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 include/linux/dma-map-ops.h |  1 +
 kernel/dma/pool.c           | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 6a1832a73cad..9382785a2faa 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -216,6 +216,7 @@ struct page *dma_alloc_from_pool(struct device *dev, size_t size,
 		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t));
 bool dma_free_from_pool(struct device *dev, void *start, size_t size);
 
+bool dma_is_from_pool(void *start, size_t size);
 int dma_direct_set_offset(struct device *dev, phys_addr_t cpu_start,
 		dma_addr_t dma_start, u64 size);
 
diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 2b2fbb709242..d1a0bb03e478 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -307,3 +307,16 @@ bool dma_free_from_pool(struct device *dev, void *start, size_t size)
 
 	return false;
 }
+
+bool dma_is_from_pool(void *start, size_t size)
+{
+	struct gen_pool *pool = NULL;
+
+	while ((pool = dma_guess_pool(pool, 0))) {
+		if (!gen_pool_has_addr(pool, (unsigned long)start, size))
+			continue;
+		return true;
+	}
+
+	return false;
+}
-- 
2.55.0.795.g602f6c329a-goog


