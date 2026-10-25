Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632C5606A32F
	for <kexec@archiver.kernel.org>; Sun, 25 Oct 2026 20:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=QM5kHePI;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=NGVrWQy5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=rp5Fden8a6neVzulsysbnvEXD4vRCF1NzLSbVrqKH4E=; b=QM5kHePINCe2Yg
	b0ZHervu1QRNbzO3jK0jf+vBE2Nnot9RULZITjdIYos1+Vdyxd8/B+7jfedNhmjohClBO2qFjz53A
	OXWROAU6DX22GIL1ADT1f2yWUTYBcTXHBJAgKa5iqAYcQ+GBLiYcVV5WwJFG0i4435Ui4F15Qiv3m
	7lv+ieT4gh3QLbuT9RdeyRyvAWa2cl6JcPZ1p5Q/ogjdREyRrDj8j1JhHMH9Y9JimmzdtL+zGPG25
	rSvmFnosnXafyEoEb44sHU7tHdHJUNtgdlN64qKBKeP81d0asihsfj0v5weJHRJOCzred8zNI5y/I
	zBhrxDi/CjTi7hTVdTBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL4zg-00000001Qbl-2CB0;
	Sun, 25 Oct 2026 20:39:04 +0000
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL4ze-00000001Qb7-1vc3
	for kexec@lists.infradead.org;
	Sun, 25 Oct 2026 20:39:03 +0000
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-6b1dae0febeso3331080a12.2
        for <kexec@lists.infradead.org>; Sun, 25 Oct 2026 13:39:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792960740; cv=none;
        d=google.com; s=arc-20260327;
        b=nTmB26ztMLj4NJMsA9SIBjGX4P+t9Mi9wKJ27k/YAJFvWo20CnDEnOgS2EO4GdbjAR
         PdlmK617hHXjOtiELnx0cz0ejnYWI6/uC/Vd+4iBLUSlJcAXauybwbnz7ZtDcakIm4IA
         Lg6LSSScliW+AppcGmr/iNUKy/vZVOxOBqZMGfipcpJ21snMdOupfbryIwNOnt9XvqP0
         hhvSyMgI3yovlZxZHINgZZe0rJg/xUEQr3YRTqEsLcS5jiENFOh4X2nCl+32Np8LJUFV
         D2UXjrbMJr8v+g/PyiBO7VjWEK9p0CB5INSPAgAr2QYaOFWIT1BxB0amp1l1F0ouUXot
         JgzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rp5Fden8a6neVzulsysbnvEXD4vRCF1NzLSbVrqKH4E=;
        fh=+QP3TfZtK3YvcqYImiBUufpYNGIZqg//85HGZQjsBaI=;
        b=Qt6wBNElWpWee2UEB5jo5THY1Z/qc5IoNKA4T6wYKAyqDIonQZIBZ1vbutzkQJxB++
         BJnEVSuAt/EYvo7j0CnxKSGQVV7McFsLTZjeX8rWXgz48+I4opVlcupOM3CP9eYhHrOJ
         eJe7m3oe+iD5rrksFvaA3Gjsbqy8BpbFes88x5My3ybpAEMjyGKODENbZh9dphH6RcZW
         ZFehlkbWyLxyetooxD+bznHablwzqPRZhi+qFvVQVUhxXoF3eTo4SU4++iPDTEybLqZJ
         atJCLxY61zDb/AgTaDZgDUJX/cELVrXSrnAFudbRhmQtGbLak31Uc2ugnN7CZGwl1zOD
         +8Lw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792960740; x=1793565540; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rp5Fden8a6neVzulsysbnvEXD4vRCF1NzLSbVrqKH4E=;
        b=NGVrWQy5y9xi7l0oONLhs/0WZEsfiIX0BK2cpofR01Iu7P4WeFQaE2TkBCiB2v4qxi
         OAsCuQzNOuEKpDxrGmCNyfaE6xPMj8z406RE8P4wcsxsdVNcrx4XXhnVAs1l2NJ7H6Q7
         AOCD6oz98f2pKK/wsdji45XLaM7CY1hfvwYV2LNvo07XeyQvbKWLek63iKvWoNrMeREi
         4KrMuEEfp64SDRMXP+O3XWDb3xBPij8DvmZCpUMnJiSML1ziCvNzlDmyx3Dmvew8ooPP
         q/ON18zQz64c0o0KiUfZ1kFwF6J9CE+/O/qo7VABLsEYcjgRDzpldOyQZnyPb/9IreTb
         /isg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792960740; x=1793565540;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rp5Fden8a6neVzulsysbnvEXD4vRCF1NzLSbVrqKH4E=;
        b=CLF3oZWrCk2GIf/4m012BLrerskTZdt2XQRrei88ILdfznVWC6SC06RP6Kz1Ag9NWF
         Y8gqWgO75w3SHLP+g9LQuyCyeYOR/J/04GkJqrMrTsvrdvBc1hXWN942vUep9e2gyz8H
         iGGB0U9P/vj6IR6Oi8da6YdN+xIkub/J//mkIIAtvoQC1eDLoadWBbcl2XODrEG3uCI2
         5srWudlyF4/OnUI5w6zBlOMMMG/J+7waZ7TTi76QY0kJs/QdE28jA+xneaIxkpEtgont
         ekPd9OBUFTlwPDxT6tgpobnKxKCHwjYzPAoVWjhyryNHOaVznt/PbYnIFWq4WV3uDj/e
         QO3g==
