Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6C1606A320
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 05:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Py6gC2B8;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bGe5wGQi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=lhosHtg8wPbXMxrTNQaWwGDOdBWHTWddIh+Zj1SEb0g=; b=Py6gC2B8Fs1mFuZN8LsIgUzjdx
	RsBtSLTwJvUv7Oqy7cvwyB4hpbMI2XuTc9jRDuYWs5u41uvekPU46uqt9JCMkgfMWeCbF14ocCb0l
	2xVHKVRfCCN/1kZv1WwB62AU6VVdr7OVPazihedf5xCsGpqokgQRiGFflVu+NZ6JTnc6Jwac0J+D2
	yYyajk/b9hrDQ5vHRxePW4/lJQkn2cy3F6eNS4ofAnhS6aFqiGhdKLDLPjl8Qu1IEFrQneklV6rXp
	a4NTT7z6MkSf/iDBaHbL8ZSkMLtlrcxcWoLiPetofRoFkW2Ly74eXaJ31rQfwCBkHReCDU49+OP0f
	G0hw2Fgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR19p-00000005gD1-32kK;
	Wed, 11 Nov 2026 05:46:05 +0000
Received: from mail-ed1-x545.google.com ([2a00:1450:4864:20::545])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR19n-00000005gCN-2lL0
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 05:46:04 +0000
Received: by mail-ed1-x545.google.com with SMTP id 4fb4d7f45d1cf-6a125f5b317so2996932a12.1
        for <kexec@lists.infradead.org>; Tue, 10 Nov 2026 21:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794375961; x=1794980761; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lhosHtg8wPbXMxrTNQaWwGDOdBWHTWddIh+Zj1SEb0g=;
        b=bGe5wGQixGcOTQxTG324YG3eDPSbGXJjm6NWOePqLqC+6KPbs9jYV3Zi+OrUBwGUqv
         /rMXyfsKr4qtLHka0lu5mTLwHknpMExWOiXEh7mKWfJRT0d3D0Wt0NjNPJdJD1SVb/th
         3xU6wZGZ8EO//Qd3Gv8UoWVEK1BJxhONtpbC4DZje8HrkjVAbThoRwls/pKMeSZWMiJN
         QZeYoupvfpFV60WAIH7mw584rsQ46C38cV5ZawWz9rkI28qk9QL6sxqxl9U3UYRoJO6B
         JhvcM5kUaThkvPHwcRpAhYND1fnolc++y/gSoXRGKmGWKla/FpHbbalmzbCpSMe+Uvc3
         VZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794375961; x=1794980761;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lhosHtg8wPbXMxrTNQaWwGDOdBWHTWddIh+Zj1SEb0g=;
        b=O7OSXmSU6xjLNfFOdik/sjd5++wt5YFHaQAtMLGHiwoSHxQPu5AKZE0FtLJ1rNxLMW
         rmrv43UTPuLk2EyN2ZOEXWEtxUCVeUfAjC1anysUhWaO6+AathoNgQzT10GBMNg2v582
         ntRgIT8TEu9oWDbA5vO9Yxb2R1KqXZRqB03vn8y2YJEbtzyiZ86NG4n0OjrvZtXqsB8Y
         l/egPSwDvcEeumk1GTCfqQ8f79+vbAWk2c6CzagyBphkVnMOyZauymI6rR7BWE6h/tEe
         rppFq65QrBF2fmibAjtvjdX9Q32o/mWuNRMAIUOcpIwht1Z1Nch+RXuHBb16Wa++8+O5
         SFZQ==
X-Forwarded-Encrypted: i=1; AL+hErHm9/C5tmtjeuJ2Vs8iuw65J41NVDY0FyKtWtAYkQKAOjWYtuIcM0Nvz7IfL9aWDCae8l8oew==@lists.infradead.org
X-Gm-Message-State: APuU4Z/Ha/E165SjK2RXqjUWhZ0wOE2CwtTMJVdaK1c6SSGlg6CtU3S3
	LR29QTdEQrXelm0WBZNA+ki9fu4DfYdOTavZjZms8WC5pa1wo1ePxX1Co7W+9TkZezvZnOAn0nu
	eAwjBz0LNEf6Lw277OQ==
X-Received: from eduw9.prod.google.com ([2002:aa7:dcc9:0:b0:6aa:448f:b887])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:b18:b0:6b1:c1e5:a85b with SMTP id 4fb4d7f45d1cf-6b777342a32mr753053a12.3.1794375960798;
 Tue, 10 Nov 2026 21:46:00 -0800 (PST)
Date: Wed, 11 Nov 2026 05:45:59 +0000
In-Reply-To: <DMRK0PU0VCN3.15F59WLOQ05P4@soleen.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261110050202.529473-1-tarunsahu@google.com> <20261110050202.529473-3-tarunsahu@google.com>
 <DMRK0PU0VCN3.15F59WLOQ05P4@soleen.com>
