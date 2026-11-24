Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2744606A32C
	for <kexec@archiver.kernel.org>; Tue, 24 Nov 2026 18:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bWBMCATu;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W4Z3pRyA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6NnSt+5MgSPrSh5hGTfh0N0vas814GEFyC4NmY/aZJQ=; b=bWBMCATu52lOZW/PDu/nNiXMYM
	kpiudDZOcCwPDMI9q4O4Jex/kbwht8qmkT94buz0YwNW+lgH4xgvdiHCuctd+YGdXp/MPw8RlPhJF
	xlBBPTo6ywCbEvVXs2c5J640JcV1vGk3kGMu2RmodFqmVVGnEnj6LY7nrt6PViGqaD150xXtf0QdX
	T8qJscoqSpEQaPqEJiq4oReHizjyIqLIOibfN49TGpSFj/xxbyUwJPWikJNC+J2lFZp+KQibJDU7c
	2XLS1XlOsz5Fq1YfX8zVcy8R2lGXEzJKZI2m8q1LL3YOGC5GpENDaIGMluPWCMjtir5eS/qoe3w37
	kAtvLgCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVvF5-00000007Uli-17tB;
	Tue, 24 Nov 2026 18:27:47 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVvF3-00000007UlY-1tf6
	for kexec@lists.infradead.org;
	Tue, 24 Nov 2026 18:27:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EC7AD40996;
	Tue, 24 Nov 2026 18:27:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03821F000C6;
	Tue, 24 Nov 2026 18:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795544864;
	bh=6NnSt+5MgSPrSh5hGTfh0N0vas814GEFyC4NmY/aZJQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=W4Z3pRyAGAKenXsQ8RQhpNCCOYrOv8BxiWZ059qbalZp3zlzhDwlm97UbaFSmAHN8
	 cIUGceHwJ1I8J2bG6ficooY7fcSULumr8ZT+4oA4Xk0HQ2X1OLlFzKdbT5ModoUdcb
	 muxJWnfO555Leiz/emOtvnNZ8mSa583PNA2az5/S0f6UKPJYbPUpYHhlXuXccWorVQ
	 4M8ACH0rHD1+bhGKupIPBXO3Ph/EOdB6V87sOT32aPLDFF8cXff16GFwwXCeYohO1F
	 qOG3oTB5sP4VUHB1TPAZwAyjsD+z/Ep0NHeBmIkrw2GdhUpmhWq+tNrR6o58PekVw2
	 xIzQ6Vq4JkXvw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Andrew Morton <akpm@linux-foundation.org>,
  kexec@lists.infradead.org,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org
Subject: Re: [PATCH v3] mm/memfd_luo: don't use memfd_pin_folios()
In-Reply-To: <awXQ-sYNkY-TALqE@kernel.org> (Mike Rapoport's message of "Tue,
	24 Nov 2026 20:01:30 +0200")
References: <20261123130115.4021199-1-pratyush@kernel.org>
	<179546369651.425130.14155931836758567682.b4-review@b4>
	<2vxzo6bez3hs.fsf@kernel.org> <awWx1YnA0PcB2RaB@kernel.org>
	<2vxztsl6xj59.fsf@kernel.org> <awXQ-sYNkY-TALqE@kernel.org>
Date: Tue, 24 Nov 2026 18:27:41 +0000
Message-ID: <2vxzpkvuxexu.fsf@kernel.org>
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24 2026, Mike Rapoport wrote:

> On Tue, Nov 24, 2026 at 04:56:50PM +0000, Pratyush Yadav wrote:
>> On Tue, Nov 24 2026, Mike Rapoport wrote:
>> 
>> > On Tue, Nov 24, 2026 at 02:51:59PM +0000, Pratyush Yadav wrote:
>> >> On Mon, Nov 23 2026, Mike Rapoport wrote:
>> [...]
>> > v2 was better I think, but it still had that
>> >
>> > 		if (err == -EBUSY && ++busy_retries < MEMFD_LUO_MIGRATE_RETRIES)
>> > 			continue;
>> > 		if (err)
>> > 			return err;
>> >
>> > which I don't really like.
>> >
>> > I came up with a variant below that IMHO makes things more explicit:
>> >
>> > static int memfd_luo_get_folio(struct inode *inode, pgoff_t index,
>> > 			       struct folio **foliop)
>> > {
>> > 	int err, retries = 0;
>> > 	struct folio *folio;
>> >
>> > 	for (;;) {
>> > 		if (retries > MEMFD_LUO_MIGRATE_RETRIES)
>> > 			return -EBUSY;
>> >
>> > 		err = shmem_get_folio(inode, index, 0, &folio, SGP_CACHE);
>> > 		if (err)
>> > 			return err;
>> >
>> > 		if (likely(folio_is_longterm_pinnable(folio)))
>> > 			break;
>> >
>> > 		folio_unlock(folio);
>> > 		err = memfd_luo_migrate_folio(folio);
>> > 		if (err) {
>> > 			if (err != -EBUSY)
>> > 				return err;
>> > 			retries++;
>> > 		}
>> > 	}
>> 
>> This has a super theoretical corner case where the migration can
>> succeed, then the folio can migrate back to CMA by the time we do
>> shmem_get_folio(). So we can loop infinitely.
>
> Oops :)
>  
>> I think the if (retries > MEMFD_LUO_MIGRATE_RETRIES) should be after the
>> folio_is_longterm_pinnable() check and retries should increment after
>
> Maybe after folio_unlock() then?

Right. Sounds good.

>
>> every migration, not only failed ones.
>> 
>> Apart from that, your variant looks nicer.
>> 
>> Does that sound good?
[...]

-- 
Regards,
Pratyush Yadav

