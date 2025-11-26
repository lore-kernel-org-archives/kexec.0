Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56680D10386
	for <kexec@archiver.kernel.org>; Wed, 26 Nov 2025 07:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Iv7ZH0U5VwCrSx4pIQP2NujklUNE6c7fxiogNvnqOWg=; b=u8PUyYHUObdnQWWCaXpzu+yM3/
	EvYxvj6bKFgYZeZyKck6PHxqEWSRjC+fD5b2QDQCuMpYNE3/JBfea6PKYL3Ws5/l2a1dZJ+j6Ez5K
	Qn+PO+g5BHTDduS9MpMxgeKb/qn16r6NWDjMyuPNnzdckFOf11S8reswEXt3yfeu5Ek+MZBsc5lIR
	Cd7JE5zP+jj8LP5Ww7g0C/xZEIUedfqgzrnm0tzOEXa++YTQInT6CcwDbdOc7cneqPpvNBBotjkHI
	z35nOoTSbrkMWQI42kFdK45SsJ+zc8x/5xqGfMnI0pDL2fuITzXllrmYOll/8gTGodPO+7VpmjuS/
	kNSUX74Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO9uY-0000000EVw7-3rAl;
	Wed, 26 Nov 2025 07:25:58 +0000
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO9uV-0000000EVuc-2lzx
	for kexec@lists.infradead.org;
	Wed, 26 Nov 2025 07:25:57 +0000
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-640a3317b89so9323071a12.0
        for <kexec@lists.infradead.org>; Tue, 25 Nov 2025 23:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764141953; x=1764746753; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iv7ZH0U5VwCrSx4pIQP2NujklUNE6c7fxiogNvnqOWg=;
        b=PNvx8NqLCVbc2KAVNccNrjfDRZ7Is1qGganYgxIBxK7tPjCoft26K9sL+b9aCFGRuv
         C82TiVeqdhXU7ZrvjJvsJhuEIk5xLKhGq/Lq8pNDAWLj3dXCRudAXPTdNZ3JrQNBYnff
         Q1UjDgerYf4jAj1Xq2Uyy47hAq5vB7BjEAVsX2zdpNjBG/fCPdqdoWfMUYpvIPJyOhEh
         xKwcyEJaXLEnIUiLrYAmRlQYEOcM3EVuBbmuUjMfo+ReUWbs348/BiHR0x+eN7wokzyB
         fkVwhI0Ql3p8WMny4wC97KhxXjN+S6sIH0xvhUHDotJqKA/AtjluH7mqbBFtc1tBfj8G
         1qsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764141953; x=1764746753;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iv7ZH0U5VwCrSx4pIQP2NujklUNE6c7fxiogNvnqOWg=;
        b=tnFH1bIslnyjE/zOm6FGo78vKy+zgr5Z/7v+Yh/VNoMIc0QZqO/2ejXJLcF05Ka7vp
         PRqPF3P0ikUTPnsWAXyyJlLUNk6X7vJuxybrbu+eoiUmouHpO+vdWakFleZMMaYWguzG
         LA40xDQc9x/yVyWzhpUZqKv6sxQpk7aR///GGIHCUMCe27JPBNLtfh1SR7Tlhq7IGr5c
         oBkXQUD+fEer/e00ANbNxBJSMOPDj8zPufBLVq5zzBJuz7+MAjeg+yRO2oCe7wEb8D0J
         5NQcCzCcvqoLFgbp6ZFmWD1dz2OcQbonn+k0zdOO6xfzAahY7XPZhd169qsb1E+LTQH8
         5j8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1Fzl8dy1TQeQl/XPPK3xS2L1FRe1pdlZ6kIYvIHF4j9owb4H6aBQXmHlSmgKrppnLZU1wSg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxUrbgNSbLuFTKoI1ho6byyOG26SIsm4wfjbbWDHlrwW8vVcs0N
	z8QFyvXFM17QbkI/UekYLkAKkWkrFnckzyW95G/GnoQJRh52yq3GLfze
