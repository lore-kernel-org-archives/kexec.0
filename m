Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail3.webfaction.com ([70.85.44.146])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KusQ7-0005ls-NE
	for kexec@lists.infradead.org; Tue, 28 Oct 2008 17:31:56 +0000
Date: Tue, 28 Oct 2008 13:31:46 -0400
From: Forest Bond <forest@alittletooquiet.net>
Subject: Re: kexec & memtest86+: inconsistent memory errors
Message-ID: <20081028173146.GA9750@storm.local.network>
References: <20081007182350.GD13130@storm.local.network>
MIME-Version: 1.0
In-Reply-To: <20081007182350.GD13130@storm.local.network>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0524146414=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Chris Hovious <chris.hovious@logicsupply.com>


--===============0524146414==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 07, 2008 at 02:23:50PM -0400, Forest Bond wrote:
> We've been using kexec to drop into memtest86+ for a few years now.  We r=
un
> memtest86+ from within our Linux-based hardware test suite.  This has alw=
ays
> worked quite well.  It was painful to get running at first (kexec was sti=
ll
> young then and wasn't included with our distribution's kernel), but is ve=
ry easy
> to use now.
>=20
> Unfortunately, though, we've hit a new snag with our latest platform vers=
ion.
> This is based on Ubuntu 8.04.
>=20
> Specific software version info:
>=20
>   kernel version 2.6.24-19-generic
>   kexec-tools-testing 20070330 released 30th March 2007
>   memtest86+ version 2.01
>=20
> The problem is that memtest86+ reports numerous memory errors when booted=
 via
> kexec, booting directly into memtest86+ does not turn up these errors.
>=20
> I suspect a device is getting mapped into memory and not deallocated prio=
r to
> kexec execution (but I may be putting my ignorance on display).
>=20
> Any ideas?

Can anyone confirm that my suspicions about this might be correct?  Can any=
one
recommend troubleshooting techniques?

Thanks,
Forest
--=20
Forest Bond
http://www.alittletooquiet.net
http://www.pytagsfs.org

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFJB0yCRO4fQQdv5AwRAnWNAJ4+adl3ntBTxsbCYJ8J3/x1hZo9UgCg2xpq
6Wlz8XqcyW85IHwLlkeUEVQ=
=5xoh
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--


--===============0524146414==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0524146414==--

