Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D4C5C44500
	for <kexec@archiver.kernel.org>; Thu, 22 Jan 2026 12:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=l/jbOXRz2UxbzZ3+gwMR/HUDE0ALp1ml2pDzU1///BE=; b=f2sULrwzUBnqAZMk3bFzXy4oGz
	ceQwmVbBa4hJvJdz1d1w6CtwlN8SDRsFMwWqftoOzfS6DaGSLPeKzuH1LzDrF4nSNku2PbSDPgcFT
	gABNMLJcV5P0pNNYgoGq04phYjoRod7U4+1Z/UsItutV2YGxQKGE5RSkb1GXKID7yqkup2pQ1d9Iu
	ryqxzVyN57AB2A+sQVHXKOhlpaWn9zuVCUVON4xyJY7L0qjTKjDU3gytKtXfw4tDvEsk54tslIqb3
	fuv+R01t+qw2SE6STC1NvWwfPK4999zdWcM7pSb2nSDRB7E3CivGfMYPjYsWyIM5jk/J7TovAjfwv
	snx6xlpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vitda-000000072az-0WVE;
	Thu, 22 Jan 2026 12:18:10 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vitdY-000000072an-1N8Y
	for kexec@bombadil.infradead.org;
	Thu, 22 Jan 2026 12:18:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=l/jbOXRz2UxbzZ3+gwMR/HUDE0ALp1ml2pDzU1///BE=; b=ONEGAb0UcqbgtZwBQG95tO1uwV
	Jn/y4IYXlH/arOGNzSks6Lv1ajfJbxVzfgEqnQ0iahn0YznmARzu3Hj2tFn0ru5cj8xKI6kB1ml6H
	hPkghMK67DQHf3NoFVr+/aDfu16opkGM4v0wZwfaTUiZSS0E4qXug8YRmWfqhxsTyQmHvlKUz7LIp
	FB2BdJIq8+Sb9Je+lbk7CaY11Q5McHcqcgmpL26dtzz9XpVE3QCBQZJxVKZMl28LDhlhgF0PTFb6k
	0JJmeHJBhujstv5B0ckCPvSNQTsIRMGXZjIBNkivZz/1Vzn3YZzyXTz3A6gRE5NJFHq0QxbxRHn5D
	Ucia0W0w==;
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vitdU-00000000K02-3nJ1
	for kexec@lists.infradead.org;
	Thu, 22 Jan 2026 12:18:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3E0B3437E5;
	Thu, 22 Jan 2026 12:18:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7F2C116C6;
	Thu, 22 Jan 2026 12:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769084283;
	bh=+pKK6YqjCMJk2Ik3AjBYzI1PBFwRJgM5oBdefe1/cHs=;
	h=From:To:Cc:Subject:Date:From;
	b=r8OKixc2G/2NXhTyA+0uVZl/ZDMOjEaHITQyYQCFBafsKOn+b2PIkFccWozlddAlO
	 18YXHZZ+97eI/p7OC3F3DFcXbmIq+sgDcaBuyEr4pQ2+GoJPXFRMZ6EvWWC3FWH7Rw
	 hjc+jZt6nUszsq4VmpQo/p2ZD+okWpNpMOKCmMILuTjRUZ4/JtCvD4m4ekFCO+ENNb
	 UXDj+c8/WvFNyXlkBPNoHIfhJlVtjbyhyfXYcRBAguuMLVvs8LDXIHalDDpV+cBZkJ
	 PmuO/M7TiCItvBHXcog3MVE4QoAAYSi05Ii2Dzxkz8Eb3dzpDe98c3AXLfw4aPy+l8
	 /yPeLZe254KUw==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <ptyadav@amazon.de>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] kho: cleanup error handling in kho_populate()
Date: Thu, 22 Jan 2026 14:17:57 +0200
Message-ID: <20260122121757.575987-1-rppt@kernel.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260122_121805_436263_A30F97FA 
X-CRM114-Status: GOOD (  14.14  )
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

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

* use dedicated labels for error handling instead of checking if a pointer
  is not null to decide if it should be unmapped
* drop assignment of values to err that are only used to print a numeric
  error code, there are pr_warn()s for each failure already so printing a
  numeric error code in the next line does not add anything useful

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 kernel/liveupdate/kexec_handover.c | 39 +++++++++++++-----------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index d4482b6e3cae..e248ce2e04b7 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1441,46 +1441,40 @@ void __init kho_memory_init(void)
 void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 			 phys_addr_t scratch_phys, u64 scratch_len)
 {
+	unsigned int scratch_cnt = scratch_len / sizeof(*kho_scratch);
 	struct kho_scratch *scratch = NULL;
 	phys_addr_t mem_map_phys;
 	void *fdt = NULL;
-	int err = 0;
-	unsigned int scratch_cnt = scratch_len / sizeof(*kho_scratch);
+	int err;
 
 	/* Validate the input FDT */
 	fdt = early_memremap(fdt_phys, fdt_len);
 	if (!fdt) {
 		pr_warn("setup: failed to memremap FDT (0x%llx)\n", fdt_phys);
-		err = -EFAULT;
-		goto out;
+		goto err_report;
 	}
 	err = fdt_check_header(fdt);
 	if (err) {
 		pr_warn("setup: handover FDT (0x%llx) is invalid: %d\n",
 			fdt_phys, err);
-		err = -EINVAL;
-		goto out;
+		goto err_unmap_fdt;
 	}
 	err = fdt_node_check_compatible(fdt, 0, KHO_FDT_COMPATIBLE);
 	if (err) {
 		pr_warn("setup: handover FDT (0x%llx) is incompatible with '%s': %d\n",
 			fdt_phys, KHO_FDT_COMPATIBLE, err);
-		err = -EINVAL;
-		goto out;
+		goto err_unmap_fdt;
 	}
 
 	mem_map_phys = kho_get_mem_map_phys(fdt);
-	if (!mem_map_phys) {
-		err = -ENOENT;
-		goto out;
-	}
+	if (!mem_map_phys)
+		goto err_unmap_fdt;
 
 	scratch = early_memremap(scratch_phys, scratch_len);
 	if (!scratch) {
 		pr_warn("setup: failed to memremap scratch (phys=0x%llx, len=%lld)\n",
 			scratch_phys, scratch_len);
-		err = -EFAULT;
-		goto out;
+		goto err_unmap_fdt;
 	}
 
 	/*
@@ -1497,7 +1491,7 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 		if (WARN_ON(err)) {
 			pr_warn("failed to mark the scratch region 0x%pa+0x%pa: %pe",
 				&area->addr, &size, ERR_PTR(err));
-			goto out;
+			goto err_unmap_scratch;
 		}
 		pr_debug("Marked 0x%pa+0x%pa as scratch", &area->addr, &size);
 	}
@@ -1519,13 +1513,14 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 	kho_scratch_cnt = scratch_cnt;
 	pr_info("found kexec handover data.\n");
 
-out:
-	if (fdt)
-		early_memunmap(fdt, fdt_len);
-	if (scratch)
-		early_memunmap(scratch, scratch_len);
-	if (err)
-		pr_warn("disabling KHO revival: %d\n", err);
+	return;
+
+err_unmap_scratch:
+	early_memunmap(scratch, scratch_len);
+err_unmap_fdt:
+	early_memunmap(fdt, fdt_len);
+err_report:
+	pr_warn("disabling KHO revival\n");
 }
 
 /* Helper functions for kexec_file_load */

base-commit: 24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7
-- 
2.51.0


