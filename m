Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760FBC3ABBF
	for <kexec@archiver.kernel.org>; Wed,  7 May 2025 23:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fLNwEV8SgZJkGHrUBzZ9lp1C8q+dL6Ko3cbg0++18Zo=; b=JFIuAM4quNsQ896zHXuoaGrLoE
	NEDTw5peP2gJtqUFfXRFkgL13FMygvtOncAxNx7MH5wmIez4BCBw7BQ7mgrBDlG+kSjGPGhAaVSHC
	13ROlSFmLikh7DTJq0P5IN0q2UkgD7RKotIIzc71HUap8x4qOzLd2ujenk7ohF7crVm8QpI9XOgI0
	sACIdBQtpEB4IJLw7G+EJtVATcXiRmer0v5Bb94HUxCyBqPgfSkilz4dX26VKCZbmJUHktf1mOcdz
	/hK7dga/WnCIv27AUg36qarFj38E2bbdgfyDTXHvaKe83sUS7TCeGvZTEXp1sYGscRjGlAr+Vz/SG
	TMht97cQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCobD-0000000H01O-3Mtq;
	Wed, 07 May 2025 23:54:51 +0000
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCoaz-0000000H00w-0noq;
	Wed, 07 May 2025 23:54:38 +0000
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-af908bb32fdso404979a12.1;
        Wed, 07 May 2025 16:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746662076; x=1747266876; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fLNwEV8SgZJkGHrUBzZ9lp1C8q+dL6Ko3cbg0++18Zo=;
        b=EmDx6nrg3BiG3co8U4id1WAdDAkr87SuwWPCAOnB9ZF0scg24kTiCYh7cCLqB9cbjV
         M8dpVn0f2eMlyHm0LMqiWA/Ybl+Wr9GgA+duK1IKUhDxKjdB6lLFUSWDJzIR6DA42cFh
         zmsdI6fipYerXv8yUVHZjYAz+hShnowpHmDUhj51ev89kJFzqw+qA9VzLClrdhINklNk
         FkQAc71gmS7fEyR2qY55KLvCgZsAgVWScrctuvYcbR2TMbekVTk3rdKk1pAz1wXBM0aD
         kgJMyEtphXxxNkgNbEYmV5phoKJUmIQGrMoZyepKiHUFy4z9f44XzQMtaVmOuWnbRNtI
         Q2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746662076; x=1747266876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLNwEV8SgZJkGHrUBzZ9lp1C8q+dL6Ko3cbg0++18Zo=;
        b=PJ/LoME93L+6qOU0M2X3hZ4LyXbJn0zWccmCNIZPia6V35c2nS/TWzg2Q+8wliKC3W
         mO2/6z2OBDb197r3vadfaiq05S9+EQ6xQui41dukhlgd40qQHkfpDdR/KUDoymSEI+jT
         HjUvOx07zqmJbCkLluhckZuZJ3at5gH1iWX6OwYbfWbycIxTHotZ2bKoeBhKrC9xKb0e
         zN+DQtC3m4rq7e/fr7frXjXz5fcm8daq0XZXq10ADL8cQue/oPDqT2vLv+zd74y7aq2w
         fjebMiFhW5SGORViX1KTY2w3e67QmFzHGtSKDcC+/7goOqXhRdUGdAoMA5ni+IoewH2y
         gHDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWppHBo1vcGDk7VAhrGKoGTnpB9jggYhoQNl3rEj5HSrbElXxQm4DJvrPoV3U8zaI/Rcmqi4QgeLReYXg0leo9mXQ==@lists.infradead.org, AJvYcCWxoLmE0cAs5GtXERIcPYJoem6sydiWZcMCDgHjkZkEMxHjn3CcvtxhMC+FS/TmQ/qiiGYp2A==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx7+ItU9+3iodpn85jAahy8RDRV7CT5FVctSnnhh4+Src/mNoGD
	YLA7CauR+d5+V0Kzdu5mTlm7kQOH0pB18cHFlRIH5dQrfCmOvvam