X-Forwarded-Encrypted: i=1; AKwUvBydLb5Sz4UvOSAdXPrg4pQKFgMrzV3dTUQigHOHIwBCoMLRxvg3hmvearYPA8TjbywMREc8Wg==@lists.infradead.org
X-Gm-Message-State: AFq9FYKm+s9aIHy7653JBU561xRGmhZuQ4Gt7y1+CYWPM12cHIHj7kQ0
	ZkPEi97tc3hPhVvKrz8jU+aT++d8H5GJh3YMwnAL+oar/n9JcOxvfi8Uoumv6Gtr0++ZAUpGZK/
	9m9DygUwN10b5Y400UtKd70n/yxq8ph9uRbBoK1nwDg==
X-Gm-Gg: AYBFou2/clvJdvVG9vzEVI9ZEAUq0F4wDM76D9jeQwlrAY/6lL35KRgIvKngq38DOOO
	srrk7xGcBLYsTmUGp2bQUHv3TYix/hVQeyKkAkwtx2SHSAkXb8TGcFhwDMvkddlUOUlMBxX/Q2P
	eoSYDzd4VGk7Vx1LewbW5WlbDevKMfxv8jftMIGvToN3ElptkxDkE3396VD8F0yrGHHUv9lnlWx
	PF4B61S3pPXimX+1pUL1VE51Ahtj/ZqdXpCTdNEd9oJ11252MEtT8jYRc/psr2g9APxnxm1c7YJ
	zPgHhnE4kKVIFzUNKgq9A50+LP6Tik4qerpk0eleiOCbnS9wKAqEI0yDk1K+kD8R5TTWbiT1Yv8
	SbxBbKbBkaWtp3h7jjWs1kbcbZ92IyS5jwamTuY3S/VNwnWHnv3BfbnbPN4Kd9KH/BzVV
X-Received: by 2002:aa7:dd0f:0:b0:6b2:2339:370d with SMTP id
 4fb4d7f45d1cf-6b443000b00mr4543991a12.39.1792960740017; Sun, 25 Oct 2026
 13:39:00 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CALzav=dLdJoVy=B1pv0FAurD9OhAzLSTjJNbtjTdJRmSqaB0yw@mail.gmail.com>
 <CA+CK2bAQRMAEXZyHTEuUN0_Fo59Sn0hBmYbme_J9ewjx6gPyJQ@mail.gmail.com>
 <atlKsD-aJB3mJr2j@google.com> <CA+CK2bABt4OZO31TenVF2+uBUWVwViWbvfE00=0xbAw=f7K9SA@mail.gmail.com>
 <atl7peoVHdP5hz7z@google.com> <CA+CK2bBFXnJA1kddbLKGq0DAHDgjYhsTSQQay-xeX7jJC1V_UQ@mail.gmail.com>
 <CALzav=e=ho2gVrn+7KpZ3ZyasvH2u15-pC-RSRSS7KcMfKqUJQ@mail.gmail.com>
 <CA+CK2bAJo8dnTOyKMgnnMnk-SCXbTsv+JCLEOWkjyj-wqtEkHg@mail.gmail.com>
 <atpNFEFIlqAoYIwH@google.com> <CA+CK2bB2C3Am5ssRuzYpfiU7_vB81vxMGc19HQLq7N=_7YrbTg@mail.gmail.com>
 <attmFVIFU_mS0Y7p@google.com>
In-Reply-To: <attmFVIFU_mS0Y7p@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sun, 25 Oct 2026 16:38:23 -0400
X-Gm-Features: AclHuK80OiwlBnY6tUr3jZ6atHcY2MdRSOFYk5-Bhewn5rIfzUZ_oGQw-LNyjus
Message-ID: <CA+CK2bDXDWbww_d3sD6OZqpo37V1a3t76_ubbrXLQS=9DB3dWA@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20261025_133902_568931_9236EED1 
X-CRM114-Status: GOOD (  33.28  )
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
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 9:50=E2=80=AFAM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2026-10-22 04:53 PM, Pasha Tatashin wrote:
> > On Thu, Oct 22, 2026 at 1:51=E2=80=AFPM David Matlack <dmatlack@google.=
com> wrote:
> > > On 2026-10-22 12:11 AM, Pasha Tatashin wrote:
>
> > > > Lets drop the fourth macro argument and generate the combined struc=
t name:
> > > >
> > > > #define DECLARE_LUO_SER(name, expected_size, ext_flags_count)      =
        \
