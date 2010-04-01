Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from charlotte.tuxdriver.com ([70.61.120.58] helo=smtp.tuxdriver.com)
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1Nx8yQ-0006q5-Ke
	for kexec@lists.infradead.org; Thu, 01 Apr 2010 01:13:31 +0000
Date: Wed, 31 Mar 2010 21:13:11 -0400
From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH] amd iommu: force flush of iommu prior during shutdown
Message-ID: <20100401011311.GC2069@localhost.localdomain>
References: <20100331152417.GB13406@hmsreliant.think-freely.org>
	<20100331212535.GR29241@sequoia.sous-sol.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100331212535.GR29241@sequoia.sous-sol.org>
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
To: Chris Wright <chrisw@sous-sol.org>
Cc: joerg.roedel@amd.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, iommu@lists.linux-foundation.org, vgoyal@redhat.com

On Wed, Mar 31, 2010 at 02:25:35PM -0700, Chris Wright wrote:
> * Neil Horman (nhorman@tuxdriver.com) wrote:
> > Flush iommu during shutdown
> > 
> > When using an iommu, its possible, if a kdump kernel boot follows a primary
> > kernel crash, that dma operations might still be in flight from the previous
> > kernel during the kdump kernel boot.  This can lead to memory corruption,
> > crashes, and other erroneous behavior, specifically I've seen it manifest during
> > a kdump boot as endless iommu error log entries of the form:
> > AMD-Vi: Event logged [IO_PAGE_FAULT device=00:14.1 domain=0x000d
> > address=0x000000000245a0c0 flags=0x0070]
> 
> We've already fixed this problem once before, so some code shift must
> have brought it back.  Personally, I prefer to do this on the bringup
> path than the teardown path.  Besides keeping the teardown path as
> simple as possible (goal is to get to kdump kernel asap), there's also
> reason to competely flush on startup in genernal in case BIOS has done
> anything unsavory.
> 
Chris,
	Can you elaborate on what you did with the iommu to make this safe?  It
will save me time digging through the history on this code, and help me
understand better whats going on here.

I was starting to think that we should just leave the iommu on through a kdump,
and re-construct a new page table based on the old table (filtered by the error
log) on kdump boot, but it sounds like a better solution might be in place.

Thanks
Neil

> thanks,
> -chris
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
