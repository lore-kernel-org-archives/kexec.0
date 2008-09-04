Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KbOe2-00071T-If
	for kexec@lists.infradead.org; Thu, 04 Sep 2008 23:53:46 +0000
Date: Fri, 5 Sep 2008 09:53:45 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] sh: Add vmlinux crash dump support
Message-ID: <20080904235343.GD12715@verge.net.au>
References: <20080903113811.31135.32678.sendpatchset@rx1.opensource.se>
	<20080904020310.GA25701@verge.net.au>
	<20080904093039.GB16025@linux-sh.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080904093039.GB16025@linux-sh.org>
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
To: Paul Mundt <lethal@linux-sh.org>
Cc: kexec@lists.infradead.org, Magnus Damm <magnus.damm@gmail.com>

On Thu, Sep 04, 2008 at 06:30:40PM +0900, Paul Mundt wrote:
> On Thu, Sep 04, 2008 at 12:03:14PM +1000, Simon Horman wrote:
> > On Wed, Sep 03, 2008 at 08:38:11PM +0900, Magnus Damm wrote:
> > > From: Magnus Damm <damm@igel.co.jp>
> > > 
> > > This patch adds SuperH crash dump support. The vmlinux loader is modified
> > > with crash dump hooks as on other architectures. SuperH does not need any
> > > backup region, so only the elf header is allocated from the top of the
> > > reserved memory window. The actual size of the memory window is passed
> > > to the secondary kernel on the command line using "mem=".
> > > 
> > > The secondary kernel must be configured to match the reserved memory
> > > window, change kernel parameters CONFIG_MEMORY_START and CONFIG_MEMORY_SIZE.
> > > 
> > > Linux-2.6.27 should be usable as primary kernel on SuperH, later kernel
> > > versions are needed to fully support secondary kernel /proc/vmcore.
> > 
> > Hi Magnus,
> > 
> > this looks ok to me. Has Paul or someone else reviewed it?
> > 
> I have now, looks good to me.

Thanks Magnus, Thanks Paul. Applied :-)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
