Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D625ED0E6E3
	for <kexec@archiver.kernel.org>; Tue, 25 Nov 2025 13:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fXwrcsGOzeGcA2i2pd7rin4jvEAGdwNQnI6Ofa/c+Xg=; b=jyw0+lvLRQeVDtmkLw3Ya+0yMP
	U38BSy0Q7Iy/5D+3FygcOsdOagpI4w0CIeQklj93SD09Nv7uOOzeAB/iJsxbA+PVEvHAN4hYSkGbA
	pfWd1BzPLW/F/AcS0ix/AVnZql5aM1DNuuMPpIV+9tgtVGfvX4FRXKHXU2kQJVdXDAHFa+HLYUwUf
	PMZ2lpJZu2sCwpFXYejTtjlKTxeK7hOzbQ9oscL30yb3T/y6Fv/H5HPk64uxfCjev8s/5nCNGinHM
	UQlKT3fXDGYtxLTpDTDGDRuqcCL7IEefKLWZQC9vZEkJRJfcGXLaN6p3TMESDyYLqbELO13BcQ7cO
	zJzIwt7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNstV-0000000DKRG-1SpL;
	Tue, 25 Nov 2025 13:15:45 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNstT-0000000DKQv-0i7v;
	Tue, 25 Nov 2025 13:15:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D7B6F6014E;
	Tue, 25 Nov 2025 13:15:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D137FC4CEF1;
	Tue, 25 Nov 2025 13:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764076541;
	bh=xyeAb8HK2fahKTFKKpRAL4i0ZxzwGkco4WoE+HqG/is=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ASXrhPsa3i6t+6CdTp8v5KWjJs1sf9rqFTuzxudbTrrAhu/q0W8ZGbjN1K20e+iDo
	 205vJs3L9pkqFzjE1+HW7DTV7jrEdcDYd24SFyCVVnDTX/wNahnOd4Qk68Z00J8kXr
	 j1EUasFL/9VUSInsbdCYWce15cb5xFhleXGzyHy86wq3/CwNrXdMhvVrbdbwIfnv9z
	 hPmpOxAd9NYhjoyjco93WWyazGjSNWlNkszP0XtmRsjPMJ6z4t9rTrG8MsUBLPsd1q
	 WHW9cg96yPY9fpYkNVEOZLuzrC8Qr29uF3tWpAYeailnWxDzxKVSoWaleM9Hqkusy3
	 TBzWlxFPukOsg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Changyuan Lyu <changyuanl@google.com>,  akpm@linux-foundation.org,
  linux-kernel@vger.kernel.org,  Mike Rapoport <rppt@kernel.org>,
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
  x86@kernel.org,  Breno Leitao <leitao@debian.org>,  thevlad@meta.com
Subject: Re: [PATCH v8 12/17] x86/e820: temporarily enable KHO scratch for
 memory below 1M
In-Reply-To: <a0f875f1-45ad-4dfc-b5c8-ecb51b242523@gmail.com> (Usama Arif's
	message of "Mon, 24 Nov 2025 19:24:58 +0000")
References: <20250509074635.3187114-1-changyuanl@google.com>
	<20250509074635.3187114-13-changyuanl@google.com>
	<a0f875f1-45ad-4dfc-b5c8-ecb51b242523@gmail.com>
Date: Tue, 25 Nov 2025 14:15:34 +0100
Message-ID: <mafs01plmxngp.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Mon, Nov 24 2025, Usama Arif wrote:

