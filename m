Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B83CD8C83
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 18:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R6yDcpji1C+GYUKGpWyVAnr/m2Kie2TV2BOTVneeC1s=; b=WQ5LNQzJLWvDrxO2UFM+0MrCD/
	RGZ9lpNNi7gc1U9dh61Butedn6si3rLr1rVPoBXCkQx2pIHKECcymlIOhWswsYLNlnrFX/DvqH0PJ
	nUW34+gl51jB4KJgC5WmOvsZBFAcTUsPOLlFJ9WM+tkRaubKY6LfH+Qycr0AowwOgbdzYbA70TIje
	2wVYRjZBCF33PgRDMHCszBLKsAs/PX3GGS8v1Ftrs0DGUZwXFGnU9Mw6Bqe3mjucMXRWbrzk8C+G3
	yKooYUNRmB8IebHGQKMzPIeanjzePiPxi4znn8vGa0GlFp0rLLto65xfw4w2hNe5vyGEZNAdz1txt
	CcvCa1Zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVZO5-0000000133y-1ROY;
	Fri, 05 Jun 2026 18:35:21 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVZO4-0000000133A-29B9
	for kexec@lists.infradead.org;
	Fri, 05 Jun 2026 18:35:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E750E4385C;
	Fri,  5 Jun 2026 18:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14F11F00898;
	Fri,  5 Jun 2026 18:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780684519;
	bh=R6yDcpji1C+GYUKGpWyVAnr/m2Kie2TV2BOTVneeC1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XfzK9R9w/+8j97Px+AmChM/ZPMAXQowShQTxBd5VUEBg+YEwWjMWhB0B6YsyVkPO+
	 GjB/7x0yCdaGCzZ8sxAZ/EE/hxP8QlxBiOJJ+gwE8p+KWWB/VuK1lk07m0UZTjsWBq
	 cyHcRCjsUdF7+sZjLUA5E55RAgute94fLjtEcDtAbM7hQ1TM76OZEObpy+PL8+M66m
	 kHWBuG90PapNjA3UsFO8LNgzplcVXSfi45kX9pPIaZiK7SocUu9CDbiBCr5JQDEXIZ
	 OFbQtfkQS4PwE3ghGzotdfuDdTBG3uACNcT5bA+3546BO52jNNQK4scjWbvzP3++qY
	 swHEtglvX23lw==
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
Subject: [PATCH v2 03/18] kho: return virtual address of mem_map
Date: Fri,  5 Jun 2026 20:34:36 +0200
Message-ID: <20260605183501.3884950-4-pratyush@kernel.org>
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

Currently it is only used by kho_populate(), which doesn't care whether
the address is virtual or physical and only cares that it exists and is
valid. In coming patches, more callers will be added, all of which will
need the virtual address.

Make things simpler by directly returning the virtual address. Rename
kho_get_mem_map_phys() to kho_get_mem_map() to accurately reflect what
it returns.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 kernel/liveupdate/kexec_handover.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index e8454dc5b489..d8dd0ede4f87 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -509,10 +509,11 @@ static int __init kho_preserved_memory_reserve(unsigned long key)
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
@@ -521,7 +522,11 @@ static phys_addr_t __init kho_get_mem_map_phys(const void *fdt)
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
@@ -1644,8 +1649,7 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 {
 	unsigned int scratch_cnt = scratch_len / sizeof(*kho_scratch);
 	struct kho_scratch *scratch = NULL;
-	phys_addr_t mem_map_phys;
-	void *fdt = NULL;
+	void *fdt = NULL, *mem_map;
 	bool populated = false;
 	int err;
 
@@ -1668,8 +1672,8 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 		goto unmap_fdt;
 	}
 
-	mem_map_phys = kho_get_mem_map_phys(fdt);
-	if (!mem_map_phys)
+	mem_map = kho_get_mem_map(fdt);
+	if (!mem_map)
 		goto unmap_fdt;
 
 	scratch = early_memremap(scratch_phys, scratch_len);
-- 
2.54.0.1032.g2f8565e1d1-goog


