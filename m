Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B4ACC43334
	for <kexec@archiver.kernel.org>; Mon, 13 Jun 2022 08:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eUi/tXEO4Orvz8aN1lV59jGjQ2KCZ3239PbYI9ACrS4=; b=oOxTO+FP1fod62
	hswMZsjL86hFQSZzTEz9PiKn6SJdRl/19xCcb+pQ2HHqU95lWLnCsn5UoQyVdMa2avDRMZo3g3Y+x
	Eb/OgR0ZH/VHjBWTxt3mTCRSHSZPnm9GJsRpBA7fpXD7dlciocT1v48PQP/+1H6yZYni4xRteGON6
	zigEAJxI8MD+wZZXMF8nqsEU/uqOXnQbnQUkQuek8h28Na2U9T3jlKS8mh+Ov4z7jyNkznGHDsEoU
	9+lwsH9ATNqkQnqAsiogDkYq7rwbkqV7nwuHPx8E61mDd9MY3V/12CR2k26OeuyLqxz6B/xzr8b/Q
	bMPgeD+vfoiiCQYsIX4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0fBR-002BWJ-SE; Mon, 13 Jun 2022 08:12:25 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0fAa-002B0C-Nv; Mon, 13 Jun 2022 08:11:34 +0000
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LM43g22Gxz1K9Vw;
	Mon, 13 Jun 2022 16:09:35 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 16:11:06 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 16:11:04 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, "H . Peter Anvin"
	<hpa@zytor.com>, Eric Biederman <ebiederm@xmission.com>, Rob Herring
	<robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
	<devicetree@vger.kernel.org>, Dave Young <dyoung@redhat.com>, Baoquan He
	<bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	<kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Jonathan Corbet <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>, Randy Dunlap
	<rdunlap@infradead.org>, Feng Zhou <zhoufeng.zf@bytedance.com>, Kefeng Wang
	<wangkefeng.wang@huawei.com>, Chen Zhou <dingguo.cz@antgroup.com>, "John
 Donnelly" <John.p.donnelly@oracle.com>, Dave Kleikamp
	<dave.kleikamp@oracle.com>
Subject: [PATCH 4/5] arm64: kdump: Decide when to reserve crash memory in reserve_crashkernel()
Date: Mon, 13 Jun 2022 16:09:31 +0800
Message-ID: <20220613080932.663-5-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20220613080932.663-1-thunder.leizhen@huawei.com>
References: <20220613080932.663-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220613_011133_153115_6FC874F2 
X-CRM114-Status: GOOD (  18.81  )
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

After the kexec completes data loading, the crash memory must be set to be
inaccessible, to prevent the current kernel from damaging the data of the
crash kernel. But for some platforms, the DMA zones is not known until the
dtb or acpi table is parsed, but by then the linear mapping has been
created, all are forced to be page-level mapping.

To optimize the system performance (reduce the TLB miss rate) when
crashkernel=X,high is used. The reservation of crash memory is divided
into two phases: reserve crash high memory before paging_init() is called
and crash low memory after it. We only perform page mapping for the crash
high memory.

commit 031495635b46 ("arm64: Do not defer reserve_crashkernel() for
platforms with no DMA memory zones") has caused reserve_crashkernel() to
be called in two places: before or after paging_init(), which is
controlled by whether CONFIG_ZONE_DMA/DMA32 is enabled. Just move the
control into reserve_crashkernel(), prepare for the optimizations
mentioned above.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/mm/init.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 8539598f9e58b4d..fb24efbc46f5ef4 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -90,6 +90,9 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit;
 phys_addr_t __ro_after_init arm64_dma_phys_limit = PHYS_MASK + 1;
 #endif
 
+#define DMA_PHYS_LIMIT_UNKNOWN		0
+#define DMA_PHYS_LIMIT_KNOWN		1
+
 /* Current arm64 boot protocol requires 2MB alignment */
 #define CRASH_ALIGN			SZ_2M
 
@@ -131,18 +134,23 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
  * line parameter. The memory reserved is used by dump capture kernel when
  * primary kernel is crashing.
  */
-static void __init reserve_crashkernel(void)
+static void __init reserve_crashkernel(int dma_state)
 {
 	unsigned long long crash_base, crash_size;
 	unsigned long long crash_low_size = 0;
 	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
 	char *cmdline = boot_command_line;
+	int dma_enabled = IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32);
 	int ret;
 	bool fixed_base;
 
 	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
 		return;
 
+	if ((!dma_enabled && (dma_state != DMA_PHYS_LIMIT_UNKNOWN)) ||
+	     (dma_enabled && (dma_state != DMA_PHYS_LIMIT_KNOWN)))
+		return;
+
 	/* crashkernel=X[@offset] */
 	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
 				&crash_size, &crash_base);
@@ -413,8 +421,7 @@ void __init arm64_memblock_init(void)
 
 	early_init_fdt_scan_reserved_mem();
 
-	if (!IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32))
-		reserve_crashkernel();
+	reserve_crashkernel(DMA_PHYS_LIMIT_UNKNOWN);
 
 	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
 }
@@ -462,8 +469,7 @@ void __init bootmem_init(void)
 	 * request_standard_resources() depends on crashkernel's memory being
 	 * reserved, so do it here.
 	 */
-	if (IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32))
-		reserve_crashkernel();
+	reserve_crashkernel(DMA_PHYS_LIMIT_KNOWN);
 
 	memblock_dump_all();
 }
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
