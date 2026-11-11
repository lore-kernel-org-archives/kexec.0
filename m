Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E865606A885
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 15:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=iR6gQtWq;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=Ms809EVX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=7MN59RS0FEa8Yt1lpkKUAzp9vOqlc0URHQI/8ivhnpE=; b=iR6gQtWq9rrn/i
	VnVX8uq8y5qkiwRyfqyJ+yzJ1LA9jjTvJE/i4YvYMjzDcabMh0mmF9QIhI9sM82sdGgDyDBTX2Dy7
	cvYN4m5DugnLpTILanemn+wFxh1C9VnR2NE+7Fq95fREswRp9ronCSjMg+CnGpHIugGf9yyS5k80u
	K7cl4P++PxZBuDAXES8jc8WRYBrbEjhQ5XuD5lM3Li6k5vwVMDIo0t/lz49iy9FKp+zrzyPZDZszb
	kFLcAQrCY+5kcNUfxHgY2/RXEbyDpyAhn0/4znosjXeveKz/JmSN0P6A6SMC5Em4yPYmMVZBz/1oJ
	Xi8ix9bU5+3/PlaEIRYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRA36-000000073xv-0oxm;
	Wed, 11 Nov 2026 15:15:44 +0000
Received: from mail-vs1-xe2d.google.com ([2607:f8b0:4864:20::e2d])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRA33-000000073xY-2KtM
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 15:15:42 +0000
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-7d2dc1ac787so1037596137.2
        for <kexec@lists.infradead.org>; Wed, 11 Nov 2026 07:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794410139; x=1795014939; darn=lists.infradead.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7MN59RS0FEa8Yt1lpkKUAzp9vOqlc0URHQI/8ivhnpE=;
        b=Ms809EVXgUbeLeEuova16HErZjjW6gb48S4xUb71fDfxi2zT0vLpHQMkNTbQWCpQ9X
         fa4RysxFevd+1YXVTY1AS5KiSvb52UsTDERdylzeZVf2XwNdf+RfMQyRBJ7T+MATGQpu
         DIuidnDZOgQe+PEMlN9Ue6Cw4lQ7Cw5q+vuZ79u5nWvdh72sBRBaIQoL1VsEj5giJkqV
         fYWvSXbc9lNIvXPtA3HqMjcCk/6mlP2Jqk1mRHAlvR9EsETPBNXWJ4KZ4hGmAVoOvDK8
         R4UoecKSR7XTu/R2zuSoIdXLf3vBzMsEs37gLibNsGufb22mgEYp0XdIetmtJ0GzzrtQ
         l8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794410139; x=1795014939;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7MN59RS0FEa8Yt1lpkKUAzp9vOqlc0URHQI/8ivhnpE=;
        b=smDxVqzwDI8PzU6dHL/9one9oPcj/fyqpxFHUN5Mu66GuYi2MY25IrhsHGMp4NfyLJ
         cjz+fH2DPb1/s/Efm+1SdJ8IBnoY8DOR3jWmJ86byeRDkyLhrDF8wvfflbwJFkZFDDO7
         PgzZ5BoCeHhEjllpn8+Gi0JLeEJ2lClXFg2n/HVT3euEqw9NA3xjSCcVxoB/Gx6Shjyo
         wt5j5rj04qVgn8sP9XQOV507m48CIFQZkyGOFG6aebZWB1mDUZ8vGKlt+w5YCQ6s8Ija
         0skMagu+JrGtxevLbTLqzXXlFPhzzPoP5ELpb7lYPKo/IuTlbNzoxkkO9RDAi77RXBg2
         7lUw==
X-Forwarded-Encrypted: i=1; AL+hErEP+SZMJ8cH2R26+8J3RLvnVevU4ruxNPmbANEqcHtzXbee7gRS4BH9G+KSred0AbpIoXhttg==@lists.infradead.org
X-Gm-Message-State: APuU4Z+v/Yi1CLF9JJko/CjdKvg7YRnFlRHFmg35mpFcznwI85Q5OpwA
	uRHkztxr2EOVetCPXKZjSoSYXSjBtPmOHzA+pfJHbmqgoYjwoK9GICceTix4rgE8nEw=
