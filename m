Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE52CCCA462
	for <kexec@archiver.kernel.org>; Fri, 16 Oct 2026 06:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=X/NJsqoDw9kAgUv61Xlf8FJQUfxWPDelOgkY9LP+DeM=; b=z4WkOpk/Ji79Jsj/9HS1KiOq9k
	7U7sy/QIaFLiJPPn3m2525Hg18wH4W9AbJKEs/QAcKAHti6EE21ym4bpPdUvH2j0QZBGvRaJjSwfr
	Z+9E+BfCdM6fnHuR9dVn+5AtH1elfc1rv6DN0M6dTOXWSr7Ry2/jbPO0QS3SC3LY9YXBvt/IJgR9Y
	bWm8seovX4SpbSLubSjxJAbSKfd7FU5bW+Ku8VF8DwcvxvW25njZBkjFsD0l/6daMtTZKeek3r0BQ
	LiccmXerhbAgu+rNhrvdfs/g2Izq03oYjAxq+jQ+Rp51erbVspuK2yJT7K9dkQOp5CU74OY3BChyT
	vAGxSbcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHbEj-0000000254f-3fw4;
	Fri, 16 Oct 2026 06:16:13 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHbEi-0000000253v-3KTh
	for kexec@bombadil.infradead.org;
	Fri, 16 Oct 2026 06:16:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=X/NJsqoDw9kAgUv61Xlf8FJQUfxWPDelOgkY9LP+DeM=; b=PBCAJDSUTC/0Zaj+oH6J5tYsYM
	WqCIC0eG7AiCEAhMCx/8FqcZ886ARnB/lU9mJeTIdEIQypqn2xA/BOrCDg4nFr2yJW/7NFjEEwatH
	NmOmsS0LoD8RVTr6GAWxiqmPdijifzE6Sg8jFJOssHBODWOJTlIfxAd99/LDdEhcKivbY7thhMofX
	qr8UCmYwjXKy9DrR3q64Xme0Y4ofYQNKyVYoQaQrPoro8xy/G1xbD10p9kdnH8L3KR3ItgWC5GGaX
	4I8SWVfH8ytiGjwmH7VolOR8z/KX4eFdzVZzhby00J2WsK3P8ffYEwJqsSALnpUc1Ed3GB7GTPoNn
	PXlY2uNA==;
Received: from mail-pz2-x0a.google.com ([2607:f8b0:4864:3b::a])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xHbEe-000000019Yq-24gw
	for kexec@lists.infradead.org;
	Fri, 16 Oct 2026 06:16:11 +0000
Received: by mail-pz2-x0a.google.com with SMTP id 41be03b00d2f7-ccb794ce92fso507420a12.1
        for <kexec@lists.infradead.org>; Thu, 15 Oct 2026 23:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792131366; x=1792736166; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X/NJsqoDw9kAgUv61Xlf8FJQUfxWPDelOgkY9LP+DeM=;
        b=otxZCDoccm47mjJtx+dinBu8V96G5xI144ZoAp5iCRnIBMAgU+kGhhcJza3lSrC5Oo
         XrhUfuXbn7F4V2RzNV0wFHSpJnqE0LusE4rxlSibF98JNtLNZ1/D/B9MDw9MPbP+X54U
         y22WgZg+cS2unBbf05+CrIsCmXvkxnw7woxnrMeIUY9KheVePHIoPwcKXjkDppodChGr
         AUsH8KeMdbaPc7SJyH+9jfl8nBJ5QRKH7hVMHm3CL99aB/AjkkeJ94i36xFSBfiyz9jt
         e+Otahb7utPW2VQKXPtxJ07GHneNaS6qiYtrZt+RcDV1MZOwncAARLry3zC5wJjAZw5Y
         xQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792131366; x=1792736166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X/NJsqoDw9kAgUv61Xlf8FJQUfxWPDelOgkY9LP+DeM=;
        b=C/YMUub2SEHrKeeIeqwuosnU2WpXJCrF1j+6NqS3UHy8w5F+44ft2fdeAv24FR8Fgt
         P67CjTg6g/tGV2pxyPl2l7mZ2z7ZZDoyBdWyNsbP2s5soR5yyrT+iUgK8zK157sFnqWa
         eg4bQx0xIAckhUFoD5K/dI/oLiKifr4rmW+OEkSsBkq+ZJwvmq70WuoOCMdFEmNJHe9v
         DKI5d+bHCUoj5f3pADQstcAs47hZYby1l6ag9Uh1zVY591HliEY1BAMQ5Hxskbh1xfEO
         TZnTj1yw4Wty9Xc6Y8885dftWyapMSFm7fHY/5NgQx+L4tsJOhwALynJcXLnBwc7mh2H
         8W7Q==
X-Forwarded-Encrypted: i=1; AKwUvBw13LjSSSnysMMWevsL761MeVLRp6bV3l9/YV+U1RmSpxqvJJrMFva6XgdMvPyNs2eVTkSQdw==@lists.infradead.org
X-Gm-Message-State: AFq9FYLYqe9H/ryZzkZ0L8eAynMo6xLqQOjqZEgZ4z0Fr1utdzmTp1PK
	prOR2Ww7f2GgLwpqfSE5HtfcGyWAgkEgGzD28BrUBH2zgeSYk0zI90wN
X-Gm-Gg: AYBFou0f/7RnS5B2z6lGLDbInj4HdyQiUqAoYb1mtJ5bWDTAKq9yk4wezzLrgU8JRRr
	fTG/xdJxyeOIoMv1LAAQZ2VUfTYiQM2wBowPyxTLAXBjszflOMnPv1kI2ND1cH9KObRCnrC6+qO
	IorbcFe22Izy0RRd3qtvo70mlUnYbjcXaNyiu1B4A06I743i0pCsA/I/KPXlINDPpwtUiNBH64e
	EhjBldZZ/oXwKQ8FjD38NTjM2XJTp9gjEjR3fq8ncuR2zXAbRCoN5DVgzTiGGkrmzxj40sMEN73
	gOROri5Pi6zVkr8fGJjuw//K4q2iEqZCcZDrTIcm0mzFMN4NlgB4LO0nvVrSg1kpXgRpnLf0OMj
	2HNpMMDwtQtL7NODgGN2MpWAV4agl3eCk+JZQr6jGgDXmqzL0gzyGnNXMgbJDwKJVzwYc9UUoAg
	6cZqVEl6dC4KE626XTswMngNwU3rJn8d1SQQW6ey8s/4bfcHdUNlQX18wX9ZjW0+9Cl621rrsLx
	TEx1yskLOw=
X-Received: by 2002:a05:6a00:c494:b0:89c:d875:602a with SMTP id d2e1a72fcca58-89cd8756af1mr6506797b3a.11.1792131366058;
        Thu, 15 Oct 2026 23:16:06 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f57b334e6sm586375b3a.42.2026.10.15.23.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 23:16:05 -0700 (PDT)
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
Subject: [RESEND PATCH v8 0/8] kdump: reduce vmcore size and capture time
Date: Fri, 16 Oct 2026 14:15:41 +0800
Message-ID: <20261016061549.4181390-1-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261016_071609_094664_DE314F58 
X-CRM114-Status: GOOD (  19.96  )
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
   exist but need extra preparation, so temporarily dropped the patch
   that introduced the problem to keep this series simple in v8.

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


