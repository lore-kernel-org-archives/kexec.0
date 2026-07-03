Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73DBBC44500
	for <kexec@archiver.kernel.org>; Fri,  3 Jul 2026 02:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XM5kwFHnX+0cnGF4HO/uD9DD/Pao8oPN685wEM7A8g4=; b=rVZsVXkkK4Lo5TuAW0Td3ubOMh
	9zXm1ohM9C1z7qPmTpHupGb4VF4NyuRqInQvSCWTnBTXy8xpGPlBr8N9c8pQKvD9VVzEYQdkQp+KQ
	LKo3rVaV+YhXwvNiv82joLZjs7pcCO8ZB2If9Tn4EyY96QES/vH6XuIoihN4oz4wlem4BV8j5arXs
	t/ul9+6M9CErw9n7Xgj37ni8bqWwO50udCrZmdno/kTMgcvPV3tkTAV6cIYJPbYohZdezYvaywqod
	JYgefC9iPPEIB5D2MUSzlQZ5Z5RkYloXBWmFRvZ5OVSM4zC2G9JDztDs/EnA7ba0ClyP1wyPtAHwk
	LMLOARKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfTKc-00000005rlP-0rxk;
	Fri, 03 Jul 2026 02:08:42 +0000
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfTKZ-00000005rkd-0E38
	for kexec@lists.infradead.org;
	Fri, 03 Jul 2026 02:08:40 +0000
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-2c987913b08so550005ad.2
        for <kexec@lists.infradead.org>; Thu, 02 Jul 2026 19:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783044518; x=1783649318; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XM5kwFHnX+0cnGF4HO/uD9DD/Pao8oPN685wEM7A8g4=;
        b=WeUNk3iZy/YV/i08YQkwDTB32d7trvNMa34f38kvFAPtx4Hd0nXoTHRQILODrhlvg4
         NQRSYx6ydoAI0MtnjhwhYyV0oqJ2Z89zSnb1ZM6uAfDx/BAvRcdkPuOlqKoB2mXUOFTv
         XKsemCtsNHlEhlpApHPcLKoWDF3oe5axe8wEmQb4Sf23tl88/dMFOrgZLPrH1W21fwB/
         VqRXl2gfW5qIkEboEpXNGtt1Dm4pJZGYCM87D8SAgatL0aYh3kzC0HXB/Xwk/ZcdP/YB
         U2IRw4pJg8GQDdLNLAG+7i+Lx1QAfGhF8VTjlBToq7oq6uwrddJtngtOSAOHM1OfWw0r
         xdqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783044518; x=1783649318;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XM5kwFHnX+0cnGF4HO/uD9DD/Pao8oPN685wEM7A8g4=;
        b=HHZtNORYBZCBr0BtH6uBXP5Wr/MXlwnLDN8ywCamCc0yHSOw/3ZwUHWSiYWDaZdnKc
         6uGLi0wVb9TXOXUcAdjZitUFXtxmP+SVNo9HmqJNao1VQ3q4JbZTZAEOckwZ/xHshawh
         cj+Ng9XRy4GuRiFiPWF5vuM7xIlrUZxwQEoN8R2P8YvmAi0msiHR4CpaQyOaMiek2HaB
         ilYtACG3eIHt3fPgtaykc8QJcy4RV+H9EMcE0k5ziokkv540/sJ7+wONw71k+X/6531W
         jQNUKcGeAYIf/qmgHRI9Zt2tIH+on3zNslftZDnuqV7VBfrvaShLzURzpL8PNFTkkhXI
         A/9A==
X-Forwarded-Encrypted: i=1; AHgh+RoCHLtMKEJDku0aqT+8dJlVw3nPSDK69Ni03L/2WHzhaYHumm3H3uz1PhsGTzPuN/4RDzf5dA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxWt4t8HRSmzSeAOt1kNFc12r/5kIuAGZOY7XZBNF8tvUecle2G
	mYRmfIj138fA8CXLbOLB1ls8BPiXO6zTwfkNT6Kzbb2LceujIi4vaU+tl+7kkgT5tMlloyTo/xq
	naw==
X-Received: from plpn16.prod.google.com ([2002:a17:902:9690:b0:2c8:1ded:d061])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:291:b0:2c9:e86e:a9f3
 with SMTP id d9443c01a7336-2ca7e6f0ad5mr88741955ad.10.1783044517372; Thu, 02
 Jul 2026 19:08:37 -0700 (PDT)
