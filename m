Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vigg6-0000l0-Vz
 for kexec@lists.infradead.org; Tue, 19 Nov 2013 08:28:59 +0000
Date: Tue, 19 Nov 2013 09:28:27 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH 4/4] kexec/xen: directly load images images into Xen
Message-ID: <20131119082827.GC30799@olila.local.net-space.pl>
References: <1383749722-12091-1-git-send-email-david.vrabel@citrix.com>
 <1383749722-12091-5-git-send-email-david.vrabel@citrix.com>
 <20131119012014.GC17628@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131119012014.GC17628@verge.net.au>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, David Vrabel <david.vrabel@citrix.com>, xen-devel@lists.xen.org

On Tue, Nov 19, 2013 at 10:20:14AM +0900, Simon Horman wrote:
> On Wed, Nov 06, 2013 at 02:55:22PM +0000, David Vrabel wrote:
> > From: David Vrabel <david.vrabel@citrix.com>
> >
> > Xen 4.4 has an improvided kexec hypercall ABI that allows images to be
> > loaded and executed without any kernel involvement.  Use the API
> > provided by libxc to load images when running in a Xen guest.
> >
> > Support for loading images via the kexec_load syscall in non-upstream
> > ("classic") Xen kernels is no longer supported.
> >
> > Signed-off-by: David Vrabel <david.vrabel@citrix.com>
> > Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>
> > ---
> >  kexec/Makefile                  |    1 +
> >  kexec/arch/i386/crashdump-x86.c |   20 +++++-
> >  kexec/crashdump-xen.c           |   34 ++++++++++
> >  kexec/crashdump.h               |    3 +-
> >  kexec/kexec-xen.c               |  139 +++++++++++++++++++++++++++++++++++++++
> >  kexec/kexec.c                   |   24 +++++--
> >  kexec/kexec.h                   |    5 ++
> >  7 files changed, 218 insertions(+), 8 deletions(-)
> >  create mode 100644 kexec/kexec-xen.c
> >

[...]

> I have applied the following follow-up patch to resolves some errors.
> Let me know if I messed it up.
>
> From: Simon Horman <horms@verge.net.au>
>
> [PATCH] kexec/xen: Correct some compile errors
>
> Correct various problems introduced by
> 08cf823704b0fa3b ("kexec/xen: directly load images images into Xen").
>
> These all relate to the case here HAVE_LIBXENCTRL is not set.
>
> Signed-off-by: Simon Horman <horms@verge.net.au>
> ---
>  kexec/kexec-xen.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/kexec/kexec-xen.c b/kexec/kexec-xen.c
> index 77f65c0..e885246 100644
> --- a/kexec/kexec-xen.c
> +++ b/kexec/kexec-xen.c
> @@ -2,6 +2,7 @@
>  #include <stdio.h>
>  #include <string.h>
>  #include <stdlib.h>
> +#include <stdlib.h>

Thanks for fixes but why are you including stdlib.h twice?

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
