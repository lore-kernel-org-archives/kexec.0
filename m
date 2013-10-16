Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VWFvS-0003Qp-C0
 for kexec@lists.infradead.org; Wed, 16 Oct 2013 01:29:27 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 1368E3EE0BC
 for <kexec@lists.infradead.org>; Wed, 16 Oct 2013 10:29:02 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 01B5445DEB6
 for <kexec@lists.infradead.org>; Wed, 16 Oct 2013 10:29:02 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id D339E45DEBA
 for <kexec@lists.infradead.org>; Wed, 16 Oct 2013 10:29:01 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id C7B8AE18003
 for <kexec@lists.infradead.org>; Wed, 16 Oct 2013 10:29:01 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 723D31DB803F
 for <kexec@lists.infradead.org>; Wed, 16 Oct 2013 10:29:01 +0900 (JST)
Message-ID: <525DEB54.4030401@jp.fujitsu.com>
Date: Wed, 16 Oct 2013 10:26:44 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] x86, apic: Disable BSP if boot cpu is AP
References: <20131015054214.13666.11737.stgit@localhost6.localdomain6>
 <20131015054327.13666.1689.stgit@localhost6.localdomain6>
 <20131015193049.GO31215@redhat.com>
In-Reply-To: <20131015193049.GO31215@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: fengguang.wu@intel.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bp@alien8.de, ebiederm@xmission.com, akpm@linux-foundation.org, hpa@linux.intel.com, jingbai.ma@hp.com

(2013/10/16 4:30), Vivek Goyal wrote:
> On Tue, Oct 15, 2013 at 02:43:27PM +0900, HATAYAMA Daisuke wrote:
>> Currently, on x86 architecture, if crash happens on AP in the kdump
>> 1st kernel, the 2nd kernel fails to wake up multiple CPUs. The typical
>> behaviour we actually see is immediate system reset or hang.
>>
>> This comes from the hardware specification that the processor with BSP
>> flag is jumped at BIOS init code when receiving INIT; the behaviour we
>> then see depends on the init code.
>>
>> This never happens if we use only one cpu in the 2nd kernel. So, we
>> have avoided the issue by the workaround that specifying maxcpus=1 or
>> nr_cpus=1 in kernel parameter of the 2nd kernel.
>>
>> In order to address the issue, this patch disables BSP if boot cpu is
>> an AP, and thus we don't try to wake up the BSP by sending INIT.
>>
>> Before this idea we discussed the following two ideas but we cannot
>> adopt them in each reasons:
>>
>> 1. Switch CPU from AP to BSP via IPI NMI at crash in the 1st kernel
>>
>>     This is done in the kdump crash path where logic is in inconsistent
>>     state. Any part of memory can be corrupted, including
>>     hardware-related table being accessed for example when paging is
>>     performed or interruption is performed.
>>
>> 2. Unset BSP flag of the boot cpu in the 1st kernel
>>
>>     Unsetting BSP flag can affect some real world firmware badly. For
>>     example, Ma verified that some HP systems fail to reboot under this
>>     configuration. See:
>>
>>     http://lkml.indiana.edu/hypermail/linux/kernel/1308.1/03574.html
>>
>> Due to the idea 1, we have to address the issue in the 2nd kernel on
>> AP. Then, it's impossible to know which CPU is BSP by rdmsr
>> instruction because the CPU is the one we are now trying to wake
>> up. From the same reason, it's also impossible to unset BSP flag of
>> the BSP by wrmsr instruction.
>>
>> Next, due to the idea 2, BSP is halting in the 1st kernel while
>> keeping BSP flag set (or possibly could be running somewhere in
>> catastrophic state.) In generall, CPUs except for the boot cpu in the
>> 2nd kernel -- the cpu under which crash happened --- can be thought of
>> as remaining in any inconsistent state in the 1st kernel. For APs,
>> it's possible to recover sane state by initiating INIT to them; see
>> 3.7.3 Processor-specific INIT in MultiProcessor
>> specification. However, there's no way for BSP. Therefore, there's no
>> other way to disable BSP.
>>
>> My motivation is to generate crash dump quickly on the system with
>> huge memory. We can assume such system also has a lot of N-cpus and
>> (N-1)-cpus are still available.
>>
>> To identify which CPU is BSP, we lookup ACPI table or MP table. One
>> concern is that ACPI guidlines BIOS *should* list the BSP in the first
>> MADT LAPIC entry; not *must*. In this sense, this logic relis on BIOS
>> following ACPI's guideline. On the other hand, we don't need to worry
>> about this in MP table case because it has explit BSP flag.
>>
>> To avoid any undesirable bahaviour caused by any broken BIOS that
>> doesn't conform to the guideline, it's enough to limit the number of
>> cpus to 1 by specifying maxcpu=1 or nr_cpus=1, as is currently done in
>> default kdump configuration. (But of course, it's problematic in
>> maxcpu=1 case if trying to wake up other cpus later in user space.)
>>
>> SFI and devicetree doesn't provide BSP information, so there's no
>> functionality change in their codes, only assigning false for all the
>> entries, keeping interface uniform.
>
> Hi Hatayama,
>
> So we rely on ACPI reporting BSP properly. And SFI and device tree does
> not provide BSP info. So for those cases situations where BSP is not
> reported, situaiton is little dicy. We might try to bring up those cpus
> and bring down the system.
>

Yes, I intend that. If there's no BIOS facility reporting BSP information
in the system, max_cpus=1 or nrcpus=1 should be specified just as so far.

> I am wondering if there is any attribute of cpu which we can pass to
> second kernel on command line. And tell second kernel not to bring up
> that specific cpu. (Say exclude_cpu=<cpu_attr>)? If this works, then
> if ACPI or other mechanism don't report BSP, we could possibly assume
> that cpu 0 is BSP and ask second kernel to not try to boot it.
>

I've come up with similar idea. If there's such kernel option, rest of
the processing can be implemented in user-land, i.e., get apicid of
BSP from /proc/cpuid and set it in kernel command line of 2nd kernel.
What kexec-tools should do on fedora/RHEL? Also, this idea covers SFI
and device tree.

The reason why I didn't choose such idea was first passing the value
via command-line seems rather ad-hoc. The second reason is that in any
case it's compromised design. Rigorously, we cannot get correct mapping
of apicid to {BSP, APIC} at the 1st kernel. That is, there's a class of
the bugs that affect BSP flag of each processor. For example, on
catastrophic state, all the cpus can have BSP flag on the 2nd kernel due
to wrmsr instructions generated by the bug causing crash. In this sense,
current implementation is less reliable than max_cpus=1 case.

If addressing this rigorously, for example, we need to check status of
BSP flag between 1st kernel and 2nd kernel to keep processor with BSP
flag unique, exclude cpus in catastrophic state that are not checked,
and to tell the 2nd kernel which cpu can be wake up.

This is not simple so I've avoided in current implementation.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
