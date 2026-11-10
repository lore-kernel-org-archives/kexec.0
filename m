Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE40606C92E
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 05:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=g/EijSO4;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Q3OWKrys
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Sj2aHvE/30fRUSODl4VGY86EHM+govAz/p3nvPD2KF0=; b=g/EijSO4pegYiINhU4teTAB5EF
	OVaTlIjHIMhNFr6WYUm+s9GKU2cSvxc0nZGJ/KfGlEb8reTyfcDhsRJoOuCsfP6c65BtQBYfouSpD
	C876GhGV+BgHZbhhbeLaS18IlERIiRV5LNHricZw07FTGODGD5eMmv5or+R/b696ViPKVyBKzMbgP
	A5CDqR/2KXHseDT4PF9ELkIp/N25HiTyaG5wq/LD0TpXRCTiypnsIesVMW340rFJp192a2JQ8hvdv
	ZaTS3zrFdI4QIlShv81IFufKRJ+j5WlLo52IVpIrnf5IyXiwGRRFmtPlcB3mabxtzgUH1GzJIPf/Y
	dtY87Itg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQdzy-00000002RTT-08Js;
	Tue, 10 Nov 2026 05:02:22 +0000
Received: from mail-ed1-x546.google.com ([2a00:1450:4864:20::546])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQdzm-00000002RDl-3lQ7
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 05:02:13 +0000
Received: by mail-ed1-x546.google.com with SMTP id 4fb4d7f45d1cf-6b706aec65bso1580341a12.3
        for <kexec@lists.infradead.org>; Mon, 09 Nov 2026 21:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794286929; x=1794891729; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sj2aHvE/30fRUSODl4VGY86EHM+govAz/p3nvPD2KF0=;
        b=Q3OWKrysh/dwI+Dw1wqqhBZYRB3ml7H636qnFN3715syq6jE1x8d5l8XpFonCTeoDa
         +MBCvJ1o5T+iTP9G/j/b502t5ceC/XctyhmzE+U4lBwJEe+f2zl1LSLPajEI8kJSrSBy
         8tAlqstNEMMDrcMlJfm7jtCTkOz6Teg73ngfd9YjY5g/3FkMm1ASobWVl6SkyJU8Oj5u
         W6CwpCeTG70Jj+mT8RDs67wVisM/q7z2zNEawIyqJ6Z9MfgjcrBAtEfXQJw2GOvvNXS5
         fzxn3CKDNJ1SGD5iln4or2rJsPYbJDiJabHbv8o8CqWIgqIytXZdF3JBcMqgdh08gbdA
         udIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794286929; x=1794891729;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sj2aHvE/30fRUSODl4VGY86EHM+govAz/p3nvPD2KF0=;
        b=Y5XW6jj97+uMfEXTTWXrmjhyq6ZYhG8UAQImlFlYrFcyAkyQ2r22RYwNTV6gI5uxUW
         9CxgDygY6f7hoXQNIfmtd3nh+WG0RJMMZ9FQrr++LkcRy4K6TBGFDTM56Yb79CkbAJmp
         3r418e3oXF+SR7WYqbYSQlgWf1e/xBGjDGtHnD7HrfReMVhF755dcTlifaufSlvQDm8s
         eMuvo2RWyoWCPgrDYW3dIHv6sJlXejVmSCalpTErZAL5WuGfUPUFTUCFvTELMoN1P5Y3
         3h7L3+sc2zdNmg9QvZAcqw9XxynE8xbctlZSgdAtSt1RBUOs2SM5PngWNiJtEzr1Ww8p
         Nrxw==
X-Forwarded-Encrypted: i=1; AL+hErHmQVS4P2MO6iT3D2FBSMdSuEEV5yi9rSOLvMP3Z1o1M8PP2FlxrawgSVr+0A2cl9PHXLekWQ==@lists.infradead.org
X-Gm-Message-State: APuU4Z8jAWB61Wnq2eNXQC/sFV+OORg00yrIWV/ynyyGe48ctTNDTl5+
	SgY3FOxaNMbqpdLJDiKJh3XL806V+JXSA0aF+oEKcCuxxfC3/yjqzYGJ7M7XvToUKxqcmDoHmDe
	qlxDavOcakGFA4zeCBA==
