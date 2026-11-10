Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2674606A327
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 17:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1F4/ZICw;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WDEC3wKQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6/eB+/CH5yaEpI1uhM4dFjSsW0sUvRV8va2xHbNL6Kg=; b=1F4/ZICw9WiHXOHAOBF6MvlD6Q
	GKG9SrwwMSXFQzJGGQX4kSJ+QZy7Rrc4Fu0Bwkq9ArI4vJUGDUgD+Z9XTV9Tq6zMtG7E/19IQ3nr6
	edzptijprvYxGeKnHSQkZWafW8wAOq71cxF0baWTTaBAvhuV8W6N4vzuPz2yf94yWqWPAgivHgL4r
	CgOKFIHGm7nnEhfow8M5DFCoR/WfASYCFYO1dQeCC9jEioAOPUG8m9ryCdKyiUH/7aOhjCfDBLsqA
	rT6E/XwK0eyvyZQ85F7atEhcsGFQUzYLK5ICgxGifbjr/7W0Qlr/9rdYY54G4GI7gMSCT00Tv/flD
	ywXBzF2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQpnQ-00000004hK4-1W4s;
	Tue, 10 Nov 2026 17:38:12 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQpnO-00000004hJq-1Ftq
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 17:38:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9A9D44088B;
	Tue, 10 Nov 2026 17:38:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392F71F0089F;
	Tue, 10 Nov 2026 17:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794332289;
	bh=6/eB+/CH5yaEpI1uhM4dFjSsW0sUvRV8va2xHbNL6Kg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=WDEC3wKQyX0hwMUN7w0VPurSY8Nvo/ERaH/+f4RahK/VRm8DW4X2gwlvhh7KTVPcD
	 M1BCzIkLVMIL9ZJYaGK3hVB9BiyTYIK8mAg88QneuGhyvFPARVRjC6tIdUJJ8BPvBH
	 txO0v2O2BXqcz5yMfuH0485bf+bmK8ZDLA4Z+ynQioxlG/HCoIBIpUfLW1Nr9AKDC+
	 PzWNOAj5G3lN37XjPQeNeEtRlMi8Oc9OwVJT0CsDSxxdAIrbUy+//RaNdNL+a6YfzG
	 EEUQ1wiGUUPMeoXetkDh3OZ/8xOdTkUCqOpfLg9RMsOYCt2JFmSKHxZKJ8EOM6H9Sv
	 Q1oK4bFpBW/TQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Andrew Morton <akpm@linux-foundation.org>,
  kexec@lists.infradead.org,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org
