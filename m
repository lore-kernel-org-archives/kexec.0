Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RzLdW-0002ba-OA
 for kexec@lists.infradead.org; Mon, 20 Feb 2012 05:18:09 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 135793EE0B5
 for <kexec@lists.infradead.org>; Mon, 20 Feb 2012 14:18:00 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id EB0F045DE58
 for <kexec@lists.infradead.org>; Mon, 20 Feb 2012 14:17:59 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id C4E6445DE56
 for <kexec@lists.infradead.org>; Mon, 20 Feb 2012 14:17:59 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id B07211DB8044
 for <kexec@lists.infradead.org>; Mon, 20 Feb 2012 14:17:59 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 4680D1DB8052
 for <kexec@lists.infradead.org>; Mon, 20 Feb 2012 14:17:59 +0900 (JST)
Date: Mon, 20 Feb 2012 14:17:33 +0900 (   )
Message-Id: <20120220.141733.294710222.d.hatayama@jp.fujitsu.com>
Subject: Re: [tip:x86/debug] x86/kdump: No need to disable ioapic/ lapic in
 crash path
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20120217201842.GP9751@redhat.com>
References: <m1fwe9bpk2.fsf@fess.ebiederm.org>
 <CABOkKT21zhyMwMmbR9WTipk5e=y_qMZ8ByG=njatjKbFLZW+xQ@mail.gmail.com>
 <20120217201842.GP9751@redhat.com>
Mime-Version: 1.0
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
To: dzickus@redhat.com
Cc: linux-tip-commits@vger.kernel.org, yinghai@kernel.org, mingo@elte.hu, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, ebiederm@xmission.com, hpa@zytor.com, akpm@linux-foundation.org, torvalds@linux-foundation.org, tglx@linutronix.de, vgoyal@redhat.com

From: Don Zickus <dzickus@redhat.com>
Subject: Re: [tip:x86/debug] x86/kdump: No need to disable ioapic/ lapic in crash path
Date: Fri, 17 Feb 2012 15:18:42 -0500

> On Sat, Feb 18, 2012 at 12:49:16AM +0900, HATAYAMA Daisuke wrote:
>> A few days ago I investigted the case where system is reseted due to
>> triple fault caused by the NMI after idt is disabled in
>> machine_kexec. I didn't see the reset when trigering the kdump with
>> NMI since the NMI is masked until next iret instruction executed as
>> described in 6.7.2. Handling Multiple NMIs of Intel Manual Vol.3A.
>> The NMI mask remains untill the first iret execution on the 2nd
>> kernel: just the return path of the first kernel_thread invocation for
>> init process. The exact path is:
> 
> hmm.  So even though the local apic was disabled you still got an NMI?
> That could have been from an external NMI.  I forget how that is wired up,
> if it goes through the IOAPIC to the Local APIC or directly to the NMI pin
> on the cpu.
> 

Please don't confused. I used RHEL kernels based on 2.6.18 and
2.6.32. I didn't use the patch disabling local apic.

>> 
>>   switch_to
>>   -> ret_from_fork
>>      -> int_ret_from_sys_call
>>         -> retint_restore_args
>>            -> irq_return
>> 
>> At that phase idt is already set up and kdump works.
>> 
>> From the discussion I interpret kdump doesn't assume this behaviour,
>> right?
> 
> probably not.
> 

Thanks.

>> 
>> BTW, does anyone know the detail of the NMI mask? I couldn't figure
>> out about it from the Intel spec more than ``certain hardware
>> conditions''... I expect those who look at here are x86 NMI experts.
> 
> I don't understand the question.
> 
> Cheers,
> Don
> 

Fig 10-4 explaining Local APIC Structure says INIT/NMI/SMI are
directly sent to CPU Core, but the later part of this route is not
explained formally anyware. Only the explanation is the sentence in
6.7 Nonmaskable Interrupt (NMI):

  The processor also invokes certain hardware conditions to insure
  that no other interrupts, including NMI interrupts, are received
  until the NMI handler has completed executing.

I'm just wondering if this is explained more formally anyware.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
