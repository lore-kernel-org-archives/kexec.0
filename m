Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A5EDCD6E68
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 16:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uW7guSvt1v56bZ3HcSG0jneWFUNT6pShqr6MCcNCKKI=; b=NFEvt3fF3OYSR9i6S+WZOK9s+O
	EHeT5uVh77isXt5SJUtqUf1M8rG+D63uqpfLG9UAoN7wqUtESa/KHAfZQplB34sdHFwLkEDoCUJlw
	Hj8H+iF86PkQNBEegKRabY53VP7TpbC45MD8mr6DjscqGgqNHbyjI0YRYnZ5ltYPBjXOzfd/QQbfo
	AVkct9c9WQRJAfPzlgTy/JMLK/wxr+K1HAnQs0xIYxwcUbRJY2iXDXkRExx8VVbVN8tkRkUlSogzE
	Pkq8cA9hKOUW4POwiU494scNhwuxt8H3rIYL8xg5MMZO+eB2aUOnIikfpUiv3mGrKMBOyD+G+Hz5e
	N/fTu3gQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUSDW-0000000DU7B-10hN;
	Tue, 02 Jun 2026 16:43:50 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUSDU-0000000DU6x-0EdX
	for kexec@lists.infradead.org;
	Tue, 02 Jun 2026 16:43:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3CE796001A;
	Tue,  2 Jun 2026 16:43:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943DD1F00893;
	Tue,  2 Jun 2026 16:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780418626;
	bh=uW7guSvt1v56bZ3HcSG0jneWFUNT6pShqr6MCcNCKKI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=EE3InH4Bt9pRWzoN2GzoKpFcCodwaD3ih8vC1w6LghJZfvvzqXFx7RXPXnBeM81az
	 ZC9QYbleELuaPnB2qWI1sQMjc5SoSfrkMPTtvvLpqHKVMghCgBKmrHcitN6FhZuwkz
	 i71gdb9aM+yQZZF359hzV3teaxPSp3dJglRsojVBPlLIDxZYnqKR1q3VM716W/qf6S
	 qOOLPhfa7x5ifxlsK8CjXMk5MUadZz8hPQnNCZY4vF9KRFJ+f64GtQgHqyMXFXNIG6
	 wBeCrvtFlW6x1AVXrT3/tdMxImqCxINKtCMKYoF/qEg4RkoezDVUnXQTNZnT/2ETfC
	 LnXTzdeQ8fUxg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  linux-kselftest@vger.kernel.org,
  rppt@kernel.org,  shuah@kernel.org,  akpm@linux-foundation.org,
  linux-mm@kvack.org,  skhan@linuxfoundation.org,
  linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org,
  corbet@lwn.net,  dmatlack@google.com,  kexec@lists.infradead.org,
  skhawaja@google.com,  graf@amazon.com
