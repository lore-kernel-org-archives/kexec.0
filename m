Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA885C3DA60
	for <kexec@archiver.kernel.org>; Thu, 18 Jul 2024 03:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MLC54CixBSt/kb3usE04/szA71yGgTLYnCA8Z88MnVw=; b=0H1jaPMRHvKMM+
	Zfz8mfXv6cdt/Ip578TQ2/7gsJCnKZgmSAcE7LN7G6Dt4NNI2EKnJgz0LSuLOtzKrNszi99vZf5gV
	U2wacgpxlSDNoO5oHeq+Jr5+Fa8fNdz9AYEb7QwnNvQ9klsAisbeZ9TV7j3fKzVaYP6BVWdRxoHm/
	spKXajuQ6+KUU7oHYc85BMRmiDd178risbKgm6jckMCyJjVwufYM2fW0bDFvIvPsSRlaziYz/Tjy8
	Z4n682HJ8OGYrHfE0fRnFAYxdgbjOElqR3b9wrEoLukj9G92Mgi9LSIGDFxyVWKNCWXvcNGWdzHI1
	1Zbepcnu90skyUfhubLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUIAT-0000000Ffcu-2UyI;
	Thu, 18 Jul 2024 03:50:57 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUIA9-0000000FfPy-03yD;
	Thu, 18 Jul 2024 03:50:38 +0000
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WPdyZ6ZSXzQm2G;
	Thu, 18 Jul 2024 11:46:30 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 3489718010A;
	Thu, 18 Jul 2024 11:50:20 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 18 Jul
 2024 11:50:04 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <linux@armlinux.org.uk>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <bhe@redhat.com>,
	<vgoyal@redhat.com>, <dyoung@redhat.com>, <arnd@arndb.de>, <afd@ti.com>,
	<linus.walleij@linaro.org>, <akpm@linux-foundation.org>,
	<eric.devolder@oracle.com>, <gregkh@linuxfoundation.org>,
	<javierm@redhat.com>, <deller@gmx.de>, <robh@kernel.org>,
	<hbathini@linux.ibm.com>, <thunder.leizhen@huawei.com>,
	<chenjiahao16@huawei.com>, <linux-kernel@vger.kernel.org>,
	<kexec@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v3 2/3] crash: Fix x86_32 crash memory reserve dead loop bug at high
Date: Thu, 18 Jul 2024 11:54:43 +0800
Message-ID: <20240718035444.2977105-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718035444.2977105-1-ruanjinjie@huawei.com>
References: <20240718035444.2977105-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi100008.china.huawei.com (7.221.188.57)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_205037_456495_B81D881E 
X-CRM114-Status: GOOD (  10.57  )
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

On x86_32 Qemu machine with 1GB memory, the cmdline "crashkernel=512M" will
also cause system stall as below:

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
on x86_32, the first "low" crash kernel memory reservation for 512M fails,
then it go into the "retry" loop and never came out as below (consider
CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX = 512M):

-> reserve_crashkernel_generic() and high is false
   -> alloc at [0, 0x20000000] fail
      -> alloc at [0x20000000, 0x20000000] fail and repeatedly
      (because CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX).

Fix it by skipping meaningless calls of memblock_phys_alloc_range() with
`start = end`

After this patch, the retry dead loop is avoided and print below info:
	cannot allocate crashkernel (size:0x20000000)

And apply generic crashkernel reservation to 32bit system will be ready.

Fixes: 9c08a2a139fe ("x86: kdump: use generic interface to simplify crashkernel reservation code")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Baoquan He <bhe@redhat.com>
Tested-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v3:
- Fix it as Baoquan suggested.
- Update the commit message.
---
 kernel/crash_reserve.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index c5213f123e19..dacc268429e2 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -414,7 +414,8 @@ void __init reserve_crashkernel_generic(char *cmdline,
 			search_end = CRASH_ADDR_HIGH_MAX;
 			search_base = CRASH_ADDR_LOW_MAX;
 			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
-			goto retry;
+			if (search_base != search_end)
+				goto retry;
 		}
 
 		/*
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
