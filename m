Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56144C4332F
	for <kexec@archiver.kernel.org>; Fri, 14 Oct 2022 17:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4pIHDLCKoIr91s/EVKrMisBEu2QE4il5uAgcdmpnyPE=; b=L0AEUCBLJzKS9RkVXsZf2uchcS
	DMCKo8LrsdI41+GxkXL9a8A+f18J/cEPW/jwaDQJlWPvrTL7eY7yX9pP2jET+avQSPp3SQtvxN7Ug
	xLzQU3eb8XxnT9u/bFempq2VR9Afet/WCq/hEKyMLX/jFT3kFIt1FS/hifHVw8ssJmVvu10JwlRh1
	n5J4V6uTPT/oAU+pKjXuSotQN88D504iE0k5dcT6aAcBm7ReArQyw63eMeYc61aXFYd8KxZSUBliU
	ke5MlrmLRr5uGFx9WY0r8jLUw3ovFNiH5SQBG75nSMdEMaty2F3WDFd4n8mDMVUAwJI5HkuE+upU9
	JE0quLpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ojOTw-00FUR5-Hg; Fri, 14 Oct 2022 17:28:24 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ojKJo-00Ehx7-9K; Fri, 14 Oct 2022 13:01:41 +0000
Received: by mail-pl1-x633.google.com with SMTP id n7so4688841plp.1;
        Fri, 14 Oct 2022 06:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p4dlnb05MmevigtHJ5npeQ25AeXBFYvEvQsw5sWpFGI=;
        b=TGoQstWfBGwpuTarpv5uEIg+GAgT/B8QqBhRDR96IZxKwAI4I5PIdzTiMa9zbhp4+9
         oAHw1vwsww0hwwxwcqeYc+wUEuYZoqeph9+B1ucQa+mI6s7swkxUN88mJvXsIGpgsJnX
         hRojlYcK4Ty6urHIZNAr+kU0uKT9sIm0NBkNS8p1SDGuOM8XExer/rUuUxrU7tO3wyQr
         B7trVpUSBbKblV8FU5M5YZnFjGQUA/nCtq6MPDrYS1utsCDFVFBPogUXJ1mhkJzaYXHs
         lfRYXVKu4T0ycTRnriT5zMr3m0CsJLpduN8kEhjgYnB5Z9tAoVvaVwU9Arp1sJ0fRMMR
         x6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4dlnb05MmevigtHJ5npeQ25AeXBFYvEvQsw5sWpFGI=;
        b=aUl+VmMpEllxZnTVu82jbKRZ9K4ZQdDOVSLwVak9RfRgKRcY3Ar+jP/OKlq2YQuGBe
         dQJM9C110/UK8ehZwwENt3Ci5Pm/Al+EwgL0/66duxC5jWqPS6gR5cmKkjmDxaNB37Rt
         370Ba4huU6eRgZ6F7IgPULrid3mbzwps88fm6nF+WMfytpukgEhatQ5WJfidzFEdUrCC
         ZSj2Na6leeLqQkGq2sq3scfiexsuFTWg7D7lJh2hkb69r3ueZqfgl3ddu7kwzsnLt2K6
         4PhLfCy5KVBJvkYxoJvMcaObAAngHAn7zX3pvgWyUK2bTvsOVriaUUHMOI3GjCaEZs50
         nNww==
X-Gm-Message-State: ACrzQf0ijq+TqI5AksffNXdfGg0xU3HKOVwRlCMP70ycyfbOhqXYPDCF
	BLejgTnFh2u2yrSNSfJITX3ZSMFWrqZPI5tU
X-Google-Smtp-Source: AMsMyM6j7YsVpDg/m4uDWdQUc2SyFqtniSBBp/CWN50pRwlBieYiOP5HFCzYzVOIfZ3g5tS7seORQQ==
X-Received: by 2002:a17:90b:4c85:b0:20d:7040:532a with SMTP id my5-20020a17090b4c8500b0020d7040532amr5544291pjb.243.1665752496799;
        Fri, 14 Oct 2022 06:01:36 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-8.three.co.id. [180.214.232.8])
        by smtp.gmail.com with ESMTPSA id y18-20020aa79e12000000b0056246403534sm1687407pfq.88.2022.10.14.06.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 06:01:36 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
	id B5EF7103F3B; Fri, 14 Oct 2022 20:01:32 +0700 (WIB)
Date: Fri, 14 Oct 2022 20:01:32 +0700
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
Subject: Re: [PATCH 2/2] Documentation: kdump: describe VMCOREINFO export for
 RISCV64
Message-ID: <Y0ldrJ91ac0um3++@debian.me>
References: <20221014074810.4471-1-xianting.tian@linux.alibaba.com>
 <20221014074810.4471-3-xianting.tian@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20221014074810.4471-3-xianting.tian@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221014_060140_350318_D4631B26 
X-CRM114-Status: GOOD (  10.47  )
X-Mailman-Approved-At: Fri, 14 Oct 2022 10:28:23 -0700
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
Content-Type: multipart/mixed; boundary="===============4198082399330771470=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org


--===============4198082399330771470==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nuzjBSR3N8Zosn2Q"
Content-Disposition: inline


--nuzjBSR3N8Zosn2Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 14, 2022 at 03:48:10PM +0800, Xianting Tian wrote:
> The following interrelated definitions and ranges are needed by the kdump
> crash tool, they are exported by "arch/riscv/kernel/crash_core.c":
>     VA_BITS,
>     PAGE_OFFSET,
>     phys_ram_base,
>     MODULES_VADDR ~ MODULES_END,
>     VMALLOC_START ~ VMALLOC_END,
>     VMEMMAP_START ~ VMEMMAP_END,
>     KASAN_SHADOW_START ~ KASAN_SHADOW_END,
>     KERNEL_LINK_ADDR ~ ADDRESS_SPACE_END
>=20
> Document these RISCV64 exports above.
>=20

The patch description LGTM, thanks.

> +------------------------------------------------------------------------=
----------------------------------------------------------------------------
> +MODULES_VADDR|MODULES_END|VMALLOC_START|VMALLOC_END|VMEMMAP_START|VMEMMA=
P_END|KASAN_SHADOW_START|KASAN_SHADOW_END|KERNEL_LINK_ADDR|ADDRESS_SPACE_END
> +------------------------------------------------------------------------=
----------------------------------------------------------------------------

The overline above header text is unnecessary, so I have to strip it:

---- >8 ----

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation=
/admin-guide/kdump/vmcoreinfo.rst
index 6c7a1728de220e..8e2e164cf3db49 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -615,7 +615,6 @@ phys_ram_base
=20
 Indicates the start physical RAM address.
=20
---------------------------------------------------------------------------=
--------------------------------------------------------------------------
 MODULES_VADDR|MODULES_END|VMALLOC_START|VMALLOC_END|VMEMMAP_START|VMEMMAP_=
END|KASAN_SHADOW_START|KASAN_SHADOW_END|KERNEL_LINK_ADDR|ADDRESS_SPACE_END
 --------------------------------------------------------------------------=
--------------------------------------------------------------------------
=20
Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--nuzjBSR3N8Zosn2Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY0ldpgAKCRD2uYlJVVFO
o51wAQDygf3rDiQGj/G3/lq6CeZQlyPUhwNtm2mmc2lNlrve0QD/cAljpqNnnPtK
WUvHdL90TLML7Na4fSDiq+671IZ0TAI=
=33JA
-----END PGP SIGNATURE-----

--nuzjBSR3N8Zosn2Q--


--===============4198082399330771470==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============4198082399330771470==--

