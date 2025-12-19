Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7844BD711CE
	for <kexec@archiver.kernel.org>; Fri, 19 Dec 2025 00:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VRLIZ+Id1A3SMxQgIBWSqDdOfJhpJaefDTuwxeIWUn4=; b=cbe+KV+EZDp/9bXTXNSI44r4mL
	1jvzWVBH74ZbhHN6C2Ndd3+n/wniFp9bKMwq/MP3YLW2/Pz0hN5+JgHiXny+q+dpqvX08SeurKA+A
	j9QlYXye+zNJ1nvMWEegFOF8uze0M+NuEuOihKBJJFhlzMuPaqZb8MemwOZen31tYnu44GAK9fRsN
	4Lh6YvX0kTUH1GJKaykePmUxA0frkpOTCLgOgp+MfG9mBuovn4+l8karr7yTPFaO5txdJN1ijSN5a
	SpXJcMXzhZf5XWYn0QC2a1PwyDO8Dfc7op65vquJyfjKP5Kcm3oFBXs+TO2PZrY1sgXa7jzhM/NtZ
	fkLOD2Ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWOHr-00000009OFU-1zkH;
	Fri, 19 Dec 2025 00:24:03 +0000
Received: from mail-yx1-xb144.google.com ([2607:f8b0:4864:20::b144])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWOHp-00000009OF9-1Wbj
	for kexec@lists.infradead.org;
	Fri, 19 Dec 2025 00:24:02 +0000
Received: by mail-yx1-xb144.google.com with SMTP id 956f58d0204a3-6432842cafdso1098973d50.2
        for <kexec@lists.infradead.org>; Thu, 18 Dec 2025 16:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1766103840; x=1766708640; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VRLIZ+Id1A3SMxQgIBWSqDdOfJhpJaefDTuwxeIWUn4=;
        b=Q4t7GBLBK9HJUh/KaVUV1XJmptepblpIdnL+RBVxTaOdBgJI+Z3+GKKj+Cd+G/Ecw6
         Yaa8wWvyhY5jDVv3Zq/d7eSISiR+Yoy7EnyClhuFyxHvicuVntXmtnPMXzHuCmj8yACz
         kd7TLD6B9BRHTzpQRbCDL1aXaw4+XPk+S6qa5peynYHviLgq1uBO5p23Y1SOM8pQLcVj
         GAZZx30MQFa0r+mAvjOcEb4r1StRoumEOVwaJMu/I+peWUNocfToUtz8K0O+Okz1bySM
         Nhr5f6/AftA9cWuLdGjdwlTvHF8SMIBzbyk8sXDzM9vvpU8mHB6S8B+P9FnZD522UJWW
         kKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766103840; x=1766708640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VRLIZ+Id1A3SMxQgIBWSqDdOfJhpJaefDTuwxeIWUn4=;
        b=asPeGwubQeTL9qtFo1kYp6qMuOb/GoFtgtDB55Fy0oWzdjHnPrBsISrlWm+kIaGACb
         cNXqnJ5+w7o9n4pKwQDow0axm+hM6vPu4y2ZuxTuK4OOTYCeXlvCd4yRsgKH4WRMj64R
         djx7t5c+PN5+A57N3rLAcd8oT10YMKAJ7EYpd14KqnONU6xsSZRJN6VjUw1vK8gpiJ8d
         AnA/d5MijFOFyESDSL3yAHkOdCqMekhwUNOXeeM1RB9/J6LiFRiVuc7yiQYTzl7gYf5m
         8ZbLJaqFBK9CaOwu2UaYoKbH39MlXTcH14PNtg0MSZ+Mx31rxQ52puCYgPgQ1vCY6vN0
         ruPw==
X-Forwarded-Encrypted: i=1; AJvYcCWFi6u6ekMCsWdvls2oe3c25aArN972tsZUZ3aCiicyZZNhv7iscZ1NfvDZWAywDMQNtauNGA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzkOd/ZSJXc7CZYUmm3V9cx+w8nDN/oWqhnF9nFY16Emg7dQvpD
	J6zIq/rUL15ZxFFNf3cGlsSRPIU8RelWPRoKPXf2NzAiGn4etjIpRIolZDjj2JOwPCM=
X-Gm-Gg: AY/fxX5dNMB3aXXs4ULMB6F/eo2WXPue1kBQ6GGjZKtEKujdh+928GSAhBcZUY4J4Wz
	tC0n9X4oOFaYq4SZblitCFc4KdAVKJlx91fsASAj/Extq6tU5ru9bcZSb6EL1owMNi3+GpvtXy1
	cVa5KnWXBusbLR3wyKyHcKBeFwW+3W82D+TxADXvi9L0KUpfLCAKg6MgsNIQ45jtdLn2abWArJv
	EPKLPknH8ohHYf7Ssd1D+TFKP+dZ997B/TvAHmR1BNdu12Ruy/IYqjmOf/DGLqk6D66RX1Kx72E
	RDARJHySuRi07y54wY61xeLQ7ZzAZJ728hHsfbczU3Dq5mLS6OtTu6q/puEqaWHprKDSyiAOZ10
	XwTLXOOpbG+Ui+D4fzSEiGKbwVqzzJ7yyG2PuMCswk3xRjvaNU/rpe6T1CxDHkQ6sh5k8wkqWfi
	KIWK8fP9KK2Gfc0/IAgNExtlQJTqaVLwC+AUSGk4jjJPTrnxcgfILgiB0KYZK+zTwCu3oGrk0kn
	5DDzNuto2AYeYIF+5G+6n4Ko7LOpcsAFXF2iw==
