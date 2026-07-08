Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ABADC44509
	for <kexec@archiver.kernel.org>; Wed,  8 Jul 2026 23:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CKctKavL+T1fCBJtVjfwPQ5K5bQzru9zHJrkxaBJCqQ=; b=RC1nB8vg8cvt/JIB4TlYWK7p2a
	kk2LoTavkGGkfzC4IjAwrGoweYTEKGikcuhGpMO8eTza1MuhGScrehAniuKhn6RL5OeW5KJOD1tyP
	Pc6OZxws6Gd1ivBgNRPDZP25cH3FPpLccXKa38bNHt5QLHkxAjgS6tyz0ei2mxPA7gnAtABQgQZyB
	EmqXn4Pt9X6QWZXSq9lwsrW9XN34hXOKY8p8WpP++Jjr9eayVtY/uJMxVV/Whwj2oZRRkEQ1SrEa1
	9na7fwT//2xIV12nXQmCYmu8r1+zFnb3K/d5EYTjkAEb0xzg3DmpfDLAZ/e/mymcBxvEJKNa34ZF3
	bdm1pecw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whc0h-00000000cwz-48uz;
	Wed, 08 Jul 2026 23:48:59 +0000
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whc0e-00000000cvm-3Mcq
	for kexec@lists.infradead.org;
	Wed, 08 Jul 2026 23:48:58 +0000
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-c88d7a75507so509974a12.1
        for <kexec@lists.infradead.org>; Wed, 08 Jul 2026 16:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783554535; x=1784159335; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CKctKavL+T1fCBJtVjfwPQ5K5bQzru9zHJrkxaBJCqQ=;
        b=F/1+36ApDFljxXK6A+P1GWIqK4KbmgdnnaxyfGOuPV2iBOcBS3iD15XVQHD7HucPx+
         Bsjz4Gg2qYQdzladHOdwDuSHdS+prQIWiARR4kXp2UR88SNmErMWfenZVsZJ4oTlU5DH
         HmSp+kisaFEVVPrgKK8DwFRXoJGQZiqHa+gt6MBBCSztgHbz1zWACko6OKrWoC3GBG5x
         OcH83NpMG4F5y5/KHKEFaE6ZesaXwU2QA77ww0XQQ7YhCs0tVTcmDNfeQjEywT7JBDA7
         3Jc9OlqvuIejc0y4GGBcjuXhcrcU7MjIlz0L7a7c7sXQ3DQutxBsDqtNrQVW2fNKG1Ka
         rgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783554535; x=1784159335;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CKctKavL+T1fCBJtVjfwPQ5K5bQzru9zHJrkxaBJCqQ=;
        b=KHl3BgXUzXxPagGVml/6CxQI17E91BHTMhCXnse2mFjM0y0hfzkueiB22UFYzNErAs
         /4FiaXCVib0BGN5ix6W4PbWkb5dNccz0WkAM10/zPAcBebPBtasGRbqTVTcreUqwJK3I
         yOvfmsXHxy+Uhv1Ftzog5SJVORC6nDKo6LiZSNZTLAvr+/Og5zF5fu/t2OfJiXZO7O81
         meJt4XLbNo/gvdCcPlW8t3RhCXmDh73oBs569BzfQmuZjh+JVNcNRV4S86VPLxj3bv7U
         h7F481G7ZTLrx7WYf/ZQBweXXMwqkz/JdDgCewIas9PiOHwwqFifyTm11xRrgDjWvyEg
         IkaQ==
X-Forwarded-Encrypted: i=1; AHgh+RoJm2HpnH49gmYzxSYpJZ/eJ1hqyz7cDVH7ZOC/h4ZNapDUgEYeTN5xhcSEwocPwcssidMQyA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyApI/EifxaT4BydDQaBqWGO+RgqGzLFl10SHtpCSP6UXRV3OAD
	lacSPn2jfExX8kYWXQt5E91y519411sG9q1S5LRK18utNYwzINc0OF9Hqg3KJ4nEb+NUu5AioSz
	1lmYZrFILXsWBTw==
