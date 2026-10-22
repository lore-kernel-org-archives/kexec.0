Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF8D606A319
	for <kexec@archiver.kernel.org>; Thu, 22 Oct 2026 03:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=F6kw+g7J;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=L7uUhps3;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=cycTq64r
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3R15WlwvcCDjwHgI3tMxUhnF1Vz0ctYaUW1v5Utzjsw=; b=F6kw+g7JFTsB3al+oUIqApOQUC
	Kf4r76uVbMqzPy/F+zQ0QP2fLLyvrL/4PwddeN3iO5BXYNhJLNvW0ZnkS6B0bahiI3yJQGQTxmXlv
	KyC+2XTH/Ee8qH0X1prn8pH0NWPUDCCEvJRh7OvWFNF+EN3JahHycweY8EdIvqqQcKRDEbwJarV2X
	MYVWokyGYIU/0ErjaW33PajyU3yNKBs8AHc8cPHX6KVpHTT9iDxE10RcyaAlCeA4/fmICLoBM1v2s
	z4EZ/4bL+u22K1Az/TZMAsucYlbYoKssig/QixTOCiJ3Ziun0zNU0YwRQnwg56/xo+p06I3SIl8Gr
	ZuPeTGrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJjq2-0000000DISa-0svn;
	Thu, 22 Oct 2026 03:51:34 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJjq0-0000000DIS4-10PK
	for kexec@bombadil.infradead.org;
	Thu, 22 Oct 2026 03:51:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=3R15WlwvcCDjwHgI3tMxUhnF1Vz0ctYaUW1v5Utzjsw=; b=L7uUhps3NrDWJvWK7Ap7rnmitU
	Abov3T5NoTtrIcGmSvxOXvbGp3YKOXycZUi9HvwfuDrhSic533cuxu5wsv6SUKWGGOIDgj5XoJkN+
	HtGaauycLsbqvebv/d/Snu8RLCQMgkaqOzi07GyAWXoPGmT1SaeR+P91sWA5/E9Prqlr/Qbvcj+Sl
	i+c6o51prTyHKZ0V6z1oeWk25mW5Srgbh6WgZIjaPfBXrcB+0FdjEUtlMQTzzFpkBaB5fDtPyGxkO
	TR9VX2ucaCX/7QbWzbJs21wHnYa9cyQDauFvxc2tuKoY96THK0vhktzJmUwGcVMtPs+Zm0tNup4Bm
	VZX9zzOQ==;
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xJjpv-00000006RHU-16PA
	for kexec@lists.infradead.org;
	Thu, 22 Oct 2026 03:51:30 +0000
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-6b21cf1a580so1405454a12.1
        for <kexec@lists.infradead.org>; Wed, 21 Oct 2026 20:51:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792641086; cv=none;
        d=google.com; s=arc-20260327;
        b=je+LubI+5MPIwTebaw5LwDhQBXhrJvX9Wzm/iZ5/DYYCiNDTWNa59arvIB043BDnTu
         RGooDJB3ubjucetjU0yNYQP6ULigiekoeVj848vTM5LbXQJTqBsX7bCEw4BDp4Io8x+5
         yOJdJt6X92BrZLkNBrGOttANCK74Wp+Sn5mo6KLCvZho4Vs1y7BsTh5+bYS3yOL3rSeU
         o+wnwkXyB9tMrQNAlqkJpHbQMnGpVxCGWm/+igZEYGFL20kFzd3NolnOpKyozM5UHxF1
         7u2jVW7HKNbpwqwA4ehT+Zv+asTqTym6S8dCjtWDBrsWUhCdMXwOU5fn1sUl2ysNOioW
         g52A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3R15WlwvcCDjwHgI3tMxUhnF1Vz0ctYaUW1v5Utzjsw=;
        fh=9Mz3pxKGhyfy6+NgdMRpSXXMGjjsG6u5VGKqF2moYPg=;
        b=XmXQ7KFiR05WjWCAZI4cKZKfO8EtM0jGKsR8ZLUp40AxhDpFDs5wQ16oZqZq8sS7LK
         ybKPQ0aTLP+lnRH6JAExjg/7uj/DSXy/1Tar3hYHMcY2y2yielLxEzsoL5x5+aLGp6C7
         DM7eLDn8k6AL+0WILtE1wwz2ZB6NacL0pAWtZxco5UG6ROy5ZbRt+/NyVLgbhh3jxtrR
         53jD7FkBVdZsa0PeaQFXZNcajTq36XZ7Tbzj5gN7nl4K9a75DYT/prUS2FkAXOxOGbXN
         /fFpq5hgZiCwkyYbwM/521AmVEz3DdiD/bGPv5+GLDn8br9W9kF3VRYEFCgs8M8Zb3Tx
         SqNg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792641086; x=1793245886; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3R15WlwvcCDjwHgI3tMxUhnF1Vz0ctYaUW1v5Utzjsw=;
        b=cycTq64ryGIfyKFPs9JcBA4ApNg5QkRxHD18PAkH5AazCu0fxAse4godECiF0kNbRx
         l71ARQmEjNnVmPQstMgJ2A4PILe9f4Y1pkAz1vhq4NIeNNpnOGC7mpm2KlI4V3Ols3Wy
         ahfB574mtOBeRd0dj2ONJj7e4HldYub8b+I9I7A80pinKy8v3UYwoVAuWDg9nSDNFqPA
         dVSa7rDyXthOWm8K260blkLpCDtZuW4LMIEoKtRRbJ1T4v7SjcJvkHgLyOrwiPCG2Shw
         2rOb56XYhREfYRQAX9c28tcmCuBCyNdI8FI0+OOlkOZjxWttAFtxaJHpeG7b3GpGMXDA
         e7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792641086; x=1793245886;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3R15WlwvcCDjwHgI3tMxUhnF1Vz0ctYaUW1v5Utzjsw=;
        b=OhVf2nhgiHabCygRPPZMuDNbjWgiYd1EivHylKx+lCYCeh0EYeza8JjcT2Vmkt5QPL
         Gs4V18HmGuk3yHeDT818jdq48zhzLEPpoMnk7Ar/jOMRuqbIOZSZEZCA5PSlSM3DIfVA
         5h5zokRZVGiMMog3bWRHssrbtU/CzXdcAMN8tD/YbuGLcWBcL/sXXIdqZl2zcrI61dYN
         k29aFmlGCvKpbbaARJVMFwIAbYIVJ4UVAK0ke5oEiVIxzazq86gOrL38gqXmJG17EbGH
         NR06hNnYEfk1Tofu+sTLhih7Gr6okCr93xXaniGFK533xg7ZeVo03XvsVPe6ncdeoGZi
         7pvQ==
