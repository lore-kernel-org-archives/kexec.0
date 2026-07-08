Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12046C44503
	for <kexec@archiver.kernel.org>; Wed,  8 Jul 2026 23:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nqgUUDLbrc3OMfaB+epoRKq9BuL+wqg9nIdlWGSYSoM=; b=Ov5+b43raJ7PXryA0Q89c37MSl
	eCSPsF3q83KLgKmMG+nyektBewCKm/ptqLgEp6KAzMx3L/zuQ3sGocGLYNIYF4ZE82G5/Rm9Dcexj
	6954/2I4Ng/s9nLPiB+kynIP5At5eQfueLOFL17dWGEMizxxdBzY2jlE3f7aDH9FVXRP7x5+8ZGO9
	z0a4EpPpwKndZcmEIryGJR9CLC4VmMGo65jypxZN/nBrbCM5msoHsBBFn08P969F9qPQGKK+BwRLu
	S5zKQZiEBPS2TF1jZgDshKGAOXHWOW/H9u9vhVlhSJIvBL1iyiQqITaLxFCGIc3kkpb9/3st5KNxK
	w7PQLjdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whc0p-00000000d66-0ZeL;
	Wed, 08 Jul 2026 23:49:07 +0000
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whc0m-00000000d0X-3eC5
	for kexec@lists.infradead.org;
	Wed, 08 Jul 2026 23:49:05 +0000
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-2cc77a6943eso28434545ad.0
        for <kexec@lists.infradead.org>; Wed, 08 Jul 2026 16:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783554543; x=1784159343; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nqgUUDLbrc3OMfaB+epoRKq9BuL+wqg9nIdlWGSYSoM=;
        b=XHz8Nj+o/g9+7dA1r6Y+6ka7UMvAUB6y9fe2H7ovtkBqC11crW22T04qDh/m6adXAf
         aSIOsJG1YpWhoWur0pLvwRqoM4w/AteigNYMcG0Gpc+A2ehz2ltXxCIEyF+z7X+HbMsm
         07IuhvVQdC+eQyob3stFMKAcJyFaHT+yVozjxgOWtzlmoDJV1fvTJQ5YtUto8xoDhm4m
         xVYJGzoR7iqxX9Ka91S50IOF6BoKtKQE9uwd6W/KL6jvoVNQ5+BJjmDLdqi6ykAikePt
         dv2UIiTv4k7GzwBrxnVgauJxFGpruX9xQ1HbDOyylx+mG/FWoc/Sd1iNx4GRn6QQD5HX
         /+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783554543; x=1784159343;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nqgUUDLbrc3OMfaB+epoRKq9BuL+wqg9nIdlWGSYSoM=;
        b=f85Tm+u6irT1eRNy5DoB0wcTWaSRcRcE51zfM/ka39n97gGcCSphtGF7yCASsWyKqt
         0EMSRc+C9nCodWffDoDkAaVjg96Oy2TK3mFdvA2cSXXd6HL3XNLsbutZPsR0Bglju1D9
         5T7/4ftQFvWl4cVCOCinWE20Renyb5AD8Lw9s0nhNeNOW6cswzkD/k6ZuAGYz4RjWho3
         JSnXq+JmFUhCj/wFvdzzUtOd/1RxCEP5EdHPcXGIxWqgYFizBJSbyOpvGAO9rs0UUl0K
         fepzOctYFO7Ui7GfNWs8ZQFPjRYnww1J7V4Lt78PTss0Y+7FexO8bZHiYqO8zUIgCyOz
         fMUw==
X-Forwarded-Encrypted: i=1; AHgh+Rp6FCNsLp1BvoxwOMyrjjxWWhFgIgc5b64p9Crt1k4d2suz+E4C+gdw7CMmtCqiQfUY+1SGrg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwVz8cfiAekWpJFA/CXvB/snxjs29trnM8QUD0J8rsq6zl/419c
	UwuRRfd4DUFfCzWmlPz8VVcDdN73ThG4CQHxsY+Gfib1Z3BGjyX8/8d/eu8FrQwd/poIQVfMUTU
	+AunMzetZ/YQqZA==
X-Received: from pldv18.prod.google.com ([2002:a17:902:ca92:b0:2ca:d0f4:2f91])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ef06:b0:2ca:a03a:29b2 with SMTP id d9443c01a7336-2ccea2a565fmr51586345ad.8.1783554542780;
 Wed, 08 Jul 2026 16:49:02 -0700 (PDT)
Date: Wed,  8 Jul 2026 23:48:53 +0000
In-Reply-To: <20260708234854.4044652-1-skhawaja@google.com>
Mime-Version: 1.0
References: <20260708234854.4044652-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260708234854.4044652-10-skhawaja@google.com>
Subject: [RFC PATCH v2 09/10] dma: pool: Export the is_from_pool helper for kunit
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
X-CRM114-CacheID: sfid-20260708_164904_928199_CCE10193 
X-CRM114-Status: UNSURE (   9.83  )
X-CRM114-Notice: Please train this message.
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

When kunit is enabled, export the is_from_pool() helper function so it
can be used to check whether the allocations are from DMA pools.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 kernel/dma/pool.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index d1a0bb03e478..78496568973f 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -3,6 +3,9 @@
  * Copyright (C) 2012 ARM Ltd.
  * Copyright (C) 2020 Google LLC
  */
+
+#include <kunit/visibility.h>
+
 #include <linux/cma.h>
 #include <linux/debugfs.h>
 #include <linux/dma-map-ops.h>
@@ -320,3 +323,4 @@ bool dma_is_from_pool(void *start, size_t size)
 
 	return false;
 }
+EXPORT_SYMBOL_IF_KUNIT(dma_is_from_pool);
-- 
2.55.0.795.g602f6c329a-goog


