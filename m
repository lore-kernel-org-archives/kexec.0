Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from bilbo.ozlabs.org ([203.10.76.25])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1MGuE0-0007vW-2j
	for kexec@lists.infradead.org; Wed, 17 Jun 2009 12:26:55 +0000
Subject: Re: [PATCH] Do not inline putprops function
From: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <20090617115917.GD31595@in.ibm.com>
References: <20090617113456.GC31595@in.ibm.com>
	<20090617114551.GA5672@verge.net.au>
	<20090617115917.GD31595@in.ibm.com>
Date: Wed, 17 Jun 2009 22:26:35 +1000
Message-Id: <1245241595.4269.15.camel@concordia>
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
Content-Type: multipart/mixed; boundary="===============0466005442=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: mohan@in.ibm.com
Cc: linuxppc-dev@ozlabs.org, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, miltonm@bga.com


--===============0466005442==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-5Rg9Pwn15+VvVi8FWhQm"


--=-5Rg9Pwn15+VvVi8FWhQm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-06-17 at 17:29 +0530, M. Mohan Kumar wrote:
> Do not inline putprops function
>=20
> With the recent kexec-tools git tree, both kexec and kdump kernels hang (=
i.e
> kexec -l and kexec -p respectively). This happened after the patch "ppc64=
:
> cleanups" commit b43a84a31a4be6ed025c1bdef3bb1c3c12e01b16. I tried
> reverting each hunk and then found out that retaining following lines in
> fs2dt.c makes kexec/kdump work.
>=20
> -static unsigned *dt_len; /* changed len of modified cmdline
> -                           in flat device-tree */
>=20
> [....]
>=20
> -               dt_len =3D dt;
>=20
> I don't have any clue why removing a unused variable would cause the kexe=
c
> kernel to hang. After further investigation, I observed that if the putpr=
ops
> function is not inlined, kexec/kdump kernel would work even after removin=
g
> the above lines.
>=20
> This patch directs gcc to not inline the putprops function. Now we could
> invoke kexec and kdump kernels.

What compiler version are you using? Does the behaviour change if you
use a newer/older compiler? It sounds to me like there's some deeper bug
and your patch is just papering over it.

cheers

--=-5Rg9Pwn15+VvVi8FWhQm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAko44PsACgkQdSjSd0sB4dJ5MQCfaDXTPJjZgiB0XajA00U+rBt1
ctAAoKL4oFogfSyYVilZ6ubJziQ9rhtN
=gJIX
-----END PGP SIGNATURE-----

--=-5Rg9Pwn15+VvVi8FWhQm--



--===============0466005442==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0466005442==--


