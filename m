Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E54DCA5FD1
	for <kexec@archiver.kernel.org>; Tue, 20 Jan 2026 17:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jwrVgQu8T1zQqFt9YAueQy5DCsjrQY33U9ppp5mocfU=; b=t3Kkf4FJpuDxubFPE21vJBjj1I
	qYYYU1xFfq5/2EFhyKQuzwEWfP8GJSpPz6nzKgwa0wt/Xsm6WgaZwWQVRSCpLJHxPIA05Nhdosz+F
	OsN1hse6DTMJEWE0gF6Rjc4gZ+TNS4pQ/062AgjgjyJZMfhkpVJurm5ksnz7t5zQGfPlye7XRLYC8
	C7Qf4lFQwjLtMiw836zt4gcSOIIRTmDysIo88C9Y2zdESJCxXj5OCRiKCz+TrR0fT+fjNDVA0D0Mv
	KCnGtrQ29mfKY/CFGCh6VexidhwRbPeJ9C/acPEx47TMGPKo7DuuWk/HL9BzwC0yqu5+6c1laO80U
	pvoZoFEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viG0q-00000004H4e-394i;
	Tue, 20 Jan 2026 17:59:32 +0000
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com ([52.12.53.23])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viG0n-00000004H3p-3YVm
	for kexec@lists.infradead.org;
	Tue, 20 Jan 2026 17:59:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1768931969; x=1800467969;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jwrVgQu8T1zQqFt9YAueQy5DCsjrQY33U9ppp5mocfU=;
  b=FT7nDKnJAOeqGaaKo/KF+1XsiU73p711t4C5btJ2O3YEHzSZxDadFYy4
   nK+ufFo2ZzFGkc+bM/mHBArJA9dsYXfNFQexItm4WypigfVAIIWBOdDA0
   q1+dv4/yM5IBuGCoQoYVcRj2lQua8y6UaO/9TbIOItmgiOT2IbYLjB0eV
   df79x0dI+SgK6AuDNTMNHRbiD9tdd7aIK/fbvgc0tkEV3jAXfzqTvTQxh
   qGB4DizBHS6q5QM/iMhpx2MiVWfUE+2veC/MsugJ/utdW5hGaG+URkHXO
   HxpeW8hIS11yjfjp9x50AHcxug15YY5oPFqu+hocGMC2sK652uNeYjpQc
   g==;
X-CSE-ConnectionGUID: DOz3H3uJRdeGXpuxql/bYw==
X-CSE-MsgGUID: h62isw/sQbqrB5itx0IYpw==
X-IronPort-AV: E=Sophos;i="6.21,241,1763424000"; 
   d="scan'208";a="11095148"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 17:59:23 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:10556]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.244:2525] with esmtp (Farcaster)
 id 1f2c0798-ec03-4bf6-a1ae-8006272cbe1b; Tue, 20 Jan 2026 17:59:23 +0000 (UTC)
X-Farcaster-Flow-ID: 1f2c0798-ec03-4bf6-a1ae-8006272cbe1b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Tue, 20 Jan 2026 17:59:23 +0000
Received: from dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com
 (10.253.109.105) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35; Tue, 20 Jan 2026
 17:59:21 +0000
From: Evangelos Petrongonas <epetron@amazon.de>
To: Mike Rapoport <rppt@kernel.org>
CC: Evangelos Petrongonas <epetron@amazon.de>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, "Alexander
 Graf" <graf@amazon.com>, Jason Miu <jasonmiu@google.com>,
	<linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
	<linux-mm@kvack.org>, <nh-open-source@amazon.com>
Subject: [PATCH v2] kho: skip memoryless NUMA nodes when reserving scratch areas
Date: Tue, 20 Jan 2026 17:59:11 +0000
Message-ID: <20260120175913.34368-1-epetron@amazon.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
X-Originating-IP: [10.253.109.105]
X-ClientProxiedBy: EX19D036UWB002.ant.amazon.com (10.13.139.139) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260120_095930_196958_CA0DC5D5 
X-CRM114-Status: GOOD (  12.05  )
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

kho_reserve_scratch() iterates over all online NUMA nodes to allocate
per-node scratch memory. On systems with memoryless NUMA nodes (nodes
that have CPUs but no memory), memblock_alloc_range_nid() fails because
there is no memory available on that node. This causes KHO initialization
to fail and kho_enable to be set to false.

Some ARM64 systems have NUMA topologies where certain nodes contain only
CPUs without any associated memory. These configurations are valid and
should not prevent KHO from functioning.

Fix this by only counting nodes that have memory (N_MEMORY state) and
skip memoryless nodes in the per-node scratch allocation loop.

Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
---
v2:
- Removed kho_mem_nodes_count in favour of nodes_weight(nodes_state[N_MEMORY])
- Use for_each_node_state(nid, N_MEMORY) to loop over nodes that are both
online and have memory.
TIL: Nodes in N_MEMORY are a subset of those that are online. Thanks Mike :)

 kernel/liveupdate/kexec_handover.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 9dc51fab604f..979ebaf015bf 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -643,7 +643,7 @@ static void __init kho_reserve_scratch(void)
 	scratch_size_update();
 
 	/* FIXME: deal with node hot-plug/remove */
-	kho_scratch_cnt = num_online_nodes() + 2;
+	kho_scratch_cnt = nodes_weight(node_states[N_MEMORY]) + 2;
 	size = kho_scratch_cnt * sizeof(*kho_scratch);
 	kho_scratch = memblock_alloc(size, PAGE_SIZE);
 	if (!kho_scratch)
@@ -673,7 +673,11 @@ static void __init kho_reserve_scratch(void)
 	kho_scratch[i].size = size;
 	i++;
 
-	for_each_online_node(nid) {
+	/*
+	 * Loop over nodes that have both memory and are online. Skip
+	 * memoryless nodes, as we can not allocate scratch areas there.
+	 */
+	for_each_node_state(nid, N_MEMORY) {
 		size = scratch_size_node(nid);
 		addr = memblock_alloc_range_nid(size, CMA_MIN_ALIGNMENT_BYTES,
 						0, MEMBLOCK_ALLOC_ACCESSIBLE,
-- 
2.43.0




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


