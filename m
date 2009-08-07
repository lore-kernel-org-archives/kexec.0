Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp02.in.ibm.com ([59.145.155.2])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1MZQY8-0007Bb-1o
	for kexec@lists.infradead.org; Fri, 07 Aug 2009 14:36:09 +0000
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp02.in.ibm.com (8.14.3/8.13.1) with ESMTP id n77EZucG013547
	for <kexec@lists.infradead.org>; Fri, 7 Aug 2009 20:05:56 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n77EZuph2023614
	for <kexec@lists.infradead.org>; Fri, 7 Aug 2009 20:05:56 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n77EZtT1021212
	for <kexec@lists.infradead.org>; Fri, 7 Aug 2009 20:05:55 +0530
Date: Fri, 7 Aug 2009 20:05:49 +0530
From: "M. Mohan Kumar" <mohan@in.ibm.com>
Subject: Re: [PATCH] Do not inline putprops function
Message-ID: <20090807143549.GA3110@in.ibm.com>
References: <20090617133435.GB4059@in.ibm.com>
	<20090617140514.GB31383@hmsreliant.think-freely.org>
	<20090617142652.GC4059@in.ibm.com>
	<20090617144007.GC31383@hmsreliant.think-freely.org>
	<20090623125534.GA8664@in.ibm.com>
	<20090623135604.GC1157@hmsreliant.think-freely.org>
	<1245803263.9237.3.camel@concordia>
	<20090803054919.GA19594@in.ibm.com>
	<20090805164938.GA2970@in.ibm.com>
	<1249568660.20200.23.camel@concordia>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1249568660.20200.23.camel@concordia>
Reply-To: mohan@in.ibm.com
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
Cc: linuxppc-dev@ozlabs.org, Neil Horman <nhorman@redhat.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, miltonm@bga.com

Hi,

After enabling EARLY_DEBUG (and DEBUG in some of the files in
arch/powerpc/kernel directory), without forcing the dtstruct variable to 8
byte alignment: 

# ./kexec -e
Starting new kernel
console [udbg0] enabled
 -> early_setup(), dt_ptr: 0x7723000
 -> early_init_devtree(c000000007723000)
Invalid tag 5 scanning flattened device tree !
search "chosen", depth: 0, uname:
Invalid tag 5 scanning flattened device tree !
dt_root_size_cells = 2
dt_root_addr_cells = 2
Invalid tag 5 scanning flattened device tree !
reserving: 128c000 -> 5ec1f7
reserving: 7734000 -> 8cc000
reserving: 7723000 -> f698
Phys. mem: 0
-> move_device_tree
<- move_device_tree
Scanning CPUs ...
Invalid tag 5 scanning flattened device tree !
 <- early_init_devtree()
Probing machine type ...
  pSeries ...
No suitable machine found !


So device-tree is getting corrupted when dtstruct variable is not aligned to
8 byte variable. This problem is not seen with gcc-3.4. Is it compiler
issue? or bug in the code.

Regards,
M. Mohan Kumar.

On Fri, Aug 07, 2009 at 12:24:20AM +1000, Michael Ellerman wrote:
> On Wed, 2009-08-05 at 22:19 +0530, M. Mohan Kumar wrote:
> > Hi,
> > 
> > When I align the dtstruct variable to 8 bytes, I am able to invoke kdump.
> > 
> > When the line
> > 	static unsigned dtstruct[TREEWORDS], *dt;
> > changed to 
> > 	static unsigned dtstruct[TREEWORDS] __attribute__ ((aligned (8))), *dt;
> > 
> > kexec-tool works.
> 
> Hmm, odd.
> 
> Can you check how it's aligned without your change? ie. in the original
> binary, is it 4 byte aligned?
> 
> When you make the change, is the only thing that changes in the binary
> the alignedness of dtstruct, or does it cause other things to move
> around?
> 
> I don't think an unaligned dt blob should have any effect on the kernel,
> ie. it should copy it in fine, but I'd have to look at the code.
> 
> cheers



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
