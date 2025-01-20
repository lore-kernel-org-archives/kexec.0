Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A95BC02181
	for <kexec@archiver.kernel.org>; Mon, 20 Jan 2025 10:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rUuf+qPnVXziY4ELR+clEQNjKjKr8CVJKIW2VDFxZIQ=; b=nkbwIQGYGPKfs5kvE5lwxaOxXZ
	aTaA/n0qGcP5UqznZae/ge/5UoGHdHq1YvCWrGOl/ipgtW9A4dGSI0KB0r1H8QYA/0UkNim/k3mRX
	VgfYjGg2fRnEWwj5dAq1xL+4b1fb7uGGgi2ZuSAZ+CFfRoCBVmMs8EKymY/Gk2CjB9uTxmTYf4llB
	gXrsyRRL5lDq4sB+prBY3Ry6/dQEwKF5ncpuW9lfWeIGrFD/LCom//rGd1T2l/+d65gqBnmnO/d/D
	VupkgSYUhLqBiRn5Wg4MHIpN6rNX1wJPE9OAIOForKLQiZGsU+xOCkplPj5SVQsv8U9nZGWgbxnpS
	ez+dfejg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tZp0A-00000005Kfy-1piM;
	Mon, 20 Jan 2025 10:27:26 +0000
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tZp05-00000005KfD-38Za
	for kexec@lists.infradead.org;
	Mon, 20 Jan 2025 10:27:23 +0000
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5d9837f201aso9850494a12.0
        for <kexec@lists.infradead.org>; Mon, 20 Jan 2025 02:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737368839; x=1737973639; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rUuf+qPnVXziY4ELR+clEQNjKjKr8CVJKIW2VDFxZIQ=;
        b=MmX9lJC31Paj7pg6EVL1PgEt51ZQgWluQF6HV1+Iy5Omyg7J1DQkzJ/nJQghzCiYsr
         DpQ0sOJHueSDkhSzLgcE/mxAZzZwlz4N1SbP3UU6c5UMrtuZyL2pBAXijTsnLIt7Pqmk
         OVo1EAXSzkpkKCsPD1XaxybvOI32Jopc1hlQjsCRMAg+kFX25vG0Xa+UHZIBytpxZinN
         p0vjcV/qJdJBvnaOgvm+mCwsHxiqRM4c3gO5KUyNcqVj5uZp89A1pKAoN48Snpnk/urO
         GlQZC/B6vmgVV9d8wpOkHq2WbFritvwR0rqYK+NLSsKx8aldhVMXbah+wY3djBQu2ouX
         gCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737368839; x=1737973639;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rUuf+qPnVXziY4ELR+clEQNjKjKr8CVJKIW2VDFxZIQ=;
        b=puyoydazKZ8pm7/C+xmgv5NQK8414upfE7Ze8WOv2DeXGhLhlM7iJ+GhviztxWeHhD
         GrkpuV+gCtti7wS6YfRCRHeSsUNbvCsdq8xGS2qaIc6YLDq4nAGnEsb/WngbLpojdzll
         3fK2hZZvVoERzZ22L9SVKT8jZbZG2stOGU7vsySEJjRrofM0MUNXwM4Sse7J/0Rbnn+t
         EqYlGUb2wjauZqjBQ2/+YazWSEq+moE0TeNWYgd5NqL67jL6pT6WWOwUbvo5sV2uLV4K
         UGSSxWGj7Kz2UN8NnjxFE/7WwMVV+u/3i2Cq9gnRrr4se533NQ7U8dMn1uuIUeJwRQ4p
         G7nA==
X-Forwarded-Encrypted: i=1; AJvYcCVm4mFt7AN0vOLR6jmhcPv4E1S0L3miRjsGohFeU8C+3HZ0SUZ8yfofQMFsqSXmRD5mCXdnFQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxkvvfiIwnEIO0JaLAYCY4nospVswbFgkMaQxZP5NebhBzjj1hC
	Gjjkbq4bHYxxsK2vFfAalGGFRWMkkZVsZoKdaOKnlhPwiRYZ5L7t
X-Gm-Gg: ASbGncshKqoyzgxBUIVQ2L57t07njuvddqmZPXF4m4Q4jeA3yidDa0A3J9JuDmq2l4T
	A5GcsiK8kwmcef5qPSnnDc+N1O+ThH7TefsAH15nENMEKI1oppzsaLw/uZwsxvqaJszH6w8gpnp
	GJGBxu+RyAg3ECa02R6iXhtUnlQbsoFnTypsi5tacmrxT12s5Fm2AUdb0Fy2Y689OE5ugv2E9PC
	d7gjRpqE3I+8lWGUhG+RvpSvJ8guTvn/wDNf4R7n88+2O7rM3+ckWTpi9gIx0siwrAoAbogRAwC
	ixZyRdr91OMdwxOukw7uUZodGef23y7qDm7g0xkShQ==
