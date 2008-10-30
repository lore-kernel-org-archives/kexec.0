Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga14.intel.com ([143.182.124.37])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KvSiH-0005Fc-QB
	for kexec@lists.infradead.org; Thu, 30 Oct 2008 08:17:06 +0000
Subject: [PATCH -mm 1/3 -v3] kexec/i386: remove PAGE_SIZE alignment from
	relocate_kernel
From: Huang Ying <ying.huang@intel.com>
Date: Thu, 30 Oct 2008 16:17:01 +0800
Message-Id: <1225354621.24095.111.camel@yhuang-dev.sh.intel.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0342016511=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Simon Horman <horms@verge.net.au>, Ian Campbell <Ian.Campbell@citrix.com>, Magnus Damm <magnus.damm@gmail.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org


--===============0342016511==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-HSAJ/F0KW4x8D9BLfKcY"


--=-HSAJ/F0KW4x8D9BLfKcY
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


--=-HSAJ/F0KW4x8D9BLfKcY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkJbXoACgkQKhFGF+eHlpjNwwCfcZfbtUZlnk0Mwub4h9hZUFcd
gjAAnjHNO5dWl8bApW/EWIvPw7GHtgIW
=Fy7V
-----END PGP SIGNATURE-----

--=-HSAJ/F0KW4x8D9BLfKcY--



--===============0342016511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0342016511==--


