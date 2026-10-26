Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511DF606A327
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 17:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=F/d7IDuo;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=K1x3mJX6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=YNhavcwMmnkc/7Ctxrs7vPIYiccZaS2q3CINRB+03cg=; b=F/d7IDuoQ0F3Zfer45WiE5f34t
	7gSOw7GAFlITpdVjr2LaNK8968W8xqmP2/cYNWOqnxYVKRHP3ZwgE4TiCFyFBQbJJn6kyIm4EwxBm
	Wia+DviNfonnrK8WxsrDsouZJddCRouirmO0lBmMo1LiG1glnsKw2iqcl5HmOL8PObBVIcZfGtotF
	tJZWe+YlRU5DsGWN3JyjLZLCi5bEt1BrU5y42tu1qSUprAKFogrjJf/T4HlSajyiOthP07jAh0K5m
	26AwJ0LAMiTQIhx/wiYjTU5oHCzwZuWIYew64Kux0QSBu/ME5WHRhYans0pbHmN+dVL5kdJBIp+ft
	pWJxdP5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLOiO-000000030ZF-0CYS;
	Mon, 26 Oct 2026 17:42:32 +0000
Received: from mail-ej1-x647.google.com ([2a00:1450:4864:20::647])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLOiJ-000000030X6-1d2A
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 17:42:28 +0000
Received: by mail-ej1-x647.google.com with SMTP id a640c23a62f3a-c40d92085ceso13919066b.0
        for <kexec@lists.infradead.org>; Mon, 26 Oct 2026 10:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793036545; x=1793641345; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YNhavcwMmnkc/7Ctxrs7vPIYiccZaS2q3CINRB+03cg=;
        b=K1x3mJX6YATi52nf8pz8K2/GMIUUehrERcbq0ULwfWJp6YEmLUQlnf+bjGiX7FpXBr
         ERLoveb2/JavB1SRtqbR89ETUW+G26epuSxSrWTPgpRnnChbpzE7mpfQkzC4TfA5vGsU
         gzn9SD8zMqjy1uduGUdXqUD2+Cq+Ecu+CLPaIixC3O6YFj56Mk20PkEmm81MKrivcv4h
         n9SL3q1YIvaxOtFEiawZ4trGXqpmbjp2jWvJL4sYIhuWnyvv5gfD3seNFZ8V/K3OdD9k
         w9ZBydDSUzWUdJZmZL00MWbR1sEsfeeiVXX0b7AGwEDc0rnpZjBZ9aSrDWleFLhP2mqT
         V99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793036545; x=1793641345;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YNhavcwMmnkc/7Ctxrs7vPIYiccZaS2q3CINRB+03cg=;
        b=OKWW2T32pfgDNd6XKdcBB2WOYagPln2z76fE/N5BEYqoAE+8snIQW+rQB933fw7zvs
         Mg1cvAfCQkEQqg8grYL6Nv5b57E1N+9MpNqe+I4Nc5q9NwrYDHzTmLjaHS+k82iTiQNG
         R2gquw87hDGFtDx2bHFuY70wNUeDiSbxpjSPJlgRrMcxu3NxhSFLcDJLnD6lIpZCaaiX
         5tYBKlkX34k2A0L0Y7f/PXiAkliQxuoJtCkBhgm700SCRg0O4RZQuTkBmVVR1xp2sDPY
         n3N73B9bVy56fShY9P3qexKoxeMgSi47+Cd9YDkD06aWqfsBa1CrYFTZAHSAUzh3tQ7e
         Z6xw==
X-Forwarded-Encrypted: i=1; AKwUvBweVdeguqgWY9PEp4+o4UlD67AdJnvTzD+noO/X1OWjRFg+MXHdl4PwjVy2hqdFXeN1DIVD2w==@lists.infradead.org
X-Gm-Message-State: AFq9FYLwydQuEDSLOAeiNA+RGvYJyewobbf+Ug/t3FuzhWvTVZP+9NU2
	jKK9fvFSyNBBhH0EA+mKOLBcTTFvacnkptpqcHCVx2rGBFmyeE2c0qSbgEgfzwW7ZnAAeCjkJXH
	FQiaZZ77jGfDYazOmAw==
X-Received: from ejyz9.prod.google.com ([2002:a17:906:d009:b0:c31:667b:ebec])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:7fa7:b0:c2d:c6e7:9e9a with SMTP id a640c23a62f3a-c49a72250d3mr35398966b.11.1793036542749;
 Mon, 26 Oct 2026 10:42:22 -0700 (PDT)
