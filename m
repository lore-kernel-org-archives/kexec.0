Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KuSfx-00008r-As
	for kexec@lists.infradead.org; Mon, 27 Oct 2008 14:02:33 +0000
Message-ID: <4905C9ED.807@redhat.com>
Date: Mon, 27 Oct 2008 16:02:21 +0200
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] kvm: disable virtualization on kdump
References: <20081022232824.GD5247@verge.net.au>
	<20081023194129.GD27959@blackpad>
	<20081023222906.GB10753@verge.net.au>
	<m1tzb2hkny.fsf@frodo.ebiederm.org> <4904676F.3020706@redhat.com>
	<m1mygre7nk.fsf@frodo.ebiederm.org>
	<490487C1.1010707@redhat.com> <20081026213927.GF23893@blackpad>
	<m1bpx6bxhm.fsf@frodo.ebiederm.org>
	<49058645.9010005@redhat.com> <20081027122808.GH23893@blackpad>
In-Reply-To: <20081027122808.GH23893@blackpad>
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
Cc: Andrew Morton <akpm@osdl.org>, kvm@vger.kernel.org, kexec@lists.infradead.org, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

Eduardo Habkost wrote:
> Can't we just set a flag when we are about to enable vmx, so we run vmxoff
> only when know it's enabled? There will be a tiny window between setting
> this flag and and actually running vmxon where things could go wrong,
> but this doesn't look that bad.
>   

It makes more sense to have a vmxon api in the core; you call it, the 
kernel enables it and sets a flag; then either you or the core can 
disable it.

> Having to handle #UD would make things more messy, in my opinion.
>   

It's not too bad, either relying on exception handlers or hacking our own.

> BTW, is this problem vmx-specific? Do we need to do something similar
> for svm?
>
>   

svm needs it as well, since it shares some memory with the cpu.  It's 
less critical though, will likely work even without it.

>> If we trust the exception handlers, there's no problem.  Otherwise we  
>> need to replace the current #UD handler with an iret (perhaps switching  
>> temporarily to another IDT).
>>     
>
> I think we can't fully trust anything if we are on the crash dump path,
> so the less code we depend on, the better.
>   

So we can point #UD temporarily at an 'addq $3, (%rsp); iret' for the 
vmxoff instruction.  Or implement the 'enable virt extensions' API.

> The patches I've sent to the kvm mailing list added a notifier interface
> specific for kexec_crash, using raw_notifier_*().
>
> IMO, if a notifier registration interface was acceptable, the raw
> notifiers would be good enough for that. But Eric seems to think that
> adding a notifier registration interface for the crash handler path
> wouldn't be a good idea, and I am starting to agree with him.
>
>   

I wouldn't mind notifiers (with a nice comment explaining that you must 
know what you're doing, though that's the case with most kernel APIs).  
I'm fine with either approach.

>> The general kexec path also wants this fixed.
>>     
>
> When I've tested it, kexec called the kvm reboot notifier, so
> everything worked fine.
>   

Oh, okay.

-- 
error compiling committee.c: too many arguments to function


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
