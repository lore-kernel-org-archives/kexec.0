Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from 8bytes.org ([88.198.83.132])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NyLaO-0001L6-5x
	for kexec@lists.infradead.org; Sun, 04 Apr 2010 08:53:40 +0000
Date: Sun, 4 Apr 2010 10:53:38 +0200
From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 3/4] Revert "x86: disable IOMMUs on kernel crash"
Message-ID: <20100404085338.GU24846@8bytes.org>
References: <20100403012751.834020949@sous-sol.org>
	<20100403012820.229410717@sous-sol.org>
	<20100403174128.GQ24846@8bytes.org>
	<m1vdc8juju.fsf@fess.ebiederm.org> <4BB83EAE.5090609@bwalle.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4BB83EAE.5090609@bwalle.de>
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
To: Bernhard Walle <bernhard@bwalle.de>
Cc: nhorman@redhat.com, nhorman@tuxdriver.com, Joerg Roedel <joerg.roedel@amd.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, hbabu@us.ibm.com, iommu@lists.linux-foundation.org, "Eric W. Biederman" <ebiederm@xmission.com>, vgoyal@redhat.com

On Sun, Apr 04, 2010 at 09:24:30AM +0200, Bernhard Walle wrote:
> Am 03.04.10 19:49, schrieb Eric W. Biederman:
> > Not a problem.  We require a lot of things of the kdump kernel,
> > and it is immediately apparent in a basic sanity test.
> 
> Also, in most cases (for example: distribution kernels), the kdump
> kernel nowadays is identical to the running kernel. So, if the running
> kernel has IOMMU support, the kdump kernel also has.

Yes, I know. But is that a requirement for kexec? If not we still
potentially have this problem. It is a smaller problem than
data-corruption caused by in-flight dma because most
people^Wdistributions indeed use the same kernel for normal boot and
kexec, thats true.

	Joerg


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
