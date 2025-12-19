Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9761CD74961
	for <kexec@archiver.kernel.org>; Fri, 19 Dec 2025 07:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6QLENq4Vv2SQsAQ4s6mi75aJFbGZLylufA139w0/C0s=; b=RZXafTkm73g9d9Fa0SL7tVR15l
	mPZSmGfXhw85Txk9gZJST8+MyiE6Ugy5/ifO5wz2wSgnJAFdwrNaDhRNtMU55B7cIwD9IF/73teOE
	fF0X3IP7XaUomBDRKP9iwHTCCTk5EzNZUPVHAfhcLFoqPlwYIZsWQ6TvXihZxqEMGGoIdMuLh/+fb
	o3qmrSb2ncHYm3G7noptELAK/CEERD0Ze5itrJ6r5CWwv9hsNzA+LYWEkHyFlA0r/+XS7Opg4vP6U
	JadP9ALhZ1mL8BMcZ27GdfqFhpTBcLbcLUSl5WyQf/3rjfGrcd+TfH2EC323Nydj9q3C8zb3dHRCT
	APC0w6/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWUew-00000009kTa-2Ugq;
	Fri, 19 Dec 2025 07:12:18 +0000
Received: from mail-yw1-x1144.google.com ([2607:f8b0:4864:20::1144])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWUet-00000009kTF-28qB
	for kexec@lists.infradead.org;
	Fri, 19 Dec 2025 07:12:16 +0000
Received: by mail-yw1-x1144.google.com with SMTP id 00721157ae682-78c33f74b72so12115187b3.2
        for <kexec@lists.infradead.org>; Thu, 18 Dec 2025 23:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1766128334; x=1766733134; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6QLENq4Vv2SQsAQ4s6mi75aJFbGZLylufA139w0/C0s=;
        b=f2RneSMLd1Z2XLw3iWVrg4tJsX8JSZVMWQWsnh92y2WN3SH9eidmHfdstTYVD/dxwF
         9j2k3J/gfNaYcxmjWt4LI2mTDqy5jdQYGu/Fptwu0G3pcP4f1tjMuB3AFxHkFjWoWyp9
         Ew5eTxPu53D94obvOUnRzEdzjzUWLU6RWZ6i7Dmf0x1Kg60NoaNX7/Pw7+3efkDmisBM
         OxKpuXBAbyJRSubXL5b88d4fPWiRo0+zg1G03eZaKIEm9piQ4ovB1tbcSjhyGfAjjK+L
         y5OnX32bOphixGPDJEdsAqH2WyD2Rox+nkhXo/p1WhwkF26rpoE15NcdxwTUIumWyW2a
         DB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766128334; x=1766733134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6QLENq4Vv2SQsAQ4s6mi75aJFbGZLylufA139w0/C0s=;
        b=r9CYx0d8Zc/wtzuwmrltq7u5vbnO7oBu7v/fz467LYMV7btRj4aeWRbxUOaRqDqnk0
         bEA3PtuuDYN3R71Q74sVQr9UBpY9PUvsbxSQJlEHFvGds0L5r43vW5B2DeFOu04+BWtv
         twdcYa/Uq99hkwjCRB1xIS6cy/8hCldIBitXZ+EgRpFvGM8O1EEqSfYUwBjU4P0wLQtF
         fwfLxfZ5pmWiokaXx27E34gTS3p1ZWyi+tWpSKA3q+woBZV6uwZyt52vGJExaYnHxenw
         oxAxLjfIztQ4jYcd6Sz6t4YSqWO7vkRSNkoojapxahuzhh+1nshejK9pwPT3UeCuE/uu
         H7eg==
