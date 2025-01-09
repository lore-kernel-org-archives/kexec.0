Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E49C1E77197
	for <kexec@archiver.kernel.org>; Thu,  9 Jan 2025 16:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dX4VAIGuA5p4o4v1mMF/f2hbtB1svOw3Z2SHsNP1eCA=; b=WZb0Bvcs6ImVGg7suvqQ6O9ldD
	f42+k+dWhwKnNpO+qFIjvIVLdW4K0FqvPI0qwxtQU3gOwZ3hYCoMUYW0hkMOmkdKSge/HD00pEIVB
	XunFA9HP9mm69X/gFRpDyai9o1get4Tpoh+orVi32ScZql7R/+tPnsXlJ0DCjaDu9ge1l6edSHZ9t
	Q9/XQlLEltg1T3wX72H+a57LKbnpmy5wJj/ezkgpnsbe7b8HoU5v8VChNR6WdxFSm60xNB/HHwgxH
	6X8nKbx6SjMP6BlF0l55RdY/RWSgQi/1ngASyWfqhjBBfV+DGqj+HnPsHXa02cGv9/4tDJuFmjWSK
	VUFNun0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVvWV-0000000Ci8m-2ejm;
	Thu, 09 Jan 2025 16:36:43 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVvWI-0000000Ci5U-0fJ0
	for kexec@bombadil.infradead.org;
	Thu, 09 Jan 2025 16:36:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=dX4VAIGuA5p4o4v1mMF/f2hbtB1svOw3Z2SHsNP1eCA=; b=rI1UF9QZhJ1C+hwBuaBpqRL4yz
	8L8R8e7ZGU3Y0WsQqy//8y7QK+sXQEAkqA3ZlMvIKakHaPBLazg8sFMe6C+QnmmYTwmg6o3cIpVhS
	DGRgo6mK/uvUwql94XAsZ2AApQhKcQb1Ul4fO1ypb+N3+ExnxqcCkkrs7xX+DTpUG2v0D7Z0Mi4rN
	SKZG6d+ZPdRpCZyNzTEIrRv6yIyyQJJGI6NuClnx1Y03CvWjrDxN/ZGa3Bxrziyww8CnPb7tF35nL
	IrXvGe8oinJrjBJOarBcnckb9eyMcv9gLcBMiTMYfsN7vLcll9OXY/OfpjJ0X9DfBbsS5j+WueIOf
	9T7S/t1A==;
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVvWB-00000009bXq-00bp
	for kexec@lists.infradead.org;
	Thu, 09 Jan 2025 16:36:28 +0000
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5d3f28a4fccso1414008a12.2
        for <kexec@lists.infradead.org>; Thu, 09 Jan 2025 08:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736440579; x=1737045379; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dX4VAIGuA5p4o4v1mMF/f2hbtB1svOw3Z2SHsNP1eCA=;
        b=L4EjtwdvlIQcA2Yi/Kz7TutWA9LLppmtMC1N8cdBrZAM50/ToE8LWzlpr3bOTstdFd
         VjEwtd8EUn+j8D9zbnzyaoB3VYh0ujW7yYelNj8bq733V4i8M4uWvt0f6XN7XZsW9Zac
         fPf7od6RJsL3zoDizGu3KfVWHW9VEINSzNVLF3j9LZcC4lZCFvRBhvB9Y4rZu3t+DJ5A
         REGYABtUeJIga9+OU3S4DdTWv9omGdE0EbWU1gcENTRsTsPvml2PHL5KxcjYsKa7tAJP
         hEUKvbvhYkK48epctNVMY9QsUUaGMf7e6ZW7jXhq9W723ZrwsjmG6M+xtBASebE6f4PR
         YaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736440579; x=1737045379;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dX4VAIGuA5p4o4v1mMF/f2hbtB1svOw3Z2SHsNP1eCA=;
        b=U6qHR1nW5/rNFIQCiXOLp9kapGa9kcWUCFif64dPHdWdcIIrZ7+Cvc9zLDRXb7sEGL
         7R43eoJEqlmdLUS3VdtCNbXOQANsAmOwMGb7TG/UfHk5gJP12ZsufWjW7siHXeJVGbXC
         uBlhJJZQ0evy44v7boU08C7T3Djft7KCbUYwXFgwDTUIY3QvF6Z7ioI0oQ9KHAxJcRbJ
         AgJ6rjZFopBjFe6aY9y/QUGJLQVNZJk4lGeF1NDL8QysIXgEHcaSPdABfnJAIXs4ZfIe
         KmXtR5KOlph/VlA+OPW3hmKqrUb/XVMXrQaYQ+CODcRV1sL8g2N+H2TXJn5pxPsbxzue
         44hw==
