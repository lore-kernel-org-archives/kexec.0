Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TNzKf-0004CB-4m
 for kexec@lists.infradead.org; Tue, 16 Oct 2012 05:04:46 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 23E0C3EE0AE
 for <kexec@lists.infradead.org>; Tue, 16 Oct 2012 14:04:43 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 06C8445DE59
 for <kexec@lists.infradead.org>; Tue, 16 Oct 2012 14:04:43 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id D819E45DE56
 for <kexec@lists.infradead.org>; Tue, 16 Oct 2012 14:04:42 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id C8E5C1DB8047
 for <kexec@lists.infradead.org>; Tue, 16 Oct 2012 14:04:42 +0900 (JST)
Received: from m020.s.css.fujitsu.com (m020.s.css.fujitsu.com [10.0.81.60])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 778AE1DB803C
 for <kexec@lists.infradead.org>; Tue, 16 Oct 2012 14:04:42 +0900 (JST)
Date: Tue, 16 Oct 2012 14:03:13 +0900 (JST)
Message-Id: <20121016.140313.279437418.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH v1 0/2] x86, apic: Disable BSP if boot cpu is AP
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <3E5A0FA7E9CA944F9D5414FEC6C7122030B0DD68@ORSMSX105.amr.corp.intel.com>
References: <20121016043357.20003.5885.stgit@localhost6.localdomain6>
 <3E5A0FA7E9CA944F9D5414FEC6C7122030B0DD68@ORSMSX105.amr.corp.intel.com>
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
Date: Tue, 16 Oct 2012 04:51:36 +0000

>> -----Original Message-----
>> From: HATAYAMA Daisuke [mailto:d.hatayama@jp.fujitsu.com]
>> Sent: Monday, October 15, 2012 9:35 PM
>> To: linux-kernel@vger.kernel.org; kexec@lists.infradead.org;
>> x86@kernel.org
>> Cc: mingo@elte.hu; tglx@linutronix.de; hpa@zytor.com; Brown, Len; Yu,
>> Fenghua; vgoyal@redhat.com; ebiederm@xmission.com;
>> grant.likely@secretlab.ca; rob.herring@calxeda.com;
>> d.hatayama@jp.fujitsu.com
>> Subject: [PATCH v1 0/2] x86, apic: Disable BSP if boot cpu is AP
>> 
>> Multiple CPUs are useful for CPU-bound processing like compression and
>> I do want to use compression to generate crash dump quickly. But now
>> we cannot wakeup the 2nd and later cpus in the kdump 2nd kernel if
>> crash happens on AP. If crash happens on AP, kexec enters the 2nd
>> kernel with the AP, and there BSP in the 1st kernel is expected to be
>> haling in the 1st kernel or possibly in any fatal system error state.
>> 
>> To wake up AP, we use the method called INIT-INIT-SIPI. INIT causes
>> BSP to jump into BIOS init code. A typical visible behaviour is hang
>> or immediate reset, depending on the BIOS init code.
>> 
>> AP can be initiated by INIT even in a fatal state: MP spec explains
>> that processor-specific INIT can be used to recover AP from a fatal
>> system error. On the other hand, there's no method for BSP to recover;
>> it might be possible to do so by NMI plus any hand-coded reset code
>> that is carefully designed, but at least I have no idea in this
>> direction now.
> 
> In my BSP hotplug patchset, BPS is waken up by NMI. The patchset is
> not in tip tree yet.
> 
> BSP hotplug patchset can be found at https://lkml.org/lkml/2012/10/12/336
> 
>> 
>> Therefore, the idea I do in this patch set is simply to disable BSP if
>> vboot cpu is AP.
>> 
> 
> The BSP hotplug patchset will be useful for you goal. With the BSP hotplug
> patcheset, you can wake up BSP and don't need to disable it.
> 
>> My motivation is to use multiple CPUs in order to quickly generate
>> crash dump on the machine with huge amount of memory. I assume such
>> machine tends to also have a lot of CPUs. So disabling one CPU would
>> be no problem.
> 
> Luckily you don't need to disable any CPU to archive your goal with
> the BSP hotplug pachest:)
> 
> On a dual core/single thread machine, this means you get 100% performance
> boost with BSP's help.
> 
> Plus crash dump kernel code is better structured by not treating BSP
> specially.
> 

Hello Fenghua.

I've of course noticed your patch set and locally tested, but I saw
NMI to BSP failed in the 2nd kernel. I'll send a log to you later.

BTW, I tested with your previous v8 patch set. Did you change
something during v8 to v9 relevant to this issue?

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
