Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from metropolitan.anduras.de ([80.237.200.159])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1LMMYb-0003Mt-OE
	for kexec@lists.infradead.org; Mon, 12 Jan 2009 13:10:18 +0000
Message-ID: <496B4127.1070201@anduras.de>
Date: Mon, 12 Jan 2009 14:09:59 +0100
From: Sven Anders <anders@anduras.de>
MIME-Version: 1.0
Subject: Re: newbie question: kexec linux-based bootstrap
References: <F795765B112E7344AF36AA911279641508F6AFCB@xmb-sjc-212.amer.cisco.com>
In-Reply-To: <F795765B112E7344AF36AA911279641508F6AFCB@xmb-sjc-212.amer.cisco.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0771430731=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Bizhan Gholikhamseh (bgholikh)" <bgholikh@cisco.com>
Cc: kexec@lists.infradead.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============0771430731==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA3819E75A6CDCC2C2DF6F038"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA3819E75A6CDCC2C2DF6F038

Bizhan Gholikhamseh (bgholikh) schrieb:
>
> HI all,
>
> =20
>
> I have been investigating how to boot Linux as bootstrap to boot
> another Linux.
>
> =20
>
> From my understanding, Linux has a kexec system call which provides
> overlay another Linux image on the current running Linux.
>
> =20
>
> Is my understanding correct?
>
Yes, it correct. We are using a similiar configuration without problems.

Mit freundlichen Gr=FC=DFen
 Sven Anders

--=20
 Sven Anders <anders@anduras.de>                 () Ascii Ribbon Campaign=

                                                 /\ Support plain text e-=
mail
 ANDURAS service solutions AG
 Innstra=DFe 71 - 94036 Passau - Germany
 Web: www.anduras.de - Tel: +49 (0)851-4 90 50-0 - Fax: +49 (0)851-4 90 5=
0-55

Rechtsform: Aktiengesellschaft - Sitz: Passau - Amtsgericht Passau HRB 60=
32
Mitglieder des Vorstands: Sven Anders, Marcus Junker
Vorsitzender des Aufsichtsrats: Mark Peters


--------------020700000505060307000205
Content-Type: text/x-vcard; charset=utf-8;
 name="anders.vcf"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="anders.vcf"

begin:vcard
fn:Sven Anders
n:Anders;Sven
org:ANDURAS AG;Research and Development
adr;quoted-printable:;;Innstra=3DC3=3D9Fe 71;Passau;Bavaria;94036;Germany=

email;internet:anders@anduras.de
title:Dipl. Inf.
tel;work:++49 (0)851 / 490 50 -0
tel;fax:++49 (0)851 / 590 50 - 55
x-mozilla-html:FALSE
url:http://www.anduras.de
version:2.1
end:vcard


--------------020700000505060307000205--

--------------enigA3819E75A6CDCC2C2DF6F038
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAklrQTUACgkQ5lKZ7Feg4EeVfwCgk4dy85BE3v8Q8Ox6R7zEnmK7
9P4AnR29mKleIpulIVdazgZlhoagUzmV
=oYnN
-----END PGP SIGNATURE-----

--------------enigA3819E75A6CDCC2C2DF6F038--


--===============0771430731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0771430731==--

