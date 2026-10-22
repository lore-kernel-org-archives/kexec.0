Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17C4606A32A
	for <kexec@archiver.kernel.org>; Thu, 22 Oct 2026 20:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1zhFEfql;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=W54FOMcl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=q7AHGxYo2F1tyAP4/knTgDUev2PNwFvE7RNfo85FnlQ=; b=1zhFEfqlJzkLuL
	s44CoBDhQnel80ZTJYBcw7iu1VJnVZt6UfTyuvWXDp2RLxnTuHVAPkDhGpBlkarC13FoDVr3AJIvj
	nXFBUrK354pHb9g7Y0k15SBxkqLwTvVSlzb6aSmasTe/Pi/eHkE26QYGx1sSWOUVmlAa0aKpcBIgb
	x2ikoxpzfJgVYOZqROKcH4mYLIHewpmJgSGO4nS92fciAISQgROjaZRB5TXy/wsHIQfof06ogwwr0
	Vp+KrQRjqkXbRzJOBC3PuVUpr2NzhpWFo+ABugFnjccTTHthkAoCx8fEqloG6bgP8sgbQeMP0avhs
	WzZ3GzI1ST/XexwaCO4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJznf-0000000ExmM-0HSu;
	Thu, 22 Oct 2026 20:54:11 +0000
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJznc-0000000ExkX-0899
	for kexec@lists.infradead.org;
	Thu, 22 Oct 2026 20:54:09 +0000
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-6afafc89b48so235839a12.2
        for <kexec@lists.infradead.org>; Thu, 22 Oct 2026 13:54:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792702446; cv=none;
        d=google.com; s=arc-20260327;
        b=nMpRAddrxuG40UABmrTj75qcW8HGQoWnBs6tW5sdN371lDHxwNWgH6PpyU7EZQSG0O
         QC/ULqi5L44l3zA14CkfI0POjnpkFOPiW3OCLucGXoEIaB4z9IeTEfR88mHY2gBNliGi
         ceHR80pYRsun59W58kkBc2xHMlh+bG98XXyJ7BS8+OJt5VpwABGYDT5yDhAlMslXCmmx
         CVTw6WrUCry610AJPi6LQ3aduQNZ0pypTpGWUocnLsJ+7CYXJOZYEscniwlQHN+DOCSb
         QkVG482H7ZmnBaNgfMOftIExfTVbs6IdnaN18BePRxeLHBnB6yYQGvmO9r2sFfyYHux4
         trfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q7AHGxYo2F1tyAP4/knTgDUev2PNwFvE7RNfo85FnlQ=;
        fh=uLnEo45UJoUNKNfptmiROImK6xt/uAaa45JWXVFjy64=;
        b=sfASYg8csJZx5FZBDe13fR74r/MQ2cXHCCH8YLyvKGiIeEfofp5Bw8SMZKYTRXSWwU
         CZGrePDrYhWZRiKzO4kUmumPf8bzIyU3RMvIWtZLYu2fFb5Dn5VVchkYzpi8qjguNljC
         UtH1kT9rih0aTv4lpZ5894FgSnQADP3VTY7dHhjPng+YCQ84H/Zu+HTlTlFGpT3MRRLl
         S4dpiJ+LZUOywKVwI0d7IabSKTLACdVLCvDUaTHT79Zi91SFwkczELQz2dYVuTXAJs0P
         UrutMAQB5CWeCLWGxHUaGcHAOtI4R0hIT1CBRiWnkJxdRpq8x2t4e5ziuXh67ywvX4PD
         Q45Q==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792702446; x=1793307246; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q7AHGxYo2F1tyAP4/knTgDUev2PNwFvE7RNfo85FnlQ=;
        b=W54FOMcl3MAuOcUGdlr5PxBfeUlJb36wVZ1rlAO6i/W+ynJKk3SqVoorf0uHV+WlwD
         Mat7eH7JGaqrDe5dYUS0AOW/gwprEyipTWeObMF08JFc6luP2/f4zK9FQfmbNLs5GO6y
         mSDD9wAFTpO3N/e8zzPWIQnzAFttETlXQaLMqdhvovnlUrWxb3STdFhFUE9bfD/zNOWw
         zCX9TXOPqBU1bHiptJB29PDZZ2Slt6MUPc1M40zgZjr441djP2++A8/pHodLEDYhqix1
         C20knvsDZsLko9b3IDHny7BWRKphS6SaQ0T0J9/nfwlhiiR7IXUfTYeHXt7Wz/YFILcS
         MVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792702446; x=1793307246;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q7AHGxYo2F1tyAP4/knTgDUev2PNwFvE7RNfo85FnlQ=;
        b=sPiJ6lcraaEB3jqho7uFpN3AQKBp/XzhF3jqhP2Ogpb3YneEqorNPYrf4sP2EG2gF/
         zeGxxz8Nyn1HHSe/V1QvTPSa2BGTulH89z82DZjQwoVo5LtRzwwXjU3Dds43oLj8AKt0
         6P6NjFbbT483Nn0/+d9swO7gbVX2G2nCfZBq8yiih5Gp8ELWN27uhqhhWI6Y7DHXaNH0
         5GmqP7Em76ykYokegv9ARFHlTttLIaabAyRTIPPLxHAK1ILDUJYGmB+vzBRxLmvXvtqJ
         G0pphZ8TtolGqytQ6ruTxyABEpIobvN8Rdshfe7xaADR8u+yaX+7ac44YIBHyHyZ004P
         dnFA==
