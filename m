Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368976083613
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 16:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BDSOyqXE;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aeO4DMk9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=/6GFZTwsk8K1yLnVIeqvPcsTES79RyAO3TzYi1kGa5Q=; b=BDSOyqXEuIsmz2
	v5hNTEDYuoUXyw//BbuoqlCQNYmOYU01X6HAsr2Lkt3YE49tpSegq3SwnXMOmN5nZQDY+u/cgLILX
	BhvEAAh+vrmmHwm6aIXMWORz9GADYW5FavLonrRoG4ManLUhT/GGb32iaCALLu2e8SevU3Q0XVPd8
	r9ZCZnKozptbmBoisqrVtRG4pjFi2ugooEBWh7nMNoztpXFiniu4QB+YIf0l3qAQtiS1Qjk+0ynXi
	qBOQvFS3gNvJkI1msO0S2qvBfhz/NXQNy76CGEr/LDZXvOPFeY/kKTC9Yl43uBi6bxXARXPIpwPNH
	gZYPDpCJrgJ7uh+l4TOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOeBv-000000066WY-3jBO;
	Wed, 04 Nov 2026 16:50:27 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOeBu-000000066VJ-2pM3
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 16:50:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6D8C241800;
	Wed,  4 Nov 2026 16:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E91D1F00A16;
	Wed,  4 Nov 2026 16:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793811026;
	bh=/6GFZTwsk8K1yLnVIeqvPcsTES79RyAO3TzYi1kGa5Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aeO4DMk9XPtbQT+GYd1/yOejHvlEsWQ/UgzcpfDeOQ2e2s/9kc9FreNPXKPf6weAs
	 mL7bawIeFKrOcfYYBAyq776eTEnQkA9hB5rlksBtRq1l+00FbMs1zfoXsYh1HIphSW
	 wiH84CQNK4gWj7wdN6vOBM0EDiHrViUvk9ITZfz8zGAeoCygfV8MA9+YB2kO9Tm3HS
	 RF6A5gBQbHOlC8u80oz8VcqxFnq7Y4RXFqi/FyKnFAyfjERJGTip+25X8T+qZMo0WP
	 SRIHzUDKv83T7QmVADSycLJpwAVLMf1dbr4pTsDSztmaExcMyv0rhv7ArtQBAcxwr1
	 ncfYo2Cy1vNXg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Wed, 04 Nov 2026 18:50:11 +0200
Subject: [PATCH v2 3/3] kho: fix bootmem sizing
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-kho-bootmem-sizing-v2-3-b0d1a834780f@kernel.org>
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

Bootmem areas are sized from overlapping views of the memory reserved in
memblock:

* the global area is sized from all reserved memory, including memory
  allocated on specific nodes, so on NUMA systems everything allocated
  on a node is accounted in both the global area and the area of that
  node.
* per-node sizes are calculated after the lowmem and the global areas
  are reserved. With CONFIG_NUMA=n all memblock regions belong to node 0,
  so the lowmem and the global areas are accounted in the size of node 0
  area and scaled once again.

As a result, bootmem is about twice bigger than it should be on NUMA
systems and about four times bigger with CONFIG_NUMA=n. On small systems
reservation of the bootmem may fail and then KHO gets disabled.

Make the areas cover separate parts of the reserved memory: the lowmem
area covers allocations below ARCH_LOW_ADDRESS_LIMIT, per-node areas
cover allocations above it on each node and the global area covers
allocations that are not bound to any node. Calculate all sizes before
reserving any of the areas.

With CONFIG_NUMA=n the global area becomes empty and it is not reserved.

If ARCH_LOW_ADDRESS_LIMIT covers all memory, as may happen on arm64, any
area can serve lowmem allocations, so don't reserve the lowmem area.

Bootmem sizes in MiB in x86 QEMU VMs, before -> after:

                     CONFIG_NUMA=y     CONFIG_NUMA=n
  1G,  1 node         176 ->   92       320 ->   80
  4G,  1 node         508 ->  332      1264 ->  316
  16G, 2 nodes       1268 ->  704      2944 ->  736
  32G, 4 nodes       2296 -> 1224      5196 -> 1300
  64G, 4 nodes       4344 -> 2248      9664 -> 2420

Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
Reported-by: Kexin Liu <liukexin@kylinos.cn>
Reported-by: George Guo <guodongtai@kylinos.cn>
Closes: https://lore.kernel.org/all/20260904025101.9959-1-dongtai.guo@linux.dev
Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Closes: https://lore.kernel.org/all/20260922131217.698809-1-sourabhjain@linux.ibm.com
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 kernel/liveupdate/kexec_handover.c | 93 ++++++++++++++++++++++----------------
 1 file changed, 54 insertions(+), 39 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 5b1797d1289c8..c4b697a612f67 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -685,6 +685,7 @@ static unsigned int bootmem_scale __initdata = 200;
 static phys_addr_t bootmem_size_global __initdata;
 static phys_addr_t bootmem_size_pernode __initdata;
 static phys_addr_t bootmem_size_lowmem __initdata;
+static phys_addr_t bootmem_size_node[MAX_NUMNODES] __initdata;
 
 static int __init kho_parse_bootmem_size(char *p)
 {
@@ -754,29 +755,58 @@ static int __init kho_parse_bootmem_size(char *p)
 }
 early_param("kho_bootmem", kho_parse_bootmem_size);
 
