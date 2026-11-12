Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B05606A880
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 10:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=AFLIvml3;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZlMHficu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=pQGWp2+wbRGJ+dC6yywFPAL6siNGmTYONc9+D5I1sYo=; b=AFLIvml3NzsQvv
	u9w/hcLdd2kYc7aOnErweZo0yYmptclsJeOAgsjCFrwQ3aGtvR82qrPuEmfI3c4IVJ5oLG0MU/m6s
	ud2YnltJEYHQuoOyHgu5SzqVY+Ye9T7dPAn+4AcizkHWsnqQVeA9/i1m3snjq2Tzdakfzo+DQyQZH
	H6JSZm77Hz2U+ri++30F7vrgBdhMG+6Pp9SoqD4TowL+tYOVro3dJ7UNO+gqTDPNu2C2LURdTvyI9
	PjwPwgjOvFYkmQkTFfgTSA+2+Sc3XR/eHwmwycIjPA3aZgzC7rhOZO+HSbDOlqOm3nZEUYu0R2yiJ
	OMhCBcSXFwlA6YnHm5Xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRSD5-00000009YK1-1s9B;
	Thu, 12 Nov 2026 10:39:15 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRSD2-00000009YIP-2Qgy
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 10:39:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 08F3742BA4;
	Thu, 12 Nov 2026 10:39:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D0E1F00A06;
	Thu, 12 Nov 2026 10:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794479951;
	bh=pQGWp2+wbRGJ+dC6yywFPAL6siNGmTYONc9+D5I1sYo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZlMHficuQjiF6MUrwFLyug43w6wSJLMXFXJ6483iQndymcjhhAAViAWQJbFhd4X/J
	 YAKZ4oVQkU4wzxZPKyo7Lh/L4k2hTlTn832X4g4pWzN1lbU0Q38BiDwIkPKyI1hSGT
	 3/GSdegMs9Pq+ao7m2WJjdCYNpwqOScJdnsGW44R9XeVQOT26uSeMVcv2tHvIFNLRi
	 7YXkh557+OZEOrvSZ5smwJXhKQOXvSVZChfyATRm2gOA4EpRr8SMb+FLoxjSUo32y4
	 4fWuopt3h3Ak5sPo6P/CwDjq/0AFdcLtt8VoojhKDgHjrJJZTmjg2Tw1TWWfzwvQUO
	 ry/DzWvp4wEGA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 12 Nov 2026 12:38:54 +0200
Subject: [PATCH v3 2/5] kho: walk bootmem areas in address order
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-kho-bootmem-sizing-v3-2-f0c8d00295d5@kernel.org>
References: <20261112-kho-bootmem-sizing-v3-0-f0c8d00295d5@kernel.org>
In-Reply-To: <20261112-kho-bootmem-sizing-v3-0-f0c8d00295d5@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Chen Pei <cp0613@linux.alibaba.com>, George Guo <guodongtai@kylinos.cn>, 
 Kexin Liu <liukexin@kylinos.cn>, Randy Dunlap <rdunlap@infradead.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Sourabh Jain <sourabhjain@linux.ibm.com>, kexec@lists.infradead.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, 
 Mukesh Pilaniya <mpilaniy@redhat.com>
X-Mailer: b4 0.16.1-dev
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

kexec_add_buffer() users may depend on the order in which memory holes are
searched. For instance, arm64 places the kernel bottom-up and then
requires the DTB to be above the kernel.

kho_walk_bootmem() walks the bootmem areas in the order they were
reserved, so if the kernel lands in a small area at the top of the memory
there is no room left for the DTB and kexec fails. For example, on an
arm64 VM with 2G of RAM and kho_bootmem=8M,64M,64M, the lowmem area is
reserved first at the top of the memory, the kernel image takes most of
it and kexec fails with

  kexec_file(Image): Could not find any suitable kernel location!

Sort the bootmem areas by address and walk them in ascending order, or in
descending order for top-down searches, like kexec_walk_resources() does.

Fixes: 3bdecc3c93f9 ("kexec: add KHO support to kexec file loads")
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Reviewed-by: Mukesh Pilaniya <mpilaniy@redhat.com>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 kernel/liveupdate/kexec_handover.c | 57 ++++++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 11 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index b30ba686cb301..df4a972a860da 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -26,6 +26,7 @@
 #include <linux/list.h>
 #include <linux/memblock.h>
 #include <linux/page-isolation.h>
+#include <linux/sort.h>
 #include <linux/unaligned.h>
 #include <linux/vmalloc.h>
 
@@ -826,6 +827,14 @@ bool kho_bootmem_overlap(phys_addr_t phys, size_t size)
 	return false;
 }
 
+static int __init kho_bootmem_cmp(const void *_a, const void *_b)
+{
+	const struct kho_bootmem *a = _a;
+	const struct kho_bootmem *b = _b;
+
+	return cmp_int(a->addr, b->addr);
+}
+
 /**
  * kho_reserve_bootmem - Reserve a contiguous chunk of memory for kexec
  *
@@ -910,6 +919,9 @@ static void __init kho_reserve_bootmem(void)
 	 */
 	kho_bootmem_cnt = i;
 
+	sort(kho_bootmem, kho_bootmem_cnt, sizeof(*kho_bootmem),
+	     kho_bootmem_cmp, NULL);
+
 	return;
 
 err_free_bootmem_areas:
@@ -2087,20 +2099,40 @@ int kho_fill_kimage(struct kimage *image)
 	return 0;
 }
 
-static int kho_walk_bootmem(struct kexec_buf *kbuf,
-			    int (*func)(struct resource *, void *))
+static int kho_bootmem_walk_one(struct kexec_buf *kbuf,
+				const struct kho_bootmem *area,
+				int (*func)(struct resource *, void *))
+{
+	struct resource res = {
+		.start = area->addr,
+		.end = area->addr + area->size - 1,
+	};
+
+	/* Try to fit the kbuf into our KHO bootmem region */
+	return func(&res, kbuf);
+}
+
+static int kho_bootmem_walk_top_down(struct kexec_buf *kbuf,
+				     int (*func)(struct resource *, void *))
 {
 	int ret = 0;
-	int i;
 
-	for (i = 0; i < kho_bootmem_cnt; i++) {
-		struct resource res = {
-			.start = kho_bootmem[i].addr,
-			.end = kho_bootmem[i].addr + kho_bootmem[i].size - 1,
-		};
+	for (int i = kho_bootmem_cnt - 1; i >= 0; i--) {
+		ret = kho_bootmem_walk_one(kbuf, &kho_bootmem[i], func);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
 
-		/* Try to fit the kimage into our KHO bootmem region */
-		ret = func(&res, kbuf);
+static int kho_bootmem_walk_bottom_up(struct kexec_buf *kbuf,
+				      int (*func)(struct resource *, void *))
+{
+	int ret = 0;
+
+	for (int i = 0; i < kho_bootmem_cnt; i++) {
+		ret = kho_bootmem_walk_one(kbuf, &kho_bootmem[i], func);
 		if (ret)
 			break;
 	}
@@ -2116,7 +2148,10 @@ int kho_locate_mem_hole(struct kexec_buf *kbuf,
 	if (!kho_enable || kbuf->image->type == KEXEC_TYPE_CRASH)
 		return 1;
 
-	ret = kho_walk_bootmem(kbuf, func);
+	if (kbuf->top_down)
+		ret = kho_bootmem_walk_top_down(kbuf, func);
+	else
+		ret = kho_bootmem_walk_bottom_up(kbuf, func);
 
 	return ret == 1 ? 0 : -EADDRNOTAVAIL;
 }

-- 
2.53.0


