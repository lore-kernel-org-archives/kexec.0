Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9157C5DF8C
	for <kexec@archiver.kernel.org>; Sat, 22 Aug 2026 06:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6eacw4YePywUKJOL7QhFxdGGTcFFbEXg3nV8IglWfIA=; b=2a7cNKtJubDxPitPf9k8DhPCMR
	GV83IFtvFtVMXvyC4FDEE3K8d2IkJ0w9V+RQG7MR7RAuMPtouXbKj5RN81CtTpUPR87YjuIY4OuRd
	pYgYniRlUEqVDV9b8e7hdFM6adSFDcAOZ2h/IDFofp4bA/4AMiLUz44k74Fdz3sr3fn0eMcE+OSSK
	i1DNc/vLOgKt+oNjaKzrRztTX27I01CquN088ulm9a1hFWSQacI0Fc2O7uKMIkC47up9x3v6kYPoH
	1y6p/Y1KYC67sE+YPvTrAnU6CNCQguiC9NLbaKGMCeZueIedjledoqzRdPA8ft3WIByb/NWpCEMKH
	elHhnNbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxfS5-0000000EKGG-3jKN;
	Sat, 22 Aug 2026 06:43:37 +0000
Received: from [113.46.200.220] (helo=canpmsgout05.his.huawei.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxfS2-0000000EKFJ-38qf
	for kexec@lists.infradead.org;
	Sat, 22 Aug 2026 06:43:36 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=6eacw4YePywUKJOL7QhFxdGGTcFFbEXg3nV8IglWfIA=;
	b=hYIe8WPmsGe8PIEm71LjWkodGMOUa9oyyhcsN2syDBuzunzkpnpzzS1RQ5wtKAkMAvHjIn5hZ
	aq0RtlP42KEZaIT8VKHjTtKGiKiIodz/0p/Ih/T3zfKozgcP3YQTkmnmtmpVcmcBdOhFZGjl+Tj
	ToKFI5d/w5hz/K+yKW1qgFI=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4hRnRG1LPmz12LDV;
	Sat, 22 Aug 2026 14:32:42 +0800 (CST)
Received: from kwepemo200009.china.huawei.com (unknown [7.202.195.26])
	by mail.maildlp.com (Postfix) with ESMTPS id 9EDD140561;
	Sat, 22 Aug 2026 14:43:01 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemo200009.china.huawei.com
 (7.202.195.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 22 Aug
 2026 14:43:00 +0800
From: LongWei27 <longwei27@huawei.com>
To: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, Pasha
 Tatashin <pasha.tatashin@soleen.com>
CC: Pratyush Yadav <pratyush@kernel.org>, <kexec@lists.infradead.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<hewenliang4@huawei.com>, Long Wei <longwei27@huawei.com>
Subject: [PATCH] kho: Convert error handling to immediate return pattern
Date: Sat, 22 Aug 2026 14:41:27 +0800
Message-ID: <20260822064127.498411-1-longwei27@huawei.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.159.234]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemo200009.china.huawei.com (7.202.195.26)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260821_234335_325393_CE85F3AF 
X-CRM114-Status: UNSURE (   8.16  )
X-CRM114-Notice: Please train this message.
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

From: Long Wei <longwei27@huawei.com>

Replace the chained error accumulation (err |= func()) with immediate
per-step error checking and early return in kho_out_fdt_setup().

Signed-off-by: Long Wei <longwei27@huawei.com>
---
 kernel/liveupdate/kexec_handover.c | 32 +++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 175c08a6e..93443ad84 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1438,20 +1438,34 @@ static __init int kho_out_fdt_setup(void)
 	int err;
 
 	err = fdt_create(root, PAGE_SIZE);
-	err |= fdt_finish_reservemap(root);
-	err |= fdt_begin_node(root, "");
-	err |= fdt_property_string(root, "compatible", KHO_FDT_COMPATIBLE);
+	if (err)
+		return err;
+	err = fdt_finish_reservemap(root);
+	if (err)
+		return err;
+	err = fdt_begin_node(root, "");
+	if (err)
+		return err;
+	err = fdt_property_string(root, "compatible", KHO_FDT_COMPATIBLE);
+	if (err)
+		return err;
 
 	preserved_mem_tree_pa = virt_to_phys(tree->root);
 
-	err |= fdt_property(root, KHO_FDT_MEMORY_MAP_PROP_NAME,
-			    &preserved_mem_tree_pa,
-			    sizeof(preserved_mem_tree_pa));
+	err = fdt_property(root, KHO_FDT_MEMORY_MAP_PROP_NAME,
+			   &preserved_mem_tree_pa,
+			   sizeof(preserved_mem_tree_pa));
+	if (err)
+		return err;
 
-	err |= fdt_end_node(root);
-	err |= fdt_finish(root);
+	err = fdt_end_node(root);
+	if (err)
+		return err;
+	err = fdt_finish(root);
+	if (err)
+		return err;
 
-	return err;
+	return 0;
 }
 
 static void __init kho_in_kexec_metadata(void)
-- 
2.43.0


