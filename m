Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 2 Oct 2018 14:47:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v15 06/16] of/fdt: add helper functions for handling
 properties
Message-ID: <20181002044710.GD1886@umbus.fritz.box>
References: <20180928064841.14117-1-takahiro.akashi@linaro.org>
 <20180928064841.14117-7-takahiro.akashi@linaro.org>
 <CAL_JsqKwmcdQ+2eK3LGHhcQ2Wb+Yz1-Atz0-3K6WKNZQt_woVw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKwmcdQ+2eK3LGHhcQ2Wb+Yz1-Atz0-3K6WKNZQt_woVw@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4365885578303001907=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Rob Herring <robh+dt@kernel.org>
Cc: prudo@linux.ibm.com, Herbert Xu <herbert@gondor.apana.org.au>, Baoquan He <bhe@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, bhsharma@redhat.com, Frank Rowand <frowand.list@gmail.com>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, David Howells <dhowells@redhat.com>, "AKASHI,
 Takahiro" <takahiro.akashi@linaro.org>, devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, kexec@lists.infradead.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, James Morse <james.morse@arm.com>, dyoung@redhat.com, David Miller <davem@davemloft.net>, Vivek Goyal <vgoyal@redhat.com>


--===============4365885578303001907==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pZs/OQEoSSbxGlYw"
Content-Disposition: inline