> On 09/05/2025 08:46, Changyuan Lyu wrote:
>> From: Alexander Graf <graf@amazon.com>
>> 
>> KHO kernels are special and use only scratch memory for memblock
>> allocations, but memory below 1M is ignored by kernel after early boot
>> and cannot be naturally marked as scratch.
>> 
>> To allow allocation of the real-mode trampoline and a few (if any) other
>> very early allocations from below 1M forcibly mark the memory below 1M
>> as scratch.
>> 
>> After real mode trampoline is allocated, clear that scratch marking.
>> 
>> Signed-off-by: Alexander Graf <graf@amazon.com>
>> Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> Co-developed-by: Changyuan Lyu <changyuanl@google.com>
>> Signed-off-by: Changyuan Lyu <changyuanl@google.com>
>> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
>> ---
>>  arch/x86/kernel/e820.c   | 18 ++++++++++++++++++
>>  arch/x86/realmode/init.c |  2 ++
>>  2 files changed, 20 insertions(+)
>> 
>> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
>> index 9920122018a0b..c3acbd26408ba 100644
>> --- a/arch/x86/kernel/e820.c
>> +++ b/arch/x86/kernel/e820.c
>> @@ -1299,6 +1299,24 @@ void __init e820__memblock_setup(void)
>>  		memblock_add(entry->addr, entry->size);
>>  	}
>>  
>> +	/*
>> +	 * At this point memblock is only allowed to allocate from memory
>> +	 * below 1M (aka ISA_END_ADDRESS) up until direct map is completely set
>> +	 * up in init_mem_mapping().
>> +	 *
>> +	 * KHO kernels are special and use only scratch memory for memblock
>> +	 * allocations, but memory below 1M is ignored by kernel after early
>> +	 * boot and cannot be naturally marked as scratch.
>> +	 *
>> +	 * To allow allocation of the real-mode trampoline and a few (if any)
>> +	 * other very early allocations from below 1M forcibly mark the memory
>> +	 * below 1M as scratch.
>> +	 *
>> +	 * After real mode trampoline is allocated, we clear that scratch
>> +	 * marking.
>> +	 */
>> +	memblock_mark_kho_scratch(0, SZ_1M);
>> +
>>  	/*
>>  	 * 32-bit systems are limited to 4BG of memory even with HIGHMEM and
>>  	 * to even less without it.
>> diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
>> index f9bc444a3064d..9b9f4534086d2 100644
>> --- a/arch/x86/realmode/init.c
>> +++ b/arch/x86/realmode/init.c
>> @@ -65,6 +65,8 @@ void __init reserve_real_mode(void)
>>  	 * setup_arch().
>>  	 */
>>  	memblock_reserve(0, SZ_1M);
>> +
>> +	memblock_clear_kho_scratch(0, SZ_1M);
>>  }
>>  
>>  static void __init sme_sev_setup_real_mode(struct trampoline_header *th)
>
> Hello!
>
> I am working with Breno who reported that we are seeing the below warning at boot
> when rolling out 6.16 in Meta fleet. It is difficult to reproduce on a single host
> manually but we are seeing this several times a day inside the fleet.
>
>  20:16:33  ------------[ cut here ]------------
>  20:16:33  WARNING: CPU: 0 PID: 0 at mm/memblock.c:668 memblock_add_range+0x316/0x330
>  20:16:33  Modules linked in:
>  20:16:33  CPU: 0 UID: 0 PID: 0 Comm: swapper Tainted: G S                  6.16.1-0_fbk0_0_gc0739ee5037a #1 NONE 
>  20:16:33  Tainted: [S]=CPU_OUT_OF_SPEC
>  20:16:33  RIP: 0010:memblock_add_range+0x316/0x330
>  20:16:33  Code: ff ff ff 89 5c 24 08 41 ff c5 44 89 6c 24 10 48 63 74 24 08 48 63 54 24 10 e8 26 0c 00 00 e9 41 ff ff ff 0f 0b e9 af fd ff ff <0f> 0b e9 b7 fd ff ff 0f 0b 0f 0b cc cc cc cc cc cc cc cc cc cc cc
>  20:16:33  RSP: 0000:ffffffff83403dd8 EFLAGS: 00010083 ORIG_RAX: 0000000000000000
>  20:16:33  RAX: ffffffff8476ff90 RBX: 0000000000001c00 RCX: 0000000000000002
>  20:16:33  RDX: 00000000ffffffff RSI: 0000000000000000 RDI: ffffffff83bad4d8
>  20:16:33  RBP: 000000000009f000 R08: 0000000000000020 R09: 8000000000097101
>  20:16:33  R10: ffffffffff2004b0 R11: 203a6d6f646e6172 R12: 000000000009ec00
>  20:16:33  R13: 0000000000000002 R14: 0000000000100000 R15: 000000000009d000
>  20:16:33  FS:  0000000000000000(0000) GS:0000000000000000(0000) knlGS:0000000000000000
>  20:16:33  CR2: ffff888065413ff8 CR3: 00000000663b7000 CR4: 00000000000000b0
>  20:16:33  Call Trace:
>  20:16:33   <TASK>
>  20:16:33   ? __memblock_reserve+0x75/0x80
>  20:16:33   ? setup_arch+0x30f/0xb10
>  20:16:33   ? start_kernel+0x58/0x960
>  20:16:33   ? x86_64_start_reservations+0x20/0x20
>  20:16:33   ? x86_64_start_kernel+0x13d/0x140
>  20:16:33   ? common_startup_64+0x13e/0x140
>  20:16:33   </TASK>
>  20:16:33  ---[ end trace 0000000000000000 ]--- 
>
>
> Rolling out with memblock=debug is not really an option in a large scale fleet due to the
> time added to boot. But I did try on one of the hosts (without reproducing the issue) and I see:
>
> [    0.000616]  memory.cnt  = 0x6
> [    0.000617]  memory[0x0]	[0x0000000000001000-0x000000000009bfff], 0x000000000009b000 bytes flags: 0x40
> [    0.000620]  memory[0x1]	[0x000000000009f000-0x000000000009ffff], 0x0000000000001000 bytes flags: 0x40
> [    0.000621]  memory[0x2]	[0x0000000000100000-0x000000005ed09fff], 0x000000005ec0a000 bytes flags: 0x0
> ...
>
> The 0x40 (MEMBLOCK_KHO_SCRATCH) is coming from memblock_mark_kho_scratch in e820__memblock_setup. I believe this
> should be under ifdef like the diff at the end? (Happy to send this as a patch for review if it makes sense).
> We have KEXEC_HANDOVER disabled in our defconfig, therefore MEMBLOCK_KHO_SCRATCH shouldnt be selected and
> we shouldnt have any MEMBLOCK_KHO_SCRATCH type regions in our memblock reservations.
>
> The other thing I did was insert a while(1) just before the warning and inspected the registers in qemu.
> R14 held the base register, and R15 held the size at that point.
> In the warning R14 is 0x100000 meaning that someone is reserving a region with a different flag to MEMBLOCK_NONE
> at the boundary of MEMBLOCK_KHO_SCRATCH.

