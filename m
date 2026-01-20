Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B38CA5FCC
	for <kexec@archiver.kernel.org>; Tue, 20 Jan 2026 17:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MfhT75hO3NZBcebmZbN8NiQlhZEwXQzjYMHe6XNmZFw=; b=1qRWt8i7gpD1VkhdBY5xW6uMvM
	1iu5Fo7OX473LFkVb0vivRlNycR0olha/ntjKSWGIrHpV0P9AaSboWKWDvL2hLjia8SuxrsXRoF3t
	iLfAtDS8g2vK4IMcdta2so9bEnmUt6R8BJltlflG92q5Zmuf+7ZzKFNiEtjxwWEwl4XFxeRsGeVfd
	UU8tj5WuBRvndM3+h1IqAZVzYY8dssLrB3bnvdvYzdu67yevU2tOCnrvhrefwQ3S37mO81TZpwzPH
	T1Hij8CeeTuUKFiIo27phOyZ2ZF8e9hlYSf+QpAKrG8mbUiUHBMEXzTsmSIWH1ssQo3WeWlPtNYvP
	hkdvTwMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viFzB-00000004GrW-26vC;
	Tue, 20 Jan 2026 17:57:49 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viFz7-00000004Gr6-3pGp
	for kexec@lists.infradead.org;
	Tue, 20 Jan 2026 17:57:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 25B5A40485;
	Tue, 20 Jan 2026 17:57:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2854AC16AAE;
	Tue, 20 Jan 2026 17:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768931865;
	bh=YpDjEfkNyumQSj2vKApRnaV2QIrJCawbl/fbFRLhjvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DTUy1n4wndhSupFBOffwXqXmKNwnFwm/n+eeE46Wo+yZ8Kbn2dJr3RrCfkJuRWYi/
	 pEHCFCX6KfjgiR7YTg55Y0w26XvYnbzdmQ94nheoUD3Kp+DA5I427bvu4Dk3tGOsUn
	 ymc/ptSYMFWjtFx5aIi7DLYfY3fuz83zrASsBzH9QHnR1znbtpSM8rSIeFQoa+U8c0
	 Xt1gRRlJnxqNG7BwFNHUSTbSa5xRLwgIiIkmucPHpBhQj5ruBcA8VnCSzRk9Pyhdyz
	 rNEAOf8tvwk9N5fkvY0MFf2b/hK2DSkRxLX0vEazp4um7ulfj2fG40UWaMrSnbdPhy
	 P0jdxOzuBkSSg==
Date: Tue, 20 Jan 2026 19:57:37 +0200
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
Subject: Re: [PATCH v7 1/2] kho: Adopt radix tree for preserved memory
 tracking
Message-ID: <aW_CEV-Qqrj2dvEb@kernel.org>
References: <20260116034432.1520731-1-jasonmiu@google.com>
 <20260116034432.1520731-2-jasonmiu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116034432.1520731-2-jasonmiu@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260120_095746_020290_3C6FCC26 
X-CRM114-Status: GOOD (  33.14  )
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

Hi Jason,

On Thu, Jan 15, 2026 at 07:44:31PM -0800, Jason Miu wrote:
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

...

> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 49bf2cecab12..06adaf56cd69 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -5,6 +5,7 @@
>   * Copyright (C) 2025 Microsoft Corporation, Mike Rapoport <rppt@kernel.org>
>   * Copyright (C) 2025 Google LLC, Changyuan Lyu <changyuanl@google.com>
>   * Copyright (C) 2025 Pasha Tatashin <pasha.tatashin@soleen.com>
> + * Copyright (C) 2025 Google LLC, Jason Miu <jasonmiu@google.com>

It's already 2026 ;-)

>   */
>  
>  #define pr_fmt(fmt) "KHO: " fmt

...

