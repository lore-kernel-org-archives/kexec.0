Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1409CCFD36C
	for <kexec@archiver.kernel.org>; Tue, 25 Nov 2025 00:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/30Sv7hB0LicpiampkA1ftcU0prNdSbcPBoiTLyH+p8=; b=bEv07/KrwXWexY/jss5T1h4qbm
	Floci8OQSc2BmFIb9Mrajzgsu34EaETF3glPF1SQzgJmB1CLGiPfowkkI86BiOQlq98ahNMF9SLPl
	Bsr8VFiWjPKcmfmgxnchMg0a+tqWYnQ74wcyahTcj9YqvZnNu3eVhKhgO3R1BZBqi0+Dc0A2pBEPk
	kH4p7llp1MN4PPfte6Wl8Wz5I6LXkjZI+qLqmxrMnzOUQZLFKq+DV1yk3UBmYK9Wu6MkQ3xVM5WI2
	Inke35DFsiJWTblWWJp307qDsggNvC0zKbIrPK2rOocI0ibJ+Eptn+62hORV2z1qEUozVo9BG9QMU
	O9FqpE/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNhOP-0000000CXQW-08qP;
	Tue, 25 Nov 2025 00:58:53 +0000
Received: from terminus.zytor.com ([2607:7c80:54:3::136] helo=mail.zytor.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNhOL-0000000CXOy-3OQi;
	Tue, 25 Nov 2025 00:58:50 +0000
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5AP0uYXF996032
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 24 Nov 2025 16:56:34 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5AP0uYXF996032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025112201; t=1764032198;
	bh=/30Sv7hB0LicpiampkA1ftcU0prNdSbcPBoiTLyH+p8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=pxJB5zldasPJ8sdmLh0wioBOAStcMVJqKxpCl7tUXUSINXMmUBeS7dNsEx2DQ1rHr
	 XyZoVi3mLQNx0QdMP5qZ3kL5TU3TP9vj29/8Aunuv4u/KcysuGO0CgZT2YdLZbZOHg
	 CGkFHMN332sDzfQymgzLnQJH25bHVdEOD96lQLb3Ds9FuqZ57hJcOWCV1d9Rj/Xt51
	 to9x6WpheBLmGoLubWu2PfFRTKOhF12Nal4pfE0FarSmtWMnjRKSG/RqDpu2kHeTRq
	 cqQlhDvFh98P0/3SjxHLqyRLuG/zgpzntAvyphOgr6ZDN768schUUrBkcSXZdA7Qnn
	 r3ol4NJ3NCiFg==
Date: Mon, 24 Nov 2025 16:56:34 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Usama Arif <usamaarif642@gmail.com>, Changyuan Lyu <changyuanl@google.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>
CC: anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com,
        benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com,
        corbet@lwn.net, dave.hansen@linux.intel.com,
        devicetree@vger.kernel.org, dwmw2@infradead.org, ebiederm@xmission.com,
        graf@amazon.com, jgowans@amazon.com, kexec@lists.infradead.org,
        krzk@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, pasha.tatashin@soleen.com,
        pbonzini@redhat.com, peterz@infradead.org, ptyadav@amazon.de,
        robh@kernel.org, rostedt@goodmis.org, rppt@kernel.org,
        saravanak@google.com, skinsburskii@linux.microsoft.com,
        tglx@linutronix.de, thomas.lendacky@amd.com, will@kernel.org,
        x86@kernel.org, Breno Leitao <leitao@debian.org>, thevlad@meta.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v8_12/17=5D_x86/e820=3A_temporari?=
 =?US-ASCII?Q?ly_enable_KHO_scratch_for_memory_below_1M?=
User-Agent: K-9 Mail for Android
In-Reply-To: <a0f875f1-45ad-4dfc-b5c8-ecb51b242523@gmail.com>
References: <20250509074635.3187114-1-changyuanl@google.com> <20250509074635.3187114-13-changyuanl@google.com> <a0f875f1-45ad-4dfc-b5c8-ecb51b242523@gmail.com>
Message-ID: <22BDBF5C-C831-4BBC-A854-20CA77234084@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251124_165849_854039_0A015512 
X-CRM114-Status: GOOD (  23.77  )
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

On November 24, 2025 11:24:58 AM PST, Usama Arif <usamaarif642@gmail=2Ecom>=
 wrote:
>
>
>On 09/05/2025 08:46, Changyuan Lyu wrote:
>> From: Alexander Graf <graf@amazon=2Ecom>
>>=20
>> KHO kernels are special and use only scratch memory for memblock
>> allocations, but memory below 1M is ignored by kernel after early boot
>> and cannot be naturally marked as scratch=2E
>>=20
>> To allow allocation of the real-mode trampoline and a few (if any) othe=
r
>> very early allocations from below 1M forcibly mark the memory below 1M
>> as scratch=2E
>>=20
>> After real mode trampoline is allocated, clear that scratch marking=2E
>>=20
>> Signed-off-by: Alexander Graf <graf@amazon=2Ecom>
>> Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel=2Eorg>
>> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel=2Eorg>
>> Co-developed-by: Changyuan Lyu <changyuanl@google=2Ecom>
>> Signed-off-by: Changyuan Lyu <changyuanl@google=2Ecom>
>> Acked-by: Dave Hansen <dave=2Ehansen@linux=2Eintel=2Ecom>
>> ---
>>  arch/x86/kernel/e820=2Ec   | 18 ++++++++++++++++++
>>  arch/x86/realmode/init=2Ec |  2 ++
>>  2 files changed, 20 insertions(+)
>>=20
>> diff --git a/arch/x86/kernel/e820=2Ec b/arch/x86/kernel/e820=2Ec
>> index 9920122018a0b=2E=2Ec3acbd26408ba 100644
>> --- a/arch/x86/kernel/e820=2Ec
>> +++ b/arch/x86/kernel/e820=2Ec
>> @@ -1299,6 +1299,24 @@ void __init e820__memblock_setup(void)
>>  		memblock_add(entry->addr, entry->size);
>>  	}
>> =20
>> +	/*
>> +	 * At this point memblock is only allowed to allocate from memory
>> +	 * below 1M (aka ISA_END_ADDRESS) up until direct map is completely s=
et
>> +	 * up in init_mem_mapping()=2E
>> +	 *
>> +	 * KHO kernels are special and use only scratch memory for memblock
>> +	 * allocations, but memory below 1M is ignored by kernel after early
>> +	 * boot and cannot be naturally marked as scratch=2E
>> +	 *
>> +	 * To allow allocation of the real-mode trampoline and a few (if any)
>> +	 * other very early allocations from below 1M forcibly mark the memor=
y
>> +	 * below 1M as scratch=2E
>> +	 *
>> +	 * After real mode trampoline is allocated, we clear that scratch
>> +	 * marking=2E
>> +	 */
>> +	memblock_mark_kho_scratch(0, SZ_1M);
>> +
>>  	/*
>>  	 * 32-bit systems are limited to 4BG of memory even with HIGHMEM and
>>  	 * to even less without it=2E
>> diff --git a/arch/x86/realmode/init=2Ec b/arch/x86/realmode/init=2Ec
>> index f9bc444a3064d=2E=2E9b9f4534086d2 100644
>> --- a/arch/x86/realmode/init=2Ec
>> +++ b/arch/x86/realmode/init=2Ec
>> @@ -65,6 +65,8 @@ void __init reserve_real_mode(void)
>>  	 * setup_arch()=2E
>>  	 */
>>  	memblock_reserve(0, SZ_1M);
>> +
>> +	memblock_clear_kho_scratch(0, SZ_1M);
>>  }
>> =20
>>  static void __init sme_sev_setup_real_mode(struct trampoline_header *t=
h)
>
>Hello!
>
>I am working with Breno who reported that we are seeing the below warning=
 at boot
