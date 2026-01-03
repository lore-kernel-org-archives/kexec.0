Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096D0FC6171
	for <kexec@archiver.kernel.org>; Sat,  3 Jan 2026 05:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lZgtRUf8QSMBPWBbIO9SBlR1yZTUnPXvstMpo+N3AXk=; b=adoH6z8+TjhnHeyq7GiO8mwBxl
	rH5xVsuGs76hvFJTWF+ryHvKt4L5bcbflwXqWOo1g+IS9/WnM/VNcuwaM+nIpBGuycLlsicpeP2p/
	jiwiRSVS+/AaEiGgHi9efrJeFVolh+ka5pJzmtWFf4fPO42aUf/5zFrkTy3/HqKEjL9H59Yw805OL
	576n1+ruBMWvh6fmP+gIc1jaLW78kbWLbsqW7m6Zkgb0YtjDHAe2Ha0i2vjArZCISOsktCjDiS5ZU
	6iRsus49kX7ha7Q3x9hDs5++36BkQlcJbVHB8rs0J53Mp/LXAzdwgp/lkJD9+3F7yiu3J5EUNqlZv
	J/1ZGd5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vbu7A-00000008zg3-37qm;
	Sat, 03 Jan 2026 05:23:48 +0000
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vbu75-00000008zfb-4AsO
	for kexec@lists.infradead.org;
	Sat, 03 Jan 2026 05:23:46 +0000
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-42e2ba54a6fso5381684f8f.3
        for <kexec@lists.infradead.org>; Fri, 02 Jan 2026 21:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767417821; x=1768022621; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZgtRUf8QSMBPWBbIO9SBlR1yZTUnPXvstMpo+N3AXk=;
        b=dJBDks0jUjRKr0xXCzxQA/rWh0kj/sjB28g596avtFd5QQFSOvs7rgMkjwIpuAm+ap
         aTdqiXWg5Hn49q/jFRSHZmma4Z9MNvC2ibYPhwprnwOc2FnOMLd/9B2S2ogoio9T4gmR
         a+Il1h6EI1Pz+xklyT2biA0Vkldh56c0phEvlOGUrxUe3UqoXx3M7YGuq0Y8HhuqttTu
         kE0uSBagXmc3C42XSHUgnNl8pvoyY+5SPdWdn47uHRi2w6iSdrb7vn8ycmL0r0muHfvX
         q2b2W3uSXulKxTCLglywu1z4P/1M8LAYXUERkkVGxwLbKepCZ3+s6knEAwNXZ29W5e8c
         nx+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767417821; x=1768022621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lZgtRUf8QSMBPWBbIO9SBlR1yZTUnPXvstMpo+N3AXk=;
        b=avKly7iYAr+/SF1Y23MO92PvrH9KUF7LWgMCpJ+aA8avk8VXclcZ5oSWaeh2uA6UrW
         PBMOKRmRX5Jyv/jzL3iJRszrY+ZqYJi9GoLv9gx/uOpKmZhalQGePUB6+wM9fRYbTtca
         +QzP94zZcJAVZL69z4lb4hujmzg/Dswf1LJB4LLlKAgC56aqdX0bBoEKcux7tujZyDtc
         zrJf+nZjEhthZETpNuE17xlL/ims0TRKcfwcUi+Lu4EA75H6EUaVsfdxi9e+jSDCDT0M
         yQontvLmKaBemGM2AUBTI6B+qV5B2g5eK2/mYgMSZYXam7Dgy4GHqrWRrxstkqZqwrld
         gDEg==
X-Forwarded-Encrypted: i=1; AJvYcCVG3Di27rOMPtU5ddQcrRF/PGDz08iCwYGNppCpjByMFf7y/eeere5qYbXq/Jipv4AMKmj0bQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwjlkppfKCkg9ZZL91wN4ccQgv8Z9FqSEZF3LAd8Z+Hcj4wtbeG
	qp2JznerKuJvO7vyqjMkb0igx6+KnVY7F3I6spujuhDNKnzABFC4oTiv359VKB/E3ZCrWtYJSMn
	IMDcuoFEB2SH+XuClyTpKeazsdh+fHfTG3HpCPW5v
