Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A68FD0E6EC
	for <kexec@archiver.kernel.org>; Tue, 25 Nov 2025 14:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EZ4ODszvfszsaMwq6cWxl41Hem6czzJu/Sexl3aAaTM=; b=KyHWwAMUn3je0AYlV9mYOTiOab
	Kzx/pqK51K3L15Uk9xg22PtB6otu6N4QzIEsCJMeSIxWLdPr4QkvQ+G2Jh0JBfONCkozSJzH+hcmJ
	03JeZj/d26S8PwVxWgza6bk14WjCUhhrAr6J9eprbLZ4oNG+DK5ydxm/de4QYF0jI9BbCwk6hWyRq
	02jWgSvCKihjNiAsVtUcrx9klO2TTDok9v7WzgjAy3U1G7IelCjcryMevXaZtU4fGpYFbl7j5OF4U
	+D2v20Pu30OFsmELm6MxpTOQ7njLtDaKI7CkCufDGFQdAYux8fFW1VWdzbvAnYbBcJ7Sy+iEOtCkK
	Kz+wZyqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNu5L-0000000DRFB-1XKd;
	Tue, 25 Nov 2025 14:32:03 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNu5I-0000000DRET-3qTu
	for kexec@lists.infradead.org;
	Tue, 25 Nov 2025 14:32:02 +0000
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-477bf34f5f5so32337545e9.0
        for <kexec@lists.infradead.org>; Tue, 25 Nov 2025 06:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764081119; x=1764685919; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EZ4ODszvfszsaMwq6cWxl41Hem6czzJu/Sexl3aAaTM=;
        b=e18BSYY1bkIzs6xcwRdEpe+f2xsWhV8hY5AHXIzkmU+plLMboPBiX+7QKy6DVSloOm
         r6A87828sKVoaVYFXpPZv9H2Pm3R+QhxyAe7Ihg9BqHXSymfoOsE2FypyuE7KIN8r9hp
         tU9EMl2/KlepsBJo0njstVjcA1zOkFYlkkuRWsj520elMZnvYABSGqZCaXBasYX5X3XM
         bMPWXhBDDjijKGBSz6B+Mc9FDGM4ypTggBRVeOApEdkLm3gzyH9e6eVDjosZ+AaNeNHA
         fdJm0KvWB64Ov2wB2cW/uDOqU5XUwTdCFGq6k7e8y3oe/DL7cxiqF82ml+G276VfIYjo
         Tx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764081119; x=1764685919;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EZ4ODszvfszsaMwq6cWxl41Hem6czzJu/Sexl3aAaTM=;
        b=HILEcqGQDNBmzml87RwvGcghbXJRO5pdx0dtbw7Y3VPnHFrgBO6cD+pVmQg25Yu+6m
         6jeZLNGXrEw2N1G5fRIHG6uxx8eEAj4nSLlZJBhy2oq0Xsuc9lku9Ilh05EDSjNgKXcU
         UFybbeIk7tuaUmAMgJdSUXGq5WKo81Lpbk0VbUxYZFIN47SGLQm6hb/K3FQ3a8stcNQz
         ECSbFPGpKyACcFmyUjaysoV8kNPg9WbfLHDGWQz2E8it/njKLQsKzBmqG+N5yhd105xA
         kw6/AWlCuFdtaX/IpoD2ctEYDscspf8eJ3Gs5cT36L9ImxBUYdur5gTkKF6KId1LEexK
         z10Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzBzn5oV0Ks5HAQu0K7I1oy+x5qFHGhMKW7YhEGBAGz/aAkp54TMCi8HRPEfj1Otmxiv0D6w==@lists.infradead.org
X-Gm-Message-State: AOJu0YwQsF5L+EZwyKtFEjFGAEInAUla96TXYlnnXOQwgRNVxxEKAU1e
	y8AF3MC3XvyR4Zfvnsyy1saUf33idR+7TmA7hF5O9A7+P59m1As+7lXe
