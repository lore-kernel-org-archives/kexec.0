Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C5AC44500
	for <kexec@archiver.kernel.org>; Tue,  7 Jul 2026 08:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JHmjKjFbMTC2Cvz1h5jMZ+zuLJbwjekQv7bIQWsFtOg=; b=OW4XjdKQsxC6iASztSN2MWbjzD
	SqnPk1G88LAeavtfPdaAOnTQXu4VlOe9kLVFAZxfAer8RjbFLtjd7kP1hc8QKgkXVVh590Ju0HPZz
	ApzTm5xCNiW+ReXzvUWKuxyQcyGjobJfwYpn2d8jD5CmvfcZVKm1hDNnpAriH/U1D3Tfc4plQngmk
	CMyj5bFp6C7EuTMeRZCivmR3PtBAXaAzAkjjB0ji3pmbimGP2HNiX1l6MH+wzVdrYVUVbjwsLXc5B
	2bgc7PHbAUn4biF2cTdhZqeIr9MpF9SZgtiblZyO/GdzzfRAewvMOPmla6tL49oFySxIrO3xe4P80
	v0/UQPGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wh1AV-0000000ETgF-3xwI;
	Tue, 07 Jul 2026 08:28:39 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wh1AU-0000000ETg1-40Ww
	for kexec@lists.infradead.org;
	Tue, 07 Jul 2026 08:28:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2D3FE618AF;
	Tue,  7 Jul 2026 08:28:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8321F00A3A;
	Tue,  7 Jul 2026 08:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783412917;
	bh=JHmjKjFbMTC2Cvz1h5jMZ+zuLJbwjekQv7bIQWsFtOg=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=KM1WK8HfwWaEyyJAfcCqlBoxaDuzsz6VRxeXWtkm1cdle9DBn0RFCuYm4aRQn2da9
	 Y8rgzXNzizHCMZOo/f1u7jgxiTw2Od/KQ1UWqP0QKsZapvSlm+fEjGt/hlyb50/7Dh
	 fqGLjnviqRpnW4mLbpxF6p42qCwoc0WxkeS8+BSLNHQ3JVp/QX1pzeXs5LrILWdsye
	 8r7eiOp5mB0mu7a16UhVESdpa6DpV7p2e31RvQTMMtEiimD0jWIX0vN6u0poCtCWB4
	 /nU3VXVAWrKNtgQc8E7Cn56L1v55V2E/QaQBAnTcydr+Z22icYC8kMX2yWSpAjeCu1
	 dbFVKqQsWcJng==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH 1/4] kho: Introduce infrastructure to track
 preserved page types
From: Mike Rapoport <rppt@kernel.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 David Matlack <dmatlack@google.com>, kexec@lists.infradead.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260703020832.1731864-2-praan@google.com>
References: <20260703020832.1731864-1-praan@google.com>
 <20260703020832.1731864-2-praan@google.com>
Date: Tue, 07 Jul 2026 11:28:28 +0300
Message-Id: <178341290876.3292146.1907620918477010323.b4-review@b4>
X-Mailer: b4 0.16-dev
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