Subject: Re: [PATCH v2] mm/memfd_luo: don't use memfd_pin_folios()
In-Reply-To: <179381215936.28814.9050829645096838793.b4-review@b4> (Mike
	Rapoport's message of "Wed, 04 Nov 2026 19:09:19 +0200")
References: <20261103172251.2348370-1-pratyush@kernel.org>
	<179381215936.28814.9050829645096838793.b4-review@b4>
Date: Tue, 10 Nov 2026 18:38:06 +0100
Message-ID: <2vxzse18h9j5.fsf@kernel.org>
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04 2026, Mike Rapoport wrote:

>> memfd_luo takes a snapshot of the folios in the file's mapping. To make
>> sure the snapshot does not go out of sync, it pins the folios in the
>> file via memfd_pin_folios(). The pinning also migrates the folios out of
>> MIGRATE_MOVABLE to make sure doesn't land in KHO boot memory or in a CMA
>> region.
>> 
>> memfd_pin_folios() does not lock the folios. So it can race with
>> shmem_writeout(). A folio returned by memfd_pin_folios() might already
>> be in swap cache. This happens to work but is fragile. memfd_luo looks
>> at folio flags and index on a folio that isn't in the memfd's page
>> cache.
>> 
>> In addition, memfd_pin_folios() needs the caller to allocate an array of
>> folios. memfd_luo does not really need that since it will vmalloc
>> folios_ser and store the information there anyway. The folios array is
>> unnecessary overhead.
>> 
>> Finally, memfd_pin_folios() fills in holes in the memfd. This makes
>> preserving sparse memfds very expensive in both compute and memory.
>> While this patch doesn't yet stop filling in the holes, it sets up the
>> infrastructure to make it simpler.
>> 
>> Fix all this by walking the page cache directly using shmem_get_folio()
>> with SGP_CACHE. This returns a locked folio with an elevated refcount.
>> memfd_luo holds that reference until the memfd is unpreserved. This
>> blocks compaction, migration, etc.
>> 
>> There is still a need to migrate folios out of MIGRATE_MOVABLE page
>> blocks. This is because those might be CMA or KHO scratch. memfd_luo
>> will hold a longterm reference to the folios so it will block migration
>> in that pageblock. Introduce memfd_luo_migrate_folio() to do this.
>> 
>> Also factor out folio unpreservation logic into memfd_luo_put_folios()
>> and use it from memfd_luo_unpreserve_folios() and from error paths in
>> memfd_luo_preserve_folios().
>> 
>> Since shmem_get_folio() always returns uptodate folios, drop the folio
>> zeroing logic.
>> 
>> This change also improves preservation performance, shown in the table
>> below.
>> 
>> |------------------+----------+------------+-------|
>> | memfd            | baseline | this patch | delta |
>> |------------------+----------+------------+-------|
>> | 4K pages, 32 GiB | 748 ms   | 600 ms     |  -20% |
>> | THP, 4 GiB       | 0.59 ms  | 0.59 ms    |    0% |
>> | THP, 16 GiB      | 2.99 ms  | 2.61 ms    |  -13% |
>> | THP, 32 GiB      | 4.83 ms  | 5.21 ms    |   +8% |
>> | sparse, 32 GiB   | 8695 ms  | 7269 ms    |  -16% |
>> |------------------+----------+------------+-------|
>> 
>> Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
>
> With a few nits below
>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thanks!

>
>> +/*
>> + * Move a folio out of ZONE_MOVABLE or CMA, so it can be held until the next
>
> "held until next kernel" - here and below - I feel that something is off
> here, but can't pinpoint what exactly.

Hmm, perhaps this:

    Preservation holds a longterm reference on the folio. This would
    block migration in ZONE_MOVABLE or CMA. Move it out.

?

>
>> + * kernel. Called with a reference on the unlocked folio, which is always
>> + * dropped. The caller must look up the folio again afterwards.
>
> I'm having hard time parsing "called with a reference" sentence :)

What about this:

     Must be called with folio unlocked. Drops the reference to folio.
     The caller must look it up again.

?

>
>> +/*
>> + * Look up the folio at @index, allocating it if needed, and make sure it can be
>> + * held until the next kernel. Folios that are not longterm pinnable are migrated
>> + * out first, retrying a few times if someone else has them isolated.
>> + *
>> + * On success, returns 0 with *@foliop locked and holding a reference.
>> + */
>> +static int memfd_luo_get_folio(struct inode *inode, pgoff_t index,
>> +			       struct folio **foliop)
>> +{
>> +	int err, busy_retries = 0;
>> +	struct folio *folio;
>> +
>> +	for (;;) {
>
> Won't
> 	for (retry = 0; retry < MEMFD_LUO_MIGRATE_RETRIES; retry++) {
>
> look better and the body simpler?

Right, good idea.

>
>> +		err = shmem_get_folio(inode, index, 0, &folio, SGP_CACHE);
>> +		if (err)
>> +			return err;
>> +
>> +		if (likely(folio_is_longterm_pinnable(folio)))
>> +			break;
>> +
>> +		folio_unlock(folio);
>> +		err = memfd_luo_migrate_folio(folio);
>> +		/* Someone else might have it isolated, retry a bit. */
>> +		if (err == -EBUSY && ++busy_retries < MEMFD_LUO_MIGRATE_RETRIES)
>> +			continue;
>> +		if (err)
>> +			return err;
>> +	}
>> +
>> +	*foliop = folio;
>> +	return 0;
>> +}
>
> .

-- 
Regards,
Pratyush Yadav

