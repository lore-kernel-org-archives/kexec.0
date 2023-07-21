Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8334EB64DC
	for <kexec@archiver.kernel.org>; Fri, 21 Jul 2023 08:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y5bxoHSKWkvHGHcN1bTs1cd7EYXjqqKhDRcBvi0YKmk=; b=Z/HSSLMRnbfD9v
	eaiUlaw6Sso6s11PhJbmFkKb9HOjcelwteE/FXH0a5jWadfbH/ylf1k+zWgsB9BsJgtZs1xm1/yyC
	/RqAEpV4gJsX5FcbsZnQ4C6TnHKKA7rRGJk9KAWQu7jG5am06vTimIGHHXsCS/vmAbhO4D0RLPb0b
	+BoXS9RYeDJlXl2apMKpaIQHyq2vb+xj0dg6vHl+9Rc0HIZN8V4tTAmeX+Q5ovN8X9pMk0/q5CCA+
	2bDBZUCz8rL2mst5FSwQyMkbCy+WzCAIdsXLzTJo+qDy7TYPLp/mTrzfrSQMp5aFw0U0kkq5kobKx
	3ZVf61snnecbOSdg2MMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qMlOD-00DLLs-1m;
	Fri, 21 Jul 2023 08:21:29 +0000
Received: from dggsgout12.his.huawei.com ([45.249.212.56])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qMlO7-00DLHM-17;
	Fri, 21 Jul 2023 08:21:26 +0000
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4R6jF33Wktz4f3jHZ;
	Fri, 21 Jul 2023 16:21:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.174.178.55])
	by APP4 (Coremail) with SMTP id gCh0CgAHoZT2P7pkhprcOQ--.24672S5;
	Fri, 21 Jul 2023 16:21:13 +0800 (CST)
From: thunder.leizhen@huaweicloud.com
To: Dave Young <dyoung@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Cc: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/3] arm64: kdump: Allocate crash low memory in the bottom-up direction
Date: Fri, 21 Jul 2023 16:17:24 +0800
Message-Id: <20230721081726.882-2-thunder.leizhen@huaweicloud.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20230721081726.882-1-thunder.leizhen@huaweicloud.com>
References: <20230721081726.882-1-thunder.leizhen@huaweicloud.com>
MIME-Version: 1.0
X-CM-TRANSID: gCh0CgAHoZT2P7pkhprcOQ--.24672S5
X-Coremail-Antispam: 1UD129KBjvJXoW3ZF43XF4fuF1UGFWDAFWUArb_yoWkGryUpr
	1xJF4ftF1jyFnrGa1fJrn7Cr4xZa1S9a45XFyYyrn5KF9rKr93Kr43uFy7WryUKr95WFy7
	AFWrtr9Yva18XrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBCb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6r106r1rM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwAKzVCY07xG64k0F2
	4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWU
	JVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7V
	AKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42
	IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2db1UUUUU
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230721_012123_802225_F2E48774 
X-CRM114-Status: GOOD (  24.79  )
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

From: Zhen Lei <thunder.leizhen@huawei.com>

arm64_memblock_init()
	reserve_crashkernel()			(1)
paging_init()
	map_mem()				(2)
unflatten_device_tree or parse ACPI 		(3)
bootmem_init()
	zone_sizes_init()
		Update arm64_dma_phys_limit	(4)
	late_reserve_crashkernel()		(5)

For most arm64 platforms, DMA-capable devices can access the whole low 4G
memory without SMMU enabled. So we can directly use SZ_4G as upper limit
to do memblock alloc. However, DMA zone does not cover all the 32-bit
addressable memory on some specific platforms (e.g. 30-bit on Raspberry
Pi 4), and the upper limit of DMA zone (arm64_dma_phys_limit) is updated
after map_mem(), see (3)(4) above. Let's change the allocation direction
of low memory from top-town to bottom-up. In this way, as long as DMA zone
has continuous free memory that meets the size, the memory reserved for
crash will not exceed DMA zone. Of course, it's possible that the DMA zone
is not enough, so add late_reserve_crashkernel() to perform fall back if
need:
1. For case crashkernel=X(offset is not specified)
   Fall back to reserve region above DMA zone, and reserve default size of
   memory in DMA zone.
