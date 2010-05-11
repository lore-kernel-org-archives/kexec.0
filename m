Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1OBjW1-0001gV-5s
	for kexec@lists.infradead.org; Tue, 11 May 2010 07:04:29 +0000
Subject: Re: [PATCH 2/2] powerpc,kexec: Speedup kexec hpte tear down
From: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <20100511062826.E1C49D3340@localhost.localdomain>
References: <20100511062826.E1C49D3340@localhost.localdomain>
Date: Tue, 11 May 2010 17:04:23 +1000
Message-ID: <1273561463.9209.138.camel@concordia>
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
Content-Type: multipart/mixed; boundary="===============0930903384=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Michael Neuling <mikey@neuling.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, kexec@lists.infradead.org, Anton Blanchard <anton@samba.org>, linuxppc-dev@ozlabs.org


--===============0930903384==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-S056dRzmrEHDBzKyyTOs"


--=-S056dRzmrEHDBzKyyTOs
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2010-05-11 at 16:28 +1000, Michael Neuling wrote:
> Currently for kexec the PTE tear down on 1TB segment systems normally
> requires 3 hcalls for each PTE removal. On a machine with 32GB of
> memory it can take around a minute to remove all the PTEs.
>=20
..
> -	/* TODO: Use bulk call */

...
> +	/* Read in batches of 4,
> +	 * invalidate only valid entries not in the VRMA
> +	 * hpte_count will be a multiple of 4
> +         */
> +	for (i =3D 0; i < hpte_count; i +=3D 4) {
> +		lpar_rc =3D plpar_pte_read_4_raw(0, i, (void *)ptes);
> +		if (lpar_rc !=3D H_SUCCESS)
> +			continue;
> +		for (j =3D 0; j < 4; j++){
> +			if ((ptes[j].pteh & HPTE_V_VRMA_MASK) =3D=3D
> +				HPTE_V_VRMA_MASK)
> +				continue;
> +			if (ptes[j].pteh & HPTE_V_VALID)
> +				plpar_pte_remove_raw(0, i + j, 0,
> +					&(ptes[j].pteh), &(ptes[j].ptel));
>  		}

Have you tried using the bulk remove call, if none of the HPTEs are for
the VRMA? Rumour was it was slower/the-same, but that may have been
apocryphal.

cheers

--=-S056dRzmrEHDBzKyyTOs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkvpAXYACgkQdSjSd0sB4dKXawCeJ7V3TcQtShH5hjQn4YCKEN3V
C6IAoL6p36Q1m0kH1tnY7k3hevShl1WP
=OLqj
-----END PGP SIGNATURE-----

--=-S056dRzmrEHDBzKyyTOs--



--===============0930903384==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0930903384==--


