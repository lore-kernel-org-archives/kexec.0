Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE82C531D0
	for <kexec@archiver.kernel.org>; Sat, 25 Jul 2026 17:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RcJ0nQ8kdM2z71n3oAQxiS9jOdJPtLpFn1GyFRLutr8=; b=xqgOZTnAmhYkUIVL15l2gwLRkJ
	IqhJ5tKKVEdwQdLhMnKoBqbXL6xvv2nQA1uYH+qROokmzwK4S/C7aQv3cjoC+Ee0DfzXacmiovsuM
	w+ZD0UkmuSsq/Qv7F0eAEp6PbdQiqhbJANRy9Q/RBHMSF3grMgsCIMazK1/sWCmab6X9d6uU4oUlD
	CNY6ohAg9+BBOmDdNVngjl1HCCTWji8MTWobz2nu7Kq4gg6OPwKXTAlsvjfW6bxnXggqcYo8oh8nU
	OCsi6u6zpVwO5bPZAXwVgRjwece8Jz4KzA9TwJ/rcLqkAISALoduQ5HFbqckCgIraxzJuZty54apJ
	gnRZsW+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wng4U-00000000aId-0Q5E;
	Sat, 25 Jul 2026 17:21:58 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wng4S-00000000aHh-3vDr
	for kexec@lists.infradead.org;
	Sat, 25 Jul 2026 17:21:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 510C360AA2;
	Sat, 25 Jul 2026 17:21:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0D41F00A3F;
	Sat, 25 Jul 2026 17:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785000116;
	bh=RcJ0nQ8kdM2z71n3oAQxiS9jOdJPtLpFn1GyFRLutr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gUjvw3NwOs4cPA8Ku5wlCO5nfCTS/tc/dOMfEN2LRy5Q7uAZNzI7+sM6X+g/YxdUL
	 o3fSnfECVorR5ydPD6NhHE0C88TXCnADNJQAh8MenEa9Lx3vd93/zE5JIRmZWiFd73
	 J8wQoFEB4Udj8s5SPZAxNxM4YWWKDPHCR3nLYNQqCEyWMijL4XBmHEVv/I4YhiSlux
	 W0JttGR/ltUF0EH8VztYA59ytBHUqOPJpuPJ9gxa17XkET3uZshEUx+8FgBJ/TLerh
	 6KFtAge/+ItzYblCFX2I2RljTiD63fBhy/qdGas3IZLS29k8tNO1cC+a8Xwso5RKOk
	 EP6HJNLUYiLEg==
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
Subject: [PATCH v4 04/21] kho: return virtual address of mem_map from kho_get_mem_map()
Date: Sat, 25 Jul 2026 19:21:04 +0200
Message-ID: <20260725172133.4018491-5-pratyush@kernel.org>
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
2.55.0.229.g6434b31f56-goog


