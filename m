Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from bilbo.ozlabs.org ([203.10.76.25])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1MJGL7-0007Pn-R6
	for kexec@lists.infradead.org; Wed, 24 Jun 2009 00:27:57 +0000
Subject: Re: [PATCH] Do not inline putprops function
From: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <20090623135604.GC1157@hmsreliant.think-freely.org>
References: <20090617113456.GC31595@in.ibm.com>
	<20090617114551.GA5672@verge.net.au>
	<20090617115917.GD31595@in.ibm.com>
	<1245241595.4269.15.camel@concordia>
	<20090617130413.GB2774@localhost.localdomain>
	<20090617133435.GB4059@in.ibm.com>
	<20090617140514.GB31383@hmsreliant.think-freely.org>
	<20090617142652.GC4059@in.ibm.com>
	<20090617144007.GC31383@hmsreliant.think-freely.org>
	<20090623125534.GA8664@in.ibm.com>
	<20090623135604.GC1157@hmsreliant.think-freely.org>
Date: Wed, 24 Jun 2009 10:27:43 +1000
Message-Id: <1245803263.9237.3.camel@concordia>
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
Content-Type: multipart/mixed; boundary="===============0632928810=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Neil Horman <nhorman@redhat.com>
Cc: linuxppc-dev@ozlabs.org, "M. Mohan Kumar" <mohan@in.ibm.com>, kexec@lists.infradead.org, miltonm@bga.com, Simon Horman <horms@verge.net.au>


--===============0632928810==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-ggNhO6RKgPj9FrJxG8iU"


--=-ggNhO6RKgPj9FrJxG8iU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-06-23 at 09:56 -0400, Neil Horman wrote:
> On Tue, Jun 23, 2009 at 06:25:34PM +0530, M. Mohan Kumar wrote:
> > On Wed, Jun 17, 2009 at 10:40:07AM -0400, Neil Horman wrote:
> > =20
> > > > send objdump of fs2dt.o with and without this assignment.
> > > >=20
> > > That would be a fine thing to do, and I'd be happy to compare them.  =
My though
> > > regarding the comparison of the device tree on a good and bad run was=
 meant to
> > > expidite what change in the assembly we'd be looking for.  If its the=
 kdump
> > > kernel boot thats hanging, Its likely hanging on something in the dev=
ice tree,
> > > as thats whats being manipulated by this code.  So I figure that unde=
rstanding
> > > whats changed there will point us toward what change in the assembly =
might be
> > > responsible for the hang.  The assmebly's going to be signficantly di=
fferent
> > > (lots of optimization might be lost from no longer inlining a functio=
n), so
> > > anything that helps us narrow down whats changed will be good
> >=20
> > I am attaching the objdumps of fs2dt with and without dt_len.
> >=20
> Well it definately looks like removing that variable had some code change=
s.
> It'll take some time to match it up to source, but Most interesting I thi=
nk is
> the variance in putprops around address f34.  Looks like its doing some s=
tring
> maniuplation in a reversed order, using a huge offset.  Might be worthwhi=
le to
> check to see if theres any string overruns in this code.

Yeah I still suspect it's just a bug in the code that's being exposed
now.

Mohan, can you try running it under valgrind?

cheers

--=-ggNhO6RKgPj9FrJxG8iU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkpBcv8ACgkQdSjSd0sB4dIrYgCeOc0NKJAe0vj8YBryzOSF47S1
6o0AoIwG689eO7S+Neae/5wgpE8f1Ydn
=xAmA
-----END PGP SIGNATURE-----

--=-ggNhO6RKgPj9FrJxG8iU--



--===============0632928810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0632928810==--


