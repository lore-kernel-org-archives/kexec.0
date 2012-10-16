Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TO0na-0002Rr-9q
 for kexec@lists.infradead.org; Tue, 16 Oct 2012 06:38:44 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 6AA433EE0B6
 for <kexec@lists.infradead.org>; Tue, 16 Oct 2012 15:38:36 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 5257245DEBC
 for <kexec@lists.infradead.org>; Tue, 16 Oct 2012 15:38:36 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 2FC8745DEB6
 for <kexec@lists.infradead.org>; Tue, 16 Oct 2012 15:38:36 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 226E31DB8040
 for <kexec@lists.infradead.org>; Tue, 16 Oct 2012 15:38:36 +0900 (JST)
Received: from m024.s.css.fujitsu.com (m024.s.css.fujitsu.com [10.0.81.64])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id CC3CF1DB803B
 for <kexec@lists.infradead.org>; Tue, 16 Oct 2012 15:38:35 +0900 (JST)
Date: Tue, 16 Oct 2012 15:38:17 +0900 (JST)
Message-Id: <20121016.153817.42643171.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH v1 0/2] x86, apic: Disable BSP if boot cpu is AP
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <3E5A0FA7E9CA944F9D5414FEC6C7122030B0DD91@ORSMSX105.amr.corp.intel.com>
References: <3E5A0FA7E9CA944F9D5414FEC6C7122030B0DD68@ORSMSX105.amr.corp.intel.com>
 <20121016.140313.279437418.d.hatayama@jp.fujitsu.com>
 <3E5A0FA7E9CA944F9D5414FEC6C7122030B0DD91@ORSMSX105.amr.corp.intel.com>
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
To: fenghua.yu@intel.com
Cc: len.brown@intel.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, grant.likely@secretlab.ca, ebiederm@xmission.com, hpa@zytor.com, mingo@elte.hu, tglx@linutronix.de, vgoyal@redhat.com

From: "Yu, Fenghua" <fenghua.yu@intel.com>
Subject: RE: [PATCH v1 0/2] x86, apic: Disable BSP if boot cpu is AP
Date: Tue, 16 Oct 2012 05:14:46 +0000

>> >> My motivation is to use multiple CPUs in order to quickly generate
>> >> crash dump on the machine with huge amount of memory. I assume such
>> >> machine tends to also have a lot of CPUs. So disabling one CPU would
>> >> be no problem.
>> >
>> > Luckily you don't need to disable any CPU to archive your goal with
>> > the BSP hotplug pachest:)
>> >
>> > On a dual core/single thread machine, this means you get 100%
>> performance
>> > boost with BSP's help.
>> >
>> > Plus crash dump kernel code is better structured by not treating BSP
>> > specially.
>> >
>> 
>> Hello Fenghua.
>> 
>> I've of course noticed your patch set and locally tested, but I saw
>> NMI to BSP failed in the 2nd kernel. I'll send a log to you later.
>> 
>> BTW, I tested with your previous v8 patch set. Did you change
>> something during v8 to v9 relevant to this issue?
> 
> In the patch 0/12 in v9, I describe what change is in v9 on the top of v8:
> 
> v9: Add Intel vendor check to support the feature on Intel platforms only.
> 
> Did you see the BSP wake up failure on the latest tip tree?
> 
> There is a rcu regression issue which prevents BSP from waking up in 3.6.0.
> The issue has been fixed on 10/12. The commit is a4fbe35a. Please make sure
> your tip tree has this commit.
> 

Thanks for pointing out this. And I've recalled my investigation in
the past now. So I want to stop retrying your patch v9 now. This NMI
method is definitely not applicable to 2nd kernel without any change.

Your NMI method assumes BSP thread is halting in play dead loop. But
on the 2nd kernel, BSP is halting in the 1st kernel (or possibly in a
fatail system error). Even if throwing NMI to BSP, it goes back to the
1st kernel soon again. I at least confirmed NMI handler is executed in
this case.

Also, throwing NMI changes stack in the 1st kernel, which is
unpermissible from kdump's perspective. But x86_64 uses Interrupt
Stack Table (IST), in which stack switching is not performed. So 2nd
kernel's stack is used at least on x86_64.

To sum up, to apply NMI method in the 2nd kernel, I think it necessary
to modify contexts pushed on the stack so execution goes to the 2nd
kernel's start_secondary() while initializing its state
appropreately.

Also I think it necessary to discuss whether this NMI method is
reliable enough for kdump use.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
