Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8300FF885A
	for <kexec@archiver.kernel.org>; Mon,  4 May 2026 14:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jMK9CbMmL+n4tiRm5m3IaX0DcVz+Sz54nDXJZPFiknU=; b=osaooQU/zy4ZEe+Ns5/m56decF
	ucCTmjzzjlR484+ibzI07Xf1HaLFXV9qObaKeDj60i02MYEZQByXeSliq2OHQc1mdui5r+mWOsrxR
	6q00Hpqa+j16GJzZ2rqUY71nRS02C91p/hdoX5bMuEZjPE/k5KUW6sy+yHiQMdVeSQiKk6QbESHNk
	HGQFmhiIWBVKcw3PuXBas3ea75W+/y6XRPdXAoMFwGaX3fez/iGojchGTHMl9FtthqbxKkO9QhF0p
	naX9zVa0i2HeGgmt7M8ukCLjS30PNhKhGGazysy+jE3aGY1+vNZL18mp+3ZMaQxzeDzx+53c7kcGh
	zSH0XMuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJuXW-0000000DUmu-2lLC;
	Mon, 04 May 2026 14:44:54 +0000
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJuXT-0000000DUka-1VII
	for kexec@lists.infradead.org;
	Mon, 04 May 2026 14:44:54 +0000
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-5102582e237so32912211cf.2
        for <kexec@lists.infradead.org>; Mon, 04 May 2026 07:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1777905890; x=1778510690; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jMK9CbMmL+n4tiRm5m3IaX0DcVz+Sz54nDXJZPFiknU=;
        b=K8Nc/xrSyWtl53yh4Ui02qTGRZopImO+EX7Rhl1vc98FoULFzqdqmgF6pNUE9BVeDg
         JokZywyp6vfEIQKKeH14MeFbCjz5TwTxfS8P7UtFiySYmYQc5zU7gfMuKfEUD4lUyDvb
         6u8qq4GmbE7cfH4/t2dud7vqPrd6xXntqsuX1U9lDT5dlPRz402UwSDT803RTBXeswmK
         xzWNBhp2Jv3fvAKZDymjVuO93mgxwVlqN0uguejVJqgqmQj9dH8LoLET7cWadOv2yCH3
         r/ynizV6ZPn4xsJFEzJ49O55farOVkUj6pJRU7ZeoCOu3o1al+0WJVSzkTs72471V15M
         OXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777905890; x=1778510690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jMK9CbMmL+n4tiRm5m3IaX0DcVz+Sz54nDXJZPFiknU=;
        b=dA3UnZIrKnx5QULX2qTn1IVg+33mOXy292oGN5GdP8ItvDJTVPb/Z2e+pT5IAlRjcx
         8ee6PsWBDEqGYueF6p7Il0Yyz5llV8YwuIFaOy6HkyQ8vvox4dx2EgVZXMh6PxLPxZaA
         7OuluNfTfMq9tr3j+OuFDGAScAbIhGzPlClGUEgtODkjpViG4QIvfyotWPQb6S8fD1zL
         45EmvBNEEQTmbUk8VxIrDbC1O4Q3uZmic9KVuLNHTSxVzime7stbLkUkTX/z4RH2HS8C
         2ma6EgROqF5v+LfNDW4+waoeyGTHVsYPnB7tMHY/jOR9WL3DKMsuwCvNUQ6NCXXVwQlO
         rzHQ==
X-Forwarded-Encrypted: i=1; AFNElJ93cwDZNhAQqv5+LxSNTPRMXqDZlv0+zXHalAcuCeAgVvHOSirO51cTKH4IYsj7k3WvezPoLg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyI0atNJlEsL6ekwWk7KlsO32rEfsidOk3glVbLpbPkI8L2Sqh4
	uG0fVtTaL+8sxG1BsLWcFyjb91zTtvgVj0flHC3c6EGdLavgrs5JL9j8BYtMdvRBPsQ=
X-Gm-Gg: AeBDiesgw34X+qRa9vPUt9WBeP5zi0t0g6mX8V6+Z9AhQysi6ruWYQ5OqMh3wyao7G3
	qyTkMixWLua5so+W4H4swcWmdE5wePqc/pQz0w3MdsbMSxcqXxzvq6EidnakBrM8MFXE2vAPIYA
	gEAk6A2OkxGnnx7cNJIEL2JTA+4w8UBHdmAnF7s1LbXEp256Q2BBw1abO9GnOq/qgJNneTLHEP9
	2LwicfgKxi4MkWlVjkxIoq7k9eXpYopmmo0dQnZWZinqbjWmWiAGIQkUIytwhxlvHBLJBjt3smV
	PDeh6MDZOY8e/9zcZJvi8ExAV/vVOCTzl0y8/g9L+TjZmv7yvYw5840tcuMcAcChScpaG1ufsca
	DsTcGdNgWayCuiD+iHX6ACeNt8nDwiTuorFBEp36pr7qZSOvksM63ICD1WXdv8zpBnmVTLdndi9
	WSSXzSZl0wMbKaEWvhHMnRMQRjuoIH/pEZTyFBNxSosfwHNYBATuInDUwymuD+5Q==