>when rolling out 6=2E16 in Meta fleet=2E It is difficult to reproduce on =
a single host
>manually but we are seeing this several times a day inside the fleet=2E
>
> 20:16:33  ------------[ cut here ]------------
> 20:16:33  WARNING: CPU: 0 PID: 0 at mm/memblock=2Ec:668 memblock_add_ran=
ge+0x316/0x330
> 20:16:33  Modules linked in:
> 20:16:33  CPU: 0 UID: 0 PID: 0 Comm: swapper Tainted: G S               =
   6=2E16=2E1-0_fbk0_0_gc0739ee5037a #1 NONE=20
> 20:16:33  Tainted: [S]=3DCPU_OUT_OF_SPEC
> 20:16:33  RIP: 0010:memblock_add_range+0x316/0x330
> 20:16:33  Code: ff ff ff 89 5c 24 08 41 ff c5 44 89 6c 24 10 48 63 74 24=
 08 48 63 54 24 10 e8 26 0c 00 00 e9 41 ff ff ff 0f 0b e9 af fd ff ff <0f> =
0b e9 b7 fd ff ff 0f 0b 0f 0b cc cc cc cc cc cc cc cc cc cc cc
> 20:16:33  RSP: 0000:ffffffff83403dd8 EFLAGS: 00010083 ORIG_RAX: 00000000=
00000000
> 20:16:33  RAX: ffffffff8476ff90 RBX: 0000000000001c00 RCX: 0000000000000=
002
> 20:16:33  RDX: 00000000ffffffff RSI: 0000000000000000 RDI: ffffffff83bad=
4d8
> 20:16:33  RBP: 000000000009f000 R08: 0000000000000020 R09: 8000000000097=
101
> 20:16:33  R10: ffffffffff2004b0 R11: 203a6d6f646e6172 R12: 000000000009e=
c00
> 20:16:33  R13: 0000000000000002 R14: 0000000000100000 R15: 000000000009d=
000
> 20:16:33  FS:  0000000000000000(0000) GS:0000000000000000(0000) knlGS:00=
00000000000000
> 20:16:33  CR2: ffff888065413ff8 CR3: 00000000663b7000 CR4: 0000000000000=
0b0
> 20:16:33  Call Trace:
> 20:16:33   <TASK>
> 20:16:33   ? __memblock_reserve+0x75/0x80
> 20:16:33   ? setup_arch+0x30f/0xb10
> 20:16:33   ? start_kernel+0x58/0x960
> 20:16:33   ? x86_64_start_reservations+0x20/0x20
> 20:16:33   ? x86_64_start_kernel+0x13d/0x140
> 20:16:33   ? common_startup_64+0x13e/0x140
> 20:16:33   </TASK>
> 20:16:33  ---[ end trace 0000000000000000 ]---=20
>
>
>Rolling out with memblock=3Ddebug is not really an option in a large scal=
e fleet due to the
>time added to boot=2E But I did try on one of the hosts (without reproduc=
ing the issue) and I see:
>
>[    0=2E000616]  memory=2Ecnt  =3D 0x6
>[    0=2E000617]  memory[0x0]	[0x0000000000001000-0x000000000009bfff], 0x=
000000000009b000 bytes flags: 0x40
>[    0=2E000620]  memory[0x1]	[0x000000000009f000-0x000000000009ffff], 0x=
0000000000001000 bytes flags: 0x40
>[    0=2E000621]  memory[0x2]	[0x0000000000100000-0x000000005ed09fff], 0x=
000000005ec0a000 bytes flags: 0x0
>=2E=2E=2E
>
>The 0x40 (MEMBLOCK_KHO_SCRATCH) is coming from memblock_mark_kho_scratch =
in e820__memblock_setup=2E I believe this
>should be under ifdef like the diff at the end? (Happy to send this as a =
patch for review if it makes sense)=2E
>We have KEXEC_HANDOVER disabled in our defconfig, therefore MEMBLOCK_KHO_=
SCRATCH shouldnt be selected and
>we shouldnt have any MEMBLOCK_KHO_SCRATCH type regions in our memblock re=
servations=2E
>
>The other thing I did was insert a while(1) just before the warning and i=
nspected the registers in qemu=2E
>R14 held the base register, and R15 held the size at that point=2E
>In the warning R14 is 0x100000 meaning that someone is reserving a region=
 with a different flag to MEMBLOCK_NONE
