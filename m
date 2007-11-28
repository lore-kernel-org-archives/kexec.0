Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1IxOy6-0005Ur-Nd
	for kexec@lists.infradead.org; Wed, 28 Nov 2007 15:37:00 +0000
Date: Wed, 28 Nov 2007 10:36:49 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] kexec: force x86_64 arches to boot kdump kernels on
	boot cpu
Message-ID: <20071128153649.GC3192@redhat.com>
References: <20071127014740.GA28622@hmsreliant.think-freely.org>
	<20071127131355.GA14887@hmsendeavour.rdu.redhat.com>
	<m1y7cjkec2.fsf@ebiederm.dsl.xmission.com>
	<200711271445.56792.ak@suse.de>
	<m1lk8jka8j.fsf@ebiederm.dsl.xmission.com>
	<474C64CB.7080004@redhat.com>
	<20071127194220.GG14887@hmsendeavour.rdu.redhat.com>
	<20071127200011.GA3703@redhat.com>
	<20071127222408.GH24223@one.firstfloor.org>
	<474CA733.9050908@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <474CA733.9050908@redhat.com>
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
Cc: Neil Horman <nhorman@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>, hbabu@us.ibm.com, Andi Kleen <andi@firstfloor.org>, "Eric W. Biederman" <ebiederm@xmission.com>

On Tue, Nov 27, 2007 at 03:24:35PM -0800, Ben Woodard wrote:
> Andi Kleen wrote:
>>> Are we putting the system back in PIC mode or virtual wire mode? I have
>>> not seen systems which support PIC mode. All latest systems seems
>>> to be having virtual wire mode. I think in case of PIC mode, interrupts
>>
>> Yes it's probably virtual wire. For real PIC mode we would need really
>> old systems without APIC.
>>
>>> can be delivered to cpu0 only. In virt wire mode, one can program IOAPIC
>>> to deliver interrupt to any of the cpus and that's what we have been
>>
>> The code doesn't try to program anything specific, it just restores the state
>> that was left over originally by the BIOS.
>>
>
> So if the BIOS originally left the IOAPIC in a state where the timer 
> interrupts were only going to CPU0 then by restoring that state we could be 
> bringing this problem upon ourselves when we restore that state.
>

Hi Ben,

Apart from restoring the original state (Bring APICS back to virtual wire
mode), we also reprogram IOAPIC so that timer interrupt can go to crashing
cpu (and not necessarily cpu0). Look at following code in disable_IO_APIC.

                entry.dest.physical.physical_dest =
                                        GET_APIC_ID(apic_read(APIC_ID));

Here we read the apic id of crashing cpu and program IOAPIC accordingly.
This will make sure that even in virtual wire mode, timer interrupts
will be delivered to crashing cpu APIC.

I think we need to go deeper and compare the state of system (APICS,
timer etc) during normal boot and kdump boot and see where is the
difference. This is how I solved some of the timer interrupt related
issues in the past.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
