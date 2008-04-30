Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JrLXn-0000s7-PX
	for kexec@lists.infradead.org; Wed, 30 Apr 2008 23:17:01 +0000
Subject: Re: [PATCH] Make extended crashkernel= syntax less confusing
From: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <20080430112915.f56d8815.akpm@linux-foundation.org>
References: <a8d9dc7f83b9c34d9e0165503b323a7f32b00260.1209519344.git.michael@ellerman.id.au>
	<20080430112915.f56d8815.akpm@linux-foundation.org>
Date: Thu, 01 May 2008 09:16:30 +1000
Message-Id: <1209597390.7592.4.camel@localhost>
Mime-Version: 1.0
Reply-To: michael@ellerman.id.au
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0148559405=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: bwalle@suse.de, kexec@lists.infradead.org


--===============0148559405==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-k7mTRr7MGYrzCHKz9DlB"


--=-k7mTRr7MGYrzCHKz9DlB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-04-30 at 11:29 -0700, Andrew Morton wrote:
> On Wed, 30 Apr 2008 11:36:27 +1000 (EST)
> Michael Ellerman <michael@ellerman.id.au> wrote:
>=20
> > The extended crashkernel syntax is a little confusing in the
> > way it handles ranges. eg:
> >=20
> >  crashkernel=3D512M-2G:64M,2G-:128M
> >=20
> > Means if the machine has between 512M and 2G of memory the
> > crash region should be 64M, and if the machine has 2G of
> > memory the region should be 64M. Only if the machine has
> > more than 2G memory will 128M be allocated.
> >=20
> > Although that semantic is correct, it is somewhat baffling.
> > Instead I propose that the end of the range means the first
> > address past the end of the range, ie: 512M up to but not
> > including 2G.
> >=20
> > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> > Acked-by: Bernhard Walle <bwalle@suse.de>
> > ---
> >=20
> >  kernel/kexec.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >=20
> > diff --git a/kernel/kexec.c b/kernel/kexec.c
> > index 6782dce..0ab5e33 100644
> > --- a/kernel/kexec.c
> > +++ b/kernel/kexec.c
> > @@ -1217,7 +1217,7 @@ static int __init parse_crashkernel_mem(char 			*=
cmdline,
> >  		}
> > =20
> >  		/* match ? */
> > -		if (system_ram >=3D start && system_ram <=3D end) {
> > +		if (system_ram >=3D start && system_ram < end) {
> >  			*crash_size =3D size;
> >  			break;
> >  		}
>=20
> I'm a bit surprised to see the code being updated but not the
> documentation.  Were they out of sync before or are they out of sync afte=
r
> this patch or were they always in sync or what?

Well I think my patch makes the code match the documentation, but it
depends on how you interpret "between xM and yM".

Bernhard's patch to make it explicit is a good idea though.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-k7mTRr7MGYrzCHKz9DlB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIGP3OdSjSd0sB4dIRAgZpAKCDdhG3LidW+O4xzB0bcOI7UH6RPwCeOozL
Ct7YgcPrkHdqmMD3C04iQko=
=hwcK
-----END PGP SIGNATURE-----

--=-k7mTRr7MGYrzCHKz9DlB--



--===============0148559405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0148559405==--


