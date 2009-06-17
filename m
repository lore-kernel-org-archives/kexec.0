Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MGuof-0006sj-CY
	for kexec@lists.infradead.org; Wed, 17 Jun 2009 13:04:43 +0000
Date: Wed, 17 Jun 2009 09:04:13 -0400
From: Neil Horman <nhorman@redhat.com>
Subject: Re: [PATCH] Do not inline putprops function
Message-ID: <20090617130413.GB2774@localhost.localdomain>
References: <20090617113456.GC31595@in.ibm.com>
	<20090617114551.GA5672@verge.net.au>
	<20090617115917.GD31595@in.ibm.com>
	<1245241595.4269.15.camel@concordia>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1245241595.4269.15.camel@concordia>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
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
To: Michael Ellerman <michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, mohan@in.ibm.com, kexec@lists.infradead.org, miltonm@bga.com, Simon Horman <horms@verge.net.au>

On Wed, Jun 17, 2009 at 10:26:35PM +1000, Michael Ellerman wrote:
> On Wed, 2009-06-17 at 17:29 +0530, M. Mohan Kumar wrote:
> > Do not inline putprops function
> > 
> > With the recent kexec-tools git tree, both kexec and kdump kernels hang (i.e
> > kexec -l and kexec -p respectively). This happened after the patch "ppc64:
> > cleanups" commit b43a84a31a4be6ed025c1bdef3bb1c3c12e01b16. I tried
> > reverting each hunk and then found out that retaining following lines in
> > fs2dt.c makes kexec/kdump work.
> > 
> > -static unsigned *dt_len; /* changed len of modified cmdline
> > -                           in flat device-tree */
> > 
> > [....]
> > 
> > -               dt_len = dt;
> > 
> > I don't have any clue why removing a unused variable would cause the kexec
> > kernel to hang. After further investigation, I observed that if the putprops
> > function is not inlined, kexec/kdump kernel would work even after removing
> > the above lines.
> > 
> > This patch directs gcc to not inline the putprops function. Now we could
> > invoke kexec and kdump kernels.
> 
> What compiler version are you using? Does the behaviour change if you
> use a newer/older compiler? It sounds to me like there's some deeper bug
> and your patch is just papering over it.
> 
Agreed, this doesn't make any sense. Try changing the compiler version to see if
the problem goes away or stops.  It might also be worthwhile to dump the
contents of the device tree at the start and end of the kexec process.  If the
changing of how a function is inlined is causing a hang, its likely changing how
the putprops function is writing information to the device tree.  Understanding
what that change is will likely provide clues to how the code has changed.

Neil

> cheers



> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
