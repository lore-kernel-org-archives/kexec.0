Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JSMpy-0004Qa-0P
	for kexec@lists.infradead.org; Fri, 22 Feb 2008 01:36:30 +0000
Received: from tabatha.lab.ultramonkey.org (vagw.valinux.co.jp [210.128.90.14])
	by koto.vergenet.net (Postfix) with ESMTP id 6F9B7341BD
	for <kexec@lists.infradead.org>; Fri, 22 Feb 2008 10:36:24 +0900 (JST)
Date: Fri, 22 Feb 2008 10:36:22 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [ANNOUNCE] kexec-tools-testing v20080221-rc
Message-ID: <20080222013620.GA29572@verge.net.au>
References: <20080221091628.GA15981@verge.net.au>
	<20080221100139.GA3815@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080221100139.GA3815@suse.de>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

On Thu, Feb 21, 2008 at 11:01:39AM +0100, Bernhard Walle wrote:
> * Simon Horman <horms@verge.net.au> [2008-02-21 10:16]:
> > 
> > commit e959e493753c740eb7554bc2191c58b079761e11
> > Author: Simon Horman <horms@verge.net.au>
> > 
> >     Only include needed files in distribution tarball
> > 
> >  create mode 100644 doc/Makefile
> >  create mode 100644 include/Makefile
> >  create mode 100644 kexec/arch/alpha/Makefile
> 
> I think the configure script should be distributed with the tarball,
> not only configure.ac. Usually, "make dist" should be used to generate
> a working distribution tarball.

Yes agreed.

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