--pZs/OQEoSSbxGlYw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 28, 2018 at 08:44:42AM -0500, Rob Herring wrote:
> +David Gibson
>=20
> On Fri, Sep 28, 2018 at 1:48 AM AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> >
> > These functions will be used later to handle kexec-specific properties
> > in arm64's kexec_file implementation.
> >
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Frank Rowand <frowand.list@gmail.com>
> > Cc: devicetree@vger.kernel.org
> > ---
> >  drivers/of/fdt.c       | 56 ++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/of_fdt.h |  4 +++
> >  2 files changed, 60 insertions(+)
> >
> > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > index 800ad252cf9c..c65c31562ccb 100644
> > --- a/drivers/of/fdt.c
> > +++ b/drivers/of/fdt.c
> > @@ -25,6 +25,7 @@
> >  #include <linux/debugfs.h>
> >  #include <linux/serial_core.h>
> >  #include <linux/sysfs.h>
> > +#include <linux/types.h>
> >
> >  #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
> >  #include <asm/page.h>
> > @@ -1323,3 +1324,58 @@ late_initcall(of_fdt_raw_init);
> >  #endif
> >
> >  #endif /* CONFIG_OF_EARLY_FLATTREE */
> > +
> > +#define FDT_ALIGN(x, a)        (((x) + (a) - 1) & ~((a) - 1))
> > +#define FDT_TAGALIGN(x)        (FDT_ALIGN((x), FDT_TAGSIZE))
> > +
> > +int fdt_prop_len(const char *prop_name, int len)
> > +{
> > +       return (strlen(prop_name) + 1) +
> > +               sizeof(struct fdt_property) +
> > +               FDT_TAGALIGN(len);
>=20
> Looks like you are using this to calculate how much space you need to
> allocate in addition to the current DTB for a couple of new or
> replaced properties. I'm not sure that this calculation is completely
> accurate. And it is strange there doesn't seem to be any libfdt
> function for this already. It would be simpler to just add some fixed
> additional amount.
>=20
> Maybe David G has comments on this?

Hrm.  Yeah, the approach I'd suggest would be to just add a fixed
amount, and if your functions return -FDT_ERR_NOSPACE, add some more.
That's pretty much the expected way of working with fdts in write
mode.

If that's really not suitable, we could look at adding a helper to
estimate this in libfdt.  Or, actually, I suspect taking an existing
libfdt internal helper, polishing and exporting it.

>=20
> > +}
> > +
>=20
> The rest of this should go in drivers/of/fdt_address.c. Ultimately, it
> should go into libfdt, but I'm fine with having it in the kernel for
> now.
>=20
> > +static void fill_property(void *buf, u64 val64, int cells)
> > +{
> > +       __be32 val32;
> > +
> > +       while (cells) {
> > +               val32 =3D cpu_to_fdt32((val64 >> (32 * (--cells))) & U3=
2_MAX);
> > +               memcpy(buf, &val32, sizeof(val32));
> > +               buf +=3D sizeof(val32);
>=20
> This is kind of hard to read. I would copy u-boot's fdt_pack_reg function.
>=20
> BTW, for purposes of moving to libfdt, we'll need the authors'
> (Masahiro Yamada and Hans de Goede) permission to dual license.
>=20
> > +       }
> > +}
> > +
> > +int fdt_setprop_reg(void *fdt, int nodeoffset, const char *name,
> > +                                               u64 addr, u64 size)
> > +{
> > +       int addr_cells, size_cells;
> > +       char buf[sizeof(__be32) * 2 * 2];
> > +               /* assume dt_root_[addr|size]_cells <=3D 2 */
> > +       void *prop;
> > +       size_t buf_size;
> > +
> > +       addr_cells =3D fdt_address_cells(fdt, 0);
> > +       if (addr_cells < 0)
> > +               return addr_cells;
> > +       size_cells =3D fdt_size_cells(fdt, 0);
> > +       if (size_cells < 0)
> > +               return size_cells;
> > +
> > +       /* if *_cells >=3D 2, cells can hold 64-bit values anyway */
> > +       if ((addr_cells =3D=3D 1) && (addr > U32_MAX))
> > +               return -FDT_ERR_BADVALUE;
> > +
> > +       if ((size_cells =3D=3D 1) && (size > U32_MAX))
> > +               return -FDT_ERR_BADVALUE;
> > +
> > +       buf_size =3D (addr_cells + size_cells) * sizeof(u32);
> > +       prop =3D buf;
> > +
> > +       fill_property(prop, addr, addr_cells);
> > +       prop +=3D addr_cells * sizeof(u32);
> > +
> > +       fill_property(prop, size, size_cells);
> > +
> > +       return fdt_setprop(fdt, nodeoffset, name, buf, buf_size);
> > +}
> > diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
> > index b9cd9ebdf9b9..842af6ea92ea 100644
> > --- a/include/linux/of_fdt.h
> > +++ b/include/linux/of_fdt.h
> > @@ -108,5 +108,9 @@ static inline void unflatten_device_tree(void) {}
> >  static inline void unflatten_and_copy_device_tree(void) {}
> >  #endif /* CONFIG_OF_EARLY_FLATTREE */
> >
> > +int fdt_prop_len(const char *prop_name, int len);
> > +int fdt_setprop_reg(void *fdt, int nodeoffset, const char *name,
> > +                                               u64 addr, u64 size);
> > +
> >  #endif /* __ASSEMBLY__ */
> >  #endif /* _LINUX_OF_FDT_H */
> >
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--pZs/OQEoSSbxGlYw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluy+E4ACgkQbDjKyiDZ
s5JtlBAAwizCSVib6UkcvOgkkohgXhzieZbtAj1zxuutxehiRJ2CMs5Q1kOr39FD
8WtQH8sswlfkJw0S2OQAhkdt2xzYnyndUkgPt0Qnvzm8q9JF4I+o2yrH+5p5Jge7
euP0mNWIyT7zGaoXVPYWaSC429eQ9ZE3ZESSlGEvFOoURy99h0W6lzDG2Kw7qulS
5QkB/iyVCJmDHMinny32vIWbIIO6vQBpPwFl3cLbzqg/BlLMe9Gl6REAeSZVa1VO
7uNFhfs0xUYpkSLUrzy4jFYk7+LjSuIZtlAGkyVql9AUEY0oLayn80stJHMFA1f0
lrY5HHeZGUqwoI8OQUiiIxp893ZM97y/c6sH+DlFWzCYZJrixo6WCV24+jtuODUJ
5uoY2SwpPMDdwH0wJVKxEgQ99tai7qWd6Jcd3pcIi6o7sffChl93l6nzp0rU1Vn2
pX8LNrlQEperUClK5AWfPYPf1BMq/CdxkWhzdxchDWuDSI3kHuEh6Vng+ycvRI3Y
XzolJQH+Sl1dBtdtKaYVyq9ooBNkGLxj0ZEiw1/wheXxVmYHJrq4fpwO+DwLg2d5
K2fhu8SEWl3nPc6rwh83nHYAmVnTvQDsUOKXBvZvVQJSReuQt80A4DHziwH4fxv7
0QgVciFtiBiZRCO4PWIm4fYgtBEcF4PqU1npd/LGSiyG8LGpq6g=
=j2A5
-----END PGP SIGNATURE-----

--pZs/OQEoSSbxGlYw--


--===============4365885578303001907==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============4365885578303001907==--

