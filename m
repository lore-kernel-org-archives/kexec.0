Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from sous-sol.org ([216.99.217.87] helo=sequoia.sous-sol.org)
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1NzCpc-0006pQ-AW
	for kexec@lists.infradead.org; Tue, 06 Apr 2010 17:44:57 +0000
Date: Tue, 6 Apr 2010 10:42:57 -0700
From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH 3/4] Revert "x86: disable IOMMUs on kernel crash"
Message-ID: <20100406174257.GG29241@sequoia.sous-sol.org>
References: <20100403012751.834020949@sous-sol.org>
	<20100403012820.229410717@sous-sol.org>
	<20100403174128.GQ24846@8bytes.org>
	<m1vdc8juju.fsf@fess.ebiederm.org> <4BB83EAE.5090609@bwalle.de>
	<20100404085338.GU24846@8bytes.org>
	<m17hond01n.fsf@fess.ebiederm.org>
	<20100404100101.GW24846@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100404100101.GW24846@8bytes.org>
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
Cc: nhorman@redhat.com, nhorman@tuxdriver.com, Bernhard Walle <bernhard@bwalle.de>, Joerg Roedel <joerg.roedel@amd.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, hbabu@us.ibm.com, iommu@lists.linux-foundation.org, "Eric W. Biederman" <ebiederm@xmission.com>, vgoyal@redhat.com

* Joerg Roedel (joro@8bytes.org) wrote:
> On Sun, Apr 04, 2010 at 02:44:36AM -0700, Eric W. Biederman wrote:
> > Joerg Roedel <joro@8bytes.org> writes:
> > 
> > > On Sun, Apr 04, 2010 at 09:24:30AM +0200, Bernhard Walle wrote:
> > >> Am 03.04.10 19:49, schrieb Eric W. Biederman:
> > >> > Not a problem.  We require a lot of things of the kdump kernel,
> > >> > and it is immediately apparent in a basic sanity test.
> > >> 
> > >> Also, in most cases (for example: distribution kernels), the kdump
> > >> kernel nowadays is identical to the running kernel. So, if the running
> > >> kernel has IOMMU support, the kdump kernel also has.
> > >
> > > Yes, I know. But is that a requirement for kexec?
> > 
> > For normal kexec no.  That path is expected to do a clean hardware
> > shutdown.
> > 
> > For kexec on panic aka kdump the requirement is that your your crash
> > kernel be able to initialize your hardware from any state it can be
> > put in.
> 
> Ok, if you show me where this is documented for everybody then I am
> probably convinced :-)
> We should fixup the gart initialization anyway.

So, you planning to pull in all 4 patches then?

thanks,
-chris

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
