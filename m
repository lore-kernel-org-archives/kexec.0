Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 324F1EE4983
	for <kexec@archiver.kernel.org>; Tue, 30 Dec 2025 16:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MG9ep1clevva76W2JMLv7DULyp0iwWN39Gin1y59CsU=; b=mZA2/X4tw7tY3tAEP9lMgo+L8/
	Bh6saqpTNY+xziXNkte00cREvvUxPFWFCMV8AvMFaAqc2I/qglElhcCNPrcYwBvzdlW9lmS5gEHIA
	GfLqPozQym5zeiygL4GbLj2dury8XoMJ9AI8CkleISRzO1bZdSmYxcZlLBYH4L3EOftknsvG0QZ/B
	rR68hILR2R4HR9K2yPTErt8oNoNork6pPBMslEyNbFpQqKg8ZCcEOhaGdaJyD13+x6+kAVmLoper2
	tMiB/YHzABTnbexf9H5CoN0u8qTRP4wP5PE/O+uUHGNZmdB/2JQNfTuyGslip3rz0/1Qtq1+6letW
	yVAP9afQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vacEG-000000052Fe-3Iem;
	Tue, 30 Dec 2025 16:05:48 +0000
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vacEE-000000052FC-0hqI
	for kexec@lists.infradead.org;
	Tue, 30 Dec 2025 16:05:47 +0000
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-b7355f6ef12so1945340966b.3
        for <kexec@lists.infradead.org>; Tue, 30 Dec 2025 08:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1767110744; x=1767715544; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MG9ep1clevva76W2JMLv7DULyp0iwWN39Gin1y59CsU=;
        b=hG2OqAU8+BMT/WxQzjSYiySDi+g0XP1AP0RYrOgrfyS6kquP6ZVrHJyQ4KfneSxyKg
         fwAVpLoUbiGA1MyJD26dpbAdCknXVMncloxMnVo/tD+72L28ULOmPoXGfJOZ41PtcEIA
         mPMurxnVVsRrRPgLEQprLPNBhWAlKuAtQqbBs+Bl+i8nlJCm7iqWmBpW1HDr7P6KFfdn
         tRl6kU6uZT6UhI6VYzbTpDjzRbNaMMMjBJFFf9FI9aM15oYpkxZb4AZ1aFYtDR+9kusi
         d4+Emmy5syBmuYmIMTKRt31o9+r4H/irADGhHN74v3g8u2IPoM28iK9dnCy6I8USc1+l
         QyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767110744; x=1767715544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MG9ep1clevva76W2JMLv7DULyp0iwWN39Gin1y59CsU=;
        b=W2UxsO5l5Ac2kLq+vwLH3KVivxlbEwyZC3xKNdCQyxzaBgqx6gBeqvUjjye/42kmmm
         70ljQro/wNs0c5+4tqRMGUNYMQmCybzLR7CDBGwa3OPfCgLOy4Ch/XxkKp10aR/M2nxv
         hW2ORUYVw/v40+6xuo10Q3DyUO0zI8a0o9WnR9vzewAi3xKqkcR1BvAF6KfI9NZXGjTu
         pSISIaLrCoKSMWDte9lxylPgPJEHjPv+kBv4fymjWZ0Ix4bMh+LT2yIaznQUDZ6hu8VB
         r0CVtUkurrizVIuBlcyYmjWbl5cHRBAH6Zc2o37H3MU/3B5nMwvv3w3lhXNKtGCkKbOg
         jAzw==
X-Forwarded-Encrypted: i=1; AJvYcCVdumoVN0nZpaYezg6C2IRZNhAcxP+2wA3tMM8MGq8wBnBYNUpLL8B7WZ6IIujqG3cIM1z9zw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxnWZXUsSBAbVFxnitAcETo/0hnAKHlcBnIdVDNN6vs+XMcrniO
	f7SoPncV3v+gGBn9fzIdg1gjeq6El/UNhDiwsjTycYomxS494ipmR5L7W/NW/8a61go2S4a2+Uz
	b3rcEXHlyZYWNtbFys4Y9mE54hrj27cuzdI6xI9jf5w==
