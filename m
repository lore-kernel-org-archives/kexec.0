Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [139.28.40.42] (helo=tarta.nabijaczleweli.xyz)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQumQ-0000SU-3M
 for kexec@lists.infradead.org; Fri, 09 Oct 2020 15:58:03 +0000
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
 by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 314F7361225
 for <kexec@lists.infradead.org>; Fri,  9 Oct 2020 17:39:52 +0200 (CEST)
Date: Fri, 9 Oct 2020 17:39:51 +0200
From: Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Subject: [PATCH 3/5] i386/kexec-mb2-x86.c: cast ints to uintptr_t before
 pointers to avoid warnings
Message-ID: <29d02a9eb51ba7c66881ad28ee8d7aa399a52615.1602257696.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1602257696.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
In-Reply-To: <cover.1602257696.git.nabijaczleweli@nabijaczleweli.xyz>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============9047101599186997896=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org


--===============9047101599186997896==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mr7qbdjnubsklenf"
Content-Disposition: inline


--mr7qbdjnubsklenf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 kexec/arch/i386/kexec-mb2-x86.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kexec/arch/i386/kexec-mb2-x86.c b/kexec/arch/i386/kexec-mb2-x8=
6.c
index 1ad8aed..b4996bc 100644
--- a/kexec/arch/i386/kexec-mb2-x86.c
+++ b/kexec/arch/i386/kexec-mb2-x86.c
@@ -360,13 +360,13 @@ static uint64_t multiboot2_make_mbi(struct kexec_info=
 *info, char *cmdline, int
 	}
=20
 out:
-	return (uint64_t) ptrorig;
+	return (uint64_t) (uintptr_t) ptrorig;
 }
=20
 static uint64_t multiboot2_mbi_add_module(void *mbi_buf, uint64_t mbi_ptr,=
 uint32_t mod_start,
 					  uint32_t mod_end, char *mod_clp)
 {
-	struct multiboot_tag_module *tag =3D (struct multiboot_tag_module *) mbi_=
ptr;
+	struct multiboot_tag_module *tag =3D (struct multiboot_tag_module *) (uin=
tptr_t) mbi_ptr;
=20
 	tag->type =3D MULTIBOOT_TAG_TYPE_MODULE;
 	tag->size =3D sizeof(struct multiboot_tag_module) + strlen((char *)(long)=
 mod_clp) + 1;
@@ -381,7 +381,7 @@ static uint64_t multiboot2_mbi_add_module(void *mbi_buf=
, uint64_t mbi_ptr, uint3
=20
 static uint64_t multiboot2_mbi_end(void *mbi_buf, uint64_t mbi_ptr)
 {
-	struct multiboot_tag *tag =3D (struct multiboot_tag *) mbi_ptr;
+	struct multiboot_tag *tag =3D (struct multiboot_tag *) (uintptr_t) mbi_pt=
r;
=20
 	tag->type =3D MULTIBOOT_TAG_TYPE_END;
 	tag->size =3D sizeof (struct multiboot_tag);
--=20
2.28.0


--mr7qbdjnubsklenf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAl+AhEYACgkQvP0LAY0m
WPE3kBAAptC8uc/6LxXxeGzDgpB15AZnaQdju8CPTC7cPyZN0etWNr1kWC3XIkl8
+dTtoHNCbsDlKoBQFzBa6B6/dE73EFZTp8wbXM1h42NCQSinJ4TdT0EVjVp/NTHW
LjfR1g//7TyY1UNt+CGcjdF4YQqA/ScsBNWIW3VwGiwO8l54lm21DtcArD0cSHDs
utWEGxnIkkeHaLiq+IH4JvE62D0TS51fCUy00xeTEJAZvV8FyskMbvKuM7jo5Yjv
ejc1V96SYkAUwWuqiCvASG0snt2E9f2iaTiCdFDsXkn93a2Ky3k/6SqVHTMGWQNj
3eQXWi9vhE+GRUwqnjD55mQUQ4sByIIwnns22UZXzurKSyf+M2+R92CdQ38XALa7
S6jkUQteDQU38jgwEdLlB8tJrByAlvZH3OvxxsHFDVVzbuyIpdzXdy9MxMw0cxIB
BEMmaFkXpmUHd4Vnrf5EsS9ERcFDmo+r0s+0/My3rS+9CdJM6nPfa6SUoUxKt4Gu
CLwb043M1FPqI1bLwqvZYSAkdZQLlGohUT+4fffvbYjZyyPF0Q+7WzsNotratPvh
Q1VapDql2vLxarztUjw8MUZiGWm773qd7rl/+BGzTwFfjIo/PmfvPQ6T+EkNrmqH
hzqmsCSkP5tsZofWkFymKfXazPZ4IscCEVfY+r+p/HTg0lULIiQ=
=0D81
-----END PGP SIGNATURE-----

--mr7qbdjnubsklenf--


--===============9047101599186997896==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============9047101599186997896==--