X-Forwarded-Encrypted: i=1; AJvYcCUbGUWtTPTePFsxREfF9zVNGC7RUrdwH/SW59IgzNc4p4W4qxOlwdUi/SAvIq2YB5/DjMbgAQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzD4kgcrenRFOXNHGfoay+Pvr6RltmQqfWlZjNBrOQdudk2WxBb
	j1pREOzfYN/6yU34jyZAga7PBfGITMMGekHJScrujrgraqIP0Z5OLRCc3j/yljfo0i8=
X-Gm-Gg: AY/fxX6hAxi9cAVmylmnzEtuPke0EeUIWgbCTvHd6p1zOzjv/kGMt6+tpMWkxu7d/Jx
	MsUMih6kA+1S2koay2LCfDiRwuzu9KBPsq1pjIPl+Dt5nyQsJxczOBYXBRtB6G/ZF14ry4UnV6n
	AnIA7ht0aIRwTXK+N8Nw9spQn26BLjDqhvgsoJd3Q7r/yWqazDKXgUO5Dg6IXEx+z3sR4pS4/hj
	hIyDKJMi8JlyBaUnPWNm5cd4Kfc0fmBKYo6yGwxcKHbxWHFyW2OvRmM9p9vkvobIZN2NdQIt0HK
	R3CVhuLjGfuTnOEv7/RncQ0w5pyhSHCI5TSwNj49Lrch4iQCXCY2vK+WakycH6jrLWG/O4wcgDt
	I8kLjfjpsme5zG8ei51eWXsB6GtPD+5w9T4uGScv555FXL2AGwE2fyVAzW+IaVtuISPYsjoGlJ3
	5oVVR4930/7XiAin5ZAIZNwxmKbLF+4dW8y1bBk/YgIhFuovOHxpfF6G5agPToSLCEugIh4aSF+
	KjroyhDn7E3gQYZFLz0P+L+PHzrPkXR5ST2LA==
X-Google-Smtp-Source: AGHT+IEWVVc2D1cqR3AcZS0yhRsNlUTKLbAvt0ocD1LffHnt0W3gu7vYKX6GCKHep/ypCYEXliKiAQ==
X-Received: by 2002:a05:690c:368f:b0:787:febb:7f82 with SMTP id 00721157ae682-78fb3ecce81mr19078597b3.8.1766128334090;
        Thu, 18 Dec 2025 23:12:14 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb44f0d57sm6743917b3.31.2025.12.18.23.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 23:12:13 -0800 (PST)
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
Subject: [PATCH v3] kho: validate preserved memory map during population
Date: Fri, 19 Dec 2025 02:12:09 -0500
Message-ID: <20251219071209.3696755-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.322.g1dd061c0dc-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251218_231215_563868_797CF37B 
X-CRM114-Status: GOOD (  13.37  )
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
initialization and subsequent list corruption (double-free) during
kho_init().

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
---
Changes v3:
- Addressed review comments, and added review-by from Mike

 kernel/liveupdate/kexec_handover.c | 39 ++++++++++++++++--------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 9dc51fab604f..2d9ce33c63dc 100644
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
 
@@ -1475,6 +1469,14 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 		goto out;
 	}
 
+	mem_map_phys = kho_get_mem_map_phys(fdt);
+	if (!mem_map_phys) {
+		pr_warn("setup: handover FDT (0x%llx) present but no preserved memory found\n",
+			fdt_phys);
+		err = -ENOENT;
+		goto out;
+	}
+
 	scratch = early_memremap(scratch_phys, scratch_len);
 	if (!scratch) {
 		pr_warn("setup: failed to memremap scratch (phys=0x%llx, len=%lld)\n",
@@ -1515,6 +1517,7 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 
 	kho_in.fdt_phys = fdt_phys;
 	kho_in.scratch_phys = scratch_phys;
+	kho_in.mem_map_phys = mem_map_phys;
 	kho_scratch_cnt = scratch_cnt;
 	pr_info("found kexec handover data.\n");
 

base-commit: ea1013c1539270e372fc99854bc6e4d94eaeff66
-- 
2.52.0.322.g1dd061c0dc-goog


