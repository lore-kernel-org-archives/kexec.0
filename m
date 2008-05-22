Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JzgD1-0006Up-EO
	for kexec@lists.infradead.org; Fri, 23 May 2008 22:58:00 +0000
Received: from yukiko.shinjuku.tokyo.vergenet.net (unknown [202.128.119.59])
	by koto.vergenet.net (Postfix) with ESMTP id 425093406B
	for <kexec@lists.infradead.org>; Sat, 24 May 2008 07:57:55 +0900 (JST)
Resent-Message-ID: <20080523225752.GC4517@verge.net.au>
Resent-To: kexec@lists.infradead.org
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JzAvv-0007ew-P0
	for kexec@lists.infradead.org; Thu, 22 May 2008 13:34:17 +0000
Date: Thu, 22 May 2008 15:34:03 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [RFC] Win32 port of the userspace tools using MinGW.
Message-ID: <20080522153403.1e6e714a@kopernikus.site>
In-Reply-To: <20080516054813.GA21670@oh.minilop.net>
References: <20080516054813.GA21670@oh.minilop.net>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1951032544=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Jamey Sharp <jamey@thetovacompany.com>
Cc: kexec@lists.infradead.org

--===============1951032544==
Content-Type: multipart/signed; boundary="Sig_/au/0MU7oTczgi9VwOrPE.E2";
	protocol="application/pgp-signature"; micalg=PGP-SHA1

--Sig_/au/0MU7oTczgi9VwOrPE.E2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

* Jamey Sharp <jamey@thetovacompany.com> [2008-05-15 22:48]:
>
> OK, I haven't quite gotten around to posting the Windows kernel driver
> source that goes with this.

Do you plan to release the driver sources? Is there a driver binary
available for now?

> +
> +	if(memory_range)
> +	{
> +		*range =3D memory_range;
> +		*ranges =3D memory_ranges;
> +		return 0;
> +	}

I think you should use the kernel coding style here, i.e. the '{' in
the same line as the 'if'.



	Bernhard

--Sig_/au/0MU7oTczgi9VwOrPE.E2
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFINXZMiGU2lt2vZFQRAkrkAKCqpRLqA4JpAxQb88j5gX+QVKlOPgCgiwIi
ZLW8rQieUwjPc/BBk9wLJt4=
=2ehA
-----END PGP SIGNATURE-----

--Sig_/au/0MU7oTczgi9VwOrPE.E2--



--===============1951032544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1951032544==--


