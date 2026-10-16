Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4362CCA463
	for <kexec@archiver.kernel.org>; Fri, 16 Oct 2026 03:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Ed5L209SneTzZcWvCiPDVyFxWV1jqEY6cKUsalB6bvY=; b=YhOsj8f5HFkWFulXfmzrITZWe1
	pxhmP6gQzduJO4NL0cucVrNXsENYrp7Gcx82ATKlxFztPJAPGPzNcPEdxc2gaMZL6Kt2BXC1BvDkH
	wnVsOBxPF3G8W4N131+hRSc16ZNbNUC33GLzJrZp1izzJM0nEBqkyzfXl6vQ9iOX9kFSYoTx71hv8
	BdbMI1Zp43K9BWJIgFbCJvvo03VruyT00hQN0ROI6c3RDunFey+upEA/ElPdcjazDd589bXB5/NhE
	KypyWMjpRbE89mG8E4RcIoo0TCTEyR7eY8aIsDhj/qHZxRMqD8HgvwIsT10m7LfgQYuc4s17l7wdR
	axi0l1Eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHYJt-00000001nB9-3eqc;
	Fri, 16 Oct 2026 03:09:21 +0000
Received: from mail-pj2-x06.google.com ([2607:f8b0:4864:39::6])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHYJn-00000001n9f-3mbL
	for kexec@lists.infradead.org;
	Fri, 16 Oct 2026 03:09:18 +0000
Received: by mail-pj2-x06.google.com with SMTP id 98e67ed59e1d1-3acc610014eso196347a91.0
        for <kexec@lists.infradead.org>; Thu, 15 Oct 2026 20:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792120153; x=1792724953; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ed5L209SneTzZcWvCiPDVyFxWV1jqEY6cKUsalB6bvY=;
        b=sdCFeRTgnkQWgtgrCJdCcRReoJcQirOypY0s/gv4y8VzJffRjWBMQG0Y2xZY4myGfx
         16CC/leT80NOYH8mZawS54saXwZLU4+3X0yrw43/Tau4r7hv60oXpLIXLSolrXXvqLYK
         1cQyKjOelPEmk3McakafGc5vC6aIpP9X8ao9Lvu46bLWuvUjtmJCq3712yZ0VUzBd5ZG
         2X77J70GQr7HrZxpSXj+1An5hXlwfm58ejROG+qa/F3RDCoUxOlTVXR0nwUXgIGzzLSE
         i12YDFkUU5LsFbKa3noik9F2DsbUAazmcb84qmMDnowCdyUCAf8Ttgeq9uuGtJkqDi5X
         t9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792120153; x=1792724953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ed5L209SneTzZcWvCiPDVyFxWV1jqEY6cKUsalB6bvY=;
        b=LlHw0Nlz7vFzlI7VFnOijVyQ8f6eVxErArPbmsOE71Ofn0BN1ozjE7IPjlLsF3zxtA
         EU/AgwF8rRfHR4O/sTENanwrnoQtCO8sxz9diGUC9XZhkjhF2pvM8jyo/GP2fLjN1Hgh
         rHiH99L7zykhsv1YanF83vr+z480xq9D+fv+l9TCO2yD8CYd51ej+ctYMksEI1ILfaaM
         fY0Tm//mHkFbDLXL4L4X8p/x0Z335twp3C5W67skCyB/octNjkneMofYVuupPKpDtqfJ
         HFk6xC7qlOAYGQKtvUL3gGBcxOYC75CpOXPgA2Cxgh+kQcnZ2x8EyOpEZmNly4U6n5tg
         IP4Q==
X-Forwarded-Encrypted: i=1; AKwUvBx4KDPQDcWPBnsABjwR1WslHyV5NZpnwOryJhvHaZueO8UyFdeUYwZ7/hL8FjGbuxOvm5qJDg==@lists.infradead.org
X-Gm-Message-State: AFq9FYJE8fxbqX+ZrSAkpSX8oME629OCb1FDEkOSVlt4bpgvh9QVMjui
	Eo1kNevH86U4cBLdy5/3ouf1eI/42frxOTYTbooaHN90292oTDZ1KXHp
