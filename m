Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A285C433EF
	for <kexec@archiver.kernel.org>; Mon, 11 Jul 2022 09:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=X1qAjQ7RAWwca8wfHxV/XVnujyWvBNG3O3k7Gb2pdKE=; b=MfZYMIO5E5BxZP
	iufwllJmhyPm2EcO8d1FUSMoXESmsZDjimlq6sDbc0BXZEprHoqHNHUEpZlErqcMrKZPpEvvjBQPJ
	v//8ViZJvYBSFER+7fY4p7siEY4kpWIv7bjzsDUDKf396wz083prsUj3yImh3OIssqBNg5zV4RCGl
	kT8XrmybHplILlxdhDY9yK122VyW/AlCJn7Agcysn2Wd3UFiaKAH13aDtnc2cULDJZZs4retbBjqw
	DcPmEQ/6lKYYoVdXoCTcAmTJCB7qLPeyaq93pyuLI9QC8bWjm9beneuGlFFb9lJjUpR7jqRmQ0VCf
	4yFed89KoHkPGCkGqwEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oApM6-00HTPp-Ok; Mon, 11 Jul 2022 09:05:26 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oApLX-00HT3V-Pf; Mon, 11 Jul 2022 09:04:53 +0000
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LhHtB0k8zzTgkG;
	Mon, 11 Jul 2022 17:01:06 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 11 Jul 2022 17:04:43 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 11 Jul 2022 17:04:42 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal
	<vgoyal@redhat.com>, <kexec@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>, "Eric W . Biederman"
	<ebiederm@xmission.com>, Randy Dunlap <rdunlap@infradead.org>, Feng Zhou
	<zhoufeng.zf@bytedance.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, "Chen
 Zhou" <dingguo.cz@antgroup.com>, John Donnelly <John.p.donnelly@oracle.com>,
	Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: [PATCH v3 2/2] arm64: kdump: Support crashkernel=X fall back to reserve region above DMA zones
Date: Mon, 11 Jul 2022 17:03:19 +0800
Message-ID: <20220711090319.1604-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20220711090319.1604-1-thunder.leizhen@huawei.com>
References: <20220711090319.1604-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220711_020452_614023_E637E61D 
X-CRM114-Status: GOOD (  13.97  )
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

For crashkernel=X without '@offset', select a region within DMA zones
first, and fall back to reserve region above DMA zones. This allows
users to use the same configuration on multiple platforms.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  2 +-
 arch/arm64/mm/init.c                            | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 65a2c3a22a4b57d..cb6a346419a1fe0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -823,7 +823,7 @@
 			memory region [offset, offset + size] for that kernel
 			image. If '@offset' is omitted, then a suitable offset
 			is selected automatically.
-			[KNL, X86-64] Select a region under 4G first, and
+			[KNL, X86-64, ARM64] Select a region under 4G first, and
 			fall back to reserve region above 4G when '@offset'
 			hasn't been specified.
 			See Documentation/admin-guide/kdump/kdump.rst for further details.
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 5390f361208ccf7..8539598f9e58b4d 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -138,6 +138,7 @@ static void __init reserve_crashkernel(void)
 	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
 	char *cmdline = boot_command_line;
 	int ret;
+	bool fixed_base;
 
 	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
 		return;
@@ -166,15 +167,28 @@ static void __init reserve_crashkernel(void)
 		return;
 	}
 
+	fixed_base = !!crash_base;
 	crash_size = PAGE_ALIGN(crash_size);
 
 	/* User specifies base address explicitly. */
-	if (crash_base)
+	if (fixed_base)
 		crash_max = crash_base + crash_size;
 
+retry:
 	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
 					       crash_base, crash_max);
 	if (!crash_base) {
+		/*
+		 * Attempt to fully allocate low memory failed, fall back
+		 * to high memory, the minimum required low memory will be
+		 * reserved later.
+		 */
+		if (!fixed_base && (crash_max == CRASH_ADDR_LOW_MAX)) {
+			crash_max = CRASH_ADDR_HIGH_MAX;
+			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
+			goto retry;
+		}
+
 		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
 			crash_size);
 		return;
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
