Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C53FA3741
	for <kexec@archiver.kernel.org>; Fri, 13 Sep 2024 11:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LvJ5jACdgbXv82erxvzNcX8ujbD6gQlW+e7EsfOD838=; b=QdsIDZzv0pzcF7
	34kPeoP1Rsa5bMQc+krLb9zGPjXu9Ggs7/WeErTQmGKbGf52Lv4xTfEBnA7e5LZ+aGBvyN7xYutMd
	DH3TyLZQMwhUBQ+2gSOkRc8Z0wuEmcIx+JcYDpWBpyKBANWyv7XsBdsS6lDiLNVQT6H65ks/dV0gC
	A7RyqMuoIh30h9sAUyD1MmjXUQZu42soUwomdj7yP2vFNfVWuVHioob7C0VY3m8j3YFjxMwW9lj4Z
	+f0e0scUW5ipCzv1Por628XZjVujnMtDvE3ykO28wplnY5nyB7mL9jyyD4DltZjtF6KCikcrFxuEu
	DihNS/gTBqxHZiG2BYnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp48l-0000000FhYr-3KOW;
	Fri, 13 Sep 2024 11:07:03 +0000
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp48g-0000000FhXs-1KhN
	for kexec@lists.infradead.org;
	Fri, 13 Sep 2024 11:07:00 +0000
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a8d64b27c45so104765466b.3
        for <kexec@lists.infradead.org>; Fri, 13 Sep 2024 04:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726225616; x=1726830416; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CFdQ0EzFUbNiBdx0MjAaEserQ2Pnrtzma67XilXfJi8=;
        b=ebKdAMd7mVxaahPbKBGwukCwHGhnrz+A913ZCfpeMWgozJgJxuIOYJltQM0/+ka/NO
         MBeYM8Xn+STIRyGCRWCzVjfDBxjQ6l7b6fYmJWfjXpolrSeu+OwvCTcU/awN26zL0CPR
         BnEgPYnz8jiCVYDge7zU+QBQfmstB41JY3TpYapKl93y2FWo+QmqZlM3atqfdfb0Rc/q
         QZ3JkovTwJsb/roruRYRo3fng0c6tQJ0mIl9jJanG8Uq0it71qDXrhO+sMk90rK33W0X
         Y41objKqLgN5FwBPFC61qXImV0bsQGGBfVZzev0VMSd+mNnCYUn+cbggFEIXo87ByR6Q
         wUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726225616; x=1726830416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CFdQ0EzFUbNiBdx0MjAaEserQ2Pnrtzma67XilXfJi8=;
        b=BU+kAW5sRq3T473rqpovx+5SeC2mQP6SJpOyISBe2I0PQACwBuSX2nBYMnCzrywABj
         Zc1Y3y5p+ZdDpCBxaL7MnhfhwiolaesNWEofvdCPpPM5/e83i5PD/cP6DoAuhQHdKixn
         r6SncWQ1H3mr9ya0sq3ZW7ouX+XlJr1kc1DkjNmU9sQy6FTewVxHBRvGR8XavyGTWw9v
         UjHx00XpuDsoAeWqNeT3gbO7fOVn9oKhXvC7rZFSpghhmqqyPjRkHocKwmgPBlVXKKsn
         YQaD7TSaucUnIjt9oEV7HJuWzruuFc3hLJCo1m14KremTyahnKUY8dvL0UiVbLqY9lV9
         1qpg==
X-Forwarded-Encrypted: i=1; AJvYcCVaO2JdDj304svOTYkrh5sSTeIqUZUjr6m7m0J1B2pfPPAwSQzYRyE3W45ljHj6CEH29yIl/A==@lists.infradead.org
X-Gm-Message-State: AOJu0YzzlJ4xim/mp16Bj5/opJRHrguGr3nGFltE9toZYcPebXYyegT+
	nLajX5uR2EpXIWaiXT0nqulnGiDrEAcXg6xrZNh9A819qpT0mWyq
X-Google-Smtp-Source: AGHT+IEbuqZYHatkDhQKEvJhMn72YTY/AmGM3pWNQOzzeCGUq6TJmY5yCDpCdEfcdYIYgcHP9h/MNQ==
X-Received: by 2002:a17:907:724e:b0:a8a:8c04:ce95 with SMTP id a640c23a62f3a-a90481087f5mr189076766b.43.1726225615341;
        Fri, 13 Sep 2024 04:06:55 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::4:ee51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25953275sm859159266b.70.2024.09.13.04.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 04:06:54 -0700 (PDT)
Message-ID: <1c37546a-e15e-465f-bcbb-6f39c0fcf82d@gmail.com>
Date: Fri, 13 Sep 2024 12:06:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in
 820_table_firmware