Message-ID: <9huz1p8rrkdk.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 02/19] kho: block: Record the entry size in the block header
From: tarunsahu@google.com
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, 
	maz@kernel.org, will@kernel.org, David Matlack <dmatlack@google.com>, 
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, 
	arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	Bjorn Helgaas <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, 
	gle.com@google.com, pbonzini@redhat.com, 
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: kvmarm@lists.linux.dev, linux-pci@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	skhawaja@google.com, sagis@google.com, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_214603_727795_A1972436 
X-CRM114-Status: GOOD (  37.39  )
X-Spam-Score: -9.5 (---------)
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
X-Spam-Status: No, score=-23.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

"Pasha Tatashin" <pasha.tatashin@soleen.com> writes:

> On Tue Nov 10, 2026 at 12:01 AM EST, Tarun Sahu wrote:
>> Subsystems using the KHO Serialization Blocks framework currently do
>> not record the serialized entry size in the block header. The entry size
>> is only known to individual callers, which must track and store it in an
>> owning serialized data structure. If a newer source kernel adds fields
>> to an entry, the changed entry size breaks the stride when an older
>> target kernel iterates over blocks.
>>
>> Add an entry_size field to struct kho_block_header_ser. On the outgoing
>> side, record bs->entry_size into every block header during allocation.
>> During restoration, derive the entry stride directly from the block
>> header instead of relying on caller-supplied dimensions. The
>> kho_block_set_init() interface remains unchanged. A zero entry size,
>> or one that differs between blocks of a set, is rejected during
>> restoration.
>>
>> This change modifies the serialized layout of struct kho_block_header_ser
>> and shifts the offset of serialized entries within preserved blocks.
>> Bump KHO_FDT_COMPATIBLE from kho-v4 to kho-v5 so that pre-v5 and post-v5
>> kernels cleanly reject mismatched handover state during boot. Also
>> update the stale compatible string example in the documentation.
>>
>> Suggested-by: Pratyush Yadav <pratyush@kernel.org>
>> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
>> ---
>>  include/linux/kho/abi/block.h          | 10 ++++----
>>  include/linux/kho/abi/kexec_handover.h |  6 ++---
>>  kernel/liveupdate/kho_block.c          | 32 +++++++++++++++++++++++---
>>  3 files changed, 38 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/linux/kho/abi/block.h b/include/linux/kho/abi/block.h
>> index 36bdbaf9b3b8..a40b0906c821 100644
>> --- a/include/linux/kho/abi/block.h
>> +++ b/include/linux/kho/abi/block.h
>> @@ -40,9 +40,10 @@
>>  
>>  /**
>>   * struct kho_block_header_ser - Header for the serialized data block.
>> - * @next:  Physical address of the next struct kho_block_header_ser.
>> - * @count: The number of entries that immediately follow this header in the
>> - *         memory block.
>> + * @next:       Physical address of the next struct kho_block_header_ser.
>> + * @count:      The number of entries that immediately follow this header in the
>> + *              memory block.
>> + * @entry_size: The size in bytes of each serialized entry in the block.
>>   *
>>   * This structure is located at the beginning of a block of physical memory
>>   * preserved across a kexec. It provides the necessary metadata to interpret
>> @@ -51,9 +52,10 @@
>>  struct kho_block_header_ser {
>>  	u64 next;
>>  	u64 count;
>> +	u64 entry_size;
>>  };
>>  
>> -static_assert(sizeof(struct kho_block_header_ser) == 16);
>> +static_assert(sizeof(struct kho_block_header_ser) == 24);
>>  static_assert(!IS_ENABLED(CONFIG_64BIT) ||
>>  	      __alignof__(struct kho_block_header_ser) == 8);
>
> The above change goes away once my comment on the previous patch 
> is addressed.

Ack.

>
>>  
>> diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/abi/kexec_handover.h
>> index 2f4fb9c63942..6f12f5037ea5 100644
>> --- a/include/linux/kho/abi/kexec_handover.h
>> +++ b/include/linux/kho/abi/kexec_handover.h
>> @@ -41,7 +41,7 @@
>>   *   restore the preserved data.::
>>   *
>>   *     / {
>> - *         compatible = "kho-v3";
>> + *         compatible = "kho-v5";
>>   *
>>   *         preserved-memory-map = <0x...>;
>>   *
>> @@ -62,7 +62,7 @@
>>   *     };
>>   *
>>   *   Root KHO Node (/):
>> - *     - compatible: "kho-v3"
>> + *     - compatible: "kho-v5"
>
> These are just examples, don't update them.
>
Got it.

>>   *
>>   *       Identifies the overall KHO ABI version.
>>   *
>> @@ -90,7 +90,7 @@
>>   */
>>  
>>  /* The compatible string for the KHO FDT root node. */
>> -#define KHO_FDT_COMPATIBLE "kho-v4"
>> +#define KHO_FDT_COMPATIBLE "kho-v5"
>>  
>>  /* The FDT property for the preserved memory map. */
>>  #define KHO_FDT_MEMORY_MAP_PROP_NAME "preserved-memory-map"
>> diff --git a/kernel/liveupdate/kho_block.c b/kernel/liveupdate/kho_block.c
>> index 0d2a342ef422..9b148009085e 100644
>> --- a/kernel/liveupdate/kho_block.c
>> +++ b/kernel/liveupdate/kho_block.c
>> @@ -16,6 +16,12 @@
>>   * array of serialized entries. Multiple blocks are linked together via a
>>   * physical pointer in the header, forming a linked list that can be easily
>>   * traversed in both the current and the next kernel.
>> + *
>> + * Each block header also records the size of its entries. A newer kernel may
>
> "newer kernel" does not make sense in the documentation comment, as any 
> kernel can do that. I would suggest "outgoing kernel." By the way, in 
> this series you use the terms "source" and "destination" kernel, whereas 
> traditionally we have used "outgoing" and "incoming." While both 
> conventions work, it would be preferable to maintain consistency.
>

