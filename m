Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TDaay-0000V5-Iu
 for kexec@lists.infradead.org; Mon, 17 Sep 2012 12:38:38 +0000
Message-ID: <505719BD.6080608@canonical.com>
Date: Mon, 17 Sep 2012 14:38:21 +0200
From: Stefan Bader <stefan.bader@canonical.com>
MIME-Version: 1.0
Subject: Re: [PATCHv3 0/9] Support Xen versions up to xen-4.1
References: <201208241741.27573.petr@tesarici.cz>
 <0E9227E8EFCFF54EA493F6C0399C015D39BFC5A112@ABGEX70E.FSC.NET>
 <20120903140100.ac4dbf21401ace0e24a442d9@mxc.nes.nec.co.jp>
 <0E9227E8EFCFF54EA493F6C0399C015D39C0F0F687@ABGEX70E.FSC.NET>
In-Reply-To: <0E9227E8EFCFF54EA493F6C0399C015D39C0F0F687@ABGEX70E.FSC.NET>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============9063297944884179692=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Trapp, Norbert" <norbert.trapp@ts.fujitsu.com>
Cc: "petr@tesarici.cz" <petr@tesarici.cz>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============9063297944884179692==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="------------enigF50D94FEBA548DFC4A6AFD60"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF50D94FEBA548DFC4A6AFD60
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12.09.2012 16:39, Trapp, Norbert wrote:
> Hello Atsushi, Petr, Stefan et al.,
>=20

Hi Norbert,

> When applying the makedumpfile Xen4 patches to the makedumpfile 1.5.0
> version and using it for a crash file to save just the dom0 and xen pag=
es
> it again worked splendid in that makedumpfile was much faster than with=
out
> the Xen4 patches. Alas I had to remove the OFFSET_IN_UNION_INIT(page._d=
omain,
> "page_info", "domain") call because OFFSET_IN_UNION_INIT was no longer =
present.
> It didn't matter much because the call is only needed for makedumpfile =
-g or when
> using the /boot/xen-syms file. In the current 1.5.0  makedumpfile.c ver=
sion you
> see
>=20
>     OFFSET_INIT(page_info._domain, "page_info", "u").
>=20
> The Xen4 patch modified this because the _domain structure member is in=
 different
> unions for different version (x86, ia64) and may also not be the first =
entry in
> the union depending on the Xen version.
>=20
>     OFFSET_IN_UNION_INIT(page_info._domain, "page_info", "_domain");
>=20
> As an experiment I tried to use
>=20

>     OFFSET_INIT(page_info._domain, "page_info", "domain")

Just to make sure and since I am a bit lazy: with the Xen patch the page_=
info
structure has a member (somewhere) named domain? (or _domain)?

>=20
> with makedumpfile 1.5.0. To get the correct offset I had to
> modify the dwarf_info.c code:
>=20
> --- ../makedumpfile-1.5.0/dwarf_info.c  2012-09-06 07:30:23.000000000 +=
0200
> +++ dwarf_info.c        2012-09-12 15:49:23.000000000 +0200
> @@ -449,8 +449,8 @@
>  static int
>  is_anonymous_container(Dwarf_Die *die)
>  {
> -       if (dwarf_diename(die))
> -               return FALSE;
> +       //if (dwarf_diename(die))
> +       //      return FALSE;
>         if (dwarf_tag(die) =3D=3D DW_TAG_structure_type)
>                 return TRUE;
>         if (dwarf_info.cmd !=3D DWARF_INFO_GET_MEMBER_OFFSET_1ST_UNION
> @@ -495,7 +495,7 @@
>                  * Descend into anonymous members and search for member=

>                  * there.
>                  */
> -               if (!name) {
> +               if ((!name) || (strcmp(name, dwarf_info.member_name) !=3D=
 0)) {
>                         if (!get_die_type(walker, &die_type))
>                                 continue;
>                         if (is_anonymous_container(&die_type))
>=20
>=20
> This is not a patch but just a description of what I modified for a tes=
t.
> The underlying question is why only the anonymous unions are used and n=
ot the
> ones with a name.

I made the patch because one element in some anonymous structure/union co=
mbo was
not found in newer kernels and the previous exceptions for such a thing w=
ere
hard coded. But as far as the dwarf info I was looking at the named
structures/unions were handled and I did not want to modify that case wit=
hout a
way to test.

-Stefan
>=20
> With kind regards
>=20
> 	Norbert
>=20
> Norbert Trapp
> PDG ES&S SWE OS 6
>=20
> FUJITSU
> Fujitsu Technology Solutions GmbH
> Domagkstra=C3=9Fe 28, D-80807 M=C3=BCnchen, Germany
> E-mail: Norbert.Trapp at ts.fujitsu.com
> Web: ts.fujitsu.com
> Company details: ts.fujitsu.com/imprint
>=20
>> -----Original Message-----
>> From: Atsushi Kumagai [mailto:kumagai-atsushi@mxc.nes.nec.co.jp]
>> Sent: Monday, September 03, 2012 7:01 AM
>> To: Trapp, Norbert; petr@tesarici.cz
>> Cc: kexec@lists.infradead.org
>> Subject: Re: [PATCHv3 0/9] Support Xen versions up to xen-4.1
>>
> ...
>>
>> Thank you for your report, that's good.
>> So, I'll review these patches for makedumpfile-1.5.1.
>>
>>
>> Thanks
>> Atsushi Kumagai
>=20



--------------enigF50D94FEBA548DFC4A6AFD60
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBCgAGBQJQVxnFAAoJEOhnXe7L7s6jvR8QAKRfqF9rrssJ1tUSzmg+E9W+
utnmvT7fcc/a93T9jUvBuEUCUpD7dZCKQBRUNi0K8+FdVrHu2QPoY2zeSjURzndO
dNt40xGUcmiNa/EoiKjD00Nu6umhOButHxc2iRbUbIhGaDbXWpIpUIh3aa/MhXfl
YcyeQY8Ai7pb6mm0hrjASg4b8Q+xQiSJywTmopNt+xw2qaXAiFuFSVm0CoaRlKfw
bllANlV/3zuaI3/u2/75WEPiHRLUxsRWYP8twETHnqcIE6N+RBTZoTyQqmznzya+
pPo3/IGyeb36lH8wfOVXB25FgKm45uzI7OReIZCQCgaKk/SMs2n54T20Eb2rd5Un
Xt5ElkoAONwzfZI6S3UNJZb7Z4iPvoMNLD9R2M1tpuAEIh1wFK684TPGdg1/bo5P
yms2rXoEvtOwJjVBJqSbqe9vt124PsiazGxAK8tpcmHZvNTyqAsZk6nhqk0smLSf
1UbEAA1GsOAHCxR4PlCpp12mVWI+L/7HVyARumS1A8nJ+i/kZjj+mLm2cIhDEl6E
HB2a2ZJ3GZc9mXjSiRl6Q6XuV5cYsXO68q7A/cFZ5heEFfQ5f/ajTenzs55I9dOd
AIueB/uYKfE14Tm6xd06o72BOQbvQfTdcJaNNppQbJwDkoPnRPf6xVn1BsvTedl4
XiqbJGxtI3TUgYAMkVgN
=Hm54
-----END PGP SIGNATURE-----

--------------enigF50D94FEBA548DFC4A6AFD60--


--===============9063297944884179692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============9063297944884179692==--

