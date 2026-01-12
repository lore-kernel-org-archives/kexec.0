Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6572D232D7
	for <kexec@archiver.kernel.org>; Mon, 12 Jan 2026 10:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HzjYZYBHySAp9w9krJyhV6EXGC4z6s9fB+/3IJ2l66o=; b=IfoGSW9hRXOzcpDWaZuttQIfYS
	3pUENNogArFJrsgSa7jwntVAlht54s/9I/YOwrmF+phPZJCxs01WuJoU/HhN+1/2G2HdEbcsQ+OE9
	P7bFj9AS2uaVB88en72PTomplFNzL6zoQsV+fCz9+onIrqLZe6Z8H4yY9MNW0H1eGQOuqmQwK9BJv
	+S2B09aOqvpwj6+iyz6fzfYveeJj7zKGx1L3Ik5HQsM8vP/lWD66+ADCO4CdknJinualbhjj+mABV
	QYQ0hl58ijSwfDuyoNXSbIfraQhqDbhbtIRTz0B7PDw0iCPvhww4gI+k4ItK918iDnTG3oFCkFgXV
	pZVyypLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfExw-000000058DM-1uSa;
	Mon, 12 Jan 2026 10:16:04 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfExv-000000058DG-3y8e
	for kexec@lists.infradead.org;
	Mon, 12 Jan 2026 10:16:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id EE7B96001D;
	Mon, 12 Jan 2026 10:16:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41188C16AAE;
	Mon, 12 Jan 2026 10:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768212962;
	bh=5H8Asd6ECAeeCJMDcewHAKiYsD49AUcZV+2Vmxk0dfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A9LIXXYOyBQsscRZFafNFyXooBQgSq4XZd7U7HXgnan2DSrMZ3pyXjYwiOKlxvwEC
	 DBUxb09K6BkF2mgUIEyK0lbalmnkWypZJUxB32+cvlWlX6cyEpgS7GQDcon8zhG1Rw
	 aGLFUnQk3RUJKc8SkcC///AjvbrwkBr6jK6Ptty7ME34hBEB7+f7Pq5Irumn6+kDbJ
	 hazFwNrxKY4O82MHYOpaHC0+MXQtM9Y7aiNnnCCg3ohYaIDzMG0k7G8OW0pnP2bxIs
	 HGmfMrOdFYNXtzXrocGp0j3fP2POj8jb0S7t+TyusxY/SuA5sUHWDw2LxZJzwy11N3
	 z4XyrOZ9eYVOg==
Date: Mon, 12 Jan 2026 12:15:54 +0200
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
Subject: Re: [PATCH v4 1/2] kho: Adopt radix tree for preserved memory
 tracking
Message-ID: <aWTJ2v9J-Aa6ykBf@kernel.org>
References: <20260109001127.2596222-1-jasonmiu@google.com>
 <20260109001127.2596222-2-jasonmiu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109001127.2596222-2-jasonmiu@google.com>
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

On Thu, Jan 08, 2026 at 04:11:26PM -0800, Jason Miu wrote:
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
> ---
>  Documentation/core-api/kho/abi.rst     |   6 +
>  Documentation/core-api/kho/index.rst   |  16 +
>  include/linux/kho/abi/kexec_handover.h | 141 ++++-
>  include/linux/kho_radix_tree.h         |  72 +++
>  kernel/liveupdate/kexec_handover.c     | 722 +++++++++++++------------
>  5 files changed, 583 insertions(+), 374 deletions(-)
>  create mode 100644 include/linux/kho_radix_tree.h
 
...