>at the boundary of MEMBLOCK_KHO_SCRATCH=2E
>
>diff --git a/arch/x86/kernel/e820=2Ec b/arch/x86/kernel/e820=2Ec
>index c3acbd26408ba=2E=2E26e4062a0bd09 100644
>--- a/arch/x86/kernel/e820=2Ec
>+++ b/arch/x86/kernel/e820=2Ec
>@@ -1299,6 +1299,7 @@ void __init e820__memblock_setup(void)
>                memblock_add(entry->addr, entry->size);
>        }
>=20
>+#ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
>        /*
>         * At this point memblock is only allowed to allocate from memory
>         * below 1M (aka ISA_END_ADDRESS) up until direct map is complete=
ly set
>@@ -1316,7 +1317,7 @@ void __init e820__memblock_setup(void)
>         * marking=2E
>         */
>        memblock_mark_kho_scratch(0, SZ_1M);
>-
>+#endif
>        /*
>         * 32-bit systems are limited to 4BG of memory even with HIGHMEM =
and
>         * to even less without it=2E
>diff --git a/arch/x86/realmode/init=2Ec b/arch/x86/realmode/init=2Ec
>index 88be32026768c=2E=2E1cd80293a3e23 100644
>--- a/arch/x86/realmode/init=2Ec
>+++ b/arch/x86/realmode/init=2Ec
>@@ -66,8 +66,9 @@ void __init reserve_real_mode(void)
>         * setup_arch()=2E
>         */
>        memblock_reserve(0, SZ_1M);
>-
>+#ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
>        memblock_clear_kho_scratch(0, SZ_1M);
>+#endif
> }
>=20
> static void __init sme_sev_setup_real_mode(struct trampoline_header *th)

What does "scratch" mean in this exact context? (Sorry, don't have the cod=
e in front of me=2E)

