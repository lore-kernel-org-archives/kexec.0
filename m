Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A48A606A32F
	for <kexec@archiver.kernel.org>; Wed, 21 Oct 2026 15:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZF+c6LBw;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=eF1BhjNM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yVHoNG/F+MSh1AvSZ4DFO2pLKQWPL8PGoHBteE3nowI=; b=ZF+c6LBwLIvu3oNvydc99scv0x
	qrGcSKBvkEgXjrq0G2h0po13t/dZ77Pe8WR1smPycks8/Z2slthgBFQ0Ctttt2qpliU/wtgo7do6I
	diHoonlPunj/XIA62FL/p/xvWWgKgAaA1nhjXyeLEADNJYFNonV+PuBx5egIMjXlkbFnQuf0Aq/oZ
	IQqTvN4P3zldnwSsEKsSutyVOPdxWZF3wz/R8OqA4YkGml/cxdscN43BUURTx901jUpagTcwoKECO
	5z+F1NXyeYzNOZWTcYChvVDjbbzdmSSOrM9pJdYwMn9/9Ut8l6HgZYRf8mza3Vj/pry7UjuH5kqG2
	LJQVbaNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJYCY-0000000CFqh-1Ij0;
	Wed, 21 Oct 2026 15:26:02 +0000
Received: from mail-ej1-f69.google.com ([209.85.218.69])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJYC9-0000000CFY6-04y1
	for kexec@lists.infradead.org;
	Wed, 21 Oct 2026 15:25:38 +0000
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c41b03cd1dcso79611866b.3
        for <kexec@lists.infradead.org>; Wed, 21 Oct 2026 08:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792596334; x=1793201134; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yVHoNG/F+MSh1AvSZ4DFO2pLKQWPL8PGoHBteE3nowI=;
        b=eF1BhjNMjTbU4dmFm4v0FZ7LPD7D9LO2vM02XRNCoexLNh3DNNE+gEhFIF1fB9ZHPU
         3PMEZGgftkFIT6P0BgYEktTaUPPlHPDYxEF84cTXQQEOXuG8uDxQaQA1rlYMkZA4jtOQ
         VRiyBJ1uaEUj7QV4MRgiUsLdYD3NP02KObYH0oPDqEeqCL8hajzgDOjEBQPOQW3CFPng
         hCmuU6P63lPt7kpSrYmgy76HfoLb+HjZr4Uc86uCGcMttFb+j39ct+rQFC31bqFzv1mE
         nfiR6bOLZsoYw/oo8b3d2Yi16A0MaNyZg/oROuGx2wPRs6oW2tVdNMALjYc0482VswGE
         85kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792596334; x=1793201134;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yVHoNG/F+MSh1AvSZ4DFO2pLKQWPL8PGoHBteE3nowI=;
        b=HpIEwSfPRKY9nDmRlup1K/r9tJ1yAtjcNY4UuB2DgUJXAqcAN+ZqPcGZKbUB/hhXkm
         5G1wAGwu3bP26TNqLN8Wa4Lfrw+v47mWqFQxP2jVRZCxmHdKKRWi/zudtH5BcQRdzc3h
         bkcPszL9c9ATfTENqYyD5gsORWezT0A/8dND5u5E3RW2/0XpVK1r30IJn4nQI+gxkAfo
         2J3GsjYgutTxkRZHCEBUcdKlQUkWg991PrMlMYvIrElU9c1DB9pVGKOfVHUR3QMu8bne
         betPPYF9a0grOFCrbJvGp6ouQbL69lUEw96oMBEyG/TFT0F4VAkiRtsH9psoeHx6RjHE
         d4pA==
X-Forwarded-Encrypted: i=1; AKwUvByXYqPmb6mU+JzIhbfyD8ltCZEyc/8LBuQk6EDl6iYij9HFo6jCD9G6vbXQGQeSSZK5wHYMcA==@lists.infradead.org
X-Gm-Message-State: AFq9FYKGBMqjVAp+ZtQMPCbH/sN3m84+pR/5PBSS5EHHIWG39fuOJ+Wq
	f/d/ELSguPezJ2C4A4JMieyQ9BtixnvAj5maNGq8p0TvOorcqHRz7v8BhDVmkz1UEvQ7bBJhbev
	Absz87Nw04A+Grjdcig==
X-Received: from ejeck13-n2.prod.google.com ([2002:a17:907:e1cd:20b0:c2e:8317:2af9])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:c64b:10b0:c46:7fa4:922b with SMTP id a640c23a62f3a-c467fa4a587mr117629166b.33.1792596333890;
 Wed, 21 Oct 2026 08:25:33 -0700 (PDT)
Date: Wed, 21 Oct 2026 15:25:27 +0000
In-Reply-To: <20261021152527.375070-1-tarunsahu@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261021152527.375070-5-tarunsahu@google.com>
Subject: [RFC PATCH v2 4/4] mm: memfd_luo: Add the 2-bit pair feature header
From: Tarun Sahu <tarunsahu@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, 
	David Matlack <dmatlack@google.com>, jgg@nvidia.com, robin.murphy@arm.com, 
	loganodell@google.com, oupton@kernel.org, kevin.tian@intel.com, 
	alex@shazbot.org, dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, 
	will@kernel.org, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_082537_126457_AC7484B0 
X-CRM114-Status: GOOD (  21.24  )
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
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Embed the fixed-size 128-byte struct luo_feature_hdr at the start of
struct memfd_luo_ser and define enum memfd_luo_feature
(MEMFD_LUO_FEAT_CORE and MEMFD_LUO_FEAT_MAX) for memfd preservation.

