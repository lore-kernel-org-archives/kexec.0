Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BCC606A323
	for <kexec@archiver.kernel.org>; Thu, 22 Oct 2026 03:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FPbiVpuW;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=XYtaE0au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Un0pCsebAGgOHU5j/UFuxo61lM6ZZUr6aOfHjWXDb9g=; b=FPbiVpuWQLtF3S7ZUbOGpPdI4f
	SUG944aGo6Mu+RJSWZHQ8J1bOU5Uv4gSUBvLs6qCynvBvAbTnN0eL3etjCCP1N8rP7Lz3dUVOs1Lb
	82iEj0OpHBbGQJtfRG9vKQTUNQAyYsfYwDJK0v5t3Ec5pzvS+oG/NMD0IILbs1Nym14XfVvPZ0v2+
	jgXQxDYAwLjuTQtPZN0xvs4cssKgd3QqR+LNMuik84TSuNscOmLGmLvRTHAsZoG5+1CTny+/z5fbP
	kbm9XgXm30lVOVsXtwLZgIt2Xig2floerFFzOSjCS2FDUwQiAfrV/LLpaWMcZ6GGSos0fHasLStBk
	ft56MhVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJjY3-0000000DHXO-2Vj7;
	Thu, 22 Oct 2026 03:32:59 +0000
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJjY0-0000000DHWW-1OI0
	for kexec@lists.infradead.org;
	Thu, 22 Oct 2026 03:32:57 +0000
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-6acb9c018ffso767737a12.1
        for <kexec@lists.infradead.org>; Wed, 21 Oct 2026 20:32:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792639974; cv=none;
        d=google.com; s=arc-20260327;
        b=Y90QyeZR11fo7yLs/J5UAA1o6TSYRiPLsnuvYUWfQB43mPcohw6G6BEJ6bGmeNNxcs
         R/vkOuhw1+q5JvZxV3qUwCIv/lM4QfVKl4IDbE3bwhnHaxwpbS172vKurSnjZeTbVkjm
         pEBl4DrlWxXCb58yykWNoKnv/NgTtoH3Li9u5JFXyBz+/Vf3MCkWWnbNB+SmlKAnR0Oh
         8B2lLOpW9/RinJsZlhiZMMFYtxuLT3Mlr6j522yHkdvuskD/7kL73HGJxbl4jAroVdtm
         8y7Emq+pSU+gE2Idim8YlNzPhG88N1xSmVQwr/G/E48jRqwEPCZzlIQVamlcACmDPJ6T
         ++cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Un0pCsebAGgOHU5j/UFuxo61lM6ZZUr6aOfHjWXDb9g=;
        fh=NRuRTQg7LZkLfIg4XOx6ma3N8FlBLWu42LmQSsY6MfU=;
        b=CpKPNQMnx/TEpcjTZtL249ZfjZTbSPqUTQmplS/XlNlbqUafq7sGSv6/Ouu4Vh2kvj
         BkpTnKNoLJLo/HdUqI3/oFOzcg6KoCchLAGMGQapXfk5nYRRDDjGIJg049VsdMtZD77E
         q9xhy7gD41xn0zKndZtzoWHJ2OD5O+tj868z5sYFvFAIskmBlA8GjXbw7SGnCJQidO8N
         LzUDSuMfj1qJApO87Ks0+RU/5nP5GpXEWGSZteqlJPKNwTMInkjaNSmMftG0wQAOxqxB
         /I6Br2iMW8M+KWxcP7iV9Eo7zkNJR84EpNagRaaREppDMbAiOxF5nx0SjeSARHfR43va
         MfXA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792639974; x=1793244774; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Un0pCsebAGgOHU5j/UFuxo61lM6ZZUr6aOfHjWXDb9g=;
        b=XYtaE0aul8X3GEIdu9eMFaCP7XJQ4UUbKfDxseG6B1ljGGeymGamEFeahZ/JKKYukM
         GPHkK/i60fyra+q7+36LzDd/b0daemjT9TG+jl+55V2c1xjhZHzN7ARvE57ApyULqarw
         nY9jw3k2YTP2IakjcklSYLDiB6S+vPOyGeznZ8lAGX203miNKXQQyIqcdT68dxN4s2la
         OcEJw97nD+Bs0kZznApil+lmLbC2yvfDKQ6N28rLc3QtPLuHnwfb9g+BeYeJRa3ddMif
         AMG6GpAoBjlibYXQy1acY6vRVm/k98UWx0eTgoy6wlctqfrQqogyuYGhCc7hRBqpPNhe
         YHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792639974; x=1793244774;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Un0pCsebAGgOHU5j/UFuxo61lM6ZZUr6aOfHjWXDb9g=;
        b=AtfN8lDO5JYjDvMl+NEZYJaD0HqHCCkKPlr1RNXzmcZ05tNWs5+98c7/Kp+ruWp3wJ
         KNh1CsXjsKkHfdoYTzMtzH4szfgPFGzfvqw8auM+WlNo1LI+Rery8z4cJOG4UfoDm6k9
         tPxK2BNdvedH2Hrq69iKr+62vgTbCeZeTAvYfCYGFP3vhkW8zCIqn0c7EroebScgFuFz
         R8mNadje7EHE7nZ1r4Yqvmc/IXchHYPVdEkpoSvXqMwFqNuiSyj+vApqf5x0mk9OgpLw
         sxwa86z/ukjH0rSQx29bi1PQjURX2ZLM8hu+5QaqHCDw9rnZdNzVUTIU3/iKhlttk+gi
         H+FA==