To: Dave Young <dyoung@redhat.com>, Ard Biesheuvel <ardb@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, linux-efi@vger.kernel.org,
 kexec@lists.infradead.org, ebiederm@xmission.com, bhe@redhat.com,
 vgoyal@redhat.com, tglx@linutronix.de, dave.hansen@linux.intel.com,
 x86@kernel.org, linux-kernel@vger.kernel.org, rmikey@meta.com,
 gourry@gourry.net
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
 <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
 <2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com>
 <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
 <20240912-wealthy-gabby-tamarin-aaba3c@leitao>
 <CAMj1kXHh-Kov8c1pto0LJL6debugz1og6GFMYCwvfu+RiQGreA@mail.gmail.com>
 <6b2cc4c4-4354-4b29-bc73-c1384b90dfc6@gmail.com>
 <CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com>
 <CAMj1kXFr+N9LMj0=wULchYosUpV0ygZSKUj1vdUP0KWEANKasw@mail.gmail.com>
 <CALu+AoS9+OxPmVJB9fAJFkjsX9xUVw6K_uXiOi0-XsK6-b4THg@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CALu+AoS9+OxPmVJB9fAJFkjsX9xUVw6K_uXiOi0-XsK6-b4THg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_040658_394059_04D85E11 
X-CRM114-Status: GOOD (  19.32  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org



On 13/09/2024 11:56, Dave Young wrote:
> On Thu, 12 Sept 2024 at 22:15, Ard Biesheuvel <ardb@kernel.org> wrote:
>>
>> (cc Dave)
> 
> Thanks for ccing me.
> 
>>
>> Full thread here:
>> https://lore.kernel.org/all/CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com/T/#u
>>
>> On Thu, 12 Sept 2024 at 16:05, Ard Biesheuvel <ardb@kernel.org> wrote:
>>>
>>> On Thu, 12 Sept 2024 at 15:55, Usama Arif <usamaarif642@gmail.com> wrote:
>>>>
>>>>
>>>>
>>>> On 12/09/2024 14:10, Ard Biesheuvel wrote:
>>>>> Does the below help at all?
>>>>>
>>>>> --- a/drivers/firmware/efi/tpm.c
>>>>> +++ b/drivers/firmware/efi/tpm.c
>>>>> @@ -60,7 +60,7 @@ int __init efi_tpm_eventlog_init(void)
>>>>>         }
>>>>>
>>>>>         tbl_size = sizeof(*log_tbl) + log_tbl->size;
>>>>> -       memblock_reserve(efi.tpm_log, tbl_size);
>>>>> +       efi_mem_reserve(efi.tpm_log, tbl_size);
>>>>>
>>>>>         if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
>>>>>                 pr_info("TPM Final Events table not present\n");
>>>>
>>>> Unfortunately not. efi_mem_reserve updates e820_table, while kexec looks at /sys/firmware/memmap
>>>> which is e820_table_firmware.
>>>>
>>>> arch_update_firmware_area introduced in the RFC patch does the same thing as efi_mem_reserve does at
>>>> its end, just with e820_table_firmware instead of e820_table.
>>>> i.e. efi_mem_reserve does:
>>>>         e820__range_update(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
>>>>         e820__update_table(e820_table);
>>>>
>>>> while arch_update_firmware_area does:
>>>>         e820__range_update_firmware(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
>>>>         e820__update_table(e820_table_firmware);
>>>>
>>>
>>> Shame.
>>>
>>> Using efi_mem_reserve() is appropriate here in any case, but I guess
>>> kexec on x86 needs to be fixed to juggle the EFI memory map, memblock
>>> table, and 3 (!) versions of the E820 table in the correct way
>>> (e820_table, e820_table_kexec and e820_table_firmware)
>>>
>>> Perhaps we can put this additional logic in x86's implementation of
>>> efi_arch_mem_reserve()? AFAICT, all callers of efi_mem_reserve() deal
>>> with configuration tables produced by the firmware that may not be
>>> reserved correctly if kexec looks at e820_table_firmware[] only.
>>
> 
> I have not read all the conversations,  let me have a look and response later.
> 
> The first glance about the patch is that I think the kexec_file_load
> syscall (default of latest kexec-tools) will not use
> e820_table_firmware AFAIK.  it will only use e820_table_kexec.

I initially thought that as well. But it looks like kexec just reads /sys/firmware/memmap

https://github.com/horms/kexec-tools/blob/main/kexec/firmware_memmap.h#L29

which is e820_table_firmware.

The patch that Ard sent in https://lore.kernel.org/all/20240912155159.1951792-2-ardb+git@google.com/
is the right approach to it I believe, and I dont see the issue anymore after applying that patch.

> 
> Usama, can you confirm how you tested this?
> kexec -c -l  will use kexec_load syscall

I am currently testing in my VM setup with kexec_load. But production is running
kexec_file_load and has the same issue.

Thanks,
Usama

> kexec [-s] -l will use kexec_file_load syscall
> 
> Thanks
> Dave
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
