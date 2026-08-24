Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C69BC5DF97
	for <kexec@archiver.kernel.org>; Mon, 24 Aug 2026 02:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pNZbPImN1HBVjw42D9IBO0B2LYorjmfZ4vM9pHSZXPA=; b=swsyZMnz4DE+2RQ7YpKlH9C+iI
	ugaBDYpYVf2MlH44ehsUhwfyGmL00CdR2rnoLgPK1RcnvCqLEz+oAD+Eh2X+rUUQK+3Xnhn9cxzaL
	0oyjdhqICANivdb0jPvb6GGoDOzLC+59lA5FbTdlYSpj8Vxy7Ogsl9V11vq5GA2mNMdbCkC45/kwD
	oj5l+svtcOQYog9eWpx9B9EwwbSpoVrPGaRSSw+JKyjGHeobN2zLvfCzuVydqG0izukfQdlX3a/LN
	JG4uBPi24Ik0P5XJ/UpkTy+tWeReCPNDk7V4T7wb42RB1h/UbJ7cHyDNfLp8+MEZmH3OdsO1UoG0r
	4V0i1YEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyKi3-0000000FpfR-4BFh;
	Mon, 24 Aug 2026 02:46:51 +0000
Received: from canpmsgout03.his.huawei.com ([113.46.200.218])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyKi0-0000000FpeQ-1RFx
	for kexec@lists.infradead.org;
	Mon, 24 Aug 2026 02:46:50 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=pNZbPImN1HBVjw42D9IBO0B2LYorjmfZ4vM9pHSZXPA=;
	b=I2RdeO+iwb22nkG/IYlzNCm9HdhqW7GckDNeGGN/3EmcJ2TiP1syF4ThvRRNCX2uBpDHdCrdQ
	pRAiQ1xQ4S1Way6fXAwqUobXUv+IydhgMSqP8gaq3gVoEZbAap9p9+qYTpplARZNSyq6JrG6c5A
	9sIP94/YG/HyLTu3suFMpFk=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4hSw4f2rkYzpSvB;
	Mon, 24 Aug 2026 10:35:30 +0800 (CST)
Received: from kwepemo200009.china.huawei.com (unknown [7.202.195.26])
	by mail.maildlp.com (Postfix) with ESMTPS id B608B40538;
	Mon, 24 Aug 2026 10:46:34 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemo200009.china.huawei.com
 (7.202.195.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 10:46:33 +0800
From: LongWei27 <longwei27@huawei.com>
To: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, Pasha
 Tatashin <pasha.tatashin@soleen.com>
CC: Pratyush Yadav <pratyush@kernel.org>, <kexec@lists.infradead.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<hewenliang4@huawei.com>, Long Wei <longwei27@huawei.com>
Subject: [PATCH V2] kho: Convert error handling to immediate return pattern
Date: Mon, 24 Aug 2026 10:44:48 +0800
Message-ID: <20260824024448.550552-1-longwei27@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00c96a62-f783-497c-a7ac-1de495e4af06@huawei.com>
References: <00c96a62-f783-497c-a7ac-1de495e4af06@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.159.234]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo200009.china.huawei.com (7.202.195.26)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260823_194648_867802_45CE0243 
X-CRM114-Status: GOOD (  10.63  )
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

Two problems with the current approach:
1. It continues executing FDT operations even after a failure, which
   is pointless and potentially unsafe on an invalid FDT context.
2. Bitwise OR of multiple negative error codes produces a result that
   may not represent any actual error, making debugging misleading.

Early return fails fast and preserves the original error code for
accurate diagnosis.

No functional change intended.

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


