Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1D4606A31E
	for <kexec@archiver.kernel.org>; Thu, 22 Oct 2026 00:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Jv2Eyl9K;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=DiXbNk9s;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=KZ+VB7Ek
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GniLS46Pd/diYcFVcDjCnHYBi+2sUltr0IiHdgmwVU0=; b=Jv2Eyl9KByQLJ+sJ6hP8GpyiLr
	XkroGrLVHpxtVlpr2XxGb+9w0goRLHOJGfYmThCnElALnBlKHdCn5HUzFmf2nCvX6y586/QnuDCPF
	xK0XT3lr13NopJuF+HyUED+2XkB/mjym0E5nOeVdUVptmSL5Vmth+gn685rPwKhwdfUrSSJp+N5hN
	r0udy73dhzS1zGtoExUswXAq3aIgK4vdF/mPTAGD7Rl/Z597TxrSow3/hi9FRMZ27y963Kw6kZbzM
	d7wK/VXiF2q9U4ae+IvFUgaY14YBH5fL76jdUZBPTQcjCVqjKPcBztHHH/+g0xbQxtqCH0gaQkLBL
	bCV+JwJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJgtJ-0000000D6vE-1FZU;
	Thu, 22 Oct 2026 00:42:45 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJgtH-0000000D6uX-2Osr
	for kexec@bombadil.infradead.org;
	Thu, 22 Oct 2026 00:42:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:Subject:Message-ID:
	Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GniLS46Pd/diYcFVcDjCnHYBi+2sUltr0IiHdgmwVU0=; b=DiXbNk9sTN5Jq5e92OJbspe+ch
	f74YyBLxbA8hiwXAGV+EN/cyskLQOlixpGhgJEa8ipivtvTbRXnrG1XFKexgv9fy/ZwzjcUmMM+YR
	TqqR4o9o3eZH7FY12tI8e5266ThR00kdnGsTghKWainiHIIRDntBFP+7VRuzI62BXYdmo8Qobcukt
	7JkBCHS1FgIjM3IeWMlcbG0hL3xAJdBKhcEC7tQIKwa056SSvkhNRwWmS5WVr5+R7PmYuFAugKT4h
	U4xdgKzIRLHiURhLOt1PDhafs/pb6qzE+hdf4AJtwGVBX7pxgQuTV29MWYctkoWz/eAayPvBER2vU
	+VFSH1hQ==;
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xJgtC-00000006Lbs-2q6b
	for kexec@lists.infradead.org;
	Thu, 22 Oct 2026 00:42:41 +0000
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-6b203527bceso1810828a12.0
        for <kexec@lists.infradead.org>; Wed, 21 Oct 2026 17:42:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792629757; cv=none;
        d=google.com; s=arc-20260327;
        b=obmgT9lfx1K74KkcHJL2mPVqDApAz4gXC1Df+dIaQwUq7Y0p5YAAHERm0rMBP9sTNH
         3/BpnfIsu1CFNbadWnyhBMDKnIr3GwuxXIEFHwuiBr5TLoGrRslnxCkRNXZZsk4DUcRC
         jPa9erLF3z6/86gjGxDh1o4t4GdDaDxBurnw60T9mY6hObZXIXB3LRKUAo7+wF0QOxbO
         tYFTSXXHBrODieqquI1O2HPFUMPbZjcGOBOHJZpmEmXvRf6DHMgfISUrx0Uk5PL7TBiI
         8QVtviC8raEaYPfUokVTvztLEJQKPZZtSCAnapwsPVsJ0uaQ5EonSa6lu1OqRscPbLCG
         Y5qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GniLS46Pd/diYcFVcDjCnHYBi+2sUltr0IiHdgmwVU0=;
        fh=6lz+Wdy47Yq+bhOH43QcwFKwbjMm0CUvlQUFA7+qOYY=;
        b=bESJDks4nFkddMdYJwgDcGRGw+Uw0Iryq1VG3Uf+TmgCvav9xddfZdJKMtiaZfBIEz
         x2/ymqFZcsPwSY+rj7Yd8LR0mPj14Cgs3xnpWZ7i0Oi47gFwWcIY2f5Oh8YBYINQO/oZ
         1K0LkKq+Pm0txcfntubPmyhnTo6sOdA+/bOcszoBPafK84cb6yUGZLmqEIfS511yWc5L
         m0SjK51nZWCwkSWeFvMrzZhyqnEUI/ieatZJO3OOQDR4YDWv1Dvit6klHft8d2kwKtil
         QVyqT0EVJB8XoUFjiwBN+wSWOZ7AXt4p42w4BXzDrQZWrWrT5jhAxB23l+eXU+y1ZjLh
         Yn6Q==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792629757; x=1793234557; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GniLS46Pd/diYcFVcDjCnHYBi+2sUltr0IiHdgmwVU0=;
        b=KZ+VB7Ekwv5PewDfeNoeAeFmKD/kZwlb8EIPVAnVC1zfkOP8pqCuof9bdAxol4DW8x
         n6TrvFq+/jmdQv0YIegAnbIE/+pNn84kqdqTc8eao0pRZLB2zypNpdN4eYmgmPfPttBQ
         eFTG+tL3RsbnMaqrMuhWlHLB2BvJg1U02awV+Njn7QFKW5oC3yt/lW0bun6skjvpYDkX
         xfzekPJY7+2UBTvK3trakD8EAvgFOwdmyO6mATXeWFYyEML3JW18OFyPqS7Ea2cLVjt4
         quO4MmZagMRgA+lZZtxsUSylRNncBgLqU5q/7NDMqx38Y2bEPNMzxDAhGCtmTwDFcon8
         66/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792629757; x=1793234557;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GniLS46Pd/diYcFVcDjCnHYBi+2sUltr0IiHdgmwVU0=;
        b=CRJpp1qB/eseO+O4QX/EBvmiC8AOgTi+d85bcJp/bD4MyRrVWawVAtGFqN83NlfMFe
         4dzqzuxSyynDVWwurExkPuhVIL4eveeoNU1/w9Yzy2cNHhZoKnz2ENUtVHbDjRe/+K4v
         yAWMaNvMHLobMWSELRh7wAXjbkfCWH/GNybYhgbv4dEqqmQy9W48VsqAC8McGUjMYklB
         J7esDILwIpHpAT8jirASzG33ntJ9CuWqi4GXtvicwPpAFXwdvxCi6+JFUd0+8/CDq7xR
         fyrJ2YVDrPZBhKJZoKf7+/QjeM4mlfC4fv2Cc7s3kWvP3SGtARACKYmVGVSJasqvhLcO
         OECA==
