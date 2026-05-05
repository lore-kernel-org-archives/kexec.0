Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC19FF885A
	for <kexec@archiver.kernel.org>; Tue,  5 May 2026 00:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Obu+hjMmt2gyOfNoZeJMdjxX5bs05kcQmj8x3MdMggE=; b=gFO+PJ3gMLoVad7EIrLQN6NGat
	ExhM9RowhDBrpUGIAiExyhg5EucYRT/2SUI/woYNLtzgkyF/LsrDxUwM0Zz0c8RyyKq5t7dgqd6Zd
	j1VmfWFmScnLI2R1xzO1yCgEPAMoGj7HpF/+9ImAD8NCecHERj8gmKrWkxlLhNmPbLxsWa38W6kH3
	Uw1J2du3HbGZ0FYSUHzRAYEcDva3LF9Z0vGQEq/W5nudW+KTuDiYy6aaDR697w2W506eanbKsMPrC
	Nakkl3bD0iGrW422R7GIaxLjFlngXp77v9Hx6ECD+5J5PawOox+FZ9ybEQsvpL7s/N4EckRFdbcIU
	ZEun+bOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wK3dX-0000000EiRV-1e1O;
	Tue, 05 May 2026 00:27:43 +0000
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wK3dU-0000000EiQB-1SP6
	for kexec@lists.infradead.org;
	Tue, 05 May 2026 00:27:42 +0000
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-837d0d71c61so746264b3a.1
        for <kexec@lists.infradead.org>; Mon, 04 May 2026 17:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777940859; x=1778545659; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Obu+hjMmt2gyOfNoZeJMdjxX5bs05kcQmj8x3MdMggE=;
        b=qGvnklQLiYYMtIx0rag06XC64ReE1oeGdTo+W+loPqJUEjCL3LyFZ3AdVDgOQVKfwL
         QhqoiW3eU2WkPxpNR3a22fiqgdXTHy1AXaqi8xZtks+2xAyhCshRctUteHUo1xSRxvrC
         moVhGZzXKlrW27ffxFtkmvssFR4CyOCI6m+UcvQapEywP2xIifptu+HPL8/yDErKaPfw
         nTHl4l0sZSwiv7Sde3PubNjy42GRGln4JlH702MsJ1R86zVDjoTAUSuANxYNQVF9y7yS
         AEcP2msdAs092D8vrIb+1zXeVeJQDPCefLXGVvk/yw2QL4VmUWRtzdnbSpWrHEHC6c79
         w7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777940859; x=1778545659;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Obu+hjMmt2gyOfNoZeJMdjxX5bs05kcQmj8x3MdMggE=;
        b=jLNBsZFjtUkmTDgxodqln2v1P32y8LqSQOb+AtZV8E3Mef1v3tU7v0hw7tV1OEceiD
         Ug3hGEZPcRdaVNr1DEDAA5UHPLUV+68PKXtVj9iXpIpT5C+cF3kGdF3i/JnZNLvx1+wp
         TZDOVjakDr5E+YH5aS6d/rzT7Wk5lYQfE/uTogZx2Awx23oCIN4ImYJBa8fcXieCqBNo
         MDH0usziU/IjdNwsW5it9eSNRFDb/BRxCc32OSJN9qXJdg7zfrkHqd1LdhQVwqaDXodE
         MISIK6a6gRhdHveNzl9WVKNV/P3JASE5pz1PhvSFVnr8P7f/ZrFx5ktBH0aIuQJd1yEN
         DXzA==
X-Forwarded-Encrypted: i=1; AFNElJ8HKZThH2Feo7F8+x0+epVL5b7/y/1p+0Fm7CoVfokhVsX0mxgxEsPLZnCcJO/WlThXoJFAdQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx35uyaNdp7V1CMM2kqV1Onucsa7cd4wXv2OC3mWpOMVqiKts/m
	yGRbvSof7PcZIpCK3t2cpPJuZ/BUrrkLAvrNJqG+gYf1HHdQKpgqy2ZUcsMhabb3/3U0jm5Hx5X
	U7/E5sKiAXl7AgQ==
X-Received: from pfbhh11.prod.google.com ([2002:a05:6a00:868b:b0:82f:a959:4a7f])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4188:b0:834:e5a2:d089 with SMTP id d2e1a72fcca58-8352d29abeamr10788662b3a.33.1777940858612;
 Mon, 04 May 2026 17:27:38 -0700 (PDT)
Date: Tue,  5 May 2026 00:27:33 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260505002737.2213734-1-skhawaja@google.com>
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
X-CRM114-CacheID: sfid-20260504_172740_415955_BBB4827E 
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
-- 
2.54.0.545.g6539524ca2-goog


