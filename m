Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77EEFCD1297
	for <kexec@archiver.kernel.org>; Wed, 29 Apr 2026 13:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nr360FbUv9sUz0ZpaDZVBTbPpIZGiTIqAhWXONpjB3w=; b=wo89Em/4GpclQcZaavjJPinNuN
	tfcraoiTjrEkkgVuJDTqCe38itFGWrn7LMTNku9lW3hGfMQjNDyJ8aozFeRIk76ntKSYuPtpY4c77
	5ywhLPmBcMgfdBoJqttubsZ26Fy035FHrqhp4FPYGHT7l9LxDpof7ePh/puxv54aVmFCx/NsBTx/+
	G2wrr9D/3+HylJmNSIQ5Ds3lEwc83uSmr/PNoFvhkKSrt8m9Bf5f61KrXaB++J7A0CPwppa/DVf+O
	SSSYDU3I27jwPGB0ckSggHZqunzearQoeyNRO7puGlVlPVfNx8OdT105sEV/Z9hDJ/kaSg027iFCf
	AuAmBwVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI59A-00000003gkz-3BaI;
	Wed, 29 Apr 2026 13:40:12 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI598-00000003ghq-1gkG
	for kexec@lists.infradead.org;
	Wed, 29 Apr 2026 13:40:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 114514083B;
	Wed, 29 Apr 2026 13:40:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B36C2BCC6;
	Wed, 29 Apr 2026 13:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777470009;
	bh=UueBsq01JA9/z9WSGSLkvtLjqf9jJ9B97O+wRu3Lxo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UfJW+gSG2hHNWNoTkzTSCO1P9P/dSOfWxc9kBCsK5009yDv+2I/0Io+9QKuv+++ak
	 TCAHvLyL4sgUOYy5HVRKo19JHKkGN4spdRILrK5F32AOsLHzYMfVOtROTqycfzBLYw
	 10WAJ9JsR+XIfA7Etr63hAEoZddPOVXUhlw5l0M4itFuSuurWnFNKqRHEVrI0fGfdH
	 /mXxwmUqtQDAF7asLJAHhI/8RJQfy34ei80E41so/aYblUWqu5l52ZCBXwtNMk2PkC
	 qVe1/4nvLoVcHYSugIiYGapj0Q++uzzYQ582cjSmLHTGzvAqP50GorSirPnfctbrz4
	 +tSkIo0+KIcDQ==
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
Subject: [PATCH 11/12] kho: return virtual address of mem_map
Date: Wed, 29 Apr 2026 15:39:13 +0200
Message-ID: <20260429133928.850721-12-pratyush@kernel.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260429133928.850721-1-pratyush@kernel.org>
References: <20260429133928.850721-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260429_064010_514537_4C58EAA2 
X-CRM114-Status: GOOD (  14.35  )
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

There are currently 3 callers of kho_get_mem_map_phys(). Two of them,
kho_mem_retrieve() and kho_extend_scratch() need the virtual address.
The third, kho_populate() doesn't care. Make things simpler by
directly returning the virtual address. Rename kho_get_mem_map_phys() to
kho_get_mem_map() to accurately reflect what it returns.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 kernel/liveupdate/kexec_handover.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index c2b843a5fb28..2e13b80d1c7d 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -625,10 +625,11 @@ static int __init kho_preserved_memory_reserve(unsigned long key, void *data)
 	return 0;
 }
 
-/* Returns physical address of the preserved memory map from FDT */
-static phys_addr_t __init kho_get_mem_map_phys(const void *fdt)
+/* Returns virtual address of the preserved memory map from FDT */
+static __init void *kho_get_mem_map(const void *fdt)
 {
 	const void *mem_ptr;
+	phys_addr_t mem_map_phys;
 	int len;
 
 	mem_ptr = fdt_getprop(fdt, 0, KHO_FDT_MEMORY_MAP_PROP_NAME, &len);
@@ -637,7 +638,11 @@ static phys_addr_t __init kho_get_mem_map_phys(const void *fdt)
 		return 0;
 	}
 
-	return get_unaligned((const u64 *)mem_ptr);
+	mem_map_phys = get_unaligned((const u64 *)mem_ptr);
+	if (!mem_map_phys)
+		return NULL;
+
+	return phys_to_virt(mem_map_phys);
 }
 
 /*
@@ -932,15 +937,15 @@ void __init kho_extend_scratch(void)
 		.key = kho_ext_mark_scratch,
 	};
 	struct kho_radix_tree radix;
-	phys_addr_t prev_end = 0, mem_map_phys;
+	phys_addr_t prev_end = 0;
 	int err = 0;
 
 	if (!is_kho_boot())
 		return;
 
 	/* Make sure the KHO radix tree is initialized. */
-	mem_map_phys = kho_get_mem_map_phys(kho_get_fdt());
-	err = kho_radix_init_tree(&kho_in.radix_tree, phys_to_virt(mem_map_phys));
+	err = kho_radix_init_tree(&kho_in.radix_tree,
+				  kho_get_mem_map(kho_get_fdt()));
 	if (err)
 		goto print;
 
@@ -1587,11 +1592,9 @@ static int __init kho_mem_retrieve(const void *fdt)
 	const struct kho_radix_walk_cb cb = {
 		.key = kho_preserved_memory_reserve,
 	};
-	phys_addr_t mem_map_phys;
 	int err;
 
-	mem_map_phys = kho_get_mem_map_phys(fdt);
-	err = kho_radix_init_tree(&kho_in.radix_tree, phys_to_virt(mem_map_phys));
+	err = kho_radix_init_tree(&kho_in.radix_tree, kho_get_mem_map(fdt));
 	if (err)
 		return err;
 
@@ -1816,8 +1819,7 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 {
 	unsigned int scratch_cnt = scratch_len / sizeof(*kho_scratch);
 	struct kho_scratch *scratch = NULL;
-	phys_addr_t mem_map_phys;
-	void *fdt = NULL;
+	void *fdt = NULL, *mem_map;
 	bool populated = false;
 	int err;
 
@@ -1840,8 +1842,8 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 		goto unmap_fdt;
 	}
 
-	mem_map_phys = kho_get_mem_map_phys(fdt);
-	if (!mem_map_phys)
+	mem_map = kho_get_mem_map(fdt);
+	if (!mem_map)
 		goto unmap_fdt;
 
 	scratch = early_memremap(scratch_phys, scratch_len);
-- 
2.54.0.545.g6539524ca2-goog


