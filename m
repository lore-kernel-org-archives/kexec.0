Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C6F6D711D3
	for <kexec@archiver.kernel.org>; Fri, 19 Dec 2025 03:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=r2/OhVQU+QVH8G/cODFOhwoAozt9Fs2Kb3PN40QPAds=; b=jjYTpeEjFNEKWgAKUSW16UHwwx
	kJhkp3xoaCFceCmjER5NFzQP+tzSU6OMok3RDKtJh9stDtW9863ced8toWQ7/rxJNO2C8MX0R7jGI
	lWLBztOvxrPOjG0u4k7ZvkOwoKSxZrkVsGJ8vmVvZfWT8H8G2R8kuyPrD/DRKUZUvZlVJ6+sLBQnn
	w5Yl4D8RR8C5TXfxmUT7FQYjRSE1njlOy+wkJ7B5ghii50QxCb0ooWx/qIT19CgnVIjMqXsJE+k4N
	vkrlLkl4WrtzBILA4WbepCeL6zwQ5XoEPvrB0ZpcaCr9p7kKRNDk+zAcmjQ3Y3wnHIhlAoQeOiBj/
	U8D1pwlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWQrW-00000009Wok-0A2m;
	Fri, 19 Dec 2025 03:09:02 +0000
Received: from mail-yw1-x1141.google.com ([2607:f8b0:4864:20::1141])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWQrT-00000009WoA-2Boz
	for kexec@lists.infradead.org;
	Fri, 19 Dec 2025 03:09:00 +0000
Received: by mail-yw1-x1141.google.com with SMTP id 00721157ae682-787da30c50fso11967337b3.3
        for <kexec@lists.infradead.org>; Thu, 18 Dec 2025 19:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1766113738; x=1766718538; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=r2/OhVQU+QVH8G/cODFOhwoAozt9Fs2Kb3PN40QPAds=;
        b=SNOh9YomOeWS0e8D2cJgzz9tGCMKO5wxcKYoRI9lU6PMF3Cf4XfcaQFXsk1wgKlitd
         q7S1m3yRaXS0X/JQt0u8Q8pEFO+9qyCIV3WGJiL2Oz8Zut6VBCXNNT36Hfz14NkpYguw
         BxK7pLTepekjVVSz/aMtxsaP9niIOb5YqnLUTY2ClL4mlbGkocjYyQ9y/O7SkSwm6mK/
         cNQM28MSfshepeQVRwux4mfy12oDvi74HA2keFFZ+RHW1CrK73lrGoSlwCs2kAMlP+Gi
         fDFEN5EWkDd+y4Mr/Q6cEeDMxPR5olfTe1FF3u+tI96kjLjuH5ze5HmicYm2ixbM4ULn
         cXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766113738; x=1766718538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r2/OhVQU+QVH8G/cODFOhwoAozt9Fs2Kb3PN40QPAds=;
        b=o97ETT6M9jFnCar0DhhPvFCdgUO9IF54C5BJqkMKbaoGieVb+xcWkIb+ozpM5aBXb9
         FN/ewAG247mudftxIR3/5VSYXtsmfsPcyz2zM1eKI0cUx1KvYRvJFMgxUhcK3rhkOPIX
         601zcDk40glse/ZZcsMC39fqI9kMmolMW9tM7TLm6SE0r87YE0KfUG17Oylfb1J4He+i
         ws0gnahJdyeBJd+vXZSLndgoYQ0rPfJSaLXiR+pIOrHJ0WjIPqIgQGXMBrCILEsBSnoP
         SLBIRK21gF6FcklAOouOomJ9frdS4DpoWcAQD8rDHMA1wnaUtAUJbU+ALJmsEambgCs4
         zvEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyUODfYYGH9oTZo8CHcrK7e1+qY245L1GAVsy64TRqn7TCrA5YS3+uQjGmvF+mYRrQ5p7Gew==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz0/bpe7GP55GeiMx5uTJoGUJe901odLx+fUFawJ1/Jvxq5txqp
	KXzr6OUSl8vQ/K6piCvt6LOPc4IsG0bMkWKYRzYKRoW5WFZo5SyGZ7kAwGMeD0dnZxM=
