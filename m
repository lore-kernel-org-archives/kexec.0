Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CEE1D2F03B
	for <kexec@archiver.kernel.org>; Tue, 27 Jan 2026 14:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ppkYoCuCIwbG08Yog1w1PKZoiZaGtf8kK0Yf9zB3YpY=; b=aZiEARFyIRvMX0SJVY8e4F5/0N
	aGCv573whC+L28QAssR3WrYSAeCznr70ds/EBrJXOrtdVrvESQWfut8cInt9uzzlNK5iAwIvEnvh0
	kXAi4FV8eIWgBLGOGvDpJqAWd5coCwPS3IWO4u9vOudzv02cTjJHp9XXhEYXGYxLiabonXAtWpNPl
	W+2YtwsuOwQWDUNJtG8ZE2ibcqCQZJjNNdJy0wApgx9ZnvkYiMIt0r7fkhxQDcdrXNNygE2kWsv5a
	0V4IcHuwJwjuRfHPPZIwhHOyN5c/99x6dcwB3OS7HXePoxQvTYI809bnbA8ZiT+Dmm9QOswyJE0UA
	x85dUx5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkkDD-0000000EPYx-40FZ;
	Tue, 27 Jan 2026 14:38:35 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkkDA-0000000EPXB-1wbp
	for kexec@lists.infradead.org;
	Tue, 27 Jan 2026 14:38:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=ppkYoCuCIwbG08Yog1w1PKZoiZaGtf8kK0Yf9zB3YpY=; b=iX4++nwmPyyfA9UIOdjH2mSyHF
	Jw2TGQpc8CK0TuxKaivM6Ut1YtVbgkbzz3i3OipDWGK/y+dAKh7mNRsBXJ8zervKp/6Lvwvttv7ua
	gpLVJIg7nxpG1pYMkk5BS6CP2UkJy29go0G0f7Z/bMW9azK6R/HIabSTttfgVNQgOlY5y73+1yX/S
	IW8vnoYDW55ogz1sEiRiLP1WCMgYx1bDxh9nhVi1OWH86QDcakpQL3RlqLERmnzp3inqkuP+A1X83
	kiSjwDCgJsXldxyoxN6lI3Y5KBYRQnMYjiaAOdU7Q7gsuFynTlFee3TrEixgHNAm3IcI5tzfszHLU
	EOU/w3lw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vkkD3-00H3b9-MS; Tue, 27 Jan 2026 14:38:26 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 27 Jan 2026 06:37:36 -0800
Subject: [PATCH v6 1/4] kho: add size parameter to kho_add_subtree()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-kho-v6-1-56f9396681c2@debian.org>
References: <20260127-kho-v6-0-56f9396681c2@debian.org>
In-Reply-To: <20260127-kho-v6-0-56f9396681c2@debian.org>
To: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-mm@kvack.org, usamaarif642@gmail.com, rmikey@meta.com, clm@fb.com, 
 riel@surriel.com, Breno Leitao <leitao@debian.org>, 
 SeongJae Park <sj@kernel.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-f4305
X-Developer-Signature: v=1; a=openpgp-sha256; l=9092; i=leitao@debian.org;
 h=from:subject:message-id; bh=nk3yyun6LiJx2hB1RVium4TTK98kuuyYqMmz5Tx1hAc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpeM3Wnk5kJhqw21vjInix4DA5gZacK/0QQ2Ckq
 LMAStNlioyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXjN1gAKCRA1o5Of/Hh3
 bTdBD/9jXaXJvc23pY8B3+/fv4tKZqlbkoijG6RR/T1DyACmP3943c/gwoIZTcJCUTl5/bup/vE
 aBSptIjtYz4+FZGzu37omfjUU6frY+vS6gE8Nwx97zMuxAA1jfW6fAvLvDagyYgfzSUcV/6g0X7
 5RxDmj0OVaiq08orWHyfYZUY61MEy/o76114FYj3qyDbUm6L+sdwyRnEP2AqXQeCSMfPw2DWMda
 YDxLQLgAnF/icmdLKuXGXk99fZuVG30yDhaLw6V8tc4IRBVLSIwX9Z9NGOXSELi2Ke7Zl49DoWY
 6lKFAl2GOuJHC8DpEtUdRNMpJhNxV9E9/Ik+535Ii3rnpoUEGE4lhic2VVsE5rCvJ0tBMh/Cn1a
 DP9Thcm1qx9U5U5Nkf9jNam0u4NcWSG4t0WAwImyzG0HiGfv9NEuORY00yPIKWzcflg0+rkcsq+
 E8A3/O56XS63mqGh1LrEOyz4ALG+4uFcZ3vPMMFQBNbTJZJNLFGlsH5yjqS58hZfTrwckS4NsNr
 tulrzon/DE7epcWHop6o3YwRgUK9dHG7/erTuPmxUQ1hUGm1RLGUG7YtCpCNBGXXAlYiVaADzQv
 PK60F5iE4CTZGqaO03nweNEwHqhF7VdYF+Led+hvM0XEZLUfifHmAQwXhOEUxncXOubJY7J3ffH
 1LFeYfAkNugoiTw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260127_063832_697831_00B96727 
X-CRM114-Status: GOOD (  20.36  )
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

Also update kho_in_debugfs_init() to compute sizes using fdt_totalsize()
for the root and sub-FDTs it processes, since these are known to be
actual FDT blobs.

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
index 8a2b2a7e50fc6..ad2da9e4e6a04 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -726,6 +726,7 @@ static void __init kho_reserve_scratch(void)
  * kho_add_subtree - record the physical address of a sub FDT in KHO root tree.
  * @name: name of the sub tree.
  * @fdt: the sub tree blob.
