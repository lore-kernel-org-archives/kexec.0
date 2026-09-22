Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5AC9C982FF
	for <kexec@archiver.kernel.org>; Tue, 22 Sep 2026 08:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9UsbLRFUse88WvBnvQ2Q7a6jE7KnWiu4inPojM0/Ln8=; b=fC637GTOQVJzJmD6c/gNkswsaD
	/Q5Ghnj46ZiZcerLnsUmkj+xRC0Njkg9HuyZJ1syFpiz77nHzqXou6p8986YJ+G1iO7HtvsgHnMw1
	sMwrjZb5U5J1OXpWoEc5AX679+rrqBU7X+gx0qb/zvBs/DE1vR+ZkSKrqvCwR7sdMiZdyhcVH55NY
	/cQxl1+4qTVKuCkobWJ1elo35/mD5sHp3lL/O8GqT2gQ6fJEsGkszcHNxpLgwBqOXZE44NvSQ+Y17
	0k2cUP2Fk8jTh+OV2XmYWDExwCrDn0p6MjiYpu3yZgWSqPbXCddjgN2xHQ1PLeggdg5krH/VzC7BX
	35bVBSrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8w5v-00000004iQ9-3bMZ;
	Tue, 22 Sep 2026 08:43:19 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8w5t-00000004iPU-3GEd
	for kexec@bombadil.infradead.org;
	Tue, 22 Sep 2026 08:43:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=9UsbLRFUse88WvBnvQ2Q7a6jE7KnWiu4inPojM0/Ln8=; b=JCEcj4oUBB39lufBkOjPhM1BjO
	JUv38CpTwn6NRnPVYZwluPoklgbKUNIup5hZknCrbeFIxoMdmUWhGIXd7WfIHxEid0CUZxP4gzVX4
	0qbMJ8KkyPx8RkLaO+POYXSRVklkWTf3OUQcp6P9sg9zO5xfjg3YfAyJMsQrj6FeTfDhXMr9mz1dH
	Ud6Ngvt5zYh7NpDUsutmGBYV/i03XZSOwyX09/oZPc2mmWYuHDo5WvkUbZdI7wWxEy1RuPm/dkM8/
	ucsNUXtqtwqLDalmLeySaA05YB1nRN48QTEptrVgUHl8mkl3BFgJc5+ewp/B/DQ4VKSV0E+Drlgac
	bdIWE0dQ==;
Received: from mail-pj2-x00.google.com ([2607:f8b0:4864:39::])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x8w5q-0000000DHQd-1XwU
	for kexec@lists.infradead.org;
	Tue, 22 Sep 2026 08:43:16 +0000
Received: by mail-pj2-x00.google.com with SMTP id 98e67ed59e1d1-39e59dca659so2355030a91.1
        for <kexec@lists.infradead.org>; Tue, 22 Sep 2026 01:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790066592; x=1790671392; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9UsbLRFUse88WvBnvQ2Q7a6jE7KnWiu4inPojM0/Ln8=;
        b=VLO8y52RCC748YAmeZT42k8M5hwtPEZIE+n61WcUUKzVANlRp8iKyutXDlADfqmE/M
         8bz3da1K5uzM81Wsj9p96O92STc7yPEfP95bXFG4qy+iZx45eUdj+/CdCE0QEaK5Ufpw
         s7wCof01iRezGMNMO5kMqvR9KFxibxmCUzyLRN0909pUXru1uERDCkDSfGqmyLsQgz+E
         0xwSGKDZTzFuR1aK8QKCRaJrWz1OWbD3omGen3lOehyg3894AaQDeAM8hMRozAwsXbNn
         QOT7f6WQQ+2az5p3CYX1WB1Dbag8663LialBfkWSjI+vXzGp5TufjKbw5Rw2Rp8DGtLz
         91+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790066592; x=1790671392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9UsbLRFUse88WvBnvQ2Q7a6jE7KnWiu4inPojM0/Ln8=;
        b=UuxalEV/ZG9jH3/CMKPy0MiNEaO+sJ+0iwQfHQ1LW3/NIlTgnpEp+vWtvoUF8dWPi5
         kSsTAPQ3Fs8GROAmt8ZIwZjrc6aeBJkObcbl+yMaSZKRyFpX+mkLiCAdEIuZSM7dUINV
         E+KQZh7yBv2w++rV5LJfsFQDMCfob/gLe2FElb18dqXsLaiT/h6Bcn7RBbf11DMAxBE1
         ShuE6/uEd9eNk9WHoXdvabB/lRH3lxvcXdYONphgFGLBasjl/gkhyDrl/3YZJzYgl6ca
         3i55p0Y7mSuvBYcd5HiJeOPVtoNo/495YGWSjRUctWa/9BMGlz6oB4UnUUoyNTarozwc
         ks3A==
X-Forwarded-Encrypted: i=1; AKwUvBzYYgoSvnqTndqBD2HbWzRCHU+LG8nJZroGdFxWtAuvWpisnHztd75rbJfiDYRMlrAQ7hCm6g==@lists.infradead.org
X-Gm-Message-State: AFuF++mXmfWjsUW3Z/aogrzKFHk7ULzxhUQYDpFR+WXHUeMrUfIv7Fzd
	GtiULC59C2zql6+qiJ5hs1GgwpCF1y6Yc8Va3o/4gUY2r51qDav7hIy7