X-Gm-Gg: ASbGncvLqvc8SU49op0mkj0wZnT1s0bzBfkQwScnQX7RFl34gbTxgUdeePh0EPuIBPK
	RDANhs9MQnfO8Byt0gN3tjKDw4q8NGhlGZ2nYo8PP7B3KumoyyVgK7bmJB2xD+J9E/JIjbEe/bV
	QgXwdxFHpPtVoFGNbZNHVanUp/mC9CbDra91+0uXb3o2XyhgBlWr0XsP94cTHFFqfNa2x8RIeBP
	I9W1hy9cuJoXntBSth+ZfNmGzAl74SBmpgb9iXnzylZIupnBLYacE6GNP7CAavJfaashz/LvNXS
	hcBu292vrk6nrqTUBV7BwLDrIfWxK5EqPuu04Kj/
X-Google-Smtp-Source: AGHT+IHhK4fQ0eXffxWp3og4eay8JmyRcAaEmd9mi0QFw/ybw320/zjs9kUfsYWXYw9PozpDfctKkQ==
X-Received: by 2002:a05:6a21:32a6:b0:20a:942:47e9 with SMTP id adf61e73a8af0-21599fcc6admr2320890637.6.1746662075529;
        Wed, 07 May 2025 16:54:35 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058d7a225sm11870093b3a.23.2025.05.07.16.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 16:54:34 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 5AB6041E8D47; Thu, 08 May 2025 06:54:32 +0700 (WIB)
Date: Thu, 8 May 2025 06:54:32 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Changyuan Lyu <changyuanl@google.com>, akpm@linux-foundation.org
Cc: anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com,
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com,
	corbet@lwn.net, dave.hansen@linux.intel.com,
	devicetree@vger.kernel.org, dwmw2@infradead.org,
	ebiederm@xmission.com, graf@amazon.com, hpa@zytor.com,
	jgowans@amazon.com, kexec@lists.infradead.org, krzk@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
	mark.rutland@arm.com, mingo@redhat.com, pasha.tatashin@soleen.com,
	pbonzini@redhat.com, peterz@infradead.org, ptyadav@amazon.de,
	robh@kernel.org, rostedt@goodmis.org, rppt@kernel.org,
	saravanak@google.com, skinsburskii@linux.microsoft.com,
	tglx@linutronix.de, thomas.lendacky@amd.com, will@kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v7 17/18] Documentation: add documentation for KHO
Message-ID: <aBvyuKI3i4z_3xSG@archie.me>
References: <aBl0kUIKryH5AUD5@archie.me>
 <20250507173840.2541517-1-changyuanl@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zRFld30/pgx52G1k"
Content-Disposition: inline
In-Reply-To: <20250507173840.2541517-1-changyuanl@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_165437_237679_F1C404FF 
X-CRM114-Status: GOOD (  32.51  )
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


--zRFld30/pgx52G1k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 07, 2025 at 10:38:40AM -0700, Changyuan Lyu wrote:
> From: Changyuan Lyu <changyuanl@google.com>
> Date: Wed, 7 May 2025 10:14:34 -0700
> Subject: [PATCH] fixup! Documentation: add documentation for KHO
>=20
> Signed-off-by: Changyuan Lyu <changyuanl@google.com>
> ---
>  Documentation/admin-guide/mm/kho.rst    | 29 ++++++++++---------------
>  Documentation/core-api/kho/concepts.rst |  4 ++--
>  Documentation/core-api/kho/fdt.rst      |  2 +-
>  3 files changed, 15 insertions(+), 20 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/mm/kho.rst b/Documentation/admin-g=
uide/mm/kho.rst
> index c64aa7aadb300..6dc18ed4b8861 100644
> --- a/Documentation/admin-guide/mm/kho.rst
> +++ b/Documentation/admin-guide/mm/kho.rst
> @@ -8,14 +8,14 @@ Kexec HandOver (KHO) is a mechanism that allows Linux t=
o preserve memory
>  regions, which could contain serialized system states, across kexec.
>=20
>  This document expects that you are familiar with the base KHO
> -:ref:`concepts <concepts>`. If you have not read
> +:ref:`concepts <kho-concepts>`. If you have not read
>  them yet, please do so now.
>=20
>  Prerequisites
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> -KHO is available when the ``CONFIG_KEXEC_HANDOVER`` config option is set=
 to y
