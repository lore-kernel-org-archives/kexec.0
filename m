Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KuTnn-0007kI-EV
	for kexec@lists.infradead.org; Mon, 27 Oct 2008 15:14:43 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20081022232824.GD5247@verge.net.au>
	<20081023194129.GD27959@blackpad>
	<20081023222906.GB10753@verge.net.au>
	<m1tzb2hkny.fsf@frodo.ebiederm.org> <4904676F.3020706@redhat.com>
	<m1mygre7nk.fsf@frodo.ebiederm.org> <490487C1.1010707@redhat.com>
	<20081026213927.GF23893@blackpad> <m1bpx6bxhm.fsf@frodo.ebiederm.org>
	<49058645.9010005@redhat.com>
Date: Mon, 27 Oct 2008 08:05:50 -0700
In-Reply-To: <49058645.9010005@redhat.com> (Avi Kivity's message of "Mon, 27
	Oct 2008 11:13:41 +0200")
Message-ID: <m1skqi9iy9.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] kvm: disable virtualization on kdump
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
To: Avi Kivity <avi@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, kexec@lists.infradead.org, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, Vivek Goyal <vgoyal@redhat.com>

Avi Kivity <avi@redhat.com> writes:

> There's no way to query whether vmx is enabled or disabled, AFAICT.  So we have
> to execute vmxoff and ignore possible #UDs.
>
> If we trust the exception handlers, there's no problem.  Otherwise we need to
> replace the current #UD handler with an iret (perhaps switching temporarily to
> another IDT).

Ugh.  We already change the IDT on that code path so that
may be a way to go.

> The general kexec path also wants this fixed.

It looks like someone hooked the reboot notifier which should
be called on the normal kexec path.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
