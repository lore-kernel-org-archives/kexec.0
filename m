Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DDACCD1A5
	for <kexec@archiver.kernel.org>; Wed, 22 Oct 2025 00:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0xEV8oP7/LJpDk2U5jLeRfggXS9CoYgLq/Xr9trinnw=; b=DHmBAYf2oG8Oagcd8nUS7yXmah
	UHNGO7sYtM2+ZrqyaUfEJ7V68RIztFbm29//1LEXWOVTlOYV3imWqIepAjTe/HDAE1Z0FR1F7tKOh
	n2XPCdEmOtgDSiJSlGI/IhT4CoJKaFzwi1bfIao0JTBoiK/PHsYCwXMih+7ClN/d4Ub+dQ72+ESkz
	Ol61dIju4az/jCIVPmApAxK0a7dveF0CCszzmmoRtTUbV/j0d7xn0OqbsoCOOgHccPUezKbc4+vNR
	YD4nVT4OjUwvITGTh8ScnVYHr9Rnn0eYxPAGLP8VcaNa921pSLq9bsfqPakDXrTTBOzkD2iETDfV/
	vqSSGAhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBNCc-000000016dH-12eH;
	Wed, 22 Oct 2025 00:59:46 +0000
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBNCa-000000016ce-12rA
	for kexec@lists.infradead.org;
	Wed, 22 Oct 2025 00:59:45 +0000
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-47117f92e32so41202895e9.1
        for <kexec@lists.infradead.org>; Tue, 21 Oct 2025 17:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761094782; x=1761699582; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xEV8oP7/LJpDk2U5jLeRfggXS9CoYgLq/Xr9trinnw=;
        b=JWITx+4qyUV0g2ODeDl5O5xAxB7xE5sLvYqGnT44BF5+zfG10nHfQQsxSO7C7AKkyR
         Zi4GnEheTipKnbfQ9YWcgl+eNTfcXvfRnx+d1bft/Z300sVMXet0XCL7uBYK31FExu7f
         ESGDTq0zR18Utd/vHhw04Rgah+9IRZcXqNVyA+oS0pLY8zDLHnPEtJT2sU8DwNMjvSct
         DmxHRbfKWjzX7cirjPVs4e1I2HnegbrheVSJWawZ5wgHaN5vbHG+0GYmpdVR1g6hHd1/
         ++WFyjAsF5xWCjrViTMxjv2e5m41sWPiBhzMDFWjA6t/4DUQN40QEr9Uig1sQkr3jP1I
         YJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761094782; x=1761699582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xEV8oP7/LJpDk2U5jLeRfggXS9CoYgLq/Xr9trinnw=;
        b=nUj1b0EHwji0ZOdxAQWRdoZupAhdYBtSo/NjjLLzl13gRWjMWI06sY1wGU9wuH4DVK
         jBx9sl+KGDamd+DzWH4AhQDWMoGBx7UtvgfVxd6Lhku5hI5MQ1e1kBC3NnefQ2ZSWNfW
         UZv+eCnEf6AFUOKCmRTTQ6HLqrINpOYrOBdUVC3OQgwxMbpgFrv0C7g/YXxhMSoowYSO
         XBiJXevercMJDb2/rlSqUBqKCbE8r28mlgJBurzGnXMsZPVxAdIfYQAYVaOYwdVcQ77i
         jh6D2GuMku3/81KptrDzJuwGpTLhnArKvqj7vx5f/8GroaeXhOtQxUakZHnbNYrhURoI
         o+cg==
X-Forwarded-Encrypted: i=1; AJvYcCWllJk9DeK5K46jOpQtO3e+vyX5rvHBSs86m9jPDWIcT0YZwPELsHj3r1z5fAO4L/7nlHbILQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw2kq01AdaJcjwx+cDsJNscoOBKaNd4D7gPFmFtdiMnTl2lm928
	Qed9A3IKd4lXJUJP4hDwIdjoTBezooLeg3y+Zpo+P00eBaP1ZsvBDJ1GXKRsh1/VOaPHAJ4wSPA
	U9YlycedFzD8xv+P+8kfA4ciAfwFj4ul2ubAbxvSJ
