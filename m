Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF1FCD6E7C
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 18:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v/RGerRyxm8aTVCl41zoP38L2i7Ee87yOlG4ezqSjQo=; b=rks5hIWhVeN8Y+kHuSp28+oNaD
	odgj6+FfoG8+9L1Wb9a18TtWBMAR41VlHqKfGwnZ4w1xhXyu1IOLBIM6KFy4Nt4XUCkpk1rkJwV34
	bsk1+SM1Klq7QKB/ZqWSDxG/Yc1HDNY30/gL9F80YZAyBaidU9OSApuDTzCX0id5l3urzBgWoAvsY
	obPcSho3DNyRIie7KIwz4jLQN5DsIrRdMn+qHqo60De6dk9+lR9k/90cCLtc4JORTulr0Ar/wAKTK
	f5AXbys9BL4sDTDPBdunNW2/cNiitqFgpAUwAaUOiRKL8TGVozoJCWkd3+Fq7lU6AmDfaRDctEHed
	/Uvg4thg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVZO7-0000000135b-1jSf;
	Fri, 05 Jun 2026 18:35:23 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVZO6-0000000134l-2XXO
	for kexec@lists.infradead.org;
	Fri, 05 Jun 2026 18:35:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5EBC444277;
	Fri,  5 Jun 2026 18:35:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E09D1F00893;
	Fri,  5 Jun 2026 18:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780684522;
	bh=v/RGerRyxm8aTVCl41zoP38L2i7Ee87yOlG4ezqSjQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MPgdUrBersvdIeiDJvd3LrUzlJMbmXc7u1YjP1PjvngfbnOg1wTMed/fISSH2vkVk
	 eBSrWcyzbcOa0R9swpxLwaqTyUddu6ao3yUL8xKCDAN+N9Gp2VQqeXfynMFPggmv++
	 hMyo7fR3rde1IXG7mxJf3wKg9r9gOR/rJCgkI6xqG6n0sbmCkqc+B0kk/++ipOEwBF
	 F7lKau1V1WtMfkSYGEK6vZYrTjxT5GZtaxWGKT8dPb/DE3jaKX3IuvrYdl1M27/k8F
	 cwBxsx9XgdMuGiqDZMQ6GidAqfuioEjCuFMdGwOI1CaYau8zZ272Azz3K2wTHrBDDH
	 Mjp/oWSKjc6DQ==
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
Subject: [PATCH v2 04/18] kho: store incoming radix tree in kho_in
Date: Fri,  5 Jun 2026 20:34:37 +0200
Message-ID: <20260605183501.3884950-5-pratyush@kernel.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <20260605183501.3884950-1-pratyush@kernel.org>
References: <20260605183501.3884950-1-pratyush@kernel.org>
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

This allows other functions to also use the radix tree. While at it,
also use kho_get_mem_map_phys() instead of duplicating the code to get
the radix tree root from the FDT.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 kernel/liveupdate/kexec_handover.c | 32 ++++++++++++------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index d8dd0ede4f87..61e436f5077e 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1334,6 +1334,7 @@ struct kho_in {
 	char previous_release[__NEW_UTS_LEN + 1];
 	u32 kexec_count;
 	struct kho_debugfs dbg;
+	struct kho_radix_tree radix_tree;
 };
 
 static struct kho_in kho_in = {
@@ -1413,24 +1414,15 @@ EXPORT_SYMBOL_GPL(kho_retrieve_subtree);
 
 static int __init kho_mem_retrieve(const void *fdt)
 {
-	struct kho_radix_tree tree;
-	const phys_addr_t *mem;
-	int len;
-
-	/* Retrieve the KHO radix tree from passed-in FDT. */
-	mem = fdt_getprop(fdt, 0, KHO_FDT_MEMORY_MAP_PROP_NAME, &len);
-
-	if (!mem || len != sizeof(*mem)) {
-		pr_err("failed to get preserved KHO memory tree\n");
-		return -ENOENT;
-	}
-
-	if (!*mem)
-		return -EINVAL;
-
-	tree.root = phys_to_virt(*mem);
-	mutex_init(&tree.lock);
-	return kho_radix_walk_tree(&tree, kho_preserved_memory_reserve);
+	/*
+	 * kho_get_mem_map() should always succeed. If it fails, kho_populate()
+	 * catches that and never sets kho_in.scratch_phys, which stops memory
+	 * retrieval.
+	 */
+	kho_in.radix_tree.root = kho_get_mem_map(fdt);
+	mutex_init(&kho_in.radix_tree.lock);
+	return kho_radix_walk_tree(&kho_in.radix_tree,
+				   kho_preserved_memory_reserve);
 }
 
 static __init int kho_out_fdt_setup(void)
@@ -1637,8 +1629,10 @@ void __init kho_memory_init(void)
 	if (kho_in.scratch_phys) {
 		kho_scratch = phys_to_virt(kho_in.scratch_phys);
 
-		if (kho_mem_retrieve(kho_get_fdt()))
+		if (kho_mem_retrieve(kho_get_fdt())) {
 			kho_in.fdt_phys = 0;
+			kho_in.radix_tree.root = NULL;
+		}
 	} else {
 		kho_reserve_scratch();
 	}
-- 
2.54.0.1032.g2f8565e1d1-goog


