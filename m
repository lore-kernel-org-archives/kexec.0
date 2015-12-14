Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x22f.google.com ([2607:f8b0:400e:c03::22f])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a8XQq-0006z9-TL
 for kexec@lists.infradead.org; Mon, 14 Dec 2015 18:01:10 +0000
Received: by pacdm15 with SMTP id dm15so107174311pac.3
 for <kexec@lists.infradead.org>; Mon, 14 Dec 2015 10:00:47 -0800 (PST)
Subject: Re: [PATCH v12 04/16] arm64: kvm: allows kvm cpu hotplug
References: <cover.1448403503.git.geoff@infradead.org>
 <23ca498d5e28017549c6076812d60b18e86fa20e.1448403503.git.geoff@infradead.org>
 <CAJ5Y-eYHqQCf=ZQzXb=D_P7VscM=vNc3YpYLJs+UtZLFswiaeQ@mail.gmail.com>
 <56604A6E.60102@arm.com> <5669C802.7030103@linaro.org>
 <566A84AF.202@linaro.org>
From: "Shi, Yang" <yang.shi@linaro.org>
Message-ID: <566F03C7.6070600@linaro.org>
Date: Mon, 14 Dec 2015 10:00:39 -0800
MIME-Version: 1.0
In-Reply-To: <566A84AF.202@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Geoff Levand <geoff@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, vikrams@codeaurora.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Christoffer Dall <christoffer.dall@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, kexec@lists.infradead.org, shankerd@codeaurora.org

On 12/11/2015 12:09 AM, AKASHI Takahiro wrote:
> Yang,
>
> On 12/11/2015 03:44 AM, Shi, Yang wrote:
>> On 12/3/2015 5:58 AM, Marc Zyngier wrote:
>>> On 02/12/15 22:40, Ashwin Chaugule wrote:
>>>> Hello,
>>>>
>>>> On 24 November 2015 at 17:25, Geoff Levand <geoff@infradead.org> wrote:
>>>>> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>>>>
>>>>> The current kvm implementation on arm64 does cpu-specific
>>>>> initialization
>>>>> at system boot, and has no way to gracefully shutdown a core in
>>>>> terms of
>>>>> kvm. This prevents, especially, kexec from rebooting the system on
>>>>> a boot
>>>>> core in EL2.
>>>>>
>>>>> This patch adds a cpu tear-down function and also puts an existing
>>>>> cpu-init
>>>>> code into a separate function, kvm_arch_hardware_disable() and
>>>>> kvm_arch_hardware_enable() respectively.
>>>>> We don't need arm64-specific cpu hotplug hook any more.
>>>>>
>>>>> Since this patch modifies common part of code between arm and
>>>>> arm64, one
>>>>> stub definition, __cpu_reset_hyp_mode(), is added on arm side to avoid
>>>>> compiling errors.
>>>>>
>>>>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>>>> ---
>>>>>   arch/arm/include/asm/kvm_host.h   | 10 ++++-
>>>>>   arch/arm/include/asm/kvm_mmu.h    |  1 +
>>>>>   arch/arm/kvm/arm.c                | 79
>>>>> ++++++++++++++++++---------------------
>>>>>   arch/arm/kvm/mmu.c                |  5 +++
>>>>>   arch/arm64/include/asm/kvm_host.h | 16 +++++++-
>>>>>   arch/arm64/include/asm/kvm_mmu.h  |  1 +
>>>>>   arch/arm64/include/asm/virt.h     |  9 +++++
>>>>>   arch/arm64/kvm/hyp-init.S         | 33 ++++++++++++++++
>>>>>   arch/arm64/kvm/hyp.S              | 32 ++++++++++++++--
>>>>>   9 files changed, 138 insertions(+), 48 deletions(-)
>>>>
>>>> [..]
>>>>
>>>>>
>>>>>
>>>>>   static struct notifier_block hyp_init_cpu_pm_nb = {
>>>>> @@ -1108,11 +1119,6 @@ static int init_hyp_mode(void)
>>>>>          }
>>>>>
>>>>>          /*
>>>>> -        * Execute the init code on each CPU.
>>>>> -        */
>>>>> -       on_each_cpu(cpu_init_hyp_mode, NULL, 1);
>>>>> -
>>>>> -       /*
>>>>>           * Init HYP view of VGIC
>>>>>           */
>>>>>          err = kvm_vgic_hyp_init();
>>>>
>>>> With this flow, the cpu_init_hyp_mode() is called only at VM guest
>>>> creation, but vgic_hyp_init() is called at bootup. On a system with
>>>> GICv3, it looks like we end up with bogus values from the ICH_VTR_EL2
>>>> (to get the number of LRs), because we're not reading it from EL2
>>>> anymore.
>>>
>>> Indeed, this is completely broken (I just reproduced the issue on a
>>> model). I wish this kind of details had been checked earlier, but thanks
>>> for pointing it out.
>>
>> Sorry for chiming in late. I did run into something similar when I
>> tested some earlier version patches with Akashi San.
>>
>> The guest bootup just hangs with 4.1 kernel on my LS2085 board which
>> has GICv3. Not sure if this is the same issue. But,
>> my bisect did point to this patch.
>
> Can you please try my fixup! patch to determine whether it is the same
> issue or not?

I wish I could help this time, however, unfortunately, my LS2085 board 
had some hardware failure so I lost the access to it. Once I get a 
replacement or have it fixed, I will have a try.

Regards,
Yang

>
> Thanks
> -Takahiro AKASHI
>
>
>> I used to think it is my kernel's problem (4.1 sounds a little bit
>> old) since Akashi San can't reproduce this on his
>> Hikey board.
>>
>> Thanks,
>> Yang
>>
>>>
>>>> Whats the best way to fix this?
>>>> - Call kvm_arch_hardware_enable() before vgic_hyp_init() and disable
>>>> later?
>>>> - Fold the VGIC init stuff back into hardware_enable()?
>>>
>>> None of that works - kvm_arch_hardware_enable() is called once per CPU,
>>> while vgic_hyp_init() can only be called once. Also,
>>> kvm_arch_hardware_enable() is called from interrupt context, and I
>>> wouldn't feel comfortable starting probing DT and allocating stuff from
>>> there.
>>>
>>>> - Read the VGIC number of LRs from the hyp stub?
>>>
>>> That's may UNDEF if called in the wrong context. Also, this defeats the
>>> point of stubs, which is just to install the vectors for the hypervisor.
>>>
>>>> - ..
>>>
>>> Yeah, quite.
>>>
>>> Geoff, Takahiro?
>>>
>>>     M.
>>>
>>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
