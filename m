Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JRkHx-00048Q-WE
	for kexec@lists.infradead.org; Wed, 20 Feb 2008 08:26:50 +0000
Received: from tabatha.lab.ultramonkey.org (vagw.valinux.co.jp [210.128.90.14])
	by koto.vergenet.net (Postfix) with ESMTP id 6753534186
	for <kexec@lists.infradead.org>; Wed, 20 Feb 2008 17:26:43 +0900 (JST)
Date: Wed, 20 Feb 2008 17:26:42 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [ANNOUNCE] kexec-tools-testing v20071017-rc
Message-ID: <20080220082641.GA24174@verge.net.au>
References: <20080219081130.GA3919@verge.net.au>
	<20080219160512.GA15701@suse.de>
	<20080220015114.GC18944@verge.net.au>
	<20080220075245.GA5542@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080220075245.GA5542@suse.de>
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

On Wed, Feb 20, 2008 at 08:52:45AM +0100, Bernhard Walle wrote:
> * Simon Horman <horms@verge.net.au> [2008-02-20 02:51]:
> > > 
> > > Can you fix this? :)
> > 
> > Appologies. This has now been fixed.
> 
> Thanks! I also get following error when trying to build
> 
> $ make
> make: *** No rule to make target `/home/horms/local/opt/crosstool/i686/gcc-3.4.5-glibc-2.3.6/i686-unknown-linux-gnu/bin/../lib/gcc/i686-unknown-linux-gnu/3.4.5/../../../../i686-unknown-linux-gnu/sys-include/stdio.h', needed by `kexec/kexec.o'.  Stop.
> 
> "make clean" before works.

Ok, thanks for pointing that out. I'll fix up the tarball creation code.

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
