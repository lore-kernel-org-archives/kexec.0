Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B0FC71148
	for <kexec@archiver.kernel.org>; Fri, 13 Jun 2025 15:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F40l49kROy//bCHAH9EyoBv8EvpOtzaWqX+WT7SDDYg=; b=0UX8oTNAF0mFQ/W58o3K31ixJj
	+o4iVd3Jtr1xrsv4OGEMpz5cFh6xWyGVFHiGlmZp49GkPEsJ6HL5RVguMHkfbVCHqVYCkmpvmhHSh
	PTz9jwY3S3QdvUgEFEVGGEZyEC2iiwqLBVWcXlhyWdBhDABin68umYcPBitZnIw+lWxi5paS4kdj3
	euH3bEfV8k4puNEUIHG3152Wa7VoO+QkaaOvflF05PeXCr8c+WrGXA/msFV6gJyGLieNT9SWqoAyU
	wvmh1cjXjhEH9wNQSd6YkNxWtcxPO9KxpKWLilAtq4CMa0j3vUDnFHH2Qc1vjft6M45x8y+CT6yws
	OuaWdAlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQ6KB-0000000GsfL-13mw;
	Fri, 13 Jun 2025 15:28:11 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQ5Ii-0000000GgHl-0InI
	for kexec@lists.infradead.org;
	Fri, 13 Jun 2025 14:22:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id BAF0A5C6AC5;
	Fri, 13 Jun 2025 14:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57FF2C4CEF1;
	Fri, 13 Jun 2025 14:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749824555;
	bh=mFrrGfLemhIJ3f/aDQPvUYUk++CNfebL5xpQeoqtlTo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=J9dzXAFEnZgd4nf1M5o7aWGcV/gX9j/9MDOyEwxli67WfOelfJk0qeCctddCBj6Bj
	 hGgEfzIZVVzzJukrthsoZZQoRGrvdse7kXhvO4BcjdqRyoYT2/GQq1XoFkbpJ8jycx
	 MAhYZ+Q8XLztkCx2EP0kJ3ii0ZIHICr7KAFcExYM24G8f8gY4BIALSggI6X85EDwED
	 LCSuyA9la02D+RsIX1PRMMLN2s6AsUR4gDRjjiG196yP4HZWJM/bhC5Zb6V/+MzF07
	 JenuoVPQL6pTTm5mRI4GV5y11lqDMOMVFCxUYdorgZFftJxWZHbz9DSwSTL4LaoLA1
	 dtEewPyS5Wz8w==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Alexander Graf <graf@amazon.com>,  Changyuan
 Lyu <changyuanl@google.com>,  Andrew Morton <akpm@linux-foundation.org>,
  Baoquan He <bhe@redhat.com>,  kexec@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  Michal Clapinski
 <mclapinski@google.com>
Subject: Re: [PATCH] kho: initialize tail pages for higher order folios
 properly
In-Reply-To: <aEmUU4L3eStEsYQM@kernel.org>
References: <aEc30BoLE9HRxiZm@kernel.org>
	<CA+CK2bAAbZjS2Og79xxLcDtNf-eM0up-8fwhd4fg_dp0j_TahA@mail.gmail.com>
	<aEfGTXrsEL5-DuF1@kernel.org>
	<CA+CK2bDXOWzrTsNtbCCK2rabNysf0JFQT5VfAjYrX5oSoiLmSQ@mail.gmail.com>
	<aEhgNU80Dr9iRwoD@kernel.org>
	<CA+CK2bD3n=JDuSsMGvsyMnVbPhGdhdf6zWFDa3KpzRGEXygdgQ@mail.gmail.com>
	<mafs0qzzqo2bg.fsf@kernel.org>
	<CA+CK2bBoMfJuUCV6sL80kwzYPnENnt7fDk2jRMPV0iPn1jCJdw@mail.gmail.com>
	<aEmGMNL9v9djgrGz@kernel.org> <mafs0ikl2nzqn.fsf@kernel.org>
	<aEmUU4L3eStEsYQM@kernel.org>
Date: Fri, 13 Jun 2025 16:22:32 +0200
Message-ID: <mafs0wm9fn2l3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250613_072236_199730_F0772FED 
X-CRM114-Status: GOOD (  40.37  )
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

On Wed, Jun 11 2025, Mike Rapoport wrote:

> On Wed, Jun 11, 2025 at 04:01:52PM +0200, Pratyush Yadav wrote:
>> On Wed, Jun 11 2025, Mike Rapoport wrote:
>>=20
>> > On Wed, Jun 11, 2025 at 09:14:55AM -0400, Pasha Tatashin wrote:
>> >> On Wed, Jun 11, 2025 at 9:06=E2=80=AFAM Pratyush Yadav <pratyush@kern=
el.org> wrote:
>> >> >
>> >> > On Tue, Jun 10 2025, Pasha Tatashin wrote:
>> >> >
>> >> > >> > > I think it should be the other way around, KHO should depend=
 on
>> >> > >> > > !DEFERRED_STRUCT_PAGE_INIT.
>> >> > >> >
>> >> > >> > Agreed, and this is what I first tried, but that does not work=
, there
>> >> > >> > is some circular dependency breaking the build. If you feel
>> >> > >> > adventurous you can try that :-)
>> >> > >>
>> >> > >> Hmm, weird, worked for me :/
>> >> >
>> >> > Worked for me as well.
>> >> >
>> >> > >
>> >> > > I am super confused, it did not work for me over weekend, and now=
 it
