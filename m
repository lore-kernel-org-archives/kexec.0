Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153D86082BFF
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 16:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qmfDjpd1;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mn1ozcrf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Og6DL/XuMfc+HEcGtspUv6YSe8N3e770jx9UfiUFD4A=; b=qmfDjpd1I5uynE
	ccUJ+dctWkNh0Lsj7JUo0DG08iw17ZtC/3sqRqsaI8gEhTEgyEEU2O0g+erbvTT9UQZlOf9Kv1AYs
	/ltmgWXqe2t1OrkkzCi5gX6AlhwLG3qYIJkCjV2V9HO9TAIgWlKuFqcILp3fpJ8QKqDRD0KQ4NTKG
	w2YW81Kk01ZdzhOzKNfCaaGDf6w36NcSu/mHR8RYub/HhfBt9auqne6z2D8i39X6ObkMVbS5ZASdV
	c8de9/JudZUsOEL55IhoektTWGL/+kZF/SNEVt6ha8P0qKqX6c2wrw4/QcbeLShcgpWEIprrhMMsq
	UQE2o9+BETpR8TKnts+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOeBs-000000066TO-3AcV;
	Wed, 04 Nov 2026 16:50:24 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOeBr-000000066S0-3gAM
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 16:50:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 55DF160AAB;
	Wed,  4 Nov 2026 16:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A201F0093A;
	Wed,  4 Nov 2026 16:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793811023;
	bh=Og6DL/XuMfc+HEcGtspUv6YSe8N3e770jx9UfiUFD4A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Mn1ozcrfbB74kUJLwIRXRLl6Q+s1pUFhT36GwRuOEzoCaZFwhSv+h+zuN5BDmf9qF
	 ZtGBf952ZuwVhX6OyaO1+Zj1L93iLrN5Nmd4+KJj27+BVwZWw8NsCucDMHEVb8Sb/S
	 1NiOGu7hTF/LbjwmmTNXWDhWQuN2Jipom1/nmo0c2puVYzTsNxwVcwpVW2La3BmsQw
	 oU8hqQwJJqibpZhabMTQoOMmFfm8SqBBR3+PE2bsO/cYB9pAStnoQv21IsN6F6GAiT
	 bw7Cj3PrxLNiG+/zGg6sSraBo7Hyvb+sKLIhSC5/AF1gSA67qfzYb2ts2Pk62lHTCj
	 ZzmedIlaafuEQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Wed, 04 Nov 2026 18:50:10 +0200
Subject: [PATCH v2 2/3] kho: skip zero-sized lowmem and global bootmem
 areas
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-kho-bootmem-sizing-v2-2-b0d1a834780f@kernel.org>
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

The lowmem and the global bootmem areas can have zero size, for example
when none or all of the memory is below ARCH_LOW_ADDRESS_LIMIT, or when
either of those areas is explicitly set to zero with kho_bootmem=.

For a zero-sized allocation memblock returns an address without reserving
anything, and that empty area is recorded in kho_bootmem. If there is no
memory below ARCH_LOW_ADDRESS_LIMIT, allocation of the empty lowmem area
fails and KHO gets disabled.

Extract a helper that checks for zero size and allocates memory from
memblock, and use it to skip empty areas the same way as empty per-node
areas are skipped.

Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
Reported-by: Chen Pei <cp0613@linux.alibaba.com>
Closes: https://lore.kernel.org/all/20261026131851.9942-1-cp0613@linux.alibaba.com
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 kernel/liveupdate/kexec_handover.c | 66 +++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 36 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 2ac5d94f33fd4..5b1797d1289c8 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -829,6 +829,26 @@ static int __init kho_bootmem_cmp(const void *_a, const void *_b)
 	return cmp_int(a->addr, b->addr);
 }
 
