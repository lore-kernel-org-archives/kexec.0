Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1ADAE668B4
	for <kexec@archiver.kernel.org>; Sat, 20 Dec 2025 14:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Goy8IvAF5EH1SjhL5f9/XSFbPZ8S1XtNVpjt6+v7B50=; b=lAuhQBaA/9Y3g9bWoEIHuP3qbO
	tqn3F7503uAaKiJf5PlGa+fFHVxC4Mm+09vfyu/i2lWz8UhMvRaqWcQadXV/3+H7mdqFqst4KgX0Y
	m358SdigWfY4lVz5AkJcSqovCsf1namq1AZvkdYerboLzGIdPSi2E2Trpp2l1KAGH9mZ+bEbPuj4x
	gOnKsKcav7znADddNshQCKN0K4QYHyU5mdGaI4OWf8AbE4j0YiXQ57DR02Zh/G/tcuyPP73HoM4ed
	Z0fOoNwv3wQhmpgQcMNV3HiJZRZvkN5HiuI/h9MUuh5zp9HYRvi7lYjuEPczkJMK5ry3iUOFLIMdE
	HAMbgCqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWyHt-0000000BfMU-3wVr;
	Sat, 20 Dec 2025 14:50:29 +0000
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWyHp-0000000BfLf-0Ybm
	for kexec@lists.infradead.org;
	Sat, 20 Dec 2025 14:50:28 +0000
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-6418b55f86dso3572371a12.1
        for <kexec@lists.infradead.org>; Sat, 20 Dec 2025 06:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1766242221; x=1766847021; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Goy8IvAF5EH1SjhL5f9/XSFbPZ8S1XtNVpjt6+v7B50=;
        b=avHPUxBLOFVS4jTBIEX6ZCCC4Eq9SYYkGtqHwE+p3UDNDlNwy9Nn10DTMXBD0MglfB
         xXu/WdU5T3mPlCS3OBmeY1mI3aql86YHOtsODm13uOM29V7cBX/FDE3ct3CIP5Wh60By
         XBl9SiSNs5Ea99yXtTAp279c9oB0ULRchDYAXJJaH26oERPfDf83hrD74cA3eCtiycZA
         ggy7JsbQDOiZ6FsI0loGJvJN15baI08hSm2f/Du98mfHDZZ5ec4qFudSXxNPJUcHe1fd
         qwWr6QvyKDfOjYt5FS4JPNuyZBGgIDqG7QvS+52Nwtd7aq7t3e0n05QU/tmbhAFNUmk/
         GnMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766242221; x=1766847021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Goy8IvAF5EH1SjhL5f9/XSFbPZ8S1XtNVpjt6+v7B50=;
        b=Oenhhac5dgGxGkqAWELSGtTLMLUZcYE3elqiKLXX0YCKIEZoE6WY4CacSuI0nnPVAV
         NVOOKR2ETWHjnW4atJpADYUkpUWnmnxZCUxzCS2y4AzlZXYfj09n93yjEAUYvemd7weJ
         Wsa0aTgZU3OMjxhzxt9Vt8g3J7tqbZNkLpx0f0DdR/lezqYWT0Di7B7CwWQEuDOgDA1F
         PKXp04najYPgIRx/u/879wiBgT/3XVvhFFn+akTbrNnofLYV+aXNR7MJkjLdaCLXbaCd
         xgaw9VKjJOthDBIBsAIpOUFTtZv1kGxiObA+iIlKeuSr2BY6KLykHbwPu+9rai7Ej3bD
         eo5A==
X-Forwarded-Encrypted: i=1; AJvYcCWMD7C0UloNaLtADKWXyJZdm7W9Q6njste/5bptqG279sKpvMxHzvlqpeB871q/bZdzumle1w==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy/M8+bmlvDyZue15SfeRQMk+z1ittHrtHAK7sXYeNT+kVIL3k3
	aigsSaBZAFmK5L/m/855LwIZy0xXxQncOtp75FT0LjZXCFliH8QifulV9MF+fG94NFUwDXr7L+d
	H0skXU3tccTXg9iCQWOlorRnH5cQKHvP0RLMCPjzG1g==
X-Gm-Gg: AY/fxX6Ea3ypuOavSCllxC1dowFPJrS2Cbu0ka+G6oONt62wwfAeAmyaR8W3anHGnzd
	YfkTJJiOr+mirFl25mTAsH507Fo/RpWjRGqQe+5xAs5EgiEqO/nX+4GN6u3lZZH5ojaw9kPHNWE
	PnojlVA8wBG3DATQEvFsuoMX5sidFc9/ufq/AQeShBpMBCGDjqaxiuhYfR63sJ1NMCma1pLlwMt
	tf9qYzgh7DnozbAyodm1C+2b9bJ4f4F4H9l26JyVrACzwuapJIUAT9tnxVH4Ke6UmxGtkWHZsv1
	OpOX+rBnNQSnBDGuUuv2buExYDHMTrMPmsJrz2hkbvgXwSy9TfCntVVibdbN3A==
