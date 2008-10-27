Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KuRqm-0007E2-ES
	for kexec@lists.infradead.org; Mon, 27 Oct 2008 13:09:41 +0000
Date: Mon, 27 Oct 2008 09:09:37 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 0/2] kvm: disable virtualization on kdump
Message-ID: <20081027130937.GA28226@redhat.com>
References: <20081022232824.GD5247@verge.net.au>
	<20081023194129.GD27959@blackpad>
	<20081023222906.GB10753@verge.net.au>
	<m1tzb2hkny.fsf@frodo.ebiederm.org> <4904676F.3020706@redhat.com>
	<m1mygre7nk.fsf@frodo.ebiederm.org>
	<490487C1.1010707@redhat.com> <20081026213927.GF23893@blackpad>
	<490581A9.80108@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <490581A9.80108@redhat.com>
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
Cc: Andrew Morton <akpm@osdl.org>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, kexec@lists.infradead.org, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>

On Mon, Oct 27, 2008 at 10:54:01AM +0200, Avi Kivity wrote:
> Eduardo Habkost wrote:
>>> (we can use NMI IPIs, but that will likely be messy)
>>>     
>>
>> NMI IPIs are already used on x86 native_machine_crash_shutdown(), so
>> it wouldn't get more messy that it is currently. We just need to add
>> another bit of code to the code that already runs on an NMI handler.
>>
>>   
>
> That looks like the easiest (and best) way out.
>
>> My question is: is a notifier chain too much complexity for a sensible
>> piece of code like that? If so, a compile-time hook on that point
>> would be safer,
>
> I think an unconditional vmx disable is wanted here, so kexec can work  
> with other hypervisors.
>
>>  but then it wouldn't work when KVM is compiled as a
>> out-of-tree module.
>>   
>
> The external module can do without.  It's possible to hijack the nmi  
> vector, but I don't think that's a good idea.  If someone wants  
> kexec+vmx on an older kernel, they can patch that kernel.
>
>>> But what happens when the kdump kernel reboots?  If it is 
>>> uniprocessor,  it will never have a chance to disable vmx on other 
>>> cpus.  Using acpi  reset (now default) works around this on some 
>>> machines, but not all.
>>>     
>> Good point. My problem was a hang when booting the kdump kernel, but it
>> may also cause problems later, when the kdump kernel reboots.
>>   
>
> The hang was likely caused by vmx blocking INIT.  Sigh.

Avi,

We boot kdump kernel with maxcpus=1. IIUC, in that code path we will not
be using INIT. So did you try booting kdump kernel with maxcpus=1 and did
it work for you? If not than problem could be something else.

Thanks
Vivek

>
> -- 
> error compiling committee.c: too many arguments to function

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