X-Forwarded-Encrypted: i=1; AKwUvBwlKdHqy+QHU2ifjd7wW3bLbzS4C0uFIFh7acwjxQOqf2snjr8/ot8YsLN1DC8g/DZ357Y/cw==@lists.infradead.org
X-Gm-Message-State: AFq9FYIhWwAs/d2oSBVlLS8e2GKJ88y5nntAPUxp553yTTyCPGKFlTBe
	Ewdz73L1hLaWkp46IfFa3Qxdkp6fed892HcYZKI3npzAzTKhBX5J/MHZyZZr/o9DwHtQt1F68ug
	GiJGbIx/8O5GxQ4eZ8pq1VpNfSkd233JgWxV5tMahiA==
X-Gm-Gg: AYBFou0t1jpZgqFff30iJ0Jfm2/I9x/cXTwMpuDyuqOlMoKe6V/M7TBx7S8z/0tielo
	0s4CZcly7iGAN44Spaf73xnAjZ1T5Jo6lqlY/dizShsGlhbeTmcv3RfsRPCafX7UhedGoaHN0ba
	Kdk8Vakw4ZKJBiH+7vmp021WlN/Zz7oOr4xyoCR8ekUfoVVCYb2eBD+g7XiW5hq1E6aiMAp3dMF
	ViuvdRnzVzwR3whokmn+y0uw6z6+AKGpyN/x8H3qnIg1ddRraMYe8hY1y84sKOuXHymO/DuR07M
	qgGX0PrPSx8nEpgInydmLgt+pUDVYwS26XdLdONL/AtReNXsYo3sVM3cGStuZt0Q1P2/JPZIIOp
	E+izvoLzTZFmQYCWnT+JyB5lakXN0WIMZKX0tyyoyuYRwedqPiUTcnoiDN510Kgrd0gCZ
