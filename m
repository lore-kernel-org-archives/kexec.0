Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DBF8C4167B
	for <kexec@archiver.kernel.org>; Mon,  4 Dec 2023 16:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qDCu2clRxhy5ZeAMphHwc6MMb5/NnccX2h+CUF4Kl3o=; b=M5mzNP7jFfPcoVableMNZYi/f/
	PjY3t6yWUR/SR8Pohb9Y4jHeNFmolWEPKWdX0TCtCznWPl8ERKysOh31SgzrAgu0NgiYElxmKkVvM
	Yv0SAVz84tCe48Cq4XWBfT2aboiTOeoDD0EmfidmdfNdVzZvjADOZo6+zJKwMe2zm8cIGrTFssPEp
	2NDQHtUjsZb7PBWT3reRDOLoYww6fPGGaVLC58IEtpgRdJzhmR2uDjNxllEbQ0L0YhWpVU0+d+/GU
	nIztGH5n0tvDbtTYDnQRGG4Dg3XnspxYneM1uq+Aasl+cO66N+eon/UGrmHzPibLF0Gvpdnz0YdtX
	gZx3KJLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rABaw-0054KA-0q;
	Mon, 04 Dec 2023 16:14:54 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rABat-0054JM-2M;
	Mon, 04 Dec 2023 16:14:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 50CB76122E;
	Mon,  4 Dec 2023 16:14:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970F3C433C7;
	Mon,  4 Dec 2023 16:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701706490;
	bh=SwEWkG/uCW/5Tacu2wjWGIOYBAsWvLMMutQ89lrq+CE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N346Pndsdr5C3wi2upjUoGzHZNenjnIGD4awErFqjGNAAdRyPnZdWSK8JGYpdoecv
	 j/BmEMplNLzOiX8xkbp2i6KKX0XN590J9vy+PaNwoTjR4Ks9XfnMLlbAT89oOXWGaJ
	 C/MzQOdwR1dBxtaOl5bhVKKCBLT20JGnqv+04pxBF3G/hop5GCe7OCL4WfZiTTCK9c
	 AMVvchAGsdLiSHvA1gqpPpFayD2mU0+vw31B0dcDkFVFh3fGD4X8/MV354FPbcqm3y
	 XYVBD6GcYW35X7iBaNISLOsOy2/da0trz/ZBL950aRavFOcNHgIxCOpcT/3+f2oqvy
	 2njAfgN4yL/+g==
Date: Mon, 4 Dec 2023 16:14:45 +0000
From: Conor Dooley <conor@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-parisc@vger.kernel.org, akpm@linux-foundation.org,
	joe@perches.com, nathan@kernel.org
Subject: Re: [PATCH v3 5/7] kexec_file, ricv: print out debugging message if
 required
Message-ID: <20231204-liftoff-enclosure-d3e3daf0ab6e@spud>
References: <20231130023955.5257-1-bhe@redhat.com>
 <20231130023955.5257-6-bhe@redhat.com>
 <20231201-blog-blasphemy-985d2665903c@wendy>
 <ZW3yXWJ7rTrtZzyg@MiWiFi-R3L-srv>
MIME-Version: 1.0
In-Reply-To: <ZW3yXWJ7rTrtZzyg@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_081451_875425_F65F6725 
X-CRM114-Status: GOOD (  36.96  )
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
Content-Type: multipart/mixed; boundary="===============2406271218472817895=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org


--===============2406271218472817895==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rDkxBxq3zHBt7ZDu"
Content-Disposition: inline


--rDkxBxq3zHBt7ZDu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2023 at 11:38:05PM +0800, Baoquan He wrote:
> On 12/01/23 at 10:38am, Conor Dooley wrote:
> > On Thu, Nov 30, 2023 at 10:39:53AM +0800, Baoquan He wrote:
> >=20
> > $subject has a typo in the arch bit :)
>=20
> Indeed, will fix if need report. Thanks for careful checking.
>=20
> >=20
> > > Replace pr_debug() with the newly added kexec_dprintk() in kexec_file
> > > loading related codes.
> >=20
> > Commit messages should be understandable in isolation, but this only
> > explains (part of) what is obvious in the diff. Why is this change
> > being made?
>=20
> The purpose has been detailedly described in cover letter and patch 1
> log. Andrew has picked these patches into his tree and grabbed the cover
> letter log into the relevant commit for people's later checking. All
> these seven patches will be present in mainline together. This is common
> way when posting patch series? Please let me know if I misunderstand
> anything.

Each patch having a commit message that explains why a change is being
made is the expectation. It is especially useful to explain the why
here, since it is not just a mechanical conversion of pr_debug()s as the
commit message suggests.

