Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga09.intel.com ([134.134.136.24])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Kvj7O-0006Ak-AX
	for kexec@lists.infradead.org; Fri, 31 Oct 2008 01:48:07 +0000
Subject: [PATCH 1/3 -v4] kexec/i386: remove PAGE_SIZE alignment from
	relocate_kernel
From: Huang Ying <ying.huang@intel.com>
Date: Fri, 31 Oct 2008 09:48:02 +0800
Message-Id: <1225417682.24095.136.camel@yhuang-dev.sh.intel.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1081214515=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Ingo Molnar <mingo@elte.hu>, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Simon Horman <horms@verge.net.au>, Ian Campbell <Ian.Campbell@citrix.com>, Magnus Damm <magnus.damm@gmail.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org


--===============1081214515==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-iK1vXjXz2mTvdEJlSvIR"


--=-iK1vXjXz2mTvdEJlSvIR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

This patch removes PAGE_SIZE alignment from relocate_kernel(). Before
kexec jump patches are merged, control page is mapped to
relocate_kernel in kexec page tables, so relocate_kernel must be
PAGE_SIZE aligned. Now, control page is mapped to identity mapped
address, so relocate_kernel need not to be PAGE_SIZE aligned any
more. This can reduce a few KB from kernel text segement.

Signed-off-by: Huang Ying <ying.huang@intel.com>

---
 arch/x86/kernel/relocate_kernel_32.S |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/x86/kernel/relocate_kernel_32.S
+++ b/arch/x86/kernel/relocate_kernel_32.S
@@ -39,7 +39,6 @@
 #define CP_PA_BACKUP_PAGES_MAP	DATA(0x1c)
=20
 	.text
-	.align PAGE_SIZE
 	.globl relocate_kernel
 relocate_kernel:
 	/* Save the CPU context, used for jumping back */


--=-iK1vXjXz2mTvdEJlSvIR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkKY84ACgkQKhFGF+eHlpg5UACfagSQDmKle7bBEszLd9AcC2bi
pYIAn0kA9Ygn/QLAE7zkRxKqptgwDxTW
=NXjE
-----END PGP SIGNATURE-----

--=-iK1vXjXz2mTvdEJlSvIR--



--===============1081214515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1081214515==--


