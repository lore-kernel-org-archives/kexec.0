Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B46A8CFD353
	for <kexec@archiver.kernel.org>; Mon, 24 Nov 2025 19:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9jk37GvM71JhaWd5rL6T9q167IOkQkimPTz38uVA1jc=; b=4uz5qF8kEP1LZrnsaqhIH4cRuU
	rPrgcdx/MZ/m9PWlKfpzlTHozi+EgXQniEthejfaNRygejs/ut6BoZhgK9xw3v8aHwvXTJvzyZxWn
	eox98+uy1AwqyeKvfVD07yiSdhGK2T5Kp6iGaKWBo5BSO5v/kWxgQ+2F03qubhguTDoiY4ztqSQ4F
	smqOxAG9vs0XVo/UHbE8Q85MD8R9dzF5ezD6ck//us4nRZ32qCyXQgKpudlhgEbyop5OTY8gs1XGg
	bPuS6TFBZMQsVEoEQGJcOJBRRVLtNAFsl8ywO6aseqU4fnVe1dvVabIowNjOTpiYTOeTQxxpIRX7/
	wQh0p+CQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNcBP-0000000CF6P-3cPd;
	Mon, 24 Nov 2025 19:25:07 +0000
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNcBM-0000000CF5b-2rWK
	for kexec@lists.infradead.org;
	Mon, 24 Nov 2025 19:25:06 +0000
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-477b1cc8fb4so26956375e9.1
        for <kexec@lists.infradead.org>; Mon, 24 Nov 2025 11:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764012302; x=1764617102; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9jk37GvM71JhaWd5rL6T9q167IOkQkimPTz38uVA1jc=;
        b=DKEjNMT7IIWbxzBSjO1CC8ppucB5kaqul7RgktgNyWj4P6lUCDB7sMxnylmfP2RdvF
         9nEln/KmtDd2Gu086j9G2WHYJmpmLWFJbB+hQ0MqP5Y2WOKheSUi68Meij89dmYkN7D9
         DvUd2VbZFa9HJJazUsVz467JKRDEelxkkRHLFf73jExpNsw6v0Jcd4r5r9XM9JL3VhXX
         cerjZdEngbzsxsYRfh8o0VPfc1zYt/sQNEwe9mKp39ltLSK5rV/4PMeTK2uyWZy6iV4B
         Rr3BR+iNEEErvqgfC6iWDsSZQBT/cff4EO5wytqhuqe2gaB5BHmMriRDxRn5MzjbbKFT
         VevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764012302; x=1764617102;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9jk37GvM71JhaWd5rL6T9q167IOkQkimPTz38uVA1jc=;
        b=JfIlT3MA0lMhMMyiiCQmhSw0lr1Cc8N82gNZ53HfA7YqVOlv2+HjLNYF9EByEXauwO
         Cyl/U5AQFzGNWdnppO500ePmgNESY0dXtnppGTyrW12ftAU4UhMfQoMbwuQMR0ySCc25
         zWtmk3IHyP+6x12wcBn5TacIKc6BdSqFtyepQqLOQiRPfrFsQMH1WTiJ/JzSasGcwAoW
         OtfUKx6MylefSPR0xBqhuj21u5rjhNh1Cq97RUzNtv9ZtT7fuVusINP9T5DPV8HkTGph
         ZeL2/7xgCPESbBpY9rkmCZPTHZaTGF8h2Jl2QClPaMXYZWWNoEid4GxPlhaKZ137Atai
         MmvA==
X-Forwarded-Encrypted: i=1; AJvYcCV869RIrByduKsCxDLrCCrCZOXy7RjiQw7uS1rr1um/6tgK5X9nyyrclbVFj7d7QdfCtCcsqg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyQIDgB2CGgHsjSFh816ALVpRGkRkvY7wOxAs+Va6bGrUnVHboD
	3r2h+zsWb0n1dPSt9/IuCEBoXcS7nkNdq2tZ6DobIuvvSENBT/C2Rv+v
X-Gm-Gg: ASbGncsOUNvbWTlm7SR8aZY6IoKyO0JE3iJ13nVh0r0TCHmajAhux3MnKcFNjiKmxcB
	pMHUn385lLKZoDJsQeEzHI5XEdg+diT3qespvvZ/woeSuPHbEG26imL4XVmX5L/UEnCzE1AMPGO
	wQXSpNGSF6r0oWTOFWgDrwYLewmbxBMhhc0ubnUVNjXy6DblB3fyiSK0x8PxsWD2/oceArghBoM
	AGk8DagyTvtcEAjIThaJNRmZ7X3G2AQtCJHVH6S09bqBigG1aXwxYAjkB47XlHs8Y5kMQw13AKj
	NRXH6zN6g1/o6/ev8jhUzl0ETxuq13Nod/OOKaFFZRzztMovS3uFr5nxqwmqya0o/I93qpK4Vki
	D/4l+H4pG/PNQwIzPfSOs0P9ykh2lHBfpPOQVotDdj1seZSixZfkpjNa26D/3ms4/1bBIaDgo9B
	5QKWk92QIXKKA8Iio6iVYdlq6cO3n1T8QvP4wKGxbsMzqQubmq14Kr8r6aWBM+1sQ=
