Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A0DC3DA59
	for <kexec@archiver.kernel.org>; Fri, 19 Jul 2024 09:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TqqiaTTynpy6BjijHYLaPiLKpZ+t0kQYziIjJxynovE=; b=DmXUALlAY4jcKg
	trejttnfOyjefDU5M+ZHDSVWQzxyojqrpMDKuJ6mSvpDEtOsc57bpp8mp+yEdvlWB5K0HdRMkwTxM
	RjBnkFj9/hzoKwVV8K+8+trP4ym+jL+6ePy138FF1FF8WtIvcPttCzzCZJaZ8KKqWaIB/WCpi2BQx
	QMgDuJFPviL3apjTjmGg7+tjvHye8jMZD5SDSPgJsM7xi9tAieoYmgFtDwO03s8SMG20ZcwqhR+fm
	4Og6dAWzdZEjvqzCXpkaw5lvhYMxoa5PAWvMvhl5mEd4yhsmFag3RCkASmF+bkPHZ5s327An2tT4k
	wVHWoSf/zy30MTZ2AwVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUkIj-00000002Jd9-1wHL;
	Fri, 19 Jul 2024 09:53:21 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUkIL-00000002JTz-3QQv;
	Fri, 19 Jul 2024 09:52:59 +0000
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WQPxQ2rnwzyN7N;
	Fri, 19 Jul 2024 17:48:10 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 681A91402E2;
	Fri, 19 Jul 2024 17:52:55 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 19 Jul
 2024 17:52:54 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <linux@armlinux.org.uk>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <bhe@redhat.com>, <vgoyal@redhat.com>, <dyoung@redhat.com>,
	<arnd@arndb.de>, <afd@ti.com>, <akpm@linux-foundation.org>,
	<linus.walleij@linaro.org>, <eric.devolder@oracle.com>,
	<gregkh@linuxfoundation.org>, <javierm@redhat.com>, <deller@gmx.de>,
	<robh@kernel.org>, <thunder.leizhen@huawei.com>, <hbathini@linux.ibm.com>,
	<tangyouling@kylinos.cn>, <chenjiahao16@huawei.com>,
	<kexec@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v4 1/3] crash: Fix x86_32 crash memory reserve dead loop bug
