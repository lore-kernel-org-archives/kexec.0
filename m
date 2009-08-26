Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MgG5L-0001vV-77
	for kexec@lists.infradead.org; Wed, 26 Aug 2009 10:50:40 +0000
Date: Wed, 26 Aug 2009 20:50:30 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: kexec-tools-2.0.1 and CFLAGS
Message-ID: <20090826105024.GC18761@verge.net.au>
References: <aec7e5c30908200614j68c1ad6ci7a3d8d1b9f98d08b@mail.gmail.com>
	<20090826063117.GB18761@verge.net.au>
	<aec7e5c30908260056w629fb2fp4be4c8660860f1c4@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aec7e5c30908260056w629fb2fp4be4c8660860f1c4@mail.gmail.com>
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
To: Magnus Damm <magnus.damm@gmail.com>
Cc: kexec@lists.infradead.org

On Wed, Aug 26, 2009 at 04:56:49PM +0900, Magnus Damm wrote:
> Hi Simon!
> =

> On Wed, Aug 26, 2009 at 3:31 PM, Simon Horman<horms@verge.net.au> wrote:
> > On Thu, Aug 20, 2009 at 10:14:19PM +0900, Magnus Damm wrote:
> >> Kexec-tools 2.0.1 seems to build only with optimization enabled. If I
> >> set CFLAGS before calling configure and remove the "-O2" then the code
> >> won't link properly. I found it while cross compiling for SuperH, but
> >> it's most likely an issue on other platforms as well. Have a look at
> >> the "-O0" below:
> >>
> >> =A0$ AR=3D_ar CC=3D_gcc CFLAGS=3D"-O0" LDFLAGS=3D"-static" ./configure
> >> --prefix=3D/ --host=3D"sh3-linux" --without-zlib --without-xen
> =

> [snip]
> =

> >> This issue is most likely related to get_unaligned() and
> >> put_unaligned() having bad_unaligned_access_length() in their default
> >> case that never gets optimized away.
> >>
> >> Anyway, not very important. But at least you know now. =3D)
> >
> > Hi Magnus,
> >
> > I'm some what dubious about this, but it appears to be intentional that
> > get_unaligned() doesn't exist:
> >
> > ---- From kexec/kexec.h ----
> >
> > /*
> > =A0* This function doesn't actually exist. =A0The idea is that when som=
eone
> > =A0* uses the macros below with an unsupported size (datatype), the lin=
ker
> > =A0* will alert us to the problem via an unresolved reference error.
> > =A0*/
> =

> Yes, I understand the purpose of the code and it makes sense. But the
> data size in this case _is_ correct. The issue here seems to be that
> the compiler is not optimizing away the default case reference unless
> optimization is enabled. I'd suggest moving away from automatic type
> size detection to have separate functions for each size. That would
> make it possible to comple the code both with and without optimization
> enabled.
> =

> Or may I'm misunderstanding the issue? =3D)

I think you are understanding it right, that the current code fails
with no optimisation enabled because the unused function isn't optimised
away. Is there a reason you need -O0? It seems that fixing this is probably
more effort than its worth.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