Date: Fri,  3 Jul 2026 02:08:29 +0000
In-Reply-To: <20260703020832.1731864-1-praan@google.com>
Mime-Version: 1.0
References: <20260703020832.1731864-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260703020832.1731864-2-praan@google.com>
Subject: [RFC PATCH 1/4] kho: Introduce infrastructure to track preserved page types
From: Pranjal Shrivastava <praan@google.com>
To: Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Samiullah Khawaja <skhawaja@google.com>, 
	David Matlack <dmatlack@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260702_190839_104057_C615490D 
X-CRM114-Status: GOOD (  27.11  )
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

The KHO mechanism currently treats all multi-page blocks preserved across
a kexec as split pages during restoration, i.e. every page carries a
refcount of 1.

However, many kernel allocations, most notably DMA buffer-allocations
via dma_alloc_coherent(), return high-order non-compound pages. In this
unsplit state, only the head page has a reference count of 1, while tail
pages have a reference count of 0.

Restoring these contiguous & unsplit blocks using the current KHO
restore forces a refcount of 1 on every tail page. This causes the
buddy allocator to trigger a bad page state panic on the free path in
the new kernel when CONFIG_DEBUG_VM is enabled, as it does not expect
tail pages of a high-order block to be refcounted.

Introduce a page_type field to track the refcount pattern of preserved
pages to avoid refcounting the tails pages of high-order non-compound
pages during restore.

The type is stored in the unused high bit (bit 63) of the KHO radix tree
key to ensure it survives the kexec journey (ABI), and is stashed in the
page->private metadata during early boot of the new kernel.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 include/linux/kho_radix_tree.h     | 17 +++++---
 kernel/liveupdate/kexec_handover.c | 62 ++++++++++++++++++++----------
 2 files changed, 53 insertions(+), 26 deletions(-)

diff --git a/include/linux/kho_radix_tree.h b/include/linux/kho_radix_tree.h
index 84e918b96e53..9244a3f7a2d4 100644
--- a/include/linux/kho_radix_tree.h
+++ b/include/linux/kho_radix_tree.h
@@ -34,16 +34,22 @@ struct kho_radix_tree {
 	struct mutex lock; /* protects the tree's structure and root pointer */
 };
 
+enum kho_page_type {
+	KHO_PAGE_CONTIG = 0,
+	KHO_PAGE_SPLIT,
+};
+
 typedef int (*kho_radix_tree_walk_callback_t)(phys_addr_t phys,
-					      unsigned int order);
+					      unsigned int order,
+					      enum kho_page_type type);
 
 #ifdef CONFIG_KEXEC_HANDOVER
 
 int kho_radix_add_page(struct kho_radix_tree *tree, unsigned long pfn,
-		       unsigned int order);
+		       unsigned int order, enum kho_page_type type);
 
 void kho_radix_del_page(struct kho_radix_tree *tree, unsigned long pfn,
-			unsigned int order);
+			unsigned int order, enum kho_page_type type);
 
 int kho_radix_walk_tree(struct kho_radix_tree *tree,
 			kho_radix_tree_walk_callback_t cb);
@@ -51,13 +57,14 @@ int kho_radix_walk_tree(struct kho_radix_tree *tree,
 #else  /* #ifdef CONFIG_KEXEC_HANDOVER */
 
 static inline int kho_radix_add_page(struct kho_radix_tree *tree, long pfn,
-				     unsigned int order)
+				     unsigned int order, enum kho_page_type type)
 {
 	return -EOPNOTSUPP;
 }
 
 static inline void kho_radix_del_page(struct kho_radix_tree *tree,
-				      unsigned long pfn, unsigned int order) { }
+				      unsigned long pfn, unsigned int order,
+				      enum kho_page_type type) { }
 
 static inline int kho_radix_walk_tree(struct kho_radix_tree *tree,
 				      kho_radix_tree_walk_callback_t cb)
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 4834a809985a..f829ffdd00f4 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -43,18 +43,22 @@
 
 /*
  * KHO uses page->private, which is an unsigned long, to store page metadata.
- * Use it to store both the magic and the order.
+ * Use it to store the magic, the order, and the type bit.
  */
 union kho_page_info {
 	unsigned long page_private;
 	struct {
-		unsigned int order;
+		unsigned int order : 31;
+		unsigned int type  : 1;
 		unsigned int magic;
 	};
 };
 
 static_assert(sizeof(union kho_page_info) == sizeof(((struct page *)0)->private));
 
