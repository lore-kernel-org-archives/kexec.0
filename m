Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1548FD47CD6
	for <kexec@archiver.kernel.org>; Fri, 16 Jan 2026 11:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qG4MzEbXGT3z4AyiZSiGB/Kf0T7fme7tElgC/AQRTv4=; b=Qb8AMZA9PoZXoWUmEYsle9iXlP
	KC0ciuBZlAM+a228RODeTTIwQCDKC4BeWWC/5ip8+u8chyaMQJJQ1KA091fAzmhg91qoGDxswgG1H
	O6RZMoE060AwG/oOvzFImeecLnksbcv15Vz+bgr1mnxddTTGMm9fnQK0YPc096mHwioMs5kp4S3nQ
	X523TpIYYBVeG9+QkEYs4fyS1jQVk1NctW6HcDxdTh9KG5R7d++Va/MryvB56tJkzYYhsGdlF0b8S
	dj19jhwaRDj7zw/IOt9UXXWrsMOYir0KMMsuh+gYJmc26WfgpJfV0oviJeomVghSU1d0daFvcQbNS
	9B/Ohnig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vghzm-0000000E3Aq-2DJZ;
	Fri, 16 Jan 2026 11:28:02 +0000
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com ([52.12.53.23])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vghzk-0000000E3AV-1IHf
	for kexec@lists.infradead.org;
	Fri, 16 Jan 2026 11:28:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1768562880; x=1800098880;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qG4MzEbXGT3z4AyiZSiGB/Kf0T7fme7tElgC/AQRTv4=;
  b=orlO8LDwf/P3ip0kAEzIB/Uw/29mIvyspB3C+80WU8vuNgoDj8wwFCxK
   ui0J8NXgcgy2Fu/wZb8Kb5+byXANfUdIllbS9R8nIPjlENXdVuWPs8wj3
   GNPzYo+JQEBiR+GjJ9o5/VodZTGeCCrQ3bOpxomP1lZ+sFJIjt6ITOZOZ
   MYmbbnvB+Wdr5K5Wpy+fQSSzJ217gyc5EsOgvUNvf7RRkehYKUqXjSRLx
   CYZ5KbhKpjBW1dTFSUZ/N81PtY5fX8ZSgHgsON8dabRurchejmYHqnijZ
   lgMS5G27W/uim6v6/toeJl0wh9ieBHjvhx5bat1A9cgnsbrdN+WXIw6vg
   Q==;
X-CSE-ConnectionGUID: kYRm3ihZSdOkaD7jQUuX3A==
X-CSE-MsgGUID: CLKyTbR+QlGW1oobF33dUw==
X-IronPort-AV: E=Sophos;i="6.21,230,1763424000"; 
   d="scan'208";a="10862801"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 11:27:55 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:5994]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.191:2525] with esmtp (Farcaster)
 id a6631774-5337-46bf-80a0-011e601a8a40; Fri, 16 Jan 2026 11:27:54 +0000 (UTC)
X-Farcaster-Flow-ID: a6631774-5337-46bf-80a0-011e601a8a40
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Fri, 16 Jan 2026 11:27:54 +0000
Received: from dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com
 (10.253.109.105) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35; Fri, 16 Jan 2026
 11:27:52 +0000
From: Evangelos Petrongonas <epetron@amazon.de>
To: Mike Rapoport <rppt@kernel.org>
CC: Evangelos Petrongonas <epetron@amazon.de>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, "Alexander
 Graf" <graf@amazon.com>, Jason Miu <jasonmiu@google.com>,
	<linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
	<linux-mm@kvack.org>, <nh-open-source@amazon.com>
Subject: [PATCH] kho: skip memoryless NUMA nodes when reserving scratch areas
Date: Fri, 16 Jan 2026 11:26:35 +0000
Message-ID: <20260116112640.64900-1-epetron@amazon.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
X-Originating-IP: [10.253.109.105]
X-ClientProxiedBy: EX19D043UWC002.ant.amazon.com (10.13.139.222) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260116_032800_614327_267678B3 
X-CRM114-Status: GOOD (  11.93  )
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

Fix this by introducing kho_mem_nodes_count() which counts only nodes
that have memory (N_MEMORY state), and skip memoryless nodes in the
per-node scratch allocation loop.

Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
---
 kernel/liveupdate/kexec_handover.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 9dc51fab604f..c970ed08b477 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -623,6 +623,23 @@ static phys_addr_t __init scratch_size_node(int nid)
 	return round_up(size, CMA_MIN_ALIGNMENT_BYTES);
 }
 
+/*
+ * Count online NUMA nodes that have memory. Memoryless nodes cannot have
+ * scratch memory and should be excluded.
+ */
+static unsigned int __init kho_mem_nodes_count(void)
+{
+	unsigned int cnt = 0;
+	int nid;
+
+	for_each_online_node(nid) {
+		if (node_state(nid, N_MEMORY))
+			cnt++;
+	}
+
+	return cnt;
+}
+
 /**
  * kho_reserve_scratch - Reserve a contiguous chunk of memory for kexec
  *
@@ -643,7 +660,7 @@ static void __init kho_reserve_scratch(void)
 	scratch_size_update();
 
 	/* FIXME: deal with node hot-plug/remove */
-	kho_scratch_cnt = num_online_nodes() + 2;
+	kho_scratch_cnt = kho_mem_nodes_count() + 2;
 	size = kho_scratch_cnt * sizeof(*kho_scratch);
 	kho_scratch = memblock_alloc(size, PAGE_SIZE);
 	if (!kho_scratch)
@@ -674,6 +691,10 @@ static void __init kho_reserve_scratch(void)
 	i++;
 
 	for_each_online_node(nid) {
+		/* Skip memoryless nodes - we cannot allocate scratch memory there */
+		if (!node_state(nid, N_MEMORY))
+			continue;
+
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


