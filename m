Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [139.28.40.42] (helo=tarta.nabijaczleweli.xyz)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kVzBj-0002a3-Bm
 for kexec@lists.infradead.org; Fri, 23 Oct 2020 15:41:12 +0000
Date: Fri, 23 Oct 2020 17:41:03 +0200
From: Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Subject: Re: [PATCH 2/5] configure.ac, arch/x86_64: handle x32 as subarch of
 x86_64 and don't specify -mcmodel=large there
Message-ID: <20201023154103.vwhdqxpguzlpvmwq@tarta.nabijaczleweli.xyz>
References: <cover.1602257696.git.nabijaczleweli@nabijaczleweli.xyz>
 <9c10bfea476b312f98664058d4553e96b94157d2.1602257696.git.nabijaczleweli@nabijaczleweli.xyz>
 <20201023143307.GC9820@vergenet.net>
MIME-Version: 1.0
In-Reply-To: <20201023143307.GC9820@vergenet.net>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3274263971614374132=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org


--===============3274263971614374132==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xkkr5zprzpbok3cm"
Content-Disposition: inline


--xkkr5zprzpbok3cm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2020 at 04:33:07PM +0200, Simon Horman wrote:
> On Fri, Oct 09, 2020 at 05:39:42PM +0200, Ahelenia Ziemia=C5=84ska wrote:
> > Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.=
xyz>
> > ---
> >  configure.ac                   | 8 ++++++++
> >  purgatory/arch/x86_64/Makefile | 2 ++
> >  2 files changed, 10 insertions(+)
> >=20
> > diff --git a/configure.ac b/configure.ac
> > index f025823..4e8f7c5 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -54,6 +54,14 @@ case $target_cpu in
> >  		;;
> >  	ia64|x86_64|alpha|m68k )
> >  		ARCH=3D"$target_cpu"
> > +		case $target in
> > +			*x32 )
> > +				SUBARCH=3D"x32"
> > +				;;
> > +			* )
> > +				SUBARCH=3D""
> > +				;;
> > +		esac
>=20
> Is x32 value only for x86_64 or ia64, x886_64, alpha and m68k as
> seems to be implied by this change?

There is, indeed, no x32 equivalent for non-amd64,
but I just put this here like this because there aren't
any other triples that end in "x32". Would you rather this go
in a separate "if ARCH=3Dx86_64 && target=3D*x32" clause below?

> Also, could you let me know how to exercise compiling this changeset?

The easiest way would be to install GCC for "x86_64-linux-gnux32";
on Buster, installing gcc-x86-64-linux-gnux32 followed by
  ./configure --host=3Dx86_64-linux-gnux32
worked and built.

Alternatively, you could use an x32 chroot via something
along the lines of
  debootstrap --arch=3Dx32 --variant=3Dminbase
    --include=3Ddebian-ports-archive-keyring --no-check-gpg sid target
    https://deb.debian.org/debian-ports
and proceeding as normal within.

To test the kexecution and/or get the x32 userland to run, you'll need
your kernel to have CONFIG_X86_X32=3Dy, or, on Debian amd64 kernels,
to pass syscall.x32=3Dy on the cmdline.

Best,
Ahelenia

--xkkr5zprzpbok3cm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAl+S+YwACgkQvP0LAY0m
WPGt4w/8DjB8TU64Zm8lUSgA+8Fy6uBIsum98Y8TuDlUWkZyhZmARsuu1IErKx0a
X7DTVclDTUUBgPWYb61GPWESJTQmgtO8HwynLrX5Y1ZtFbkBRa7cGupY9ozK48Nz
xe7qkjUjk/r3S7akWLpqpBZmK/kfxSfyJMR9KuDBcxdfcYvqSrprP8Y5lT5qazlV
yarD6W3Y8AU4Hqot4HEVAO1k4Tt2MWuGL2ETh+QTmavbUwWerOD9yki4Xvc5Lo1s
M5dm2y45PIA1lgeSeFW9dogh+6hD2CHYUHxvtWMWaPrjYi31iIBkOVqLQhPaTt8o
nbs/X7nv9M64Mbp1sVvzsVXSAcIJrmObENTsMkm+88PQN9251NBiOOQPorXyLaPD
upZl0SP2oRYy3ROyRFKHdBjkwKHZoGSxJbmhd3frg896obtQw2NKndKXZVA9exOZ
DvNPHevUoSsGJTbc/wwcHlhOuWvcMFbeefQ5kO6RmFK1u1oqaQjuTCGu/mkQNVxg
WvG6lCvSaCFvIQ1DX2Sv8LAbhiUfKIutTI+19BVQyeYGHCryJeG2l87+kAVTubOm
qBa4FN/bWlvAfsx3WjDE4oLckCLUMrMV8T58EWn7/UI0Ftb7aQB/62USokfvZlHx
F0IYLlE4HVi8tE2dx3AtvHbraFF5FNmMjekIWYapJBpz9yB8ySg=
=+nUx
-----END PGP SIGNATURE-----

--xkkr5zprzpbok3cm--


--===============3274263971614374132==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============3274263971614374132==--

