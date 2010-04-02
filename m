Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from sous-sol.org ([216.99.217.87] helo=sequoia.sous-sol.org)
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1NxUmh-00013P-Aq
	for kexec@lists.infradead.org; Fri, 02 Apr 2010 00:30:52 +0000
Date: Thu, 1 Apr 2010 17:30:34 -0700
From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH] amd iommu: force flush of iommu prior during shutdown
Message-ID: <20100402003034.GX29241@sequoia.sous-sol.org>
References: <m1wrwsuxn9.fsf@fess.ebiederm.org>
	<20100331191811.GD13406@hmsreliant.think-freely.org>
	<m1sk7guv5u.fsf@fess.ebiederm.org>
	<20100331202745.GE13406@hmsreliant.think-freely.org>
	<20100401142902.GF24846@8bytes.org>
	<20100401144736.GA14069@shamino.rdu.redhat.com>
	<20100401155643.GG24846@8bytes.org>
	<20100401171149.GH13603@shamino.rdu.redhat.com>
	<20100401201433.GK24846@8bytes.org>
	<20100402000012.GA8930@hmsreliant.think-freely.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100402000012.GA8930@hmsreliant.think-freely.org>
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
Cc: Neil Horman <nhorman@redhat.com>, Joerg Roedel <joro@8bytes.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, iommu@lists.linux-foundation.org, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

* Neil Horman (nhorman@tuxdriver.com) wrote:
> On Thu, Apr 01, 2010 at 10:14:34PM +0200, Joerg Roedel wrote:
> > On Thu, Apr 01, 2010 at 01:11:49PM -0400, Neil Horman wrote:
> > > On Thu, Apr 01, 2010 at 05:56:43PM +0200, Joerg Roedel wrote:
> > 
> > > > The possible fix will be to enable the hardware earlier in the
> > > > initialization path.
> > > > 
> > > That sounds like a reasonable theory, I'll try hack something together
> > > shortly.
> > 
> > Great. So the problem might be already fixed when I am back in the
> > office ;-)
> > 
> Don't hold your breath, but I'll try my best :)

The problem we had before was a combo of not clearing PDE and not having
the command buffer set up properly.  Now we have basically the same
problem.  The attach is running too early, so the invalidate commands
are falling on deaf ears.

thanks,
-chris

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
