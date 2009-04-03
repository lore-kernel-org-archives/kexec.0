Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from bilbo.ozlabs.org ([203.10.76.25])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1LpWta-0006ol-5a
	for kexec@lists.infradead.org; Fri, 03 Apr 2009 00:04:54 +0000
Subject: Re: [Cbe-oss-dev] kexec trouble with gcc-4.3
From: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <49D506BB.9030409@am.sony.com>
References: <49D506BB.9030409@am.sony.com>
Date: Fri, 03 Apr 2009 11:04:25 +1100
Message-Id: <1238717065.6227.5.camel@localhost>
Mime-Version: 1.0
Reply-To: michael@ellerman.id.au
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0971617312=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: kexec@lists.infradead.org, cbe-oss-dev@ozlabs.org


--===============0971617312==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-UkOvaWyGFnINc4TBti+0"


--=-UkOvaWyGFnINc4TBti+0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2009-04-02 at 11:40 -0700, Geoff Levand wrote:
> Hi,
>=20
> I tried building kexec with gcc-4.3 from the cell sdk-3.1
> and the resulting binary didn't work correctly.  It works
> OK with the gcc-4.1 from the same (sdk-3.1).

You mean building kexec-tools? Or building the kernel?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-UkOvaWyGFnINc4TBti+0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAknVUokACgkQdSjSd0sB4dJoNACdEi888IJTtbmRAnIRvaCT86AB
SaoAn35JuEh+Au/nTuemHM3WDdU77uMs
=MeEB
-----END PGP SIGNATURE-----

--=-UkOvaWyGFnINc4TBti+0--



--===============0971617312==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0971617312==--


