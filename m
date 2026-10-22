Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415B2606A324
	for <kexec@archiver.kernel.org>; Thu, 22 Oct 2026 04:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vtFmd6fo;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=JStJjrH6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vprUskQTUd+SPbnT8TFojrEtK+oeOiPvhjewwpNbp/8=; b=vtFmd6foluGD43pZ3qwRYWHzf8
	mJgssNHBJpQTHLA6naxawh4uflS0Yape1n1Mg08p3LXWXU/M8jnq5MJJY7a8ki6jewgV3z7vY8g/s
	MjxzpQwON5LP64DbL1eXqw2bYge1h5fwr5o4KccMLWqCaGb7Y4xzbuXvBGoJj3kFfkUAlDtE1HAA4
	f/K42RXb3XyDPpSqP3mzdZKj6OniY24Uffjx8m8XG9E0SMyZt+f7PS2vl6cPRUqKVFhKBPPlvY/+G
	khvNTnELDSvjbZtdVaMNsUv25CqbokQNzRSx/TKg5nfKVOeYhbbD6oDBhFKHAMkE06csVHfKW/9lH
	Z0FJybxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJkA9-0000000DJiq-0u5Q;
	Thu, 22 Oct 2026 04:12:21 +0000
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJkA6-0000000DJi9-0sFt
	for kexec@lists.infradead.org;
	Thu, 22 Oct 2026 04:12:19 +0000
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-6b21cf1a580so1420948a12.1
        for <kexec@lists.infradead.org>; Wed, 21 Oct 2026 21:12:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792642336; cv=none;
        d=google.com; s=arc-20260327;
        b=jYPorI/kfwEcwkxcqfsX0+Zuv7aUwrPpXBi2va6jWw43pKxdh9+tyY9SGA7ZeCzi9L
         Oxcu0PlqAJexr11LvU4dzxs91GmGqpU582udu5p4rVRH+UFLrU+R4nS2nwtmcDYkZdIt
         8CuRwGkabBrTlS0myYACas/Fa7ihPDvuyUdi1GYvYQrFfQmBdDNI4q/OqYZHgtR7HIDw
         xiNpFY9hSYQHAtNjRM9hp6sQO0Lthj9EPrvlBnB+46AwsXEQYZ7mKur3Zi8GueOjydfk
         rcUebIsjPr/Nkd1UZ7MvOh62cz3WWgL4mZv4DDL4wtHwsT2B2TeA1emTjK2MX5LUL94+
         1lIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vprUskQTUd+SPbnT8TFojrEtK+oeOiPvhjewwpNbp/8=;
        fh=APaLvcnB115qVaHHm0DXHUeBG1S4U6Yiat/uFG85dN4=;
        b=gIJiSzgfttfEF6cIanF9V5UOYZZNMs0mMUK2yWaY2MzHzShKZVVNv1/tD/GHz2rFh+
         Igm3UuO5nQgt6MROcJRFGo2ZR3BRX2wj2yjxmRcxoixWb7xMlwAXiqyN8284BrEngVhX
         xf200h2ZlfeBpoPJ9mRQ12/TZx5kEYmNMYo5KOMxZmHRhtkGfHEdWhr/MAY1xjhu8inV
         kKFPeuDY3xGopPuey1dtxmlcaEMHLxpJW9WMECRZZjAH0eFeT53KOAcc9CWw3yMLx20U
         hOyyO38j9iriRYGqmr9lPinzEmc7GnS6ZqsIwFDvyz3guo+t1RCsxChggTa8ocf8Z+w5
         Wdfg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792642336; x=1793247136; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vprUskQTUd+SPbnT8TFojrEtK+oeOiPvhjewwpNbp/8=;
        b=JStJjrH6R+2MNXjh3mBzxKtsv2HMGig9+pHzAFn5eK2OV2oiAZwz4j/366/Mw66CqE
         4osbUQLWQI06NbNgujDRdxA1zc+F7m1urrTu/otk1BydGBzgsqdSHzfRLXbIMG0fyxbX
         aMFvjFGgw6F1SFj/9Eb3pQxMqKEaubutwmJI+yMy0oNsQ4zQs22/BuZ+pI7CN55esqch
         GbJWKZbnhrJQa32D6Q97lFvwD23DPlcI1Uz6ybkDtn4vll4pguHbSwmYa7W+u1i+s0Z0
         Ss6/uQTII3JsYN6zjQjUit9Jklj9xlrB62r3gVrlEIfG/G12ugKC9Z9XViYM8JRCvjFT
         QOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792642336; x=1793247136;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vprUskQTUd+SPbnT8TFojrEtK+oeOiPvhjewwpNbp/8=;
        b=zUuSGuDvb6SRo0Xq9yAm9wHnW1TXskacRTXdiYtCS9EAeCCLu/yV9jWwX5wCRlGcf/
         XEWPjrZ+3OoIFdt/x+p0eIPNx0QbOlrAb2KnaV8xcxWrSVZDdQ/YrIPzUqy4KttQZgZo
         c68YnyXHpXQuSzDUeD4/bq6DDRPGN/ARmr60afv9iVAT0HuTgv23a1VWG7CFMR0nPqEK
         4m4xI5AID4H//hRV0fq2ygx3fdtJiUeLgSMqIP1ySIwFEGMnN3REgHKS/cAJiiSN3egt
         9I0XDqjliBWNSYu6mv2mn1mYSc3M8/QWQovLIsuh9YvFbdjQD6fEu/p+ClqkE6y7fJER
         Nc8A==
