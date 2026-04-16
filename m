Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 002A3F8A146
	for <kexec@archiver.kernel.org>; Thu, 16 Apr 2026 09:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lNY0efeN81fPPEk7hSc0vbaPFWkcvmDpUyEhycoFZW4=; b=SDKkpDr+JSVHp+i+11pweK2zva
	ztLZtiWAAdGfmfz0GGhH9rzV51U6H6uAV4E/oFQf3gcITHi95HpXmWGUstIFceinfI0StOkP9NZsU
	uJUKK3LNH6GL1slnCEDcjErZ5lYs3oWFCt6tJZRSy6ejlApkXUa/pw12rTuFwzC5SSwyGLfMSIP9b
	JpXcBVTP7JOvyTxDZlaEmG64ah9aHSsgW+C2jClNYBUO9BUo9sAx9oV1tRPH5lH00R+A5RQXx3DHC
	v/RYVUIrkN6cB8oAy60rowvzoy0K7dQ0XaDTFDe+ZOYe25LO/2u2RsJSVZuj1E3nUJF+DlTvnUsk/
	mB7FHFKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDJDu-00000002Ftf-29Lk;
	Thu, 16 Apr 2026 09:41:22 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDJDs-00000002FtN-1jEl
	for kexec@lists.infradead.org;
	Thu, 16 Apr 2026 09:41:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B6A2D60131;
	Thu, 16 Apr 2026 09:41:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5D1C2BCAF;
	Thu, 16 Apr 2026 09:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776332479;
	bh=2alzcICEC3k3e6IxHUG9ZYQslVBWBu0n2/gQ20xdRCU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=OdMSTtrEFg4+AGBw878XaR6uOAeNGvy/8yLqfJgPzBcEDzZ5fp6NaaNoMwboYXmJ1
	 7txHfU9adWdlrfIaaFQAscBcBAs5h3myYVDtGYstooiXzpqVeIB4kVus2LLAjrcieY
	 rmTVnpOms3yewsFmqwnNSGQlTlvPiRRPgon8/uNrdU6ecf8bErhYWfmzo/VDNL91y1
	 mmE3niwtXR2kS0wlP5YmV1LiquITUyAkMuCGQprFBcxlXASwnBIQzy78QiyVSkC3xn
	 E1uTWzoeDUF81anyAgjfMsoOTLa8Of82Jte969TF2IuQty8jNkGyAgF8HL3IYFMtKX
	 Cp5v8B/Fb59Rg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  =?utf-8?B?TWljaGHFgiBDxYJhcGk=?=
 =?utf-8?B?xYRza2k=?=
 <mclapinski@google.com>,  Zi Yan <ziy@nvidia.com>,  Evangelos Petrongonas
 <epetron@amazon.de>,  Pasha Tatashin <pasha.tatashin@soleen.com>,
  Alexander Graf <graf@amazon.com>,  Samiullah Khawaja
 <skhawaja@google.com>,  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v7 2/3] kho: fix deferred init of kho scratch
In-Reply-To: <adfqkOWVFgeAkItF@kernel.org> (Mike Rapoport's message of "Thu, 9
	Apr 2026 21:06:08 +0300")
References: <CAAi7L5dSOxXETv-bYs4hJ1SfixMBQXS4fmfKs3SzVvQ=yY7oSg@mail.gmail.com>
	<76559EF5-8740-4691-8776-0ADD1CCBF2A4@nvidia.com>
	<CAAi7L5ex+66qgFzRkLDbuOmC=cVrMyBctPZv6wd15n1rc2U9KQ@mail.gmail.com>
	<0D1F59C7-CA35-49C8-B341-32D8C7F4A345@nvidia.com>
	<CAAi7L5fvUPUqd3A4m6wubeYh90NH+S2KBRE1R8WKerBYhkU8kg@mail.gmail.com>
	<58A8B1B4-A73B-48D2-8492-A58A03634644@nvidia.com>
	<aburnbP64n9axmu_@kernel.org>
	<CAAi7L5evx8ta8BifNiGNfUoTiaBUsv4cgQRbm_15RoAfdKPcMw@mail.gmail.com>
	<acAAp4JaTGn_STBH@kernel.org> <2vxzwlyj9d0b.fsf@kernel.org>
	<adfqkOWVFgeAkItF@kernel.org>
Date: Thu, 16 Apr 2026 09:41:14 +0000
Message-ID: <2vxzo6jj6y4l.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Thu, Apr 09 2026, Mike Rapoport wrote:

> On Tue, Apr 07, 2026 at 12:21:56PM +0000, Pratyush Yadav wrote:
>> On Sun, Mar 22 2026, Mike Rapoport wrote:
>>=20
>> > On Thu, Mar 19, 2026 at 07:17:48PM +0100, Micha=C5=82 C=C5=82api=C5=84=
ski wrote:
[...]
>> Can we just get rid of this entirely? And just update
>> memmap_init_zone_range() to also look for scratch and set the
>> migratetype correctly from the get go? That's more consistent IMO. The
>> two main places that initialize the struct page,
>> memmap_init_zone_range() and deferred_init_memmap_chunk(), check for
>> scratch and set the migratetype correctly.
>
> We could. E.g. let memmap_init() check the memblock flags and pass the
> migratetype to memmap_init_zone_range().
>
> I wanted to avoid as much KHO code in mm/ as possible, but if it is must
> have in deferred_init_memmap_chunk() we could add some to memmap_init() as
> well.

KHO fundamentally alters mm init, so I think it would be hard to keep it
to a neat corner unfortunately... We have been somewhat successful so
far, but that has come at the cost of performance. Once we start trying
to improve performance, I reckon more and more of it will spill into mm
init.

>=20=20
>> > @@ -2061,12 +2060,15 @@ deferred_init_memmap_chunk(unsigned long start=
_pfn, unsigned long end_pfn,
>> >  		spfn =3D max(spfn, start_pfn);
>> >  		epfn =3D min(epfn, end_pfn);
>> >=20=20
>> > +		if (memblock_is_kho_scratch_memory(PFN_PHYS(spfn)))
>> > +			mt =3D MIGRATE_CMA;
>>=20
>> Would it make sense for for_each_free_mem_range() to also return the
>> flags for the region? Then you won't have to do another search. It adds
>> yet another parameter to it so no strong opinion, but something to
>> consider.
>
> I hesitated a lot about this.
> Have you seen memblock::__next_mem_range() signature? ;-)

Fair enough :-O

>
> I decided to start with something correct, but slowish and leave the churn
> and speed for later.

--=20
Regards,
Pratyush Yadav

