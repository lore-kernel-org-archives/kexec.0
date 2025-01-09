Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A0D4E77199
	for <kexec@archiver.kernel.org>; Thu,  9 Jan 2025 16:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2ck84cJZLqXsIJaAUcqVFx7P3SIRlgvwU0gI9j6xgbA=; b=mjqUqY2rFc55LQjZDNsDMaDVDO
	L2Zkjg0LrmG5uMXTHseAqVDmmhqDMQGA/7+tNPVJr1FSvpbdQty84Z8ZIpReO1n5vrNklWKldBWQG
	ntnxyKk60s3SzRGhwd2R/K8d72ijV2stA3N7IrcO4GxAh4kZ8qTGK4IwWTyiiZKBpdLAFik+Rtt8i
	7Ntf2x8lRyW7fl91V0tP/vRjB3dujjr2/77kjhlKQgch3raY9Gl6jks4mViRShg2DGsup/j/vfpIA
	/dams/9eHBxv2tSXBcfs7qMdDSmDjcBUauP6fsxvt3U0XEGU2zQUCFrYp6+Pifh/fKbsnuuxzAUMx
	hBVTTqhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVvTE-0000000ChX5-3KC8;
	Thu, 09 Jan 2025 16:33:20 +0000
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVvSB-0000000ChGA-1EZo
	for kexec@lists.infradead.org;
	Thu, 09 Jan 2025 16:32:16 +0000
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5d8c1950da7so1788711a12.3
        for <kexec@lists.infradead.org>; Thu, 09 Jan 2025 08:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736440333; x=1737045133; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2ck84cJZLqXsIJaAUcqVFx7P3SIRlgvwU0gI9j6xgbA=;
        b=BiFoIr24RvWBF18WJ9ArPCRMuLjel9cxsfv0BxVtYyOP+rszBEo009VybN7FCaELBD
         AH9a19OGgQGGwXxSaklKYVrJoHzGfXM1DZNWC3iGiefel2uIcgfbLpk9BB918WIS0afj
         DZf4tqTXZZbTMJNqsk5IvXAVxNc6oDoc/z06tqg+Uq6mQsd6r61ZKkosnSm0FU6vDMuM
         9nZ/1LUTN5VBgoRXsCPFW1EU0amBwsBc/ayg2g4mQSqj9RaeeGeh9W0/SgcmsDRO7eb4
         QcwDAh9qLBruSdlIAv8jh47MTIDK3seDGESaFh/Ro391QalaThGxdylWfAcKmMSfNS7H
         7L6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736440333; x=1737045133;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ck84cJZLqXsIJaAUcqVFx7P3SIRlgvwU0gI9j6xgbA=;
        b=ZQhFA8ssEiVu6vCtwLoEmQ5PWfdfCbw01a9Q7sAxgcXT7vhQNm+odzrLagLwWdLAYv
         8vZfikJpX5dc53R0BxEFIRjGk9yQYeKUnKmsAt1xdkAVC5tRBnY03H5lFq9IM1hvSWA9
         Sq8dTQeXnz2kh7PvTnWL0hXajRbsWh0G+uLik0Nkf9fU7nrqlKA4PcSspAZ/zmdm24Di
         5Bd7fbTo7oN0SYwAHQb8nyLlEQ5iqMesav1koAvJFhO9bL4+BHYjrBO0osVPp0s/Ohxo
         SNyWAqwrr8AndkR3NERn8aEMr3FLIaxEXL0jrw+W/j3u0LHwjHODLlLxTBNMZst0Ayqs
         K6aw==
X-Forwarded-Encrypted: i=1; AJvYcCWg+38YzhqaT7PYbIs8nXuOMNzIvhLZfPgKeyee9YNwMvuup5+MPn81RYNKevseeAChrXlhEw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwmkhsBnTb4e73SRH01lHPsOUekySOOmmPWXGDvFMBl6NqvTJty
	L6zQp+DyAbVasLdbFh9YLY8JQOZg8/CVXoNS50R5Jme+vXehF4gS
X-Gm-Gg: ASbGncuFf4wrZqCGCD0NxNCM1LoucUcM3IG1RO2SmlECR3v/eOvWTeyNy6gIXXFrWwB
	Kep/7rWObWLH1yp5gK3dJdDYSJaPnI5xgAOxbQQVO+stEk0Hf9SsCj4DWUaLtDf41vGbjWvWxNp
	bOohmWEKX9OxrIRl6b1Y2sv3YUhlDow1ni2oBc81tKUX0duO+bAbFhQnFVa9gNoHq0E4T/Rc/he
	gC4p7uSvKQ/gT9Ib3FCU9ynDQL01a5PFqh9tH179t48et/vqxwm4GI6tVbZ7Av0q7LX/fR90rJa
	FNDZQplQ3n1IFRuMuD8SYMT37M5l
