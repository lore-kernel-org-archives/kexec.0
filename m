Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JWisj-0007Iu-0E
	for kexec@lists.infradead.org; Wed, 05 Mar 2008 01:57:21 +0000
Date: Wed, 5 Mar 2008 10:57:16 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] reduce alignment constraint on ia64 elf core header
Message-ID: <20080305015714.GD3986@verge.net.au>
References: <20080303143026.GA15484@hmsreliant.think-freely.org>
	<20080303155644.GB30167@suse.de>
	<20080304042815.GA9469@verge.net.au>
	<20080304114944.GA20741@hmsreliant.think-freely.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080304114944.GA20741@hmsreliant.think-freely.org>
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
To: Neil Horman <nhorman@tuxdriver.com>
Cc: kexec@lists.infradead.org

On Tue, Mar 04, 2008 at 06:49:44AM -0500, Neil Horman wrote:
> On Tue, Mar 04, 2008 at 01:28:16PM +0900, Simon Horman wrote:
> > On Mon, Mar 03, 2008 at 04:56:44PM +0100, Bernhard Walle wrote:
> > > * Neil Horman <nhorman@tuxdriver.com> [2008-03-03 15:30]:
> > > > Hey all-
> > > > 	Patch to reduce the alignment constraints on ia64 elf core headers.
> > > > >From what I can see there is no need to align the elf core header structure to
> > > > the EFI_PAGE_SIZE (given that the EFI will never read this data, only the kernel
> > > > will when booting a kdump kernel).  And since this is going into our reserved
> > > > memory, it saves us 3K (4K vs 1K alignment).  Tested successfully by myself on
> > > > several ia64 boxes.
> > > 
> > > This is wrong. Please read this thead:
> > > 
> > > https://lists.linux-foundation.org/pipermail/fastboot/2007-February/012882.html
> > 
> > Hi Neil, Hi Bernhard,
> > 
> > I can confirm that with Neil's patch I end up with a zero
> > byte long /proc/vmcore
> > 
> > -- 
> > Horms
> 
> Rescinded.  My bad, I didn't think to check that.

Thanks to Bernhard for spotting this,
I likely would have merged it otherwise.

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
