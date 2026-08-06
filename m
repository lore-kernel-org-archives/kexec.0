Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C600EC56208
	for <kexec@archiver.kernel.org>; Thu,  6 Aug 2026 09:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=iAi2qaVA1OaGq4fUWHi+grRNkf4AM4PgvPmY0Rr+XE4=; b=jbORiAnrO1hvtMAe7FTehJNIXm
	csIMWah409Th86aKk583B4snk27Khbf6+fNzuRnOTU+pZhhzSn3ZvQi6sHONttxPdtORukRv6A4Dc
	Vbh3rmqmMFGV7CmY5zI2+SZH0ZMVLSuWiI6pwCcRJG9PFGy6nqrTZlHrxITegXyRcL5jEI/eiMvS2
	fSQ8Ad5m8kGpOLJPJTcjsS4F41reO1RSuaWmqZRsZnilHcQXs8HlH/WmztdeHBbXj0arovrK5JlSQ
	Cx9BScOnXFgmMM9Iu3mcebZUNZd4DgZtljcXdNY8MUfbO2F3G2u4rVz9k5HFbifHoMYtj4Q8VoiSZ
	YXNUGchw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wruVo-00000005PLd-3DJh;
	Thu, 06 Aug 2026 09:35:40 +0000
Received: from mail-pz2-x00.google.com ([2607:f8b0:4864:3b::])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wruVl-00000005PJP-36gX
	for kexec@lists.infradead.org;
	Thu, 06 Aug 2026 09:35:39 +0000
Received: by mail-pz2-x00.google.com with SMTP id 41be03b00d2f7-ca92f36c4acso706215a12.1
        for <kexec@lists.infradead.org>; Thu, 06 Aug 2026 02:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786008936; x=1786613736; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iAi2qaVA1OaGq4fUWHi+grRNkf4AM4PgvPmY0Rr+XE4=;
        b=ko4UyEwUz7yldv/ewNdH9ueIvQGrtl8Rbl3zFr+1GEvU1c2RYD1hcaPu2MZhAY2OJm
         EcSc/HLvwkoXFQwJ1w3ZXbqOaAZtiZN6cO3Zz05STtoDyns6547j8bAR/uisQMkY/Gxl
         Y/pBmvlqqsO6kJFyNcpbS89VVtab/Y2JX8b6DSfSAhmdpgk5ihBjBWCFyuoGBl4PMnYs
         Y09Hw2QNRmX2xARi48FHVagVkKMy+KxAynKSgv6DvdAJjYsUbh5bmq1ja4fdd0EQG4f+
         pCgVrVkBrUoQM8mkjV1Z2/qdi8z6mw/Q/uvzr8vx57q62iAWezHjQjUx+iXAu19UDiyz
         E8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786008936; x=1786613736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iAi2qaVA1OaGq4fUWHi+grRNkf4AM4PgvPmY0Rr+XE4=;
        b=gubl2IZKXGezg0oMciWNVj/1XyswuUDrBEW+2T+Tx1LpRa803/h1rYMdyg1QKnKpcz
         p7HC6E5skMW9rWPFt2I9entyvvIOhC+yBBoWAcsgFpo0I+L+O/Z3xJKR+dTR46+M+V7Y
         yLg0owvns8nWrlL93Mla8S2ayRQzLS+zzRCKU947QFSvPLxi/ZuU5Bfh6OvHUE20FcZM
         kQjg7UR7WkSCHoa0vtbRT0S08rgSuaVBTmV5RqoaVgwGkecsRynDOjwma7ARAPU3pfk/
         oFKjqEqlM+sINzoF8Po4E4kYt2XbvU2i/VDELMJ6EmnO9ubmyg5sfG1ZPnMO6enEMKsa
         ShcQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr/HZAYi1Dm1mu/spNVqRTTDXNjB0EeW19PrhPn2/rRhccWYHlGOgVzhhiKgneG4ESbFxn+jQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxVGu1ArYD4Iw7efuORwCIfIJ1vsrLCOHWi0PG1p79sd/8jAThc
	yypRAyp5ABFOhGAi5Enlre+Yl10MLTnSj2r3zYoizraLI6lvT6McPKm5
X-Gm-Gg: AR+sD11r/Z72zYkaLM+YYvIqgi8wc8vEMhivh77BN+WD6i2SqBnSVHF6W1infZ+LTmv
	JVmU+VjmLhT4dPObut6/DFoRaql89v+GC1e0C/KgZOcIZEkjvU9Hb5bO444FyGu0HIfStAWR4bD
	PVmFy0sm4gMLoF2klP6do/Dj3VukiPa1TBGgni0dPwj7Kx0inYn3mrr680GNyv9nluSrDF/Rlmh
	4FQ4OiqU8J+UtqI4lreKoq1gkgXBXixT8vm73BukO/njWKHNgMSDgGDv+Fq6/fRXqaghQJZpTzW
	cssqrprfd1xhyBJEJkWyM5+izEWeH2Ex3aXKZLtNbKA/hlhK6mG2ldivgUEFLe8/P2OgldeGO2W
	KFZQZRHxzw/VYcjBLlZSYPgze/PqNnLfCJx+yZj7RlxzLaDVOLlz01ExoPn8wtHttczc6fskN7e
	1xxSKq3djICHURF7nuTHT9MDldGyGa+veZMjKto0426DedQZifQyUTsWiBxjgT5p3qjXyjMKgRv
	Q==