X-Received: by 2002:a05:6402:321c:b0:6b1:c299:b3f8 with SMTP id
 4fb4d7f45d1cf-6b432c1a486mr859420a12.33.1792702445990; Thu, 22 Oct 2026
 13:54:05 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CA+CK2bAQbmq3ArP3XMErF_8RC2CUwvgpLY0H83D0nCJTaVKYyA@mail.gmail.com>
 <9huzecdi6go0.fsf@tarunix.c.googlers.com> <CALzav=dLdJoVy=B1pv0FAurD9OhAzLSTjJNbtjTdJRmSqaB0yw@mail.gmail.com>
 <CA+CK2bAQRMAEXZyHTEuUN0_Fo59Sn0hBmYbme_J9ewjx6gPyJQ@mail.gmail.com>
 <atlKsD-aJB3mJr2j@google.com> <CA+CK2bABt4OZO31TenVF2+uBUWVwViWbvfE00=0xbAw=f7K9SA@mail.gmail.com>
 <atl7peoVHdP5hz7z@google.com> <CA+CK2bBFXnJA1kddbLKGq0DAHDgjYhsTSQQay-xeX7jJC1V_UQ@mail.gmail.com>
 <CALzav=e=ho2gVrn+7KpZ3ZyasvH2u15-pC-RSRSS7KcMfKqUJQ@mail.gmail.com>
 <CA+CK2bAJo8dnTOyKMgnnMnk-SCXbTsv+JCLEOWkjyj-wqtEkHg@mail.gmail.com> <atpNFEFIlqAoYIwH@google.com>
In-Reply-To: <atpNFEFIlqAoYIwH@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 22 Oct 2026 16:53:28 -0400
X-Gm-Features: AclHuK_o-bcMo-_bEmG9OJEk39HO6mWdZ96jtolFahfwsqDnw1LYQXgLWQ4gcJk
Message-ID: <CA+CK2bB2C3Am5ssRuzYpfiU7_vB81vxMGc19HQLq7N=_7YrbTg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
To: David Matlack <dmatlack@google.com>
Cc: tarunsahu@google.com, Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, 
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com, 
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org, 
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, will@kernel.org, 
	Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261022_135408_184011_0E575533 
X-CRM114-Status: GOOD (  34.90  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 1:51=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2026-10-22 12:11 AM, Pasha Tatashin wrote:
> > On Wed, Oct 21, 2026 at 11:53=E2=80=AFPM David Matlack <dmatlack@google=
.com> wrote:
>
> > > > #define DECLARE_LUO_SER(name, expected_size, ext_flags_count, paylo=
ad_type) \
> > > >     struct name {                                                  =
         \
> > > >         __u32 size;                                                =
         \
> > > >         __u32 flags;                                               =
         \
> > > >         __u64 ext_flags[ext_flags_count];                          =
         \
> > > >         payload_type payload;                                      =
         \
> > > >     };                                                             =
         \
> > > >     static_assert(sizeof(struct name) =3D=3D (expected_size),      =
             \
> > > >                   "LUO struct " #name " size mismatch!")
> > > >
> > > > For example:
> > > >
> > > > struct luo_memfd_payload {
> > > >     __u64 pos;
> > > >     __u64 size;
> > > > };
> > > >
> > > > DECLARE_LUO_SER(luo_memfd_ser, 24, 0, struct luo_memfd_payload);
> > >
> > > This looks pretty reasonable but I would name the payload
> > > luo_memfd_ser. The combined struct that DECLARE_LUO_SER() creates
> > > should never be used directly since the offset of the payload in that
> > > struct is only valid in the current kernel. So I would give that
> > > struct a special name that makes it obvious you shouldn't be using it=
.
> >
> > Lets drop the fourth macro argument and generate the combined struct na=
me:
> >
> > #define DECLARE_LUO_SER(name, expected_size, ext_flags_count)          =
    \
> >     struct name##_hdr {                                                =
    \
> >         __u32 size;                                                    =
    \
> >         __u32 flags;                                                   =
    \
> >         __u64 ext_flags[ext_flags_count];                              =
    \
> >         struct name payload;                                           =
    \
> >     };                                                                 =
    \
