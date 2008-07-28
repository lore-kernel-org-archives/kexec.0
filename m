Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mtagate3.de.ibm.com ([195.212.29.152])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KNMBN-0007Xe-7M
	for kexec@lists.infradead.org; Mon, 28 Jul 2008 06:26:09 +0000
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id m6S6PMFI176312
	for <kexec@lists.infradead.org>; Mon, 28 Jul 2008 06:25:22 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.0) with
	ESMTP id m6S6PLXI3580076
	for <kexec@lists.infradead.org>; Mon, 28 Jul 2008 08:25:21 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m6S6PKWK015311
	for <kexec@lists.infradead.org>; Mon, 28 Jul 2008 08:25:21 +0200
Date: Mon, 28 Jul 2008 09:24:46 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
Subject: Re: [patch] crashdump: fix undefined reference to `elfcorehdr_addr'
Message-ID: <20080728062446.GC12655@il.ibm.com>
References: <20080728015117.GA12055@verge.net.au>
	<m1tzeamust.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m1tzeamust.fsf@frodo.ebiederm.org>
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
Cc: Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, Chandru <chandru@in.ibm.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Terry Loftin <terry.loftin@hp.com>, Simon Horman <horms@verge.net.au>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Vivek Goyal <vgoyal@redhat.com>

On Sun, Jul 27, 2008 at 10:39:30PM -0700, Eric W. Biederman wrote:
> Simon Horman <horms@verge.net.au> writes:
> 
> > There has long been a strong aversion to providing the second
> > kernel with flags like im_in_kexec or im_in_kdump, as its felt
> > that this kind of problem is better handled by making sure that
> > the hardware is in a sensible state before leaving the
> > first-kernel.  But this is arguably more reasonable in the kexec
> > case than the kdump case.
> 
> That and because we can generally solve the specific problem with a
> general feature.  Something we can enable/disable on the command
> line if needed.  Right now this is especially interesting as on
> several architectures distros are not building special kdump kernels
> but have a single kernel binary that works in both cases.
> 
> Skimming through your patches this is a case we really do need to
> implement and handle cleanly.
> 
> Currently we leave DMA running in the kexec on panic case.  We avoid
> problems by only running out of a reserved area of memory.
> 
> As as general strategy that is fine.  However we have not
> implemented that strategy in the case of IOMMUs.  And we are having
> trouble with IOMMUs.
> 
> My hunch is that we should implement options to reserve a section of
> the iommu and to tell to the iommu to use the previously reserved
> section. Although turning iommus off altogether and simply using
> swiotlb may be acceptable.  In which case we should just force usage
> of the swiotlb on the command line in /sbin/kexec.

With an isolation-capable IOMMU (such as Calgary, VT-d and AMD's
IOMMU) on the I/O path, as long as we want to keep DMAs running and
going through to memory, we need to keep the IOMMU running, with the
same set of permissions and translation tables. If we don't mind DMAs
failing, we need to gracefully handle IOMMU DMA faults (where
possible---Calgary can't do it at the moment). What we do instead with
Calgary (c.f., the patch that instigated this discussion) is a hack,
we "reinitialize" the IOMMU with the old IOMMU's translation tables so
that DMAs continue working. 

My preference would be to have stopped all DMAs in the old kernel,
which would've made this nastiness go away. Can you explain in simple
words why we can't or won't do that?

Cheers,
Muli

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
