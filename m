Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g5t0006.atlanta.hp.com ([15.192.0.43])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KbOFl-0004QB-HW
	for kexec@lists.infradead.org; Thu, 04 Sep 2008 23:28:42 +0000
Subject: Re: Trying to test my gart/iommu vmcore problem on RH
From: Bob Montgomery <bob.montgomery@hp.com>
In-Reply-To: <m1vdxpky0c.fsf@frodo.ebiederm.org>
References: <1218138156.3361.386.camel@amd.troyhebe>
	<20080808014024.GB3911@redhat.com>	<1218750773.3361.425.camel@amd.troyhebe>
	<20080815131359.GA10208@redhat.com>
	<1219081942.3361.436.camel@amd.troyhebe>
	<20080819134748.GC18972@redhat.com>	<m1wsib3raq.fsf@frodo.ebiederm.org>
	<1219442751.3361.459.camel@amd.troyhebe>
	<m18wuofw79.fsf@frodo.ebiederm.org> <20080825131603.GB18914@redhat.com>
	<m1vdxpky0c.fsf@frodo.ebiederm.org>
Date: Thu, 04 Sep 2008 17:28:48 -0600
Message-Id: <1220570928.2215.48.camel@amd.troyhebe>
Mime-Version: 1.0
Reply-To: bob.montgomery@hp.com
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Heber, Troy" <troy.heber@hp.com>, "Loftin, Terry" <terry.loftin@hp.com>, Kexec Mailing List <kexec@lists.infradead.org>, Vivek Goyal <vgoyal@redhat.com>

On Mon, 2008-08-25 at 13:46 +0000, Eric W. Biederman wrote:
> Vivek Goyal <vgoyal@redhat.com> writes:
> 
> > On Fri, Aug 22, 2008 at 04:48:10PM -0700, Eric W. Biederman wrote:
> >>
> >> Hmm.  Thinking about this we actually have 2 problems.
> >> - Communication about what is going on.
> >> - How to handle an iommu in the event of a crash dump scenario.
> >>
> >> The current solution is to ignore the iommu, and use swiotlb.  This
> >> solution does not look like it will work for future iommus.
Howdy all,

There are several aspects to this problem that make solutions come in
and out of contention:

1.  Kexec vs Kdump

	Kexec: If we are kexec'ing normally, we assume that the shutdown has
successfully stopped DMAs prior to starting our new kernel, and if not,
it's a bug in the previous kernel's driver shutdown.  So no issue here,
right?

	Kdump: The driver shutdown has been skipped as we go down during a
crash, so assume that leftover DMA operations might be in progress as
the kdump kernel comes up.  BUT!  They will be in progress to some area
of memory other than the memory being used by the kdump kernel (it has
its own crashkernel sandbox).  And on my 2.6.18-based system, with an
AMD64 NB GART-acting-as-IOMMU, the kdump kernel *does not* try to
initialize or use an IOMMU when it comes up because its memory size is
too small to need one (no one is setting crashkernel=4G@4G).  So the
kdump kernel can successfully ignore the old IOs using the old GART
aperture IOMMU.

EXCEPT(!) for the fact the we've left CPU-side translations turned on in
the GART NB hardware and the kdump kernel will currently read through
that zone using /proc/vmcore or /dev/oldmem.  That's why I like fixing
my stone-age problem by turning off CPU-side access. 

Note that real (future?) IOMMUs don't even have the concept of
translating accesses from the CPU side.  They only work on IO requests.
So reading old memory areas from the crashed kernel shouldn't cause an
IOMMU to "do" anything.


2.  GART vs Calgary vs "new AMD IOMMU" vs "new Intel IOMMU"

	The GART-as-IOMMU thing is not a "real" IOMMU.  It doesn't offer much
of the interesting protection of a real IOMMU, just "valid", "coherent"
and a translation address.  An IO card is still free to screw up and hit
other addresses outside the aperture if it wants to, or hit other pages
in the aperture that really belong to some other driver, or to write to
a page that it should only read, etc.  Consequently, there isn't much
desire to utilize the GART thing unless I really need 32-bit IO card
access to 40-bit address space.  Since I don't need that in the kdump
kernel (currently), there's no reason to try to use the GART there, so
it's safe to ignore it, as long as I don't provoke it :-)

BUT, if I had a real IOMMU that provided cool protection stuff and
domain stuff, and not just address range expansion for old IO cards,
then I might want to (or be forced to) use it all the time, independent
of memory size, and then the kdump kernel might really need to deal with
sharing it in some way with old leftover DMAs from the crashed kernel
that we're dumping.  And this, I think, is the only real issue looming.

But this should only be a kdump issue, and not a kexec issue (see #1
above), because the previous kernel should have shut all that down
before it kexec'd, right?


3.  IOMMU vs swiotlb

Isn't swiotlb just a way of hiding bounce buffer copies and management
inside of the dma_map_single and dma_unmap_single calls?  If so, it's
just software(TM) and it just uses addresses in the kdump kernel
sandbox, which (by definition) are not addresses that could have been
used in the old kernel that crashed.  There shouldn't be any conflict
between kdump kernel and old crashed kernel if one or both are using
swiotlb.  Once again, in *my* current situation, there's no reason to
use swiotlb in the kdump kernel because my memory range is restricted to
my crashkernel sandbox and I don't need any IOMMU address translation
capability.  

If the original kernel had been using swiotlb, then there's really no
issue, because any leftover DMAs are just writing to the old bounce
buffers anyway, and there's no driver left waiting to call
dma_unmap_single to copy the result into the real buffer.

What considerations have I missed?

Bob Montgomery
(vacation last week)

   



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
