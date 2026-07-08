Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12080C44509
	for <kexec@archiver.kernel.org>; Wed,  8 Jul 2026 23:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S36ZhlE0su/Uhwn2a42SI+N6oTSNT9EqACGdaCh7Irk=; b=eVgd9+DJk36P473EBMCWCAjEib
	sTv4xs+Bwd7NwAf0bceNAUxfv9sZLBWPXqV5hhBZ8Mc3mrCUQaIh3/7X+yKHIiHSeLBeRajK2IltQ
	6QcfSbJ0RSqpQPrsbZIwNAk0ezYK9/VqSZpPVq0fTJWfbkv7z/2pnp4+agsv0JgRfoexEqK/8PbGl
	LVsqXkaxcoQ/3jAckqNg8bFZbYZ8M+CkoBnK/7WdF4hakuvoE2542RSCTnG/5IgPdd/rzySpE5Lc5
	PY/44kATpeVbeSg5WJ6/3W7is1sXYkQ3W4xP3gfgMNfArEQfg+ED148tbl67Xuo+tsiKETiS89lNA
	W4DbmNNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whc0p-00000000d5n-096h;
	Wed, 08 Jul 2026 23:49:07 +0000
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whc0l-00000000czm-17Oa
	for kexec@lists.infradead.org;
	Wed, 08 Jul 2026 23:49:04 +0000
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-2c804e38c65so28117605ad.2
        for <kexec@lists.infradead.org>; Wed, 08 Jul 2026 16:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783554542; x=1784159342; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S36ZhlE0su/Uhwn2a42SI+N6oTSNT9EqACGdaCh7Irk=;
        b=bY1JpYXFchfAsd2+Bas+Aw0XZnus5iCiY3K/Z0T3lgg0CRe4imWXrRtCJrMdnG/Po1
         gdiSkA0eHlrann6d5bz+2FIqVbtABtcNqH0t/2unfUYr6WYRknAXcGCFVGi1yGVLsY8t
         WUJ6hY+p6A6WLQN8mYgZz+6U6tFj7e9YRqCin7YbbbgyKDWK6Z6FveASA16PWOCFunRd
         HoKHv9OW1fbwUxqQaoOMrvNBzA2pgV9Wz7UiRFQIjTszLLg498xPBf+vivHKiTiWrmjI
         BiJuBDIu0x9EWH1hVofv5iwYZMfp9esH1IvyA8WD8v5iR7VqimYL3VXyrzhUFE333WbF
         tQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783554542; x=1784159342;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S36ZhlE0su/Uhwn2a42SI+N6oTSNT9EqACGdaCh7Irk=;
        b=aBX2iAIFC4K4F36MerYGoky/jM81gGV4tp182ZYgKKfM4NISBAVDPfNFfaR5RiY1V3
         Om/YLEhA3b5kbOQYT3Am9/N/m7cu1D9KL63jZ1sGCvtTiB2GuKA+zzVXhhLv2rGS/tfL
         wTfwS1HZiwPSx5QJlZgl59n5wNhaAvFmEo94EXXU3iUkcWjhp2uur+CTVYY7HztWn65x
         INCHFndejKoV7Lp6bjlE2LRnKaCkPAOIXW4pjYtz+GSExf7Y3EP+GUuM0fRu4jwtmqOL
         vWF+3XCyk+T5bLLPKc+j5fRZBtArrSOJW1bjx8Mquekdp3ZVQg66V9UFDlhjRBfiALDP
         N50Q==
X-Forwarded-Encrypted: i=1; AHgh+Rr+lGHpe+sK/4aWDmZzuL6lfBhRJhj2MQ6my8Zlt1+veghe1gRmeEGCISQ1hnpqL4K1Q9qhOg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyimZm1hCBas2QjNq9d9p/ZsuBzZxoarulDlsxSikm9M3Y4nlJP
	0T8uvQQsVIbP9AYJ37iHlEfAQAJspeu7jMIEBlcBv7moBJi/ErocyEtEqJN6JyGWf9656AADt/9
	9meReoS7Z6KFk0A==
X-Received: from pgcn4.prod.google.com ([2002:a63:7204:0:b0:c99:3b68:c9c6])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:4d8e:b0:3c0:b766:74f4 with SMTP id adf61e73a8af0-3c0bca47d59mr5364528637.31.1783554541947;
 Wed, 08 Jul 2026 16:49:01 -0700 (PDT)
Date: Wed,  8 Jul 2026 23:48:52 +0000
In-Reply-To: <20260708234854.4044652-1-skhawaja@google.com>
Mime-Version: 1.0
References: <20260708234854.4044652-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260708234854.4044652-9-skhawaja@google.com>
Subject: [RFC PATCH v2 08/10] dma: contiguous: Export is_from_cma helper for kunit
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
X-CRM114-CacheID: sfid-20260708_164903_308263_10FA1842 
X-CRM114-Status: GOOD (  11.39  )
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

The is_from_cm() can be used to check if a memory allocation is done
from CMA. Export the helper when kunit is enabled so it can be used by
the kunit tests.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 kernel/dma/contiguous.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 0b1702bf39ca..6d0cf9c7528c 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -37,6 +37,8 @@
 
 #define pr_fmt(fmt) "cma: " fmt
 
+#include <kunit/visibility.h>
+
 #include <asm/page.h>
 
 #include <linux/memblock.h>
@@ -153,6 +155,7 @@ bool dma_is_from_cma(phys_addr_t phys, size_t size)
 
 	return cma_for_each_area(dma_cma_check_area, &chk) != 0;
 }
+EXPORT_SYMBOL_IF_KUNIT(dma_is_from_cma);
 
 #ifdef CONFIG_DMA_NUMA_CMA
 
-- 
2.55.0.795.g602f6c329a-goog