> >=20
> > >=20
> > > And also remove kexec_image_info() because the content has been print=
ed
> > > out in generic code.
> > >=20
> > > Signed-off-by: Baoquan He <bhe@redhat.com>
> > > ---
> > >  arch/riscv/kernel/elf_kexec.c     | 11 ++++++-----
> > >  arch/riscv/kernel/machine_kexec.c | 26 --------------------------
> > >  2 files changed, 6 insertions(+), 31 deletions(-)
> > >=20
> > > diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_ke=
xec.c
> > > index e60fbd8660c4..5bd1ec3341fe 100644
> > > --- a/arch/riscv/kernel/elf_kexec.c
> > > +++ b/arch/riscv/kernel/elf_kexec.c
> > > @@ -216,7 +216,6 @@ static void *elf_kexec_load(struct kimage *image,=
 char *kernel_buf,
> > >  	if (ret)
> > >  		goto out;
> > >  	kernel_start =3D image->start;
> > > -	pr_notice("The entry point of kernel at 0x%lx\n", image->start);
> > > =20
> > >  	/* Add the kernel binary to the image */
> > >  	ret =3D riscv_kexec_elf_load(image, &ehdr, &elf_info,
> > > @@ -252,8 +251,8 @@ static void *elf_kexec_load(struct kimage *image,=
 char *kernel_buf,
> > >  		image->elf_load_addr =3D kbuf.mem;
> > >  		image->elf_headers_sz =3D headers_sz;
> > > =20
> > > -		pr_debug("Loaded elf core header at 0x%lx bufsz=3D0x%lx memsz=3D0x=
%lx\n",
> > > -			 image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
> > > +		kexec_dprintk("Loaded elf core header at 0x%lx bufsz=3D0x%lx memsz=
=3D0x%lx\n",
> > > +			      image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
> > > =20
> > >  		/* Setup cmdline for kdump kernel case */
> > >  		modified_cmdline =3D setup_kdump_cmdline(image, cmdline,
> > > @@ -275,6 +274,8 @@ static void *elf_kexec_load(struct kimage *image,=
 char *kernel_buf,
> > >  		pr_err("Error loading purgatory ret=3D%d\n", ret);
> > >  		goto out;
> > >  	}
> > > +	kexec_dprintk("Loaded purgatory at 0x%lx\n", kbuf.mem);
> > > +
> > >  	ret =3D kexec_purgatory_get_set_symbol(image, "riscv_kernel_entry",
> > >  					     &kernel_start,
> > >  					     sizeof(kernel_start), 0);
> > > @@ -293,7 +294,7 @@ static void *elf_kexec_load(struct kimage *image,=
 char *kernel_buf,
> > >  		if (ret)
> > >  			goto out;
> > >  		initrd_pbase =3D kbuf.mem;
> >=20
> > > -		pr_notice("Loaded initrd at 0x%lx\n", initrd_pbase);
> > > +		kexec_dprintk("Loaded initrd at 0x%lx\n", initrd_pbase);
> >=20
> > This is not a pr_debug().
> >=20
> > >  	}
> > > =20
> > >  	/* Add the DTB to the image */
> > > @@ -318,7 +319,7 @@ static void *elf_kexec_load(struct kimage *image,=
 char *kernel_buf,
> > >  	}
> > >  	/* Cache the fdt buffer address for memory cleanup */
> > >  	image->arch.fdt =3D fdt;
> >=20
> > > -	pr_notice("Loaded device tree at 0x%lx\n", kbuf.mem);
> > > +	kexec_dprintk("Loaded device tree at 0x%lx\n", kbuf.mem);
> >=20
> > Neither is this. Why are they being moved from pr_notice()?
>=20
> You are right.=20
>=20
> While always printing out the loaded location of purgatory and
> device tree doesn't make sense. It will be confusing when users
> see these even when they do normal kexec/kdump loading. It should be
> changed to pr_debug().
>=20
> Which way do you suggest?
> 1) change it back to pr_debug(), fix it in another patch;
> 2) keep it as is in the patch;

Personally I think it is fine to change them all in one patch, but the
rationale for converting pr_notice() to your new debug infrastructure
needs to be in the commit message.

Thanks,
Conor.

--rDkxBxq3zHBt7ZDu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZW369QAKCRB4tDGHoIJi
0nMJAP4uVUovqQeQ+fYVKmAG4c00oB2z4haO+u5+2U2Cf9yrYwD/f9u0S9FMCfzY
i2AY9z+9fRLSvxY457Xg9s0W3YULlwE=
=OJ5C
-----END PGP SIGNATURE-----

--rDkxBxq3zHBt7ZDu--


--===============2406271218472817895==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============2406271218472817895==--

