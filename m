Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A8B4F0182F
	for <kexec@archiver.kernel.org>; Fri,  6 Mar 2026 12:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BhE/kAyP2PMNYjVkf7VWvL5e+VPagJ0YxqGnWHCRq+U=; b=yzQ2jq2MSIJ3r71AzbrsYQtTPW
	5MB1qeSH4Fdwt8AiicHEd1L47+6kFuqwn4nrzZwMg6Xg0EZdu7RrwNmPDCysuYsDhsThnZFBezZvt
	OpbPvd7jmD4oCisEwYDuEnH58SB1Kcl4G7VgmhwqucepfRbV2ZTskvQUqzTxR5rlh1RcJ2RpUETuV
	8ZLeYgpN3Ucstc/o76t0NwapVCTM4ldrB3VFkOt8Nas7gZ7R//YZL42EeMt9dV0iDhIbG9CB7gnPQ
	iTjXG4aONxhX+Q+zeygTDMcF4QGeRMBgj+646Bzt0D33ISio7q6pI3+yOvA2gJBTN30JV7jS70Juk
	W77enbRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyUTF-00000003f1K-0Qnz;
	Fri, 06 Mar 2026 12:39:57 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyUTC-00000003f03-0QOI
	for kexec@lists.infradead.org;
	Fri, 06 Mar 2026 12:39:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=BhE/kAyP2PMNYjVkf7VWvL5e+VPagJ0YxqGnWHCRq+U=; b=otTFmNzPd7YM26o9dFWndy2jPm
	syzmZNvKrdueC/JBHgsO2f3v9JoR8xugHxv5fEx3H8BAs/CU53elqAj9DQ5QAmjct+F8jOvh+MqdC
	rHZrMxpF2Q8tPyABTCTv/CukKCTnaRsKsMFsZXKgwbYtaNvmLMyUaUeIhr5Bulg7NkXqZTvFx7Aih
	QAFmWemNks0GmVla99JsL7VtKNlV0rW3rOTN0ZwgRIRzIFZqTpydnNF39B/aJNsezRwUxKapu+Iz1
	36PibsBkOI/MBnu35jNALK4kKE6UsDxvCoROvPP0plrVykCpvZp8htU0OCY5na58XLNF2Z+dNpim9
	wNsmNQ2w==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vyUTA-00HVR9-1n; Fri, 06 Mar 2026 12:39:52 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 06 Mar 2026 04:39:22 -0800
Subject: [PATCH v7 3/6] kho: persist blob size in KHO FDT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-kho-v7-3-404d14c188bb@debian.org>
References: <20260306-kho-v7-0-404d14c188bb@debian.org>
In-Reply-To: <20260306-kho-v7-0-404d14c188bb@debian.org>
To: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-mm@kvack.org, usamaarif642@gmail.com, 
 Breno Leitao <leitao@debian.org>, SeongJae Park <sj@kernel.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-363b9
X-Developer-Signature: v=1; a=openpgp-sha256; l=7293; i=leitao@debian.org;
 h=from:subject:message-id; bh=SCRWzBzn9iJWzcyHMXkCR/smhQiBHZEHRDsJ6N05VTs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpqssGJ2ZzRQn7CHLdGRWOkEqcEMCc2WgNTIUfO
 rcE++1Jb5eJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaarLBgAKCRA1o5Of/Hh3
 beRdD/4ndO7EJhwQP5T/1HuZorU8UvNdcgrME6SbRYx078Rnqo/eaP/0Q4iaB4VXYAVfzdgXTFk
 vrOIwL7SsuYiIEfhiIlbIbH7pZ9Wl9WW7n9f+cptxzHEsJlIazkpDo/NdM0XddA7s75ftK4bVoF
 yNTStYv99M2Ozt3ZDKJW4m5yLYSh6GNBEolTu9AaECy8Gwl6uE7NBtPRra2AAdZD60/rcRxfQRT
 Tz5uj7D5wXYKYxSAN3iREssM+claNxo+RoAGMNwHDZ25tCDNmp2EvyMnsP/PzxRVjn4a8Ufxcc1
 T8zTh6xWZkYJgln/twWzdzWWv5KOTk2cyj1ygeLjGJxO7abylNz8Wba9RSfgqRG912/Wh4ABfUp
 iIBZ3p8IRgj7Kpx5TcWCkHr6NuparF+KMRrZfo9w3TW6G6dTJrIeVbVMSYU1WeWlrczPdfkCDer
 VUzwZK4ijCoNumo6ubxZI+gEvA9yeMyrhRaNqebY7JlrgaWp9HgSoBXHB3ejmyP9qBN812Ufdyl
 iABe2Ew0vMudWk52iYlQymdFtxaeJkS3rG443NJXoAvOrYo06pNK72RRLMI6vvxEt4guIzPePIl
 Q4sO2SbPobAUC44aEmOYZ3tI+DzvjgIaSoMP6EkyO7JOhgoaSWPcrkoo2NTV4DbLObZoIbXl7qJ
 +BT22k9C4zgnpiw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260306_043954_311746_2244EE33 