X-Gm-Gg: ASbGnctlXLeanVs6has35qg9dPa+RAv73Z9UU4nFCiybaZ0JKZ2SQ6yH62/YvfgtHu1
	tdqAudwrtun2SQskbstdHxy6UmNuZ1PqcsUBwTNEOV+qRXMaTcpzrpe8hNolxQ89WyPDCxwNSjC
	Y2PCp+voqx/lPpUpcWEtZz780EUkWZ3OXNCdcjvKXyYwR14KWS6Hrm8GW+z1pGx95tHkLHz2MIa
	qlDUUYrDO0CybNYNF23aK7/ZfLkUTbkkJ+z9wqXCT46YRLvysqrDlunnxHkSyEO9nPNtwy2J0L9
	yWc1H3sSbsSW90Nb/3lyrYGUx58FKF0FM/P4qlSaGE0hcpbiSQmS7RyQ79dkp3eG5U4O1l8EHzX
	dockpwlzGhQhVDNic1eYcZC20H+5V8/kPnOaopUBce1KTDdiGGsCSH1e/XCag5FsijBO/VWtZQb
	5ukdCfww8jZ7qkVyGZ6ZsJjz5zUuhMbXgOiNyzeS6PHHJVYEk4/TFRE4xF5AxXtgQ2N1upNSEUP
	G++CEgw8T4Q
X-Google-Smtp-Source: AGHT+IHX0rqNNyRTR0dneFys5BvltD8NgTOoyYKLcnywZAT/mxA+kXa1PwfcBV0janZViN7HMFRH3g==
X-Received: by 2002:a17:907:7fa2:b0:b70:7cd8:9098 with SMTP id a640c23a62f3a-b76c5592b7amr549919866b.61.1764141952922;
        Tue, 25 Nov 2025 23:25:52 -0800 (PST)
