Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [139.28.40.42] (helo=tarta.nabijaczleweli.xyz)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQumQ-0000SY-3N
 for kexec@lists.infradead.org; Fri, 09 Oct 2020 15:58:04 +0000
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
 by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id D19D1361227
 for <kexec@lists.infradead.org>; Fri,  9 Oct 2020 17:39:59 +0200 (CEST)
Date: Fri, 9 Oct 2020 17:39:58 +0200
From: Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Subject: [PATCH 4/5] i386: fix string formatting-related warnings
Message-ID: <138ec3f10131b2fce08840f1f70cf657b2555445.1602257696.git.nabijaczleweli@nabijaczleweli.xyz>
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
Content-Type: multipart/mixed; boundary="===============1893289300334794153=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org


--===============1893289300334794153==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o4tcbon72l2mjpoc"
Content-Disposition: inline


--o4tcbon72l2mjpoc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

fixed the same way as in 70cca82
"kexec: Fix snprintf related compilation warnings"

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 kexec/arch/i386/x86-linux-setup.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-=
setup.c
index 057ee14..76e1185 100644
--- a/kexec/arch/i386/x86-linux-setup.c
+++ b/kexec/arch/i386/x86-linux-setup.c
@@ -232,8 +232,14 @@ static int parse_edd_extensions(const char *dir, struc=
t edd_info *edd_info)
 	char line[1024];
 	uint16_t flags =3D 0;
 	FILE *fp;
+	int ret;
+
+	ret =3D snprintf(filename, PATH_MAX, "%s/%s", dir, "extensions");
+	if (ret < 0 || ret >=3D PATH_MAX) {
+		fprintf(stderr, "snprintf failed: %s\n", strerror(errno));
+		return -1;
+	}
=20
-	snprintf(filename, PATH_MAX, "%s/%s", dir, "extensions");
 	filename[PATH_MAX-1] =3D 0;
=20
 	fp =3D fopen(filename, "r");
@@ -269,8 +275,14 @@ static int read_edd_raw_data(const char *dir, struct e=
dd_info *edd_info)
 	FILE *fp;
 	size_t read_chars;
 	uint16_t len;
+	int ret;
+
+	ret =3D snprintf(filename, PATH_MAX, "%s/%s", dir, "raw_data");
+	if (ret < 0 || ret >=3D PATH_MAX) {
+		fprintf(stderr, "snprintf failed: %s\n", strerror(errno));
+		return -1;
+	}
=20
-	snprintf(filename, PATH_MAX, "%s/%s", dir, "raw_data");
 	filename[PATH_MAX-1] =3D 0;
=20
 	fp =3D fopen(filename, "r");
--=20
2.28.0


--o4tcbon72l2mjpoc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAl+AhE4ACgkQvP0LAY0m
WPGqNxAAl8jFHcmV7d9XTvdrMRXmYaYECPK/13xEaDIefnTr6Id5U23pvzWtK4Se
KWCHnsKIoj3uqNQShlPn8W2bGma8lH1fKtAs7tBF4DRAJBxJZF/Zt2hf/n0U7EkB
nGecN4/Rzob4QcqRWPw4zG1nsYCGYKJn4rethGZpW812kDTOhUldTI6NO2Q7rFGN
Wxf3HkB0u1sAEbRu5b7OV9m4sDbLyb2tjCwedD3PrYIbH25mPWqAbY4PdROzsjTU
KJJH6ZLOBL0DXbn+hCFW220ztsXd3jPP20u7uTgcUmnXiyiWaREkGAzitZjXSCLB
UgNlERpOBjmibc/8vI5bnTUyA8vf2/oJTr23IMubJAEH1Kcs4JRN3wU/IV0GbM+8
Q8H6EwPg2rayNRxbgtCGvrSSLQ3H0mxMfuAf/STErZzzYtcNOyJCsF0NC9Ct5oM8
Mt0jR/RTaZWmh9+vKOunWFXSQYYS30ZRnOsPCAjEjEPE9JRkuzb3dp7c6g8lzTVP
tmhH55JczrKtfIEUWrXamw+giSZq0pIwDzZD9yki0/IPTf8lkjToCSbWf4wy1P0o
CWSiREgW2eQSgY8ZJlvVpSntR0EVEWqBMz8QR2kMwcZ/4DB8UmFsyQIv+x4smRgo
HauQjLmrUk3qOr9HfvWJ+gNUis48BDq/TJORRak2gw4WfbeaDeg=
=TbIL
-----END PGP SIGNATURE-----

--o4tcbon72l2mjpoc--


--===============1893289300334794153==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1893289300334794153==--

