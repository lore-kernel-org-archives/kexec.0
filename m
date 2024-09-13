Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17DAEEEE26C
	for <kexec@archiver.kernel.org>; Fri, 13 Sep 2024 11:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fDz3OfP4Na6fHE2yg1rAzLRopUVSvxUIQu1os2owqEM=; b=jE7fIkTd3tarUb
	akqD9pYZce6MnXDIZYsaD54Q1amYNk0VJcprsOVsZs6vgTOZ1WFnYNKV0TZ19Jn/kf5Ya+D7QQU1w
	JU2Xn1dwr+N5BOPc72WDfV7MoyAuE7S0NBnpS5Cp6Gq/cBqtaiLM6rwff7DJ+IQitX6/g68Gx+e6J
	iwGwl/FOWKGRDv4u7alEvdkX43NwmkEcWP1uIUc1wqit1apgsUgZel8vQW8BlxJjAZhTv9jPqP7Zw
	cT0LdAZFnuW6Vkob/Ue3e1LCUpclJCKIvOeDMz9V3FQhnPQL/mIYB/mAuJfE9io83HOESnzl7TYQk
	xEZ7GHq5kNRUiT8dMgYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp4uO-0000000Fns0-2Ejm;
	Fri, 13 Sep 2024 11:56:16 +0000
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp4uL-0000000Fnqe-2ho9
	for kexec@lists.infradead.org;
	Fri, 13 Sep 2024 11:56:15 +0000
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a8d3cde1103so271010766b.2
        for <kexec@lists.infradead.org>; Fri, 13 Sep 2024 04:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726228571; x=1726833371; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iZVgyOq08t6c939Zv1hA/wZvhoamsw4yMbHzCIvHf5c=;
        b=LmynNecMl9+XjHqLqsLeA5JjtaEO2SlZikqC29G9eR0oROVT/jAXnhIm8nP8ysN34q
         EqewyfwEX4d8AlNxpTnGYFU4UxPS9mhF2TWSgp9lADjB0AD2+F7FMs9HN7+jYYeFYavw
         tckvAuWtlK6hQp1pAn8AtVnnqBIDGPGZNNd3olyFNiGImkYi5DQAvvfgfI+hAWmsDFGo
         ZBchMeyngDMO1oWnwE2vkbEfH/eymcmXUJs3IWS8PAp7dO30jAjjXaOij+jXLgMjZq+f
         P5gb72WIGSyVI7bnXQfPv3CZXgRYQ8hBZM7+p2HkQGewoaxy5+i6f+U7NUt4kObWjtQM
         Anow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726228571; x=1726833371;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iZVgyOq08t6c939Zv1hA/wZvhoamsw4yMbHzCIvHf5c=;
        b=XKagBTKj0TWNmgK3yVhaUa8C0/IfhxFyxtTIpywc4KQ6ZLq6448YV1CVJpFOmJhP5H
         uqz0z2pTJpnepnt++dq2gXUTXYrHBlX1BwK8bBCuvaTLI/CzLFUveB6HA8bfuYQkGgDa
         UznB/h38+qopwIfY7wHxkifPpI+DQajI3vUL+7vGJrdubAf9uysZ7BMeK3MUUKyOCprR
         qil1aUeeZmg4iIHS8lUFcnWgKUIBd/pWkz0mq2EvPPIX6UIl1Z5+io6fOjywT/J9BGye
         wIbylAw2MAgHTF9zbI2b8UMWQtYHtLX9MAU38+ervreCBjIWhOspPRz62Xsida4uUwrH
         NBGg==
X-Forwarded-Encrypted: i=1; AJvYcCUafjzdNSVFPLiAly7u7nONKRCZgzuaL1qxUOROdQM2ZG5k8b1OCBCLMXuYxZB5zMJUX0Tc5g==@lists.infradead.org
X-Gm-Message-State: AOJu0YyKYSpz4bAzLxWoIKoHHhcw55Ja4ehiAL34Y8nMbnS1t+rAgFN0
	d9HA6/Kdrnoh5kikCHuWLPq1yA0Q/H9gN+x8Fz7nljzTr5Z0s3sJ
X-Google-Smtp-Source: AGHT+IEhQuxf9thQXUjHxx1/3t0J4k6xSec2pXjJJawLJF7J41sOP3r4s3o1fAPjIA1Dk3yJhLptbg==
X-Received: by 2002:a17:907:d843:b0:a77:b01b:f949 with SMTP id a640c23a62f3a-a90294995b8mr587694266b.35.1726228569887;
        Fri, 13 Sep 2024 04:56:09 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::4:ee51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25a2c441sm863941466b.90.2024.09.13.04.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 04:56:09 -0700 (PDT)
Message-ID: <c76e9653-d991-4319-8924-5883e6829d17@gmail.com>
Date: Fri, 13 Sep 2024 12:56:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in
 820_table_firmware
To: Dave Young <dyoung@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Breno Leitao <leitao@debian.org>,
 linux-efi@vger.kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
 bhe@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
 dave.hansen@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org,
 rmikey@meta.com, gourry@gourry.net
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
 <1c37546a-e15e-465f-bcbb-6f39c0fcf82d@gmail.com>
 <CALu+AoQ_Db=1naa1YffvdV7ziY8FPzugUutw6ggg8O5P0Z2ofA@mail.gmail.com>
 <CALu+AoSdN4Zh5gPbyTGS8gJ7wDFfOq81ANNH4wmv3z1vs-34Rw@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CALu+AoSdN4Zh5gPbyTGS8gJ7wDFfOq81ANNH4wmv3z1vs-34Rw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_045613_726040_D28393B4 