> > > >     struct name##_hdr {                                            =
        \
> > > >         __u32 size;                                                =
        \
> > > >         __u32 flags;                                               =
        \
> > > >         __u64 ext_flags[ext_flags_count];                          =
        \
> > > >         struct name payload;                                       =
        \
> > > >     };                                                             =
        \
> > > >     static_assert(sizeof(struct name##_hdr) =3D=3D (expected_size),=
            \
> > > >                   "LUO struct " #name " size mismatch!")
> > > >
> > > > For example:
> > > >
> > > > struct luo_memfd_ser {
> > > >     __u64 pos;
> > > >     __u64 size;
> > > > };
> > > >
> > > > DECLARE_LUO_SER_HDR(luo_memfd_ser, 24, 0);
> > >
> > > I think we are getting close, bu I have two remaining concerns:
> > >
> > >  * Reserving bits in each flags word for continuation leaves gaps
> > >    in the flag space that users have to know to skip.
> >
> > Yes, but callers should never manipulate the raw flag words directly,
> > and we can provide simple accessor macros or inlines that take a
> > contiguous feature ID (0, 1, 2, ...)
> >
> > enum luo_memfd_feats {
> >     LUO_MEMFD_FEAT_HUGETLB =3D 0,
> >     LUO_MEMFD_FEAT_SEALS   =3D 1,
> >     /* ... */
> >     LUO_MEMFD_FEAT_FOO     =3D 15, /* Automatically lands in
> > ext_flags[0] bits 0:1 */
> >     LUO_MEMFD_NR_FEATS
> > };
> >
> > if (luo_ser_get_feat(hdr, LUO_MEMFD_FEAT_HUGETLB)) {
> >     /* handle hugetlb */
> > }
>
> Sure but why deal with all the complexity just to save 8 bytes? All of
> these structs are allocated on folios and there are kilobytes of unused
> space to fit this header. And even if we optimize that we are talking
> about 8 bytes per FH/FLB... or 16 bytes for structs with arch-specific
> sub-structs like the KVM ones.

The reason I care about keeping the header compact is that we are
defining a foundational kernel ABI and want to use this header across
almost every serialized data structure so we can evolve them later
without breaking compatibility. While some top-level structs are on
sparse folios today, other serialized structs are tightly packed, and
we are looking to add KHO slab support in the future where tightly
packed allocations will be common.

That said, in your proposal, as long as nr_flags =3D=3D 0 is allowed when
a struct has no feature flags yet, luo_ser_hdr_size(hdr) is already 8
bytes and only grows to 16 bytes on the first feature flag. I am OK
with that.

> > >  * struct name##_hdr only matches structs written by the current kern=
el
> > >    (in terms of length of array and offset of payload).
> >
> > This is not an issue on the incoming path, we never cast incoming data
> > to struct name##_hdr or access ->payload directly. Instead, we parse
> > the incoming buffer, dynamically compute the header size from the
> > continuation bits, and cast the payload offset to "struct name *"
> > based on the negotiated feature flags.
>
> How?
>
> This is the only data structure that describes the header. Are you
> saying the incoming path will parse the header purely with a void *? Or
> use this header but just be careful not to access payload?
>
> We should have one header structure that can be used on the incoming and
> outgoing path. We should not have one header data structure that can be
> used on the outgoing path and one that can be used on the incoming
> path.
>
> Also we need a standard header that can be shared across all structs,
> not a per struct header. Otherwise you will need to do weird casting and
> overlays to implement the shared helper routines that parse it.

Having DECLARE_KHO_SER_WRAP() in include/linux/kho/abi/ makes it
immediately clear just by looking at kho/abi/ which serialized structs
have the versioned header and which do not, while also enforcing the
header when preserving and static-asserting the combined struct size a
compile time.

So with your header (and let's use KHO as we want to version KHO
structs as well):

struct kho_ser_hdr {
        __u32 size;        /* Size of header + payload in bytes */
        __u32 nr_flags;    /* Number of features encoded in flags[] */
        __u64 flags[];
};

The wrapped struct will look like:

#define DECLARE_KHO_SER_WRAP(name, expected_size, nr_feats)                =
\
        struct name##_wrap {                                               =
\
                __u32 size;                                                =
    \
                __u32 nr_flags;                                            =
    \
                __u64 flags[DIV_ROUND_UP(nr_feats, 32)];                   =
    \
                struct name payload;                                       =
    \
        };                                                                 =
\
        static_assert(sizeof(struct name##_wrap) =3D=3D (expected_size),   =
    \
                "struct " #name " size mismatch!")

On the incoming kernel we don't use struct name##_wrap, but we use
struct kho_ser_hdr for the wrapped data, validate the flags, and
unwrap it via kho_ser_payload(hdr) to get back the struct name *
payload type.

Pasha