Date: Fri, 19 Jul 2024 17:57:33 +0800
Message-ID: <20240719095735.1912878-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240719095735.1912878-1-ruanjinjie@huawei.com>
References: <20240719095735.1912878-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi100008.china.huawei.com (7.221.188.57)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240719_025258_207534_54EEC31B 
X-CRM114-Status: GOOD (  14.91  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On x86_32 Qemu machine with 1GB memory, the cmdline "crashkernel=1G,high"
will cause system stall as below:

	ACPI: Reserving FACP table memory at [mem 0x3ffe18b8-0x3ffe192b]
	ACPI: Reserving DSDT table memory at [mem 0x3ffe0040-0x3ffe18b7]
	ACPI: Reserving FACS table memory at [mem 0x3ffe0000-0x3ffe003f]
	ACPI: Reserving APIC table memory at [mem 0x3ffe192c-0x3ffe19bb]
	ACPI: Reserving HPET table memory at [mem 0x3ffe19bc-0x3ffe19f3]
	ACPI: Reserving WAET table memory at [mem 0x3ffe19f4-0x3ffe1a1b]
	143MB HIGHMEM available.
	879MB LOWMEM available.
	  mapped low ram: 0 - 36ffe000
	  low ram: 0 - 36ffe000
	 (stall here)

The reason is that the CRASH_ADDR_LOW_MAX is equal to CRASH_ADDR_HIGH_MAX
on x86_32, the first high crash kernel memory reservation will fail, then
go into the "retry" loop and never came out as below.

-> reserve_crashkernel_generic() and high is true
 -> alloc at [CRASH_ADDR_LOW_MAX, CRASH_ADDR_HIGH_MAX] fail
    -> alloc at [0, CRASH_ADDR_LOW_MAX] fail and repeatedly
       (because CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX).

Fix it by prevent crashkernel=,high from being parsed successfully on 32bit
system with a architecture-defined macro.

After this patch, the 'crashkernel=,high' for 32bit system can't succeed,
and it has no chance to call reserve_crashkernel_generic(), therefore this
issue on x86_32 is solved.

Fixes: 9c08a2a139fe ("x86: kdump: use generic interface to simplify crashkernel reservation code")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Suggested-by: Baoquan He <bhe@redhat.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
v4:
- Add the missing macro for loongarch.
- Only define the macro for 64bit RISCV.
- Signed-off-by -> Suggested-by as suggested.
- Remove the Tested-by as suggested.
- Add acked-by.
v3:
- Fix it as Baoquan suggested.
- Update the commit message.
v2:
- Peel off the other two patches.
- Update the commit message and fix tag.
---
 arch/arm64/include/asm/crash_reserve.h     | 2 ++
 arch/loongarch/include/asm/crash_reserve.h | 2 ++
 arch/riscv/include/asm/crash_reserve.h     | 4 ++++
 arch/x86/include/asm/crash_reserve.h       | 1 +
 kernel/crash_reserve.c                     | 2 +-
 5 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/crash_reserve.h b/arch/arm64/include/asm/crash_reserve.h
index 4afe027a4e7b..bf362c1a612f 100644
--- a/arch/arm64/include/asm/crash_reserve.h
+++ b/arch/arm64/include/asm/crash_reserve.h
@@ -7,4 +7,6 @@
 
 #define CRASH_ADDR_LOW_MAX              arm64_dma_phys_limit
 #define CRASH_ADDR_HIGH_MAX             (PHYS_MASK + 1)
+
+#define HAVE_ARCH_CRASHKERNEL_RESERVATION_HIGH
 #endif
diff --git a/arch/loongarch/include/asm/crash_reserve.h b/arch/loongarch/include/asm/crash_reserve.h
index a1d9b84b1c7d..2d02517c2127 100644
--- a/arch/loongarch/include/asm/crash_reserve.h
+++ b/arch/loongarch/include/asm/crash_reserve.h
@@ -7,6 +7,8 @@
 #define CRASH_ADDR_LOW_MAX		SZ_4G
 #define CRASH_ADDR_HIGH_MAX		memblock_end_of_DRAM()
 
+#define HAVE_ARCH_CRASHKERNEL_RESERVATION_HIGH
+
 extern phys_addr_t memblock_end_of_DRAM(void);
 
 #endif
diff --git a/arch/riscv/include/asm/crash_reserve.h b/arch/riscv/include/asm/crash_reserve.h
index 013962e63587..216402ea5b7c 100644
--- a/arch/riscv/include/asm/crash_reserve.h
+++ b/arch/riscv/include/asm/crash_reserve.h
@@ -7,5 +7,9 @@
 #define CRASH_ADDR_LOW_MAX		dma32_phys_limit
 #define CRASH_ADDR_HIGH_MAX		memblock_end_of_DRAM()
 
+#ifdef CONFIG_64BIT
+#define HAVE_ARCH_CRASHKERNEL_RESERVATION_HIGH
+#endif
+
 extern phys_addr_t memblock_end_of_DRAM(void);
 #endif
diff --git a/arch/x86/include/asm/crash_reserve.h b/arch/x86/include/asm/crash_reserve.h
index 7835b2cdff04..24c2327f9a16 100644
--- a/arch/x86/include/asm/crash_reserve.h
+++ b/arch/x86/include/asm/crash_reserve.h
@@ -26,6 +26,7 @@ extern unsigned long swiotlb_size_or_default(void);
 #else
 # define CRASH_ADDR_LOW_MAX     SZ_4G
 # define CRASH_ADDR_HIGH_MAX    SZ_64T
+#define HAVE_ARCH_CRASHKERNEL_RESERVATION_HIGH
 #endif
 
 # define DEFAULT_CRASH_KERNEL_LOW_SIZE crash_low_size_default()
diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index 5b2722a93a48..c5213f123e19 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -306,7 +306,7 @@ int __init parse_crashkernel(char *cmdline,
 	/* crashkernel=X[@offset] */
 	ret = __parse_crashkernel(cmdline, system_ram, crash_size,
 				crash_base, NULL);
-#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
+#ifdef HAVE_ARCH_CRASHKERNEL_RESERVATION_HIGH
 	/*
 	 * If non-NULL 'high' passed in and no normal crashkernel
 	 * setting detected, try parsing crashkernel=,high|low.
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
