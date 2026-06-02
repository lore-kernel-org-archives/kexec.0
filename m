Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F5DC5DF71
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 09:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YK7nPi0tW7xOJJ+rs9iJg96pyNtnhvTqAYo6vr2NvGk=; b=ZSMTzQAlSH7e9jejj52+E1f63Y
	Sk/dwLV+LrUOcb0XjnFqgj4hUdviUESpeGMZunuZCUX32AJ+zIJ9b9dxN+Ddmi/MR7fLSr0IKWUsO
	xlE2KaH9zBFrezNhJ9vRUsJ511OGp0A8IiB6g+dYht22AU08dgB3zDfYfEhN79SqToWS1HK84e1aw
	9aAWgJHWyn1CrYzGaKGTJx/rEPFigu+2Ycp+Q3D0QIU5md5YIMt7r+2SRXMmRq2IXqsHxmSDYhZXs
	oCvTC78dcTTz005uMExAPy+NZ5E5MMMXzGm/e1Fd+Olb1Ki5f23KmctfI8DvMC0Lqd2pkdugbc1r8
	x+l6VAeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUL35-0000000CcgU-0847;
	Tue, 02 Jun 2026 09:04:35 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUL33-0000000Ccfk-02T9
	for kexec@lists.infradead.org;
	Tue, 02 Jun 2026 09:04:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6665540764;
	Tue,  2 Jun 2026 09:04:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4731F00893;
	Tue,  2 Jun 2026 09:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780391072;
	bh=YK7nPi0tW7xOJJ+rs9iJg96pyNtnhvTqAYo6vr2NvGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lnxzKj7IrPLfc2t0iaFFJOV+C2Y8Xl8+qzWEz83ezFGICUcb1TY6kx6RFQMfP/Guc
	 92hNhe/kxem7KXEENmWaTBxZhrshAz8qpay0dCJxL6JnRVFLLAb6qFZahZcyzhciOx
	 eqb/Uj0mWSn9r0qRVCwEBGIeD6u9US8d//COgUsnMTYnLmwbVM3qC1KnsBUcKy8xfd
	 IoMwNwpf1l6msR4NLCsXeZdGbxCTDPcwBZECA3HP74Tq87aa1y/jSVNzWjRMAY4dvg
	 ZGRDSTHkG60FtEUinKahdXazT8pYthcQDEGV6XTlQ534d3zA2cfe5jR2pTL29pcswO
	 wm/+EXD/C+mbQ==
Date: Tue, 2 Jun 2026 12:04:24 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org, shuah@kernel.org,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net, dmatlack@google.com,
	kexec@lists.infradead.org, pratyush@kernel.org, skhawaja@google.com,
	graf@amazon.com
Subject: Re: [PATCH v4 07/13] kho: add support for linked-block serialization
Message-ID: <ah6cmLDuy3EwbDu_@kernel.org>
References: <20260530221938.115978-1-pasha.tatashin@soleen.com>
 <20260530221938.115978-8-pasha.tatashin@soleen.com>
 <178038801491.119771.18384706761138506132.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178038801491.119771.18384706761138506132.b4-review@b4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_020433_100890_55B47BFA 
X-CRM114-Status: GOOD (  41.39  )
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

I sent it before seeing v5, so some of those are already addressed, but
please take a look anyway.