X-Google-Smtp-Source: AGHT+IHIVqx9ytn5gAi5USUsY1jHhg2U2WSPQJtGGGCkUnwGVGj9YPZ5VMAqtf8TXFny2QtHU4UHSdIoz7ul+hi7Q0g=
X-Received: by 2002:a17:906:794e:b0:b5b:2c82:7dc6 with SMTP id
 a640c23a62f3a-b80371a71c3mr658870566b.40.1766242221134; Sat, 20 Dec 2025
 06:50:21 -0800 (PST)
MIME-Version: 1.0
References: <20251216084913.86342-1-epetron@amazon.de> <aUFJH9xzJXYOt_X8@kernel.org>
 <CA+CK2bDGvgcGJijAtSSa2k_FWjnZXm2jRiFd6Z9-XjEQ-Y68DQ@mail.gmail.com>
 <aUF4fsWwD9BswkFh@kernel.org> <CA+CK2bB2mn5b0N9gs1UavYLUQhbpVvdo702oHZa15E9OaZkKWg@mail.gmail.com>
 <aUUYprAotKYMiEs0@kernel.org> <CA+CK2bD101cSC_7+OWkMei2QvUVjSaRLy+LboLe8Sz7KS3by4g@mail.gmail.com>
 <861pkpkffh.fsf@kernel.org>
In-Reply-To: <861pkpkffh.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 20 Dec 2025 09:49:44 -0500
X-Gm-Features: AQt7F2pK4XT9_pgkJJh3fHmDqAK72t11dkqY99si46dJ87InO_jQlAkNaSjE-J0
Message-ID: <CA+CK2bA1kYCf0BwhX3Sg9Ur82nK-7HPzs0sg6xbVWFAJaZLhpw@mail.gmail.com>
Subject: Re: [PATCH] kho: add support for deferred struct page init
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, Evangelos Petrongonas <epetron@amazon.de>, Alexander Graf <graf@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jason Miu <jasonmiu@google.com>, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org, 
	nh-open-source@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251220_065025_247671_EFF0D568 
X-CRM114-Status: GOOD (  58.90  )
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

On Fri, Dec 19, 2025 at 10:20=E2=80=AFPM Pratyush Yadav <pratyush@kernel.or=
g> wrote:
>
> On Fri, Dec 19 2025, Pasha Tatashin wrote:
>
> > On Fri, Dec 19, 2025 at 4:19=E2=80=AFAM Mike Rapoport <rppt@kernel.org>=
 wrote:
> >>
> >> On Tue, Dec 16, 2025 at 10:36:01AM -0500, Pasha Tatashin wrote:
> >> > On Tue, Dec 16, 2025 at 10:19=E2=80=AFAM Mike Rapoport <rppt@kernel.=
org> wrote:
> >> > >
> >> > > On Tue, Dec 16, 2025 at 10:05:27AM -0500, Pasha Tatashin wrote:
> >> > > > > > +static struct page *__init kho_get_preserved_page(phys_addr=
_t phys,
> >> > > > > > +                                               unsigned int=
 order)