X-Gm-Gg: AY/fxX4lHJrqmr/CNDOmYbKfAO1MXdYgiZm1RPklhK1+nAu/dgujnmyJm06otOz27h0
	/0nSs5G9/9fK2EYMqe/H1EV91huN321WAkGKN6maFDt8PeXVPQgPuhhCOM7YyU9muz7nt90Iq05
	wtfGlMGurq1wAxeQhnx03261NWuo4rgrCsZJM2ZEmR6DelKlbS/iStB3heLAtFq/CnUMu0c3RAy
	ssUxbjfgP/eehEgEGMCyomcIUQ7pGUjywlbiCiveb4jAhjNZ60ePtu0UroiERpuNdIP2FbH+ulo
	GiFU3SgzaOlK2RuCvcb2hOkwQQ==
X-Google-Smtp-Source: AGHT+IEk6loJ8MioiHKAz7Z1lAv4Moi1oxuZ50QtEDcPJb50FtdSjNb551AAnS3pgJz8xEVU4lrLrK22GP7GJzibBQA=
X-Received: by 2002:a17:906:eecb:b0:b72:588:2976 with SMTP id
 a640c23a62f3a-b803720eb72mr3632708366b.60.1767110743871; Tue, 30 Dec 2025
 08:05:43 -0800 (PST)
MIME-Version: 1.0
References: <20251216084913.86342-1-epetron@amazon.de> <aUFJH9xzJXYOt_X8@kernel.org>
 <CA+CK2bDGvgcGJijAtSSa2k_FWjnZXm2jRiFd6Z9-XjEQ-Y68DQ@mail.gmail.com>
 <aUF4fsWwD9BswkFh@kernel.org> <CA+CK2bB2mn5b0N9gs1UavYLUQhbpVvdo702oHZa15E9OaZkKWg@mail.gmail.com>
 <aUUYprAotKYMiEs0@kernel.org> <CA+CK2bD101cSC_7+OWkMei2QvUVjSaRLy+LboLe8Sz7KS3by4g@mail.gmail.com>
 <861pkpkffh.fsf@kernel.org> <CA+CK2bA1kYCf0BwhX3Sg9Ur82nK-7HPzs0sg6xbVWFAJaZLhpw@mail.gmail.com>
 <86jyyecyzh.fsf@kernel.org> <CA+CK2bDxnTEe9Ohq5zLuyF-jqgD0DPhfdq6z=yztUsXU5p5fSQ@mail.gmail.com>
 <863452cwns.fsf@kernel.org> <CA+CK2bCjJWZG_rPoPsHWSxirmUCTOuFQzTCss2AKf9UqpThrdw@mail.gmail.com>
 <864ip99f1a.fsf@kernel.org>
In-Reply-To: <864ip99f1a.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 30 Dec 2025 11:05:05 -0500
X-Gm-Features: AQt7F2qh8Tz1-V6SEVQcAtjpTVrAQuZA4_pz9Pf3y-k5HVASt8V4EiUMlmt1L-Y
Message-ID: <CA+CK2bDDEZ5a+LJNDVMtKFtQ1D9rP6rJqU064eoru=a9eHpaAQ@mail.gmail.com>
Subject: Re: [PATCH] kho: add support for deferred struct page init
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, Evangelos Petrongonas <epetron@amazon.de>, Alexander Graf <graf@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jason Miu <jasonmiu@google.com>, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org, 
	nh-open-source@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251230_080546_250045_0C6E33D1 
X-CRM114-Status: GOOD (  57.74  )
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

