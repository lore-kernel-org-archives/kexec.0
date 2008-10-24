Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KtB6U-0004u5-8Y
	for kexec@lists.infradead.org; Fri, 24 Oct 2008 01:04:38 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20081022232824.GD5247@verge.net.au>
	<20081023194129.GD27959@blackpad>
	<20081023222906.GB10753@verge.net.au>
Date: Thu, 23 Oct 2008 18:00:17 -0700
In-Reply-To: <20081023222906.GB10753@verge.net.au> (Simon Horman's message of
	"Fri, 24 Oct 2008 09:29:08 +1100")
Message-ID: <m1tzb2hkny.fsf@frodo.ebiederm.org>
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
To: Simon Horman <horms@verge.net.au>
Cc: Andrew Morton <akpm@osdl.org>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, kexec@lists.infradead.org, Haren Myneni <hbabu@us.ibm.com>, Avi Kivity <avi@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

Simon Horman <horms@verge.net.au> writes:

> [ Added Andrew Morton, Eric Biederman, Vivek Goyal and Haren Myneni to CC ]
>
> On Thu, Oct 23, 2008 at 05:41:29PM -0200, Eduardo Habkost wrote:
>> On Thu, Oct 23, 2008 at 10:28:24AM +1100, Simon Horman wrote:
>> > On Mon, Oct 20, 2008 at 01:01:32PM -0200, Eduardo Habkost wrote:
>> > > The following two patches should make kdump work when the kvm-intel module
>> > > is loaded. We need to disable vmx mode before booting the kdump kernel,
>> > > so I've introduced a notifier interface where KVM can hook and disable
>> > > virtualization on all CPUs just before they are halted.
>> > > 
>> > > It has the same purpose of the KVM reboot notifier that gets executed
>> > > at kexec-time. But on the kdump case, things are not as simple because
>> > > the kernel has just crashed.
>> > > 
>> > > The notifier interface being introduced is x86-specific. I don't know
>> > > if an arch-independent interface would be more appropriate for this
>> > > case.

My preference would be to have a magic function call that compiles out when
kvm isn't present.  This is a code path that is hard to audit and test, and
get right.  A notifier chain seems to make a proper audit all but impossible.

Why do we need to disable vmx mode before booting a normal linux kernel?
Is it possible to disable vmx mode before we enable interrrupts in the
kdump kernel?

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