X-Gm-Gg: AY/fxX6QJ4RxY/ujixjPiYeQKcaSLdFZohSREDE3ZIKTN5kJKo50AJ3+pjczxRHr64b
	ANBiMkqMi2srH/BwLcFNHcAZAUYn8yQ/8Lo/3ggkaGgE6wnYp1QRclOT/o8vwXwK4+pcDkc76So
	S9Nz90v20m0JvLQujlC3ZZi9TNGcoKFFpD9LdXCkZCEZ5GQusASRa3gByibcbi31z4JPZitTeMP
	ZPK7u0YhkdB+SCdrA5UKhJhnPbXjb/sfk6h+MaFlqtejDrNuQDW1Rd34nGtGcr+dS06Y9fIhoIm
	wH+GFfwtgyYo/7Ds2CVbXlgHO09/QW59YZ8AwhbQHtc+EjtlBBXypKEPikIqyIZOhpbafDbL1jv
	DtmVyU2FPZQhd8JbK0mD6pBeHyuYxvmYJIzEH/6gUkuTZbWggo+XRgNakQcLuxgX5ha/pUuJJuL
	iz+tdtgAo1rs2mbPI6i0a4IIBUSfg52jJxyqaSa6Nan4wtiYYF5IQ5OUQY3xx16R6Lwngej8Edz
	H+UaLaKcrgRhMnz/WxEGAoaIVByyAGeP2NcLQ==
X-Google-Smtp-Source: AGHT+IH0SFFGcLuZ3Rz+C1B/s4/iGdSlEwbIjM/JS7E1t+K9R5SfPZNhnq31cCe+ZYL8cHIylt29xg==
X-Received: by 2002:a05:690c:c4f6:b0:786:5afa:375c with SMTP id 00721157ae682-78fb40d9808mr27748627b3.67.1766113738125;
        Thu, 18 Dec 2025 19:08:58 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb43790dcsm5069027b3.11.2025.12.18.19.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 19:08:57 -0800 (PST)
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
Subject: [PATCH v2] kho: validate preserved memory map during population
Date: Thu, 18 Dec 2025 22:08:54 -0500
Message-ID: <20251219030854.3527871-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.322.g1dd061c0dc-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251218_190859_611582_A856EA51 
X-CRM114-Status: GOOD (  13.45  )
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
Reported-by: Ricardo <ricardo@example.com>
Closes: https://lore.kernel.org/all/20251218215613.GA17304@ranerica-svr.sc.intel.com
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
Changes v2:
- Removed phys_to_virt() from kho_populate().

 kernel/liveupdate/kexec_handover.c | 39 ++++++++++++++++--------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 9dc51fab604f..6ba554208c81 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -460,27 +460,23 @@ static void __init deserialize_bitmap(unsigned int order,
 	}
 }
 
-/* Return true if memory was deserizlied */
-static bool __init kho_mem_deserialize(const void *fdt)
+/* Returns head of preserved physical memory chunks pointer from FDT */
+static phys_addr_t __init kho_get_mem_chunks_phys(const void *fdt)
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
+	phys_addr_t mem_chunks_phys;
 	struct kho_debugfs dbg;
 };
 
@@ -1434,12 +1429,10 @@ static void __init kho_release_scratch(void)
 
 void __init kho_memory_init(void)
 {
-	if (kho_in.scratch_phys) {
+	if (kho_in.mem_chunks_phys) {
 		kho_scratch = phys_to_virt(kho_in.scratch_phys);
 		kho_release_scratch();
-
-		if (!kho_mem_deserialize(kho_get_fdt()))
-			kho_in.fdt_phys = 0;
+		kho_mem_deserialize(phys_to_virt(kho_in.mem_chunks_phys));
 	} else {
 		kho_reserve_scratch();
 	}
@@ -1448,8 +1441,9 @@ void __init kho_memory_init(void)
 void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 			 phys_addr_t scratch_phys, u64 scratch_len)
 {
-	void *fdt = NULL;
 	struct kho_scratch *scratch = NULL;
+	phys_addr_t mem_chunks_phys;
+	void *fdt = NULL;
 	int err = 0;
 	unsigned int scratch_cnt = scratch_len / sizeof(*kho_scratch);
 
@@ -1475,6 +1469,14 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 		goto out;
 	}
 
+	mem_chunks_phys = kho_get_mem_chunks_phys(fdt);
+	if (!mem_chunks_phys) {
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
+	kho_in.mem_chunks_phys = mem_chunks_phys;
 	kho_scratch_cnt = scratch_cnt;
 	pr_info("found kexec handover data.\n");
 

base-commit: ea1013c1539270e372fc99854bc6e4d94eaeff66
-- 
2.52.0.322.g1dd061c0dc-goog


