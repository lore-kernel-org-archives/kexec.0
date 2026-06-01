Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11FF3CD5BD1
	for <kexec@archiver.kernel.org>; Mon,  1 Jun 2026 13:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8pAp+Xl5IkEOAsTYUYyBVwVRMkKGL9f8cUS7aCLNM7c=; b=eXPiujwXJ9BphHdlDmWfVfMOrL
	qXMpGmk4yC2GPGLP0sqwf6/QvneBhTGo3nxF8zKRt/iGUS0IqxMVmllZQUNOGdnCMfeTNCGk0xOQT
	9syU+Cji3nt/jsxGD8q6jDzDcq6dI9qZbNRRBVXTBBfv/PxxG9MQVTsRzYHqNWB/DeXxYFTtxWP4n
	qTU0A39AN6udmnVFqHWt/+7zw/8moAUdkvU2pIS+Vdi/kU5qCxFn5cV8ZuuZvTvZgArf8NjbBzoN1
	nUFGN/QgYWodQl7UyFVqly9/GwOj44fPWBUSBKu08HWss0n1YnV6B6PuQcKgsarLwpndR0GpQfCwN
	cPEfsDAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU2qo-0000000BDc6-1Dv5;
	Mon, 01 Jun 2026 13:38:42 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU2qm-0000000BDc0-1DUW
	for kexec@lists.infradead.org;
	Mon, 01 Jun 2026 13:38:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4F6CF600AA;
	Mon,  1 Jun 2026 13:38:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7544D1F00893;
	Mon,  1 Jun 2026 13:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780321119;
	bh=8pAp+Xl5IkEOAsTYUYyBVwVRMkKGL9f8cUS7aCLNM7c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Odfb2gj8m4PKjgYrWAwPGL4d2RSuzjkwFbRq+eeUs6YFR4YvJEaTEWiykG+f/B7XL
	 zlzK8dEvi02a993es4RS1bGvy30nAn4g22rTzFWR4bAQREyEz8lgj3D2FLCXGydBpS
	 2tGDKTtVHIfM+1sO0OcD/jz6Bbbl5CinySq9MbXirjhAlE8fuTptZaciFSo0KSVeAF
	 fBTWzXU9CxMMEZmMLlXhndoZ7lNfF/a6nABl4GmK20khoAWPhTLnbHcXewWOb/e13w
	 ifWl2YQwhggnb4hUy5ZXSVRgQJPW7OiQQwPM2aMhbaFjs5kJuW6VJR1z1QYemHAEF9
	 PNSu9I7UUROlA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org,  rppt@kernel.org,  shuah@kernel.org,
  akpm@linux-foundation.org,  linux-mm@kvack.org,
  skhan@linuxfoundation.org,  linux-doc@vger.kernel.org,
  linux-kernel@vger.kernel.org,  corbet@lwn.net,  dmatlack@google.com,
  kexec@lists.infradead.org,  pratyush@kernel.org,  skhawaja@google.com,
  graf@amazon.com
Subject: Re: [PATCH v4 07/13] kho: add support for linked-block serialization
In-Reply-To: <20260530221938.115978-8-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Sat, 30 May 2026 22:19:32 +0000")
References: <20260530221938.115978-1-pasha.tatashin@soleen.com>
	<20260530221938.115978-8-pasha.tatashin@soleen.com>
Date: Mon, 01 Jun 2026 15:38:34 +0200
Message-ID: <2vxzqzmqfkit.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Sat, May 30 2026, Pasha Tatashin wrote:

