Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D0DC0015E
	for <kexec@archiver.kernel.org>; Wed, 26 Jul 2023 09:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KGbv/yD13Fqa8u6Wk8M0RNDjkjHoeOvrEILqm93we2w=; b=BHxAogEBxTSWLS
	5QSp4ST6ztgv95k70/Iou2jGplfIDqdtlKSZ8yN0ngidQitQUEIWZg21Z97rIm42W6PlmMW8H22lH
	yEh+rA/u6pRw3tQp3GDO+/u2bge5JMH8SlKD6tp4l0aANR+ebQ1b8D6T6TkuWPCzfW27c+MD9NGmP
	N10Zss+vGW5gVk86CIj8yBCoqv769Afe5Dgd7iXDjl006Dw425dkbWLXDP5OFggMA84YAd0L/g7gp
	wD8paIPoh/eP00rx2ibDFdGxOuKBXaF7FRPqIBFU29TC9NV+li0VBQJ1eBaUDSoS1JgakZNA+QRBS
	kQYvv5J38mHBcvMVEZ2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qObAh-009o71-33;
	Wed, 26 Jul 2023 09:51:07 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qObAe-009o4V-2H;
	Wed, 26 Jul 2023 09:51:06 +0000
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R9pwc1TSzztRjQ;
	Wed, 26 Jul 2023 17:47:44 +0800 (CST)
Received: from huawei.com (10.67.174.205) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 17:50:58 +0800
From: Chen Jiahao <chenjiahao16@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<conor.dooley@microchip.com>, <guoren@kernel.org>, <heiko@sntech.de>,
	<bjorn@rivosinc.com>, <alex@ghiti.fr>, <akpm@linux-foundation.org>,
	<atishp@rivosinc.com>, <bhe@redhat.com>, <thunder.leizhen@huawei.com>,
	<horms@kernel.org>
CC: <chenjiahao16@huawei.com>
Subject: [PATCH -next v9 1/2] riscv: kdump: Implement crashkernel=X,[high,low]
Date: Wed, 26 Jul 2023 17:49:59 +0000
Message-ID: <20230726175000.2536220-2-chenjiahao16@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726175000.2536220-1-chenjiahao16@huawei.com>
References: <20230726175000.2536220-1-chenjiahao16@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.67.174.205]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230726_025105_142582_B544F64E 
X-CRM114-Status: GOOD (  19.62  )
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

On riscv, the current crash kernel allocation logic is trying to
allocate within 32bit addressible memory region by default, if
failed, try to allocate without 4G restriction.

In need of saving DMA zone memory while allocating a relatively large
crash kernel region, allocating the reserved memory top down in
high memory, without overlapping the DMA zone, is a mature solution.
Here introduce the parameter option crashkernel=X,[high,low].

One can reserve the crash kernel from high memory above DMA zone range
by explicitly passing "crashkernel=X,high"; or reserve a memory range
below 4G with "crashkernel=X,low".

Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>
Acked-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/kernel/setup.c |  5 +++
 arch/riscv/mm/init.c      | 93 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 91 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 971fe776e2f8..376f5d49ce85 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -178,6 +178,11 @@ static void __init init_resources(void)
 		if (ret < 0)
 			goto error;
 	}
+	if (crashk_low_res.start != crashk_low_res.end) {
+		ret = add_resource(&iomem_resource, &crashk_low_res);
+		if (ret < 0)
+			goto error;
+	}
 #endif
 
 #ifdef CONFIG_CRASH_DUMP
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 70fb31960b63..156e09a1ceee 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1297,6 +1297,28 @@ static inline void setup_vm_final(void)
 }
 #endif /* CONFIG_MMU */
 
