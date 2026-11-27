Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F18606A32E
	for <kexec@archiver.kernel.org>; Fri, 27 Nov 2026 09:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1vzJez0K;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wix8FG5B
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=Y/UMHkeyUCY25NbdTw5rz9oJMH9U+JYd8hruRProdo8=; b=1vzJez0KKgDAPQyeqBWW5xZfBq
	K3/UNxfXbdNbs3ryqEfJ6RLFqUM5C1smE7AXz1gFmbhU9BF5Req6NaItZQQLHCSqB8Z97QoqCVS29
	XThOuv5ePksO307ykWvBQ918qcw5TTOz/CWCiRpWvH580p6VddcrWwZl0aMICdot/7Aj2YBEj8X5p
	hd1l5gGmc0T9BZCv+Y/5Cf2dtdrwqyVdLsP4s9zTZYs3Ih50ePJN2sYz4t6U4OnUrXR6LEsLFFJvj
	xn1UFi2f4vXFL1tAd7se2zdVPHmNkkdqi6qrxYmnfGchMHkiKgzv0x7MIk5+/bVcpIAzaI79q2xGM
	SH/8ygxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWrvk-0000000FM2n-0MIq;
	Fri, 27 Nov 2026 09:07:44 +0000
Received: from mail-pj2-x0b.google.com ([2607:f8b0:4864:39::b])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWrvi-0000000FM1E-0Y7A
	for kexec@lists.infradead.org;
	Fri, 27 Nov 2026 09:07:43 +0000
Received: by mail-pj2-x0b.google.com with SMTP id 98e67ed59e1d1-3b426133d98so2052772a91.1
        for <kexec@lists.infradead.org>; Fri, 27 Nov 2026 01:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795770461; x=1796375261; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y/UMHkeyUCY25NbdTw5rz9oJMH9U+JYd8hruRProdo8=;
        b=Wix8FG5BFgZoGXuPlaZJZ14Vh2suHpndWcq9h/lCb+1AcP4t0bD8NnGSWEmqN9oxZP
         wdzrPcC+13xFOabwPUU3OlBWwNlKdSJ1pC7RIp6GKerXgQHkelmLy0w2TXZpo5RJKZQ5
         jG+RvsvpxAOP12ht+rKCFVfEeHzTzLkOLmJYTvwnnPsQ/gBQIa6woFT+iMpiP6ZSr8pH
         d3m4IpYF8wmW59r9/hGgQppg+NaUJ1eUksFY3Mnwa5joY3yLWySvVg10JLb4nlbw8E2M
         I+EcS/Ef0UVNLSxqkIOBI4PnhZHBehm1Miizby0Fn8DM5Jg0H1FMcCFkctNy7EKUxOyy
         T1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795770461; x=1796375261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y/UMHkeyUCY25NbdTw5rz9oJMH9U+JYd8hruRProdo8=;
        b=XgqTVLfdkwutfJBL9GNYSHnURuO9rS25H8pk/RkMVe7JQLNblqswasRafE4FYL2wq+
         nhLqDPWo93dVuBtqZ6mG5zLeDnAnHK9XOn4rNspwmr+DhEQsecjFpRn50Ozj+QHqviQ4
         jQsg8BNzpfiHLck9d+J5nG7rrXnhvZDwNk40RQaBchOJkeH7eC+P/aIrd1xvfokTFyi3
         vzuRaSDQOKp8btLu+kNZ2YPPJ25rL+vblIG5bZ+LLaQzRkl7OF2U2dN9rR/fAnVPnHaZ
         yucO+JhL1EuOzCMZwVj+UJnO5vnwPMRakXIiTp0QSCzFKFGwUfl7BiyOdeuAcrQ2MH1Y
         qfog==
X-Forwarded-Encrypted: i=1; AL+hErEJ+IoJBTU74JtBAPHjbEPTuDW4xg3UaryemfUQgHa1Ay1rq74KkI0QZuePBTYqk2CRHmpRUA==@lists.infradead.org
X-Gm-Message-State: APuU4Z8WYRu596bIuxba5mCIU+hHFPDbgJ87ftTfPP9d3KLO7fJXeIxN
	B3SP+s8OK50Sl5epd1YtzIQX3ALPJHZG3wWi6xig+9JaD9qzJbsSRook
