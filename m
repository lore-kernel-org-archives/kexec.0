Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A52ACC352A1
	for <kexec@archiver.kernel.org>; Wed,  7 Dec 2022 15:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2SohU0TEW46WQg+jBeiSL6lztlMspv+zYmcJ8b1cQ7Y=; b=qQ9hUYVeOG2a8Q6E98B+Zh95Bk
	qcGUuJ2ISYV5ScSVcGJb7nWZpOYI2Daa1FQ7rUJXo8IQoT2rJ1dS2unzj6yV6XlzLBH5LMjovTCpY
	WSYbGlPYoXiJRKiJUWCSM2JRAQ0FtPo5JycnS2/7HAMqLDnNqiFJhjSrXWwBK7BLYK67bWRhSahqo
	/hZ3akYT6wRsoNmXXXkOFj1JStkZ2hdQSRyz/AihJ3ypp9rXW+b3pEQXsUvQJ6t32azLej0a8bIaC
	K622quQ6wsZFELnWAVHASdQyZeX5hcyf8UYkT7tmgbBiujaCnqpxtoS2WLhTkjzHhnfm9wKc8ROwQ
	fuTTz/VA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2w1t-005aJq-8t; Wed, 07 Dec 2022 15:08:13 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2pTp-00Eidr-P0; Wed, 07 Dec 2022 08:08:39 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7E2EA60A51;
	Wed,  7 Dec 2022 08:08:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CAACC433B5;
	Wed,  7 Dec 2022 08:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670400515;
	bh=dh0NHFxS6FH0MAIpFjCQ0xsK44R9nD77S1vwGB4tbXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u2Z0XGwzU5rhxZ47IGdJC4cZ5SWxwZd2PAfrFapRuH0ECUlff0pUfQyCPposur7v+
	 ZkZCSIu8ispQ0Gt6qmlEHBThxzZyqIfBj+q1qqa+fg+vi93Sz72X1c2RkBa2GIp61O
	 RKrtBMKBn643EiWuVW4W4rEa9Z5Fe6cLZKyuQSPlG9RQhhmodr5vP1OAHcpsEV0Wm1
	 G13PZv4TTkqVcXJjY/MPOCeVICt3C20fnrJjxTuiBHlcLpOROHCt1i44s0TZ1cx/FJ
	 BwqQI0tRqdUkWErUJ0G0AmVuNF5aOjMxFID+QV2v0vU/yFjxR5e3vq8tdOsnAI/Wwh
	 ScGJZMPNlng/A==
Date: Wed, 7 Dec 2022 08:08:28 +0000
From: Conor Dooley <conor@kernel.org>
To: Guo Ren <guoren@kernel.org>
Cc: Palmer Dabbelt <palmer@rivosinc.com>,
	Xianting Tian <xianting.tian@linux.alibaba.com>, mick@ics.forth.gr,
	corbet@lwn.net, alexandre.ghiti@canonical.com, vgoyal@redhat.com,
	bhe@redhat.com, Paul Walmsley <paul.walmsley@sifive.com>,
	Conor Dooley <conor.dooley@microchip.com>, bagasdotme@gmail.com,
	dyoung@redhat.com, Palmer Dabbelt <palmer@dabbelt.com>,
	heiko@sntech.de, anup@brainfault.org, aou@eecs.berkeley.edu,
	hschauhan@nulltrace.org, yixun.lan@gmail.com,
	kexec@lists.infradead.org, heinrich.schuchardt@canonical.com,
	linux-doc@vger.kernel.org, crash-utility@redhat.com,
	linux-kernel@vger.kernel.org, k-hagio-ab@nec.com,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH V5 0/2] Support VMCOREINFO export for RISCV64
Message-ID: <Y5BJ/EeBTEJK2QLF@spud>
References: <20221026144208.373504-1-xianting.tian@linux.alibaba.com>
 <167002857934.4256.16584443879212253129.b4-ty@rivosinc.com>
 <Y4/KoiFhdvRBDdzH@spud>
 <CAJF2gTQX6361ME9UkOykvUEQifqioLMqovbfpqugkk174pKqfA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJF2gTQX6361ME9UkOykvUEQifqioLMqovbfpqugkk174pKqfA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221207_000837_928296_3B3D3C8C 
X-CRM114-Status: GOOD (  29.83  )
X-Mailman-Approved-At: Wed, 07 Dec 2022 07:08:12 -0800
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
Content-Type: multipart/mixed; boundary="===============2287439071274520413=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org


--===============2287439071274520413==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kTp0eC94p1NhUqFh"
Content-Disposition: inline


--kTp0eC94p1NhUqFh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 07, 2022 at 11:34:57AM +0800, Guo Ren wrote:
> On Wed, Dec 7, 2022 at 7:05 AM Conor Dooley <conor@kernel.org> wrote:
> >
> > Hey Palmer, Xianting,
> >
> > On Fri, Dec 02, 2022 at 04:49:39PM -0800, Palmer Dabbelt wrote:
> > > On Wed, 26 Oct 2022 22:42:06 +0800, Xianting Tian wrote:
> > > > As disscussed in below patch set, the patch of 'describe VMCOREINFO=
 export in Documentation'
> > > > need to update according to Bagas's comments.
> > > > https://lore.kernel.org/linux-riscv/22AAF52E-8CC8-4D11-99CB-88DE4D1=
13444@kernel.org/
> > > >
> > > > As others patches in above patch set already applied, so this patch=
 set only contains below two
> > > > patches.
> > > >
> > > > [...]
> > >
> > > Applied, thanks!
> > >
> > > [1/2] RISC-V: Add arch_crash_save_vmcoreinfo support
> > >       https://git.kernel.org/palmer/c/649d6b1019a2
> >
> > So this patch seems to be causing issues for the nommu build:
> > https://lore.kernel.org/oe-kbuild-all/202212062250.tR0otHcz-lkp@intel.c=
om/
> >
> > I had a bit of a poke at trying to see if there were some headers we
> > could pull in before actually checking the .config only to see:
> > # CONFIG_MMU is not set
> >
> > Do we have to wrap the whole thing in a `#ifdef CONFIG_MMU` to fix
> > compilation here?
> The problem does not belong to the patch.
>=20
> Could I send a fixup patch? like this?

That seems like a sane dependancy, but did you build that config?
This doesn't fix the problem for me :/

>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index ef8d66de5f38..d8c07999426c 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -512,6 +512,7 @@ config ARCH_HAS_KEXEC_PURGATORY
>=20
>  config CRASH_DUMP
>         bool "Build kdump crash kernel"
> +       depends on KEXEC
>         help
>           Generate crash dump after being started by kexec. This should
>           be normally only set in special crash dump kernels which are
>=20
> >
> > Thanks,
> > Conor.
> >
>=20
>=20
> --=20
> Best Regards
>  Guo Ren

--kTp0eC94p1NhUqFh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY5BJ8gAKCRB4tDGHoIJi
0ubRAPoCBXcQ4wIxwjTftwrdbA4d0c0vUsTpCiuxvofCAdWZkQD9FBTHcyzfFOqY
ZAI3YncP+u9hP81Ipg8Mzi7iCHql9gk=
=PuCV
-----END PGP SIGNATURE-----

--kTp0eC94p1NhUqFh--


--===============2287439071274520413==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============2287439071274520413==--

