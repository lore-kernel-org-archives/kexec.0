Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F08606A31E
	for <kexec@archiver.kernel.org>; Tue, 24 Nov 2026 15:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LOav+7Pl;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VsZmc/xP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8PNwOatqkWi3DPeRMW9K9Ow73UFN06+ullfX1MwBzgM=; b=LOav+7PlIEIVX2rfNr0SEx6mLO
	idorZz9XbPOTTbl2YqTFnRe2O9M+CWAFIYry8xDyZu96ptKEebqaOcuvm1xox1pU67C3cASbLXB8p
	ftbYsshuOKjqNY0tJUdEZ/Ga7NfkpLz8UCw5PgfJ/vy9BnXbjcQrGyBe3jmk9WvyaW0+vNYvXETe6
	a5nRSlXtnD65yoy6d8d66PQncYNqEUlGoy1y3/H+iymbEwaBp6NmmyHF7y/40QGK0nq1eVnbIeipr
	1WFeTe7aVJhDG8786fZkbbCzCYM5IV5pMI6hhlyLz3lrwTYLkuHFCTs3+An84qDasimEkuRN0QhvN
	HTrYtFUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVslD-00000006xRS-2TGr;
	Tue, 24 Nov 2026 15:48:47 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVslA-00000006xRB-0m6a
	for kexec@lists.infradead.org;
	Tue, 24 Nov 2026 15:48:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A720543C85;
	Tue, 24 Nov 2026 15:48:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3FB1F000CA;
	Tue, 24 Nov 2026 15:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795535323;
	bh=8PNwOatqkWi3DPeRMW9K9Ow73UFN06+ullfX1MwBzgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VsZmc/xPWo1bSNHT2LcbJkJ5aAZGo5Ex6MD6H/GmFufKL5/hFTFMTSWogzAlFSxaO
	 47Az5xBblVfrqyoIh1VpztG6IImhzve5VramGyXB0UaKyDKWaNMcDq9q/nYBr3Yy4+
	 sumWDRrl+hTXqT5gLqTTvgVxUVc8zn+V/YXda8G82gkbNMMR/+Jo1x7bGXv5pzV/Ju
	 sDBYG+9232JroSunsVFT6JLR11m6BK2Afz+vHmum49tYGznGjfbnOZsrdMRL+PpK8B
	 /zFkpCBcVrMjt6kCu+d8fuEsHL0hiQHmKZNDgFXoWaSz4KQyC5uyB+lt/t9w8AXv97
	 bs17euuowrjcg==
Date: Tue, 24 Nov 2026 17:48:37 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v3] mm/memfd_luo: don't use memfd_pin_folios()
Message-ID: <awWx1YnA0PcB2RaB@kernel.org>
References: <20261123130115.4021199-1-pratyush@kernel.org>
 <179546369651.425130.14155931836758567682.b4-review@b4>
 <2vxzo6bez3hs.fsf@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzo6bez3hs.fsf@kernel.org>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 02:51:59PM +0000, Pratyush Yadav wrote:
