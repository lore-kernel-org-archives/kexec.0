Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E03E7719E
	for <kexec@archiver.kernel.org>; Mon, 13 Jan 2025 11:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9p4WiiF7Tn3+Ob+aGqMCEaraRLkQng6ZulqTbNdq1sQ=; b=ZHaNI9s1HnyX8U8dhBtJVSsdvT
	IbehOBhvYUgZ7V9kKQXqNbMHhEuUUHGVINvaq1dOyOkef2vvG80Ol/wU5dknLehlU+DsXCn2FPSqV
	2khRANqXet/IUL/EmvSId2mUgbLH/lP+22iD1JV9L2HzxbChdrsTWdcW18SgM0nDUo59tGXMmyyo7
	xYf37cLsep2xLRH9gMY8SFCPKWZJ99y9DsoWyLOobrMirua5aybezH8gS8665nepL9cOyf/XIE5bk
	PqfVfQzqollCpPl8hIO/hSyAS8+6FkH3Kc6p882ocukVBy/hoNB2zkIsQqPwfEfB7H/ix+fXKS4K7
	5Cz9KtGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXIcl-00000004uWx-0RbI;
	Mon, 13 Jan 2025 11:28:51 +0000
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXIbc-00000004u6I-0bZG
	for kexec@lists.infradead.org;
	Mon, 13 Jan 2025 11:27:41 +0000
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5d982de9547so8092960a12.2
        for <kexec@lists.infradead.org>; Mon, 13 Jan 2025 03:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736767658; x=1737372458; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9p4WiiF7Tn3+Ob+aGqMCEaraRLkQng6ZulqTbNdq1sQ=;
        b=O259tJAo6ACUVI7jM8d1hE5sK/jFxFmjbSW5vnOVQ8oIuzKznM1sDyvKnJoHoU2yJ6
         Rakqo9UYe8gNKCpPzxYOZYfRhVGhMPojAiVd78hEa/Tzj4Yszu2S+yym+UHI6rrNmc6V
         RFwBOPSgT2BPmBsHLi0uVdp8J5MlY1POpfN7L0G+Akiylr2Alzqi0uTIrgPn2W+YRz24
         Xl7EUtFJi6c9cDFfZAfhhhYcp7pLkPxUTLWsFlneSeM0kn+cZAXmEA1oe0l2l2rnip3m
         NAlFFVe+3p+CDvbeIajhpNZwBn7ccgW2erLt/A0Khd+679YX4Iod6GcYetoy86Hkgj1p
         1Wsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736767658; x=1737372458;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9p4WiiF7Tn3+Ob+aGqMCEaraRLkQng6ZulqTbNdq1sQ=;
        b=gGvLOBxPWOBcap/r6fwUmLmvBFKpF5dBHMlkOgUsVMyW9msb/HjH+KzAFmJuOvvTTl
         HeCmzCiCI07qj6l3UaaTZ5KpO8LzEOd+PaEURqeytcLfj3pBitZOf4K0IfYUGoyzeRkX
         3zWU6SCZovea74Qkjeec7nJy3rL5KwxC5xTo4db9qPdfHmPYqR0W+zJQwR7OMHPanOgl
         fCgoBI+cv69c/qQ8Y1TYfKnkcUk/pB9sgrYSHvo5wmaa17TJmrwJVTz8LtUVQYAuLZ6t
         CKWBCQA2oe9ZqYBS6Ofj/y7oPWmEUOUHJWntta3sE8uZJYauSaKu6nhYTk/DnCoyqnrc
         tj9w==
X-Forwarded-Encrypted: i=1; AJvYcCVQu+yh/cFJ+u6Z1VV0bH2UtfQpd1AM79pMo0BLhhMcsLeGJrHGrUTG6BkgJxf3XZW/J8fHWQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz4MVw8sNHO0YIP/7SvcFxWX2+2cgDT+40ZszNzeIAWmfKqyMG/
	mRFiDQzY0vxLbiQTRzyMEscWiStcu5U9Mo4m1zCIM1+DWUX6r5O1