X-Received: by 2002:a05:622a:4206:b0:50d:6a40:692a with SMTP id d75a77b69052e-5104be7625cmr148834121cf.18.1777905889904;
        Mon, 04 May 2026 07:44:49 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51040ba8acdsm100582571cf.31.2026.05.04.07.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 07:44:49 -0700 (PDT)
Date: Mon, 4 May 2026 14:44:48 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Alexander Graf <graf@amazon.com>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Jason Miu <jasonmiu@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] kho: generalize radix tree APIs
Message-ID: <afiwy31X4WANSk1q@plex>
References: <20260429133928.850721-1-pratyush@kernel.org>
 <20260429133928.850721-2-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429133928.850721-2-pratyush@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260504_074451_468007_948E635B 
X-CRM114-Status: GOOD (  43.30  )
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

On 04-29 15:39, Pratyush Yadav wrote:
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> 
> The KHO radix tree is a data structure that can track the presence or
> absence of an arbitrary key, with nothing inherently tied to KHO memory
> preservation tracking. This was one of the design goals of the radix
> tree. This was done to enable it to be re-used by other users of KHO.
> 
> Despite that, the radix tree APIs are very closely tied to KHO memory
> preservation tracking. Adding a key is done by kho_radix_add_page(),
> which encodes it as a page tracking operation and takes in PFN and
> order. kho_radix_del_page() does the same. These functions encode the
> key internally that goes into the radix tree. kho_radix_walk_tree() does
> the same by baking the PFN and order into the callback arguments.
> 
> Generalize the APIs by taking the key directly and doing the encoding at
> the callers. Rename the functions to kho_radix_add_key() and
> kho_radix_del_key(). In practice, this removes a line each from the
> functions and moves the encoding function call to the callers.
> Similarly, update kho_radix_tree_walk_callback_t to take the key
> directly.
> 
> To keep the naming convention clearer, rename
> kho_radix_{encode,decode}_key() to kho_{encode,decode}_radix_key().
> 
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com> 