Date: Mon, 26 Oct 2026 17:42:16 +0000
In-Reply-To: <20261026174217.603114-1-tarunsahu@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261026174217.603114-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261026174217.603114-4-tarunsahu@google.com>
Subject: [RFC PATCH v3 3/4] mm: memfd_luo: Add the feature header
From: Tarun Sahu <tarunsahu@google.com>
To: loganodell@google.com, alex@shazbot.org, dwmw2@infradead.org, 
	seanjc@google.com, Mike Rapoport <rppt@kernel.org>, will@kernel.org, pbonzini@redhat.com, 
	jgg@nvidia.com, Pasha Tatashin <pasha.tatashin@soleen.com>, arnd@arndb.de, 
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, oupton@kernel.org, 
	baolu.lu@linux.intel.com, David Matlack <dmatlack@google.com>, robin.murphy@arm.com, 
	maz@kernel.org, Alexander Graf <graf@amazon.com>, joro@8bytes.org, 
	Bjorn Helgaas <bhelgaas@google.com>, kevin.tian@intel.com, 
	Pratyush Yadav <pratyush@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261026_104227_481034_89C41139 
X-CRM114-Status: GOOD (  26.14  )
X-Spam-Score: -9.5 (---------)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-26.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Precede struct memfd_luo_ser with the 8-byte struct luo_ser_hdr for
memfd preservation. The source kernel writes the state through struct
memfd_luo_ser_wrap, declared with DECLARE_LUO_SER_WRAP():

  DECLARE_LUO_SER_WRAP(memfd_luo_ser, 64, MEMFD_LUO_FEAT_MAX);

This consists of hdr + memfd_luo_ser (payload).

The existing struct memfd_luo_ser fields (pos, size, seals, flags,
nr_folios, folios, and MEMFD_LUO_ALL_SEALS) form MEMFD_LUO_FEAT_CORE
(index 0 of enum memfd_luo_feature). The source kernel marks it as
LUO_FEAT_REQUIRED when preserving state, and the target kernel marks it
as supported (true) in its memfd_luo_supported_feats table passed to
luo_ser_hdr_validate(). Future changes append any new fields to the end
of struct memfd_luo_ser under a new feature index so existing field
offsets never shift.

memfd_luo_retrieve() and memfd_luo_finish() validate the incoming header
against memfd_luo_supported_feats with luo_ser_hdr_validate() before
accessing any payload field; finish warns and skips discarding the folios
when the header is invalid.

Prepending the header shifts every field of the serialized memfd state,
so bump MEMFD_LUO_FH_COMPATIBLE from memfd-v2 to memfd-v3.

Signed-off-by: Logan Odell <loganodell@google.com>
Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/linux/kho/abi/memfd.h | 32 +++++++++++++++--
 mm/memfd_luo.c                | 68 ++++++++++++++++++++++++-----------
 2 files changed, 77 insertions(+), 23 deletions(-)

diff --git a/include/linux/kho/abi/memfd.h b/include/linux/kho/abi/memfd.h
index 7115a8a77cfd..d467d18fe6e8 100644
--- a/include/linux/kho/abi/memfd.h
+++ b/include/linux/kho/abi/memfd.h
@@ -14,6 +14,7 @@
 #include <linux/build_bug.h>
 #include <linux/types.h>
 #include <linux/kho/abi/kexec_handover.h>
+#include <linux/kho/abi/luo.h>
 
 /**
  * DOC: memfd Live Update ABI
@@ -22,9 +23,18 @@
  * reboot using the LUO.
  *
  * The state is serialized into `struct memfd_luo_ser`
- * which is handed over to the next kernel via the KHO mechanism.
+ * which is handed over to the target kernel via the KHO mechanism.
  *
- * This interface is a contract. Any modification to the structure layout
+ * This interface is a contract. The serialized state starts with an
+ * 8-byte `struct luo_ser_hdr` followed by `struct memfd_luo_ser`.
+ * The relative order and offsets of fields must remain unchanged as
+ * features are added or retired: new fields are appended at the end of
+ * `struct memfd_luo_ser` under a new feature flag, and retired fields are
+ * kept in place so subsequent offsets never shift. In the target kernel,
+ * the fields of a feature are read only after `luo_ser_get_feat()` shows
+ * the feature present.
+ *
+ * Any modification to the structure layout beyond feature extensions
  * constitutes a breaking change. Such changes require incrementing the
  * version number in the MEMFD_LUO_FH_COMPATIBLE string.
  */
@@ -70,6 +80,17 @@ static_assert(sizeof(struct memfd_luo_folio_ser) == 16);
 			     F_SEAL_FUTURE_WRITE | \
 			     F_SEAL_EXEC)
 
