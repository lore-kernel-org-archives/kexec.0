Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from bilbo.ozlabs.org ([203.10.76.25])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1MaK3L-00056J-Bz
	for kexec@lists.infradead.org; Mon, 10 Aug 2009 01:52:04 +0000
Subject: Re: [PATCH] Do not inline putprops function
From: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <20090807145405.GB3110@in.ibm.com>
References: <20090617140514.GB31383@hmsreliant.think-freely.org>
	<20090617142652.GC4059@in.ibm.com>
	<20090617144007.GC31383@hmsreliant.think-freely.org>
	<20090623125534.GA8664@in.ibm.com>
	<20090623135604.GC1157@hmsreliant.think-freely.org>
	<1245803263.9237.3.camel@concordia> <20090803054919.GA19594@in.ibm.com>
	<20090805164938.GA2970@in.ibm.com>
	<1249568660.20200.23.camel@concordia>
	<20090807143549.GA3110@in.ibm.com> <20090807145405.GB3110@in.ibm.com>
Date: Mon, 10 Aug 2009 11:51:49 +1000
Message-Id: <1249869109.27744.41.camel@concordia>
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
Content-Type: multipart/mixed; boundary="===============1756431151=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: mohan@in.ibm.com
Cc: linuxppc-dev@ozlabs.org, Neil Horman <nhorman@redhat.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, miltonm@bga.com


--===============1756431151==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-0JeGcxyHP8j/+1A5qOHP"


--=-0JeGcxyHP8j/+1A5qOHP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2009-08-07 at 20:24 +0530, M. Mohan Kumar wrote:
> On Fri, Aug 07, 2009 at 08:05:49PM +0530, M. Mohan Kumar wrote:
> > Hi,
> >=20
> > After enabling EARLY_DEBUG (and DEBUG in some of the files in
> > arch/powerpc/kernel directory), without forcing the dtstruct variable t=
o 8
> > byte alignment:=20
> >=20
> > # ./kexec -e
> > Starting new kernel
> > console [udbg0] enabled
> >  -> early_setup(), dt_ptr: 0x7723000
> >  -> early_init_devtree(c000000007723000)
> > Invalid tag 5 scanning flattened device tree !
> > search "chosen", depth: 0, uname:
> > Invalid tag 5 scanning flattened device tree !
> > dt_root_size_cells =3D 2
> > dt_root_addr_cells =3D 2
> > Invalid tag 5 scanning flattened device tree !
> > reserving: 128c000 -> 5ec1f7
> > reserving: 7734000 -> 8cc000
> > reserving: 7723000 -> f698
> > Phys. mem: 0
> > -> move_device_tree
> > <- move_device_tree
> > Scanning CPUs ...
> > Invalid tag 5 scanning flattened device tree !
> >  <- early_init_devtree()
> > Probing machine type ...
> >   pSeries ...
> > No suitable machine found !
> >=20
> >=20
> > So device-tree is getting corrupted when dtstruct variable is not align=
ed to
> > 8 byte variable. This problem is not seen with gcc-3.4. Is it compiler
> > issue? or bug in the code.
> >=20
>=20
> I tried writing the device tree to a binary file with and without dt_len =
and
> compared the files after hexdump:

That sounds like a good idea.

> 0000 0001 2f00 0000 0000 0003 0000 0004                 0000 0001 2f00 00=
00 0000 0003 0000 0004
> 0000 0000 0000 0002 0000 0003 0000 0004                 0000 0000 0000 00=
02 0000 0003 0000 0004
> 0000 000f 0000 0002 0000 0003 0000 0004                 0000 000f 0000 00=
02 0000 0003 0000 0004
> 0000 001b 3ef1 4800 0000 0003 0000 000d                 0000 001b 3ef1 48=
00 0000 0003 0000 000d
> 0000 002b 0000 0000 4942 4d2c 3931 3135               | 0000 002b 4942 4d=
2c 3931 3135 2d35 3035
> 2d35 3035 0000 0000 0000 0003 0000 0005               | 0000 0000 0000 00=
03 0000 0005 0000 0036

So the one on the left (which is ?) - has extra padding after 0x2b,
which is the property data length, before the property value
"IBM,9115-505". There shouldn't be any padding there.

cheers

--=-0JeGcxyHP8j/+1A5qOHP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkp/fTUACgkQdSjSd0sB4dJp2gCfRPbLvGz0zdV8B46amUsUzeah
xHMAn3/nLekoM569PsDspQUi2eD+rkeK
=ho37
-----END PGP SIGNATURE-----

--=-0JeGcxyHP8j/+1A5qOHP--



--===============1756431151==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1756431151==--


