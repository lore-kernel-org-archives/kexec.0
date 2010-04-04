Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NyMNm-0004LA-Pe
	for kexec@lists.infradead.org; Sun, 04 Apr 2010 09:44:43 +0000
Subject: Re: [PATCH 3/4] Revert "x86: disable IOMMUs on kernel crash"
References: <20100403012751.834020949@sous-sol.org>
	<20100403012820.229410717@sous-sol.org>
	<20100403174128.GQ24846@8bytes.org> <m1vdc8juju.fsf@fess.ebiederm.org>
	<4BB83EAE.5090609@bwalle.de> <20100404085338.GU24846@8bytes.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 04 Apr 2010 02:44:36 -0700
In-Reply-To: <20100404085338.GU24846@8bytes.org> (Joerg Roedel's message of
	"Sun\, 4 Apr 2010 10\:53\:38 +0200")
Message-ID: <m17hond01n.fsf@fess.ebiederm.org>
MIME-Version: 1.0
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
Cc: nhorman@redhat.com, nhorman@tuxdriver.com, Bernhard Walle <bernhard@bwalle.de>, Joerg Roedel <joerg.roedel@amd.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, hbabu@us.ibm.com, iommu@lists.linux-foundation.org, vgoyal@redhat.com

Joerg Roedel <joro@8bytes.org> writes:

> On Sun, Apr 04, 2010 at 09:24:30AM +0200, Bernhard Walle wrote:
>> Am 03.04.10 19:49, schrieb Eric W. Biederman:
>> > Not a problem.  We require a lot of things of the kdump kernel,
>> > and it is immediately apparent in a basic sanity test.
>> 
>> Also, in most cases (for example: distribution kernels), the kdump
>> kernel nowadays is identical to the running kernel. So, if the running
>> kernel has IOMMU support, the kdump kernel also has.
>
> Yes, I know. But is that a requirement for kexec?

For normal kexec no.  That path is expected to do a clean hardware
shutdown.

For kexec on panic aka kdump the requirement is that your your crash
kernel be able to initialize your hardware from any state it can be
put in.

Currently we have no kernels that properly recover and amd-iommu and
it is not a requirement that we cater to broken kernels.

> If not we still
> potentially have this problem. It is a smaller problem than
> data-corruption caused by in-flight dma because most
> people^Wdistributions indeed use the same kernel for normal boot and
> kexec, thats true.

There are exceptions made for practical reality.  The fact that
typically the kdump kernel is the same as the running kernel mean that
we don't even need to consider one of those exceptions.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
