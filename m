Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [139.28.40.42] (helo=tarta.nabijaczleweli.xyz)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQumQ-0000SW-3K
 for kexec@lists.infradead.org; Fri, 09 Oct 2020 15:58:03 +0000
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
 by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 9D7B1361223
 for <kexec@lists.infradead.org>; Fri,  9 Oct 2020 17:39:43 +0200 (CEST)
Date: Fri, 9 Oct 2020 17:39:42 +0200
From: Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Subject: [PATCH 2/5] configure.ac, arch/x86_64: handle x32 as subarch of
 x86_64 and don't specify -mcmodel=large there
Message-ID: <9c10bfea476b312f98664058d4553e96b94157d2.1602257696.git.nabijaczleweli@nabijaczleweli.xyz>
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
Content-Type: multipart/mixed; boundary="===============6486355361621299099=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org


--===============6486355361621299099==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="64j4igc65ni5wgbi"
Content-Disposition: inline


--64j4igc65ni5wgbi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 configure.ac                   | 8 ++++++++
 purgatory/arch/x86_64/Makefile | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/configure.ac b/configure.ac
index f025823..4e8f7c5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -54,6 +54,14 @@ case $target_cpu in
 		;;
 	ia64|x86_64|alpha|m68k )
 		ARCH=3D"$target_cpu"
+		case $target in
+			*x32 )
+				SUBARCH=3D"x32"
+				;;
+			* )
+				SUBARCH=3D""
+				;;
+		esac
 		;;
 	hppa*)
 		ARCH=3D"hppa"
diff --git a/purgatory/arch/x86_64/Makefile b/purgatory/arch/x86_64/Makefile
index 7300937..b0e277a 100644
--- a/purgatory/arch/x86_64/Makefile
+++ b/purgatory/arch/x86_64/Makefile
@@ -23,4 +23,6 @@ x86_64_PURGATORY_SRCS +=3D purgatory/arch/i386/console-x8=
6.c
 x86_64_PURGATORY_SRCS +=3D purgatory/arch/i386/vga.c
 x86_64_PURGATORY_SRCS +=3D purgatory/arch/i386/pic.c
=20
+ifneq ($(SUBARCH),x32)
 x86_64_PURGATORY_EXTRA_CFLAGS =3D -mcmodel=3Dlarge
+endif
--=20
2.28.0


--64j4igc65ni5wgbi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAl+AhD4ACgkQvP0LAY0m
WPFu9A/+MgVohyEUu9BnhHH86Maaq/tHIAKga0QGlnqfq4N/BQwDQf96q96JVWL8
8Z/bcvoZVf6e5A/x6XGkIpjaiucG6obJglftMGgzMAzBN4SncuYEXj6ZTJlx601K
AXiQb+wWWne4N/XILUeD3Y3gsJ6xYwNsQWLz0VAZjhfRjc2O/cFvZ1rOKpEWMtKK
sg7Z6ZlrXTj9JBexRcRKgg89XTBeqizf6nVwL1w3NtLrWPl3lAqlsptFFuQcOcxq
UbK/ewuAi/EoOzCHYcTQ8+jQw88HNsE9hC6L8RDl4aLJ38WVXvSd0GNv15zkBOVs
dHiZFepHlokBJI9gzVVKrrwvzkOVPXvyGPYgqyjg0cK4yaRbFre5Fl2287C2i1hb
E85Gmntl7yytyqGq7IavMa6nd4oV8Avlxr+Py5FdtoRWxEeDKvcrHyJlkpjOmUr8
JeTDkUzML6Af1r05sm2xQ7N49JmX3WfEbE+h+EE+OVZABNndFtWSGPB24vwrCwqD
Q/pF+Eda17x5Yd5mXlWeFXBij5/B76ZldfjWvydEXMA57niLE8OblKIw4ERb+BSV
VtvLUo4bw/MZ9JhVRD3EkCuBo61+EhujnyHLYgKT73IyeFU02SQaOURpKo15z/Yu
oLfIoUHkOwPA1yDT7NpyM1G0kc5S9MslRZD7Juu1xyCTVmhEoqA=
=FbWj
-----END PGP SIGNATURE-----

--64j4igc65ni5wgbi--


--===============6486355361621299099==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============6486355361621299099==--

