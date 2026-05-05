Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26082CD3436
	for <kexec@archiver.kernel.org>; Tue,  5 May 2026 00:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fPL/zEjIbq1+/WxDxvRlbVhXmcB0wkR7Z2KUt1rRxnY=; b=Yoasb7cPzUel9RD01OICGiX4pE
	7GcPzBKyXQGHsYHm75g/HVyHri5JxUf+ohVPERQZqxYCNylpFcjoioatzGikQ7vpwiNC/QkrPnQsN
	pxPBKmCmQXdYqayUKtbUBHytyIDeRkVYz1EgAB9UC45sFbNhtUuMA6wjvF1wLOc+Jrn7aHQ+wSOLJ
	rKEBnt1JbcIJ0mPVHaYs2lxATIwOnzNgaz3dKgTAEI0sBVjbr24O+LBC8q6ZN6Z4d/nigjeTi3f3x
	dZMZOUlpjrIImmZJixI8KSH0md4ITrZGwV49qN0hMFYCB8XOWgr2tOGEXEt58AB0uF8uYEMV1hvXo
	Z0IQB+WQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wK3dY-0000000EiSb-3y9h;
	Tue, 05 May 2026 00:27:44 +0000
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wK3dX-0000000EiRQ-2KFr
	for kexec@lists.infradead.org;
	Tue, 05 May 2026 00:27:44 +0000
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-836cfd84728so745771b3a.0
        for <kexec@lists.infradead.org>; Mon, 04 May 2026 17:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777940862; x=1778545662; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fPL/zEjIbq1+/WxDxvRlbVhXmcB0wkR7Z2KUt1rRxnY=;
        b=h2bjaNkXkYTwOaIXuNBktYdEhdBY21Spw3H9QDqaOvfeMLV2MonHPGa+wgfBwQEH3+
         bZN3L6lIE0Zox8tz2PAKO+MJoclCN3DblVYud7yTFs+kMb1sbbhezU6hUePfBpRN73Cj
         NNkJWmLYojBR1wrALQPULTiEl0rT79vV2UKIdaTPNI1ubZUSPt9alnaeXTVSyB1MKz2M
         wyMPF1RPgXk9XatGiqcuxnYej6hEfFiAgihgvmnW5eVN7lOd43M3IkdSm8q5LQhxnUnN
         NTyQ0lbtlt9UYdOmBqa5oDkbBI4MDlYZEb3JtUIrgQOaF1/Gh7yBYTcFXuZU0tbAP/W7
         NFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777940862; x=1778545662;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fPL/zEjIbq1+/WxDxvRlbVhXmcB0wkR7Z2KUt1rRxnY=;
        b=aoOWU/O0dYXCY+pHq895i+nzr7ngB9SXQgSjPsqmWyo6JcWhsADTu/xJgEd2DAZSNB
         5Ir7QAE1D3L3JZCrTwCAqgNUxt5uTM+R2H+zSvQsxbKJDqBDjOI0t6r+NhGuffQP/f3V
         UThEfEzVZncZdy4opCjM04kRrl2dcK4ZaDmBO87E7vEaRjM7I/E9spGVrrVjRrV+QzhC
         o8fhNSPUsgQWvUYjQkiKXDrz1DGiV25Y7XOYt7SRzLOp7zCoE0paAS1QqoRqb3ISB1bC
         I8K7aPxT9CoKpWKbP+KQqw3ZcAhCOrOdMi4iyF0ey5ls0iIcP+W/mZFUmgAYZrr+Duzw
         /xXg==
X-Forwarded-Encrypted: i=1; AFNElJ+J/+TfU37fPOsqxdB/RCn5oAaNPhQF8IQfFI+nuG9l2NNZT5HhD++ZdGN2MxRxxF5X28p/yw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxFopDJcwr0IMZb96HZdxD79Z3abLK2tlKuytj83Bwu9gvmzRc0
	hznwcVl5MEx0NAgIStxcUraGxi9SYD1IC9Mqnvo9SveBa+lKmDBCz9b+1QwHEvRPE86k3YHgfEX
	a1z1bOH3uSyuf9w==
X-Received: from pfbgj10.prod.google.com ([2002:a05:6a00:840a:b0:82f:d8c0:fef8])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:340e:b0:837:8a0c:8f70 with SMTP id d2e1a72fcca58-838fe8703c4mr1212855b3a.28.1777940861986;
 Mon, 04 May 2026 17:27:41 -0700 (PDT)
Date: Tue,  5 May 2026 00:27:35 +0000
In-Reply-To: <20260505002737.2213734-1-skhawaja@google.com>
Mime-Version: 1.0
References: <20260505002737.2213734-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260505002737.2213734-3-skhawaja@google.com>
Subject: [RFC PATCH 2/4] dma/pool: Add an API to check if DMA allocation is
 from pool
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
X-CRM114-CacheID: sfid-20260504_172743_591287_857D6FE7 
X-CRM114-Status: GOOD (  11.06  )
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
index 6a1832a73cad..6a0bc4ea2467 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -216,6 +216,7 @@ struct page *dma_alloc_from_pool(struct device *dev, size_t size,
 		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t));
 bool dma_free_from_pool(struct device *dev, void *start, size_t size);
 
+bool dma_is_from_pool(struct device *dev, void *start, size_t size);
 int dma_direct_set_offset(struct device *dev, phys_addr_t cpu_start,
 		dma_addr_t dma_start, u64 size);
 
diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 2b2fbb709242..32ce4d6d7683 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -307,3 +307,16 @@ bool dma_free_from_pool(struct device *dev, void *start, size_t size)
 
 	return false;
 }
+
+bool dma_is_from_pool(struct device *dev, void *start, size_t size)
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
2.54.0.545.g6539524ca2-goog


