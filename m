Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga09.intel.com ([134.134.136.24])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1L594f-0001RY-Eu
	for kexec@lists.infradead.org; Wed, 26 Nov 2008 01:20:14 +0000
Subject: [PATCH] Fix kexec x86_64 load failed bug
From: Huang Ying <ying.huang@intel.com>
In-Reply-To: <20081125134738.7075a13a@hale.suse.de>
References: <20081125134738.7075a13a@hale.suse.de>
Date: Wed, 26 Nov 2008 09:20:09 +0800
Message-Id: <1227662409.2442.11.camel@yhuang-dev.sh.intel.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1496053933=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>


--===============1496053933==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-SJ4ifchjT/gayKLf2aJL"


--=-SJ4ifchjT/gayKLf2aJL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Fix a bug of kexec load on x86_64. Kexec fails to do load on x86_64, with
error message:

  Symbol: cmdline_end not found cannot set

Because kexec/arch/i386/kexec-bzImage.c accesses cmdline_end symbol in
i386 purgatory, but there is no cmdline_end in x86_64 purgatory, and
kexec-bzImage.c is used by x86_64 too.

cmdline_end is added into x86_64 purgatory to solve the bug, because kexec
jump support for x86_64 is planned.

Reported-by: Bernhard Walle <bwalle@suse.de>
Signed-off-by: Huang Ying <ying.huang@intel.com>

diff --git a/purgatory/arch/x86_64/purgatory-x86_64.c b/purgatory/arch/x86_=
64/purgatory-x86_64.c
index 374b554..67a37f9 100644
--- a/purgatory/arch/x86_64/purgatory-x86_64.c
+++ b/purgatory/arch/x86_64/purgatory-x86_64.c
@@ -5,6 +5,7 @@
 uint8_t reset_vga =3D 0;
 uint8_t legacy_pic =3D 0;
 uint8_t panic_kernel =3D 0;
+char *cmdline_end =3D 0;
=20
 void setup_arch(void)
 {


--=-SJ4ifchjT/gayKLf2aJL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkspDsACgkQKhFGF+eHlpgvAACfYOQBCYo/NoBSZKY34xPoPvpn
VpgAnitUguzI/zMcwWFCLJBLWZcZve8y
=dz7Z
-----END PGP SIGNATURE-----

--=-SJ4ifchjT/gayKLf2aJL--



--===============1496053933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1496053933==--


