Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1L5GMj-0001xe-37
	for kexec@lists.infradead.org; Wed, 26 Nov 2008 09:07:21 +0000
Date: Wed, 26 Nov 2008 10:07:17 +0100
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] Fix kexec x86_64 load failed bug
Message-ID: <20081126100717.1759311b@hale.suse.de>
In-Reply-To: <20081126074829.GD30657@verge.net.au>
References: <20081125134738.7075a13a@hale.suse.de>
	<1227662409.2442.11.camel@yhuang-dev.sh.intel.com>
	<492CC1AA.3010408@oracle.com>
	<1227673551.2442.12.camel@yhuang-dev.sh.intel.com>
	<20081126061652.GA24221@verge.net.au>
	<1227682058.2442.19.camel@yhuang-dev.sh.intel.com>
	<20081126074829.GD30657@verge.net.au>
Mime-Version: 1.0
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
To: Simon Horman <horms@verge.net.au>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Huang Ying <ying.huang@intel.com>

* Simon Horman [2008-11-26 16:48]:
>
> On Wed, Nov 26, 2008 at 02:47:38PM +0800, Huang Ying wrote:
> > On Wed, 2008-11-26 at 14:16 +0800, Simon Horman wrote:
> > > On Wed, Nov 26, 2008 at 12:25:51PM +0800, Huang Ying wrote:
> > > > On Wed, 2008-11-26 at 11:25 +0800, Randy Dunlap wrote:
> > > > > This isn't kernel code?  Where is /purgatory/ ?
> > > > > 
> > > > > Anyway, for kernel code, that should be:
> > > > > char *cmdline_end = NULL;
> > > > 
> > > > This patch is against kexec tools, not kernel.
> > > > 
> > > > Best Regards,
> > > > Huang Ying
> > > 
> > > Hi Huang,
> > > 
> > > I think that I would prefer "char *cmdline_end = NULL;" for kexec-tools
> > > code too.
> > 
> > Patch v2 follows with NULL instead of 0.
> 
> Thanks, applied.

Verified. Huang, thanks for the quick fix!


    Bernhard
-- 
Bernhard Walle, SUSE Linux Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
