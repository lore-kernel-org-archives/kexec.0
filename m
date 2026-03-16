Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A576DF46453
	for <kexec@archiver.kernel.org>; Mon, 16 Mar 2026 11:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pcJSSMgXdtqSd0+U3RfszD90qV0ESOhNKpQO5qlUuk4=; b=SilH4u4i9apaxAm0tXhi/t/bNx
	9v96PV5lNd7IzlvocHbfolQbP/zDy9IHXffKHLq0+mUVgAa14Em06PgzrTLbbi+AKV4THkKzKGhBH
	1JXALcEPvHH7Gq5PArRFCMGN21lh4hxeJ9/QppLXsvfKpiBss0P3nJJhRUFT9G6Jyo8rdxLwO+wEV
	pTmWDliaHFJuziK7G9O7yD1lqSI9517sKG47n7XQ8FTgr0KQ+vHhfetVdpPJh2dlWufO5pc80PAr+
	mTXPMTGRdKpQ8XHmBYKTtHUk753nB9jlk37DX9wUUGM8d4Ak0ZtjDwII0/nUeAASpyGn+4IoaRJzf
	PXwXwKog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w26YX-00000003rw3-0diA;
	Mon, 16 Mar 2026 11:56:21 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w26YT-00000003rut-3E5l
	for kexec@lists.infradead.org;
	Mon, 16 Mar 2026 11:56:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=pcJSSMgXdtqSd0+U3RfszD90qV0ESOhNKpQO5qlUuk4=; b=uCBj+Dq2YKsg9NtvU0RYACTdnT
	/D42zyTmlwd2iMFWUI+GWv0Z4J6oLKf2KbDRrBV0SNbEGNNpMxZhiSt8tmnD1ECYxL1x5Ph2sUiwM
	5gsOQ5nv2vS/74qb8JF1D2svK3U25IorDO5J/jWKjSO9sYhgdkwz3Tj3JTO61N+c2ufPgkN1dCFsR
	HcCYprLUq+cHmdHAbAimKU7KtCkr9RaL+5Se1uNSGN+QLz6sRCqDZbhvthFpX29tmzX6uddHwQ8pp
	ywoh38zgsm4Nbo6MZGQN11DcIn1N1UtAEzVT915zqcjQDw+vKCnP48OAft0vJaOM1oVOsgGT5+zgZ
	eA2qa6CA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w26YN-0025yw-JG; Mon, 16 Mar 2026 11:56:10 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 16 Mar 2026 04:54:31 -0700
Subject: [PATCH v9 1/6] kho: add size parameter to kho_add_subtree()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-kho-v9-1-ed6dcd951988@debian.org>
References: <20260316-kho-v9-0-ed6dcd951988@debian.org>
In-Reply-To: <20260316-kho-v9-0-ed6dcd951988@debian.org>
To: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-mm@kvack.org, usama.arif@linux.dev, Breno Leitao <leitao@debian.org>, 
 SeongJae Park <sj@kernel.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-363b9
