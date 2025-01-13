Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C94AC02180
	for <kexec@archiver.kernel.org>; Mon, 13 Jan 2025 12:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kBy06+ZzcG8cE/DV4b6e6/PZwuQ0e32d8+VJrouA7ds=; b=sP0YEHeNrgsLMauDCN7tdgTsAM
	rxEln/t2V2bS0BwoT0BfsdvWTuqDCHeK0lABxWlv0U2vlrHDcXNGFWvoDc8kJQa7KM+cLBQtrLIVm
	1zdb2xGEM/CxKTpVBDQXTN61doQKjFCXgF9YpAdlM+2bp3H6TCDgOrwByQjxbZM45WANzbuE8zL0n
	fcwH7MLXQKcJTYIaI7Jdw3Aem/MkjZN+rSwjmgGfQTkyf2mg1MhlMOPF1GLCnvnwPAsmKfRuCvzag
	rDspMWc6XgNBW2ljD2CReCSHa9/P+LKBkOphuZDzt2viDCf5lc4wdf/tByf08W8FFbxrUSw0DXZka
	7dL73axQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXJ7E-000000051Su-3qvC;
	Mon, 13 Jan 2025 12:00:20 +0000
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXJ79-000000051Qf-3LLj
	for kexec@lists.infradead.org;
	Mon, 13 Jan 2025 12:00:17 +0000
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5d9837f201aso7500252a12.0
        for <kexec@lists.infradead.org>; Mon, 13 Jan 2025 04:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736769614; x=1737374414; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kBy06+ZzcG8cE/DV4b6e6/PZwuQ0e32d8+VJrouA7ds=;
        b=IKrf7h3PjfTaMB1UiKEm1JWlVR2eXDLKxE2yVEeVWpimaNXE2SwJSE5OVr81Cd8x8F
         aR+JGkqsoKZFmPO+2npZaq9Ylodru04o2WAxNlxaKevFQwKUhI5PjtbNG4aysOfK1JDU
         6hwMbdlS5H3i+WEt2sWsZME3Pdt/oRUSDPmQPxspOUELf4G7h7/rSLGtTeBj9h9SFPVV
         nZpeZUZltP4czdFIeDcYfIZeQy4R5Lp+3HfLn2YxFMsh3QEPynYB4RSnUH5ZnMBkncrL
         aT/qirU3wYWW2fa7oAMbD2zJF+xXBX1PHkghk08kulIlLV7jLEhYi1/KmS/yLzUHJeM9
         unOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736769614; x=1737374414;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kBy06+ZzcG8cE/DV4b6e6/PZwuQ0e32d8+VJrouA7ds=;
        b=T+FD5DR3RWQN7RAgW2YqIcEBKJpyK+KMZRx2RaUKJzvNa0LDzdK+OXbyXkte7XPrj5
         8OK+yaabOQnb8t90LofCsYLIi5bvSVdwaxeeaxe3H/8meGsvGC+VaV7q6f1kPES1gFQf
         83bpPLTkirZU0kKtURQsiRPCo50KknnSnLlGQmiQKNTtbHjiFbvC2k36qbIcZkSzEPE9
         5srO5ssEJpqJuVgj4S+ufWko/30cjWySY1LrkMZJHBwvM7ncUWv2WO7zczRG8+3T5gek
         kfJByFbwXzBmk9eBBlMM6b8wcL8xEalOa2MqNmUdVTYM4tLBGdZEYu5N+Q9Jtz+RoIPV
         1gTg==
X-Forwarded-Encrypted: i=1; AJvYcCVCONLSTjXqEE/zD6znaoBuUetXx0h9EKlco67+Z//AbNE4GkJb3nGgiXYDaQtPlt/B5LIP+g==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzi71JLxrdkMf0lAEzaFdC6XbspUJd6HF/3WYQqH8BUhjCeAFO+
	VeW8uEYX41yw3e47PZDJ+TIfLB1tl+NdDuuFPa61rHA69lFP1r0e
