Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09844CCF2D8
	for <kexec@archiver.kernel.org>; Mon, 19 Oct 2026 02:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7ti3YkcfnTEBL5joWie6hwuLUXl2KXMMFurkAbb61S4=; b=VjLGLbgPPNv8GXfsKH1jZ+lAwv
	oNqYzIFTuM+6U08rfgrj3M+wjB5vWCy9VQ+Z09lFSblfSVMOJL5r4RgcgKd8mDe36vvxdYNJ8OWC/
	p2DvuZmNIcrfYK1KBjDmG72QsT2QPeiqdljms1T1LqTVa91Bio1fTOZJ38f4lSrLu7X+Q+1LqVjS6
	BxLAfxg82y9rEcmUHNnSoclHuVUfenQqpJjjMKInt8mPkiinCJaNPAbxF4Po/z8R5TaY90tUycR5A
	rA+JJzn8bvsaz8X6Rt9+YJGuOmbLXIUATSTsd9YtuK2RiZ/k92ZT11lBRqFgGOqO23f+5aEHluLjI
	BqpKu5eQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIcqV-00000006RT5-47xL;
	Mon, 19 Oct 2026 02:11:27 +0000
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIcqP-00000006RPL-2Dtf
	for kexec@lists.infradead.org;
	Mon, 19 Oct 2026 02:11:27 +0000
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-5eabf7d5bbeso1086741e0c.1
        for <kexec@lists.infradead.org>; Sun, 18 Oct 2026 19:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792375880; x=1792980680; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7ti3YkcfnTEBL5joWie6hwuLUXl2KXMMFurkAbb61S4=;
        b=cybvtM9SgjNsBv0L5GP2CwXVgGe20criev3gZz5ZnRCKlwfXyhFp/2njis/I1aXeOJ
         4vcEhFHC1I1z5gL4v/WHm2vkVFfq82SPFRxiWN+bRY66K8Q/J6StYScKEqPDjbh2u98f
         yQuZFovTzMCaqA1ItWV45O/a1oy0DTCIIzx6c6J06uJaDw2sFwRslu69wb12NyWYE7iW
         Irtbb70Qo/019pd8iL+Vyw5fxmd7Hx5mkmZmZ6WtIi03IADn00T3x17t02YAWpmcgYUG
         p+ymhAI2tGtOfHV8gYM//zBMsUPdMPlDeFFhsxii2Ueb5445hxDhMUXhK7un2opIZpYa
         TPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792375880; x=1792980680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7ti3YkcfnTEBL5joWie6hwuLUXl2KXMMFurkAbb61S4=;
        b=lW1hg6rRL6WXYeOHgMVPQlRRVypm+2/4htXRTsgterwU2+hxL1UAPiGNnhdoDklwhZ
         IcX0wVzfHbv4rHpiQ5tSc34O4a4HNabCFs1DRKvrz8uR80CVCycYD49VUpEE6kRkdzvE
         Wwhyh0he9mGTiTKS0bz4jRl01ZeMy/jpXUHlF07RLEqdcFfy7EnFhYE4C5PUJXEDc+qd
         b1EfgZZ1EjUUs09i6/77PBaPonsWn1Iil0IxzZHSee4DLYmkCmtE1xZ8KODBrT5Xxybz
         syfa+gwvyCeqby09aBTm7iko6WgSCOeo6g4imRR3qS5iIubW094Tlb2pfrADqF+QANN+
         pTzg==
X-Forwarded-Encrypted: i=1; AKwUvBwVziAUrPvzw7Z3RPLmH31HuEyybHj0mmsT/+H651GTeNbPIMCi9zDWhahT9w1210de32ezzw==@lists.infradead.org
X-Gm-Message-State: AFq9FYLs73nFiuL7OJCr0Xkc42G5wisPDYcgXOmPwVErrzz1dBqY0hSB
	sRSFTnpzqWzxgD0BKQSZpKgmLlnjjMSDrv4GsU0GYZ3gAKUUveVOiz3uO0uoY4Zu+UA=
