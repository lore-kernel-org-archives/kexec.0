Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga11.intel.com ([192.55.52.93])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1L5EBa-0001hO-OF
	for kexec@lists.infradead.org; Wed, 26 Nov 2008 06:47:42 +0000
Subject: Re: [PATCH] Fix kexec x86_64 load failed bug
From: Huang Ying <ying.huang@intel.com>
In-Reply-To: <20081126061652.GA24221@verge.net.au>
References: <20081125134738.7075a13a@hale.suse.de>
	<1227662409.2442.11.camel@yhuang-dev.sh.intel.com>
	<492CC1AA.3010408@oracle.com>
	<1227673551.2442.12.camel@yhuang-dev.sh.intel.com>
	<20081126061652.GA24221@verge.net.au>
Date: Wed, 26 Nov 2008 14:47:38 +0800
Message-Id: <1227682058.2442.19.camel@yhuang-dev.sh.intel.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1156137241=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Bernhard Walle <bwalle@suse.de>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>


--===============1156137241==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-74vAVWp58K640+gzVDJL"


--=-74vAVWp58K640+gzVDJL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-11-26 at 14:16 +0800, Simon Horman wrote:
> On Wed, Nov 26, 2008 at 12:25:51PM +0800, Huang Ying wrote:
> > On Wed, 2008-11-26 at 11:25 +0800, Randy Dunlap wrote:
> > > This isn't kernel code?  Where is /purgatory/ ?
> > >=20
> > > Anyway, for kernel code, that should be:
> > > char *cmdline_end =3D NULL;
> >=20
> > This patch is against kexec tools, not kernel.
> >=20
> > Best Regards,
> > Huang Ying
>=20
> Hi Huang,
>=20
> I think that I would prefer "char *cmdline_end =3D NULL;" for kexec-tools
> code too.

Patch v2 follows with NULL instead of 0.

Best Regards,
Huang Ying
---------------------------------------------------->
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

---
 purgatory/arch/x86_64/purgatory-x86_64.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/purgatory/arch/x86_64/purgatory-x86_64.c
+++ b/purgatory/arch/x86_64/purgatory-x86_64.c
@@ -1,10 +1,12 @@
 #include <stdint.h>
+#include <stddef.h>
 #include <purgatory.h>
 #include "purgatory-x86_64.h"
=20
 uint8_t reset_vga =3D 0;
 uint8_t legacy_pic =3D 0;
 uint8_t panic_kernel =3D 0;
+char *cmdline_end =3D NULL;
=20
 void setup_arch(void)
 {


--=-74vAVWp58K640+gzVDJL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkks8QYACgkQKhFGF+eHlpiP7wCfWlOvvAGpQn/FL2zgLMDLfn5s
KR8An12PDA4A6/Mhnveo7M3xHyvaQ4cJ
=XKin
-----END PGP SIGNATURE-----

--=-74vAVWp58K640+gzVDJL--



--===============1156137241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1156137241==--


