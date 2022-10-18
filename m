Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B641C433FE
	for <kexec@archiver.kernel.org>; Fri, 21 Oct 2022 13:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GXcU/eFOUVVKmGg90WnjKB0VOD4dnWZWD4ZXBOk5jGQ=; b=0EdGRLtj2faRHl6OA+9nYM2bjX
	JMNvFNUEPsAdYRJLyHKkGHH1hmZ2byRG+e1qBTwuTl5FfZ+fhl+UHxRndkSZOc66NSVM58H33U9DZ
	SNbcC6HI5Q7TaXfhq3Y2xrFgk4oZp8uFm7kLdV0MWcQNAr3H2iJ1Kk2IxpPoXjk09Tl/OAfLirArT
	Q5O+mxxZsVzn+Fp3oNalfexnRkadF8Xmnj3FFMt/cl6SqyAKgPrtjMlD8bLe40CtJ0tAonW2iuKE3
	Ey7RDcjMig18Qt2FqCwC1qSIkwuHITWbmYH8+ksb5tEJ+phh16ANp+lSee3NJuWcX6O9zP6ChEEAM
	iQurAwNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olsTm-008KJY-Fm; Fri, 21 Oct 2022 13:54:30 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okd8a-001rjo-CM; Tue, 18 Oct 2022 03:19:29 +0000
Received: by mail-pf1-x435.google.com with SMTP id p14so12902422pfq.5;
        Mon, 17 Oct 2022 20:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=27lM4fsG2VGltbyI+HsR0GNVvFQa8niyfY/IiXC6g9U=;
        b=KjI9HR/u+WX7XG89cbrIUblYlmumfw6lIxgUY6dfjSZZ5wzG6Wia0bL09yLUAV9xfb
         a7mxiZDBmoJk5Bucbj/AjxlorzkmoOC03xXSu0VmBzuIgVnR1g5DS2yU0UHVKMfKnYCS
         /p/Lh529Xc5tUM21xfxM5QcW/4oNcWiT8sO+Yxdf4yJoiAbobNK8YFB3tksk5yU8wAqc
         uVrNODUp6495s2HoZOWgrzCqwdfx14qbkfhMEmIbAYLUqLpuka58am7ydj2eutrtt2Tc
         AdAiAv+1Svq1H1JNu8hJ9uRbNQ6y74kQ0zVNldgwq0xoVLdXHUp2A3eJKhgAHlY4sD+Q
         6u3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27lM4fsG2VGltbyI+HsR0GNVvFQa8niyfY/IiXC6g9U=;
        b=02KTTJZ7484DckZPrEcCC7/0kRTH8zDGNwgdH0oX4+TE+WdvSui047cGwMBr4XJbDq
         Nb7eP75trt03y+jKlF7xcOW+/KZx50jWqJRn1MOsijyg0weqqKNxP6V2IAgqRNIhn8UB
         uF1ARjMxYn6E8L1GKx8qkRJwhPhGAVbTB1t806Q3WvIYoCpyRr1qWO3kzaNtoP3YSQDD
         cbwfKNBhGOT2ZytJQ7vcoJLcnWG1OoinpZ2Dt3GjBY9p+cS/0HEvST3S6ckMC/ffgPwG
         xpJDNGP8L76Ft0Q+sZ90fk7q96tdkmiRNdxNw44yFVgMCZEAhjyKzeNxwM4JseIgIkjo
         HphQ==
X-Gm-Message-State: ACrzQf0S4lI/7uIKZFc1i9c+yrhO2AF1/dY9Ud9ZPB2PK5PIYZWpAtK5
	Xm3SzCMYsLsZFgxi8vB4TYM=
X-Google-Smtp-Source: AMsMyM6/a5vrznwL4ETCawwT7rzRy/qDKRaxQuif1QLAUCW5m9HXfnhGNCmjaMT71zdnAr9JpvFQBw==
X-Received: by 2002:a63:4850:0:b0:45d:6ee6:1c18 with SMTP id x16-20020a634850000000b0045d6ee61c18mr880131pgk.255.1666063166087;
        Mon, 17 Oct 2022 20:19:26 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-84.three.co.id. [180.214.233.84])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902f78a00b0017a018221e2sm7317751pln.70.2022.10.17.20.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 20:19:25 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
	id 03473103AB4; Tue, 18 Oct 2022 10:19:22 +0700 (WIB)