X-Forwarded-Encrypted: i=1; AJvYcCUPz+4Qz9GV19jtW2IszgZHEJdVD9DdPOpvlyBkUjmo3zHBUloBPk7zPAF81+6oSOwUW2A1yQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwoRBpO5ueqiGdeAPt9l4N7CGAwd+2mCfjhtjTatrw1lFke1mF/
	IuIt58Al8UOis2OrIxCIA3e6q1qCsgBghm9CX8Bfzt7cxVvIzyLx
X-Gm-Gg: ASbGncs9KKVhK75lOZCwr+vc392MVDEP24XprkcpwUxjewRdR6HqBhlrYRAcIE/VhnD
	HfPaXyWcKxMfV6nRMDvULfP0c4AsOQEht3R70aq7gD/Hn/aALB+x66LB4VWVeHiiLm28bkrEkGg
	mdRr63gq1e7edocL6MOA3SlG8vOastpHtj/u8ZEwON6T2ksh+ZJ2n4JAMV0FuSBBSjFRagZN+T1
	lDj2fuG4R7DUDqIDfI8wujF+tSqWEfnD9zhzolSSGb+pRXYS1F1MPQv0ph0skv/jaE7yF36f1Ga
	BcgYFG7ApRaECBFA3SzuUG7CSOVn