> Introduce a linked-block serialization mechanism for state handover.
>
> Previously, LUO used contiguous memory blocks for serializing sessions
> and files, which imposed limits on the total number of items that could
> be preserved across a live update.
>
> This commit adds the infrastructure for a more flexible, block-based
> approach where serialized data is stored in a chain of linked blocks.
> This is a generic KHO serialization block infrastructure that can be
> used by multiple subsystems.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  Documentation/core-api/kho/abi.rst   |   5 +
>  Documentation/core-api/kho/index.rst |  11 +
>  MAINTAINERS                          |   1 +
>  include/linux/kho/abi/block.h        |  56 ++++
>  include/linux/kho_block.h            |  79 ++++++
>  kernel/liveupdate/Makefile           |   1 +
>  kernel/liveupdate/kho_block.c        | 384 +++++++++++++++++++++++++++
>  7 files changed, 537 insertions(+)
>  create mode 100644 include/linux/kho/abi/block.h
>  create mode 100644 include/linux/kho_block.h
>  create mode 100644 kernel/liveupdate/kho_block.c
>
> diff --git a/Documentation/core-api/kho/abi.rst b/Documentation/core-api/kho/abi.rst
> index 799d743105a6..edeb5b311963 100644
> --- a/Documentation/core-api/kho/abi.rst
> +++ b/Documentation/core-api/kho/abi.rst
> @@ -28,6 +28,11 @@ KHO persistent memory tracker ABI
>  .. kernel-doc:: include/linux/kho/abi/kexec_handover.h
>    :doc: KHO persistent memory tracker
>  
> +KHO serialization block ABI
> +===========================
> +
> +.. kernel-doc:: include/linux/kho/abi/block.h
> +
>  See Also
>  ========
>  
> diff --git a/Documentation/core-api/kho/index.rst b/Documentation/core-api/kho/index.rst
> index 0a2dee4f8e7d..320914a42178 100644
> --- a/Documentation/core-api/kho/index.rst
> +++ b/Documentation/core-api/kho/index.rst
> @@ -83,6 +83,17 @@ Public API
>  .. kernel-doc:: kernel/liveupdate/kexec_handover.c
>    :export:
>  
> +KHO Serialization Blocks API
> +============================
> +
> +.. kernel-doc:: kernel/liveupdate/kho_block.c
> +  :doc: KHO Serialization Blocks
> +
> +.. kernel-doc:: include/linux/kho_block.h
> +
> +.. kernel-doc:: kernel/liveupdate/kho_block.c
> +  :internal:
> +
>  See Also
>  ========
>  
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2fb1c75afd16..fd119b343e99 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14194,6 +14194,7 @@ F:	Documentation/admin-guide/mm/kho.rst
>  F:	Documentation/core-api/kho/*
>  F:	include/linux/kexec_handover.h
>  F:	include/linux/kho/
> +F:	include/linux/kho_block.h
>  F:	kernel/liveupdate/kexec_handover*
>  F:	lib/test_kho.c
>  F:	tools/testing/selftests/kho/
> diff --git a/include/linux/kho/abi/block.h b/include/linux/kho/abi/block.h
> new file mode 100644
> index 000000000000..8641c20b379b
> --- /dev/null
> +++ b/include/linux/kho/abi/block.h
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2026, Google LLC.
> + * Pasha Tatashin <pasha.tatashin@soleen.com>
> + */
> +
> +/**
> + * DOC: KHO Serialization Blocks ABI
> + *
> + * Subsystems using the KHO Serialization Blocks framework rely on the stable
> + * Application Binary Interface defined below to pass serialized state from a
> + * pre-update kernel to a post-update kernel.
> + *
> + * This interface is a contract. Any modification to the structure fields,
> + * compatible strings, or the layout of the `__packed` serialization
> + * structures defined here constitutes a breaking change. Such changes require
> + * incrementing the version number in the `KHO_BLOCK_ABI_COMPATIBLE` string to
> + * prevent a new kernel from misinterpreting data from an old kernel.
> + *
> + * Changes are allowed provided the compatibility version is incremented;
> + * however, backward/forward compatibility is only guaranteed for kernels
> + * supporting the same ABI version.
> + */
> +
> +#ifndef _LINUX_KHO_ABI_BLOCK_H
> +#define _LINUX_KHO_ABI_BLOCK_H
> +
> +#include <asm/page.h>
> +#include <linux/types.h>
> +
> +#define KHO_BLOCK_ABI_COMPATIBLE	"kho-block-v1"

