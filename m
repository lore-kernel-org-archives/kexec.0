Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from bilbo.ozlabs.org ([203.10.76.25])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1MZ3tJ-0008C2-S6
	for kexec@lists.infradead.org; Thu, 06 Aug 2009 14:24:30 +0000
Subject: Re: [PATCH] Do not inline putprops function
From: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <20090805164938.GA2970@in.ibm.com>
References: <1245241595.4269.15.camel@concordia>
	<20090617130413.GB2774@localhost.localdomain>
	<20090617133435.GB4059@in.ibm.com>
	<20090617140514.GB31383@hmsreliant.think-freely.org>
	<20090617142652.GC4059@in.ibm.com>
	<20090617144007.GC31383@hmsreliant.think-freely.org>
	<20090623125534.GA8664@in.ibm.com>
	<20090623135604.GC1157@hmsreliant.think-freely.org>
	<1245803263.9237.3.camel@concordia> <20090803054919.GA19594@in.ibm.com>
	<20090805164938.GA2970@in.ibm.com>
Date: Fri, 07 Aug 2009 00:24:20 +1000
Message-Id: <1249568660.20200.23.camel@concordia>
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
Content-Type: multipart/mixed; boundary="===============1979048582=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: mohan@in.ibm.com
Cc: linuxppc-dev@ozlabs.org, Neil Horman <nhorman@redhat.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, miltonm@bga.com


--===============1979048582==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-2VJu83n7jjuqsVREaLR4"


--=-2VJu83n7jjuqsVREaLR4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-08-05 at 22:19 +0530, M. Mohan Kumar wrote:
> Hi,
>=20
> When I align the dtstruct variable to 8 bytes, I am able to invoke kdump.
>=20
> When the line
> 	static unsigned dtstruct[TREEWORDS], *dt;
> changed to=20
> 	static unsigned dtstruct[TREEWORDS] __attribute__ ((aligned (8))), *dt;
>=20
> kexec-tool works.

Hmm, odd.

Can you check how it's aligned without your change? ie. in the original
binary, is it 4 byte aligned?

When you make the change, is the only thing that changes in the binary
the alignedness of dtstruct, or does it cause other things to move
around?

I don't think an unaligned dt blob should have any effect on the kernel,
ie. it should copy it in fine, but I'd have to look at the code.

cheers

--=-2VJu83n7jjuqsVREaLR4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkp655QACgkQdSjSd0sB4dJuXwCfVJK7BSEqe7YKDSjxu+ZWyJLV
qBUAn3xYesv3ml8hG97w2HG0HssSops2
=xnLC
-----END PGP SIGNATURE-----

--=-2VJu83n7jjuqsVREaLR4--



--===============1979048582==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1979048582==--


