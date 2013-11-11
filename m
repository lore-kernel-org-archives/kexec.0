Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VfjTq-0004Yq-O8
 for kexec@lists.infradead.org; Mon, 11 Nov 2013 04:52:09 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 27E583EE15A
 for <kexec@lists.infradead.org>; Mon, 11 Nov 2013 13:51:41 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 14FB645DE6A
 for <kexec@lists.infradead.org>; Mon, 11 Nov 2013 13:51:41 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.nic.fujitsu.com [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id E6D1C45DE54
 for <kexec@lists.infradead.org>; Mon, 11 Nov 2013 13:51:40 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id D725A1DB8049
 for <kexec@lists.infradead.org>; Mon, 11 Nov 2013 13:51:40 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 767931DB8044
 for <kexec@lists.infradead.org>; Mon, 11 Nov 2013 13:51:40 +0900 (JST)
Message-ID: <528061E5.7010903@jp.fujitsu.com>
Date: Mon, 11 Nov 2013 13:49:41 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/3] x86, apic, kexec: Add disable_cpu_apic kernel
 parameter
References: <20131022150015.24240.39686.stgit@localhost6.localdomain6>
 <20131106190232.GA28119@anatevka.fc.hp.com>
In-Reply-To: <20131106190232.GA28119@anatevka.fc.hp.com>
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
To: jerry.hoemann@hp.com
Cc: fengguang.wu@intel.com, jingbai.ma@hp.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bp@alien8.de, ebiederm@xmission.com, akpm@linux-foundation.org, hpa@linux.intel.com, vgoyal@redhat.com

(2013/11/07 4:02), jerry.hoemann@hp.com wrote:
> On Wed, Oct 23, 2013 at 12:01:18AM +0900, HATAYAMA Daisuke wrote:
>> This patch set is to allow kdump 2nd kernel to wake up multiple CPUs
>> even if 1st kernel crashs on some AP, a continueing work from:
>>
>>    [PATCH v3 0/2] x86, apic, kdump: Disable BSP if boot cpu is AP
>>    https://lkml.org/lkml/2013/10/16/300.
>>
>> In this version, basic design has changed. Now users need to figure
>> out initial APIC ID of BSP in the 1st kernel and configures kernel
>> parameter for the 2nd kernel manually using disable_cpu_apic kernel
>> parameter to be newly introduced in this patch set. This design is
>> more flexible than the previous version in that we no longer have to
>> rely on ACPI/MP table to get initial APIC ID of BSP.
>>
>> Sorry, this patch set have not include in-source documentation
>> requested by Borislav Petkov yet, but I'll post it later separately,
>> which would be better to focus on documentation reviewing.
>>
>> ChangeLog
>>
>> v3 => v4)
>>
>> - Rebased on top of v3.12-rc6
>>
>> - Basic design has been changed. Now users need to figure out initial
>>    APIC ID of BSP in the 1st kernel and configures kernel parameter for
>>    the 2nd kernel manually using disable_cpu_apic kernel parameter to
>>    be newly introduced in this patch set. This design is more flexible
>>    than the previous version in that we no longer have to rely on
>>    ACPI/MP table to get initial APIC ID of BSP.
>>
>
>
> Daisuke,
>
> I have back ported version 4 of this patch to both a 2.6.32 and 3.0.80
> based kernels and distros and tested on a prototype system.  I have
> previously test version 1 & 3 as well.)
>
> The systems are configured to boot the capture kernel 8-way parallel.
> However, I am running makedumpfile single threaded.
>
> Panic is induced via "echo c > /proc/sysrq-trigger".  This is done
> under various system loads and on random cpus.  I have done over a
> thousand dumps total during this testing.
>

Thanks for your testing.

> I have seen no issues w/ the 3.0.80 dump testing on our proto.
>
> On the 2.6.32 testing on our proto, i have hit a low probability (< 5%)
> chance of the capture suffering a soft lockup hang during
> "Switching to clocksource hpet."  I have not RCA'd this yet.
> Note, I have seen this issue on earlier version of the patch, so
> it is not specific to this version.
>
> I then tested the 2.6.32 port on a dl380.  This worked without issue.
>
> Note, I have seen no issues related to this patch on our proto when
> booting the capture with a single processor.
>
> While I am still pursuing the issue of the 2.6.32 kernel on our proto,
> I believe this patch is good and should be accepted.
>

This seems there's something that depends on the system you used. But I
have never verified my patch set on 2.6.32-based kernel. I'll try to
do a similar test on some FJ systems.

The 2.6.32-based kernel you mean is one of the Longterm release kernels,
right? So, you used on the test the 2.6.32-based Longterm release kernel
with my v4 patch, right?

The root cause seems to have already been fixed on recent kernel since
you didn't see the bug on 3.0.80-based kernel, so I think binary search
would be useful.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