I used source and target, based one of the discussion we had in
hypervisor liveupdate meeting. But, for consistency, I agree, I will
change it to outgoing and incoming.

~Tarun

>> + * append fields to an entry, so the kernel that writes a block and the kernel
>> + * that reads it can use different entry sizes. The reader steps through the
>> + * entries with the recorded size, so every entry is found, and it does not read
>> + * beyond the recorded size of an entry.
>>   */
>>  
>>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> @@ -110,6 +116,8 @@ static int kho_block_set_grow_one(struct kho_block_set *bs)
>>  	if (IS_ERR(ser))
>>  		return PTR_ERR(ser);
>>  
>> +	ser->entry_size = bs->entry_size;
>> +
>>  	err = kho_block_add(bs, ser);
>>  	if (err) {
>>  		kho_block_free_ser(bs, ser);
>> @@ -242,7 +250,8 @@ static bool kho_block_set_is_cyclic(struct kho_block_set *bs)
>>   *
>>   * Restores a serialized block set from a given physical address. The caller is
>>   * responsible for ensuring that the block set @bs has been allocated and
>> - * initialized prior to calling this function.
>> + * initialized prior to calling this function. The entry size and the number
>> + * of entries per block are taken from the restored block headers.
>>   *
>>   * Return: 0 on success, or a negative errno on failure.
>>   */
>> @@ -250,6 +259,7 @@ int kho_block_set_restore(struct kho_block_set *bs, u64 head_pa)
>>  {
>>  	struct kho_block_header_ser *ser;
>>  	u64 next_pa = head_pa;
>> +	u64 entry_size = 0;
>>  	int err;
>>  
>>  	/* Restored block sets use size from the previous kernel */
>> @@ -264,8 +274,21 @@ int kho_block_set_restore(struct kho_block_set *bs, u64 head_pa)
>>  	}
>>  
>>  	while (next_pa) {
>> +		u64 capacity;
>> +
>>  		ser = phys_to_virt(next_pa);
>> -		if (!ser->count || ser->count > bs->count_per_block) {
>> +		if (!ser->entry_size || (entry_size && ser->entry_size != entry_size)) {
>> +			pr_warn("Block contains invalid entry size: %llu\n",
>> +				ser->entry_size);
>> +			err = -EINVAL;
>> +			goto err_destroy;
>> +		}
>> +		entry_size = ser->entry_size;
>> +		bs->entry_size = entry_size;
>> +		capacity = (KHO_BLOCK_SIZE - sizeof(*ser)) / bs->entry_size;
>> +		bs->count_per_block = capacity;
>> +
>> +		if (!ser->count || ser->count > capacity) {
>>  			pr_warn("Block contains invalid entry count: %llu\n",
>>  				ser->count);
>>  			err = -EINVAL;
>> @@ -370,7 +393,10 @@ void *kho_block_set_it_reserve_entry(struct kho_block_set_it *it)
>>   * @it: The block iterator.
>>   *
>>   * Iterates through previously written entries during state deserialization,
>> - * respecting the actual count stored in each block's header.
>> + * respecting the actual count stored in each block's header. Entries are
>> + * spaced by the entry size recorded by the kernel that wrote them, which can
>> + * be smaller or larger than the caller's structure. Fields beyond that size
>> + * are not present in the entry.
>>   *
>>   * Return: A pointer to the next serialized entry, or NULL if all serialized
>>   * entries have been read.
>
>
>
>
>
> -- 
> Pasha