X-Forwarded-Encrypted: i=1; AKwUvBxdV1MYnZUhsEbtfb8ZLubcI3sLOkmx1dYPlErKdmD3yLVQywpqZvRBGuxTdx3vYZaJm/l1cA==@lists.infradead.org
X-Gm-Message-State: AFq9FYJNVH1IiR47qzxI+Gpf1kHIEfiIx2a6hDJawgCbumUDI7PHPCL9
	dLuOD/RabiKbuoSNJo+2LHAAMMKkiVf/HCmLx+HHLIDtxsThNHITUFqhcWIPEx2/2N+udzgoTYP
	tNevU4IgFVuBkW7ALCxOYT/mHTFjytLEbZDfL3XmfXQ==
X-Gm-Gg: AYBFou38AxMWuOKKCYZ3S+kwCSlGqUe9moeK92utPjNVZUbTBccnTiR9lDZ+NxPiaRB
	oKymaBZ9I+Wm/BxIoYoNyIY+t6ymDQQ5irxpai3FKvd/yBQxdzmFWvPYKR+n7GnGM/xTz0f8rw4
	x719dAt5fwEFrIa+wB96IkGMaXrBGn7kp4UVvyLy9BqChthXbrZ8LUiP3tB3etC6m/99qNaxM8S
	dOEiTgsnwO7tqC4K6xCMYODVbdqB7XAUTPwjpLNCK9bXBqZrj2VIAkkysRFcw+6rEOUq3ScjADA
	8Li+6Bt4vG2SMmwexyK8AZklT69wGMGc4eRM71utjIhMGipFj/JXRN7ZfnQf4QfYMffAVbnZ/+S
	ryZd5OVyeCFJ+jfKs4C73tc9kkIqQ3tjhIpkfdf+blkAS72hPFo9KQXS1+V5oTtUMV3xMEaxnit
	28vzkcHRY4K2C5I+VN6T+35UeyLmU=
X-Received: by 2002:a05:6402:5d4:b0:6ab:e30:c9a7 with SMTP id
 4fb4d7f45d1cf-6b408e80bddmr3221542a12.10.1792642335878; Wed, 21 Oct 2026
 21:12:15 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com> <20261021152527.375070-4-tarunsahu@google.com>
 <CA+CK2bAQbmq3ArP3XMErF_8RC2CUwvgpLY0H83D0nCJTaVKYyA@mail.gmail.com>
 <9huzecdi6go0.fsf@tarunix.c.googlers.com> <CALzav=dLdJoVy=B1pv0FAurD9OhAzLSTjJNbtjTdJRmSqaB0yw@mail.gmail.com>
 <CA+CK2bAQRMAEXZyHTEuUN0_Fo59Sn0hBmYbme_J9ewjx6gPyJQ@mail.gmail.com>
 <atlKsD-aJB3mJr2j@google.com> <CA+CK2bABt4OZO31TenVF2+uBUWVwViWbvfE00=0xbAw=f7K9SA@mail.gmail.com>
 <atl7peoVHdP5hz7z@google.com> <CA+CK2bBFXnJA1kddbLKGq0DAHDgjYhsTSQQay-xeX7jJC1V_UQ@mail.gmail.com>
 <CALzav=e=ho2gVrn+7KpZ3ZyasvH2u15-pC-RSRSS7KcMfKqUJQ@mail.gmail.com>
In-Reply-To: <CALzav=e=ho2gVrn+7KpZ3ZyasvH2u15-pC-RSRSS7KcMfKqUJQ@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 22 Oct 2026 00:11:39 -0400
X-Gm-Features: AclHuK_pCDHndbxcQ4IiuuWok4wCO_ZxudIta9yn_V-W6vImOs3uvaPF1BC9RHM
Message-ID: <CA+CK2bAJo8dnTOyKMgnnMnk-SCXbTsv+JCLEOWkjyj-wqtEkHg@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20261021_211218_375996_32BBB02A 
X-CRM114-Status: GOOD (  51.99  )
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

