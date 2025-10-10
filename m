Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2739FCCA476
	for <kexec@archiver.kernel.org>; Fri, 10 Oct 2025 09:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cv4nEj7UBTV72f1gU8wuBa1ut3a9qHUaWAVjisQOCJo=; b=y5e1l+fbrGYu1gbloBXHqDnvOY
	JBqr5Kt4MwWC6Hu5ljNgt+UeZBzL4Lx1i57gz8K9J8OAxSfpnivPHGAfcy+jB3z3GF8mNKRFvvbqY
	VYC6wwLhWQMjx1UE15lQxQefEv+GUzdrL3ZD50rPl4upWRYmdjvrQwMYUIjIB05+W6xOYxpIxenm0
	TPrtKWlLhtRua0FGhwRuTZT7IerSDU37/MpZzqWwiCYz5gU+iCeMGkSXEEhgsUdxp4H9SrWgdFhSh
	8e/JyQWneld5kYJEU5aE/NN7Ttbf1SDRoxtMCHid5CxA84kt2CO3+IuevbZ9fQgIeXWG3Vz4fVR5c
	4SyFZ+Og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v79Vo-00000008AcM-0Y0e;
	Fri, 10 Oct 2025 09:34:08 +0000
Received: from mail-ed1-f53.google.com ([209.85.208.53])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v79Vl-00000008Ab2-3nxk
	for kexec@lists.infradead.org;
	Fri, 10 Oct 2025 09:34:07 +0000
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6349e3578adso3477704a12.1
        for <kexec@lists.infradead.org>; Fri, 10 Oct 2025 02:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760088843; x=1760693643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cv4nEj7UBTV72f1gU8wuBa1ut3a9qHUaWAVjisQOCJo=;
        b=aRGoMt+uzjDHcGVTzBxdpPkpn7vbzABlYfj9s+QAlciLgXN7BIYCS+DA6jwiRev3hH
         sNKuV6y0ibTgEXyQrV9FJUWlL2d5Tq3zrOqw+rrTmSplZ/b+BS7KQyvJJIPc3YbCU4+i
         wVdANMW1YtsRRhLhtSidGtb2O7XfC5dBlH+fAqwq5r7J9BfAuIyiUAUjZosz0SNN4S0I
         lw5zPgUWaHtccGjKIjUt348jnwIGBvGOo8Ys062ztKs0ASDtcAnSvdmHXpWb3ZjY5mEn
         drTz45aVs3iLRdJMa3RzZPK5vcowZxmjwzJPYJ6eBeKIIoYmL7kXLkEgBDqnRSIZAHxG
         f5mA==
X-Forwarded-Encrypted: i=1; AJvYcCUOHHcBvVjTqU5CG1FW8xOOnDWm2fpm6prEdrpVW8X33+fOftlT190x2fTA7BFJa+cwrSSVCA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxA1GWv4ion9zCvhCZHoD+nH/mbXRoFc3PkLrbmoodMOjStzUrU
	Fu/HdUsMJAoxY+4REZ0ehyiM/ipYdyYQfE/cNHrNEaxHa4tCg+loI4Gf
X-Gm-Gg: ASbGnctXt0LND0wXjzmp5nsEkEFFU5r/t2q8vA1npwgrbzf+dkTUeD3CZ/2ZUV8NqPC
	eTKVdiInJ/hSsemRZ4lf18W9hCVy5HFmOcdFKPprY1UHvux5rr/HwYzA+J9z8aGAFXlp+GgNIAz
	Pnppga+QQI0fIE0V+MwhKEX6WiwFZt9wfq+CQ9KyVUzuebAzB1VPpuQE4BJqMBTtFLYXJVUeBZp
	LeMhLXmelPbIr+MCOri34CFIiOTIdfCc9E4YBkRdlqfET4/4S5iftwagZ1WpqwD1jQUb8LaN2+C
	HyPV7CqmUS+oJfgBavPLV0zQOEOMVB/oMLGhn7LZQOoiHpip5siBQLAgxtdD2JKT13NVnHk+Fol
	S+4+HiE/irlAXzrK2hme8ihR5gEk2ck/m90ty
X-Google-Smtp-Source: AGHT+IHJJZYzLmff6dVgniqDgTA9wuOtJBZMe0+HaoaCcR6f3ALYVARpNqjkBuP0lUSeRtOHCgzETA==
X-Received: by 2002:a17:906:6b9a:b0:b45:1063:fb65 with SMTP id a640c23a62f3a-b50abaafd40mr960927966b.39.1760088843318;
        Fri, 10 Oct 2025 02:34:03 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d9a3fc41sm190057566b.87.2025.10.10.02.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 02:34:02 -0700 (PDT)
