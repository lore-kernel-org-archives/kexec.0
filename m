Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KYGNc-0001Ko-An
	for kexec@lists.infradead.org; Wed, 27 Aug 2008 08:27:53 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7R8RmZH014856
	for <kexec@lists.infradead.org>; Wed, 27 Aug 2008 04:27:48 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m7R8RlUd200986
	for <kexec@lists.infradead.org>; Wed, 27 Aug 2008 02:27:47 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m7R8RlSi015305
	for <kexec@lists.infradead.org>; Wed, 27 Aug 2008 02:27:47 -0600
Message-ID: <48B51000.4010603@in.ibm.com>
Date: Wed, 27 Aug 2008 13:57:44 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH] Let kexec work on IBM QS2x blade servers
References: <OF33221B02.C088FDA5-ONC12574B2.002C5BF5-C12574B2.002C7A61@de.ibm.com>
In-Reply-To: <OF33221B02.C088FDA5-ONC12574B2.002C5BF5-C12574B2.002C7A61@de.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Maxim Shchetynin <maxim@de.ibm.com>
Cc: kexec@lists.infradead.org

Maxim Shchetynin wrote:
> Hello,
> =

> please have a look at the following patch. This patch allows kexec to work
> on IBM QS2x blades. Would it be possible to apply this patch to a next
> kexec version?
> =

> From: Maxim Shchetynin <maxim@de.ibm.com>.
> Signed-off-by: Maxim Shchetynin <maxim@de.ibm.com>
> ---
> =

> diff -Nuar
> kexec-tools-testing-20070330/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
> kexec-tools-testing-20070330-fixed/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
> --- kexec-tools-testing-20070330/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
> 2007-03-30 06:34:36.000000000 +0200
> +++
> kexec-tools-testing-20070330-fixed/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
> 2008-06-19 17:35:23.000000000 +0200
> @@ -56,6 +56,7 @@
>             break;
> =


Hi Maxim,

>       case R_PPC64_ADDR64:
> +     case R_PPC64_REL64::

Why do we need to process R_PPC64_REL64 relocation type specially for =

QS2x blades? Is it specific to tool chain version or platform?


>             /* Simply set it */
>             *(uint64_t *)location =3D value;
>             break;
> =


Regards,
Mohan.


> Mit freundlichen Gr=FC=DFen / met vriendelijke groeten / avec regards
> =

>     Maxim V. Shchetynin
>     Linux Kernel Entwicklung
>     IBM Deutschland Research & Development GmbH
>     Linux f=FCr Cell, Abteilung 3250
>     Sch=F6naicher Stra=DFe 220
>     71032 B=F6blingen
> =

> Vorsitzender des Aufsichtsrats: Martin Jetter
> Gesch=E4ftsf=FChrung: Herbert Kircher
> Sitz der Gesellschaft: B=F6blingen
> Registriergericht: Amtsgericht Stuttgart, HRB 243294
> =

> Fahr nur so schnell wie dein Schutzengel fliegen kann!
> =

> =

> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