X-Google-Smtp-Source: AGHT+IFeHLsoYr2AmZntomxO2DLGMgEciJ8EAmlBYd3tNaV7xwLFtpLjqhrJ3Jk53gAvqzID4Fk9Ww==
X-Received: by 2002:a05:600c:3115:b0:477:b48d:ba7a with SMTP id 5b1f17b1804b1-477c01fd202mr126949555e9.32.1764012302165;
        Mon, 24 Nov 2025 11:25:02 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:ce0:a4eb:eabc:d420? ([2620:10d:c092:500::5:5b96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf3ba1b4sm214863705e9.15.2025.11.24.11.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 11:25:01 -0800 (PST)
Message-ID: <a0f875f1-45ad-4dfc-b5c8-ecb51b242523@gmail.com>
Date: Mon, 24 Nov 2025 19:24:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 12/17] x86/e820: temporarily enable KHO scratch for
 memory below 1M
To: Changyuan Lyu <changyuanl@google.com>, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>
Cc: anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com,
 benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com,
 corbet@lwn.net, dave.hansen@linux.intel.com, devicetree@vger.kernel.org,
 dwmw2@infradead.org, ebiederm@xmission.com, graf@amazon.com, hpa@zytor.com,
 jgowans@amazon.com, kexec@lists.infradead.org, krzk@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, luto@kernel.org, mark.rutland@arm.com, mingo@redhat.com,
 pasha.tatashin@soleen.com, pbonzini@redhat.com, peterz@infradead.org,
 ptyadav@amazon.de, robh@kernel.org, rostedt@goodmis.org, rppt@kernel.org,
 saravanak@google.com, skinsburskii@linux.microsoft.com, tglx@linutronix.de,
 thomas.lendacky@amd.com, will@kernel.org, x86@kernel.org,
 Breno Leitao <leitao@debian.org>, thevlad@meta.com
References: <20250509074635.3187114-1-changyuanl@google.com>
 <20250509074635.3187114-13-changyuanl@google.com>
Content-Language: en-GB
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250509074635.3187114-13-changyuanl@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251124_112504_771364_44C0A54E 
X-CRM114-Status: GOOD (  27.52  )
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



On 09/05/2025 08:46, Changyuan Lyu wrote:
> From: Alexander Graf <graf@amazon.com>
> 
> KHO kernels are special and use only scratch memory for memblock
> allocations, but memory below 1M is ignored by kernel after early boot
> and cannot be naturally marked as scratch.
> 
> To allow allocation of the real-mode trampoline and a few (if any) other
> very early allocations from below 1M forcibly mark the memory below 1M
> as scratch.
> 
> After real mode trampoline is allocated, clear that scratch marking.
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Co-developed-by: Changyuan Lyu <changyuanl@google.com>
> Signed-off-by: Changyuan Lyu <changyuanl@google.com>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> ---
>  arch/x86/kernel/e820.c   | 18 ++++++++++++++++++
>  arch/x86/realmode/init.c |  2 ++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index 9920122018a0b..c3acbd26408ba 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -1299,6 +1299,24 @@ void __init e820__memblock_setup(void)
>  		memblock_add(entry->addr, entry->size);
>  	}
>  
> +	/*
> +	 * At this point memblock is only allowed to allocate from memory
> +	 * below 1M (aka ISA_END_ADDRESS) up until direct map is completely set
> +	 * up in init_mem_mapping().
> +	 *
> +	 * KHO kernels are special and use only scratch memory for memblock
> +	 * allocations, but memory below 1M is ignored by kernel after early
> +	 * boot and cannot be naturally marked as scratch.
> +	 *
> +	 * To allow allocation of the real-mode trampoline and a few (if any)
> +	 * other very early allocations from below 1M forcibly mark the memory
> +	 * below 1M as scratch.
> +	 *
> +	 * After real mode trampoline is allocated, we clear that scratch
> +	 * marking.
> +	 */
> +	memblock_mark_kho_scratch(0, SZ_1M);
> +
>  	/*
>  	 * 32-bit systems are limited to 4BG of memory even with HIGHMEM and
>  	 * to even less without it.
> diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
> index f9bc444a3064d..9b9f4534086d2 100644
> --- a/arch/x86/realmode/init.c
> +++ b/arch/x86/realmode/init.c
> @@ -65,6 +65,8 @@ void __init reserve_real_mode(void)
>  	 * setup_arch().
>  	 */
>  	memblock_reserve(0, SZ_1M);
> +
> +	memblock_clear_kho_scratch(0, SZ_1M);
>  }
>  
>  static void __init sme_sev_setup_real_mode(struct trampoline_header *th)

Hello!

