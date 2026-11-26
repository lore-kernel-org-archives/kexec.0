Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CFB606A31E
	for <kexec@archiver.kernel.org>; Thu, 26 Nov 2026 19:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hLoa5x2O;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mC7UtwFI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=CuVLv2i2GOptfnACX7l3LiPUxZvYfKOmSODmwPhhkPw=; b=hLoa5x2OFtZZQ5TsWK+h6qWcOG
	rE/SoDi9Qj6c3XxgyDUeootm6YTjJ3ZPgvoi+I4rPr0MO8MS0E5nQGSBfadlv6MjlQyoG8mcXu3Mc
	ddqZ29nOlLTGMTWpZ5NOixzEGDoeSik1CkUqn3bfCDCYvgM1rV7FytTwVedDvpQti2ZbuHsmppPJX
	zwAF2NCT4rNbHQPaMorKtM+99+I58exp13QnsJB3xveNRYunC6paSxrN7aVzgYcz/+de2+hNWjNpj
	FNmTu9ErFM6nB2R+lQCZwELA+A7q/Swpz05bBpB4Y33w4wQeRapDZX1KhV8lwfZoRBxkGTYlzNujd
	9OwD1oMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWevn-0000000EGtj-3pkj;
	Thu, 26 Nov 2026 19:14:55 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWevk-0000000EGtV-22lZ
	for kexec@lists.infradead.org;
	Thu, 26 Nov 2026 19:14:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9B1C460D72;
	Thu, 26 Nov 2026 19:14:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B11D1F000C4;
	Thu, 26 Nov 2026 19:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795720491;
	bh=CuVLv2i2GOptfnACX7l3LiPUxZvYfKOmSODmwPhhkPw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=mC7UtwFIZfgl362g4XVFFQa/G8viDzYK9zciLeNK4vN3HA19avPzi/zfmTg9BbGIU
	 dgelNbTa7s4yMuoGmp8foEhEPgNckZ0kOOxjjZzmt6CBra5rShY0LwesOtWrGrviCT
	 BXQwqJfB3mNv/WrPnyop1ygoMYYseBWl1YAbDtlasemS/PkApEcvJLQwZ6e3eGygqI
	 Z3OXnQlvYs/Yo8WSSjFWvSEvKBPp5MXU4m+OUQkmI7PKHw5pZhjyTruSefXYjiNpzB
	 VjRtOH2rC9Q8ru9ADi02DdfamuJWXQkm/qynGSBxdwbpRo+RVi6rEgIwh1Zb8voVhL
	 ocZCZs24Dg2eQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: sashiko-bot@kernel.org
Cc: "Pratyush Yadav" <pratyush@kernel.org>,  "Pasha Tatashin"
 <pasha.tatashin@soleen.com>,  "Mike Rapoport" <rppt@kernel.org>,  "Andrew
 Morton" <akpm@linux-foundation.org>,  sashiko-reviews@lists.linux.dev,
  kexec@lists.infradead.org,  linux-mm@kvack.org
Subject: Re: [PATCH v4] mm/memfd_luo: don't use memfd_pin_folios()
In-Reply-To: <sashiko-outbox-234004@kernel.org> (sashiko-bot@kernel.org's
	message of "Wed, 25 Nov 2026 18:40:57 +0000")
References: <20261124184042.1823277-1-pratyush@kernel.org>
	<sashiko-outbox-234004@kernel.org>
Date: Thu, 26 Nov 2026 19:14:47 +0000
Message-ID: <2vxzzeuvv1zs.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25 2026, sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] mm/memfd_luo: unbatched migration and LRU drain in
>   memfd_luo_migrate_folio()
> --
>
> commit 36bee618bf022031606488c041334f6b85cc82a9
> Author: Pratyush Yadav (Google) <pratyush@kernel.org>
>
> mm/memfd_luo: don't use memfd_pin_folios()
>
> This commit replaces memfd_pin_folios() with a direct page cache walk
> using shmem_get_folio() and migrates folios out of movable or CMA
> pageblocks individually via memfd_luo_migrate_folio().
>
>> diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
>> index 6b68220275ebe..38584ecfa70be 100644
>> --- a/mm/memfd_luo.c
>> +++ b/mm/memfd_luo.c
>> @@ -77,26 +77,168 @@
>
> [ ... ]
>
>> +static int memfd_luo_migrate_folio(struct folio *folio)
>> +{
>> +	struct migration_target_control mtc = {
>> +		.nid = NUMA_NO_NODE,
>> +		/* Not movable, so the target is neither in ZONE_MOVABLE nor CMA. */
>> +		.gfp_mask = GFP_USER | __GFP_NOWARN,
>> +		.reason = MR_LONGTERM_PIN,
>> +	};
>> +	LIST_HEAD(source);
>> +	bool isolated;
>> +
>> +	/* Flush per-CPU LRU batches holding the folio so isolation works. */
>> +	lru_cache_drain_for_folio(folio, 1, NULL);
>> +	isolated = isolate_folio_to_list(folio, &source);
>> +	/* Isolation holds its own reference. */
>> +	folio_put(folio);
>> +	if (!isolated)
>> +		return -EBUSY;
>> +
>> +	if (migrate_pages(&source, alloc_migration_target, NULL,
>> +			  (unsigned long)&mtc, MIGRATE_SYNC, MR_LONGTERM_PIN,
>> +			  NULL)) {
>> +		putback_movable_pages(&source);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	return 0;
>> +}
>
> [Severity: Medium]
> Does migrating one folio at a time here regress preservation latency when
> folios in the memfd already reside in ZONE_MOVABLE or MIGRATE_CMA
> pageblocks?
>
> Previously, memfd_pin_folios() called check_and_migrate_movable_folios(),
> which shared a single enum lru_cache_drained state across the scan so
> lru_add_drain() and lru_add_drain_all() ran at most once, and passed all
> movable folios to a single migrate_pages() call so migrate_pages_batch()
> could batch TLB shootdowns across up to NR_MAX_BATCHED_MIGRATION (512)
> unmapped pages.
>
> Calling memfd_luo_migrate_folio() per folio passes NULL for the drained
> state to lru_cache_drain_for_folio(), which can trigger repeated local and
> all-CPU LRU cache drains, and invokes migrate_pages() on a single-folio
> list, forcing a cross-CPU TLB shootdown IPI for every mapped folio that
> needs migration.

I measured the performance before and after this patch with
movablecore=75%, and it found that with 4k pages, performance does
indeed drop, but the difference is quite small. Only 5-8% slower. THPs
stay about the same.

So I think the slowdown is small enough to not matter.

-- 
Regards,
Pratyush Yadav