I don't get this... The WARN_ON() is only triggered when the regions
overlap. Here, there should be no overlap, since the scratch region
should end at 0x100000 (SZ_1M) and the new region starts at 0x100000
(SZ_1M).

Anyway, you do indeed point at a bug. memblock_mark_kho_scratch() should
only be called on a KHO boot, not unconditionally. So even with
CONFIG_MEMBLOCK_KHO_SCRATCH enabled, this should only be called on a KHO
boot, not every time.

I think the below diff should fix the warning for you by making sure the
scratch areas are not present on non-KHO boot. I still don't know why
you hit the warning in the first place though. If you'd be willing to
dig deeper into that, it would be great.

Can you give the below a try and if it fixes the problem for you I can
send it on the list.

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index c3acbd26408ba..0a34dc011bf91 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -16,6 +16,7 @@
 #include <linux/firmware-map.h>
 #include <linux/sort.h>
 #include <linux/memory_hotplug.h>
+#include <linux/kexec_handover.h>
 
 #include <asm/e820/api.h>
 #include <asm/setup.h>
@@ -1315,7 +1316,8 @@ void __init e820__memblock_setup(void)
 	 * After real mode trampoline is allocated, we clear that scratch
 	 * marking.
 	 */
-	memblock_mark_kho_scratch(0, SZ_1M);
+	if (is_kho_boot())
+		memblock_mark_kho_scratch(0, SZ_1M);
 
 	/*
 	 * 32-bit systems are limited to 4BG of memory even with HIGHMEM and
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 88be32026768c..4e9b4dff17216 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -4,6 +4,7 @@
 #include <linux/memblock.h>
 #include <linux/cc_platform.h>
 #include <linux/pgtable.h>
+#include <linux/kexec_handover.h>
 
 #include <asm/set_memory.h>
 #include <asm/realmode.h>
@@ -67,7 +68,8 @@ void __init reserve_real_mode(void)
 	 */
 	memblock_reserve(0, SZ_1M);
 
-	memblock_clear_kho_scratch(0, SZ_1M);
+	if (is_kho_boot())
+		memblock_clear_kho_scratch(0, SZ_1M);
 }
 
 static void __init sme_sev_setup_real_mode(struct trampoline_header *th)


-- 
Regards,
Pratyush Yadav

