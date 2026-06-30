Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D51FC43327
	for <kexec@archiver.kernel.org>; Tue, 30 Jun 2026 07:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+GS4Pj9gB+OIxG6eqcIUsdmhCCBXu3Ye2u2fsYJSw7Q=; b=wlBVLwjRgMRAzaq1uQpG4OCMGo
	YogryKhRxzRcPc40Y9fkyXZfOB0BpbkwQjDHW1DWiaFZb+P0dx2MqCQRcbg0y7n5Z2zj7lZaRjknK
	KPCyC0Ia3mwWjNfvuYWhkleEac/nLZnLKvlGw/s9ZORFxm1oQQfCUznfa1/gAzNk5pdEzqJzdkJVv
	s97pIUj51TMby6Hwlam5avBG6/mLFdDeK81GTVk7xaGPQtpveQSGkDmQNRp7BZGE8doTJCTvvgNkN
	pes1O+s/uOElwoCjNkGjM+MecoBdYP+MzMfGMTQqfDiA4e06PYoPXPzTphOhiLJEYlH9+L9d+qgAX
	L8M6uECg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weTC9-0000000G9Jv-3Bwx;
	Tue, 30 Jun 2026 07:47:49 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weTC8-0000000G9Io-3Bqy
	for kexec@bombadil.infradead.org;
	Tue, 30 Jun 2026 07:47:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=+GS4Pj9gB+OIxG6eqcIUsdmhCCBXu3Ye2u2fsYJSw7Q=; b=P2MWKRFCRes3npn74t1GeuCu9v
	ojQ8FZbbh1T43JF7SXSU29pd+QUaDs3LicMcDtH37enUf7w5ZO9U74vQ8v4dqTaesdc5ge6Qdvv9q
	pLY1xMjW+4ewLwI9tUD0uD5Ygb6DLToGxnIa/ZhZbrrzpRapNCICYT19oMa4IlxpPsSMqb54reSAy
	DjhwoI5P3C6lhCybfTS3IaRE/O91o6Mxv1ML4t6ecJhwDR+j1WbafTDMdwJBip60rz2BKViK/Jrwi
	EnoYz+c5/Eg49Jn1RJm52DieAlWhyDQC9JdXt7l8JK7ZrwUIE3sSo2NGs+EDhKaIBfz6XJRATV+vG
	34hxggDw==;
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1weTBr-00000001cgj-18db
	for kexec@lists.infradead.org;
	Tue, 30 Jun 2026 07:47:45 +0000
Received: by mail-pl1-x643.google.com with SMTP id d9443c01a7336-2c821a50615so21151575ad.0
        for <kexec@lists.infradead.org>; Tue, 30 Jun 2026 00:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782805649; x=1783410449; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+GS4Pj9gB+OIxG6eqcIUsdmhCCBXu3Ye2u2fsYJSw7Q=;
        b=rln5CB96SfVHTOQWz6rVckMjd5umE7tmiP+/JjDH2KkiNyazSEhOc2/kRWbkT585+d
         issNH59Ye8h4eHqqaKDLjgZehMFakxYuq0LX/ZF9rS19d1Zp5rW9IIrQhO6Dw6dM6bsw
         qZNyJdc3qPtdQYoGoB+6+JN4yCyYLcb365wm1ErqHex07bXUcT1TEP/qtWPO4sAS7/EB
         1/J+yFNq0fca+0h1Se0xKeaHbzs2upjr5DK8dDhLk1BDozQ9WeLprQBCmWorSirEdpRF
         sQl/Td+OFTcWLzhTpAHdmzJ/RXi6WnpfKxQKZ8COdF2R74GPXCKXurC/oOQ5wqsicCQc
         ssYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782805649; x=1783410449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GS4Pj9gB+OIxG6eqcIUsdmhCCBXu3Ye2u2fsYJSw7Q=;
        b=PZl5Bq7FYpwBdh4Hdxjru7Mb8Lyzh73gAQqdYtRuClBZaJDMGVHQbMUJlkOzWC5lK3
         jS0E+3fi3Vyl0ol0+lQRGKdUGbCIwu+G0IRZ3DyQGKHeHHx1eoVLk1V+rQf6Ozx0Zgao
         ikobYJDDBJsULakxrhUKjuOxYwR3pAHeksR4wVF0hqoTWqXzWw+IDQyHBb23EoD/wFcm
         FxeLUI6HzFl+FK+299tso2cdDmZn2ku7u47FggsYk/Jsg2ThHGmNVl94ni5FNddZ/nTV
         MVO66gEPpDKXOHAzHIgu/cybIv1v3BK7dnI7H+cm2HhDaZ39GxTUCtdk040n1c6eqOBf
         3v1w==
X-Forwarded-Encrypted: i=1; AHgh+Rqr1jzP7lj8SuWGmV3ZSgRb1yScAO4gHcE60gbW9jwLoLMhI7+HfdC82FVO+gkXeYhS1kO2TA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzZKsubqBOdblsjVEWWEC2xHwhrE9M1oaJrYmYNCWV9SvcmXNsg
	3XZDXGcgOzBmBFYnzwEc5x17HY+gfp5UMhAFEixl1CryI5Yvzq6tahJA
