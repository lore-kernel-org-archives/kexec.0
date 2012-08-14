Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1T1DjL-0005Oi-S2
 for kexec@lists.infradead.org; Tue, 14 Aug 2012 09:48:10 +0000
Message-ID: <502A1ED3.9000500@canonical.com>
Date: Tue, 14 Aug 2012 11:48:03 +0200
From: Stefan Bader <stefan.bader@canonical.com>
MIME-Version: 1.0
Subject: Re: makedumpfile -g with recent kernels
References: <4FFAA199.5040608@canonical.com>
 <20120802141251.2efc0e407259254e6ef60586@mxc.nes.nec.co.jp>
 <501A38F1.8030801@canonical.com>
 <20120806145418.5fc2e5473aeb94f0348b023e@mxc.nes.nec.co.jp>
 <501F74C9.9070508@canonical.com>
 <20120807152356.1c2dbacbe323c2706cc6e6e8@mxc.nes.nec.co.jp>
 <5020C8D9.7060303@canonical.com>
 <20120814140357.f03d55103281db3cccfc8572@mxc.nes.nec.co.jp>
In-Reply-To: <20120814140357.f03d55103281db3cccfc8572@mxc.nes.nec.co.jp>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============9028372807162893545=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: kexec@lists.infradead.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============9028372807162893545==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="------------enig52012611381CD74FFD2DA8CD"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig52012611381CD74FFD2DA8CD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 14.08.2012 07:03, Atsushi Kumagai wrote:
> Hello Stefan,
>=20
> On Tue, 07 Aug 2012 09:50:49 +0200
> Stefan Bader <stefan.bader@canonical.com> wrote:
>=20
>>>
>>>          case DWARF_INFO_GET_MEMBER_OFFSET:
>>>                  if ((!name) || strcmp(name, dwarf_info.member_name))=

>>>                          continue;
>>>                  /*
>>>                   * Get the member offset.
>>>                   */
>>>                  if (dwarf_tag(die) =3D=3D DW_TAG_union_type)
>>>                          offset =3D 0;
>>>                  else if (!get_data_member_location(walker, &offset))=

>>>                          continue;
>>>                  dwarf_info.member_offset =3D offset;
>>>                  return TRUE;
>>>
>>> And about your code:
>>>
>>>>        case DWARF_INFO_GET_MEMBER_OFFSET_1ST_UNION:
>>>>                 if (!get_die_type(walker, &die_type))
>>>>                         continue;
>>>>                 if (dwarf_tag(&die_type) !=3D DW_TAG_union_type)
>>>>                         continue;
>>>>
>>>>                 /*
>>>>                  * At this point it is clear that this is a union.
>>>>                  * Though unions have no offset elements (the offset=

>>>>                  * is always 0. So get_data_member_location would fa=
il.
>>>>                  */
>>>>                  dwarf_info.member_offset =3D 0;
>>>>                  return TRUE;
>>>
>>> It's wrong that unions have no offset elements.
>>> Correctly, members of union have no offset elements.
>>
>> That code was just based on the (incorrect) assumption that we talk ab=
out
>> *_OFFSET_1ST_UNION and thinking those were the dies that had no offset=
 tags.
>> But the members having no offset makes much more sense. But then (with=
out
>> looking at dwarf output), if it is only the members of unions that nee=
d the
>> change (and now I understand why it is checking die and not die_type),=
 the first
>> union should always have an offset and that call would only descent in=
to
>> structures while looking for the first union and never go past a union=
=2E
>=20
> Did you point out the case like the example below ?
> (names of unions are only for explanation.)
>=20
> Example:
> 	struct EXAMPLE {                  // top layer
> 		int A;
> 		union ONE {               // the target of *_OFFSET_1ST_UNION
> 			int B;
> 			union TWO {       // but, my code reaches here
> 				int C;
> 			};
> 		};
> 	};
>=20
>=20
> Certainly, my change for *_OFFSET_1ST_UNION is wrong.
> I changed is_anonymous_container() and attach the fixed patch to this m=
ail.
> I'll merge it into the next version unless you have any comment.

Yes, and that was actually already wrong with my initial patch. Damn thes=
e
little details... So now, when looking for the first union, the recursion=
 stops
at the first one. Sounds good.

I think this looks good now... hopefully... :) Thanks.

