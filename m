Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KuNwG-0001xu-P4
	for kexec@lists.infradead.org; Mon, 27 Oct 2008 08:59:05 +0000
Message-ID: <490582D4.9000601@redhat.com>
Date: Mon, 27 Oct 2008 10:59:00 +0200
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] kvm: disable virtualization on kdump
References: <20081022232824.GD5247@verge.net.au>	<20081023194129.GD27959@blackpad>	<20081023222906.GB10753@verge.net.au>	<m1tzb2hkny.fsf@frodo.ebiederm.org>
	<4904676F.3020706@redhat.com>	<m1mygre7nk.fsf@frodo.ebiederm.org>
	<490487C1.1010707@redhat.com> <m1k5bvc9ku.fsf@frodo.ebiederm.org>
In-Reply-To: <m1k5bvc9ku.fsf@frodo.ebiederm.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, kexec@lists.infradead.org, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, Vivek Goyal <vgoyal@redhat.com>

Eric W. Biederman wrote:
>> But what happens when the kdump kernel reboots?  If it is uniprocessor, it will
>> never have a chance to disable vmx on other cpus.  Using acpi reset (now
>> default) works around this on some machines, but not all.
>>     
>
> Mostly likely any reboot path will trigger software to toggle the
> reset line on the board.  At least that has been my experience, and
> the reason we don't see many problems when we fail to properly
> shutdown devices before reboot.  If vmx persists across that it would
> seem to be very broken by design.
>   

We've observed on some machines that keyboard controller reset didn't 
work, and that the fallback to triple-fault asserted INIT and not RESET 
(and that this INIT was blocked, hanging the machine).  Switching to 
acpi reset worked on some machines, but not all.  Either acpi reset was 
not implemented on the failing machines, or it was wired to INIT and not 
RESET.

> My objections are:  on_each_cpu called from after a panic looks like
> a good way to loose control of the box and never return.  Adding
> a notifier looks like a good way too add functionality onto the
> kdump path that never gets reviewed for robustness after a kernel
> crash and thus a good way to remove the usefulness of the kexec
> on panic kernel path.
>   

Since we already have NMI IPIs, we could disable vmx there.  If it is 
done unconditionally and without notifiers, there is no chance of having 
unreviewed surprises sneaking in.

-- 
error compiling committee.c: too many arguments to function


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