2. For case crashkernel=X,high
   Fall back to searching the low memory with the specified size in
   crashkernel=,high.

In reserve_crashkernel(), the allocation policy is as follows:

low                              high
 |<---DMA---|--------------------->|
 |                                 |
 |<<<-------------(1)--------------| top-town
 |----------------(2)----------->>>| bottom-up

(1) crashkernel=Y,high, upper limit is known, top-town.
(2) crashkernel=Y,low, crashkernel=X, upper limit is unknown, bottom-up.
(x) crashkernel=X@offset, fixed.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/mm/init.c | 212 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 160 insertions(+), 52 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index d31c3a9290c5524..d2ab377520b2742 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -69,23 +69,168 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit;
 
 #define CRASH_ADDR_LOW_MAX		arm64_dma_phys_limit
 #define CRASH_ADDR_HIGH_MAX		(PHYS_MASK + 1)
-#define CRASH_HIGH_SEARCH_BASE		SZ_4G
+#define CRASHKERNEL_TYPE_FIXED_BASE	1
+#define CRASHKERNEL_TYPE_HIGH		2
 
 #define DEFAULT_CRASH_KERNEL_LOW_SIZE	(128UL << 20)
 
+static int crashkernel_type __initdata;
+
+static phys_addr_t __init crashkernel_phys_alloc_range(phys_addr_t size,
+						       phys_addr_t start,
+						       phys_addr_t end)
+{
+	phys_addr_t base;
+	bool old_direction;
+
+	old_direction = memblock_bottom_up();
+	if (!end) {
+		/* The upper limit is unknown, let's allocate from bottom to up */
+		end = CRASH_ADDR_HIGH_MAX;
+		memblock_set_bottom_up(true);
+	}
+	base = memblock_phys_alloc_range(size, CRASH_ALIGN, start, end);
+	memblock_set_bottom_up(old_direction);
+
+	return base;
+}
+
+static void __init crashkernel_low_rollback(void)
+{
+	if (crashk_low_res.end) {
+		release_resource(&crashk_low_res);
+		memblock_phys_free(crashk_low_res.start, resource_size(&crashk_low_res));
+		crashk_low_res.start = 0;
+		crashk_low_res.end   = 0;
+	}
+}
+
+static void __init crashkernel_rollback(void)
+{
+	release_resource(&crashk_res);
+	memblock_phys_free(crashk_res.start, resource_size(&crashk_res));
+	crashk_res.start = 0;
+	crashk_res.end   = 0;
+
+	crashkernel_low_rollback();
+}
+
+static void __init late_reserve_crashkernel(void)
+{
+	struct resource *res;
+	unsigned long long low_base, low_size;
+	unsigned long long crash_base, crash_size;
+
+	res = &crashk_res;
+	if (!res->end)
+		return;
+
+	crash_size = resource_size(res);
+	if (crashkernel_type == CRASHKERNEL_TYPE_HIGH) {
+		/*
+		 *       CRASH_ADDR_LOW_MAX
+		 *               |
+		 * |<----DMA---->|------------|
+		 *    |-high-|			//case1
+		 *           |-high-|		//case2
+		 *                  |-high-|	//case3
+		 */
+		if (crashk_res.end < CRASH_ADDR_LOW_MAX)		/* case 1 */
+			crashkernel_low_rollback();
+		else if (crashk_res.start >= CRASH_ADDR_LOW_MAX)	/* case 3 */
+			res = &crashk_low_res;
+
+		low_size = crashk_low_res.end ? resource_size(&crashk_low_res) : 0;
+	}
+
+	/* All crashkernel memory is reserved as expected */
+	if (res->end < CRASH_ADDR_LOW_MAX)
+		goto ok;
+
+	crashkernel_rollback();
+
+	/* For details, see Documentation/arch/arm64/kdump.rst */
+	if (crashkernel_type == CRASHKERNEL_TYPE_FIXED_BASE) {
+		pr_warn("crashkernel reservation failed - memory range is invalid\n");
+		return;
+	} else if (crashkernel_type == CRASHKERNEL_TYPE_HIGH) {
+		/* Above case 3(low memory is not enough) */
+		if (res == &crashk_low_res) {
+			pr_warn("cannot allocate crashkernel low memory (size:0x%llx)\n", low_size);
+			return;
+		}
+
+		/*
+		 * Above case 2. Fall back to searching the low memory with
+		 * the specified size in crashkernel=,high
+		 */
+		crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
+						       0, CRASH_ADDR_LOW_MAX);
+		if (!crash_base) {
+			pr_warn("cannot allocate crashkernel (size:0x%llx)\n", crash_size);
+			return;
+		}
+	} else {
+		/*
+		 * Fall back to reserve region above DMA zone and allocate default
+		 * size of memory in DMA zone.
+		 */
+		low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
+		low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, 0, CRASH_ADDR_LOW_MAX);
+		if (!low_base) {
+			pr_warn("cannot allocate crashkernel low memory (size:0x%llx)\n", low_size);
+			return;
+		}
+
+		crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
+						       CRASH_ADDR_LOW_MAX, CRASH_ADDR_HIGH_MAX);
+		if (!crash_base) {
+			pr_warn("cannot allocate crashkernel (size:0x%llx)\n", crash_size);
+			memblock_phys_free(low_base, low_size);
+			return;
+		}
+
+		crashk_low_res.start = low_base;
+		crashk_low_res.end   = low_base + low_size - 1;
+		insert_resource(&iomem_resource, &crashk_low_res);
+	}
+
+	crashk_res.start = crash_base;
+	crashk_res.end   = crash_base + crash_size - 1;
+	insert_resource(&iomem_resource, &crashk_res);
+
+ok:
+	crash_base = crashk_res.start;
+	crash_size = resource_size(&crashk_res);
+	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
+		crash_base, crash_base + crash_size, crash_size >> 20);
+
+	if (crashk_low_res.end) {
+		low_base = crashk_low_res.start;
+		low_size = resource_size(&crashk_low_res);
+		pr_info("crashkernel low memory reserved: 0x%08llx - 0x%08llx (%lld MB)\n",
+			low_base, low_base + low_size, low_size >> 20);
+	}
+
+	/*
+	 * The crashkernel memory will be removed from the kernel linear
+	 * map. Inform kmemleak so that it won't try to access it.
+	 */
+	kmemleak_ignore_phys(crash_base);
+	if (crashk_low_res.end)
+		kmemleak_ignore_phys(crashk_low_res.start);
+}
+
 static int __init reserve_crashkernel_low(unsigned long long low_size)
 {
 	unsigned long long low_base;
 
-	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, 0, CRASH_ADDR_LOW_MAX);
+	low_base = crashkernel_phys_alloc_range(low_size, 0, CRASH_ADDR_LOW_MAX);
 	if (!low_base) {
 		pr_err("cannot allocate crashkernel low memory (size:0x%llx).\n", low_size);
 		return -ENOMEM;
 	}
 
