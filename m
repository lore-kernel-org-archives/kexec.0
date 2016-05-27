Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lb0-x241.google.com ([2a00:1450:4010:c04::241])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b6ELp-00020R-Oc
 for kexec@lists.infradead.org; Fri, 27 May 2016 09:46:42 +0000
Received: by mail-lb0-x241.google.com with SMTP id rs7so1149466lbb.0
 for <kexec@lists.infradead.org>; Fri, 27 May 2016 02:46:20 -0700 (PDT)
Date: Fri, 27 May 2016 12:46:17 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: Re: [PATCH] makedumpfile: Fix compilation warning
Message-ID: <20160527094617.GB4189@localhost.localdomain>
References: <1463737874-4610-1-git-send-email-andrej.skvortzov@gmail.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E473DC@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701E473DC@BPXM01GP.gisp.nec.co.jp>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2528648260216917050=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>


--===============2528648260216917050==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
Content-Disposition: inline


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 27 May, Atsushi Kumagai wrote:
> Hello, Andrey
>=20
> Sorry for my late reply, I'll merge this into v1.6.0.
>=20
> Thanks,
> Atsushi Kumagai

No problem. Thanks.

>=20
> >After commit 5bc1f520
> >[Looking for page.compound_order/compound_dtor to exclude hugepages]
> >during build appears following compilation warning:
> >
> >makedumpfile.c: In function =E2=80=98isHugetlb=E2=80=99:
> >makedumpfile.c:244:1: warning: type of =E2=80=98dtor=E2=80=99 defaults t=
o =E2=80=98int=E2=80=99
> >[-Wimplicit-int]
> > isHugetlb(dtor)
> >  ^
> >
> >Tested with gcc 5.3.1.
> >
> >Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> >---
> > makedumpfile.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/makedumpfile.c b/makedumpfile.c
> >index ce9fba6..4f17686 100644
> >--- a/makedumpfile.c
> >+++ b/makedumpfile.c
> >@@ -241,7 +241,7 @@ is_in_same_page(unsigned long vaddr1, unsigned long =
vaddr2)
> > }
> >
> > static inline int
> >-isHugetlb(dtor)
> >+isHugetlb(int dtor)
> > {
> >         return ((NUMBER(HUGETLB_PAGE_DTOR) !=3D NOT_FOUND_NUMBER)
> > 		&& (NUMBER(HUGETLB_PAGE_DTOR) =3D=3D dtor))
> >--
> >2.8.1
> >
> >
> >_______________________________________________
> >kexec mailing list
> >kexec@lists.infradead.org
> >http://lists.infradead.org/mailman/listinfo/kexec

--=20
Best regards,
Andrey Skvortsov

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCAAGBQJXSBdpAAoJEAF8y6L1SLCtHx4P/jNHyL26R/eQiW1PeN8pTt5i
sEhoMIXaEooQ4ndLsmUIumar9TjKmS3EUP5u8xh5c9SUZHkQ/ZPW3q9RrF5v44Ss
z2vCdte9s/fgsg4dlUzbwBa55JUYgrNkdxOmwMo0kYrKAMp92Nb3AzbjKrd5ivmy
8/+MMjFnqC9xTs0WHcE9MKMCl2Y6umOU2EftXErYRqqn6/QMyxo/nOqjS0rIfZr3
CAhrKRQ4nu6NxpHk4wkGOyNa+6AQDVOXtBX/jkiRmQF3k2oCVcSAcIzL6kuBsMw4
qT+zyqVk+vR3gtgcJeH5XKTkynG5xGT4B7px7ia26hqlhmy4X8aeyaXCAWd/Ve78
14KHa5mSAtxGm3dr0oJ+H9z15Pfi1iLsrmvf5fmzcYeE8cKw2BguP0x6Y+7xcsTh
5Y5yZEBHf24blZBtwG+QQTKxJ2GqUPwXgwSKTu6yO/EDc0rgHHXDyFN6pw2tr6WZ
cgZTLL/LrMUxXBZXbC1bh3SI2fyPGjsA3ARr99H9DwbMGlO3CZhRQ92dvsZ4zr8F
vYTlMoPthL90irsUb9uCPOjRuFUvqv6YJ7RtYrEwiovLF7WlT1p7f8GVB2PkpP8J
932hfTOfhytK3Ob3s5+zAgJ7jCPM1NXoUzbSoB+FwYzfTtheZeAd1yoFESXqjjwD
5HvlrClngy/AqNogn6py
=3EiX
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--


--===============2528648260216917050==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============2528648260216917050==--