X-Google-Smtp-Source: AGHT+IFJVlthfW01rep+roRrPx41HHx1BoP/crq5DSFMeeGWPv+XAPS4A/l3WgF9Nu1tdQ84n+Nkfg==
X-Received: by 2002:a17:907:9485:b0:ab3:3b92:8ca5 with SMTP id a640c23a62f3a-ab36e2422camr1516607466b.12.1737368839235;
        Mon, 20 Jan 2025 02:27:19 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:829:739b:3caa:6500? ([2620:10d:c092:500::4:4372])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384ce6890sm596532066b.70.2025.01.20.02.27.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 02:27:18 -0800 (PST)
Message-ID: <ed7ad48f-2270-4966-bdba-ccd4592a0fd4@gmail.com>
Date: Mon, 20 Jan 2025 10:27:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] efi/memattr: Use desc_size instead of total size to
 check for corruption
From: Usama Arif <usamaarif642@gmail.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, devel@edk2.groups.io,
 kexec@lists.infradead.org, hannes@cmpxchg.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, leitao@debian.org, gourry@gourry.net,
 kernel-team@meta.com, Dave Young <dyoung@redhat.com>
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
 <20250108215957.3437660-2-usamaarif642@gmail.com>
 <CAMj1kXH54Y0ae1OGwBe7-UiRBq9cFkDHbjxos_rEZPtan7NNzQ@mail.gmail.com>
 <d9c84079-6593-43f4-9483-648b665f03db@gmail.com>
 <CAMj1kXGYsJrqDzy_+g_wSAAEuQ_OnxvyJ8ZE+4gbr6KOY7iuow@mail.gmail.com>
 <8613563a-ee7c-4271-b1f0-4d1ac365ad3a@gmail.com>
 <CALu+AoS8tb=HgaybDw5OG4A1QbOXHvuidpu0ynmz-nE1nBqzTA@mail.gmail.com>
 <db7edff7-8a87-41db-9e40-202a498c5e29@gmail.com>
 <138f28ec-341e-4c48-a14b-4371a8198de8@gmail.com>
Content-Language: en-US
In-Reply-To: <138f28ec-341e-4c48-a14b-4371a8198de8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250120_022721_838434_BAD563B9 
X-CRM114-Status: GOOD (  30.42  )
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



