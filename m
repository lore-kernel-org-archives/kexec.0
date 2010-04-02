Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from charlotte.tuxdriver.com ([70.61.120.58] helo=smtp.tuxdriver.com)
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1NxUJC-0001Bc-Jm
	for kexec@lists.infradead.org; Fri, 02 Apr 2010 00:00:23 +0000
Date: Thu, 1 Apr 2010 20:00:12 -0400
From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH] amd iommu: force flush of iommu prior during shutdown
Message-ID: <20100402000012.GA8930@hmsreliant.think-freely.org>
References: <20100331182824.GC13406@hmsreliant.think-freely.org>
	<m1wrwsuxn9.fsf@fess.ebiederm.org>
	<20100331191811.GD13406@hmsreliant.think-freely.org>
	<m1sk7guv5u.fsf@fess.ebiederm.org>
	<20100331202745.GE13406@hmsreliant.think-freely.org>
	<20100401142902.GF24846@8bytes.org>
	<20100401144736.GA14069@shamino.rdu.redhat.com>
	<20100401155643.GG24846@8bytes.org>
	<20100401171149.GH13603@shamino.rdu.redhat.com>
	<20100401201433.GK24846@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100401201433.GK24846@8bytes.org>
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
To: Joerg Roedel <joro@8bytes.org>
Cc: Neil Horman <nhorman@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, iommu@lists.linux-foundation.org, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

On Thu, Apr 01, 2010 at 10:14:34PM +0200, Joerg Roedel wrote:
> On Thu, Apr 01, 2010 at 01:11:49PM -0400, Neil Horman wrote:
> > On Thu, Apr 01, 2010 at 05:56:43PM +0200, Joerg Roedel wrote:
> 
> > > The possible fix will be to enable the hardware earlier in the
> > > initialization path.
> > > 
> > That sounds like a reasonable theory, I'll try hack something together
> > shortly.
> 
> Great. So the problem might be already fixed when I am back in the
> office ;-)
> 
Don't hold your breath, but I'll try my best :)

> > > This would only prevent possible data corruption. When the IOMMU is off
> > > the devices will not get a target abort but will only write to different
> > > physical memory locations. The window where a target abort can happen
> > > starts when the kdump kernel re-enables the IOMMU and ends when the new
> > > driver for that device attaches. This is a small window but there is not
> > > a lot we can do to avoid this small time window.
> > > 
> > Can you explain this a bit further please?  From what I read, when the iommu is
> > disabled, AIUI it does no translations.  That means that any dma addresses which
> > the driver mapped via the iommu prior to a crash that are stored in devices will
> > just get strobed on the bus without any translation.  If those dma address do
> > not lay on top of any physical ram, won't that lead to bus errors, and
> > transaction aborts?  Worse, if those dma addresses do lie on top of real
> > physical addresses, won't we get corruption in various places?  Or am I missing
> > part of how that works?
> 
> Hm, the device address may not be a valid host physical address, thats
> true. But the problem with the small time-window when the IOMMU hardware
> is re-programmed from the kdump kernel still exists.
> I need to think about other possible side-effects of leaving the IOMMU
> enabled on shutdown^Wboot into a kdump kernel.
> 
I think its an interesting angle to consider.  Thats why I was talking about
cloning the old tables in the new kdump kernel and using the error log to filter
out entries that we could safely assume were complete until enough of the iommu
page tables were free, so that we could continue to hobble along in the kdump
kernel until we got to a proper reboot.  All just thought experiment of course.
I'll try tinkering with your idea above first.
Neil

> 	Joerg
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