X-Google-Smtp-Source: AGHT+IEFAtXPoKS1+Zlj4yJmeQNwxl11BdgyoU/smQ241gIO6ZqWceiGoF12B4JGc5G8V13yPkNL6g==
X-Received: by 2002:a05:690e:169e:b0:640:fabf:565d with SMTP id 956f58d0204a3-6466a87e489mr1003195d50.43.1766103839999;
        Thu, 18 Dec 2025 16:23:59 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb452c471sm3599487b3.45.2025.12.18.16.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 16:23:59 -0800 (PST)
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
Subject: [PATCH] kho: validate preserved memory map during population
Date: Thu, 18 Dec 2025 19:23:55 -0500
Message-ID: <20251219002355.3323896-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.322.g1dd061c0dc-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251218_162401_430849_C7B513F3 
X-CRM114-Status: GOOD (  13.52  )
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
(kho_in.mem_chunks is NULL) and falls back to kho_reserve_scratch(),
allocating fresh scratch memory as if it were a standard cold boot.

Fixes: de51999e687c ("kho: allow memory preservation state updates after finalization")
Reported-by: Ricardo <ricardo@example.com>
Closes: https://lore.kernel.org/all/20251218215613.GA17304@ranerica-svr.sc.intel.com
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/kexec_handover.c | 36 +++++++++++++++++-------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 9dc51fab604f..96c708f753d4 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -460,10 +460,9 @@ static void __init deserialize_bitmap(unsigned int order,
 	}
 }
 
-/* Return true if memory was deserizlied */
-static bool __init kho_mem_deserialize(const void *fdt)
+/* Returns head of preserved physical memory chunks pointer from FDT */
+static struct khoser_mem_chunk * __init kho_get_mem_chunks(const void *fdt)
 {
-	struct khoser_mem_chunk *chunk;
 	const void *mem_ptr;
 	u64 mem;
 	int len;
@@ -471,16 +470,16 @@ static bool __init kho_mem_deserialize(const void *fdt)
 	mem_ptr = fdt_getprop(fdt, 0, PROP_PRESERVED_MEMORY_MAP, &len);
 	if (!mem_ptr || len != sizeof(u64)) {
 		pr_err("failed to get preserved memory bitmaps\n");
-		return false;
+		return NULL;
 	}
 
 	mem = get_unaligned((const u64 *)mem_ptr);
-	chunk = mem ? phys_to_virt(mem) : NULL;
 
-	/* No preserved physical pages were passed, no deserialization */
-	if (!chunk)
-		return false;
+	return mem ? phys_to_virt(mem) : NULL;
+}
 
+static void __init kho_mem_deserialize(struct khoser_mem_chunk *chunk)
+{
 	while (chunk) {
 		unsigned int i;
 
@@ -489,8 +488,6 @@ static bool __init kho_mem_deserialize(const void *fdt)
 					   &chunk->bitmaps[i]);
 		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
 	}
-
-	return true;
 }
 
 /*
@@ -1253,6 +1250,7 @@ bool kho_finalized(void)
 struct kho_in {
 	phys_addr_t fdt_phys;
 	phys_addr_t scratch_phys;
+	struct khoser_mem_chunk *mem_chunks;
 	struct kho_debugfs dbg;
 };
 
@@ -1434,12 +1432,10 @@ static void __init kho_release_scratch(void)
 
 void __init kho_memory_init(void)
 {
-	if (kho_in.scratch_phys) {
+	if (kho_in.mem_chunks) {
 		kho_scratch = phys_to_virt(kho_in.scratch_phys);
 		kho_release_scratch();
-
-		if (!kho_mem_deserialize(kho_get_fdt()))
-			kho_in.fdt_phys = 0;
+		kho_mem_deserialize(kho_in.mem_chunks);
 	} else {
 		kho_reserve_scratch();
 	}
@@ -1448,8 +1444,9 @@ void __init kho_memory_init(void)
 void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 			 phys_addr_t scratch_phys, u64 scratch_len)
 {
-	void *fdt = NULL;
+	struct khoser_mem_chunk *mem_chunks;
 	struct kho_scratch *scratch = NULL;
+	void *fdt = NULL;
 	int err = 0;
 	unsigned int scratch_cnt = scratch_len / sizeof(*kho_scratch);
 
@@ -1475,6 +1472,14 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 		goto out;
 	}
 
+	mem_chunks = kho_get_mem_chunks(fdt);
+	if (!mem_chunks) {
+		pr_warn("setup: handover FDT (0x%llx) present but no preserved memory found\n",
+			fdt_phys);
+		err = -ENOENT;
+		goto out;
+	}
+
 	scratch = early_memremap(scratch_phys, scratch_len);
 	if (!scratch) {
 		pr_warn("setup: failed to memremap scratch (phys=0x%llx, len=%lld)\n",
@@ -1515,6 +1520,7 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 
 	kho_in.fdt_phys = fdt_phys;
 	kho_in.scratch_phys = scratch_phys;
+	kho_in.mem_chunks = mem_chunks;
 	kho_scratch_cnt = scratch_cnt;
 	pr_info("found kexec handover data.\n");
 
-- 
2.52.0.322.g1dd061c0dc-goog