On Wed, Oct 21, 2026 at 11:53=E2=80=AFPM David Matlack <dmatlack@google.com=
> wrote:
>
> On Wed, Oct 21, 2026 at 8:32=E2=80=AFPM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
> >
> > On Wed, Oct 21, 2026 at 10:57=E2=80=AFPM David Matlack <dmatlack@google=
.com> wrote:
> > >
> > > On 2026-10-21 09:26 PM, Pasha Tatashin wrote:
> > > > On Wed, Oct 21, 2026 at 7:28=E2=80=AFPM David Matlack <dmatlack@goo=
gle.com> wrote:
> > > > >
> > > > > On 2026-10-21 02:50 PM, Pasha Tatashin wrote:
> > > > > > On Wed, Oct 21, 2026 at 2:47=E2=80=AFPM David Matlack <dmatlack=
@google.com> wrote:
> > > > > > >
> > > > > > > On Wed, Oct 21, 2026 at 11:40=E2=80=AFAM <tarunsahu@google.co=
m> wrote:
> > > > > > > >
> > > > > > > > Pasha Tatashin <pasha.tatashin@soleen.com> writes:
> > > > > > > >
> > > > > > > > > On Wed, Oct 21, 2026 at 11:25=E2=80=AFAM Tarun Sahu <taru=
nsahu@google.com> wrote:
> > > > > > > > >>
> > > > > > > > >> LUO and its file handlers validate handed-over state wit=
h monolithic
> > > > > > > > >> compatibility strings ("luo-v5", "memfd-v2"). Any change=
 to a serialized
> > > > > > > > >> structure, even an optional additive one, must bump the =
string, which
> > > > > > > > >> breaks live update between adjacent kernels. Replace the=
 string in
> > > > > > > > >> struct luo_ser with a feature header, so that the target=
 kernel can
> > > > > > > > >> accept or reject the source kernel state per feature.
> > > > > > > > >>
> > > > > > > > >> struct luo_feature_hdr is a fixed 128-byte header: the s=
erialized
> > > > > > > > >
> > > > > > > > > This patch is all wrong; 128 bytes is far too large. For =
every _ser
> > > > > > > > > struct, we only need 8 bytes instead.
> > > > > > > >
> > > > > > > > NOO, It is not. It is intended to avoid complex mess with u=
nnecessary
> > > > > > > > over-engineering.
> > > > > >
> > > > > > 128-byte per serialized struct is not starter.
> > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > The first 4 bytes are the size, and the next 4 bytes are =
flags (i.e.,
> > > > > > > > > 30 feature flags + 2 reserved bits for flags extension). =
The last two
> > > > > > > > > bits of the flags indicate whether an extended flags fiel=
d is present.
> > > > > > > > > Each extended flags field is 8 bytes, and its last two bi=
ts indicate
> > > > > > > > > that yet another extended flags field follows.
> > > > > > > >
> > > > > > > > If we will have dynamic extension of flags, Think about thi=
s.
> > > > > > >
> > > > > > > To support dynamic extensions in a backward compatible way yo=
u want
> > > > > > > something like this:
> > > > > > >
> > > > > > > struct luo_feature_hdr {
> > > > > > >    size
> > > > > > >    flags
> > > > > >
> > > > > > __u32 size
> > > > > > __u32 flags
> > > > > >
> > > > > > >    extensions  // offset of first luo_feature_extensions (or =
0)
> > > > > >
> > > > > > __u64 extensions[0]  --> but the size should be specificed in
> > > > > > declaration macro that I showed in the next patch.
> > > > >
> > > > > I think you may have misunderstood what I meant. In my proposal,
> > > > > extensions is an offset to the first extension, not an array of
> > > > > extensions that immediately follow the header.
> > > > >
> > > > > If the extensions immediately follow the header, then the number =
of
> > > > > extensions is baked into the struct layout. Every field after the=
m sits
> > > > > at an offset that depends on how many extensions there are. If we=
 ever
