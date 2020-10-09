Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [139.28.40.42] (helo=tarta.nabijaczleweli.xyz)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQumQ-0000SV-3M
 for kexec@lists.infradead.org; Fri, 09 Oct 2020 15:58:04 +0000
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
 by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id EDC8A3605DD
 for <kexec@lists.infradead.org>; Fri,  9 Oct 2020 17:39:19 +0200 (CEST)
Date: Fri, 9 Oct 2020 17:39:18 +0200
From: Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Subject: [PATCH 0/5] x32 support
Message-ID: <cover.1602257696.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7160665839841291936=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org


--===============7160665839841291936==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7exblbj6zn43rwry"
Content-Disposition: inline


--7exblbj6zn43rwry
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patchset essentially boils down to:
  (a) disabling -mcmodel=3Dlarge, and
  (b) allowing ELFCLASS32 in x86_64.

I've also updated the autotools scripts so they detect x32 correctly
and fixed some warnings.

Ahelenia Ziemia=C5=84ska (5):
  config: update to latest config.{sub,guess}, install-sh
  configure.ac, arch/x86_64: handle x32 as subarch of x86_64 and don't
    specify -mcmodel=3Dlarge there
  i386/kexec-mb2-x86.c: cast ints to uintptr_t before pointers to avoid
    warnings
  i386: fix string formatting-related warnings
  x86_64: allow ELFCLASS32 for x32 support

 config/config.guess                      | 1048 +++++----
 config/config.sub                        | 2603 +++++++++++-----------
 config/install-sh                        |  401 ++--
 configure.ac                             |    8 +
 kexec/arch/i386/kexec-mb2-x86.c          |    6 +-
 kexec/arch/i386/x86-linux-setup.c        |   16 +-
 kexec/arch/x86_64/kexec-elf-rel-x86_64.c |    3 +-
 purgatory/arch/x86_64/Makefile           |    2 +
 8 files changed, 2157 insertions(+), 1930 deletions(-)

--=20
2.28.0

--7exblbj6zn43rwry
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAl+AhBsACgkQvP0LAY0m
WPEHgw//Yvy/ONmRr5Wq7qjkhN6VhAerFqmhEDNmTuvDVM6IRY+rArmUyrop+bNT
iek4tOtpmKeT/a9ym1AM9pvNG+quUfKlSloO664WECPwfajs6gX3XsxG57aEWr9I
NsR2v7XddUntf7Nrns233gRoERA4MmZh7NEVVEG704cCMrn3xUkDw+7RdbIXHIld
O7aqM/6Ru9dUZQ4JSWk2M9q2kvboGuWM+PLvdhhmcyAF1T2zmsjCg9DkDk6ujmOi
DfV1mQleK4p9XpAY+sraAEXwXscRSmaY4yc09iHkPrGp5DyTZd4G4+OXG2f2yd+x
fo5MFOPYiQKXLZAbFGjKcR20p650FRdnMEB1K7H+lUdvpY4q99Rj+DPoVteu6YaN
G++6fv3wQ7OFEITnE3hmmVzQYbmK0tMwLBcUJAJ/p26gZv6EzMXLnDE5Ps/tf7g3
H+Cafe14dgCUwaKrbpC46CyMXbQiB/kETvSjekO2N4RqhFIM/TcutoT8xpq7L5Lq
f9niQCqWRY7Iqz91oiUtWYyavnxG7EmnGKPHhjg9tqNwh2nnrK2Jj50fB95uj3IQ
4Cg8UhUa9i+4vPAHiNBSYIWN4m0WufrgWGd1V/aVL02YucW8MbL/Y0TUnd43ClNc
Te93A03373Idu9VQaUyt+SuLT4e9wXsJxi6OG6f3YAASs24FfN8=
=nXzT
-----END PGP SIGNATURE-----

--7exblbj6zn43rwry--


--===============7160665839841291936==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============7160665839841291936==--