Date: Fri, 10 Oct 2025 02:33:59 -0700
From: Breno Leitao <leitao@debian.org>
To: Changyuan Lyu <changyuanl@google.com>, rppt@kernel.org
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com, benh@kernel.crashing.org, 
	bp@alien8.de, catalin.marinas@arm.com, corbet@lwn.net, 
	dave.hansen@linux.intel.com, devicetree@vger.kernel.org, dwmw2@infradead.org, 
	ebiederm@xmission.com, graf@amazon.com, hpa@zytor.com, jgowans@amazon.com, 
	kexec@lists.infradead.org, krzk@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org, mark.rutland@arm.com, 
	mingo@redhat.com, pasha.tatashin@soleen.com, pbonzini@redhat.com, 
	peterz@infradead.org, ptyadav@amazon.de, robh@kernel.org, rostedt@goodmis.org, 
	rppt@kernel.org, saravanak@google.com, skinsburskii@linux.microsoft.com, 
	tglx@linutronix.de, thomas.lendacky@amd.com, will@kernel.org, x86@kernel.org
Subject: Re: [PATCH v8 01/17] memblock: add MEMBLOCK_RSRV_KERN flag
Message-ID: <ef6wfr72set5wa5el3wbbu4yd5tnc4p2rhtjpb5kpmncv3xs5d@i3c5v3ciioi3>
References: <20250509074635.3187114-1-changyuanl@google.com>
 <20250509074635.3187114-2-changyuanl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509074635.3187114-2-changyuanl@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251010_023405_970022_F2160E75 
X-CRM114-Status: GOOD (  13.94  )
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

Hello Chanyuan, Mike,

