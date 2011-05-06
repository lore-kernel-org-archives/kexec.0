Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1QIBjO-0004Dy-8n
	for kexec@lists.infradead.org; Fri, 06 May 2011 03:29:30 +0000
Date: Fri, 6 May 2011 12:29:23 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] detect Xen dom0 properly to avoid conflict with
	pv_on_hvm domU
Message-ID: <20110506032923.GA4079@verge.net.au>
References: <20110504163232.GA24669@aepfle.de>
	<20110505122003.GM22010@verge.net.au>
	<20110505123446.GA4214@aepfle.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110505123446.GA4214@aepfle.de>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Olaf Hering <olaf@aepfle.de>
Cc: kexec@lists.infradead.org

On Thu, May 05, 2011 at 02:34:46PM +0200, Olaf Hering wrote:
> On Thu, May 05, Simon Horman wrote:
> 
> > On Wed, May 04, 2011 at 06:32:32PM +0200, Olaf Hering wrote:
> 
> > > +static int is_dom0;
> > 
> > I think you need to explicitly initialise is_dom0 to 0.
> 
> Globals are always initialized to zero, its a C language thing.

Point taken :^)

> > Alternatively, is it really such a burden to call access()
> > each time xen_present() is called?  (I'm ambivalent with regards to this).
> 
> Probably not, its called a dozen times in my testing.

As we already have the code it seems that we may as well use it.

I've merged your patch as-is.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
