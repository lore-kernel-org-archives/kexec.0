Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Ix9dM-0000v6-Mm
	for kexec@lists.infradead.org; Tue, 27 Nov 2007 23:14:35 +0000
Message-ID: <474CA520.60804@redhat.com>
Date: Tue, 27 Nov 2007 15:15:44 -0800
From: Ben Woodard <woodard@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec: force x86_64 arches to boot kdump kernels on boot
	cpu
References: <20071127014740.GA28622@hmsreliant.think-freely.org>	<200711271445.56792.ak@suse.de>	<20071127142826.GB31376@hmsreliant.think-freely.org>	<200711271543.11809.ak@suse.de>	<20071127144856.GC31376@hmsreliant.think-freely.org>	<m14pf7k8ns.fsf@ebiederm.dsl.xmission.com>	<474C832C.1060903@redhat.com>	<20071127210558.GI14887@hmsendeavour.rdu.redhat.com>
	<m1r6ibia9v.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1r6ibia9v.fsf@ebiederm.dsl.xmission.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Neil Horman <nhorman@redhat.com>, Neil Horman <nhorman@tuxdriver.com>, kexec@lists.infradead.org, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, vgoyal@in.ibm.com

Eric W. Biederman wrote:
> Neil Horman <nhorman@redhat.com> writes:
> 
>>> ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
> 
> Ben, what chipset is this?

nVidia MCP55 pro

It is the original version of 
http://www.supermicro.com/Aplus/motherboard/Opteron8000/MCP55/H8QM8-2.cfm

i.e. not the -2. However, they don't seem to advertise the original 
version. Supermicro assures me that they are practically the same but I 
haven't played with the -2 version yet.


> 
>> Ok, I think from what I understand of what we're reading here, the apic2 = -1
>> and pin2 = -1 indicate that the 8259 has no direct connection to any cpu, which
>> means that on shutdown disable_IO_APIC should take us into virtual wire mode.
>> As such enabling the APIC early in boot should fix us, but more consisely,
>> rewriting the entry in the IOAPIC to deliver int0 to the only running cpu should
>> accomplish the same goal for this problem.  Does that sound reasonable (at least
>> as a test to ensure we understand the problem) to everyone?
> 
> Close.  There are two options with virtual wire mode.  
> - Either the local apic is in virtual wire mode, and somehow the
>   legacy interrupts make it to the local cpu.
> - Or an ioapic is in virtual wire mode and the legacy interrupt
>   controller is connected to it.
> 
> So I guess fundamentally for any SMP system that only supports the
> cpu being in local apic mode and only routes interrupts to the boot
> strap processor we could be in trouble.  That is what our current
> information about your system suggests.
> 
> However most systems actually connect the i8254 PIC interrupt
> controller to the ioapic in virtual wire mode.  As I recall the
> standard mapping is to ioapic 0, pin 0.  With ioapic 0, pin 2 being
> the timer interrupt (Possibly it is the other way around).
> 
> So as a test we could feed those values into ioapic_8259 and see
> if the kdump case works.  I believe we prefer putting the ioapic
> into virtual wire mode over putting the cpu into virtual wire
> mode.  We can only control which cpu receives the legacy interrupts if
> we are putting the ioapic in virtual wire mode.
> 
> It may also be an interesting test to just enable the timer for the
> ioapic in early boot, as you have suggested.  I don't have a clue what
> that will do.
> 
> Eric
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec


-- 
-ben
-=-

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
