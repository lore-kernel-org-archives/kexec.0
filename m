Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from nigel.suspend2.net ([203.171.70.205])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IBLY0-0005DY-0E
	for kexec@lists.infradead.org; Wed, 18 Jul 2007 22:15:22 -0400
From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [PATH 0/1] Kexec jump - v2 - the first step to kexec based
	hibernation
Date: Thu, 19 Jul 2007 12:15:04 +1000
References: <1184483593.1898.98.camel@caritas-dev.intel.com>
	<20070718180420.02352d4f.akpm@linux-foundation.org>
In-Reply-To: <20070718180420.02352d4f.akpm@linux-foundation.org>
MIME-Version: 1.0
Message-Id: <200707191215.05245.nigel@nigel.suspend2.net>
Reply-To: nigel@suspend2.net
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1511614115=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: david@lang.hm, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

--===============1511614115==
Content-Type: multipart/signed; boundary="nextPart2351488.ktMTUd6rUM";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2351488.ktMTUd6rUM
Content-Type: text/plain;
  charset="cp 850"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 19 July 2007 11:04:20 Andrew Morton wrote:
> On Sun, 15 Jul 2007 15:13:13 +0800
> "Huang, Ying" <ying.huang@intel.com> wrote:
>=20
> >=20
> > The changelog between v1 and v2
> >=20
> > 1. The kexec jump implementation is put into the kexec/kdump
> >    framework instead of software suspend framework. The device
> >    and CPU state save/restore code of software suspend is called
> >    when needed.
> >=20
> > 2. The same code path is used for both kexec a new kernel and jump
> >    back to original kernel.
>=20
> I like the idea but I think I'll let people chat about it a bit more
> before looking at merging the patches, OK?

Please wait until you see a complete implementation that actually works. I'=
m=20
sitting here quietly, following (and now breaking) the "If you can't say=20
anything positive, don't say anything at all" line because I think that the=
=20
more into the implementation details people get, the uglier this is going t=
o=20
show itself to be. I'm perfectly willing to be proven wrong, but haven't se=
en=20
anything so far that's even begun to convince me otherwise.

Regards,

Nigel
=2D-=20
See http://www.tuxonice.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart2351488.ktMTUd6rUM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGnskpN0y+n1M3mo0RAge8AJoCwiUagG8l1xI7rk+vYajJQgkt+wCg6QPU
PRSGoff64GJ4SvF1YCkgYBg=
=2IrP
-----END PGP SIGNATURE-----

--nextPart2351488.ktMTUd6rUM--


--===============1511614115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1511614115==--

