Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24BD5C4332F
	for <kexec@archiver.kernel.org>; Wed, 16 Nov 2022 12:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qAJBwXNHJyug3LU/JCXL62miat9Ey2RwL9FZq9jYT6c=; b=lBdlKF1YTWlPGE
	oOmE/fkkyLGiwfN/OHv8SqNI63MbJkuSTQbmt2iyT5mkUjdlD3b8RM0je5aWvg33HtAsJh4WdHvYI
	jH4E9Uzf2/JIickFv60xBpyex6D8uIZUrjNvm6sIkpoVo294KspYS0mB67cTcbZ/Exdf1udERohKA
	/blMy4UpvfrHade6rVRgnLiND16r3vgKSLezLilt0CB5tj0n8ca87C4mhJWxw7wINn3h2PSP9t8lw
	urbfgkGfcnl8EyZcmvz8i7Q0TVs3iJN5ADKGz9GyHp3ZQOIVy28J/ATvixJrwlm/GsAZ3m0T7reG7
	AL63R3eDDTZT1yVNEwpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovHGB-003GFa-KW; Wed, 16 Nov 2022 12:11:19 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovHFu-003GAQ-67; Wed, 16 Nov 2022 12:11:09 +0000
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NC21m3JKWz15Mh0;
	Wed, 16 Nov 2022 20:10:36 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 20:10:58 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 20:10:57 +0800
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
Subject: [PATCH v4 2/2] arm64: kdump: Support crashkernel=X fall back to reserve region above DMA zones
Date: Wed, 16 Nov 2022 20:10:44 +0800
Message-ID: <20221116121044.1690-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20221116121044.1690-1-thunder.leizhen@huawei.com>
References: <20221116121044.1690-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_041102_600575_6FA4329A 
X-CRM114-Status: GOOD (  14.40  )
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
 arch/arm64/mm/init.c                            | 17 ++++++++++++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a7b7147447b8bf8..ef6d922ed26b9dc 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -842,7 +842,7 @@
 			memory region [offset, offset + size] for that kernel
 			image. If '@offset' is omitted, then a suitable offset
 			is selected automatically.
-			[KNL, X86-64] Select a region under 4G first, and
+			[KNL, X86-64, ARM64] Select a region under 4G first, and
 			fall back to reserve region above 4G when '@offset'
 			hasn't been specified.
 			See Documentation/admin-guide/kdump/kdump.rst for further details.
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index ba7227179822d10..58a0bb2c17f18cf 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -132,6 +132,7 @@ static void __init reserve_crashkernel(void)
 	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
 	char *cmdline = boot_command_line;
 	int ret;
+	bool fixed_base = false;
 
 	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
 		return;
@@ -163,12 +164,26 @@ static void __init reserve_crashkernel(void)
 	crash_size = PAGE_ALIGN(crash_size);
 
 	/* User specifies base address explicitly. */
-	if (crash_base)
+	if (crash_base) {
+		fixed_base = true;
 		crash_max = crash_base + crash_size;
+	}
 
+retry:
 	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
 					       crash_base, crash_max);
 	if (!crash_base) {
+		/*
+		 * If the first attempt was for low memory, fall back to
+		 * high memory, the minimum required low memory will be
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
