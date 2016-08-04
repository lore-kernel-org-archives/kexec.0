Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bVJKo-0005t7-TP
 for kexec@lists.infradead.org; Thu, 04 Aug 2016 14:09:19 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH v2 3/3] x86/apic: Improved the setting of interrupt mode
 for bsp
References: <1469501995-2991-1-git-send-email-weijg.fnst@cn.fujitsu.com>
 <1469501995-2991-4-git-send-email-weijg.fnst@cn.fujitsu.com>
 <87k2g92gxb.fsf@x220.int.ebiederm.org>
 <1469520148.7811.54.camel@localhost>
 <87h9b3s0vr.fsf@x220.int.ebiederm.org>
 <1470305688.2274.85.camel@localhost>
Date: Thu, 04 Aug 2016 08:52:58 -0500
In-Reply-To: <1470305688.2274.85.camel@localhost> (Jiangang Wei's message of
 "Thu, 4 Aug 2016 10:17:59 +0000")
Message-ID: <871t248wud.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Wei, Jiangang" <weijg.fnst@cn.fujitsu.com>
Cc: "bhe@redhat.com" <bhe@redhat.com>, "xpang@redhat.com" <xpang@redhat.com>, "joro@8bytes.org" <joro@8bytes.org>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Cao,
 Jin" <caoj.fnst@cn.fujitsu.com>, "mingo@redhat.com" <mingo@redhat.com>, "kernel@kyup.com" <kernel@kyup.com>, "hpa@zytor.com" <hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>

"Wei, Jiangang" <weijg.fnst@cn.fujitsu.com> writes:

> Hi Eric,
>
> I have several questions about kdump and APIC mode.
> specific issues at the end of the mail.
>
> On Tue, 2016-08-02 at 09:26 -0500, Eric W. Biederman wrote:
[snip]
>> For simplicity when MP support was first added, a few parts of early
>> bootup were left handled in PC/AT compatible mode.  Mostly it is just
>> silly.
>> 
>> Unless there is a good reason I think we should strive to remove those
>> few moments when the system is using interrupts in PC/AT mode and always
>> run interrupts in the final mode we intend to run interrupts in.
>> In fact the code under acpi_gbl_reduced_hardware does that for some
>> special cases already today.
>> 
>> At the end of the day that should end up with a simpler more reliable
>> kernel.  Especially for the dump capture kernel.
>> 
>> AKA:
>> I am proposing make the code say something like:
>> 	if (pc_at_compatible_pic_mode) {
>>         	do_legacy_pic_mode();
>>         } else {
>>         	do_mp_mode();
>>         }
>> 
>> If my memory serves virtual wire mode does not need to be enabled at all
>> in mp mode, so if we are coming from mp mode (with no shutdown of the
>> apics in the first kernel).  Then there will be no information anywhere
>> about which apics need to be programmed into apic mode.
> "mp mode" you mentioned means "Symmetric I/O Mode", right ?

Yes.

>> As such to simplify the kdump process it is the wrong process to go back
>> into virtual wire PC/AT compatible pic mode.  Because once we remove the
>> code from the crashing kernel we won't have enough information to make
>> it work.  Unfortunately in some cases it is a one way transition.
>
> You ever told me that the only reason we have do any apic shutdown is
> bugs in older kernels. and looks like you're inclined to remove the
> codes used to shutdown APIC.
> That's an import start point you suggest me to enable "Symmetric I/O
> Mode" at the bootup stage of kernel, right?

Limitations in older kernels that made it very hard to initialize
Symmetric I/O mode during bootup.  So the code started by doing the
pragmatic thing.  The limitations in the older kernels that required we
transition through PIC mode on bootup appear long since gone.  But the
code in the bootup path is still doing that silly thing, and enabling
interrupts and running in PIC mode for just a moment before switching to
the final way we handle interrupts.

Except for the history that got us there it is a ludicrous way to
operation.

> but In my opinion, the kdump-capture kernel don't need to run on MP
> system, but only on BSP. generally, we use kdump with nr_cpus=1. 
> If only one cpu is enabled and used,  do we still need to set "Symmetric
> I/O Mode" for APIC ? I think the answer is no.

We still need to set "Symmetric I/O Mode"  Part of the problem is that
we can not guarantee that we are running on the BSP when we crash.  We
can not guarantee that we can switch CPUs.  Which makes anything that
explicitly requires the use of the bootstrap processor a problem.

Today the state of the code is we transition through PIC mode before
landing in "Symmetric I/O Mode".

Further the most reliable thing we can do is to disable interrupts (aka
local_irq_disable) with the APICs in "Symmetric I/O Mode" in the
crashing kernel.  Then in the kernel that is comming up we can reprogram
the APICs to be in the same mode they are already in, and then call
(local_irq_enable).

Returning to PIC mode even with a fully working kernel is a little
tricky during ordinary kexec (as not all of the information is there) I
updated the code to probe for the missing information at bootup (while
we are still in PIC mode) years ago.  So it seems to work when
everything is perfect.

We got into this entire conversation because what we are doing on the
crash shutdown epath is not enough to return us to PIC mode and allow a
kernel that assumes virtual wire mode is working to boot.  Which to me
means it is time to short circuit things and go directly to the normal
non-PIC mode and not have a detour through PIC mode of any sort during
boot of up a crash capture kernel.

> In other words, It's intended that go back into virtual wire PC/AT
> compatible pic mode by shutdown APIC.

On the kexec on panic apic shutdown path yes.  That is what the code
currently attempts to do and as demonstrated by the existence of this
thread that code is no longer good enough.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