+static int __init kho_reserve_bootmem_area(phys_addr_t size, phys_addr_t end,
+					   int nid)
+{
+	phys_addr_t addr;
+
+	if (!size)
+		return 0;
+
+	addr = memblock_alloc_range_nid(size, BOOTMEM_ALIGNMENT_BYTES, 0, end,
+					nid, true);
+	if (!addr)
+		return -ENOMEM;
+
+	kho_bootmem[kho_bootmem_cnt].addr = addr;
+	kho_bootmem[kho_bootmem_cnt].size = size;
+	kho_bootmem_cnt++;
+
+	return 0;
+}
+
 /**
  * kho_reserve_bootmem - Reserve a contiguous chunk of memory for kexec
  *
@@ -840,8 +860,8 @@ static int __init kho_bootmem_cmp(const void *_a, const void *_b)
  */
 static void __init kho_reserve_bootmem(void)
 {
-	int nid, i = 0, max_nr_bootmem;
-	phys_addr_t addr, size;
+	int nid, max_nr_bootmem;
+	phys_addr_t size;
 
 	if (!kho_enable)
 		return;
@@ -861,66 +881,40 @@ static void __init kho_reserve_bootmem(void)
 	 * reserve bootmem area in low memory for lowmem allocations in the
 	 * next kernel
 	 */
-	size = bootmem_size_lowmem;
-	addr = memblock_phys_alloc_range(size, BOOTMEM_ALIGNMENT_BYTES, 0,
-					 ARCH_LOW_ADDRESS_LIMIT);
-	if (!addr) {
+	if (kho_reserve_bootmem_area(bootmem_size_lowmem, ARCH_LOW_ADDRESS_LIMIT,
+				     NUMA_NO_NODE)) {
 		pr_err("Failed to reserve lowmem bootmem\n");
 		goto err_free_bootmem_desc;
 	}
 
-	kho_bootmem[i].addr = addr;
-	kho_bootmem[i].size = size;
-	i++;
-
 	/* reserve large contiguous area for allocations without nid */
-	size = bootmem_size_global;
-	addr = memblock_phys_alloc(size, BOOTMEM_ALIGNMENT_BYTES);
-	if (!addr) {
+	if (kho_reserve_bootmem_area(bootmem_size_global,
+				     MEMBLOCK_ALLOC_ACCESSIBLE, NUMA_NO_NODE)) {
 		pr_err("Failed to reserve global bootmem\n");
 		goto err_free_bootmem_areas;
 	}
 
-	kho_bootmem[i].addr = addr;
-	kho_bootmem[i].size = size;
-	i++;
-
 	/*
 	 * Loop over nodes that have both memory and are online. Skip
 	 * memoryless nodes, as we can not allocate bootmem areas there.
 	 */
 	for_each_node_state(nid, N_MEMORY) {
-		size = bootmem_size_node(nid);
-		if (!size)
-			continue;
-
-		addr = memblock_alloc_range_nid(size, BOOTMEM_ALIGNMENT_BYTES,
-						0, MEMBLOCK_ALLOC_ACCESSIBLE,
-						nid, true);
-		if (!addr) {
+		if (kho_reserve_bootmem_area(bootmem_size_node(nid),
+					     MEMBLOCK_ALLOC_ACCESSIBLE, nid)) {
 			pr_err("Failed to reserve nid %d bootmem\n", nid);
 			goto err_free_bootmem_areas;
 		}
-
-		kho_bootmem[i].addr = addr;
-		kho_bootmem[i].size = size;
-		i++;
 	}
 
-	/*
-	 * Nodes that needed no bootmem were skipped, so fewer areas than
-	 * initially estimated may have been reserved.
-	 */
-	kho_bootmem_cnt = i;
-
 	sort(kho_bootmem, kho_bootmem_cnt, sizeof(*kho_bootmem),
 	     kho_bootmem_cmp, NULL);
 
 	return;
 
 err_free_bootmem_areas:
-	for (i--; i >= 0; i--)
+	for (int i = kho_bootmem_cnt - 1; i >= 0; i--)
 		memblock_phys_free(kho_bootmem[i].addr, kho_bootmem[i].size);
+	kho_bootmem_cnt = 0;
 err_free_bootmem_desc:
 	memblock_free(kho_bootmem, max_nr_bootmem * sizeof(*kho_bootmem));
 err_disable_kho:

-- 
2.53.0


