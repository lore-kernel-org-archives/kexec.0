Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AB0606A31A
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 10:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gim6cFXk;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UXOfp9RY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=AOkwsWmwjY7T0BagmEwjwy19sbGkrNkf9+nM9gVRFeA=; b=gim6cFXky5S11RKUhmkbiV35T3
	5Epyov2cJaI3VA6a85A7CHbPxa0Cg/TUbfI8I3pQqmyXGbQYXsFMuSx8IfZK1nEbRIBEV6BeI1iXx
	648WH4NI1KxZ3juhwQJiGYoghrh9x6S2rrm1C9I7pGOfu5JbMgll3oASmQVxWExztplmcfoHrRrs4
	TawHgdgpvVFsLn7AUc4QhygXyhBxU4fKXPK109cs/+KVR9oQmvMUFYNC9ofx6+7+WFyPLoSdBIclj
	lUwnlRvf0Y8st94TT6bE/4wBFN9tUN3LHeFgojPPGY1/B6N5LBUQQLg149aqfMU7Cv/yC5RA/ZClF
	54SZT47Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMNSw-00000008zOx-3KbT;
	Thu, 29 Oct 2026 10:34:38 +0000
Received: from out-55.mta0.migadu.com ([2001:41d0:1004:224b::37] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMNSq-00000008zKk-1OxC
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 10:34:34 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=V9eKCFzwICKE4rFO7Nmsc0WCMFzPWjs4u+0Fk0qiHkg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793270069; v=1; x=1793874869;
 b=UXOfp9RYEVzG9pxkQUlobs6A4jb1xYE3cZWLzCOHQGck1nZV/9xfA585SJTqLRsuzC5Wd36Q
 lj4xBsZMIOrGWoGZb2gahqDlSCr3eNASR11V9aCanvfVTk8onkRsgfuJQ5v8PN8sabF8JzeIo+U
 24AXxMU3ShTpP0llLmIiyVxQ=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id dd12de82c714536d;
	Thu, 29 Oct 2026 10:34:29 +0000
X-Mizu-Trace-ID: dd12de82c714536d
X-Migadu-Flow: FLOW_OUT
From: George Guo <dongtai.guo@linux.dev>
To: rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org
Cc: graf@amazon.com,
	changyuanl@google.com,
	akpm@linux-foundation.org,
	chenhuacai@kernel.org,
	sourabhjain@linux.ibm.com,
	liukexin@kylinos.cn,
	guodongtai@kylinos.cn,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] liveupdate: kho: calculate per-node bootmem sizes before allocating any
Date: Thu, 29 Oct 2026 19:34:25 +0900
Message-ID: <20261029103425.14689-1-dongtai.guo@linux.dev>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_033432_519343_66E43BA9 
X-CRM114-Status: GOOD (  15.84  )
X-Spam-Score: -2.1 (--)
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: George Guo <guodongtai@kylinos.cn>

kho_reserve_bootmem() calculated the per-node bootmem sizes inside the
allocation loop, after the lowmem and global areas had been allocated.

Without CONFIG_NUMA, memblock_get_region_node() returns 0 for every
region, and memblock_reserved_kern_size() attributes a region to a node
by memblock_get_region_node(). Since allocations are marked
MEMBLOCK_RSRV_KERN, the newly allocated lowmem and global areas enter
node 0's baseline and are scaled again by bootmem_size_node().

In the original 1 GiB QEMU reproducer, the default 200% scale made
node 0 request 672 MiB: twice the sum of the 98.45 MiB baseline and
224 MiB lowmem area, rounded up to 32 MiB alignment. The reservation
failed and KHO disabled itself.

With CONFIG_NUMA=y, node-specific accounting excludes the NUMA_NO_NODE
reservations.

The lowmem and global sizes are already calculated by
bootmem_size_update() before any allocation. Calculate the per-node
sizes into the kho_bootmem descriptors before reserving any bootmem
area as well, and allocate the per-node areas from the stored sizes.
Use separate read and write indices to preserve the saved sizes when
zero-sized per-node areas are skipped.

Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
Reported-by: Kexin Liu <liukexin@kylinos.cn>
Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
Changes in v2:
- Calculate every size before any allocation (Mike). The lowmem and
  global sizes are already calculated by bootmem_size_update(), so only
  the per-node sizes move out of the allocation loop.
- Rebase onto liveupdate-7.4: follow the "scratch" to "bootmem" rename,
  and keep the zero-size node skip added by "kho: do not reserve empty
  per-node bootmem areas" by reading the saved sizes with a separate
  index.
- Explain why only CONFIG_NUMA=n kernels are affected (Pratyush, Sourabh).
- The global size over-allocation on NUMA systems, which I planned to
  look at as a follow-up, is handled by Sourabh's "kho: fix global
  scratch size calculation" [1]. Mike asked there for a broader rework
  of the sizing; this patch only fixes the CONFIG_NUMA=n double
  counting.
- No Assisted-by tag, although I said on v1 that I would add one: the
  Assisted-by references have since been removed from the documentation
  in mainline.

Tested with the KHO vmtest on a 1 GiB LoongArch QEMU guest, with the
LoongArch KHO series on top: it passes with both CONFIG_NUMA=n and
CONFIG_NUMA=y. Without this patch, KHO disables itself in the
CONFIG_NUMA=n run.

v1: https://lore.kernel.org/all/20260904025101.9959-1-dongtai.guo@linux.dev/
[1] https://lore.kernel.org/all/20260922131217.698809-1-sourabhjain@linux.ibm.com/

 kernel/liveupdate/kexec_handover.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 6f1f55fe3181..9a53d7750367 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -831,7 +831,7 @@ bool kho_bootmem_overlap(phys_addr_t phys, size_t size)
  */
 static void __init kho_reserve_bootmem(void)
 {
-	int nid, i = 0, max_nr_bootmem;
+	int nid, i, j, max_nr_bootmem;
 	phys_addr_t addr, size;
 
 	if (!kho_enable)
@@ -848,6 +848,15 @@ static void __init kho_reserve_bootmem(void)
 		goto err_disable_kho;
 	}
 
+	/*
+	 * Save the per-node sizes before allocating bootmem areas. Without
+	 * CONFIG_NUMA, new lowmem and global allocations would otherwise be
+	 * counted as node 0 kernel reservations and scaled again.
+	 */
+	j = 2;
+	for_each_node_state(nid, N_MEMORY)
+		kho_bootmem[j++].size = bootmem_size_node(nid);
+
 	/*
 	 * reserve bootmem area in low memory for lowmem allocations in the
 	 * next kernel
@@ -860,6 +869,7 @@ static void __init kho_reserve_bootmem(void)
 		goto err_free_bootmem_desc;
 	}
 
+	i = 0;
 	kho_bootmem[i].addr = addr;
 	kho_bootmem[i].size = size;
 	i++;
@@ -879,9 +889,12 @@ static void __init kho_reserve_bootmem(void)
 	/*
 	 * Loop over nodes that have both memory and are online. Skip
 	 * memoryless nodes, as we can not allocate bootmem areas there.
+	 * Skipping zero-sized areas leaves i behind j, so writes to
+	 * kho_bootmem[i] cannot overwrite unread sizes.
 	 */
+	j = i;
 	for_each_node_state(nid, N_MEMORY) {
-		size = bootmem_size_node(nid);
+		size = kho_bootmem[j++].size;
 		if (!size)
 			continue;
 

base-commit: 9a6a70aefe77f6fb9ff2b3037dcf87f6dff65c8c
-- 
2.53.0


