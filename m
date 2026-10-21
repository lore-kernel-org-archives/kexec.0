Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ECC606A335
	for <kexec@archiver.kernel.org>; Wed, 21 Oct 2026 23:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=VlL+oYzy;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=jJKVNY3z;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=aSF4ybT+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7nCAo4+9lz8Iyt19nkj9TmOxKkMhE+NTyi1XeRL1MPk=; b=VlL+oYzy99UuBbASvchVw4Bi7p
	XmoH676Ek9JGYLd3wvPrUU8nzBFT98sBYGBqUZtu5gDY28hCrUSxB3LHyLaNIe0p21wJcfzQrDWlJ
	PeamFS6LO1JTU9e5N/m3ZuHxqEvB9ai3Jju9dsWHzuwkEbJB78UEZg3oslg7teYECuXPJvt3obGMP
	Hor7uEdpIKDPxKK+9twptmIpeuqLXwreJxdp5omFnD/hnB9GwV04DKoDz1yj5CxGmuJXGyJuoCQBO
	+pySJIW5IA58oWBOoedZ0cjVcNh7iURFXMY9v7F+Q7zUXgpxqovO2mcikUTPW3grjtN5ljkEjx3iS
	oXbd4eZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJfZi-0000000D1dW-0Bki;
	Wed, 21 Oct 2026 23:18:26 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJfZg-0000000D1cv-1JJf
	for kexec@bombadil.infradead.org;
	Wed, 21 Oct 2026 23:18:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=7nCAo4+9lz8Iyt19nkj9TmOxKkMhE+NTyi1XeRL1MPk=; b=jJKVNY3zJ6FUDrrQk/ko01QZIQ
	ilbo0WNU9RA5mNbwO5RHrP6EZsm0K/ZbdJ/60RP3Ze4Uyb55BbA+R6xGTjZmg5crOGfEa9tclrpuN
	Yh9TqHlIDHMWoM6e0tG2LszcfP1ry7WSnxP7GzSCuCasJPaBlYPfhFag2OO9vMmOp5W6/I3tfWxrH
	4ImXI+9rgtzSa0Iev7s4g0gjNCzQBQfXr8QffBYCBOU/H2Kk1bU2HtOC4naD/cTHi//5iZa7qjnGz
	7TOLyOAVpqkJ2APoBdfgMYKpMDMrHJOCX7vNKWxBjPkMiJK/ERIEVw8MTBeOJv83D22BtIG7YLgMC
	XCtFe6HQ==;
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xJfZd-00000006JGl-0SO3
	for kexec@lists.infradead.org;
	Wed, 21 Oct 2026 23:18:23 +0000
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so408606a12.0
        for <kexec@lists.infradead.org>; Wed, 21 Oct 2026 16:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792624698; x=1793229498; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7nCAo4+9lz8Iyt19nkj9TmOxKkMhE+NTyi1XeRL1MPk=;
        b=aSF4ybT++WiMsTkWWZZmGBUlM+TeKoCuwk6gj0dnrtXWeHfXgb8lIA0Icbj34lpn5P
         lencCGbzpDH4SzLdM+m6pWKQcTblqTpJJKrKo69aZyBbwT7s7N7EOfrm1IXTbe8r6qHK
         uHszdLHjGpnTkFAx54MMKY77uO/c+15hCeeRdY07KU74zDldKRqjJ7xF4f72WxpA7Urq
         5JE2pvAk1ZNfzYeDts6Y2yjvxOjq3TKWl5fAfx1gddhQTDTmXVY/P9j5Iuv455a9M+8U
         biOsSfLin6gwrH3gdyBpLNA9cqv1Hm/ZpLxZJXT/EhIJIimEq9K7fNAaQkeNqqPMyWLp
         q2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792624698; x=1793229498;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7nCAo4+9lz8Iyt19nkj9TmOxKkMhE+NTyi1XeRL1MPk=;
        b=b27/GuWXb74MxPAdqOX+MP1YHOIUFxw0llxl41MFyHedjevZgAp5yLcsdh3BuWTX7O
         JxpvLCTMCLs66USzkUiw/g9PaxC3vY1FAkXoTX4RYs8FumjXPifeVyM0ksv5/CnLy63J
         5neR44dagbPp6KzOuTqWsl/raSTHf97kKrZv7yrivdriCv+dau5UILOgE+RVHDBcWu4B
         sbHfEFABaeD5uD1NY78/mqXZN82t+KS/ouMwi1d2s9ZrhjZQB8XffuLyXh7pbAKEGpJj
         Sd3sEEsvIsjdmln0lqZZ/3dXLQnJXMVA99+/Qoe2F4Z4gd0dcSZgeIIsvjRk2lbGEM4B
         yxYg==
