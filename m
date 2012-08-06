Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SyHv6-0007ZF-7a
 for kexec@lists.infradead.org; Mon, 06 Aug 2012 07:40:08 +0000
Message-ID: <501F74C9.9070508@canonical.com>
Date: Mon, 06 Aug 2012 09:39:53 +0200
From: Stefan Bader <stefan.bader@canonical.com>
MIME-Version: 1.0
Subject: Re: makedumpfile -g with recent kernels
References: <4FFAA199.5040608@canonical.com>
 <20120802141251.2efc0e407259254e6ef60586@mxc.nes.nec.co.jp>
 <501A38F1.8030801@canonical.com>
 <20120806145418.5fc2e5473aeb94f0348b023e@mxc.nes.nec.co.jp>
In-Reply-To: <20120806145418.5fc2e5473aeb94f0348b023e@mxc.nes.nec.co.jp>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1150050975617667911=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: kexec@lists.infradead.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============1150050975617667911==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="------------enig91BD65CC7676F74FDB15F339"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig91BD65CC7676F74FDB15F339
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06.08.2012 07:54, Atsushi Kumagai wrote:
> Hello Stefan,
>=20
> On Thu, 02 Aug 2012 10:23:13 +0200
> Stefan Bader <stefan.bader@canonical.com> wrote:
>=20
>>>   static void
>>>   adjust_member_offset(Dwarf_Die *die)
>>>   {
>>>           long offset;
>>>
>>>           if (dwarf_info.member_offset =3D=3D NOT_FOUND_STRUCTURE)   =
  // this comparison is always true
>>>                   return;
>>>           if (!get_data_member_location(die, &offset))
>>>                   return;
>>>           dwarf_info.member_offset +=3D offset;
>>>   }
>>>
>>> At least, the change below works fine without regression.
>>>
>>>
>>> diff --git a/dwarf_info.c b/dwarf_info.c
>>> index 583df53..03e4c90 100644
>>> --- a/dwarf_info.c
>>> +++ b/dwarf_info.c
>>> @@ -520,7 +520,9 @@ search_member(Dwarf_Die *die)
>>>                         /*
>>>                          * Get the member offset.
>>>                          */
>>> -                       if (!get_data_member_location(walker, &offset=
))
>>> +                       if (dwarf_tag(die) =3D=3D DW_TAG_union_type)
>>
>> Hm, should that not be die_type to check what the walker is on? And in=
 that case
>> it seems that check was made just before... So maybe it would be ok to=
 assume 0
>> as the offset when getting here...?
>=20
> As you said, the walker will be a member of union or struct when reachi=
ng here,
> because is_anonymous_container() already checked the walker.
>=20
> However, get_data_member_location() must succeed if the walker is a mem=
ber of struct
> while it doesn't succeed if the walker is a member of union.
> That's why I added the code to check whether the walker is a member of =
union or not.

Right, I was just wondering whether that would allow to simplify even mor=
e. Like
this:

       case DWARF_INFO_GET_MEMBER_OFFSET_1ST_UNION:
                if (!get_die_type(walker, &die_type))
                        continue;
                if (dwarf_tag(&die_type) !=3D DW_TAG_union_type)
                        continue;

                /*
                 * At this point it is clear that this is a union.
                 * Though unions have no offset elements (the offset
                 * is always 0. So get_data_member_location would fail.
                 */
                 dwarf_info.member_offset =3D 0;
                 return TRUE;

>=20
>=20
> Thanks
> Atsushi Kumagai
>=20
>>> +                               offset =3D 0;
>>> +                       else if (!get_data_member_location(walker, &o=
ffset))
>>>                                 continue;
>>>                         dwarf_info.member_offset =3D offset;
>>>                         return TRUE;
>>>
>>>
>>> Unless you have better way to fix this issue, I'll merge your patch i=
nto
>>> the next version with the change above.
>>>
>>> By the way, this fix enable us also to get the offset of page._mapcou=
nt and
>>> page.private, it's very helpful for the new method of free page filte=
ring.
>>>
>>>   http://lists.infradead.org/pipermail/kexec/2012-June/006441.html
>>>
>>>
>>> Thanks
>>> Atsushi Kumagai
>>>
>>
>>



--------------enig91BD65CC7676F74FDB15F339
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBCgAGBQJQH3TSAAoJEOhnXe7L7s6jPjEP/RgS5yO48q3KDHnDfGbBH/58
th0f9PW+1UO/uMi2UOhucwQm/DTlm57nM/ijs6ArLZHR8g4xqLdgrCWUNSq0TBvv
AVle7UbRv2wiJq62uGGtTvSU2WHaPRAt94Jegu7u+SvahxoEsZXr12RlC372SwKw
5twsYcrTL6+teoZbGdibhktUJIAsTiUloZyo/HNYlvPAlQk1LLceI0msYqwIqSUC
awH20/FQAZXbO6d3+hweNZ8T0NLLLJ5EAu0BxGYQHNHrKJL9AM6qdN3+/OWdFn/r
A39kJaw/4u25GDPu5ZJy/fu07NVvrxjP/A7iHcyAckmb+VDzSGVpc69bcApxfdAy
N/ot+ptj1tKKw/W0T/vdn3RkIX3Y4VDk0dc4EYh47+Gd8sdGLYtGMoFipaeoJ8JD
GsEANqKwt1T2j3UcD1OaIDbWy0KClhQXUFNPB7qFw/0vBO/eJlmS42Q0jcLFYHHX
vqIxFKoF8uiTueqK04ROkJK8DxQsUwYHx3KSAYDK3gS+U5utnjv6ssivmdopa5eW
n2omqVplWufLhuFojslCriNueHKe0Qk7i/TYQvK90LX65fKVChz2WrAjuHEDX6Kt
6ts8Epk9a1pOhlG6rpkzSdYKK6jSm7wd7GeBpM9jx5Wa7stbNmecR+UqAtjb+Fts
knJqS4VfuZyODi/V2NUg
=bSEO
-----END PGP SIGNATURE-----

--------------enig91BD65CC7676F74FDB15F339--


--===============1150050975617667911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1150050975617667911==--