X-Forwarded-Encrypted: i=1; AKwUvBziv+AtG9NycRwXFQk/nf1NuMzgGm3XVCUZ0qnc7XmjIOKtMSm8eBuzuivu8rC3cbWpHRSzJw==@lists.infradead.org
X-Gm-Message-State: AFq9FYIN802KkUv2dj9RgUD869Rn8vFiwdT6Q3yXfm+a4Fj8XVZjA0bC
	aRyU8XNPzBCEbFSwG2C2Kw0jlZlmrt0iQwjabhBBicPRVJLRo/LTKBHNqD2Y6grsNSGj3bEYI9f
	GZlqrotRgowt/RaX4688zhRGC/8k5ZeCWivWZz5CBAw==
X-Gm-Gg: AYBFou0kbgqfLiHkMycpbfn4xBMcjsZk2QfA00MuJgS+Gf/9fsbhvuuGKMmjCYnVOR7
	mWr6vneWs/x6LAwZlVPoZhrHjDC+F83Px9Ow0k+7toyPlqNMjo0Xg/WUqzMU+3oatKwL+3+WbiD
	71CR1Ob3ynd42c9qVlhUqciFJH12UhoJE5+g4cJC1u8Bex2wyV+yuoFJF6k76Pdo9uv2n3Hslik
	JsHTt2ZDJfGyS7hclLnc6p2lLp7RucUZDVJCp168mrt2vG5/fh6Fu36sux205LAQ98TLQXTOoXs
	zn0vMXJgGtb4W01wIlOZ/Kqn3y4DFgKDzTa10DhZnbHUDEiaSk1HFH5AIUzxvJAevF96hPSrkX7
	YqqNrbZPtQQhf0dIHan6DKJTXeCq9yOFx57ntD1B2DEUh+h8P3BI8O/e2zXvxfy/9/Ekk
X-Received: by 2002:a05:6402:2355:b0:6af:d794:4a8 with SMTP id
 4fb4d7f45d1cf-6b41d595e9cmr1157408a12.12.1792639974111; Wed, 21 Oct 2026
 20:32:54 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com> <20261021152527.375070-4-tarunsahu@google.com>
 <CA+CK2bAQbmq3ArP3XMErF_8RC2CUwvgpLY0H83D0nCJTaVKYyA@mail.gmail.com>
 <9huzecdi6go0.fsf@tarunix.c.googlers.com> <CALzav=dLdJoVy=B1pv0FAurD9OhAzLSTjJNbtjTdJRmSqaB0yw@mail.gmail.com>
 <CA+CK2bAQRMAEXZyHTEuUN0_Fo59Sn0hBmYbme_J9ewjx6gPyJQ@mail.gmail.com>
 <atlKsD-aJB3mJr2j@google.com> <CA+CK2bABt4OZO31TenVF2+uBUWVwViWbvfE00=0xbAw=f7K9SA@mail.gmail.com>
 <atl7peoVHdP5hz7z@google.com>
