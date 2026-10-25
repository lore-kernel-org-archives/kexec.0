Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9398F606A328
	for <kexec@archiver.kernel.org>; Sun, 25 Oct 2026 17:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HtMmZoXl;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=hlMgFtPs
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Zq0HwRn/KBuhP5gqIfYSYOd1gJtugZDGtj1dHvKt5Z0=; b=HtMmZoXlJEN5yv
	13zXhBs0KiaCSZ45KWaHakrslFdLGyFl5Xb/wNkVmUw7BewsIR90vnZiEOF/Fc0CInz2bJXx4GWC2
	PLw7Xz63aEYkFMfI2gQS/oWWcKUjQDC4IFKS999ZCHkiQP7VYs5GzkRTWKGBZbVpSyCRviWz+nR+k
	aILAUrnvNLo2G3oiLF37Oq5xm1Fb6mit5CHtW26MNrBy6E9sJIHGs315HiFRvBW2hXBU0mZ8ycV0m
	eLxEacOzr7inwRMT86+SynPZLfmnwapdo3pAftxLJH67P2uS12OlYiakzmz6086tfHyJoGyy3+Bs/
	ThbEEPbGEr3LmpswBq1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL2Co-00000001Err-14zs;
	Sun, 25 Oct 2026 17:40:26 +0000
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL2Cm-00000001Epm-0dHh
	for kexec@lists.infradead.org;
	Sun, 25 Oct 2026 17:40:25 +0000
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-5eaf169fe3dso675438e0c.3
        for <kexec@lists.infradead.org>; Sun, 25 Oct 2026 10:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792950023; x=1793554823; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Zq0HwRn/KBuhP5gqIfYSYOd1gJtugZDGtj1dHvKt5Z0=;
        b=hlMgFtPsXzVpr8fCOTH1eHsRUErOTDThBdYswWVNVHFiLiPz3o/R7o9XPi3k1hlAsL
         DOM8V218HylMgtQ4E14RuwAK3CK3dzWqIFeom/vA5Wd6csObeyqvIrvLanSYOzjgCwN9
         4yYdGvLkRUfzNWbpcvbLFMHm6KwhQJKp0MNmpUE/qO71RMCRSgEwdP1Y1T940zqnhfIV
         3Nfjt6FVb6HU8CJFUUg+KMIWqtBUGIBziVLHGkwgdkww0U2ipx6z/+O2iMibx5PtgpKN
         zvYpo3GSaQHgZG7EAl0ERAuLh5ILMhCm6TttsxzOI7tk9gZTU9pL+Ig9eKcgWc1kHDTE
         r7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792950023; x=1793554823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Zq0HwRn/KBuhP5gqIfYSYOd1gJtugZDGtj1dHvKt5Z0=;
        b=zQKask0ul4awGI/yxLPMmOXSvM+JwKJiX51o/BLqY91ug7cDICsNfxHasQ6TO9QMsf
         SKRImXUkDzqnHw57N7s9bg73HMPYROzjRSMCsm0MSPyietEScgVsPRn94zJZsomV5MLD
         GoeH4YfFsUaZ6VyPx4nKR8p0ASgd9TJ+q7Ptc4GFWrWZ+sRE5YuMmbJiYv2+YL9XMhtD
         Any5ZfykwOuMHOsaDG78R3MJYa2fB3HarGkIL6XZzOrWjfic1vW2/jaExyBcSzoOEAlc
         fpfTodOSD5MtRJ6mSNpoE8HS2axGZc04NXNyZ/OfySc1dzk/TGIEsjycwyJ39orrsZeM
         +D4Q==
X-Forwarded-Encrypted: i=1; AKwUvBxx5Ghit194Pum+h2PSNneu1fFFXhBgVlvza3/nFZLT5E+mFdJpvoX4N69Pbn40HOZ+SvJ2HQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYJ/A9G7u1b9cNOTj1uQDIn22VuRKjF+d9D8mUNNV6wKFQmiGjnb
	gAzmZVDNh/3ipgD7fcRo5SdNF5t7YNU8hjQumcMHVwZq7zXXwm76ZoZ87BnrandSQ2g=