> >     static_assert(sizeof(struct name##_hdr) =3D=3D (expected_size),    =
        \
> >                   "LUO struct " #name " size mismatch!")
> >
> > For example:
> >
> > struct luo_memfd_ser {
> >     __u64 pos;
> >     __u64 size;
> > };
> >
> > DECLARE_LUO_SER_HDR(luo_memfd_ser, 24, 0);
>
> I think we are getting close, bu I have two remaining concerns:
>
>  * Reserving bits in each flags word for continuation leaves gaps
>    in the flag space that users have to know to skip.

Yes, but callers should never manipulate the raw flag words directly,
and we can provide simple accessor macros or inlines that take a
contiguous feature ID (0, 1, 2, ...)

enum luo_memfd_feats {
    LUO_MEMFD_FEAT_HUGETLB =3D 0,
    LUO_MEMFD_FEAT_SEALS   =3D 1,
    /* ... */
    LUO_MEMFD_FEAT_FOO     =3D 15, /* Automatically lands in
ext_flags[0] bits 0:1 */
    LUO_MEMFD_NR_FEATS
};

if (luo_ser_get_feat(hdr, LUO_MEMFD_FEAT_HUGETLB)) {
    /* handle hugetlb */
}

>  * struct name##_hdr only matches structs written by the current kernel
>    (in terms of length of array and offset of payload).

This is not an issue on the incoming path, we never cast incoming data
to struct name##_hdr or access ->payload directly. Instead, we parse
the incoming buffer, dynamically compute the header size from the
continuation bits, and cast the payload offset to "struct name *"
based on the negotiated feature flags.

>
> How about this instead:
>
> struct luo_ser_hdr {
>     __u32 size;        /* Size of header + payload in bytes */
>     __u32 nr_flags;    /* Number of features encoded in flags[] */
>     __u64 flags[];
> };
>
> Each feature occupies 2 bits of flags[], so feature N is always bits
> [2N+1:2N] of flags[N / 32], with no gaps:
>
>   00: Feature not present
>   01: Feature present, safe to ignore if not supported
>   11: Feature present, must be supported by the next kernel
>   10: Invalid
>
> The length of flags[] and the header size are computed directly rather
> than by walking continuation bits:
>
> static inline u32 luo_ser_nr_flag_words(const struct luo_ser_hdr *hdr)
> {
>     return DIV_ROUND_UP(hdr->nr_flags, 32);
> }
>
> static inline size_t luo_ser_hdr_size(const struct luo_ser_hdr *hdr)
> {
>     return struct_size(hdr, flags, luo_ser_nr_flag_words(hdr));
> }
>
> static inline void *luo_ser_payload(const struct luo_ser_hdr *hdr)
> {
>     return (void *)hdr + luo_ser_hdr_size(hdr);
> }
>
> and bounds checking is just luo_ser_hdr_size(hdr) <=3D hdr->size. The
> payload is always 8-byte aligned.
>
> Payload structs are then declared on their own, with no header:
>
> struct luo_memfd_ser {
>     __u64 pos;
>     __u64 size;
> };
> LUO_SER_ASSERT_SIZE(luo_memfd_ser, 16);
>
> The static_assert covers the payload to catch embedded structs changing
> size.  Asserting the header doesn't add anything since its size varies
> by kernel. And because flags[] is a flexible array, the header can't be
> embedded in front of a payload in a combined struct; it can only be
> reached through luo_ser_payload().
>
> I think the only downside is that the header increases to 16-bytes when
> there is at least 1 flag. But I don't think we need to be so concerned
> about an 8 byte difference...

I would prefer to keep the default header at 8 bytes. With 15 features
fitting directly inside the base __u32 flags word, adding the first 15
features to a struct keeps the header at 8 bytes and does not shift
the payload.

Computation-wise it is also very similar: for the 99% of structs that
have <=3D 15 features, LUO_FLAGS_CONT is 0, so computing the header size
is just a single bit test with no loop. Even if a struct ever needs
ext_flags, the loop will walk at most one or two extra words.

Pasha

