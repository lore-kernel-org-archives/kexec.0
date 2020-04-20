Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jQXUF-0005jQ-I5
 for kexec@lists.infradead.org; Mon, 20 Apr 2020 14:33:29 +0000
From: Lukasz Stelmach <l.stelmach@samsung.com>
Subject: [PATCH v2] arm: redefine OPT_APPEND and OPT_RAMDISK
In-Reply-To: <20200416084441.GA16024@vergenet.net>
Date: Mon, 20 Apr 2020 16:33:11 +0200
Message-ID: <dleftjmu76ns60.fsf%l.stelmach@samsung.com>
MIME-Version: 1.0
References: <20200416084441.GA16024@vergenet.net>
 <20200414085224.7069-1-l.stelmach@samsung.com>
 <CGME20200415105859eucas1p2db849d89aa9a338077a01784f73dad52@eucas1p2.samsung.com>
 <20200415105845.22067-1-l.stelmach@samsung.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8638328130123976302=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: horms@verge.net.au
Cc: kexec@lists.infradead.org

--===============8638328130123976302==
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
	protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

> On Wed, Apr 15, 2020 at 12:58:45PM +0200, =C5=81ukasz Stelmach wrote:
>> Redefine OPT_APPEND to avoid clash with OPT_KEXEC_SYSCALL_AUTO.
>> Redefine OPT_RAMDISK to avoid such problems in the future
>>
>> Signed-off-by: =C5=81ukasz Stelmach <l.stelmach at samsung.com>
>
> I am slightly concerned that this will break things for users.
> But OTOH perhaps we already broke things when adding
> OPT_KEXEC_SYSCALL_AUTO.
> Do you have any thoughts on this?

I am aware of this, but the current appears to be broken more. When I
was using '-a' it didn't work as advertised in the usage message. Short
*arch* options aren't documented there, so I suppose most people didn't
use them. ARM is the only architecture that supports short options by
defining OPT_* as characters. HPPA appears to be using them in the
optstring (copied from ARM?) but not in OPT_*. Would you like me to
clean this up too in v3?

In summary: undocumented, on one platform.

P.S. Please, cc me. I am not subscribed to the list.
=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAl6dsqcACgkQsK4enJil
gBCwnwf+LMYEqxAgSDJ5GXBStjQQaQscJPPVtESlndKLZtwH8I9O5wUnmUM2CNUp
LnBf7TTmLjnKF6AmF7gJnQ5eaMkKOPi+wiYGg+3uMPnq13Bi8Qrw8OtWwu1Te7Fr
yFsXPAa6T/dDqvj3nOQ27SImBFg2QBr3O/cTbUF+32fPB58y+dngEiznFs9wT+1/
qrt5FsZA3PPoV8fP2SBm0deBhD1DMToSgsW+u2xJ3x5s1PDb4P/b2tC3BlQ6hPvh
zCdpNOWJ7JVxwS7RhhcTVSUsZQCbbdw9szwg8wEyaviw7PUr34JksDB/YizjPFpB
PYh6zTAzE92mWti/iSDX49itk89c1Q==
=WpTA
-----END PGP SIGNATURE-----
--=-=-=--


--===============8638328130123976302==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============8638328130123976302==--