X-Received: from ejczh1.prod.google.com ([2002:a17:907:e901:b0:c42:9eb:1d43])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3f03:b0:c50:475d:9804 with SMTP id a640c23a62f3a-c5049583bf0mr103443266b.13.1794286928328;
 Mon, 09 Nov 2026 21:02:08 -0800 (PST)
Date: Tue, 10 Nov 2026 05:01:46 +0000
In-Reply-To: <20261110050202.529473-1-tarunsahu@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261110050202.529473-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261110050202.529473-4-tarunsahu@google.com>
Subject: [PATCH v4 03/19] kho, memfd_luo: Reference struct kho_vmalloc via
 serialized pointer
From: Tarun Sahu <tarunsahu@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, 
	maz@kernel.org, will@kernel.org, David Matlack <dmatlack@google.com>, 
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, 
	arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	Bjorn Helgaas <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, 
	gle.com@google.com, pbonzini@redhat.com, 
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: kvmarm@lists.linux.dev, linux-pci@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	skhawaja@google.com, sagis@google.com, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_210211_725192_BA823042 
X-CRM114-Status: GOOD (  26.48  )
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
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Subsystems preserving vmalloc allocations currently embed struct
kho_vmalloc directly by value in their serialized structures or device
tree properties. For example, struct memfd_luo_ser embeds struct
kho_vmalloc folios, and test_kho writes the structure directly into the
folios_info FDT property.

Embedding struct kho_vmalloc directly couples the containing layout's
field offsets and size to struct kho_vmalloc. Any modification to struct
kho_vmalloc shifts subsequent fields in the containing structure and
breaks the handover ABI across kexec.

Convert callers to hold a DECLARE_KHOSER_PTR pointer to struct
kho_vmalloc instead of embedding it by value. In memfd_luo, allocate the
main structure and struct kho_vmalloc in the same preserved folio, placing
struct kho_vmalloc in the remaining 8-byte-aligned space, and bump the
compatibility string to memfd-v3. In test_kho, place struct kho_vmalloc
in the remaining space of the FDT folio, store the serialized pointer in
the folios_info property, and bump the compatibility string to
kho-test-v2.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/linux/kho/abi/kexec_handover.h |  6 +++
 include/linux/kho/abi/memfd.h          |  8 ++--
 lib/test_kho.c                         | 29 ++++++++----
 mm/memfd_luo.c                         | 63 ++++++++++++++++----------
 4 files changed, 68 insertions(+), 38 deletions(-)

diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/abi/kexec_handover.h
index 6f12f5037ea5..bee75a7006e8 100644
--- a/include/linux/kho/abi/kexec_handover.h
+++ b/include/linux/kho/abi/kexec_handover.h
@@ -11,6 +11,8 @@
 #define _LINUX_KHO_ABI_KEXEC_HANDOVER_H
 
 #include <linux/bits.h>
+#include <linux/build_bug.h>
+#include <linux/kconfig.h>
 #include <linux/log2.h>
 #include <linux/math.h>
 #include <linux/types.h>
@@ -177,6 +179,10 @@ struct kho_vmalloc {
 	unsigned short order;
 };
 
