Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B53EFE87846
	for <kexec@archiver.kernel.org>; Tue,  3 Feb 2026 16:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+6iEfAwVowudD9440Eytyn2K8CBL+yodt/SON0xQjqw=; b=ePJgRV2eVK3b8E13aDerIKY8Cb
	CuX7erG7QroXjwV+hZJJTvd2sKRg+1t1PrZVpJSjyPwW5kHFnLWHKIcShdLuNTwJv+leQ4mI043dH
	1VqgmaEOcQR52c71x16u3mY2a5aHa5e27EV+O4i9qwhS8heHu5vBE5VIkAHlAuIwwYAG3OC2XrrQh
	nL3hyWo8T+4zP69XA0IGRuJyhdAV+bQ9lYFjGC9HHgOMlPjhiK0MsvJSRqyQwZsbwEXmhO0TnWt/3
	IocH98Vu7IdkAJekqDXxObiJX+rh54DRLkJLA1NVywD+3Jj7pj7gtwIL5VVC4bOfQN3iu/d0YktZ0
	D2SqmUgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnJ4e-00000006tw5-2EJt;
	Tue, 03 Feb 2026 16:16:20 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnJ4Z-00000006ttT-062D
	for kexec@lists.infradead.org;
	Tue, 03 Feb 2026 16:16:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C72A14151B;
	Tue,  3 Feb 2026 16:16:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B490BC116D0;
	Tue,  3 Feb 2026 16:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770135373;
	bh=Lggy4kALKLaV7O6fLdE4+3yPKrZNAb1hhE+tXBQafR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hXLLC34Hyic6hTVqbQvX+x8C9ERdyKtNKrY6+MNR9b06xzRBHCvSqNkCZ7xinvGIP
	 7Hd3ieYzcbZvn2/LrBLyPiqnUxRcPP2niRSceJ/CsiaFC+sBVRcJgy71mcNUfrJEWD
	 ybgZiWVweo9yd1pBfJaBZ3YTCNSAcqh6faYgv8maTRlfDqe+QH35iazzaOFGhxOxDY
	 uR2PZJ6ZMlTK5ICJd2Zu+dP+hlT1PXeym14O7DAZlWFUSDhWxCRazeE/YpgthdUkEr
	 iIW/x2hf4lsc9tNn5ZWyX8aZr7ZTTFzRRpyGBAmYJTy/7AMBs52RKuFtbp4DMymukR
	 6ml1F17rWEwRA==
Date: Tue, 3 Feb 2026 18:16:05 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Jason Miu <jasonmiu@google.com>
Cc: Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>,
	David Matlack <dmatlack@google.com>,
	David Rientjes <rientjes@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v8 1/2] kho: Adopt radix tree for preserved memory
 tracking
Message-ID: <aYIfRa5fDBaLVR5y@kernel.org>
References: <20260130005739.3163049-1-jasonmiu@google.com>
 <20260130005739.3163049-2-jasonmiu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130005739.3163049-2-jasonmiu@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260203_081615_218305_F00FF7B9 
X-CRM114-Status: GOOD (  30.34  )
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

On Thu, Jan 29, 2026 at 04:57:38PM -0800, Jason Miu wrote:
> Introduce a radix tree implementation for tracking preserved memory
> pages and switch the KHO memory tracking mechanism to use it. This
> lays the groundwork for a stateless KHO implementation that eliminates
> the need for serialization and the associated "finalize" state.
> 
> This patch introduces the core radix tree data structures and
> constants to the KHO ABI. It adds the radix tree node and leaf
> structures, along with documentation for the radix tree key encoding
> scheme that combines a page's physical address and order.
> 
> To support broader use by other kernel subsystems, such as hugetlb
> preservation, the core radix tree manipulation functions are exported
> as a public API.
> 
> The xarray-based memory tracking is replaced with this new radix tree
> implementation. The core KHO preservation and unpreservation functions
> are wired up to use the radix tree helpers. On boot, the second kernel
> restores the preserved memory map by walking the radix tree whose root
> physical address is passed via the FDT.
> 
> The ABI `compatible` version is bumped to "kho-v2" to reflect the
> structural changes in the preserved memory map and sub-FDT property
> names. This includes renaming "fdt" to "preserved-data" to better
> reflect that preserved state may use formats other than FDT.
> 
> Signed-off-by: Jason Miu <jasonmiu@google.com>

With minor comments below

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
...

> +static int __kho_radix_walk_tree(struct kho_radix_node *root,
> +				 unsigned int level, unsigned long start,
> +				 kho_radix_tree_walk_callback_t cb)
> +{
> +	struct kho_radix_node *node;
> +	struct kho_radix_leaf *leaf;
> +	unsigned long key, i;
> +	unsigned int shift;
> +	int err;
> +
> +	for (i = 0; i < PAGE_SIZE / sizeof(phys_addr_t); i++) {
> +		if (!root->table[i])
> +			continue;
> +
> +		shift = ((level - 1) * KHO_TABLE_SIZE_LOG2) +
> +			KHO_BITMAP_SIZE_LOG2;
> +		key = start | (i << shift);
> +
> +		node = phys_to_virt(root->table[i]);
> +
> +		if (level == 1) {
> +			/*
> +			 * we are at level 1,
> +			 * node is pointing to the level 0 bitmap.
> +			 */
> +			leaf = (struct kho_radix_leaf *)node;
> +			err = kho_radix_walk_leaf(leaf, key, cb);
> +			if (err)
> +				return err;
> +		} else {
> +			err  = __kho_radix_walk_tree(node, level - 1,
> +						     key, cb);
> +			if (err)
> +				return err;

Nit: if (err) can be moved outside if (level == 1)

> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * kho_radix_walk_tree - Traverses the radix tree and calls a callback for each preserved page.
> + * @tree: A pointer to the KHO radix tree to walk.
> + * @cb: A callback function of type kho_radix_tree_walk_callback_t that will be
> + *      invoked for each preserved page found in the tree. The callback receives
> + *      the physical address and order of the preserved page.
> + *
> + * This function walks the radix tree, searching from the specified top level
> + * (@level) down to the lowest level (level 0). For each preserved page found,

Hmm, why do we need @level here? 
Or it rather remained from the older versions?

> + * it invokes the provided callback, passing the page's physical address and
> + * order.
> + *
> + * Return: 0 if the walk completed the specified tree, or the non-zero return
> + *         value from the callback that stopped the walk.
> + */
> +int kho_radix_walk_tree(struct kho_radix_tree *tree,
> +			kho_radix_tree_walk_callback_t cb)
> +{
> +	if (WARN_ON_ONCE(!tree->root))
> +		return -EINVAL;
> +
> +	guard(mutex)(&tree->lock);
> +
> +	return __kho_radix_walk_tree(tree->root, KHO_TREE_MAX_DEPTH - 1, 0, cb);
> +}
> +EXPORT_SYMBOL_GPL(kho_radix_walk_tree);

-- 
Sincerely yours,
Mike.

