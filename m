Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail3.webfaction.com ([70.85.44.146])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KnHDy-0001RE-Pl
	for kexec@lists.infradead.org; Tue, 07 Oct 2008 18:23:59 +0000
Date: Tue, 7 Oct 2008 14:23:50 -0400
From: Forest Bond <forest@alittletooquiet.net>
Subject: kexec & memtest86+: inconsistent memory errors
Message-ID: <20081007182350.GD13130@storm.local.network>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1463422861=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Chris Hovious <chris.hovious@logicsupply.com>


--===============1463422861==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i7F3eY7HS/tUJxUd"
Content-Disposition: inline


--i7F3eY7HS/tUJxUd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

We've been using kexec to drop into memtest86+ for a few years now.  We run
memtest86+ from within our Linux-based hardware test suite.  This has always
worked quite well.  It was painful to get running at first (kexec was still
young then and wasn't included with our distribution's kernel), but is very=
 easy
to use now.

Unfortunately, though, we've hit a new snag with our latest platform versio=
n.
This is based on Ubuntu 8.04.

Specific software version info:

  kernel version 2.6.24-19-generic
  kexec-tools-testing 20070330 released 30th March 2007
  memtest86+ version 2.01

The problem is that memtest86+ reports numerous memory errors when booted v=
ia
kexec, booting directly into memtest86+ does not turn up these errors.

I suspect a device is getting mapped into memory and not deallocated prior =
to
kexec execution (but I may be putting my ignorance on display).

Any ideas?

Thanks,
Forest
--=20
Forest Bond
http://www.alittletooquiet.net
http://www.pytagsfs.org

--i7F3eY7HS/tUJxUd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFI66k2RO4fQQdv5AwRAt6HAJ482pQMRDVOAgXIcqva+Bnlm92jCwCgznFW
DueLmkfAMSX90IK7i2vGp6k=
=uryI
-----END PGP SIGNATURE-----

--i7F3eY7HS/tUJxUd--


--===============1463422861==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1463422861==--

