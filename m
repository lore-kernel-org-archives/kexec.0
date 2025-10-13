Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15547CCD183
	for <kexec@archiver.kernel.org>; Mon, 13 Oct 2025 14:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=91rYI2vMdFaeelqR6EO7cjHmJcFvcuwMoHwsL+HZWMA=; b=wnAdcVHCgVnDdbKWscS4rP9CIf
	Zuwg3v3fmedZlpGGDFzekpqNe/p2CF8fPlCdIrENKXXW/qQPg93p46wT1bZZb0r+7fvq8g5Dq68QC
	e0SvCTlkKBcmq+az9PkqWnI/h5JcWFqbGoXVo+B4hnxgc4ZOCLmFD9FQ6M2Gu0KCZDy6wHAm68NCR
	uugdDmt/yZWj1/th7F8NVNVyXnXYJCiY7FPNR7MiAViewYkonq5O/WN2lvQlgdfjJvRNfX46hB9Wj
	wgfgCc5Usb4FzJGU6ez714Rnpk9SGcgK/jlGdbJ7EOXw+E6vCgwUnfguOeqYKc0MjZg9fE4mRkecE
	f1j69mRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8K1V-0000000DXVo-3FiG;
	Mon, 13 Oct 2025 14:59:41 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8K1T-0000000DXUX-0MHH;
	Mon, 13 Oct 2025 14:59:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id AB6C1404E2;
	Mon, 13 Oct 2025 14:59:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87EC5C4CEE7;
	Mon, 13 Oct 2025 14:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760367578;
	bh=Q4amGCgEx94K8om8pN467kDbQql6OA0eh29fHknE5Fw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WTk8n4FzwfU+JNjoGVR3OOl9hk+bHZHl0+w5GZRjNYV4kcGnUqw90e8JkiIMYKBVG
	 NcRsWksnrwcNhPIi5h+FE6/w7V49pHEpvBJWDcfp0XXxUphNZwlLcwqTdOS2Xv5h7H
	 Ul0xhpRLHAp0v3U+9tWebDkckBTJyEpUQ7VkzJRTjJ7rMvZEqDE56NUEyhKX1KF1zu
	 LtNnj2IWLDizfR5k0EAVLhiypzbKxwaeEPrWlIC63tsQcyvoiy5YWWAZ6X69XXqsee
	 FAkG/CwJmqtbCg+OysuPgKOrseEsQDQlXtHMNhTe2lx3PAI0wJ8StKBXuFCzGviqs2
	 SmK2gwrIbAo8g==
From: Pratyush Yadav <pratyush@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Changyuan Lyu <changyuanl@google.com>,  rppt@kernel.org,
  akpm@linux-foundation.org,  linux-kernel@vger.kernel.org,
  anthony.yznaga@oracle.com,  arnd@arndb.de,  ashish.kalra@amd.com,
  benh@kernel.crashing.org,  bp@alien8.de,  catalin.marinas@arm.com,
  corbet@lwn.net,  dave.hansen@linux.intel.com,
  devicetree@vger.kernel.org,  dwmw2@infradead.org,  ebiederm@xmission.com,
  graf@amazon.com,  hpa@zytor.com,  jgowans@amazon.com,
  kexec@lists.infradead.org,  krzk@kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-doc@vger.kernel.org,
  linux-mm@kvack.org,  luto@kernel.org,  mark.rutland@arm.com,
  mingo@redhat.com,  pasha.tatashin@soleen.com,  pbonzini@redhat.com,
  peterz@infradead.org,  robh@kernel.org,  rostedt@goodmis.org,
  saravanak@google.com,  skinsburskii@linux.microsoft.com,
  tglx@linutronix.de,  thomas.lendacky@amd.com,  will@kernel.org,
  x86@kernel.org