X-Gm-Gg: AY/fxX7G9ioS7eXPyxSD+6qRAFkjMk9mVAo43QfNX1WMei5itCeHqKHvHv+gKNNIwV3
	rbTja2tk9ZkG4BRBdEezqseOqIBfAY+Oj1uf/MsFtxXE+I/yhegPYnpy9AflAUY26N2Y+QMqjrG
	qzD99c/RryKA2R4fFr+j2treqmw9iPI38cMJaFInZKEQ5TpcfZ29p7Iasu+1COL6IzdJDGwoZPc
	rxvRd+rYcohK7fqurc7YTdXdB4kEMRXFaDvdJ5SGBBZitFJGx4L7ig9Gj29NHI05jImCsVHVhSC
	QMmKdyp/DJ1qirCjTX0T
X-Google-Smtp-Source: AGHT+IE4mQWmRBvH97nv4gWQOk5C2ZKjea27wZ9QrkyWmMJAiSuXXrY0G4eg4AtkqH+3miTS2o2rpDJDFiIBbXk/GGM=
X-Received: by 2002:a05:6000:2c0e:b0:42b:3afa:5e1d with SMTP id
 ffacd0b85a97d-4324e4c9d89mr61654880f8f.20.1767417820911; Fri, 02 Jan 2026
 21:23:40 -0800 (PST)
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
From: Jason Miu <jasonmiu@google.com>
Date: Fri, 2 Jan 2026 21:23:28 -0800
X-Gm-Features: AQt7F2pBVwG4Pai_GRfwCF2pWs-iKdBHBTiPITQe_l8Bzkpho3IogZSBp0YD7ds
Message-ID: <CAHN2nPKH5BGrYFZihTWY4+HYXtnko+EVdq5VpT5R4Sk_VnPt-w@mail.gmail.com>
Subject: Re: [PATCH] kho: add support for deferred struct page init
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Evangelos Petrongonas <epetron@amazon.de>, Alexander Graf <graf@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-mm@kvack.org, nh-open-source@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260102_212344_100935_458DD5EE 
X-CRM114-Status: GOOD (  64.61  )
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

On Mon, Dec 29, 2025 at 1:03=E2=80=AFPM Pratyush Yadav <pratyush@kernel.org=
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

Yes I think this makes the life easier and simplifies NID retrieval,
as I mentioned below.

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

To encode the NID in to a single radix tree I think we can use the
prefix bits before the order bit. For a preserved order-0 page the
order bit is at 52 so we can use the bits 63-53 to encode the NID for
each order. But I tend to have one tree for NID, which makes the
process easier and more scalable. The cost will be 1 extra page
because of the array pointing to each radix tree.

When traversing the radix tree during early boot we must initialize
the head pages. We can have the page.private containing the order and
NID info, like:

```
union kho_page_info {
  unsigned long page_private;
  struct {
    u16_t nid;
    u16_t order;
    unsigned int magic;
  };
};
```

early_pfn_to_nid() should work here. If we ensure that pages in the
same order do not cross the zone boundary as Pasha mentioned above, we
can set the tail pages with the same NID later, when calling
kho_restore_page() after deferred struct page init.

With the `union kho_page_info`, this will be part of the ABI.

> Not sure if we should target it for the initial merge of the radix tree,
> but I think this is something we can try to figure out later down the
> line.
>

I suggest keeping the initial merge of the radix tree simpler,
ensuring it has the same feature set as the current implementation. We
can add the new deferred struct page support as a separate feature
later. =3D)

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
>

I think we should traverse the radix tree once during the early
boot-up to reserve pages in memblock. But if we can hook the radix
tree walking in page_alloc_init_late(), we can further defer the page
structs (including head and tail) here. Having one radix tree per NID
seems handy here if page_alloc_init_late() allocates one thread per
NID for parallelization.

> >
> > Magic is not reliable. During machine reset in many firmware
> > implementations, and in every kexec reboot, memory is not zeroed. The
> > kernel usually allocates vmemmap using exactly the same pages, so
> > there is just too high a chance of getting magic values accidentally
> > inherited from the previous boot.
>
> I don't think that can happen. All the pages are zeroed when
> initialized, which will clear the magic. We should only be setting the
> magic on an initialized struct page.
>
> >
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

Yes, we can preserve the pages used for radix tree nodes in the new
kernel. I think we should un-preserve them once LUO is done? Since KHO
can be used by other clients we can add APIs to preserve/unpreserve
the radix tree nodes.

--
Jason Miu

