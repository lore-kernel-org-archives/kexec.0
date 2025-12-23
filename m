Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C822E6F093
	for <kexec@archiver.kernel.org>; Tue, 23 Dec 2025 14:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vshIKu39IbphKk1hyt1uS5BaulPgmjMjuk5AnSSvw9w=; b=Oz+R0NU9lj7S5uuh/VQ4hQMA6F
	i6Df8Oq+e1QEDY7A2Pn+a4ofU9cdoktnQfNiNGpTGK8PW8DwZHJ7GPHvCGocBZFfYxm62zXIJPTLg
	MwqQYdajobhRSSFmXVkJcxAM0XHXOqwJq4tuSO3VCSf0nUConiEIV87lbgw72SXoQONjkR113Pxgf
	whPKxqctGAu2RK5F5zByt9y74G3Jj37/IVs2YX74VTrM59DlomGsCZl4eBMz0F1F0ZfdJhJiWrBzq
	DvHDHGDNxSJhEKzKuDvPLlQ9CMyUymizO7eCF7q+KMY33bT6S435KM+X0+We6D3T4iV9Fg5i4Z4l9
	tS6e2t6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vY2xT-0000000FZbz-08Et;
	Tue, 23 Dec 2025 14:01:51 +0000
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vY2xP-0000000FZbH-34VD
	for kexec@lists.infradead.org;
	Tue, 23 Dec 2025 14:01:49 +0000
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-78fb7ab7562so28732817b3.2
        for <kexec@lists.infradead.org>; Tue, 23 Dec 2025 06:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1766498506; x=1767103306; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vshIKu39IbphKk1hyt1uS5BaulPgmjMjuk5AnSSvw9w=;
        b=cpAO1Ss/fJuIzam3c6Ftv5O7Ct/+8KArzX16WKzmBNvpuRzTXFlmmNDmsfZA8XCwhG
         sN2erkcEcxlVTiDmg1mkW6tTjUF2U5gq2mbRUAGjkT9gyMvZDCVT5Rvd9HnZOiIEeP1U
         jxx4331K5+XH8cngdl3uRewXFhwVHkLZZsqscdhQJ4jnjTGFQMqZ9R2z8QRydE7zUpX/
         a7udNFEd0AGDdACKpGhze52uAd9jemyP/ZSXH7GToeZqG0jl4BZOFkrimy0CqxEY5xfX
         PRTMX6j5BCeVhEhqpx8GAboDhEX6IVR9MaZRSxRW3+ssw0Iy6p32h8cuPENgpgzJy96z
         Pf4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766498506; x=1767103306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vshIKu39IbphKk1hyt1uS5BaulPgmjMjuk5AnSSvw9w=;
        b=GDGwiAlmbT1mFqIc0XPFIdm3ZK8VCFv08unQrxh5DfwUxvTR2NBVz1QwL5syVvbEJL
         nC+7KVQMEbcdYH96gERrqI2xgcWc0ME+BwpOLzweGh0YyMWrf4NljRAoIU7OMau9sfgI
         JWPTttd6TT0zQF0XJEYzxucnbzYvOLyNBwQ2fkwK+JO/kf4W29xdNHD9S5UKgChssVdO
         E5le5vN9WLXv5LwxEKm7q4D884QMY5ylX6hFX4M52OK7CwAdO7SFlY0PfaMOVOjz9EkK
         vjLIEYXkC6kEOVltJvmdZQTuXanv5wwR158TDKLZZZPSXjnGynfpjnB2m6s9WvC9ZF3S
         PTYw==
X-Forwarded-Encrypted: i=1; AJvYcCXKCHsOaYJvZXTacIDPDNR3VW0Rrrc2IIpELWHD4UhIODmkDvcSHghrJHO1JPlxI52PewS6wQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwjXVPE8nQeYhd/ZYAXv5MAujrxIRS4tuOyoUuFehWvuShm8meD
	daCXgQId3wrZ4eGtBbr7e8ymMP4jfijh/5cpCq1RuofHNMDbnG+nFAgmiDAiEodFV9U=
X-Gm-Gg: AY/fxX5W+2GrB1baGp/GbFZHeBawFuPe6YWi57ypQz9Hu4YkmzoQ1B1jUH6Wo79Jd2r
	bqfRKIiXYfFFUKPr0BBWBDiVMoVbPo5O8DQEni3k5vdx6T0oAkitHx0AZsLJD+/oH/qI9mGq1lh
	Xjfrt553Z+vuu1GNgTLOebxhtzC45ddHywwe6eay5e542ydISakejVPDaasc31VCYTDscA05g6X
	0LJQwvR1LW4Wdc+giZk2zizouDrmvkZb+Tq82ON6EAvzfz2mk57TzTLTwh/ZT5VEdhnAAMCxCqt
	7BNTMmvXnfkMWMoStJykDrbXQOrzPMTfSyjq2tLlrPXiTQ0UAt73fSJlq8zVKxCqXzUMeXbeKm7
	I7fnFtS7coIOeE7CNSQ+5TUI246M2aQhJRj+rlxPeZFKMcd832qFdSCk1sze1nFshFkhoy8R3Xg
	5iayFJ4RwZTRdOs2IVoDR0VHkKUfYDquvhS2y+gzcBx6U3JZbQFXYq6feKWHRaGtKShHhIP3tRc
	lnuWw2Qj46Nk9jo6b+3QTudlEDcPzIYN8PINQ==
X-Google-Smtp-Source: AGHT+IH5CPaJf1hFF18a7CLmrmSafeqmgYVCXu6LIDTysGZNKbl/h5bcqgxuwkcD9gwaFkH2YgNd4A==
X-Received: by 2002:a05:690c:4b88:b0:78c:6664:3104 with SMTP id 00721157ae682-78fb3f05364mr244887467b3.5.1766498506252;
        Tue, 23 Dec 2025 06:01:46 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ffebd2690sm1244367b3.15.2025.12.23.06.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 06:01:45 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	graf@amazon.com,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	pratyush@kernel.org,
	ricardo.neri-calderon@linux.intel.com
