Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.windriver.com ([147.11.1.11])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Yngv1-0002KZ-9E
 for kexec@lists.infradead.org; Thu, 30 Apr 2015 05:21:51 +0000
Date: Thu, 30 Apr 2015 13:21:24 +0800
From: Kevin Hao <kexin.hao@windriver.com>
Subject: Re: [PATCH] purgatory: Disabling GCC's stack protection
Message-ID: <20150430052124.GD29972@pek-khao-d1.corp.ad.wrs.com>
References: <1430225419-23969-1-git-send-email-kexin.hao@windriver.com>
 <20150430043950.GD15511@verge.net.au>
 <20150430050809.GI15511@verge.net.au>
MIME-Version: 1.0
In-Reply-To: <20150430050809.GI15511@verge.net.au>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0143748251429366837=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

--===============0143748251429366837==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/7F8UcOhwbEJvS7n"
Content-Disposition: inline

--/7F8UcOhwbEJvS7n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2015 at 02:08:09PM +0900, Simon Horman wrote:
> On Thu, Apr 30, 2015 at 01:39:50PM +0900, Simon Horman wrote:
> > Hi Kevin,
> >=20
> > On Tue, Apr 28, 2015 at 08:50:19PM +0800, Kevin Hao wrote:
> > > If the GCC's stack protection is enabled by default, the purgatory wi=
ll
> > > also be built with this option. But it makes no sense to enable this
> > > for the purgatory code, and would cause error when we are trying to
> > > relocate the purgatory codes because symbol like __stack_chk_fail is
> > > unresolved. Instead of disabling this for some archs specifically,
> > > disable it for all the archs.
> > >=20
> > > Signed-off-by: Kevin Hao <kexin.hao@windriver.com>
> >=20
> > This seems like a reasonable change to me, however, it does
> > not apply cleanly to the kexec tree on kernel.org which I maintain.
> >=20
> > https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
> >=20
> > Could you rebase and repost?
>=20
> I have now realised that Mike Frysinger has posted a similar,
> slightly more comprehensive, patch which I have now applied.
>=20
> Could you see if it addresses the problem you are seeing?
>=20
> It is the following commit in the above tree:
>=20
> 4a837c9a19f9 purgatory: force PIC/PIE/SSP off

Yes, it should solve my problem too. I didn't realized there already have
a patch for this issue. Sorry for the noise.

Thanks,
Kevin

--/7F8UcOhwbEJvS7n
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJVQbvUAAoJEJNY7TDerrFxlmcIAKlfTc17RyxYaONCM6u32mma
uOzY0RB0lC5KPfDKm6cj/xWXvEmwS87L5akSvxvHufKZZYKbM+6oAJuAg/+e80Wh
rTe1yJIwBlYQW3o6LTDrcxedvsKYAApZe/KZYiKSSKd/u7OH+ClMt2wzIg5PRbPY
3PEVF3TDx+g6LKFfBvEkYnYvuQkPxDbBFpUCaxFz5NY6GOlUIA7kqHMJEsL3KhiW
fnvO8uGLK8ZmTv28EA9OnedXXMhCeTmt/p02w0DTR/I+h1krcmCHuNVLDXMRk0mu
nSRsxlW0fw5xzc1k4l7W6wrpboW7p6AzyEBoQtP8QcLt08nmPINEIrnpB43S0eE=
=2SG2
-----END PGP SIGNATURE-----

--/7F8UcOhwbEJvS7n--


--===============0143748251429366837==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0143748251429366837==--