+#define KHO_KEY_TYPE_SHIFT 63
+#define KHO_KEY_TYPE_MASK  BIT(KHO_KEY_TYPE_SHIFT)
+
 static bool kho_enable __ro_after_init = IS_ENABLED(CONFIG_KEXEC_HANDOVER_ENABLE_DEFAULT);
 
 bool kho_is_enabled(void)
@@ -85,42 +89,52 @@ static struct kho_out kho_out = {
 };
 
 /**
- * kho_radix_encode_key - Encodes a physical address and order into a radix key.
+ * kho_radix_encode_key - Encodes a physical address, order and type into a radix key.
  * @phys: The physical address of the page.
  * @order: The order of the page.
+ * @type: The page type.
  *
- * This function combines a page's physical address and its order into a
+ * This function combines a page's physical address, its order, and its type into a
  * single unsigned long, which is used as a key for all radix tree
  * operations.
  *
  * Return: The encoded unsigned long radix key.
  */
-static unsigned long kho_radix_encode_key(phys_addr_t phys, unsigned int order)
+static unsigned long kho_radix_encode_key(phys_addr_t phys, unsigned int order,
+					  enum kho_page_type type)
 {
 	/* Order bits part */
 	unsigned long h = 1UL << (KHO_ORDER_0_LOG2 - order);
 	/* Shifted physical address part */
 	unsigned long l = phys >> (PAGE_SHIFT + order);
+	/* Type bit part */
+	unsigned long t = (unsigned long)type << KHO_KEY_TYPE_SHIFT;
 
-	return h | l;
+	return h | l | t;
 }
 
 /**
- * kho_radix_decode_key - Decodes a radix key back into a physical address and order.
+ * kho_radix_decode_key - Decodes a radix key back into physical address, order, and type.
  * @key: The unsigned long key to decode.
  * @order: An output parameter, a pointer to an unsigned int where the decoded
  *         page order will be stored.
+ * @type: An output parameter, a pointer to where the decoded type will be stored.
  *
  * This function reverses the encoding performed by kho_radix_encode_key(),
- * extracting the original physical address and page order from a given key.
+ * extracting the original physical address, page order, and type from a given key.
  *
  * Return: The decoded physical address.
  */