X-Gm-Gg: AYBFou1DiaRdu7pGtiQxph90opAo0APG6r/7b+3+i4gE1EW2pNDhovD4epjIX0lBZnT
	N9ia13VO7z6MeN4mFKuFjwmZTfm7SOo1kk9ZfT7fOCpWJDvV9CBzxHBXTuEzpTS8Fs5l14MzS/b
	lYa2ZxmE36Y0uDdO14AszvOYxd41srY0NDl2tlQLsb6Mwq29zR99AYwnSE6ZnD7FfKfJMzJbZoC
	ENizbF/XWMt+ilAZldK6dsxQubae2aItttI5lcoErlvUJLKlCgb2VgalZ3jANkz3tFqnbhp+Hxy
	rTLZSD48ZLjpx2JhztPvwOdDGqrlMvusrF9fIuCSJmxcruZKmC5khf1IoofeXqeLBApat0BNzNU
	5WBkvF8xCURSxuonGU+E7rvyq5ErZdfXRysZfzfVeZO71q5iAI+eM7YmAqfBwT9hAr+Cp4rtyda
	1FLZ2lib7tRd/z6sAJypS7/YGikBRvozT5nJMQK4+PAupKMz/H1GWMMXNv8Kvn5kQ/l+H7Wa9GN
	lgaT0KcQ3FEiW5hc62HGoxEIEfIbPT+L9AcINubf2GSOt8KdnNj6qeQWJvHm4snkC6ArTTfB7nQ
	eh3ymWf+YYq4LMCNQo4=
X-Received: by 2002:a05:6102:26d0:b0:7cc:1192:5636 with SMTP id ada2fe7eead31-7cc36905d1emr2154033137.12.1792375880231;
        Sun, 18 Oct 2026 19:11:20 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eabbd9ea2bsm4271383e0c.2.2026.10.18.19.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 19:11:19 -0700 (PDT)
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
Subject: [PATCH v1 2/8] kho: move radix tree, vmalloc, and FDT helpers to internal header
Date: Sun, 18 Oct 2026 22:11:05 -0400
Message-ID: <20261019021111.990394-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
In-Reply-To: <20261019021111.990394-1-pasha.tatashin@soleen.com>
References: <20261019021111.990394-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261018_191123_495753_E78827DE 
X-CRM114-Status: GOOD (  21.88  )
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

Move the shared KHO radix tree key encoding and indexing helpers,
vmalloc flag conversion helpers, and FDT validation and lookup helpers
from kexec_handover.c into kexec_handover_internal.h as static inline
functions.

The radix tree and vmalloc flag helpers are small bit-manipulation
routines, and the FDT helpers are small wrappers with a single call site
per translation unit, so it is natural to inline them in the internal
header.

This is going to be used by the upcoming KHO read-only mode to walk
preserved KHO radix trees, vmalloc preservation chains, and FDT
subtrees without duplicating the implementation.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/kexec_handover.c          | 115 +----------------
 kernel/liveupdate/kexec_handover_internal.h | 134 ++++++++++++++++++++
 2 files changed, 136 insertions(+), 113 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index ce5983abf181..f427cdd9a969 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -113,29 +113,6 @@ static const void *kho_get_fdt(void)
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
 /**
  * kho_decode_radix_key - Decodes a radix key back into a physical address and order.
  * @key: The unsigned long key to decode.
@@ -161,20 +138,6 @@ static phys_addr_t kho_decode_radix_key(unsigned long key, unsigned int *order)
 	return phys;
 }
 
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
@@ -634,21 +597,6 @@ static int __init kho_preserved_memory_reserve(unsigned long key, void *data)
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
@@ -1287,13 +1235,6 @@ void kho_unpreserve_pages(struct page *page, unsigned long nr_pages)
 }
 EXPORT_SYMBOL_GPL(kho_unpreserve_pages);
 
-/* vmalloc flags KHO supports */
-#define KHO_VMALLOC_SUPPORTED_FLAGS	(VM_ALLOC | VM_ALLOW_HUGE_VMAP)
-
-/* KHO internal flags for vmalloc preservations */
-#define KHO_VMALLOC_ALLOC	0x0001
-#define KHO_VMALLOC_HUGE_VMAP	0x0002
-
 static unsigned short vmalloc_flags_to_kho(unsigned int vm_flags)
 {
 	unsigned short kho_flags = 0;
@@ -1306,18 +1247,6 @@ static unsigned short vmalloc_flags_to_kho(unsigned int vm_flags)
 	return kho_flags;
 }
 
