Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C28CC98332
	for <kexec@archiver.kernel.org>; Sat, 26 Sep 2026 09:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=z4j7omQNB+TmgxmIXBVcLYQY7ezzfW8m8OBFfXrJ8Kk=; b=IUlGDKNBGrQfVtVBwkeyYvMQYQ
	0QlXJPXl9EqIK1vN2ukqgvhjddWBrPPLgpd7W7nbx3l4Afz5yYGKNSa5YfgNzEY1u+thjWDvSWM9j
	LbjvwzGqM6QMvbiyziDprqEJex88zkVBOnTDIjLOn8cTVZqkFIoen1rlfOE8Hyj1BDn9AZAjCvtjl
	8gV0A87tCd5Mgrc5H/Iw58sQVegR9gDfTz5TC/uNjyLAqcKJOIX2nZSBHvQ3S+xuxfcHpy/Lt0x8w
	Dm167Hq5rIx5bwZkkBaHuyljwL3No4yWNEaeNA5iB6c6TluyRJ6kV8cWyvzxroUPSgwKiUdFmEaLO
	2f5GJ1Sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAOeO-0000000FCd6-2wPW;
	Sat, 26 Sep 2026 09:24:56 +0000
Received: from mail-ej1-x647.google.com ([2a00:1450:4864:20::647])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAOeM-0000000FCcN-18LL
	for kexec@lists.infradead.org;
	Sat, 26 Sep 2026 09:24:55 +0000
Received: by mail-ej1-x647.google.com with SMTP id a640c23a62f3a-c2cad6a0fb0so61746266b.0
        for <kexec@lists.infradead.org>; Sat, 26 Sep 2026 02:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790414691; x=1791019491; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z4j7omQNB+TmgxmIXBVcLYQY7ezzfW8m8OBFfXrJ8Kk=;
        b=msZGfc4tXMEz4eOTM8oLY9snwOO7rpIa3ZsY050r9eWOmxeceaGZqu4xewPhR4b+Ke
         kQErAY1IEpDKlUrpA2yZoHW/VyJ0TJX6zZAmSQ349EEUC16fD+UWz9sJtrlyN3uLURjj
         dXOOLrK6tby1b+YvXVAMu4siN2fyNeM4peV/pMHRHE6zfjg8fnmpghmCTAmcNGVnSgvV
         zkyyBK4hMbbs4WPCN3O/S5EmF3xddFW/jD64FFYLbh1z2gqINX3ASfCvhIowR0Q6HwA9
         inYfiaVhpAzbUaOrRH0Scd56HNbpDeylQMfMrkoyYFPDkW5EnI79DkG9g4DQqCJIOO6c
         qeVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790414691; x=1791019491;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z4j7omQNB+TmgxmIXBVcLYQY7ezzfW8m8OBFfXrJ8Kk=;
        b=YIP2iOmzqmvW8kUSEMX7wy6ACdV1kXcqgP/MV8mz6rIwvL09jt1i19N5XNLcT1QYVR
         KrC//5SxyUUreA9NkZqLFRFcRU7pfnHiOCNvNy4vt8eN1wYR7rOhEGRZX2H8/gAY48rR
         /phSRB+euvKxFjtdD5cODz2zkmA7pqycE2wZ0TPjfi/d/DnFTn0dLb8P7ZLse3c/t/Bq
         5l+n+QGtqoDbXRbHMIUrqyOlvczM688AeT5NU1QjISmc6wJKoh2aacvqoAcWWL1r59zm
         rz73PbhUpVbfsyzG0lAhWwoG/ISm8z40fDjoY+o3bJIi/dw+nSYzfsVYgojH36+B3wzA
         xBZw==
X-Forwarded-Encrypted: i=1; AKwUvBw0X1bJz/WAfTJlrGFy3C0nJd5qeDA+3qFHzW5Ud8TBY1x3+3qCo+VPFw5BoP/hobUtg2UdYg==@lists.infradead.org
X-Gm-Message-State: AFuF++kfImk585yab/0kUSrk/SkZQrmarp6AAGWDLIBHk5roJwEh4Btr
	HxPWSOjPL9bk5rHjVdPNfH6/i5ZIf1/jVg1rOzrXBHZYWT4WWp9fw2saQuUpQCg5MhbDHYdqD6x
	zEELPu0uTWNyz/gt9OA==
