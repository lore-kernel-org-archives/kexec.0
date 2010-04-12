Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1O1CfE-0005cc-O7
	for kexec@lists.infradead.org; Mon, 12 Apr 2010 05:58:30 +0000
Date: Mon, 12 Apr 2010 15:58:25 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: fix 64Gb limit on x86 w/ PAE
Message-ID: <20100412055825.GA10066@verge.net.au>
References: <20100408164644.GB16868@hmsreliant.think-freely.org>
	<20100408223245.GA4795@verge.net.au>
	<20100409012439.GA2060@localhost.localdomain>
	<20100409014144.GA25947@verge.net.au>
	<20100409121749.GB16609@hmsreliant.think-freely.org>
	<20100409134111.GA27573@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100409134111.GA27573@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: anderson@redhat.com, kexec@lists.infradead.org, Neil Horman <nhorman@tuxdriver.com>

On Fri, Apr 09, 2010 at 09:41:11AM -0400, Vivek Goyal wrote:
> On Fri, Apr 09, 2010 at 08:17:49AM -0400, Neil Horman wrote:
> > Version 2, with Simons consistency fixes and cleanups
> > 
> > Fix up x86 kexec to exclude memory on i686 kernels beyond 64GB limit
> > 
> > We found a problem recently on x86 systems.  If a 32 bit PAE enabled system
> > contains more then 64GB of physical ram, the kernel will truncate the max_pfn
> > value to 64GB.  Unfortunately it still leaves all the physical memory regions
> > present in /proc/iomem.  Since kexec builds its elf headers based on
> > /proc/iomem the elf headers indicate the size of memory is larger than what the
> > kernel is willing to address.  The result is that, during a copy of
> > /proc/vmcore, a read will return -EFAULT when the requested offset is beyond the
> > 64GB range, leaving the seemingly truncated vmcore useless, as the elf headers
> > indicate memory beyond what the file contains.
> > 
> > The fix for it is pretty straightforward, just ensure that, when on x86 systems,
> > we don't record any entries in the memory_range array that cross  the 64Gb mark.
> > This keeps us in line with the kernel and lets the copy finish sucessfully,
> > providing a workable core
> > 
> > Tested successfully by myself
> > Originally-authored-by: Dave Anderson <anderson@redhat.com>
> > Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> > 
> > 
> >  crashdump-x86.c |   15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> > index 9d37442..9d35b3e 100644
> > --- a/kexec/arch/i386/crashdump-x86.c
> > +++ b/kexec/arch/i386/crashdump-x86.c
> > @@ -34,6 +34,12 @@
> >  #include "crashdump-x86.h"
> >  #include <x86/x86-linux.h>
> >  
> > +/*
> > + * This defines the the last address that we can support access to
> > + * with a PAE enabled kernel
> > + */
> > +#define 64G_LIMIT 0xfffffffff
> > +
> >  extern struct arch_options_t arch_options;
> >  
> >  /* Forward Declaration. */
> > @@ -114,6 +120,15 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
> >  		if (end <= 0x0009ffff)
> >  			continue;
> >  
> > +		/*
> > +		 *  Exclude any segments starting at or beyond 64GB, and
> > +		 *  restrict any segments from ending at or beyond 64GB.
> > +		 */
> > +		if (start > 64GB_LIMIT)
> > +			continue;
> > +		if (end > 64GB_LIMIT)
> > +			end = 64GB_LIMIT;
> > +
> 
> Looks good to me.
> 
> Acked-by: Vivek Goyal <vgoyal@redhat.com>

Thanks Neil. Thanks Vivek. Thanks Dave. Applied :-)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
