Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C12A0C3DA4B
	for <kexec@archiver.kernel.org>; Wed, 17 Jul 2024 07:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=fn5l6kuN3rmozuO/EN93IAR/o68EEuRKadbQBi6c7K4=; b=1UQ7AfLXoFi7bM
	2kWJsbg1Xhta6MgGqHz++JFAaT886NdHXI9ahA2HbTjZGudZU3tQBBHaFAv5GiSFWoAp6wqfJncWY
	jzMRyEVPy1iWvLa0ZAUDOdXg7b8dy/TvJoyKU6tTh1cjAos7HZtQ+/krnIVZWar600dNf8uqNVHMp
	DRcGrIsaZ/IDTWvrOJsLPWP4FceUEqi3+F6tUNCUFuYLaqqYoCj7ZQi1Vyy8nzswhTTJI1Kb9wB4w
	UfiT9R7so+lDKTtY1TEmH2TQCZHCQgqOrMlQobMNN/8UalsLp7tJ9HLssurXUlWqAgaGhiVisql0g
	ztutYeeMjoMjyZlSjFzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTyiH-0000000CvrL-3Pd8;
	Wed, 17 Jul 2024 07:04:33 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTyiE-0000000Cvq8-0r3k
	for kexec@lists.infradead.org;
	Wed, 17 Jul 2024 07:04:32 +0000
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WP6MF4lL3zdhck;
	Wed, 17 Jul 2024 15:02:33 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 5486718009B;
	Wed, 17 Jul 2024 15:04:17 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 17 Jul
 2024 15:04:16 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <bhe@redhat.com>, <vgoyal@redhat.com>, <dyoung@redhat.com>,
	<akpm@linux-foundation.org>, <kexec@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] crash: fix x86_32 memory reserve dead loop retry bug at "high"
Date: Wed, 17 Jul 2024 15:09:04 +0800
Message-ID: <20240717070904.2671147-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi100008.china.huawei.com (7.221.188.57)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_000430_428813_E759FCF4 
X-CRM114-Status: GOOD (  11.76  )
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

Similar to commit 8f9dade5906a ("crash: fix x86_32 memory reserve dead loop
retry bug") and in the symmetry case, on x86_32 Qemu machine with
1GB memory, the cmdline "crashkernel=512M" will also cause system stall
as below:

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

Fix it by also changing the another out check condition, the fixed base
situation has no problem because it warn out if it fail to alloc.

After this patch, it prints:
	cannot allocate crashkernel (size:0x20000000)

Fixes: 9c08a2a139fe ("x86: kdump: use generic interface to simplify crashkernel reservation code")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/crash_reserve.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index 03e455738e75..36c13cf942f4 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -409,7 +409,7 @@ void __init reserve_crashkernel_generic(char *cmdline,
 		 * low memory, fall back to high memory, the minimum required
 		 * low memory will be reserved later.
 		 */
-		if (!high && search_end == CRASH_ADDR_LOW_MAX) {
+		if (!high && !search_base) {
 			search_end = CRASH_ADDR_HIGH_MAX;
 			search_base = CRASH_ADDR_LOW_MAX;
 			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
