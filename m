Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from haggis.tip.net.au ([2402:b800:7003:1::20]
 helo=members.tip.net.au)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UIV77-0004tN-GS
 for kexec@lists.infradead.org; Thu, 21 Mar 2013 02:20:22 +0000
Date: Thu, 21 Mar 2013 13:20:12 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: Tree for Mar 20 (vmcore)
Message-Id: <20130321132012.e6f9a10287fb171dcd05c62d@canb.auug.org.au>
In-Reply-To: <alpine.DEB.2.02.1303201709440.23363@chino.kir.corp.google.com>
References: <20130320160536.54e62fc11a3651494b710e3b@canb.auug.org.au>
 <5149E813.8060307@infradead.org>
 <alpine.DEB.2.02.1303201153330.17761@chino.kir.corp.google.com>
 <alpine.DEB.2.02.1303201709440.23363@chino.kir.corp.google.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4512681731061203684=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: David Rientjes <rientjes@google.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, linux-next@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

--===============4512681731061203684==
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Thu__21_Mar_2013_13_20_12_+1100_3AEuIuWAOW.r+yBf"

--Signature=_Thu__21_Mar_2013_13_20_12_+1100_3AEuIuWAOW.r+yBf
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 20 Mar 2013 17:10:30 -0700 (PDT) David Rientjes <rientjes@google.co=
m> wrote:
>
> On Wed, 20 Mar 2013, David Rientjes wrote:
>=20
> > I don't think that's it, linux/kexec.h already gets included indirectly=
. =20
> > The problem is that CONFIG_KEXEC isn't set so the definition in kexec.h=
 is=20
> > meaningless.
> >=20
> > This comes from "vmcore: check NT_VMCORE_PAD as a mark indicating the e=
nd=20
> > of ELF note buffer" merged through the -mm tree.  I've added the patch'=
s=20
> > author and Andrew to the cc.
> >=20
> > How can this be protected by CONFIG_KEXEC?
>=20
> These patches were removed from -mm today so it should no longer be a=20
> problem.

What exactly are "these patches" so that I can remove them from my copy
of the mmotm tree (assuming that Andrew does not get a new mmotm released
in the next hour or so).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Thu__21_Mar_2013_13_20_12_+1100_3AEuIuWAOW.r+yBf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJRSm5cAAoJEECxmPOUX5FEBdcP/R2QqT176pmKUS79pyIpy9Jy
8MbrsGlgsrKmXOcYYJrhJKPYO5WVCUyppkM2KAYc/CNZdbrf9eaX/91L5jHTkFC3
bwvVn3Ceaa1WN9VM1zP/adYogq2QPsXlcNSSRWNq9m6u/BcfTgmVVvSEwbmiq3AF
41ruCnoYSb4YKOqdUDCt6p1ffEMPuLHN09oU8x+JQrSNzBG6ePCiph2byZVF0ojc
IfWOscKieDVdcCj32UIDhPPK8OBJUrrST4npr2pHZBFwAnvJqXZGgyIG7WK7zoeI
R8Ge6l46L6LaazlqNY40S9yJ8NZZj8zhNbDmxl8sR4AGiV05uKP2B4FgrmE+47/O
9Wm+UVq2+UKNGKUJw2ZaICgqmakXc5LM7j1VnJtOFKw45P5OUQwVYZkdUdajIVJs
FISTsL9YDMXvPof6Wqm0so0GQU9SYHNg2oB8b3vWjzglgdYQOiFje4C1ctXgqUUI
KhCZlkobt78gStLvCXR9LEF9rzziLInEyvivzvBrRvEFdp0cYkrLZ21Frw/ACH9d
x7zMoh2gTh1Mh9j1YYhBC44q3SbO0KKM1ebmOb2zjahmj4CdwsNjCckOdFntDhFy
oKrAa6y9Z+2wbLMcB4fpNtsr92AZRCWNFs9SL5G4BUQD9my9RhW+1W8jXmZM0YX+
cfoMXrlbDmtcwFV0hP/n
=Xr1I
-----END PGP SIGNATURE-----

--Signature=_Thu__21_Mar_2013_13_20_12_+1100_3AEuIuWAOW.r+yBf--


--===============4512681731061203684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============4512681731061203684==--

