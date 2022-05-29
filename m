Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD5BC43334
	for <kexec@archiver.kernel.org>; Thu,  2 Jun 2022 06:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ohtsCKjwEi/bSRB2fjuGaFbtD3US6QXDQJEN41hs4rU=; b=p8LdFR44VvTbkp1F76fOl0uxBB
	RvgXu8Vyg/9Mbw0C5XqUglY7Gm8+n7f44408AcG5qguQyqz0af/F+DveYtLTrvJbDfiQT9zhE6+VA
	764VHv8DLERwjTrZQCmx9JKpCfHBgO93EWhKyjxauMwFpiBKesj+3jxxRcsSPUJZ9Yi4Hei2pIPVH
	qFCsR4cSuAbeSvfnAOTytOLPXZMEuIda0QB7kPyR7Xj452Bg3x2fEsBWGLBiYTQL0iiu71V/qZm67
	mgyEO6+8zJMvu5TxGLhSv7s6FL/e/RcgXoUxjW0IH8nQj5tYD4DPNB8KFe32HdBXq/bg/InDBLoXj
	bef4mbvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nweZT-001oHO-8Y; Thu, 02 Jun 2022 06:44:39 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nvJZr-003zzp-6I
	for kexec@lists.infradead.org; Sun, 29 May 2022 14:07:32 +0000
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1nvJZU-0006Ii-Jf; Sun, 29 May 2022 16:07:08 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1nvJZO-005H9k-2S; Sun, 29 May 2022 16:07:00 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1nvJZL-00Ct7w-OW; Sun, 29 May 2022 16:06:59 +0200
Date: Sun, 29 May 2022 16:06:55 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	Li Zhengyu <lizhengyu3@huawei.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v2] kexec_file: Drop weak attribute from
 arch_kexec_apply_relocations[_add]
Message-ID: <20220529140655.bnd4fgggccrorj4t@pengutronix.de>
References: <20220519091237.676736-1-naveen.n.rao@linux.vnet.ibm.com>
 <20220529065637.xgapqjp2342flbuj@pengutronix.de>
 <264786d9-7756-19e0-2742-8b8d17f5ace5@csgroup.eu>
MIME-Version: 1.0
In-Reply-To: <264786d9-7756-19e0-2742-8b8d17f5ace5@csgroup.eu>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: kexec@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220529_070731_272443_79A9AF1F 
X-CRM114-Status: GOOD (  25.71  )
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
Content-Type: multipart/mixed; boundary="===============3925376455497148690=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org


--===============3925376455497148690==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qvv5wvvttflg77jh"
Content-Disposition: inline


--qvv5wvvttflg77jh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, May 29, 2022 at 09:46:47AM +0000, Christophe Leroy wrote:
> Le 29/05/2022 =C3=A0 08:56, Uwe Kleine-K=C3=B6nig a =C3=A9crit=C2=A0:
> > Hello,
> >=20
> > on current linux-next ARCH=3Driscv allmodconfig breaks with:
> >=20
> >    CC      arch/riscv/kernel/elf_kexec.o
> > arch/riscv/kernel/elf_kexec.c:345:5: error: redefinition of =E2=80=98ar=
ch_kexec_apply_relocations_add=E2=80=99
> >    345 | int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
> >        |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > In file included from arch/riscv/kernel/elf_kexec.c:16:
> > include/linux/kexec.h:236:1: note: previous definition of =E2=80=98arch=
_kexec_apply_relocations_add=E2=80=99 with type =E2=80=98int(struct purgato=
ry_info *, Elf64_Shdr *, const Elf64_Shdr *, const Elf64_Shdr *)=E2=80=99 {=
aka =E2=80=98int(struct purgatory_info *, struct elf64_shdr *, const struct=
 elf64_shdr *, const struct elf64_shdr *)=E2=80=99}
> >    236 | arch_kexec_apply_relocations_add(struct purgatory_info *pi, El=
f_Shdr *section,
> >        | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >=20
> > (I think) because there is a conflict between the two commits:
> >=20
> > 233c1e6c319c kexec_file: drop weak attribute from arch_kexec_apply_relo=
cations[_add]
> > 838b3e28488f RISC-V: Load purgatory in kexec_file
> >=20
> > And so next is broken starting from
> > 164a9037b1d33f28ba27671c16ec1c23d4a11acf which merges the riscv tree.
> >=20
>=20
> In arch/riscv/include/asm/kexec.h, do the same as s390 did in commit=20
> 233c1e6c319c:
>=20
> diff --git a/arch/s390/include/asm/kexec.h b/arch/s390/include/asm/kexec.h
> index 7f3c9ac34bd8..540dd469b088 100644
> --- a/arch/s390/include/asm/kexec.h
> +++ b/arch/s390/include/asm/kexec.h
> @@ -83,4 +83,12 @@ struct kimage_arch {
>   extern const struct kexec_file_ops s390_kexec_image_ops;
>   extern const struct kexec_file_ops s390_kexec_elf_ops;
>=20
> +#ifdef CONFIG_KEXEC_FILE
> +struct purgatory_info;
> +int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
> +				     Elf_Shdr *section,
> +				     const Elf_Shdr *relsec,
> +				     const Elf_Shdr *symtab);
> +#define arch_kexec_apply_relocations_add arch_kexec_apply_relocations_add
> +#endif
>   #endif /*_S390_KEXEC_H */

I can confirm that doing

diff --git a/arch/riscv/include/asm/kexec.h b/arch/riscv/include/asm/kexec.h
index 206217b23301..eee260e8ab30 100644
--- a/arch/riscv/include/asm/kexec.h
+++ b/arch/riscv/include/asm/kexec.h
@@ -55,6 +55,13 @@ extern riscv_kexec_method riscv_kexec_norelocate;
=20
 #ifdef CONFIG_KEXEC_FILE
 extern const struct kexec_file_ops elf_kexec_ops;
+
+struct purgatory_info;
+int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
+				     Elf_Shdr *section,
+				     const Elf_Shdr *relsec,
+				     const Elf_Shdr *symtab);
+#define arch_kexec_apply_relocations_add arch_kexec_apply_relocations_add
 #endif
=20
 #endif

on top of 838b3e28488f results in a compilable tree. And when merging
233c1e6c319c into this, it is still building.

I'm not enough into kexec (and riscv) to judge if this is sensible, or
create a useful commit log but the obvious way forward is to apply the
above patch to the riscv tree before it hits Linus' tree.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qvv5wvvttflg77jh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKTffwACgkQwfwUeK3K
7Ak9FQf/SQrMKKxpQ8gVUDFht3yFkQLOJJe/adkmkFoMpxOZklvcq5hSdJP2Y1NL
I3Y35bb9SR1VPi6fFHHGuBqB0BiK9mKo1KLb9ZY7/7udpfI1e6tPW4ea2QuscqZt
i7IQb1Gff1YzWYfW7/Y8ZugIJTDFvuTiHTFxrOlwiQVkQnywWACEMsCBjb0Aj9XE
9yKOSWeqmnvhvS2+2U9v8FWLJOPTSaeQ3hSjJ3xXjEkoJz3L0pHcnqyIz8UAmQhl
DRO6UpPbq6hLtMkKF8AmIFLstoEaEt636vw7pl+9MrM3zJX7DMYiIpwGZ/431+YB
6ERUkRrVesGri6hOFffuYrCwXZHfdw==
=Cu9X
-----END PGP SIGNATURE-----

--qvv5wvvttflg77jh--


--===============3925376455497148690==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============3925376455497148690==--

