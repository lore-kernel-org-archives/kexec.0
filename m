Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE9DE66886
	for <kexec@archiver.kernel.org>; Sat, 20 Dec 2025 03:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1SKx+S0FkyJgsVAeCS9CdFTq8gPlDnAtjpP2X9NjBVc=; b=Id1SskCdaxEKlygBBc4VWZRiiD
	MOADFtuU8KbeMBK08lPqmKk0WiFEGfJjGUr5j4WkBi1IwNffjJtZAUDVdNsNDYoNABGNrMzVCe27A
	3WjKgb/CQzYMfjbNzZqu6154H9P8w5yE1FE4i3XIFPRbzUdlHCRKqf4S/EJEY2boGphhirmRxDGmO
	xxlKPAvo2iz5VhyvxVHcDsfNDD4Gto7/25aiOLzgJE0npaKc9/FsZ6djo4jEX6mokFpXaPFb/lVYL
	MgQ+HyJkDVTRaIvsTNFTK1kzQhXU92P1O2eKEpi/UUB1C4ede2UMhL4AIt0d3JNkFq45wDF8IiT4a
	Je9xG7Ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWnVq-0000000BEoS-46ml;
	Sat, 20 Dec 2025 03:20:10 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWnVo-0000000BEnv-2Lgf
	for kexec@lists.infradead.org;
	Sat, 20 Dec 2025 03:20:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id BA77043B58;
	Sat, 20 Dec 2025 03:20:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9279CC4CEF1;
	Sat, 20 Dec 2025 03:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766200807;
	bh=PQoYiqwGtHkDFoeLJkBa9fjc7yrVcV49QT03Es5KPS8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=d3OaU/Odir3KCpAeDg2VtrL0s7Tv4VK4KjGhQzLhaCCeBuaKhbN4EK3PylJb1AVGt
	 otpqz1foWorLZpdgH2IeuBbJ0btf4gFfX7Hhn/GNTqPDA0kWpByy5CM2dvWC2Xmbqh
	 +FJUWBoL4DtkZT0Cut3hYTwiF/MegdUUg3j0HLswbeUt6zLVTLzbh7Kl1Sg5ilDPQu
	 MmfJRxuGDJ+asd2YsQn5erxv803SlEHiFcPy+0N/vof1w2zlJqORme2X0hu97df65c
	 Iial1U/dJo/crLdmQb6xJgc6c7DajZtP8Zv7MQ7+RyfxxTytYf0bA8mUPs1xwqPXGC
	 e9gOsckGcCkzg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Mike Rapoport <rppt@kernel.org>,  Evangelos Petrongonas
 <epetron@amazon.de>,  Pratyush Yadav <pratyush@kernel.org>,  Alexander
 Graf <graf@amazon.com>,  Andrew Morton <akpm@linux-foundation.org>,  Jason
 Miu <jasonmiu@google.com>,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  nh-open-source@amazon.com
