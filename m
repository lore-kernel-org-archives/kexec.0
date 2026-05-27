Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB36CD5BD1
	for <kexec@archiver.kernel.org>; Wed, 27 May 2026 03:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NK9+MAufae3OUHglq3BxF1m5jq3s3djB2nPaLW09hjI=; b=p1MFo8CCGQUQoxB7+jIdQhdG8B
	8UkUiXBX58voC3DXdb956iU1+4tciX0g3k80kzDuZsSblvfhQoI0fOVbdYUlqNzNLm2r/Ns5otvk2
	Jo1QlgI9hlSfDbvbWCbzpE7bBSUYI8A7iAPlHngyy9I0IbI1ZJnIanldl/8g4DDPGYocIO4bEX9kh
	N/mVHfbP6sT328d6sSOJh1ii/suC2jztALcP1pfEDH9vy8IMnME3VtLzbPfuSWo5Srw/fryuu2w94
	Vb5SCIj7YyFDzuC9f8poeGMWYSsRLpXEZAQjTQF7k5dfdud1/vxA1W+HmffBIMs6TraP5G+ARYzBn
	X2ESfrxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS4xd-00000003ENU-3Yjz;
	Wed, 27 May 2026 03:29:37 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS4xZ-00000003ELM-0G26
	for kexec@lists.infradead.org;
	Wed, 27 May 2026 03:29:36 +0000
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-82f8893bff3so5229064b3a.2
        for <kexec@lists.infradead.org>; Tue, 26 May 2026 20:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779852571; x=1780457371; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NK9+MAufae3OUHglq3BxF1m5jq3s3djB2nPaLW09hjI=;
        b=UwIUK1Jf9KWd+hU9vNM0qasrmwN6p8i9ixv2ur6xwQBUXcnHBW/r1zIDQnNuFCCsrE
         vTxoXumSv0jdt5RBtlU52tg9sWdSmd92vKZPFRjkG07aiIOLzLxUcHYQcXvzfofS3lD4
         Fqmn72taG9nvyoe2OWJO0UjtKxhmx9fZ3ResVDGFoBebvCBWPZeDj+/SwnSu7/S8b5Nk
         rwz+pttkBXiVpnvbg+IueZrBIHLgtsQUlMqIQvaueuSYAX38dimUbZGK88zbxIKe/mI4
         49DPSHIUGjV6ohmeEJ4luFdfgfdoz17OcZA2n5NZZifmwTye6gsHa6Rx+SebgIPkMRV9
         ZF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779852571; x=1780457371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NK9+MAufae3OUHglq3BxF1m5jq3s3djB2nPaLW09hjI=;
        b=XTjDWeWBrLklEw5EdkMl7AMTqUUd2Wh9vo3fKPz2V1FiINaxaw8nbc9SpWqmtTABnj
         JuUJqwwrWkeKpqqYk5axtMVkh0VYgsxNwGEwoKZQeEZgp3eK4lCeDdUc4nU46zYxldw6
         LPTeqbnjkPgR2+gszqn334i2zTGJV7fDv1Ik34VzrT5uKH+CVeriFFj8fr5a/9fSf/SS
         5juipW9YFZCB1eogofhZggib2azcCldC9/aule/45g0hqfm5C0RDaeLnvj2ObcCIhBmh
         APiXhopV4tBIOHXjpVofydbA2GOlmEbR6bhvCaWr1u6EtvK2LTWCVEvY0cQKhNDxp9cn
         DE8Q==
X-Forwarded-Encrypted: i=1; AFNElJ99g1N6GU8EvLOUgpeJwWXFfP4ilZak5lYS4wVbTe0Ny9pFcaAmibDJtSw0tqE79u2q5HZ8IA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy8Mo2MEwpEphMbKaceWP1YLc8yAuNC0zuTd+KPcfwaNkfRyac5
	q4mk+7Y0h7kV60k1KoUiC63A9vDo968GX5yjvM/b+sI3xshrUGyfkHrT
X-Gm-Gg: Acq92OGPopp1xdlKyHB2hUBxlNJyVCR5th/c0wLOHtLGulnjhtKmsVTNpGDQwBverX1
	ITmv6Fv1eE5tXIvmjoDPKPkoHPa5x/TyEgI/m+AV84NDohodoyLO6A378f9EYI3gtZTAVxcA3+k
	9T1VdnsB83Ft9M8aSdH7cTbVOEEPihEYNP2SRO01r8mcHCo27aWIQ/K6++4s3/5b3SbnCV14N4Z
	hRf59snuetK2MTc0y7cBJGFWFvXd8vXlhtRjeoaMyrM4xTdWPHVHvVfVKQnHTl94LBR0tBtgqtA
	fsazyLEEAS1ilj+OhLpeOB7QoyQa6W0cfujhtaLf3uyWO2QHi9SFxyy/RAuY6zLj8TqGDSlCYfi
	AD6DSXTf9dwmYJBZbOui79krmHvk2qkRaGdoLyVDitacgM6gtELBZBGftQL3Ut6NsjEhfoYwcwC
	r2J2CD5dRJFQ1h+Lo5l0uLD7aYJVj6qYrCA8aR998wTZFHF7U=
X-Received: by 2002:a05:6a00:4f94:b0:82c:6da7:2d3d with SMTP id d2e1a72fcca58-8415f3d0e36mr19286959b3a.11.1779852571354;
        Tue, 26 May 2026 20:29:31 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d7307596sm749688b3a.59.2026.05.26.20.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 20:29:30 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	iommu@lists.linux.dev,
	zhaomeijing@lixiang.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	robh@kernel.org,
	saravanak@kernel.org,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	quic_obabatun@quicinc.com
Subject: [PATCH v3 00/11] kdump: reduce vmcore size and capture time
Date: Wed, 27 May 2026 11:29:06 +0800
Message-ID: <20260527032917.3385849-1-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260526_202933_095595_56135EF2 
X-CRM114-Status: GOOD (  11.80  )
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

The series is organized as follows:
Patches 1-3: Pre-existing fixes and a small prep change.
Patches 4-5: Restructure to allow appending /memreserve/ entries.
Patches 6-7: Add a dumpable flag and append /memreserve/ entries.
Patch 8: Add generic kdump helpers.
Patches 9-11: Wire the helpers into arm64, riscv and loongarch kdump
              elfcorehdr preparation.

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

Wandun Chen (11):
  of: reserved_mem: handle NULL name in of_reserved_mem_lookup()
  kexec/crash: provide crash_exclude_mem_range() stub when
    CONFIG_CRASH_DUMP=n
  of: reserved_mem: avoid post-init UAF when alloc_reserved_mem_array()
    fails
  of: reserved_mem: zero total_reserved_mem_cnt if no valid
    /reserved-memory entry
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
 drivers/of/fdt.c                           |  11 +-
 drivers/of/of_private.h                    |   3 +
 drivers/of/of_reserved_mem.c               | 117 +++++++++++++++++++--
 include/linux/crash_core.h                 |   6 ++
 include/linux/of_reserved_mem.h            |  15 +++
 kernel/dma/contiguous.c                    |   1 +
 9 files changed, 157 insertions(+), 12 deletions(-)

-- 
2.43.0


