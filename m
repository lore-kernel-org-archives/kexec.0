Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JvYF2-0003G1-Ad
	for kexec@lists.infradead.org; Mon, 12 May 2008 13:39:00 +0000
Date: Mon, 12 May 2008 15:38:49 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] Add --reuse-cmdline
Message-ID: <20080512153849.74753e71@kopernikus.site>
In-Reply-To: <19164.1210353205@neuling.org>
References: <20080508204943.GA24160@suse.de>
	<19164.1210353205@neuling.org>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1454703601=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Michael Neuling <mikey@neuling.org>
Cc: kexec@lists.infradead.org

--===============1454703601==
Content-Type: multipart/signed; boundary="Sig_/XVYJV.ZkU.f5R3y3b_UR6.k";
	protocol="application/pgp-signature"; micalg=PGP-SHA1

--Sig_/XVYJV.ZkU.f5R3y3b_UR6.k
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

at first thanks for looking at the patch.

* Michael Neuling <mikey@neuling.org> [2008-05-09 12:13]:
>=20
> In message <20080508204943.GA24160@suse.de> you wrote:
> > This patch adds an option "--reuse-cmdline" for people that are lazy in=
 typin
> g
> > --append=3D"$(cat /proc/cmdline)". The advantage of "--reuse-cmdline" i=
s also t
> hat
> > it strips off BOOT_IMAGE (since it may not be correct any more) from li=
lo and
> > other boot loaders, and, more important, the crashkernel option in case=
 a
> > panic kernel is loaded.
> >=20
> > If you like the option I can also add it for really all architectures. =
Tested
>  only
> > with x86-bzImage both the kexec and kdump case.
>=20
> For ppc64, the default is to reuse the command line.  We should probably
> merge functionality.

Where is that functionality implemented? I couldn't find it. Does the
kernel that automatically on PPC64? I know too litte about that
architecture.

> Either way, this should probably be a generic option, not x86 specific.

Well, I thought first of it. But since the '--append' parameter is not
generic, this makes no sense.

Maybe it would make sense to change the command line handling in
general to be global and not image specific, but first I need to
understand how that works on PPC64 ... (and probably others).



	Bernhard

--Sig_/XVYJV.ZkU.f5R3y3b_UR6.k
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFIKEhsiGU2lt2vZFQRAkquAKCDUisShyRAufQGM/59/+YzdZ294gCaAg6A
VjPQVtXccsdh8xbtQ0l0e3U=
=sEBi
-----END PGP SIGNATURE-----

--Sig_/XVYJV.ZkU.f5R3y3b_UR6.k--


--===============1454703601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1454703601==--