> -at compile time. Every KHO producer may have its own config option that =
you
> +KHO is available when the kernel is compiled with ``CONFIG_KEXEC_HANDOVE=
R``
> +set to y. Every KHO producer may have its own config option that you
>  need to enable if you would like to preserve their respective state acro=
ss
>  kexec.
>=20
> @@ -29,7 +29,7 @@ Perform a KHO kexec
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>  First, before you perform a KHO kexec, you need to move the system into
> -the :ref:`KHO finalization phase <finalization_phase>` ::
> +the :ref:`KHO finalization phase <kho-finalization-phase>` ::
>=20
>    $ echo 1 > /sys/kernel/debug/kho/out/finalize
>=20
> @@ -43,7 +43,7 @@ use the ``-s`` parameter to use the in-kernel kexec fil=
e loader, as user
>  space kexec tooling currently has no support for KHO with the user space
>  based file loader ::
>=20
> -  # kexec -l Image --initrd=3Dinitrd -s
> +  # kexec -l /path/to/Image --initrd /path/to/initrd -s
>    # kexec -e
>=20
>  The new kernel will boot up and contain some of the previous kernel's st=
ate.
> @@ -89,20 +89,15 @@ stabilized.
>      as input file for the KHO payload image.
>=20
>  ``/sys/kernel/debug/kho/out/scratch_len``
> -    To support continuous KHO kexecs, we need to reserve
> -    physically contiguous memory regions that will always stay
> -    available for future kexec allocations. This file describes
> -    the length of these memory regions. Kexec user space tooling
> -    can use this to determine where it should place its payload
> -    images.
> +    Lengths of KHO scratch regions, which are physically contiguous
> +    memory regions that will always stay available for future kexec
> +    allocations. Kexec user space tools can use this file to determine
> +    where it should place its payload images.
>=20
>  ``/sys/kernel/debug/kho/out/scratch_phys``
> -    To support continuous KHO kexecs, we need to reserve
> -    physically contiguous memory regions that will always stay
> -    available for future kexec allocations. This file describes
> -    the physical location of these memory regions. Kexec user space
> -    tooling can use this to determine where it should place its
> -    payload images.
> +    Physical locations of KHO scratch regions. Kexec user space tools
> +    can use this file in conjunction to scratch_phys to determine where
> +    it should place its payload images.
>=20
>  ``/sys/kernel/debug/kho/out/sub_fdts/``
>      In the KHO finalization phase, KHO producers register their own
> diff --git a/Documentation/core-api/kho/concepts.rst b/Documentation/core=
-api/kho/concepts.rst
> index f1826ac10da75..36d5c05cfb307 100644
> --- a/Documentation/core-api/kho/concepts.rst
> +++ b/Documentation/core-api/kho/concepts.rst
> @@ -1,5 +1,5 @@
>  .. SPDX-License-Identifier: GPL-2.0-or-later
> -.. _concepts:
> +.. _kho-concepts:
>=20
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  Kexec Handover Concepts
> @@ -56,7 +56,7 @@ for boot memory allocations and as target memory for ke=
xec blobs, some parts
>  of that memory region may be reserved. These reservations are irrelevant=
 for
>  the next KHO, because kexec can overwrite even the original kernel.
>=20
> -.. _finalization_phase:
> +.. _kho-finalization-phase:
>=20
>  KHO finalization phase
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/Documentation/core-api/kho/fdt.rst b/Documentation/core-api/=
kho/fdt.rst
> index 4a5d53c670d4b..62505285d60d6 100644
> --- a/Documentation/core-api/kho/fdt.rst
> +++ b/Documentation/core-api/kho/fdt.rst
> @@ -32,7 +32,7 @@ KHO process will be bypassed.
>  Property ``fdt``
>  ----------------
>=20
> -Generally, A KHO user serialize its state into its own FDT and instructs
> +Generally, a KHO user serialize its state into its own FDT and instructs
>  KHO to preserve the underlying memory, such that after kexec, the new ke=
rnel
>  can recover its state from the preserved FDT.
>=20

Looks good.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--zRFld30/pgx52G1k
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaBvyuAAKCRD2uYlJVVFO
o38OAP0S2nuy3loMuC8zH7tkpPoIY66aWe/gz0KYX9I9KbADyAEAiwNKd6K9jY8l
qW+w4NnoiMRcH659o8/VFU3sEV3Tegw=
=bbPy
-----END PGP SIGNATURE-----

--zRFld30/pgx52G1k--

