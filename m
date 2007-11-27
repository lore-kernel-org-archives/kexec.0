Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Ix9lu-0001Ye-4I
	for kexec@lists.infradead.org; Tue, 27 Nov 2007 23:23:24 +0000
Message-ID: <474CA733.9050908@redhat.com>
Date: Tue, 27 Nov 2007 15:24:35 -0800
From: Ben Woodard <woodard@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec: force x86_64 arches to boot kdump kernels on boot
	cpu
References: <20071127014740.GA28622@hmsreliant.think-freely.org>
	<20071127131355.GA14887@hmsendeavour.rdu.redhat.com>
	<m1y7cjkec2.fsf@ebiederm.dsl.xmission.com>
	<200711271445.56792.ak@suse.de>
	<m1lk8jka8j.fsf@ebiederm.dsl.xmission.com>
	<474C64CB.7080004@redhat.com>
	<20071127194220.GG14887@hmsendeavour.rdu.redhat.com>
	<20071127200011.GA3703@redhat.com>
	<20071127222408.GH24223@one.firstfloor.org>
In-Reply-To: <20071127222408.GH24223@one.firstfloor.org>
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
To: Andi Kleen <andi@firstfloor.org>
Cc: Neil Horman <nhorman@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>, hbabu@us.ibm.com, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

Andi Kleen wrote:
>> Are we putting the system back in PIC mode or virtual wire mode? I have
>> not seen systems which support PIC mode. All latest systems seems
>> to be having virtual wire mode. I think in case of PIC mode, interrupts
> 
> Yes it's probably virtual wire. For real PIC mode we would need really
> old systems without APIC.
> 
>> can be delivered to cpu0 only. In virt wire mode, one can program IOAPIC
>> to deliver interrupt to any of the cpus and that's what we have been
> 
> The code doesn't try to program anything specific, it just restores the state
> that was left over originally by the BIOS.
> 

So if the BIOS originally left the IOAPIC in a state where the timer 
interrupts were only going to CPU0 then by restoring that state we could 
be bringing this problem upon ourselves when we restore that state.

Would anyone have any problems with code that simply verified that the 
state which we are restoring allowed interrupts to get to the processor 
that we are currently crashing on and if not, poked in a reasonable value.

Yes this would add some complexity to the code paths where we were 
crashing but it could prevent the problem that we are seeing. It seems 
like a small fairly safe change rather than a big disruptive change like 
moving the initialization of the IOAPIC earlier in the boot process.

> -Andi


-- 
-ben
-=-

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
