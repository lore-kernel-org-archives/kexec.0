Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA56ACA6014
	for <kexec@archiver.kernel.org>; Thu,  8 Oct 2026 19:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p7HbPFLbPRXHp9XhuAZ/3vm7gntFtncf0PzNuO46BI0=; b=0FjxL2W08omqBTn1izG+F/i5sa
	ci/U0Vw6PPupethsI8V12TboQGiZdrFjTYmwFjZQp0jMTjp8DAVqss77Xvfva1XYK7nZ3CTnricpC
	xr5OXuZG7c8B3LO1RudDKZckD++rSvL6axvoOND5g17DKwRhPe/1NAfNO1WG38WYvPk60kKv/jNlu
	wWS5Qhb4gsWP5wP3TKVNjM6MHe1Vz9x75GcT3ZbW6LEP1txSQUsLgl+vHVG6uN9dX+2DasF7Cg+ZC
	O2/ejdoct4C4JLkTgcLb+gm7TqLSXIqLuCSmk+0UrYQfb1qTG9/ukpd7zoHBYCrdobzrpb3QvYvHk
	qa87gCrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEtTp-00000004tpL-2EmF;
	Thu, 08 Oct 2026 19:08:37 +0000
Received: from mail-ed1-x545.google.com ([2a00:1450:4864:20::545])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEtTn-00000004toc-1MFv
	for kexec@lists.infradead.org;
	Thu, 08 Oct 2026 19:08:36 +0000
Received: by mail-ed1-x545.google.com with SMTP id 4fb4d7f45d1cf-6a99c6e4d78so1358107a12.0
        for <kexec@lists.infradead.org>; Thu, 08 Oct 2026 12:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791486513; x=1792091313; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p7HbPFLbPRXHp9XhuAZ/3vm7gntFtncf0PzNuO46BI0=;
        b=kA7zb4hPU/FnDS2u5OYtduCNDDKp/INa/BOX8/W7ZUU5a977L8SBNa+CF/wjkLH+cd
         bPp6plmXb3p0o00c5vCU9NvInKi76SS6GL0jlSEZA2uCmxdL31Nz2gA5MJHZnHicD8e+
         gTB7w+ctCir0+nLCJvwJV7GKdR/Az1G2Jcl3/ZuUZN8gpgvJs95156tUaUNL6BMcsftJ
         Kf6FlAiVv9d9fCF4/1loctfHzoJKVXzSk16OKgtbyq9yesFGFtjlBXkQbsQ1oJNQY4x1
         31hyxcRJP2P+Vl5vvpEQiNUkjed08aJAJUkejS/m6xObB8v2Y03Z+4UpwNY7PEkArGbI
         EZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791486513; x=1792091313;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p7HbPFLbPRXHp9XhuAZ/3vm7gntFtncf0PzNuO46BI0=;
        b=oS4EdS1STfsGrVvWU+JfzghBjloH1szLDMBo/WqrG01P7WIxSB+Aq7XvmQe43tvdxH
         MAr2hSidbt/vb7xzmM/QOApW+cQzObe5ISoTg9uhD4NaIch04F22vkzcVvIxIJgxHrK8
         ItIhUDSBCTtur1ZFHPovtSOKfn0TY9Weqtmv6ZvpyLmw3PBLe5msxuVQasvEZfN9oW1z
         fVM2TV3IhouWdvS468yO0hzacfTAUM/wjZSVe75fBdNLleoTMw//Jq9ZM4QqPm8hzZ9C
         qlmVZop4qgSyO+dZq6TF88BZ8ldenaY/X7UEf8z395eyTfr6TSf3iNIRjV3oTLzsmStJ
         OQVA==
X-Gm-Message-State: AFq9FYK5Ep+cr5nJjdT0mytHW9yTrVlA478sbnMrLAiO9ka2t7SaB+hN
	qWPQQ8BtRFekX616XkujMz+xGRbC7xoKI8eDjwZPn+A10BTgwpkZoWlg2m4OaKPOSbFeosjPH9o
	quiqPXk0D24oBIMlKQg==
X-Received: from edbgy14.prod.google.com ([2002:a05:6402:5bce:b0:6ac:b91c:a379])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:50c9:b0:6af:a270:b2a7 with SMTP id 4fb4d7f45d1cf-6b0118ea2damr3315575a12.0.1791486512418;
 Thu, 08 Oct 2026 12:08:32 -0700 (PDT)
Date: Thu,  8 Oct 2026 19:08:28 +0000
In-Reply-To: <20261008190828.3221718-1-tarunsahu@google.com>
Mime-Version: 1.0
References: <20261008190828.3221718-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261008190828.3221718-2-tarunsahu@google.com>
Subject: [PATCH v4 2/2] memblock: use binary search to locate candidate regions
From: Tarun Sahu <tarunsahu@google.com>
To: dmatlack@google.com, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pratyush Yadav <pratyush@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261008_120835_380808_DBFCCC2A 
X-CRM114-Status: GOOD (  15.26  )
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

Using binary search reduces the candidate search complexity to O(log N)
(from O(N)), cutting KHO memory retrieval time from ~268s to ~50ms.

memblock_search() open codes the same binary search, so reimplement it on
top of the new helper.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
---
 mm/memblock.c | 45 +++++++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 59dda7d085f3..614d0a55dd70 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -586,6 +586,29 @@ static void __init_memblock memblock_insert_region(struct memblock_type *type,
 	type->total_size += size;
 }
 
+/**
+ * __memblock_search - Find the first region index where rend > base
+ * @type: memblock type to search
+ * @base: base physical address of the candidate range
+ *
+ * Returns the first region index that could potentially overlap @base.
+ */
+static int __init_memblock __memblock_search(struct memblock_type *type,
+						  phys_addr_t base)
+{
+	int mid, low = 0;
+	int high = type->cnt;
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
@@ -644,8 +667,9 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 	 */
 	base = obase;
 	nr_new = 0;
+	idx = __memblock_search(type, base);
 
-	for (idx = 0; idx < type->cnt; idx++) {
+	for (; idx < type->cnt; idx++) {
 		struct memblock_region *rgn = &type->regions[idx];
 		phys_addr_t rbase = rgn->base;
 		phys_addr_t rend = rbase + rgn->size;
@@ -821,7 +845,9 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
 		if (memblock_double_array(type, base, size) < 0)
 			return -ENOMEM;
 
-	for (idx = 0; idx < type->cnt; idx++) {
+	idx = __memblock_search(type, base);
+
+	for (; idx < type->cnt; idx++) {
 		struct memblock_region *rgn = &type->regions[idx];
 		phys_addr_t rbase = rgn->base;
 		phys_addr_t rend = rbase + rgn->size;
@@ -2062,19 +2088,10 @@ void __init memblock_mem_limit_remove_map(phys_addr_t limit)
 
 static int __init_memblock memblock_search(struct memblock_type *type, phys_addr_t addr)
 {
-	unsigned int left = 0, right = type->cnt;
-
-	do {
-		unsigned int mid = (right + left) / 2;
+	int idx = __memblock_search(type, addr);
 
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
2.56.0.385.gd3acb90ef8-goog