All current struct memfd_luo_ser fields (pos, size, seals, flags,
nr_folios, folios) and MEMFD_LUO_ALL_SEALS belong to
MEMFD_LUO_FEAT_CORE (LUO_FEAT_REQUIRED in memfd_luo_features). Future
changes add new entries to enum memfd_luo_feature before
MEMFD_LUO_FEAT_MAX and append any new fields to the end of struct
memfd_luo_ser so existing field offsets never shift.

Signed-off-by: Logan Odell <loganodell@google.com>
Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/linux/kho/abi/memfd.h | 35 ++++++++++++++++++++++++++++++-----
 mm/memfd_luo.c                | 14 ++++++++++++++
 2 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/include/linux/kho/abi/memfd.h b/include/linux/kho/abi/memfd.h
index 371ffd108a79..f0b5235a408d 100644
--- a/include/linux/kho/abi/memfd.h
+++ b/include/linux/kho/abi/memfd.h
@@ -13,6 +13,7 @@
 
 #include <linux/types.h>
 #include <linux/kho/abi/kexec_handover.h>
+#include <linux/kho/abi/luo.h>
 
 /**
  * DOC: memfd Live Update ABI
@@ -21,11 +22,20 @@
  * reboot using the LUO.
  *
  * The state is serialized into a packed structure `struct memfd_luo_ser`
- * which is handed over to the next kernel via the KHO mechanism.
+ * which is handed over to the target kernel via the KHO mechanism.
  *
- * This interface is a contract. Any modification to the structure layout
- * constitutes a breaking change. Such changes require incrementing the
- * version number in the MEMFD_LUO_FH_COMPATIBLE string.
+ * This interface is a contract. `struct memfd_luo_ser` starts with a fixed
+ * 128-byte `struct luo_feature_hdr`. The relative order and offsets of
+ * fields must remain unchanged as features are added or retired: new fields
+ * are appended at the end of `struct memfd_luo_ser` under a new feature
+ * flag in `enum memfd_luo_feature` (before `MEMFD_LUO_FEAT_MAX`), and
+ * retired fields are kept in place so subsequent offsets never shift. In
+ * the target kernel, fields of a `LUO_FEAT_REQUIRED` feature are guaranteed
+ * present once `luo_feature_hdr_validate()` succeeds, whereas fields of a
+ * `LUO_FEAT_OPTIONAL` feature should be accessed only after checking
+ * `luo_feature_is_active()`. All current fields (`pos`, `size`, `seals`,
+ * `flags`, `nr_folios`, `folios`) and `MEMFD_LUO_ALL_SEALS` belong to
+ * `MEMFD_LUO_FEAT_CORE` (`LUO_FEAT_REQUIRED` in `memfd_luo_features`).
  */
 
 /**
@@ -58,7 +68,7 @@ struct memfd_luo_folio_ser {
 
 /*
  * The set of seals this version supports preserving. If support for any new
- * seals is needed, add it here and bump version.
+ * seals is needed, gate them behind a new feature flag.
  */
 #define MEMFD_LUO_ALL_SEALS (F_SEAL_SEAL | \
 			     F_SEAL_SHRINK | \
@@ -67,8 +77,22 @@ struct memfd_luo_folio_ser {
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
+static_assert((int)MEMFD_LUO_FEAT_MAX <= LUO_FEAT_MAX);
+
 /**
  * struct memfd_luo_ser - Main serialization structure for a memfd.
+ * @features:  ABI feature and size header for memfd_luo_ser.
  * @pos:       The file's current position (f_pos).
  * @size:      The total size of the file in bytes (i_size).
  * @seals:     The seals present on the memfd. The seals are uABI so it is safe
@@ -79,6 +103,7 @@ struct memfd_luo_folio_ser {
  *             struct memfd_luo_folio_ser.
  */
 struct memfd_luo_ser {
+	struct luo_feature_hdr features;
 	u64 pos;
 	u64 size;
 	u32 seals;
diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index 64f8b8cb75bd..ea1f4c8cd259 100644
--- a/mm/memfd_luo.c
+++ b/mm/memfd_luo.c
@@ -84,6 +84,10 @@
 
 #include "internal.h"
 
+static const u8 memfd_luo_features[MEMFD_LUO_FEAT_MAX] = {
+	[MEMFD_LUO_FEAT_CORE] = LUO_FEAT_REQUIRED,
+};
+
 static int memfd_luo_preserve_folios(struct file *file,
 				     struct kho_vmalloc *kho_vmalloc,
 				     struct memfd_luo_folio_ser **out_folios_ser,
@@ -284,6 +288,8 @@ static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
 		goto err_free_ser;
 	}
 
+	luo_feature_hdr_init(&ser->features, sizeof(*ser),
+			     memfd_luo_features);
 	ser->pos = args->file->f_pos;
 	inode_size = i_size_read(inode);
 
@@ -525,6 +531,14 @@ static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
 	if (!ser)
 		return -EINVAL;
 
+	err = luo_feature_hdr_validate(&ser->features, memfd_luo_features);
+	if (err) {
+		pr_err("memfd_luo_ser feature header validation failed (size=%llu, flags[0]=%#llx): %pe\n",
+		       ser->features.size, ser->features.flags[0],
+		       ERR_PTR(err));
+		goto free_ser;
+	}
+
 	/* Make sure the file only has seals supported by this version. */
 	if (ser->seals & ~MEMFD_LUO_ALL_SEALS) {
 		err = -EOPNOTSUPP;
-- 
2.56.0.212.g129ede20d9-goog