X-Gm-Gg: AYBFou1AR7JtUg+bctVfaZiRTustx/LRSKzhocaTlwVv23PCnkEZ/pzmQ2gLheVdeoQ
	CD8HbsQiEGJ2jcqLC8e04WpctoDI0GidvMgVlJy0nxiJqh531Gc3UAx3JJ9ZVbToCfSw1ZW/3D+
	j2DPM3+Du98+wOk9tDtKV3kYntvLhPbVr8LEdcec/l6J+awrJycVHP3fT9M5UAf5nQzXiMI4/mM
	HAdLbFVHm8IKbQ09s1BGrcstVqqDldvc8isEs93yW86QDxwJbLSxqaeHmMU1xHewMYVEDBqqB59
	zOPr25HkoT2F3Jd75uXS2Sp7zYmaPEDTETNBkcfBC66sh4/3Md6eQeA81CFdaP+Cz8m7NV7CSIV
	pTQ8O5QyVbwv27a2ZSszphh1C5lxSxl4rf4F9BqrkIiSBKpYUn0pk1JeBloPkpLyCUJJHsK21Ky
	piBdRRfMgVH1pc8mQpfV/DvChszqDZtsc0siDvg7INpjTbE79Dp8M9wR6aHU3UzDin2eiEyKy3n
	EPbOeNZ7FRB/2G8KTgXaubpPcoTjn+gOYq2Ol2y+hu2RgoqDMeJIz0ySl/35JUoojIbNHi7pVE4
	Cq8nrQM1bmx8NjIlmfISkZJ8OWISzwSCd3rJ7Bjt82jFDa36ZTrdWxRMQbxiF3E+ZLCp80ow4qz
	zPBZCfdy6F3y7cXk3WD/Q5g==
X-Received: by 2002:a05:6122:1d89:b0:5ea:e197:43ee with SMTP id 71dfb90a1353d-5ec232b6235mr1454185e0c.19.1792950022728;
        Sun, 25 Oct 2026 10:40:22 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec234673ebsm5783333e0c.13.2026.10.25.10.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 10:40:22 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	kuba@kernel.org,
	enelsonmoore@gmail.com,
	bp@alien8.de,
	shuah@kernel.org,
	david@kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	mhocko@suse.com,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	vbabka@kernel.org,
	dapeng1.mi@linux.intel.com,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	surenb@google.com,
	pasha.tatashin@soleen.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	elver@google.com,
	graf@amazon.com,
	lirongqing@baidu.com,
	liam@infradead.org,
	jlayton@kernel.org
