Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D1DCD98CF
	for <kexec@archiver.kernel.org>; Mon, 15 Jun 2026 13:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hk9Nj8auN43vzbdvT/JSZbvGvgTnYxbmgt2R+JraBvc=; b=NC6wHNqCk4bUDnzAHV//ks7ZON
	QUpRhEKaTcoySHml/xZhKO+8CCo8orqOLjBIEkSKHBFyoBnlF1hVAS2vokcCRBuJSJGibUR23QG9a
	0S0EEHKro+MrHLuA+CEINSRwOmUZ2CPenSuqSNrF0xMHQUCPvdhhN1EZtwK3IduP/1L26zJtwP+Dl
	X4OfNkjmVS3blNiRMh77EispBVM8X6TMtV8rJnZCrcc+M2B0FBa3UilraMHBHO7jCDBVQAc4EEtZM
	2o0fhJVl1FuMHAxERSkvTU82HO8LlEeR/AviEZ4DuQsCNQdowqNrjEIGYQsNooa6ioxD8uOjIURIC
	hO/ckL9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZ7MH-0000000EIhf-3Pev;
	Mon, 15 Jun 2026 13:28:09 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZ7MG-0000000EIhQ-1Xsj
	for kexec@lists.infradead.org;
	Mon, 15 Jun 2026 13:28:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8B8B26008A;
	Mon, 15 Jun 2026 13:28:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E6E1F00A3A;
	Mon, 15 Jun 2026 13:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781530087;
	bh=Hk9Nj8auN43vzbdvT/JSZbvGvgTnYxbmgt2R+JraBvc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=LOfb/H7VzPAB1K8lpgRTYzUUcJ/tP2I0kzJpw3yOJnf8DpSSp2mquhYMvIuTgrdZt
	 9wF32sfQ08nw6W3IoWJRf6paLh1keR4Xjb1bolfmtelTzWb/0JQNpKGYthZX/+u/JE
	 6TqMWEXJ+C/0VMaz48vmscxqdNMNYLuBqRLelkW5e26kyg9eTF60lwiLu31/NqN3kN
	 Uywgp78ADqMBBekdqawyyi35yJIQqMgIcCraQnKfpfWSQ+ftOzZFDj3eFJ7EjlvLRY
	 j/DjatVH1Tp5nZuJXTLiTSmyflvWbN2QU32tJMMjgrfKhiWZpNBImZbM+bzDFFtp6q
	 /WiwAuWpDtzOw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Alexander Graf <graf@amazon.com>,  Muchun
 Song <muchun.song@linux.dev>,  Oscar Salvador <osalvador@suse.de>,  David
 Hildenbrand <david@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Jason Miu <jasonmiu@google.com>,  Jork
 Loeser <jloeser@linux.microsoft.com>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 15/18] kho: extend scratch
In-Reply-To: <178143855117.2123877.6330314807920146675.b4-review@b4> (Mike
	Rapoport's message of "Sun, 14 Jun 2026 15:02:31 +0300")
References: <20260605183501.3884950-1-pratyush@kernel.org>
	<20260605183501.3884950-16-pratyush@kernel.org>
	<178143855117.2123877.6330314807920146675.b4-review@b4>
Date: Mon, 15 Jun 2026 15:28:03 +0200
Message-ID: <2vxztsr4orvg.fsf@kernel.org>
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

On Sun, Jun 14 2026, Mike Rapoport wrote:

> On Fri, 05 Jun 2026 20:34:48 +0200, Pratyush Yadav <pratyush@kernel.org> wrote:
>> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
>> index af22086ca2d6..8540608b8602 100644
>> --- a/kernel/liveupdate/kexec_handover.c
>> +++ b/kernel/liveupdate/kexec_handover.c
>> @@ -869,6 +886,119 @@ static void __init kho_reserve_scratch(void)
>>  	kho_enable = false;
>>  }
>>  
>> +#define KHO_EXT_SHIFT 30 /* 1 GiB */
>
> Please add a comment why exactly 1 Gib.
> I'd also define a size macro as SZ_1G and make shift const_ilog2(SIZE)

ACK.

>
>> +
>> +static int __init kho_ext_walk_key(unsigned long key, void *data)
>
> Maybe _leaf? No strong feelings though

Sure.

>
>> +{
>> +	struct kho_radix_tree *tree = data;
>
> Would be nice to say which tree in the variable name ;)

How about preserved_mem_map?

>
>> [ ... skip 15 lines ... ]
>> +	return 0;
>> +}
>> +
>> +static int __init kho_ext_walk_node(phys_addr_t phys, void *data)
>> +{
>> +	struct kho_radix_tree *tree = data;
>
> Ditto
>
>> [ ... skip 15 lines ... ]
>> +
>> +	*prev_end = start + (1UL << KHO_EXT_SHIFT);
>> +	return 0;
>> +}
>> +
>> +/**
>
> I don't think we expose statics as kernel-doc somewhere, so this
> probably shouldn't be a kernel-doc comment

This is a leftover from the previous version, where this was external.

I think the documentation is still worthwhile though, so I suppose I'll
turn it into a normal comment by removing the /**.

>
>> + * kho_extend_scratch - Extend the scratch regions
>> + *
>> + * The KHO radix tree mixes both physical address and order into a single key.
>
> Here it's rather the preserved memory map radix tree or something like
> that.

Sure, will update.

>
>> + * This makes it hard to look for free ranges directly. This function first
>> + * walks the radix tree and digests it down into another radix tree, whose keys
>
> Here as well, maybe don't even mention radix to make it shorter, the
> important part is that we wakk the preserved memory map and create a
> radix tree that identifies blocks around the preserved memory.

ACK.

>
>> + * identify blocks of KHO_EXT_SHIFT which contain preserved memory.
>> + *
>> + * Then it walks the digested radix tree and marks everything that doesn't have
>> + * preserved memory as scratch.
>> + *
>> + * NOTE: This function allocates memory so it should be called when scratch has
>> + * available space.
>> + *
>> + * NOTE: The pages of the KHO radix tree tables are not marked as preserved in
>
> ^ preserved memory map radix tree :)

ACK.

>
>> + * the KHO tree. But they are expected to remain untouched until the tree is
>> + * fully parsed. So this function also considers them to be "preserved memory"
>> + * and marks their blocks as busy.
>> + */
>> +static void __init kho_extend_scratch(void)
>> +{
>> +	const struct kho_radix_walk_cb kho_cb = {
>> +		.leaf = kho_ext_walk_key,
>> +		.node = kho_ext_walk_node,
>> +	};
>> +	const struct kho_radix_walk_cb ext_cb = {
>> +		.leaf = kho_ext_mark_scratch,
>> +	};
>> +	struct kho_radix_tree radix;
>
> sashiko says:
>
>   Is it possible for the radix variable to contain uninitialized stack memory
>   here?
>   If radix is uninitialized, tree->root might contain garbage data when passed
>   to kho_radix_init_tree()
>
> and I agree :)
>
> This should be
>
> 	struct kho_radix_tree radix = { 0 };

Ugh, right. But at the same time, it is odd for an initialization
function to expect an initialized object. Perhaps I should move the
kho_radix_init_tree() from kho_mem_retrieve() to
kho_memory_init_early(). Then kho_extend_scratch() won't have to do the
init at all and I can remove the if (tree->root) check from
kho_radix_init_tree().

-- 
Regards,
Pratyush Yadav

