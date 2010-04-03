Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Ny9Dm-0006nU-GU
	for kexec@lists.infradead.org; Sat, 03 Apr 2010 19:41:31 +0000
Subject: Re: [PATCH 3/4] Revert "x86: disable IOMMUs on kernel crash"
References: <20100403012751.834020949@sous-sol.org>
	<20100403012820.229410717@sous-sol.org>
	<20100403174128.GQ24846@8bytes.org> <m1vdc8juju.fsf@fess.ebiederm.org>
	<20100403191314.GR24846@8bytes.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 03 Apr 2010 12:41:21 -0700
In-Reply-To: <20100403191314.GR24846@8bytes.org> (Joerg Roedel's message of
	"Sat\, 3 Apr 2010 21\:13\:14 +0200")
Message-ID: <m1vdc8iase.fsf@fess.ebiederm.org>
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
Cc: nhorman@redhat.com, nhorman@tuxdriver.com, Joerg Roedel <joerg.roedel@amd.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, hbabu@us.ibm.com, iommu@lists.linux-foundation.org, vgoyal@redhat.com

Joerg Roedel <joro@8bytes.org> writes:

> On Sat, Apr 03, 2010 at 10:49:09AM -0700, Eric W. Biederman wrote:
>> Joerg Roedel <joro@8bytes.org> writes:
>
>> > Another problem: This also breaks if the kdump kernel has no
>> > iommu-support.
>> 
>> Not a problem.  We require a lot of things of the kdump kernel,
>> and it is immediately apparent in a basic sanity test.
>
> Only if the sanity test is done on an iommu machine which I don't want
> to rely on.

That makes no sense.

The requirements on the kdump kernel has always been that it somehow
figure out to recover a machine that is in a random hardware state.
That requires drivers for the hardware, that is critical to the
machines operation.

The easy test for sysadmins is to do:
echo > /proc/sysrq-trigger

Anyone who thinks the result from one piece of hardware applies to
another is deluded.

We have been down the path of doing lots of things in the crashing
kernel with lkcd, in practice it was worthless in the event of real
world crashes.

kexec on panic isn't perfect but it at least is an architecture that
works often enough to be usable.  It does require testing to make certain
the basic code paths don't regress, but even so it is a lot easier
to maintain and keep useful than any alternative I know of.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
