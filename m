Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YGlWq-0005X2-In
 for kexec@lists.infradead.org; Thu, 29 Jan 2015 09:36:49 +0000
Received: by mail-pa0-f42.google.com with SMTP id bj1so37040180pad.1
 for <kexec@lists.infradead.org>; Thu, 29 Jan 2015 01:36:25 -0800 (PST)
Message-ID: <54C9FF0F.9050300@linaro.org>
Date: Thu, 29 Jan 2015 18:36:15 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
MIME-Version: 1.0
Subject: Re: [PATCH 7/8] arm64/kexec: Add checks for KVM
References: <cover.1421449714.git.geoff@infradead.org>
 <a3353cf2ac47f49c20bbbb88405301cbaa359805.1421449714.git.geoff@infradead.org>
 <20150126191942.GQ23313@leverpostej>
In-Reply-To: <20150126191942.GQ23313@leverpostej>
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
To: Mark Rutland <mark.rutland@arm.com>, Geoff Levand <geoff@infradead.org>
Cc: Marc Zyngier <Marc.Zyngier@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>

Hello,

On 01/27/2015 04:19 AM, Mark Rutland wrote:
> On Sat, Jan 17, 2015 at 12:23:34AM +0000, Geoff Levand wrote:
>> Add runtime checks that fail the arm64 kexec syscall for situations that would
>> result in system instability do to problems in the KVM kernel support.
>> These checks should be removed when the KVM problems are resolved fixed.
>>
>> Signed-off-by: Geoff Levand <geoff@infradead.org>
>> ---
>>   arch/arm64/kernel/machine_kexec.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
>> index 3d84759..a36459d 100644
>> --- a/arch/arm64/kernel/machine_kexec.c
>> +++ b/arch/arm64/kernel/machine_kexec.c
>> @@ -16,6 +16,9 @@
>>   #include <asm/cacheflush.h>
>>   #include <asm/system_misc.h>
>>
>> +/* TODO: Remove this include when KVM can support a kexec reboot. */
>> +#include <asm/virt.h>
>> +
>>   /* Global variables for the relocate_kernel routine. */
>>   extern const unsigned char relocate_new_kernel[];
>>   extern const unsigned long relocate_new_kernel_size;
>> @@ -100,6 +103,13 @@ int machine_kexec_prepare(struct kimage *image)
>>
>>   	kexec_image_info(image);
>>
>> +	/* TODO: Remove this message when KVM can support a kexec reboot. */
>> +	if (IS_ENABLED(CONFIG_KVM) && is_hyp_mode_available()) {
>> +		pr_err("%s: Your kernel is configured with KVM support (CONFIG_KVM=y) which currently does not allow for kexec re-boot.\n",
>> +			__func__);
>> +		return -ENOSYS;
>> +	}
>
> If you really don't want to implement KVM teardown, surely this should
> be at the start of the series, so we don't have a point in the middle
> where things may explode in this case?

I'm going to fix this KVM issue (teardown) in cooperation with Geoff.

Looking into kvm init code, kvm_arch_init() in particular,
I guess that teardown function (kvm_arch_exit()) should do
   (reverting kvm_timer_hyp_init() per cpu)
- stop arch timer

   (reverting cpu_init_hyp_mode() per cpu)
- flush TLB
- jump into identical mapping (using boot_hyp_pgd?)
- disable MMU?
- restore vbar_el2 to __hyp_stub_vectors (or NULL?)

   (reverting kvm_mmu_init())
- Do we need to free page tables and a bounce(trampoline) page?

Is this good enough for safely shutting down kvm?
Do I miss anything essential, or can I skip anyhing?

I really appreciate your comments.
-Takahiro AKASHI

> Mark.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
