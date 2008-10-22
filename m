Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Ksn7p-0001Wj-EZ
	for kexec@lists.infradead.org; Wed, 22 Oct 2008 23:28:25 +0000
Date: Thu, 23 Oct 2008 10:28:24 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/2] kvm: disable virtualization on kdump
Message-ID: <20081022232824.GD5247@verge.net.au>
References: <1224514894-30171-1-git-send-email-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1224514894-30171-1-git-send-email-ehabkost@redhat.com>
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
Cc: kexec@lists.infradead.org, kvm@vger.kernel.org

On Mon, Oct 20, 2008 at 01:01:32PM -0200, Eduardo Habkost wrote:
> The following two patches should make kdump work when the kvm-intel module
> is loaded. We need to disable vmx mode before booting the kdump kernel,
> so I've introduced a notifier interface where KVM can hook and disable
> virtualization on all CPUs just before they are halted.
> 
> It has the same purpose of the KVM reboot notifier that gets executed
> at kexec-time. But on the kdump case, things are not as simple because
> the kernel has just crashed.
> 
> The notifier interface being introduced is x86-specific. I don't know
> if an arch-independent interface would be more appropriate for this
> case.
> 
> It was tested only using kvm-intel. Testing on different machines
> is welcome.

These changes look fine to me from a kexec/kdump point of view.

Reviewed-by: Simon Horman <horms@verge.net.au>

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
