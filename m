Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KuDZK-0004fH-2Q
	for kexec@lists.infradead.org; Sun, 26 Oct 2008 21:54:43 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20081022232824.GD5247@verge.net.au>
	<20081023194129.GD27959@blackpad>
	<20081023222906.GB10753@verge.net.au>
	<m1tzb2hkny.fsf@frodo.ebiederm.org> <4904676F.3020706@redhat.com>
	<m1mygre7nk.fsf@frodo.ebiederm.org> <490487C1.1010707@redhat.com>
Date: Sun, 26 Oct 2008 14:47:45 -0700
In-Reply-To: <490487C1.1010707@redhat.com> (Avi Kivity's message of "Sun, 26
	Oct 2008 17:07:45 +0200")
Message-ID: <m1k5bvc9ku.fsf@frodo.ebiederm.org>
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

> Eric W. Biederman wrote:
>>> so reboots don't
>>> work.  It also assigns some memory to the cpu; if the new kernel isn't aware
> of
>>> it,
>>
>> Not a problem for a kdump kernel, as it lives out of a reserved region
>> of memory.
>>
>
> But it is a problem for general kexec.

Agreed.  We certainly want to cleanly disable vmx on a normal
kexec reboot.

>>>> Is it possible to disable vmx mode before we enable interrrupts in the
>>>> kdump kernel?
>>>>
>>>>
>>> You need IPIs to disable vmx on smp.
>>>
>>
>> Thank you.  Reading your description and taking a quick look at
>> the code in hardware disable it does not appear that there is
>> anything needed (other than restricting ourselves it running
>> uniprocessor in the kdump kernel) that needs to happen.
>>
>> Certainly it would be nice to have kvm disabled in hardware,
>> but if you are proposing using the existing hardware disable
>> I must say that the cure looks much worse than the disease.
>>
>
> Certainly you don't want to issue IPIs when kdump()ing.  It's not unlikely that
> the other cpus have interrupts permanently disabled.
>
> (we can use NMI IPIs, but that will likely be messy)
>
>> It looks like the disable function is all of about 20 assembly
>> instructions so I would not have a problem if he had a
>> little inline function we could call that test to see if
>> vmx is enabled and disable it in the case of kexec on panic.
>>
>> The normal polite shutdown.  That just looks like asking for trouble.
>>
>
> But what happens when the kdump kernel reboots?  If it is uniprocessor, it will
> never have a chance to disable vmx on other cpus.  Using acpi reset (now
> default) works around this on some machines, but not all.

Mostly likely any reboot path will trigger software to toggle the
reset line on the board.  At least that has been my experience, and
the reason we don't see many problems when we fail to properly
shutdown devices before reboot.  If vmx persists across that it would
seem to be very broken by design.

In any case if reboot fails after a kdump that is a minor thing.  Someone
can always push the power button or the equivalent.

My objections are:  on_each_cpu called from after a panic looks like
a good way to loose control of the box and never return.  Adding
a notifier looks like a good way too add functionality onto the
kdump path that never gets reviewed for robustness after a kernel
crash and thus a good way to remove the usefulness of the kexec
on panic kernel path.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
