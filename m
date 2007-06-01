Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Hu7Xa-0003i3-48
	for kexec@lists.infradead.org; Fri, 01 Jun 2007 09:51:46 -0400
Date: Fri, 1 Jun 2007 15:51:27 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [RFC] makedumpfile-1.1.4-rc: ia64 DISCONTIGMEM support
Message-ID: <20070601135127.GB9804@suse.de>
References: <20070601181114oomichi@mail.jp.nec.com>
MIME-Version: 1.0
In-Reply-To: <20070601181114oomichi@mail.jp.nec.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1810768460=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: kexec@lists.infradead.org


--===============1810768460==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Ken'ichi,

* Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp> [2007-06-01 11:11]:
>=20
> The attached patch is for the development, and it isn't stable yet.
> This patch can be applied to makedumpfile version 1.1.3.
> If you find some problems in this patch, please let me know.
> If there aren't any problems, I will release a new makedumpfile
> by next weekend.
>=20
> Changelog:
> 1. Add __FUNCTION__ to ERRMSG.
>   The function name is added to ERRMSG.
> 2. Add ia64_vtop().
>   The translation function from a virtual address to a
>   physical address is added for ia64.
>   The patch was provided by Bernhard Walle.
> 3. Add ia64 DISCONTIGMEM support.
>   A new makedumpfile supports ia64 DISCONTIGMEM.
> 4. Cleanup README.
>   The destination of BUG REPORT is changed to kexec-ml.
>   The item REQUIREMENTS is added.
> 5. Fix DISCONTIGMEM bitmap.
>   This patch fixes the problem that it cannot output the part
>   of bitmap on DISCONTIGMEM kernel.
> 6. Fix ELF output with overlapping sections.
>   The patch was provided by Bernhard Walle.

thanks for your effort. I tested it here and it works well.



Thanks,
   Bernhard

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFGYCReiGU2lt2vZFQRAmLvAJ9djaNXyw8qYrk8wrFRVHhYjGjR4QCggWh4
NEEc1XQWUngSgRplU+zzfoc=
=8h1d
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--


--===============1810768460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1810768460==--