On Mon, Dec 29, 2025 at 4:03=E2=80=AFPM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> On Tue, Dec 23 2025, Pasha Tatashin wrote:
>
> >> > if (WARN_ON_ONCE(info.magic !=3D KHO_PAGE_MAGIC || info.order > MAX_=
PAGE_ORDER))
> >> > return NULL;
> >>
> >> See my patch that drops this restriction:
> >> https://lore.kernel.org/linux-mm/20251206230222.853493-2-pratyush@kern=
el.org/
> >>
> >> I think it was wrong to add it in the first place.
> >
> > Agree, the restriction can be removed. Indeed, it is wrong as it is
> > not enforced during preservation.
> >
> > However, I think we are going to be in a world of pain if we allow
> > preserving memory from different topologies within the same order. In
> > kho_preserve_pages(), we have to check if the first and last page are
> > from the same nid; if not, reduce the order by 1 and repeat until they
> > are. It is just wrong to intermix different memory into the same
> > order, so in addition to removing that restriction, I think we should
> > implement this enforcement.
>
> Sure, makes sense.
>
> >
> > Also, perhaps we should pass the NID in the Jason's radix tree
> > together with the order. We could have a single tree that encodes both
> > order and NID information in the top level, or we can have one tree
> > per NID. It does not really matter to me, but that should help us with
> > faster struct page initialization.
>
> Can we use NIDs in ABI? Do they stay stable across reboots? I never
> looked at how NIDs actually get assigned.
>
> Not sure if we should target it for the initial merge of the radix tree,
> but I think this is something we can try to figure out later down the
> line.
>
> >
> >> >> To get the nid, you would need to call early_pfn_to_nid(). This tak=
es a
> >> >> spinlock and searches through all memblock memory regions. I don't =
think
> >> >> it is too expensive, but it isn't free either. And all this would b=
e
> >> >> done serially. With the zone search, you at least have some room fo=
r
> >> >> concurrency.
> >> >>
> >> >> I think either approach only makes a difference when we have a larg=
e
> >> >> number of low-order preservations. If we have a handful of high-ord=
er
> >> >> preservations, I suppose the overhead of nid search would be neglig=
ible.
> >> >
> >> > We should be targeting a situation where the vast majority of the
> >> > preserved memory is HugeTLB, but I am still worried about lower orde=
r
> >> > preservation efficiency for IOMMU page tables, etc.
> >>
> >> Yep. Plus we might get VMMs stashing some of their state in a memfd to=
o.
> >
> > Yes, that is true, but hopefully those are tiny compared to everything =
else.
> >
> >> >> Long term, I think we should hook this into page_alloc_init_late() =
so
> >> >> that all the KHO pages also get initalized along with all the other
> >> >> pages. This will result in better integration of KHO with rest of M=
M
> >> >> init, and also have more consistent page restore performance.
> >> >
> >> > But we keep KHO as reserved memory, and hooking it up into
> >> > page_alloc_init_late() would make it very different, since that memo=
ry
> >> > is part of the buddy allocator memory...
> >>
> >> The idea I have is to have a separate call in page_alloc_init_late()
> >> that initalizes KHO pages. It would traverse the radix tree (probably =
in
> >> parallel by distributing the address space across multiple threads?) a=
nd
> >> initialize all the pages. Then kho_restore_page() would only have to
> >> double-check the magic and it can directly return the page.
> >
> > I kind of do not like relying on magic to decide whether to initialize
> > the struct page. I would prefer to avoid this magic marker altogether:
> > i.e. struct page is either initialized or not, not halfway
> > initialized, etc.
>
> The magic is purely sanity checking. It is not used to decide anything
> other than to make sure this is actually a KHO page. I don't intend to
> change that. My point is, if we make sure the KHO pages are properly
> initialized during MM init, then restoring can actually be a very cheap
> operation, where you only do the sanity checking. You can even put the
> magic check behind CONFIG_KEXEC_HANDOVER_DEBUG if you want, but I think
> it is useful enough to keep in production systems too.

It is part of a critical hotpath during blackout, should really be
behind CONFIG_KEXEC_HANDOVER_DEBUG

> > Magic is not reliable. During machine reset in many firmware
> > implementations, and in every kexec reboot, memory is not zeroed. The
> > kernel usually allocates vmemmap using exactly the same pages, so
> > there is just too high a chance of getting magic values accidentally
> > inherited from the previous boot.
>
> I don't think that can happen. All the pages are zeroed when
> initialized, which will clear the magic. We should only be setting the
> magic on an initialized struct page.

This can happen due to bugs when we use a partially initialized
"struct page", something that Mike have been looking to do. So, pass
some information in a struct page before it is fully initialized.

> >> Radix tree makes parallelism easier than the linked lists we have now.
> >
> > Agree, radix tree can absolutely help with parallelism.
> >
> >> >> Jason's radix tree patches will make that a bit easier to do I thin=
k.
> >> >> The zone search will scale better I reckon.
> >> >
> >> > It could, perhaps early in boot we should reserve the radix tree, an=
d
> >> > use it as a source of truth look-ups later in boot?
> >>
> >> Yep. I think the radix tree should mark its own pages as preserved too
> >> so they stick around later in boot.
> >
> > Unfortunately, this can only be done in the new kernel, not in the old
> > kernel; otherwise we can end up with a recursive dependency that may
> > never be satisfied.
>
> Right. It shouldn't be too hard to do in the new kernel though. We will
> walk the whole tree anyway.
>
> --
> Regards,
> Pratyush Yadav