In-Reply-To: <atl7peoVHdP5hz7z@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Oct 2026 23:32:17 -0400
X-Gm-Features: AclHuK8_AnwdTvKegXWFQaKFyzs_ctZH_O_1uRYIa-PRh8yAhLXciiK9Gp-4xIE
Message-ID: <CA+CK2bBFXnJA1kddbLKGq0DAHDgjYhsTSQQay-xeX7jJC1V_UQ@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20261021_203256_442472_40C4C81B 
X-CRM114-Status: GOOD (  44.89  )
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

On Wed, Oct 21, 2026 at 10:57=E2=80=AFPM David Matlack <dmatlack@google.com=
> wrote:
>
> On 2026-10-21 09:26 PM, Pasha Tatashin wrote:
> > On Wed, Oct 21, 2026 at 7:28=E2=80=AFPM David Matlack <dmatlack@google.=
com> wrote:
> > >
> > > On 2026-10-21 02:50 PM, Pasha Tatashin wrote:
> > > > On Wed, Oct 21, 2026 at 2:47=E2=80=AFPM David Matlack <dmatlack@goo=
gle.com> wrote:
> > > > >
> > > > > On Wed, Oct 21, 2026 at 11:40=E2=80=AFAM <tarunsahu@google.com> w=
rote:
> > > > > >
> > > > > > Pasha Tatashin <pasha.tatashin@soleen.com> writes:
> > > > > >
> > > > > > > On Wed, Oct 21, 2026 at 11:25=E2=80=AFAM Tarun Sahu <tarunsah=
u@google.com> wrote:
> > > > > > >>
> > > > > > >> LUO and its file handlers validate handed-over state with mo=
nolithic
> > > > > > >> compatibility strings ("luo-v5", "memfd-v2"). Any change to =
a serialized
> > > > > > >> structure, even an optional additive one, must bump the stri=
ng, which
> > > > > > >> breaks live update between adjacent kernels. Replace the str=
ing in
> > > > > > >> struct luo_ser with a feature header, so that the target ker=
nel can
> > > > > > >> accept or reject the source kernel state per feature.
> > > > > > >>
> > > > > > >> struct luo_feature_hdr is a fixed 128-byte header: the seria=
lized
> > > > > > >
> > > > > > > This patch is all wrong; 128 bytes is far too large. For ever=
y _ser
> > > > > > > struct, we only need 8 bytes instead.
> > > > > >
> > > > > > NOO, It is not. It is intended to avoid complex mess with unnec=
essary
> > > > > > over-engineering.
> > > >
> > > > 128-byte per serialized struct is not starter.
> > > >
> > > > > >
> > > > > > >
> > > > > > > The first 4 bytes are the size, and the next 4 bytes are flag=
s (i.e.,
> > > > > > > 30 feature flags + 2 reserved bits for flags extension). The =
last two
> > > > > > > bits of the flags indicate whether an extended flags field is=
 present.