> +/**
> + * DOC: KHO persistent memory tracker
> + *
> + * KHO tracks preserved memory using a radix tree data structure. Each node of
> + * the tree is exactly a single page. The leaf nodes are bitmaps where each set
> + * bit is a preserved page of any order. The intermediate nodes are tables of
> + * physical addresses that point to a lower level node.
> + *
> + * The tree hierarchy is shown below::
> + *
> + *   root
> + *   +-------------------+
> + *   |     Level 5       | (struct kho_radix_node)
> + *   +-------------------+
> + *     |
> + *     v
> + *   +-------------------+
> + *   |     Level 4       | (struct kho_radix_node)
> + *   +-------------------+
> + *     |
> + *     | ... (intermediate levels)
> + *     |
> + *     v
> + *   +-------------------+
> + *   |      Level 0      | (struct kho_radix_leaf)
> + *   +-------------------+
> + *
> + * The tree is traversed using a key that encodes the page's physical address
> + * (pa) and its order into a single unsigned long value. The encoded key value
> + * is composed of two parts: the 'order bit' in the upper part and the 'page
> + * offset' in the lower part.::
> + *
> + *   +------------+-----------------------------+--------------------------+
> + *   | Page Order | Order Bit                   | Page Offset              |
> + *   +------------+-----------------------------+--------------------------+
> + *   | 0          | ...000100 ... (at bit 52)   | pa >> (PAGE_SHIFT + 0)   |
> + *   | 1          | ...000010 ... (at bit 51)   | pa >> (PAGE_SHIFT + 1)   |
> + *   | 2          | ...000001 ... (at bit 50)   | pa >> (PAGE_SHIFT + 2)   |
> + *   | ...        | ...                         | ...                      |
> + *   +------------+-----------------------------+--------------------------+
> + *
> + * Page Offset:

To me "page offset" reads as offset from somewhere and here it's rather pfn
on steroids :) 
Also in many places in the kernel "page offset" refers to the offset inside a
page.

Can't say I can think of a better name, but it feels that it should express
that this is an address more explicitly.

> + * The 'page offset' is the physical address normalized for its order. It
> + * effectively represents the page offset for the given order.
> + *
> + * Order Bit:
> + * The 'order bit' encodes the page order by setting a single bit at a
> + * specific position. The position of this bit itself represents the order.
> + *
> + * For instance, on a 64-bit system with 4KB pages (PAGE_SHIFT = 12), the
> + * maximum range for a page offset (for order 0) is 52 bits (64 - 12). This
> + * offset occupies bits [0-51]. For order 0, the order bit is set at
> + * position 52.
> + *
> + * The following diagram illustrates how the encoded key value is split into
> + * indices for the tree levels, with PAGE_SIZE of 4KB::
> + *
> + *        63:60   59:51    50:42    41:33    32:24    23:15         14:0
> + *   +---------+--------+--------+--------+--------+--------+-----------------+
> + *   |    0    |  Lv 5  |  Lv 4  |  Lv 3  |  Lv 2  |  Lv 1  |  Lv 0 (bitmap)  |
> + *   +---------+--------+--------+--------+--------+--------+-----------------+
> + *
> + * The radix tree stores pages of all sizes (orders) in a single 6-level

"sizes" can be misleading here because "all sizes" can mean non power-of-2
sizes as well. I'd just use "pages of all orders".

> + * hierarchy. It efficiently shares lower table levels, especially due to

Don't we share the higher levels? Also using "tree" instead of "table"
seems clearer to me.

> + * common zero top address bits, allowing a single, efficient algorithm to
> + * manage all pages. This bitmap approach also offers memory efficiency; for
> + * example, a 512KB bitmap can cover a 16GB memory range for 0-order pages with
> + * PAGE_SIZE = 4KB.
> + *
> + * The data structures defined here are part of the KHO ABI. Any modification
> + * to these structures that breaks backward compatibility must be accompanied by
> + * an update to the "compatible" string. This ensures that a newer kernel can
> + * correctly interpret the data passed by an older kernel.
> + */
> +
> +/*
> + * Defines constants for the KHO radix tree structure, used to track preserved
> + * memory. These constants govern the indexing, sizing, and depth of the tree.
> + */
> +enum kho_radix_consts {
> +	/*
> +	 * The bit position of the order bit (and also the length of the
> +	 * page offset) for an order-0 page.
> +	 */
> +	KHO_ORDER_0_LOG2 = 64 - PAGE_SHIFT,
> +
> +	/* Size of the table in kho_radix_node, in log2 */
> +	KHO_TABLE_SIZE_LOG2 = const_ilog2(PAGE_SIZE / sizeof(phys_addr_t)),
> +
> +	/* Number of bits in the kho_radix_leaf bitmap, in log2 */
> +	KHO_BITMAP_SIZE_LOG2 = PAGE_SHIFT + const_ilog2(BITS_PER_BYTE),
> +
> +	/*
> +	 * The total tree depth is the number of intermediate levels
> +	 * and 1 bitmap level.
> +	 */
> +	KHO_TREE_MAX_DEPTH =
> +	DIV_ROUND_UP(KHO_ORDER_0_LOG2 - KHO_BITMAP_SIZE_LOG2,
> +		     KHO_TABLE_SIZE_LOG2) + 1,

Extra tab in indentation of DIV_ROUND_UP would make it more readable IMHO.

> +};
> +
> +struct kho_radix_node {
> +	u64 table[1 << KHO_TABLE_SIZE_LOG2];
> +};
> +
> +struct kho_radix_leaf {
> +	DECLARE_BITMAP(bitmap, 1 << KHO_BITMAP_SIZE_LOG2);
> +};
> +
>  #endif	/* _LINUX_KHO_ABI_KEXEC_HANDOVER_H */
> diff --git a/include/linux/kho_radix_tree.h b/include/linux/kho_radix_tree.h
> new file mode 100644
> index 000000000000..8f03dd226dd9
> --- /dev/null
> +++ b/include/linux/kho_radix_tree.h
> @@ -0,0 +1,72 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _LINUX_KHO_ABI_RADIX_TREE_H
> +#define _LINUX_KHO_ABI_RADIX_TREE_H