X-Forwarded-Encrypted: i=1; AKwUvByHiQwbjLAYiDj2U/gqnVde0EwkvjrmqAXBQ8GIeAKJCgfHdM7jzFRVs5kzoyUC7qqjwmuGdQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYLHJBPrMmT3KA9B//zSnCcBN6aI69QzBptWxIi6QPM8q93+mk+o
	h+Klo1itDfC+9UHPcj9sRWSDNUngNubFZSSTAFGr+1RwDowzj8uB5g9A3KnLcjpWbvC9bUH/ZPZ
	gl/Mr2USwuL8Ne41rWHuu/tzSyWyXslhdLa9KRT2+Cg==
X-Gm-Gg: AYBFou3qtoBftvE+MGktqoENdBzCkc1djg5sSEnaLGJ1VUih0gPClBY1KShI9Ktx0B4
	SWSAccNG9B6hcCT1l/2itZ4YJ8sKBspNfKhM0+MWXmjY2tiZgtweZ+/bSsw/eOc2/LDWd2MOIx9
	MtatzXVvPC2dw8N7vwaeEh4abPHa2y3we+5blJgDt2Osh87BWETLkKo+MXD5JIJdnLUCob6B/f6
	t8JNzZ5oJ02LUHGuAOYmjGwoBfBHXqiukBhjsjVVdKVaCwsbpRUUqA5hY3BMK9cHDGhLDrkX8TY
	MDPcLEULZyMX/vHwq7uwDO4IDhm+DB3mKxJ/uPcPWClrRi1RaWEN1cQFxdZL6Yi9lVaTIt8HUf0
	84qvWylZLnVdS5j+jR+pnWbjTsF66EUu+3L7XR0AwqCmYwOdqcnpAlomDsHTUku+9kS6CU8AfjR
	5+8wAk0N7r20jJ
X-Received: by 2002:a05:6402:28c3:b0:6b1:b5ea:2580 with SMTP id
 4fb4d7f45d1cf-6b408f158c0mr2564977a12.44.1792629756618; Wed, 21 Oct 2026
 17:42:36 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com> <20261021152527.375070-5-tarunsahu@google.com>
 <CA+CK2bCWo7ixrNLKPvqETn3JSFwSNaB2UsPgy9RHVAhWroJURQ@mail.gmail.com> <atlINfvlXY4wMbpO@google.com>