> +int kho_radix_add_page(struct kho_radix_tree *tree,
> +		       unsigned long pfn, unsigned int order)
> +{
> +	/* Newly allocated nodes for error cleanup */
> +	struct kho_radix_node *intermediate_nodes[KHO_TREE_MAX_DEPTH] = { 0 };
> +	unsigned long key = kho_radix_encode_key(PFN_PHYS(pfn), order);
> +	struct kho_radix_node *new_node, *anchor_node;
> +	struct kho_radix_node *node = tree->root;
> +	unsigned int i, idx, anchor_idx;
> +	struct kho_radix_leaf *leaf;
> +	int err = 0;
> +
> +	if (WARN_ON_ONCE(!tree->root))
> +		return -EINVAL;
> +
> +	might_sleep();
> +
> +	guard(mutex)(&tree->lock);
> +
> +	/* Go from high levels to low levels */
> +	for (i = KHO_TREE_MAX_DEPTH - 1; i > 0; i--) {
> +		idx = kho_radix_get_table_index(key, i);
> +
> +		if (node->table[idx]) {
> +			node = phys_to_virt(node->table[idx]);
> +			continue;
> +		}
> +
> +		/* Next node is empty, create a new node for it */
> +		new_node = (struct kho_radix_node *)get_zeroed_page(GFP_KERNEL);
> +		if (!new_node) {
> +			err = -ENOMEM;
> +			goto err_free_nodes;
> +		}
> +
> +		node->table[idx] = virt_to_phys(new_node);
> +
> +		/*
> +		 * Capture the node where the new branch starts for cleanup
> +		 * if allocation fails.
> +		 */
> +		if (!anchor_node) {

I think anchor_node should be initialized to NULL for this to work.

> +			anchor_node = node;
> +			anchor_idx = idx;
> +		}
> +		intermediate_nodes[i] = new_node;
> +
> +		node = new_node;
> +	}
> +
> +	/* Handle the leaf level bitmap (level 0) */
> +	idx = kho_radix_get_bitmap_index(key);
> +	leaf = (struct kho_radix_leaf *)node;
> +	__set_bit(idx, leaf->bitmap);
> +
> +	return 0;
> +
> +err_free_nodes:
> +	for (i = KHO_TREE_MAX_DEPTH - 1; i > 0; i--) {
> +		if (intermediate_nodes[i])
> +			free_page((unsigned long)intermediate_nodes[i]);
> +	}
> +	if (anchor_node)
> +		anchor_node->table[anchor_idx] = 0;
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(kho_radix_add_page);

...

> +		if (WARN_ON(!node->table[idx]))
> +			return;
> +
> +		node = phys_to_virt((phys_addr_t)node->table[idx]);

No need for casting.

> +		shift = ((level - 1) * KHO_TABLE_SIZE_LOG2) +
> +			KHO_BITMAP_SIZE_LOG2;
> +		key = start | (i << shift);
> +
> +		node = phys_to_virt((phys_addr_t)root->table[i]);

Ditto.

> @@ -1466,12 +1489,6 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
>  		goto out;
>  	}
>  
> -	mem_map_phys = kho_get_mem_map_phys(fdt);
> -	if (!mem_map_phys) {
> -		err = -ENOENT;
> -		goto out;
> -	}

I think we should keep the logic that skips scratch initialization if there
were no memory preservations, like Pasha implemented here:
https://lkml.kernel.org/r/20251223140140.2090337-1-pasha.tatashin@soleen.com
(commit e1c3bfd091f3 ("kho: validate preserved memory map during
population") in today's mm tree)

We just should update the validation to work with the radix tree.

>  	scratch = early_memremap(scratch_phys, scratch_len);
>  	if (!scratch) {
>  		pr_warn("setup: failed to memremap scratch (phys=0x%llx, len=%lld)\n",
> @@ -1512,7 +1529,6 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
>  
>  	kho_in.fdt_phys = fdt_phys;
>  	kho_in.scratch_phys = scratch_phys;
> -	kho_in.mem_map_phys = mem_map_phys;
>  	kho_scratch_cnt = scratch_cnt;
>  	pr_info("found kexec handover data.\n");
>  
> -- 
> 2.52.0.457.g6b5491de43-goog
> 

-- 
Sincerely yours,
Mike.