> ---
>  include/linux/kho_radix_tree.h     | 18 +++----
>  kernel/liveupdate/kexec_handover.c | 76 ++++++++++++++----------------
>  2 files changed, 42 insertions(+), 52 deletions(-)
> 
> diff --git a/include/linux/kho_radix_tree.h b/include/linux/kho_radix_tree.h
> index 84e918b96e53..f368f3b9f923 100644
> --- a/include/linux/kho_radix_tree.h
> +++ b/include/linux/kho_radix_tree.h
> @@ -34,30 +34,24 @@ struct kho_radix_tree {
>  	struct mutex lock; /* protects the tree's structure and root pointer */
>  };
>  
> -typedef int (*kho_radix_tree_walk_callback_t)(phys_addr_t phys,
> -					      unsigned int order);
> +typedef int (*kho_radix_tree_walk_callback_t)(unsigned long key);
>  
>  #ifdef CONFIG_KEXEC_HANDOVER
>  
> -int kho_radix_add_page(struct kho_radix_tree *tree, unsigned long pfn,
> -		       unsigned int order);
> -
> -void kho_radix_del_page(struct kho_radix_tree *tree, unsigned long pfn,
> -			unsigned int order);
> -
> +int kho_radix_add_key(struct kho_radix_tree *tree, unsigned long key);
> +void kho_radix_del_key(struct kho_radix_tree *tree, unsigned long key);
>  int kho_radix_walk_tree(struct kho_radix_tree *tree,
>  			kho_radix_tree_walk_callback_t cb);
>  
>  #else  /* #ifdef CONFIG_KEXEC_HANDOVER */
>  
> -static inline int kho_radix_add_page(struct kho_radix_tree *tree, long pfn,
> -				     unsigned int order)
> +static inline int kho_radix_add_key(struct kho_radix_tree *tree, unsigned long key)
>  {
>  	return -EOPNOTSUPP;
>  }
>  
> -static inline void kho_radix_del_page(struct kho_radix_tree *tree,
> -				      unsigned long pfn, unsigned int order) { }
> +static inline void kho_radix_del_key(struct kho_radix_tree *tree,
> +				     unsigned long key) { }
>  
>  static inline int kho_radix_walk_tree(struct kho_radix_tree *tree,
>  				      kho_radix_tree_walk_callback_t cb)
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 33fcf848ef95..ba568d34c5b4 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -85,7 +85,7 @@ static struct kho_out kho_out = {
>  };
>  
>  /**
> - * kho_radix_encode_key - Encodes a physical address and order into a radix key.
> + * kho_encode_radix_key - Encodes a physical address and order into a radix key.
>   * @phys: The physical address of the page.
>   * @order: The order of the page.
>   *
> @@ -95,7 +95,7 @@ static struct kho_out kho_out = {
>   *
>   * Return: The encoded unsigned long radix key.
>   */
> -static unsigned long kho_radix_encode_key(phys_addr_t phys, unsigned int order)
> +static unsigned long kho_encode_radix_key(phys_addr_t phys, unsigned int order)
>  {
>  	/* Order bits part */
>  	unsigned long h = 1UL << (KHO_ORDER_0_LOG2 - order);
> @@ -106,17 +106,17 @@ static unsigned long kho_radix_encode_key(phys_addr_t phys, unsigned int order)
>  }
>  
>  /**
> - * kho_radix_decode_key - Decodes a radix key back into a physical address and order.
> + * kho_decode_radix_key - Decodes a radix key back into a physical address and order.
>   * @key: The unsigned long key to decode.
>   * @order: An output parameter, a pointer to an unsigned int where the decoded
>   *         page order will be stored.
>   *
> - * This function reverses the encoding performed by kho_radix_encode_key(),
> + * This function reverses the encoding performed by kho_encode_radix_key(),
>   * extracting the original physical address and page order from a given key.
>   *
>   * Return: The decoded physical address.
>   */
> -static phys_addr_t kho_radix_decode_key(unsigned long key, unsigned int *order)
> +static phys_addr_t kho_decode_radix_key(unsigned long key, unsigned int *order)
>  {
>  	unsigned int order_bit = fls64(key);
>  	phys_addr_t phys;
> @@ -144,24 +144,21 @@ static unsigned long kho_radix_get_table_index(unsigned long key,
>  }
>  
>  /**
> - * kho_radix_add_page - Marks a page as preserved in the radix tree.
> + * kho_radix_add_key - Add a key to the radix tree.
>   * @tree: The KHO radix tree.
> - * @pfn: The page frame number of the page to preserve.
> - * @order: The order of the page.
> + * @key: The key to add.
>   *
> - * This function traverses the radix tree based on the key derived from @pfn
> - * and @order. It sets the corresponding bit in the leaf bitmap to mark the
> - * page for preservation. If intermediate nodes do not exist along the path,
> - * they are allocated and added to the tree.
> + * This function traverses the radix tree based on the key provided. It sets the
> + * corresponding bit in the leaf bitmap to mark the key as present. If
> + * intermediate nodes do not exist along the path, they are allocated and added
> + * to the tree.
>   *
>   * Return: 0 on success, or a negative error code on failure.
>   */
> -int kho_radix_add_page(struct kho_radix_tree *tree,
> -		       unsigned long pfn, unsigned int order)
> +int kho_radix_add_key(struct kho_radix_tree *tree, unsigned long key)
>  {
>  	/* Newly allocated nodes for error cleanup */
>  	struct kho_radix_node *intermediate_nodes[KHO_TREE_MAX_DEPTH] = { 0 };
> -	unsigned long key = kho_radix_encode_key(PFN_PHYS(pfn), order);
>  	struct kho_radix_node *anchor_node = NULL;
>  	struct kho_radix_node *node = tree->root;
>  	struct kho_radix_node *new_node;
> @@ -224,22 +221,19 @@ int kho_radix_add_page(struct kho_radix_tree *tree,
>  
>  	return err;
>  }
> -EXPORT_SYMBOL_GPL(kho_radix_add_page);
> +EXPORT_SYMBOL_GPL(kho_radix_add_key);
>  
>  /**
> - * kho_radix_del_page - Removes a page's preservation status from the radix tree.
> + * kho_radix_del_key - Removes the key from the radix tree.
>   * @tree: The KHO radix tree.
> - * @pfn: The page frame number of the page to unpreserve.
> - * @order: The order of the page.
> + * @key: The key to remove.
>   *
>   * This function traverses the radix tree and clears the bit corresponding to
> - * the page, effectively removing its "preserved" status. It does not free
> - * the tree's intermediate nodes, even if they become empty.
> + * the key, effectively removing it from the tree. It does not free the tree's
> + * intermediate nodes, even if they become empty.
>   */
> -void kho_radix_del_page(struct kho_radix_tree *tree, unsigned long pfn,
> -			unsigned int order)
> +void kho_radix_del_key(struct kho_radix_tree *tree, unsigned long key)
>  {
> -	unsigned long key = kho_radix_encode_key(PFN_PHYS(pfn), order);
>  	struct kho_radix_node *node = tree->root;
>  	struct kho_radix_leaf *leaf;
>  	unsigned int i, idx;
> @@ -270,21 +264,18 @@ void kho_radix_del_page(struct kho_radix_tree *tree, unsigned long pfn,
>  	idx = kho_radix_get_bitmap_index(key);
>  	__clear_bit(idx, leaf->bitmap);
>  }
> -EXPORT_SYMBOL_GPL(kho_radix_del_page);
> +EXPORT_SYMBOL_GPL(kho_radix_del_key);
>  
>  static int kho_radix_walk_leaf(struct kho_radix_leaf *leaf,
>  			       unsigned long key,
>  			       kho_radix_tree_walk_callback_t cb)
>  {
>  	unsigned long *bitmap = (unsigned long *)leaf;
> -	unsigned int order;
> -	phys_addr_t phys;
>  	unsigned int i;
>  	int err;
>  
>  	for_each_set_bit(i, bitmap, PAGE_SIZE * BITS_PER_BYTE) {
> -		phys = kho_radix_decode_key(key | i, &order);
> -		err = cb(phys, order);
> +		err = cb(key | i);
>  		if (err)
>  			return err;
>  	}
> @@ -332,15 +323,14 @@ static int __kho_radix_walk_tree(struct kho_radix_node *root,
>  }
>  
>  /**
> - * kho_radix_walk_tree - Traverses the radix tree and calls a callback for each preserved page.
> + * kho_radix_walk_tree - Traverses the radix tree and calls a callback for each key.
>   * @tree: A pointer to the KHO radix tree to walk.
>   * @cb: A callback function of type kho_radix_tree_walk_callback_t that will be
> - *      invoked for each preserved page found in the tree. The callback receives
> - *      the physical address and order of the preserved page.
> + *      invoked for each key in the tree.
>   *
>   * This function walks the radix tree, searching from the specified top level
> - * down to the lowest level (level 0). For each preserved page found, it invokes
> - * the provided callback, passing the page's physical address and order.
> + * down to the lowest level (level 0). For each key found, it invokes the
> + * provided callback.
>   *
>   * Return: 0 if the walk completed the specified tree, or the non-zero return
>   *         value from the callback that stopped the walk.
> @@ -365,7 +355,8 @@ static void __kho_unpreserve(struct kho_radix_tree *tree,
>  	while (pfn < end_pfn) {
>  		order = min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
>  
> -		kho_radix_del_page(tree, pfn, order);
> +		kho_radix_del_key(tree, kho_encode_radix_key(PFN_PHYS(pfn),
> +							     order));
>  
>  		pfn += 1 << order;
>  	}
> @@ -498,13 +489,16 @@ static struct page *__init kho_get_preserved_page(phys_addr_t phys,
>  	return pfn_to_page(pfn);
>  }
>  
> -static int __init kho_preserved_memory_reserve(phys_addr_t phys,
> -					       unsigned int order)
> +static int __init kho_preserved_memory_reserve(unsigned long key)
>  {
>  	union kho_page_info info;
>  	struct page *page;
> +	unsigned int order;
> +	phys_addr_t phys;
>  	u64 sz;
>  
> +	phys = kho_decode_radix_key(key, &order);
> +
>  	sz = 1 << (order + PAGE_SHIFT);
>  	page = kho_get_preserved_page(phys, order);
>  
> @@ -858,7 +852,8 @@ int kho_preserve_folio(struct folio *folio)
>  	if (WARN_ON(kho_scratch_overlap(pfn << PAGE_SHIFT, PAGE_SIZE << order)))
>  		return -EINVAL;
>  
> -	return kho_radix_add_page(tree, pfn, order);
> +	return kho_radix_add_key(tree, kho_encode_radix_key(PFN_PHYS(pfn),
> +							    order));
>  }
>  EXPORT_SYMBOL_GPL(kho_preserve_folio);
>  
> @@ -876,7 +871,7 @@ void kho_unpreserve_folio(struct folio *folio)
>  	const unsigned long pfn = folio_pfn(folio);
>  	const unsigned int order = folio_order(folio);
>  
> -	kho_radix_del_page(tree, pfn, order);
> +	kho_radix_del_key(tree, kho_encode_radix_key(PFN_PHYS(pfn), order));
>  }
>  EXPORT_SYMBOL_GPL(kho_unpreserve_folio);
>  
> @@ -916,7 +911,8 @@ int kho_preserve_pages(struct page *page, unsigned long nr_pages)
>  		while (pfn_to_nid(pfn) != pfn_to_nid(pfn + (1UL << order) - 1))
>  			order--;
>  
> -		err = kho_radix_add_page(tree, pfn, order);
> +		err = kho_radix_add_key(tree, kho_encode_radix_key(PFN_PHYS(pfn),
> +								   order));
>  		if (err) {
>  			failed_pfn = pfn;
>  			break;
> -- 
> 2.54.0.545.g6539524ca2-goog
> 