X-Gm-Gg: ASbGncthe4CZ44hFFRzF8RgEWrTPwSN4o+QylpeMa0v5O4mgGwsyUzz9DiK0boPRDpl
	BVylMtABBeHdtMFiBrGd8mdq494GnZg+c3GY7odnaZDdN6m7F2wh//rysV891l7yA/ifwCcjMY2
	NHIxRCb64/j4FBypFhnXHDn6qOWMYks9fa+HjYHAGuYyteDjqJVLaNry3++CO5+BWHE+ri8dhXW
	KON9Ci5CaXcQ+I2QDUluzH5iNfdnumkUYkwLhQdDj93YTJBefb+UtlXniY=
X-Google-Smtp-Source: AGHT+IGx3Qzgr+9yTFCdhHfzYJR0ao2Q/u8VvpEx6LPIGJlsEQvV8faBYF79WSejez6shY/tdzi/USdR7Q8GO8tc8zg=
X-Received: by 2002:a05:600c:4507:b0:46e:376c:b1f0 with SMTP id
 5b1f17b1804b1-47117876744mr147970965e9.7.1761094781549; Tue, 21 Oct 2025
 17:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <20251001011941.1513050-1-jasonmiu@google.com> <20251001011941.1513050-2-jasonmiu@google.com>
 <20251006141444.GN3360665@nvidia.com> <CAHN2nPKjg6=0QTcSoptxvQW9MpP0YwGUTx_gQDBxgCtSzxY5Pg@mail.gmail.com>
 <20251009175205.GB3899236@nvidia.com>
In-Reply-To: <20251009175205.GB3899236@nvidia.com>
From: Jason Miu <jasonmiu@google.com>
Date: Tue, 21 Oct 2025 17:59:29 -0700
X-Gm-Features: AS18NWCV7ujd1_nk4jzUplOGzOVRDyy3XvJOMidHbQL4TGXpAjE_MJA9mRNpbHA
Message-ID: <CAHN2nPJbXeSzLuznWcV+vo80rtk5odd+2GDW_NVDUGPG1KO-Gg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] kho: Adopt KHO radix tree data structures
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251021_175944_337963_4A23FBDE 
X-CRM114-Status: GOOD (  48.32  )
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

Thanks Jason, I uploaded the patch v2 according to your feedback.

On Thu, Oct 9, 2025 at 10:52=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> > > > -#define PROP_PRESERVED_MEMORY_MAP "preserved-memory-map"
> > > > +#define PROP_PRESERVED_PAGE_RADIX_TREE "preserved-page-radix-tree"
> > > >  #define PROP_SUB_FDT "fdt"
> > >
> > > I'de really like to see all of these sorts of definitions in some
> > > structured ABI header not open coded all over the place..
> >
> > Do you think `include/linux/kexec_handover.h` is the appropriate
> > place, or would you prefer a new, dedicated ABI header (e.g., in
> > `include/uapi/linux/`) for all KHO-related FDT constants?
>
> I would avoid uapi, but maybe Pasha has some
> idea.
>
>  include/linux/live_update/abi/ ?

Yes, moved to include/linux/live_update/abi/.

>
> > Agreed. Will change `u64` according to Pasha's comment. And we use
> > explicit casts like `(u64)virt_to_phys(new_tree)` and `(struct
> > kho_radix_tree *)phys_to_virt(table_entry)` in the current series. I
> > believe this, along with the `u64` type, makes it clear that the table
> > stores physical addresses.
>
> Well, the macros were intended to automate this and avoid mistakes
> from opencoding.. Just keep using them?
>

Sure, added two inline functions `kho_radix_tree_desc()` and
`kho_radix_tree()`  back for converting.

> > > > + */
> > > > +static unsigned long kho_radix_encode(unsigned long pa, unsigned i=
nt order)
> > >
> > > pa is phys_addr_t in the kernel, never unsigned long.
> > >
> > > If you want to make it all dynamic then this should be phys_addr_t
> >
> > Should this also be `u64`, or we stay with `phys_addr_t` for all page
> > addresses?
>
> you should use phys_addr_t for everything that originates from a
> phys_addr_t, and u64 for all the ABI
>
done

