Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JSTnr-0000ZW-7C
	for kexec@lists.infradead.org; Fri, 22 Feb 2008 09:02:47 +0000
Received: from tabatha.lab.ultramonkey.org (vagw.valinux.co.jp [210.128.90.14])
	by koto.vergenet.net (Postfix) with ESMTP id 168B7341A7
	for <kexec@lists.infradead.org>; Fri, 22 Feb 2008 18:02:41 +0900 (JST)
Date: Fri, 22 Feb 2008 18:02:40 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Fix compilation warning
Message-ID: <20080222090239.GA25249@verge.net.au>
References: <20080220080755.GB5542@suse.de>
	<20080221092153.GB15981@verge.net.au>
	<20080221092832.GA22609@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080221092832.GA22609@suse.de>
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

On Thu, Feb 21, 2008 at 10:28:33AM +0100, Bernhard Walle wrote:
> * Simon Horman <horms@verge.net.au> [2008-02-21 10:21]:
> > On Wed, Feb 20, 2008 at 09:07:55AM +0100, Bernhard Walle wrote:
> > > This patch fixes following compilation warning:
> > > 
> > > purgatory/purgatory.c:21: warning: passing argument 2 of 'sha256_update' makes pointer from integer without a cast
> > > 
> > 
> > Thanks Bernhard, I have queued that up.
> > Although I notice that on arm the warning turns into
> > 
> > purgatory/purgatory.c: In function 'verify_sha256_digest':
> > purgatory/purgatory.c:21: warning: cast to pointer from integer of different size
> 
> Isn't this the case on every 32 bit system?

Yes, now you mention it, I expect so. I guess its not a problem.

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
