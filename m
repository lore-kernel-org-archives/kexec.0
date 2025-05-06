Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF225C3ABBC
	for <kexec@archiver.kernel.org>; Tue,  6 May 2025 05:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=poh4flnsblOTuXQPZPNN2P3hxWXnOplQoLoK9Oy5wOo=; b=T4N0oscgjbB//+/UdKytJfLXlh
	tPn+HB+IBUS2JlMn52R1/Oz2jckxTzeKTI8eZWawOUiPEqtdxwrqDBvFMnd1PinjHfCcHQwwnYW9L
	yhKbOAqVNnlgiWSUoYoh/ruCEuVgT5q0STRiSO8egUYagLXFLiapSQzzzNaGIi3UiVmimQz/UxlaW
	TyJqgfHhg2heyZTiVQYBdGxqrRQBbs5PiKOt7D6WGLSdl8U3BBz1M+OKrx23FYL+7UXjTZJcLv9Kc
	6qsTaV6nKSEhFMLKneU8mTF9eCz7i8TNuOAvM+Q0ix7p3vTRnwe96S+CsmnUfArhAeUvgo502mYtz
	USV79o9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCAr0-0000000ARWm-1A21;
	Tue, 06 May 2025 05:28:30 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC863-00000009lpr-3kCa;
	Tue, 06 May 2025 02:31:53 +0000
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-736b0c68092so4481384b3a.0;
        Mon, 05 May 2025 19:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746498710; x=1747103510; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=poh4flnsblOTuXQPZPNN2P3hxWXnOplQoLoK9Oy5wOo=;
        b=jgKVbMUMMMd5eHO3MsgLImFIztlllvq08alEGpSj9QDoIcvy5VEsvi8578JTcviIH5
         RwoMDkz0sEIYd9Oi9KSPy4PL4MYAyOGT7CeMB3UMWV9i7OxjBLNW/K6UT8yB76U4oLhp
         mmtvpkTtETJOOcVZw0wH9QuMM36YpiikUA4j1rN7czW5ObFzOhhA3av1YqHx9ZAni8bu
         2IauC6FWzDIrpkHiUz1rnY5hPJm8mLVFqeb7dBtn5JkQSzNW2HOQFmDSvEukVYoUj5sB
         9F0MX161eHltLq2WKmtaCXB0FTno4yjSZoSKj9OlzNEBNproE+QQOih01br2XSvUwUjc
         nS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746498710; x=1747103510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=poh4flnsblOTuXQPZPNN2P3hxWXnOplQoLoK9Oy5wOo=;
        b=idRu4vajzDjAyb7r3Zj07bjX61ei2rP0qRrpY7SlJFIDQNSDT0JfLkh8L0q+fVNUKR
         /55zW6CX8KYxlOMzfwb3UEvr+p/NX/ESjlKchdTYpQM4eCRm/27VTEQx9LkjqQg82QG+
         QRiB6tSryjdRP/UU/vBxQ8vBmfMzZVzokojtnhU2jgCg9MAL4jVg7edmfUD5WNAKrT20
         M2RSoptWSgm0koXObwq2kkw/WIUNx4XYYyxg0NlHoDb/dWBQRwJgoUFViE4NO+vCBwr8
         40vgAc2EWvcDhY5xr6lHMUapcuQYxPj8SunOn0RI5JHO8ttv6iGda9IHdsR+IAgnVX2Q
         yTHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6qCKHJ+jG0axc3MLOyJOOEGdKD5cW5kN7ETkYF6nENfQdMPLUimApOVojmOZ07FpvbGBGOdVAwzmkRdbBhnbeVA==@lists.infradead.org, AJvYcCX/nxJo/GwHtdF4DHqW3hwwdid7qHqUZrrGtYJG4MmuP5W5+Llz7KHxDT1Cphhas+SiD12uGw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz9qdGEokGCUfp62xMcrErr9FK+cHJI4Lz4BAmwiFRyfoDXksqn
	2Z7S/Mk5nVoaFxicuv5PYXB3J1G5IsdpERAHcIQx8sVVyye9u0J+
X-Gm-Gg: ASbGnctVqzAB5leOKYO6JPtNJLsrpFfeg0U7Zez3n93YI+udz24WCRzua2x19n7Heik
	f+cwGKj+03x7hEIOzXy08HwElVCGN3egWnEBXuPI3PRedmDDFapGk1KYq48QAjYPGGo6zAkLExq
	Zct0OlerU7/g3ViY8kMXGpEAdU3h0Q/qK7qCyMcsUKJ6TxR9IrFWI9V6hueCBzHkx+wns1mcUng
	1jLrmu8JoDBKbYMuEOdmGsjmJk6TfWZvToZpEpYKjSkgJ/pvwB9VufUFncRtMugVkTi3XSQ4+HX
	O2/HQNSL7Iv4UxM3f/VuCybeVE/wKS8pZPZmN9LE