X-Forwarded-Encrypted: i=1; AKwUvBwDQPB9aXSCIBlJP/u0qa0wndWnsqQCFJpBdoPtsHBpK/DNAU71SMiyOi/llJSjH6Cs27IFdA==@lists.infradead.org
X-Gm-Message-State: AFq9FYIRfZ8CkpL2p16x/93VDrhqxFPLcGgXYHGN57Dj2YhpiqOtv4Y/
	F9QFgjKOFMhrsLXTu+bOEz9Z3toNS1UIYKPu+uRNg3bj5uX7Xz6fxbVHAxciQmwlMQ==
X-Gm-Gg: AYBFou07G19ClWR3Sne1qZ+WIeNsoGeRj/2M0tAO+jU1dQH9alijBy4dmsyM7gLS2Mt
	T1cj+pUleb8tU5QGUD/rYF0urNZBg5b3NcNqHMOhttsenSPWwWOickIOzL9W4ezw1R2ULifbAKM
	189v6TiUZ2a0cGPtHXP+B/9MPXW0iIaXK1HYN8w/N8K5QkMi84lyFwuKOlOjsYW1w0g5P6ztbVe
	YtjE+c66WarXMQDyhj6/mqQbGHZXKu2u03QTd1Oy1/g5f9iKvZvKVOXlAgqgbt9PfFgTJkil52B
	amDz0hmLWsR2wQIDDWxnlSXe+XdvfFODNxa2ejGl5GfiViqBCc1H4FB/4kFBg+AmG5WIDBTw0U+
	gyiRDuNB3zW+nXtvhWvGIX2srbIHkZuLaYoiYjy31QYcRPbcUEhI9SPEUiOoBi3FDW4lnFsBIL3
	ofp75vNzw7oMKZyFwRW3q5YaXJRY+xap0bzgeLenv4nn51SodeiF0f+vAkY4m0kg3pHxPv6MlIz
	Zwz5Aw8fuJI7Zd3hDbtd+pYxBqeNaQ7UbQ18YCVXpEd/sZ5QPjVon01pEjZ0R3KAiqJBvHJULCe
	HBq3UC7+NAKc5IWlc0VlDSWtMLlPB4kX43h/NQ==
X-Received: by 2002:a17:90b:3c8d:b0:3ac:7f4c:a690 with SMTP id 98e67ed59e1d1-3ad86eeb9e6mr2442353a91.35.1792624697709;
        Wed, 21 Oct 2026 16:18:17 -0700 (PDT)
