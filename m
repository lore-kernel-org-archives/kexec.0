Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1DE5FF8867
	for <kexec@archiver.kernel.org>; Wed, 29 Apr 2026 13:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YS6t+2Nob30CSU4tZTpVZ3UGaAlozkF+AcURmj9cnPc=; b=30h95tFBTDZcmTnCzZz2hb+ygt
	moz1pfHW+cPaGPdJf6ZvjPO57KS/U7XQ+BDTx+KCHmzG5/zWC0bgBuv7r9ds/lGLPtIBfvGFUwzf3
	GNuNiVfwWiHMjUh+3aMimWWEzYU7HxTZLfBKhKAc4/JvSG4iB5StSsTp5tY8Fp7w3Y8/OUp9AAAGp
	ajZaF6uV4CJWoMuWEht4Z1TObpVryN2+2VSVOPMwLgkHt7bi2mjKQbw0gsT50HU8W8v6Oyih42PyK
	girQQqYaRBuAh4z+NXKFnETgIi76cmjR8/dMFrsFPHxbnCps0/asftVSWX51OXk03nR0rnydv4zzp
	zz0dDrSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI58q-00000003gSd-2X4H;
	Wed, 29 Apr 2026 13:39:52 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI58o-00000003gR3-2S3V
	for kexec@lists.infradead.org;
	Wed, 29 Apr 2026 13:39:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5FB3A440FB;
	Wed, 29 Apr 2026 13:39:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B8BC2BCB8;
	Wed, 29 Apr 2026 13:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777469989;
	bh=YXAWpdZ3W51xhQU3+WJdhbI9oKC26cOKjbvk+teZUO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hF0BgQZheuBbHrIBASmeG6IKFi6/IfNNPeQo4/p0QxH4XIWw4txR06lG8lRig2e7h
	 A7KyoQyT45WLHHJE/4PHYo447I6CmnxKf3qOeDaEHmCjwoixY8PKhtRkiFyJ5H6sy8
	 iXMRxEkO/wfImxBhD3iJK1QcnZ122+C46VH4sgF2lFM/eBTFxMI1T15wCj0THO3F+9
	 QUvhJl4+uG+NgnPVwSKSXv6IICHD3xHivOTewplC4HtnPjwNajpBJlycdIDmCde1Vn
	 ii53ZdcSSQPrjnHo1cUt16ll9JZx4kAntipfObI5T/NpEoxJMH+wiV75qujnqHSWT0
	 Z1nuxlnaTUmQQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Miu <jasonmiu@google.com>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/12] kho: store incoming radix tree in kho_in
Date: Wed, 29 Apr 2026 15:39:04 +0200
Message-ID: <20260429133928.850721-3-pratyush@kernel.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260429133928.850721-1-pratyush@kernel.org>
References: <20260429133928.850721-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260429_063950_646304_8EE02070 
X-CRM114-Status: GOOD (  15.25  )
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
 kernel/liveupdate/kexec_handover.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index ba568d34c5b4..5758dc6fab5d 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1294,6 +1294,7 @@ struct kho_in {
 	char previous_release[__NEW_UTS_LEN + 1];
 	u32 kexec_count;
 	struct kho_debugfs dbg;
+	struct kho_radix_tree radix_tree;
 };
 
 static struct kho_in kho_in = {
@@ -1373,24 +1374,10 @@ EXPORT_SYMBOL_GPL(kho_retrieve_subtree);
 
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
+	kho_in.radix_tree.root = phys_to_virt(kho_get_mem_map_phys(fdt));
+	mutex_init(&kho_in.radix_tree.lock);
+	return kho_radix_walk_tree(&kho_in.radix_tree,
+				   kho_preserved_memory_reserve);
 }
 
 static __init int kho_out_fdt_setup(void)
@@ -1597,8 +1584,10 @@ void __init kho_memory_init(void)
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
2.54.0.545.g6539524ca2-goog


