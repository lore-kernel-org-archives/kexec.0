Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1HrPS3-0003TK-L6
	for kexec@lists.infradead.org; Thu, 24 May 2007 22:22:49 -0400
Date: Fri, 25 May 2007 11:22:35 +0900
From: Horms <horms@verge.net.au>
Subject: Re: [PATCH] fix kexec-tools options
Message-ID: <20070525022234.GI26510@verge.net.au>
References: <20070524124936.GA7982@in.ibm.com> <26898.1180015012@neuling.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <26898.1180015012@neuling.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Michael Neuling <mikey@neuling.org>
Cc: kexec@lists.infradead.org, maneesh@in.ibm.com

On Thu, May 24, 2007 at 11:56:52PM +1000, Michael Neuling wrote:
> > o value for OPT_REUSE_INITRD clashes with arch specific options which are
> >   defined as (OPT_MAX + 1), like --serial option on x86_64. Changed the
> >   values so that OPT_REUSE_INITRD is less than OPT_MAX.
> > 
> > Signed-off-by: Maneesh Soni <maneesh@in.ibm.com>
> 
> Oops.. thanks for fixing.
> 
> > ----
> > --- kexec.h.orig	2007-05-15 10:06:33.000000000 +0530
> > +++ kexec.h	2007-05-24 17:37:34.000000000 +0530
> 
> BTW the path has been stripped here, so this patch doesn't apply.  I've
> fixed it up and reposted below.
> 
> Mikey

Thanks guys, applied.

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
