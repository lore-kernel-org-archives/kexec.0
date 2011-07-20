Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QjcOW-0000Xx-OH
	for kexec@lists.infradead.org; Wed, 20 Jul 2011 19:25:21 +0000
Date: Wed, 20 Jul 2011 15:25:09 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [patch 0/9] kdump: Patch series for s390 support
Message-ID: <20110720192509.GD10079@redhat.com>
References: <20110714180528.GF6672@redhat.com>
	<1310739717.10789.31.camel@br98xy6r>
	<20110715143820.GG3428@redhat.com>
	<1310744603.10789.79.camel@br98xy6r>
	<20110718123140.GB31986@redhat.com>
	<1310997641.4427.10.camel@br98xy6r>
	<20110718141943.GE31986@redhat.com>
	<1311000253.4427.23.camel@br98xy6r>
	<20110718152532.GF31986@redhat.com>
	<1311012188.4427.58.camel@br98xy6r>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1311012188.4427.58.camel@br98xy6r>
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
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, horms@verge.net.au, ebiederm@xmission.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, kexec@lists.infradead.org

On Mon, Jul 18, 2011 at 08:03:08PM +0200, Michael Holzheu wrote:
> Hello Vivek,
> 
> On Mon, 2011-07-18 at 11:25 -0400, Vivek Goyal wrote:
> > On Mon, Jul 18, 2011 at 04:44:13PM +0200, Michael Holzheu wrote:
> > > On Mon, 2011-07-18 at 10:19 -0400, Vivek Goyal wrote:
> > > > - Make sure these headers are not overwritten by newly booted kernel.
> > > 
> > > And that was my question: What is the best way to do that. E.g. we could
> > > pass a 2nd kernel parameter "elfcorehdr_size", implement s390 boot
> > > parameter or implement the memmap kernel parameter.
> > 
> > You could do that but I think a more generic parameter will make more
> > sense.
> > 
> > - Either something along the lines of memmap=
> > - Or excludemem=x@y
> > - Or modify memory map in s390 specific bootloading protocol block etc.
> 
> Ok, understood. Thanks for the information.
> 
> We still have discussions here, if we could somehow implement our
> original idea of triggering kdump by the stand-alone dump tools. Sorry
> for being so stubborn :-(
> 
> So here comes the modified suggestion:
> 
> As requested by you we can pre-allocate the ELF header and use purgatory
> as done on other architectures.
> 
> To allow the stand-alone dump tools as kdump triggers, we then only
> would have to provide an s390 specific way to tell the stand-alone dump
> tools:
> 1. Entry point address into purgatory
> 2. Address, size and checksum for purgatory
> 
> We could store address, size and checksum of the purgatory to a fixed
> offset in the kdump kernel image. This can be done in the kexec tools
> code. Then the dump tools only would need the crashkernel memory offset
> to find all information. Then dump tools will verify purgatory and
> afterwards jump to the purgatory code. Then purgatory verifies all kexec
> segments. For s390, if this check fails, we return to caller
> (stand-alone tools). If the check is ok, then purgatory code on s390
> saves all registers to the preallocated ELF notes and starts kdump.
> 
> I think, this is all s390 specific and IMHO will not affect other
> architectures at all.
> 
> What you as kdump framework maintainer would have to accept with this
> solution is that it is allowed now to start kdump directly via purgatory
> without using code from the old kernel (e.g. crash_kexec). This has as
> implication that all things that the old kernel has to initialize for
> kdump has to be done before the system crashes. Currently this is only
> the initialization of vmcoreinfo.

Hi Michael,

Instead of introdcuing a new entry point for second kernel, why not
jump to crash_kexec() from stand alone tools? That should be functionally
equivalent to what you described above without any need to pass the 
purgatory details to stand alone tools.

Only thing which needs to be figured out is how to pass the address of
crash_kexec() to stand alone tools and set registers/parameters 
appropriately.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