Subject: Re: [PATCH v8 01/17] memblock: add MEMBLOCK_RSRV_KERN flag
In-Reply-To: <ef6wfr72set5wa5el3wbbu4yd5tnc4p2rhtjpb5kpmncv3xs5d@i3c5v3ciioi3>
	(Breno Leitao's message of "Fri, 10 Oct 2025 02:33:59 -0700")
References: <20250509074635.3187114-1-changyuanl@google.com>
	<20250509074635.3187114-2-changyuanl@google.com>
	<ef6wfr72set5wa5el3wbbu4yd5tnc4p2rhtjpb5kpmncv3xs5d@i3c5v3ciioi3>
Date: Mon, 13 Oct 2025 16:59:32 +0200
Message-ID: <mafs0wm4yluej.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251013_075939_165269_5CE6BF67 
X-CRM114-Status: GOOD (  17.36  )
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

On Fri, Oct 10 2025, Breno Leitao wrote:

> Hello Chanyuan, Mike,
>
> On Fri, May 09, 2025 at 12:46:19AM -0700, Changyuan Lyu wrote:
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -492,7 +492,7 @@ static int __init_memblock memblock_double_array(struct memblock_type *type,
>>  	 * needn't do it
>>  	 */
>>  	if (!use_slab)
>> -		BUG_ON(memblock_reserve(addr, new_alloc_size));
>> +		BUG_ON(memblock_reserve_kern(addr, new_alloc_size));
>>  
>>  	/* Update slab flag */
>>  	*in_slab = use_slab;
>> @@ -642,7 +642,7 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>>  #ifdef CONFIG_NUMA
>>  			WARN_ON(nid != memblock_get_region_node(rgn));
>>  #endif
>> -			WARN_ON(flags != rgn->flags);
>> +			WARN_ON(flags != MEMBLOCK_NONE && flags != rgn->flags);
>
> I am hitting some sporadic warnings at early boot on a production kernel
> (6.16). Unfortunately this issue is not easily reproduce for me to test on
> upstream.
>
> 	09:14:44  BIOS-provided physical RAM map:
> 	09:14:44  BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
> 	09:14:44  BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
> 	09:14:44  BIOS-e820: [mem 0x0000000000100000-0x0000000064cb7fff] usable
> 	09:14:44  BIOS-e820: [mem 0x0000000064cb8000-0x0000000064dc3fff] reserved
> 	09:14:44  BIOS-e820: [mem 0x0000000064dc4000-0x0000000065b13fff] usable
> 	09:14:44  BIOS-e820: [mem 0x0000000065b14000-0x0000000065b61fff] reserved
> 	09:14:44  BIOS-e820: [mem 0x0000000065b62000-0x0000000065ed0fff] usable
> 	09:14:44  BIOS-e820: [mem 0x0000000065ed1000-0x0000000065f2bfff] reserved
> 	09:14:44  BIOS-e820: [mem 0x0000000065f2c000-0x0000000066621fff] usable
> 	09:14:44  BIOS-e820: [mem 0x0000000066622000-0x0000000066630fff] reserved
> 	09:14:44  BIOS-e820: [mem 0x0000000066631000-0x0000000068107fff] usable
> 	09:14:44  BIOS-e820: [mem 0x0000000068108000-0x000000006819dfff] ACPI data
> 	09:14:44  BIOS-e820: [mem 0x000000006819e000-0x000000006a48cfff] usable
> 	09:14:44  BIOS-e820: [mem 0x000000006a48d000-0x000000006c58cfff] reserved
> 	09:14:44  BIOS-e820: [mem 0x000000006c58d000-0x000000006c5dcfff] ACPI data
> 	09:14:44  BIOS-e820: [mem 0x000000006c5dd000-0x000000006cfdcfff] ACPI NVS
> 	09:14:44  BIOS-e820: [mem 0x000000006cfdd000-0x000000006e9fcfff] reserved
> 	09:14:44  BIOS-e820: [mem 0x000000006e9fd000-0x000000006fffffff] usable
> 	09:14:44  BIOS-e820: [mem 0x0000000070000000-0x000000008fffffff] reserved
> 	09:14:44  BIOS-e820: [mem 0x00000000fd000000-0x00000000fe7fffff] reserved
> 	09:14:44  BIOS-e820: [mem 0x00000000fed20000-0x00000000fed44fff] reserved
> 	09:14:44  BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
> 	09:14:44  BIOS-e820: [mem 0x0000000100000000-0x000000107fff655f] usable
> 	09:14:44  BIOS-e820: [mem 0x000000107fff6560-0x000000107fff656f] type 128
> 	09:14:44  BIOS-e820: [mem 0x000000107fff6570-0x000000107fffffff] usable
> 	09:14:44  random: crng init done
> 	09:14:44  ------------[ cut here ]------------
> 	09:14:44 WARNING: CPU: 0 PID: 0 at mm/memblock.c:668 memblock_add_range (mm/memblock.c:668)
> 	09:14:44  Modules linked in:
> 	09:14:44  Tainted: [S]=CPU_OUT_OF_SPEC
> 	09:14:44 RIP: 0010:memblock_add_range (mm/memblock.c:668)
> 	09:14:44 Code: 28 80 3c 01 00 0f 84 04 fd ff ff 4c 89 ef e8 6c 77 09 00 e9 f7 fc ff ff 0f 0b 83 7c 24 1c 00 0f 85 9c fd ff ff e9 c5 fd ff ff <0f> 0b e9 be fd ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 6b fd
> 	All code
> 	========
> 	0:    28 80 3c 01 00 0f        sub    %al,0xf00013c(%rax)
> 	6:    84 04 fd ff ff 4c 89     test   %al,-0x76b30001(,%rdi,8)
> 	d:    ef                       out    %eax,(%dx)
> 	e:    e8 6c 77 09 00           call   0x9777f
> 	13:    e9 f7 fc ff ff           jmp    0xfffffffffffffd0f
> 	18:    0f 0b                    ud2
> 	1a:    83 7c 24 1c 00           cmpl   $0x0,0x1c(%rsp)
> 	1f:    0f 85 9c fd ff ff        jne    0xfffffffffffffdc1
> 	25:    e9 c5 fd ff ff           jmp    0xfffffffffffffdef
> 	2a:*    0f 0b                    ud2            <-- trapping instruction
> 	2c:    e9 be fd ff ff           jmp    0xfffffffffffffdef
> 	31:    44 89 f1                 mov    %r14d,%ecx
> 	34:    80 e1 07                 and    $0x7,%cl
> 	37:    80 c1 03                 add    $0x3,%cl
> 	3a:    38 c1                    cmp    %al,%cl
> 	3c:    0f                       .byte 0xf
> 	3d:    8c 6b fd                 mov    %gs,-0x3(%rbx)
>
> 	Code starting with the faulting instruction
> 	===========================================
> 	0:    0f 0b                    ud2
> 	2:    e9 be fd ff ff           jmp    0xfffffffffffffdc5
> 	7:    44 89 f1                 mov    %r14d,%ecx
> 	a:    80 e1 07                 and    $0x7,%cl
> 	d:    80 c1 03                 add    $0x3,%cl
> 	10:    38 c1                    cmp    %al,%cl
> 	12:    0f                       .byte 0xf
> 	13:    8c 6b fd                 mov    %gs,-0x3(%rbx)
> 	09:14:44  RSP: 0000:ffffffff85e07d48 EFLAGS: 00010083 ORIG_RAX: 0000000000000000
> 	09:14:44  RAX: 0000000000000020 RBX: 0000000000001c00 RCX: dffffc0000000000
> 	09:14:44  RDX: 000000000009f000 RSI: 000000000009d000 RDI: ffffffff8685ebf8
> 	09:14:44  RBP: 0000000000000002 R08: 0000000000000020 R09: 0000000000000000
> 	09:14:44  R10: ffffffffff200570 R11: fffffbffffe400b2 R12: 000000000009d000
> 	09:14:44  R13: 0000000000100000 R14: ffffffff8edf5ce4 R15: ffffffff8edf5ce0
> 	09:14:44  FS:  0000000000000000(0000) GS:0000000000000000(0000) knlGS:0000000000000000
> 	09:14:44  CR2: ffff888059e2dff8 CR3: 000000005bc1d000 CR4: 00000000000000b0
> 	09:14:44  Call Trace:
> 	09:14:44   <TASK>
> 	09:14:44 ? __memblock_reserve (mm/memblock.c:936)
> 	09:14:44 ? add_early_ima_buffer (arch/x86/kernel/setup.c:413)
> 	09:14:44 ? parse_setup_data (arch/x86/kernel/setup.c:500)
> 	09:14:44 ? setup_arch (arch/x86/kernel/setup.c:245 arch/x86/kernel/setup.c:958)
> 	09:14:44 ? start_kernel (init/main.c:922)
> 	09:14:44 ? x86_64_start_reservations (arch/x86/kernel/ebda.c:57)
> 	09:14:44 ? x86_64_start_kernel (arch/x86/kernel/head64.c:231)
> 	09:14:44 ? common_startup_64 (arch/x86/kernel/head_64.S:419)
> 	09:14:44   </TASK>
> 	....
> 	Memory: 49640988K/66772816K available (54946K kernel code, 19058K rwdata, 22636K rodata, 2940K init, 120968K bss, 10650188K reserved, 6291456K cma-reserved)
>
> So, there is a memory override, and I am curious about it. Do you think it

Yeah, it seems IMA is reserving a region that overlaps a region reserved
by something else that doesn't use memblock_reserve_kern().

> would be useful to expand this warning to dump more information about the
> issue? (only compiled tested)
>
> 	if (flags != MEMBLOCK_NONE && flags != rgn->flags) {
> 		pr_warn("memblock: Flag mismatch at region [%pa-%pa]\n",
> 			&rgn->base, &rend);
> 		pr_warn("  Existing region flags: %#x\n", rgn->flags);
> 		pr_warn("  New range flags: %#x\n", flags);
> 		pr_warn("  New range: [%pa-%pa]\n", &base, &end);
> 		WARN_ON_ONCE(1);
> 	}

I suppose this would be useful. I think enabling memblock debug prints
would also be helpful (using the "memblock=debug" commandline parameter)
if it doesn't impact your production environment too much.

-- 
Regards,
Pratyush Yadav