X-Gm-Gg: AZFdTZeh3sInSpnVcOgMZUYpsAcW5mcSd6ffLEUbmvyT6F5iRU6RB+GbLOuYAdN+LOG
	ePPJoYXLSLhdPsMuEsnVhyVFAMypfr8zLMMoK202fPpERVl7PMM7F3nsMC8ah2OXwYuK/F7Pb0t
	7Z5oygcU4w4KlRzAzMGAtMGuHJus7EsYyxaP9R2ODGAm6qnsNvCxBZXCzH0iwn12RHR63LLsTwe
	bILVcs+YbD28Rkyll71glT0+jaL0/6haS79iaHuyP3i9uH6cm/iY7s8SW6jccgIdCV5lPjAd5Ve
	ga+1QTcQlcTtQXvsECepfwHTbf4ToIclPzdpO3Sxndeo15GagW2VhQP0xYsOXXi6Dm+/A3F4qMk
	UNz0lcC2hi4G6kZn5i7KXp7aZfBFgjs/J7oRK9qhTpIIuxC5xhAjolBf+5kCg/3oclsUkTa46pk
	q9uqvUVStx6Ib8qFcwOqPJsjDABr+bxP+l52A3aACpwGwWZ5ZFDl+c03wl96OQWe8rQ3z0R1nK7
	cheWcR4lxDo1U0ooxC/MFIeBdrG9vPYTAhSv8LrWrxFvgVjpLwt62FIJ+7l/1cCaE0IIHYVHPlH
	6I2YiQTNruJDbPOYHPbgO9Kwr6C060s4SrdaTHU/aA==
X-Received: by 2002:a17:90b:5287:b0:3b0:d35d:bb86 with SMTP id 98e67ed59e1d1-3b41c8fe261mr23255612a91.15.1795770460754;
        Fri, 27 Nov 2026 01:07:40 -0800 (PST)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6d06ee37sm11718725a12.28.2026.11.27.01.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 01:07:39 -0800 (PST)
From: Wandun Chen <chenwandun1@gmail.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	robh@kernel.org,
	baoquan.he@linux.dev,
	rppt@kernel.org,
	m.szyprowski@samsung.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
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
	ruanjinjie@huawei.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	iommu@lists.linux.dev
Subject: [PATCH v10 0/8] kdump: reduce vmcore size and capture time
Date: Fri, 27 Nov 2026 17:07:15 +0800
Message-ID: <20261127090723.741253-1-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261127_010742_192825_230968B1 
X-CRM114-Status: GOOD (  14.13  )
X-Spam-Score: -1.8 (-)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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


v9 --> v10:
1. Rebased on the latest linux-next, which includes the
   reserved-memory rework.

2. Patch 7: fix two issues found by Sashiko [1], by skipping
   the NODUMP marking entirely when early reservation fail
   and clamping the marked range to page boundaries.

   The changes only tighten the conditions for marking NODUMP
   and the overall logic is unchanged, so the Acked-by and
   Reviewed-by tags are kept -- Marek, Rob, please let me know
   if you disagree and I will drop them.

3. The remaining x86-specific race in patch 3 found by Sashiko [2]
   (Xen balloon inserting a System RAM resource outside
   device_hotplug_lock) is pre-existing, and fixing it depends on
   resolving other pre-existing issues first, so it will be sent
   separately.

[1] https://sashiko.dev/#/message/sashiko-outbox-181183@kernel.org
[2] https://sashiko.dev/#/message/sashiko-outbox-181179@kernel.org

An Ack for patch 1 from the riscv maintainers is still pending:
I have pinged them, but no response yet. The Ack will be added
once received.

v8 --> v9:
1. Patch 7: Avoid a potential boot panic on SH when NODUMP marking requires
   memblock resizing before it is allowed. SH supports neither
   CONFIG_KEXEC_FILE nor CONFIG_CRASH_HOTPLUG, so skip marking when both
   are disabled.

v7: https://lore.kernel.org/lkml/20260922084256.1515554-1-chenwandun1@gmail.com/
v6: https://lore.kernel.org/lkml/20260902073116.802752-1-chenwandun1@gmail.com/
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
 drivers/of/fdt.c                           |  2 +
 drivers/of/of_private.h                    |  1 +
 drivers/of/of_reserved_mem.c               | 30 ++++++++++++
 include/linux/crash_core.h                 |  2 +
 include/linux/memblock.h                   |  9 ++++
 include/linux/of_reserved_mem.h            |  1 +
 kernel/crash_core.c                        | 53 +++++++++++++++++++++-
 kernel/dma/contiguous.c                    |  1 +
 mm/memblock.c                              | 16 +++++++
 15 files changed, 116 insertions(+), 94 deletions(-)

-- 
2.43.0


