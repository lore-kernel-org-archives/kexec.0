Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10478C982FF
	for <kexec@archiver.kernel.org>; Tue, 22 Sep 2026 08:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M1ZOEGC6NTnorBW1vtDJTTSNUXHaycEwYALUJLCTDV4=; b=E56EEtnkea/3nOw9+58irfKJ06
	GGvMZWgQefa+RDXxEy/hLQFXt9/dHPKoCceaRpvdv6ThIWhlkkuGMNUN7rbRbvQc7dSnzsEnOJ9Ds
	/SsLexYF5UBJLFvxczDHI/GpbYivHioh+OF63cEIYeTTUhdSGdl42FIV0tA40V7EYVU/8F51+U7O3
	BEIop1mYnH1cgyewt4ygjJPPmu68zHxnI6xH/S35KzKDV7q2aR2SJMV0YNjYrTSsE9Ny2STUcO39C
	M26arsCP4P0zbDlP+kO0s24D8RHNAY+N4TPhoScoeX8l1gCaPRExDMMQCOB+j0mc1dZvhIFV3Aqoq
	TCXjuJ+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8w68-00000004iVE-3ymq;
	Tue, 22 Sep 2026 08:43:32 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8w65-00000004iUN-2k6j
	for kexec@bombadil.infradead.org;
	Tue, 22 Sep 2026 08:43:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=M1ZOEGC6NTnorBW1vtDJTTSNUXHaycEwYALUJLCTDV4=; b=AdMMMYdynOVuoi86+7FHMkuMff
	cAuK76QTDurhTcz+IAu5BuKbvk9EJzXV0QwAO8UFdBRyI59LyjoVztHW8mxsJOVUOBXZmd+bVpPUS
	0w7qZTV4dmktFxjYaIeO+bPytd/MyVY9AC56o7PoI1545sIefSFUZ0TfzAbWQh/8bSuoTlVeYvFIB
	ms6btRfpqV9XoTJ8VULNWnccdD/z5kpmYGeyWs7j2w2zVzAB/8pbBKJTfDqUyglqPuJ9IpqB/OTvi
	OccJ5Hpj3japB0i3GsakazSiTYNNMyE0nTYCldJCF4NYEMZ4aqhotg8F+gnjmxengh01RImzlVjE0
	WYoJB9Mw==;
Received: from mail-pj2-x0b.google.com ([2607:f8b0:4864:39::b])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x8w61-0000000DHSq-21Li
	for kexec@lists.infradead.org;
	Tue, 22 Sep 2026 08:43:28 +0000
Received: by mail-pj2-x0b.google.com with SMTP id 98e67ed59e1d1-39569e136f9so3159373a91.0
        for <kexec@lists.infradead.org>; Tue, 22 Sep 2026 01:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790066604; x=1790671404; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M1ZOEGC6NTnorBW1vtDJTTSNUXHaycEwYALUJLCTDV4=;
        b=nziQsYpl5u2i9n6g3dU+LeYyJAE0cDsATo0lNvS9qdjhJ83NbEgk9Y/jMg/uEIeKL/
         Pe4ifGsV6RVp9EZD5dtb/JRRmfM81NiKpwQXMK5mpNHEhnLAe9+3WOmrl4X4yQfdyUkL
         moWZC7ybPKY2TDQSS18xYOQIQ8kUw2gyhSvya4kidXsQBjOb3rL4rThsFpH3JhyYDHoZ
         /6XQPVDqK8/RKQ+iI0gDu+4dD5ULec4APT742v9/m0rMogNs/OV8vf5vMNOBf1ch3OKs
         jdrD2KvxoQehLp4gzH0aqd5gJ53K2c+c8MSHVFhugCGlSczqhvQJHia0C6tGjQoNPNhL
         4pmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790066604; x=1790671404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M1ZOEGC6NTnorBW1vtDJTTSNUXHaycEwYALUJLCTDV4=;
        b=XIO+mkr01SLAyjpGdzCFOGzXQvH+SjLK8Or+s+Q2szgad3OFilujneust9qVnHd/jC
         cPay+1Ha8waOHRfdXGF4UrgIeMLgRqW2uZR7YeiLclcGk6qbUCVFR0JW453+4fROG811
         6G/vUpDlI3siz6zJeISh53r8prrwH7Byn0egfJ9yCEMRSAVUlAJ4h7EF8B9vBbyyaeGj
         rxsQeSUFqROWeX7IASWtPXPsxPqGQArxCxVAkEj0moPhJxJBFqQ8EHr4ACIwb3IWpo8s
         PNI4A2ZHcWnQZJzQkVTvO0fCh/f6QHNXH7OYoahN8HkwHtpYYfjlLLDK76O5DXwKka0X
         BBkg==
X-Forwarded-Encrypted: i=1; AKwUvBzCLbB6t9R8RBKJTF87iB2IMGMHj+bjEX7usn6JBG+DvDZrG9rCUKKdJAe09jsmbnJNZGKA2A==@lists.infradead.org
X-Gm-Message-State: AFuF++m0ZAkc8sT9OEwziG5K9MXZIrK9LGGChxk4Aje1gPjeO76LsCvz
	2k1TYrL9cgbNGiAfdxxYkfiop0BJ+yG9z95ToTdBw8+YCLfENzuS7EOv
X-Gm-Gg: AYBFou34ZpSj8nQok5pK9xWl3TA8jjYkB9XjJjUkOEZzWfnV3apWQ1D9L399q3ra6he
	mxy8o7s0SL/33fUHLeQ9dj38wuZW3RgZaKY+gxWoGBefWAAnLyndV/JPCS1URBmMmDXSXDriG1e
	C2vDWlrwXRdKJ8GKmwciW8vb6FO3DwxuTj+4YNFS+iS4oi1lFlRpROhGo1qtBvun9HGapWR4sb2
	SRSSzhBOzZp0jVZj9aMalVFQxW4b8NPCjvKjH7WzFkeCAHFvMaTeIbd62PVxt7UzXmGXOswKV2/
	dmL+0mNiGSEHE9A0Cr52bdAetC5W19/SJ+0INkdvFovcQTGsgJN2vSIxSg0Lkqvrwdex1QGeKak
	FVji9U2W1lA0y2eC2KiD/8pXWToZ3Clsx5/4lbYqKfAnFu9WTS1GF/CYfnVXrCg5POyyZJts0iB
	DlMXNoHjY5359N4SN4CLYpAbrmBk3OyHUFLgVFhAe/qT3gND6i0RZ6z7U2esb5xmO255l+dibGD
	b18PkIVzxo=
X-Received: by 2002:a17:90b:1d8c:b0:39d:f4fd:8075 with SMTP id 98e67ed59e1d1-3a073182cebmr482494a91.19.1790066603666;
        Tue, 22 Sep 2026 01:43:23 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0674a5ae4sm3670016a91.12.2026.09.22.01.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 01:43:23 -0700 (PDT)
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
Subject: [PATCH v7 1/9] riscv: build crash_mem ranges from memblock instead of resource tree
Date: Tue, 22 Sep 2026 16:42:48 +0800
Message-ID: <20260922084256.1515554-2-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922084256.1515554-1-chenwandun1@gmail.com>
References: <20260922084256.1515554-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_094326_943575_1B124166 
X-CRM114-Status: GOOD (  11.94  )
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
Acked-by: Baoquan He <baoquan.he@linux.dev>
---
 arch/riscv/Kconfig                     |  2 +-
 arch/riscv/kernel/machine_kexec_file.c | 31 ++++++++++----------------
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a590db7687c8..991657b2465f 100644
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


