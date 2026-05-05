Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6560FF885A
	for <kexec@archiver.kernel.org>; Tue,  5 May 2026 00:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=P7hLyOAFb/XotDLSfzs07sOc8bnqFDsHZkne19sPDsE=; b=b54vNHJEw82PQi9YqaZ6TyuK7D
	ZzzmO5kmTRTxr245HpnqEQYesM0e8smnwTfU9QcItM4zlgnZuurlMPaNxxN4MeOP5MXtvdvE1mKDD
	2SYsjPVpSiD4OjeDNeuTLkddytYiUxaITusanEqlpBbsiOWhsiIFlVPFKcILwjGXkoaf9XFXfoRGZ
	X/T07xgZR7kImN7CDmFcAL+T8Yz8cR5Jdn7ysbYHQqfwPW2isHcshSOlIFadjZWfiYmD4I0Lhnfhv
	4EU/DPKun8LPg0H+NaTGvop1eX8Ln6C4zHS/4Ad1IFeRsVo3DdoUcL2xnnPT87AaivLM2y9gpKcZZ
	h1wXJu7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wK3ZN-0000000Ei3X-3Wq9;
	Tue, 05 May 2026 00:23:25 +0000
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wK3ZL-0000000Ei34-3c73
	for kexec@lists.infradead.org;
	Tue, 05 May 2026 00:23:25 +0000
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-2b2ecc96a9aso46256385ad.1
        for <kexec@lists.infradead.org>; Mon, 04 May 2026 17:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777940602; x=1778545402; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P7hLyOAFb/XotDLSfzs07sOc8bnqFDsHZkne19sPDsE=;
        b=WM0VHCYo3xP+tZiw61fB9iE4UY/zkad4ZN70BgWke9UHYJpoCn5qTY2cW1T1/Bqn87
         Z9L+hZ9w++QveVjOp/SfP5mE7ChZMFrOlQpc+a4HYTg70RricsX5FwFd8O9GFS+4DlNp
         cXdznC8YhM5g18C+RKE6sL4iQDrpF43/P4xZCAx/TjnP7urQrMGnH3RxWDHEGJyWVNLk
         d+jxcTtscmc9LyFj7QAYQCajCb3o1KfCjVpVLqgQ5YL5oJTTIkLU/yy14cyvSg7vOk2x
         cBIuJsPf8VZzyKLTBBgFRiP6NtFHp25YZVg7rPc95F8sPCCH5xialpn98VEOIZKYJA/n
         Fg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777940602; x=1778545402;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P7hLyOAFb/XotDLSfzs07sOc8bnqFDsHZkne19sPDsE=;
        b=VuzO2n2hURZW2QqeaI/uUyrWWfS5YAnNHQDKNyIOVgTM0ceuqs5YUrtVVwDNJxC2og
         Hs7dHTag+zyMI4ZZGfn7ga2XF9+v0QlWR/wmyP9sML1AU2HJBk8Yt1enAPTlIWTSqGiD
         PfJ3AHEIxLiQYgQg+NvOgG+pQJSYyW2pNcf52UzTep0w7MtSq/qNIuycSfo5wJedbUo7
         u8jLFmP3Ycti5XRod9oggMvGzf/hIQ4i447n3wiWaxF2t7PqPia6w+wRqJXaUjiqn5jN
         x9KznIYpDZ61PTwCZe/HNRQjPGrcyt3Q0T6AaTvmcfXtIG+K7zsuKpGcMWjvtXuWPpd5
         QVWA==
X-Forwarded-Encrypted: i=1; AFNElJ/6fozYtatZBO0ezzXFZeawOi1Nl2rU7W0xRRGDSQXWZgNsB6DtyPRvL0W/BbuRIThuBty/Mg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy0w5rFKWjAh3iQC8ToSGAHE0NLy7MN0Us4G23fTDbHTRzY7+ky
	wkNVgrQkuaESWam3pAxnvPm7lbTgfoLueRQZ3bw3PGnBbp6SlhhOfZ8Q6mcxrUIlO0PvGusTU6b
	F5JtS47NXx1dwgg==
X-Received: from pfr4.prod.google.com ([2002:a05:6a00:94c4:b0:836:55e:c2f])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:6a15:b0:3a2:cf6d:a9f7 with SMTP id adf61e73a8af0-3aa3b75b178mr909398637.36.1777940601569;
 Mon, 04 May 2026 17:23:21 -0700 (PDT)
Date: Tue,  5 May 2026 00:23:16 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260505002320.2210067-1-skhawaja@google.com>
Subject: [RFC PATCH 0/4] dma-mapping: Add preservation of direct allocations
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
X-CRM114-CacheID: sfid-20260504_172323_934594_E5107E2D 
X-CRM114-Status: UNSURE (   9.47  )
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

This is an RFC to discuss the preservation of DMA allocations for
devices that are using direct allocation mode. Note preservation here
means preservation of physical memory only using KHO. IOVAs and IOMMU
mappings are out of scope.

The complexity and need of this was discussed in the thread mentioned
below. It was proposed to allow preservation of only a subset of
allocations with minimum support.

https://lore.kernel.org/all/aepfYzkI7NsVGCF0@google.com/
https://lore.kernel.org/all/aepRy7Gp7Ng85Zr7@willie-the-truck/

Note DMA allocation allows allocation from various allocators in various
configurations. This RFC supports preservation with,

- Direct Allocation Only.
- Pages allocated through alloc_page (Buddy allocator).
- No CMA support.
- No DMA allocators.

The changes are also pushed here:
https://github.com/samikhawaja/linux/tree/dma-alloc-preserve-direct

Looking forward to your feedback on this.

Thanks

Samiullah Khawaja (4):
  dma: Add DMA allocation preservation KHO ABI
  dma/pool: Add an API to check if DMA allocation is from pool
  dma-direct: Add API to preserve/restore allocations
  dma-mapping: Add API to preserve/restore DMA allocation

 include/linux/dma-direct.h        |  29 ++++++
 include/linux/dma-map-ops.h       |   1 +
 include/linux/dma-mapping.h       |  50 +++++++++
 include/linux/kho/abi/dma_alloc.h |  30 ++++++
 kernel/dma/Kconfig                |   3 +
 kernel/dma/direct.c               | 163 ++++++++++++++++++++++++++++++
 kernel/dma/mapping.c              |  52 ++++++++++
 kernel/dma/pool.c                 |  13 +++
 8 files changed, 341 insertions(+)
 create mode 100644 include/linux/kho/abi/dma_alloc.h


base-commit: 9974969c14031a097d6b45bcb7a06bb4aa525c40
prerequisite-patch-id: 41f13f37cb3b439f17dfa4e3f2d5c767aaef0346
-- 
2.54.0.545.g6539524ca2-goog