X-CRM114-Status: GOOD (  23.95  )
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

kho_add_subtree() accepts a size parameter but only forwards it to
debugfs. The size is not persisted in the KHO FDT, so it is lost across
kexec. This makes it impossible for the incoming kernel to determine the
blob size without understanding the blob format.

Store the blob size as a "blob-size" property in the KHO FDT alongside
the "preserved-data" physical address. This allows the receiving kernel
to recover the size for any blob regardless of format.

Also extend kho_retrieve_subtree() with an optional size output
parameter so callers can learn the blob size without needing to
understand the blob format. Update all callers to pass NULL for the
new parameter.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/kexec_handover.h         |  5 +++--
 include/linux/kho/abi/kexec_handover.h | 12 ++++++++++++
 kernel/liveupdate/kexec_handover.c     | 28 ++++++++++++++++++++++------
 kernel/liveupdate/luo_core.c           |  2 +-
 lib/test_kho.c                         |  2 +-
 mm/memblock.c                          |  2 +-
 6 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 0666cf298c7f4..8968c56d2d73e 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -34,7 +34,7 @@ struct page *kho_restore_pages(phys_addr_t phys, unsigned long nr_pages);
 void *kho_restore_vmalloc(const struct kho_vmalloc *preservation);
 int kho_add_subtree(const char *name, void *blob, size_t size);
 void kho_remove_subtree(void *blob);
-int kho_retrieve_subtree(const char *name, phys_addr_t *phys);
+int kho_retrieve_subtree(const char *name, phys_addr_t *phys, size_t *size);
 
 void kho_memory_init(void);
 
@@ -104,7 +104,8 @@ static inline int kho_add_subtree(const char *name, void *blob, size_t size)
 
 static inline void kho_remove_subtree(void *blob) { }
 
-static inline int kho_retrieve_subtree(const char *name, phys_addr_t *phys)
+static inline int kho_retrieve_subtree(const char *name, phys_addr_t *phys,
+				       size_t *size)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/abi/kexec_handover.h
index 6b7d8ef550f98..15bf7a5be8cf1 100644
--- a/include/linux/kho/abi/kexec_handover.h
+++ b/include/linux/kho/abi/kexec_handover.h
@@ -47,14 +47,17 @@
  *
  *         <subnode-name-1> {
  *             preserved-data = <0x...>;
+ *             blob-size = <0x...>;
  *         };
  *
  *         <subnode-name-2> {
  *             preserved-data = <0x...>;
+ *             blob-size = <0x...>;
  *         };
  *               ... ...
  *         <subnode-name-N> {
  *             preserved-data = <0x...>;
+ *             blob-size = <0x...>;
  *         };
  *     };
  *
@@ -78,6 +81,12 @@
  *
  *       Physical address pointing to a subnode data blob that is also
  *       being preserved.
+ *
+ *     - blob-size: u64
+ *
+ *       Size in bytes of the preserved data blob. This is needed because
+ *       blobs may use arbitrary formats (not just FDT), so the size
+ *       cannot be determined from the blob content alone.
  */
 
 /* The compatible string for the KHO FDT root node. */
@@ -89,6 +98,9 @@
 /* The FDT property for preserved data blobs. */
 #define KHO_FDT_SUB_TREE_PROP_NAME "preserved-data"
 
