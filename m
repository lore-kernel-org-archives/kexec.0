Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADB0606A31E
	for <kexec@archiver.kernel.org>; Tue, 24 Nov 2026 18:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=AhjQ3XqY;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aOCxnsb8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=kHUlsupwDOpkHbLX8S2w072pY8Rr3ikdGTNicvjXqnc=; b=AhjQ3XqY3TDnFXbm37EdekDj1K
	CTlPfCv/s7NlddPcHq78wvcMK1wNe7Ru/L9y0m+AYr4RB0DyQGeapDOJP08sCfzqcmx0eCwIcvXNa
	/QjPkPw0S7Y/aTPOLOQg+c0rfD0hrSS8ZuTsS1AsQ9OzeG6gLstx34A0gXFnX+YFOpGd9AQM29qi/
	sQontqhmataWLcMAABmK2g4+BICVx4S5HgiQ3zJZH8OoC5C5UbpcXctqXo3f/agyuWDgJoxTHVAs6
	9GupPHs4TK9VdNZBa19cju6n4FKyA18GHCIsKDAOzJRZUex1ifguGF798qE1vvNagIEVbLSYvQEt9
	bPlL+jdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVupm-00000007Rqo-20at;
	Tue, 24 Nov 2026 18:01:38 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVupl-00000007RqU-1gkJ
	for kexec@lists.infradead.org;
	Tue, 24 Nov 2026 18:01:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 75CD462884;
	Tue, 24 Nov 2026 18:01:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF151F000D0;
	Tue, 24 Nov 2026 18:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795543296;
	bh=kHUlsupwDOpkHbLX8S2w072pY8Rr3ikdGTNicvjXqnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aOCxnsb8KPo+uJrOTN2VG0/4LzIxOzbWkwFqqZPQqsYidT1LLQds618V5lhevH4cZ
	 ej1MUDUfWcJgncApHe/rrdwWbCxUG8cV5c6de3Q4njvOYqmVc01Uv/Y++uX6vESr2m
	 45lz90ReFnUu+mllQHU/ZP/mRkUaa9hXavmj0vO2IXP3+q1U/c1I27mqUXCb3ZJ/4P
	 vP4hw80hjwtC/HjjhEv5DXnz/NJN5w8MMALFsjvA68MUA+ciDfSjXrbDDhFLqZ7wtu
	 iq+89nJGM972PYb5N8h9knZmqK9DAfA0Zj9W07jBwwW1p57V47z4WmVx0uNShB2Dzs
	 +NX9oH8Lpn0+g==
Date: Tue, 24 Nov 2026 20:01:30 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v3] mm/memfd_luo: don't use memfd_pin_folios()
Message-ID: <awXQ-sYNkY-TALqE@kernel.org>
References: <20261123130115.4021199-1-pratyush@kernel.org>
 <179546369651.425130.14155931836758567682.b4-review@b4>
 <2vxzo6bez3hs.fsf@kernel.org>
 <awWx1YnA0PcB2RaB@kernel.org>
 <2vxztsl6xj59.fsf@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxztsl6xj59.fsf@kernel.org>
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

On Tue, Nov 24, 2026 at 04:56:50PM +0000, Pratyush Yadav wrote:
> On Tue, Nov 24 2026, Mike Rapoport wrote:
> 
> > On Tue, Nov 24, 2026 at 02:51:59PM +0000, Pratyush Yadav wrote:
> >> On Mon, Nov 23 2026, Mike Rapoport wrote:
> [...]
> > v2 was better I think, but it still had that
> >
> > 		if (err == -EBUSY && ++busy_retries < MEMFD_LUO_MIGRATE_RETRIES)
> > 			continue;
> > 		if (err)
> > 			return err;
> >
> > which I don't really like.
> >
> > I came up with a variant below that IMHO makes things more explicit:
> >
> > static int memfd_luo_get_folio(struct inode *inode, pgoff_t index,
> > 			       struct folio **foliop)
> > {
> > 	int err, retries = 0;
> > 	struct folio *folio;
> >
> > 	for (;;) {
> > 		if (retries > MEMFD_LUO_MIGRATE_RETRIES)
> > 			return -EBUSY;
> >
> > 		err = shmem_get_folio(inode, index, 0, &folio, SGP_CACHE);
> > 		if (err)
> > 			return err;
> >
> > 		if (likely(folio_is_longterm_pinnable(folio)))
> > 			break;
> >
> > 		folio_unlock(folio);
> > 		err = memfd_luo_migrate_folio(folio);
> > 		if (err) {
> > 			if (err != -EBUSY)
> > 				return err;
> > 			retries++;
> > 		}
> > 	}
> 
> This has a super theoretical corner case where the migration can
> succeed, then the folio can migrate back to CMA by the time we do
> shmem_get_folio(). So we can loop infinitely.

Oops :)
 
> I think the if (retries > MEMFD_LUO_MIGRATE_RETRIES) should be after the
> folio_is_longterm_pinnable() check and retries should increment after

Maybe after folio_unlock() then?

> every migration, not only failed ones.
> 
> Apart from that, your variant looks nicer.
> 
> Does that sound good?
> 
> >
> > 	*foliop = folio;
> > 	return 0;
> > }
> >
> > It does an iteration more than v2 with the same MEMFD_LUO_MIGRATE_RETRIES,
> > but that's not really important.
> >
> > Your call really, I can live with either of them.
> 
> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.

