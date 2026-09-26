Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D5BC9833A
	for <kexec@archiver.kernel.org>; Sat, 26 Sep 2026 09:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sTQndXxkIuwWKoVUm7RH0Lfp0eOzvHI6CoK2okedbuw=; b=pREm/dK9L4zuUyFOYyCqL/5Ii7
	WDfAuH8MVu3+6qp53Y19yshu0EwcXsfB74ceOeS0NG9Hk7rygKVWULa8nSg476pq/xC+9lh11/L8m
	neiBWesoytxO95b+zEbGF94jzhY3L0gvkIMrcPNISrBdcfSthPVLQePjNHk6YkFLSFuVRpzfaedEO
	mhCEVcBgOjcK6pAoJe4qCAXYOhEi0MJtw4yyONwidIRIYXddbKfs3k66AmvZpT372Gpyqh7itOo4U
	UPFK0NV6qqXmFj6/JQ8sZcMasuaJ9jtvb/NacyogQMVouIN62H9R5A7EVWebBFkRMQj1zG3QNYf0/
	k0ft2aiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAOeP-0000000FCdR-3YVm;
	Sat, 26 Sep 2026 09:24:57 +0000
Received: from mail-ed1-x548.google.com ([2a00:1450:4864:20::548])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAOeN-0000000FCcQ-0yqY
	for kexec@lists.infradead.org;
	Sat, 26 Sep 2026 09:24:56 +0000
Received: by mail-ed1-x548.google.com with SMTP id 4fb4d7f45d1cf-6a5d57a8d51so2020622a12.1
        for <kexec@lists.infradead.org>; Sat, 26 Sep 2026 02:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790414693; x=1791019493; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sTQndXxkIuwWKoVUm7RH0Lfp0eOzvHI6CoK2okedbuw=;
        b=UycT2wHasGtSlWbpcH+02qFpWLw8EwdJeqD6fPPfpWjz+MukMJfSVOXzPwuG5K7GzK
         6W1GQme+w0vgtqe9u1mTaovZi2v2UswUnTbkSL3flkLCgEo/XoCXr4Sig05b5cJBMZxS
         s7xlOGIFvzg5kSlkRQPlRc8Qn5nCAUMVpjqtp4A7PcgynK8/R6dnVD/aoyrtdYmbKzvQ
         CCA+l1MafL/piyKv53Fo3EK1bmsnV/cAs23zOvaKVgDJo/5+I15B7khTZgelWVTeAfbr
         JRNY7CqTN/P6H4Wb1jKlIL0gFylPYn759hrlDyE6PaNH8iFdArDOASrWUB6SeQ57PZCn
         djaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790414693; x=1791019493;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sTQndXxkIuwWKoVUm7RH0Lfp0eOzvHI6CoK2okedbuw=;
        b=i/FobRHJJSDfc/C2mb8v/u5kU2OhgTd92CwhwEo/V+wiOpfuyQ+Dm6EAdRuPxIUVpy
         s4CH/YjiHolwG4/su26Lhx0bldS2omYV06f7UQEHcb95EPVHHh+DkQT9VXGJvp/TouMh
         1b4OC2vUe/VZ3mN3PYS+Ys4Q1+RzGfFbbGClzmx9gjZfBElwKI5UhNSKNZvV42yNaeJR
         dbEdy71qg01PxgojHji7AAJYjranR+YkVjpu0CvFDdzHpNg7fd63gCX610tnQp0s29qs
         9QccNXHgMj3jdto42UCOD54edSRFiqDTMtWIObuTNqW4e7ormp7L/lPxx7+Z9A+POlae
         Le1A==
X-Forwarded-Encrypted: i=1; AKwUvBxadlYl9M3bSPVoEnvTR/+mjtFPyOIZU296gvFU78Rk1NRYZ3fLsy0ucezoMRHUq75JmL6LGw==@lists.infradead.org
X-Gm-Message-State: AFuF++n2Wra87IhkDmGyKCgH7rCgZhIBFbkPp1Zkwlexhd6AK+/I47ie
	+UJJr3htHbZq6SaotucTx5SzGaS/EbvwZwHDNO9Wb/fcNsNsISvq5iXhavY94iRhtVzVUxfE/vi
	YWqhin50R0pWWgNGKyw==
X-Received: from edbet5.prod.google.com ([2002:a05:6402:3785:b0:6ab:222:1e7f])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:23c7:b0:6a9:e7eb:f52f with SMTP id 4fb4d7f45d1cf-6aac90a9049mr5754388a12.28.1790414692533;
 Sat, 26 Sep 2026 02:24:52 -0700 (PDT)
Date: Sat, 26 Sep 2026 09:24:48 +0000
In-Reply-To: <20260926092448.4090401-1-tarunsahu@google.com>
Mime-Version: 1.0
References: <20260926092448.4090401-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260926092448.4090401-2-tarunsahu@google.com>
Subject: [PATCH v3 2/2] memblock: use binary search to locate candidate regions
From: Tarun Sahu <tarunsahu@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	dmatlack@google.com, Mike Rapoport <rppt@kernel.org>, kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, dev.jain@arm.com, 
	Pratyush Yadav <pratyush@kernel.org>, linux-mm@kvack.org, Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260926_022455_290589_79AE5E15 
X-CRM114-Status: GOOD (  15.34  )
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

 mm/memblock.c | 53 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 16 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 59dda7d085f3..87c71435c80c 100644
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
 
 	if (!size)
 		return 0;
@@ -644,8 +671,9 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 	 */
 	base = obase;
 	nr_new = 0;
+	start_idx = memblock_bsearch_start(type, base);
 
-	for (idx = 0; idx < type->cnt; idx++) {
+	for (idx = start_idx; idx < type->cnt; idx++) {
 		struct memblock_region *rgn = &type->regions[idx];
 		phys_addr_t rbase = rgn->base;
 		phys_addr_t rend = rbase + rgn->size;
@@ -809,7 +837,7 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
 					int *start_rgn, int *end_rgn)
 {
 	phys_addr_t end = base + memblock_cap_size(base, &size);
-	int idx;
+	int idx, start_idx;
 
 	*start_rgn = *end_rgn = 0;
 
@@ -821,7 +849,9 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
 		if (memblock_double_array(type, base, size) < 0)
 			return -ENOMEM;
 
-	for (idx = 0; idx < type->cnt; idx++) {
+	start_idx = memblock_bsearch_start(type, base);
+
+	for (idx = start_idx; idx < type->cnt; idx++) {
 		struct memblock_region *rgn = &type->regions[idx];
 		phys_addr_t rbase = rgn->base;
 		phys_addr_t rend = rbase + rgn->size;
@@ -2062,19 +2092,10 @@ void __init memblock_mem_limit_remove_map(phys_addr_t limit)
 
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
 
base-commit: 1f18d740165163910df64d3063e1ad31648bc5e0
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