X-Developer-Signature: v=1; a=openpgp-sha256; l=9305; i=leitao@debian.org;
 h=from:subject:message-id; bh=ZINrtSAqEMynn+IK2Mha2BFhMjVOo8eeR6qkY8mCn3Q=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpt+/QRUXxNVd9164+/pNrm/TpfyExDD5YV1mc3
 hmtdGhCSi2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCabfv0AAKCRA1o5Of/Hh3
 bSAYEACON8fL8GUSVSmsSJg0qQk5osBc0D9+p0+C543bZHSyImySFR8MqvWo92DDQ1C1aSbU11M
 5MEAU7zlEIzVYYulpYTL+AgGmqJTlLtd5f2BGaWwOBNwwO3g70+cUv0EdnZ/6lVjCTGH5oanM0a
 3y+Q/fUZR7VIQfzCyyBYidBA11YyYEVOl58dmezl/1T32V33/T1/zMP40VJT7Bydjjuevnbqc0j
 rCTVSuRjERl3BLIpQHszFp5URKm2REmt6mDq/pzcpcuiC3+aLR64g7So/LYK/KUMqwNCbdV+lxr
 ocSk2Ea50DGzdCO2qKMe5m5rJ+SgG55MNB4SoLONG5OLrFC8+pKUNkQWuLOUa0APxn8iIfLEYcT
 x3gZM3r0yL81+Yk0R1mblWvSRgVMTKugqHRonq7nnKr8GJ8Wpe/qnm9TwNhByyG4ASaBim2VmZA
 LszmN453122tKqMZhjMZBU8kjuSC1SvYMMRGM9M9RvRYn2S9lGFS18QjjTCUr+lOLWase31kymY
 Ha+1dZnOy+WZb2KzG7adZ4crRLAtCYyeOX1NiPLbKcCPEKyTkTxrp3j+SigkWvH1A9L9VoxIjr6
 0b5BDIHK/7xWf17om8vSaC7Vge9G9+RqC3TpwjCTJY7fyrk0a9IE2qlYaGKYdKZS4XyJau/dU/i
 j5cEVemYvfQs30Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260316_045618_398538_02067FF0 
X-CRM114-Status: GOOD (  19.53  )
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

kho_add_subtree() assumes the fdt argument is always an FDT and calls
fdt_totalsize() on it in the debugfs code path. This assumption will
break if a caller passes arbitrary data instead of an FDT.

When CONFIG_KEXEC_HANDOVER_DEBUGFS is enabled, kho_debugfs_fdt_add()
calls __kho_debugfs_fdt_add(), which executes:

    f->wrapper.size = fdt_totalsize(fdt);

Fix this by adding an explicit size parameter to kho_add_subtree() so
callers specify the blob size. This allows subtrees to contain
arbitrary data formats, not just FDTs. Update all callers:

  - memblock.c: use fdt_totalsize(fdt)
  - luo_core.c: use fdt_totalsize(fdt_out)
  - test_kho.c: use fdt_totalsize()
  - kexec_handover.c (root fdt): use fdt_totalsize(kho_out.fdt)

Also update __kho_debugfs_fdt_add() to receive the size explicitly
instead of computing it internally via fdt_totalsize(). In
kho_in_debugfs_init(), pass fdt_totalsize() for the root FDT and
sub-blobs since all current users are FDTs. A subsequent patch will
persist the size in the KHO FDT so the incoming side can handle
non-FDT blobs correctly.

Suggested-by: Pratyush Yadav <pratyush@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/kexec_handover.h              |  4 ++--
 kernel/liveupdate/kexec_handover.c          |  8 +++++---
 kernel/liveupdate/kexec_handover_debugfs.c  | 15 +++++++++------
 kernel/liveupdate/kexec_handover_internal.h |  5 +++--
 kernel/liveupdate/luo_core.c                |  3 ++-
 lib/test_kho.c                              |  3 ++-
 mm/memblock.c                               |  2 +-
 7 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index ac4129d1d7416..abb1d324f42d0 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -32,7 +32,7 @@ void kho_restore_free(void *mem);
 struct folio *kho_restore_folio(phys_addr_t phys);
 struct page *kho_restore_pages(phys_addr_t phys, unsigned long nr_pages);
 void *kho_restore_vmalloc(const struct kho_vmalloc *preservation);
-int kho_add_subtree(const char *name, void *fdt);
+int kho_add_subtree(const char *name, void *fdt, size_t size);
 void kho_remove_subtree(void *fdt);
 int kho_retrieve_subtree(const char *name, phys_addr_t *phys);
 
@@ -97,7 +97,7 @@ static inline void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
 	return NULL;
 }
 
-static inline int kho_add_subtree(const char *name, void *fdt)
+static inline int kho_add_subtree(const char *name, void *fdt, size_t size)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index b64f36a452965..55bdc5d2d1929 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -752,6 +752,7 @@ static void __init kho_reserve_scratch(void)
  * kho_add_subtree - record the physical address of a sub FDT in KHO root tree.
  * @name: name of the sub tree.
  * @fdt: the sub tree blob.