Date: Tue, 18 Oct 2022 10:19:22 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Xianting Tian <xianting.tian@linux.alibaba.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	anup@brainfault.org, heiko@sntech.de, guoren@kernel.org,
	mick@ics.forth.gr, alexandre.ghiti@canonical.com, bhe@redhat.com,
	vgoyal@redhat.com, dyoung@redhat.com, corbet@lwn.net,
	Conor.Dooley@microchip.com, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, crash-utility@redhat.com,
	heinrich.schuchardt@canonical.com, k-hagio-ab@nec.com,
	hschauhan@nulltrace.org, yixun.lan@gmail.com
Subject: Re: [PATCH V2 2/2] Documentation: kdump: describe VMCOREINFO export
 for RISCV64
Message-ID: <Y04bOv49sRsauLb6@debian.me>
References: <20221014134139.5151-1-xianting.tian@linux.alibaba.com>
 <20221014134139.5151-3-xianting.tian@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20221014134139.5151-3-xianting.tian@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221017_201928_462671_505890FB 
X-CRM114-Status: GOOD (  14.39  )
X-Mailman-Approved-At: Fri, 21 Oct 2022 06:53:58 -0700
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
Content-Type: multipart/mixed; boundary="===============3225056287001494839=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org


--===============3225056287001494839==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mJXlfJec3bfb1DWQ"
Content-Disposition: inline


--mJXlfJec3bfb1DWQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 14, 2022 at 09:41:39PM +0800, Xianting Tian wrote:
> The following interrelated definitions and ranges are needed by the kdump
> crash tool, they are exported by "arch/riscv/kernel/crash_core.c":

Better say "..., which are exported by ..."

> diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentati=
on/admin-guide/kdump/vmcoreinfo.rst
> index 6726f439958c..8e2e164cf3db 100644
> --- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
> +++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> @@ -595,3 +595,33 @@ X2TLB
>  -----
> =20
>  Indicates whether the crashed kernel enabled SH extended mode.
> +
> +RISCV64
> +=3D=3D=3D=3D=3D=3D=3D
> +
> +VA_BITS
> +-------
> +
> +The maximum number of bits for virtual addresses. Used to compute the
> +virtual memory ranges.
> +
> +PAGE_OFFSET
> +-----------
> +
> +Indicates the virtual kernel start address of direct-mapped RAM region.
> +
> +phys_ram_base
> +-------------
> +
> +Indicates the start physical RAM address.
> +
> +MODULES_VADDR|MODULES_END|VMALLOC_START|VMALLOC_END|VMEMMAP_START|VMEMMA=
P_END|KASAN_SHADOW_START|KASAN_SHADOW_END|KERNEL_LINK_ADDR|ADDRESS_SPACE_END
> +------------------------------------------------------------------------=
----------------------------------------------------------------------------
> +
> +Used to get the correct ranges:
> +
> +  * MODULES_VADDR ~ MODULES_END : Kernel module space.
> +  * VMALLOC_START ~ VMALLOC_END : vmalloc() / ioremap() space.
> +  * VMEMMAP_START ~ VMEMMAP_END : vmemmap region, used for struct page a=
rray.
> +  * KASAN_SHADOW_START ~ KASAN_SHADOW_END : kasan shadow space.
> +  * KERNEL_LINK_ADDR ~ ADDRESS_SPACE_END : Kernel link and BPF space.

The documentation LGTM, thanks.

When the patch subject is fixed,

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--mJXlfJec3bfb1DWQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY04bNgAKCRD2uYlJVVFO
o9kOAP9AaJtAmveWT2rKBcXBOriMgs2qxe6Fqu9neGo2fj4foQD/UM0HMxKN6GnG
IlT9w8j9jQUfpIzT4s7r+oaaSOgTJQY=
=ew2W
-----END PGP SIGNATURE-----

--mJXlfJec3bfb1DWQ--


--===============3225056287001494839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============3225056287001494839==--