-Stefan
>=20
>=20
> Thanks
> Atsushi Kumagai
>=20
> ---
>  dwarf_info.c   |  122 +++++++++++++++++++-----------------------------=
--------
>  dwarf_info.h   |    1 -
>  makedumpfile.c |    8 ----
>  makedumpfile.h |    6 ---
>  4 files changed, 42 insertions(+), 95 deletions(-)
>=20
> diff --git a/dwarf_info.c b/dwarf_info.c
> index 1429858..fb11e49 100644
> --- a/dwarf_info.c
> +++ b/dwarf_info.c
> @@ -64,7 +64,6 @@ is_search_structure(int cmd)
>  	if ((cmd =3D=3D DWARF_INFO_GET_STRUCT_SIZE)
>  	    || (cmd =3D=3D DWARF_INFO_GET_MEMBER_OFFSET)
>  	    || (cmd =3D=3D DWARF_INFO_GET_MEMBER_TYPE)
> -	    || (cmd =3D=3D DWARF_INFO_GET_MEMBER_OFFSET_IN_UNION)
>  	    || (cmd =3D=3D DWARF_INFO_GET_MEMBER_OFFSET_1ST_UNION)
>  	    || (cmd =3D=3D DWARF_INFO_GET_MEMBER_ARRAY_LENGTH))
>  		return TRUE;
> @@ -447,75 +446,41 @@ get_dwarf_base_type(Dwarf_Die *die)
>  	return TRUE;
>  }
> =20
> -/*
> - * Function for searching struct page.union.struct.mapping.
> - */
>  static int
> -__search_mapping(Dwarf_Die *die, long *offset)
> +is_anonymous_container(Dwarf_Die *die)
>  {
> -	int tag;
> -	const char *name;
> -	Dwarf_Die child, *walker;
> -
> -	if (dwarf_child(die, &child) !=3D 0)
> +	if (dwarf_diename(die))
>  		return FALSE;
> -
> -	walker =3D &child;
> -	do {
> -		tag  =3D dwarf_tag(walker);
> -		name =3D dwarf_diename(walker);
> -
> -		if (tag !=3D DW_TAG_member)
> -			continue;
> -		if ((!name) || strcmp(name, dwarf_info.member_name))
> -			continue;
> -		if (!get_data_member_location(walker, offset))
> -			continue;
> +	if (dwarf_tag(die) =3D=3D DW_TAG_structure_type)
> +		return TRUE;
> +	if (dwarf_info.cmd !=3D DWARF_INFO_GET_MEMBER_OFFSET_1ST_UNION
> +	    && dwarf_tag(die) =3D=3D DW_TAG_union_type)
>  		return TRUE;
> -
> -	} while (!dwarf_siblingof(walker, walker));
> -
>  	return FALSE;
>  }
> =20
> -/*
> - * Function for searching struct page.union.struct.
> - */
> -static int
> -search_mapping(Dwarf_Die *die, long *offset)
> +static void
> +adjust_member_offset(Dwarf_Die *die)
>  {
> -	Dwarf_Die child, *walker;
> -	Dwarf_Die die_struct;
> -
> -	if (dwarf_child(die, &child) !=3D 0)
> -		return FALSE;
> -
> -	walker =3D &child;
> -
> -	do {
> -		if (dwarf_tag(walker) !=3D DW_TAG_member)
> -			continue;
> -		if (!get_die_type(walker, &die_struct))
> -			continue;
> -		if (dwarf_tag(&die_struct) !=3D DW_TAG_structure_type)
> -			continue;
> -		if (__search_mapping(&die_struct, offset))
> -			return TRUE;
> -	} while (!dwarf_siblingof(walker, walker));
> +	long offset;
> =20
> -	return FALSE;
> +	if (dwarf_info.member_offset =3D=3D NOT_FOUND_STRUCTURE)
> +		return;
> +	if (!get_data_member_location(die, &offset))
> +		return;
> +	dwarf_info.member_offset +=3D offset;
>  }
> =20
> -static void
> +static int
>  search_member(Dwarf_Die *die)
>  {
>  	int tag;
> -	long offset, offset_union;
> +	long offset;
>  	const char *name;
> -	Dwarf_Die child, *walker, die_union;
> +	Dwarf_Die child, *walker, die_type;
> =20
>  	if (dwarf_child(die, &child) !=3D 0)
> -		return;
> +		return FALSE;
> =20
>  	walker =3D &child;
> =20
> @@ -526,6 +491,20 @@ search_member(Dwarf_Die *die)
>  		if (tag !=3D DW_TAG_member)
>  			continue;
> =20
> +		/*
> +		 * Descend into anonymous members and search for member
> +		 * there.
> +		 */
> +		if (!name) {
> +			if (!get_die_type(walker, &die_type))
> +				continue;
> +			if (is_anonymous_container(&die_type))
> +				if (search_member(&die_type)) {
> +					adjust_member_offset(walker);
> +					return TRUE;
> +				}
> +		}
> +
>  		switch (dwarf_info.cmd) {
>  		case DWARF_INFO_GET_MEMBER_TYPE:
>  			if ((!name) || strcmp(name, dwarf_info.member_name))
> @@ -535,39 +514,23 @@ search_member(Dwarf_Die *die)
>  			 */
>  			if (!get_dwarf_base_type(walker))
>  				continue;
> -			return;
> +			return TRUE;
>  		case DWARF_INFO_GET_MEMBER_OFFSET:
>  			if ((!name) || strcmp(name, dwarf_info.member_name))
>  				continue;
>  			/*
>  			 * Get the member offset.
>  			 */
> -			if (!get_data_member_location(walker, &offset))
> +			if (dwarf_tag(die) =3D=3D DW_TAG_union_type)
> +				offset =3D 0;
> +			else if (!get_data_member_location(walker, &offset))
>  				continue;
>  			dwarf_info.member_offset =3D offset;
> -			return;
> -		case DWARF_INFO_GET_MEMBER_OFFSET_IN_UNION:
> -			if (!get_die_type(walker, &die_union))
> -				continue;
> -			if (dwarf_tag(&die_union) !=3D DW_TAG_union_type)
> -				continue;
> -			/*
> -			 * Search page.mapping in union.
> -			 */
> -			if (!search_mapping(&die_union, &offset_union))
> -				continue;
> -
> -			/*
> -			 * Get the member offset.
> -			 */
> -			if (!get_data_member_location(walker, &offset))
> - 				continue;
> -			dwarf_info.member_offset =3D offset + offset_union;
> - 			return;
> +			return TRUE;
>  		case DWARF_INFO_GET_MEMBER_OFFSET_1ST_UNION:
> -			if (!get_die_type(walker, &die_union))
> +			if (!get_die_type(walker, &die_type))
>  				continue;
> -			if (dwarf_tag(&die_union) !=3D DW_TAG_union_type)
> +			if (dwarf_tag(&die_type) !=3D DW_TAG_union_type)
>  				continue;
>  			/*
>  			 * Get the member offset.
> @@ -575,7 +538,7 @@ search_member(Dwarf_Die *die)
>  			if (!get_data_member_location(walker, &offset))
>  				continue;
>  			dwarf_info.member_offset =3D offset;
> -			return;
> +			return TRUE;
>  		case DWARF_INFO_GET_MEMBER_ARRAY_LENGTH:
>  			if ((!name) || strcmp(name, dwarf_info.member_name))
>  				continue;
> @@ -584,14 +547,14 @@ search_member(Dwarf_Die *die)
>  			 */
>  			if (!get_data_array_length(walker))
>  				continue;
> -			return;
> +			return TRUE;
>  		}
>  	} while (!dwarf_siblingof(walker, walker));
> =20
>  	/*
>  	 * Return even if not found.
>  	 */
> -	return;
> +	return FALSE;
>  }
> =20
>  static void
> @@ -636,7 +599,6 @@ search_structure(Dwarf_Die *die, int *found)
>  		break;
>  	case DWARF_INFO_GET_MEMBER_TYPE:
>  	case DWARF_INFO_GET_MEMBER_OFFSET:
> -	case DWARF_INFO_GET_MEMBER_OFFSET_IN_UNION:
>  	case DWARF_INFO_GET_MEMBER_OFFSET_1ST_UNION:
>  	case DWARF_INFO_GET_MEMBER_ARRAY_LENGTH:
>  		search_member(die);
> diff --git a/dwarf_info.h b/dwarf_info.h
> index 1e07484..8d0084d 100644
> --- a/dwarf_info.h
> +++ b/dwarf_info.h
> @@ -37,7 +37,6 @@
>  enum {
>  	DWARF_INFO_GET_STRUCT_SIZE,
>  	DWARF_INFO_GET_MEMBER_OFFSET,
> -	DWARF_INFO_GET_MEMBER_OFFSET_IN_UNION,
>  	DWARF_INFO_GET_MEMBER_OFFSET_1ST_UNION,
>  	DWARF_INFO_GET_MEMBER_ARRAY_LENGTH,
>  	DWARF_INFO_GET_SYMBOL_ARRAY_LENGTH,
> diff --git a/makedumpfile.c b/makedumpfile.c
> index d024e95..d32ce55 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -874,17 +874,9 @@ get_structure_info(void)
>  	SIZE_INIT(page, "page");
>  	OFFSET_INIT(page.flags, "page", "flags");
>  	OFFSET_INIT(page._count, "page", "_count");
> -
>  	OFFSET_INIT(page.mapping, "page", "mapping");
> =20
>  	/*
> -	 * On linux-2.6.16 or later, page.mapping is defined
> -	 * in anonymous union.
> -	 */
> -	if (OFFSET(page.mapping) =3D=3D NOT_FOUND_STRUCTURE)
> -		OFFSET_IN_UNION_INIT(page.mapping, "page", "mapping");
> -
> -	/*
>  	 * Some vmlinux(s) don't have debugging information about
>  	 * page.mapping. Then, makedumpfile assumes that there is
>  	 * "mapping" next to "private(unsigned long)" in the first
> diff --git a/makedumpfile.h b/makedumpfile.h
> index 6f5489d..4bf502f 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -239,12 +239,6 @@ do { \
>  	     =3D=3D FAILED_DWARFINFO) \
>  		return FALSE; \
>  } while (0)
> -#define OFFSET_IN_UNION_INIT(X, Y, Z) \
> -do { \
> -	if ((OFFSET(X) =3D get_member_offset(Y, Z, DWARF_INFO_GET_MEMBER_OFFS=
ET_IN_UNION)) \
> -	     =3D=3D FAILED_DWARFINFO) \
> -		return FALSE; \
> -} while (0)
>  #define SYMBOL_ARRAY_LENGTH_INIT(X, Y) \
>  do { \
>  	if ((ARRAY_LENGTH(X) =3D get_array_length(Y, NULL, DWARF_INFO_GET_SYM=
BOL_ARRAY_LENGTH)) =3D=3D FAILED_DWARFINFO) \
>=20



--------------enig52012611381CD74FFD2DA8CD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBCgAGBQJQKh7TAAoJEOhnXe7L7s6jybcQAM6rB1CMQD2Ow84hWAcw/xQ9
7edhbmvhsYkVMM+PALuaEpdBgkEGAKhntM/RCxKrgUX3WCCLO0bAFBHOqd5UJlNM
xCMH3ePiMEBI8JEd56LB6IkwWvi7Dmzq90z4wAfTgv1D974LRHnT35e2jUs7LE2N
q1R8CCLJBq8Y2y0lSXwCxfdDWFUbEbx7tN/YrA/wknBM1Zj8k8Ivq+eJvhuD+dX0
i+WRp6rSP3h4US9csVYlwa0ubBYlOhkuJBz0IubigcQH5vWeSmTBUCyIvGpHksN5
rAsKviyKFZFo+HCvAADorMnQiofuD/piwi/ShrwK8hKDSP0Ph3kp7h+J6q8QajVL
UhAYoHtTrkZwUBDTrijXM6YhraYPC94zVptpsiE2U/atacAtXFiyDZ/7wHhKlWmX
yeSUmTHr19mibnl4kH4z6khrpPHOH59NzPVXG5NgRd3NYB2J1TB2JX5f5BosuYdy
EtzXBnskNtsbP9egFNFpsX7PZB5XYO+1F4lNXukiBkNqeAqTQpFmm7Y4SLrxFmrd
vloQza7xNWuOTpXh9+OJewfzWVUgw034/m19irhfVuj1OAHpQzbGZv//koJGulPh
CiWFdHDVxoly7OELbfB2CSMQx6gjDjnz2j9kyn969byD9bvrOr1Y6mE8L9kOiW8+
eSeS7u2PLetxA3HsV7r7
=ZPse
-----END PGP SIGNATURE-----

--------------enig52012611381CD74FFD2DA8CD--


--===============9028372807162893545==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============9028372807162893545==--

