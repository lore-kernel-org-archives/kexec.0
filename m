Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C05BAC982D2
	for <kexec@archiver.kernel.org>; Fri, 18 Sep 2026 00:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yxuYFkClNtObVJTirGhxvNI3z/6AMlB4AtngbQawpYk=; b=Ew4LTzosmLsEiTmv4FREjOXl2L
	3115QgLhp2pXTLs230NN1lz8/73HSgm7zYmf/9zI0ivK9T4jOyOFpX1uzSZ9B/WlzZ4kdHSK6PdBL
	UpenOM84eDdRgY/RJHyXfzwKbtk0cirRr/TLUKSM37We6UudC2shiXQ/r04DKtch0wiub9/9iYc/3
	tULkoYCkD2mG/fRjcJgmI3xcIAUucm5fEBH44OI0OliR1xob3Np+Ai75HpJXrMktkUwv3ggc5/y97
	0Hr24crI1KNFEXUrPXEjlj0nma0+WJ9NXiv9ndcjPzmyfQhg5bznfrj0O99tdAY4uyQ2soRr9OWu0
	NHMaQDQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7MNM-0000000D19E-0Ggi;
	Fri, 18 Sep 2026 00:22:48 +0000
Received: from mail-ed1-x548.google.com ([2a00:1450:4864:20::548])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7MNJ-0000000D18I-3CRy
	for kexec@lists.infradead.org;
	Fri, 18 Sep 2026 00:22:46 +0000
Received: by mail-ed1-x548.google.com with SMTP id 4fb4d7f45d1cf-6a9cdcbe249so146347a12.2
        for <kexec@lists.infradead.org>; Thu, 17 Sep 2026 17:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789690962; x=1790295762; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yxuYFkClNtObVJTirGhxvNI3z/6AMlB4AtngbQawpYk=;
        b=lfxmGeexdTOqNPkBUSh31azRjgYJY2pL4vfiuhR4TVxj72OGgx2cw0NaVz0Ee0KYFu
         XPTWPKHJWHEcYJ3Xz83k7ANCsO5uDRzYh18c1G1+LGvQISaDcfu3jVa9ItxhFQLPwPXk
         5b2k/zUSzHpeLeZ/KZKDu4gSzW2GipWljW9+Jk28vxwq5QYmx0uQ6ohtk7yVzKJNpTyC
         f7/+efP/4TQvXJDKv3B9y0+36zU+M/bNd1Y1189mMehw2KiiYzfeRSP4Gh1gM7y8678C
         iG5OzmW/B64M7hRXZxEfVk48PwpQzeKZ/xFt1GielZ8WeW+bkTSUl2h934CBqdM3suK/
         WI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789690962; x=1790295762;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yxuYFkClNtObVJTirGhxvNI3z/6AMlB4AtngbQawpYk=;
        b=CQ+LsXFTq7YL/kmiceyrJTb/Za15fX4BOr4VQAVgmnz3nmpGsEadLqNwyI1/iRwzh8
         Q/6mB7i3DLhAC8M3zZyUan667ZeZlAGfVRJIqIDGVO6WM++dLHT7HDhGDSbq1bOYr6YI
         3XY7X4fVTSIg6oXlGw4QABD0Imq60NfLp7MR92rgv1CoEkR3WkhythX+GyuUTdMgHTTZ
         B9UAdKkEgi/NeXagymwROTH6BuY4tT0lh4Oh838lA/VqHbFtnEFeakveNf29NqdzPalD
         SdUq0qxsa6F1nPcO9KyXa9KSdvhiRYBQSyEUyhSROMDFZil+n7HZQ+an0fxfqTdQ7fej
         mPQQ==
X-Forwarded-Encrypted: i=1; AKwUvBxLGBfXgI56XEovoQvROgsbXrEdEAp6rphOZA6MLS2BnQJi0Hb6OROdGxOCEUDzYGFTfBzI5g==@lists.infradead.org
X-Gm-Message-State: AFuF++msLdBTFmCL8DdqaAcDASVGsjvtHr+N37cDZDQzxxXFoAoiGDrp
	vh+F3HgzDOCsii7/7nGLnX0dtOyZP22yXY3eOSqxLPjHSDki1ZUfIBB0UDdaq+/YdV/KgDL0369
	ZHgOGI9rlFqv7mi4+cQ==
X-Received: from ejsg22.prod.google.com ([2002:a17:906:69d6:b0:c29:ece4:d406])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3f87:b0:c26:19e3:e98e with SMTP id a640c23a62f3a-c2a1582bdfbmr81796266b.46.1789690961563;
 Thu, 17 Sep 2026 17:22:41 -0700 (PDT)
Date: Fri, 18 Sep 2026 00:22:38 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918002239.4024231-1-tarunsahu@google.com>
Subject: [PATCH v2 1/2] memblock: drop for_each_memblock_type() and open code
 its users
From: Tarun Sahu <tarunsahu@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	dmatlack@google.com, Mike Rapoport <rppt@kernel.org>, kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, dev.jain@arm.com, 
	Pratyush Yadav <pratyush@kernel.org>, linux-mm@kvack.org, Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260917_172245_815940_7B0FAD43 
X-CRM114-Status: GOOD (  11.49  )
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

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 mm/memblock.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 9ce86349a29f..5aae75d34dec 100644
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
@@ -651,7 +646,8 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 	base = obase;
 	nr_new = 0;
 
-	for_each_memblock_type(idx, type, rgn) {
+	for (idx = 0; idx < type->cnt; idx++) {
+		rgn = &type->regions[idx];
 		phys_addr_t rbase = rgn->base;
 		phys_addr_t rend = rbase + rgn->size;
 
@@ -827,7 +823,8 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
 		if (memblock_double_array(type, base, size) < 0)
 			return -ENOMEM;
 
-	for_each_memblock_type(idx, type, rgn) {
+	for (idx = 0; idx < type->cnt; idx++) {
+		rgn = &type->regions[idx];
 		phys_addr_t rbase = rgn->base;
 		phys_addr_t rend = rbase + rgn->size;
 
@@ -2198,7 +2195,8 @@ static void __init_memblock memblock_dump(struct memblock_type *type)
 
 	pr_info(" %s.cnt  = 0x%lx\n", type->name, type->cnt);
 
-	for_each_memblock_type(idx, type, rgn) {
+	for (idx = 0; idx < type->cnt; idx++) {
+		rgn = &type->regions[idx];
 		char nid_buf[32] = "";
 
 		base = rgn->base;
-- 
2.55.0.1082.g2b9226bbc0-goog