X-Gm-Gg: ASbGncshMMt2yQQsodAjXwcg1abKRecM4M2rraUmLxkdXpvX7XXlW4uBVCWD52KYpnO
	jaoqcgAvkIVMwBO6Twh3ZCfFx8RGpH/WDNG4aco6OdAUP/ClbSSti8V8Uq/Z4r01Uw0YXpHFTvF
	L5cT3aKQ2Oufapdk3r2T4i/2VwcJpTcIxjZYAYTFPNI3u/S8f176UOZPktibWhxIDj41MVB3ggx
	tt8rdKO0oRuoQuVQfv8wMpmqP53xs8z/3L4WVbs9LNGnazN49hhR62YbsP8kUTb3reg1dcSOwcf
	12RLBJIpkbD0kHHbzTWQspthzL3s6wzbOw==
X-Google-Smtp-Source: AGHT+IHY6ghLf4F1/E7hRXTvtL58y1ipNyvjXd5BzF87rdGENcFmDQO+YbClGjqRU3qWE4NMAa/7Lw==
X-Received: by 2002:a05:6402:5245:b0:5d0:ee52:353e with SMTP id 4fb4d7f45d1cf-5d972e696a4mr19574109a12.29.1736767657514;
        Mon, 13 Jan 2025 03:27:37 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:829:739b:3caa:6500? ([2620:10d:c092:500::6:97ef])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d9904a55f9sm4673231a12.81.2025.01.13.03.27.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 03:27:37 -0800 (PST)
Message-ID: <db7edff7-8a87-41db-9e40-202a498c5e29@gmail.com>
Date: Mon, 13 Jan 2025 11:27:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] efi/memattr: Use desc_size instead of total size to
 check for corruption
To: Dave Young <dyoung@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
 devel@edk2.groups.io, kexec@lists.infradead.org, hannes@cmpxchg.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, leitao@debian.org,
 gourry@gourry.net, kernel-team@meta.com
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
 <20250108215957.3437660-2-usamaarif642@gmail.com>
 <CAMj1kXH54Y0ae1OGwBe7-UiRBq9cFkDHbjxos_rEZPtan7NNzQ@mail.gmail.com>
 <d9c84079-6593-43f4-9483-648b665f03db@gmail.com>
 <CAMj1kXGYsJrqDzy_+g_wSAAEuQ_OnxvyJ8ZE+4gbr6KOY7iuow@mail.gmail.com>
 <8613563a-ee7c-4271-b1f0-4d1ac365ad3a@gmail.com>
 <CALu+AoS8tb=HgaybDw5OG4A1QbOXHvuidpu0ynmz-nE1nBqzTA@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CALu+AoS8tb=HgaybDw5OG4A1QbOXHvuidpu0ynmz-nE1nBqzTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250113_032740_196584_93456869 
X-CRM114-Status: GOOD (  30.82  )
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



