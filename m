Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KuDKy-0003Gd-Qw
	for kexec@lists.infradead.org; Sun, 26 Oct 2008 21:39:53 +0000
Date: Sun, 26 Oct 2008 19:39:27 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 0/2] kvm: disable virtualization on kdump
Message-ID: <20081026213927.GF23893@blackpad>
References: <20081022232824.GD5247@verge.net.au>
	<20081023194129.GD27959@blackpad>
	<20081023222906.GB10753@verge.net.au>
	<m1tzb2hkny.fsf@frodo.ebiederm.org> <4904676F.3020706@redhat.com>
	<m1mygre7nk.fsf@frodo.ebiederm.org> <490487C1.1010707@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <490487C1.1010707@redhat.com>
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
Cc: Andrew Morton <akpm@osdl.org>, kvm@vger.kernel.org, kexec@lists.infradead.org, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

On Sun, Oct 26, 2008 at 05:07:45PM +0200, Avi Kivity wrote:
> Eric W. Biederman wrote:
<snip>
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
> Certainly you don't want to issue IPIs when kdump()ing.  It's not  
> unlikely that the other cpus have interrupts permanently disabled.
>
> (we can use NMI IPIs, but that will likely be messy)

NMI IPIs are already used on x86 native_machine_crash_shutdown(), so
it wouldn't get more messy that it is currently. We just need to add
another bit of code to the code that already runs on an NMI handler.

My question is: is a notifier chain too much complexity for a sensible
piece of code like that? If so, a compile-time hook on that point
would be safer, but then it wouldn't work when KVM is compiled as a
out-of-tree module.


>
>> It looks like the disable function is all of about 20 assembly
>> instructions so I would not have a problem if he had a
>> little inline function we could call that test to see if
>> vmx is enabled and disable it in the case of kexec on panic.
>>
>> The normal polite shutdown.  That just looks like asking for trouble.
>>   
>
> But what happens when the kdump kernel reboots?  If it is uniprocessor,  
> it will never have a chance to disable vmx on other cpus.  Using acpi  
> reset (now default) works around this on some machines, but not all.

Good point. My problem was a hang when booting the kdump kernel, but it
may also cause problems later, when the kdump kernel reboots.

-- 
Eduardo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