X-Forwarded-Encrypted: i=1; AKwUvByffT8onpfodv9JPVBozi3Y29ip/LCtclQfQoUoqkS0XqIS+5vIGHOFvu2eWXItaxzOlMebfA==@lists.infradead.org
X-Gm-Message-State: AFq9FYITN+k48FVEYxY+wDrXNNy8jrsKTUBRXCPyTj5y4jycQrGueXj0
	96P/vdzNjZ++YsR7+oqY9Kj4F7E111lgqpy0ESsDAhfmWr6PeWMKAJ6FpmsJM6Is5oj8S+CrU+s
	PEwYt6P3SWc/drirFPtJ5s7XoJ2NioJ7UP7bZCet6wQ==
X-Gm-Gg: AYBFou2+J+LS/yoX48J6gFlN76/WLy8qkkOZE1t1q96tyUzNzAuMDRq7j/WIytyZY2N
	+dLYn+chAmcg6fC2ROgIN6a9ACM1on7O9Ghs1Sf4piOhTu0Lj4xTIA/fBCQKykHQGjmAZF1xkXE
	r0J+drb3Y6GSLgUpceTPG6W3uyn7rn/+fTwSkX8JDPJjkRRW0/qJ7L3fIjg3ntYUsBHGvOgUvd1
	6tddcK6mJ9ZxYSKdqkVRq6BNshMmrVSKUuSpQ7f5w1PdtFezWj1eERRgn2s0FzxAQQ4QQJPSPGh
	MXRuLiGm0Exvpy4mVPe6T3hLCy3amV4mZkvmeeonN/qrRFWGSJADwHpNUrC1+EXij43164xU3t8
	d+U0pMwjZ7VAtSMrCpL/bxvZGpQtGZ8EeVZxZIRpXGVVgXcLHChwLSP4J0QjigqpVxew=
X-Received: by 2002:a05:6402:400b:b0:6b4:2185:7147 with SMTP id
 4fb4d7f45d1cf-6b4218572dbmr568868a12.15.1792641085570; Wed, 21 Oct 2026
 20:51:25 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com> <20261021152527.375070-5-tarunsahu@google.com>
 <CA+CK2bCWo7ixrNLKPvqETn3JSFwSNaB2UsPgy9RHVAhWroJURQ@mail.gmail.com>
 <atlINfvlXY4wMbpO@google.com> <CA+CK2bDf-pKbH2J13mRYRT7Ddj-Q+VXaGYePs+E-azSWXKzV5w@mail.gmail.com>
 <atl6K2Juy6Bh29lh@google.com>
