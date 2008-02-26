Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JTw92-0007zj-Jn
	for kexec@lists.infradead.org; Tue, 26 Feb 2008 09:30:41 +0000
From: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] fix valid_memory_range region merging 
In-reply-to: <20080226022933.GA12270@verge.net.au> 
References: <1165.1177570234@neuling.org> <20080226022933.GA12270@verge.net.au>
Date: Tue, 26 Feb 2008 10:29:28 +0100
Message-ID: <23516.1204018168@neuling.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

In message <20080226022933.GA12270@verge.net.au> you wrote:
> On Thu, Apr 26, 2007 at 04:50:34PM +1000, Michael Neuling wrote:
> > Check the next region we are including is type RANGE_RAM as well.
> > 
> > Signed-off-by: Michael Neuling <mikey@neuling.org>
> > ---
> > I've not actually seen this cause a problem, but it looks wrong.  We
> > should probably merge regions properly and solve this problem for real. 
> 
> Hi Michael,
> 
> appologies for this blast-from-the-past. This mail somehow
> ended up filed in the wrong place and I chanced upon it just now.
> 
> This fix does seem correct to me, though I haven't seen it cause
> any problems either. I'm happy to merge it (better late than never,
> right?) if you are still happy with it.

Sweet thanks, I'd well and truly forgotten about it.  I think it was
just a random code cleanup, so if it still applies it should be fine to
merge.

Mikey

> 
> > 
> >  kexec/kexec.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > Index: kexec-tools-testing/kexec/kexec.c
> > ===================================================================
> > --- kexec-tools-testing.orig/kexec/kexec.c
> > +++ kexec-tools-testing/kexec/kexec.c
> > @@ -96,7 +96,8 @@ int valid_memory_range(struct kexec_info
> >  		mstart = info->memory_range[i].start;
> >  		mend = info->memory_range[i].end;
> >  		if (i < info->memory_ranges - 1
> > -		    && mend == info->memory_range[i+1].start)
> > +		    && mend == info->memory_range[i+1].start
> > +		    && info->memory_range[i+1].type == RANGE_RAM)
> >  			mend = info->memory_range[i+1].end;
> >  
> >  		/* Check to see if we are fully contained */
> 
> -- 
> Horms
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
