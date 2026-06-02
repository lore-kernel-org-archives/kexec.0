Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B8FC5DF71
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 08:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8677rqzPwCK7BT2bqGJkDF7s4XcZqoB/M7pK9qZ0mPI=; b=i/PeWs0mR0vVRqrSWWKkgaoHN4
	jH9Kjw+ANZcCo4SHG+eKFqEXXA3ZvQyUklkJMfiyeb6Cne5hb81aHuqccOmSmJ9N7SjkAiWh1+dUl
	Jx8mPrLkUDFOXE1x8trV8YCfPx3p8oNpwD9VNEOAPVQnMyNsTl5Hu09plH2ldyzqNToV5QG1iXRkS
	QOnumiCxnwJztGXrukX7Gtyi7fracVRjT6sKSeo37vMdvyMD77oHQL/hYUdET2aGLvATruWo7xixH
	VinDh2q5u/XSfPlMkJRXFlRhdGfJ85ufPgwyfuFX1ZAdau+RjLFRGDt/PxS5qaAQPQGgdUsss/Aiw
	ADVQ5azg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUKG4-0000000CXvF-3OIk;
	Tue, 02 Jun 2026 08:13:56 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUKG2-0000000CXu5-1kRi
	for kexec@lists.infradead.org;
	Tue, 02 Jun 2026 08:13:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7EF6343952;
	Tue,  2 Jun 2026 08:13:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363D11F00899;
	Tue,  2 Jun 2026 08:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780388033;
	bh=8677rqzPwCK7BT2bqGJkDF7s4XcZqoB/M7pK9qZ0mPI=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=WfMh9fz62CnhrepjlqZLoJaI2CY23PyiNds+OHaCi+8uuAOcT1mIy0T88mUaIDRN7
	 VEo98JrsdK7inKt4bTisyphkakz1/LUWeVEjGVxnQnzEQh30te7NE/d3u5dUKCU/Sp
	 wPGEPy5r5+gvz8EDne4kJsLtakhboDBaUh9HH1h/fzo6YBwPyIwDq8hTnkE7Abl/rW
	 rBRG2hDPLmDXN8AO9LsNJFSIriipy2mQ7gvrB5+sk5Ok3qhVEOZATuI9HYuHoPu0nm
	 BX4SXyAoytHokJpp16Qsr/aKFFNQWEC6fE2YyxvOYDXV6suIcEVxlYjw3EVHnzoZj8
	 HqwZWBRf5O/oQ==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 07/13] kho: add support for linked-block
 serialization
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org, rppt@kernel.org, shuah@kernel.org, 
 akpm@linux-foundation.org, linux-mm@kvack.org, skhan@linuxfoundation.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net, 
 dmatlack@google.com, kexec@lists.infradead.org, pratyush@kernel.org, 
 skhawaja@google.com, graf@amazon.com
In-Reply-To: <20260530221938.115978-8-pasha.tatashin@soleen.com>
References: <20260530221938.115978-1-pasha.tatashin@soleen.com>
 <20260530221938.115978-8-pasha.tatashin@soleen.com>
Date: Tue, 02 Jun 2026 11:13:34 +0300
Message-Id: <178038801491.119771.18384706761138506132.b4-review@b4>
X-Mailer: b4 0.15.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_011354_520745_EAC1BC8D 
X-CRM114-Status: GOOD (  31.83  )
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

On Sat, 30 May 2026 22:19:32 +0000, Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> diff --git a/include/linux/kho_block.h b/include/linux/kho_block.h
> new file mode 100644
> index 000000000000..5e6b87b1befa
> --- /dev/null
> +++ b/include/linux/kho_block.h
> @@ -0,0 +1,79 @@
> [ ... skip 19 lines ... ]
> +	struct list_head list;
> +	struct kho_block_header_ser *ser;
> +};
> +
> +/**
> + * struct kho_block_set - A set of blocks that belong to the same object.

"same object" sounds off to me. The blocks belong to the same module?
user?

Thoughts?

> + * @blocks:          The list of serialization blocks (struct kho_block).
> + * @nblocks:         The number of allocated serialization blocks.
> + * @head_pa:         Physical address of the first block header.
> + * @entry_size:      The size of each entry in the blocks.

I think it's "... entry in a block"

> [ ... skip 42 lines ... ]
> +
> +void kho_block_it_init(struct kho_block_it *it, struct kho_block_set *bs);
> +void *kho_block_it_next(struct kho_block_it *it);
> +void *kho_block_it_read(struct kho_block_it *it);
> +void *kho_block_it_prev(struct kho_block_it *it);
> +void kho_block_it_finalize(struct kho_block_it *it);

These operate on block sets, should be reflected in the names.
Can be kho_blocks_ to avoid too long names.

>
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

"This file" does not look good in HTML docs.

> [ ... skip 15 lines ... ]
> +
> +/*
> + * Safeguard limit for the number of serialization blocks. This is used to
> + * prevent infinite loops and excessive memory allocation in case of memory
> + * corruption in the preserved state.
> + */