+static_assert(sizeof(struct kho_vmalloc) == 16);
+static_assert(!IS_ENABLED(CONFIG_64BIT) ||
+	      __alignof__(struct kho_vmalloc) == 8);
+
 /**
  * DOC: KHO persistent memory tracker
  *
diff --git a/include/linux/kho/abi/memfd.h b/include/linux/kho/abi/memfd.h
index 376a724a1d8c..7b49dd6d7e2a 100644
--- a/include/linux/kho/abi/memfd.h
+++ b/include/linux/kho/abi/memfd.h
@@ -81,7 +81,7 @@ static_assert(!IS_ENABLED(CONFIG_64BIT) ||
  *             to directly use them in the ABI.
  * @flags:     Flags for the file. Unused flag bits must be set to 0.
  * @nr_folios: Number of folios in the folios array.
- * @folios:    KHO vmalloc descriptor pointing to the array of
+ * @folios:    Pointer to KHO vmalloc descriptor for the array of
  *             struct memfd_luo_folio_ser.
  */
 struct memfd_luo_ser {
@@ -90,14 +90,14 @@ struct memfd_luo_ser {
 	u32 seals;
 	u32 flags;
 	u64 nr_folios;
-	struct kho_vmalloc folios;
+	DECLARE_KHOSER_PTR(folios, struct kho_vmalloc *);
 };
 
-static_assert(sizeof(struct memfd_luo_ser) == 48);
+static_assert(sizeof(struct memfd_luo_ser) == 40);
 static_assert(!IS_ENABLED(CONFIG_64BIT) ||
 	      __alignof__(struct memfd_luo_ser) == 8);
 
 /* The compatibility string for memfd file handler */
-#define MEMFD_LUO_FH_COMPATIBLE	"memfd-v2"
+#define MEMFD_LUO_FH_COMPATIBLE	"memfd-v3"
 
 #endif /* _LINUX_KHO_ABI_MEMFD_H */
diff --git a/lib/test_kho.c b/lib/test_kho.c
index aa6a0956bb8b..cd0f183ff68e 100644
--- a/lib/test_kho.c
+++ b/lib/test_kho.c
@@ -25,7 +25,7 @@
 
 #define KHO_TEST_MAGIC	0x4b484f21	/* KHO! */
 #define KHO_TEST_FDT	"kho_test"
-#define KHO_TEST_COMPAT "kho-test-v1"
+#define KHO_TEST_COMPAT "kho-test-v2"
 
 static long max_mem = (PAGE_SIZE << MAX_PAGE_ORDER) * 2;
 module_param(max_mem, long, 0644);
@@ -34,7 +34,7 @@ struct kho_test_state {
 	unsigned int nr_folios;
 	struct folio **folios;
 	phys_addr_t *folios_info;
-	struct kho_vmalloc folios_info_phys;
+	DECLARE_KHOSER_PTR(folios_info_phys, struct kho_vmalloc *);
 	int nr_folios_preserved;
 	struct folio *fdt;
 	__wsum csum;
@@ -47,13 +47,13 @@ static void kho_test_unpreserve_data(struct kho_test_state *state)
 	for (int i = 0; i < state->nr_folios_preserved; i++)
 		kho_unpreserve_folio(state->folios[i]);
 
-	kho_unpreserve_vmalloc(&state->folios_info_phys);
+	if (KHOSER_LOAD_PTR(state->folios_info_phys))
+		kho_unpreserve_vmalloc(KHOSER_LOAD_PTR(state->folios_info_phys));
 	vfree(state->folios_info);
 }
 
 static int kho_test_preserve_data(struct kho_test_state *state)
 {
-	struct kho_vmalloc folios_info_phys;
 	phys_addr_t *folios_info;
 	int err;
 
@@ -61,11 +61,10 @@ static int kho_test_preserve_data(struct kho_test_state *state)
 	if (!folios_info)
 		return -ENOMEM;
 
-	err = kho_preserve_vmalloc(folios_info, &folios_info_phys);
+	err = kho_preserve_vmalloc(folios_info, KHOSER_LOAD_PTR(state->folios_info_phys));
 	if (err)
 		goto err_free_info;
 
-	state->folios_info_phys = folios_info_phys;
 	state->folios_info = folios_info;
 
 	for (int i = 0; i < state->nr_folios; i++) {
@@ -123,14 +122,19 @@ static int kho_test_prepare_fdt(struct kho_test_state *state, ssize_t fdt_size)
 
 static int kho_test_preserve(struct kho_test_state *state)
 {
-	ssize_t fdt_size;
+	struct kho_vmalloc *folios_vmalloc;
+	ssize_t fdt_size, alloc_size;
 	int err;
 
 	fdt_size = state->nr_folios * sizeof(phys_addr_t) + PAGE_SIZE;
-	state->fdt = folio_alloc(GFP_KERNEL, get_order(fdt_size));
+	alloc_size = fdt_size + sizeof(struct kho_vmalloc);
+	state->fdt = folio_alloc(GFP_KERNEL, get_order(alloc_size));
 	if (!state->fdt)
 		return -ENOMEM;
 
+	folios_vmalloc = folio_address(state->fdt) + fdt_size;
+	KHOSER_STORE_PTR(state->folios_info_phys, folios_vmalloc);
+
 	err = kho_preserve_folio(state->fdt);
 	if (err)
 		goto err_free_fdt;
@@ -234,7 +238,8 @@ static int kho_test_save(void)
 
 static int kho_test_restore_data(const void *fdt, int node)
 {
-	const struct kho_vmalloc *folios_info_phys;
+	const DECLARE_KHOSER_PTR(*folios_info_phys, struct kho_vmalloc *);
+	const struct kho_vmalloc *folios_vmalloc;
 	const unsigned int *nr_folios;
 	phys_addr_t *folios_info;
 	const __wsum *old_csum;
@@ -255,7 +260,11 @@ static int kho_test_restore_data(const void *fdt, int node)
 	if (!folios_info_phys || len != sizeof(*folios_info_phys))
 		return -EINVAL;
 
-	folios_info = kho_restore_vmalloc(folios_info_phys);
+	folios_vmalloc = KHOSER_LOAD_PTR(*folios_info_phys);
+	if (!folios_vmalloc)
+		return -EINVAL;
+
+	folios_info = kho_restore_vmalloc(folios_vmalloc);
 	if (!folios_info)
 		return -EINVAL;
 
diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index 6b68220275eb..4471cced57db 100644
--- a/mm/memfd_luo.c
+++ b/mm/memfd_luo.c
@@ -85,9 +85,8 @@
 #include "internal.h"
 
 static int memfd_luo_preserve_folios(struct file *file,
-				     struct kho_vmalloc *kho_vmalloc,
-				     struct memfd_luo_folio_ser **out_folios_ser,
-				     u64 *nr_foliosp)
+				     struct memfd_luo_ser *ser,
+				     struct memfd_luo_folio_ser **out_folios_ser)
 {
 	struct inode *inode = file_inode(file);
 	struct memfd_luo_folio_ser *folios_ser;
@@ -104,7 +103,8 @@ static int memfd_luo_preserve_folios(struct file *file,
 	 * are not set.
 	 */
 	if (!size) {
-		*nr_foliosp = 0;
+		ser->folios.phys = 0;
+		ser->nr_folios = 0;
 		*out_folios_ser = NULL;
 		return 0;
 	}
@@ -200,12 +200,12 @@ static int memfd_luo_preserve_folios(struct file *file,
 		pfolio->index = folio->index;
 	}
 
-	err = kho_preserve_vmalloc(folios_ser, kho_vmalloc);
+	err = kho_preserve_vmalloc(folios_ser, KHOSER_LOAD_PTR(ser->folios));
 	if (err)
 		goto err_unpreserve;
 
 	kvfree(folios);
-	*nr_foliosp = nr_folios;
+	ser->nr_folios = nr_folios;
 	*out_folios_ser = folios_ser;
 
 	/*
@@ -254,37 +254,43 @@ static void memfd_luo_unpreserve_folios(struct kho_vmalloc *kho_vmalloc,
 	vfree(folios_ser);
 }
 
+static size_t memfd_luo_ser_size(void)
+{
+	return sizeof(struct memfd_luo_ser) + sizeof(struct kho_vmalloc);
+}
+
+static struct memfd_luo_ser *memfd_luo_ser_init(void *mem)
+{
+	struct kho_vmalloc *kho_vmalloc = mem + sizeof(struct memfd_luo_ser);
+	struct memfd_luo_ser *ser = mem;
+
+	KHOSER_STORE_PTR(ser->folios, kho_vmalloc);
+	return ser;
+}
+
 static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
 {
 	struct inode *inode = file_inode(args->file);
 	struct memfd_luo_folio_ser *folios_ser;
 	struct memfd_luo_ser *ser;
-	u64 nr_folios, inode_size;
 	int err = 0, seals;
+	u64 inode_size;
 
 	inode_lock(inode);
 	shmem_freeze(inode, true);
 
-	/* Allocate the main serialization structure in preserved memory */
-	ser = kho_alloc_preserve(sizeof(*ser));
-	if (IS_ERR(ser)) {
-		err = PTR_ERR(ser);
-		goto err_unlock;
-	}
-
 	seals = memfd_get_seals(args->file);
 	if (seals < 0) {
 		err = seals;
-		goto err_free_ser;
+		goto err_unlock;
 	}
 
 	/* Make sure the file only has the seals supported by this version. */
 	if (seals & ~MEMFD_LUO_ALL_SEALS) {
 		err = -EOPNOTSUPP;
-		goto err_free_ser;
+		goto err_unlock;
 	}
 
-	ser->pos = args->file->f_pos;
 	inode_size = i_size_read(inode);
 
 	/*
@@ -293,18 +299,26 @@ static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
 	 */
 	if (DIV_ROUND_UP_ULL(inode_size, PAGE_SIZE) > UINT_MAX) {
 		err = -EFBIG;
-		goto err_free_ser;
+		goto err_unlock;
+	}
+
+	/* Allocate the main serialization structure in preserved memory */
+	ser = kho_alloc_preserve(memfd_luo_ser_size());
+	if (IS_ERR(ser)) {
+		err = PTR_ERR(ser);
+		goto err_unlock;
 	}
+	ser = memfd_luo_ser_init(ser);
 
+	ser->pos = args->file->f_pos;
 	ser->size = inode_size;
 	ser->seals = seals;
+	ser->flags = 0;
 
-	err = memfd_luo_preserve_folios(args->file, &ser->folios,
-					&folios_ser, &nr_folios);
+	err = memfd_luo_preserve_folios(args->file, ser, &folios_ser);
 	if (err)
 		goto err_free_ser;
 
-	ser->nr_folios = nr_folios;
 	inode_unlock(inode);
 
 	args->private_data = folios_ser;
@@ -351,7 +365,8 @@ static void memfd_luo_unpreserve(struct liveupdate_file_op_args *args)
 
 	ser = phys_to_virt(args->serialized_data);
 
-	memfd_luo_unpreserve_folios(&ser->folios, args->private_data,
+	memfd_luo_unpreserve_folios(KHOSER_LOAD_PTR(ser->folios),
+				    args->private_data,
 				    ser->nr_folios);
 
 	kho_unpreserve_free(ser);
@@ -401,7 +416,7 @@ static void memfd_luo_finish(struct liveupdate_file_op_args *args)
 		return;
 
 	if (ser->nr_folios) {
-		folios_ser = kho_restore_vmalloc(&ser->folios);
+		folios_ser = kho_restore_vmalloc(KHOSER_LOAD_PTR(ser->folios));
 		if (!folios_ser)
 			goto out;
 
@@ -552,7 +567,7 @@ static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
 	i_size_write(file_inode(file), ser->size);
 
 	if (ser->nr_folios) {
-		folios_ser = kho_restore_vmalloc(&ser->folios);
+		folios_ser = kho_restore_vmalloc(KHOSER_LOAD_PTR(ser->folios));
 		if (!folios_ser) {
 			err = -EINVAL;
 			goto put_file;
-- 
2.56.0.506.g506a7eabc5-goog


