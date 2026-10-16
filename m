Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D60CCA463
	for <kexec@archiver.kernel.org>; Fri, 16 Oct 2026 03:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pI8cU+3Va0VJY6BQ+e7sBVT9LPRu4J+OFo4gOdjLJ30=; b=NGG+vU26Xa4WZEewe6GBcpDofC
	qYx8hMYkdH05T6RIYLGB6qpWCV2gxxJWPb4D6wOn88hwLvqneuUmm5nTfpaSraEDkqhoQCxlVdosi
	1UnBoxA/44BZSMiYnNkUaZHEOgVK5PL0IpyW6IFJjxZE9tumxQMOyzejQ+9tvhVdtj6TfhlHkgU24
	QxQrAmF0EVKWMxlTUsWvq1hjQOIQFr+ME5A9kb+ahNPoL9GJMzuIWyWAcAZOLjplZygIJ19YDQaE5
	uIEQI36s4zN4EiREVEL2Q2vL3HiN+2R+51MPO9DwI+CZXRXk2o2/sgiS8h5HCD9S76SCG7d5UBPWO
	XjdHwpIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHYKA-00000001nKL-17Rs;
	Fri, 16 Oct 2026 03:09:38 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHYK8-00000001nIs-1j8c
	for kexec@bombadil.infradead.org;
	Fri, 16 Oct 2026 03:09:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=pI8cU+3Va0VJY6BQ+e7sBVT9LPRu4J+OFo4gOdjLJ30=; b=QvU48NGnKIVwM6anWEXYTIb20D
	zfwWM7J1HyzoKxPd5L01EwdJRyrTxniDaaawg5jPpXO0LZ/lwlBT7jvo4owPNAM5MiMbvEFYadX/W
	lHs20gY8CKb0pFlmEfk8SYf9OMW1FNTBlm1AF/S4RCOYZDx6mWDKinbAhwDE3oXcNIGsOfAE60eFN
	Y9pJXKJZw41CMvYb4v1dJIh+yyQGm7+nq50OKOeOVk/3imbA+Abi5kPDH2h2sXgfS3DUoKkHOaYT1
	a7OBHTc6nrOUNZabOCNLhzE8xDJCsYL+oSc7uji3QNPQn/KeL705vatAkc1qUjcq5rTnSVnL3a6qP
	ywyD527Q==;
Received: from mail-pj2-x01.google.com ([2607:f8b0:4864:39::1])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xHYK0-000000011sl-0OVZ
	for kexec@lists.infradead.org;
	Fri, 16 Oct 2026 03:09:34 +0000
Received: by mail-pj2-x01.google.com with SMTP id 98e67ed59e1d1-3a51696a650so3488760a91.1
        for <kexec@lists.infradead.org>; Thu, 15 Oct 2026 20:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792120165; x=1792724965; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pI8cU+3Va0VJY6BQ+e7sBVT9LPRu4J+OFo4gOdjLJ30=;
        b=pykGi6p5n0lqjw+03t5NPoFmTh51Zcnh/Nr0Bua9q4mV5HRaRUwEx3ChVne3b58iyO
         YtfPYWAkIcthNQ3DPZy7+mVVdqil8Z7hPYYgCrTiOT5zCsfgpsHGBJPbgL2h/8Tn5YoR
         8FdnkaxGtTVW1sOxshAwCnKUmucPYNY90AIEwRwx9Dca9s1zaca3xEcVUFNuCSOJCEcr
         JDAua4vMIcocjTeo9Rfl/Yj/OxbH+dx5h7JnK47U5XSX6wqJGemVEZffphtrcbvn/5iX
         Toa/F8Ere+S1HiT/XOlBzs0Xy6xnVbhEm+BdDYLVwgaIMsJ+2nD0R0DEgPYJCxqzrye/
         6KqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792120165; x=1792724965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pI8cU+3Va0VJY6BQ+e7sBVT9LPRu4J+OFo4gOdjLJ30=;
        b=ciYalPwqOs9QQFdDaTBNaHzGaa7bswHzGWp+uoK1hhw5lnEALCi3DdNQxJ2GINAUvx
         RA3EPyE3v2osLDr7726t/2M9FqcO2iFFbw1mPJD/QXd+4bFb8Zws7wXGOIk747x2GBfv
         BbwmhTQ0/aoPi1JZxTONhSNwMxCILsjhg2y8ofqnVE8LLyM2aWixg94W1NBN+89j9mPX
         DIg+OS9r7dmFqOjVheIBKqBbQvd2KGtwnxAx0T6ePoIZ8BpImDb9NxWdOdZLRSdRN4yc
         H2E+U7DzvJtRGxIivL3G3lqcRZdJG2CuNOd5sKTmuG7slH9qkzx+CBQ67bn5PJIuwyP0
         eDSg==
X-Forwarded-Encrypted: i=1; AKwUvBxHOc8qzX/28D4yfcFPbMa5syE961lE9jlOtnuUZRzfTcwZ8IUJUuG+eVlN1dDi3SIPDVcVig==@lists.infradead.org
X-Gm-Message-State: AFq9FYKRn53aks26FZbtlPIHBuEu1I2lzw2L6By878Rdqsz762AlLWrk
	aTFC0BmduKyinbmISay7K/1vXKmmFRcYpzC1nkP8xbZdPcHcXgmHBCOB
X-Gm-Gg: AYBFou39Pm02Q8oKyaYX+kLYgeM8MMVdWi4aHF+xE8rTbnuzDmmDqnbyVl1C5hU6LjV
	5tBZx3wjbqhBUx1xdDHva4YwRYZJ0l2oGzXY3+4effXcJjaA/sQnKe6l2LtDJnqZ0fmLlejDD8N
	T+q5Ko9pSD8OpO46bBFjSiQWe235L2oFk87SRbTrqIgf0FZbts5qa1QhGDu9jPQgV05XCaBwqEE
	yPJct49PHDy5E8L+bmHYj6lSqHzfe3+nZoTg3lOElzFsMKrBZDx2UAQh+o8vaaRIFZJL/RfWEY9
	WF1L5N823+s2ZCzWtYlnf3yojJ5a/Dl5wTnNWsxQ6bShQPKAKFIWGItkkW2dCwoKdDNWtNFXE1a
	4JL9u1xicBb51IqZS+iaORSvYEUp+o/8YIdYsMdI69iNbxj4pyHgbgAAdGdPrFTJ9Ype8o8vHhv
	SSl9z3PLBko4vh2pCaSZY4LD9gmQDTHQ9OdhjDc0czShEza892JGGc9F5jGUXcs6OFz7YyUxKU7
	kkIFb+se58=
X-Received: by 2002:a17:90b:5823:b0:3a7:9413:cfae with SMTP id 98e67ed59e1d1-3ab3ab1d561mr18240688a91.42.1792120164811;
        Thu, 15 Oct 2026 20:09:24 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd3cc73c7sm370085a91.4.2026.10.15.20.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 20:09:24 -0700 (PDT)
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
Subject: [PATCH v8 1/8] riscv: build crash_mem ranges from memblock instead of resource tree
Date: Fri, 16 Oct 2026 11:08:48 +0800
Message-ID: <20261016030855.4062882-2-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016030855.4062882-1-chenwandun1@gmail.com>
References: <20261016030855.4062882-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261016_040928_393587_010CDFAC 
X-CRM114-Status: GOOD (  12.44  )
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
index 62a4be0474e3..529310e3ae1e 100644
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