+static phys_addr_t __init reserved_mem_size(phys_addr_t limit, int nid)
+{
+	return memblock_reserved_kern_size(limit, nid) -
+	       memblock_reserved_hugetlb_size(limit, nid);
+}
+
+static phys_addr_t __init bootmem_scale_size(phys_addr_t size)
+{
+	return size * bootmem_scale / 100;
+}
+
+/*
+ * The lowmem area covers allocations below ARCH_LOW_ADDRESS_LIMIT, per-node
+ * areas cover allocations above it on each node and the global area covers
+ * allocations that are not bound to any node.
+ *
+ * The reserved memory on a node and the total reserved memory include
+ * lowmem, so it is subtracted from both.
+ *
+ * If ARCH_LOW_ADDRESS_LIMIT covers all memory, any area can serve lowmem
+ * allocations and there is no lowmem area.
+ *
+ * All sizes must be calculated before any area is reserved, otherwise the
+ * areas reserved first will be accounted in the sizes of the others.
+ */
 static void __init bootmem_size_update(void)
 {
-	/*
-	 * If fixed sizes are not provided via command line, calculate them now.
-	 * Remove HugeTLB allocations from it because they never get allocated
-	 * from bootmem.
-	 */
+	int nid;
+
 	if (bootmem_scale) {
-		phys_addr_t size;
-
-		size = memblock_reserved_kern_size(ARCH_LOW_ADDRESS_LIMIT,
-						   NUMA_NO_NODE);
-		size -= memblock_reserved_hugetlb_size(ARCH_LOW_ADDRESS_LIMIT,
-						       NUMA_NO_NODE);
-		size = size * bootmem_scale / 100;
-		bootmem_size_lowmem = size;
-
-		size = memblock_reserved_kern_size(MEMBLOCK_ALLOC_ANYWHERE,
-						   NUMA_NO_NODE);
-		size -= memblock_reserved_hugetlb_size(MEMBLOCK_ALLOC_ANYWHERE,
-						       NUMA_NO_NODE);
-		size = size * bootmem_scale / 100 - bootmem_size_lowmem;
-		bootmem_size_global = size;
+		phys_addr_t low_limit = ARCH_LOW_ADDRESS_LIMIT;
+		phys_addr_t lowmem, global, size;
+
+		if (low_limit >= memblock_end_of_DRAM() - 1)
+			low_limit = 0;
+
+		lowmem = reserved_mem_size(low_limit, NUMA_NO_NODE);
+		global = reserved_mem_size(MEMBLOCK_ALLOC_ANYWHERE, NUMA_NO_NODE);
+		global -= lowmem;
+
+		for_each_node_state(nid, N_MEMORY) {
+			size = reserved_mem_size(MEMBLOCK_ALLOC_ANYWHERE, nid) -
+			       reserved_mem_size(low_limit, nid);
+			bootmem_size_node[nid] = bootmem_scale_size(size);
+			global -= size;
+		}
+
+		bootmem_size_lowmem = bootmem_scale_size(lowmem);
+		bootmem_size_global = bootmem_scale_size(global);
+	} else {
+		for_each_node_state(nid, N_MEMORY)
+			bootmem_size_node[nid] = bootmem_size_pernode;
 	}
 
 	/*
@@ -785,24 +815,9 @@ static void __init bootmem_size_update(void)
 	 */
 	bootmem_size_lowmem = round_up(bootmem_size_lowmem, BOOTMEM_ALIGNMENT_BYTES);
 	bootmem_size_global = round_up(bootmem_size_global, BOOTMEM_ALIGNMENT_BYTES);
-}
-
-static phys_addr_t __init bootmem_size_node(int nid)
-{
-	phys_addr_t size;
-
-	if (bootmem_scale) {
-		size = memblock_reserved_kern_size(MEMBLOCK_ALLOC_ANYWHERE,
-						   nid);
-		/* Do not count HugeTLB pages. */
-		size -= memblock_reserved_hugetlb_size(MEMBLOCK_ALLOC_ANYWHERE,
-						       nid);
-		size = size * bootmem_scale / 100;
-	} else {
-		size = bootmem_size_pernode;
-	}
-
-	return round_up(size, BOOTMEM_ALIGNMENT_BYTES);
+	for_each_node_state(nid, N_MEMORY)
+		bootmem_size_node[nid] = round_up(bootmem_size_node[nid],
+						  BOOTMEM_ALIGNMENT_BYTES);
 }
 
 bool kho_bootmem_overlap(phys_addr_t phys, size_t size)
@@ -899,7 +914,7 @@ static void __init kho_reserve_bootmem(void)
 	 * memoryless nodes, as we can not allocate bootmem areas there.
 	 */
 	for_each_node_state(nid, N_MEMORY) {
-		if (kho_reserve_bootmem_area(bootmem_size_node(nid),
+		if (kho_reserve_bootmem_area(bootmem_size_node[nid],
 					     MEMBLOCK_ALLOC_ACCESSIBLE, nid)) {
 			pr_err("Failed to reserve nid %d bootmem\n", nid);
 			goto err_free_bootmem_areas;

-- 
2.53.0