+/* Reserve 128M low memory by default for swiotlb buffer */
+#define DEFAULT_CRASH_KERNEL_LOW_SIZE	(128UL << 20)
+
+static int __init reserve_crashkernel_low(unsigned long long low_size)
+{
+	unsigned long long low_base;
+
+	low_base = memblock_phys_alloc_range(low_size, PMD_SIZE, 0, dma32_phys_limit);
+	if (!low_base) {
+		pr_err("cannot allocate crashkernel low memory (size:0x%llx).\n", low_size);
+		return -ENOMEM;
+	}
+
+	pr_info("crashkernel low memory reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
+		low_base, low_base + low_size, low_size >> 20);
+
+	crashk_low_res.start = low_base;
+	crashk_low_res.end = low_base + low_size - 1;
+
+	return 0;
+}
+
 /*
  * reserve_crashkernel() - reserves memory for crash kernel
  *
@@ -1308,8 +1330,12 @@ static void __init reserve_crashkernel(void)
 {
 	unsigned long long crash_base = 0;
 	unsigned long long crash_size = 0;
+	unsigned long long crash_low_size = 0;
 	unsigned long search_start = memblock_start_of_DRAM();
-	unsigned long search_end = memblock_end_of_DRAM();
+	unsigned long search_end = (unsigned long)dma32_phys_limit;
+	char *cmdline = boot_command_line;
+	bool fixed_base = false;
+	bool high = false;
 
 	int ret = 0;
 
@@ -1325,14 +1351,36 @@ static void __init reserve_crashkernel(void)
 		return;
 	}
 
-	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
+	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
 				&crash_size, &crash_base);
-	if (ret || !crash_size)
+	if (ret == -ENOENT) {
+		/* Fallback to crashkernel=X,[high,low] */
+		ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
+		if (ret || !crash_size)
+			return;
+
+		/*
+		 * crashkernel=Y,low is valid only when crashkernel=X,high
+		 * is passed.
+		 */
+		ret = parse_crashkernel_low(cmdline, 0, &crash_low_size, &crash_base);
+		if (ret == -ENOENT)
+			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
+		else if (ret)
+			return;
+
+		search_start = (unsigned long)dma32_phys_limit;
+		search_end = memblock_end_of_DRAM();
+		high = true;
+	} else if (ret || !crash_size) {
+		/* Invalid argument value specified */
 		return;
+	}
 
 	crash_size = PAGE_ALIGN(crash_size);
 
 	if (crash_base) {
+		fixed_base = true;
 		search_start = crash_base;
 		search_end = crash_base + crash_size;
 	}
@@ -1345,12 +1393,37 @@ static void __init reserve_crashkernel(void)
 	 * swiotlb can work on the crash kernel.
 	 */
 	crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
-					       search_start,
-					       min(search_end, (unsigned long) SZ_4G));
+					       search_start, search_end);
 	if (crash_base == 0) {
-		/* Try again without restricting region to 32bit addressible memory */
+		/*
+		 * For crashkernel=size[KMG]@offset[KMG], print out failure
+		 * message if can't reserve the specified region.
+		 */
+		if (fixed_base) {
+			pr_warn("crashkernel: allocating failed with given size@offset\n");
+			return;
+		}
+
+		if (high) {
+			/*
+			 * For crashkernel=size[KMG],high, if the first attempt was
+			 * for high memory, fall back to low memory.
+			 */
+			search_start = memblock_start_of_DRAM();
+			search_end = (unsigned long)dma32_phys_limit;
+		} else {
+			/*
+			 * For crashkernel=size[KMG], if the first attempt was for
+			 * low memory, fall back to high memory, the minimum required
+			 * low memory will be reserved later.
+			 */
+			search_start = (unsigned long)dma32_phys_limit;
+			search_end = memblock_end_of_DRAM();
+			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
+		}
+
 		crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
-						search_start, search_end);
+						       search_start, search_end);
 		if (crash_base == 0) {
 			pr_warn("crashkernel: couldn't allocate %lldKB\n",
 				crash_size >> 10);
@@ -1358,6 +1431,12 @@ static void __init reserve_crashkernel(void)
 		}
 	}
 
+	if ((crash_base >= dma32_phys_limit) && crash_low_size &&
+	     reserve_crashkernel_low(crash_low_size)) {
+		memblock_phys_free(crash_base, crash_size);
+		return;
+	}
+
 	pr_info("crashkernel: reserved 0x%016llx - 0x%016llx (%lld MB)\n",
 		crash_base, crash_base + crash_size, crash_size >> 20);
 
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
