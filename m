Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate3.uk.ibm.com ([194.196.100.163])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QuP76-0007X8-2L
	for kexec@lists.infradead.org; Fri, 19 Aug 2011 13:27:56 +0000
Received: from d06nrmr1806.portsmouth.uk.ibm.com
	(d06nrmr1806.portsmouth.uk.ibm.com [9.149.39.193])
	by mtagate3.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p7JDRrMs004962
	for <kexec@lists.infradead.org>; Fri, 19 Aug 2011 13:27:53 GMT
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
	[9.149.37.250])
	by d06nrmr1806.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p7JDRrrC2650262
	for <kexec@lists.infradead.org>; Fri, 19 Aug 2011 14:27:53 +0100
Received: from d06av09.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av09.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p7JDRrGo028348
	for <kexec@lists.infradead.org>; Fri, 19 Aug 2011 07:27:53 -0600
Subject: Re: [patch v3 2/8] kdump: Make kimage_load_crash_segment() weak
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
In-Reply-To: <20110818171541.GC15413@redhat.com>
References: <20110812134849.748973593@linux.vnet.ibm.com>
	<20110812134907.166585439@linux.vnet.ibm.com>
	<20110818171541.GC15413@redhat.com>
Date: Fri, 19 Aug 2011 15:27:52 +0200
Message-ID: <1313760472.3858.26.camel@br98xy6r>
Mime-Version: 1.0
Reply-To: holzheu@linux.vnet.ibm.com
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, horms@verge.net.au, ebiederm@xmission.com, schwidefsky@de.ibm.com, kexec@lists.infradead.org

Hello Vivek,

On Thu, 2011-08-18 at 13:15 -0400, Vivek Goyal wrote:
> On Fri, Aug 12, 2011 at 03:48:51PM +0200, Michael Holzheu wrote:
> > From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> > 
> > On s390 we do not create page tables at all for the crashkernel memory.
> > This requires a s390 specific version for kimage_load_crash_segment().
> > Therefore this patch declares this function as "__weak". The s390 version is
> > very simple. It just copies the kexec segment to real memory without using
> > page tables:
> > 
> > int kimage_load_crash_segment(struct kimage *image,
> >                               struct kexec_segment *segment)
> > {
> >         return copy_from_user_real((void *) segment->mem, segment->buf,
> >                                    segment->bufsz);
> > }
> > 
> > There are two main advantages of not creating page tables for the
> > crashkernel memory:
> > 
> > a) It saves memory. We have scenarios in mind, where crashkernel
> >    memory can be very large and saving page table space is important.
> > b) We protect the crashkernel memory from being overwritten.
> 
> Michael,
> 
> Thinking more about it. Can't we provide a arch specific version of
> kmap() and kunmap() so that we create temporary mappings to copy
> the pages and then these are torn off.

Isn't kmap/kunmap() used for higmem? These functions are called from
many different functions in the Linux kernel, not only for kdump. I
would assume that creating and removing mappings with these functions is
not what a caller would expect and probably would break the Linux kernel
at many other places, no?

Perhaps we can finish this discussion after my vacation. I will change
my patch series that we even do not need this patch...

So only two common code patches are remaining. I will send the common
code patches again and will ask Andrew Morton to integrate them in the
next merge window. The s390 patches will be integrated by Martin.

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