X-Google-Smtp-Source: AGHT+IET95vGKgOoOgihxI5Y69+gtj6ZhylVDaWZo4Dnakul58/pEHmiKxDp/vg/0dYX/btNLYrQaw==
X-Received: by 2002:a05:6402:2105:b0:5d3:d7b0:b834 with SMTP id 4fb4d7f45d1cf-5d972df67ecmr5972933a12.1.1736440331324;
        Thu, 09 Jan 2025 08:32:11 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:829:739b:3caa:6500? ([2620:10d:c092:500::5:337c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d99046d822sm719871a12.56.2025.01.09.08.32.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 08:32:10 -0800 (PST)
Message-ID: <cade51c5-5fcc-4208-b46c-f2e2038f03e7@gmail.com>
Date: Thu, 9 Jan 2025 16:32:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/2] efi/memattr: add efi_mem_attr_table as a reserved
 region in 820_table_firmware
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, devel@edk2.groups.io,
 kexec@lists.infradead.org, hannes@cmpxchg.org, dyoung@redhat.com,
 x86@kernel.org, linux-kernel@vger.kernel.org, leitao@debian.org,
 gourry@gourry.net, kernel-team@meta.com
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
 <20250108215957.3437660-3-usamaarif642@gmail.com>
 <CAMj1kXFWZNRwx1H2HT8V9hNvUKDi0O3kcLku+g94UOvNBzz5eQ@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAMj1kXFWZNRwx1H2HT8V9hNvUKDi0O3kcLku+g94UOvNBzz5eQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250109_083215_341908_71763683 
X-CRM114-Status: GOOD (  30.46  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org



On 09/01/2025 16:15, Ard Biesheuvel wrote:
> On Wed, 8 Jan 2025 at 23:00, Usama Arif <usamaarif642@gmail.com> wrote:
>>
>> When this area is not reserved, it comes up as usable in
>> /sys/firmware/memmap. This means that kexec, which uses that memmap
>> to find usable memory regions, can select the region where
>> efi_mem_attr_table is and overwrite it and relocate_kernel.
>>
>> Since the patch in [1] was merged, all boots after kexec
>> are producing the warning that it introduced.
>>
>> Having a fix in firmware can be difficult to get through.
> 
> I don't follow. I don't think there is anything wrong with the
> firmware here. Could you elaborate?
> 

So the problem is, kexec sees this memory as System RAM, and decides
it can be used to place an image here.

I guess the question is (and I actually don't know the answer here),
whose responsibility is it to mark this region as reserved so that 
its not touched by anyone else. I would have thought it should be
firmware?

Maybe its not the firmwares' job to mark it as reserved, but just pass
it to kernel and the kernel is supposed to make sure it gets reserved
in a proper way, even across kexecs.

I think in the end whoevers' responsibility it is, the easiest path forward
seems to be in kernel? (and not firmware or libstub)

> 
>> The next ideal place would be in libstub. However, it looks like
>> InstallMemoryAttributesTable [2] is not available as a boot service
>> call option [3], [4], and install_configuration_table does not
>> seem to work as a valid substitute.
>>
> 
> To do what, exactly?
> 

To change the memory type from System RAM to either reserved or
something more appropriate, i.e. any type that is not touched by
kexec or any other userspace.

Basically the example code I attached at the end of the cover letter in 
https://lore.kernel.org/all/20250108215957.3437660-1-usamaarif642@gmail.com/
It could be EFI_ACPI_RECLAIM_MEMORY or EFI_RESERVED_TYPE, both of which aren't
touched by kexec.

>> As a last option for a fix, this patch marks that region as reserved in
>> e820_table_firmware if it is currently E820_TYPE_RAM so that kexec doesn't
>> use it for kernel segments.
>>
>> [1] https://lore.kernel.org/all/20241031175822.2952471-2-ardb+git@google.com/
>> [2] https://github.com/tianocore/edk2/blob/master/MdeModulePkg/Core/Dxe/Misc/MemoryAttributesTable.c#L100
>> [3] https://github.com/tianocore/edk2/blob/42a141800c0c26a09d2344e84a89ce4097a263ae/MdeModulePkg/Core/Dxe/DxeMain/DxeMain.c#L41
>> [4] https://elixir.bootlin.com/linux/v6.12.6/source/drivers/firmware/efi/libstub/efistub.h#L327
>>
>> Reported-by: Breno Leitao <leitao@debian.org>
>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>> ---
>>  arch/x86/include/asm/e820/api.h | 2 ++
>>  arch/x86/kernel/e820.c          | 6 ++++++
>>  arch/x86/platform/efi/efi.c     | 9 +++++++++
>>  drivers/firmware/efi/memattr.c  | 1 +
>>  include/linux/efi.h             | 7 +++++++
>>  5 files changed, 25 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
>> index 2e74a7f0e935..4e9aa24f03bd 100644
>> --- a/arch/x86/include/asm/e820/api.h
>> +++ b/arch/x86/include/asm/e820/api.h
>> @@ -16,6 +16,8 @@ extern bool e820__mapped_all(u64 start, u64 end, enum e820_type type);
>>
>>  extern void e820__range_add   (u64 start, u64 size, enum e820_type type);
>>  extern u64  e820__range_update(u64 start, u64 size, enum e820_type old_type, enum e820_type new_type);
>> +extern u64  e820__range_update_firmware(u64 start, u64 size, enum e820_type old_type,
>> +                                       enum e820_type new_type);
>>  extern u64  e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool check_type);
>>  extern u64  e820__range_update_table(struct e820_table *t, u64 start, u64 size, enum e820_type old_type, enum e820_type new_type);
>>
>> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
>> index 82b96ed9890a..01d7d3c0d299 100644
>> --- a/arch/x86/kernel/e820.c
>> +++ b/arch/x86/kernel/e820.c
>> @@ -538,6 +538,12 @@ u64 __init e820__range_update_table(struct e820_table *t, u64 start, u64 size,
>>         return __e820__range_update(t, start, size, old_type, new_type);
>>  }
>>
>> +u64 __init e820__range_update_firmware(u64 start, u64 size, enum e820_type old_type,
>> +                                      enum e820_type new_type)
>> +{
>> +       return __e820__range_update(e820_table_firmware, start, size, old_type, new_type);
>> +}
>> +
>>  /* Remove a range of memory from the E820 table: */
>>  u64 __init e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool check_type)
>>  {
>> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
>> index a7ff189421c3..13684c5d7c05 100644
>> --- a/arch/x86/platform/efi/efi.c
>> +++ b/arch/x86/platform/efi/efi.c
>> @@ -168,6 +168,15 @@ static void __init do_add_efi_memmap(void)
>>         e820__update_table(e820_table);
>>  }
>>
>> +/* Reserve firmware area if it was marked as RAM */
>> +void arch_update_firmware_area(u64 addr, u64 size)
>> +{
>> +       if (e820__get_entry_type(addr, addr + size) == E820_TYPE_RAM) {
>> +               e820__range_update_firmware(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
>> +               e820__update_table(e820_table_firmware);
>> +       }
>> +}
>> +
>>  /*
>>   * Given add_efi_memmap defaults to 0 and there is no alternative
>>   * e820 mechanism for soft-reserved memory, import the full EFI memory
>> diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
>> index d3bc161361fb..d131781e2d7b 100644
>> --- a/drivers/firmware/efi/memattr.c
>> +++ b/drivers/firmware/efi/memattr.c
>> @@ -53,6 +53,7 @@ int __init efi_memattr_init(void)
>>         size = tbl->num_entries * tbl->desc_size;
>>         tbl_size = sizeof(*tbl) + size;
>>         memblock_reserve(efi_mem_attr_table, tbl_size);
>> +       arch_update_firmware_area(efi_mem_attr_table, tbl_size);
>>         set_bit(EFI_MEM_ATTR, &efi.flags);
>>
>>  unmap:
>> diff --git a/include/linux/efi.h b/include/linux/efi.h
>> index e5815867aba9..8eb9698bd6a4 100644
>> --- a/include/linux/efi.h
>> +++ b/include/linux/efi.h
>> @@ -1358,4 +1358,11 @@ extern struct blocking_notifier_head efivar_ops_nh;
>>  void efivars_generic_ops_register(void);
>>  void efivars_generic_ops_unregister(void);
>>
>> +#ifdef CONFIG_X86_64
>> +void __init arch_update_firmware_area(u64 addr, u64 size);
>> +#else
>> +static inline void __init arch_update_firmware_area(u64 addr, u64 size)
>> +{
>> +}
>> +#endif
>>  #endif /* _LINUX_EFI_H */
>> --
>> 2.43.5
>>


