Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga14.intel.com ([143.182.124.37])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Kv1fd-0007Vj-VD
	for kexec@lists.infradead.org; Wed, 29 Oct 2008 03:24:38 +0000
Subject: [PATCH 2/2] core dump file support for ELF loader
From: Huang Ying <ying.huang@intel.com>
Date: Wed, 29 Oct 2008 11:24:30 +0800
Message-Id: <1225250670.24095.41.camel@yhuang-dev.sh.intel.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0211247223=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>


--===============0211247223==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-/geQ+d+dKcNj5zeFpoJV"


--=-/geQ+d+dKcNj5zeFpoJV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

This patch adds core dump file support to ELF file loader. This can be
used by kexec based hibernation to load hibernated image, which is
from /proc/vmcore, a core dump file.

Signed-off-by: Huang Ying <ying.huang@intel.com>

---
 kexec/kexec-elf-exec.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kexec/kexec-elf-exec.c
+++ b/kexec/kexec-elf-exec.c
@@ -20,7 +20,8 @@ int build_elf_exec_info(const char *buf,
 	if (result < 0) {
 		return result;
 	}
-	if ((ehdr->e_type !=3D ET_EXEC) && (ehdr->e_type !=3D ET_DYN)) {
+	if ((ehdr->e_type !=3D ET_EXEC) && (ehdr->e_type !=3D ET_DYN) &&
+	    (ehdr->e_type !=3D ET_CORE)) {
 		/* not an ELF executable */
 		if (probe_debug) {
 			fprintf(stderr, "Not ELF type ET_EXEC or ET_DYN\n");


--=-/geQ+d+dKcNj5zeFpoJV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkH12oACgkQKhFGF+eHlpg2WACeMWkuoMMCzDkFNHi8AWHuD04B
KMEAoJV3MB/S0aQm/7eDDhNd8qpoe0BF
=KUUT
-----END PGP SIGNATURE-----

--=-/geQ+d+dKcNj5zeFpoJV--



--===============0211247223==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0211247223==--