+ * @size: size of the blob in bytes.
  *
  * Creates a new child node named @name in KHO root FDT and records
  * the physical address of @fdt. The pages of @fdt must also be preserved
@@ -763,7 +764,7 @@ static void __init kho_reserve_scratch(void)
  *
  * Return: 0 on success, error code on failure
  */
-int kho_add_subtree(const char *name, void *fdt)
+int kho_add_subtree(const char *name, void *fdt, size_t size)
 {
 	phys_addr_t phys = virt_to_phys(fdt);
 	void *root_fdt = kho_out.fdt;
@@ -788,7 +789,7 @@ int kho_add_subtree(const char *name, void *fdt)
 	if (err < 0)
 		goto out_pack;
 
-	WARN_ON_ONCE(kho_debugfs_fdt_add(&kho_out.dbg, name, fdt, false));
+	WARN_ON_ONCE(kho_debugfs_fdt_add(&kho_out.dbg, name, fdt, size, false));
 
 out_pack:
 	fdt_pack(root_fdt);
@@ -1452,7 +1453,8 @@ static __init int kho_init(void)
 	}
 
 	WARN_ON_ONCE(kho_debugfs_fdt_add(&kho_out.dbg, "fdt",
-					 kho_out.fdt, true));
+					 kho_out.fdt,
+					 fdt_totalsize(kho_out.fdt), true));
 
 	return 0;
 
diff --git a/kernel/liveupdate/kexec_handover_debugfs.c b/kernel/liveupdate/kexec_handover_debugfs.c
index acf3682226824..ca0153736af13 100644
--- a/kernel/liveupdate/kexec_handover_debugfs.c
+++ b/kernel/liveupdate/kexec_handover_debugfs.c
@@ -25,7 +25,7 @@ struct fdt_debugfs {
 };
 
 static int __kho_debugfs_fdt_add(struct list_head *list, struct dentry *dir,
-				 const char *name, const void *fdt)
+				 const char *name, const void *fdt, size_t size)
 {
 	struct fdt_debugfs *f;
 	struct dentry *file;
@@ -35,7 +35,7 @@ static int __kho_debugfs_fdt_add(struct list_head *list, struct dentry *dir,
 		return -ENOMEM;
 
 	f->wrapper.data = (void *)fdt;
-	f->wrapper.size = fdt_totalsize(fdt);
+	f->wrapper.size = size;
 
 	file = debugfs_create_blob(name, 0400, dir, &f->wrapper);
 	if (IS_ERR(file)) {
@@ -50,7 +50,7 @@ static int __kho_debugfs_fdt_add(struct list_head *list, struct dentry *dir,
 }
 
 int kho_debugfs_fdt_add(struct kho_debugfs *dbg, const char *name,
-			const void *fdt, bool root)
+			const void *fdt, size_t size, bool root)
 {
 	struct dentry *dir;
 
@@ -59,7 +59,7 @@ int kho_debugfs_fdt_add(struct kho_debugfs *dbg, const char *name,
 	else
 		dir = dbg->sub_fdt_dir;
 
-	return __kho_debugfs_fdt_add(&dbg->fdt_list, dir, name, fdt);
+	return __kho_debugfs_fdt_add(&dbg->fdt_list, dir, name, fdt, size);
 }
 
 void kho_debugfs_fdt_remove(struct kho_debugfs *dbg, void *fdt)
@@ -113,7 +113,8 @@ __init void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt)
 		goto err_rmdir;
 	}
 
-	err = __kho_debugfs_fdt_add(&dbg->fdt_list, dir, "fdt", fdt);
+	err = __kho_debugfs_fdt_add(&dbg->fdt_list, dir, "fdt", fdt,
+				    fdt_totalsize(fdt));
 	if (err)
 		goto err_rmdir;
 
@@ -121,6 +122,7 @@ __init void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt)
 		int len = 0;
 		const char *name = fdt_get_name(fdt, child, NULL);
 		const u64 *fdt_phys;