+ * @size: size of the blob in bytes.
  *
  * Creates a new child node named @name in KHO root FDT and records
  * the physical address of @fdt. The pages of @fdt must also be preserved
@@ -737,7 +738,7 @@ static void __init kho_reserve_scratch(void)
  *
  * Return: 0 on success, error code on failure
  */
-int kho_add_subtree(const char *name, void *fdt)
+int kho_add_subtree(const char *name, void *fdt, size_t size)
 {
 	phys_addr_t phys = virt_to_phys(fdt);
 	void *root_fdt = kho_out.fdt;
@@ -762,7 +763,7 @@ int kho_add_subtree(const char *name, void *fdt)
 	if (err < 0)
 		goto out_pack;
 
-	WARN_ON_ONCE(kho_debugfs_fdt_add(&kho_out.dbg, name, fdt, false));
+	WARN_ON_ONCE(kho_debugfs_fdt_add(&kho_out.dbg, name, fdt, size, false));
 
 out_pack:
 	fdt_pack(root_fdt);
@@ -1402,7 +1403,8 @@ static __init int kho_init(void)
 	}
 
 	WARN_ON_ONCE(kho_debugfs_fdt_add(&kho_out.dbg, "fdt",
-					 kho_out.fdt, true));
+					 kho_out.fdt,
+					 fdt_totalsize(kho_out.fdt), true));
 
 	return 0;
 
diff --git a/kernel/liveupdate/kexec_handover_debugfs.c b/kernel/liveupdate/kexec_handover_debugfs.c
index 2abbf62ba9424..64970c88c483c 100644
--- a/kernel/liveupdate/kexec_handover_debugfs.c
+++ b/kernel/liveupdate/kexec_handover_debugfs.c
@@ -24,7 +24,7 @@ struct fdt_debugfs {
 };
 
 static int __kho_debugfs_fdt_add(struct list_head *list, struct dentry *dir,
-				 const char *name, const void *fdt)
+				 const char *name, const void *fdt, size_t size)
 {
 	struct fdt_debugfs *f;
 	struct dentry *file;
@@ -34,7 +34,7 @@ static int __kho_debugfs_fdt_add(struct list_head *list, struct dentry *dir,
 		return -ENOMEM;
 
 	f->wrapper.data = (void *)fdt;
-	f->wrapper.size = fdt_totalsize(fdt);
+	f->wrapper.size = size;
 
 	file = debugfs_create_blob(name, 0400, dir, &f->wrapper);
 	if (IS_ERR(file)) {
@@ -49,7 +49,7 @@ static int __kho_debugfs_fdt_add(struct list_head *list, struct dentry *dir,
 }
 
 int kho_debugfs_fdt_add(struct kho_debugfs *dbg, const char *name,
-			const void *fdt, bool root)
+			const void *fdt, size_t size, bool root)
 {
 	struct dentry *dir;
 
@@ -58,7 +58,7 @@ int kho_debugfs_fdt_add(struct kho_debugfs *dbg, const char *name,
 	else
 		dir = dbg->sub_fdt_dir;
 
-	return __kho_debugfs_fdt_add(&dbg->fdt_list, dir, name, fdt);
+	return __kho_debugfs_fdt_add(&dbg->fdt_list, dir, name, fdt, size);
 }
 
 void kho_debugfs_fdt_remove(struct kho_debugfs *dbg, void *fdt)
@@ -130,7 +130,8 @@ __init void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt)
 		goto err_rmdir;
 	}
 
-	err = __kho_debugfs_fdt_add(&dbg->fdt_list, dir, "fdt", fdt);
+	err = __kho_debugfs_fdt_add(&dbg->fdt_list, dir, "fdt", fdt,
+				    fdt_totalsize(fdt));
 	if (err)
 		goto err_rmdir;
 
@@ -138,6 +139,7 @@ __init void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt)
 		int len = 0;
 		const char *name = fdt_get_name(fdt, child, NULL);
 		const u64 *fdt_phys;
+		void *sub_fdt;
 
 		fdt_phys = fdt_getprop(fdt, child, "fdt", &len);
 		if (!fdt_phys)
@@ -147,8 +149,9 @@ __init void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt)
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
index 0202c85ad14f9..a51f97f0fa0e6 100644
--- a/kernel/liveupdate/kexec_handover_internal.h
+++ b/kernel/liveupdate/kexec_handover_internal.h
@@ -30,7 +30,7 @@ int kho_debugfs_init(void);
 void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt);
 int kho_out_debugfs_init(struct kho_debugfs *dbg);
 int kho_debugfs_fdt_add(struct kho_debugfs *dbg, const char *name,
-			const void *fdt, bool root);
+			const void *fdt, size_t size, bool root);
 void kho_debugfs_fdt_remove(struct kho_debugfs *dbg, void *fdt);
 #else
 static inline int kho_debugfs_init(void) { return 0; }
@@ -38,7 +38,8 @@ static inline void kho_in_debugfs_init(struct kho_debugfs *dbg,
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
index dda7bb57d421c..a4721813dd994 100644
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
index a20fafaf9846b..f2d7d9108cf41 100644
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
index b3ddfdec7a809..91d4162eec63f 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2510,7 +2510,7 @@ static int __init prepare_kho_fdt(void)
 	if (err)
 		goto err_unpreserve_fdt;
 
-	err = kho_add_subtree(MEMBLOCK_KHO_FDT, fdt);
+	err = kho_add_subtree(MEMBLOCK_KHO_FDT, fdt, fdt_totalsize(fdt));
 	if (err)
 		goto err_unpreserve_fdt;
 

-- 
2.47.3