X-Received: from ejv16.prod.google.com ([2002:a17:906:3090:b0:c2d:beff:b397])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:6c17:b0:c29:f5d8:9c71 with SMTP id a640c23a62f3a-c2ac223e35emr724660966b.32.1790414691194;
 Sat, 26 Sep 2026 02:24:51 -0700 (PDT)
Date: Sat, 26 Sep 2026 09:24:47 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260926092448.4090401-1-tarunsahu@google.com>
Subject: [PATCH v3 1/2] memblock: drop for_each_memblock_type() and open code
 its users
From: Tarun Sahu <tarunsahu@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	dmatlack@google.com, Mike Rapoport <rppt@kernel.org>, kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, dev.jain@arm.com, 
	Pratyush Yadav <pratyush@kernel.org>, linux-mm@kvack.org, Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260926_022454_357322_E5DA2023 
X-CRM114-Status: GOOD (  12.13  )
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

for_each_memblock_type() always starts the iteration at index 0 and its
body is a trivial 'for' loop, so it hides very little. It also gets in
the way of iterating from an arbitrary index, which the next patch
needs.

Remove the macro and open code its three users: memblock_add_range(),
memblock_isolate_range() and memblock_dump(). While at it, move the
region pointer into the loop body scope.

No functional change.

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
v2 -> v3:
- Move declaration of 'rgn' into loop body scope in memblock_add_range(),
  memblock_isolate_range(), and memblock_dump()
- Add Reviewed-by: Pratyush Yadav <pratyush@kernel.org>.

 mm/memblock.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index f5aaa38cfa31..59dda7d085f3 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -155,11 +155,6 @@ struct memblock_type physmem = {
  */
 static __refdata struct memblock_type *memblock_memory = &memblock.memory;
 
-#define for_each_memblock_type(i, memblock_type, rgn)			\
-	for (i = 0, rgn = &memblock_type->regions[0];			\
-	     i < memblock_type->cnt;					\
-	     i++, rgn = &memblock_type->regions[i])
-
 #define memblock_dbg(fmt, ...)						\
 	do {								\
 		if (memblock_debug)					\
@@ -615,7 +610,6 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 	phys_addr_t obase = base;
 	phys_addr_t end = base + memblock_cap_size(base, &size);
 	int idx, nr_new, start_rgn = -1, end_rgn;
-	struct memblock_region *rgn;
 
 	if (!size)
 		return 0;
@@ -651,7 +645,8 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 	base = obase;
 	nr_new = 0;
 
-	for_each_memblock_type(idx, type, rgn) {
+	for (idx = 0; idx < type->cnt; idx++) {
+		struct memblock_region *rgn = &type->regions[idx];
 		phys_addr_t rbase = rgn->base;
 		phys_addr_t rend = rbase + rgn->size;
 
@@ -815,7 +810,6 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
 {
 	phys_addr_t end = base + memblock_cap_size(base, &size);
 	int idx;
-	struct memblock_region *rgn;
 
 	*start_rgn = *end_rgn = 0;
 
@@ -827,7 +821,8 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
 		if (memblock_double_array(type, base, size) < 0)
 			return -ENOMEM;
 
-	for_each_memblock_type(idx, type, rgn) {
+	for (idx = 0; idx < type->cnt; idx++) {
+		struct memblock_region *rgn = &type->regions[idx];
 		phys_addr_t rbase = rgn->base;
 		phys_addr_t rend = rbase + rgn->size;
 
@@ -2194,11 +2189,11 @@ static void __init_memblock memblock_dump(struct memblock_type *type)
 	phys_addr_t base, end, size;
 	enum memblock_flags flags;
 	int idx;
-	struct memblock_region *rgn;
 
 	pr_info(" %s.cnt  = 0x%lx\n", type->name, type->cnt);
 
-	for_each_memblock_type(idx, type, rgn) {
+	for (idx = 0; idx < type->cnt; idx++) {
+		struct memblock_region *rgn = &type->regions[idx];
 		char nid_buf[32] = "";
 
 		base = rgn->base;

base-commit: 1f18d740165163910df64d3063e1ad31648bc5e0
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


