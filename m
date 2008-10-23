Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Kt8g2-0007vz-7w
	for kexec@lists.infradead.org; Thu, 23 Oct 2008 22:29:11 +0000
Date: Fri, 24 Oct 2008 09:29:08 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/2] kvm: disable virtualization on kdump
Message-ID: <20081023222906.GB10753@verge.net.au>
References: <20081022232824.GD5247@verge.net.au>
	<20081023194129.GD27959@blackpad>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20081023194129.GD27959@blackpad>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, kvm@vger.kernel.org, kexec@lists.infradead.org, Haren Myneni <hbabu@us.ibm.com>, Avi Kivity <avi@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>

[ Added Andrew Morton, Eric Biederman, Vivek Goyal and Haren Myneni to CC ]

On Thu, Oct 23, 2008 at 05:41:29PM -0200, Eduardo Habkost wrote:
> On Thu, Oct 23, 2008 at 10:28:24AM +1100, Simon Horman wrote:
> > On Mon, Oct 20, 2008 at 01:01:32PM -0200, Eduardo Habkost wrote:
> > > The following two patches should make kdump work when the kvm-intel module
> > > is loaded. We need to disable vmx mode before booting the kdump kernel,
> > > so I've introduced a notifier interface where KVM can hook and disable
> > > virtualization on all CPUs just before they are halted.
> > > 
> > > It has the same purpose of the KVM reboot notifier that gets executed
> > > at kexec-time. But on the kdump case, things are not as simple because
> > > the kernel has just crashed.
> > > 
> > > The notifier interface being introduced is x86-specific. I don't know
> > > if an arch-independent interface would be more appropriate for this
> > > case.
> > > 
> > > It was tested only using kvm-intel. Testing on different machines
> > > is welcome.
> > 
> > These changes look fine to me from a kexec/kdump point of view.
> > 
> > Reviewed-by: Simon Horman <horms@verge.net.au>
> 
> Thanks.
> 
> Considering they touch both KVM and kexec, which tree would be best way
> to get them in?

As I understand it, there is no kexec tree as such, rather
patches either get picked up by an arch tree or Andrew Morton.
I am happy to create and maintain a kexec tree if there is a need.
But in this case it seems that using the KVM tree would be best.

> (Avi: the patches were sent only to kexec and kvm mailing lists,
> initially. If it's better to submit them to your address also so it gets
> on your queue, please let me know)

I won't speak for Avi, but usually its good to CC the maintainer.

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
