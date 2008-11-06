Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx40.mail.ru ([194.67.23.36])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Ky7AX-00060s-6d
	for kexec@lists.infradead.org; Thu, 06 Nov 2008 15:53:13 +0000
From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: [PATCH 15/15] Revert "x86: default to reboot via ACPI"
Date: Thu, 6 Nov 2008 18:53:05 +0300
References: <1225915018-6548-1-git-send-email-ehabkost@redhat.com>
	<20081106143021.GD13023@elte.hu> <20081106150610.GA1644@elte.hu>
In-Reply-To: <20081106150610.GA1644@elte.hu>
MIME-Version: 1.0
Message-Id: <200811061853.08003.arvidjaar@mail.ru>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1728619789=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Avi Kivity <avi@redhat.com>

--===============1728619789==
Content-Type: multipart/signed; boundary="nextPart3611024.4Tzsott5ad";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3611024.4Tzsott5ad
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

[I had to trim direct recipients as my provider would refuse deliver
claiming it is spam]

On Thursday 06 November 2008, Ingo Molnar wrote:
>=20
> * Ingo Molnar <mingo@elte.hu> wrote:
>=20
> > > Andrey Borzenkov's patch, for example, adds a new DMI entry=20
> > > because reboot=3Dacpi breaks his keyboard (even without KVM, I=20
> > > guess). Andrey, was that the case?
> >=20
> > hm, IIRC the problem was KVM in his case too.
>=20
> actually, Andrey's problem seems to be unrelated. So i've queued up=20
> the revert below in tip/x86/urgent for v2.6.28. Thanks guys!
>=20

Yes, I do not use KVM. Actually my CPU (PIII) does not even support
virtualization.

> 	Ingo
>=20
> ---------------->
> From 8d00450d296dedec9ada38d43b83e79cca6fd5a3 Mon Sep 17 00:00:00 2001
> From: Eduardo Habkost <ehabkost@redhat.com>
> Date: Tue, 4 Nov 2008 12:52:44 -0200
> Subject: [PATCH] Revert "x86: default to reboot via ACPI"
>=20
> This reverts commit c7ffa6c26277b403920e2255d10df849bd613380.
>=20
> the assumptio of this change was that this would not break
> any existing machine. Andrey Borzenkov reported troubles with
> the ACPI reboot method: the system would hang on reboot, necessiating
> a power cycle. Probably more systems are affected as well.
>=20

To be precise - system reboots but keyboard is non-functional after that.
Power off is required to clear this condition.

I am fine with either way (revert or DMI). But if problem which ACPI
reboot fixed (or worked around) is not solved differently I think
reverting to old way is better.

> Also, there are patches queued up for v2.6.29 to disable virtualization
> on emergency_restart() - which was the original motivation of
> this change.
>=20
> Reported-by: Andrey Borzenkov <arvidjaar@mail.ru>
> Bisected-by: Andrey Borzenkov <arvidjaar@mail.ru>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> Acked-by: Avi Kivity <avi@redhat.com>
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> ---
>  arch/x86/kernel/reboot.c |    6 +-----
>  1 files changed, 1 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
> index f4c93f1..724adfc 100644
> --- a/arch/x86/kernel/reboot.c
> +++ b/arch/x86/kernel/reboot.c
> @@ -29,11 +29,7 @@ EXPORT_SYMBOL(pm_power_off);
> =20
>  static const struct desc_ptr no_idt =3D {};
>  static int reboot_mode;
> -/*
> - * Keyboard reset and triple fault may result in INIT, not RESET, which
> - * doesn't work when we're in vmx root mode.  Try ACPI first.
> - */
> -enum reboot_type reboot_type =3D BOOT_ACPI;
> +enum reboot_type reboot_type =3D BOOT_KBD;
>  int reboot_force;
> =20
>  #if defined(CONFIG_X86_32) && defined(CONFIG_SMP)
>=20
>=20



--nextPart3611024.4Tzsott5ad
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkTEuMACgkQR6LMutpd94yH5QCgrM8x9e9RfhnpwYr8marXgSR3
86wAnigAsx3VuR4y/r8Gk0glOdm06Tu/
=Idq1
-----END PGP SIGNATURE-----

--nextPart3611024.4Tzsott5ad--


--===============1728619789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1728619789==--