In-Reply-To: <atl6K2Juy6Bh29lh@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Oct 2026 23:50:49 -0400
X-Gm-Features: AclHuK9es7KH6zjO9m5YDGIDDY6Onq6kZ5W4q1tuNZUyMat9PK3sQU18xuWoZac
Message-ID: <CA+CK2bB9xoAWP0kC+KtXeDTdwt0kWqb-PLHN=6DsA=mnRpMfxA@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261022_045127_507694_3EB2579B 
X-CRM114-Status: GOOD (  42.34  )
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 10:51=E2=80=AFPM David Matlack <dmatlack@google.com=
> wrote:
>
> On 2026-10-21 08:41 PM, Pasha Tatashin wrote:
> > > > >  /**
> > > > >   * struct memfd_luo_ser - Main serialization structure for a mem=
fd.
> > > > > + * @features:  ABI feature and size header for memfd_luo_ser.
> > > > >   * @pos:       The file's current position (f_pos).
> > > > >   * @size:      The total size of the file in bytes (i_size).
> > > > >   * @seals:     The seals present on the memfd. The seals are uAB=
I so it is safe
> > > > > @@ -79,6 +103,7 @@ struct memfd_luo_folio_ser {
> > > > >   *             struct memfd_luo_folio_ser.
> > > > >   */
> > > > >  struct memfd_luo_ser {
> > > > > +       struct luo_feature_hdr features;
> > > >
> > > > I have not looked into this yet, but I would prefer to use some kin=
d
> > > > of macro constructor for serialized structs. That way, they will
> > > > automatically include the header, making it easier to search the co=
de
> > > > for what is actually preserved versus what exists only in this kern=
el.
> > >
> > > If you want to know what is preserved don't you just look at
> > > include/linux/kho/abi?
> >
> > Yes, and having it initialized and declared in the code correctly with
> > proper macros and verified just gives the right handling and avoids
> > making silly mistakes. The second reason is so we never forget to
> > include the header, and to make it expandable and easy for everyone to
> > use. I think this kind of constructor is just useful overall. Are
> > there any reasons why we wouldn't want to use it?
> >
> > > > So, I think something like this:
> > > > /* Base serialization header: 4 bytes total size, 4 bytes flags */
> > > > struct luo_ser_hdr {
> > > >     __u32 total_size;
> > >
> > > Why do we need the size? I'm not really opposed to it I just don't
> > > understand what problem it solves.
> > [...]
> > > The luo_ser_hdr is needed for top-level file handler and FLB ser
> > > structs. Those structs are always dynamically allocated and preserved
> > > with KHO.
> >
> > The top level is not enough. I think it is needed for every single
> > serialized struct in kho/abi - the blocks, the FLBs, etc. They all
> > must
> > be expandable in case we need to allow that. Let's have future
> > protection for everything that gets preserved.
> >
> > For example, take a look at vCPU preservation:
> > https://lore.kernel.org/all/20260920193650.3373435-9-pasha.tatashin@sol=
een.com
> > https://lore.kernel.org/all/20260920193650.3373435-11-pasha.tatashin@so=
leen.com
> >
> > +struct kvm_vcpu_ser {
> > +    u32 vcpu_id;
> > +    u32 flags;
> > +    u64 vm_token;
> > +    DECLARE_KHOSER_PTR(arch_state, struct kvm_vcpu_arch_ser *);
> > +};
> >
> > We might want to add fields to the arch-independent part, and we also
> > absolutely must keep the arch-dependent parts expandable. Therefore,
> > the header needs to stay small and flexible enough to grow as needed.
>
> Hm, anything that is dynamically allocated can have it, but anything
> that it is embedded directly or in an array cannot, because those
> structs cannot grow anyway. So I agree it's not exclusive to the
> top-level FLB and FH structs. But I would push back on any a mandate
> that _every_ struct in include/linux/kho/abi needs it.

OK, we should *aspire* to convert as many serialized structs as
possible to the versioned format by default, and require a very strong
justification for any exceptions (such as tightly packed arrays or
block set entries). Even in those cases, we should be certain that
omitting
the header saves meaningful memory and that we are not shooting
ourselves in the foot if we later decide to replace those container
primitives or need to evolve the entries independently.

Right now, shared serialized primitives like kho_vmalloc and
kho_block_header_ser do not have proper versioning at all, and because
they are used by many clients, updating them is already problematic.
We can't simply rely on top-level FH flags to version everything:
since these primitives are shared across handlers, any change to them
would otherwise require updating every FH that uses them.

BTW, since these primitives live in KHO and all the ABI headers are in
include/linux/kho/abi/, perhaps this header format, versioning, and
the declaration macros should be part of KHO rather than LUO (e.g.,
struct kho_ser_hdr and DECLARE_KHO_SER)? Then LUO would just focus
exporting FD preservation-capabilities to userspace, as it deals only
with FDs, not internal representation. There should also be a global
switch that shows the KHO version the kernel is using, perhaps via
sysfs.

