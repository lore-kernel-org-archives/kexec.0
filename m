Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC445CA6016
	for <kexec@archiver.kernel.org>; Thu,  8 Oct 2026 19:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lziypnwRraIlsorF0VwfpRYSW789AnxqR1Fmirni4Xo=; b=Tgavb04i3Ik8CV35DDyw1MFmt6
	p50qpBVGD7Crnraun3QpLOEjP5kY6WahgRQBEecH5QeF+FIyZVLiSst1YmzYz8M8QSesMWat9vU10
	Pl77L6N6xY/ad0mHXU4IcNQd6oDsjNjWYIHNMGrY8R8gaF9WDJB0jU1cAu70Z3C+HBQwvuPPuRf9y
	1qaeCYBqGrfYhVvXxNKrA6F9PHamqVtEeS+er3a4X+lbeCF8ZsxsrW0m5XPk1xpNHl0P5yGbeBSgJ
	4AeiJxrRO3EVpaA1ZYWqXUPRYi0wD1E82aFDefxGdJQo/9UUSj1pNE1LOzh2e1JDMWrs0xaD1K65+
	asB1ofYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEtTp-00000004tpG-1wlU;
	Thu, 08 Oct 2026 19:08:37 +0000
Received: from mail-ed1-x545.google.com ([2a00:1450:4864:20::545])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEtTm-00000004tob-1bcg
	for kexec@lists.infradead.org;
	Thu, 08 Oct 2026 19:08:35 +0000
Received: by mail-ed1-x545.google.com with SMTP id 4fb4d7f45d1cf-6aaff9e86b0so6178971a12.1
        for <kexec@lists.infradead.org>; Thu, 08 Oct 2026 12:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791486511; x=1792091311; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lziypnwRraIlsorF0VwfpRYSW789AnxqR1Fmirni4Xo=;
        b=N4ycMemW6OdWQBfiB+w4oDGVpr5mSNlh7k92rwRBHXZH+SbzGcgzaCXpFKZM1d+Mq7
         iPXmrofdRE+kD7fUo+jdJOw7CrHxMzhOwlYkoz307K1Bzug5bTE5dV1pXQ8mAb3Xbew7
         Cg+bTpMm+RwQCcFuNwSK+sPfPO4eBAp9J+1ZCEB6J3IRuM/PUHfGhvsyObT3MRPRgV6n
         XrdtGAP6cd1hUp3RPXEHijgz0msWhwZs6d4vT6PAagIKE4raOdOpo05QX9nbmTcb/agC
         aPuJwnq/1EZPyKHbI3X2y+46f85uEn9jCnUrL9qsI7+DwAz5Zgf+KMOhYaWhe65Tcmjo
         Y+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791486511; x=1792091311;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lziypnwRraIlsorF0VwfpRYSW789AnxqR1Fmirni4Xo=;
        b=w2kt6XmE2OzKfIjbPp5SX+nE2YdfOMV3XkhZ1xc3V+3+5f7WiK1r7+Gw9z4doBuv8v
         UKbWuCI/fhGv0UHV8MJ8Q7MRZ7Ew5RXsfYHW/pr1jglq6yYwFZ5hncYbo5i52etqF5Ce
         zLtL6eFum5WTbDE0sUYvLTDU3e0k8jzniv9ACYlc9Vbiheb3JcNchYvfLTAZFdlyh5+z
         7jRA/hYADe/VHfk7AudEtbEcgxjJbJ4VmjFGV8ZpVwAtLiEz/QAopz9lzyj+K8apcGjR
         MhW/f5/o6h44ZDBN8KXpeTe8CcoGpgm0m89e8Ew94E+HMN3FuA3LHstUklUZPeuCNNC1
         Jqhw==
X-Gm-Message-State: AFq9FYIk+Lh11MmVBzrXr8l6GRIR6rDR3u7WyU8O3ZA9KwpSn6tiKjju
	WBD3ob0TJXWCvg1AMac0AnqnH1HGsTk97rBwE5QEQXjXKYxJaMaEA/4COI0PZnEjrLqDeRmxV/I
	UOip5R509uRt8i2TQrg==
X-Received: from edl6-n2.prod.google.com ([2002:a05:6402:4246:20b0:6aa:e587:e1c1])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:3211:b0:6aa:edb3:d687 with SMTP id 4fb4d7f45d1cf-6aff38f1e95mr6238564a12.15.1791486510254;
 Thu, 08 Oct 2026 12:08:30 -0700 (PDT)
Date: Thu,  8 Oct 2026 19:08:27 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261008190828.3221718-1-tarunsahu@google.com>
Subject: [PATCH v4 1/2] memblock: drop for_each_memblock_type() and open code
 its users
From: Tarun Sahu <tarunsahu@google.com>
To: dmatlack@google.com, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pratyush Yadav <pratyush@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261008_120834_473395_4998C377 
X-CRM114-Status: GOOD (  12.65  )
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
-- 
2.56.0.385.gd3acb90ef8-goog