+/**
+ * enum memfd_luo_feature - Feature indices for &struct memfd_luo_ser.
+ * @MEMFD_LUO_FEAT_CORE: Core feature covering `pos`, `size`, `seals`, `flags`,
+ *                       `nr_folios`, `folios`, and %MEMFD_LUO_ALL_SEALS.
+ * @MEMFD_LUO_FEAT_MAX:  Number of defined &enum memfd_luo_feature features.
+ */
+enum memfd_luo_feature {
+	MEMFD_LUO_FEAT_CORE = 0,
+	MEMFD_LUO_FEAT_MAX,
+};
+
 /**
  * struct memfd_luo_ser - Main serialization structure for a memfd.
  * @pos:       The file's current position (f_pos).
@@ -80,6 +101,8 @@ static_assert(sizeof(struct memfd_luo_folio_ser) == 16);
  * @nr_folios: Number of folios in the folios array.
  * @folios:    KHO vmalloc descriptor pointing to the array of
  *             struct memfd_luo_folio_ser.
+ *
+ * Preceded by &struct luo_ser_hdr.
  */
 struct memfd_luo_ser {
 	u64 pos;
@@ -92,7 +115,10 @@ struct memfd_luo_ser {
 
 static_assert(sizeof(struct memfd_luo_ser) == 48);
 
+/* memfd state written by this kernel. Never cast incoming state to it. */
+DECLARE_LUO_SER_WRAP(memfd_luo_ser, 64, MEMFD_LUO_FEAT_MAX);
+
 /* The compatibility string for memfd file handler */
-#define MEMFD_LUO_FH_COMPATIBLE	"memfd-v2"
+#define MEMFD_LUO_FH_COMPATIBLE	"memfd-v3"
 
 #endif /* _LINUX_KHO_ABI_MEMFD_H */
diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index 6b68220275eb..85424a5fbc20 100644
--- a/mm/memfd_luo.c
+++ b/mm/memfd_luo.c
@@ -84,6 +84,10 @@
 
 #include "internal.h"
 
+static const bool memfd_luo_supported_feats[MEMFD_LUO_FEAT_MAX] = {
+	[MEMFD_LUO_FEAT_CORE] = true,
+};
+
 static int memfd_luo_preserve_folios(struct file *file,
 				     struct kho_vmalloc *kho_vmalloc,
 				     struct memfd_luo_folio_ser **out_folios_ser,
@@ -258,6 +262,7 @@ static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
 {
 	struct inode *inode = file_inode(args->file);
 	struct memfd_luo_folio_ser *folios_ser;
+	struct memfd_luo_ser_wrap *wrap;
 	struct memfd_luo_ser *ser;
 	u64 nr_folios, inode_size;
 	int err = 0, seals;
@@ -266,9 +271,9 @@ static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
 	shmem_freeze(inode, true);
 
 	/* Allocate the main serialization structure in preserved memory */
-	ser = kho_alloc_preserve(sizeof(*ser));
-	if (IS_ERR(ser)) {
-		err = PTR_ERR(ser);
+	wrap = kho_alloc_preserve(sizeof(*wrap));
+	if (IS_ERR(wrap)) {
+		err = PTR_ERR(wrap);
 		goto err_unlock;
 	}
 
@@ -284,6 +289,10 @@ static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
 		goto err_free_ser;
 	}
 
+	memfd_luo_ser_wrap_init(wrap);
+	luo_ser_set_feat(&wrap->hdr, MEMFD_LUO_FEAT_CORE, LUO_FEAT_REQUIRED);
+
+	ser = &wrap->ser;
 	ser->pos = args->file->f_pos;
 	inode_size = i_size_read(inode);
 
@@ -308,12 +317,12 @@ static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
 	inode_unlock(inode);
 
 	args->private_data = folios_ser;
-	args->serialized_data = virt_to_phys(ser);
+	args->serialized_data = virt_to_phys(wrap);
 
 	return 0;
 
 err_free_ser:
-	kho_unpreserve_free(ser);
+	kho_unpreserve_free(wrap);
 err_unlock:
 	shmem_freeze(inode, false);
 	inode_unlock(inode);
@@ -322,18 +331,18 @@ static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
 
 static int memfd_luo_freeze(struct liveupdate_file_op_args *args)
 {
-	struct memfd_luo_ser *ser;
+	struct memfd_luo_ser_wrap *wrap;
 
 	if (WARN_ON_ONCE(!args->serialized_data))
 		return -EINVAL;
 
-	ser = phys_to_virt(args->serialized_data);
+	wrap = phys_to_virt(args->serialized_data);
 
 	/*
 	 * The pos might have changed since prepare. Everything else stays the
 	 * same.
 	 */
-	ser->pos = args->file->f_pos;
+	wrap->ser.pos = args->file->f_pos;
 
 	return 0;
 }
@@ -341,7 +350,7 @@ static int memfd_luo_freeze(struct liveupdate_file_op_args *args)
 static void memfd_luo_unpreserve(struct liveupdate_file_op_args *args)
 {
 	struct inode *inode = file_inode(args->file);
-	struct memfd_luo_ser *ser;
+	struct memfd_luo_ser_wrap *wrap;
 
 	if (WARN_ON_ONCE(!args->serialized_data))
 		return;
@@ -349,12 +358,12 @@ static void memfd_luo_unpreserve(struct liveupdate_file_op_args *args)
 	inode_lock(inode);
 	shmem_freeze(inode, false);
 
-	ser = phys_to_virt(args->serialized_data);
+	wrap = phys_to_virt(args->serialized_data);
 
-	memfd_luo_unpreserve_folios(&ser->folios, args->private_data,
-				    ser->nr_folios);
+	memfd_luo_unpreserve_folios(&wrap->ser.folios, args->private_data,
+				    wrap->ser.nr_folios);
 
-	kho_unpreserve_free(ser);
+	kho_unpreserve_free(wrap);
 	inode_unlock(inode);
 }
 
@@ -385,6 +394,7 @@ static void memfd_luo_discard_folios(const struct memfd_luo_folio_ser *folios_se
 
 static void memfd_luo_finish(struct liveupdate_file_op_args *args)
 {
+	struct luo_ser_hdr *hdr;
 	struct memfd_luo_folio_ser *folios_ser;
 	struct memfd_luo_ser *ser;
 
@@ -396,10 +406,17 @@ static void memfd_luo_finish(struct liveupdate_file_op_args *args)
 	if (args->retrieve_status)
 		return;
 
-	ser = phys_to_virt(args->serialized_data);
-	if (!ser)
+	if (WARN_ON_ONCE(!args->serialized_data))
 		return;
 
+	hdr = phys_to_virt(args->serialized_data);
+	if (luo_ser_hdr_validate(hdr, memfd_luo_supported_feats,
+				 ARRAY_SIZE(memfd_luo_supported_feats))) {
+		pr_warn("invalid feature header, folios not discarded\n");
+		goto out;
+	}
+
+	ser = luo_ser_payload(hdr);
 	if (ser->nr_folios) {
 		folios_ser = kho_restore_vmalloc(&ser->folios);
 		if (!folios_ser)
@@ -410,7 +427,7 @@ static void memfd_luo_finish(struct liveupdate_file_op_args *args)
 	}
 
 out:
-	kho_restore_free(ser);
+	kho_restore_free(hdr);
 }
 
 static int memfd_luo_retrieve_folios(struct file *file,
@@ -516,15 +533,26 @@ static int memfd_luo_retrieve_folios(struct file *file,
 
 static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
 {
+	struct luo_ser_hdr *hdr;
 	struct memfd_luo_folio_ser *folios_ser;
 	struct memfd_luo_ser *ser;
 	struct file *file;
 	int err;
 
-	ser = phys_to_virt(args->serialized_data);
-	if (!ser)
+	if (WARN_ON_ONCE(!args->serialized_data))
 		return -EINVAL;
 
+	hdr = phys_to_virt(args->serialized_data);
+	err = luo_ser_hdr_validate(hdr, memfd_luo_supported_feats,
+				   ARRAY_SIZE(memfd_luo_supported_feats));
+	if (err) {
+		pr_err("memfd_luo_ser feature header validation failed (size=%u, nr_features=%u): %pe\n",
+		       hdr->size, hdr->nr_features, ERR_PTR(err));
+		goto free_ser;
+	}
+
+	ser = luo_ser_payload(hdr);
+
 	/* Make sure the file only has seals supported by this version. */
 	if (ser->seals & ~MEMFD_LUO_ALL_SEALS) {
 		err = -EOPNOTSUPP;
@@ -565,14 +593,14 @@ static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
 	}
 
 	args->file = file;
-	kho_restore_free(ser);
+	kho_restore_free(hdr);
 
 	return 0;
 
 put_file:
 	fput(file);
 free_ser:
-	kho_restore_free(ser);
+	kho_restore_free(hdr);
 	return err;
 }
 
-- 
2.56.0.307.g5fe7bd680c-goog


