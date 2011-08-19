Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QuPRQ-0007v7-Gu
	for kexec@lists.infradead.org; Fri, 19 Aug 2011 13:48:57 +0000
Date: Fri, 19 Aug 2011 09:48:36 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [patch v3 2/8] kdump: Make kimage_load_crash_segment() weak
Message-ID: <20110819134836.GB18656@redhat.com>
References: <20110812134849.748973593@linux.vnet.ibm.com>
	<20110812134907.166585439@linux.vnet.ibm.com>
	<20110818171541.GC15413@redhat.com>
	<1313760472.3858.26.camel@br98xy6r>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1313760472.3858.26.camel@br98xy6r>
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
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, hbabu@us.ibm.com, horms@verge.net.au, ebiederm@xmission.com, schwidefsky@de.ibm.com, kexec@lists.infradead.org

On Fri, Aug 19, 2011 at 03:27:52PM +0200, Michael Holzheu wrote:
> Hello Vivek,
> 
> On Thu, 2011-08-18 at 13:15 -0400, Vivek Goyal wrote:
> > On Fri, Aug 12, 2011 at 03:48:51PM +0200, Michael Holzheu wrote:
> > > From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> > > 
> > > On s390 we do not create page tables at all for the crashkernel memory.
> > > This requires a s390 specific version for kimage_load_crash_segment().
> > > Therefore this patch declares this function as "__weak". The s390 version is
> > > very simple. It just copies the kexec segment to real memory without using
> > > page tables:
> > > 
> > > int kimage_load_crash_segment(struct kimage *image,
> > >                               struct kexec_segment *segment)
> > > {
> > >         return copy_from_user_real((void *) segment->mem, segment->buf,
> > >                                    segment->bufsz);
> > > }
> > > 
> > > There are two main advantages of not creating page tables for the
> > > crashkernel memory:
> > > 
> > > a) It saves memory. We have scenarios in mind, where crashkernel
> > >    memory can be very large and saving page table space is important.
> > > b) We protect the crashkernel memory from being overwritten.
> > 
> > Michael,
> > 
> > Thinking more about it. Can't we provide a arch specific version of
> > kmap() and kunmap() so that we create temporary mappings to copy
> > the pages and then these are torn off.
> 
> Isn't kmap/kunmap() used for higmem? These functions are called from
> many different functions in the Linux kernel, not only for kdump. I
> would assume that creating and removing mappings with these functions is
> not what a caller would expect and probably would break the Linux kernel
> at many other places, no?

[CCing linux-mm]

Yes it is being used for highmem pages. If arch has not defined kmap()
then generic definition is just returning page_address(page), expecting
that page will be mapped.

I was wondering that what will be broken if arch decides to extend this
to create temporary mappings for pages which are not HIGHMEM but do
not have any mapping. (Like this special case of s390).

I guess memory management guys can give a better answer here. As a layman,
kmap() seems to be the way to get a kernel mapping for any page frame
and if one is not already there, then arch might create one on the fly,
like we do for HIGHMEM pages. So the question is can be extend this
to also cover pages which are not highmem but do not have any mappings
on s390.

> 
> Perhaps we can finish this discussion after my vacation. I will change
> my patch series that we even do not need this patch...

So how are you planning to get rid of this patch without modifying kmap(),
kunmap() implementation for s390?

> 
> So only two common code patches are remaining. I will send the common
> code patches again and will ask Andrew Morton to integrate them in the
> next merge window.The s390 patches will be integrated by Martin.

I am fine with merge of other 2 common patches. Once you repost the
series, I will ack those.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