X-Gm-Gg: ASbGncuxME2j1sscHGKdRpOuJ34foKSJMyJm42hM4f/3kyqQf4sacdIpAPuRLTPlNPH
	iTw42JgexCvWh/yWV0069Cz0MIIj0/6vuSPZycSfov9YPwIxkxO3yPwq2FYqS4Jp+jCj7mKUZii
	PaJQ4ylL07jrX5szLsyvCEmH4bHGhKAw0mdQdJawsrn4p0QbkjLmK+q8vDajRJlsz8U7tRkrRl5
	sgLHnY3YiBR1hvcdI4LpHyVM/5Bm2oDPtknuHrcWiu2iO4FwpQkEg1tknVC+JWcrrHTYtjwq64+
	efxtOXmFW1VIUTUj6IwAzkvdXAdMtkOaqA==
X-Google-Smtp-Source: AGHT+IE2OiQLKWaCSsDOk6IrssLsCvOozbvLXI9Jg/KEGSqDrR4j0Kdgbeeer+mXtV1iLbFtO49dBQ==
X-Received: by 2002:a17:907:3f1d:b0:aa6:88a2:cfbd with SMTP id a640c23a62f3a-ab2c3d09e99mr1401413766b.22.1736769613078;
        Mon, 13 Jan 2025 04:00:13 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:829:739b:3caa:6500? ([2620:10d:c092:500::6:97ef])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c90d52edsm490919366b.42.2025.01.13.04.00.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 04:00:12 -0800 (PST)
Message-ID: <138f28ec-341e-4c48-a14b-4371a8198de8@gmail.com>
Date: Mon, 13 Jan 2025 12:00:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] efi/memattr: Use desc_size instead of total size to
 check for corruption
From: Usama Arif <usamaarif642@gmail.com>
To: Dave Young <dyoung@redhat.com>, Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, devel@edk2.groups.io,
 kexec@lists.infradead.org, hannes@cmpxchg.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, leitao@debian.org, gourry@gourry.net,
 kernel-team@meta.com
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
 <20250108215957.3437660-2-usamaarif642@gmail.com>
 <CAMj1kXH54Y0ae1OGwBe7-UiRBq9cFkDHbjxos_rEZPtan7NNzQ@mail.gmail.com>
 <d9c84079-6593-43f4-9483-648b665f03db@gmail.com>
 <CAMj1kXGYsJrqDzy_+g_wSAAEuQ_OnxvyJ8ZE+4gbr6KOY7iuow@mail.gmail.com>
 <8613563a-ee7c-4271-b1f0-4d1ac365ad3a@gmail.com>
 <CALu+AoS8tb=HgaybDw5OG4A1QbOXHvuidpu0ynmz-nE1nBqzTA@mail.gmail.com>
 <db7edff7-8a87-41db-9e40-202a498c5e29@gmail.com>
Content-Language: en-US
In-Reply-To: <db7edff7-8a87-41db-9e40-202a498c5e29@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250113_040015_844358_63731E8B 
X-CRM114-Status: GOOD (  30.31  )
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