Received: from ?IPV6:2a02:6b6f:e750:1800:450:cba3:aec3:a1fd? ([2a02:6b6f:e750:1800:450:cba3:aec3:a1fd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654d55d7fsm1796765066b.21.2025.11.25.23.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 23:25:51 -0800 (PST)
Message-ID: <d38aeb5d-5a46-4e8d-b3c1-f2b4cdb15b04@gmail.com>
Date: Wed, 26 Nov 2025 07:25:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 12/17] x86/e820: temporarily enable KHO scratch for
 memory below 1M
Content-Language: en-GB
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,
 Changyuan Lyu <changyuanl@google.com>, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, anthony.yznaga@oracle.com, arnd@arndb.de,
 ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de,
 catalin.marinas@arm.com, corbet@lwn.net, dave.hansen@linux.intel.com,
 devicetree@vger.kernel.org, dwmw2@infradead.org, ebiederm@xmission.com,
 graf@amazon.com, hpa@zytor.com, jgowans@amazon.com,
 kexec@lists.infradead.org, krzk@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, luto@kernel.org, mark.rutland@arm.com, mingo@redhat.com,
 pasha.tatashin@soleen.com, pbonzini@redhat.com, peterz@infradead.org,
 robh@kernel.org, rostedt@goodmis.org, saravanak@google.com,
 skinsburskii@linux.microsoft.com, tglx@linutronix.de,
 thomas.lendacky@amd.com, will@kernel.org, x86@kernel.org,
 Breno Leitao <leitao@debian.org>, thevlad@meta.com
References: <20250509074635.3187114-1-changyuanl@google.com>
 <20250509074635.3187114-13-changyuanl@google.com>
 <a0f875f1-45ad-4dfc-b5c8-ecb51b242523@gmail.com>
 <mafs01plmxngp.fsf@kernel.org> <aSW0MF9BXjLnY2Fr@kernel.org>
 <ba690e06-c2a1-4d2e-9428-9ca2ea9f2b86@gmail.com>
 <aSaazgjKX8PfFDXf@kernel.org>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <aSaazgjKX8PfFDXf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_232555_802474_02C46ACF 
X-CRM114-Status: GOOD (  43.21  )
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



On 26/11/2025 06:14, Mike Rapoport wrote:
> On Tue, Nov 25, 2025 at 06:47:15PM +0000, Usama Arif wrote:
>>
>>
>> On 25/11/2025 13:50, Mike Rapoport wrote:
>>> Hi,
>>>
>>> On Tue, Nov 25, 2025 at 02:15:34PM +0100, Pratyush Yadav wrote:
>>>> On Mon, Nov 24 2025, Usama Arif wrote:
>>>
>>>>>> --- a/arch/x86/realmode/init.c
>>>>>> +++ b/arch/x86/realmode/init.c
>>>>>> @@ -65,6 +65,8 @@ void __init reserve_real_mode(void)
>>>>>>  	 * setup_arch().
>>>>>>  	 */
>>>>>>  	memblock_reserve(0, SZ_1M);
>>>>>> +
>>>>>> +	memblock_clear_kho_scratch(0, SZ_1M);
>>>>>>  }
>>>>>>  
>>>>>>  static void __init sme_sev_setup_real_mode(struct trampoline_header *th)
>>>>>
>>>>> Hello!
>>>>>
>>>>> I am working with Breno who reported that we are seeing the below warning at boot
>>>>> when rolling out 6.16 in Meta fleet. It is difficult to reproduce on a single host
>>>>> manually but we are seeing this several times a day inside the fleet.
>>>>>
>>>>>  20:16:33  ------------[ cut here ]------------
>>>>>  20:16:33  WARNING: CPU: 0 PID: 0 at mm/memblock.c:668 memblock_add_range+0x316/0x330
>>>>>  20:16:33  Modules linked in:
>>>>>  20:16:33  CPU: 0 UID: 0 PID: 0 Comm: swapper Tainted: G S                  6.16.1-0_fbk0_0_gc0739ee5037a #1 NONE 
>>>>>  20:16:33  Tainted: [S]=CPU_OUT_OF_SPEC
>>>>>  20:16:33  RIP: 0010:memblock_add_range+0x316/0x330
>>>>>  20:16:33  Code: ff ff ff 89 5c 24 08 41 ff c5 44 89 6c 24 10 48 63 74 24 08 48 63 54 24 10 e8 26 0c 00 00 e9 41 ff ff ff 0f 0b e9 af fd ff ff <0f> 0b e9 b7 fd ff ff 0f 0b 0f 0b cc cc cc cc cc cc cc cc cc cc cc
>>>>>  20:16:33  RSP: 0000:ffffffff83403dd8 EFLAGS: 00010083 ORIG_RAX: 0000000000000000
>>>>>  20:16:33  RAX: ffffffff8476ff90 RBX: 0000000000001c00 RCX: 0000000000000002
>>>>>  20:16:33  RDX: 00000000ffffffff RSI: 0000000000000000 RDI: ffffffff83bad4d8
>>>>>  20:16:33  RBP: 000000000009f000 R08: 0000000000000020 R09: 8000000000097101
>>>>>  20:16:33  R10: ffffffffff2004b0 R11: 203a6d6f646e6172 R12: 000000000009ec00
>>>>>  20:16:33  R13: 0000000000000002 R14: 0000000000100000 R15: 000000000009d000
>>>>>  20:16:33  FS:  0000000000000000(0000) GS:0000000000000000(0000) knlGS:0000000000000000
>>>>>  20:16:33  CR2: ffff888065413ff8 CR3: 00000000663b7000 CR4: 00000000000000b0
>>>>>  20:16:33  Call Trace:
>>>>>  20:16:33   <TASK>
>>>>>  20:16:33   ? __memblock_reserve+0x75/0x80
>>>
>>> Do you have faddr2line for this?
>>>>>>  20:16:33   ? setup_arch+0x30f/0xb10
>>>
>>> And this?
>>>
>>
>>
>> Thanks for this! I think it helped narrow down the problem.
>>
>> The stack is:
>>
>> 20:16:33 ? __memblock_reserve (mm/memblock.c:936) 
>> 20:16:33 ? setup_arch (arch/x86/kernel/setup.c:413 arch/x86/kernel/setup.c:499 arch/x86/kernel/setup.c:956) 
>> 20:16:33 ? start_kernel (init/main.c:922) 
>> 20:16:33 ? x86_64_start_reservations (arch/x86/kernel/ebda.c:57) 
>> 20:16:33 ? x86_64_start_kernel (arch/x86/kernel/head64.c:231) 
>> 20:16:33 ? common_startup_64 (arch/x86/kernel/head_64.S:419) 
>>
>> This is 6.16 kernel.
>>
>> 20:16:33 ? __memblock_reserve (mm/memblock.c:936) 
>> Thats memblock_add_range call in memblock_reserve
>>
>> 20:16:33 ? setup_arch (arch/x86/kernel/setup.c:413 arch/x86/kernel/setup.c:499 arch/x86/kernel/setup.c:956) 
>> That is parse_setup_data -> add_early_ima_buffer -> add_early_ima_buffer -> memblock_reserve_kern
>>
>>
>> I put a simple print like below:
>>
>> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
>> index 680d1b6dfea41..cc97ffc0083c7 100644
>> --- a/arch/x86/kernel/setup.c
>> +++ b/arch/x86/kernel/setup.c
>> @@ -409,6 +409,7 @@ static void __init add_early_ima_buffer(u64 phys_addr)
>>         }
>>  
>>         if (data->size) {
>> +               pr_err("PPP %s %s %d data->addr %llx, data->size %llx \n", __FILE__, __func__, __LINE__, data->addr, data->size);
>>                 memblock_reserve_kern(data->addr, data->size);
>>                 ima_kexec_buffer_phys = data->addr;
>>                 ima_kexec_buffer_size = data->size;
>>
>>
>> and I see (without replicating the warning):
>>
>> [    0.000000] PPP arch/x86/kernel/setup.c add_early_ima_buffer 412 data->addr 9e000, data->size 1000                                                                                          
>> ....
> 
> So it looks like in cases when the warning reproduces there's something
> that reserves memory overlapping with IMA buffer before
> add_early_ima_buffer().
> 
>>
>> [    0.000348] MEMBLOCK configuration:
>> [    0.000348]  memory size = 0x0000003fea329ff0 reserved size = 0x00000000050c969b
>> [    0.000350]  memory.cnt  = 0x5
>> [    0.000351]  memory[0x0]     [0x0000000000001000-0x000000000009ffff], 0x000000000009f000 bytes flags: 0x40
>> [    0.000353]  memory[0x1]     [0x0000000000100000-0x0000000067c65fff], 0x0000000067b66000 bytes flags: 0x0
>> [    0.000355]  memory[0x2]     [0x000000006d8db000-0x000000006fffffff], 0x0000000002725000 bytes flags: 0x0
>> [    0.000356]  memory[0x3]     [0x0000000100000000-0x000000407fff8fff], 0x0000003f7fff9000 bytes flags: 0x0
>> [    0.000358]  memory[0x4]     [0x000000407fffa000-0x000000407fffffff], 0x0000000000006000 bytes flags: 0x0
>> [    0.000359]  reserved.cnt  = 0x7
>>
>>
>> So MEMBLOCK_RSRV_KERN and MEMBLOCK_KHO_SCRATCH seem to overlap..
> 
> It does not matter, they are set on different arrays. RSRV_KERN is set on
> regions in memblock.reserved and KHO_SCRATCH is set on regions in
> memblock.memory.
> 
> So dumping memblock.memory is completely irrelevant, you need to check
> memblock.reserved for potential conflicts.
>  
>>>>>  20:16:33   ? start_kernel+0x58/0x960
>>>>>  20:16:33   ? x86_64_start_reservations+0x20/0x20
>>>>>  20:16:33   ? x86_64_start_kernel+0x13d/0x140
>>>>>  20:16:33   ? common_startup_64+0x13e/0x140
>>>>>  20:16:33   </TASK>
>>>>>  20:16:33  ---[ end trace 0000000000000000 ]--- 
>>>>>
>>>>>
>>>>> Rolling out with memblock=debug is not really an option in a large scale fleet due to the
>>>>> time added to boot. But I did try on one of the hosts (without reproducing the issue) and I see:
>>>
>>> Is it a problem to roll out a kernel that has additional debug printouts as
>>> Breno suggested earlier? I.e.
>>>
>>> 	if (flags != MEMBLOCK_NONE && flags != rgn->flags) {
>>> 		pr_warn("memblock: Flag mismatch at region [%pa-%pa]\n",
>>> 			&rgn->base, &rend);
>>> 		pr_warn("  Existing region flags: %#x\n", rgn->flags);
>>> 		pr_warn("  New range flags: %#x\n", flags);
>>> 		pr_warn("  New range: [%pa-%pa]\n", &base, &end);
>>> 		WARN_ON_ONCE(1);
>>> 	}
>>>
>>
>> I can add this, but the only thing is that it might be several weeks between me putting this in the
>> kernel and that kernel being deployed to enough machines that it starts to show up. I think the IMA coinciding
>> with memblock_mark_kho_scratch in e820__memblock_setup could be the reason for the warning. It might be better to
>> fix that case and deploy it to see if the warnings still show up?
>> I can add these prints as well incase it doesnt fix the problem.
>  
> I really don't think that effectively disabling memblock_mark_kho_scratch()
> when KHO is disabled will solve the problem because as I said the flags it
> sets are on different structure than the flags set by
> memblock_reserve_kern().
> 
>>> If you have the logs from failing boots up to the point where SLUB reports
>>> about it's initialization, e.g. 
>>>
>>> [    0.134377] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
>>>
>>> something there may hint about what's the issue. 
>>
>> So the boot doesnt fail, its just giving warnings in the fleet.
>> I have added the dmesg to the end of the mail.
>  
> Thanks, unfortunately nothing jumped at me there.
> 
>> Does something like this look good? I can try deploying this (although it will take sometime to find out).
>> We can get it upstream as well as that makes backports easier.
>>
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index 154f1d73b61f2..257c6f0eee03d 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -1119,8 +1119,13 @@ int __init_memblock memblock_reserved_mark_noinit(phys_addr_t base, phys_addr_t
>>   */
>>  __init int memblock_mark_kho_scratch(phys_addr_t base, phys_addr_t size)
>>  {
>> -       return memblock_setclr_flag(&memblock.memory, base, size, 1,
>> -                                   MEMBLOCK_KHO_SCRATCH);
>> +#ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
>> +       if (is_kho_boot())
> 
> Please use 
> 
> 	if (IS_ENABLED(CONFIG_MEMBLOCK_KHO_SCRATCH)
> 
> instead of indef.
> 
> If you send a formal patch with it, I'll take it.
> I'd suggest still deploying additional debug printouts internally.


Thanks! I will add the additional debug prints and [1] in the next release.
It will be sometime before it makes it into production, so I will try to debug
this more using the information you provided above.

[1] https://lore.kernel.org/all/20251126072051.546700-1-usamaarif642@gmail.com/

> 
>> +               return memblock_setclr_flag(&memblock.memory, base, size, 1,
>> +                                           MEMBLOCK_KHO_SCRATCH);
>> +#else
>> +       return 0;
>> +#endif
>>  }
>>  
>>  /**
>> @@ -1133,8 +1138,13 @@ __init int memblock_mark_kho_scratch(phys_addr_t base, phys_addr_t size)
>>   */
>>  __init int memblock_clear_kho_scratch(phys_addr_t base, phys_addr_t size)
>>  {
>> -       return memblock_setclr_flag(&memblock.memory, base, size, 0,
>> -                                   MEMBLOCK_KHO_SCRATCH);
>> +#ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
>> +       if (is_kho_boot())
>> +               return memblock_setclr_flag(&memblock.memory, base, size, 0,
>> +                                           MEMBLOCK_KHO_SCRATCH);
>> +#else
> 
> If nothing sets the flag _clear is anyway nop, but let's update it as well
> for symmetry.
> 