X-Google-Smtp-Source: AGHT+IFm2DxJzuwGUz6BKAo8aCcTy5T+PX1t2f2NG17JtptJTbCdw+A9Vy7/npC+48IEhStxuhVLiA==
X-Received: by 2002:a05:6a00:4294:b0:736:6ecd:8e32 with SMTP id d2e1a72fcca58-74058b23ef3mr18912149b3a.21.1746498710367;
        Mon, 05 May 2025 19:31:50 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058dbbb15sm7939011b3a.58.2025.05.05.19.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 19:31:49 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 3FFBD42439E4; Tue, 06 May 2025 09:31:45 +0700 (WIB)
Date: Tue, 6 May 2025 09:31:45 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Changyuan Lyu <changyuanl@google.com>, linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, anthony.yznaga@oracle.com, arnd@arndb.de,
	ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de,
	catalin.marinas@arm.com, corbet@lwn.net,
	dave.hansen@linux.intel.com, devicetree@vger.kernel.org,
	dwmw2@infradead.org, ebiederm@xmission.com, graf@amazon.com,
	hpa@zytor.com, jgowans@amazon.com, kexec@lists.infradead.org,
	krzk@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
	mark.rutland@arm.com, mingo@redhat.com, pasha.tatashin@soleen.com,
	pbonzini@redhat.com, peterz@infradead.org, ptyadav@amazon.de,
	robh@kernel.org, rostedt@goodmis.org, rppt@kernel.org,
	saravanak@google.com, skinsburskii@linux.microsoft.com,
	tglx@linutronix.de, thomas.lendacky@amd.com, will@kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v7 17/18] Documentation: add documentation for KHO
Message-ID: <aBl0kUIKryH5AUD5@archie.me>
References: <20250501225425.635167-1-changyuanl@google.com>
 <20250501225425.635167-18-changyuanl@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7/7+Tnuu7kTtOC0+"
Content-Disposition: inline
In-Reply-To: <20250501225425.635167-18-changyuanl@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_193151_937091_353C07B2 
X-CRM114-Status: GOOD (  21.00  )
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


--7/7+Tnuu7kTtOC0+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 01, 2025 at 03:54:24PM -0700, Changyuan Lyu wrote:
> +This document expects that you are familiar with the base KHO
> +:ref:`concepts <concepts>`. If you have not read
The reference label is generic and can collide with future patches.
It should've been disambiguated as kho_concepts instead.
> +them yet, please do so now.
> +
> +Prerequisites
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +KHO is available when the ``CONFIG_KEXEC_HANDOVER`` config option is set=
 to y
> +at compile time. Every KHO producer may have its own config option that =
you
when the kernel is compiled with ``CONFIG_KEXEC_HANDOVER`` set to y.
> +need to enable if you would like to preserve their respective state acro=
ss
> +kexec.
> +
> <snipped>...
> +First, before you perform a KHO kexec, you need to move the system into
> +the :ref:`KHO finalization phase <finalization_phase>` ::

kho_finalization_phase to disambiguate label.

> +Next, load the target payload and kexec into it. It is important that you
> +use the ``-s`` parameter to use the in-kernel kexec file loader, as user
> +space kexec tooling currently has no support for KHO with the user space
> +based file loader ::
> +
> +  # kexec -l Image --initrd=3Dinitrd -s
> +  # kexec -e

Use full paths to kernel and initramfs image.

> +``/sys/kernel/debug/kho/out/scratch_len``
> +    To support continuous KHO kexecs, we need to reserve
> +    physically contiguous memory regions that will always stay
> +    available for future kexec allocations. This file describes
> +    the length of these memory regions. Kexec user space tooling
> +    can use this to determine where it should place its payload
> +    images.

"Length of KHO scratch region, which is a physically contiguous memory regi=
ons
that will always available for future kexec allocations. Kexec user space
tools can use this file to determine where it should place its payload imag=
es."

> +
> +``/sys/kernel/debug/kho/out/scratch_phys``
> +    To support continuous KHO kexecs, we need to reserve
> +    physically contiguous memory regions that will always stay
> +    available for future kexec allocations. This file describes
> +    the physical location of these memory regions. Kexec user space
> +    tooling can use this to determine where it should place its
> +    payload images.

"Physical location of KHO scratch region. Kexec user space tools can use th=
is
file in conjunction to scratch_phys to determine where it should place its
payload images."

> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +.. _concepts:

The label can be ambiguous. It should've been _kho_concepts instead.

> +.. _finalization_phase:

The label should be _kho_finalization_phase.

> +Generally, A KHO user serialize its state into its own FDT and instructs
"Generally, a KHO user ..."
> +KHO to preserve the underlying memory, such that after kexec, the new ke=
rnel
> +can recover its state from the preserved FDT.
> +

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--7/7+Tnuu7kTtOC0+
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaBl0iQAKCRD2uYlJVVFO
oy/8AP48Fa7VB0kwt+kqGg4VMR/+tEgBDGxzTX5HXZWYD5fZLQEAm6XrPJBViu5A
Mpce1oumgUOmlwq+sRSgixha15i4eAo=
=lxMZ
-----END PGP SIGNATURE-----

--7/7+Tnuu7kTtOC0+--

