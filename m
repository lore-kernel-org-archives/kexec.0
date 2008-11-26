Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga11.intel.com ([192.55.52.93])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1L5ByN-0003Yl-RZ
	for kexec@lists.infradead.org; Wed, 26 Nov 2008 04:25:56 +0000
Subject: Re: [PATCH] Fix kexec x86_64 load failed bug
From: Huang Ying <ying.huang@intel.com>
In-Reply-To: <492CC1AA.3010408@oracle.com>
References: <20081125134738.7075a13a@hale.suse.de>
	<1227662409.2442.11.camel@yhuang-dev.sh.intel.com>
	<492CC1AA.3010408@oracle.com>
Date: Wed, 26 Nov 2008 12:25:51 +0800
Message-Id: <1227673551.2442.12.camel@yhuang-dev.sh.intel.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1950176689=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Bernhard Walle <bwalle@suse.de>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>


--===============1950176689==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ElfRZrl/9KEJtHBrn6yu"


--=-ElfRZrl/9KEJtHBrn6yu
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-11-26 at 11:25 +0800, Randy Dunlap wrote:
> This isn't kernel code?  Where is /purgatory/ ?
>=20
> Anyway, for kernel code, that should be:
> char *cmdline_end =3D NULL;

This patch is against kexec tools, not kernel.

Best Regards,
Huang Ying


--=-ElfRZrl/9KEJtHBrn6yu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEUEABECAAYFAkksz80ACgkQKhFGF+eHlpjoSwCWPGwC48PQe3fNXtmiC70Vc0aQ
IACfWPCojtTalW/zW8nUrj0RwmGc8JM=
=Wd12
-----END PGP SIGNATURE-----

--=-ElfRZrl/9KEJtHBrn6yu--



--===============1950176689==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1950176689==--