X-Gm-Gg: AfdE7cm9VjlABxvvcyW9JJLPqha5ivC4QKKBOjyv5+hm1S7/YgcBA39lLQbiMsVOfzq
	NwZE/3kBD+vy8uapus/XK+47rQvpva8fr/d0xDn7GEJjxendHToaWWnFBNG7TUJW2piK8rqneHV
	HVyanhsXwBzGOQnZo2e7suoDrV0ynJ9lYySji/Dv5i2Mj8pc/jLRblRgzYNBYqvZU6FNyFu/coS
	Te51d3kRx92NaUx0Og4CK7M8/CxPOPybCzb5L84wQkYJQqxIt8Pv3lYgHb3yK8m1fSms0znA/vq
	5a+qJtpFswxl4VvqthH8af7DWOZyBcPsDWTf/2otlK+65O48TEWzhFFtbCKZ7Z+JILgVJPuid/K
	iECwynmAXvXdfnOAIxgZ1SJ86aF9ccFjQtqZRQQ3H4Gqc2hBHWjKi6jJrsLmXeixi+AdsoFvopk
	PUGhtIkT19vufC6DdCQ0tOVLVuYg==
X-Received: by 2002:a17:903:46cf:b0:2c9:f0e3:e20a with SMTP id d9443c01a7336-2ca2ea178a7mr21382995ad.33.1782805648953;
        Tue, 30 Jun 2026 00:47:28 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca382a2d3dsm7821045ad.55.2026.06.30.00.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 00:47:28 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh@kernel.org,
	saravanak@kernel.org,
	bhe@redhat.com,
	rppt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	iommu@lists.linux.dev,
	zhaomeijing@lixiang.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	alex@ghiti.fr,
	akpm@linux-foundation.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com
Subject: [PATCH v4 00/10] kdump: reduce vmcore size and capture time
Date: Tue, 30 Jun 2026 15:47:04 +0800
Message-ID: <20260630074715.4126796-1-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260630_084743_833186_C58946E2 
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

From: Wandun Chen <chenwandun@lixiang.com>

On SoCs that carve out large firmware-owned reserved memory (GPU
firmware, DSP, modem, camera ISP, NPU, ...), kdump currently dumps
those carveouts as part of system RAM even though their contents are
firmware state that is not useful for kernel crash analysis.

This series introduces an opt-in 'dumpable' flag [1] on struct
reserved_mem and uses it to filter the elfcorehdr PT_LOAD ranges on
DT-based architectures (arm64, riscv, loongarch). By default reserved
regions are treated as non-dumpable; CMA regions are explicitly opted
in because their pages are returned to the buddy allocator and may
carry key crash-analysis data.

Since the reserved memory regions are filtered out, the vmcore is
smaller in size and faster to produce. The reserved memory
has already been filtered out in x86; the optimizations in this series
apply to systems that use DTS such as arm64/riscv/loongarch.

The series is organized as follows:
Patches 1-4: Small prepare changes and cleanups.
Patches 5: Add dumpable flag to opt-in vmcore.
Patches 6: Append /memreserve/ entries into reserved_mem[].
Patch 7: Add generic kdump helpers.
Patches 8-10: Wire the helpers into arm64, riscv and loongarch kdump
              elfcorehdr preparation.

v3 --> v4:
1. Rebase this series on v7.2-rc1.
2. Add two cleanup patches (patch 02/03).
3. Simplify patch 03 to avoid checking whether initial_boot_params is
   NULL multiple times, suggested by Rob.

v2 --> v3:
1. Fix out-of-bounds issue if device tree lacks /reserved-memory node.[2]
2. Fix UAF issue when alloc_reserved_mem_array() fails.
3. Add some prepare patches.

v1 --> v2:
1. v1 added an opt-out DT property ('linux,no-dump'). Per Rob's
   feedback [1], v2 drop that property and exclude reserve memory
   by default.
2. Split some prepared patches from the original patches.
3. Address coding-style comments on patch 5 from Rob.

[1] https://lore.kernel.org/lkml/20260506144542.GA2072596-robh@kernel.org/
[2] https://sashiko.dev/#/patchset/20260520091844.592753-1-chenwandun%40lixiang.com?part=4


Wandun Chen (10):
  kexec/crash: provide crash_exclude_mem_range() stub when
    CONFIG_CRASH_DUMP=n
  of: reserved_mem: dedup and relocate reserved-memory messages
  of: reserved_mem: skip late scan when no regions are reserved
  of: reserved_mem: split alloc_reserved_mem_array() from
    fdt_scan_reserved_mem_late()
  of: reserved_mem: add dumpable flag to opt-in vmcore
  of: reserved_mem: save /memreserve/ entries into the reserved_mem
    array
  of: reserved_mem: add kdump helpers to exclude non-dumpable regions
  arm64: kdump: exclude non-dumpable reserved memory regions from vmcore
  riscv: kdump: exclude non-dumpable reserved memory regions from vmcore
  loongarch: kdump: exclude non-dumpable reserved memory regions from
    vmcore

 arch/arm64/kernel/machine_kexec_file.c     |   6 ++
 arch/loongarch/kernel/machine_kexec_file.c |   6 ++
 arch/riscv/kernel/machine_kexec_file.c     |   4 +
 drivers/of/fdt.c                           |  11 ++-
 drivers/of/of_private.h                    |   3 +
 drivers/of/of_reserved_mem.c               | 108 ++++++++++++++++++---
 include/linux/crash_core.h                 |   6 ++
 include/linux/of_reserved_mem.h            |  15 +++
 kernel/dma/contiguous.c                    |   1 +
 9 files changed, 142 insertions(+), 18 deletions(-)

-- 
2.43.0


