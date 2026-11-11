Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E770606A888
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 11:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FGxslJsj;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SG9tFMpB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=PStEUSkX+1yhjx9hF8qKMw4AbqqWqwkP6MwbN4MhM6I=; b=FGxslJsjMI9AbU
	pyQogpi8Fv9SkkghGgm6mCYNJlPQSjz5SFh6x40mlvi5dWichJSk0QnIl+Au+KJtWu/nd+D6rARF+
	VJOx8Goza/ZOIQp3IflOr2w/dAwb7NJDBC0QLEp3pmNfIouUbztsPJexGMhv0NBAxD6gu0/y8j8BC
	xwmgH3ZqgJDWaO1wezExN0fIjtaUoV2oy+PSsd1GewIOGkLzmDFYhMfnj3tlxw1o2aldQSGBUn3mD
	G5idTZZCO78sUUyoU3W1BdjsVuG4Up00/NOku1a2lHErznLtMyKcfUztiW7cMuc+41GcGUiEif5AV
	nUwqYZ0uPkjVH1xf82Hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR6Lu-00000006SwX-0hOK;
	Wed, 11 Nov 2026 11:18:54 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR6Ls-00000006SvL-1Dcf
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 11:18:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BA5D362EC1;
	Wed, 11 Nov 2026 11:18:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA7E1F00A06;
	Wed, 11 Nov 2026 11:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794395931;
	bh=PStEUSkX+1yhjx9hF8qKMw4AbqqWqwkP6MwbN4MhM6I=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=SG9tFMpBduAay2CvpwqJuQOM30xPquK1LEBTAvF8mPFlhiTXLGCFIoXChRYEIhzGW
	 NMzBLNxWyhwQx2pR/UqQMma8sXH6BYOGfZviMJ+RGFfOUtu/kf8VmCmazOV8TDw5U+
	 +1evhbDmoNgM3z7JXXESOHo83v78CYCUmqNImYjARvLnLg6tiECf1hfp+DpLkBep/s
	 YpnrJH07pEyYs67YlYna1NXvWvtrHsRrsnCEPfbx1kTGqbJy1vJfbagC7rECt4g7DW
	 4Q726YcDvVbMW0WTfecrndaVc28chS5EgXIyeQAbSfqEHFjel2z/gEGzC59zg0vr2J
	 gY4JKxszzUi4g==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 2/6] kho: support incremental entry publication in
 kho_block
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org, rppt@kernel.org, shuah@kernel.org, 
 linux-mm@kvack.org, skhan@linuxfoundation.org, linux-doc@vger.kernel.org, 
 vipinsh@google.com, linux-kernel@vger.kernel.org, corbet@lwn.net, 
 dmatlack@google.com, kexec@lists.infradead.org, pratyush@kernel.org, 
 rdunlap@infradead.org, graf@amazon.com
In-Reply-To: <20261105050053.3063001-3-pasha.tatashin@soleen.com>
References: <20261105050053.3063001-1-pasha.tatashin@soleen.com>
 <20261105050053.3063001-3-pasha.tatashin@soleen.com>
Date: Wed, 11 Nov 2026 13:18:40 +0200
Message-Id: <179439592040.425130.12391503339294194908.b4-review@b4>
X-Mailer: b4 0.16.1-dev
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

> To allow LUO sessions to be frozen and committed into the outgoing KHO
> subtree from userspace ahead of reboot, kho_block needs to support
> publishing entries one by one into a live serialized block chain while
> new blocks may still be preallocated or shrunk for uncommitted sessions.
> 
> Currently, kho_block assumes outgoing block sets are populated in a
> single batch during reboot() before the chain is exposed: preallocated
> blocks are linked onto the chain immediately even while empty
> (ser->count == 0), and reserving a slot increments ser->count before the
> entry is populated.
> 
> Address this by keeping preallocated outgoing blocks unlinked in
> kho_block_add(), linking blocks lazily only as entries are written. Add
> kho_block_set_it_append() to copy each entry into its slot before
> publishing the updated ser->count and next-block link via
> smp_store_release(), paired with smp_load_acquire() in
> kho_block_set_it_read_entry().
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  include/linux/kho_block.h     |  1 +
>  kernel/liveupdate/kho_block.c | 86 +++++++++++++++++++++++++++++++----
>  2 files changed, 77 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/kho_block.h b/include/linux/kho_block.h
> index 93a7cc2be5f51..a9e696ef3e08e 100644
> --- a/include/linux/kho_block.h
> +++ b/include/linux/kho_block.h
> @@ -100,6 +100,7 @@ static inline bool kho_block_set_is_empty(struct kho_block_set *bs)
>  
>  void kho_block_set_it_init(struct kho_block_set_it *it, struct kho_block_set *bs);
>  void *kho_block_set_it_reserve_entry(struct kho_block_set_it *it);
> +void *kho_block_set_it_append(struct kho_block_set_it *it, const void *src);
>  void *kho_block_set_it_read_entry(struct kho_block_set_it *it);
>  void *kho_block_set_it_prev(struct kho_block_set_it *it);
>  
> diff --git a/kernel/liveupdate/kho_block.c b/kernel/liveupdate/kho_block.c
> index 0d2a342ef4228..2813c6fd593c4 100644
> --- a/kernel/liveupdate/kho_block.c
> +++ b/kernel/liveupdate/kho_block.c
> @@ -16,6 +16,12 @@
>   * array of serialized entries. Multiple blocks are linked together via a
>   * physical pointer in the header, forming a linked list that can be easily
>   * traversed in both the current and the next kernel.
> + *
> + * Outgoing blocks preallocated via kho_block_set_grow() remain unlinked until
> + * entries are written into them. Callers publishing entries incrementally into
> + * a live KHO subtree can use kho_block_set_it_append(), which populates each
> + * entry before exposing the updated block count or next-block link via
> + * release-store ordering.