+		void *sub_fdt;
 
 		fdt_phys = fdt_getprop(fdt, child, KHO_FDT_SUB_TREE_PROP_NAME, &len);
 		if (!fdt_phys)
@@ -130,8 +132,9 @@ __init void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt)
 				name, len);
 			continue;
 		}
+		sub_fdt = phys_to_virt(*fdt_phys);
 		err = __kho_debugfs_fdt_add(&dbg->fdt_list, sub_fdt_dir, name,
-					    phys_to_virt(*fdt_phys));
+					    sub_fdt, fdt_totalsize(sub_fdt));
 		if (err) {
 			pr_warn("failed to add fdt %s to debugfs: %pe\n", name,
 				ERR_PTR(err));
diff --git a/kernel/liveupdate/kexec_handover_internal.h b/kernel/liveupdate/kexec_handover_internal.h
index 9a832a35254cf..2a28cb8db9b0a 100644
--- a/kernel/liveupdate/kexec_handover_internal.h
+++ b/kernel/liveupdate/kexec_handover_internal.h
@@ -27,7 +27,7 @@ int kho_debugfs_init(void);
 void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt);
 int kho_out_debugfs_init(struct kho_debugfs *dbg);
 int kho_debugfs_fdt_add(struct kho_debugfs *dbg, const char *name,
-			const void *fdt, bool root);
+			const void *fdt, size_t size, bool root);
 void kho_debugfs_fdt_remove(struct kho_debugfs *dbg, void *fdt);
 #else
 static inline int kho_debugfs_init(void) { return 0; }
@@ -35,7 +35,8 @@ static inline void kho_in_debugfs_init(struct kho_debugfs *dbg,
 				       const void *fdt) { }
 static inline int kho_out_debugfs_init(struct kho_debugfs *dbg) { return 0; }
 static inline int kho_debugfs_fdt_add(struct kho_debugfs *dbg, const char *name,
-				      const void *fdt, bool root) { return 0; }
+				      const void *fdt, size_t size,
+				      bool root) { return 0; }
 static inline void kho_debugfs_fdt_remove(struct kho_debugfs *dbg,
 					  void *fdt) { }
 #endif /* CONFIG_KEXEC_HANDOVER_DEBUGFS */
diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index 84ac728d63baa..04d06a0906c0e 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -172,7 +172,8 @@ static int __init luo_fdt_setup(void)
 	if (err)
 		goto exit_free;
 
-	err = kho_add_subtree(LUO_FDT_KHO_ENTRY_NAME, fdt_out);
+	err = kho_add_subtree(LUO_FDT_KHO_ENTRY_NAME, fdt_out,
+			      fdt_totalsize(fdt_out));
 	if (err)
 		goto exit_free;
 	luo_global.fdt_out = fdt_out;
diff --git a/lib/test_kho.c b/lib/test_kho.c
index 7ef9e40618696..2631824373152 100644
--- a/lib/test_kho.c
+++ b/lib/test_kho.c
@@ -143,7 +143,8 @@ static int kho_test_preserve(struct kho_test_state *state)
 	if (err)
 		goto err_unpreserve_data;
 
-	err = kho_add_subtree(KHO_TEST_FDT, folio_address(state->fdt));
+	err = kho_add_subtree(KHO_TEST_FDT, folio_address(state->fdt),
+			      fdt_totalsize(folio_address(state->fdt)));
 	if (err)
 		goto err_unpreserve_data;
 
diff --git a/mm/memblock.c b/mm/memblock.c
index ae6a5af46bd78..29e12ea2a854c 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2488,7 +2488,7 @@ static int __init prepare_kho_fdt(void)
 	if (err)
 		goto err_unpreserve_fdt;
 
-	err = kho_add_subtree(MEMBLOCK_KHO_FDT, fdt);
+	err = kho_add_subtree(MEMBLOCK_KHO_FDT, fdt, fdt_totalsize(fdt));
 	if (err)
 		goto err_unpreserve_fdt;
 

-- 
2.52.0


