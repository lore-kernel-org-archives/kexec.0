Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E95CD6E5D
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 02:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9MJOr97mrATixEW5kehH0DvlyrDDJP/7LhB74lpVfHs=; b=r8ljDsFr1tHSluhFGMXelwL8yK
	kro9ZTqOU3dHSdppVhCmY56LxNypYsk2nzk+cw+LrBwdBHjglgP1viqTnYocGUX5y76wjaah7d4xH
	vI/53Bl8QCPjYpLQwYCXhzKF0oS5ybpo4kLXPOLDLRCdgTjhwNYCKHEv4j04knwxqCZcLunb3j7DW
	WZpteT5OOumleXngznqwJAIQY7eW7sweoJdLa/CdOAdVyi8YEUxXVkvUqGRVMKXTmXKNN4TcVakAe
	uPCy2x0p1Wk4hd4Z64FtosSnGEgz5LI3iDV8xWnpTxUbtpEn1XidKkl/uzVoz+EtLMiaTuH3WjKc1
	eEgCnRqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUbEc-0000000E63G-1LMr;
	Wed, 03 Jun 2026 02:21:34 +0000
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUbEZ-0000000E62n-3Mrb
	for kexec@lists.infradead.org;
	Wed, 03 Jun 2026 02:21:33 +0000
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-516d634956fso138897401cf.2
        for <kexec@lists.infradead.org>; Tue, 02 Jun 2026 19:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780453290; x=1781058090; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9MJOr97mrATixEW5kehH0DvlyrDDJP/7LhB74lpVfHs=;
        b=QI+pyUCAm8yu0uLUuazoemuBb7V3b4/wXN0PJFHG+cCsLtQRNEd1mpcMZAtcQSHCQp
         xmSd9igbqQb3PdgogFmFMjfPAW+dtOmeGgZoC7S2ab0fRDLGQFqL93M36I1KiQoI3mxl
         sVLplwpF++RBKCpHA/8LLa7hwpTJXsdJLP2zvet7XQ5rF9N9FnI0qGoM+ir5b8GvEak8
         m+ZrOA3MeKJTOkTvRWfvMDT/gXIU79oMxo4pJtHXLKuCFtlXry/rtX+xHrto8qQUY+0f
         xegMna+wuedgDvINu7J2BRaQzV1Bhx0ftqHH/isUJZGc6OAsnlxdkhw9cSVclG4e1Dhk
         i35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780453290; x=1781058090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9MJOr97mrATixEW5kehH0DvlyrDDJP/7LhB74lpVfHs=;
        b=juwztxnhjwHYuqoQXZT7MKKQjdc/GVMHnS4TbnEvULGRVtrKizJAtrb3BoNVvFYh9n
         k2M8LBGg8rqPsQRaYtM5ACmbp3k4qEXnXxGJCeEoFp6ATppemK3+v+ZH8koWyqMt5eg1
         1IUbO17/hJGGZXygiyPZeTeIuWCkBgcLpuXfsd/rzOJFIu2eCt44CQoSloubKoiM2g7w
         EQmotGS5zx+0wB54qY/nxpx3P1/2k3KHG747RVvoOpKaq1/7zO1nnEvwjDK7ISuL8/g4
         2JQt/qt8hdslTHJl7n1+N3rFr8iU/6j6CvuhWBLXIkMhmSHt6GU2q8WNbFgFesWgV+W4
         kmNg==
X-Forwarded-Encrypted: i=1; AFNElJ+waDq1MuOOVBD2SXcPESkJPQY+iQ8WioSAg6Bt4MwvIKW5bM4Hz8eO238FsiXSMewR/Ekyjg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxjWVDA914OJ4xzOinUJTxHaBBuoLi3mgXQgk0TGlpLanHrfrSc
	ORR3M+NbRl9DRQtSE4iSJU7MzX5P8ltmKrMRN/ZxRjB+f7WTGiHEY5XKzR8T/KFHPiE=
