Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1OC0ru-0006PR-36
	for kexec@lists.infradead.org; Wed, 12 May 2010 01:36:14 +0000
Subject: Re: [PATCH 2/2] powerpc,kexec: Speedup kexec hpte tear down
From: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <9537.1273626418@neuling.org>
References: <20100511062826.E1C49D3340@localhost.localdomain>
	<1273561463.9209.138.camel@concordia> <30983.1273620594@neuling.org>
	<1273624565.5738.8.camel@concordia> <7247.1273624988@neuling.org>
	<20100512010003.GB3548@drongo>  <9537.1273626418@neuling.org>
Date: Wed, 12 May 2010 11:36:11 +1000
Message-ID: <1273628171.5738.36.camel@concordia>
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
Content-Type: multipart/mixed; boundary="===============0520828576=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Michael Neuling <mikey@neuling.org>
Cc: kexec@lists.infradead.org, Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>, linuxppc-dev@ozlabs.org


--===============0520828576==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-bu56UQMJhGcW/DJfYuf8"


--=-bu56UQMJhGcW/DJfYuf8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2010-05-12 at 11:06 +1000, Michael Neuling wrote:
> > > We probably only do the remove on < 1% of the hptes now.  So I doubt =
we
> > > would get a speedup since most of the time we aren't do the remove
> > > anymore.
> >=20
> > It would be nice to have some actual numbers.  Could you add some
> > counters and print the results at the end?  (Or don't you have any
> > way to print things at that stage?)
>=20
> Printing is hard at that point but I think we can do it.  I'll try to
> when I get some time.

A version of udbg_putcLP() that uses a raw hcall should work, or there
was code added to purgatory recently to print to the HV console which
you could nick.

> A heavily loaded system which kdumps will need a lot more hptes removes
> than kexec, so stats for both these cases might be useful also.

Yeah, or even a system that is kexec'ed while lots of stuff is still
running.

cheers



--=-bu56UQMJhGcW/DJfYuf8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkvqBgsACgkQdSjSd0sB4dKSBgCfZD3RoXWXft7f8agnCUQbU/Qq
7/YAn3f/X+Vghs1inbGC4/U57qS/IbaS
=34Ff
-----END PGP SIGNATURE-----

--=-bu56UQMJhGcW/DJfYuf8--



--===============0520828576==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0520828576==--