During KHO radix development, I argued for a separate compatible for the
radix tree, but at that time, we tied the radix tree to core KHO ABI.
The argument being that all core KHO data structures belong to the KHO
ABI set. I imagine this will be used by kho_vmalloc, so it will also be
end up being used by a core KHO API.

So, do we want separate ABI? I don't much have a preference myself, but
I do think the compatible management will be a bit easier if this relied
on KHO compatible, especially once kho_vmalloc starts using it.

> +
> +/**
> + * KHO_BLOCK_SIZE - The size of each serialization block.
> + *
> + * This is defined as PAGE_SIZE. PAGE_SIZE is ABI compliant because live
> + * update between kernels with different page sizes is not supported by KHO.
> + */
> +#define KHO_BLOCK_SIZE			PAGE_SIZE
> +
> +/**
> + * struct kho_block_header_ser - Header for the serialized data block.
> + * @next:  Physical address of the next struct kho_block_header_ser.
> + * @count: The number of entries that immediately follow this header in the
> + *         memory block.
> + *
> + * This structure is located at the beginning of a block of physical memory
> + * preserved across a kexec. It provides the necessary metadata to interpret
> + * the array of entries that follow.
> + */
> +struct kho_block_header_ser {
> +	u64 next;
> +	u64 count;
> +} __packed;
> +
> +#endif /* _LINUX_KHO_ABI_BLOCK_H */
> diff --git a/include/linux/kho_block.h b/include/linux/kho_block.h
> new file mode 100644
> index 000000000000..5e6b87b1befa
> --- /dev/null
> +++ b/include/linux/kho_block.h
> @@ -0,0 +1,79 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2026, Google LLC.
> + * Pasha Tatashin <pasha.tatashin@soleen.com>
> + */
> +
> +#ifndef _LINUX_KHO_BLOCK_H
> +#define _LINUX_KHO_BLOCK_H
> +
> +#include <linux/list.h>
> +#include <linux/types.h>
> +#include <linux/kho/abi/block.h>
> +
> +/**
> + * struct kho_block - Internal representation of a serialization block.
> + * @list: List head for linking blocks in memory.
> + * @ser:  Pointer to the serialized header in preserved memory.
> + */
> +struct kho_block {
> +	struct list_head list;
> +	struct kho_block_header_ser *ser;
> +};
> +
> +/**
> + * struct kho_block_set - A set of blocks that belong to the same object.
> + * @blocks:          The list of serialization blocks (struct kho_block).
> + * @nblocks:         The number of allocated serialization blocks.
> + * @head_pa:         Physical address of the first block header.
> + * @entry_size:      The size of each entry in the blocks.
> + * @count_per_block: The maximum number of entries each block can hold.
> + * @incoming:        True if this block set was restored from the previous kernel.
> + */
> +struct kho_block_set {
> +	struct list_head blocks;
> +	long nblocks;
> +	u64 head_pa;
> +	size_t entry_size;

I think we should add the entry_size to kho_block_header_ser? I think it
is a part of the ABI of the block set. If this changes, we cannot parse
a block set with a different size. If a subsystem wants to change entry
size, they create a new block set with different entry size, and then
they bump their compatible version.

> +	u64 count_per_block;
> +	bool incoming;
> +};
> +
> +/**
> + * struct kho_block_it - Iterator for serializing entries into blocks.
> + * @bs:         The block set being iterated.
> + * @block:      The current block.
> + * @i:          The current entry index within @block.
> + */
> +struct kho_block_it {
> +	struct kho_block_set *bs;
> +	struct kho_block *block;
> +	u64 i;
> +};
> +
> +/**
> + * KHO_BLOCK_SET_INIT - Initialize a static kho_block_set.
> + * @_name:       Name of the kho_block_set variable.
> + * @_entry_size: The size of each entry in the block set.
> + */
> +#define KHO_BLOCK_SET_INIT(_name, _entry_size) {                        \
> +	.blocks = LIST_HEAD_INIT((_name).blocks),                       \
> +	.entry_size = _entry_size,                                      \
> +}
> +
> +void kho_block_set_init(struct kho_block_set *bs, size_t entry_size);
> +
> +int kho_block_grow(struct kho_block_set *bs, u64 count);
> +void kho_block_shrink(struct kho_block_set *bs, u64 count);