X-Gm-Gg: ASbGncsKiQnGGx3kTBEJMarYxQ9nDBqf8LaXCbF3ntLVFJ/7HHndFp7+eKbMPhw1RZB
	BwytBQXnHpkdHn4TYFdfDE/x1qJOX1d658l/7cNEXwVYqa4d4qbdvMtSDgm/ufhtVKKnUVf2VaC
	f0cpYtanKR/FyTDCCKlcnHSK/kFIGZy5kXxrG/dwaRFZA5mqdo11dkAyoJxsSF0Hd2JsieY5pGq
	6/6W1bcv6L2rss6NTximJveUr7yL9Gr0rc+G0uEU97MQENY4qnvEYTlYZZQqfUFVyOI02qf8VvJ
	Yr7c/HXuadoI3w1+GdheDlx3xRS7tkxMvwnoUEHpCopao22hLoJgJ30ez3q9AsxtI5NUAh21WlA
	31q0JWIpHucI0bHPT8MFNhcDjwasDZPREjqfowZ9PdmpzCVX+0qSgD/JuI0lxszvRCkD4kDjkJp
	0tPtUtYwdWg2eSrcZR4ish16Q0Wa4zJeTuNXEgu1P0xrfdfihaYAujf11/s80qzO4=
X-Google-Smtp-Source: AGHT+IET/PZINZcMffFdmxJigMRJhlhA6uIQoTot58T3/URSr348bM3kiSSBFmcvLwKBiV4zYcA0QA==
X-Received: by 2002:a5d:5d08:0:b0:42b:41d3:daf9 with SMTP id ffacd0b85a97d-42e0f1d5993mr3302081f8f.2.1764081118878;
        Tue, 25 Nov 2025 06:31:58 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:ce0:a4eb:eabc:d420? ([2620:10d:c092:500::5:f0ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e432sm33683057f8f.9.2025.11.25.06.31.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 06:31:58 -0800 (PST)
Message-ID: <80622f99-0ef4-491b-87f6-c9790dfecef6@gmail.com>
Date: Tue, 25 Nov 2025 14:31:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 12/17] x86/e820: temporarily enable KHO scratch for
 memory below 1M
Content-Language: en-GB
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Changyuan Lyu <changyuanl@google.com>, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
 anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com,
 benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com,
 corbet@lwn.net, dave.hansen@linux.intel.com, devicetree@vger.kernel.org,
 dwmw2@infradead.org, ebiederm@xmission.com, graf@amazon.com, hpa@zytor.com,
 jgowans@amazon.com, kexec@lists.infradead.org, krzk@kernel.org,
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
 <mafs01plmxngp.fsf@kernel.org>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <mafs01plmxngp.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_063201_018073_FB48932C 
X-CRM114-Status: GOOD (  41.36  )
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



On 25/11/2025 13:15, Pratyush Yadav wrote:
> On Mon, Nov 24 2025, Usama Arif wrote:
> 
>> On 09/05/2025 08:46, Changyuan Lyu wrote:
>>> From: Alexander Graf <graf@amazon.com>
>>>
>>> KHO kernels are special and use only scratch memory for memblock
>>> allocations, but memory below 1M is ignored by kernel after early boot
>>> and cannot be naturally marked as scratch.
>>>
>>> To allow allocation of the real-mode trampoline and a few (if any) other
>>> very early allocations from below 1M forcibly mark the memory below 1M
>>> as scratch.
>>>
>>> After real mode trampoline is allocated, clear that scratch marking.
>>>
>>> Signed-off-by: Alexander Graf <graf@amazon.com>
>>> Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>>> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>>> Co-developed-by: Changyuan Lyu <changyuanl@google.com>
>>> Signed-off-by: Changyuan Lyu <changyuanl@google.com>
>>> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
>>> ---
>>>  arch/x86/kernel/e820.c   | 18 ++++++++++++++++++
>>>  arch/x86/realmode/init.c |  2 ++
>>>  2 files changed, 20 insertions(+)
>>>
>>> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
>>> index 9920122018a0b..c3acbd26408ba 100644
>>> --- a/arch/x86/kernel/e820.c
>>> +++ b/arch/x86/kernel/e820.c
>>> @@ -1299,6 +1299,24 @@ void __init e820__memblock_setup(void)
>>>  		memblock_add(entry->addr, entry->size);
>>>  	}
>>>  
>>> +	/*
>>> +	 * At this point memblock is only allowed to allocate from memory
>>> +	 * below 1M (aka ISA_END_ADDRESS) up until direct map is completely set
>>> +	 * up in init_mem_mapping().
>>> +	 *
>>> +	 * KHO kernels are special and use only scratch memory for memblock
>>> +	 * allocations, but memory below 1M is ignored by kernel after early
>>> +	 * boot and cannot be naturally marked as scratch.
>>> +	 *
>>> +	 * To allow allocation of the real-mode trampoline and a few (if any)
>>> +	 * other very early allocations from below 1M forcibly mark the memory
>>> +	 * below 1M as scratch.
>>> +	 *
>>> +	 * After real mode trampoline is allocated, we clear that scratch
>>> +	 * marking.
>>> +	 */
>>> +	memblock_mark_kho_scratch(0, SZ_1M);
>>> +
>>>  	/*
>>>  	 * 32-bit systems are limited to 4BG of memory even with HIGHMEM and
>>>  	 * to even less without it.
>>> diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
>>> index f9bc444a3064d..9b9f4534086d2 100644
>>> --- a/arch/x86/realmode/init.c
>>> +++ b/arch/x86/realmode/init.c
>>> @@ -65,6 +65,8 @@ void __init reserve_real_mode(void)
>>>  	 * setup_arch().
>>>  	 */
>>>  	memblock_reserve(0, SZ_1M);
>>> +
>>> +	memblock_clear_kho_scratch(0, SZ_1M);
>>>  }
>>>  
>>>  static void __init sme_sev_setup_real_mode(struct trampoline_header *th)
>>
>> Hello!
>>
>> I am working with Breno who reported that we are seeing the below warning at boot
>> when rolling out 6.16 in Meta fleet. It is difficult to reproduce on a single host
>> manually but we are seeing this several times a day inside the fleet.
>>
>>  20:16:33  ------------[ cut here ]------------
>>  20:16:33  WARNING: CPU: 0 PID: 0 at mm/memblock.c:668 memblock_add_range+0x316/0x330
>>  20:16:33  Modules linked in:
>>  20:16:33  CPU: 0 UID: 0 PID: 0 Comm: swapper Tainted: G S                  6.16.1-0_fbk0_0_gc0739ee5037a #1 NONE 
>>  20:16:33  Tainted: [S]=CPU_OUT_OF_SPEC
>>  20:16:33  RIP: 0010:memblock_add_range+0x316/0x330
>>  20:16:33  Code: ff ff ff 89 5c 24 08 41 ff c5 44 89 6c 24 10 48 63 74 24 08 48 63 54 24 10 e8 26 0c 00 00 e9 41 ff ff ff 0f 0b e9 af fd ff ff <0f> 0b e9 b7 fd ff ff 0f 0b 0f 0b cc cc cc cc cc cc cc cc cc cc cc
>>  20:16:33  RSP: 0000:ffffffff83403dd8 EFLAGS: 00010083 ORIG_RAX: 0000000000000000
>>  20:16:33  RAX: ffffffff8476ff90 RBX: 0000000000001c00 RCX: 0000000000000002
>>  20:16:33  RDX: 00000000ffffffff RSI: 0000000000000000 RDI: ffffffff83bad4d8
>>  20:16:33  RBP: 000000000009f000 R08: 0000000000000020 R09: 8000000000097101
>>  20:16:33  R10: ffffffffff2004b0 R11: 203a6d6f646e6172 R12: 000000000009ec00
>>  20:16:33  R13: 0000000000000002 R14: 0000000000100000 R15: 000000000009d000
>>  20:16:33  FS:  0000000000000000(0000) GS:0000000000000000(0000) knlGS:0000000000000000
>>  20:16:33  CR2: ffff888065413ff8 CR3: 00000000663b7000 CR4: 00000000000000b0
>>  20:16:33  Call Trace:
>>  20:16:33   <TASK>
>>  20:16:33   ? __memblock_reserve+0x75/0x80
>>  20:16:33   ? setup_arch+0x30f/0xb10
>>  20:16:33   ? start_kernel+0x58/0x960
>>  20:16:33   ? x86_64_start_reservations+0x20/0x20
>>  20:16:33   ? x86_64_start_kernel+0x13d/0x140
>>  20:16:33   ? common_startup_64+0x13e/0x140
>>  20:16:33   </TASK>
>>  20:16:33  ---[ end trace 0000000000000000 ]--- 
>>
>>
>> Rolling out with memblock=debug is not really an option in a large scale fleet due to the
>> time added to boot. But I did try on one of the hosts (without reproducing the issue) and I see:
>>
>> [    0.000616]  memory.cnt  = 0x6
>> [    0.000617]  memory[0x0]	[0x0000000000001000-0x000000000009bfff], 0x000000000009b000 bytes flags: 0x40
>> [    0.000620]  memory[0x1]	[0x000000000009f000-0x000000000009ffff], 0x0000000000001000 bytes flags: 0x40
>> [    0.000621]  memory[0x2]	[0x0000000000100000-0x000000005ed09fff], 0x000000005ec0a000 bytes flags: 0x0
>> ...
>>
>> The 0x40 (MEMBLOCK_KHO_SCRATCH) is coming from memblock_mark_kho_scratch in e820__memblock_setup. I believe this
>> should be under ifdef like the diff at the end? (Happy to send this as a patch for review if it makes sense).
>> We have KEXEC_HANDOVER disabled in our defconfig, therefore MEMBLOCK_KHO_SCRATCH shouldnt be selected and
>> we shouldnt have any MEMBLOCK_KHO_SCRATCH type regions in our memblock reservations.
>>
>> The other thing I did was insert a while(1) just before the warning and inspected the registers in qemu.
>> R14 held the base register, and R15 held the size at that point.
>> In the warning R14 is 0x100000 meaning that someone is reserving a region with a different flag to MEMBLOCK_NONE
>> at the boundary of MEMBLOCK_KHO_SCRATCH.
> 
> I don't get this... The WARN_ON() is only triggered when the regions
> overlap. Here, there should be no overlap, since the scratch region
> should end at 0x100000 (SZ_1M) and the new region starts at 0x100000
> (SZ_1M).
> 