I misinterpreted the file name during v3 review, no need for _ABI here :)

> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/mutex_types.h>
> +#include <linux/types.h>

...

> +#ifdef CONFIG_KEXEC_HANDOVER
> +
> +int kho_radix_add_page(struct kho_radix_tree *tree, unsigned long pfn,
> +		       unsigned int order);
> +
> +void kho_radix_del_page(struct kho_radix_tree *tree, unsigned long pfn,
> +			unsigned int order);
> +
> +int kho_radix_walk_tree(struct kho_radix_tree *tree, unsigned int level,

I think 'level' and 'start' should not be a part of public API. We don't
want to expose walking the tree from arbitrary place.

> +			unsigned long start, kho_radix_tree_walk_callback_t cb);
> +
> +#else  /* #ifdef CONFIG_KEXEC_HANDOVER */

...

> +/**
> + * kho_radix_decode_key - Decodes a radix key back into a physical address and order.
> + * @key: The unsigned long key to decode.
> + * @order: An output parameter, a pointer to an unsigned int where the decoded
> + *         page order will be stored.
> + *
> + * This function reverses the encoding performed by kho_radix_encode_key(),
> + * extracting the original physical address and page order from a given key.
> + *
> + * Return: The decoded physical address.
> + */
> +static phys_addr_t kho_radix_decode_key(unsigned long key,
> +					unsigned int *order)

Nit: *order can be on the same line as key 

