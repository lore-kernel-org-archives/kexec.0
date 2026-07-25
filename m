Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24170C531C9
	for <kexec@archiver.kernel.org>; Sat, 25 Jul 2026 17:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MiZwROqV6W7eFtc2tbetOC+Vk2IDYu0WCKkwIdfUuFU=; b=Hl4+2wgtrZypnetMYrHQcel4xf
	HIBJhTC38KMTvdZ23gQt/PW9P19bAclBYm+vTmCsxzGvo0KO9WPUJs3RyX1rm8seGBdX/rGkZcVge
	smC3C2A5uKNM7fW2es3nFVDI14wnTzMPoepHBaiC/wDsT6P3AxUfXotrLwM5A6m7rTvkB6ON02G8t
	Zurtp3AQ6myOztaAZpWBJdwvssH7qp713iAe8AOji24aK50+fAHfebj1aJhLB71MpoR258z2IoG0v
	1+xa/aKhNeoGXR55oQNMugFc+cJ9uywjcE891On8P3VT2AyKn/DHkQpjEKXVYLQ7mGEVcNzOV9Xlw
	/7PZkXFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wng4Z-00000000aMy-1ONF;
	Sat, 25 Jul 2026 17:22:03 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wng4X-00000000aLk-46cx
	for kexec@lists.infradead.org;
	Sat, 25 Jul 2026 17:22:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6857D60A96;
	Sat, 25 Jul 2026 17:22:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E893F1F00A3E;
	Sat, 25 Jul 2026 17:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785000121;
	bh=MiZwROqV6W7eFtc2tbetOC+Vk2IDYu0WCKkwIdfUuFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JW2WQPUHtTN4/4mKaKNJvigwz60iQPO3wM4+2u8D6piNH+j/z7R63JvijCcR9KRrK
	 8u2lUUwUcHq57p9ruG19nUAia4BRE+btAJIEFe5NWUBV4H9OGX86Kgs38y4l+w2h6g
	 UqCHJQSAk3JvCgVWleKmPQGCSN3T38uXprcGhR3arnjCQqMr57J0MmnYCEnrrlg0kg
	 JAF677oubw7A0U8+QkXieraGd15ReXneNZhsf1unYExNyO1bhheqcMJ6zTXMT9uiMR
	 lS4cVSgGQ3gHCvkWNz7K5Szf8kvKnKjolT2qp5IB2Lp/9tm/1L4dmMdZxgNISgXlwM
	 Mfx9M46xLEOTw==
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
Subject: [PATCH v4 06/21] kho: move all memory retrieval logic to kho_mem_retrieve()
Date: Sat, 25 Jul 2026 19:21:06 +0200
Message-ID: <20260725172133.4018491-7-pratyush@kernel.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260725172133.4018491-1-pratyush@kernel.org>
References: <20260725172133.4018491-1-pratyush@kernel.org>
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
2.55.0.229.g6434b31f56-goog