These block management functions seem like internal details of the block
set API. Do we need to export them? I think users should not have to
worry about block management. They should read, set, or clear entries
using the iterators, and internally the block management should take of
allocation or freeing. So here for example, I th

> +
> +int kho_block_restore(struct kho_block_set *bs, u64 head_pa);
> +void kho_block_destroy(struct kho_block_set *bs);

Nit: kho_block_set_{restore,destroy}()? At first glance I thought they
manipulated a single block.

> +void kho_block_set_clear(struct kho_block_set *bs);
> +
> +void kho_block_it_init(struct kho_block_it *it, struct kho_block_set *bs);
> +void *kho_block_it_next(struct kho_block_it *it);
> +void *kho_block_it_read(struct kho_block_it *it);
> +void *kho_block_it_prev(struct kho_block_it *it);
> +void kho_block_it_finalize(struct kho_block_it *it);
> +
> +#endif /* _LINUX_KHO_BLOCK_H */
> diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
> index d2f779cbe279..eec9d3ae07eb 100644
> --- a/kernel/liveupdate/Makefile
> +++ b/kernel/liveupdate/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  luo-y :=								\
> +		kho_block.o						\
>  		luo_core.o						\
>  		luo_file.o						\
>  		luo_flb.o						\
> diff --git a/kernel/liveupdate/kho_block.c b/kernel/liveupdate/kho_block.c
> new file mode 100644
> index 000000000000..a4e650af946f
> --- /dev/null
> +++ b/kernel/liveupdate/kho_block.c
> @@ -0,0 +1,384 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (c) 2026, Google LLC.
> + * Pasha Tatashin <pasha.tatashin@soleen.com>
> + */
> +
> +/**
> + * DOC: KHO Serialization Blocks
> + *
> + * KHO provides a mechanism to preserve stateful data across a kexec handover
> + * by serializing it into memory blocks. This file provides the common
> + * infrastructure for managing these blocks.
> + *
> + * Each block consists of a header (struct kho_block_header_ser) followed by an
> + * array of serialized entries. Multiple blocks are linked together via a
> + * physical pointer in the header, forming a linked list that can be easily
> + * traversed in both the current and the next kernel.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/io.h>
> +#include <linux/kexec_handover.h>
> +#include <linux/kho/abi/block.h>
> +#include <linux/kho_block.h>
> +#include <linux/slab.h>
> +
> +/*
> + * Safeguard limit for the number of serialization blocks. This is used to
> + * prevent infinite loops and excessive memory allocation in case of memory
> + * corruption in the preserved state.
> + */
> +#define KHO_MAX_BLOCKS 10000
> +
> +/**
> + * kho_block_set_init - Initialize a block set.
> + * @bs:         The block set to initialize.
> + * @entry_size: The size of each entry in the blocks.
> + */
> +void kho_block_set_init(struct kho_block_set *bs, size_t entry_size)
> +{
> +	*bs = (struct kho_block_set)KHO_BLOCK_SET_INIT(*bs, entry_size);
> +}
> +
> +static inline u64 kho_block_count_per_block(struct kho_block_set *bs)
> +{
> +	if (unlikely(!bs->count_per_block)) {
> +		bs->count_per_block = (KHO_BLOCK_SIZE -
> +				       sizeof(struct kho_block_header_ser)) /
> +				      bs->entry_size;
> +		WARN_ON(!bs->count_per_block);
> +	}
> +	return bs->count_per_block;
> +}

This looks odd. I don't see a reason to calculate this lazily. Why not
just do it when initializing the block set, in kho_block_set_init() or
kho_block_restore()? And then use bs->count_per_block directly.