> > > > > > > Each extended flags field is 8 bytes, and its last two bits i=
ndicate
> > > > > > > that yet another extended flags field follows.
> > > > > >
> > > > > > If we will have dynamic extension of flags, Think about this.
> > > > >
> > > > > To support dynamic extensions in a backward compatible way you wa=
nt
> > > > > something like this:
> > > > >
> > > > > struct luo_feature_hdr {
> > > > >    size
> > > > >    flags
> > > >
> > > > __u32 size
> > > > __u32 flags
> > > >
> > > > >    extensions  // offset of first luo_feature_extensions (or 0)
> > > >
> > > > __u64 extensions[0]  --> but the size should be specificed in
> > > > declaration macro that I showed in the next patch.
> > >
> > > I think you may have misunderstood what I meant. In my proposal,
> > > extensions is an offset to the first extension, not an array of
> > > extensions that immediately follow the header.
> > >
> > > If the extensions immediately follow the header, then the number of
> > > extensions is baked into the struct layout. Every field after them si=
ts
> > > at an offset that depends on how many extensions there are. If we eve=
r
> > > need one more extension, all the fields shift and old and new kernels
> > > can no longer read each other's struct. That is the problem Tarun
> >
> > We can structure it cleanly by nesting the payload: something like
> > struct { struct header {...}h; struct serialize_data { ... }p; };
> > That way, the header can expand dynamically at the front, while all
> > fields inside `serialize_data` stay at fixed offsets relative to the
> > start
> > of the payload.
> >
> > Since the header size is self-describing via continuation bits (e.g.,
> > the last two bits indicating whether another flag word follows), LUO
> > can
> > easily compute where the payload begins in the incoming blob. This
> > keeps the implementation simple, avoids linked lists of offsets.
>
> Oh interesting. I agree a dynamically sized header at the front can work
> and is simpler than a linked list.
>
> So the header and the payload need to be separate, and the payload is
> located with pointer arithmetic on the header. For example:
>
> struct luo_ser_hdr {
>     u32 size;    /* Size of the payload in bytes */
>     u32 flags;    /* Bits [31:30] indicate an extension word follows */
>     /* u64 extension words follow while the continuation bits are set */
> };
>
> /* Size of the header, including any extension words. */
> size_t luo_ser_hdr_size(const struct luo_ser_hdr *hdr);
>
> static inline void *luo_ser_payload(const struct luo_ser_hdr *hdr)
> {
>     return (void *)hdr + luo_ser_hdr_size(hdr);
> }
>
> On preserve:
>
>     hdr =3D kho_alloc_preserve(luo_ser_hdr_size_for(nr_ext) + sizeof(*ser=
));
>     luo_ser_hdr_init(hdr, sizeof(*ser), ...);
>     ser =3D luo_ser_payload(hdr);
>     ...
>     args->serialized_data =3D virt_to_phys(hdr);
>
> On retrieve:
>
>     hdr =3D phys_to_virt(args->serialized_data);
>     err =3D luo_ser_hdr_validate(hdr, ...);
>     if (err)
>         return err;
>
>     ser =3D luo_ser_payload(hdr);
>
> What would size mean in luo_ser_hdr? The size of the payload or the size
> of the combined luo_ser_hdr + payload. luo_ser_hdr is self describing so
> maybe it's just the size of the payload?

> What would size mean in luo_ser_hdr? The size of the payload or the size
> of the combined luo_ser_hdr + payload. luo_ser_hdr is self describing so
> maybe it's just the size of the payload?

Either works, but having size cover the combined hdr + payload
provides a few extra guarantees:

1. A single static_assert validates the entire serialized struct at
compile time, including the header and the number of ext_flags
elements.
2. Bounds checking while traversing the header continuation bits on
retrieve: we can sanity-check that luo_ser_hdr_size(hdr) <=3D hdr->size
so we never walk past the end of the serialized blob if there is
memory corruption.

If we declare the payload struct separately and pass it into the
macro, handlers also get a clean type for luo_ser_payload(hdr):

#define DECLARE_LUO_SER(name, expected_size, ext_flags_count, payload_type)=
 \
    struct name {                                                          =
 \
        __u32 size;                                                        =
 \
        __u32 flags;                                                       =
 \
        __u64 ext_flags[ext_flags_count];                                  =
 \
        payload_type payload;                                              =
 \
    };                                                                     =
 \
    static_assert(sizeof(struct name) =3D=3D (expected_size),              =
     \
                  "LUO struct " #name " size mismatch!")

For example:

struct luo_memfd_payload {
    __u64 pos;
    __u64 size;
};

DECLARE_LUO_SER(luo_memfd_ser, 24, 0, struct luo_memfd_payload);