On 13/01/2025 12:00, Usama Arif wrote:
> 
> 
> On 13/01/2025 11:27, Usama Arif wrote:
>>
>>
>> On 13/01/2025 02:33, Dave Young wrote:
>>> On Fri, 10 Jan 2025 at 18:54, Usama Arif <usamaarif642@gmail.com> wrote:
>>>>
>>>>
>>>>
>>>> On 10/01/2025 07:21, Ard Biesheuvel wrote:
>>>>> On Thu, 9 Jan 2025 at 17:36, Usama Arif <usamaarif642@gmail.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 09/01/2025 15:45, Ard Biesheuvel wrote:
>>>>>>> On Wed, 8 Jan 2025 at 23:00, Usama Arif <usamaarif642@gmail.com> wrote:
>>>>>>>>
>>>>>>>> The commit in [1] introduced a check to see if EFI memory attributes
>>>>>>>> table was corrupted. It assumed that efi.memmap.nr_map remains
>>>>>>>> constant, but it changes during late boot.
>>>>>>>> Hence, the check is valid during cold boot, but not in the subsequent
>>>>>>>> kexec boot.
>>>>>>>>
>>>>>>>> This is best explained with an exampled. At cold boot, for a test
>>>>>>>> machine:
>>>>>>>> efi.memmap.nr_map=91,
>>>>>>>> memory_attributes_table->num_entries=48,
>>>>>>>> desc_size = 48
>>>>>>>> Hence, the check introduced in [1] where 3x the size of the
>>>>>>>> entire EFI memory map is a reasonable upper bound for the size of this
>>>>>>>> table is valid.
>>>>>>>>
>>>>>>>> In late boot __efi_enter_virtual_mode calls 2 functions that updates
>>>>>>>> efi.memmap.nr_map:
>>>>>>>> - efi_map_regions which reduces the `count` of map entries
>>>>>>>>   (for e.g. if should_map_region returns false) and which is reflected
>>>>>>>>   in efi.memmap by __efi_memmap_init.
>>>>>>>>   At this point efi.memmap.nr_map becomes 46 in the test machine.
>>>>>>>> - efi_free_boot_services which also reduces the number of memory regions
>>>>>>>>   available (for e.g. if md->type or md->attribute is not the right value).
>>>>>>>>   At this point efi.memmap.nr_map becomes 9 in the test machine.
>>>>>>>> Hence when you kexec into a new kernel and pass efi.memmap, the
>>>>>>>> paramaters that are compared are:
>>>>>>>> efi.memmap.nr_map=9,
>>>>>>>> memory_attributes_table->num_entries=48,
>>>>>>>> desc_size = 48
>>>>>>>> where the check in [1] is no longer valid with such a low efi.memmap.nr_map
>>>>>>>> as it was reduced due to efi_map_regions and efi_free_boot_services.
>>>>>>>>
>>>>>>>> A more appropriate check is to see if the description size reported by
>>>>>>>> efi and memory attributes table is the same.
>>>>>>>>
>>>>>>>> [1] https://lore.kernel.org/all/20241031175822.2952471-2-ardb+git@google.com/
>>>>>>>>
>>>>>>>> Fixes: 8fbe4c49c0cc ("efi/memattr: Ignore table if the size is clearly bogus")
>>>>>>>> Reported-by: Breno Leitao <leitao@debian.org>
>>>>>>>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>>>>>>>> ---
>>>>>>>>  drivers/firmware/efi/memattr.c | 16 ++++++----------
>>>>>>>>  1 file changed, 6 insertions(+), 10 deletions(-)
>>>>>>>>
>>>>>>>
>>>>>>> The more I think about this, the more I feel that kexec on x86 should
>>>>>>> simply discard this table, and run with the firmware code RWX (which
>>>>>>> is not the end of the world).
>>>>>>
>>>>>>
>>>>>> By discard this table, do you mean kexec not use e820_table_firmware?
>>>>>
>>>>> No, I mean kexec ignores the memory attributes table.
>>>>>
>>>>>> Also a very basic question, what do you mean by run with the firmware RWX?
>>>>>>
>>>>>
>>>>> The memory attributes table is an overlay for the EFI memory map that
>>>>> describes which runtime code regions may be mapped with restricted
>>>>> permissions. Without this table, everything will be mapped writable as
>>>>> well as executable, but only in the EFI page tables, which are only
>>>>> active when an EFI call is in progress.
>>>>>
>>>>
>>>> Thanks for explaining!
>>>>
>>>> So basically get rid of memattr.c :)
>>>>
>>>> Do you mean get rid of it only for kexec, or not do it for any
>>>> boot (including cold boot)?
>>>> I do like this idea! I couldn't find this in the git history,
>>>> but do you know if this was added in the linux kernel just
>>>> because EFI spec added support for it, or if there was a
>>>> specific security problem?
>>>>
>>>
>>> Usama, can you try the patch below?
>>> [ format is wrong due to webmail corruption.  But if it works I can
>>> send a formal patch later ]
>>>
>>> $ git diff arch/x86
>>> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
>>> index 846bf49f2508..58dc77c5210e 100644
>>> --- a/arch/x86/platform/efi/quirks.c
>>> +++ b/arch/x86/platform/efi/quirks.c
>>> @@ -561,6 +561,11 @@ int __init efi_reuse_config(u64 tables, int nr_tables)
>>>
>>>                 if (!efi_guidcmp(guid, SMBIOS_TABLE_GUID))
>>>                         ((efi_config_table_64_t *)p)->table = data->smbios;
>>> +
>>> +               /* Not bother to play with mem attr table across kexec */
>>> +               if (!efi_guidcmp(guid, EFI_MEMORY_ATTRIBUTES_TABLE_GUID))
>>> +                       ((efi_config_table_64_t *)p)->table =
>>> EFI_INVALID_TABLE_ADDR;
>>> +
>>>                 p += sz;
>>>         }
>>>
>>
>> This would work, I am guessing it will have a similar effect to what I sent
>> last week in 
>> https://lore.kernel.org/all/fd63613c-fd26-42de-b5ed-cc734f72eb36@gmail.com/
>>
>> I think it needs to be wrapped in ifdef CONFIG_X86_64.
>>
> 
> IMO we should consider the 2 patches in this series first before disabling it for
> kexec. These patches actually fix the issue.
> 

Hi Ard,

Just wanted to check how should we proceed forward? Should we try and fix the warning
and corruption during kexec as done in this series or not initialize memory attributes
table at all in kexec boot? I would prefer fixing the issues as in this series.

Thanks,
Usama


