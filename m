Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7700EC44506
	for <kexec@archiver.kernel.org>; Thu,  9 Jul 2026 17:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OdR3sfWoKe3cnBBg7L3z1+zE6eZi3SJfP8R+a0w376E=; b=2Tr9KiXEEDlfgU/uTTYeTVOJpI
	vhZBi1HIyEt8AkDMgltAFOMkOwFpp/WuvPunke0sX7gYNwgkEOI4ulMvYdJtqnCk0yOj88Np2NObW
	zr1NHHEJ2WVsBFL0qV2z42U74+OR3x/8X3v8cGUePtPEYV2fOKOsS/1cnj1i69laF2Vh5y6CpKfVA
	ZqpOFmD0oR515laVK8mKNUwqPIxs3abX/vNLNOrIydh1L4HHijmRqWm9inX6/dUgVEUxcW6fgvCgy
	Z8fTqkXApHa0DMPoeAgwttZP3LCWTyNsK1NDKeY0IaDWvKAlmIlwZrXSSBjC1SmEFn4NBXqI/PI8I
	YxOGy6AA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whshv-0000000382m-3R0v;
	Thu, 09 Jul 2026 17:38:43 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whshu-0000000382C-3xVr
	for kexec@lists.infradead.org;
	Thu, 09 Jul 2026 17:38:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B181440125;
	Thu,  9 Jul 2026 17:38:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE331F000E9;
	Thu,  9 Jul 2026 17:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783618722;
	bh=OdR3sfWoKe3cnBBg7L3z1+zE6eZi3SJfP8R+a0w376E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X1Y97Jrahs8hijJTCASPXnmlJiKUoiDP6LV1Xv047Hm9DwwiT5rhMHZw0xgMpmbWd
	 mc6R2mkHp2mqY5XK9SyoSLjISgCDlUbfLhJ2k8iTlKS1m8nsEv77Hf3fJU+gfqgMwM
	 lL4cXCNbMtg2TkjNaDaDPC/a+3qyDQbJezObq5pMXAyLkFV9UINwK/LYFJhLGuqlnv
	 39TqSrDFUVgeXfi2jmdkwqAx0VT1CysRe2z2Z/R+fLi1yPSYxE4EviTMvTsjxLppfX
	 9nhzYy85aBfE1OWke3RQvFWic4FUU47hgiYJ6w6zFjG+Q7bmAFWxI4KOajnLYvIoUJ
	 4y7mZVXIIHhHw==
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
Subject: [PATCH v3 04/21] kho: return virtual address of mem_map
Date: Thu,  9 Jul 2026 19:37:53 +0200
Message-ID: <20260709173821.429921-5-pratyush@kernel.org>
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

Currently it is only used by kho_populate(), which doesn't care whether
the address is virtual or physical and only cares that it exists and is
valid. In coming patches, more callers will be added, all of which will
need the virtual address.

Make things simpler by directly returning the virtual address. Rename
kho_get_mem_map_phys() to kho_get_mem_map() to accurately reflect what
it returns.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 kernel/liveupdate/kexec_handover.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index e7451743b87e..5c35c11c273b 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -512,19 +512,24 @@ static int __init kho_preserved_memory_reserve(unsigned long key)
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
 	if (!mem_ptr || len != sizeof(u64)) {
 		pr_err("failed to get preserved memory map\n");
-		return 0;
+		return NULL;
 	}
 
-	return get_unaligned((const u64 *)mem_ptr);
+	mem_map_phys = get_unaligned((const u64 *)mem_ptr);
+	if (!mem_map_phys)
+		return NULL;
+
+	return phys_to_virt(mem_map_phys);
 }
 
 /*
@@ -1647,9 +1652,8 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 {
 	unsigned int scratch_cnt = scratch_len / sizeof(*kho_scratch);
 	struct kho_scratch *scratch = NULL;
-	phys_addr_t mem_map_phys;
-	void *fdt = NULL;
 	bool populated = false;
+	void *fdt = NULL;
 	int err;
 
 	/* Validate the input FDT */
@@ -1671,8 +1675,13 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 		goto unmap_fdt;
 	}
 
-	mem_map_phys = kho_get_mem_map_phys(fdt);
-	if (!mem_map_phys)
+	/*
+	 * At this point phys_to_virt() doesn't work properly and so
+	 * kho_get_mem_map() can return a pre-KASLR virtual address. But here we
+	 * only want to make sure the mem_map is valid so the actual value
+	 * doesn't matter as long as it isn't NULL.
+	 */
+	if (!kho_get_mem_map(fdt))
 		goto unmap_fdt;
 
 	scratch = early_memremap(scratch_phys, scratch_len);
-- 
2.55.0.141.g00534a21ce-goog


