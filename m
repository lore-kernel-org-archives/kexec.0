Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KYADk-00015l-Lu
	for kexec@lists.infradead.org; Wed, 27 Aug 2008 01:53:17 +0000
Received: from yukiko.kent.sydney.vergenet.net
	(124-170-204-174.dyn.iinet.net.au [124.170.204.174])
	by kirsty.vergenet.net (Postfix) with ESMTP id 6773824076
	for <kexec@lists.infradead.org>; Wed, 27 Aug 2008 11:53:15 +1000 (EST)
Resent-Message-ID: <20080827015314.GA19066@verge.net.au>
Resent-To: kexec@lists.infradead.org
Received: from metis.extern.pengutronix.de ([83.236.181.26])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KXL9v-0002c3-Gy
	for kexec@lists.infradead.org; Sun, 24 Aug 2008 19:21:55 +0000
Received: from themisto.extern.pengutronix.de ([83.236.181.29]
	helo=[127.0.0.1])
	by metis.extern.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <mkl@pengutronix.de>) id 1KXL9i-0005qK-Ef
	for kexec@lists.infradead.org; Sun, 24 Aug 2008 21:21:47 +0200
Message-ID: <48B1B4C0.3070209@pengutronix.de>
Date: Sun, 24 Aug 2008 21:21:36 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
Subject: [patch] fix compilation on arm
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1135848000=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============1135848000==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4CAAD345BA29D467DEA4E771"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4CAAD345BA29D467DEA4E771
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

cross compilation to arm fails with toolchain based on recent new kernel
headers, due to mussing asm/page.h, This patch fixes the problem.

cheers, Marc

--=20
 Marc Kleine-Budde              Phone: +49-231-2826-924
 Pengutronix - Linux Solutions for Science and Industry
 Vertretung West/Dortmund     http://www.pengutronix.de

=46rom f1786e47eb58f4eec4357ff07d8d009222e6ea7c Mon Sep 17 00:00:00 2001
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sun, 24 Aug 2008 21:11:05 +0200
Subject: [PATCH] remove "asm/page.h" include, define _XOPEN_SOURCE

In recent kernels "asm/page.h" isn't exported to userspace anymore, thus
the include is removed.

Further this patch defines _XOPEN_SOURCE, in order to use getpagesize.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 kexec/arch/arm/kexec-zImage-arm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kexec/arch/arm/kexec-zImage-arm.c
b/kexec/arch/arm/kexec-zImage-arm.c
index 440ad73..5eb4905 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -3,6 +3,7 @@
  *
  */
 #define _GNU_SOURCE
+#define _XOPEN_SOURCE
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
@@ -11,7 +12,6 @@
 #include <stdint.h>
 #include <getopt.h>
 #include <arch/options.h>
-#include <asm/page.h>
 #include "../../kexec.h"

 #define COMMAND_LINE_SIZE 1024
--=20
1.5.5.1



--------------enig4CAAD345BA29D467DEA4E771
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIsbTFjTAFq1RaXHMRAmUSAJ4gX6QQThdJmfaazKntx4D4/boHhwCaAyjj
Ovv1WcF2RdLdY5sWKDKTaVM=
=j3o8
-----END PGP SIGNATURE-----

--------------enig4CAAD345BA29D467DEA4E771--



--===============1135848000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1135848000==--


