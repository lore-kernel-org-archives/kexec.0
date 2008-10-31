Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga01.intel.com ([192.55.52.88])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Kvj7I-00069o-7a
	for kexec@lists.infradead.org; Fri, 31 Oct 2008 01:48:00 +0000
Subject: [PATCH 0/3 -v4] kexec/i386: kexec page table code clean up
From: Huang Ying <ying.huang@intel.com>
Date: Fri, 31 Oct 2008 09:47:57 +0800
Message-Id: <1225417677.24095.135.camel@yhuang-dev.sh.intel.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1626238851=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Ingo Molnar <mingo@elte.hu>, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Simon Horman <horms@verge.net.au>, Ian Campbell <Ian.Campbell@citrix.com>, Magnus Damm <magnus.damm@gmail.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org


--===============1626238851==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-PqCX37kr74nBYYzpcT7D"


--=-PqCX37kr74nBYYzpcT7D
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

This patchset cleans up page table setup code of kexec on i386.

This patchset is based on v2.6.28-rc2-338-g65fc716 and has been tested
on i386.

v4:

- Re-based on mainline git tree: v2.6.28-rc2-338-g65fc716.

v3:

- Remove PAGE_SIZE alignment from relocate_kernel()

- Re-based on 2.6.28-rc2-mm1

v2:

- Rename some function names, such as alloc_page_tables ->
  machine_kexec_alloc_page_tables, etc.

- Cleanup error processing for machine_alloc_page_tables.


Best Regards,
Huang Ying

--=-PqCX37kr74nBYYzpcT7D
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkKY8kACgkQKhFGF+eHlphCwACeMGdWeChge+VXg1pvIGbflZwX
b80An0ryfgz0ttXegCkgvDLvJ6tZRU/r
=Rf4V
-----END PGP SIGNATURE-----

--=-PqCX37kr74nBYYzpcT7D--



--===============1626238851==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1626238851==--