On Fri, May 09, 2025 at 12:46:19AM -0700, Changyuan Lyu wrote:
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -492,7 +492,7 @@ static int __init_memblock memblock_double_array(struct memblock_type *type,
>  	 * needn't do it
>  	 */
>  	if (!use_slab)
> -		BUG_ON(memblock_reserve(addr, new_alloc_size));
> +		BUG_ON(memblock_reserve_kern(addr, new_alloc_size));
>  
>  	/* Update slab flag */
>  	*in_slab = use_slab;
> @@ -642,7 +642,7 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>  #ifdef CONFIG_NUMA
>  			WARN_ON(nid != memblock_get_region_node(rgn));
>  #endif
> -			WARN_ON(flags != rgn->flags);
> +			WARN_ON(flags != MEMBLOCK_NONE && flags != rgn->flags);

I am hitting some sporadic warnings at early boot on a production kernel
(6.16). Unfortunately this issue is not easily reproduce for me to test on
upstream.

	09:14:44  BIOS-provided physical RAM map:
	09:14:44  BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
	09:14:44  BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
	09:14:44  BIOS-e820: [mem 0x0000000000100000-0x0000000064cb7fff] usable
	09:14:44  BIOS-e820: [mem 0x0000000064cb8000-0x0000000064dc3fff] reserved
	09:14:44  BIOS-e820: [mem 0x0000000064dc4000-0x0000000065b13fff] usable
	09:14:44  BIOS-e820: [mem 0x0000000065b14000-0x0000000065b61fff] reserved
	09:14:44  BIOS-e820: [mem 0x0000000065b62000-0x0000000065ed0fff] usable
	09:14:44  BIOS-e820: [mem 0x0000000065ed1000-0x0000000065f2bfff] reserved
	09:14:44  BIOS-e820: [mem 0x0000000065f2c000-0x0000000066621fff] usable
	09:14:44  BIOS-e820: [mem 0x0000000066622000-0x0000000066630fff] reserved
	09:14:44  BIOS-e820: [mem 0x0000000066631000-0x0000000068107fff] usable
	09:14:44  BIOS-e820: [mem 0x0000000068108000-0x000000006819dfff] ACPI data
	09:14:44  BIOS-e820: [mem 0x000000006819e000-0x000000006a48cfff] usable
	09:14:44  BIOS-e820: [mem 0x000000006a48d000-0x000000006c58cfff] reserved
	09:14:44  BIOS-e820: [mem 0x000000006c58d000-0x000000006c5dcfff] ACPI data
	09:14:44  BIOS-e820: [mem 0x000000006c5dd000-0x000000006cfdcfff] ACPI NVS
	09:14:44  BIOS-e820: [mem 0x000000006cfdd000-0x000000006e9fcfff] reserved
	09:14:44  BIOS-e820: [mem 0x000000006e9fd000-0x000000006fffffff] usable
	09:14:44  BIOS-e820: [mem 0x0000000070000000-0x000000008fffffff] reserved
	09:14:44  BIOS-e820: [mem 0x00000000fd000000-0x00000000fe7fffff] reserved
	09:14:44  BIOS-e820: [mem 0x00000000fed20000-0x00000000fed44fff] reserved
	09:14:44  BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
	09:14:44  BIOS-e820: [mem 0x0000000100000000-0x000000107fff655f] usable
	09:14:44  BIOS-e820: [mem 0x000000107fff6560-0x000000107fff656f] type 128
	09:14:44  BIOS-e820: [mem 0x000000107fff6570-0x000000107fffffff] usable
	09:14:44  random: crng init done
	09:14:44  ------------[ cut here ]------------
	09:14:44 WARNING: CPU: 0 PID: 0 at mm/memblock.c:668 memblock_add_range (mm/memblock.c:668)
	09:14:44  Modules linked in:
	09:14:44  Tainted: [S]=CPU_OUT_OF_SPEC
	09:14:44 RIP: 0010:memblock_add_range (mm/memblock.c:668)
	09:14:44 Code: 28 80 3c 01 00 0f 84 04 fd ff ff 4c 89 ef e8 6c 77 09 00 e9 f7 fc ff ff 0f 0b 83 7c 24 1c 00 0f 85 9c fd ff ff e9 c5 fd ff ff <0f> 0b e9 be fd ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 6b fd
	All code
	========
	0:    28 80 3c 01 00 0f        sub    %al,0xf00013c(%rax)
	6:    84 04 fd ff ff 4c 89     test   %al,-0x76b30001(,%rdi,8)
	d:    ef                       out    %eax,(%dx)
	e:    e8 6c 77 09 00           call   0x9777f
	13:    e9 f7 fc ff ff           jmp    0xfffffffffffffd0f
	18:    0f 0b                    ud2
	1a:    83 7c 24 1c 00           cmpl   $0x0,0x1c(%rsp)
	1f:    0f 85 9c fd ff ff        jne    0xfffffffffffffdc1
	25:    e9 c5 fd ff ff           jmp    0xfffffffffffffdef
	2a:*    0f 0b                    ud2            <-- trapping instruction
	2c:    e9 be fd ff ff           jmp    0xfffffffffffffdef
	31:    44 89 f1                 mov    %r14d,%ecx
	34:    80 e1 07                 and    $0x7,%cl
	37:    80 c1 03                 add    $0x3,%cl
	3a:    38 c1                    cmp    %al,%cl
	3c:    0f                       .byte 0xf
	3d:    8c 6b fd                 mov    %gs,-0x3(%rbx)

	Code starting with the faulting instruction
	===========================================
	0:    0f 0b                    ud2
	2:    e9 be fd ff ff           jmp    0xfffffffffffffdc5
	7:    44 89 f1                 mov    %r14d,%ecx
	a:    80 e1 07                 and    $0x7,%cl
	d:    80 c1 03                 add    $0x3,%cl
	10:    38 c1                    cmp    %al,%cl
	12:    0f                       .byte 0xf
	13:    8c 6b fd                 mov    %gs,-0x3(%rbx)
	09:14:44  RSP: 0000:ffffffff85e07d48 EFLAGS: 00010083 ORIG_RAX: 0000000000000000
	09:14:44  RAX: 0000000000000020 RBX: 0000000000001c00 RCX: dffffc0000000000
	09:14:44  RDX: 000000000009f000 RSI: 000000000009d000 RDI: ffffffff8685ebf8
	09:14:44  RBP: 0000000000000002 R08: 0000000000000020 R09: 0000000000000000
	09:14:44  R10: ffffffffff200570 R11: fffffbffffe400b2 R12: 000000000009d000
	09:14:44  R13: 0000000000100000 R14: ffffffff8edf5ce4 R15: ffffffff8edf5ce0
	09:14:44  FS:  0000000000000000(0000) GS:0000000000000000(0000) knlGS:0000000000000000
	09:14:44  CR2: ffff888059e2dff8 CR3: 000000005bc1d000 CR4: 00000000000000b0
	09:14:44  Call Trace:
	09:14:44   <TASK>
	09:14:44 ? __memblock_reserve (mm/memblock.c:936)
	09:14:44 ? add_early_ima_buffer (arch/x86/kernel/setup.c:413)
	09:14:44 ? parse_setup_data (arch/x86/kernel/setup.c:500)
	09:14:44 ? setup_arch (arch/x86/kernel/setup.c:245 arch/x86/kernel/setup.c:958)
	09:14:44 ? start_kernel (init/main.c:922)
	09:14:44 ? x86_64_start_reservations (arch/x86/kernel/ebda.c:57)
	09:14:44 ? x86_64_start_kernel (arch/x86/kernel/head64.c:231)
	09:14:44 ? common_startup_64 (arch/x86/kernel/head_64.S:419)
	09:14:44   </TASK>
	....
	Memory: 49640988K/66772816K available (54946K kernel code, 19058K rwdata, 22636K rodata, 2940K init, 120968K bss, 10650188K reserved, 6291456K cma-reserved)

So, there is a memory override, and I am curious about it. Do you think it
would be useful to expand this warning to dump more information about the
issue? (only compiled tested)

	if (flags != MEMBLOCK_NONE && flags != rgn->flags) {
		pr_warn("memblock: Flag mismatch at region [%pa-%pa]\n",
			&rgn->base, &rend);
		pr_warn("  Existing region flags: %#x\n", rgn->flags);
		pr_warn("  New range flags: %#x\n", flags);
		pr_warn("  New range: [%pa-%pa]\n", &base, &end);
		WARN_ON_ONCE(1);
	}

Thanks
--breno