> > > > > need one more extension, all the fields shift and old and new ker=
nels
> > > > > can no longer read each other's struct. That is the problem Tarun
> > > >
> > > > We can structure it cleanly by nesting the payload: something like
> > > > struct { struct header {...}h; struct serialize_data { ... }p; };
> > > > That way, the header can expand dynamically at the front, while all
> > > > fields inside `serialize_data` stay at fixed offsets relative to th=
e
> > > > start
> > > > of the payload.
> > > >
> > > > Since the header size is self-describing via continuation bits (e.g=
.,
> > > > the last two bits indicating whether another flag word follows), LU=
O
> > > > can
> > > > easily compute where the payload begins in the incoming blob. This
> > > > keeps the implementation simple, avoids linked lists of offsets.
> > >
> > > Oh interesting. I agree a dynamically sized header at the front can w=
ork
> > > and is simpler than a linked list.
> > >
> > > So the header and the payload need to be separate, and the payload is
> > > located with pointer arithmetic on the header. For example:
> > >
> > > struct luo_ser_hdr {
> > >     u32 size;    /* Size of the payload in bytes */
> > >     u32 flags;    /* Bits [31:30] indicate an extension word follows =
*/
> > >     /* u64 extension words follow while the continuation bits are set=
 */
> > > };
> > >
> > > /* Size of the header, including any extension words. */
> > > size_t luo_ser_hdr_size(const struct luo_ser_hdr *hdr);
> > >
> > > static inline void *luo_ser_payload(const struct luo_ser_hdr *hdr)
> > > {
> > >     return (void *)hdr + luo_ser_hdr_size(hdr);
> > > }
> > >
> > > On preserve:
> > >
> > >     hdr =3D kho_alloc_preserve(luo_ser_hdr_size_for(nr_ext) + sizeof(=
*ser));
> > >     luo_ser_hdr_init(hdr, sizeof(*ser), ...);
> > >     ser =3D luo_ser_payload(hdr);
> > >     ...
> > >     args->serialized_data =3D virt_to_phys(hdr);
> > >
> > > On retrieve:
> > >
> > >     hdr =3D phys_to_virt(args->serialized_data);
> > >     err =3D luo_ser_hdr_validate(hdr, ...);
> > >     if (err)
> > >         return err;
> > >
> > >     ser =3D luo_ser_payload(hdr);
> > >
> > > What would size mean in luo_ser_hdr? The size of the payload or the s=
ize
> > > of the combined luo_ser_hdr + payload. luo_ser_hdr is self describing=
 so
> > > maybe it's just the size of the payload?
> >
> > > What would size mean in luo_ser_hdr? The size of the payload or the s=
ize
> > > of the combined luo_ser_hdr + payload. luo_ser_hdr is self describing=
 so
> > > maybe it's just the size of the payload?
> >
> > Either works, but having size cover the combined hdr + payload
> > provides a few extra guarantees:
> >
> > 1. A single static_assert validates the entire serialized struct at
> > compile time, including the header and the number of ext_flags
> > elements.
> > 2. Bounds checking while traversing the header continuation bits on
> > retrieve: we can sanity-check that luo_ser_hdr_size(hdr) <=3D hdr->size
> > so we never walk past the end of the serialized blob if there is
> > memory corruption.
> >
> > If we declare the payload struct separately and pass it into the
> > macro, handlers also get a clean type for luo_ser_payload(hdr):
> >
> > #define DECLARE_LUO_SER(name, expected_size, ext_flags_count, payload_t=
ype) \
> >     struct name {                                                      =
     \
> >         __u32 size;                                                    =
     \
> >         __u32 flags;                                                   =
     \
> >         __u64 ext_flags[ext_flags_count];                              =
     \
> >         payload_type payload;                                          =
     \
> >     };                                                                 =
     \
> >     static_assert(sizeof(struct name) =3D=3D (expected_size),          =
         \
> >                   "LUO struct " #name " size mismatch!")
> >
> > For example:
> >
> > struct luo_memfd_payload {
> >     __u64 pos;
> >     __u64 size;
> > };
> >
> > DECLARE_LUO_SER(luo_memfd_ser, 24, 0, struct luo_memfd_payload);
>
> This looks pretty reasonable but I would name the payload
> luo_memfd_ser. The combined struct that DECLARE_LUO_SER() creates
> should never be used directly since the offset of the payload in that
> struct is only valid in the current kernel. So I would give that
> struct a special name that makes it obvious you shouldn't be using it.

Lets drop the fourth macro argument and generate the combined struct name:

#define DECLARE_LUO_SER(name, expected_size, ext_flags_count)              =
\
    struct name##_hdr {                                                    =
\
        __u32 size;                                                        =
\
        __u32 flags;                                                       =
\
        __u64 ext_flags[ext_flags_count];                                  =
\
        struct name payload;                                               =
\
    };                                                                     =
\
    static_assert(sizeof(struct name##_hdr) =3D=3D (expected_size),        =
    \
                  "LUO struct " #name " size mismatch!")

For example:

struct luo_memfd_ser {
    __u64 pos;
    __u64 size;
};

DECLARE_LUO_SER_HDR(luo_memfd_ser, 24, 0);