Subject: [PATCH v2 2/9] kho: move radix tree and FDT helpers to common file
Date: Sun, 25 Oct 2026 13:40:09 -0400
Message-ID: <20261025174017.3870481-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
In-Reply-To: <20261025174017.3870481-1-pasha.tatashin@soleen.com>
References: <20261025174017.3870481-1-pasha.tatashin@soleen.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261025_104024_278218_8A874152 
X-CRM114-Status: GOOD (  28.50  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Read-only KHO mode needs to traverse preserved KHO radix trees and FDT
subtrees without duplicating the parsing and key-encoding implementation
in kexec_handover.c.

Move the shared KHO radix tree key encoding and indexing helpers, FDT
validation and lookup helpers, and kho_retrieve_subtree() from
kexec_handover.c into a shared compilation unit
kernel/liveupdate/kexec_handover_common.c with prototypes in
kexec_handover_internal.h, and factor kho_radix_find_leaf() for use by
kho_radix_del_key() and the upcoming read-only KHO backend.

While factoring kho_check_fdt() from kho_populate(), drop the "setup: "
prefix from the FDT validation warnings and verify that
fdt_totalsize(fdt) does not exceed PAGE_SIZE, which is safe for
kho_populate() as both the x86 and device-tree kexec paths allocate and
pass a single-page FDT. Also use get_unaligned() in
kho_retrieve_subtree() when reading 64-bit FDT properties, matching
kho_get_mem_map_phys(), since FDT property values are 4-byte aligned.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 Documentation/core-api/kho/index.rst        |   3 +
 kernel/liveupdate/Makefile                  |   2 +-
 kernel/liveupdate/kexec_handover.c          | 167 ++--------------
 kernel/liveupdate/kexec_handover_common.c   | 211 ++++++++++++++++++++
 kernel/liveupdate/kexec_handover_internal.h |  13 ++
 5 files changed, 240 insertions(+), 156 deletions(-)
 create mode 100644 kernel/liveupdate/kexec_handover_common.c

diff --git a/Documentation/core-api/kho/index.rst b/Documentation/core-api/kho/index.rst
index e78a2bbe2be1..bce7fe281194 100644
--- a/Documentation/core-api/kho/index.rst
+++ b/Documentation/core-api/kho/index.rst
@@ -83,6 +83,9 @@ Public API
 .. kernel-doc:: kernel/liveupdate/kexec_handover.c
   :export:
 
+.. kernel-doc:: kernel/liveupdate/kexec_handover_common.c
+  :export:
+
 KHO Serialization Blocks API
 ============================
 
diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
index d9f469462556..f6bed6bcd380 100644
--- a/kernel/liveupdate/Makefile
+++ b/kernel/liveupdate/Makefile
@@ -7,7 +7,7 @@ luo-y :=								\
 		luo_flb.o						\
 		luo_session.o
 
-obj-$(CONFIG_KEXEC_HANDOVER)		+= kexec_handover.o
+obj-$(CONFIG_KEXEC_HANDOVER)		+= kexec_handover.o kexec_handover_common.o
 obj-$(CONFIG_KEXEC_HANDOVER_DEBUGFS)	+= kexec_handover_debugfs.o
 
 obj-$(CONFIG_LIVEUPDATE)		+= luo.o
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index ce5983abf181..c24f25bfc96a 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -108,73 +108,11 @@ struct kho_in {
 static struct kho_in kho_in = {
 };
 
-static const void *kho_get_fdt(void)
+const void *kho_get_fdt(void)
 {
 	return kho_in.fdt_phys ? phys_to_virt(kho_in.fdt_phys) : NULL;
 }
 
-/**
- * kho_encode_radix_key - Encodes a physical address and order into a radix key.
- * @phys: The physical address of the page.
- * @order: The order of the page.
- *
- * This function combines a page's physical address and its order into a
- * single unsigned long, which is used as a key for all radix tree
- * operations.
- *
- * Return: The encoded unsigned long radix key.
- */
-static unsigned long kho_encode_radix_key(phys_addr_t phys, unsigned int order)
-{
-	/* The physical address is encoded by shifting the PFN by its order. */
-	unsigned long shift = PAGE_SHIFT + order;
-	/* Order bit goes right before the shifted PFN. */
-	unsigned long h = 1UL << (64 - shift);
-	/* Shifted PFN. */
-	unsigned long l = phys >> shift;
-
-	return h | l;
-}
-
-/**
- * kho_decode_radix_key - Decodes a radix key back into a physical address and order.
- * @key: The unsigned long key to decode.
- * @order: An output parameter, a pointer to an unsigned int where the decoded
- *         page order will be stored.
- *
- * This function reverses the encoding performed by kho_encode_radix_key(),
- * extracting the original physical address and page order from a given key.
- *
- * Return: The decoded physical address.
- */
-static phys_addr_t kho_decode_radix_key(unsigned long key, unsigned int *order)
-{
-	/* fls64() indexes starting from 1. */
-	unsigned int order_bit = fls64(key) - 1;
-	phys_addr_t phys;
-
-	/* order bit goes right before the shifted PFN. */
-	*order = 64 - (PAGE_SHIFT + order_bit);
-	/* The order bit is discarded by the shift */
-	phys = key << (PAGE_SHIFT + *order);
-
-	return phys;
-}
-
-static unsigned long kho_radix_get_bitmap_index(unsigned long key)
-{
-	return key % (1 << KHO_BITMAP_SIZE_LOG2);
-}
-
-static unsigned long kho_radix_get_table_index(unsigned long key,
-					       unsigned int level)
-{
-	int s;
-
-	s = ((level - 1) * KHO_TABLE_SIZE_LOG2) + KHO_BITMAP_SIZE_LOG2;
-	return (key >> s) % (1 << KHO_TABLE_SIZE_LOG2);
-}
-
 static void __ref *kho_radix_alloc_node(void)
 {
 	struct kho_radix_node *node;
@@ -283,6 +221,11 @@ int kho_radix_add_key(struct kho_radix_tree *tree, unsigned long key)
 }
 EXPORT_SYMBOL_GPL(kho_radix_add_key);
 
+static void *kho_phys_to_virt(phys_addr_t pa)
+{
+	return phys_to_virt(pa);
+}
+
 /**
  * kho_radix_del_key - Removes the key from the radix tree.
  * @tree: The KHO radix tree.
@@ -294,9 +237,7 @@ EXPORT_SYMBOL_GPL(kho_radix_add_key);
  */
 void kho_radix_del_key(struct kho_radix_tree *tree, unsigned long key)
 {
-	struct kho_radix_node *node = tree->root;
 	struct kho_radix_leaf *leaf;
-	unsigned int i, idx;
 
 	if (WARN_ON_ONCE(!tree->root))
 		return;
@@ -309,24 +250,12 @@ void kho_radix_del_key(struct kho_radix_tree *tree, unsigned long key)
 
 	guard(mutex)(&tree->lock);
 
-	/* Go from high levels to low levels */
-	for (i = KHO_TREE_MAX_DEPTH - 1; i > 0; i--) {
-		idx = kho_radix_get_table_index(key, i);
-
-		/*
-		 * Attempting to delete a page that has not been preserved,
-		 * return with a warning.
-		 */
-		if (WARN_ON(!node->table[idx]))
-			return;
-
-		node = phys_to_virt(node->table[idx]);
-	}
+	leaf = kho_radix_find_leaf(virt_to_phys(tree->root), key,
+				   kho_phys_to_virt);
+	if (WARN_ON(!leaf))
+		return;
 
-	/* Handle the leaf level bitmap (level 0) */
-	leaf = (struct kho_radix_leaf *)node;
-	idx = kho_radix_get_bitmap_index(key);
-	__clear_bit(idx, leaf->bitmap);
+	__clear_bit(kho_radix_get_bitmap_index(key), leaf->bitmap);
 }
 EXPORT_SYMBOL_GPL(kho_radix_del_key);
 
@@ -634,21 +563,6 @@ static int __init kho_preserved_memory_reserve(unsigned long key, void *data)
 	return 0;
 }
 
-/* Returns physical address of the preserved memory map from FDT */
-static phys_addr_t __init kho_get_mem_map_phys(const void *fdt)
-{
-	const void *mem_ptr;
-	int len;
-
-	mem_ptr = fdt_getprop(fdt, 0, KHO_FDT_MEMORY_MAP_PROP_NAME, &len);
-	if (!mem_ptr || len != sizeof(u64)) {
-		pr_err("failed to get preserved memory map\n");
-		return 0;
-	}
-
-	return get_unaligned((const u64 *)mem_ptr);
-}
-
 static void __init *kho_get_mem_map(const void *fdt)
 {
 	phys_addr_t phys = kho_get_mem_map_phys(fdt);
@@ -1647,53 +1561,6 @@ bool is_kho_boot(void)
 }
 EXPORT_SYMBOL_GPL(is_kho_boot);
 
-/**
- * kho_retrieve_subtree - retrieve a preserved sub blob by its name.
- * @name: the name of the sub blob passed to kho_add_subtree().
- * @phys: if found, the physical address of the sub blob is stored in @phys.
- * @size: if not NULL and found, the size of the sub blob is stored in @size.
- *
- * Retrieve a preserved sub blob named @name and store its physical
- * address in @phys and optionally its size in @size.
- *
- * Return: 0 on success, error code on failure
- */
-int kho_retrieve_subtree(const char *name, phys_addr_t *phys, size_t *size)
-{
-	const void *fdt = kho_get_fdt();
-	const u64 *val;
-	int offset, len;
-
-	if (!fdt)
-		return -ENOENT;
-
-	if (!phys)
-		return -EINVAL;
-
-	offset = fdt_subnode_offset(fdt, 0, name);
-	if (offset < 0)
-		return -ENOENT;
-
-	val = fdt_getprop(fdt, offset, KHO_SUB_TREE_PROP_NAME, &len);
-	if (!val || len != sizeof(*val))
-		return -EINVAL;
-
-	*phys = (phys_addr_t)*val;
-
-	val = fdt_getprop(fdt, offset, KHO_SUB_TREE_SIZE_PROP_NAME, &len);
-	if (!val || len != sizeof(*val)) {
-		pr_warn("broken KHO subnode '%s': missing or invalid blob-size property\n",
-			name);
-		return -EINVAL;
-	}
-
-	if (size)
-		*size = (size_t)*val;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(kho_retrieve_subtree);
-
 static void __init kho_mem_retrieve(void)
 {
 	const struct kho_radix_walk_cb cb = {
@@ -1981,18 +1848,8 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 		pr_warn("setup: failed to memremap FDT (0x%llx)\n", fdt_phys);
 		goto report;
 	}
-	err = fdt_check_header(fdt);
-	if (err) {
-		pr_warn("setup: handover FDT (0x%llx) is invalid: %d\n",
-			fdt_phys, err);
-		goto unmap_fdt;
-	}
-	err = fdt_node_check_compatible(fdt, 0, KHO_FDT_COMPATIBLE);
-	if (err) {
-		pr_warn("setup: handover FDT (0x%llx) is incompatible with '%s': %d\n",
-			fdt_phys, KHO_FDT_COMPATIBLE, err);
+	if (kho_check_fdt(fdt, fdt_phys))
 		goto unmap_fdt;
-	}
 
 	mem_map_phys = kho_get_mem_map_phys(fdt);
 	if (!mem_map_phys)
diff --git a/kernel/liveupdate/kexec_handover_common.c b/kernel/liveupdate/kexec_handover_common.c
new file mode 100644
index 000000000000..f2784f5c523c
--- /dev/null
+++ b/kernel/liveupdate/kexec_handover_common.c
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * kexec_handover_common.c - Shared Kexec Handover helpers
+ *
+ * Copyright (C) 2025 Microsoft Corporation, Mike Rapoport <rppt@kernel.org>
+ * Copyright (c) 2026, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+#define pr_fmt(fmt) "KHO: " fmt
+
+#include <linux/bitops.h>
+#include <linux/export.h>
+#include <linux/init.h>
+#include <linux/kexec_handover.h>
+#include <linux/kho/abi/kexec_handover.h>
+#include <linux/libfdt.h>
+#include <linux/mm.h>
+#include <linux/printk.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+
+#include "kexec_handover_internal.h"
+
+/**
+ * kho_encode_radix_key - Encodes a physical address and order into a radix key.
+ * @phys: The physical address of the page.
+ * @order: The order of the page.
+ *
+ * This function combines a page's physical address and its order into a
+ * single unsigned long, which is used as a key for all radix tree
+ * operations.
+ *
+ * Return: The encoded unsigned long radix key.
+ */
+unsigned long kho_encode_radix_key(phys_addr_t phys, unsigned int order)
+{
+	/* The physical address is encoded by shifting the PFN by its order. */
+	unsigned long shift = PAGE_SHIFT + order;
+	/* Order bit goes right before the shifted PFN. */
+	unsigned long h = 1UL << (64 - shift);
+	/* Shifted PFN. */
+	unsigned long l = phys >> shift;
+
+	return h | l;
+}
+
+/**
+ * kho_decode_radix_key - Decodes a radix key back into a physical address and order.
+ * @key: The unsigned long key to decode.
+ * @order: An output parameter, a pointer to an unsigned int where the decoded
+ *         page order will be stored.
+ *
+ * This function reverses the encoding performed by kho_encode_radix_key(),
+ * extracting the original physical address and page order from a given key.
+ *
+ * Return: The decoded physical address.
+ */
+phys_addr_t kho_decode_radix_key(unsigned long key, unsigned int *order)
+{
+	/* fls64() indexes starting from 1. */
+	unsigned int order_bit = fls64(key) - 1;
+	phys_addr_t phys;
+
+	/* order bit goes right before the shifted PFN. */
+	*order = 64 - (PAGE_SHIFT + order_bit);
+	/* The order bit is discarded by the shift */
+	phys = key << (PAGE_SHIFT + *order);
+
+	return phys;
+}
+
+unsigned long kho_radix_get_bitmap_index(unsigned long key)
+{
+	return key % (1 << KHO_BITMAP_SIZE_LOG2);
+}
+
+unsigned long kho_radix_get_table_index(unsigned long key, unsigned int level)
+{
+	int s;
+
+	s = ((level - 1) * KHO_TABLE_SIZE_LOG2) + KHO_BITMAP_SIZE_LOG2;
+	return (key >> s) % (1 << KHO_TABLE_SIZE_LOG2);
+}
+
+/**
+ * kho_radix_find_leaf - Find the radix tree leaf for a given key.
+ * @root_pa: Physical address of the radix tree root node.
+ * @key:     The encoded radix key to look up.
+ * @map:     Callback to map a physical page address to a virtual pointer.
+ *
+ * Traverses the intermediate radix tree levels from @root_pa using @map to
+ * translate physical node addresses and returns the mapped leaf node for
+ * @key.
+ *
+ * Return: Virtual pointer to the leaf node on success, or NULL if @key is
+ * not present or a mapping fails.
+ */
+struct kho_radix_leaf *kho_radix_find_leaf(phys_addr_t root_pa,
+					   unsigned long key,
+					   void *(*map)(phys_addr_t pa))
+{
+	phys_addr_t pa = root_pa;
+	unsigned int i, idx;
+
+	if (!pa || unlikely(fls64(key) > KHO_RADIX_KEY_WIDTH))
+		return NULL;
+
+	for (i = KHO_TREE_MAX_DEPTH - 1; i > 0; i--) {
+		const struct kho_radix_node *node = map(pa);
+
+		if (!node)
+			return NULL;
+
+		idx = kho_radix_get_table_index(key, i);
+		pa = (phys_addr_t)READ_ONCE(node->table[idx]);
+		if (!pa)
+			return NULL;
+	}
+
+	return map(pa);
+}
+
+int __init kho_check_fdt(const void *fdt, phys_addr_t fdt_phys)
+{
+	int err;
+
+	err = fdt_check_header(fdt);
+	if (err) {
+		pr_warn("handover FDT (0x%llx) is invalid: %d\n",
+			(unsigned long long)fdt_phys, err);
+		return err;
+	}
+
+	if (fdt_totalsize(fdt) > PAGE_SIZE) {
+		pr_warn("handover FDT (0x%llx) totalsize %u exceeds PAGE_SIZE\n",
+			(unsigned long long)fdt_phys, fdt_totalsize(fdt));
+		return -EINVAL;
+	}
+
+	err = fdt_node_check_compatible(fdt, 0, KHO_FDT_COMPATIBLE);
+	if (err) {
+		pr_warn("handover FDT (0x%llx) is incompatible with '%s': %d\n",
+			(unsigned long long)fdt_phys, KHO_FDT_COMPATIBLE, err);
+		return err;
+	}
+
+	return 0;
+}
+
+/* Returns physical address of the preserved memory map from FDT */
+phys_addr_t __init kho_get_mem_map_phys(const void *fdt)
+{
+	const void *mem_ptr;
+	int len;
+
+	mem_ptr = fdt_getprop(fdt, 0, KHO_FDT_MEMORY_MAP_PROP_NAME, &len);
+	if (!mem_ptr || len != sizeof(u64)) {
+		pr_err("failed to get preserved memory map\n");
+		return 0;
+	}
+
+	return get_unaligned((const u64 *)mem_ptr);
+}
+
+/**
+ * kho_retrieve_subtree - retrieve a preserved sub blob by its name.
+ * @name: the name of the sub blob passed to kho_add_subtree().
+ * @phys: if found, the physical address of the sub blob is stored in @phys.
+ * @size: if not NULL and found, the size of the sub blob is stored in @size.
+ *
+ * Retrieve a preserved sub blob named @name and store its physical
+ * address in @phys and optionally its size in @size.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int kho_retrieve_subtree(const char *name, phys_addr_t *phys, size_t *size)
+{
+	const void *fdt = kho_get_fdt();
+	const u64 *val;
+	int offset, len;
+
+	if (!fdt)
+		return -ENOENT;
+
+	if (!phys)
+		return -EINVAL;
+
+	offset = fdt_subnode_offset(fdt, 0, name);
+	if (offset < 0)
+		return -ENOENT;
+
+	val = fdt_getprop(fdt, offset, KHO_SUB_TREE_PROP_NAME, &len);
+	if (!val || len != sizeof(*val))
+		return -EINVAL;
+
+	*phys = (phys_addr_t)get_unaligned(val);
+
+	val = fdt_getprop(fdt, offset, KHO_SUB_TREE_SIZE_PROP_NAME, &len);
+	if (!val || len != sizeof(*val)) {
+		pr_warn("broken KHO subnode '%s': missing or invalid blob-size property\n",
+			name);
+		return -EINVAL;
+	}
+
+	if (size)
+		*size = (size_t)get_unaligned(val);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kho_retrieve_subtree);
diff --git a/kernel/liveupdate/kexec_handover_internal.h b/kernel/liveupdate/kexec_handover_internal.h
index 38181076f603..e73a2e310917 100644
--- a/kernel/liveupdate/kexec_handover_internal.h
+++ b/kernel/liveupdate/kexec_handover_internal.h
@@ -2,10 +2,23 @@
 #ifndef LINUX_KEXEC_HANDOVER_INTERNAL_H
 #define LINUX_KEXEC_HANDOVER_INTERNAL_H
 
+#include <linux/init.h>
 #include <linux/kexec_handover.h>
+#include <linux/kho/abi/kexec_handover.h>
 #include <linux/list.h>
 #include <linux/types.h>
 
+const void *kho_get_fdt(void);
+unsigned long kho_encode_radix_key(phys_addr_t phys, unsigned int order);
+phys_addr_t kho_decode_radix_key(unsigned long key, unsigned int *order);
+unsigned long kho_radix_get_bitmap_index(unsigned long key);
+unsigned long kho_radix_get_table_index(unsigned long key, unsigned int level);
+struct kho_radix_leaf *kho_radix_find_leaf(phys_addr_t root_pa,
+					   unsigned long key,
+					   void *(*map)(phys_addr_t pa));
+int __init kho_check_fdt(const void *fdt, phys_addr_t fdt_phys);
+phys_addr_t __init kho_get_mem_map_phys(const void *fdt);
+
 #ifdef CONFIG_KEXEC_HANDOVER_DEBUGFS
 #include <linux/debugfs.h>
 
-- 
2.56.0.307.g5fe7bd680c-goog


