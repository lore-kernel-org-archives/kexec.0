Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JTwYx-0006Nq-NY
	for kexec@lists.infradead.org; Tue, 26 Feb 2008 09:57:28 +0000
Date: Tue, 26 Feb 2008 18:57:20 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] fix valid_memory_range region merging
Message-ID: <20080226095719.GA15739@verge.net.au>
References: <1165.1177570234@neuling.org> <20080226022933.GA12270@verge.net.au>
	<23516.1204018168@neuling.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <23516.1204018168@neuling.org>
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
To: Michael Neuling <mikey@neuling.org>
Cc: kexec@lists.infradead.org

On Tue, Feb 26, 2008 at 10:29:28AM +0100, Michael Neuling wrote:
> In message <20080226022933.GA12270@verge.net.au> you wrote:
> > On Thu, Apr 26, 2007 at 04:50:34PM +1000, Michael Neuling wrote:
> > > Check the next region we are including is type RANGE_RAM as well.
> > > 
> > > Signed-off-by: Michael Neuling <mikey@neuling.org>
> > > ---
> > > I've not actually seen this cause a problem, but it looks wrong.  We
> > > should probably merge regions properly and solve this problem for real. 
> > 
> > Hi Michael,
> > 
> > appologies for this blast-from-the-past. This mail somehow
> > ended up filed in the wrong place and I chanced upon it just now.
> > 
> > This fix does seem correct to me, though I haven't seen it cause
> > any problems either. I'm happy to merge it (better late than never,
> > right?) if you are still happy with it.
> 
> Sweet thanks, I'd well and truly forgotten about it.  I think it was
> just a random code cleanup, so if it still applies it should be fine to
> merge.

Cool, it seems to apply just fine.
I've queued it up to be merged after the release.

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
