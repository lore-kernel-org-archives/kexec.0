Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B738C61DD3
	for <kexec@archiver.kernel.org>; Thu,  3 Sep 2026 15:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fqrjp7diFK7hTPI/YVRHNUU83H0HuCgE52mHERNgxw0=; b=tkRPZIVVQnTBzE9WP/RtscSiii
	uZ7Yg0G/3eGPx7KY8kPbpj3i+qpv2VCBB6LI26uPdTKJ32ClhNi1Te/YntOKis3HVRn1lGUW9Goyu
	YrH1utAPI/g52Uc0rArKAoutCHMlq5cMAozCv7FOVyHOtLwG82VjQKBdRkuigDKTuf96GaR5spGax
	GeviB78AtCLaYd6e6kD2gSR3RmeUbk7jLhhNk3w1KCObMgFI2OpNFfc2zOUwF8fKEQ70A6v/Y6Xn2
	5o6eRHgw4Dy/fOkYPm+brLoHmFVAoU9bdrAa9pZecXUBPYp83/LLtnoLxVbT5rgBINDXHrhA7jo7D
	duLjqsxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x29qL-000000004Kf-3751;
	Thu, 03 Sep 2026 15:59:13 +0000
Received: from mail-ed1-x546.google.com ([2a00:1450:4864:20::546])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x29qJ-000000004Jy-2PPH
	for kexec@lists.infradead.org;
	Thu, 03 Sep 2026 15:59:12 +0000
Received: by mail-ed1-x546.google.com with SMTP id 4fb4d7f45d1cf-6a5f96426b9so3023617a12.1
        for <kexec@lists.infradead.org>; Thu, 03 Sep 2026 08:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788451149; x=1789055949; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fqrjp7diFK7hTPI/YVRHNUU83H0HuCgE52mHERNgxw0=;
        b=ql9JvCCJc4G683KKA0cqNQNNJ+fTFZ5dZLepanB95Xr4MVDXh7bvsKQY5P7FZK7sTg
         5Qvw7OeGZ36wWyydyKKZ8Ce5gfcQNIr9fAUawsVJh7ohle638GsXXi+B7bm6S02aAUUs
         W3+0FRAdQRydzTL8R2KTL7G3YkOqlfMkpI0g4k5TUcmGJCUqZB2ZlPIjoKPNXQk+0U2h
         zhfofIxQwnacQbS/nS6Ob5Y11Sj6RWrBSp8Bv/g6SBh0P+eXNWZS7dwu4dU5wqI8IFaJ
         6YQF+Ha31fENUeH0YAHwb6Ur+hUVKVQV0xsGCPGSJ9N5BTtbTkVgWnhthJuKFgd2Bs8x
         2V4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788451149; x=1789055949;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fqrjp7diFK7hTPI/YVRHNUU83H0HuCgE52mHERNgxw0=;
        b=BCPUr1cQ2LMaf/uDO1860/Mz7HB5KkciRGThhfXG6AucGRMyIkZFE+EjqgaayvFwyV
         YVaN2Oa+TAfB+7e7h61uCRFnF3ExzPgM5Sz1sv9gpdAWypmoppmiGVZQ7ILr2kNZR+3C
         du45BnJlk1slIWp2VjTCgNE2RRiyk9ZuPasXeqjT7WNR680bUkRlJmADDpRhbZEj8EmB
         2c1C0o7Mk7jsQF/7oydqXxHpuaujxchZ/NgBgAJ29Z4yQv6xPexniUH4pUZ+679GA1we
         GKN6wukZFRWcU6OWfhRQayC9MOHEWZpREW8dpkPM3KRC6ePARSKLLLbqmmHNaJwrHS62
         X5oQ==
X-Forwarded-Encrypted: i=1; AKwUvByb+KSd5VfOqPMYlkUT2im7W9/5Tv1YlKkLSHCJ4fUYJiMiBldgHVHfbX7to34kVlV7mjyG1g==@lists.infradead.org
X-Gm-Message-State: AFuF++lPEvZwL4o122KkS1uNMO7CosLmnG6F6oi9ZQC7GMDbvsJJn7W3
	8pOutP7yNP2f8yX3z2cGkAXGC8hl0tjFT90H2pCvNSr+q0yGLTSStZ5CuRDobEHF4WlQwV30buw
	myfSRUiaG5Rg68EkJVA==