Received: from google.com (64.75.127.34.bc.googleusercontent.com. [34.127.75.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad85f62d22sm3123694a91.4.2026.10.21.16.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 16:18:16 -0700 (PDT)
Date: Wed, 21 Oct 2026 23:18:13 +0000
From: David Matlack <dmatlack@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Tarun Sahu <tarunsahu@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de,
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com,
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org,
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com,
	will@kernel.org, Alexander Graf <graf@amazon.com>,
	Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	kexec@lists.infradead.org, skhawaja@google.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 4/4] mm: memfd_luo: Add the 2-bit pair feature
 header
Message-ID: <atlINfvlXY4wMbpO@google.com>
References: <20261021152527.375070-1-tarunsahu@google.com>
 <20261021152527.375070-5-tarunsahu@google.com>
 <CA+CK2bCWo7ixrNLKPvqETn3JSFwSNaB2UsPgy9RHVAhWroJURQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bCWo7ixrNLKPvqETn3JSFwSNaB2UsPgy9RHVAhWroJURQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261022_001821_435053_6F4F0615 
X-CRM114-Status: GOOD (  51.20  )
X-Spam-Score: -15.7 (---------------)
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
X-Spam-Status: No, score=-23.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-21 01:38 PM, Pasha Tatashin wrote:
> On Wed, Oct 21, 2026 at 11:25 AM Tarun Sahu <tarunsahu@google.com> wrote:
> >
> > Embed the fixed-size 128-byte struct luo_feature_hdr at the start of
> > struct memfd_luo_ser and define enum memfd_luo_feature
> > (MEMFD_LUO_FEAT_CORE and MEMFD_LUO_FEAT_MAX) for memfd preservation.
> >
> > All current struct memfd_luo_ser fields (pos, size, seals, flags,
> > nr_folios, folios) and MEMFD_LUO_ALL_SEALS belong to
> > MEMFD_LUO_FEAT_CORE (LUO_FEAT_REQUIRED in memfd_luo_features). Future
> > changes add new entries to enum memfd_luo_feature before
> > MEMFD_LUO_FEAT_MAX and append any new fields to the end of struct
> > memfd_luo_ser so existing field offsets never shift.
> >
> > Signed-off-by: Logan Odell <loganodell@google.com>
> > Signed-off-by: Tarun Sahu <tarunsahu@google.com>
> > ---
> >  include/linux/kho/abi/memfd.h | 35 ++++++++++++++++++++++++++++++-----
> >  mm/memfd_luo.c                | 14 ++++++++++++++
> >  2 files changed, 44 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/kho/abi/memfd.h b/include/linux/kho/abi/memfd.h
> > index 371ffd108a79..f0b5235a408d 100644
> > --- a/include/linux/kho/abi/memfd.h
> > +++ b/include/linux/kho/abi/memfd.h
> > @@ -13,6 +13,7 @@
> >
> >  #include <linux/types.h>
> >  #include <linux/kho/abi/kexec_handover.h>
> > +#include <linux/kho/abi/luo.h>
> >
> >  /**
> >   * DOC: memfd Live Update ABI
> > @@ -21,11 +22,20 @@
> >   * reboot using the LUO.
> >   *
> >   * The state is serialized into a packed structure `struct memfd_luo_ser`
> > - * which is handed over to the next kernel via the KHO mechanism.
> > + * which is handed over to the target kernel via the KHO mechanism.
> >   *
> > - * This interface is a contract. Any modification to the structure layout
> > - * constitutes a breaking change. Such changes require incrementing the
> > - * version number in the MEMFD_LUO_FH_COMPATIBLE string.
> > + * This interface is a contract. `struct memfd_luo_ser` starts with a fixed
> > + * 128-byte `struct luo_feature_hdr`. The relative order and offsets of
> > + * fields must remain unchanged as features are added or retired: new fields
> > + * are appended at the end of `struct memfd_luo_ser` under a new feature
> > + * flag in `enum memfd_luo_feature` (before `MEMFD_LUO_FEAT_MAX`), and
> > + * retired fields are kept in place so subsequent offsets never shift. In
> > + * the target kernel, fields of a `LUO_FEAT_REQUIRED` feature are guaranteed
> > + * present once `luo_feature_hdr_validate()` succeeds, whereas fields of a
> > + * `LUO_FEAT_OPTIONAL` feature should be accessed only after checking
> > + * `luo_feature_is_active()`. All current fields (`pos`, `size`, `seals`,
> > + * `flags`, `nr_folios`, `folios`) and `MEMFD_LUO_ALL_SEALS` belong to
> > + * `MEMFD_LUO_FEAT_CORE` (`LUO_FEAT_REQUIRED` in `memfd_luo_features`).
> >   */
> >
> >  /**
> > @@ -58,7 +68,7 @@ struct memfd_luo_folio_ser {
> >
> >  /*
> >   * The set of seals this version supports preserving. If support for any new
> > - * seals is needed, add it here and bump version.
> > + * seals is needed, gate them behind a new feature flag.
> >   */
> >  #define MEMFD_LUO_ALL_SEALS (F_SEAL_SEAL | \
> >                              F_SEAL_SHRINK | \
> > @@ -67,8 +77,22 @@ struct memfd_luo_folio_ser {
> >                              F_SEAL_FUTURE_WRITE | \
> >                              F_SEAL_EXEC)
> >
> > +/**
> > + * enum memfd_luo_feature - Feature indices for &struct memfd_luo_ser.
> > + * @MEMFD_LUO_FEAT_CORE: Core feature covering `pos`, `size`, `seals`, `flags`,
> > + *                       `nr_folios`, `folios`, and %MEMFD_LUO_ALL_SEALS.
> > + * @MEMFD_LUO_FEAT_MAX:  Number of defined &enum memfd_luo_feature features.
> > + */
> > +enum memfd_luo_feature {
> > +       MEMFD_LUO_FEAT_CORE = 0,
> > +       MEMFD_LUO_FEAT_MAX,
> > +};
> > +
> > +static_assert((int)MEMFD_LUO_FEAT_MAX <= LUO_FEAT_MAX);
> > +
> >  /**
> >   * struct memfd_luo_ser - Main serialization structure for a memfd.
> > + * @features:  ABI feature and size header for memfd_luo_ser.
> >   * @pos:       The file's current position (f_pos).
> >   * @size:      The total size of the file in bytes (i_size).
> >   * @seals:     The seals present on the memfd. The seals are uABI so it is safe
> > @@ -79,6 +103,7 @@ struct memfd_luo_folio_ser {
> >   *             struct memfd_luo_folio_ser.
> >   */
> >  struct memfd_luo_ser {
> > +       struct luo_feature_hdr features;
> 
> I have not looked into this yet, but I would prefer to use some kind
> of macro constructor for serialized structs. That way, they will
> automatically include the header, making it easier to search the code
> for what is actually preserved versus what exists only in this kernel.

If you want to know what is preserved don't you just look at
include/linux/kho/abi?

> 
> So, I think something like this:
> /* Base serialization header: 4 bytes total size, 4 bytes flags */
> struct luo_ser_hdr {
>     __u32 total_size;

Why do we need the size? I'm not really opposed to it I just don't
understand what problem it solves.

The luo_ser_hdr is needed for top-level file handler and FLB ser
structs. Those structs are always dynamically allocated and preserved
with KHO.

On retrieve, KHO gives you back the blob of memory. You look at the
header to determine what features are used in the struct, and then
access the fields associated with those features. At no point do you
need to check the size.

The only time you need the size is for a KHO block array. You want to
store the size of the KHO block array elements so that the retrieving
kernel can correctly initialize the iterator.

e.g. from the PCI base series:

/**
 * struct pci_ser - PCI Subsystem Live Update State
 *
 * This struct tracks state about all devices that are being preserved across
 * a Live Update for the next kernel. It contains only state owned by the PCI
 * core; the state a driver needs to resume its device is preserved separately
 * by that driver.
 *
 * @required_flags: Features that the next kernel must support to take over
 *                  the preserved devices. No flags are currently defined.
 * @optional_flags: Features that the next kernel may ignore if it does not
 *                  support them. No flags are currently defined.
 * @dev_ser_size: The size in bytes of each struct pci_dev_ser in @devices.
 * @nr_devices: The number of devices that were preserved.
 * @devices: Physical address of the first KHO block containing pci_dev_ser.
 */
struct pci_ser {
	u64 required_flags;
	u64 optional_flags;
	u32 dev_ser_size; <==========
	u32 nr_devices;
	u64 devices;
};

>     __u32 flags;
> };
> 
> #define LUO_SER_INIT_HDR(obj, _flags) do {           \
>     (obj)->hdr.total_size = sizeof(*(obj));          \
>     (obj)->hdr.flags = (_flags);                     \
> } while (0)
> 
> #define DECLARE_LUO_SER(name, expected_size, members)       \
>     struct name {                                           \
>         struct luo_ser_hdr hdr;                             \
>         members                                             \
>     };                                                      \
>     static_assert(sizeof(struct name) == (expected_size),   \
>                   "LUO struct " #name " size mismatch!")

Why?

Practically every change to a serialized struct is going to involve
appending one or more fields to the end of the struct. Asserting the
size means we have to update the hard-coded size as well every time we
do that.

Is this to protect against embedded structs accidentally changing?

> 
> Usage:
> /*
>  * Header:  8 bytes (hdr: 4 bytes total_size + 4 bytes flags)
>  * Payload: 8 (pos) + 8 (size) + 4 (seals) + 4 (_pad) = 24 bytes
>  * Total:   32 bytes
>  */
> DECLARE_LUO_SER(memfd_luo_ser, 32,
>     __u64 pos;
>     __u64 size;
>     __u32 seals;
>     __u32 _pad;
> );

IMO this makes the code harder to read. I think open coding keeps things
simpler.

struct pci_ser {
	struct luo_ser_hdr header;
	__u32 dev_ser_size;
	__u32 nr_devices;
	__u64 devices;
};
LUO_SER_ASSSERT_SIZE(pci_ser, 32);

> 
> struct memfd_luo_ser *ser;
> ...
> LUO_SER_INIT_HDR(ser, 0);
> 
> Thanks,
> Pasha
> 
> >         u64 pos;
> >         u64 size;
> >         u32 seals;
> > diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
> > index 64f8b8cb75bd..ea1f4c8cd259 100644
> > --- a/mm/memfd_luo.c
> > +++ b/mm/memfd_luo.c
> > @@ -84,6 +84,10 @@
> >
> >  #include "internal.h"
> >
> > +static const u8 memfd_luo_features[MEMFD_LUO_FEAT_MAX] = {
> > +       [MEMFD_LUO_FEAT_CORE] = LUO_FEAT_REQUIRED,
> > +};
> > +
> >  static int memfd_luo_preserve_folios(struct file *file,
> >                                      struct kho_vmalloc *kho_vmalloc,
> >                                      struct memfd_luo_folio_ser **out_folios_ser,
> > @@ -284,6 +288,8 @@ static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
> >                 goto err_free_ser;
> >         }
> >
> > +       luo_feature_hdr_init(&ser->features, sizeof(*ser),
> > +                            memfd_luo_features);
> >         ser->pos = args->file->f_pos;
> >         inode_size = i_size_read(inode);
> >
> > @@ -525,6 +531,14 @@ static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
> >         if (!ser)
> >                 return -EINVAL;
> >
> > +       err = luo_feature_hdr_validate(&ser->features, memfd_luo_features);
> > +       if (err) {
> > +               pr_err("memfd_luo_ser feature header validation failed (size=%llu, flags[0]=%#llx): %pe\n",
> > +                      ser->features.size, ser->features.flags[0],
> > +                      ERR_PTR(err));
> > +               goto free_ser;
> > +       }
> > +
> >         /* Make sure the file only has seals supported by this version. */
> >         if (ser->seals & ~MEMFD_LUO_ALL_SEALS) {
> >                 err = -EOPNOTSUPP;
> > --
> > 2.56.0.212.g129ede20d9-goog
> >

