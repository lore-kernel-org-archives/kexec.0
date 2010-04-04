Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NyNNW-00028h-Hp
	for kexec@lists.infradead.org; Sun, 04 Apr 2010 10:48:31 +0000
Subject: Re: [PATCH 3/4] Revert "x86: disable IOMMUs on kernel crash"
References: <20100403012751.834020949@sous-sol.org>
	<20100403012820.229410717@sous-sol.org>
	<20100403174128.GQ24846@8bytes.org> <m1vdc8juju.fsf@fess.ebiederm.org>
	<4BB83EAE.5090609@bwalle.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 04 Apr 2010 00:51:10 -0700
In-Reply-To: <4BB83EAE.5090609@bwalle.de> (Bernhard Walle's message of "Sun\,
	04 Apr 2010 09\:24\:30 +0200")
Message-ID: <m1pr2fhd01.fsf@fess.ebiederm.org>
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
To: Bernhard Walle <bernhard@bwalle.de>
Cc: nhorman@redhat.com, nhorman@tuxdriver.com, Joerg Roedel <joerg.roedel@amd.com>, Joerg Roedel <joro@8bytes.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, hbabu@us.ibm.com, iommu@lists.linux-foundation.org, vgoyal@redhat.com

Bernhard Walle <bernhard@bwalle.de> writes:

> Am 03.04.10 19:49, schrieb Eric W. Biederman:
>> Not a problem.  We require a lot of things of the kdump kernel,
>> and it is immediately apparent in a basic sanity test.
>
> Also, in most cases (for example: distribution kernels), the kdump
> kernel nowadays is identical to the running kernel. So, if the running
> kernel has IOMMU support, the kdump kernel also has.

I have been rather pleasantly surprised at how well that works.  Although
I am still glad I insisted that using the same kernel version not be a
hard requirement.  It allowed us to specify a good solid interface.

How to cope with GART in that situation without having to manually specify
iommu=off in the configuration I find a more compelling question.

I expect I will have a look at that in the coming months if someone doesn't get
there before I do.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
