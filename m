Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VZ9y3-0003Pn-5i
 for kexec@lists.infradead.org; Thu, 24 Oct 2013 01:44:08 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 5F49E3EE1CD
 for <kexec@lists.infradead.org>; Thu, 24 Oct 2013 10:43:33 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 4E31945DEBE
 for <kexec@lists.infradead.org>; Thu, 24 Oct 2013 10:43:33 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 2BA7B45DEB6
 for <kexec@lists.infradead.org>; Thu, 24 Oct 2013 10:43:33 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 1EF1DE18003
 for <kexec@lists.infradead.org>; Thu, 24 Oct 2013 10:43:33 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id B3D8B1DB803C
 for <kexec@lists.infradead.org>; Thu, 24 Oct 2013 10:43:32 +0900 (JST)
Message-ID: <52687AF4.5090404@jp.fujitsu.com>
Date: Thu, 24 Oct 2013 10:42:12 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/3] x86, apic, kexec: Add disable_cpu_apic kernel
 parameter
References: <20131022150015.24240.39686.stgit@localhost6.localdomain6>
 <20131022220803.GA32387@anatevka.fc.hp.com> <526712B2.7070108@jp.fujitsu.com>
 <20131023155127.GA17437@redhat.com>
In-Reply-To: <20131023155127.GA17437@redhat.com>
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
Cc: fengguang.wu@intel.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, jerry.hoemann@hp.com, bp@alien8.de, ebiederm@xmission.com, akpm@linux-foundation.org, hpa@linux.intel.com, jingbai.ma@hp.com

(2013/10/24 0:51), Vivek Goyal wrote:
> On Wed, Oct 23, 2013 at 09:05:06AM +0900, HATAYAMA Daisuke wrote:
>
> [..]
>>> Do you literally mean a human at each boot will have to configure
>>> the kdump configuration files for passing disable_cpu_apic?
>>> Or do you envision the setting of disable_cpu_apic being put into
>>> the kdump initialization scripts?
>>>
>>> thanks
>>>
>>> Jerry
>>
>> Nearer to the former case, but this is not what a human should do. It's
>> a cumbersome task. I think, on fedora/RHEL system for example, kdump
>> service should check at each boot automatically.
>
> Hi Hatayama,
>
> So what information should I look for to prepare disable_cpu_apic=X in
> kdump script?
>
> Is BSP processor info exported to user space somewhere? Or assuming that
> processor 0 is BSP and corresponding apicid should be disabled in kdump
> kernel is good enough?
>

Yes, this patch set assumes that the processor 0 is BSP and there's no
other BSP. Because this patch cares about only one BSP processor,
the disabled_cpu_apicid variable has unsigned int, not mask.

I think this assumption is reasonable since doing it rigorously requires
additional processing between 1st and 2nd kernels just as I explained in
previous mail.

> I am looking at /proc/cpuinfo and following 3 fields seem interesting.
>
> processor: 0
> apicid		: 0
> initial apicid	: 0
>
> What's the difference between apicid and "initial apicid". I guess
> initial apicid reflects the apicid number as set by firmware and then
> kernel can overwrite it and new number would be reflected in "apicid"?
>
> If that's the case, then I guess we should be looking at "apicid" of
> processor "0" and set that in disable_cpu_apic? Because that's the
> number kdump kernel  boot should see in apic upon boot.
>

Yes, that's fully correct, and please see 10.4.6 Local APIC ID in Intel SPG
for details.

BTW, we can use cpuid instruction in user-space, too. It might be more
flexible to use cpuid than looking up /proc/cpuinfo.

Also, there's one corner case that if we hot-remove cpu0, we cannot
look up /proc/cpuinfo to get cpu0 information since /proc/cpunifo displays
*online* cpus only. We cannot use even cpuid instruction for offline cpu.
So, to address this corner case, we need to prepare new interface to see
cpu0 initial apicid which is always available.

My idea is for example to introduce the following file in sysfs:

   /sys/devices/system/cpu/cpu0/initial_apicid

Under the current implementation, cpu0 hot-remove is software one and kernel
must start with cpu0 in boot time. It's enough to assign the value of initial
APIC ID in the boot time. The one in boot_cpu_data?

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
