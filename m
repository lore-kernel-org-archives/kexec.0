Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91089EB64DD
	for <kexec@archiver.kernel.org>; Fri, 21 Jul 2023 08:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=X2SgUbSuq1CPbLxm0R8vdft6fvsQMhRUia8uUfwzlho=; b=fbFN4Hmu1Th2kY
	NKe7rB2uJybMsHAIyYYq6oJrp9KC7/z/xWmeXv4DgUye5nOMcyxF3tOZDzS0JvSE4OZKXtke5WAWe
	yPCKVpeiNRYcbB1tywEHvS9OA7ovB1rO7U0XBy3BBQWLomu4v1EmwcnVjb8uDaj1H/0vPolZ3rah5
	yWoDJkBqrNYxMg9Y6RK9hel3L0I9amfSjqRmpFrZUJrYJDlC2YQ66BESD5EBZelC3YG3Huwcr8Y56
	CWk6ZZNJi/wKTk6XELK/f2P3BwtwiFUZX9XG9hwxNFPXkYko9yerJC7MD2M/E/nQ1Y/Jnw+FBcSQ7
	RFy1zXCZO/PxGivfCFXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qMlOC-00DLKU-1g;
	Fri, 21 Jul 2023 08:21:28 +0000
Received: from [45.249.212.51] (helo=dggsgout11.his.huawei.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qMlO7-00DLHD-0i;
	Fri, 21 Jul 2023 08:21:25 +0000
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R6jF54MWYz4f41GL;
	Fri, 21 Jul 2023 16:21:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.174.178.55])
	by APP4 (Coremail) with SMTP id gCh0CgAHoZT2P7pkhprcOQ--.24672S6;
	Fri, 21 Jul 2023 16:21:14 +0800 (CST)
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
Subject: [PATCH 2/3] arm64: kdump: use page-level mapping for crashkernel region
Date: Fri, 21 Jul 2023 16:17:25 +0800
Message-Id: <20230721081726.882-3-thunder.leizhen@huaweicloud.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20230721081726.882-1-thunder.leizhen@huaweicloud.com>
References: <20230721081726.882-1-thunder.leizhen@huaweicloud.com>
MIME-Version: 1.0
X-CM-TRANSID: gCh0CgAHoZT2P7pkhprcOQ--.24672S6
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4ktrWkuw43ZF1Uuw4rZrb_yoW8Wr4rpr
	1kZ3s8Gr4rC3Z3ua1fWwn7Z3yrtw1FkFy5Za13A3Wvga1kJ39xKryrWFySvryjgrWftr4S
	vr10yrn3Wa12yrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBCb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6r106r1rM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwAKzVCY07xG64k0F2
	4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWU
	JVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7V
	AKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42
	IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU49mRUUUUU
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230721_012123_449579_56204471 
X-CRM114-Status: UNSURE (   9.80  )
X-CRM114-Notice: Please train this message.
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

Use page-level mappings for crashkernel region so that we can use
set_memory_valid() to do access protection for it.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/mm/mmu.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 95d360805f8aeb3..e0a197ebe14837d 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -594,6 +594,11 @@ static void __init map_mem(pgd_t *pgdp)
 	 */
 	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
 
+#ifdef CONFIG_KEXEC_CORE
+	if (crashk_res.end)
+		memblock_mark_nomap(crashk_res.start, resource_size(&crashk_res));
+#endif
+
 	/* map all the memory banks */
 	for_each_mem_range(i, &start, &end) {
 		if (start >= end)
@@ -621,6 +626,22 @@ static void __init map_mem(pgd_t *pgdp)
 		       PAGE_KERNEL, NO_CONT_MAPPINGS);
 	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
 	arm64_kfence_map_pool(early_kfence_pool, pgdp);
+
+	/*
+	 * Use page-level mappings here so that we can shrink the region
+	 * in page granularity and put back unused memory to buddy system
+	 * through /sys/kernel/kexec_crash_size interface.
+	 */
+#ifdef CONFIG_KEXEC_CORE
+	if (crashk_res.end) {
+		__map_memblock(pgdp, crashk_res.start,
+			       crashk_res.end + 1,
+			       PAGE_KERNEL,
+			       NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
+		memblock_clear_nomap(crashk_res.start,
+				     resource_size(&crashk_res));
+	}
+#endif
 }
 
 void mark_rodata_ro(void)
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