X-Gm-Gg: AYBFou3XGs2xbx+TIERkAsVJk3ufa/CCQB9Dx67Yzyf4MY3Txrl1gaB2VKvrBoI2dER
	Hql6VSdghibZerESyckH3EPMtW1Y3nxZ4Fq1nXKGjuY5qvloNQhaY1iB+xIhbEmCZMKt/M7jq0i
	Ei5gUnHrPzgYJdvlzJz3IWucpZPL5JLuk9cf1PYkqgOpxHaAbwsm+9vjQsjpZbQFtdp2UgQFTuH
	E14/8IpcNrF6dy0cbz7r0KiPsW3lop9NzGl18OQUcPgOmVpRpaR2+mEbGz+HDA5lNNUfVCTGydS
	6mghK8hNugM51YV/C8IRbMIiFhuQFZwnGGv5E6MTBsZFdElvAbChrtM5nF4PZg2WARMSksdiggw
	4/7gM4gK0XlYat0/dP1TMEf6k1YJY+m9AE79jNxP+/itKjYbb1xK25i71YBF0SnXjIsbv1/tfuu
	s6CcCOpNJNURsEXwfQcrrjZLfKxoIOiZWsiLdZlbOyi1IJWEQjrMSQCwWgxgstOxkEGonAbxrzK
	1giGY5GNA0FnwUzO+kft8OsiBJZeQ6bKJhvF0dDmF6Eo8KoA0tt3m9u9rahxkXiDpBZzUETSU7f
	qt5OAy7I0BJ6Ad29QciOmdJCsXdRyAIvSj1cmkbI4oDcuc14OXr8CTkNCDnpLGWX6pR90/vJjGd
	82JOYndJFyCzXCMEYzIQkd6oNd+sg
X-Received: by 2002:a05:6102:5cc8:b0:7d2:cdd6:6be with SMTP id ada2fe7eead31-7d505fa8765mr836563137.21.1794410138969;
        Wed, 11 Nov 2026 07:15:38 -0800 (PST)
