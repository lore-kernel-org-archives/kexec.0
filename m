Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VbSRK-0001pM-Ac
 for kexec@lists.infradead.org; Wed, 30 Oct 2013 09:51:51 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id E17283EE127
 for <kexec@lists.infradead.org>; Wed, 30 Oct 2013 18:51:19 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id CDC1245DE56
 for <kexec@lists.infradead.org>; Wed, 30 Oct 2013 18:51:19 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id B208A45DE51
 for <kexec@lists.infradead.org>; Wed, 30 Oct 2013 18:51:19 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id A393E1DB8041
 for <kexec@lists.infradead.org>; Wed, 30 Oct 2013 18:51:19 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 4C2A41DB803E
 for <kexec@lists.infradead.org>; Wed, 30 Oct 2013 18:51:19 +0900 (JST)
Message-ID: <5270D604.9020409@jp.fujitsu.com>
Date: Wed, 30 Oct 2013 18:48:52 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/3] x86, apic, kexec: Add disable_cpu_apic kernel
 parameter
References: <20131022150015.24240.39686.stgit@localhost6.localdomain6>
 <20131029142151.GA2782@dhcp-16-105.nay.redhat.com>
 <5270567D.8000706@jp.fujitsu.com>
 <20131030060643.GA24866@dhcp-16-105.nay.redhat.com>
In-Reply-To: <20131030060643.GA24866@dhcp-16-105.nay.redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Baoquan He <bhe@redhat.com>
Cc: hpa@linux.intel.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com, bp@alien8.de, ebiederm@xmission.com, akpm@linux-foundation.org, fengguang.wu@intel.com, jingbai.ma@hp.com

(2013/10/30 15:06), Baoquan He wrote:
> On 10/30/13 at 09:44am, HATAYAMA Daisuke wrote:
>> (2013/10/29 23:21), Baoquan He wrote:
>>> Hi,
>>>
>>> I am reviewing this patchset, and found there's a cpu0 hotplug feature
>>> posted by intel which we can borrow an idea from. In that implementation,
>>> CPU0 is waken up by nmi not INIT to avoid the realmode bootstrap code
>>> execution. I tried it by below patch which includes one line of change.
>>>
>>> By console printing, I got the boot cpu is always 0(namely cpu=0),
>>> however the apicid related to each processor keeps the same as in 1st
>>> kernel. In my HP Z420 machine, the apicid for BSP is 0, so I just make a
>>> test patch which depends on the fact that apicid for BSP is 0. Maybe
>>> generally the apicid for BSP can't be guaranteed, then passing it from
>>> 1st kernel to 2nd kernel in cmdline is very helpful, just as you have
>>> done for disable_cpu_apic.
>>>
>>> On my HP z420, I add nr_cpus=4 in /etc/sysconfig/kdump, and then execute
>>> below command, then 3 APs (1 boot cpu and 2 AP) can be waken up
>>> correctly, but BSP failed because NMI received for unknown reason 21 on
>>> CPU0. I think I need further check why BSP failed to wake up by nmi. But
>>> 3 processors are brought up successfully and kdump is successful too.
>>>
>>> sudo taskset -c 1 sh -c "echo c >/proc/sysrq-trigger"
>>>
>>> [    0.296831] smpboot: Booting Node   0, Processors  #   1
>>> [    0.302095]
>>> *****************************************************cpu=1, apicid=0, wakeup_cpu_via_init_nmi
>>> [    0.311942] cpu=1, apicid=0, register_nmi_handlercpu=1, apicid=0, wakeup_secondary_cpu_via_nmi
>>> [    0.320826] Uhhuh. NMI received for unknown reason 21 on CPU 0.
>>> [    0.327129] Do you have a strange power saving mode enabled?
>>> [    0.333858] Dazed and confused, but trying to continue
>>> [    0.339290] cpu=1, apicid=0, wakeup_cpu_via_init_nmi
>>> [    2.409099] Uhhuh. NMI received for unknown reason 21 on CPU 0.
>>> [    2.415393] Do you have a strange power saving mode enabled?
>>> [    2.421142] Dazed and confused, but trying to continue
>>> [    5.379519] smpboot: CPU1: Not responding
>>> [    5.383692] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
>>>
>>
>> We've already discussed this approach and concluded this is not applicable
>> to our issue.
>> Follow http://lists.infradead.org/pipermail/kexec/2012-October/006905.html.
>>
>> The reason is:
>>
>> - The cpu0-hotplugging approach assumes BSP to be halting before initiating
>>    NMI to it while in our case, BSP is halting in the 1st kernel or is
>>    running in arbitrary position of the 1st kernel in catastrophic state.
>>
>> - In general, NMI modifies stack, which means if throwing NMI to the BSP
>>    in the 1st kernel, stack on the 1st kernel is modified. It's unpermissible
>>    from kdump's perspective.
>
> Hi HATAYAMA,
>
> All right. I didn't think of the stack issues NMI will bring. In fact
> without this NMI stack problem, using CPU0 Hotplug as a base and sending
> nmi to bsp will be good, because BSP failure can be acceptable, then
> (N-1)cpus can be used. Later on if possible the contexts modifying can
> be changed to let BSP wake up correctly. After all, from the user's
> point of view, multiple cpus can be waken up, why not waking up all cpus
> including BSP.
>
> Anyway, this issue has been discussed so long time, and it will be great
> to run multiple cpus in 2nd kernel. This evolution may be like CPU0 Hotplug,
> they let cpus except of BSP hot plug available, then hanle the last cpu -
> the BSP finally. From this perspective, I like your patch and hope it
> can be merged asap.
>

Considering again, I'm now beginning with thinking that making CPU halting
in the 1st kernel to execute the 2nd kernel's NMI handler is impossible.

The address of IDT is saved in IDTR and this is a per-cpu register, and
value of IDTR in the 2nd kernel and the one in the 1st kernel are different.
In other words, to wake up BSP from 2nd kernel using NMI, it's necessary to
tell the address of IDTR in the 2nd kernel to the BSP halting in the 1st
kernel.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
