Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from 8bytes.org ([88.198.83.132])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NxMlD-0005Y1-2w
	for kexec@lists.infradead.org; Thu, 01 Apr 2010 15:56:47 +0000
Date: Thu, 1 Apr 2010 17:56:43 +0200
From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] amd iommu: force flush of iommu prior during shutdown
Message-ID: <20100401155643.GG24846@8bytes.org>
References: <20100331152417.GB13406@hmsreliant.think-freely.org>
	<20100331155430.GF14011@redhat.com>
	<20100331182824.GC13406@hmsreliant.think-freely.org>
	<m1wrwsuxn9.fsf@fess.ebiederm.org>
	<20100331191811.GD13406@hmsreliant.think-freely.org>
	<m1sk7guv5u.fsf@fess.ebiederm.org>
	<20100331202745.GE13406@hmsreliant.think-freely.org>
	<20100401142902.GF24846@8bytes.org>
	<20100401144736.GA14069@shamino.rdu.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100401144736.GA14069@shamino.rdu.redhat.com>
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
To: Neil Horman <nhorman@tuxdriver.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, iommu@lists.linux-foundation.org, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

On Thu, Apr 01, 2010 at 10:47:36AM -0400, Neil Horman wrote:
> On Thu, Apr 01, 2010 at 04:29:02PM +0200, Joerg Roedel wrote:
> > I am back in office next tuesday and will look into this problem too.
> > 
> Thank you.

Just took a look and I think the problem is that the devices are
attached to domains before the IOMMU hardware is enabled. This happens
in the function prealloc_protection_domains(). The attach code issues
the dte-invalidate commands but they are not executed because the
hardware is off. I will verify this when I have access to hardware
again.
The possible fix will be to enable the hardware earlier in the
initialization path.

> > Right. The default for all devices is to forbid DMA.
> > 
> Thanks, glad to know I read that right, took me a bit to understand it :)

I should probably add a comment :-)

> > Thats indeed true. I have seen that with ixgbe cards for example. They
> > seem to be really confused after an target abort.
> > 
> Yeah, this part worries me, target aborts lead to various brain dead hardware
> pieces.  What are you thoughts on leaving the iommu on through a reboot to avoid
> this issue (possibly resetting any pci device that encounters a target abort, as
> noted in the error log on the iommu?

This would only prevent possible data corruption. When the IOMMU is off
the devices will not get a target abort but will only write to different
physical memory locations. The window where a target abort can happen
starts when the kdump kernel re-enables the IOMMU and ends when the new
driver for that device attaches. This is a small window but there is not
a lot we can do to avoid this small time window.

	Joerg


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