Subject: Re: [PATCH] kho: add support for deferred struct page init
In-Reply-To: <CA+CK2bD101cSC_7+OWkMei2QvUVjSaRLy+LboLe8Sz7KS3by4g@mail.gmail.com>
	(Pasha Tatashin's message of "Fri, 19 Dec 2025 11:28:50 -0500")
References: <20251216084913.86342-1-epetron@amazon.de>
	<aUFJH9xzJXYOt_X8@kernel.org>
	<CA+CK2bDGvgcGJijAtSSa2k_FWjnZXm2jRiFd6Z9-XjEQ-Y68DQ@mail.gmail.com>
	<aUF4fsWwD9BswkFh@kernel.org>
	<CA+CK2bB2mn5b0N9gs1UavYLUQhbpVvdo702oHZa15E9OaZkKWg@mail.gmail.com>
	<aUUYprAotKYMiEs0@kernel.org>
	<CA+CK2bD101cSC_7+OWkMei2QvUVjSaRLy+LboLe8Sz7KS3by4g@mail.gmail.com>
Date: Sat, 20 Dec 2025 12:20:02 +0900
Message-ID: <861pkpkffh.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251219_192008_642747_31DD1C38 
X-CRM114-Status: GOOD (  46.96  )
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

On Fri, Dec 19 2025, Pasha Tatashin wrote:

> On Fri, Dec 19, 2025 at 4:19=E2=80=AFAM Mike Rapoport <rppt@kernel.org> w=
rote:
>>
>> On Tue, Dec 16, 2025 at 10:36:01AM -0500, Pasha Tatashin wrote:
>> > On Tue, Dec 16, 2025 at 10:19=E2=80=AFAM Mike Rapoport <rppt@kernel.or=
g> wrote:
>> > >
>> > > On Tue, Dec 16, 2025 at 10:05:27AM -0500, Pasha Tatashin wrote:
>> > > > > > +static struct page *__init kho_get_preserved_page(phys_addr_t=
 phys,
>> > > > > > +                                               unsigned int o=
rder)
>> > > > > > +{
>> > > > > > +     unsigned long pfn =3D PHYS_PFN(phys);
>> > > > > > +     int nid =3D early_pfn_to_nid(pfn);
>> > > > > > +
>> > > > > > +     for (int i =3D 0; i < (1 << order); i++)
>> > > > > > +             init_deferred_page(pfn + i, nid);
>> > > > >
>> > > > > This will skip pages below node->first_deferred_pfn, we need to =
use
>> > > > > __init_page_from_nid() here.
>> > > >
>> > > > Mike, but those struct pages should be initialized early anyway. If
>> > > > they are not yet initialized we have a problem, as they are going =
to
>> > > > be re-initialized later.
>> > >
>> > > Can say I understand your point. Which pages should be initialized e=
arlt?
>> >
>> > All pages below node->first_deferred_pfn.
>> >
>> > > And which pages will be reinitialized?
>> >
>> > kho_memory_init() is called after free_area_init() (which calls
>> > memmap_init_range to initialize low memory struct pages). So, if we
>> > use __init_page_from_nid() as suggested, we would be blindly running
>> > __init_single_page() again on those low-memory pages that
>> > memmap_init_range() already set up. This would cause double
>> > initialization and corruptions due to losing the order information.
>> >
>> > > > > > +
>> > > > > > +     return pfn_to_page(pfn);
>> > > > > > +}
>> > > > > > +
>> > > > > >  static void __init deserialize_bitmap(unsigned int order,
>> > > > > >                                     struct khoser_mem_bitmap_p=
tr *elm)
>> > > > > >  {
>> > > > > > @@ -449,7 +466,7 @@ static void __init deserialize_bitmap(unsi=
gned int order,
>> > > > > >               int sz =3D 1 << (order + PAGE_SHIFT);
>> > > > > >               phys_addr_t phys =3D
>> > > > > >                       elm->phys_start + (bit << (order + PAGE_=
SHIFT));
>> > > > > > -             struct page *page =3D phys_to_page(phys);
>> > > > > > +             struct page *page =3D kho_get_preserved_page(phy=
s, order);
>> > > > >
>> > > > > I think it's better to initialize deferred struct pages later in
>> > > > > kho_restore_page. deserialize_bitmap() runs before SMP and it al=
ready does
>> > > >
>> > > > The KHO memory should still be accessible early in boot, right?
>> > >
>> > > The memory is accessible. And we anyway should not use struct page f=
or
>> > > preserved memory before kho_restore_{folio,pages}.
>> >
>> > This makes sense, what happens if someone calls kho_restore_folio()
>> > before deferred pages are initialized?
>>
>> That's fine, because this memory is still memblock_reserve()ed and defer=
red
>> init skips reserved ranges.
>> There is a problem however with the calls to kho_restore_{pages,folio}()
>> after memblock is gone because we can't use early_pfn_to_nid() then.

I suppose we can select CONFIG_ARCH_KEEP_MEMBLOCK with
CONFIG_KEXEC_HANDOVER. But that comes with its own set of problems like
wasting memory, especially when there are a lot of scattered preserved
pages

I don't think this is a very good idea, just throwing it out there as an
option.

>
> I agree with the regarding memblock and early_pfn_to_nid(), but I
> don't think we need to rely on early_pfn_to_nid() during the restore
> phase.
>
>> I think we can start with Evangelos' approach that initializes struct pa=
ges
>> at deserialize time and then we'll see how to optimize it.
>
> Let's do the lazy tail initialization that I proposed to you in a
> chat: we initialize only the head struct page during
> deserialize_bitmap(). Since this happens while memblock is still
> active, we can safely use early_pfn_to_nid() to set the nid in the
> head page's flags, and also preserve order as we do today.
>
> Then, we can defer the initialization of all tail pages to
> kho_restore_folio(). At that stage, we no longer need memblock or
> early_pfn_to_nid(); we can simply inherit the nid from the head page
> using page_to_nid(head).

Does that assumption always hold? Does every contiguous chunk of memory
always have to be in the same node? For folios it would hold, but what
about kho_preserve_pages()?

>
> This approach seems to give us the best of both worlds: It avoids the
> memblock dependency during restoration. It keeps the serial work in
> deserialize_bitmap() to a minimum (O(1)O(1) per region). It allows the
> heavy lifting of tail page initialization to be done later in the boot
> process, potentially in parallel, as you suggested.

Here's another idea I have been thinking about, but never dug deep
enough to figure out if it actually works.

__init_page_from_nid() loops through all the zones for the node to find
the zone id for the page. We can flip it the other way round and loop
through all zones (on all nodes) to find out if the PFN spans that zone.
Once we find the zone, we can directly call __init_single_page() on it.
If a contiguous chunk of preserved memory lands in one zone, we can
batch the init to save some time.

Something like the below (completely untested):


	static void kho_init_page(struct page *page)
	{
		unsigned long pfn =3D page_to_pfn(page);
		struct zone *zone;
=09
		for_each_zone(zone) {
			if (zone_spans_pfn(zone, pfn))
				break;
		}
=09
		__init_single_page(page, pfn, zone_idx(zone), zone_to_nid(zone));
	}

It doesn't do the batching I mentioned, but I think it at least gets the
point across. And I think even this simple version would be a good first
step.

This lets us initialize the page from kho_restore_folio() without having
to rely of memblock being alive, and saves us from doing work during
early boot. We should only have a handful of zones and nodes in
practice, so I think it should perform fairly well too.

We would of course need to see how it performs in practice. If it works,
I think it would be cleaner and simpler than splitting the
initialization into two separate parts.

Evangelos, would you mind giving it a try to see if the idea works and
how well it performs?

--=20
Regards,
Pratyush Yadav