Subject: [PATCH v4] kho: validate preserved memory map during population
Date: Tue, 23 Dec 2025 09:01:40 -0500
Message-ID: <20251223140140.2090337-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251223_060147_817523_9AD4EB4D 
X-CRM114-Status: GOOD (  13.43  )
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

If the previous kernel enabled KHO but did not call kho_finalize()
(e.g., CONFIG_LIVEUPDATE=n or userspace skipped the finalization step),
the 'preserved-memory-map' property in the FDT remains empty/zero.

Previously, kho_populate() would succeed regardless of the memory map's
state, reserving the incoming scratch regions in memblock. However,
kho_memory_init() would later fail to deserialize the empty map. By that
time, the scratch regions were already registered, leading to partial
initialization and subsequent list corruption (freeing scratch area
twice) during kho_init().

Move the validation of the preserved memory map earlier into
kho_populate(). If the memory map is empty/NULL:
1. Abort kho_populate() immediately with -ENOENT.
2. Do not register or reserve the incoming scratch memory, allowing the new
   kernel to reclaim those pages as standard free memory.
3. Leave the global 'kho_in' state uninitialized.

Consequently, kho_memory_init() sees no active KHO context
(kho_in.mem_chunks_phys is 0) and falls back to kho_reserve_scratch(),
allocating fresh scratch memory as if it were a standard cold boot.

Fixes: de51999e687c ("kho: allow memory preservation state updates after finalization")
Reported-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Closes: https://lore.kernel.org/all/20251218215613.GA17304@ranerica-svr.sc.intel.com
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Tested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes v4:
- Addressed Tested-by
- Addressed review comments from Pratyush.

 kernel/liveupdate/kexec_handover.c | 37 +++++++++++++++---------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 9dc51fab604f..d4482b6e3cae 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -460,27 +460,23 @@ static void __init deserialize_bitmap(unsigned int order,
 	}
 }
 
-/* Return true if memory was deserizlied */
-static bool __init kho_mem_deserialize(const void *fdt)
+/* Returns physical address of the preserved memory map from FDT */
+static phys_addr_t __init kho_get_mem_map_phys(const void *fdt)
 {
-	struct khoser_mem_chunk *chunk;
 	const void *mem_ptr;
-	u64 mem;
 	int len;
 
 	mem_ptr = fdt_getprop(fdt, 0, PROP_PRESERVED_MEMORY_MAP, &len);
 	if (!mem_ptr || len != sizeof(u64)) {
 		pr_err("failed to get preserved memory bitmaps\n");
-		return false;
+		return 0;
 	}
 
-	mem = get_unaligned((const u64 *)mem_ptr);
-	chunk = mem ? phys_to_virt(mem) : NULL;
-
-	/* No preserved physical pages were passed, no deserialization */
-	if (!chunk)
-		return false;
+	return get_unaligned((const u64 *)mem_ptr);
+}
 
+static void __init kho_mem_deserialize(struct khoser_mem_chunk *chunk)
+{
 	while (chunk) {
 		unsigned int i;
 
@@ -489,8 +485,6 @@ static bool __init kho_mem_deserialize(const void *fdt)
 					   &chunk->bitmaps[i]);
 		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
 	}
-
-	return true;
 }
 
 /*
@@ -1253,6 +1247,7 @@ bool kho_finalized(void)
 struct kho_in {
 	phys_addr_t fdt_phys;
 	phys_addr_t scratch_phys;
+	phys_addr_t mem_map_phys;
 	struct kho_debugfs dbg;
 };
 
@@ -1434,12 +1429,10 @@ static void __init kho_release_scratch(void)
 
 void __init kho_memory_init(void)
 {
-	if (kho_in.scratch_phys) {
+	if (kho_in.mem_map_phys) {
 		kho_scratch = phys_to_virt(kho_in.scratch_phys);
 		kho_release_scratch();
-
-		if (!kho_mem_deserialize(kho_get_fdt()))
-			kho_in.fdt_phys = 0;
+		kho_mem_deserialize(phys_to_virt(kho_in.mem_map_phys));
 	} else {
 		kho_reserve_scratch();
 	}
@@ -1448,8 +1441,9 @@ void __init kho_memory_init(void)
 void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 			 phys_addr_t scratch_phys, u64 scratch_len)
 {
-	void *fdt = NULL;
 	struct kho_scratch *scratch = NULL;
+	phys_addr_t mem_map_phys;
+	void *fdt = NULL;
 	int err = 0;
 	unsigned int scratch_cnt = scratch_len / sizeof(*kho_scratch);
 
@@ -1475,6 +1469,12 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 		goto out;
 	}
 
+	mem_map_phys = kho_get_mem_map_phys(fdt);
+	if (!mem_map_phys) {
+		err = -ENOENT;
+		goto out;
+	}
+
 	scratch = early_memremap(scratch_phys, scratch_len);
 	if (!scratch) {
 		pr_warn("setup: failed to memremap scratch (phys=0x%llx, len=%lld)\n",
@@ -1515,6 +1515,7 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 
 	kho_in.fdt_phys = fdt_phys;
 	kho_in.scratch_phys = scratch_phys;
+	kho_in.mem_map_phys = mem_map_phys;
 	kho_scratch_cnt = scratch_cnt;
 	pr_info("found kexec handover data.\n");
 

base-commit: cc3aa43b44bdb43dfbac0fcb51c56594a11338a8
-- 
2.52.0.351.gbe84eed79e-goog