I am working with Breno who reported that we are seeing the below warning at boot
when rolling out 6.16 in Meta fleet. It is difficult to reproduce on a single host
manually but we are seeing this several times a day inside the fleet.

 20:16:33  ------------[ cut here ]------------
 20:16:33  WARNING: CPU: 0 PID: 0 at mm/memblock.c:668 memblock_add_range+0x316/0x330
 20:16:33  Modules linked in:
 20:16:33  CPU: 0 UID: 0 PID: 0 Comm: swapper Tainted: G S                  6.16.1-0_fbk0_0_gc0739ee5037a #1 NONE 
 20:16:33  Tainted: [S]=CPU_OUT_OF_SPEC
 20:16:33  RIP: 0010:memblock_add_range+0x316/0x330
 20:16:33  Code: ff ff ff 89 5c 24 08 41 ff c5 44 89 6c 24 10 48 63 74 24 08 48 63 54 24 10 e8 26 0c 00 00 e9 41 ff ff ff 0f 0b e9 af fd ff ff <0f> 0b e9 b7 fd ff ff 0f 0b 0f 0b cc cc cc cc cc cc cc cc cc cc cc
 20:16:33  RSP: 0000:ffffffff83403dd8 EFLAGS: 00010083 ORIG_RAX: 0000000000000000
 20:16:33  RAX: ffffffff8476ff90 RBX: 0000000000001c00 RCX: 0000000000000002
 20:16:33  RDX: 00000000ffffffff RSI: 0000000000000000 RDI: ffffffff83bad4d8
 20:16:33  RBP: 000000000009f000 R08: 0000000000000020 R09: 8000000000097101
 20:16:33  R10: ffffffffff2004b0 R11: 203a6d6f646e6172 R12: 000000000009ec00
 20:16:33  R13: 0000000000000002 R14: 0000000000100000 R15: 000000000009d000
 20:16:33  FS:  0000000000000000(0000) GS:0000000000000000(0000) knlGS:0000000000000000
 20:16:33  CR2: ffff888065413ff8 CR3: 00000000663b7000 CR4: 00000000000000b0
 20:16:33  Call Trace:
 20:16:33   <TASK>
 20:16:33   ? __memblock_reserve+0x75/0x80
 20:16:33   ? setup_arch+0x30f/0xb10
 20:16:33   ? start_kernel+0x58/0x960
 20:16:33   ? x86_64_start_reservations+0x20/0x20
 20:16:33   ? x86_64_start_kernel+0x13d/0x140
 20:16:33   ? common_startup_64+0x13e/0x140
 20:16:33   </TASK>
 20:16:33  ---[ end trace 0000000000000000 ]--- 


Rolling out with memblock=debug is not really an option in a large scale fleet due to the
time added to boot. But I did try on one of the hosts (without reproducing the issue) and I see:

[    0.000616]  memory.cnt  = 0x6
[    0.000617]  memory[0x0]	[0x0000000000001000-0x000000000009bfff], 0x000000000009b000 bytes flags: 0x40
[    0.000620]  memory[0x1]	[0x000000000009f000-0x000000000009ffff], 0x0000000000001000 bytes flags: 0x40
[    0.000621]  memory[0x2]	[0x0000000000100000-0x000000005ed09fff], 0x000000005ec0a000 bytes flags: 0x0
...

The 0x40 (MEMBLOCK_KHO_SCRATCH) is coming from memblock_mark_kho_scratch in e820__memblock_setup. I believe this
should be under ifdef like the diff at the end? (Happy to send this as a patch for review if it makes sense).
We have KEXEC_HANDOVER disabled in our defconfig, therefore MEMBLOCK_KHO_SCRATCH shouldnt be selected and
we shouldnt have any MEMBLOCK_KHO_SCRATCH type regions in our memblock reservations.

The other thing I did was insert a while(1) just before the warning and inspected the registers in qemu.
R14 held the base register, and R15 held the size at that point.
In the warning R14 is 0x100000 meaning that someone is reserving a region with a different flag to MEMBLOCK_NONE
at the boundary of MEMBLOCK_KHO_SCRATCH.

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index c3acbd26408ba..26e4062a0bd09 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1299,6 +1299,7 @@ void __init e820__memblock_setup(void)
                memblock_add(entry->addr, entry->size);
        }
 
+#ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
        /*
         * At this point memblock is only allowed to allocate from memory
         * below 1M (aka ISA_END_ADDRESS) up until direct map is completely set
@@ -1316,7 +1317,7 @@ void __init e820__memblock_setup(void)
         * marking.
         */
        memblock_mark_kho_scratch(0, SZ_1M);
-
+#endif
        /*
         * 32-bit systems are limited to 4BG of memory even with HIGHMEM and
         * to even less without it.
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 88be32026768c..1cd80293a3e23 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -66,8 +66,9 @@ void __init reserve_real_mode(void)
         * setup_arch().
         */
        memblock_reserve(0, SZ_1M);
-
+#ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
        memblock_clear_kho_scratch(0, SZ_1M);
+#endif
 }
 
 static void __init sme_sev_setup_real_mode(struct trampoline_header *th)

