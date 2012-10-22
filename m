Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TQOev-0005Jc-JM
 for kexec@lists.infradead.org; Mon, 22 Oct 2012 20:31:39 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20121016043357.20003.5885.stgit@localhost6.localdomain6>
 <20121016043528.20003.601.stgit@localhost6.localdomain6>
 <873916i88t.fsf@xmission.com> <5085A9A8.5020004@zytor.com>
Date: Mon, 22 Oct 2012 13:31:27 -0700
In-Reply-To: <5085A9A8.5020004@zytor.com> (H. Peter Anvin's message of "Mon,
 22 Oct 2012 13:16:40 -0700")
Message-ID: <87fw56fduo.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH v1 2/2] x86, apic: Disable BSP if boot cpu is AP
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: len.brown@intel.com, fenghua.yu@intel.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, grant.likely@secretlab.ca, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, tglx@linutronix.de, mingo@elte.hu, vgoyal@redhat.com

"H. Peter Anvin" <hpa@zytor.com> writes:

> On 10/22/2012 01:04 PM, Eric W. Biederman wrote:
>> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> writes:
>> 
>>> We disable BSP if boot cpu is AP.
>>>
>>> INIT-INIT-SIPI sequence, a protocal to initiate AP, cannot be used for
>>> BSP since it causes BSP jump to BIOS init code; typical visible
>>> behaviour is hang or immediate reset, depending on the BIOS init code.
>>>
>>> INIT can be used to reset AP in a fatal system error state as
>>> described in MP spec 3.7.3 Processor-specific INIT. In contrast, there
>>> is no processor-specific INIT for BSP to initilize from a fatal system
>>> error. It might be possible to do so by NMI plus any hand-crafted
>>> reset code that is carefully designed, but at least I have no idea in
>>> this direction now.
>> 
>> Has anyone looked at clearing bit 8 of the IA32_APIC_BASE_MSR (0x1B) on
>> the bootstrap processor?  Bit 8 being the bit that indicates we are a
>> bootstrap processor.
>> 
>> If we can clear that bit INIT will always place the processor in
>> wait-for-startup-ipi mode and we won't have this problem.
>> 
>> That would also solve the hotunplug the bootstrap processor without
>> using an NMI as well.
>> 
>
> IIRC Fenghua experimented with that and it didn't work.  Not all BIOSes
> use that bit to determine BSP-ness.

What does a BIOS have to do with anything?

The practical issue here is does an INIT IPI cause the cpu to go into
startup-ipi-wait or to start booting at 4G-16 bytes.

For dealing with BIOSen we may still need to use the bootstrap processor
for firmware calls, cpu suspend, and other firmware weirdness, but that
should all be completely orthogonal to the behavior to what happens
when an INIT IPI is sent to the cpu.

The only firmware problem I can imagine having is cpu virtualization
bug.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
