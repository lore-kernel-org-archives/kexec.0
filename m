Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1OCWw1-0005lQ-7n
	for kexec@lists.infradead.org; Thu, 13 May 2010 11:50:37 +0000
Subject: Re: [PATCH 1/2] Fix kexec on powerpc32
From: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <alpine.DEB.2.01.1005130417590.3356@bogon.housecafe.de>
References: <20100511174749.19309.44615.stgit@muvarov>
	<4BEA5726.50806@nerdbynature.de>
	<alpine.DEB.2.01.1005130417590.3356@bogon.housecafe.de>
Date: Thu, 13 May 2010 21:50:32 +1000
Message-ID: <1273751432.8067.1.camel@concordia>
Mime-Version: 1.0
Reply-To: michael@ellerman.id.au
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1814635965=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Christian Kujau <lists@nerdbynature.de>
Cc: Maxim Uvarov <muvarov@gmail.com>, linuxppc-dev@lists.ozlabs.org, uvarov@dev.rtsoft.ru, kexec@lists.infradead.org, horms@verge.net.au


--===============1814635965==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-P0oH1J4HhofOD3Z4wucS"


--=-P0oH1J4HhofOD3Z4wucS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-05-13 at 04:19 -0700, Christian Kujau wrote:
> On Wed, 12 May 2010 at 00:22, Christian Kujau wrote:
> > # kexec -e
> > Starting new kernel
> > Bye!
> >=20
> > ....but then the system just hung there, no more messages, I had to
> > powercycle it.
>=20
> Are there any debug flags (or kernel options?) I can set, to find out why=
=20
> it hangs here? Or does kexec not understand zImages?

Not really. There's extra debugging on some systems (with a hypervisor
console). I think you're on 32-bit, which means I don't really know what
I'm talking about, but I don't think zImage works - use vmlinux.

cheers

--=-P0oH1J4HhofOD3Z4wucS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkvr54UACgkQdSjSd0sB4dKl3ACfQra7xtusbUVD6mhuUnRjyDvI
pKwAnicfAryKO2bDkhQSbiU1Ve1cVXsq
=MnSc
-----END PGP SIGNATURE-----

--=-P0oH1J4HhofOD3Z4wucS--



--===============1814635965==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1814635965==--