X-Gm-Gg: AYBFou1/5aqYJ/TeVulV+kqVf3ocO3k8b+UEPSIPZutDB4CQBKBo6AdzmNOaPBUg3Ej
	xtuXLHFlNCvwpmgmczgxXxXRtI6pmvSEPD+PXupTElrjmKI0OIlDqOE6cL4t/xNCNI+76xG0c/G
	b2+8c10kOuPx/WmYE4iMxfOY73lXLCEF/7zyby2xmstYW92owAV3rC68Kxhz9eiQLjsMvPHQaT5
	mx9BnBhcL70pHZVnzAc2Kd0syXO0+ytgZqfZpYgFBC+1I0IOMgnsIC3bH/hZocV9SfHgLEB8zCc
	VuLyd+BLQ19hiSEEywOxUm0J1CSzy/LMrLjtIrP6zrgVDwNO+fki20CZhspsOfwrk/nOjQA1bt1
	GtNpV0t9N5sVHTvVa78lmKbsuY2RXItkZrzyxE5QQgxnKjZrR8i9RPUkXcP2uR5vwvMidOOQJzb
	Y5PwSOlQ2EaS/05OW8t0j7V6YpBrkDJgVruDm5CnRo235+diR32j80xba8eRyunOLewd7sZRDsJ
	U/Z7t3CA+EEDC3X4KD3bw==
X-Received: by 2002:a17:90b:4cca:b0:39e:423:bb8f with SMTP id 98e67ed59e1d1-3a0730988bdmr477897a91.1.1790066591638;
        Tue, 22 Sep 2026 01:43:11 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0674a5ae4sm3670016a91.12.2026.09.22.01.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 01:43:10 -0700 (PDT)
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
Subject: [PATCH v7 0/9] kdump: reduce vmcore size and capture time
Date: Tue, 22 Sep 2026 16:42:47 +0800
Message-ID: <20260922084256.1515554-1-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_094314_527350_8CAF8E00 
X-CRM114-Status: GOOD (  15.13  )
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

This series introduces a MEMBLOCK_NODUMP flag in memblock to filter
reserved memory on DT-based architectures (arm64, riscv, loongarch).
Reserved regions are marked MEMBLOCK_NODUMP by default so kdump omits
them; reusable CMA regions are different because their pages are handed
back to the buddy allocator and may carry crash-relevant data.

ACPI systems already filter reserved memory out of the vmcore through
their existing path; only DT-based systems currently fail to filter these
regions, which is what this series addresses. The flag lives in memblock
itself rather than in a DT-only structure, so both ACPI and DT systems
can benefit from it (suggested by Rob, thanks).

Since the reserved memory regions are filtered out, the vmcore is
smaller in size and faster to produce.

The series is based on linux-next and is organized as follows:

Patches 1-3: Preparation and bugfixes: switch riscv crash_mem to memblock,
	     fold the duplicated per-arch memblock walks into the weak
             defaults, and serialize crash header preparation against
             memory hotplug.
Patches 4-8: NODUMP infrastructure: switch crash_core to
             for_each_mem_region(), introduce the MEMBLOCK_NODUMP flag,
	     add a dumpable flag to struct reserved_mem, and mark
	     /reserved-memory and /memreserve/ entries with MEMBLOCK_NODUMP
	     flag.
Patch 9:     Exclude MEMBLOCK_NODUMP regions from the vmcore ELF
             header.

v6 --> v7:
1. Fix a stale MEMBLOCK_NODUMP flag issue [1]. Memory reserved and
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


v4 --> v5:
1. Rework the mechanism around a memblock-level MEMBLOCK_NODUMP flag
   (suggested by Rob) instead of the v4 opt-in 'dumpable' flag on
   DT-only struct reserved_mem [2].
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
1. Fix out-of-bounds issue if device tree lacks /reserved-memory node.
2. Fix UAF issue when alloc_reserved_mem_array() fails.
3. Add some prepare patches.

v1 --> v2:
1. v1 added an opt-out DT property ('linux,no-dump'). Per Rob's
   feedback [3], v2 drop that property and exclude reserve memory
   by default.
2. Split some prepared patches from the original patches.
3. Address coding-style comments on patch 5 from Rob.

[1] https://sashiko.dev/#/message/20260917220750.GA4013814-robh%40kernel.org
[2] https://lore.kernel.org/lkml/20260723234126.GA3253409-robh@kernel.org/
[3] https://lore.kernel.org/lkml/20260506144542.GA2072596-robh@kernel.org/



Wandun Chen (9):
  riscv: build crash_mem ranges from memblock instead of resource tree
  crash_core: fold duplicated memblock arch hooks into the weak default
  crash_core: serialize crash header preparation against hotplug
  crash_core: replace for_each_mem_range() with for_each_mem_region()
  memblock: introduce MEMBLOCK_NODUMP flag
  of: reserved_mem: add dumpable flag to opt-in vmcore
  of: reserved_mem: mark /reserved-memory entries with MEMBLOCK_NODUMP
  of: reserved_mem: mark /memreserve/ entries as MEMBLOCK_NODUMP
  crash_core: skip MEMBLOCK_NODUMP regions when building vmcore ELF
    header

 arch/arm64/kernel/machine_kexec_file.c     | 29 ------------
 arch/loongarch/kernel/machine_kexec_file.c | 27 ------------
 arch/riscv/Kconfig                         |  2 +-
 arch/riscv/kernel/machine_kexec_file.c     | 33 --------------
 arch/x86/kernel/crash.c                    |  2 +-
 drivers/of/fdt.c                           |  2 +
 drivers/of/of_private.h                    |  2 +
 drivers/of/of_reserved_mem.c               | 48 ++++++++++++++++++++
 include/linux/crash_core.h                 |  2 +
 include/linux/memblock.h                   |  9 ++++
 include/linux/of_reserved_mem.h            |  1 +
 kernel/crash_core.c                        | 51 ++++++++++++++++++++--
 kernel/dma/contiguous.c                    |  1 +
 mm/memblock.c                              | 43 +++++++++++++++++-
 14 files changed, 155 insertions(+), 97 deletions(-)

-- 
2.43.0


