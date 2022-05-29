Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 939DCC43334
	for <kexec@archiver.kernel.org>; Thu,  2 Jun 2022 06:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6l11vFDT3SbwReuNHF2wBBC7AkhHXjwbP4/VHDIq5fg=; b=igKrCerQ36b3gyVOKjbZR94NIG
	S53LJunMi7H7M7USs3bJmI8d63XcJ3zS7SvvBgk71JKwx9JdA5ll4wQvU92uPTA95eYW7VBA2+Gdu
	oJPzTXiCJZxFbucU7ub1HbVbiQHpjAv6vjs8efXhPQc2RachSzxSJXxT8MrW/vAbrMu+wSOUasYjP
	HdXLFzH/ajXLRvV61TNKUtFPONhyJFgwIDNv7UgL+m201xiXDUmPepfpLQ0xljTRDKrvZTiqrYlno
	2JSX5x8BX18c6Wo95UcKoQ0IWRS0QwzY1CY/nAk/axUGagaW/1j8JJRjXT6gbjoNklqydJ8lPxoWH
	OfokmnJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nweZO-001oDL-Fa; Thu, 02 Jun 2022 06:44:34 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nvCrn-003Peu-Su
	for kexec@lists.infradead.org; Sun, 29 May 2022 06:57:37 +0000
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1nvCrD-0001Nl-TF; Sun, 29 May 2022 08:56:59 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1nvCr5-005D0y-Nd; Sun, 29 May 2022 08:56:50 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1nvCr3-00Cp8z-H3; Sun, 29 May 2022 08:56:49 +0200
Date: Sun, 29 May 2022 08:56:37 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	Li Zhengyu <lizhengyu3@huawei.com>,
	Palmer Dabbelt <palmer@rivosinc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Eric Biederman <ebiederm@xmission.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-riscv@lists.infradead.org,
	kernel@pengutronix.de, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v2] kexec_file: Drop weak attribute from
 arch_kexec_apply_relocations[_add]
Message-ID: <20220529065637.xgapqjp2342flbuj@pengutronix.de>
References: <20220519091237.676736-1-naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20220519091237.676736-1-naveen.n.rao@linux.vnet.ibm.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: kexec@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220528_235735_975401_03499C84 
X-CRM114-Status: GOOD (  11.17  )
X-Mailman-Approved-At: Wed, 01 Jun 2022 23:44:27 -0700
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
Content-Type: multipart/mixed; boundary="===============4878020250565845075=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org


--===============4878020250565845075==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kx2r5dh4j5uektvu"
Content-Disposition: inline


--kx2r5dh4j5uektvu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

on current linux-next ARCH=3Driscv allmodconfig breaks with:

  CC      arch/riscv/kernel/elf_kexec.o
arch/riscv/kernel/elf_kexec.c:345:5: error: redefinition of =E2=80=98arch_k=
exec_apply_relocations_add=E2=80=99
  345 | int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from arch/riscv/kernel/elf_kexec.c:16:
include/linux/kexec.h:236:1: note: previous definition of =E2=80=98arch_kex=
ec_apply_relocations_add=E2=80=99 with type =E2=80=98int(struct purgatory_i=
nfo *, Elf64_Shdr *, const Elf64_Shdr *, const Elf64_Shdr *)=E2=80=99 {aka =
=E2=80=98int(struct purgatory_info *, struct elf64_shdr *, const struct elf=
64_shdr *, const struct elf64_shdr *)=E2=80=99}
  236 | arch_kexec_apply_relocations_add(struct purgatory_info *pi, Elf_Shd=
r *section,
      | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

(I think) because there is a conflict between the two commits:

233c1e6c319c kexec_file: drop weak attribute from arch_kexec_apply_relocati=
ons[_add]
838b3e28488f RISC-V: Load purgatory in kexec_file

And so next is broken starting from
164a9037b1d33f28ba27671c16ec1c23d4a11acf which merges the riscv tree.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kx2r5dh4j5uektvu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKTGRsACgkQwfwUeK3K
7AmDxAf9Ggb6UqEX3OJcHfUAj6XII7Pgm7ANdk/sgjvS9u4KABETUJ4Dub8m44b7
YzTKjAz6Aoat5x0aX/BoeMEGOLKrO10yBqljertv1U3F28A0fvUejuJJoBHnmQHO
A2rACjr5HuulnTTeF3vSwtxdKVzyR5bT4ys1ELO0drRWIdeds63oFpM3vg/7Dhkm
6DGR26o5+bBCUsDlpnNlSTy4bqMaXAtqnImET8yrafbTbDhSXbwO57dOlfT0QmTC
p2LoUfw5d64itPHNimGmnAJxtoJEET/gGLFzTbZIJk84CEydkc+3/2DyFU3rwHTZ
DBh5qrnvrwgxqtYd5zu0HPAfvgDQMA==
=tj8R
-----END PGP SIGNATURE-----

--kx2r5dh4j5uektvu--


--===============4878020250565845075==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============4878020250565845075==--