Subject: Re: [PATCH v4 07/13] kho: add support for linked-block serialization
In-Reply-To: <ah2OeTDFltPWwsik@google.com> (Pasha Tatashin's message of "Mon,
	1 Jun 2026 10:37:35 -0400")
References: <20260530221938.115978-1-pasha.tatashin@soleen.com>
	<20260530221938.115978-8-pasha.tatashin@soleen.com>
	<2vxzqzmqfkit.fsf@kernel.org> <ah2OeTDFltPWwsik@google.com>
Date: Tue, 02 Jun 2026 18:43:43 +0200
Message-ID: <2vxzcxy8evuo.fsf@kernel.org>
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

On Mon, Jun 01 2026, Pasha Tatashin wrote:

> On 06-01 15:38, Pratyush Yadav wrote:
>> On Sat, May 30 2026, Pasha Tatashin wrote:
>> 
>> > Introduce a linked-block serialization mechanism for state handover.
>> >
>> > Previously, LUO used contiguous memory blocks for serializing sessions
>> > and files, which imposed limits on the total number of items that could
>> > be preserved across a live update.
>> >
>> > This commit adds the infrastructure for a more flexible, block-based
>> > approach where serialized data is stored in a chain of linked blocks.
>> > This is a generic KHO serialization block infrastructure that can be
>> > used by multiple subsystems.
>> >
>> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
[...]
>> > +/**
>> > + * DOC: KHO Serialization Blocks ABI
>> > + *
>> > + * Subsystems using the KHO Serialization Blocks framework rely on the stable
>> > + * Application Binary Interface defined below to pass serialized state from a
>> > + * pre-update kernel to a post-update kernel.
>> > + *
>> > + * This interface is a contract. Any modification to the structure fields,
>> > + * compatible strings, or the layout of the `__packed` serialization
>> > + * structures defined here constitutes a breaking change. Such changes require
>> > + * incrementing the version number in the `KHO_BLOCK_ABI_COMPATIBLE` string to
>> > + * prevent a new kernel from misinterpreting data from an old kernel.
>> > + *
>> > + * Changes are allowed provided the compatibility version is incremented;
>> > + * however, backward/forward compatibility is only guaranteed for kernels
>> > + * supporting the same ABI version.
>> > + */
>> > +
>> > +#ifndef _LINUX_KHO_ABI_BLOCK_H
>> > +#define _LINUX_KHO_ABI_BLOCK_H
>> > +
>> > +#include <asm/page.h>
>> > +#include <linux/types.h>
>> > +
>> > +#define KHO_BLOCK_ABI_COMPATIBLE	"kho-block-v1"
>> 
>> During KHO radix development, I argued for a separate compatible for the
>> radix tree, but at that time, we tied the radix tree to core KHO ABI.
>> The argument being that all core KHO data structures belong to the KHO
>> ABI set. I imagine this will be used by kho_vmalloc, so it will also be
>> end up being used by a core KHO API.
>> 
>> So, do we want separate ABI? I don't much have a preference myself, but
>> I do think the compatible management will be a bit easier if this relied
>> on KHO compatible, especially once kho_vmalloc starts using it.
>
> I prefer to make them fine-grained, now that we are adding more and more 
> features: kho vmalloc, kho radix, and kho block should all have their 
> own compatibility strings. Furthermore, any components that depend on 
> them should include these compatibility strings in their own 
> compatibility strings, in the same manner I have done in this series.

Sure, sounds good.

>
>> 
>> > +
>> > +/**
>> > + * KHO_BLOCK_SIZE - The size of each serialization block.
>> > + *
>> > + * This is defined as PAGE_SIZE. PAGE_SIZE is ABI compliant because live
>> > + * update between kernels with different page sizes is not supported by KHO.
>> > + */
>> > +#define KHO_BLOCK_SIZE			PAGE_SIZE
>> > +
>> > +/**
>> > + * struct kho_block_header_ser - Header for the serialized data block.
>> > + * @next:  Physical address of the next struct kho_block_header_ser.
>> > + * @count: The number of entries that immediately follow this header in the
>> > + *         memory block.
>> > + *
>> > + * This structure is located at the beginning of a block of physical memory
>> > + * preserved across a kexec. It provides the necessary metadata to interpret
>> > + * the array of entries that follow.
>> > + */
>> > +struct kho_block_header_ser {
>> > +	u64 next;
>> > +	u64 count;
>> > +} __packed;
>> > +
>> > +#endif /* _LINUX_KHO_ABI_BLOCK_H */
>> > diff --git a/include/linux/kho_block.h b/include/linux/kho_block.h
>> > new file mode 100644
>> > index 000000000000..5e6b87b1befa
>> > --- /dev/null
>> > +++ b/include/linux/kho_block.h
>> > @@ -0,0 +1,79 @@
>> > +/* SPDX-License-Identifier: GPL-2.0 */
>> > +/*
>> > + * Copyright (c) 2026, Google LLC.
>> > + * Pasha Tatashin <pasha.tatashin@soleen.com>
>> > + */
>> > +
>> > +#ifndef _LINUX_KHO_BLOCK_H
>> > +#define _LINUX_KHO_BLOCK_H
>> > +
>> > +#include <linux/list.h>
>> > +#include <linux/types.h>
>> > +#include <linux/kho/abi/block.h>
>> > +
>> > +/**
>> > + * struct kho_block - Internal representation of a serialization block.
>> > + * @list: List head for linking blocks in memory.
>> > + * @ser:  Pointer to the serialized header in preserved memory.
>> > + */
>> > +struct kho_block {
>> > +	struct list_head list;
>> > +	struct kho_block_header_ser *ser;
>> > +};
>> > +
>> > +/**
>> > + * struct kho_block_set - A set of blocks that belong to the same object.
>> > + * @blocks:          The list of serialization blocks (struct kho_block).
>> > + * @nblocks:         The number of allocated serialization blocks.
>> > + * @head_pa:         Physical address of the first block header.
>> > + * @entry_size:      The size of each entry in the blocks.
>> > + * @count_per_block: The maximum number of entries each block can hold.
>> > + * @incoming:        True if this block set was restored from the previous kernel.
>> > + */
>> > +struct kho_block_set {
>> > +	struct list_head blocks;
>> > +	long nblocks;
>> > +	u64 head_pa;
>> > +	size_t entry_size;
>> 
>> I think we should add the entry_size to kho_block_header_ser? I think it
>> is a part of the ABI of the block set. If this changes, we cannot parse
>> a block set with a different size. If a subsystem wants to change entry
>> size, they create a new block set with different entry size, and then
>> they bump their compatible version.
>
> I have considered that, and we can certainly do it; however, I do not 
> see how it would affect the current implementation. If luo_file or 
> luo_session change entry_size, they must change the LUO compatibility 
> version, which would prevent LU from one kernel to the next. However, 
> for flexibility and future extensibility, I believe it would be useful 
> to add entry_size and block_size (which is PAGE_SIZE, but could be 
> larger for some users) to the header. This is more of a feature request 
> than an issue with the current series.

My suggestion was mainly for sanity checking. So if LUO or another user
inadvertently changes entry size, it gets caught. But thinking about it
more, there are a million other ways to break compatibility while
keeping the entry size same so perhaps it doesn't matter as much...

>
>> 
>> > +	u64 count_per_block;
>> > +	bool incoming;
>> > +};
>> > +
>> > +/**
>> > + * struct kho_block_it - Iterator for serializing entries into blocks.
>> > + * @bs:         The block set being iterated.
>> > + * @block:      The current block.
>> > + * @i:          The current entry index within @block.
>> > + */
>> > +struct kho_block_it {
>> > +	struct kho_block_set *bs;
>> > +	struct kho_block *block;
>> > +	u64 i;
>> > +};
>> > +
>> > +/**
>> > + * KHO_BLOCK_SET_INIT - Initialize a static kho_block_set.
>> > + * @_name:       Name of the kho_block_set variable.
>> > + * @_entry_size: The size of each entry in the block set.
>> > + */
>> > +#define KHO_BLOCK_SET_INIT(_name, _entry_size) {                        \
>> > +	.blocks = LIST_HEAD_INIT((_name).blocks),                       \
>> > +	.entry_size = _entry_size,                                      \
>> > +}
>> > +
>> > +void kho_block_set_init(struct kho_block_set *bs, size_t entry_size);
>> > +
>> > +int kho_block_grow(struct kho_block_set *bs, u64 count);
>> > +void kho_block_shrink(struct kho_block_set *bs, u64 count);
>> 
>> These block management functions seem like internal details of the block
>
> This is not so. The confusion here is that they must be allocated and 
> preserved at runtime as resources are registered/unregistered, while 
> these blocks are only used serialization phase, 
>
> These calls are more like notifiers that more files/sessions are created 
> removed, so we can adjust block count accordingly if necessary (allocate 
> preserver memory), and have them available durign 
> serialization/deserialization