On Tue, Jun 02, 2026 at 11:13:34AM +0300, Mike Rapoport wrote:
> On Sat, 30 May 2026 22:19:32 +0000, Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> > diff --git a/include/linux/kho_block.h b/include/linux/kho_block.h
> > new file mode 100644
> > index 000000000000..5e6b87b1befa
> > --- /dev/null
> > +++ b/include/linux/kho_block.h
> > @@ -0,0 +1,79 @@
> > [ ... skip 19 lines ... ]
> > +	struct list_head list;
> > +	struct kho_block_header_ser *ser;
> > +};
> > +
> > +/**
> > + * struct kho_block_set - A set of blocks that belong to the same object.
> 
> "same object" sounds off to me. The blocks belong to the same module?
> user?
> 
> Thoughts?
> 
> > + * @blocks:          The list of serialization blocks (struct kho_block).
> > + * @nblocks:         The number of allocated serialization blocks.
> > + * @head_pa:         Physical address of the first block header.
> > + * @entry_size:      The size of each entry in the blocks.
> 
> I think it's "... entry in a block"
> 
> > [ ... skip 42 lines ... ]
> > +
> > +void kho_block_it_init(struct kho_block_it *it, struct kho_block_set *bs);
> > +void *kho_block_it_next(struct kho_block_it *it);
> > +void *kho_block_it_read(struct kho_block_it *it);
> > +void *kho_block_it_prev(struct kho_block_it *it);
> > +void kho_block_it_finalize(struct kho_block_it *it);
> 
> These operate on block sets, should be reflected in the names.
> Can be kho_blocks_ to avoid too long names.
> 
> >
> > diff --git a/kernel/liveupdate/kho_block.c b/kernel/liveupdate/kho_block.c
> > new file mode 100644
> > index 000000000000..a4e650af946f
> > --- /dev/null
> > +++ b/kernel/liveupdate/kho_block.c
> > @@ -0,0 +1,384 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * Copyright (c) 2026, Google LLC.
> > + * Pasha Tatashin <pasha.tatashin@soleen.com>
> > + */
> > +
> > +/**
> > + * DOC: KHO Serialization Blocks
> > + *
> > + * KHO provides a mechanism to preserve stateful data across a kexec handover
> > + * by serializing it into memory blocks. This file provides the common
> 
> "This file" does not look good in HTML docs.
> 
> > [ ... skip 15 lines ... ]
> > +
> > +/*
> > + * Safeguard limit for the number of serialization blocks. This is used to
> > + * prevent infinite loops and excessive memory allocation in case of memory
> > + * corruption in the preserved state.
> > + */
> 
> Can you add how much memory it is and how many entries with, say, 4 u64
> it can accommodate?
> 
> > [ ... skip 13 lines ... ]
> > +{
> > +	if (unlikely(!bs->count_per_block)) {
> > +		bs->count_per_block = (KHO_BLOCK_SIZE -
> > +				       sizeof(struct kho_block_header_ser)) /
> > +				      bs->entry_size;
> > +		WARN_ON(!bs->count_per_block);
> 
> Don't you want to set count_per_block in _init()?
> 
> > [ ... skip 29 lines ... ]
> > +	if (!block)
> > +		return -ENOMEM;
> > +
> > +	block->ser = ser;
> > +	last = list_last_entry_or_null(&bs->blocks, struct kho_block, list);
> > +	list_add_tail(&block->list, &bs->blocks);
> 
> No locks?
> 
> > [ ... skip 12 lines ... ]
> > + * @bs:    The block set.
> > + * @count: The current number of entries.
> > + *
> > + * This function handles the dynamic expansion of a block set. It allocates
> > + * and links a new serialization block if the provided entry count matches
> > + * the current total capacity of the set.
> 
> This is a weird semantics for a generic API. I'd expect _grow() would
> add count - current_count blocks.
> 
> > [ ... skip 25 lines ... ]
> > +}
> > +
> > +/**
> > + * kho_block_shrink - Conditionally destroy the last block in a block set.
> > + * @bs:              The block set.
> > + * @count:           The current number of entries across all blocks.
> 
> Maybe 
>  	... of valid entries?
> 
> > + *
> > + * This function checks if the last block in the set is redundant based on the
> > + * total entry count and the capacity of the preceding blocks. If the entry
> > + * count can be accommodated by the blocks that come before the last one, the
> > + * last block is destroyed and removed from the set.
> 
> This should mention that it's the caller responsibility to ensure that
> entries are removed in the right order.
> 
> > [ ... skip 49 lines ... ]
> > +
> > +		fast = phys_to_virt(fast->next);
> > +		slow = phys_to_virt(slow->next);
> > +
> > +		if (slow == fast) {
> > +			pr_err("Cyclic list detected\n");
> 
> Maybe "block set is corrupted"?
> 
> > +			return false;
> > +		}
> > +	}
> > +
> > +	return true;
> > +}
> > +
> > +/**
> > + * kho_block_restore - Restore a block set from a physical address.
> > + * @bs:      The block set to restore.
> > + * @head_pa: Physical address of the first block header.
> 
> I'd mention that the block set should be allocated and initialized
> 
> > [ ... skip 10 lines ... ]
> > +	bs->incoming = true;
> > +	if (!head_pa)
> > +		return 0;
> > +
> > +	bs->head_pa = head_pa;
> > +	if (!kho_cyclic_blocks_check(bs)) {
> 
> if (kho_block_set_cyclic()) 
> 
> reads nicer IMO
> 
> > [ ... skip 87 lines ... ]
> > +{
> > +	if (!it->block)
> > +		return NULL;
> > +
> > +	if (it->i == kho_block_count_per_block(it->bs)) {
> > +		it->block->ser->count = it->i;
> 
> Why iterator updates ser->count?
> 
> > +		if (list_is_last(&it->block->list, &it->bs->blocks))
> > +			return NULL;
> > +		it->block = list_next_entry(it->block, list);
> > +		it->i = 0;
> > +	}
> > +
> > +	return (void *)(it->block->ser + 1) + (it->i++ * it->bs->entry_size);
> 
> In a month we'll need an LLM's help to understand what it does.
> 
> > +}
> > +
> > +/**
> > + * kho_block_it_read - Return the next entry slot for reading.
> > + * @it: The block iterator.
> 
> And what is the conceptual difference between this and _it_next()?
> 
> > [ ... skip 49 lines ... ]
> > + * @it: The block iterator.
> > + */
> > +void kho_block_it_finalize(struct kho_block_it *it)
> > +{
> > +	if (it->block)
> > +		it->block->ser->count = it->i;
> 
> So, it looks like the intention of _it_next is for write, and this ends a
> write iteration.
> 
> I think the names should be adjusted to make it clearer.
> 
> -- 
> Sincerely yours,
> Mike.
> 

-- 
Sincerely yours,
Mike.

