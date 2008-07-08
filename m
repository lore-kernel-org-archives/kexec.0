Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from chilli.pcug.org.au ([203.10.76.44] helo=smtps.tip.net.au)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KG28V-0008G5-6v
	for kexec@lists.infradead.org; Tue, 08 Jul 2008 01:36:55 +0000
Date: Tue, 8 Jul 2008 11:36:46 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 1/4] kdump : add support for ibm,
	dynamic-reconfiguration-memory for kexec/kdump
Message-Id: <20080708113646.13836635.sfr@canb.auug.org.au>
In-Reply-To: <200807080014.24910.chandru@in.ibm.com>
References: <200807080014.24910.chandru@in.ibm.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0447953921=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Chandru <chandru@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org

--===============0447953921==
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__8_Jul_2008_11_36_46_+1000_qCsD8LuKexgnx0JD"

--Signature=_Tue__8_Jul_2008_11_36_46_+1000_qCsD8LuKexgnx0JD
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Chandru,

On Tue, 8 Jul 2008 00:14:24 +0530 Chandru <chandru@in.ibm.com> wrote:
>
> @@ -917,7 +918,33 @@ static int __init early_init_dt_scan_drc
>  			if ((base + size) > 0x80000000ul)
>  				size =3D 0x80000000ul - base;
>  		}
> -		lmb_add(base, size);
> +		strcpy(buf, "linux,usable-memory");
> +		sprintf(t, "%d", (int)n);
> +		strcat(buf, t);

Why don't you use
		snprintf(buf, sizeof(buf), "linux,usable-memory%ld", n);
instead?

> +		usm =3D (cell_t *)of_get_flat_dt_prop(node,
> +						 (const char *)buf, &l);
		      ^^^^^^^^^^		 ^^^^^^^^^^^^^^
unnecessary casts.

>  static void __init parse_drconf_memory(struct device_node *memory)
>  {

> +		strcpy(buf, "linux,usable-memory");
> +		sprintf(t, "%d", (int)n);
> +		strcat(buf, t);

See snprint comment above.

> +		usm =3D of_get_property(memory, (const char *)buf, &len);
                                              ^^^^^^^^^^^^^^
unnecessary cast.

> +		if (usm !=3D NULL) {
> +			ranges =3D (len >> 2) / (n_mem_addr_cells +
                                 ^^^^^^^^^^
len / sizeof(u32) ?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__8_Jul_2008_11_36_46_+1000_qCsD8LuKexgnx0JD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhyxK4ACgkQjjKRsyhoI8z/lwCfUmUrovaiCzuazjzJSroWY4zL
FR8An3vnb75WMrwT51NgwxuZwAT0MCXW
=3hV8
-----END PGP SIGNATURE-----

--Signature=_Tue__8_Jul_2008_11_36_46_+1000_qCsD8LuKexgnx0JD--


--===============0447953921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0447953921==--