Can you add how much memory it is and how many entries with, say, 4 u64
it can accommodate?

> [ ... skip 13 lines ... ]
> +{
> +	if (unlikely(!bs->count_per_block)) {
> +		bs->count_per_block = (KHO_BLOCK_SIZE -
> +				       sizeof(struct kho_block_header_ser)) /
> +				      bs->entry_size;
> +		WARN_ON(!bs->count_per_block);

Don't you want to set count_per_block in _init()?

> [ ... skip 29 lines ... ]
> +	if (!block)
> +		return -ENOMEM;
> +
> +	block->ser = ser;
> +	last = list_last_entry_or_null(&bs->blocks, struct kho_block, list);
> +	list_add_tail(&block->list, &bs->blocks);

No locks?

> [ ... skip 12 lines ... ]
> + * @bs:    The block set.
> + * @count: The current number of entries.
> + *
> + * This function handles the dynamic expansion of a block set. It allocates
> + * and links a new serialization block if the provided entry count matches
> + * the current total capacity of the set.

This is a weird semantics for a generic API. I'd expect _grow() would
add count - current_count blocks.

> [ ... skip 25 lines ... ]
> +}
> +
> +/**
> + * kho_block_shrink - Conditionally destroy the last block in a block set.
> + * @bs:              The block set.
> + * @count:           The current number of entries across all blocks.

Maybe 
 	... of valid entries?

> + *
> + * This function checks if the last block in the set is redundant based on the
> + * total entry count and the capacity of the preceding blocks. If the entry
> + * count can be accommodated by the blocks that come before the last one, the
> + * last block is destroyed and removed from the set.

This should mention that it's the caller responsibility to ensure that
entries are removed in the right order.

> [ ... skip 49 lines ... ]
> +
> +		fast = phys_to_virt(fast->next);
> +		slow = phys_to_virt(slow->next);
> +
> +		if (slow == fast) {
> +			pr_err("Cyclic list detected\n");

Maybe "block set is corrupted"?

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

I'd mention that the block set should be allocated and initialized

> [ ... skip 10 lines ... ]
> +	bs->incoming = true;
> +	if (!head_pa)
> +		return 0;
> +
> +	bs->head_pa = head_pa;
> +	if (!kho_cyclic_blocks_check(bs)) {

if (kho_block_set_cyclic()) 

reads nicer IMO

> [ ... skip 87 lines ... ]
> +{
> +	if (!it->block)
> +		return NULL;
> +
> +	if (it->i == kho_block_count_per_block(it->bs)) {
> +		it->block->ser->count = it->i;

Why iterator updates ser->count?

> +		if (list_is_last(&it->block->list, &it->bs->blocks))
> +			return NULL;
> +		it->block = list_next_entry(it->block, list);
> +		it->i = 0;
> +	}
> +
> +	return (void *)(it->block->ser + 1) + (it->i++ * it->bs->entry_size);

In a month we'll need an LLM's help to understand what it does.

> +}
> +
> +/**
> + * kho_block_it_read - Return the next entry slot for reading.
> + * @it: The block iterator.

And what is the conceptual difference between this and _it_next()?

> [ ... skip 49 lines ... ]
> + * @it: The block iterator.
> + */
> +void kho_block_it_finalize(struct kho_block_it *it)
> +{
> +	if (it->block)
> +		it->block->ser->count = it->i;

So, it looks like the intention of _it_next is for write, and this ends a
write iteration.

I think the names should be adjusted to make it clearer.

-- 
Sincerely yours,
Mike.


