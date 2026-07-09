Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 860D6C43458
	for <kexec@archiver.kernel.org>; Thu,  9 Jul 2026 17:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dgB2xMhCheXYxaDaTXd3qxlc7A2ly9v83pGoMbOAmws=; b=EpTQigMnwq05GE2qjL74EHf4XN
	V/lh0qi7I+T/9TfK8tIXlnUARTlUSBKryoBfEzwAPdFMz9cdN8k2wOEoHPPEj9zrV2VS1mJ7uliJC
	ILDAdUQc8OIDnAECRMCHa7KcbK+R9slxf4CMTrnThjW7toQfsVovStdKoy9aQfoOtnTc5WEXaADkZ
	KqmpIrLkbpy8PNOc/6FUtC2kk7AlW0CPOv/X9zh/b3Lbl+VTZtJJjOsPtU8+/VUhY+U7kU2Er46i9
	/A/xF6wxhOBVmuMAaHh89lIuEr2q/FDZSCDIbhfv/ETn8HRcuxyiy6t7gJkckHuNec15+HHceNJkB
	7tjHzckA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whsiO-000000038Ql-3P0I;
	Thu, 09 Jul 2026 17:39:12 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whsiN-000000038PU-1iIv
	for kexec@lists.infradead.org;
	Thu, 09 Jul 2026 17:39:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D6B8461836;
	Thu,  9 Jul 2026 17:39:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A0CA1F00A3D;
	Thu,  9 Jul 2026 17:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783618750;
	bh=dgB2xMhCheXYxaDaTXd3qxlc7A2ly9v83pGoMbOAmws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RlW3SLa/7ACatTt0jZ2TGxgUhFDYqGkZzFlokYqAgVzHR7YUv5fO80oyI3obRxQma
	 E+1avjG09445a841Dj7dNYSogNub6lOhJTHMC9mPHYPl65v550aLUdqn8h1m+SmXIX
	 uMuaYw+QI7uJCIqBt/M9vGyfHzOhSlUgtsC3VbsWmXAcFrd4HIUWK3CpQ4RJrwh4xO
	 EiFs2M0Spe454LDUALw3E2Gg4hPnKzlpyTBhpY6ipyr4vef5NlHbyveaO5bbT+RVP8
	 MdWJe7FbzAc5dinNreJF58+0w+cIDnutUn3dCZD3OwlqrXaqVGoXXCmBDf5furhlgr
	 OotBLs7sBSajQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Miu <jasonmiu@google.com>,
	Jork Loeser <jloeser@linux.microsoft.com>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 15/21] kho: initialize preserved memory map radix tree earlier
Date: Thu,  9 Jul 2026 19:38:04 +0200
Message-ID: <20260709173821.429921-16-pratyush@kernel.org>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
In-Reply-To: <20260709173821.429921-1-pratyush@kernel.org>
References: <20260709173821.429921-1-pratyush@kernel.org>
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

Currently the preserved memory radix tree is initialized from
kho_memory_init(), which happens relatively late in MM init. In a coming
patch, the tree will be used from kho_memory_init_early(). Move the tree
initialization there.

Simplify some of the code in kho_mem_retrieve() by getting rid of the
err variable and jumping to err directly.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 kernel/liveupdate/kexec_handover.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 2ddfc804cdf7..6e8682469bd7 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1531,20 +1531,8 @@ static void __init kho_mem_retrieve(void)
 	const struct kho_radix_walk_cb cb = {
 		.leaf = kho_preserved_memory_reserve,
 	};
-	const void *fdt = kho_get_fdt();
-	int err;
 
-	/*
-	 * kho_get_mem_map() should always succeed. If it fails, kho_populate()
-	 * catches that and never sets kho_in.scratch_phys, which stops memory
-	 * retrieval.
-	 */
-	err = kho_radix_init_tree(&kho_in.radix_tree, kho_get_mem_map(fdt));
-	if (err)
-		goto err;
-
-	err = kho_radix_walk_tree(&kho_in.radix_tree, &cb, NULL);
-	if (err)
+	if (kho_radix_walk_tree(&kho_in.radix_tree, &cb, NULL))
 		goto err;
 
 	return;
@@ -1756,6 +1744,8 @@ fs_initcall(kho_init);
 
 void __init kho_memory_init_early(void)
 {
+	const void *fdt = kho_get_fdt();
+
 	if (!is_kho_boot())
 		return;
 
@@ -1765,6 +1755,20 @@ void __init kho_memory_init_early(void)
 	 * early.
 	 */
 	kho_scratch = phys_to_virt(kho_in.scratch_phys);
+
+	/*
+	 * kho_get_mem_map() should always succeed. If it fails, kho_populate()
+	 * catches that and never sets kho_in.fdt_phys.
+	 */
+	if (kho_radix_init_tree(&kho_in.radix_tree, kho_get_mem_map(fdt))) {
+		/*
+		 * Failed to initialize preserved memory radix tree. Clear FDT
+		 * and scratch so KHO users don't treat it as a KHO boot.
+		 */
+		kho_in.fdt_phys = 0;
+		kho_in.scratch_phys = 0;
+		return;
+	}
 }
 
 void __init kho_memory_init(void)
-- 
2.55.0.141.g00534a21ce-goog


