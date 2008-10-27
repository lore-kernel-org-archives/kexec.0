Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KuHd0-0003d0-L0
	for kexec@lists.infradead.org; Mon, 27 Oct 2008 02:14:47 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20081022232824.GD5247@verge.net.au>
	<20081023194129.GD27959@blackpad>
	<20081023222906.GB10753@verge.net.au>
	<m1tzb2hkny.fsf@frodo.ebiederm.org> <4904676F.3020706@redhat.com>
	<m1mygre7nk.fsf@frodo.ebiederm.org> <490487C1.1010707@redhat.com>
	<20081026213927.GF23893@blackpad>
Date: Sun, 26 Oct 2008 19:08:53 -0700
In-Reply-To: <20081026213927.GF23893@blackpad> (Eduardo Habkost's message of
	"Sun, 26 Oct 2008 19:39:27 -0200")
Message-ID: <m1bpx6bxhm.fsf@frodo.ebiederm.org>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, kvm@vger.kernel.org, kexec@lists.infradead.org, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, Avi Kivity <avi@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Sun, Oct 26, 2008 at 05:07:45PM +0200, Avi Kivity wrote:
>> Eric W. Biederman wrote:
> <snip>
>>>>> Is it possible to disable vmx mode before we enable interrrupts in the
>>>>> kdump kernel?
>>>>>
>>>>>       
>>>> You need IPIs to disable vmx on smp.
>>>>     
>>>
>>> Thank you.  Reading your description and taking a quick look at
>>> the code in hardware disable it does not appear that there is
>>> anything needed (other than restricting ourselves it running
>>> uniprocessor in the kdump kernel) that needs to happen.
>>>
>>> Certainly it would be nice to have kvm disabled in hardware,
>>> but if you are proposing using the existing hardware disable
>>> I must say that the cure looks much worse than the disease.
>>>   
>>
>> Certainly you don't want to issue IPIs when kdump()ing.  It's not  
>> unlikely that the other cpus have interrupts permanently disabled.
>>
>> (we can use NMI IPIs, but that will likely be messy)
>
> NMI IPIs are already used on x86 native_machine_crash_shutdown(), so
> it wouldn't get more messy that it is currently. We just need to add
> another bit of code to the code that already runs on an NMI handler.

Yes.  And handling of those NMIs is best effort.  Nothing fails if
they don't actually run.

> My question is: is a notifier chain too much complexity for a sensible
> piece of code like that? If so, a compile-time hook on that point
> would be safer, but then it wouldn't work when KVM is compiled as a
> out-of-tree module.

Well we could fairly easily have a non-modular function that does.
if (vmx_present && vmx_enabled) {
   turn_off_vmx();
}

Which at first skim looks like it is all of about 10-20 machine
instructions.

There are a few real places where we need code on the kdump
path because there it is not possible to do the work any
other way.  However we need to think long and hard about
that because placing the code anywhere besides in a broken
and failing kernel is going to be easier to maintain and
more reliable.

I oppose an atomic notifier because it makes the review
essentially impossible.  If any module can come in and register
a notifier we can't know what code is running on that code
path and we can't be certain the code is safe in an abnormal
case to run on that code path.

Right now we only need to support vmx on the kdump path because
of what appears to be a hardware design bug.  Enabling vmx
apparently disables standard functions like an INIT IPI.  Things
like this do happen but they should be rare.

> Good point. My problem was a hang when booting the kdump kernel, but it
> may also cause problems later, when the kdump kernel reboots.

What was the cause of the hang when booting the kdump kernel?

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