X-Gm-Gg: Acq92OFOVJcEYFXhswNtABo7C7GibkBeof+SSw90VABW9cRuBpLZzvpPVfFDCFLRUvB
	mnM4r5nMdBaMBn3+j3ZTYjDg1Nxwkq/8T7LwHk88eeyuDefKV4KBpqye1kaCJlSSF1GvW2Z8c9a
	Lyj81yVXDNDyaqy5w6x6McpVd2LMuwdB/4On5f8XRf8ia78A7d9nUk1B3zG51O15Zb1ohI21nPL
	8GrFJ8qdBvQu60hChtVXmTZJ7ni+QI1eD/9A4q+OVI59yL+VwTyNn5D2wFhmbmO/swg7ED0/sDV
	C0A+JvXah8PVF3gopujn5KfaWcRGCg5ykH9KzuULVOH0SLGGgCT1qvHi5mS5loULPgp86U//9uk
	5lpWK0qKFX2mx57DGzQSu8k8SoINZBVX81NlpJAayuLAB3lZSDYmRpYIR5/sWKZ8BGOoP6kzVYO
	JeVw/XDfQNqp3pBKhYbJb2FbP97PZ4cm9w3xHYaiJAqK+2tbrYQwThrBRGIBAfAQ==
X-Received: by 2002:a05:622a:306:b0:50d:9e8d:9837 with SMTP id d75a77b69052e-517785adec6mr26502311cf.11.1780453289820;
        Tue, 02 Jun 2026 19:21:29 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd06d600sm8167806d6.35.2026.06.02.19.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 19:21:29 -0700 (PDT)
Date: Wed, 3 Jun 2026 02:21:28 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	linux-kselftest@vger.kernel.org, shuah@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	corbet@lwn.net, dmatlack@google.com, kexec@lists.infradead.org, 
	pratyush@kernel.org, skhawaja@google.com, graf@amazon.com
Subject: Re: [PATCH v4 07/13] kho: add support for linked-block serialization
Message-ID: <ah75uAV8uPtS0XNj@plex>
References: <20260530221938.115978-1-pasha.tatashin@soleen.com>
 <20260530221938.115978-8-pasha.tatashin@soleen.com>
 <178038801491.119771.18384706761138506132.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178038801491.119771.18384706761138506132.b4-review@b4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_192131_868152_81693FFD 
X-CRM114-Status: GOOD (  43.73  )
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

On 06-02 11:13, Mike Rapoport wrote:
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

user and module are not descriptive, as the same client/user/module can 
use multiple kho_block_set for different purposes. I suggest:

"struct kho_block_set - A set of blocks containing serialized entries of 
the same type."

> 
> > + * @blocks:          The list of serialization blocks (struct kho_block).
> > + * @nblocks:         The number of allocated serialization blocks.
> > + * @head_pa:         Physical address of the first block header.
> > + * @entry_size:      The size of each entry in the blocks.
> 
> I think it's "... entry in a block"

It is 'in the blocks' (or 'across the blocks') because a single  
block_set  can contain multiple blocks, and they all share this same 
uniform entry size.

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

We have already started using kho_block_set. Although it is longer, I 
prefer to avoid kho_blocks/kho_block because the subtle difference makes 
them difficult to read and prone to typos during coding. Let's use 
kho_block_set for operations on a block_set.

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

Fixed.

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

Done

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

Done.

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

Linked blocks are not internally synchronized; that is a responsibility 
of the caller, similar to linked lists.

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

Changed the semantics to use target count, i.e. "The target number of 
valid entries to accommodate."

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

OK

> 
> > + *
> > + * This function checks if the last block in the set is redundant based on the
> > + * total entry count and the capacity of the preceding blocks. If the entry
> > + * count can be accommodated by the blocks that come before the last one, the
> > + * last block is destroyed and removed from the set.
> 
> This should mention that it's the caller responsibility to ensure that
> entries are removed in the right order.

OK

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

OK

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

Done

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

Sure, done.

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

The new name  kho_block_set_it_reserve_entry()  clarifies that this is a 
write/reservation path function (unlike the original read-only  next  
name). Reserving a slot to write entries naturally implies 
writing/finalizing the metadata count in the physical block header when 
a block becomes full

> > +		if (list_is_last(&it->block->list, &it->bs->blocks))
> > +			return NULL;
> > +		it->block = list_next_entry(it->block, list);
> > +		it->i = 0;
> > +	}
> > +
> > +	return (void *)(it->block->ser + 1) + (it->i++ * it->bs->entry_size);
> 
> In a month we'll need an LLM's help to understand what it does.

Good thing in a month we will have even stronger LLMs to help us :-)

Anyways, clean-up ...

> 
> > +}
> > +
> > +/**
> > + * kho_block_it_read - Return the next entry slot for reading.
> > + * @it: The block iterator.
> 
> And what is the conceptual difference between this and _it_next()?

This was updated :-)

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

Done

> 
> -- 
> Sincerely yours,
> Mike.
> 

