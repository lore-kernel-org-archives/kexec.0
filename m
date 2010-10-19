Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1P8Ed9-0004KM-NK
	for kexec@lists.infradead.org; Tue, 19 Oct 2010 16:01:42 +0000
Date: Tue, 19 Oct 2010 18:02:07 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec/powerpc fix optimization for size (gcc -Os) build
Message-ID: <20101019160205.GA25114@verge.net.au>
References: <20100930155216.32565.36595.stgit@localhost.localdomain>
	<1287465116.2190.8.camel@mattsm-VirtualBox>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1287465116.2190.8.camel@mattsm-VirtualBox>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Matthew McClintock <msm@freescale.com>
Cc: Maxim Uvarov <muvarov@gmail.com>, mshiokawa@miraclelinux.com, kexec@lists.infradead.org

On Tue, Oct 19, 2010 at 12:11:56AM -0500, Matthew McClintock wrote:
> On Thu, 2010-09-30 at 19:52 +0400, Maxim Uvarov wrote:
> > crt.S patch had fixes for gcc -Os (optimaze for size), same as
> >     kernel has. Without this fixes powerpc gcc 4.4 generates forever
> >     loop functions for kexec.
> > 
> >     This happends because crtsavres code was spit up to individual files
> >     (http://gcc.gnu.org/ml/gcc-patches/2008-03/msg01294.html) and
> >     kexec purgatory code has following options:
> >     --no-undefined -nostartfiles -nostdlib -nodefaultlibs
> >     So in that case crtasaveregs function are not defined and final object
> >     file has been linked without them.  This does not happen with applications
> >     built without -nostdlib, because gcc will add it's standard functions.
> > Signed-off-by: Maxim Uvarov <muvarov@gmail.com>
> 
> Acked-by: Matthew McClintock <msm@freescale.com> 
> 
> In lieu of
> http://lists.infradead.org/pipermail/kexec/2010-October/004600.html

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
