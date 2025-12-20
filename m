Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07221E668A7
	for <kexec@archiver.kernel.org>; Sat, 20 Dec 2025 02:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zElPwkkKCTpgywLCxZoiTR8/3qzdGiW3Zx7g5xyPThE=; b=DdsSyTORQhTbSCU2iHXzwqo+Yh
	Zr9JEtV9Y0ZYt2wXLziu/63+R1CYypXFedn9gpKz9LQ4sMy0716PaYUbaAI5Km7sydZ2MccDtLYIS
	NEgE6qEjM4guM/2IWuSVOGZSWny6FI0+Cu/jcGbtbfSSjvI/0mhCyFNi2Nispp65REGQCIZvjlikz
	8EpyqQaneAkwFYsO6xhkSzAIvFz93MJ5dEBrKQMote/DWyuTI42RhtPHeX26u6W4rTrwq23ikD8xB
	Hy3rHLM7GtiRuYQpHxFftKX5VmtbHbXzxtKJnqyGxAX7yFFKAmHdj8IgAtc1FujRaDN47vfu5tRMu
	QkVVrQrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWmh3-0000000BD76-3YDi;
	Sat, 20 Dec 2025 02:27:41 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWmh1-0000000BD6k-0Yv3
	for kexec@lists.infradead.org;
	Sat, 20 Dec 2025 02:27:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id BB05B4369E;
	Sat, 20 Dec 2025 02:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A908FC4CEF1;
	Sat, 20 Dec 2025 02:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766197654;
	bh=8gJbQgrMoqDVTMXtu843sIWuj5pklhAvmPm/aifE1ko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=chNtVVpzYpRYAj8/vIOo8wxb6sD4anNSHoDTf3VFoTfx2iuUoEfN7p/hOZ70kpLPJ
	 2tqiaWsvEBz4295hBXG+7i7rkrPyjhKHbz2aoWLFko7yBXGtgrri8NkQM/fyJXTwp+
	 aboma+arqiJoas03/CAS9S1b6A+yu1PBBOeW4xu6AWnYMpA4W1fvXyRA6DNEpORmFK
	 q9ZQVsgiqG4R1QYGIA8TIS23Izw7o1BmPziPcazKjwEmSK3M+VdEVhGDCrGFu30NNI
	 Np07K9faJCdOIwFse2aXsfKpmAGY/tXErS0HIazzb6FCMlJG7zCz4QgkvJlq56DD7J
	 woqh8h76j4HyQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Mike Rapoport <rppt@kernel.org>,  Evangelos Petrongonas
 <epetron@amazon.de>,  Pratyush Yadav <pratyush@kernel.org>,  Alexander
 Graf <graf@amazon.com>,  Andrew Morton <akpm@linux-foundation.org>,  Jason
 Miu <jasonmiu@google.com>,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  nh-open-source@amazon.com
Subject: Re: [PATCH] kho: add support for deferred struct page init
In-Reply-To: <CA+CK2bDLkf=5Mk0XH2XvUFS1px4cROBRjO+eKd4zvgzrS=Z-xA@mail.gmail.com>
	(Pasha Tatashin's message of "Tue, 16 Dec 2025 10:51:57 -0500")
References: <20251216084913.86342-1-epetron@amazon.de>
	<aUFJH9xzJXYOt_X8@kernel.org>
	<CA+CK2bDGvgcGJijAtSSa2k_FWjnZXm2jRiFd6Z9-XjEQ-Y68DQ@mail.gmail.com>
	<aUF4fsWwD9BswkFh@kernel.org>
	<CA+CK2bB2mn5b0N9gs1UavYLUQhbpVvdo702oHZa15E9OaZkKWg@mail.gmail.com>
	<CA+CK2bDLkf=5Mk0XH2XvUFS1px4cROBRjO+eKd4zvgzrS=Z-xA@mail.gmail.com>
Date: Sat, 20 Dec 2025 11:27:29 +0900
Message-ID: <865xa1khv2.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251219_182739_231855_360416BA 
X-CRM114-Status: GOOD (  26.97  )
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

On Tue, Dec 16 2025, Pasha Tatashin wrote:

> On Tue, Dec 16, 2025 at 10:36=E2=80=AFAM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
>>
>> On Tue, Dec 16, 2025 at 10:19=E2=80=AFAM Mike Rapoport <rppt@kernel.org>=
 wrote:
>> >
>> > On Tue, Dec 16, 2025 at 10:05:27AM -0500, Pasha Tatashin wrote:
>> > > > > +static struct page *__init kho_get_preserved_page(phys_addr_t p=
hys,
>> > > > > +                                               unsigned int ord=
er)
>> > > > > +{
>> > > > > +     unsigned long pfn =3D PHYS_PFN(phys);
>> > > > > +     int nid =3D early_pfn_to_nid(pfn);
>> > > > > +
>> > > > > +     for (int i =3D 0; i < (1 << order); i++)
>> > > > > +             init_deferred_page(pfn + i, nid);
>> > > >
>> > > > This will skip pages below node->first_deferred_pfn, we need to use
>> > > > __init_page_from_nid() here.
>> > >
>> > > Mike, but those struct pages should be initialized early anyway. If
>> > > they are not yet initialized we have a problem, as they are going to
>> > > be re-initialized later.
>> >
>> > Can say I understand your point. Which pages should be initialized ear=
lt?
>>
>> All pages below node->first_deferred_pfn.
>>
>> > And which pages will be reinitialized?
>>
>> kho_memory_init() is called after free_area_init() (which calls
>> memmap_init_range to initialize low memory struct pages). So, if we
>> use __init_page_from_nid() as suggested, we would be blindly running
>> __init_single_page() again on those low-memory pages that
>> memmap_init_range() already set up. This would cause double
>> initialization and corruptions due to losing the order information.
>>
>> > > > > +
>> > > > > +     return pfn_to_page(pfn);
>> > > > > +}
>> > > > > +
>> > > > >  static void __init deserialize_bitmap(unsigned int order,
>> > > > >                                     struct khoser_mem_bitmap_ptr=
 *elm)
>> > > > >  {
>> > > > > @@ -449,7 +466,7 @@ static void __init deserialize_bitmap(unsign=
ed int order,
>> > > > >               int sz =3D 1 << (order + PAGE_SHIFT);
>> > > > >               phys_addr_t phys =3D
>> > > > >                       elm->phys_start + (bit << (order + PAGE_SH=
IFT));
>> > > > > -             struct page *page =3D phys_to_page(phys);
>> > > > > +             struct page *page =3D kho_get_preserved_page(phys,=
 order);
>> > > >
>> > > > I think it's better to initialize deferred struct pages later in
>> > > > kho_restore_page. deserialize_bitmap() runs before SMP and it alre=
ady does
>> > >
>> > > The KHO memory should still be accessible early in boot, right?
>> >
>> > The memory is accessible. And we anyway should not use struct page for
>> > preserved memory before kho_restore_{folio,pages}.
>>
>> This makes sense, what happens if someone calls kho_restore_folio()
>> before deferred pages are initialized?
>
> I looked at your repo. I think what you're proposing makes sense, and
> indeed it will provide a performance boost if some of the folios are
> restored in parallel. Just kho_init_deferred_pages() should be using
> init_deferred_page() to avoid re-initializing the lower memory pages.
> Also, I am still wondering how it will work with HVO, but I need to
> take a look at Pratyuh's series for that.

The HVO optimization happens when the file is retrieved, after all the
folios are restored. So that is long after deferred page init. For my
series both approaches should work.

--=20
Regards,
Pratyush Yadav