X-Received: from edev1-n2.prod.google.com ([2002:a05:6402:a2c1:20b0:6a6:92c9:46e5])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:24cf:b0:6a6:32fa:54f5 with SMTP id 4fb4d7f45d1cf-6a6832f4708mr8089142a12.20.1788451148809;
 Thu, 03 Sep 2026 08:59:08 -0700 (PDT)
Date: Thu,  3 Sep 2026 15:59:06 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260903155907.1065681-1-tarunsahu@google.com>
Subject: [PATCH] memblock: use binary search to locate candidate regions
From: Tarun Sahu <tarunsahu@google.com>
To: dmatlack@google.com, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Pratyush Yadav <pratyush@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-mm@kvack.org, Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260903_085911_630699_DF0FE852 
X-CRM114-Status: GOOD (  14.95  )
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

Use binary search (memblock_bsearch_start) in memblock_add_range() and
memblock_isolate_range() to locate candidate regions instead of linearly
scanning from index 0.

Under heavy memory fragmentation (such as KHO page preservation registering
hundreds of thousands of disjoint folios), scanning from index 0 on every
insertion and isolation results in O(N^2) complexity, causing boot-time
memory retrieval to take several minutes (~268s for 393k pages).

Using binary search reduces the worst-case complexity to O(N log N)
(and O(N) for sequential appends), cutting KHO memory retrieval time
from ~268s to ~50ms.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 mm/memblock.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 9ce86349a29f..88940474b020 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -160,6 +160,11 @@ static __refdata struct memblock_type *memblock_memory = &memblock.memory;
 	     i < memblock_type->cnt;					\
 	     i++, rgn = &memblock_type->regions[i])
 
+#define for_each_memblock_type_from(i, memblock_type, rgn, start)	\
+	for (i = (start), rgn = &memblock_type->regions[i];		\
+	     i < memblock_type->cnt;					\
+	     i++, rgn = &memblock_type->regions[i])
+
 #define memblock_dbg(fmt, ...)						\
 	do {								\
 		if (memblock_debug)					\
@@ -591,6 +596,33 @@ static void __init_memblock memblock_insert_region(struct memblock_type *type,
 	type->total_size += size;
 }
 
+/**
+ * memblock_bsearch_start - Find the first region index where rend > base
+ * @type: memblock type to search
+ * @base: base physical address of the candidate range
+ *
+ * Returns the first region index that could potentially overlap @base.
+ */
+static int __init_memblock memblock_bsearch_start(struct memblock_type *type,
+						  phys_addr_t base)
+{
+	int mid, low = 0;
+	int high = type->cnt;
+
+	if (type->cnt && base >= type->regions[type->cnt - 1].base +
+				 type->regions[type->cnt - 1].size)
+		return type->cnt;
+
+	while (low < high) {
+		mid = (low + high) / 2;
+		if (type->regions[mid].base + type->regions[mid].size <= base)
+			low = mid + 1;
+		else
+			high = mid;
+	}
+	return low;
+}
+
 /**
  * memblock_add_range - add new memblock region
  * @type: memblock type to add new region into
@@ -651,7 +683,8 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 	base = obase;
 	nr_new = 0;
 
-	for_each_memblock_type(idx, type, rgn) {
+	for_each_memblock_type_from(idx, type, rgn,
+				    memblock_bsearch_start(type, base)) {
 		phys_addr_t rbase = rgn->base;
 		phys_addr_t rend = rbase + rgn->size;
 
@@ -827,7 +860,8 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
 		if (memblock_double_array(type, base, size) < 0)
 			return -ENOMEM;
 
-	for_each_memblock_type(idx, type, rgn) {
+	for_each_memblock_type_from(idx, type, rgn,
+				    memblock_bsearch_start(type, base)) {
 		phys_addr_t rbase = rgn->base;
 		phys_addr_t rend = rbase + rgn->size;
 
-- 
2.55.0.970.g62bdec98f9-goog