Yeah, I got that when reading the later patches that use these.

Perhaps kho_block_prealloc() and kho_block_unalloc() is more clear,
although it does not sound as nice. If not, then I suppose at least add
a comment explaining the intended usage.

>
>> set API. Do we need to export them? I think users should not have to
>> worry about block management. They should read, set, or clear entries
>> using the iterators, and internally the block management should take of
>> allocation or freeing. So here for example, I th
>
> something is missing :-)

I don't remember what I meant to say anymore :-/

[...]
>> > +/**
>> > + * kho_block_set_init - Initialize a block set.
>> > + * @bs:         The block set to initialize.
>> > + * @entry_size: The size of each entry in the blocks.
>> > + */
>> > +void kho_block_set_init(struct kho_block_set *bs, size_t entry_size)
>> > +{
>> > +	*bs = (struct kho_block_set)KHO_BLOCK_SET_INIT(*bs, entry_size);
>> > +}
>> > +
>> > +static inline u64 kho_block_count_per_block(struct kho_block_set *bs)
>> > +{
>> > +	if (unlikely(!bs->count_per_block)) {
>> > +		bs->count_per_block = (KHO_BLOCK_SIZE -
>> > +				       sizeof(struct kho_block_header_ser)) /
>> > +				      bs->entry_size;
>> > +		WARN_ON(!bs->count_per_block);
>> > +	}
>> > +	return bs->count_per_block;
>> > +}
>> 
>> This looks odd. I don't see a reason to calculate this lazily. Why not
>> just do it when initializing the block set, in kho_block_set_init() or
>> kho_block_restore()? And then use bs->count_per_block directly.
>
> This allows for blocks to use static initilziation, I like static inits 
> :-)

You can do this:

