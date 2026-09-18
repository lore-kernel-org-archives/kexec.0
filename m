Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAFA8C982D6
	for <kexec@archiver.kernel.org>; Fri, 18 Sep 2026 00:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2457T8NXpe+VYhyIx4NQQZX9J7v7gQmMrsUW0L2lVQ0=; b=3CmCmgPJKYsBhOPqwX0feihDCO
	WFbvpes4YWwDqwccxi8H2mP8r4bQrTf6rZNAGWhp7AtkxIp0doMCv02CldT0hydj0aF+o10FYrU04
	W2f7PQgiNkdc8vTvpL4037fHDiW5ytMspkEYoagTmOlqBf+YD6CB3ichxitp9LnV9ONk2LCNf3ajR
	WLnjUyhyiq4YGQbMbKl2uAgT3Pd1NiTvZpX+bGidiPniEU8WCELKlXBk1ftjQgcZh+qeTwoACDtxe
	rwpC4XfXYQ5KqJ9tQCCRF6L7koX4ufD+aEHdV3IG43MmV8mrsJUQXMUhLXWAeysZrnrSiXSl3gFnn
	g0DQmw9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7MNL-0000000D199-48Hb;
	Fri, 18 Sep 2026 00:22:47 +0000
Received: from mail-ej1-x646.google.com ([2a00:1450:4864:20::646])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7MNJ-0000000D18J-15qO
	for kexec@lists.infradead.org;
	Fri, 18 Sep 2026 00:22:46 +0000
Received: by mail-ej1-x646.google.com with SMTP id a640c23a62f3a-c293743f5cdso22841466b.0
        for <kexec@lists.infradead.org>; Thu, 17 Sep 2026 17:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789690963; x=1790295763; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2457T8NXpe+VYhyIx4NQQZX9J7v7gQmMrsUW0L2lVQ0=;
        b=fh/Hl5yASNUcGPQQREF40a7ovMZIZIenlgT068EjAbwpqLXOl2oclF35IlsS+ywkhI
         Fj0UZTR8EW7VASqr/LtShC57hylH5mrpMlawoaMJ2RfSktzp0vZNlEUvFbY2WDeX/3Zx
         e+fxmxt1v6yFG7etKOO0vmz3fmZQ30A6lRhsqjg6B+nphrll59W+e27wNVRJMyPKmThf
         UDOf39IsXizNfMmKBFIgcTmR7+GrUOcqSssUdVTcOwU5/fyUiVOWQn3oUd9h2LS2lsve
         gchUP6hyw6qBUgzqLxMiiTwR7NYgvbR7fXikNNgNJ6Ufou4RSA2/TKZCED/U+5OW4aQZ
         LQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789690963; x=1790295763;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2457T8NXpe+VYhyIx4NQQZX9J7v7gQmMrsUW0L2lVQ0=;
        b=XfCaLihooX6gTrHFxNHzoUdE/3zQ3X2wwkbkvezaUOUUnRElCRTkgAFzdfu5yoVJh8
         gNrCz6HStnvRcWWoi0KZOEKhQL5GS09j+19SmH7+k5MstxFctfNWyT/0/P+ZkvwfGR44
         8XDYPLb7QMD91a5Yaa43MgyNzJYnSRK6WJlS97fQUPMLGhVP/x3QpCkUOTPct+JmYzFl
         EkFFlNvfXIVb2Pr+2ybIJ5J7Z3+LmNifV8eGmULe6R9M/jV2dzcrorynuGNn7YkrSbeW
         XejjH8NmrwpyC3TyhUYD6IqNKYQODzXsbtExq8EdpaMZj6uWebpyWaMXYhvilVRrgeg5
         sy3A==
X-Forwarded-Encrypted: i=1; AKwUvBx3KiCzQ/eryfR05EPfSNJ4gSPTkC2A2TSJhZcuSKT+PhQZdqp6XqJYStpnJEVwQpcE26Q9Gw==@lists.infradead.org
X-Gm-Message-State: AFuF++kqTfnU3gkaewFltr5NJuKgIXvaOnmGOaE/rNMtjjCW9U2sNdt4
	1dugfx2XkBKvAJnn3Bqi8jt+fwAOwDMqPXFn/sV3YNO+RWxquvIXF/kdv99hKxYhVXaX+8u1YwG
	nSck8I+Dc9bsqh0QfIA==
