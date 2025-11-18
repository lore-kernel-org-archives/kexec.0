Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB67FCEE347
	for <kexec@archiver.kernel.org>; Tue, 18 Nov 2025 18:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qn+AjTDGoUktBthzjiX+VXPZpfCo/hGYtUUP0NyEVEo=; b=L8ZVnRGFShaPYibOUBpQ46O5ST
	47e8W1R6VmmNK5VZtw4gkCaJrdOMph2HoiiJ66lUO3CSilH/IOPz+YmPt4UHD+oM0TqIn9OGGJx9V
	qQYEKr8TbLYkAqtIR3Z1cYeBKoQt2hN9krCRCJU6fUeQuE+BtEbbzu3ZHOS3+ybVaWvSUbTgT66fy
	S5k9hyoQbiRWmS67y9MS2S6y21MCTFeogX7b1hm/kZTsVEhgepN6b79zUyzKysNX1XYbMs29WVvzR
	K8cP9acfoUZLiLa8uzumzfLch89bXfOgFnaWa40gOA6QVzGU7fHr8v1BBvxkUtrBEDYsPjRcXqws1
	PzLhmNTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLQAO-00000000ufg-2sTK;
	Tue, 18 Nov 2025 18:11:00 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLQAG-00000000ufY-459T
	for kexec@lists.infradead.org;
	Tue, 18 Nov 2025 18:10:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 11B456020B;
	Tue, 18 Nov 2025 18:10:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D838AC4CEFB;
	Tue, 18 Nov 2025 18:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763489451;
	bh=fOpeaPbF1C83S+AnriTWnUlfDJdmGqoTy8hMXQsnkJE=;
	h=From:To:Cc:Subject:Date:From;
	b=KGRhe/9VTVaNtHgMudCOU5AifM3JUAT8EBLPPuwbH0NsbWJas3sUy6iQkmuBxZ8Z3
	 rLqAm4yN59fr5UDfbN5AV5nyfzOc4bKV7PjwQc18uDy7+OlaeZVxmXjE7gwP+tA+XN
	 aYzJ9nGU65SSzcfzjf3PoFjz2Mh9Q3kfT9ZrU2RtvE9Pvegq/Qo6XGzJ+GiL1Zggi1
	 tMf8mb8g2CsnrTg2c5xan9f7UKsRyfD2hcNoWcL0FUtURxz/pQHXKN5lIz2XJldTG+
	 QVDZIvnvltc9exEtGnCkUaNCCL88dfNX8RURa5valgM46ZPSq25EkjDkU84BiDVD0T
	 Cmg/Zb1UfCEcA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] test_kho: always print restore status
Date: Tue, 18 Nov 2025 19:10:45 +0100
Message-ID: <20251118181046.23321-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.51.2
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

Currently the KHO test only prints a message on success, and remains
silent on failure. This makes it difficult to notice a failing test. A
failing test is usually more interesting than a successful one.

Always print the test status after attempting restore.

Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
---
 lib/test_kho.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/lib/test_kho.c b/lib/test_kho.c
index 85b60d87a50ad..47de562807955 100644
--- a/lib/test_kho.c
+++ b/lib/test_kho.c
@@ -306,7 +306,6 @@ static int kho_test_restore(phys_addr_t fdt_phys)
 	if (err)
 		return err;
 
-	pr_info("KHO restore succeeded\n");
 	return 0;
 }
 
@@ -319,8 +318,15 @@ static int __init kho_test_init(void)
 		return 0;
 
 	err = kho_retrieve_subtree(KHO_TEST_FDT, &fdt_phys);
-	if (!err)
-		return kho_test_restore(fdt_phys);
+	if (!err) {
+		err = kho_test_restore(fdt_phys);
+		if (err)
+			pr_err("KHO restore failed\n");
+		else
+			pr_info("KHO restore succeeded\n");
+
+		return err;
+	}
 
 	if (err != -ENOENT) {
 		pr_warn("failed to retrieve %s FDT: %d\n", KHO_TEST_FDT, err);

base-commit: f0bfdc2b69f5c600b88ee484c01b213712c63d94
-- 
2.47.3