> +
> +/* Free serialized data */
> +static void kho_block_free_ser(struct kho_block_set *bs,
> +			       struct kho_block_header_ser *ser)
> +{
> +	if (bs->incoming)
> +		kho_restore_free(ser);
> +	else
> +		kho_unpreserve_free(ser);
> +}
> +
> +static struct kho_block_header_ser *kho_block_alloc_ser(struct kho_block_set *bs)
> +{
> +	WARN_ON(bs->incoming);

WARN_ON_ONCE?

> +	return kho_alloc_preserve(KHO_BLOCK_SIZE);
> +}
> +
> +static int kho_block_add(struct kho_block_set *bs,
> +			 struct kho_block_header_ser *ser)
> +{
> +	struct kho_block *block, *last;
> +
> +	if (bs->nblocks >= KHO_MAX_BLOCKS)
> +		return -ENOSPC;
> +
> +	block = kzalloc_obj(*block);
> +	if (!block)
> +		return -ENOMEM;
> +
> +	block->ser = ser;
> +	last = list_last_entry_or_null(&bs->blocks, struct kho_block, list);
> +	list_add_tail(&block->list, &bs->blocks);
> +	bs->nblocks++;
> +
> +	if (last)
> +		last->ser->next = virt_to_phys(ser);
> +	else
> +		bs->head_pa = virt_to_phys(ser);
> +
> +	return 0;
> +}
> +
> +/**
> + * kho_block_grow - Create a new block if the current capacity is reached.
> + * @bs:    The block set.
> + * @count: The current number of entries.
> + *
> + * This function handles the dynamic expansion of a block set. It allocates
> + * and links a new serialization block if the provided entry count matches
> + * the current total capacity of the set.
> + *
> + * Return: 0 on success, or a negative errno on failure.
> + */
> +int kho_block_grow(struct kho_block_set *bs, u64 count)
> +{
> +	struct kho_block_header_ser *ser;
> +	int err;
> +
> +	if (WARN_ON(bs->incoming))

WARN_ON_ONCE here too?

> +		return -EINVAL;
> +
> +	if (count != bs->nblocks * kho_block_count_per_block(bs))
> +		return 0;
> +
> +	ser = kho_block_alloc_ser(bs);
> +	if (IS_ERR(ser))
> +		return PTR_ERR(ser);
> +
> +	err = kho_block_add(bs, ser);
> +	if (err) {
> +		kho_block_free_ser(bs, ser);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * kho_block_shrink - Conditionally destroy the last block in a block set.
> + * @bs:              The block set.
> + * @count:           The current number of entries across all blocks.
> + *
> + * This function checks if the last block in the set is redundant based on the
> + * total entry count and the capacity of the preceding blocks. If the entry
> + * count can be accommodated by the blocks that come before the last one, the
> + * last block is destroyed and removed from the set.
> + */
> +void kho_block_shrink(struct kho_block_set *bs, u64 count)
> +{
> +	struct kho_block *last, *new_last;
> +
> +	if (count > (bs->nblocks - 1) * kho_block_count_per_block(bs))
> +		return;
> +
> +	if (list_empty(&bs->blocks))
> +		return;
> +
> +	last = list_last_entry(&bs->blocks, struct kho_block, list);
> +	list_del(&last->list);
> +	bs->nblocks--;
> +	kho_block_free_ser(bs, last->ser);
> +	kfree(last);
> +
> +	new_last = list_last_entry_or_null(&bs->blocks, struct kho_block, list);
> +	if (new_last)
> +		new_last->ser->next = 0;
> +	else
> +		bs->head_pa = 0;
> +}
> +
> +/*
> + * kho_cyclic_blocks_check - Check for cycles in a linked list of blocks.
> + * Uses Floyd's cycle-finding algorithm to ensure sanity of the incoming list.
> + */
> +static bool kho_cyclic_blocks_check(struct kho_block_set *bs)
> +{
> +	struct kho_block_header_ser *fast;
> +	struct kho_block_header_ser *slow;
> +	int count = 0;
> +
> +	fast = phys_to_virt(bs->head_pa);
> +	slow = fast;
> +
> +	while (fast) {
> +		if (count++ >= KHO_MAX_BLOCKS) {
> +			pr_err("Linked list too long\n");
> +			return false;
> +		}
> +
> +		if (!fast->next)
> +			break;
> +
> +		fast = phys_to_virt(fast->next);
> +		if (!fast->next)
> +			break;
> +
> +		fast = phys_to_virt(fast->next);
> +		slow = phys_to_virt(slow->next);
> +
> +		if (slow == fast) {
> +			pr_err("Cyclic list detected\n");

Heh, reminds me of the time I was practicing leetcode for interviews ;-)

> +			return false;
> +		}
> +	}
> +
> +	return true;
> +}
> +
> +/**
> + * kho_block_restore - Restore a block set from a physical address.
> + * @bs:      The block set to restore.
> + * @head_pa: Physical address of the first block header.
> + *
> + * Return: 0 on success, or a negative errno on failure.
> + */
> +int kho_block_restore(struct kho_block_set *bs, u64 head_pa)
> +{
> +	struct kho_block_header_ser *ser;
> +	u64 next_pa = head_pa;
> +	int err;
> +
> +	/* Restored block sets use size from the previous kernel */
> +	bs->incoming = true;
> +	if (!head_pa)
> +		return 0;
> +
> +	bs->head_pa = head_pa;
> +	if (!kho_cyclic_blocks_check(bs)) {
> +		bs->head_pa = 0;
> +		return -EINVAL;
> +	}
> +
> +	while (next_pa) {
> +		ser = phys_to_virt(next_pa);
> +		if (ser->count > kho_block_count_per_block(bs)) {
> +			pr_warn("Block contains too many entries: %llu\n",
> +				ser->count);
> +			err = -EINVAL;
> +			goto err_destroy;
> +		}
> +		err = kho_block_add(bs, ser);
> +		if (err)
> +			goto err_destroy;
> +		next_pa = ser->next;
> +	}
> +
> +	return 0;
> +
> +err_destroy:
> +	kho_block_destroy(bs);
> +	return err;
> +}
> +
> +/**
> + * kho_block_destroy - Destroy all blocks in a block set.
> + * @bs:          The block set.
> + */
> +void kho_block_destroy(struct kho_block_set *bs)
> +{
> +	u64 head_pa = bs->head_pa;
> +	struct kho_block *block;
> +
> +	while (!list_empty(&bs->blocks)) {
> +		block = list_first_entry(&bs->blocks, struct kho_block, list);
> +		list_del(&block->list);
> +		kfree(block);
> +	}

Nit:

	list_for_each_entry_safe(block, tmp, &bs->blocks, list) {
		list_del(&block->list);
		kfree(block);
	}

is a bit more idiomatic (and IMO easier to read).

> +	bs->nblocks = 0;
> +	bs->head_pa = 0;
> +
> +	while (head_pa) {
> +		struct kho_block_header_ser *ser = phys_to_virt(head_pa);
> +
> +		head_pa = ser->next;
> +		kho_block_free_ser(bs, ser);

Nit: also, can't you put this also in the previous loop? Something like:

	list_for_each_entry_safe(block, tmp, &bs->blocks, list) {
		list_del(&block->list);
		kho_block_free_ser(block->ser);
		kfree(block);
	}

> +	}
> +}
> +
> +/**
> + * kho_block_set_clear - Clear all serialized data in a block set.
> + * @bs: The block set to clear.
> + */
> +void kho_block_set_clear(struct kho_block_set *bs)
> +{
> +	struct kho_block *block;
> +
> +	list_for_each_entry(block, &bs->blocks, list) {
> +		block->ser->count = 0;
> +		memset(block->ser + 1, 0, KHO_BLOCK_SIZE - sizeof(*block->ser));
> +	}
> +}
> +
> +/**
> + * kho_block_it_init - Initialize a block set iterator.
> + * @it:         The iterator to initialize.
> + * @bs:         The block set to iterate over.
> + */
> +void kho_block_it_init(struct kho_block_it *it, struct kho_block_set *bs)
> +{
> +	it->bs = bs;
> +	it->block = list_first_entry_or_null(&bs->blocks, struct kho_block, list);
> +	it->i = 0;
> +}
> +
> +/**
> + * kho_block_it_next - Return the next entry slot in the block set.
> + * @it: The block iterator.
> + *
> + * If the current block is full, it automatically advances to the next block
> + * in the set.
> + *
> + * Return: A pointer to the next entry slot, or NULL if no more slots are
> + * available.
> + */
> +void *kho_block_it_next(struct kho_block_it *it)

The naming and documentation here are very confusing. This and
kho_block_it_read() look pretty much identical, and their documentation
also looks pretty much identical. There seems to be only one tiny
difference: this function returns the slot while incrementing the block
count.

Can we do better something like kho_block_it_write_next(struct
kho_block_it *it, void *entry) (size was specified when creating block
set)? Yes, this results in a copy but does that matter that much?

And if you really want to avoid copying, perhaps
kho_block_it_add_entry()? Or something along the lines? To make it clear
this is adding an entry to the block set.

Also, make the intended usage clear in the documentation.

> +{
> +	if (!it->block)
> +		return NULL;
> +
> +	if (it->i == kho_block_count_per_block(it->bs)) {
> +		it->block->ser->count = it->i;
> +		if (list_is_last(&it->block->list, &it->bs->blocks))
> +			return NULL;
> +		it->block = list_next_entry(it->block, list);
> +		it->i = 0;
> +	}
> +
> +	return (void *)(it->block->ser + 1) + (it->i++ * it->bs->entry_size);
> +}
> +
> +/**
> + * kho_block_it_read - Return the next entry slot for reading.
> + * @it: The block iterator.
> + *
> + * This function iterates through entries that were previously serialized,
> + * respecting the count stored in each block's header.
> + *
> + * Return: A pointer to the next entry slot, or NULL if no more entries are
> + * available.
> + */
> +void *kho_block_it_read(struct kho_block_it *it)
> +{
> +	if (!it->block)
> +		return NULL;
> +
> +	while (it->i == it->block->ser->count) {

Hmm, the while loop suggests we can have blocks with zero count. Do you
think we should detect those and error out instead? Since it doesn't
really make sense to have a block with no entries.

> +		if (list_is_last(&it->block->list, &it->bs->blocks))
> +			return NULL;
> +		it->block = list_next_entry(it->block, list);
> +		it->i = 0;
> +	}
> +
> +	return (void *)(it->block->ser + 1) + (it->i++ * it->bs->entry_size);
> +}
> +
> +/**
> + * kho_block_it_prev - Return the previous entry slot in the block set.
> + * @it: The block iterator.
> + *
> + * If the current index is at the start of a block, it automatically moves to
> + * the end of the previous block.
> + *
> + * Return: A pointer to the previous entry slot, or NULL if at the very
> + * beginning of the block set.
> + */
> +void *kho_block_it_prev(struct kho_block_it *it)
> +{
> +	if (!it->block)
> +		return NULL;
> +
> +	if (it->i == 0) {
> +		if (list_is_first(&it->block->list, &it->bs->blocks))
> +			return NULL;
> +		it->block = list_prev_entry(it->block, list);
> +		it->i = kho_block_count_per_block(it->bs);
> +	}
> +
> +	return (void *)(it->block->ser + 1) + (--it->i * it->bs->entry_size);
> +}
> +
> +/**
> + * kho_block_it_finalize - Finalize the current block by setting its entry count.
> + * @it: The block iterator.
> + */
> +void kho_block_it_finalize(struct kho_block_it *it)
> +{
> +	if (it->block)
> +		it->block->ser->count = it->i;
> +}

Doesn't kho_block_it_next() already do this when you add an entry? So
this seems redundant.

-- 
Regards,
Pratyush Yadav

