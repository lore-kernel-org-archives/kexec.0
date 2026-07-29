Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A17C54F55
	for <kexec@archiver.kernel.org>; Wed, 29 Jul 2026 14:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=URUZhhyk9GJSCPvpDkxOhTJZJrRdQj3QnZX2BRofioY=; b=iIaLovk3JUwUbYz5K6InwmGbss
	YpKJOuIA5BOpur/nAewRaZbiLAU2zKV+MzMaEMRlEBBLD6ZQCeXrbAfjVC70QLf5cFEH9mDfo6a6r
	xajgw9+oIc0MzfuxumWihWxJ9RE18zTq4iVnH8ql/IsSaXeZBPArJdG1cgT3Xeud0uvR/kxr3S2aB
	E3mPzHsS+hu5JAs2UI3pBJhwmIbik3zSAeV69axtJky4+NlUunz3aW+DzskS+O1i5u656cUAMUx5h
	Cyb+1vvi48vnWP+psViD7H+0nQTepZGUeidWa1Tu0Qj0Y1ReD+w99/U68Fs+m9MJpHQeN7aw1JewS
	SPaLRS5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp5hy-00000008J09-2a45;
	Wed, 29 Jul 2026 14:56:34 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp5hx-00000008IzC-2ahC
	for kexec@lists.infradead.org;
	Wed, 29 Jul 2026 14:56:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 175B243FAD;
	Wed, 29 Jul 2026 14:56:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E821F00A3A;
	Wed, 29 Jul 2026 14:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785336993;
	bh=URUZhhyk9GJSCPvpDkxOhTJZJrRdQj3QnZX2BRofioY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VDX7Guv/RSc9zTFHdXr/EBRF1MFHptXJSjdg5B0zd/T2N/+vIibUpoOWl+1LCiPBg
	 i3NOrFuyCkDBCnuZuSuaNeNdVpqTUs+cMCf40jway8yW/VNXrfeXKSKRklHLnWwETN
	 n01K906XSS2hQ9o4B5mkr6yeA51LtH/FEOUo/RDH93Crasm0pjeVCdybz9+lMWv+3Q
	 IhQioV/AgZWNI6aza5IDxxMDTXcdag0+jiIYIlWiuN7Wj0lzYuvrmtqkszK3+m05Pz
	 kBhqTMXrzZdCL26S64rFf5R5rOFkBCejRvIrddhGTwHMuzvImr2Acsgv2u3Hc3Kq0A
	 fxg6H6umLDy2w==
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
Subject: [PATCH v5 04/22] kho: return virtual address of mem_map from kho_get_mem_map()
Date: Wed, 29 Jul 2026 16:55:49 +0200
Message-ID: <20260729145610.2827231-5-pratyush@kernel.org>
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

Currently the preserved memory map address is returned by
kho_get_mem_map_phys(). It is only used by kho_populate().
kho_populate() doesn't use the actual value. It only cares that the
address exists and is valid.

In coming patches, more callers will be added, all of which will need
the virtual address of the preserved memory map. Since kho_populate()
doesn't care about the actual value and only cares about validity, it
can also use the virtual address returned by kho_get_mem_map(). It only
needs to make sure the returned value is not NULL.

Rename kho_get_mem_map_phys() to kho_get_mem_map() and return the
virtual address of the preserved memory map.

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
2.55.0.508.g3f0d502094-goog