In-Reply-To: <atlINfvlXY4wMbpO@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Oct 2026 20:41:59 -0400
X-Gm-Features: AclHuK9RD7eBi8LXJX6p9TV9aNPWci2BfQZ8v_Dy1k8oV1MBnEFNI7PYFBzBpTQ
Message-ID: <CA+CK2bDf-pKbH2J13mRYRT7Ddj-Q+VXaGYePs+E-azSWXKzV5w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/4] mm: memfd_luo: Add the 2-bit pair feature header
To: David Matlack <dmatlack@google.com>
Cc: Tarun Sahu <tarunsahu@google.com>, Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
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
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261022_014239_855980_3D64F67A 
X-CRM114-Status: GOOD (  54.87  )
X-Spam-Score: -0.2 (/)
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> > >  /**
> > >   * struct memfd_luo_ser - Main serialization structure for a memfd.
> > > + * @features:  ABI feature and size header for memfd_luo_ser.
> > >   * @pos:       The file's current position (f_pos).
> > >   * @size:      The total size of the file in bytes (i_size).
> > >   * @seals:     The seals present on the memfd. The seals are uABI so it is safe
> > > @@ -79,6 +103,7 @@ struct memfd_luo_folio_ser {
> > >   *             struct memfd_luo_folio_ser.
> > >   */
> > >  struct memfd_luo_ser {
> > > +       struct luo_feature_hdr features;
> >
> > I have not looked into this yet, but I would prefer to use some kind
> > of macro constructor for serialized structs. That way, they will
> > automatically include the header, making it easier to search the code
> > for what is actually preserved versus what exists only in this kernel.
>
> If you want to know what is preserved don't you just look at
> include/linux/kho/abi?

Yes, and having it initialized and declared in the code correctly with
proper macros and verified just gives the right handling and avoids
making silly mistakes. The second reason is so we never forget to
include the header, and to make it expandable and easy for everyone to
use. I think this kind of constructor is just useful overall. Are
there any reasons why we wouldn't want to use it?

> > So, I think something like this:
> > /* Base serialization header: 4 bytes total size, 4 bytes flags */
> > struct luo_ser_hdr {
> >     __u32 total_size;
>
> Why do we need the size? I'm not really opposed to it I just don't
> understand what problem it solves.
[...]
> The luo_ser_hdr is needed for top-level file handler and FLB ser
> structs. Those structs are always dynamically allocated and preserved
> with KHO.

The top level is not enough. I think it is needed for every single
serialized struct in kho/abi - the blocks, the FLBs, etc. They all
must
be expandable in case we need to allow that. Let's have future
protection for everything that gets preserved.

For example, take a look at vCPU preservation:
https://lore.kernel.org/all/20260920193650.3373435-9-pasha.tatashin@soleen.com
https://lore.kernel.org/all/20260920193650.3373435-11-pasha.tatashin@soleen.com

+struct kvm_vcpu_ser {
+    u32 vcpu_id;
+    u32 flags;
+    u64 vm_token;
+    DECLARE_KHOSER_PTR(arch_state, struct kvm_vcpu_arch_ser *);
+};

We might want to add fields to the arch-independent part, and we also
absolutely must keep the arch-dependent parts expandable. Therefore,
the header needs to stay small and flexible enough to grow as needed.

> On retrieve, KHO gives you back the blob of memory. You look at the
> header to determine what features are used in the struct, and then
> access the fields associated with those features. At no point do you
> need to check the size.
>
> The only time you need the size is for a KHO block array. You want to
> store the size of the KHO block array elements so that the retrieving
> kernel can correctly initialize the iterator.
>
> e.g. from the PCI base series:
>
> /**
>  * struct pci_ser - PCI Subsystem Live Update State
>  *
>  * This struct tracks state about all devices that are being preserved across
>  * a Live Update for the next kernel. It contains only state owned by the PCI
>  * core; the state a driver needs to resume its device is preserved separately
>  * by that driver.
>  *
>  * @required_flags: Features that the next kernel must support to take over
>  *                  the preserved devices. No flags are currently defined.
>  * @optional_flags: Features that the next kernel may ignore if it does not
>  *                  support them. No flags are currently defined.
>  * @dev_ser_size: The size in bytes of each struct pci_dev_ser in @devices.
>  * @nr_devices: The number of devices that were preserved.
>  * @devices: Physical address of the first KHO block containing pci_dev_ser.
>  */
> struct pci_ser {
>         u64 required_flags;
>         u64 optional_flags;
>         u32 dev_ser_size; <==========
>         u32 nr_devices;
>         u64 devices;
> };

Having `total_size` embedded in the standard header of every
serialized struct solves this uniformly: any struct can be placed in a
block array without needing an ad-hoc `*_ser_size` field in the parent
struct, and on retrieve we can always sanity-check that the preserved
blob is at least as large as the struct fields implied by the flags.

>
> >     __u32 flags;
> > };
> >
> > #define LUO_SER_INIT_HDR(obj, _flags) do {           \
> >     (obj)->hdr.total_size = sizeof(*(obj));          \
> >     (obj)->hdr.flags = (_flags);                     \
> > } while (0)
> >
> > #define DECLARE_LUO_SER(name, expected_size, members)       \
> >     struct name {                                           \
> >         struct luo_ser_hdr hdr;                             \
> >         members                                             \
> >     };                                                      \
> >     static_assert(sizeof(struct name) == (expected_size),   \
> >                   "LUO struct " #name " size mismatch!")
>
> Why?
>
> Practically every change to a serialized struct is going to involve
> appending one or more fields to the end of the struct. Asserting the
> size means we have to update the hard-coded size as well every time we
> do that.
>
> Is this to protect against embedded structs accidentally changing?
>

Yes, exactly. See how kvm_vcpu_arch_ser is proposed in that same series:

+struct kvm_vcpu_arch_ser {
+    struct kvm_regs regs;
+    struct kvm_sregs sregs;
+    struct kvm_mp_state mp_state;
+    u32 pad;
+    struct kvm_xcrs xcrs;
+    struct kvm_lapic_state lapic;
+    u8 pad_xsave[40];
+    struct kvm_xsave xsave;
+    struct kvm_vcpu_events events;
+    struct kvm_debugregs debugregs;
+    u32 num_msrs;
+    u32 cpuid_nent;
+    struct kvm_msr_entry msrs[];
+};

All the above structs are uAPI, so they are stable compared to random
kernel structs, but they still have a size and can be expanded. So,
having the size and a static assert guarantees that when we expand
these uAPI structs, we automatically catch that in this struct and add
the appropriate flag to notify the next kernel of the changed world.
Also, it catches implicit compiler padding changes across
architectures.

> >
> > Usage:
> > /*
> >  * Header:  8 bytes (hdr: 4 bytes total_size + 4 bytes flags)
> >  * Payload: 8 (pos) + 8 (size) + 4 (seals) + 4 (_pad) = 24 bytes
> >  * Total:   32 bytes
> >  */
> > DECLARE_LUO_SER(memfd_luo_ser, 32,
> >     __u64 pos;
> >     __u64 size;
> >     __u32 seals;
> >     __u32 _pad;
> > );
>
> IMO this makes the code harder to read. I think open coding keeps things
> simpler.

I am ok switching to a different construct or way of declaring these
structs if what I proposed is hard to read. However, we still need
standardization so that every serialized struct has a common,
expandable header (taking only 8 bytes by default), has its size
verified at both compile time and runtime, and is initialized in a
uniform way.

>
> struct pci_ser {
>         struct luo_ser_hdr header;
>         __u32 dev_ser_size;
>         __u32 nr_devices;
>         __u64 devices;
> };
> LUO_SER_ASSSERT_SIZE(pci_ser, 32);
>
> >
> > struct memfd_luo_ser *ser;
> > ...
> > LUO_SER_INIT_HDR(ser, 0);
> >
> > Thanks,
> > Pasha
> >
> > >         u64 pos;
> > >         u64 size;
> > >         u32 seals;
> > > diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
> > > index 64f8b8cb75bd..ea1f4c8cd259 100644
> > > --- a/mm/memfd_luo.c
> > > +++ b/mm/memfd_luo.c
> > > @@ -84,6 +84,10 @@
> > >
> > >  #include "internal.h"
> > >
> > > +static const u8 memfd_luo_features[MEMFD_LUO_FEAT_MAX] = {
> > > +       [MEMFD_LUO_FEAT_CORE] = LUO_FEAT_REQUIRED,
> > > +};
> > > +
> > >  static int memfd_luo_preserve_folios(struct file *file,
> > >                                      struct kho_vmalloc *kho_vmalloc,
> > >                                      struct memfd_luo_folio_ser **out_folios_ser,
> > > @@ -284,6 +288,8 @@ static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
> > >                 goto err_free_ser;
> > >         }
> > >
> > > +       luo_feature_hdr_init(&ser->features, sizeof(*ser),
> > > +                            memfd_luo_features);
> > >         ser->pos = args->file->f_pos;
> > >         inode_size = i_size_read(inode);
> > >
> > > @@ -525,6 +531,14 @@ static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
> > >         if (!ser)
> > >                 return -EINVAL;
> > >
> > > +       err = luo_feature_hdr_validate(&ser->features, memfd_luo_features);
> > > +       if (err) {
> > > +               pr_err("memfd_luo_ser feature header validation failed (size=%llu, flags[0]=%#llx): %pe\n",
> > > +                      ser->features.size, ser->features.flags[0],
> > > +                      ERR_PTR(err));
> > > +               goto free_ser;
> > > +       }
> > > +
> > >         /* Make sure the file only has seals supported by this version. */
> > >         if (ser->seals & ~MEMFD_LUO_ALL_SEALS) {
> > >                 err = -EOPNOTSUPP;
> > > --
> > > 2.56.0.212.g129ede20d9-goog
> > >