> >> > > > > > +{
> >> > > > > > +     unsigned long pfn =3D PHYS_PFN(phys);
> >> > > > > > +     int nid =3D early_pfn_to_nid(pfn);
> >> > > > > > +
> >> > > > > > +     for (int i =3D 0; i < (1 << order); i++)
> >> > > > > > +             init_deferred_page(pfn + i, nid);
> >> > > > >
> >> > > > > This will skip pages below node->first_deferred_pfn, we need t=
o use
> >> > > > > __init_page_from_nid() here.
> >> > > >
> >> > > > Mike, but those struct pages should be initialized early anyway.=
 If
> >> > > > they are not yet initialized we have a problem, as they are goin=
g to
> >> > > > be re-initialized later.
> >> > >
> >> > > Can say I understand your point. Which pages should be initialized=
 earlt?
> >> >
> >> > All pages below node->first_deferred_pfn.
> >> >
> >> > > And which pages will be reinitialized?
> >> >
> >> > kho_memory_init() is called after free_area_init() (which calls
> >> > memmap_init_range to initialize low memory struct pages). So, if we
> >> > use __init_page_from_nid() as suggested, we would be blindly running
> >> > __init_single_page() again on those low-memory pages that
> >> > memmap_init_range() already set up. This would cause double
> >> > initialization and corruptions due to losing the order information.
> >> >
> >> > > > > > +
> >> > > > > > +     return pfn_to_page(pfn);
> >> > > > > > +}
> >> > > > > > +
> >> > > > > >  static void __init deserialize_bitmap(unsigned int order,
> >> > > > > >                                     struct khoser_mem_bitmap=
_ptr *elm)
> >> > > > > >  {
> >> > > > > > @@ -449,7 +466,7 @@ static void __init deserialize_bitmap(un=
signed int order,
> >> > > > > >               int sz =3D 1 << (order + PAGE_SHIFT);
> >> > > > > >               phys_addr_t phys =3D
> >> > > > > >                       elm->phys_start + (bit << (order + PAG=
E_SHIFT));
> >> > > > > > -             struct page *page =3D phys_to_page(phys);
> >> > > > > > +             struct page *page =3D kho_get_preserved_page(p=
hys, order);
> >> > > > >
> >> > > > > I think it's better to initialize deferred struct pages later =
in
> >> > > > > kho_restore_page. deserialize_bitmap() runs before SMP and it =
already does
> >> > > >
> >> > > > The KHO memory should still be accessible early in boot, right?
> >> > >
> >> > > The memory is accessible. And we anyway should not use struct page=
 for
> >> > > preserved memory before kho_restore_{folio,pages}.
> >> >
> >> > This makes sense, what happens if someone calls kho_restore_folio()
> >> > before deferred pages are initialized?
> >>
> >> That's fine, because this memory is still memblock_reserve()ed and def=
erred
> >> init skips reserved ranges.
> >> There is a problem however with the calls to kho_restore_{pages,folio}=
()
> >> after memblock is gone because we can't use early_pfn_to_nid() then.
>
> I suppose we can select CONFIG_ARCH_KEEP_MEMBLOCK with
> CONFIG_KEXEC_HANDOVER. But that comes with its own set of problems like
> wasting memory, especially when there are a lot of scattered preserved
> pages
>
> I don't think this is a very good idea, just throwing it out there as an
> option.
>
> >
> > I agree with the regarding memblock and early_pfn_to_nid(), but I
> > don't think we need to rely on early_pfn_to_nid() during the restore
> > phase.
> >
> >> I think we can start with Evangelos' approach that initializes struct =
pages
> >> at deserialize time and then we'll see how to optimize it.
> >
> > Let's do the lazy tail initialization that I proposed to you in a
> > chat: we initialize only the head struct page during
> > deserialize_bitmap(). Since this happens while memblock is still
> > active, we can safely use early_pfn_to_nid() to set the nid in the
> > head page's flags, and also preserve order as we do today.
> >
> > Then, we can defer the initialization of all tail pages to
> > kho_restore_folio(). At that stage, we no longer need memblock or
> > early_pfn_to_nid(); we can simply inherit the nid from the head page
> > using page_to_nid(head).
>
> Does that assumption always hold? Does every contiguous chunk of memory
> always have to be in the same node? For folios it would hold, but what
> about kho_preserve_pages()?

NUMA node boundaries are SECTION_SIZE aligned. Since SECTION_SIZE is
larger than MAX_PAGE_ORDER it is mathematically impossible for a
single chunk to span multiple nodes.

> > This approach seems to give us the best of both worlds: It avoids the
> > memblock dependency during restoration. It keeps the serial work in
> > deserialize_bitmap() to a minimum (O(1)O(1) per region). It allows the
> > heavy lifting of tail page initialization to be done later in the boot
> > process, potentially in parallel, as you suggested.
>
> Here's another idea I have been thinking about, but never dug deep
> enough to figure out if it actually works.
>
> __init_page_from_nid() loops through all the zones for the node to find
> the zone id for the page. We can flip it the other way round and loop
> through all zones (on all nodes) to find out if the PFN spans that zone.
> Once we find the zone, we can directly call __init_single_page() on it.
> If a contiguous chunk of preserved memory lands in one zone, we can
> batch the init to save some time.
>
> Something like the below (completely untested):
>
>
>         static void kho_init_page(struct page *page)
>         {
>                 unsigned long pfn =3D page_to_pfn(page);
>                 struct zone *zone;
>
>                 for_each_zone(zone) {
>                         if (zone_spans_pfn(zone, pfn))
>                                 break;
>                 }
>
>                 __init_single_page(page, pfn, zone_idx(zone), zone_to_nid=
(zone));
>         }
>
> It doesn't do the batching I mentioned, but I think it at least gets the
> point across. And I think even this simple version would be a good first
> step.
>
> This lets us initialize the page from kho_restore_folio() without having
> to rely of memblock being alive, and saves us from doing work during
> early boot. We should only have a handful of zones and nodes in
> practice, so I think it should perform fairly well too.
>
> We would of course need to see how it performs in practice. If it works,
> I think it would be cleaner and simpler than splitting the
> initialization into two separate parts.

I think your idea is clever and would work. However, consider the
cache efficiency: in deserialize_bitmap(), we must write to the head
struct page anyway to preserve the order. Since we are already
bringing that 64-byte cacheline in and dirtying it, and since memblock
is available and fast at this stage, it makes sense to fully
initialize the head page right then.
If we do that, we get the nid for "free" (cache-wise) and we avoid the
overhead of iterating zones during the restore phase. We can then
simply inherit the nid from the head page when initializing the tail
pages later.

Pasha

