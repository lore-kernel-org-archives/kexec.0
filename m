Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Yrh1p-0006F4-IT
 for kexec@lists.infradead.org; Mon, 11 May 2015 06:17:26 +0000
Received: by pacyx8 with SMTP id yx8so101928883pac.1
 for <kexec@lists.infradead.org>; Sun, 10 May 2015 23:17:02 -0700 (PDT)
Message-ID: <55504956.9020007@linaro.org>
Date: Mon, 11 May 2015 15:16:54 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
MIME-Version: 1.0
Subject: Re: [v2 0/5] arm64: add kdump support
References: <1429861989-8417-1-git-send-email-takahiro.akashi@linaro.org>
 <20150424095312.GD29183@leverpostej>
In-Reply-To: <20150424095312.GD29183@leverpostej>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "hbabus@us.ibm.com" <hbabus@us.ibm.com>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, ard.biesheuvel@linaro.org, "geoff@infradead.org" <geoff@infradead.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "david.griego@linaro.org" <david.griego@linaro.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "vgoyal@redhat.com" <vgoyal@redhat.com>

Hi

Sorry for late response. I was on vacation.

On 04/24/2015 06:53 PM, Mark Rutland wrote:
> Hi,
>
> On Fri, Apr 24, 2015 at 08:53:03AM +0100, AKASHI Takahiro wrote:
>> This patch set enables kdump (crash dump kernel) support on arm64 on top of
>> Geoff's kexec patchset.
>>
>> In this version, there are some arm64-specific usage/constraints:
>> 1) "mem=" boot parameter must be specified on crash dump kernel
>>     if the system starts on uefi.
>
> This sounds very painful. Why is this the case, and how do x86 and/or
> ia64 get around that?

As Dave (Young) said, x86 uses "memmap=XX" kernel commandline parameters
to specify usable memory for crash dump kernel.
On my arm64 implementation, "linux,usable-memory" property is added
to device tree blob by kexec-tools for this purpose.
This is because, when I first implemented kdump on arm64, ppc is the only
architecture that supports kdump AND utilizes device trees.
Since kexec-tools as well as the kernel already has this framework,
I believed that device-tree approach was smarter than a commandline
parameter.

However, uefi-based kernel ignores all the memory-related properties
in a device tree and so this "mem=" workaround was added.


>> 2) Kvm will not be enabled on crash dump kernel even if configured
>> See commit messages and Documentation/kdump/kdump.txt for details.
>>
>> The only concern I have is whether or not we can use the exact same kernel
>> as both system kernel and crash dump kernel. The current arm64 kernel is
>> not relocatable in the exact sense but I see no problems in using the same
>> binary when testing kdump.
>
> Ard has been working on decoupling the kernel text/data, FDT, and linear
> memory mappings, which would allow the kernel to be loaded anywhere and
> still be able to access all of memory [3]. I assume that's what you mean
> by "relocatable"?

I'm still trying to understand Ard's patchset, but I think yes.

>> I tested the code with
>> 	- ATF v1.1 + EDK2(UEFI) v3.0-rc0
>> 	- kernel v4.0 + Geoff' kexec v9
>> on
>> 	- Base fast model, and
>> 	- MediaTek MT8173-EVB
>> using my own kexec-tools [1], currently v0.12.
>>
>> You may want to start a kernel with the following boot parameter:
>> 	crashkernel=64M (or so, on model)
>> and try
>> 	$ kexec -p --load <vmlinux> --append ...
>> 	$ echo c > /proc/sysrq-trigger
>>
>> To examine vmcore (/proc/vmcore), you should use
>> 	- gdb v7.7 or later
>> 	- crash + a small patch (to recognize v4.0 kernel)
>>
>> Changes from v1:
>> * rebased to Geoff's v9
>> * tested this patchset on real hardware and fixed bugs:
>> - added cache flush operation in ipi_cpu_stop() when shutting down
>>    the system. Otherwise, data saved in vmcore's note sections by
>>    crash_save_cpu() might not be flushed to dumped memory and crash command
>>    fail to fetch correct data.
>
> We'll need to give this a go on something with a system cache too (e.g.
> Seattle or X-Gene). Even if that's only UP it would give me much greater
> confidence in the cache maintenance.

Is there any genric interface to do so?

>>    I will address Mark's commit[2] after Geoff takes care of it on kexec.
>> - modified to use ioremap_cache() instead of ioremap() when reading
>>    crash memory. Otherwise, accessing /proc/vmcore on crash dump kernel
>>    might cause an alignment fault.
>> * allows reserve_crashkernel() to handle "crashkernel=xyz[MG]" correctly,
>>    thanks to Pratyush Anand. And it now also enforces memory limit.
>
> I worry that there could be potentially bad interaction between this and
> Ard's patches, depending on how the memory area to use is chosen. It is
> probably fine, but we should make sure that it is.

I'm not sure what the point is, but I will try to check it.

Thanks,
-Takahiro AKASHI

>> * moved reserve_crashkernel() and reserve_elfcorehdr() to
>>    arm64_memblock_init() to clarify that they should be called before
>>    dma_contignuous_reserve().
>>
>> [1] https://git.linaro.org/people/takahiro.akashi/kexec-tools.git
>> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-April/338171.html
>
> [3] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-April/337596.html
>
> Thanks,
> Mark.
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