> The KHO mechanism currently treats all multi-page blocks preserved across
> a kexec as split pages during restoration, i.e. every page carries a
> refcount of 1.
> 
> However, many kernel allocations, most notably DMA buffer-allocations
> via dma_alloc_coherent(), return high-order non-compound pages. In this
> unsplit state, only the head page has a reference count of 1, while tail
> pages have a reference count of 0.
> 
> Restoring these contiguous & unsplit blocks using the current KHO
> restore forces a refcount of 1 on every tail page. This causes the
> buddy allocator to trigger a bad page state panic on the free path in
> the new kernel when CONFIG_DEBUG_VM is enabled, as it does not expect
> tail pages of a high-order block to be refcounted.
> 
> Introduce a page_type field to track the refcount pattern of preserved
> pages to avoid refcounting the tails pages of high-order non-compound
> pages during restore.
> 
> The type is stored in the unused high bit (bit 63) of the KHO radix tree
> key to ensure it survives the kexec journey (ABI), and is stashed in the
> page->private metadata during early boot of the new kernel.
> 
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
>
> diff --git a/include/linux/kho_radix_tree.h b/include/linux/kho_radix_tree.h
> index 84e918b96e53d..9244a3f7a2d47 100644
> --- a/include/linux/kho_radix_tree.h
> +++ b/include/linux/kho_radix_tree.h
> @@ -34,16 +34,22 @@ struct kho_radix_tree {
>  	struct mutex lock; /* protects the tree's structure and root pointer */
>  };
>  
> +enum kho_page_type {
> +	KHO_PAGE_CONTIG = 0,
> +	KHO_PAGE_SPLIT,
> +};
> +
>  typedef int (*kho_radix_tree_walk_callback_t)(phys_addr_t phys,
> -					      unsigned int order);
> +					      unsigned int order,
> +					      enum kho_page_type type);
>  
>  #ifdef CONFIG_KEXEC_HANDOVER
>  
>  int kho_radix_add_page(struct kho_radix_tree *tree, unsigned long pfn,
> -		       unsigned int order);
> +		       unsigned int order, enum kho_page_type type);
>  
>  void kho_radix_del_page(struct kho_radix_tree *tree, unsigned long pfn,
> -			unsigned int order);
> +			unsigned int order, enum kho_page_type type);

This conflicts with Pratyush's generalization of the radix tree APIs [1].
I'd suggest rebasing this on top of that and saying that generalization
of the radix tree APIs is a dependency of this patchset.

