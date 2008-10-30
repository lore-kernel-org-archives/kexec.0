Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KvMR1-0006kh-LY
	for kexec@lists.infradead.org; Thu, 30 Oct 2008 01:34:52 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <m1tzb2hkny.fsf@frodo.ebiederm.org> <4904676F.3020706@redhat.com>
	<m1mygre7nk.fsf@frodo.ebiederm.org> <490487C1.1010707@redhat.com>
	<20081026213927.GF23893@blackpad>
	<m1bpx6bxhm.fsf@frodo.ebiederm.org>
	<49058645.9010005@redhat.com> <20081027122808.GH23893@blackpad>
	<4905C9ED.807@redhat.com> <m18wsa7xl0.fsf@frodo.ebiederm.org>
	<20081028194530.GK23893@blackpad> <m18ws84gxc.fsf@frodo.ebiederm.org>
	<49082FD0.3040009@redhat.com> <m13aif4fk7.fsf@frodo.ebiederm.org>
	<4908975A.7050900@redhat.com>
Date: Wed, 29 Oct 2008 18:33:39 -0700
In-Reply-To: <4908975A.7050900@redhat.com> (Avi Kivity's message of "Wed, 29
	Oct 2008 19:03:22 +0200")
Message-ID: <m1bpx23lzg.fsf@frodo.ebiederm.org>
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
>> Most of the reason I was wondering is that the cpu hardware probing
>> largely seems to be a duplicate of what we have in the core for
>> probing cpu capabilities already, and could likely be made smaller
>> by building upon the existing codebase.
>>
>>
>
> We use the core cpuid functions, or are you referring to something else?

I was referring to the arch/x86/kernel/cpu/*
and arch/x86/include/asm/cpufeature.h

The core functions that are responsible for detecting all of the cpu features,
and disabling them if there are cpu errata.

The usual pattern is that code does all of the magic detection logic and
then the code that would use it would just need to test: cpu_has_vmx or cpu_has_svm.

At least in part that allows us to show the working cpu features in /proc/cpuinfo.

>>> svm can writeback into memory at odd times if we don't do this, and the cost
> is
>>> small - clear a bit in EFER.  There's no reason to be lazy.
>>>
>>
>> Especially if we can clear that bit unconditionally (when
>> EFER is present) I'm all for it.
>>
>
> That is the case.

Cool.  I forget if we have to test for EFER on 32bit, or if we can just wrmsr
and be done with it.  Regardless that sounds easy to do on the kexec path.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