-	pr_info("crashkernel low memory reserved: 0x%08llx - 0x%08llx (%lld MB)\n",
-		low_base, low_base + low_size, low_size >> 20);
-
 	crashk_low_res.start = low_base;
 	crashk_low_res.end   = low_base + low_size - 1;
 	insert_resource(&iomem_resource, &crashk_low_res);
@@ -102,12 +247,10 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
  */
 static void __init reserve_crashkernel(void)
 {
-	unsigned long long crash_low_size = 0, search_base = 0;
+	unsigned long long crash_low_size = 0;
 	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
 	unsigned long long crash_base, crash_size;
 	char *cmdline = boot_command_line;
-	bool fixed_base = false;
-	bool high = false;
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
@@ -131,9 +274,8 @@ static void __init reserve_crashkernel(void)
 		else if (ret)
 			return;
 
-		search_base = CRASH_HIGH_SEARCH_BASE;
 		crash_max = CRASH_ADDR_HIGH_MAX;
-		high = true;
+		crashkernel_type = CRASHKERNEL_TYPE_HIGH;
 	} else if (ret || !crash_size) {
 		/* The specified value is invalid */
 		return;
@@ -143,67 +285,31 @@ static void __init reserve_crashkernel(void)
 
 	/* User specifies base address explicitly. */
 	if (crash_base) {
-		fixed_base = true;
-		search_base = crash_base;
+		crashkernel_type = CRASHKERNEL_TYPE_FIXED_BASE;
 		crash_max = crash_base + crash_size;
 	}
 
-retry:
-	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
-					       search_base, crash_max);
+	crash_base = crashkernel_phys_alloc_range(crash_size, crash_base, crash_max);
 	if (!crash_base) {
 		/*
 		 * For crashkernel=size[KMG]@offset[KMG], print out failure
 		 * message if can't reserve the specified region.
 		 */
-		if (fixed_base) {
+		if (crashkernel_type == CRASHKERNEL_TYPE_FIXED_BASE) {
 			pr_warn("crashkernel reservation failed - memory is in use.\n");
 			return;
 		}
 
-		/*
-		 * For crashkernel=size[KMG], if the first attempt was for
-		 * low memory, fall back to high memory, the minimum required
-		 * low memory will be reserved later.
-		 */
-		if (!high && crash_max == CRASH_ADDR_LOW_MAX) {
-			crash_max = CRASH_ADDR_HIGH_MAX;
-			search_base = CRASH_ADDR_LOW_MAX;
-			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
-			goto retry;
-		}
+		pr_warn("cannot allocate crashkernel (size:0x%llx)\n", crash_size);
 
-		/*
-		 * For crashkernel=size[KMG],high, if the first attempt was
-		 * for high memory, fall back to low memory.
-		 */
-		if (high && crash_max == CRASH_ADDR_HIGH_MAX) {
-			crash_max = CRASH_ADDR_LOW_MAX;
-			search_base = 0;
-			goto retry;
-		}
-		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
-			crash_size);
 		return;
 	}
 
