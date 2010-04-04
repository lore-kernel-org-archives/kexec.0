Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtprelay03.ispgateway.de ([80.67.18.15])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NyKCI-0003oJ-1Y
	for kexec@lists.infradead.org; Sun, 04 Apr 2010 07:24:42 +0000
Message-ID: <4BB83EAE.5090609@bwalle.de>
Date: Sun, 04 Apr 2010 09:24:30 +0200
From: Bernhard Walle <bernhard@bwalle.de>
MIME-Version: 1.0
Subject: Re: [PATCH 3/4] Revert "x86: disable IOMMUs on kernel crash"
References: <20100403012751.834020949@sous-sol.org>	<20100403012820.229410717@sous-sol.org>	<20100403174128.GQ24846@8bytes.org>
	<m1vdc8juju.fsf@fess.ebiederm.org>
In-Reply-To: <m1vdc8juju.fsf@fess.ebiederm.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: nhorman@redhat.com, nhorman@tuxdriver.com, Joerg Roedel <joerg.roedel@amd.com>, Joerg Roedel <joro@8bytes.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, hbabu@us.ibm.com, iommu@lists.linux-foundation.org, vgoyal@redhat.com

Am 03.04.10 19:49, schrieb Eric W. Biederman:
> Not a problem.  We require a lot of things of the kdump kernel,
> and it is immediately apparent in a basic sanity test.

Also, in most cases (for example: distribution kernels), the kdump
kernel nowadays is identical to the running kernel. So, if the running
kernel has IOMMU support, the kdump kernel also has.


Regards,
Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