X-Google-Smtp-Source: AGHT+IFH4Mf4jMgpRx3khbxhhYmeEL2WA8ovuW6XBYno3NsJIZaj1ShKSo8fqHjrVfklGFxDEAk+6g==
X-Received: by 2002:a05:6402:1ed4:b0:5d0:bcdd:ff8f with SMTP id 4fb4d7f45d1cf-5d972dfbcc3mr6581488a12.4.1736440578846;
        Thu, 09 Jan 2025 08:36:18 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:829:739b:3caa:6500? ([2620:10d:c092:500::5:337c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d9903c3333sm785494a12.47.2025.01.09.08.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 08:36:18 -0800 (PST)
Message-ID: <d9c84079-6593-43f4-9483-648b665f03db@gmail.com>
Date: Thu, 9 Jan 2025 16:36:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] efi/memattr: Use desc_size instead of total size to
 check for corruption
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, devel@edk2.groups.io,
 kexec@lists.infradead.org, hannes@cmpxchg.org, dyoung@redhat.com,
 x86@kernel.org, linux-kernel@vger.kernel.org, leitao@debian.org,
 gourry@gourry.net, kernel-team@meta.com
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
 <20250108215957.3437660-2-usamaarif642@gmail.com>
 <CAMj1kXH54Y0ae1OGwBe7-UiRBq9cFkDHbjxos_rEZPtan7NNzQ@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAMj1kXH54Y0ae1OGwBe7-UiRBq9cFkDHbjxos_rEZPtan7NNzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250109_163626_511712_182CD5A9 
X-CRM114-Status: GOOD (  29.56  )
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



On 09/01/2025 15:45, Ard Biesheuvel wrote:
> On Wed, 8 Jan 2025 at 23:00, Usama Arif <usamaarif642@gmail.com> wrote:
>>
>> The commit in [1] introduced a check to see if EFI memory attributes
>> table was corrupted. It assumed that efi.memmap.nr_map remains
>> constant, but it changes during late boot.
>> Hence, the check is valid during cold boot, but not in the subsequent
>> kexec boot.
>>
>> This is best explained with an exampled. At cold boot, for a test
>> machine:
>> efi.memmap.nr_map=91,
>> memory_attributes_table->num_entries=48,
>> desc_size = 48
>> Hence, the check introduced in [1] where 3x the size of the
>> entire EFI memory map is a reasonable upper bound for the size of this
>> table is valid.
>>
>> In late boot __efi_enter_virtual_mode calls 2 functions that updates
>> efi.memmap.nr_map:
>> - efi_map_regions which reduces the `count` of map entries
>>   (for e.g. if should_map_region returns false) and which is reflected
>>   in efi.memmap by __efi_memmap_init.
>>   At this point efi.memmap.nr_map becomes 46 in the test machine.
>> - efi_free_boot_services which also reduces the number of memory regions
>>   available (for e.g. if md->type or md->attribute is not the right value).
>>   At this point efi.memmap.nr_map becomes 9 in the test machine.
>> Hence when you kexec into a new kernel and pass efi.memmap, the
>> paramaters that are compared are:
>> efi.memmap.nr_map=9,
>> memory_attributes_table->num_entries=48,
>> desc_size = 48
>> where the check in [1] is no longer valid with such a low efi.memmap.nr_map
>> as it was reduced due to efi_map_regions and efi_free_boot_services.
>>
>> A more appropriate check is to see if the description size reported by
>> efi and memory attributes table is the same.
>>
>> [1] https://lore.kernel.org/all/20241031175822.2952471-2-ardb+git@google.com/
>>
>> Fixes: 8fbe4c49c0cc ("efi/memattr: Ignore table if the size is clearly bogus")
>> Reported-by: Breno Leitao <leitao@debian.org>
>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>> ---
>>  drivers/firmware/efi/memattr.c | 16 ++++++----------
>>  1 file changed, 6 insertions(+), 10 deletions(-)
>>
> 
> The more I think about this, the more I feel that kexec on x86 should
> simply discard this table, and run with the firmware code RWX (which
> is not the end of the world).


By discard this table, do you mean kexec not use e820_table_firmware?
Also a very basic question, what do you mean by run with the firmware RWX?

Sorry for the very basic questions above!


> 
> The main reason is that the EFI memory map and the EFI memory
> attributes table are supposed to be a matched pair, where each RTcode
> entry in the former is broken down into multiple code and data
> segments in the latter. The amount of mangling that the x86 arch code
> does of the EFI memory map makes it intractable to ensure that they
> remain in sync, and so it is better not to bother.
> 
> 
>> diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
>> index c38b1a335590..d3bc161361fb 100644
>> --- a/drivers/firmware/efi/memattr.c
>> +++ b/drivers/firmware/efi/memattr.c
>> @@ -40,21 +40,17 @@ int __init efi_memattr_init(void)
>>                 goto unmap;
>>         }
>>
>> -
>>         /*
>> -        * Sanity check: the Memory Attributes Table contains up to 3 entries
>> -        * for each entry of type EfiRuntimeServicesCode in the EFI memory map.
>> -        * So if the size of the table exceeds 3x the size of the entire EFI
>> -        * memory map, there is clearly something wrong, and the table should
>> -        * just be ignored altogether.
>> +        * Sanity check: the Memory Attributes Table desc_size and
>> +        * efi.memmap.desc_size should match.
>>          */
>> -       size = tbl->num_entries * tbl->desc_size;
>> -       if (size > 3 * efi.memmap.nr_map * efi.memmap.desc_size) {
>> -               pr_warn(FW_BUG "Corrupted EFI Memory Attributes Table detected! (version == %u, desc_size == %u, num_entries == %u)\n",
>> -                       tbl->version, tbl->desc_size, tbl->num_entries);
>> +       if (efi.memmap.desc_size != tbl->desc_size) {
>> +               pr_warn(FW_BUG "Corrupted EFI Memory Attributes Table detected! (version == %u, table desc_size == %u, efi.memmap.desc_size == %lu, table num_entries == %u)\n",
>> +                       tbl->version, tbl->desc_size, efi.memmap.desc_size, tbl->num_entries);
>>                 goto unmap;
>>         }
>>
>> +       size = tbl->num_entries * tbl->desc_size;
>>         tbl_size = sizeof(*tbl) + size;
>>         memblock_reserve(efi_mem_attr_table, tbl_size);
>>         set_bit(EFI_MEM_ATTR, &efi.flags);
>> --
>> 2.43.5
>>


