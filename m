Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <b35922dfd7f62489d35ab15362891a90bf46c3d2.camel@suse.de>
Subject: Re: [PATCH v4 7/8] linux/log2.h: Fix 64bit calculations in
 roundup/down_pow_two()
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Date: Thu, 12 Dec 2019 14:16:27 +0100
In-Reply-To: <20191205223044.GA250573@google.com>
References: <20191205223044.GA250573@google.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1584875826772588478=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, "J. Bruce Fields" <bfields@fieldses.org>, linux-nfs@vger.kernel.org, Edward Cree <ecree@solarflare.com>, linux-clk@vger.kernel.org, f.fainelli@gmail.com, Herbert Xu <herbert@gondor.apana.org.au>, Emilio =?ISO-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>, maz@kernel.org, Joerg Roedel <joro@8bytes.org>, phil@raspberrypi.org, Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, Chen-Yu Tsai <wens@csie.org>, Chuck Lever <chuck.lever@oracle.com>, Martin Habets <mhabets@solarflare.com>, wahrenst@gmx.net, Tom Lendacky <thomas.lendacky@amd.com>, Jiri Pirko <jiri@resnulli.us>, Solarflare linux maintainers <linux-net-drivers@solarflare.com>, Maxime Ripard <mripard@kernel.org>, linux-rpi-kernel@lists.infradead.org, Anna Schumaker <anna.schumaker@netapp.com>, Trond Myklebust <trond.myklebust@hammerspace.com>, linux-arm-kernel@lists.infradead.org, Mirko Lindner <mlindner@marvell.com>, Mike Marciniszyn <mike.marciniszyn@intel.com>, mbrugger@suse.com, Stephen Boyd <sboyd@kernel.org>, netdev@vger.kernel.org, Yishai Hadas <yishaih@mellanox.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, jeremy.linton@arm.com, "David
 S. Miller" <davem@davemloft.net>, Stephen Hemminger <stephen@networkplumber.org>, linux-rdma@vger.kernel.org, iommu@lists.linux-foundation.org, Moni Shoua <monis@mellanox.com>, Eric Biederman <ebiederm@xmission.com>, james.quinlan@broadcom.com, Thomas Graf <tgraf@suug.ch>, andrew.murray@arm.com, Robin Murphy <robin.murphy@arm.con>, David Woodhouse <dwmw2@infradead.org>, Dennis Dalessandro <dennis.dalessandro@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>


--===============1584875826772588478==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-vpJ9shRBsDfxzY4jD4N5"


--=-vpJ9shRBsDfxzY4jD4N5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-12-05 at 16:30 -0600, Bjorn Helgaas wrote:
> You got the "n" on "down" in the subject, but still missing "of" ;)

Yes, sorry about that, I tend to re-read what I meant to say instead of wha=
t
it's actually written.

> On Tue, Dec 03, 2019 at 12:47:40PM +0100, Nicolas Saenz Julienne wrote:
> > Some users need to make sure their rounding function accepts and return=
s
> > 64bit long variables regardless of the architecture. Sadly
> > roundup/rounddown_pow_two() takes and returns unsigned longs. It turns
> > out ilog2() already handles 32/64bit calculations properly, and being
> > the building block to the round functions we can rework them as a
> > wrapper around it.
>=20
> Missing "of" in the function names here.
> s/a wrapper/wrappers/

Noted

> IIUC the point of this is that roundup_pow_of_two() returned
> "unsigned long", which can be either 32 or 64 bits (worth pointing
> out, I think), and many callers need something that returns
> "unsigned long long" (always 64 bits).

I'll update the commit message to be a more explicit.

> It's a nice simplification to remove the "__" variants.  Just as a
> casual reader of this commit message, I'd like to know why we had both
> the roundup and the __roundup versions in the first place, and why we
> no longer need both.

So, the commit that introduced it (312a0c170945b) meant to use the '__' var=
iant
as a helper, but, due to the fact this is a header file, some found it and =
made
use of it. I went over some if the commits introducing '__' usages and none=
 of
them seem to acknowledge its use as opposed to the macro version. I think i=
t's
fair to say it's a case of cargo-culting.

> > -#define roundup_pow_of_two(n)			\
> > -(						\
> > -	__builtin_constant_p(n) ? (		\
> > -		(n =3D=3D 1) ? 1 :			\
> > -		(1UL << (ilog2((n) - 1) + 1))	\
> > -				   ) :		\
> > -	__roundup_pow_of_two(n)			\
> > - )
> > +#define roundup_pow_of_two(n)			  \
> > +(						  \
> > +	(__builtin_constant_p(n) && ((n) =3D=3D 1)) ? \
> > +	1 : (1ULL << (ilog2((n) - 1) + 1))        \
> > +)
>=20
> Should the resulting type of this expression always be a ULL, even
> when n=3D=3D1, i.e., should it be this?
>=20
>   1ULL : (1ULL << (ilog2((n) - 1) + 1))        \
>=20
> Or maybe there's no case where that makes a difference?

It should be 1ULL on either case.

Regards,
Nicolas


--=-vpJ9shRBsDfxzY4jD4N5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl3yPasACgkQlfZmHno8
x/4qrgf9GTaIX4ZRG0TCYwOuyJCzR/7cg3GMSsuHo8bknRFfBKmZUwtS0JmNNrn7
f1Av7IZ0OAbAWPJQkzOXw4OxNhVxq0ItdXAktetVKaF6U5Dz/5tWkkwHLFdhSepV
FcS4qxWo8nOugcgYRzN6kDaihMFUqbAIioU7n1HGLRGN2s9vaJM1rNmOrGMPovU3
BbGTs4/7BMM3FmqoGwWUKX5FPFNamYrxAaaOknMUVa16iI7MN7hYH5scWUUK56ER
57y4jC6vGu17Cku4HBlynsoZpm6z6SvHDoXIMZCbUKbJogsiQo+b1+cZTWLVGi2P
qQGX/jHjIhYWNVa2Le9F3qgxxmf0uA==
=hg1F
-----END PGP SIGNATURE-----

--=-vpJ9shRBsDfxzY4jD4N5--



--===============1584875826772588478==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1584875826772588478==--