X-Received: from ejcgo34.prod.google.com ([2002:a17:907:da2:b0:c29:de6c:6ff9])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3c96:b0:c26:30fa:7cf2 with SMTP id a640c23a62f3a-c2a157fbe2fmr84040766b.13.1789690962738;
 Thu, 17 Sep 2026 17:22:42 -0700 (PDT)
Date: Fri, 18 Sep 2026 00:22:39 +0000
In-Reply-To: <20260918002239.4024231-1-tarunsahu@google.com>
Mime-Version: 1.0
References: <20260918002239.4024231-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918002239.4024231-2-tarunsahu@google.com>
Subject: [PATCH v2 2/2] memblock: use binary search to locate candidate regions
From: Tarun Sahu <tarunsahu@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	dmatlack@google.com, Mike Rapoport <rppt@kernel.org>, kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, dev.jain@arm.com, 
	Pratyush Yadav <pratyush@kernel.org>, linux-mm@kvack.org, Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260917_172245_334601_57FC008C 
X-CRM114-Status: GOOD (  16.14  )
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

memblock_search() open codes the same binary search, so reimplement it on
top of the new helper.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 mm/memblock.c | 53 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 16 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 5aae75d34dec..00a8768de988 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -586,6 +586,33 @@ static void __init_memblock memblock_insert_region(struct memblock_type *type,
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
@@ -609,7 +636,7 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 	bool insert = false;
 	phys_addr_t obase = base;
 	phys_addr_t end = base + memblock_cap_size(base, &size);
-	int idx, nr_new, start_rgn = -1, end_rgn;
+	int idx, start_idx, nr_new, start_rgn = -1, end_rgn;
 	struct memblock_region *rgn;
 
 	if (!size)
@@ -645,8 +672,9 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 	 */
 	base = obase;
 	nr_new = 0;
+	start_idx = memblock_bsearch_start(type, base);
 
-	for (idx = 0; idx < type->cnt; idx++) {
+	for (idx = start_idx; idx < type->cnt; idx++) {
 		rgn = &type->regions[idx];
 		phys_addr_t rbase = rgn->base;
 		phys_addr_t rend = rbase + rgn->size;
@@ -810,7 +838,7 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
 					int *start_rgn, int *end_rgn)
 {
 	phys_addr_t end = base + memblock_cap_size(base, &size);
-	int idx;
+	int idx, start_idx;
 	struct memblock_region *rgn;
 
 	*start_rgn = *end_rgn = 0;
@@ -823,7 +851,9 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
 		if (memblock_double_array(type, base, size) < 0)
 			return -ENOMEM;
 
-	for (idx = 0; idx < type->cnt; idx++) {
+	start_idx = memblock_bsearch_start(type, base);
+
+	for (idx = start_idx; idx < type->cnt; idx++) {
 		rgn = &type->regions[idx];
 		phys_addr_t rbase = rgn->base;
 		phys_addr_t rend = rbase + rgn->size;
@@ -2064,19 +2094,10 @@ void __init memblock_mem_limit_remove_map(phys_addr_t limit)
 
 static int __init_memblock memblock_search(struct memblock_type *type, phys_addr_t addr)
 {
-	unsigned int left = 0, right = type->cnt;
+	int idx = memblock_bsearch_start(type, addr);
 
-	do {
-		unsigned int mid = (right + left) / 2;
-
-		if (addr < type->regions[mid].base)
-			right = mid;
-		else if (addr >= (type->regions[mid].base +
-				  type->regions[mid].size))
-			left = mid + 1;
-		else
-			return mid;
-	} while (left < right);
+	if (idx < type->cnt && addr >= type->regions[idx].base)
+		return idx;
 	return -1;
 }
 
-- 
2.55.0.1082.g2b9226bbc0-goog