> > > > +{
> > > > +     unsigned long h =3D 1UL << (BITS_PER_LONG - PAGE_SHIFT - orde=
r);
> > >
> > > And this BITS_PER_LONG is confused, it is BITS_PER_PHYS_ADDR_T which
> > > may not exist.
> > >
> > > Use an enum ORDER_0_LG2 maybe
> >
> > I prefer `KHO_RADIX_ORDER_0_BIT_POS` (defined as `BITS_PER_LONG -
> > PAGE_SHIFT`) over `ORDER_0_LG2`, as I think the latter is a bit hard
> > to understand, what do you think? This constant, along with others,
> > will be placed in the enum.
>
> Sure, though I prefer LG2 to BIT_POS

Lets pick LG2. =3D)

>
> BIT_POS to me implies it is being used as  bit wise operation, while
> log2 is a mathematical concept
>
>   X_lg2 =3D ilog2(X)  &&  X =3D=3D 1 << X_lg2
>
> > > > +                             kho_radix_tree_walk_callback_t cb)
> > > > +{
> > > > +     int level_shift =3D ilog2(PAGE_SIZE / sizeof(unsigned long));
> > > > +     struct kho_radix_tree *next_tree;
> > > > +     unsigned long encoded, i;
> > > > +     int err =3D 0;
> > > >
> > > > +     if (level =3D=3D 1) {
> > > > +             encoded =3D offset;
> > > > +             return kho_radix_walk_bitmaps((struct kho_bitmap_tabl=
e *)root,
> > > > +                                           encoded, cb);
> > >
> > > Better to do this in the caller  a few lines below
> >
> > But the caller is in a different tree level? Should we only walk the
> > bitmaps at the lowest level?
>
> I mean just have the caller do
>
> if (level-1 =3D=3D0)
>    kho_radix_walk_bitmaps()
> else
>    ..
>
> Avoids a function call

I see. Done.

>
> > > > +     for (i =3D 0; i < PAGE_SIZE / sizeof(unsigned long); i++) {
> > > > +             if (root->table[i]) {
> > > > +                     encoded =3D offset << level_shift | i;
> > >
> > > This doesn't seem right..
> > >
> > > The argument to the walker should be the starting encoded of the tabl=
e
> > > it is about to walk.
> > >
> > > Since everything always starts at 0 it should always be
> > >   start | (i << level_shift)
> > >
> > > ?
> >
> > You're right that this line might not be immediately intuitive. The
> > var `level_shift` (which is constant value 9 here) is applied to the
> > *accumulated* `offset` from the parent level. Let's consider an
> > example of a preserved page at physical address `0x1000`, which
> > encodes to `0x10000000000001` (bit 52 is set for order 0, bit 0 is set
> > for page 1).
>
> Oh, weird, too weird maybe. I'd just keep all the values as fully
> shifted, level_shift should be adjusted to have the full shift for
> this level. Easier to understand.
>
> Also, I think the order bits might have become a bit confused, I think
> I explained it wrong.
>
> My idea was to try to share the radix levels to save space eg if we
> have like this patch does:
>
>   Order phys
>   00001 abcd
>   00010 0bcd
>   00100 00cd
>   01000 000d
>
> Then we don't get too much page level sharing, the middle ends up with
> 0 indexes in tables that cannot be shared.
>
> What I was going for was to push all the shared pages to the left
>
>   00001 abcd
>   00000 1bcd
>   00000 01cd
>   00000 001d
>
> Here the first radix level has index 0 or 1 and is fully shared. So eg
> Order 4 and 5 will have all the same 0 index table levels. This also
> reduces the max height of the tree because only +1 bit is needed to
> store order.
>
> Jason

Thanks for the clarification. I updated the logic by keeping the
encoded value fully shifted and adjusting the `level_shift` according
to the current level.

And yes we are having the shared pages on the left side (zeros in the
encoded prefix) while having the order bits shift to right when the
page order increases. I hope the updated code makes this more clearer.

--
Jason Miu