-static phys_addr_t kho_radix_decode_key(unsigned long key, unsigned int *order)
+static phys_addr_t kho_radix_decode_key(unsigned long key, unsigned int *order,
+					enum kho_page_type *type)
 {
-	unsigned int order_bit = fls64(key);
+	unsigned int order_bit;
 	phys_addr_t phys;
 
+	*type = (key & KHO_KEY_TYPE_MASK) >> KHO_KEY_TYPE_SHIFT;
+	key &= ~KHO_KEY_TYPE_MASK;
+
+	order_bit = fls64(key);
 	/* order_bit is numbered starting at 1 from fls64 */
 	*order = KHO_ORDER_0_LOG2 - order_bit + 1;
 	/* The order is discarded by the shift */
@@ -148,6 +162,7 @@ static unsigned long kho_radix_get_table_index(unsigned long key,
  * @tree: The KHO radix tree.
  * @pfn: The page frame number of the page to preserve.
  * @order: The order of the page.
+ * @type: The page type.
  *
  * This function traverses the radix tree based on the key derived from @pfn
  * and @order. It sets the corresponding bit in the leaf bitmap to mark the
@@ -157,11 +172,12 @@ static unsigned long kho_radix_get_table_index(unsigned long key,
  * Return: 0 on success, or a negative error code on failure.
  */
 int kho_radix_add_page(struct kho_radix_tree *tree,
-		       unsigned long pfn, unsigned int order)
+		       unsigned long pfn, unsigned int order,
+		       enum kho_page_type type)
 {
 	/* Newly allocated nodes for error cleanup */
 	struct kho_radix_node *intermediate_nodes[KHO_TREE_MAX_DEPTH] = { 0 };
-	unsigned long key = kho_radix_encode_key(PFN_PHYS(pfn), order);
+	unsigned long key = kho_radix_encode_key(PFN_PHYS(pfn), order, type);
 	struct kho_radix_node *anchor_node = NULL;
 	struct kho_radix_node *node = tree->root;
 	struct kho_radix_node *new_node;
@@ -231,15 +247,16 @@ EXPORT_SYMBOL_GPL(kho_radix_add_page);
  * @tree: The KHO radix tree.
  * @pfn: The page frame number of the page to unpreserve.
  * @order: The order of the page.
+ * @type: The page type.
  *
  * This function traverses the radix tree and clears the bit corresponding to
  * the page, effectively removing its "preserved" status. It does not free
  * the tree's intermediate nodes, even if they become empty.
  */
 void kho_radix_del_page(struct kho_radix_tree *tree, unsigned long pfn,
-			unsigned int order)
+			unsigned int order, enum kho_page_type type)
 {
-	unsigned long key = kho_radix_encode_key(PFN_PHYS(pfn), order);
+	unsigned long key = kho_radix_encode_key(PFN_PHYS(pfn), order, type);
 	struct kho_radix_node *node = tree->root;
 	struct kho_radix_leaf *leaf;
 	unsigned int i, idx;
@@ -277,14 +294,15 @@ static int kho_radix_walk_leaf(struct kho_radix_leaf *leaf,
 			       kho_radix_tree_walk_callback_t cb)
 {
 	unsigned long *bitmap = (unsigned long *)leaf;
+	enum kho_page_type type;
 	unsigned int order;
 	phys_addr_t phys;
 	unsigned int i;
 	int err;
 
 	for_each_set_bit(i, bitmap, PAGE_SIZE * BITS_PER_BYTE) {
-		phys = kho_radix_decode_key(key | i, &order);
-		err = cb(phys, order);
+		phys = kho_radix_decode_key(key | i, &order, &type);
+		err = cb(phys, order, type);
 		if (err)
 			return err;
 	}
@@ -485,7 +503,8 @@ static struct page *__init kho_get_preserved_page(phys_addr_t phys,
 }
 
 static int __init kho_preserved_memory_reserve(phys_addr_t phys,
-					       unsigned int order)
+					       unsigned int order,
+					       enum kho_page_type type)
 {
 	union kho_page_info info;
 	struct page *page;
@@ -499,6 +518,7 @@ static int __init kho_preserved_memory_reserve(phys_addr_t phys,
 	memblock_reserved_mark_noinit(phys, sz);
 	info.magic = KHO_PAGE_MAGIC;
 	info.order = order;
+	info.type = type;
 	page->private = info.page_private;
 
 	return 0;
@@ -859,7 +879,7 @@ int kho_preserve_folio(struct folio *folio)
 	if (WARN_ON(kho_scratch_overlap(pfn << PAGE_SHIFT, PAGE_SIZE << order)))
 		return -EINVAL;
 
-	return kho_radix_add_page(tree, pfn, order);
+	return kho_radix_add_page(tree, pfn, order, KHO_PAGE_CONTIG);
 }
 EXPORT_SYMBOL_GPL(kho_preserve_folio);
 
@@ -877,7 +897,7 @@ void kho_unpreserve_folio(struct folio *folio)
 	const unsigned long pfn = folio_pfn(folio);
 	const unsigned int order = folio_order(folio);
 
-	kho_radix_del_page(tree, pfn, order);
+	kho_radix_del_page(tree, pfn, order, KHO_PAGE_CONTIG);
 }
 EXPORT_SYMBOL_GPL(kho_unpreserve_folio);
 
@@ -906,7 +926,7 @@ static void __kho_unpreserve(struct kho_radix_tree *tree,
 	while (pfn < end_pfn) {
 		order = __kho_preserve_pages_order(pfn, end_pfn);
 
-		kho_radix_del_page(tree, pfn, order);
+		kho_radix_del_page(tree, pfn, order, KHO_PAGE_CONTIG);
 
 		pfn += 1 << order;
 	}
@@ -939,7 +959,7 @@ int kho_preserve_pages(struct page *page, unsigned long nr_pages)
 	while (pfn < end_pfn) {
 		unsigned int order = __kho_preserve_pages_order(pfn, end_pfn);
 
-		err = kho_radix_add_page(tree, pfn, order);
+		err = kho_radix_add_page(tree, pfn, order, KHO_PAGE_CONTIG);
 		if (err) {
 			failed_pfn = pfn;
 			break;
-- 
2.55.0.rc0.799.gd6f94ed593-goog


