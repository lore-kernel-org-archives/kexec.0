Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 917CDCF6BE2
	for <kexec@archiver.kernel.org>; Wed,  7 Jan 2026 02:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nPVPfkr/y2YYTpshmkF6KZTylgTLjqX2OuEnIKqe7Nc=; b=Nc3gcCr3L5x7c6gCsD11M0ez/k
	ZoMFs2UQg7FJulr61UiBGb1DTk4CN6dVvaD1ddtS9WvUt08NCxCqcTNPHhW2wgAzuVhbcHn4ww3ZE
	lcRCKoQv+PZJuxedVQcLIjM/E5TfTmlFR0dhdHw3nNxTmHtg2mQ302CUpe8rFWzEOkZ3MJTexdWKo
	SDvyz8uMq55sN4H7Umacrn6AV0MGNbOMnxMxBDJhziHlK9WC4HmD6B0PpZA8G7wvhY7nmP7Piq/Fe
	yM3xWIu0Ro3UHYBvMs3Ecq4v4J9FxmEByOM4Nh8IEaSUX7gWmRXkewh6UdXzAOwvV9P7wtXSJohhD
	v7t58FaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdJEi-0000000E4Je-0A9H;
	Wed, 07 Jan 2026 02:25:24 +0000
Received: from canpmsgout05.his.huawei.com ([113.46.200.220])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdJEf-0000000E4Ik-0do6
	for kexec@lists.infradead.org;
	Wed, 07 Jan 2026 02:25:23 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=nPVPfkr/y2YYTpshmkF6KZTylgTLjqX2OuEnIKqe7Nc=;
	b=eSoHDgAZDEdyakPtnm2r4lz14cJx1JhE389G5KPkFU0OloU6l16n0E1lB5q1iRsH14ch2eHPs
	aynE6cbhCCN/lJi1pWZWgKOszrIZVfD5i2wWU/MxUZ4tilD4RKKQ40KyA5UEOp8ggUnR894tWeU
	PAuSQorJ/HHw2n5/gfJhRdc=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dmBcr1kQfz12LDj;
	Wed,  7 Jan 2026 10:22:04 +0800 (CST)
Received: from kwepemk100009.china.huawei.com (unknown [7.202.194.57])
	by mail.maildlp.com (Postfix) with ESMTPS id AB7874056A;
	Wed,  7 Jan 2026 10:25:08 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemk100009.china.huawei.com
 (7.202.194.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 7 Jan
 2026 10:25:07 +0800
From: l00580197 <longwei27@huawei.com>
To: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, Pasha
 Tatashin <pasha.tatashin@soleen.com>
CC: Pratyush Yadav <pratyush@kernel.org>, <kexec@lists.infradead.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<hewenliang4@huawei.com>, Long Wei <longwei27@huawei.com>
Subject: [PATCH] kho: test: clean up residual memory upon test_kho module unload
Date: Wed, 7 Jan 2026 10:24:27 +0800
Message-ID: <20260107022427.4114424-1-longwei27@huawei.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.159.234]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk100009.china.huawei.com (7.202.194.57)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260106_182522_058550_57CCA028 
X-CRM114-Status: UNSURE (   8.13  )
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

During the initialization phase, the test_kho module invokes the
kho_preserve_folio function, which internally configures bitmaps
within kho_mem_track and establishes chunk linked lists in KHO.
Upon unloading the test_kho module, it is necessary to clean up
these states.

Signed-off-by: Long Wei <longwei27@huawei.com>
---
 lib/test_kho.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/test_kho.c b/lib/test_kho.c
index 47de56280795..69230da5a056 100644
--- a/lib/test_kho.c
+++ b/lib/test_kho.c
@@ -339,11 +339,15 @@ module_init(kho_test_init);
 
 static void kho_test_cleanup(void)
 {
+	/* unpreserve and free the data stored in folios */
+	kho_test_unpreserve_data(&kho_test_state);
 	for (int i = 0; i < kho_test_state.nr_folios; i++)
 		folio_put(kho_test_state.folios[i]);
 
 	kvfree(kho_test_state.folios);
-	vfree(kho_test_state.folios_info);
+
+	/* Unpreserve and release the FDT folio */
+	kho_unpreserve_folio(kho_test_state.fdt);
 	folio_put(kho_test_state.fdt);
 }
 
-- 
2.43.0


