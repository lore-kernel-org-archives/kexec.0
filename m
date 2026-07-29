Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC80C53219
	for <kexec@archiver.kernel.org>; Wed, 29 Jul 2026 14:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0oSBVDvJVhrS8ulDeZlNQQxyRW9eRLFb9CyP3FfzZyU=; b=rI4+JMWwiB+3gSh1KESG2pap80
	VSoNj/LQgeado99aLfNyr4EFLyUiuRrs0SECcGxXSTq6Ehlodn3FI+gYgUumILiN6hW5/hl5IlJrR
	ZIiB2xYMNsY6mqk52FEpC9+sxTVhocRk9mP59rTwPWfSB9NHSoquyoiwJ3RQBUilCg2x4GgI2HIvU
	0vYV3RY9knrAm1MrVVfOvemE/xiDkfrig8KsokPYlDop0IzFwY68nzl2tuZTtOor617UhbxXHV/Rt
	MZgNUP571iAhfRM9wYGsvr+utNhnM1r2IjdyOmnyPKFtjmfiMkcTJD2dsTqO79Cn81IsyFVWMKDUj
	19yEGBKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp5i3-00000008J3Y-3A2w;
	Wed, 29 Jul 2026 14:56:39 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp5i2-00000008J2T-1xW8
	for kexec@lists.infradead.org;
	Wed, 29 Jul 2026 14:56:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 39136434C6;
	Wed, 29 Jul 2026 14:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81211F00A3A;
	Wed, 29 Jul 2026 14:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785336998;
	bh=0oSBVDvJVhrS8ulDeZlNQQxyRW9eRLFb9CyP3FfzZyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eZiJysUwogklnynCVt8wR3BtC2dUOduHvdoCdY/cT5ZxzeTR7BuquI//AGnwADH7E
	 J8xoxKzIIS59SVEZEM8D3h2XruK+PFkxeGkBv8o9ktM8teqWncAMoWjMdB32pUbTWk
	 1wSkDW4wqYWxlb+ASQsM67wDaUK3FWNcj8mmS7XYc2xmUpEGQrTD0vcaD4r1jj3NAj
	 f8Pz+Y2QrQujD0BQiiKeUTdzPbqG7Y/DU8+d+mBFU3c8qFFNVA4zmWPTJa7GOz4R42
	 YRV8lDVodKYhSctsXEd1VVDFl3q46+bFqCjZxP3OkUT7a0w+AKgSkT2r/sHtSdB5yS
	 U7yyXXY+hlJmQ==
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
Subject: [PATCH v5 06/22] kho: move all memory retrieval logic to kho_mem_retrieve()
Date: Wed, 29 Jul 2026 16:55:51 +0200
Message-ID: <20260729145610.2827231-7-pratyush@kernel.org>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
In-Reply-To: <20260729145610.2827231-1-pratyush@kernel.org>
References: <20260729145610.2827231-1-pratyush@kernel.org>
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

The memory retrieval logic is spread out across kho_mem_retrieve() and
kho_memory_init(). The incoming scratch area is initialized at
kho_memory_init(), and the error handling is done there too.

Consolidate all this logic into kho_mem_retrieve() to make the code
cleaner.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 kernel/liveupdate/kexec_handover.c | 31 ++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index b53ae68ca087..e3408e1844dc 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1415,8 +1415,13 @@ int kho_retrieve_subtree(const char *name, phys_addr_t *phys, size_t *size)
 }
 EXPORT_SYMBOL_GPL(kho_retrieve_subtree);
 
-static int __init kho_mem_retrieve(const void *fdt)
+static void __init kho_mem_retrieve(void)
 {
+	const void *fdt = kho_get_fdt();
+	int err;
+
+	kho_scratch = phys_to_virt(kho_in.scratch_phys);
+
 	/*
 	 * kho_get_mem_map() should always succeed. If it fails, kho_populate()
 	 * catches that and never sets kho_in.scratch_phys, which stops memory
@@ -1424,8 +1429,16 @@ static int __init kho_mem_retrieve(const void *fdt)
 	 */
 	kho_in.radix_tree.root = kho_get_mem_map(fdt);
 	mutex_init(&kho_in.radix_tree.lock);
-	return kho_radix_walk_tree(&kho_in.radix_tree,
-				   kho_preserved_memory_reserve);
+
+	err = kho_radix_walk_tree(&kho_in.radix_tree, kho_preserved_memory_reserve);
+	if (err) {
+		/*
+		 * Failed to initialize preserved memory. Clear FDT and radix
+		 * so KHO users don't treat it as a KHO boot.
+		 */
+		kho_in.fdt_phys = 0;
+		kho_in.radix_tree.root = NULL;
+	}
 }
 
 static __init int kho_out_fdt_setup(void)
@@ -1629,16 +1642,10 @@ fs_initcall(kho_init);
 
 void __init kho_memory_init(void)
 {
-	if (kho_in.scratch_phys) {
-		kho_scratch = phys_to_virt(kho_in.scratch_phys);
-
-		if (kho_mem_retrieve(kho_get_fdt())) {
-			kho_in.fdt_phys = 0;
-			kho_in.radix_tree.root = NULL;
-		}
-	} else {
+	if (kho_in.scratch_phys)
+		kho_mem_retrieve();
+	else
 		kho_reserve_scratch();
-	}
 }
 
 void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
-- 
2.55.0.508.g3f0d502094-goog