X-Received: from pfblh15.prod.google.com ([2002:a05:6a00:710f:b0:845:eada:32d2])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:9513:b0:845:db8d:f631 with SMTP id d2e1a72fcca58-84842ec1f1dmr4624788b3a.7.1783554534952;
 Wed, 08 Jul 2026 16:48:54 -0700 (PDT)
Date: Wed,  8 Jul 2026 23:48:44 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260708234854.4044652-1-skhawaja@google.com>
Subject: [RFC PATCH v2 00/10] dma-mapping: Add preservation of direct allocations
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
X-CRM114-CacheID: sfid-20260708_164856_846590_09B02FD3 
X-CRM114-Status: GOOD (  15.50  )
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

This is an RFC v2 to discuss the preservation of DMA allocations for
devices that are using direct allocation mode. Note preservation here
means preservation of physical memory using KHO only. IOVAs and IOMMU
mappings are out of scope.

The complexity and need of this was discussed in the thread mentioned
below. It was proposed to allow preservation of only a subset of
allocations with minimum support. Offline discussion with Will Deacon
concluded that this series is still needed, because we still want to use
coherent allocations for Arm sMMUv3 ste/cds, so sending this v2.

https://lore.kernel.org/all/aepfYzkI7NsVGCF0@google.com/
https://lore.kernel.org/all/aepRy7Gp7Ng85Zr7@willie-the-truck/

Note DMA allocation allows memory allocation from various allocators in
various configurations. This RFC supports preservation with,

- Direct Allocation Only.
- Pages allocated through alloc_page (Buddy allocator).
- No CMA support.
- No DMA pools.
- No device coherent memory regions.

Note that this series does not include/use the page-split and page
refcount fixes during KHO restore, that are in review here:
https://lore.kernel.org/all/20260703020832.1731864-1-praan@google.com/

The changes are also pushed here:
https://github.com/samikhawaja/linux/tree/dma-alloc-preserve-direct-v2

Testing:

This patch series includes a Kunit test, for testing dma allocation
preservation, by using the KHO stubs added in a separate patch series:
https://lore.kernel.org/all/20260521193202.746810-1-skhawaja@google.com/

The following test runs are executed in qemu.

Run on x86:

   KTAP version 1
   1..1
       KTAP version 1
       # Subtest: dma_direct_liveupdate
       # module: direct_test
       1..5
           KTAP version 1
           # Subtest: test_dma_direct_coherent
           ok 1 size=128
           ok 2 size=4096
           ok 3 size=8192
           ok 4 size=12288
           ok 5 size=32768
       # test_dma_direct_coherent: pass:5 fail:0 skip:0 total:5
       ok 1 test_dma_direct_coherent
           KTAP version 1
           # Subtest: test_dma_direct_non_coherent
           ok 1 size=128
           ok 2 size=4096
           ok 3 size=8192
           ok 4 size=12288
           ok 5 size=32768
       # test_dma_direct_non_coherent: pass:5 fail:0 skip:0 total:5
       ok 2 test_dma_direct_non_coherent
           KTAP version 1
           # Subtest: test_dma_direct_coherent_atomic
           ok 1 size=128
           ok 2 size=4096
           ok 3 size=8192
           ok 4 size=12288
           ok 5 size=32768
       # test_dma_direct_coherent_atomic: pass:5 fail:0 skip:0 total:5
       ok 3 test_dma_direct_coherent_atomic
           KTAP version 1
           # Subtest: test_dma_direct_non_coherent_atomic
           ok 1 size=128
           ok 2 size=4096
           ok 3 size=8192
           ok 4 size=12288
           ok 5 size=32768
       # test_dma_direct_non_coherent_atomic: pass:5 fail:0 skip:0 total:5
       ok 4 test_dma_direct_non_coherent_atomic
       ok 5 test_dmam_preservation
   # dma_direct_liveupdate: pass:5 fail:0 skip:0 total:5
   # Totals: pass:21 fail:0 skip:0 total:21
   ok 1 dma_direct_liveupdate