X-Received: by 2002:a05:6a00:9515:b0:84c:1cd2:142e with SMTP id d2e1a72fcca58-84f4fe9e75cmr58122b3a.23.1786008936445;
        Thu, 06 Aug 2026 02:35:36 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f453b0aeasm1043878b3a.13.2026.08.06.02.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 02:35:35 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh@kernel.org,
	saravanak@kernel.org,
	rppt@kernel.org,
	baoquan.he@linux.dev,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	m.szyprowski@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-mm@kvack.org,
	kexec@lists.infradead.org,
	iommu@lists.linux.dev
Cc: kernel@xen0n.name,
	alex@ghiti.fr,
	akpm@linux-foundation.org,
	ruirui.yang@linux.dev,
	robin.murphy@arm.com
Subject: [PATCH v5 0/8] kdump: reduce vmcore size and capture time
Date: Thu,  6 Aug 2026 17:35:11 +0800
Message-ID: <20260806093519.2907771-1-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260806_023537_779484_3B95C07A 
X-CRM114-Status: GOOD (  12.48  )
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

On SoCs that carve out large firmware-owned reserved memory (GPU,
camera ISP, ...), kdump currently dumps those carveouts as part of
system RAM even though their contents are firmware state that is not
useful for kernel crash analysis.

This series introduces a 'dumpable' flag on struct reserved_mem and a
MEMBLOCK_NODUMP flag in memblock to filter vmcore ELF header on DT-based
architectures (arm64, riscv, loongarch). Reserved regions default to
non-dumpable and are marked MEMBLOCK_NODUMP so kdump omits them;
reusable CMA regions are explicitly marked dumpable in rmem_cma_setup()
because their pages are handed back to the buddy allocator and may carry
crash-relevant data.

Since the reserved memory regions are filtered out, the vmcore is
smaller in size and faster to produce. ACPI systems already filter
reserved memory out of the vmcore through their existing path; only
DT-based systems currently fail to filter these regions, which is what
this series addresses. The flag lives in memblock itself rather than
in a DT-only structure, so the mechanism is generic and both ACPI and
DT systems can benefit from it (suggested by Rob, thanks).

The series is based on linux-next and is organized as follows:
  Patches 1-2: Introduce MEMBLOCK_NODUMP in memblock and the dumpable
               flag on struct reserved_mem.
  Patches 3-4: Mark non-dumpable /reserved-memory and /memreserve/
               entries with MEMBLOCK_NODUMP.
  Patch 5:     Switch riscv to memblock so the NODUMP flag is visible
               to the vmcore ELF header builder; add (KEXEC_FILE &&
               CRASH_DUMP) to riscv's ARCH_KEEP_MEMBLOCK condition.
  Patches 6-8: Fold the duplicated per-arch memblock walks into the
               weak defaults in crash_core, switch to
               for_each_mem_region(), and exclude MEMBLOCK_NODUMP
               regions from the vmcore ELF header.

v4 --> v5:
1. Rework the mechanism around a memblock-level MEMBLOCK_NODUMP flag
   (suggested by Rob) instead of the v4 opt-in 'dumpable' flag on
   DT-only struct reserved_mem.

2. Switch the riscv vmcore elf header preparation to use memblock
   instead of the resource tree, aligning it with arm64 and loongarch,
   so riscv also can exclude reserved memory from vmcore.

3. Deduplicate the vmcore elf header preparation: arm64, riscv and
   loongarch open-coded the same logic, so fold it into shared
    __weak defaults in crash_core.

4.  Drop the v4 patch that saved /memreserve/ entries into the
    reserved_mem array; /memreserve/ is now marked MEMBLOCK_NODUMP
    directly.

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

Wandun Chen (8):
  memblock: introduce MEMBLOCK_NODUMP flag
  of: reserved_mem: add dumpable flag to opt-in vmcore
  of: reserved_mem: mark /reserved-memory entries with MEMBLOCK_NODUMP
  of: reserved_mem: mark /memreserve/ entries as MEMBLOCK_NODUMP
  riscv: build crash_mem ranges from memblock instead of resource tree
  crash_core: fold duplicated memblock arch hooks into the weak default
  crash_core: replace for_each_mem_range() with for_each_mem_region()
  crash_core: skip MEMBLOCK_NODUMP regions when building vmcore ELF
    header

 arch/arm64/kernel/machine_kexec_file.c     | 29 ------------------
 arch/loongarch/kernel/machine_kexec_file.c | 27 -----------------
 arch/riscv/Kconfig                         |  2 +-
 arch/riscv/kernel/machine_kexec_file.c     | 33 --------------------
 drivers/of/fdt.c                           |  2 ++
 drivers/of/of_private.h                    |  1 +
 drivers/of/of_reserved_mem.c               | 35 ++++++++++++++++++++++
 include/linux/memblock.h                   |  9 ++++++
 include/linux/of_reserved_mem.h            |  1 +
 kernel/crash_core.c                        | 34 +++++++++++++++++++--
 kernel/dma/contiguous.c                    |  1 +
 mm/memblock.c                              | 16 ++++++++++
 12 files changed, 98 insertions(+), 92 deletions(-)

-- 
2.43.0


