Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24BC6082BE4
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=DA7uolWF;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OrV0p0IV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=kvZ5XnxdxIW2P/kVJf4H5CXZ0aIg/W594yfUcOxNZPc=; b=DA7uolWFZ18bfo
	1Mww5CYYqXlIz+1JBap+HzUqusHFQCxpnd8+6uR1oR9+vn18uggOnsrr/9tzmd7tu9dJkPWqeKAqW
	AsTl+jw9c7e3bnpcd8BVrqKKfaYWwr8gY2P6XaAQxw1xE35PYTgfAhyw+dThscxX953kBOUYYhems
	c/+2wm7E2gr0R1VZem6hB9PZb0VshptqrFDQ72Qyh3ElixFxRGQ4/EZF5ZP2WOUyFooUznGwnL/XZ
	Vsq4C00JtP9zS/uF0sKo+AgwpjmAtt64BmOvSlzU9lXIrs6/aBzmxlh3gm99d6vn3//bZ3iwbuHie
	SBk7pwr6XCWZ79e/obGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOeBp-000000066PF-2RmF;
	Wed, 04 Nov 2026 16:50:21 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOeBo-000000066Ng-0RRW
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 16:50:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D81E043887;
	Wed,  4 Nov 2026 16:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0316E1F00A15;
	Wed,  4 Nov 2026 16:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793811019;
	bh=kvZ5XnxdxIW2P/kVJf4H5CXZ0aIg/W594yfUcOxNZPc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OrV0p0IVAw9DP4Kokc9d6E9ta+ht4bkjrdGuDvM1eepif0lae0cEYg1sM1ZcXQBcg
	 J9ChDTB9CYfELh/48UhZe7Jxf5NNvFFccS8qFAyyInz3AYU8osJD+wFdgK5mN0JdDy
	 yKhGlLB7zLJvVMXF4Mw1WMkJAjRyLzml5wKH2/jdC5CuGTWAVia+MkEQ1tZwAhSoeQ
	 ooFzd/iHmeaG3rg4YpJcaL22VPZvae4mjVVqx6L6EumhzvpsiMCrbO9OnqD/PtN7LB
	 T+NlyZLKBSFgQdg94qXVHWFVJvR3ThloVy6yYcEftDrEbICo19QP4zcmf672CU9lSu
	 3Qt6m3gZnsg4A==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Wed, 04 Nov 2026 18:50:09 +0200
Subject: [PATCH v2 1/3] kho: walk bootmem areas in address order
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-kho-bootmem-sizing-v2-1-b0d1a834780f@kernel.org>
References: <20261104-kho-bootmem-sizing-v2-0-b0d1a834780f@kernel.org>
In-Reply-To: <20261104-kho-bootmem-sizing-v2-0-b0d1a834780f@kernel.org>
To: Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Chen Pei <cp0613@linux.alibaba.com>, George Guo <guodongtai@kylinos.cn>, 
 Kexin Liu <liukexin@kylinos.cn>, Sourabh Jain <sourabhjain@linux.ibm.com>, 
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
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
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 kernel/liveupdate/kexec_handover.c | 57 ++++++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 11 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 6f1f55fe31819..2ac5d94f33fd4 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -26,6 +26,7 @@
 #include <linux/list.h>
 #include <linux/memblock.h>
 #include <linux/page-isolation.h>
+#include <linux/sort.h>
 #include <linux/unaligned.h>
 #include <linux/vmalloc.h>
 
@@ -820,6 +821,14 @@ bool kho_bootmem_overlap(phys_addr_t phys, size_t size)
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
@@ -904,6 +913,9 @@ static void __init kho_reserve_bootmem(void)
 	 */
 	kho_bootmem_cnt = i;
 
+	sort(kho_bootmem, kho_bootmem_cnt, sizeof(*kho_bootmem),
+	     kho_bootmem_cmp, NULL);
+
 	return;
 
 err_free_bootmem_areas:
@@ -2081,20 +2093,40 @@ int kho_fill_kimage(struct kimage *image)
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
@@ -2110,7 +2142,10 @@ int kho_locate_mem_hole(struct kexec_buf *kbuf,
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


