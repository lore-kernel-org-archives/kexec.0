Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([103.22.144.67])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aiaA4-0007cP-9E
 for kexec@lists.infradead.org; Wed, 23 Mar 2016 04:12:49 +0000
Date: Wed, 23 Mar 2016 15:10:26 +1100
From: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [PATCH 1/3] Pass struct mem_sym into machine_apply_elf_rel()
Message-ID: <20160323041025.GP46309@thor.bakeyournoodle.com>
References: <20160226180311.2938d804@kryten>
MIME-Version: 1.0
In-Reply-To: <20160226180311.2938d804@kryten>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4984021146119431233=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Alan Modra <amodra@gmail.com>, Simon Horman <horms@verge.net.au>, Anton Blanchard <anton@samba.org>, Bill Schmidt <wschmidt@us.ibm.com>


--===============4984021146119431233==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xNm6VWMD3PcA105u"
Content-Disposition: inline


--xNm6VWMD3PcA105u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 26, 2016 at 06:03:11PM +1100, Anton Blanchard wrote:
> On PowerPC64 ABIv2 we need to look at the symbol to determine
> if it has a local entry point. Pass struct mem_sym into
> machine_apply_elf_rel() so we can.
>=20
> Signed-off-by: Anton Blanchard <anton@samba.org>

Anton, Alan and Bill clearly know this stuff inside and out but can we get a
review from other PPC folks ?

It'd be awesom to see this merged in distros.

Tony.

--xNm6VWMD3PcA105u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW8hcxAAoJELsOJpO+HXxJxCwIAJ791NO715u1xx8f6f0W19ep
FakpuL8OVXgpJ0vqo8yPx6RyxSu4o7VJWskXcK3CXEoVvWosNkw7yH8wVLvLBXXf
brm7VRVCbxM82VhaixnmCwKBZPfAT0eKM/93w8grqY9An8vQPFthVzQsTgXpkee2
HUCVuAlvkwCQ/h1RVE8pcpm9JhZqE21YcHC1MA8TdCIqH2zRbpmxlJs6Xpt5pqAs
b7Bslz/hHb7q2C8r6he2Poji6v4SM8CZ1CsiYFdOphyEbgBelMefXZFVAkONv0Jy
QJyR+bFjDhLVYNG0ziWDl8Jc0PJ3MYyB6aW6oAWuXeTW2UjUJd5DM2OfUVrUj3k=
=LrGn
-----END PGP SIGNATURE-----

--xNm6VWMD3PcA105u--


--===============4984021146119431233==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============4984021146119431233==--