On 13/01/2025 11:27, Usama Arif wrote:
> 
> 
> On 13/01/2025 02:33, Dave Young wrote:
>> On Fri, 10 Jan 2025 at 18:54, Usama Arif <usamaarif642@gmail.com> wrote:
>>>
>>>
>>>
>>> On 10/01/2025 07:21, Ard Biesheuvel wrote:
>>>> On Thu, 9 Jan 2025 at 17:36, Usama Arif <usamaarif642@gmail.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 09/01/2025 15:45, Ard Biesheuvel wrote:
>>>>>> On Wed, 8 Jan 2025 at 23:00, Usama Arif <usamaarif642@gmail.com> wrote:
>>>>>>>
>>>>>>> The commit in [1] introduced a check to see if EFI memory attributes
>>>>>>> table was corrupted. It assumed that efi.memmap.nr_map remains
>>>>>>> constant, but it changes during late boot.
>>>>>>> Hence, the check is valid during cold boot, but not in the subsequent
>>>>>>> kexec boot.
>>>>>>>
>>>>>>> This is best explained with an exampled. At cold boot, for a test
>>>>>>> machine:
>>>>>>> efi.memmap.nr_map=91,
>>>>>>> memory_attributes_table->num_entries=48,
>>>>>>> desc_size = 48
>>>>>>> Hence, the check introduced in [1] where 3x the size of the
>>>>>>> entire EFI memory map is a reasonable upper bound for the size of this
>>>>>>> table is valid.
>>>>>>>
>>>>>>> In late boot __efi_enter_virtual_mode calls 2 functions that updates
>>>>>>> efi.memmap.nr_map:
>>>>>>> - efi_map_regions which reduces the `count` of map entries
>>>>>>>   (for e.g. if should_map_region returns false) and which is reflected
>>>>>>>   in efi.memmap by __efi_memmap_init.
>>>>>>>   At this point efi.memmap.nr_map becomes 46 in the test machine.
>>>>>>> - efi_free_boot_services which also reduces the number of memory regions
>>>>>>>   available (for e.g. if md->type or md->attribute is not the right value).
>>>>>>>   At this point efi.memmap.nr_map becomes 9 in the test machine.
>>>>>>> Hence when you kexec into a new kernel and pass efi.memmap, the
>>>>>>> paramaters that are compared are:
>>>>>>> efi.memmap.nr_map=9,
>>>>>>> memory_attributes_table->num_entries=48,
>>>>>>> desc_size = 48
>>>>>>> where the check in [1] is no longer valid with such a low efi.memmap.nr_map
>>>>>>> as it was reduced due to efi_map_regions and efi_free_boot_services.
>>>>>>>
>>>>>>> A more appropriate check is to see if the description size reported by
>>>>>>> efi and memory attributes table is the same.
>>>>>>>
>>>>>>> [1] https://lore.kernel.org/all/20241031175822.2952471-2-ardb+git@google.com/
>>>>>>>
>>>>>>> Fixes: 8fbe4c49c0cc ("efi/memattr: Ignore table if the size is clearly bogus")
>>>>>>> Reported-by: Breno Leitao <leitao@debian.org>
>>>>>>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>>>>>>> ---
>>>>>>>  drivers/firmware/efi/memattr.c | 16 ++++++----------
>>>>>>>  1 file changed, 6 insertions(+), 10 deletions(-)
>>>>>>>
>>>>>>
>>>>>> The more I think about this, the more I feel that kexec on x86 should
>>>>>> simply discard this table, and run with the firmware code RWX (which
>>>>>> is not the end of the world).
>>>>>
>>>>>
>>>>> By discard this table, do you mean kexec not use e820_table_firmware?
>>>>
>>>> No, I mean kexec ignores the memory attributes table.
>>>>
>>>>> Also a very basic question, what do you mean by run with the firmware RWX?
>>>>>
>>>>
>>>> The memory attributes table is an overlay for the EFI memory map that
>>>> describes which runtime code regions may be mapped with restricted
>>>> permissions. Without this table, everything will be mapped writable as
>>>> well as executable, but only in the EFI page tables, which are only
>>>> active when an EFI call is in progress.
>>>>
>>>
>>> Thanks for explaining!
>>>
>>> So basically get rid of memattr.c :)
>>>
>>> Do you mean get rid of it only for kexec, or not do it for any
>>> boot (including cold boot)?
>>> I do like this idea! I couldn't find this in the git history,
>>> but do you know if this was added in the linux kernel just
>>> because EFI spec added support for it, or if there was a
>>> specific security problem?
>>>
>>
>> Usama, can you try the patch below?
>> [ format is wrong due to webmail corruption.  But if it works I can
>> send a formal patch later ]
>>
>> $ git diff arch/x86
>> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
>> index 846bf49f2508..58dc77c5210e 100644
>> --- a/arch/x86/platform/efi/quirks.c
>> +++ b/arch/x86/platform/efi/quirks.c
>> @@ -561,6 +561,11 @@ int __init efi_reuse_config(u64 tables, int nr_tables)
>>
>>                 if (!efi_guidcmp(guid, SMBIOS_TABLE_GUID))
>>                         ((efi_config_table_64_t *)p)->table = data->smbios;
>> +
>> +               /* Not bother to play with mem attr table across kexec */
>> +               if (!efi_guidcmp(guid, EFI_MEMORY_ATTRIBUTES_TABLE_GUID))
>> +                       ((efi_config_table_64_t *)p)->table =
>> EFI_INVALID_TABLE_ADDR;
>> +
>>                 p += sz;
>>         }
>>
> 
> This would work, I am guessing it will have a similar effect to what I sent
> last week in 
> https://lore.kernel.org/all/fd63613c-fd26-42de-b5ed-cc734f72eb36@gmail.com/
> 
> I think it needs to be wrapped in ifdef CONFIG_X86_64.
> 

IMO we should consider the 2 patches in this series first before disabling it for
kexec. These patches actually fix the issue.


