Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE61E606A31C
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 06:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=AQ0m7M7c;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TJ19gYVp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=cs0evi9dVSmKWqiPi75Cnylb6/Wxv9tJ6r+A8LIBuRE=; b=AQ0m7M7chdsRu0ymr6UbvzAHQJ
	5kvmZEIBFZRQHBNfWsNm4tMCm7g/PdvX2TZFlg6V7otFlu351lbFe0ZG2lrWgJq8H46syzTGZcl3N
	C5zFLawyn5olBcvUPMMYlMBU/GKOTM+zgVqNjTAFFXzk+ugTsHUZ/K8NHzEsDMyLHQM4CXtBMgn4L
	zDLnL8XSPjlj9Z2sP747Q+G3rp8Le7dAJrkwM+7aodDY4aqQBeYkdWcfsYsH8QZlV5RvfxbkwgHdB
	K6/NAwtD6cIGVP2DO53ZSC94EPfvfqQW8VQaTUB4AvXMfPeusppNAwsxdlr5QNV2IVMMPf0XglyT4
	GjW32+Uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR1de-00000005jJa-1deo;
	Wed, 11 Nov 2026 06:16:54 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR1dc-00000005jHv-31Zb
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 06:16:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7466444880;
	Wed, 11 Nov 2026 06:16:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E6A1F00A11;
	Wed, 11 Nov 2026 06:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794377812;
	bh=cs0evi9dVSmKWqiPi75Cnylb6/Wxv9tJ6r+A8LIBuRE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TJ19gYVponJXD+6bXVDXHTYShKtvx4kcBfVwQuS7qpbOzWRj8Pp+US+SAxz+Udt0Q
	 svT7zXCMBNACh8E1zYYtOhtP9+zlXPJtNcVsiM03nuZVZoz5nqfBwsj+3GD6N0k5NZ
	 sRnybVSechBWdKccJWIc2b+VF88rIjd4wikq3LoCuAKD4JiN/Lo1S8bDqCEB48nAl/
	 xn/xBGef74dOtIMPWFnhCYH1ClDI3VARcH4/lPQ94XXZGeZd8zdNYdIGE+xYO/ajVm
	 jLOxNdr10MlfUw+3DdwrRxoUo7o/5FkniBmLmn2RYbgz5Yjb4OfmpvIfDucaGGLNEf
	 u4DA/vs9XvuGg==
Message-ID: <sashiko-outbox-208417@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 14/19] liveupdate: Add feature header to struct
 luo_flb_ser
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org, will@kernel.org, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, "Bjorn
 Helgaas" <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, gle.com@google.com, pbonzini@redhat.com, "Andrew
 Morton" <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: kvmarm@lists.linux.dev, linux-pci@vger.kernel.org, "Pratyush Yadav" <pratyush@kernel.org>, kexec@lists.infradead.org, kvm@vger.kernel.org, skhawaja@google.com, sagis@google.com, linux-mm@kvack.org
In-Reply-To: <20261110050202.529473-15-tarunsahu@google.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-15-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:16:50 +0000
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] liveupdate: -EOPNOTSUPP collision in luo_flb_retrieve_one()
  on validation
--

commit f2fc7f3d05b147a7eeaad5c4521b29383721337e
Author: Tarun Sahu <tarunsahu@google.com>

liveupdate: Add feature header to struct luo_flb_ser

This commit adds a struct kho_ser_hdr feature header to each serialized
struct luo_flb_ser entry and validates each entry header during retrieval
in luo_flb_retrieve_one().

> diff --git a/kernel/liveupdate/luo_flb.c b/kernel/liveupdate/luo_flb.c
> index a8dcdb8456fd2..d38c223741ff4 100644
> --- a/kernel/liveupdate/luo_flb.c
> +++ b/kernel/liveupdate/luo_flb.c
[ ... ]
> @@ -177,10 +178,18 @@ static int luo_flb_retrieve_one(struct liveupdate_f=
lb *flb)
>  	if (!fh->active)
>  		return -ENODATA;
> =20
> -	for (int i =3D 0; i < fh->header_ser->count; i++) {
> -		if (!strcmp(fh->ser[i].name, flb->compatible)) {
> -			private->incoming.data =3D fh->ser[i].data;
> -			refcount_set(&private->incoming.count, fh->ser[i].count);
> +	for (u64 i =3D 0; i < fh->header_ser->count;
> +	     i++, fhdr =3D (void *)fhdr + fhdr->size) {
> +		struct luo_flb_ser *ser;
> +
> +		err =3D kho_ser_validate(fhdr, luo_flb_ser);
> +		if (err)
> +			return err;
> +
> +		ser =3D kho_ser_payload(fhdr, luo_flb_ser);
> +		if (!strcmp(ser->name, flb->compatible)) {
> +			private->incoming.data =3D ser->data;
> +			refcount_set(&private->incoming.count, ser->count);
>  			found =3D true;
>  			break;
>  		}

[Severity: Medium]
Does returning -EOPNOTSUPP from kho_ser_validate() collide with the
-EOPNOTSUPP return value that liveupdate_flb_get_incoming() uses to
indicate that Live Update is disabled?

When an incoming struct luo_flb_ser entry has an unsupported required
feature bit set, kho_ser_validate() returns -EOPNOTSUPP, which
liveupdate_flb_get_incoming() propagates to callers:

drivers/pci/liveupdate.c:pci_liveupdate_flb_get_incoming() {
	...
	ret =3D liveupdate_flb_get_incoming(&pci_liveupdate_flb, (void **)&incomin=
g);

	/* Live Update is not enabled. */
	if (ret =3D=3D -EOPNOTSUPP)
		return NULL;
	...
}

Instead of panicking on incompatible incoming state, the PCI subsystem
treats Live Update as disabled and proceeds with normal enumeration over
preserved devices.

Also, kho_ser_validate() runs on every entry before checking ser->name, so
an unsupported required feature on an earlier entry fails lookups for later
compatible FLBs, and returning before refcount_set(&private->incoming.count,
ser->count) leaves private->incoming.count at 0, which underflows in
liveupdate_flb_put_incoming() during luo_file_finish().  Validating all
luo_flb_ser entries up front in luo_flb_setup_incoming() (or translating
the validation error code) would avoid both issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110050202.5294=
73-1-tarunsahu@google.com?part=3D14