-	if ((crash_base >= CRASH_ADDR_LOW_MAX) && crash_low_size &&
-	     reserve_crashkernel_low(crash_low_size)) {
+	if (crash_low_size && reserve_crashkernel_low(crash_low_size)) {
 		memblock_phys_free(crash_base, crash_size);
 		return;
 	}
 
-	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
-		crash_base, crash_base + crash_size, crash_size >> 20);
-
-	/*
-	 * The crashkernel memory will be removed from the kernel linear
-	 * map. Inform kmemleak so that it won't try to access it.
-	 */
-	kmemleak_ignore_phys(crash_base);
-	if (crashk_low_res.end)
-		kmemleak_ignore_phys(crashk_low_res.start);
-
 	crashk_res.start = crash_base;
 	crashk_res.end = crash_base + crash_size - 1;
 	insert_resource(&iomem_resource, &crashk_res);
@@ -408,6 +514,8 @@ void __init arm64_memblock_init(void)
 
 	early_init_fdt_scan_reserved_mem();
 
+	reserve_crashkernel();
+
 	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
 }
 
@@ -454,7 +562,7 @@ void __init bootmem_init(void)
 	 * request_standard_resources() depends on crashkernel's memory being
 	 * reserved, so do it here.
 	 */
-	reserve_crashkernel();
+	late_reserve_crashkernel();
 
 	memblock_dump_all();
 }
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