> On Mon, Nov 23 2026, Mike Rapoport wrote:
> 
> > Hi,
> >
> >> memfd_luo takes a snapshot of the folios in the file's mapping. To make
> >> sure the snapshot does not go out of sync, it pins the folios in the
> >> file via memfd_pin_folios(). The pinning also migrates the folios out of
> >> MIGRATE_MOVABLE to make sure doesn't land in KHO boot memory or in a CMA
> >> region.
> >> 
> >> memfd_pin_folios() does not lock the folios. So it can race with
> >> shmem_writeout(). A folio returned by memfd_pin_folios() might already
> >> be in swap cache. This happens to work but is fragile. memfd_luo looks
> >> at folio flags and index on a folio that isn't in the memfd's page
> >> cache.
> >> 
> >> In addition, memfd_pin_folios() needs the caller to allocate an array of
> >> folios. memfd_luo does not really need that since it will vmalloc
> >> folios_ser and store the information there anyway. The folios array is
> >> unnecessary overhead.
> >> 
> >> Finally, memfd_pin_folios() fills in holes in the memfd. This makes
> >> preserving sparse memfds very expensive in both compute and memory.
> >> While this patch doesn't yet stop filling in the holes, it sets up the
> >> infrastructure to make it simpler.
> >> 
> >> Fix all this by walking the page cache directly using shmem_get_folio()
> >> with SGP_CACHE. This returns a locked folio with an elevated refcount.
> >> memfd_luo holds that reference until the memfd is unpreserved. This
> >> blocks compaction, migration, etc.
> >> 
> >> There is still a need to migrate folios out of MIGRATE_MOVABLE page
> >> blocks. This is because those might be CMA or KHO scratch. memfd_luo
> >> will hold a longterm reference to the folios so it will block migration
> >> in that pageblock. Introduce memfd_luo_migrate_folio() to do this.
> [...]
> >> +/*
> >> + * Look up the folio at @index, allocating it if needed. Preservation holds a
> >> + * longterm reference on the folio, so folios that are not longterm pinnable are
> >> + * migrated out first, retrying a few times if someone else has them isolated.
> >> + *
> >> + * On success, returns 0 with *@foliop locked and holding a reference.
> >> + */
> >> +static int memfd_luo_get_folio(struct inode *inode, pgoff_t index,
> >> +			       struct folio **foliop)
> >> +{
> >> +	struct folio *folio;
> >> +	int err, retry;
> >> +
> >> +	for (retry = 0; retry < MEMFD_LUO_MIGRATE_RETRIES; retry++) {
> >> +		err = shmem_get_folio(inode, index, 0, &folio, SGP_CACHE);
> >> +		if (err)
> >> +			return err;
> >> +
> >> +		if (likely(folio_is_longterm_pinnable(folio))) {
> >> +			*foliop = folio;
> >> +			return 0;
> >> +		}
> >> +
> >> +		folio_unlock(folio);
> >> +		err = memfd_luo_migrate_folio(folio);
> >> +		/* Someone else might have it isolated, retry a bit. */
> >> +		if (err && err != -EBUSY)
> >> +			return err;
> >> +	}
> >> +
> >> +	return -EBUSY;
> >
> > In v2 we did another shmem_get_folio() after a successfull migration,
> > now even if the last iteration migrates successfully we still return
> > -EBUSY and don't update *foloip.
> 
> Argh, right... Good catch!
> 
> How about this:
> 
> 	for (retry = 0; ; retry++) {
> 		err = shmem_get_folio(inode, index, 0, &folio, SGP_CACHE);
> 		if (err)
> 			return err;
> 
> 		if (likely(folio_is_longterm_pinnable(folio))) {
> 			*foliop = folio;
> 			return 0;
> 		}
> 
> 		folio_unlock(folio);
> 		if (retry == MEMFD_LUO_MIGRATE_RETRIES) {
> 			folio_put(folio);
> 			return -EBUSY;
> 		}
> 
> 		err = memfd_luo_migrate_folio(folio);
> 		/* Someone else might have it isolated, retry a bit. */
> 		if (err && err != -EBUSY)
> 			return err;
> 	}
> 
> 	/* Should never get here. */
> 	return -EINVAL;
> 
> Or, I suppose I can go back to the original implementation.
> 
> What do you think?

v2 was better I think, but it still had that

		if (err == -EBUSY && ++busy_retries < MEMFD_LUO_MIGRATE_RETRIES)
			continue;
		if (err)
			return err;

which I don't really like.

I came up with a variant below that IMHO makes things more explicit:

static int memfd_luo_get_folio(struct inode *inode, pgoff_t index,
			       struct folio **foliop)
{
	int err, retries = 0;
	struct folio *folio;

	for (;;) {
		if (retries > MEMFD_LUO_MIGRATE_RETRIES)
			return -EBUSY;

		err = shmem_get_folio(inode, index, 0, &folio, SGP_CACHE);
		if (err)
			return err;

		if (likely(folio_is_longterm_pinnable(folio)))
			break;

		folio_unlock(folio);
		err = memfd_luo_migrate_folio(folio);
		if (err) {
			if (err != -EBUSY)
				return err;
			retries++;
		}
	}

	*foliop = folio;
	return 0;
}

It does an iteration more than v2 with the same MEMFD_LUO_MIGRATE_RETRIES,
but that's not really important.

Your call really, I can live with either of them.
 
> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.