X-Gm-Gg: AYBFou1OCdqDS6ZdZ5p6c2+tyhZa10O5k4SO+W2eI1JG6S58k5vSOnMCnw9hQhcGFZX
	MEqd0kQPb74/vZ8HEz7pIuiKWI8zF0Cm2WvkMZZx5cQ7XpNPUm4IrRVCDj2a6bfbva9VwDyeWvD
	3vDftutBi5dxchVbXikEeSau6W96mkO24TCLWI6MXlbSIKowGMYTPKnncAM3mN4RHBxmm3MRve+
	Ip+OjnWiGS1kQq1oxjmbz4+6BYa6nI2blBIypc2wEE2o+7/r9fh/gk0Iun7tlmrCv8b2QVuYMdw
	5H6y+cV8V8/G1WNGx1flbSjMp6EZkIhSvXmAjKm2FquS72vjfoA4oPGGzb8NGueiNOS+AJxoSZ+
	pwSNdSbn0hykjKGTBB7dfeYbfcGW7iCk188mMFT8JKDoqgSTMExBAcInsbjpLBOJx35bguvaatS
	p3rmbpWodJbgSVf2R/rCFgAkH6Yjq8rofvrKF2XG5hZEDJpX3sP5RWJvUuDg3Pids46/iC1XyF/
	LD9v+u7E+drkXMIuhXpdw==
X-Received: by 2002:a17:90a:d44d:b0:3a4:b0f3:6597 with SMTP id 98e67ed59e1d1-3ab39fea5c6mr19481452a91.0.1792120152572;
        Thu, 15 Oct 2026 20:09:12 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd3cc73c7sm370085a91.4.2026.10.15.20.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 20:09:11 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: robh@kernel.org,
	baoquan.he@linux.dev,
	rppt@kernel.org,
	m.szyprowski@samsung.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	saravanak@kernel.org,
	akpm@linux-foundation.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	iommu@lists.linux.dev
Subject: [PATCH v8 0/8] kdump: reduce vmcore size and capture time
Date: Fri, 16 Oct 2026 11:08:47 +0800
Message-ID: <20261016030855.4062882-1-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261015_200916_444902_506DC848 
X-CRM114-Status: GOOD (  18.42  )
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

ACPI systems already filter reserved memory out of the vmcore through
their existing path: firmware reports those carveouts as unusable in
the EFI memory map, they get MEMBLOCK_NOMAP set in memblock.memory
(is_usable_memory(), efi-init.c), and the ELF header builder has
always skipped nomap regions; only DT-based systems currently fail
to filter these regions, which is what this series addresses.

This series introduces a MEMBLOCK_NODUMP flag (suggested by Rob) in
memblock to filter reserved memory on DT-based architectures. A new
flag is needed because MEMBLOCK_NOMAP can only express regions without
a linear mapping, while MEMBLOCK_NODUMP can filter regions that are
linearly mapped. Reserved regions are marked MEMBLOCK_NODUMP by default
so kdump omits them; reusable CMA regions are different because their
pages are handed back to the buddy allocator and may carry crash-relevant
data.

Since the reserved memory regions are filtered out, the vmcore is
smaller in size and faster to produce.

The series is based on linux-next and is organized as follows:

Patches 1-3: Preparation and bugfixes: switch riscv crash_mem to
             memblock, fold the duplicated per-arch memblock walks
             into the weak defaults, and serialize crash header
             preparation against memory hotplug.
Patches 4-7: NODUMP infrastructure: switch crash_core to
             for_each_mem_region(), introduce the MEMBLOCK_NODUMP
             flag, add a dumpable flag to struct reserved_mem, and
             mark /reserved-memory entries with MEMBLOCK_NODUMP.
Patch 8:     Skip MEMBLOCK_NODUMP regions when building the vmcore
             ELF header.

v6 --> v8 (v7 mainly tried to fix the initrd issue on release in v6,
that approach is superseded here):

1. Stop marking /memreserve/ regions with NODUMP. v6 marked
   /memreserve/ regions with NODUMP. But a bootloader may specify
   a /memreserve/ entry for memory that the kernel later frees
   (e.g. the initrd), and those pages would then be wrongly
   filtered out of the vmcore after being reused as normal memory.
   The v7 fix (clearing the flag in free_reserved_area()) caused
   a lockless runtime mutation of memblock.memory [1]. Better solutions
   exist but need extra preparation, so they are left out to keep
   this series simple in v8.

