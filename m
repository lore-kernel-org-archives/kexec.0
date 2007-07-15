Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from nigel.suspend2.net ([203.171.70.205])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IACUb-0005GF-HO
	for kexec@lists.infradead.org; Sun, 15 Jul 2007 18:23:07 -0400
From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [PATH 0/1] Kexec jump - v2 - the first step to kexec based
	hibernation
Date: Sun, 15 Jul 2007 19:08:04 +1000
References: <1184483593.1898.98.camel@caritas-dev.intel.com>
In-Reply-To: <1184483593.1898.98.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Message-Id: <200707151908.05388.nigel@nigel.suspend2.net>
Reply-To: nigel@suspend2.net
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1676602157=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: david@lang.hm, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

--===============1676602157==
Content-Type: multipart/signed; boundary="nextPart2387600.KdldWAbgaJ";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2387600.KdldWAbgaJ
Content-Type: text/plain;
  charset="cp 850"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Sunday 15 July 2007 17:13:13 Huang, Ying wrote:
> The complete changelog of the patch is as follow:
>=20
> ---
>=20
> Kexec base hibernation has some potential advantages over uswsusp and
> TuxOnIce (suspend2). Some most obvious advantages are:
>=20
> 1. The hibernation image size can exceed half of memory size easily.
> 2. The hibernation image can be written to and read from almost
>    anywhere, such as USB disk, NFS.

This isn't right. TuxOnIce has no problem with image sizes exceeding half t=
he=20
amount of memory, and both uswsusp and TuxOnIce could write to a USB disk/k=
ey=20
or NFS as well. Historically, the issue with writing to USB devices has bee=
n=20
an issue with USB device drivers, not hibernation implementations. I haven'=
t=20
tried writing an image to USB, but with the work on the drivers, I wouldn't=
=20
be surprised if it was usable now. NFS? Again, I haven't tried, but wouldn'=
t=20
expect it to be impossible. I did try writing an image to an NBD device a=20
couple of years ago. It didn't quite work, but wasn't far away.
=20
Regards,

Nigel
=2D-=20
See http://www.tuxonice.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart2387600.KdldWAbgaJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGmeP1N0y+n1M3mo0RAoHhAJ9YREzwIWYaoPvbA4ET8xBpobd93gCgg9TC
j7gTdHPM36nEygefLK6wyC0=
=q9qY
-----END PGP SIGNATURE-----

--nextPart2387600.KdldWAbgaJ--


--===============1676602157==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1676602157==--