-static unsigned int kho_flags_to_vmalloc(unsigned short kho_flags)
-{
-	unsigned int vm_flags = 0;
-
-	if (kho_flags & KHO_VMALLOC_ALLOC)
-		vm_flags |= VM_ALLOC;
-	if (kho_flags & KHO_VMALLOC_HUGE_VMAP)
-		vm_flags |= VM_ALLOW_HUGE_VMAP;
-
-	return vm_flags;
-}
-
 static struct kho_vmalloc_chunk *new_vmalloc_chunk(struct kho_vmalloc_chunk *cur)
 {
 	struct kho_vmalloc_chunk *chunk;
@@ -1660,37 +1589,7 @@ EXPORT_SYMBOL_GPL(is_kho_boot);
  */
 int kho_retrieve_subtree(const char *name, phys_addr_t *phys, size_t *size)
 {
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
+	return __kho_retrieve_subtree(kho_get_fdt(), name, phys, size);
 }
 EXPORT_SYMBOL_GPL(kho_retrieve_subtree);
 
@@ -1981,18 +1880,8 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 		pr_warn("setup: failed to memremap FDT (0x%llx)\n", fdt_phys);
 		goto report;
 	}
-	err = fdt_check_header(fdt);
-	if (err) {
-		pr_warn("setup: handover FDT (0x%llx) is invalid: %d\n",
-			fdt_phys, err);
+	if (kho_check_fdt(fdt, fdt_phys))
 		goto unmap_fdt;
-	}
-	err = fdt_node_check_compatible(fdt, 0, KHO_FDT_COMPATIBLE);
-	if (err) {
-		pr_warn("setup: handover FDT (0x%llx) is incompatible with '%s': %d\n",
-			fdt_phys, KHO_FDT_COMPATIBLE, err);
-		goto unmap_fdt;
-	}
 
 	mem_map_phys = kho_get_mem_map_phys(fdt);
 	if (!mem_map_phys)
diff --git a/kernel/liveupdate/kexec_handover_internal.h b/kernel/liveupdate/kexec_handover_internal.h
index 38181076f603..094b4917a0f1 100644
--- a/kernel/liveupdate/kexec_handover_internal.h
+++ b/kernel/liveupdate/kexec_handover_internal.h
@@ -3,8 +3,142 @@
 #define LINUX_KEXEC_HANDOVER_INTERNAL_H
 
 #include <linux/kexec_handover.h>
+#include <linux/kho/abi/kexec_handover.h>
+#include <linux/libfdt.h>
 #include <linux/list.h>
+#include <linux/mm.h>
+#include <linux/printk.h>
 #include <linux/types.h>
+#include <linux/unaligned.h>
+#include <linux/vmalloc.h>
+
+/* vmalloc flags KHO supports */
+#define KHO_VMALLOC_SUPPORTED_FLAGS	(VM_ALLOC | VM_ALLOW_HUGE_VMAP)
+
+/* KHO internal flags for vmalloc preservations */
+#define KHO_VMALLOC_ALLOC	0x0001
+#define KHO_VMALLOC_HUGE_VMAP	0x0002
+
+static inline unsigned int kho_flags_to_vmalloc(unsigned short kho_flags)
+{
+	unsigned int vm_flags = 0;
+
+	if (kho_flags & KHO_VMALLOC_ALLOC)
+		vm_flags |= VM_ALLOC;
+	if (kho_flags & KHO_VMALLOC_HUGE_VMAP)
+		vm_flags |= VM_ALLOW_HUGE_VMAP;
+
+	return vm_flags;
+}
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
+static inline unsigned long kho_encode_radix_key(phys_addr_t phys,
+						 unsigned int order)
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
+static inline unsigned long kho_radix_get_bitmap_index(unsigned long key)
+{
+	return key % (1 << KHO_BITMAP_SIZE_LOG2);
+}
+
+static inline unsigned long kho_radix_get_table_index(unsigned long key,
+						      unsigned int level)
+{
+	int s;
+
+	s = ((level - 1) * KHO_TABLE_SIZE_LOG2) + KHO_BITMAP_SIZE_LOG2;
+	return (key >> s) % (1 << KHO_TABLE_SIZE_LOG2);
+}
+
+static inline int kho_check_fdt(const void *fdt, phys_addr_t fdt_phys)
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
+static inline phys_addr_t kho_get_mem_map_phys(const void *fdt)
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
+static inline int __kho_retrieve_subtree(const void *fdt, const char *name,
+					 phys_addr_t *phys, size_t *size)
+{
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
 
 #ifdef CONFIG_KEXEC_HANDOVER_DEBUGFS
 #include <linux/debugfs.h>
-- 
2.56.0.176.g3575e65682-goog


