Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7558AC61DFD
	for <kexec@archiver.kernel.org>; Wed,  2 Sep 2026 07:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cEYvUbaRHsvrLqexK6TwRNN/GB2ra0YD4DknJvJHsJI=; b=KdSNyOe6f563nL27P7PUxBamQy
	vEGDQ0xneCxnkk3fb8a2GHSmWkdUMBNOE0MSVdNqZwhy/Qvu4y/EwVdaZo/w6tpzfW8UeR0Zk4R/R
	0pF3iH56bwSCzRrVYbZlQiUlGFdkQGDVxFno1Opj4bDTD7LA2TJL9rVFThw+uxuLxiBWwVQISr8wn
	YX/awZGGn1glMVxpxTb6rNXvTpNtMQuGTNgFzgMDQWG8M0gyBlcZvxvHrKY+LVO2VJNdBKDHVPCF3
	tpyWJYSmy8/YW5VsHWBPbSK3om/GhIsXKmSgVxU4H982ZlWY2kzQxWd6C1KyTYJTjbcocNPyr6ngx
	x+juDxYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1fS2-0000000DvrF-0HIB;
	Wed, 02 Sep 2026 07:32:06 +0000
Received: from mail-pz2-x02.google.com ([2607:f8b0:4864:3b::2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1fRw-0000000Dvn2-1As1
	for kexec@lists.infradead.org;
	Wed, 02 Sep 2026 07:32:01 +0000
Received: by mail-pz2-x02.google.com with SMTP id 41be03b00d2f7-cc1c753b1bbso175893a12.1
        for <kexec@lists.infradead.org>; Wed, 02 Sep 2026 00:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788334319; x=1788939119; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cEYvUbaRHsvrLqexK6TwRNN/GB2ra0YD4DknJvJHsJI=;
        b=kKByqb/82Y7lmTn1wzhDT7qiQQmSkXEQXhvc2XIQ5BZHkc4KpXEmUUFjmw3aCEFhyq
         wjO5II/otHDeXnfqV6Cw0hhsRzOX95LmXXTAdjTh/x3nBZdZxdkNfOTDTzbxSYGPo5ZN
         L4Z7Oc8mhSjURkjit8KcT0IB7EqU9jx2IbXQg3wXoE6+iyiCFSyyyZ7bY2GauKOyNiWP
         Y8XtE1xGDc+X2WYb4n3FHoOirkePeDfHbKvKunykWxcQOMPTBBGhc9zgMlJRO6PsEzG9
         f6HYK6QL+56mtPJFg8MakK04gzv314c6szwA+PkIg92XIi3ZSSxqX4YPErucOBhJJKw3
         nUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788334319; x=1788939119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cEYvUbaRHsvrLqexK6TwRNN/GB2ra0YD4DknJvJHsJI=;
        b=amVLh6EGMwAf1BZf24GMp/5uad0x+R77izDdsDZrqaTVGo/dI1bSmVpqC0gTX5YWnv
         pAzYHi2iFIbGhmrtyHC9Gr1Nj5k4EAxnwyN2CeuAKCQsZsYWuREsb0VsTRX9qgqWoCq4
         Uvo3dd2mREXaoUmHR2Epygi+0ShpY8VwkhSaXGXYdyPbfjcGX4HQ7M2BJOh1yJF2uWTc
         812ak4//Nm4H7ASWjpGjNrcr9vc/lJpDasBKv9MhDg/anrp5ty/dTky/1fDoF2AO4ZU8
         Qrl4mFD+dLDnoxZaagLldhPgf4yJT5Bb9EfK5wN5kbiJS/bgE6nxVPMb57DOLsin+ysT
         y3Zg==
X-Forwarded-Encrypted: i=1; AKwUvBwnd+C8/KeZraKYLeCVO5DrcRDR1v/I8x4+uuQhsgJjWWtxt93ySdxAE3eDOWKXF5c5CFG7BQ==@lists.infradead.org
X-Gm-Message-State: AFuF++k1tbQZy5djPak/mYM6sWF3UbLwdjHtbH/1nALpLIhq42BSPZgY
	EneZp7JBkaDtQt2tlnygjomNV+eDZV2JeMhu+5udlhK4Ki/E9nd8eDm+
X-Gm-Gg: AYBFou2Xjnmt0BvMqbkatJfss9/QwWlmVAHnyVNtygV8m5EHYDgcIvywKxrGqUJYOFA
	9g7kJItWeGjUlTs4bOpqrBMnIvjw+Vv2ypmdEOzFQom8LuH9gXzoZi6SFavcn5W6+WNAcnRwzA/
	p41n1oUyHHh6A6PbhAf5L1QITDUeGMggGxDTxLdulE5h3+Dzo0+oZ9Q59Xaw094xlbT6J47GSYd
	GeIqrFD2PnCNNaU9SoNOcZcgqBiEx/2rIaeJLn2BREhScIaAdrU1Xro31LvtYpUzA46wiCYKJec
	a4pnsuylTZKCweK/0A+JT5dLN13lSd7bbj27k2MTo/3PsOM3IZ92vGxXCBnFoXElEJEm1DadGzB
	4th+SyIpCDiY+SpgK5JzLKXgqjs4qhAVUyUXOSdZILKWrhWV5+xrSwG97dUOVkcCpLUUpTih9Hm
	4o7+X0RoJ/8z8ZMywokJNA9FOicfOy8KtxfLyvtxYI0+EeOjl4pUZOBFO8IHMgm/dupOj8UPR4
X-Received: by 2002:a05:6a00:4188:b0:857:7384:b5fc with SMTP id d2e1a72fcca58-85ed4d137e7mr5136737b3a.24.1788334319386;
        Wed, 02 Sep 2026 00:31:59 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85db2adcbedsm926914b3a.20.2026.09.02.00.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 00:31:58 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	robh@kernel.org,
	saravanak@kernel.org,
	akpm@linux-foundation.org,
	baoquan.he@linux.dev,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	m.szyprowski@samsung.com
Cc: mark.rutland@arm.com,
	kernel@xen0n.name,
	alex@ghiti.fr,
	hpa@zytor.com,
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
Subject: [PATCH v6 02/10] riscv: build crash_mem ranges from memblock instead of resource tree
Date: Wed,  2 Sep 2026 15:31:08 +0800
Message-ID: <20260902073116.802752-3-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902073116.802752-1-chenwandun1@gmail.com>
References: <20260902073116.802752-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_003200_351725_DF18A65E 
X-CRM114-Status: GOOD (  12.38  )
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

Replace walk_system_ram_res() with for_each_mem_range(). A later patch
introduces MEMBLOCK_NODUMP in memblock, the reserved-memory regions
marked with MEMBLOCK_NODUMP can be excluded from the vmcore by walking
memblock.

for_each_mem_range() iterates memblock.memory, which is freed after
init unless ARCH_KEEP_MEMBLOCK is selected. riscv needs ARCH_KEEP_MEMBLOCK
to filter reserved memory from the vmcore, so extend its condition
(ACPI || KEXEC) with CRASH_DUMP. arm64 and loongarch already select
ARCH_KEEP_MEMBLOCK unconditionally.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
---
 arch/riscv/Kconfig                     |  2 +-
 arch/riscv/kernel/machine_kexec_file.c | 31 ++++++++++----------------
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d6c2dbf8455c..1de14a2d5aba 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -58,7 +58,7 @@ config RISCV
 	select ARCH_HAS_UBSAN
 	select ARCH_HAS_VDSO_ARCH_DATA
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
-	select ARCH_KEEP_MEMBLOCK if ACPI || KEXEC
+	select ARCH_KEEP_MEMBLOCK if ACPI || KEXEC || CRASH_DUMP
 	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE	if 64BIT && MMU
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
index 26cd2a8bd0cd..808e872f4063 100644
--- a/arch/riscv/kernel/machine_kexec_file.c
+++ b/arch/riscv/kernel/machine_kexec_file.c
@@ -37,39 +37,32 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 }
 
 #ifdef CONFIG_CRASH_DUMP
-static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
-{
-	unsigned int *nr_ranges = arg;
-
-	(*nr_ranges)++;
-	return 0;
-}
-
 unsigned int arch_get_system_nr_ranges(void)
 {
 	unsigned int nr_ranges = 2 + crashk_cma_cnt; /* For exclusion of crashkernel region */
+	u64 i;
+	phys_addr_t start, end;
 
-	walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);
+	for_each_mem_range(i, &start, &end)
+		nr_ranges++;
 
 	return nr_ranges;
 }
 
-static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
+int arch_crash_populate_cmem(struct crash_mem *cmem)
 {
-	struct crash_mem *cmem = arg;
+	u64 i;
+	phys_addr_t start, end;
 
-	cmem->ranges[cmem->nr_ranges].start = res->start;
-	cmem->ranges[cmem->nr_ranges].end = res->end;
-	cmem->nr_ranges++;
+	for_each_mem_range(i, &start, &end) {
+		cmem->ranges[cmem->nr_ranges].start = start;
+		cmem->ranges[cmem->nr_ranges].end = end - 1;
+		cmem->nr_ranges++;
+	}
 
 	return 0;
 }
 
-int arch_crash_populate_cmem(struct crash_mem *cmem)
-{
-	return walk_system_ram_res(0, -1, cmem, prepare_elf64_ram_headers_callback);
-}
-
 static char *setup_kdump_cmdline(struct kimage *image, char *cmdline,
 				 unsigned long cmdline_len)
 {
-- 
2.43.0