On 13/01/2025 02:33, Dave Young wrote:
> On Fri, 10 Jan 2025 at 18:54, Usama Arif <usamaarif642@gmail.com> wrote:
>>
>>
>>
>> On 10/01/2025 07:21, Ard Biesheuvel wrote:
>>> On Thu, 9 Jan 2025 at 17:36, Usama Arif <usamaarif642@gmail.com> wrote:
>>>>
>>>>
>>>>
>>>> On 09/01/2025 15:45, Ard Biesheuvel wrote:
>>>>> On Wed, 8 Jan 2025 at 23:00, Usama Arif <usamaarif642@gmail.com> wrote:
>>>>>>
>>>>>> The commit in [1] introduced a check to see if EFI memory attributes
>>>>>> table was corrupted. It assumed that efi.memmap.nr_map remains
>>>>>> constant, but it changes during late boot.
>>>>>> Hence, the check is valid during cold boot, but not in the subsequent
>>>>>> kexec boot.
>>>>>>
>>>>>> This is best explained with an exampled. At cold boot, for a test
>>>>>> machine:
>>>>>> efi.memmap.nr_map=91,
>>>>>> memory_attributes_table->num_entries=48,
>>>>>> desc_size = 48
>>>>>> Hence, the check introduced in [1] where 3x the size of the
>>>>>> entire EFI memory map is a reasonable upper bound for the size of this
>>>>>> table is valid.
>>>>>>
>>>>>> In late boot __efi_enter_virtual_mode calls 2 functions that updates
>>>>>> efi.memmap.nr_map:
>>>>>> - efi_map_regions which reduces the `count` of map entries
>>>>>>   (for e.g. if should_map_region returns false) and which is reflected
>>>>>>   in efi.memmap by __efi_memmap_init.
>>>>>>   At this point efi.memmap.nr_map becomes 46 in the test machine.
>>>>>> - efi_free_boot_services which also reduces the number of memory regions
>>>>>>   available (for e.g. if md->type or md->attribute is not the right value).
>>>>>>   At this point efi.memmap.nr_map becomes 9 in the test machine.
>>>>>> Hence when you kexec into a new kernel and pass efi.memmap, the
>>>>>> paramaters that are compared are:
>>>>>> efi.memmap.nr_map=9,
>>>>>> memory_attributes_table->num_entries=48,
>>>>>> desc_size = 48
>>>>>> where the check in [1] is no longer valid with such a low efi.memmap.nr_map
>>>>>> as it was reduced due to efi_map_regions and efi_free_boot_services.
>>>>>>
>>>>>> A more appropriate check is to see if the description size reported by
>>>>>> efi and memory attributes table is the same.
>>>>>>
>>>>>> [1] https://lore.kernel.org/all/20241031175822.2952471-2-ardb+git@google.com/
>>>>>>
>>>>>> Fixes: 8fbe4c49c0cc ("efi/memattr: Ignore table if the size is clearly bogus")
>>>>>> Reported-by: Breno Leitao <leitao@debian.org>
>>>>>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>>>>>> ---
>>>>>>  drivers/firmware/efi/memattr.c | 16 ++++++----------
>>>>>>  1 file changed, 6 insertions(+), 10 deletions(-)
>>>>>>
>>>>>
>>>>> The more I think about this, the more I feel that kexec on x86 should
>>>>> simply discard this table, and run with the firmware code RWX (which
>>>>> is not the end of the world).
>>>>
>>>>
>>>> By discard this table, do you mean kexec not use e820_table_firmware?
>>>
>>> No, I mean kexec ignores the memory attributes table.
>>>
>>>> Also a very basic question, what do you mean by run with the firmware RWX?
>>>>
>>>
>>> The memory attributes table is an overlay for the EFI memory map that
>>> describes which runtime code regions may be mapped with restricted
>>> permissions. Without this table, everything will be mapped writable as
>>> well as executable, but only in the EFI page tables, which are only
>>> active when an EFI call is in progress.
>>>
>>
>> Thanks for explaining!
>>
>> So basically get rid of memattr.c :)
>>
>> Do you mean get rid of it only for kexec, or not do it for any
>> boot (including cold boot)?
>> I do like this idea! I couldn't find this in the git history,
>> but do you know if this was added in the linux kernel just
>> because EFI spec added support for it, or if there was a
>> specific security problem?
>>
> 
> Usama, can you try the patch below?
> [ format is wrong due to webmail corruption.  But if it works I can
> send a formal patch later ]
> 
> $ git diff arch/x86
> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> index 846bf49f2508..58dc77c5210e 100644
> --- a/arch/x86/platform/efi/quirks.c
> +++ b/arch/x86/platform/efi/quirks.c
> @@ -561,6 +561,11 @@ int __init efi_reuse_config(u64 tables, int nr_tables)
> 
>                 if (!efi_guidcmp(guid, SMBIOS_TABLE_GUID))
>                         ((efi_config_table_64_t *)p)->table = data->smbios;
> +
> +               /* Not bother to play with mem attr table across kexec */
> +               if (!efi_guidcmp(guid, EFI_MEMORY_ATTRIBUTES_TABLE_GUID))
> +                       ((efi_config_table_64_t *)p)->table =
> EFI_INVALID_TABLE_ADDR;
> +
>                 p += sz;
>         }
> 

This would work, I am guessing it will have a similar effect to what I sent
last week in 
https://lore.kernel.org/all/fd63613c-fd26-42de-b5ed-cc734f72eb36@gmail.com/

I think it needs to be wrapped in ifdef CONFIG_X86_64.