Run on arm64:

   KTAP version 1
   1..1
       KTAP version 1
       # Subtest: dma_direct_liveupdate
       # module: direct_test
       1..5
           KTAP version 1
           # Subtest: test_dma_direct_coherent
           ok 1 size=128
           ok 2 size=4096
           ok 3 size=8192
           ok 4 size=12288
           ok 5 size=32768
       # test_dma_direct_coherent: pass:5 fail:0 skip:0 total:5
       ok 1 test_dma_direct_coherent
           KTAP version 1
           # Subtest: test_dma_direct_non_coherent
           ok 1 size=128
           ok 2 size=4096
           ok 3 size=8192
           ok 4 size=12288
           ok 5 size=32768
       # test_dma_direct_non_coherent: pass:5 fail:0 skip:0 total:5
       ok 2 test_dma_direct_non_coherent
           KTAP version 1
           # Subtest: test_dma_direct_coherent_atomic
           ok 1 size=128
           ok 2 size=4096
           ok 3 size=8192
           ok 4 size=12288
           ok 5 size=32768
       # test_dma_direct_coherent_atomic: pass:5 fail:0 skip:0 total:5
       ok 3 test_dma_direct_coherent_atomic
           KTAP version 1
           # Subtest: test_dma_direct_non_coherent_atomic
       # test_dma_direct_non_coherent_atomic: DMA allocation using pool, expecting -EOPNOTSUPP
           ok 1 size=128
       # test_dma_direct_non_coherent_atomic: DMA allocation using pool, expecting -EOPNOTSUPP
           ok 2 size=4096
       # test_dma_direct_non_coherent_atomic: DMA allocation using pool, expecting -EOPNOTSUPP
           ok 3 size=8192
       # test_dma_direct_non_coherent_atomic: DMA allocation using pool, expecting -EOPNOTSUPP
           ok 4 size=12288
       # test_dma_direct_non_coherent_atomic: DMA allocation using pool, expecting -EOPNOTSUPP
           ok 5 size=32768
       # test_dma_direct_non_coherent_atomic: pass:5 fail:0 skip:0 total:5
       ok 4 test_dma_direct_non_coherent_atomic
       ok 5 test_dmam_preservation
   # dma_direct_liveupdate: pass:5 fail:0 skip:0 total:5
   # Totals: pass:21 fail:0 skip:0 total:21
   ok 1 dma_direct_liveupdate

Looking forward to your feedback on this.

Changelog:

rfc v2:

  - Add dma_is_from_cma() to check if an allocation is from CMA.
  - Add dma_is_from_dev_coherent() to check if an allocation is from a device coherent region.
  - Add support for preserving device-managed DMA allocations (dmam_alloc_*).
  - Add KUnit test suite for dma-direct liveupdate preservation.

Samiullah Khawaja (10):
  dma: Add DMA allocation preservation KHO ABI
  dma/pool: Add an API to check if DMA allocation is from pool
  dma: contiguous: Add API to check if an allocation is from CMA
  dma-coherent: Allow checking if allocation is from dev coherent region
  dma-direct: Add API to preserve/restore allocations
  dma-mapping: Add API to preserve/restore DMA allocation
  dma-mapping: Add support of preserving dmam allocations
  dma: contiguous: Export is_from_cma helper for kunit
  dma: pool: Export the is_from_pool helper for kunit
  dma-direct: Add KUnit test for liveupdate preservation

 include/linux/dma-direct.h        |  29 +++++
 include/linux/dma-map-ops.h       |  10 ++
 include/linux/dma-mapping.h       | 100 ++++++++++++++
 include/linux/kho/abi/dma_alloc.h |  32 +++++
 kernel/dma/Kconfig                |  12 ++
 kernel/dma/Makefile               |   1 +
 kernel/dma/coherent.c             |  11 ++
 kernel/dma/contiguous.c           |  27 ++++
 kernel/dma/direct.c               | 189 +++++++++++++++++++++++++++
 kernel/dma/direct_test.c          | 208 ++++++++++++++++++++++++++++++
 kernel/dma/mapping.c              | 132 +++++++++++++++++++
 kernel/dma/pool.c                 |  17 +++
 12 files changed, 768 insertions(+)
 create mode 100644 include/linux/kho/abi/dma_alloc.h
 create mode 100644 kernel/dma/direct_test.c


base-commit: ec4084bc445027a52f600e30a976928be1ba1950
-- 
2.55.0.795.g602f6c329a-goog