Yes, this is likely a separate problem. I just discovered flags = 0x40 while trying to
debug it with KEXEC_HANDOVER disabled.

> Anyway, you do indeed point at a bug. memblock_mark_kho_scratch() should
> only be called on a KHO boot, not unconditionally. So even with
> CONFIG_MEMBLOCK_KHO_SCRATCH enabled, this should only be called on a KHO
> boot, not every time.
> 
> I think the below diff should fix the warning for you by making sure the
> scratch areas are not present on non-KHO boot. I still don't know why
> you hit the warning in the first place though. If you'd be willing to
> dig deeper into that, it would be great.
> 
> Can you give the below a try and if it fixes the problem for you I can
> send it on the list.

Is there a reason for compiling this code with is_kho_boot, when we have disabled
KEXEC_HANDOVER and dont want this in? i.e. why not just ifdef it with MEMBLOCK_KHO_SCRATCH
when that defconfig is designed for it?

> 
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index c3acbd26408ba..0a34dc011bf91 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -16,6 +16,7 @@
>  #include <linux/firmware-map.h>
>  #include <linux/sort.h>
>  #include <linux/memory_hotplug.h>
> +#include <linux/kexec_handover.h>
>  
>  #include <asm/e820/api.h>
>  #include <asm/setup.h>
> @@ -1315,7 +1316,8 @@ void __init e820__memblock_setup(void)
>  	 * After real mode trampoline is allocated, we clear that scratch
>  	 * marking.
>  	 */
> -	memblock_mark_kho_scratch(0, SZ_1M);
> +	if (is_kho_boot())
> +		memblock_mark_kho_scratch(0, SZ_1M);
>  
>  	/*
>  	 * 32-bit systems are limited to 4BG of memory even with HIGHMEM and
> diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
> index 88be32026768c..4e9b4dff17216 100644
> --- a/arch/x86/realmode/init.c
> +++ b/arch/x86/realmode/init.c
> @@ -4,6 +4,7 @@
>  #include <linux/memblock.h>
>  #include <linux/cc_platform.h>
>  #include <linux/pgtable.h>
> +#include <linux/kexec_handover.h>
>  
>  #include <asm/set_memory.h>
>  #include <asm/realmode.h>
> @@ -67,7 +68,8 @@ void __init reserve_real_mode(void)
>  	 */
>  	memblock_reserve(0, SZ_1M);
>  
> -	memblock_clear_kho_scratch(0, SZ_1M);
> +	if (is_kho_boot())
> +		memblock_clear_kho_scratch(0, SZ_1M);
>  }
>  
>  static void __init sme_sev_setup_real_mode(struct trampoline_header *th)
> 
> 