+/* The FDT property for the size of preserved data blobs. */
+#define KHO_FDT_SUB_TREE_SIZE_PROP_NAME "blob-size"
+
 /**
  * DOC: Kexec Handover ABI for vmalloc Preservation
  *
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index ebaf3104c36ab..e52615fdd5e4b 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -768,6 +768,7 @@ int kho_add_subtree(const char *name, void *blob, size_t size)
 {
 	phys_addr_t phys = virt_to_phys(blob);
 	void *root_fdt = kho_out.fdt;
+	u64 size_u64 = size;
 	int err = -ENOMEM;
 	int off, fdt_err;
 
@@ -789,6 +790,11 @@ int kho_add_subtree(const char *name, void *blob, size_t size)
 	if (err < 0)
 		goto out_pack;
 
+	err = fdt_setprop(root_fdt, off, KHO_FDT_SUB_TREE_SIZE_PROP_NAME,
+			  &size_u64, sizeof(size_u64));
+	if (err < 0)
+		goto out_pack;
+
 	WARN_ON_ONCE(kho_debugfs_blob_add(&kho_out.dbg, name, blob,
 					  size, false));
 
@@ -1311,16 +1317,17 @@ bool is_kho_boot(void)
 EXPORT_SYMBOL_GPL(is_kho_boot);
 
 /**
- * kho_retrieve_subtree - retrieve a preserved sub FDT by its name.
- * @name: the name of the sub FDT passed to kho_add_subtree().
- * @phys: if found, the physical address of the sub FDT is stored in @phys.
+ * kho_retrieve_subtree - retrieve a preserved sub blob by its name.
+ * @name: the name of the sub blob passed to kho_add_subtree().
+ * @phys: if found, the physical address of the sub blob is stored in @phys.
+ * @size: if not NULL and found, the size of the sub blob is stored in @size.
  *
- * Retrieve a preserved sub FDT named @name and store its physical
- * address in @phys.
+ * Retrieve a preserved sub blob named @name and store its physical
+ * address in @phys and optionally its size in @size.
  *
  * Return: 0 on success, error code on failure
  */
-int kho_retrieve_subtree(const char *name, phys_addr_t *phys)
+int kho_retrieve_subtree(const char *name, phys_addr_t *phys, size_t *size)
 {
 	const void *fdt = kho_get_fdt();
 	const u64 *val;
@@ -1342,6 +1349,15 @@ int kho_retrieve_subtree(const char *name, phys_addr_t *phys)
 
 	*phys = (phys_addr_t)*val;
 
+	if (size) {
+		val = fdt_getprop(fdt, offset, KHO_FDT_SUB_TREE_SIZE_PROP_NAME,
+				  &len);
+		if (val && len == sizeof(*val))
+			*size = (size_t)*val;
+		else
+			*size = 0;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(kho_retrieve_subtree);
diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index 04d06a0906c0e..48b25c9abeda3 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -88,7 +88,7 @@ static int __init luo_early_startup(void)
 	}
 
 	/* Retrieve LUO subtree, and verify its format. */
-	err = kho_retrieve_subtree(LUO_FDT_KHO_ENTRY_NAME, &fdt_phys);
+	err = kho_retrieve_subtree(LUO_FDT_KHO_ENTRY_NAME, &fdt_phys, NULL);
 	if (err) {
 		if (err != -ENOENT) {
 			pr_err("failed to retrieve FDT '%s' from KHO: %pe\n",
diff --git a/lib/test_kho.c b/lib/test_kho.c
index 2631824373152..aa6a0956bb8b7 100644
--- a/lib/test_kho.c
+++ b/lib/test_kho.c
@@ -319,7 +319,7 @@ static int __init kho_test_init(void)
 	if (!kho_is_enabled())
 		return 0;
 
-	err = kho_retrieve_subtree(KHO_TEST_FDT, &fdt_phys);
+	err = kho_retrieve_subtree(KHO_TEST_FDT, &fdt_phys, NULL);
 	if (!err) {
 		err = kho_test_restore(fdt_phys);
 		if (err)
diff --git a/mm/memblock.c b/mm/memblock.c
index 29e12ea2a854c..4f4bf1a9d7900 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2533,7 +2533,7 @@ static void *__init reserve_mem_kho_retrieve_fdt(void)
 	if (fdt)
 		return fdt;
 
-	err = kho_retrieve_subtree(MEMBLOCK_KHO_FDT, &fdt_phys);
+	err = kho_retrieve_subtree(MEMBLOCK_KHO_FDT, &fdt_phys, NULL);
 	if (err) {
 		if (err != -ENOENT)
 			pr_warn("failed to retrieve FDT '%s' from KHO: %d\n",

-- 
2.47.3