Received: from localhost (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee1dcd3930sm1185914e0c.11.2026.11.11.07.15.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 07:15:37 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Nov 2026 10:15:36 -0500
Message-Id: <DMSHB0JBS5V8.1IZD7WPEQGPMA@soleen.com>
Subject: Re: [PATCH v5 2/6] kho: support incremental entry publication in
 kho_block
From: "Pasha Tatashin" <pasha.tatashin@soleen.com>
To: "Mike Rapoport" <rppt@kernel.org>, "Pasha Tatashin"
 <pasha.tatashin@soleen.com>
Cc: <linux-kselftest@vger.kernel.org>, <shuah@kernel.org>,
 <linux-mm@kvack.org>, <skhan@linuxfoundation.org>,
 <linux-doc@vger.kernel.org>, <vipinsh@google.com>,
 <linux-kernel@vger.kernel.org>, <corbet@lwn.net>, <dmatlack@google.com>,
 <kexec@lists.infradead.org>, <pratyush@kernel.org>,
 <rdunlap@infradead.org>, <graf@amazon.com>
X-Mailer: aerc 0.22.0-39-g5d7784875be2
References: <20261105050053.3063001-1-pasha.tatashin@soleen.com>
 <20261105050053.3063001-3-pasha.tatashin@soleen.com>
 <179439592040.425130.12391503339294194908.b4-review@b4>
In-Reply-To: <179439592040.425130.12391503339294194908.b4-review@b4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261111_071541_655588_63D61A79 
X-CRM114-Status: GOOD (  35.08  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed Nov 11, 2026 at 6:18 AM EST, Mike Rapoport wrote:
> Hi,
>
>> To allow LUO sessions to be frozen and committed into the outgoing KHO
>> subtree from userspace ahead of reboot, kho_block needs to support
>> publishing entries one by one into a live serialized block chain while
>> new blocks may still be preallocated or shrunk for uncommitted sessions.
>>=20
>> Currently, kho_block assumes outgoing block sets are populated in a
>> single batch during reboot() before the chain is exposed: preallocated
>> blocks are linked onto the chain immediately even while empty
>> (ser->count =3D=3D 0), and reserving a slot increments ser->count before=
 the
>> entry is populated.
>>=20
>> Address this by keeping preallocated outgoing blocks unlinked in
>> kho_block_add(), linking blocks lazily only as entries are written. Add
>> kho_block_set_it_append() to copy each entry into its slot before
>> publishing the updated ser->count and next-block link via
>> smp_store_release(), paired with smp_load_acquire() in
>> kho_block_set_it_read_entry().
>>=20
>> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>> ---
>>  include/linux/kho_block.h     |  1 +
>>  kernel/liveupdate/kho_block.c | 86 +++++++++++++++++++++++++++++++----
>>  2 files changed, 77 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/linux/kho_block.h b/include/linux/kho_block.h
>> index 93a7cc2be5f51..a9e696ef3e08e 100644
>> --- a/include/linux/kho_block.h
>> +++ b/include/linux/kho_block.h
>> @@ -100,6 +100,7 @@ static inline bool kho_block_set_is_empty(struct kho=
_block_set *bs)
>> =20
>>  void kho_block_set_it_init(struct kho_block_set_it *it, struct kho_bloc=
k_set *bs);
>>  void *kho_block_set_it_reserve_entry(struct kho_block_set_it *it);
>> +void *kho_block_set_it_append(struct kho_block_set_it *it, const void *=
src);
>>  void *kho_block_set_it_read_entry(struct kho_block_set_it *it);
>>  void *kho_block_set_it_prev(struct kho_block_set_it *it);
>> =20
>> diff --git a/kernel/liveupdate/kho_block.c b/kernel/liveupdate/kho_block=
.c
>> index 0d2a342ef4228..2813c6fd593c4 100644
>> --- a/kernel/liveupdate/kho_block.c
>> +++ b/kernel/liveupdate/kho_block.c
>> @@ -16,6 +16,12 @@
>>   * array of serialized entries. Multiple blocks are linked together via=
 a
>>   * physical pointer in the header, forming a linked list that can be ea=
sily
>>   * traversed in both the current and the next kernel.
>> + *
>> + * Outgoing blocks preallocated via kho_block_set_grow() remain unlinke=
d until
>> + * entries are written into them. Callers publishing entries incrementa=
lly into
>> + * a live KHO subtree can use kho_block_set_it_append(), which populate=
s each
>> + * entry before exposing the updated block count or next-block link via
>> + * release-store ordering.
>
>
>>   */
>> =20
>>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> @@ -93,9 +99,7 @@ static int kho_block_add(struct kho_block_set *bs,
>>  	list_add_tail(&block->list, &bs->blocks);
>>  	bs->nblocks++;
>> =20
>> -	if (last)
>> -		last->ser->next =3D virt_to_phys(ser);
>> -	else
>> +	if (!last)
>>  		bs->head_pa =3D virt_to_phys(ser);
>
>
>> =20
>>  	return 0;
>> @@ -129,14 +133,15 @@ static void kho_block_set_shrink_one(struct kho_bl=
ock_set *bs)
>>  	last =3D list_last_entry(&bs->blocks, struct kho_block, list);
>>  	list_del(&last->list);
>>  	bs->nblocks--;
>> -	kho_block_free_ser(bs, last->ser);
>> -	kfree(last);
>> =20
>>  	new_last =3D list_last_entry_or_null(&bs->blocks, struct kho_block, li=
st);
>>  	if (new_last)
>> -		new_last->ser->next =3D 0;
>> +		WRITE_ONCE(new_last->ser->next, 0);
>
> Why this is needed? Docs explicitly state that "Synchronization and
> locking are the responsibility of the caller".

This was done as prep for the kho-ro changes: when an uncommitted=20
session closes and shrinks an unused trailing block, new_last may=20
already be published and read concurrently via kho-ro. I will move it=20
into a separate patch in the kho-ro series to clearly explain the=20
intent.

>
>>  	else
>>  		bs->head_pa =3D 0;
>> +
>> +	kho_block_free_ser(bs, last->ser);
>> +	kfree(last);
>
> This change seems unnecessary.

Leftover from the earlier pop support (unlinking last->ser before=20
unpreserving/freeing it). Will drop this change in v6 as well; I have=20
since simplified the logic so adding to KHO is always a one-way trip.

>>  }
>> =20
>>  /**
>> @@ -144,9 +149,9 @@ static void kho_block_set_shrink_one(struct kho_bloc=
k_set *bs)
>>   * @bs:    The block set.
>>   * @count: The target number of valid entries to accommodate.
>>   *
>> - * Dynamically preallocates and links preserved memory blocks if the ta=
rget
>> - * entry count exceeds the current total capacity of the set, ensuring =
they
>> - * are available during serialization/deserialization.
>> + * Dynamically preallocates preserved memory blocks if the target entry=
 count
>> + * exceeds the current total capacity of the set, ensuring they are ava=
ilable
>> + * during serialization/deserialization.
>>   *
>>   * Context: Caller must hold a lock protecting the block set.
>>   * Return: 0 on success, or a negative errno on failure.
>> @@ -318,6 +323,7 @@ void kho_block_set_clear(struct kho_block_set *bs)
>>  	struct kho_block *block;
>> =20
>>  	list_for_each_entry(block, &bs->blocks, list) {
>> +		block->ser->next =3D 0;
>>  		block->ser->count =3D 0;
>>  		memset(block->ser + 1, 0, KHO_BLOCK_SIZE - sizeof(*block->ser));
>>  	}
>> @@ -348,6 +354,7 @@ void kho_block_set_it_init(struct kho_block_set_it *=
it, struct kho_block_set *bs
>>   */
>>  void *kho_block_set_it_reserve_entry(struct kho_block_set_it *it)
>>  {
>> +	struct kho_block *prev =3D NULL;
>>  	void *entry;
>> =20
>>  	if (!it->block)
>> @@ -356,15 +363,73 @@ void *kho_block_set_it_reserve_entry(struct kho_bl=
ock_set_it *it)
>>  	if (it->i =3D=3D it->bs->count_per_block) {
>>  		if (list_is_last(&it->block->list, &it->bs->blocks))
>>  			return NULL;
>> +		prev =3D it->block;
>>  		it->block =3D list_next_entry(it->block, list);
>>  		it->i =3D 0;
>>  	}
>> =20
>> +	if (!it->i)
>> +		it->block->ser->next =3D 0;
>> +
>>  	entry =3D kho_block_entry(it, it->i++);
>>  	it->block->ser->count =3D it->i;
>> +	if (prev)
>> +		prev->ser->next =3D virt_to_phys(it->block->ser);
>
> kernel-doc should mention that this function now links blocks.
>
> And I believe there should be a paragraph about the new flow in the DOC:
> section.

+1, I will update the kernel-doc.

>
>> +
>>  	return entry;
>>  }
>> =20
>> +/**
>> + * kho_block_set_it_append - Write and publish an entry at the next slo=
t.
>> + * @it:  The block iterator.
>> + * @src: Entry data of size @it->bs->entry_size to copy into the slot.
>> + *
>> + * Copies @src into the next available slot before updating the block's=
 entry
>> + * count or linking a newly occupied block to the previous block, so co=
ncurrent
>> + * readers never observe an uninitialized slot or an empty block.
>> + *
>> + * Return: A pointer to the written entry slot, or NULL if the block se=
t's
>> + * capacity is fully exhausted.
>> + */
>> +void *kho_block_set_it_append(struct kho_block_set_it *it, const void *=
src)
>> +{
>> +	struct kho_block *prev =3D NULL;
>> +	void *dst;
>> +
>> +	if (!it->block)
>> +		return NULL;
>> +
>> +	if (it->i =3D=3D it->bs->count_per_block) {
>> +		if (list_is_last(&it->block->list, &it->bs->blocks))
>> +			return NULL;
>> +		prev =3D it->block;
>> +		it->block =3D list_next_entry(it->block, list);
>> +		it->i =3D 0;
>> +	}
>> +
>> +	if (!it->i)
>> +		WRITE_ONCE(it->block->ser->next, 0);
>> +
>> +	dst =3D kho_block_entry(it, it->i++);
>> +	memcpy(dst, src, it->bs->entry_size);
>> +
>> +	/*
>> +	 * Ensure the serialized entry is visible before exposing the
>> +	 * incremented count to concurrent readers.
>> +	 */
>> +	smp_store_release(&it->block->ser->count, it->i);
>> +	if (prev) {
>> +		/*
>> +		 * Ensure the new block's first entry and header are visible
>> +		 * before linking prev->ser->next for concurrent readers.
>> +		 */
>> +		smp_store_release(&prev->ser->next,
>> +				  virt_to_phys(it->block->ser));
>
> Until now the locking model was "the caller is responsible to hold a
> lock".
>
> Using WRITE_ONCE() and smp_store_release() instead of plain assignments
> implies that it is not anymore, or at least not always.
>
> This should be a well documented separate change.

Agreed. I wrote this patch as preparation for both early freeze and=20
kho-ro: mutations to struct kho_block_set itself still require caller=20
locking, while the WRITE_ONCE() and release/acquire ordering allow a=20
concurrent kho-ro reader to walk the live serialized physical block=20
chain while the host continues committing entries under its lock.

In v6, I will remove the kho-ro parts, and submit them together with the=20
next iteration of that series.

--=20
Pasha


