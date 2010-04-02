Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from sous-sol.org ([216.99.217.87] helo=sequoia.sous-sol.org)
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1NxVqC-0006un-1P
	for kexec@lists.infradead.org; Fri, 02 Apr 2010 01:38:33 +0000
Date: Thu, 1 Apr 2010 18:38:27 -0700
From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH 1/2] x86/amd-iommu: enable iommu before attaching devices
Message-ID: <20100402013827.GA29241@sequoia.sous-sol.org>
References: <20100331202745.GE13406@hmsreliant.think-freely.org>
	<20100401142902.GF24846@8bytes.org>
	<20100401144736.GA14069@shamino.rdu.redhat.com>
	<20100401155643.GG24846@8bytes.org>
	<20100401171149.GH13603@shamino.rdu.redhat.com>
	<20100401201433.GK24846@8bytes.org>
	<20100402000012.GA8930@hmsreliant.think-freely.org>
	<20100402003034.GX29241@sequoia.sous-sol.org>
	<20100402012353.GY29241@sequoia.sous-sol.org>
	<20100402013513.GA2435@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100402013513.GA2435@localhost.localdomain>
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
To: Neil Horman <nhorman@redhat.com>
Cc: Neil Horman <nhorman@tuxdriver.com>, Joerg Roedel <joerg.roedel@amd.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, hbabu@us.ibm.com, iommu@lists.linux-foundation.org, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

* Neil Horman (nhorman@redhat.com) wrote:
> On Thu, Apr 01, 2010 at 06:23:53PM -0700, Chris Wright wrote:
> > Hit another kdump problem as reported by Neil Horman.  When initializaing
> > the IOMMU, we attach devices to their domains before the IOMMU is
> > fully (re)initialized.  Attaching a device will issue some important
> > invalidations.  In the context of the newly kexec'd kdump kernel, the
> > IOMMU may have stale cached data from the original kernel.  Because we
> > do the attach too early, the invalidation commands are placed in the new
> > command buffer before the IOMMU is updated w/ that buffer.  This leaves
> > the stale entries in the kdump context and can renders device unusable.
> > Simply enable the IOMMU before we do the attach.
> > 
> > Cc: Neil Horman <nhorman@tuxdriver.com>
> > Cc: Vivek Goyal <vgoyal@redhat.com>
> > Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> 
> I'll test this out this weekend, thanks Chris!

Great, thanks!  I tested w/ both default and iommu=pt.  Both worked,
didn't spot any regressions.  But additional testing is very welcome.

thanks,
-chris

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
