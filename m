Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69091CD6E7C
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 18:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=alS6uT4DTp+WwL7sso5ivBySgAZ17Nint0mun5DyoD4=; b=vxZTcSG2yxy5jS7JFIyFTIUFSM
	jbFqfjHymR5A4BQBYAm41owXXfu70/xkL9QRJc7mgq3hg4BvSjGeorgil0u2z3v+mP+fzRcSFzMqT
	qaJRkv+SlxKSOjFDzIXcfD5F9Dr8g4MtaNV2qcp1vd6PvfyfFKiBylHllacE06alFVHGQEyyKW7/I
	lE7fUAho64fafPmMsGFzl0sdWQ9f4ngpml1UJQSzbB+GLrftODUT0HU2Ho24nQolSoTN9KU9CyZD7
	rvuEjoyjxIwrE9Nh1cbNyMb8PjK1eGp9KH+Uogens6RXtOnjmtlNMaWpyqJBaroba+JLX7qFaXacD
	K5AR4XRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVZOA-0000000137S-228u;
	Fri, 05 Jun 2026 18:35:26 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVZO9-0000000136t-2PIp
	for kexec@lists.infradead.org;
	Fri, 05 Jun 2026 18:35:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0A49E600AE;
	Fri,  5 Jun 2026 18:35:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7341F00898;
	Fri,  5 Jun 2026 18:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780684524;
	bh=alS6uT4DTp+WwL7sso5ivBySgAZ17Nint0mun5DyoD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gmowAtOvxTzKu9ncHNPpRCnzGA8aVRacUBa9izDlXmH8W4c2eEeVmTQbE3rGtjedw
	 9ua31Na8GiOZ1dansxYyc4ww00X4kERyhigsjMj//6tPpR1dT8ta5FAYuC9rLTEbY6
	 clH238G1imQE2lF4pz4yqmu2Olzn6gfL3cS4YKiSBIBQxOkulAuY7RUm42r8PIKhIl
	 AWQ4DPyn4eD0GIIoepvbCSkRashG4zd8VlKWBU/q5j/RtQ430n6KVgFAiCgEclekwd
	 +GSPWHJEw/TboqaF5GTuSVNhantMko73vA//MVGrF5uImhBihA8fQztwHqDoFvqgWB
	 zbxK+H2/vhaqQ==
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
Subject: [PATCH v2 05/18] kho: move all memory retrieval logic to kho_mem_retrieve()
Date: Fri,  5 Jun 2026 20:34:38 +0200
Message-ID: <20260605183501.3884950-6-pratyush@kernel.org>
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
index 61e436f5077e..7e556afae283 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1412,8 +1412,13 @@ int kho_retrieve_subtree(const char *name, phys_addr_t *phys, size_t *size)
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
@@ -1421,8 +1426,16 @@ static int __init kho_mem_retrieve(const void *fdt)
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
@@ -1626,16 +1639,10 @@ fs_initcall(kho_init);
 
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
2.54.0.1032.g2f8565e1d1-goog