#define KHO_BLOCK_SET_INIT(_name, _entry_size) {                        \
	.blocks = LIST_HEAD_INIT((_name).blocks),                       \
	.entry_size = _entry_size,                                      \
	.count_per_block = (KHO_BLOCK_SIZE - sizeof(struct kho_block_header_ser)) / (_entry_size), \
}

Compiles for me.

[...]
>> > +void kho_block_destroy(struct kho_block_set *bs)
>> > +{
>> > +	u64 head_pa = bs->head_pa;
>> > +	struct kho_block *block;
>> > +
>> > +	while (!list_empty(&bs->blocks)) {
>> > +		block = list_first_entry(&bs->blocks, struct kho_block, list);
>> > +		list_del(&block->list);
>> > +		kfree(block);
>> > +	}
>> 
>> Nit:
>> 
>> 	list_for_each_entry_safe(block, tmp, &bs->blocks, list) {
>> 		list_del(&block->list);
>> 		kfree(block);
>> 	}
>> 
>> is a bit more idiomatic (and IMO easier to read).
>
> Sure
>
>> 
>> > +	bs->nblocks = 0;
>> > +	bs->head_pa = 0;
>> > +
>> > +	while (head_pa) {
>> > +		struct kho_block_header_ser *ser = phys_to_virt(head_pa);
>> > +
>> > +		head_pa = ser->next;
>> > +		kho_block_free_ser(bs, ser);
>> 
>> Nit: also, can't you put this also in the previous loop? Something like:
>> 
>> 	list_for_each_entry_safe(block, tmp, &bs->blocks, list) {
>> 		list_del(&block->list);
>> 		kho_block_free_ser(block->ser);
>> 		kfree(block);
>> 	}
>
> We actually can't merge these into a single loop because of partial 
> restoration failures handling in kho_block_restore().
>
> If kho_block_restore fails halfway through restoring a chain of blocks 
> (for example, if kho_block_add fails on block 3 of 5), we jump to the 
> err_destroy cleanup path which calls kho_block_destroy().
>
> At this point:
> - bs->blocks only contains the tracked blocks we successfully added 
>   (blocks 1 and 2).
> - bs->head_pa still points to the physical head of the entire 5-block 
>   incoming chain.
>
> But, this is a good place to add a comment.

IMO it would be cleaner for kho_block_destroy() to destroy the currently
initialized block set, and then the error handling path in restore path
can clean up the rest.

>
>> > +	}
>> > +}
[...]
>> > +/**
>> > + * kho_block_it_prev - Return the previous entry slot in the block set.
>> > + * @it: The block iterator.
>> > + *
>> > + * If the current index is at the start of a block, it automatically moves to
>> > + * the end of the previous block.
>> > + *
>> > + * Return: A pointer to the previous entry slot, or NULL if at the very
>> > + * beginning of the block set.
>> > + */
>> > +void *kho_block_it_prev(struct kho_block_it *it)
>> > +{
>> > +	if (!it->block)
>> > +		return NULL;
>> > +
>> > +	if (it->i == 0) {
>> > +		if (list_is_first(&it->block->list, &it->bs->blocks))
>> > +			return NULL;
>> > +		it->block = list_prev_entry(it->block, list);
>> > +		it->i = kho_block_count_per_block(it->bs);
>> > +	}
>> > +
>> > +	return (void *)(it->block->ser + 1) + (--it->i * it->bs->entry_size);
>> > +}
>> > +
>> > +/**
>> > + * kho_block_it_finalize - Finalize the current block by setting its entry count.
>> > + * @it: The block iterator.
>> > + */
>> > +void kho_block_it_finalize(struct kho_block_it *it)
>> > +{
>> > +	if (it->block)
>> > +		it->block->ser->count = it->i;
>> > +}
>> 
>> Doesn't kho_block_it_next() already do this when you add an entry? So
>> this seems redundant.
>
> It is not redundant because of how the final partially-fille block is handled.
>
> kho_block_it_next() only writes the count into the block header when a block is completely full and it is advancing to the next one:
>
> if (it->i == kho_block_count_per_block(it->bs)) {
>     it->block->ser->count = it->i;
>     ...
>
> But for the very last block in the set, it is usually only partially
> filled (e.g., we write 10 entries into a block with a capacity of 64).
> Since it->i never reaches the maximum capacity, kho_block_it_next()
> never commits its count.
>
> Pasha

I think we can make kho_block_it_next() always write it. I think it
makes sense from an API point of view, since I see this API as "adding
an entry to the block set", so updating its internal counters makes
sense.

Requiring the finalize will be error prone, since it is easy to forget.
Then you silently lose some entries on the next boot.

-- 
Regards,
Pratyush Yadav

