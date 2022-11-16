Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5FEC43217
	for <kexec@archiver.kernel.org>; Wed, 16 Nov 2022 12:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U1M1+20BN1CtoZJz43lsLHCuKCMSD+9Ti9qE1K9AT0Q=; b=N09QJyWv4pcE1k
	xzwje8haJGg448YP8BvYWqhKo0SWX7aT/9T2d2nLt2b0N01NrpaWnxZsOmms4QvQaNvdwaW8L1WXE
	KnDaGq55ibCaZ7d4AeGF2vDlqb61ph36PNlf9GAVKRBX3+lKN5C4Tv47+v+zoi7QOOUOZY3/FJaMa
	ow4xAD6DHo9XLhiI4mPHh3zvzIINinNsYwh+gZmtjUeXapYiRXdb38mr1/ZX8wPUG7CBlhQe77bZe
	VchiRU9JtEeL9711s0KzcTxYAtxHCEBxZur7Qpu+9acCpPHs0drrY+C1NpWP2RrJZ2jRLzKGpsQJO
	jDxk1OjvStE9JLN50n1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovHGD-003GG8-5z; Wed, 16 Nov 2022 12:11:21 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovHFu-003GAE-UA; Wed, 16 Nov 2022 12:11:09 +0000
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NC21Z2bk1zHvsF;
	Wed, 16 Nov 2022 20:10:26 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 20:10:57 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 20:10:56 +0800
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
Subject: [PATCH v4 1/2] arm64: kdump: Provide default size when crashkernel=Y,low is not specified
Date: Wed, 16 Nov 2022 20:10:43 +0800
Message-ID: <20221116121044.1690-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20221116121044.1690-1-thunder.leizhen@huawei.com>
References: <20221116121044.1690-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_041103_339559_60396939 
X-CRM114-Status: GOOD (  15.66  )
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

Try to allocate at least 128 MiB low memory automatically for the case
that crashkernel=,high is explicitly specified, while crashkenrel=,low
is omitted. This allows users to focus more on the high memory
requirements of their business rather than the low memory requirements
of the crash kernel booting.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 13 +++++--------
 arch/arm64/mm/init.c                            |  8 ++++++--
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 7dea58f4a69cc8c..a7b7147447b8bf8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -862,26 +862,23 @@
 			available.
 			It will be ignored if crashkernel=X is specified.
 	crashkernel=size[KMG],low
-			[KNL, X86-64] range under 4G. When crashkernel=X,high
+			[KNL, X86-64, ARM64] range under 4G. When crashkernel=X,high
 			is passed, kernel could allocate physical memory region
 			above 4G, that cause second kernel crash on system
 			that require some amount of low memory, e.g. swiotlb
 			requires at least 64M+32K low memory, also enough extra
 			low memory is needed to make sure DMA buffers for 32-bit
 			devices won't run out. Kernel would try to allocate
-			at least 256M below 4G automatically.
+			default	size of memory below 4G automatically. The default
+			size is	platform dependent.
+			  --> x86: max(swiotlb_size_or_default() + 8MiB, 256MiB)
+			  --> arm64: 128MiB
 			This one lets the user specify own low range under 4G
 			for second kernel instead.
 			0: to disable low allocation.
 			It will be ignored when crashkernel=X,high is not used
 			or memory reserved is below 4G.
 
-			[KNL, ARM64] range in low memory.
-			This one lets the user specify a low range in the
-			DMA zone for the crash dump kernel.
-			It will be ignored when crashkernel=X,high is not used
-			or memory reserved is located in the DMA zones.
-
 	cryptomgr.notests
 			[KNL] Disable crypto self-tests
 
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 4b4651ee47f271a..ba7227179822d10 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -96,6 +96,8 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit = PHYS_MASK + 1;
 #define CRASH_ADDR_LOW_MAX		arm64_dma_phys_limit
 #define CRASH_ADDR_HIGH_MAX		(PHYS_MASK + 1)
 
+#define DEFAULT_CRASH_KERNEL_LOW_SIZE	(128UL << 20)
+
 static int __init reserve_crashkernel_low(unsigned long long low_size)
 {
 	unsigned long long low_base;
@@ -147,7 +149,9 @@ static void __init reserve_crashkernel(void)
 		 * is not allowed.
 		 */
 		ret = parse_crashkernel_low(cmdline, 0, &crash_low_size, &crash_base);
-		if (ret && (ret != -ENOENT))
+		if (ret == -ENOENT)
+			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
+		else if (ret)
 			return;
 
 		crash_max = CRASH_ADDR_HIGH_MAX;
@@ -170,7 +174,7 @@ static void __init reserve_crashkernel(void)
 		return;
 	}
 
-	if ((crash_base >= CRASH_ADDR_LOW_MAX) &&
+	if ((crash_base > CRASH_ADDR_LOW_MAX - crash_low_size) &&
 	     crash_low_size && reserve_crashkernel_low(crash_low_size)) {
 		memblock_phys_free(crash_base, crash_size);
 		return;
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
