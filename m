Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KuOAU-0000AG-U6
	for kexec@lists.infradead.org; Mon, 27 Oct 2008 09:13:47 +0000
Message-ID: <49058645.9010005@redhat.com>
Date: Mon, 27 Oct 2008 11:13:41 +0200
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] kvm: disable virtualization on kdump
References: <20081022232824.GD5247@verge.net.au>	<20081023194129.GD27959@blackpad>	<20081023222906.GB10753@verge.net.au>	<m1tzb2hkny.fsf@frodo.ebiederm.org>
	<4904676F.3020706@redhat.com>	<m1mygre7nk.fsf@frodo.ebiederm.org>
	<490487C1.1010707@redhat.com>	<20081026213927.GF23893@blackpad>
	<m1bpx6bxhm.fsf@frodo.ebiederm.org>
In-Reply-To: <m1bpx6bxhm.fsf@frodo.ebiederm.org>
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
>> NMI IPIs are already used on x86 native_machine_crash_shutdown(), so
>> it wouldn't get more messy that it is currently. We just need to add
>> another bit of code to the code that already runs on an NMI handler.
>>     
>
> Yes.  And handling of those NMIs is best effort.  Nothing fails if
> they don't actually run.
>
>   

Unless someone can come up with another way to disable vmx remotely, 
that's going to change if you have vmx enabled.

> Well we could fairly easily have a non-modular function that does.
> if (vmx_present && vmx_enabled) {
>    turn_off_vmx();
> }
>
> Which at first skim looks like it is all of about 10-20 machine
> instructions.
>
>   

There's no way to query whether vmx is enabled or disabled, AFAICT.  So 
we have to execute vmxoff and ignore possible #UDs.

If we trust the exception handlers, there's no problem.  Otherwise we 
need to replace the current #UD handler with an iret (perhaps switching 
temporarily to another IDT).

> There are a few real places where we need code on the kdump
> path because there it is not possible to do the work any
> other way.  However we need to think long and hard about
> that because placing the code anywhere besides in a broken
> and failing kernel is going to be easier to maintain and
> more reliable.
>   

vmx blocking INITs makes it impossible to leave this to the new kernel.

> I oppose an atomic notifier because it makes the review
> essentially impossible.  If any module can come in and register
> a notifier we can't know what code is running on that code
> path and we can't be certain the code is safe in an abnormal
> case to run on that code path.
>   

What if it's a specialized notifier for kexec?  Or even kexec_crash?

That said, I have no issue with static code at the call site.

> Right now we only need to support vmx on the kdump path because
> of what appears to be a hardware design bug.  Enabling vmx
> apparently disables standard functions like an INIT IPI.  Things
> like this do happen but they should be rare.
>   

The general kexec path also wants this fixed.

-- 
error compiling committee.c: too many arguments to function


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