2. Fix a build failure in patch 2 with both ARCH_KEEP_MEMBLOCK and
   MEMORY_HOTPLUG are unset. There the memblock arrays live in
   .init.data, and the weak defaults referencing them create section
   mismatches, which turn into build errors when SECTION_MISMATCH_WARN_ONLY
   is also unset.

3. RISCV recently gained crash hotplug support, so adapt its handler
   like x86 in patch 3: use __crash_prepare_headers() instead of
   crash_prepare_headers() to avoid self-deadlock.

4. Update the cover letter per review feedback: describe how ACPI
   systems filter reserved memory and why a new flag is needed
   instead of reusing NOMAP.

Every patch in this series now carries an Acked-by or Reviewed-by tag.
Patches 2 and 3 have changed since v6, but the changes (a build fix and
a riscv hotplug adaptation) do not alter the logic the tags were given
for, so their tags are kept. If any tag should not be carried, please
let me know and I will drop it.


v6 --> v7:
1. Fix a stale MEMBLOCK_NODUMP flag issue [2]. Memory reserved and
   marked as NODUMP may later be freed (the initrd, for example),
   so the NODUMP flag must be cleared accordingly. Since the fix is
   part of the NODUMP infrastructure introduced by patch 5, it has
   been folded into that patch.
2. Drop the "generic" related description in the cover letter.
3. Collect the Acked-by and Reviewed-by tags received during the v6
   review (thanks to Baoquan, Mike, Rob and Marek). Patch 5 is the
   only one without a tag, as its Reviewed-by was dropped when the
   fix was folded in.
4. Drop patch 1 of v6, which has been merged separately.


v5 --> v6:
1. Serialize crash header preparation against memory hotplug to avoid
   out-of-bounds or use-after-free issues.
2. MEMBLOCK_NODUMP marking is now done after memblock allows resizing,
   avoiding a panic from too few regions before resize is permitted.
3. Reordered the patches, put pre-existing bugfixes earlier in the series.

[1] https://lore.kernel.org/lkml/20260922090252.B01541F000FF@smtp.kernel.org/
[2] https://sashiko.dev/#/message/20260917220750.GA4013814-robh%40kernel.org

v5: https://lore.kernel.org/lkml/20260806093519.2907771-1-chenwandun1@gmail.com/
v4: https://lore.kernel.org/lkml/20260630074715.4126796-1-chenwandun1@gmail.com/


Wandun Chen (8):
  riscv: build crash_mem ranges from memblock instead of resource tree
  crash_core: fold duplicated memblock arch hooks into the weak default
  crash_core: serialize crash header preparation against hotplug
  crash_core: replace for_each_mem_range() with for_each_mem_region()
  memblock: introduce MEMBLOCK_NODUMP flag
  of: reserved_mem: add dumpable flag to opt-in vmcore
  of: reserved_mem: mark /reserved-memory entries with MEMBLOCK_NODUMP
  crash_core: skip MEMBLOCK_NODUMP regions when building vmcore ELF
    header

 arch/arm64/kernel/machine_kexec_file.c     | 29 ------------
 arch/loongarch/kernel/machine_kexec_file.c | 27 -----------
 arch/riscv/Kconfig                         |  2 +-
 arch/riscv/kernel/crash.c                  |  2 +-
 arch/riscv/kernel/machine_kexec_file.c     | 33 --------------
 arch/x86/kernel/crash.c                    |  2 +-
 drivers/of/fdt.c                           |  1 +
 drivers/of/of_private.h                    |  1 +
 drivers/of/of_reserved_mem.c               | 15 ++++++
 include/linux/crash_core.h                 |  2 +
 include/linux/memblock.h                   |  9 ++++
 include/linux/of_reserved_mem.h            |  1 +
 kernel/crash_core.c                        | 53 +++++++++++++++++++++-
 kernel/dma/contiguous.c                    |  1 +
 mm/memblock.c                              | 16 +++++++
 15 files changed, 100 insertions(+), 94 deletions(-)

-- 
2.43.0


