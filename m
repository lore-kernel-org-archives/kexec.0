Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Ku7Dg-0003Yr-3b
	for kexec@lists.infradead.org; Sun, 26 Oct 2008 15:07:56 +0000
Message-ID: <490487C1.1010707@redhat.com>
Date: Sun, 26 Oct 2008 17:07:45 +0200
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] kvm: disable virtualization on kdump
References: <20081022232824.GD5247@verge.net.au>	<20081023194129.GD27959@blackpad>	<20081023222906.GB10753@verge.net.au>	<m1tzb2hkny.fsf@frodo.ebiederm.org>
	<4904676F.3020706@redhat.com> <m1mygre7nk.fsf@frodo.ebiederm.org>
In-Reply-To: <m1mygre7nk.fsf@frodo.ebiederm.org>
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
>> so reboots don't
>> work.  It also assigns some memory to the cpu; if the new kernel isn't aware of
>> it, 
>>     
>
> Not a problem for a kdump kernel, as it lives out of a reserved region
> of memory.
>   

But it is a problem for general kexec.

>>> Is it possible to disable vmx mode before we enable interrrupts in the
>>> kdump kernel?
>>>
>>>       
>> You need IPIs to disable vmx on smp.
>>     
>
> Thank you.  Reading your description and taking a quick look at
> the code in hardware disable it does not appear that there is
> anything needed (other than restricting ourselves it running
> uniprocessor in the kdump kernel) that needs to happen.
>
> Certainly it would be nice to have kvm disabled in hardware,
> but if you are proposing using the existing hardware disable
> I must say that the cure looks much worse than the disease.
>   

Certainly you don't want to issue IPIs when kdump()ing.  It's not 
unlikely that the other cpus have interrupts permanently disabled.

(we can use NMI IPIs, but that will likely be messy)

> It looks like the disable function is all of about 20 assembly
> instructions so I would not have a problem if he had a
> little inline function we could call that test to see if
> vmx is enabled and disable it in the case of kexec on panic.
>
> The normal polite shutdown.  That just looks like asking for trouble.
>   

But what happens when the kdump kernel reboots?  If it is uniprocessor, 
it will never have a chance to disable vmx on other cpus.  Using acpi 
reset (now default) works around this on some machines, but not all.

-- 
error compiling committee.c: too many arguments to function


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
