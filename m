Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <553A1E62.9030400@arm.com>
Date: Fri, 24 Apr 2015 11:43:46 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
Subject: Re: [v2 2/5] arm64: kdump: implement machine_crash_shutdown()
References: <1429861989-8417-1-git-send-email-takahiro.akashi@linaro.org>
 <1429861989-8417-3-git-send-email-takahiro.akashi@linaro.org>
 <20150424103900.GF29183@leverpostej>
In-Reply-To: <20150424103900.GF29183@leverpostej>
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
To: Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "hbabus@us.ibm.com" <hbabus@us.ibm.com>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "geoff@infradead.org" <geoff@infradead.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "david.griego@linaro.org" <david.griego@linaro.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "vgoyal@redhat.com" <vgoyal@redhat.com>

On 24/04/15 11:39, Mark Rutland wrote:
> On Fri, Apr 24, 2015 at 08:53:05AM +0100, AKASHI Takahiro wrote:
>> kdump calls machine_crash_shutdown() to shut down non-boot cpus and
>> save per-cpu general-purpose registers before restarting the crash dump
>> kernel. See kernel_kexec().
>> ipi_cpu_stop() is used and a bit modified to support this behavior.
>>
>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>> ---
>>  arch/arm64/include/asm/kexec.h    |   34 ++++++++++++++++++++++-
>>  arch/arm64/kernel/machine_kexec.c |   55 ++++++++++++++++++++++++++++++++++++-
>>  arch/arm64/kernel/smp.c           |   12 ++++++--
>>  3 files changed, 97 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
>> index 3530ff5..eaf3fcb 100644
>> --- a/arch/arm64/include/asm/kexec.h
>> +++ b/arch/arm64/include/asm/kexec.h
>> @@ -30,6 +30,8 @@
>>  
>>  #if !defined(__ASSEMBLY__)
>>  
>> +extern bool in_crash_kexec;
>> +
>>  /**
>>   * crash_setup_regs() - save registers for the panic kernel
>>   *
>> @@ -40,7 +42,37 @@
>>  static inline void crash_setup_regs(struct pt_regs *newregs,
>>  				    struct pt_regs *oldregs)
>>  {
>> -	/* Empty routine needed to avoid build errors. */
>> +	if (oldregs) {
>> +		memcpy(newregs, oldregs, sizeof(*newregs));
>> +	} else {
>> +		__asm__ __volatile__ (
>> +			"stp	 x0,   x1, [%3]\n\t"
> 
> Why the tabs?
> 
> Please use #16 * N as the offset for consistency with entry.S, with 0
> for the first N.
> 
> [...]
> 
>> +static void machine_kexec_mask_interrupts(void)
>> +{
>> +	unsigned int i;
>> +	struct irq_desc *desc;
>> +
>> +	for_each_irq_desc(i, desc) {
>> +		struct irq_chip *chip;
>> +
>> +		chip = irq_desc_get_chip(desc);
>> +		if (!chip)
>> +			continue;
>> +
>> +		if (chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
>> +			chip->irq_eoi(&desc->irq_data);
>> +
>> +		if (chip->irq_mask)
>> +			chip->irq_mask(&desc->irq_data);
>> +
>> +		if (chip->irq_disable && !irqd_irq_disabled(&desc->irq_data))
>> +			chip->irq_disable(&desc->irq_data);
>> +	}
>> +}
> 
> I'm surprised that this isn't left to the irqchip driver init code in
> the crash kernel. For all we know this state could be corrupt anyway.

Indeed, parsing the irqdesc list is a recipe for disaster. Who knows
which locks have been taken or simply corrupted, pointers nuked...

> Is there any reason we can't get the GIC driver to nuke all of this at
> probe time?

This feels like the better option. I can cook a patch or two for that.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
