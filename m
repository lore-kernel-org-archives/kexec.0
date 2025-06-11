Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 565F0C71141
	for <kexec@archiver.kernel.org>; Wed, 11 Jun 2025 17:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tz0s9Nhk1NekMxgXFzl8NlI6KDa9+1IDHOxFID8tMZM=; b=mcdLnGZyvozREnDBuJGxbJt8lt
	tArABnDtOZEAMx9MKn6H1WJe5sjcR5KWPp4RxlgkTOfAnq1XvFO+eQzmpXXL8tkLURCM2j68FkN/p
	WW1IbSaeNCSA1DOvn2okkc0jaoz2CexWIM2cewM7cCBCS7J+NLMFA2udTqAFnj4yP6+vhLp24vdyx
	TmUGCqIdHQY7XGD9u/6oDXhCS8tddFKdBKxrFhqAGyoVpDZR6Vn/dKKo0KYdFFy2ikxRoD+89qQ48
	A7IovWRMW81wwfR5cuBCXgv7e1Yl+j40Tugc4cyywI+jPPFPtXOeMqsAKAe63woapHU3p5KiPc6Ee
	aiFpYJMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPPjf-0000000Alkx-0DZi;
	Wed, 11 Jun 2025 17:59:39 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPL9j-00000009uyf-0IlP
	for kexec@lists.infradead.org;
	Wed, 11 Jun 2025 13:06:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 74846629F6;
	Wed, 11 Jun 2025 13:06:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64DD7C4CEF3;
	Wed, 11 Jun 2025 13:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749647174;
	bh=EfalNR3PDNY/xJp/lHBiYvQkpmXJrUDUdS4YWf1xllw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HCRACyj6aEf4dnGcjywhOK8Dl8sqsXVP98Sc28D6Vp3FdXAV1yR8nV7lw2Xq0QAja
	 c6XYzCpzNS9ZFn8vfO17Ils8afPFrQjRDJXDzqot8B9PG3JQb4nilR51/eSfoqQUq8
	 jzcBKaxoeIIM1oA10ODttFxBYr4CemZQf6p9Lz7O1K8xe4G8fD9GAZ06+9yXs4ef3d
	 +jxsMLVjlRmum5eD0qYmY17wDTvTRk4A2aBbqdatoIzxv2aWO6PetwCTbTJCij1mWW
	 p/Z7phbdkdGWYVoQmMXufNhW8KqgKu+xksURZLd3BmCVgGanofNMM1Lmtv4iJTBsEA
	 /REcd+UZGNI2A==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Mike Rapoport <rppt@kernel.org>,  Pratyush Yadav <pratyush@kernel.org>,
  Alexander Graf <graf@amazon.com>,  Changyuan Lyu <changyuanl@google.com>,
  Andrew Morton <akpm@linux-foundation.org>,  Baoquan He <bhe@redhat.com>,
  kexec@lists.infradead.org,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  Michal Clapinski <mclapinski@google.com>
Subject: Re: [PATCH] kho: initialize tail pages for higher order folios
 properly
In-Reply-To: <CA+CK2bD3n=JDuSsMGvsyMnVbPhGdhdf6zWFDa3KpzRGEXygdgQ@mail.gmail.com>
References: <20250605171143.76963-1-pratyush@kernel.org>
	<aEKhF3HcrvG77Ogb@kernel.org> <mafs0jz5osutx.fsf@kernel.org>
	<aEc30BoLE9HRxiZm@kernel.org>
	<CA+CK2bAAbZjS2Og79xxLcDtNf-eM0up-8fwhd4fg_dp0j_TahA@mail.gmail.com>
	<aEfGTXrsEL5-DuF1@kernel.org>
	<CA+CK2bDXOWzrTsNtbCCK2rabNysf0JFQT5VfAjYrX5oSoiLmSQ@mail.gmail.com>
	<aEhgNU80Dr9iRwoD@kernel.org>
	<CA+CK2bD3n=JDuSsMGvsyMnVbPhGdhdf6zWFDa3KpzRGEXygdgQ@mail.gmail.com>
Date: Wed, 11 Jun 2025 15:06:11 +0200
Message-ID: <mafs0qzzqo2bg.fsf@kernel.org>
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

On Tue, Jun 10 2025, Pasha Tatashin wrote:

>> > > I think it should be the other way around, KHO should depend on
>> > > !DEFERRED_STRUCT_PAGE_INIT.
>> >
>> > Agreed, and this is what I first tried, but that does not work, there
>> > is some circular dependency breaking the build. If you feel
>> > adventurous you can try that :-)
>>
>> Hmm, weird, worked for me :/

Worked for me as well.

>
> I am super confused, it did not work for me over weekend, and now it
> is working. Even `make menuconfig` would not work. Anyways, I will put
> it in the appropriate place.
>
>>
>> > > > We will need to teah KHO to work with deferred struct page init. I
>> > > > suspect, we could init preserved struct pages and then skip over them
>> > > > during deferred init.
>> > >
>> > > We could, but with that would mean we'll run this before SMP and it's not
>> > > desirable. Also, init_deferred_page() for a random page requires
>> >
>> > We already run KHO init before smp_init:
>> > start_kernel() -> mm_core_init() -> kho_memory_init() ->
>> > kho_restore_folio() -> struct pages must be already initialized here!
>> >
>> > While deferred struct pages are initialized:
>> > start_kernel() -> rest_init() -> kernel_init() ->
>> > kernel_init_freeable() -> page_alloc_init_late() ->
>> > deferred_init_memmap()
>> >
>> > If the number of preserved pages that is needed during early boot is
>> > relatively small, that it should not be an issue to pre-initialize
>> > struct pages for them before deferred struct pages are initialized. We
>> > already pre-initialize some  "struct pages" that are needed during
>> > early boot before the reset are initialized, see deferred_grow_zone()
>>
>> deferred_grow_zone() takes a chunk in the beginning of uninitialized range,
>> with kho we are talking about some random pages. If we preinit them early,
>> deferred_init_memmap() will overwrite them.
>
> Yes, this is why I am saying that we would need to skip the KHO
> initialized "struct pages" somehow during deferred initialization. If
> we create an ordered by PFN list of early-initialized KHO struct
> pages, skipping during deferred initialization could be done
> efficiently.

Or keep things simple and don't use any KHO struct pages during early
init. You can access the page itself, just don't use its struct page.

Currently the only user of kho_restore_folio() during init is
kho_memory_init(). The FDT is accessed by doing
phys_to_virt(kho_in.fdt_phys) anyway, so there is really no need for
restoring the folio so early. It can be done later, for example when LUO
does the finish event, to clean up and free the folio.

-- 
Regards,
Pratyush Yadav

