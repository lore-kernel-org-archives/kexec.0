Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0285C606A31C
	for <kexec@archiver.kernel.org>; Wed, 21 Oct 2026 08:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=X+C4lcuk;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mxkMuP/U
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e9/qG3hNPJNIGpwptQDGRFtRM3jaRgB/Z0bZ0bWRF/Y=; b=X+C4lcuktHRQXnEHqawpt1CU+E
	dtz0MRlSSuVgWhVFpwRkRFigzftmpSxx9YDrhGcUBP97MhiTwIdhw6EWuhl1p5+ZM2pvAXR5CggxV
	vEj/JnH4EWWYMSqh3/Y4y2Lr6bh6vz6LiIiQ2vvKr9oPyfFri2VBaXkVr5n8Vy3tABqYOqW1PPFID
	u8ArOUUI4ngPdMJ/DoXCnuWCxJJIOF7jhysxFxTdSIGfica2gCUCgzKpXJy6ubngn+bi0zPNt9OPh
	HbPFN9VzWScIaELccNyasiWkgKnLmDpGswuVPhcVF5rBbvu7fd5h6xmhDWYi9c8Bt6jYfkkhL/OM1
	4REvJgtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJRih-0000000BMBU-0BAw;
	Wed, 21 Oct 2026 08:30:47 +0000
Received: from mail-pz2-x01.google.com ([2607:f8b0:4864:3b::1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJRie-0000000BM9z-1sGk
	for kexec@lists.infradead.org;
	Wed, 21 Oct 2026 08:30:45 +0000
Received: by mail-pz2-x01.google.com with SMTP id 41be03b00d2f7-cd63952c9f2so54346a12.1
        for <kexec@lists.infradead.org>; Wed, 21 Oct 2026 01:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792571443; x=1793176243; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e9/qG3hNPJNIGpwptQDGRFtRM3jaRgB/Z0bZ0bWRF/Y=;
        b=mxkMuP/UQTnyd6tPIhvSCP3dwPC1gb1N7zqK/+gpX/53U3H+jH1KGCG9bB6obkslUl
         aQ2+RZ7927JrPX0VdF/QgMkIRtzHNxvTLLFvVtdgooIibtPPjTssV0Ej+hBvtmv7MsKO
         r0nffS8cpcxv8ycDyg4eh4+v69Pck4r76xGCYHzmzFRV5UrPK6an0+Fvh7a9RjLJM222
         B7eUiE8E/IuTsSofOjcWUuijsCz++dvGztiNi4/THp63tFXWtPkYUUDhpDQtqZqOUsmS
         oVU/11i4b2hai4LySYCfspbOhmWpPIBYl6wWQvWYoZrgrcqO/bU7Afi6cp7vDVc4leva
         DrGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792571443; x=1793176243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e9/qG3hNPJNIGpwptQDGRFtRM3jaRgB/Z0bZ0bWRF/Y=;
        b=txs6U/HwfkEaN63FFiYEh9dJhP4K80fNN5K48fmbDZOLwjou9AQi9vE7ocI0h5OGDx
         o/ounOdPo8ZX3fdML1FpFEZzXcxuKfDcRZD1zPitUk3OuegkpYc0Oxj+0ceBHVDzv8sf
         r95Yyv/kb0QM8H0XxTvIPF0+Lf7vUVXdZeASQovMycxtCV/GymByDAsGpPMZI2dHBEyR
         6NI+4RsJUxa9DOxNnzCvBNuUI6QBZ/R7+YlRwYht57fyKghpj0AaOsfr7hhPCVP5ByOH
         CUoeJYCh8JK7cZupBI2YrYa8q97FgS3AjzPSzwRJs7+K8bRQt7hLKigJM/DWhlu0D9y2
         aZiA==
X-Forwarded-Encrypted: i=1; AKwUvBxZ5iOfuUP2oSWrM2tvs7Du2qm7Mf2BTumXfn/+CFESv+HIo8j3hq8ESzqWb/37cPhCNecLTw==@lists.infradead.org
X-Gm-Message-State: AFq9FYKN/6KrmSoHZP4Qv9+i++WqRago9HikeAh9tI7tWwchN+upWTK6
	0jnEIX9uYlIipUEOML6rA9O0D9Gu4WQdtwDknLF9xS3ISfRQwUjq05Ud
X-Gm-Gg: AYBFou1okEfhQ+4E3cNwgNdjbG1uKpZAPYwiUNMq1IFAyHAFU4GvlIoUj8GSDdLEOdN
	skcZZaUg/kVcWEbMLfz8b3wZc87sfTPY1QyaOfPCnmn1pVlgXehiQY8MSyvTZfCfP8wA3l97/3C
	fKfcd9Z1qDY2nsdrhnswW144vHmAdb/QjAyQF6ZTTrxjIe3f0SdrzlIgcqyPgt1yJwLH8f70W6b
	07WzjNTzs4nNt8yP+lJglpzvFoou2rMFX+bd6dwkJos/byTmJRUoeAbzOFWdGZd6TI6SyOVyXLY
	nsvBGOIUwq4OYwoyL0Ul7zsPIfbWkHxfyiAVl2Cg2ePAEwbamn5+zdc93nsABCMITqf7G71xaBX
	CcIgBAmsi825C9WLvihHKkrVoZ8JUeBaiSFeTBKc/azR2XsFyV6IVW5+jmxi/Q0rLvz4AE1Zkqs
	IbcfbPVOqyi6Yl8BHjVyQDVVpFnSf9v9Cbt5c2qyhqOEwI7jBTRzUecJ7Uxl3wFSIMwK3GNmv/o
	Fk3KdOtpupmCNSyPtfxNYmNHu1MCVEB9bYeZGH5B8tsybFfFG5bHZwhwzU2EVv1bEmN
X-Received: by 2002:a05:6a00:a204:b0:874:708d:b620 with SMTP id d2e1a72fcca58-8a089d13a97mr1238939b3a.30.1792571443298;
        Wed, 21 Oct 2026 01:30:43 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0895e273bsm600653b3a.41.2026.10.21.01.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 01:30:42 -0700 (PDT)
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
Subject: [PATCH v9 1/8] riscv: build crash_mem ranges from memblock instead of resource tree
Date: Wed, 21 Oct 2026 16:30:04 +0800
Message-ID: <20261021083011.2170525-2-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021083011.2170525-1-chenwandun1@gmail.com>
References: <20261021083011.2170525-1-chenwandun1@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_013044_489299_B302A76E 
X-CRM114-Status: GOOD (  11.77  )
X-Spam-Score: -1.9 (-)
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
index e7891a2a89da..e21d0bab77ee 100644
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


