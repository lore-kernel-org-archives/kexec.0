Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
References: <20190913225009.3406-1-prsriva@linux.microsoft.com>
 <20190913225009.3406-2-prsriva@linux.microsoft.com>
 <87zhiz1x9l.fsf@morokweng.localdomain>
 <02234482-b095-e064-f4d6-1c6255a4ff9f@linux.microsoft.com>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [RFC PATCH v1 1/1] Add support for arm64 to carry ima measurement
 log in kexec_file_load
In-reply-to: <02234482-b095-e064-f4d6-1c6255a4ff9f@linux.microsoft.com>
Date: Tue, 24 Sep 2019 17:25:30 -0300
Message-ID: <87zhit5tmt.fsf@morokweng.localdomain>
MIME-Version: 1.0
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
To: prsriva <prsriva@linux.microsoft.com>
Cc: mark.rutland@arm.com, jean-philippe@linaro.org, arnd@arndb.de, yamada.masahiro@socionext.com, sboyd@kernel.org, catalin.marinas@arm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, zohar@linux.ibm.com, takahiro.akashi@linaro.org, kristina.martsenko@arm.org, duwe@lst.de, linux-arm-kernel@lists.infradead.org, james.morse@arm.org, linux-integrity@vger.kernel.org, tglx@linutronix.de, allison@lohutok.net


Hello,

prsriva <prsriva@linux.microsoft.com> writes:

> On 9/19/19 8:07 PM, Thiago Jung Bauermann wrote:
>> Hello Prakhar,
>>
>> Prakhar Srivastava <prsriva@linux.microsoft.com> writes:
>>
>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>> index 3adcec05b1f6..f39b12dbf9e8 100644
>>> --- a/arch/arm64/Kconfig
>>> +++ b/arch/arm64/Kconfig
>>> @@ -976,6 +976,13 @@ config KEXEC_VERIFY_SIG
>>>   	  verification for the corresponding kernel image type being
>>>   	  loaded in order for this to work.
>>>
>>> +config HAVE_IMA_KEXEC
>>> +	bool "Carry over IMA measurement log during kexec_file_load() syscall"
>>> +	depends on KEXEC_FILE
>>> +	help
>>> +	  Select this option to carry over IMA measurement log during
>>> +	  kexec_file_load.
>>> +
>>>   config KEXEC_IMAGE_VERIFY_SIG
>>>   	bool "Enable Image signature verification support"
>>>   	default y
>> This is not right. As it stands, HAVE_IMA_KEXEC is essentially a synonym
>> for IMA_KEXEC.
>>
>> It's not meant to be user-visible in the config process. Instead, it's
>> meant to be selected by the arch Kconfig (probably by the ARM64 config
>> symbol) to signal to IMA's Kconfig that it can offer the IMA_KEXEC
>> option.
>>
>> I also mentioned in my previous review that config HAVE_IMA_KEXEC should
>> be defined in arch/Kconfig, not separately in both arch/arm64/Kconfig
>> and arch/powerpc/Kconfig.
>
> I see the entry exists in arch/Kconfig and is overwritten.
> I will remove entries both from powerpc and arm64.
>
> How do i cross-compile for powerpc?

There are some instructions here:

https://github.com/linuxppc/wiki/wiki/Building-powerpc-kernels

>>> diff --git a/arch/arm64/include/asm/ima.h b/arch/arm64/include/asm/ima.h
>>> new file mode 100644
>>> index 000000000000..e23cee84729f
>>> --- /dev/null
>>> +++ b/arch/arm64/include/asm/ima.h
>>> @@ -0,0 +1,29 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +#ifndef _ASM_ARM64_IMA_H
>>> +#define _ASM_ARM64_IMA_H
>>> +
>>> +struct kimage;
>>> +
>>> +int ima_get_kexec_buffer(void **addr, size_t *size);
>>> +int ima_free_kexec_buffer(void);
>>> +
>>> +#ifdef CONFIG_IMA
>>> +void remove_ima_buffer(void *fdt, int chosen_node);
>>> +#else
>>> +static inline void remove_ima_buffer(void *fdt, int chosen_node) {}
>>> +#endif
>> I mentioned in my previous review that remove_ima_buffer() should exist
>> even if CONFIG_IMA isn't set. Did you arrive at a different conclusion?
>
> I made the needed changed in makefile, missed removing the
>
> configs here. Thanks for pointing this out.

Thanks.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
