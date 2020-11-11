Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [139.28.40.42] (helo=tarta.nabijaczleweli.xyz)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcpQW-0000uu-10
 for kexec@lists.infradead.org; Wed, 11 Nov 2020 12:40:44 +0000
Date: Wed, 11 Nov 2020 13:40:35 +0100
From: Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Subject: Re: [PATCH 2/5] configure.ac, arch/x86_64: handle x32 as subarch of
 x86_64 and don't specify -mcmodel=large there
Message-ID: <20201111124035.r77xyn3r4dewmt2b@nabtop.nabijaczleweli.xyz>
References: <cover.1602257696.git.nabijaczleweli@nabijaczleweli.xyz>
 <9c10bfea476b312f98664058d4553e96b94157d2.1602257696.git.nabijaczleweli@nabijaczleweli.xyz>
 <20201023143307.GC9820@vergenet.net>
 <20201023154103.vwhdqxpguzlpvmwq@tarta.nabijaczleweli.xyz>
 <20201023184023.GA20943@vergenet.net>
MIME-Version: 1.0
In-Reply-To: <20201023184023.GA20943@vergenet.net>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7460025052926064115=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org


--===============7460025052926064115==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z3cak6sbcndddm5k"
Content-Disposition: inline


--z3cak6sbcndddm5k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2020 at 08:40:26PM +0200, Simon Horman wrote:
> On Fri, Oct 23, 2020 at 05:41:03PM +0200, Ahelenia Ziemia=C5=84ska wrote:
> > There is, indeed, no x32 equivalent for non-amd64,
> > but I just put this here like this because there aren't
> > any other triples that end in "x32". Would you rather this go
> > in a separate "if ARCH=3Dx86_64 && target=3D*x32" clause below?
>=20
> Yes, I think that would be slightly nicer.

Updated patch below.

-- >8 --
Subject: [PATCH 2/5] configure.ac, arch/x86_64: handle x32 as subarch
 of x86_64 and don't specify -mcmodel=3Dlarge there

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 configure.ac                   | 11 +++++++++++
 purgatory/arch/x86_64/Makefile |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/configure.ac b/configure.ac
index f025823..eb3ecac 100644
--- a/configure.ac
+++ b/configure.ac
@@ -63,6 +63,17 @@ case $target_cpu in
 		;;
 esac
=20
+if test "$ARCH" =3D "x86_64" ; then
+	case $target in
+		*x32 )
+			SUBARCH=3D"x32"
+			;;
+		* )
+			SUBARCH=3D""
+			;;
+	esac
+fi
+
 dnl ---Options
=20
 OBJDIR=3D`pwd`/objdir
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
2.29.1

--z3cak6sbcndddm5k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAl+r28AACgkQvP0LAY0m
WPETKQ/+Pv6KblbTvkdTqyVYPHnGq+nwH1riX3Nq901eDmK0GtmwWtkokVNzVKwh
m3Tct6TWPQS8N/1c5zibIXcbgWV1V61xInmUlNgfX1T+f9MKTXqTZQt9SaTgRZ+L
kkj+k/7GWPweuQjEiPCo9i72syAl3fYMrcoRAKEgjbdETaamxfXLJOQSna4Z6VCw
7Y2UNfScDINHmZB6mBU62I7Vg/Wg3qJ51lZhKlIMfPS9i8VJ3IOpCjkdxUGmk5mK
HhMh63HzTaHk1TTHKkgB5+n/11QMHDPdIHYf1Af3dNYPhuwMLWXznAwKyWuYUxV9
C1fPki3CZDuxJSukxLSGq0gC+OA8qvYExB0Mz7UJgjpl0pk0SsetfeWK9/vPJcAJ
+HbEn+Gwlax4wPtRf8ajhPNOLKhz0kgOP78FoO4td3hEd/v/hYqhYle6IldAy8ZR
whG1qj781NJsziCTpMlO1gx2qBSwZJwDC20BG/9qf+/FI3l3HHAddVKS5AueSEUu
YMmLohO8yXW4mOqQKCjgYcoMSU09ciCDjzYNH2/ovwGml5XHCynqO+oYOaWc/zIz
S628wI5DxgL3mUsOl/q0n9NP+1vgg49EUtmYEdZv2eTHJRGN1KJvjG4rql8Hs5AH
vL9moG0P8CneSj57rJxLD3ro6nAtuJ1+YbETfhevTRB0zhajDWE=
=+iUO
-----END PGP SIGNATURE-----

--z3cak6sbcndddm5k--


--===============7460025052926064115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============7460025052926064115==--