X-CRM114-Status: GOOD (  25.11  )
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



On 13/09/2024 12:49, Dave Young wrote:
> On Fri, 13 Sept 2024 at 19:13, Dave Young <dyoung@redhat.com> wrote:
>>
>> On Fri, 13 Sept 2024 at 19:07, Usama Arif <usamaarif642@gmail.com> wrote:
>>>
>>>
>>>
>>> On 13/09/2024 11:56, Dave Young wrote:
>>>> On Thu, 12 Sept 2024 at 22:15, Ard Biesheuvel <ardb@kernel.org> wrote:
>>>>>
>>>>> (cc Dave)
>>>>
>>>> Thanks for ccing me.
>>>>
>>>>>
>>>>> Full thread here:
>>>>> https://lore.kernel.org/all/CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com/T/#u
>>>>>
>>>>> On Thu, 12 Sept 2024 at 16:05, Ard Biesheuvel <ardb@kernel.org> wrote:
>>>>>>
>>>>>> On Thu, 12 Sept 2024 at 15:55, Usama Arif <usamaarif642@gmail.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 12/09/2024 14:10, Ard Biesheuvel wrote:
>>>>>>>> Does the below help at all?
>>>>>>>>
>>>>>>>> --- a/drivers/firmware/efi/tpm.c
>>>>>>>> +++ b/drivers/firmware/efi/tpm.c
>>>>>>>> @@ -60,7 +60,7 @@ int __init efi_tpm_eventlog_init(void)
>>>>>>>>         }
>>>>>>>>
>>>>>>>>         tbl_size = sizeof(*log_tbl) + log_tbl->size;
>>>>>>>> -       memblock_reserve(efi.tpm_log, tbl_size);
>>>>>>>> +       efi_mem_reserve(efi.tpm_log, tbl_size);
>>>>>>>>
>>>>>>>>         if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
>>>>>>>>                 pr_info("TPM Final Events table not present\n");
>>>>>>>
>>>>>>> Unfortunately not. efi_mem_reserve updates e820_table, while kexec looks at /sys/firmware/memmap
>>>>>>> which is e820_table_firmware.
>>>>>>>
>>>>>>> arch_update_firmware_area introduced in the RFC patch does the same thing as efi_mem_reserve does at
>>>>>>> its end, just with e820_table_firmware instead of e820_table.
>>>>>>> i.e. efi_mem_reserve does:
>>>>>>>         e820__range_update(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
>>>>>>>         e820__update_table(e820_table);
>>>>>>>
>>>>>>> while arch_update_firmware_area does:
>>>>>>>         e820__range_update_firmware(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
>>>>>>>         e820__update_table(e820_table_firmware);
>>>>>>>
>>>>>>
>>>>>> Shame.
>>>>>>
>>>>>> Using efi_mem_reserve() is appropriate here in any case, but I guess
>>>>>> kexec on x86 needs to be fixed to juggle the EFI memory map, memblock
>>>>>> table, and 3 (!) versions of the E820 table in the correct way
>>>>>> (e820_table, e820_table_kexec and e820_table_firmware)
>>>>>>
>>>>>> Perhaps we can put this additional logic in x86's implementation of
>>>>>> efi_arch_mem_reserve()? AFAICT, all callers of efi_mem_reserve() deal
>>>>>> with configuration tables produced by the firmware that may not be
>>>>>> reserved correctly if kexec looks at e820_table_firmware[] only.
>>>>>
>>>>
>>>> I have not read all the conversations,  let me have a look and response later.
>>>>
>>>> The first glance about the patch is that I think the kexec_file_load
>>>> syscall (default of latest kexec-tools) will not use
>>>> e820_table_firmware AFAIK.  it will only use e820_table_kexec.
>>>
>>> I initially thought that as well. But it looks like kexec just reads /sys/firmware/memmap
>>>
>>> https://github.com/horms/kexec-tools/blob/main/kexec/firmware_memmap.h#L29
>>>
>>> which is e820_table_firmware.
>>
>> That piece of code is only used by kexec_load
>>
>>>
>>> The patch that Ard sent in https://lore.kernel.org/all/20240912155159.1951792-2-ardb+git@google.com/
>>> is the right approach to it I believe, and I dont see the issue anymore after applying that patch.
>>>
>>>>
>>>> Usama, can you confirm how you tested this?
>>>> kexec -c -l  will use kexec_load syscall
>>>
>>> I am currently testing in my VM setup with kexec_load. But production is running
>>> kexec_file_load and has the same issue.
>>
>> Ok, I mean efi_mem_reserve should be able to work if you retest with
>> kexec_file_load.
> 
> Hold on,  I'm not sure about above :(
> 
> checking the efi_arch_mem_reserve(), currently it updates the e820
> table, if you update the e820_table_kexec and e820_table_firmware then
> I think both kexec_load and kexec_file_load will work.
> 
> Anyway I was not aware very much about the firmware e820 tables and
> kexec tables when they were created.   I suspect that a cleanup and
> revisit is needed.  I will have a look at that.

Yes, I feel like there is one too many tables! From reading the code
I understand that /sys/firmware/memmap should contain the untouched map
at time of boot, i.e. e820_table_firmware. But I would be in favour of
getting rid of e820_table_firmware, and just having e820_table_kexec.
And /sys/firmware/memmap gets data from e820_table_kexec.
> 
> For Ard's fix to allocate it as ACPI memory, I think it should be good
> and simpler.
>

 
Agreed!

>>
>>>
>>> Thanks,
>>> Usama
>>>
>>>> kexec [-s] -l will use kexec_file_load syscall
>>>>
>>>> Thanks
>>>> Dave
>>>>
>>>
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