>  int kho_radix_walk_tree(struct kho_radix_tree *tree,
>  			kho_radix_tree_walk_callback_t cb);
> @@ -51,13 +57,14 @@ int kho_radix_walk_tree(struct kho_radix_tree *tree,
>  #else  /* #ifdef CONFIG_KEXEC_HANDOVER */
>  
>  static inline int kho_radix_add_page(struct kho_radix_tree *tree, long pfn,
> -				     unsigned int order)
> +				     unsigned int order, enum kho_page_type type)
>  {
>  	return -EOPNOTSUPP;
>  }
>  
>  static inline void kho_radix_del_page(struct kho_radix_tree *tree,
> -				      unsigned long pfn, unsigned int order) { }
> +				      unsigned long pfn, unsigned int order,
> +				      enum kho_page_type type) { }
>  
>  static inline int kho_radix_walk_tree(struct kho_radix_tree *tree,
>  				      kho_radix_tree_walk_callback_t cb)
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 4834a809985ab..f829ffdd00f45 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -43,18 +43,22 @@
>  
>  /*
>   * KHO uses page->private, which is an unsigned long, to store page metadata.
> - * Use it to store both the magic and the order.
> + * Use it to store the magic, the order, and the type bit.
>   */
>  union kho_page_info {
>  	unsigned long page_private;
>  	struct {
> -		unsigned int order;
> +		unsigned int order : 31;
> +		unsigned int type  : 1;
>  		unsigned int magic;
>  	};
>  };
>  
>  static_assert(sizeof(union kho_page_info) == sizeof(((struct page *)0)->private));
>  
> +#define KHO_KEY_TYPE_SHIFT 63
> +#define KHO_KEY_TYPE_MASK  BIT(KHO_KEY_TYPE_SHIFT)
> +
>  static bool kho_enable __ro_after_init = IS_ENABLED(CONFIG_KEXEC_HANDOVER_ENABLE_DEFAULT);
>  
>  bool kho_is_enabled(void)
> @@ -85,42 +89,52 @@ static struct kho_out kho_out = {
>  };
>  
>  /**
> - * kho_radix_encode_key - Encodes a physical address and order into a radix key.
> + * kho_radix_encode_key - Encodes a physical address, order and type into a radix key.
>   * @phys: The physical address of the page.
>   * @order: The order of the page.
> + * @type: The page type.
>   *
> - * This function combines a page's physical address and its order into a
> + * This function combines a page's physical address, its order, and its type into a
>   * single unsigned long, which is used as a key for all radix tree
>   * operations.
>   *
>   * Return: The encoded unsigned long radix key.
>   */
> -static unsigned long kho_radix_encode_key(phys_addr_t phys, unsigned int order)
> +static unsigned long kho_radix_encode_key(phys_addr_t phys, unsigned int order,
> +					  enum kho_page_type type)
>  {
>  	/* Order bits part */
>  	unsigned long h = 1UL << (KHO_ORDER_0_LOG2 - order);
>  	/* Shifted physical address part */
>  	unsigned long l = phys >> (PAGE_SHIFT + order);
> +	/* Type bit part */
> +	unsigned long t = (unsigned long)type << KHO_KEY_TYPE_SHIFT;
>  
> -	return h | l;
> +	return h | l | t;
>  }
>  
>  /**
> - * kho_radix_decode_key - Decodes a radix key back into a physical address and order.
> + * kho_radix_decode_key - Decodes a radix key back into physical address, order, and type.
>   * @key: The unsigned long key to decode.
>   * @order: An output parameter, a pointer to an unsigned int where the decoded
>   *         page order will be stored.
> + * @type: An output parameter, a pointer to where the decoded type will be stored.
>   *
>   * This function reverses the encoding performed by kho_radix_encode_key(),
> - * extracting the original physical address and page order from a given key.
> + * extracting the original physical address, page order, and type from a given key.
>   *
>   * Return: The decoded physical address.
>   */
> -static phys_addr_t kho_radix_decode_key(unsigned long key, unsigned int *order)
> +static phys_addr_t kho_radix_decode_key(unsigned long key, unsigned int *order,
> +					enum kho_page_type *type)
>  {
> -	unsigned int order_bit = fls64(key);
> +	unsigned int order_bit;
>  	phys_addr_t phys;
>  
> +	*type = (key & KHO_KEY_TYPE_MASK) >> KHO_KEY_TYPE_SHIFT;
> +	key &= ~KHO_KEY_TYPE_MASK;
> +
> +	order_bit = fls64(key);
>  	/* order_bit is numbered starting at 1 from fls64 */
>  	*order = KHO_ORDER_0_LOG2 - order_bit + 1;
>  	/* The order is discarded by the shift */
> @@ -148,6 +162,7 @@ static unsigned long kho_radix_get_table_index(unsigned long key,
>   * @tree: The KHO radix tree.
>   * @pfn: The page frame number of the page to preserve.
>   * @order: The order of the page.
> + * @type: The page type.
>   *
>   * This function traverses the radix tree based on the key derived from @pfn
>   * and @order. It sets the corresponding bit in the leaf bitmap to mark the
> @@ -157,11 +172,12 @@ static unsigned long kho_radix_get_table_index(unsigned long key,
>   * Return: 0 on success, or a negative error code on failure.
>   */
>  int kho_radix_add_page(struct kho_radix_tree *tree,
> -		       unsigned long pfn, unsigned int order)
> +		       unsigned long pfn, unsigned int order,
> +		       enum kho_page_type type)
>  {
>  	/* Newly allocated nodes for error cleanup */
>  	struct kho_radix_node *intermediate_nodes[KHO_TREE_MAX_DEPTH] = { 0 };
> -	unsigned long key = kho_radix_encode_key(PFN_PHYS(pfn), order);
> +	unsigned long key = kho_radix_encode_key(PFN_PHYS(pfn), order, type);
>  	struct kho_radix_node *anchor_node = NULL;
>  	struct kho_radix_node *node = tree->root;
>  	struct kho_radix_node *new_node;
> @@ -231,15 +247,16 @@ EXPORT_SYMBOL_GPL(kho_radix_add_page);
>   * @tree: The KHO radix tree.
>   * @pfn: The page frame number of the page to unpreserve.
>   * @order: The order of the page.
> + * @type: The page type.
>   *
>   * This function traverses the radix tree and clears the bit corresponding to
>   * the page, effectively removing its "preserved" status. It does not free
>   * the tree's intermediate nodes, even if they become empty.
>   */
>  void kho_radix_del_page(struct kho_radix_tree *tree, unsigned long pfn,
> -			unsigned int order)
> +			unsigned int order, enum kho_page_type type)
>  {
> -	unsigned long key = kho_radix_encode_key(PFN_PHYS(pfn), order);
> +	unsigned long key = kho_radix_encode_key(PFN_PHYS(pfn), order, type);
>  	struct kho_radix_node *node = tree->root;
>  	struct kho_radix_leaf *leaf;
>  	unsigned int i, idx;
> @@ -277,14 +294,15 @@ static int kho_radix_walk_leaf(struct kho_radix_leaf *leaf,
>  			       kho_radix_tree_walk_callback_t cb)
>  {
>  	unsigned long *bitmap = (unsigned long *)leaf;
> +	enum kho_page_type type;
>  	unsigned int order;
>  	phys_addr_t phys;
>  	unsigned int i;
>  	int err;
>  
>  	for_each_set_bit(i, bitmap, PAGE_SIZE * BITS_PER_BYTE) {
> -		phys = kho_radix_decode_key(key | i, &order);
> -		err = cb(phys, order);
> +		phys = kho_radix_decode_key(key | i, &order, &type);
> +		err = cb(phys, order, type);
>  		if (err)
>  			return err;
>  	}
> @@ -485,7 +503,8 @@ static struct page *__init kho_get_preserved_page(phys_addr_t phys,
>  }
>  
>  static int __init kho_preserved_memory_reserve(phys_addr_t phys,
> -					       unsigned int order)
> +					       unsigned int order,
> +					       enum kho_page_type type)
>  {
>  	union kho_page_info info;
>  	struct page *page;
> @@ -499,6 +518,7 @@ static int __init kho_preserved_memory_reserve(phys_addr_t phys,
>  	memblock_reserved_mark_noinit(phys, sz);
>  	info.magic = KHO_PAGE_MAGIC;
>  	info.order = order;
> +	info.type = type;
>  	page->private = info.page_private;
>  
>  	return 0;
> @@ -859,7 +879,7 @@ int kho_preserve_folio(struct folio *folio)
>  	if (WARN_ON(kho_scratch_overlap(pfn << PAGE_SHIFT, PAGE_SIZE << order)))
>  		return -EINVAL;
>  
> -	return kho_radix_add_page(tree, pfn, order);
> +	return kho_radix_add_page(tree, pfn, order, KHO_PAGE_CONTIG);
>  }
>  EXPORT_SYMBOL_GPL(kho_preserve_folio);
>  
> @@ -877,7 +897,7 @@ void kho_unpreserve_folio(struct folio *folio)
>  	const unsigned long pfn = folio_pfn(folio);
>  	const unsigned int order = folio_order(folio);
>  
> -	kho_radix_del_page(tree, pfn, order);
> +	kho_radix_del_page(tree, pfn, order, KHO_PAGE_CONTIG);
>  }
>  EXPORT_SYMBOL_GPL(kho_unpreserve_folio);
>  
> @@ -906,7 +926,7 @@ static void __kho_unpreserve(struct kho_radix_tree *tree,
>  	while (pfn < end_pfn) {
>  		order = __kho_preserve_pages_order(pfn, end_pfn);
>  
> -		kho_radix_del_page(tree, pfn, order);
> +		kho_radix_del_page(tree, pfn, order, KHO_PAGE_CONTIG);

Shouldn't this use _SPLIT to keep the existing semantics?

>  
>  		pfn += 1 << order;
>  	}
> @@ -939,7 +959,7 @@ int kho_preserve_pages(struct page *page, unsigned long nr_pages)
>  	while (pfn < end_pfn) {
>  		unsigned int order = __kho_preserve_pages_order(pfn, end_pfn);
>  
> -		err = kho_radix_add_page(tree, pfn, order);
> +		err = kho_radix_add_page(tree, pfn, order, KHO_PAGE_CONTIG);

Ditto

>  		if (err) {
>  			failed_pfn = pfn;
>  			break;

[1] https://lore.kernel.org/all/20260605183501.3884950-1-pratyush@kernel.org

-- 
Sincerely yours,
Mike.


