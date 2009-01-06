Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1LKLao-000333-Jt
	for kexec@lists.infradead.org; Tue, 06 Jan 2009 23:44:15 +0000
Subject: Re: [PATCH] powerpc: check crash_base for relocatable kernel
From: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <kexec-29-1-7.miltonm@bga.com>
References: <kexec-29-1-7.miltonm@bga.com>
Date: Wed, 07 Jan 2009 10:44:02 +1100
Message-Id: <1231285442.8292.10.camel@localhost>
Mime-Version: 1.0
Reply-To: michael@ellerman.id.au
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0243352825=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Milton Miller <miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>, kexec@lists.infradead.org, "M.MohanK" <"umar mohan"@in.ibm.com>


--===============0243352825==
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-FFqWjNFUZYKxLEfaXwl3"


--=-FFqWjNFUZYKxLEfaXwl3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2009-01-02 at 14:46 -0600, Milton Miller wrote:
> @@ -94,10 +95,35 @@ void __init reserve_crashkernel(void)
>  				KDUMP_KERNELBASE);
> =20
>  	crashk_res.start =3D KDUMP_KERNELBASE;
> +#else
> +	if (!crashk_res.start) {
> +		/*
> +		 * unspecified address, choose a region of specified size
> +		 * can overlap with initrd (ignoring corruption when retained)
> +		 * ppc64 requires kernel and some stacks to be in first segemnt
> +		 */
> +		crashk_res.start =3D KDUMP_KERNELBASE;
> +	}
> +
> +	crash_base =3D PAGE_ALIGN(crashk_res.start);
> +	if (crash_base !=3D crashk_res.start) {
> +		printk("Crash kernel base must be aligned to 0x%lx\n",
> +				PAGE_SIZE);
> +		crashk_res.start =3D crash_base;
> +	}
> +
>  #endif
>  	crash_size =3D PAGE_ALIGN(crash_size);
>  	crashk_res.end =3D crashk_res.start + crash_size - 1;
> =20
> +	/* The crash region must not overlap the current kernel */
> +	if (overlaps_crashkernel(__pa(_stext), _end - _stext)) {
> +		printk(KERN_WARNING
> +			"Crash kernel can not overlap current kernel\n");
> +		crashk_res.start =3D crashk_res.end =3D 0;
> +		return;
> +	}

I think we can be smarter here. Why don't we adjust the crash kernel
region so that it doesn't overlap the first kernel? ie. move it up a
bit.

There's also the issue of the RMO, I'm not sure what we should do there,
but I think the kernel needs some smarts otherwise users are going to
shoot themselves in the foot.

We could ignore the @x setting and split the RMO between both kernels
somewhat intelligently.

What might work is multiple crash regions, that way we could have some
space in the RMO for the second kernel (say 32MB?), but the rest outside
- leaving some RMO for the first kernel. But I think that would require
some serious surgery.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-FFqWjNFUZYKxLEfaXwl3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAklj7MIACgkQdSjSd0sB4dLBdgCfZk1sxjUdSvVDI7/zJPkrVdAe
UAMAniZbgjgXYcoQq70SvLu30w/Bufb0
=yJJU
-----END PGP SIGNATURE-----

--=-FFqWjNFUZYKxLEfaXwl3--



--===============0243352825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0243352825==--