>> >> > > is working. Even `make menuconfig` would not work. Anyways, I wil=
l put
>> >> > > it in the appropriate place.
>> >> > >
>> >> > >>
>> >> > >> > > > We will need to teah KHO to work with deferred struct page=
 init. I
>> >> > >> > > > suspect, we could init preserved struct pages and then ski=
p over them
>> >> > >> > > > during deferred init.
>> >> > >> > >
>> >> > >> > > We could, but with that would mean we'll run this before SMP=
 and it's not
>> >> > >> > > desirable. Also, init_deferred_page() for a random page requ=
ires
>> >> > >> >
>> >> > >> > We already run KHO init before smp_init:
>> >> > >> > start_kernel() -> mm_core_init() -> kho_memory_init() ->
>> >> > >> > kho_restore_folio() -> struct pages must be already initialize=
d here!
>> >> > >> >
>> >> > >> > While deferred struct pages are initialized:
>> >> > >> > start_kernel() -> rest_init() -> kernel_init() ->
>> >> > >> > kernel_init_freeable() -> page_alloc_init_late() ->
>> >> > >> > deferred_init_memmap()
>> >> > >> >
>> >> > >> > If the number of preserved pages that is needed during early b=
oot is
>> >> > >> > relatively small, that it should not be an issue to pre-initia=
lize
>> >> > >> > struct pages for them before deferred struct pages are initial=
ized. We
>> >> > >> > already pre-initialize some  "struct pages" that are needed du=
ring
>> >> > >> > early boot before the reset are initialized, see deferred_grow=
_zone()
>> >> > >>
>> >> > >> deferred_grow_zone() takes a chunk in the beginning of uninitial=
ized range,
>> >> > >> with kho we are talking about some random pages. If we preinit t=
hem early,
>> >> > >> deferred_init_memmap() will overwrite them.
>> >> > >
>> >> > > Yes, this is why I am saying that we would need to skip the KHO
>> >> > > initialized "struct pages" somehow during deferred initialization=
. If
>> >> > > we create an ordered by PFN list of early-initialized KHO struct
>> >> > > pages, skipping during deferred initialization could be done
>> >> > > efficiently.
>> >> >
>> >> > Or keep things simple and don't use any KHO struct pages during ear=
ly
>> >> > init. You can access the page itself, just don't use its struct pag=
e.
>> >> >
>> >> > Currently the only user of kho_restore_folio() during init is
>> >> > kho_memory_init(). The FDT is accessed by doing
>> >> > phys_to_virt(kho_in.fdt_phys) anyway, so there is really no need for
>> >> > restoring the folio so early. It can be done later, for example whe=
n LUO
>> >> > does the finish event, to clean up and free the folio.
>> >>=20
>> >> Good suggestion, however, KHO does not have any sophisticated users
>> >> that we are going to be adding as part of the live update work in the
>> >> future: IR, KVM, early VCPU threads, and so on. So, while today, this
>> >> might work, in the future, I am not sure if we should expect struct
>> >> pages are not accessed until after deferred initialization or simply
>> >> fix it once and for all.
>> >
>> > KHO already accesses stuct page early and uses page->private for order.
>> > Since preserved memory is reserved in memblock, deferred init of struct
>> > pages won't touch those pages, we just need to make sure they are prop=
erly=20
>>=20
>> Not strictly true. Some of them might have been initialized from
>> free_area_init() -> memmap_init() (the ones not eligible for deferred
>> init), which happens before KHO makes its memblock reservations.
>>=20
>> > initialized at some point. If we don't expect many kho_restore_folio()
>> > before page_alloc_init_late() we can use init_deferred_page() for early
>> > accesses.
>>=20
>> I tried doing this when looking into this initially, but it doesn't work
>> for some reason.
>>=20
>>     static void kho_restore_page(struct page *page, unsigned int order)
>>     {
>>     	unsigned int i, nr_pages =3D (1 << order);
>>=20=20=20=20=20
>>     	/* Head page gets refcount of 1. */
>>     	init_deferred_page(page_to_pfn(page), NUMA_NO_NODE);
>
>
> This would do
>
> 	if (early_page_initialised(pfn, nid))
> 		return;
>
> 	__init_page_from_nid(pfn, nid);
>
> and I'm really surprised it didn't crash in early_page_initialised()
> because of NUMA_NO_NODE :)

Oh, right. Using the wrong node completely throws
early_page_initialised() off.

>
> What might work here is=20
>
> 	pfn =3D page_to_pfn(page);
> 	__init_page_from_nid(pfn, early_pfn_to_nid(pfn));

Yep, that works. Although this would do early_pfn_to_nid() for each page
so it isn't very efficient. And we also need to make sure memblock does
not go away.

>
>>     	set_page_count(page, 1);
>>=20=20=20=20=20
>>     	/* For higher order folios, tail pages get a page count of zero. */
>>     	for (i =3D 1; i < nr_pages; i++) {
>>     		init_deferred_page(page_to_pfn(page + i), NUMA_NO_NODE);
>>     		set_page_count(page + i, 0);
>>     	}
>>=20=20=20=20=20
>>     [...]
>>=20
[...]

--=20
Regards,
Pratyush Yadav

