Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf0-x233.google.com ([2a00:1450:4010:c07::233])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a4UMo-0005pk-O0
 for kexec@lists.infradead.org; Thu, 03 Dec 2015 13:56:16 +0000
Received: by lfdl133 with SMTP id l133so90381924lfd.2
 for <kexec@lists.infradead.org>; Thu, 03 Dec 2015 05:55:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAJ5Y-eYHqQCf=ZQzXb=D_P7VscM=vNc3YpYLJs+UtZLFswiaeQ@mail.gmail.com>
References: <cover.1448403503.git.geoff@infradead.org>
 <23ca498d5e28017549c6076812d60b18e86fa20e.1448403503.git.geoff@infradead.org>
 <CAJ5Y-eYHqQCf=ZQzXb=D_P7VscM=vNc3YpYLJs+UtZLFswiaeQ@mail.gmail.com>
From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Date: Thu, 3 Dec 2015 08:55:32 -0500
Message-ID: <CAJ5Y-eaxSAHQon2A1yP6mChsxcqPsU9Y1L1=-Lh8cF337H2pBQ@mail.gmail.com>
Subject: Re: [PATCH v12 04/16] arm64: kvm: allows kvm cpu hotplug
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Geoff Levand <geoff@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, vikrams@codeaurora.org, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, shankerd@codeaurora.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, kexec@lists.infradead.org, Christoffer Dall <christoffer.dall@linaro.org>

On 2 December 2015 at 17:40, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
> Hello,
>
> On 24 November 2015 at 17:25, Geoff Levand <geoff@infradead.org> wrote:
>> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>
>> The current kvm implementation on arm64 does cpu-specific initialization
>> at system boot, and has no way to gracefully shutdown a core in terms of
>> kvm. This prevents, especially, kexec from rebooting the system on a boot
>> core in EL2.
>>
>> This patch adds a cpu tear-down function and also puts an existing cpu-init
>> code into a separate function, kvm_arch_hardware_disable() and
>> kvm_arch_hardware_enable() respectively.
>> We don't need arm64-specific cpu hotplug hook any more.
>>
>> Since this patch modifies common part of code between arm and arm64, one
>> stub definition, __cpu_reset_hyp_mode(), is added on arm side to avoid
>> compiling errors.
>>
>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>> ---
>>  arch/arm/include/asm/kvm_host.h   | 10 ++++-
>>  arch/arm/include/asm/kvm_mmu.h    |  1 +
>>  arch/arm/kvm/arm.c                | 79 ++++++++++++++++++---------------------
>>  arch/arm/kvm/mmu.c                |  5 +++
>>  arch/arm64/include/asm/kvm_host.h | 16 +++++++-
>>  arch/arm64/include/asm/kvm_mmu.h  |  1 +
>>  arch/arm64/include/asm/virt.h     |  9 +++++
>>  arch/arm64/kvm/hyp-init.S         | 33 ++++++++++++++++
>>  arch/arm64/kvm/hyp.S              | 32 ++++++++++++++--
>>  9 files changed, 138 insertions(+), 48 deletions(-)
>
> [..]
>
>>
>>
>>  static struct notifier_block hyp_init_cpu_pm_nb = {
>> @@ -1108,11 +1119,6 @@ static int init_hyp_mode(void)
>>         }
>>
>>         /*
>> -        * Execute the init code on each CPU.
>> -        */
>> -       on_each_cpu(cpu_init_hyp_mode, NULL, 1);
>> -
>> -       /*
>>          * Init HYP view of VGIC
>>          */
>>         err = kvm_vgic_hyp_init();
>
> With this flow, the cpu_init_hyp_mode() is called only at VM guest
> creation, but vgic_hyp_init() is called at bootup. On a system with
> GICv3, it looks like we end up with bogus values from the ICH_VTR_EL2
> (to get the number of LRs), because we're not reading it from EL2
> anymore.

..or more likely, that the function to read the ICH_VTR_EL2 is not
mapped in EL2, because we deferred the cpu_init_hyp_mode() calls. In
any case, this ends up breaking KVM and manifests as a guest console
which is stuck.

>
> Whats the best way to fix this?
> - Call kvm_arch_hardware_enable() before vgic_hyp_init() and disable later?
> - Fold the VGIC init stuff back into hardware_enable()?
> - Read the VGIC number of LRs from the hyp stub?
> - ..
>
> Regards,
> Ashwin.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
