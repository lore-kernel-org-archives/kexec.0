Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3888C624DB
	for <kexec@archiver.kernel.org>; Fri,  4 Sep 2026 02:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ascp5NYA1knU/Tz2E2qXWiVQS08FjekVudivbuxitpc=; b=b7WLWb5tg77ABjUVWI3bEzRhlq
	a4NpTUrj21+aTxK3COERV/xiDj0VNUtXRVKhvntiPYoztlxHF3P9IZRDS1cy4jIQhU7L8Ujs97jmP
	84vbtb1OEmdC4vFFI0I3IkIr6SdKZK0WgJs5kZnQkpgtJrlOzzyv9O9kb5GkTQhyG8r8WAF0KtRe9
	hiz43AcVfZ3cz4BzMRIwAy6d7fHMQxDNHRzXikqnUeMkgpmFrfinFF0rTeYIHZRF2gMbtFfWiONaq
	VcPqZu0d+XoBtjMdXJo9QuqcPYzUV7xo4MxZwkRSrXNBwbj1TGyOcozcgEJtZHFL9D3nH8IUcIjvE
	VG18Q2zQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2K1W-00000000tci-1m8V;
	Fri, 04 Sep 2026 02:51:26 +0000
Received: from out-216.mta0.migadu.com ([2001:41d0:1004:224b::d8] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2K1U-00000000tc0-0qIR
	for kexec@lists.infradead.org;
	Fri, 04 Sep 2026 02:51:25 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=R8hp6kP4f0zaqRkny35jyzu+c4C1uLJKHJHYlP03c7k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788490278; v=1; x=1789095078;
 b=Gcks6LRnqD3FVoHEn4u6xsXUFyG1bsuk3j4ANwcrU0YvSgb5U7CbaQPJonN7AcuKGeSVdnYw
 llssHOWY6i8W1aYxc8Mt3h1A61nARgfw/YDui3dN89wRIUhToNlJIYoTNNDcek8pdXfiabxf90s
 9hpWo+BlMqatfkEWXBaFO580=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 0b116a6762a44da4;
	Fri, 04 Sep 2026 02:51:18 +0000
X-Mizu-Trace-ID: 0b116a6762a44da4
X-Migadu-Flow: FLOW_OUT
From: George Guo <dongtai.guo@linux.dev>
To: rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org
Cc: graf@amazon.com,
	changyuanl@google.com,
	akpm@linux-foundation.org,
	chenhuacai@kernel.org,
	liukexin@kylinos.cn,
	guodongtai@kylinos.cn,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] liveupdate: kho: calculate per-node scratch sizes before allocation
Date: Fri,  4 Sep 2026 10:51:01 +0800
Message-ID: <20260904025101.9959-1-dongtai.guo@linux.dev>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260903_195124_383791_B5F4F52C 
X-CRM114-Status: GOOD (  13.70  )
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

From: George Guo <guodongtai@kylinos.cn>

The default percentage-based policy sizes scratch areas from the current
kernel's MEMBLOCK_RSRV_KERN footprint. This is a reasonable heuristic for
predicting the early memory demand of the next kernel.

scratch_size_update() calculates the lowmem and global sizes before either
area is allocated. However, kho_reserve_scratch() calculates each per-node
size only after allocating the lowmem and global areas. Since memblock
allocations are marked MEMBLOCK_RSRV_KERN, the per-node calculation
includes those newly allocated scratch areas and scales them again.

This feedback substantially inflates the per-node request. On a 1 GiB
LoongArch QEMU guest, the relevant reservation baseline is about
98.45 MiB. With the default 200% scale and 32 MiB alignment, the old
ordering allocates 224 MiB of lowmem scratch, then requests 672 MiB for
node 0, for a total of 896 MiB. The node allocation fails and KHO is
disabled. The same incorrect calculation is hidden on the tested 1 GiB
x86 guest because its baseline is smaller and its memory map can satisfy
the inflated request.

Calculate and save all per-node sizes in the scratch descriptors before
reserving any scratch areas, then use the saved sizes during allocation.
This keeps the percentage heuristic while preventing scratch memory from
becoming input to the sizing of more scratch memory. On the LoongArch
guest, the aligned total is reduced from 896 MiB to 448 MiB.

The KHO vmtest passes on 1 GiB LoongArch and x86 QEMU guests with this
change.

Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
Reported-by: Kexin Liu <liukexin@kylinos.cn>
Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 kernel/liveupdate/kexec_handover.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 7c4d86daf86d..39f489a258d9 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -847,6 +847,17 @@ static void __init kho_reserve_scratch(void)
 		goto err_disable_kho;
 	}
 
+	/*
+	 * Calculate the per-node sizes before reserving any scratch areas.
+	 * memblock allocations are marked MEMBLOCK_RSRV_KERN, so calculating
+	 * them later would count the lowmem and global scratch areas as kernel
+	 * allocations and scale them again.
+	 */
+	i = 2;
+	for_each_node_state(nid, N_MEMORY)
+		kho_scratch[i++].size = scratch_size_node(nid);
+	i = 0;
+
 	/*
 	 * reserve scratch area in low memory for lowmem allocations in the
 	 * next kernel
@@ -880,7 +891,7 @@ static void __init kho_reserve_scratch(void)
 	 * memoryless nodes, as we can not allocate scratch areas there.
 	 */
 	for_each_node_state(nid, N_MEMORY) {
-		size = scratch_size_node(nid);
+		size = kho_scratch[i].size;
 		addr = memblock_alloc_range_nid(size, SCRATCH_ALIGNMENT_BYTES,
 						0, MEMBLOCK_ALLOC_ACCESSIBLE,
 						nid, true);
-- 
2.53.0


