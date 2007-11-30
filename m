Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [2002:a646:1c45::1] (helo=ebiederm.dsl.xmission.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Ixw2R-0005Jj-Qx
	for kexec@lists.infradead.org; Fri, 30 Nov 2007 02:55:36 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] kexec: force x86_64 arches to boot kdump kernels on boot
	cpu
References: <m1y7cjkec2.fsf@ebiederm.dsl.xmission.com>
	<200711271445.56792.ak@suse.de>
	<m1lk8jka8j.fsf@ebiederm.dsl.xmission.com>
	<474C64CB.7080004@redhat.com>
	<20071127194220.GG14887@hmsendeavour.rdu.redhat.com>
	<20071127200011.GA3703@redhat.com>
	<20071127222408.GH24223@one.firstfloor.org>
	<474CA733.9050908@redhat.com> <20071128153649.GC3192@redhat.com>
	<20071128160206.GA21286@hmsendeavour.rdu.redhat.com>
	<20071128190525.GD3192@redhat.com>
	<m1d4tudun5.fsf@ebiederm.dsl.xmission.com>
	<474F7290.8010504@redhat.com>
Date: Thu, 29 Nov 2007 19:54:16 -0700
In-Reply-To: <474F7290.8010504@redhat.com> (Ben Woodard's message of "Thu, 29
	Nov 2007 18:16:48 -0800")
Message-ID: <m1sl2oa1ev.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Ben Woodard <woodard@redhat.com>
Cc: Neil Horman <nhorman@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>, hbabu@us.ibm.com, Andi Kleen <andi@firstfloor.org>, Vivek Goyal <vgoyal@redhat.com>

Ben Woodard <woodard@redhat.com> writes:

> Eric W. Biederman wrote:
>> Vivek Goyal <vgoyal@redhat.com> writes:
>>
>>> Ok. Got it. So in this case we route the interrupts directly through LAPIC
>>> and put LVT0 in ExtInt mode and IOAPIC is bypassed.
>>>
>>> I am looking at Intel Multiprocessor specification v1.4 and as per figure
>>> 3-3 on page 3-9, 8259 is connected to LINTIN0 line, which in turn is
>>> connected to LINTIN0 pin on all processors. If that is the case, even in
>>> this mode, all the CPU should see the timer interrupts (which is coming
>>> from 8259)?
>>
>> However things are implemented completely differently now.  I don't think
>> the coherent hypertransport domain of AMD processors actually routes
>> ExtINT interrupts to all cpus but instead one (the default route?) is
>> picked.
>>
>> So I think for the kdump case we pretty much need to use an IOAPIC
>> in virtual wire mode for recent AMD systems.
>>
>> For current Intel systems I believe either scenario still works.
>>
>>> Can you print the LAPIC registers (print_local_APIC) during normal boot
>>> and during kdump boot and paste here?
>>
>> It's worth a look.
>>
>> I still think we need to just use apic mode at kernel startup, and
>> be done with it.
>>
>
> Neil whipped up a patch to try this and evidently it worked on his test boxes
> but it didn't work very well on our problem tests box. It hung after the kernel
> printed "Ready". i.e. on a normal boot I get:

Interesting can you please try an early_printk console.


I expect you made it a fair ways and it just didn't show up because you didn't
get as far as the normal serial port setup.

You don't have any output from your linux kernel.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
