Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vaxcm-0004KT-UN
 for kexec@lists.infradead.org; Tue, 29 Oct 2013 00:57:38 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 378FD3EE127
 for <kexec@lists.infradead.org>; Tue, 29 Oct 2013 09:57:01 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 28F2145DE4E
 for <kexec@lists.infradead.org>; Tue, 29 Oct 2013 09:57:01 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 061DD45DD78
 for <kexec@lists.infradead.org>; Tue, 29 Oct 2013 09:57:01 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id EEE4A1DB803A
 for <kexec@lists.infradead.org>; Tue, 29 Oct 2013 09:57:00 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 94E7F1DB802C
 for <kexec@lists.infradead.org>; Tue, 29 Oct 2013 09:57:00 +0900 (JST)
Message-ID: <526F0725.2000906@jp.fujitsu.com>
Date: Tue, 29 Oct 2013 09:53:57 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/3] x86, apic, kexec: Add disable_cpu_apic kernel
 parameter
References: <20131022150015.24240.39686.stgit@localhost6.localdomain6>
 <20131022220803.GA32387@anatevka.fc.hp.com> <526712B2.7070108@jp.fujitsu.com>
 <20131023155127.GA17437@redhat.com> <52687AF4.5090404@jp.fujitsu.com>
 <20131025130514.64a47214@hananiah.suse.cz>
In-Reply-To: <20131025130514.64a47214@hananiah.suse.cz>
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
To: Petr Tesarik <ptesarik@suse.cz>, kexec@lists.infradead.org

(2013/10/25 20:05), Petr Tesarik wrote:
> On Thu, 24 Oct 2013 10:42:12 +0900
> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
>
>> (2013/10/24 0:51), Vivek Goyal wrote:
>>> On Wed, Oct 23, 2013 at 09:05:06AM +0900, HATAYAMA Daisuke wrote:
>>>
>>> [..]
>>>>> Do you literally mean a human at each boot will have to configure
>>>>> the kdump configuration files for passing disable_cpu_apic?
>>>>> Or do you envision the setting of disable_cpu_apic being put into
>>>>> the kdump initialization scripts?
>>>>>
>>>>> thanks
>>>>>
>>>>> Jerry
>>>>
>>>> Nearer to the former case, but this is not what a human should do. It's
>>>> a cumbersome task. I think, on fedora/RHEL system for example, kdump
>>>> service should check at each boot automatically.
>>>
>>> Hi Hatayama,
>>>
>>> So what information should I look for to prepare disable_cpu_apic=X in
>>> kdump script?
>>>
>>> Is BSP processor info exported to user space somewhere? Or assuming that
>>> processor 0 is BSP and corresponding apicid should be disabled in kdump
>>> kernel is good enough?
>>>
>>
>> Yes, this patch set assumes that the processor 0 is BSP and there's no
>> other BSP. Because this patch cares about only one BSP processor,
>> the disabled_cpu_apicid variable has unsigned int, not mask.
>>
>> I think this assumption is reasonable since doing it rigorously requires
>> additional processing between 1st and 2nd kernels just as I explained in
>> previous mail.
>>
>>> I am looking at /proc/cpuinfo and following 3 fields seem interesting.
>>>
>>> processor: 0
>>> apicid		: 0
>>> initial apicid	: 0
>>>
>>> What's the difference between apicid and "initial apicid". I guess
>>> initial apicid reflects the apicid number as set by firmware and then
>>> kernel can overwrite it and new number would be reflected in "apicid"?
>>>
>>> If that's the case, then I guess we should be looking at "apicid" of
>>> processor "0" and set that in disable_cpu_apic? Because that's the
>>> number kdump kernel  boot should see in apic upon boot.
>>>
>>
>> Yes, that's fully correct, and please see 10.4.6 Local APIC ID in Intel SPG
>> for details.
>>
>> BTW, we can use cpuid instruction in user-space, too. It might be more
>> flexible to use cpuid than looking up /proc/cpuinfo.
>>
>> Also, there's one corner case that if we hot-remove cpu0, we cannot
>> look up /proc/cpuinfo to get cpu0 information since /proc/cpunifo displays
>> *online* cpus only. We cannot use even cpuid instruction for offline cpu.
>> So, to address this corner case, we need to prepare new interface to see
>> cpu0 initial apicid which is always available.
>>
>> My idea is for example to introduce the following file in sysfs:
>>
>>     /sys/devices/system/cpu/cpu0/initial_apicid
>
> I'm confused. So, should I look at the "initial apicid" line, or the
> "apicid" line in /proc/cpuinfo? Your previous mail suggested the
> "apicid" line, but then it's confusing to call the sysfs file
> "initial_apicid".
>

You should look at initial apicid. Initial apicid is the value assigned
during MP initialization and their values are unique while the values on
local APIC ID registers vary at runtime.

If you say "apicid" line about ones in ACPI MADT or MP table, they are
initial ones, although there's explicit "initial".

> Unfortunately, all my systems list the same value under "apicid" and
> "initial apicid", so I don't know how to test.

You don't need to compare two kind of values at all. You have only to use
initial apicid to identify target cpu beyond different component: BIOS,
1st kernel and 2nd kernel.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
