Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-iw0-f177.google.com ([209.85.214.177])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1P3F1b-0005bC-NQ
	for kexec@lists.infradead.org; Tue, 05 Oct 2010 21:26:20 +0000
Received: by iwn1 with SMTP id 1so2323543iwn.36
	for <kexec@lists.infradead.org>; Tue, 05 Oct 2010 14:26:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1286306243-14236-1-git-send-email-msm@freescale.com>
References: <1286306243-14236-1-git-send-email-msm@freescale.com>
Date: Wed, 6 Oct 2010 01:26:14 +0400
Message-ID: <AANLkTikW216sA4nu1bwmjLG7RY3hHwMB7A6yvKgNoNZZ@mail.gmail.com>
Subject: Re: [PATCH] kexec/ppc: Use -O0 instead of -Os for purgatory
From: Maxim Uvarov <muvarov@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Matthew McClintock <msm@freescale.com>
Cc: kexec@lists.infradead.org

I'm ok with that changes. I'm not sure why kernel did not turn this
optimization off and goes
with compiling crt.s with sources. There could be a reasons for that.
More likely to not put anything from
libgcc to kernel. We should do the same for purgatory code. So maybe
it's reasonable
to apply my patch and go the same way as kernel goes (but it will
break old compilers, that should not
be huge problem.)

Maxim.

2010/10/5 Matthew McClintock <msm@freescale.com>:
> Purgatory code with -Os is not working on certain compilers,
> instead of finding out the hard way, just compile with -O0
>
> Signed-off-by: Matthew McClintock <msm@freescale.com>
> ---
> Tried to get a dicussion going on this issue, but for now I
> suspect it is better to have a working kexec on ppc instead of
> waiting
>
> =A0purgatory/arch/ppc/Makefile | =A0 =A02 ++
> =A01 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/purgatory/arch/ppc/Makefile b/purgatory/arch/ppc/Makefile
> index 72289a0..319870e 100644
> --- a/purgatory/arch/ppc/Makefile
> +++ b/purgatory/arch/ppc/Makefile
> @@ -2,6 +2,8 @@
> =A0# Purgatory ppc
> =A0#
>
> +ppc_PURGATORY_EXTRA_CFLAGS =3D -O0
> +
> =A0ppc_PURGATORY_SRCS +=3D purgatory/arch/ppc/v2wrap_32.S
> =A0ppc_PURGATORY_SRCS +=3D purgatory/arch/ppc/misc.S
> =A0ppc_PURGATORY_SRCS +=3D purgatory/arch/ppc/purgatory-ppc.c
> --
> 1.6.6.1
>
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>



-- =

Best regards,
Maxim Uvarov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