>   */
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> @@ -93,9 +99,7 @@ static int kho_block_add(struct kho_block_set *bs,
>  	list_add_tail(&block->list, &bs->blocks);
>  	bs->nblocks++;
>  
> -	if (last)
> -		last->ser->next = virt_to_phys(ser);
> -	else
> +	if (!last)
>  		bs->head_pa = virt_to_phys(ser);


>  
>  	return 0;
> @@ -129,14 +133,15 @@ static void kho_block_set_shrink_one(struct kho_block_set *bs)
>  	last = list_last_entry(&bs->blocks, struct kho_block, list);
>  	list_del(&last->list);
>  	bs->nblocks--;
> -	kho_block_free_ser(bs, last->ser);
> -	kfree(last);
>  
>  	new_last = list_last_entry_or_null(&bs->blocks, struct kho_block, list);
>  	if (new_last)
> -		new_last->ser->next = 0;
> +		WRITE_ONCE(new_last->ser->next, 0);

Why this is needed? Docs explicitly state that "Synchronization and
locking are the responsibility of the caller".

>  	else
>  		bs->head_pa = 0;
> +
> +	kho_block_free_ser(bs, last->ser);
> +	kfree(last);

This change seems unnecessary.

>  }
>  
>  /**
> @@ -144,9 +149,9 @@ static void kho_block_set_shrink_one(struct kho_block_set *bs)
>   * @bs:    The block set.
>   * @count: The target number of valid entries to accommodate.
>   *
> - * Dynamically preallocates and links preserved memory blocks if the target
> - * entry count exceeds the current total capacity of the set, ensuring they
> - * are available during serialization/deserialization.
> + * Dynamically preallocates preserved memory blocks if the target entry count
> + * exceeds the current total capacity of the set, ensuring they are available
> + * during serialization/deserialization.
>   *
>   * Context: Caller must hold a lock protecting the block set.
>   * Return: 0 on success, or a negative errno on failure.
> @@ -318,6 +323,7 @@ void kho_block_set_clear(struct kho_block_set *bs)
>  	struct kho_block *block;
>  
>  	list_for_each_entry(block, &bs->blocks, list) {
> +		block->ser->next = 0;
>  		block->ser->count = 0;
>  		memset(block->ser + 1, 0, KHO_BLOCK_SIZE - sizeof(*block->ser));
>  	}
> @@ -348,6 +354,7 @@ void kho_block_set_it_init(struct kho_block_set_it *it, struct kho_block_set *bs
>   */
>  void *kho_block_set_it_reserve_entry(struct kho_block_set_it *it)
>  {
> +	struct kho_block *prev = NULL;
>  	void *entry;
>  
>  	if (!it->block)
> @@ -356,15 +363,73 @@ void *kho_block_set_it_reserve_entry(struct kho_block_set_it *it)
>  	if (it->i == it->bs->count_per_block) {
>  		if (list_is_last(&it->block->list, &it->bs->blocks))
>  			return NULL;
> +		prev = it->block;
>  		it->block = list_next_entry(it->block, list);
>  		it->i = 0;
>  	}
>  
> +	if (!it->i)
> +		it->block->ser->next = 0;
> +
>  	entry = kho_block_entry(it, it->i++);
>  	it->block->ser->count = it->i;
> +	if (prev)
> +		prev->ser->next = virt_to_phys(it->block->ser);

kernel-doc should mention that this function now links blocks.

And I believe there should be a paragraph about the new flow in the DOC:
section.

> +
>  	return entry;
>  }
>  
> +/**
> + * kho_block_set_it_append - Write and publish an entry at the next slot.
> + * @it:  The block iterator.
> + * @src: Entry data of size @it->bs->entry_size to copy into the slot.
> + *
> + * Copies @src into the next available slot before updating the block's entry
> + * count or linking a newly occupied block to the previous block, so concurrent
> + * readers never observe an uninitialized slot or an empty block.
> + *
> + * Return: A pointer to the written entry slot, or NULL if the block set's
> + * capacity is fully exhausted.
> + */
> +void *kho_block_set_it_append(struct kho_block_set_it *it, const void *src)
> +{
> +	struct kho_block *prev = NULL;
> +	void *dst;
> +
> +	if (!it->block)
> +		return NULL;
> +
> +	if (it->i == it->bs->count_per_block) {
> +		if (list_is_last(&it->block->list, &it->bs->blocks))
> +			return NULL;
> +		prev = it->block;
> +		it->block = list_next_entry(it->block, list);
> +		it->i = 0;
> +	}
> +
> +	if (!it->i)
> +		WRITE_ONCE(it->block->ser->next, 0);
> +
> +	dst = kho_block_entry(it, it->i++);
> +	memcpy(dst, src, it->bs->entry_size);
> +
> +	/*
> +	 * Ensure the serialized entry is visible before exposing the
> +	 * incremented count to concurrent readers.
> +	 */
> +	smp_store_release(&it->block->ser->count, it->i);
> +	if (prev) {
> +		/*
> +		 * Ensure the new block's first entry and header are visible
> +		 * before linking prev->ser->next for concurrent readers.
> +		 */
> +		smp_store_release(&prev->ser->next,
> +				  virt_to_phys(it->block->ser));

Until now the locking model was "the caller is responsible to hold a
lock".

Using WRITE_ONCE() and smp_store_release() instead of plain assignments
implies that it is not anymore, or at least not always.

This should be a well documented separate change.

-- 
Sincerely yours,
Mike.


