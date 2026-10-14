Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5348BCC6B1A
	for <kexec@archiver.kernel.org>; Wed, 14 Oct 2026 13:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=N/Kx0frmkxosvQcop9AdOprS27rR/qXNkOdGxt6bKsI=; b=EK0xEenihedoWknueI/B8JFO3t
	NWyuV6pBluzcRbpUlc4riz7ZQmg4c7HsAx55GMVJqI2imFHAuQGNGqV+mQZFGO6V2uOXYw/t+2Wci
	SCrerYQIxrwtolotQyM3FzgtAHQ9Nkb6eWHCWR9cGTM+wX/28vnsRY4wdC5jbcLPFY/NpbKWYWKlK
	ctu+4Oe3KR23k8QlndHddaLyNMKA4UdUbc2//qF13qGHcrrytooNQOtawJmzpxHqLQqTmcIfa0eRk
	/5yukTxS5L0+j606/lR4pn4L1Jz2lSjYjkEkst6l3OHGm2m4x4C/eoUBw5DbS49qcLEMwQ9KIHHzF
	6t8+MX4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGyq5-0000000FYXi-0HOc;
	Wed, 14 Oct 2026 13:16:13 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGyq0-0000000FYX8-1loZ
	for kexec@lists.infradead.org;
	Wed, 14 Oct 2026 13:16:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DA4BA60219;
	Wed, 14 Oct 2026 13:16:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD001F000FF;
	Wed, 14 Oct 2026 13:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791983767;
	bh=N/Kx0frmkxosvQcop9AdOprS27rR/qXNkOdGxt6bKsI=;
	h=From:To:Cc:Subject:Date;
	b=IfV8S4NQS0MqMSLTMwNl1QtVDDkd4UFmd5o0O0OGBCKj/A4Te/Y8nCmicx7OVbrwq
	 6DOy8g4oT/WhRQ7kj6Ob0FSCFmHLmTwhMvQFGI9QK3hFL6CdwN4EUKuYNzuDQiSNjX
	 bArrNH0X6myiUQssLkLoGWrMMxej/xMGzZRMKfmW0ZbzCse+Z0b7fldUO91ZcIHFOM
	 d+Hs+e1vRtiAbij056A7JxS/5qBI5Tv/WmDU6XUSkVyv9eK67kKv/B8cPngMEYBECe
	 Kbbcgcll6kLnGn2PCbYd1kYd4Ae9KvsUUTW1OzIR0NwYzxDhr8QQUw4u2VZQbY+yqn
	 uca2v4+jYSvKg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Bing Jiao <bingjiao@google.com>
Subject: [PATCH] kho: do not reserve empty per-node bootmem areas
Date: Wed, 14 Oct 2026 15:15:44 +0200
Message-ID: <20261014131547.259138-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

Some nodes do not allocate any early boot memory. An example is
hotpluggable nodes with movable_node enabled. So the scratch size for
them ends up being zero. Zero size allocations normally don't play well
with memblock. Memblock returns an address, but then doesn't actually
reserve anything. This address ends up being recorded in kho_bootmem
with a size of 0. In case of hotpluggable nodes with movable_nodes, the
allocation on the node actually fails because memblock refuses to
allocate there, and so KHO fails to initialize.

Skip bootmem reservation for such nodes entirely.

To keep the code more robust, avoid overloading kho_bootmem_cnt. use
max_nr_bootmem to store the size of kho_bootmem array. This ensures that
the location of kho_bootmem_cnt assignment does not affect the cleanup
paths.

Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
Reported-by: Bing Jiao <bingjiao@google.com>
Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 kernel/liveupdate/kexec_handover.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 7018e25e4eda..6f1f55fe3181 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -831,8 +831,8 @@ bool kho_bootmem_overlap(phys_addr_t phys, size_t size)
  */
 static void __init kho_reserve_bootmem(void)
 {
+	int nid, i = 0, max_nr_bootmem;
 	phys_addr_t addr, size;
-	int nid, i = 0;
 
 	if (!kho_enable)
 		return;
@@ -840,8 +840,8 @@ static void __init kho_reserve_bootmem(void)
 	bootmem_size_update();
 
 	/* FIXME: deal with node hot-plug/remove */
-	kho_bootmem_cnt = nodes_weight(node_states[N_MEMORY]) + 2;
-	size = kho_bootmem_cnt * sizeof(*kho_bootmem);
+	max_nr_bootmem = nodes_weight(node_states[N_MEMORY]) + 2;
+	size = max_nr_bootmem * sizeof(*kho_bootmem);
 	kho_bootmem = memblock_alloc(size, PAGE_SIZE);
 	if (!kho_bootmem) {
 		pr_err("Failed to reserve bootmem array\n");
@@ -882,6 +882,9 @@ static void __init kho_reserve_bootmem(void)
 	 */
 	for_each_node_state(nid, N_MEMORY) {
 		size = bootmem_size_node(nid);
+		if (!size)
+			continue;
+
 		addr = memblock_alloc_range_nid(size, BOOTMEM_ALIGNMENT_BYTES,
 						0, MEMBLOCK_ALLOC_ACCESSIBLE,
 						nid, true);
@@ -895,13 +898,19 @@ static void __init kho_reserve_bootmem(void)
 		i++;
 	}
 
+	/*
+	 * Nodes that needed no bootmem were skipped, so fewer areas than
+	 * initially estimated may have been reserved.
+	 */
+	kho_bootmem_cnt = i;
+
 	return;
 
 err_free_bootmem_areas:
 	for (i--; i >= 0; i--)
 		memblock_phys_free(kho_bootmem[i].addr, kho_bootmem[i].size);
 err_free_bootmem_desc:
-	memblock_free(kho_bootmem, kho_bootmem_cnt * sizeof(*kho_bootmem));
+	memblock_free(kho_bootmem, max_nr_bootmem * sizeof(*kho_bootmem));
 err_disable_kho:
 	pr_warn("Failed to reserve bootmem, disabling kexec handover\n");
 	kho_enable = false;

base-commit: e1fe7daedae7a4a23aca6dbd58e1746750b632dc
-- 
2.56.0.385.gd3acb90ef8-goog