>  {

...

> +static unsigned long kho_radix_get_index(unsigned long key,
> +					 unsigned int level)
> +{
> +	int s;
> +
> +	if (level == 0)
> +		return kho_radix_get_bitmap_index(key);

I'd drop this and use get_bitmap_index() explicitly for level-0.
Maybe also rename _get_index() to _get_table_index().

> +
> +	s = ((level - 1) * KHO_TABLE_SIZE_LOG2) + KHO_BITMAP_SIZE_LOG2;
> +	return (key >> s) % (1 << KHO_TABLE_SIZE_LOG2);
> +}

...

> +void kho_radix_del_page(struct kho_radix_tree *tree, unsigned long pfn,
> +			unsigned int order)
> +{
> +	unsigned long key = kho_radix_encode_key(PFN_PHYS(pfn), order);
> +	struct kho_radix_node *node = tree->root;
> +	struct kho_radix_leaf *leaf;
> +	unsigned int i, idx;
> +
> +	if (WARN_ON_ONCE(!tree->root))
> +		return;
> +
> +	might_sleep();
> +
> +	guard(mutex)(&tree->lock);
> +
> +	/* Go from high levels to low levels */
> +	for (i = KHO_TREE_MAX_DEPTH - 1; i > 0; i--) {
> +		idx = kho_radix_get_index(key, i);
> +
> +		/*
> +		 * Attempting to delete a page that has not been preserved,
> +		 * return with a warning.
> +		 */
> +		if (WARN_ON(!node->table[idx]))
> +			return;
> +
> +		if (node->table[idx])

There's already WARN_ON(!node->table) and return, no need for another if
here.

> +			node = phys_to_virt((phys_addr_t)node->table[idx]);
> +	}
> +
> +	/* Handle the leaf level bitmap (level 0) */
> +	leaf = (struct kho_radix_leaf *)node;
> +	idx = kho_radix_get_index(key, 0);
> +	__clear_bit(idx, leaf->bitmap);

I think I already mentioned it in earlier reviews, but I don't remember any
response.

How do we approach freeing empty bitmaps and intermediate nodes?
If we do a few preserve/uppreserve cycles for memory that can be allocated
and freed in between we might get many unused bitmaps.

My view is that we should free the empty bitmaps, maybe asynchronously.
The intermediate nodes probably don't take that much memory to bother with
them.

> +}
> +EXPORT_SYMBOL_GPL(kho_radix_del_page);

...

> +/**
> + * kho_radix_walk_tree - Traverses the radix tree and calls a callback for each preserved page.
> + * @tree: A pointer to the KHO radix tree to walk.
> + * @level: The starting level for the walk (typically KHO_TREE_MAX_DEPTH - 1).
> + * @start: The initial key prefix for the walk (typically 0).
> + * @cb: A callback function of type kho_radix_tree_walk_callback_t that will be
> + *      invoked for each preserved page found in the tree. The callback receives
> + *      the physical address and order of the preserved page.
> + *
> + * This function walks the radix tree, searching from the specified top level
> + * (@level) down to the lowest level (level 0). For each preserved page found,
> + * it invokes the provided callback, passing the page's physical address and
> + * order.
> + *
> + * Return: 0 if the walk completed the specified tree, or the non-zero return
> + *         value from the callback that stopped the walk.
> + */
> +int kho_radix_walk_tree(struct kho_radix_tree *tree, unsigned int level,
> +			unsigned long start, kho_radix_tree_walk_callback_t cb)
> +{
> +	if (WARN_ON_ONCE(!tree->root))
> +		return -EINVAL;
> +
> +	guard(mutex)(&tree->lock);
> +
> +	return __kho_radix_walk_tree(tree->root, level, start, cb);

Like I said, let's make it

	return __kho_radix_walk_tree(tree->root, KHO_TREE_MAX_DEPTH - 1, 0, cb);

and drop level and start parameters.

> +}
> +EXPORT_SYMBOL_GPL(kho_radix_walk_tree);

...

> @@ -260,11 +388,20 @@ static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
>  
>  	/* Clear private to make sure later restores on this page error out. */
>  	page->private = 0;
> +	/* Head page gets refcount of 1. */
> +	set_page_count(page, 1);
>  
> -	if (is_folio)
> -		kho_init_folio(page, info.order);
> -	else
> -		kho_init_pages(page, nr_pages);
> +	/*
> +	 * For higher order folios, tail pages get a page count of zero.
> +	 * For physically contiguous order-0 pages every pages gets a page
> +	 * count of 1
> +	 */
> +	ref_cnt = is_folio ? 0 : 1;
> +	for (unsigned int i = 1; i < nr_pages; i++)
> +		set_page_count(page + i, ref_cnt);
> +
> +	if (is_folio && info.order)
> +		prep_compound_page(page, info.order);

It looks like this reverts latest Pratyush's changes to kho_restore_page(),
please rebase on a newer version of mm.git/linux-next.git.

>  
>  	adjust_managed_page_count(page, nr_pages);
>  	return page;

...

> +static int __init kho_radix_memblock_reserve(phys_addr_t phys,
> +					     unsigned int order)

I don't think _radix should be mentioned in the callback at all.
How about 

kho_preserved_memory_reserve()?

>  {

...

> +	/* Reserve the memory preserved in KHO radix tree in memblock */

	/* Reserve memory preserved by KHO in memblock */

What data structure is used to track the preserved memory is not important
here.

> +	memblock_reserve(phys, sz);
> +	memblock_reserved_mark_noinit(phys, sz);
> +	info.magic = KHO_PAGE_MAGIC;
> +	info.order = order;
> +	page->private = info.page_private;
>  
>  	return 0;
>  }

...

>  static __init int kho_out_fdt_setup(void)
>  {
> +	struct kho_radix_tree *tree = &kho_out.radix_tree;
>  	void *root = kho_out.fdt;
> -	u64 empty_mem_map = 0;
> +	u64 preserved_mem_tree_pa;
>  	int err;
>  
>  	err = fdt_create(root, PAGE_SIZE);
>  	err |= fdt_finish_reservemap(root);
>  	err |= fdt_begin_node(root, "");
>  	err |= fdt_property_string(root, "compatible", KHO_FDT_COMPATIBLE);
> -	err |= fdt_property(root, KHO_FDT_MEMORY_MAP_PROP_NAME, &empty_mem_map,
> -			    sizeof(empty_mem_map));
> +
> +	scoped_guard(mutex, &tree->lock) {

This runs exactly one time on boot and there's no place in the code that
can concurrently change tree->root.

> +		preserved_mem_tree_pa = (u64)virt_to_phys(tree->root);

I don't think we should cast phys_addr_t to u64.

> +	}
> +
> +	err |= fdt_property(root, KHO_FDT_MEMORY_MAP_PROP_NAME,
> +			    &preserved_mem_tree_pa,
> +			    sizeof(preserved_mem_tree_pa));
> +
>  	err |= fdt_end_node(root);
>  	err |= fdt_finish(root);
>  
> @@ -1332,16 +1329,26 @@ static __init int kho_out_fdt_setup(void)
>  
>  static __init int kho_init(void)
>  {
> +	struct kho_radix_tree *tree = &kho_out.radix_tree;
>  	const void *fdt = kho_get_fdt();
>  	int err = 0;
>  
>  	if (!kho_enable)
>  		return 0;
>  
> +	scoped_guard(mutex, &tree->lock) {

No need for lock here. If anything tries to access the tree before the root
is allocated we are anyway doomed.

> +		tree->root = (struct kho_radix_node *)
> +			kzalloc(PAGE_SIZE, GFP_KERNEL);

No need for casting from void *.

> +		if (!tree->root) {
> +			err = -ENOMEM;
> +			goto err_free_scratch;
> +		}
> +	}

-- 
Sincerely yours,
Mike.

