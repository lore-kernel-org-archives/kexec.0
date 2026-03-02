Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43BA0106ACD1
	for <kexec@archiver.kernel.org>; Thu, 12 Mar 2026 16:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k8s7sWUeIumSRdyN37vrcqKhTj67JVNAlPnWRgZl5yI=; b=Qt+g/Uxtds5R9SUlzgds+yh7r8
	GEEprQYej9HOrbjPK6cKqv/Khwa0+T6bTpB7XtDCrhQd+TxsLjcKE7j41zzfIGDNAxsCgmC3zb4gX
	7VN41QCqgeuZV7uSA/61X6GECjaPrHDB414B2dT0y/gL7j3JXi9Sef3yeeur5DMEM3P94ouaf/n4A
	xSSK8C+N5w3Urbpik78PT/h/nwjcWi7okReGkzpXnZjkeDiLC0ukQMiB0g/uGgWqRbsTppW8TNsg0
	krgUh5hBnMg2pIQMHvpXenpIld9qJqQ8N7Fb/MfzbZezD5On4zjlFFBf7W7yBPkN5T+da+Oq/Ozew
	HjbKtpcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0jAS-0000000Ec8W-2lrT;
	Thu, 12 Mar 2026 16:45:48 +0000
Received: from canpmsgout01.his.huawei.com ([113.46.200.216])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwuLx-0000000CDKQ-3do0;
	Mon, 02 Mar 2026 03:53:55 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=k8s7sWUeIumSRdyN37vrcqKhTj67JVNAlPnWRgZl5yI=;
	b=6ElkgikEZ/vz6lGd2d8Hi65EczFJ5BuYqAG/cR6uHlmF93k5wGX4SQ7JlS1PM1flAsSBFY1P4
	abFOuPIM+zmOUy9YZBMlU7l0HnKXjwKY/0EGrHkwBevOJz+NryhtLTCFS/oYKEq7xwtBMIdpLRK
	g8/yMrjJCbP3CwCK34Ihj04=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fPPzz6lVLz1T4G5;
	Mon,  2 Mar 2026 11:48:47 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 6F5FE40363;
	Mon,  2 Mar 2026 11:53:46 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 2 Mar
 2026 11:53:43 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <robh@kernel.org>, <saravanak@kernel.org>,
	<akpm@linux-foundation.org>, <bhe@redhat.com>, <vgoyal@redhat.com>,
	<dyoung@redhat.com>, <rdunlap@infradead.org>, <pmladek@suse.com>,
	<dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <paulmck@kernel.org>,
	<lirongqing@baidu.com>, <fvdl@google.com>, <rppt@kernel.org>,
	<ardb@kernel.org>, <leitao@debian.org>, <sourabhjain@linux.ibm.com>,
	<jbohac@suse.cz>, <cfsworks@gmail.com>, <osandov@fb.com>,
	<tangyouling@kylinos.cn>, <ritesh.list@gmail.com>, <hbathini@linux.ibm.com>,
	<eajames@linux.ibm.com>, <songshuaishuai@tinylab.org>,
	<kevin.brodsky@arm.com>, <samuel.holland@sifive.com>,
	<vishal.moola@gmail.com>, <junhui.liu@pigmoral.tech>, <coxu@redhat.com>,
	<liaoyuanhong@vivo.com>, <fuqiang.wang@easystack.cn>, <brgerst@gmail.com>,
	<x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v8 3/5] crash: Use crash_exclude_core_ranges() on powerpc
Date: Mon, 2 Mar 2026 11:53:13 +0800
Message-ID: <20260302035315.3892241-4-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260302035315.3892241-1-ruanjinjie@huawei.com>
References: <20260302035315.3892241-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260301_195354_325714_A1FBC752 
X-CRM114-Status: GOOD (  15.67  )
X-Mailman-Approved-At: Thu, 12 Mar 2026 09:45:47 -0700
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

The crash memory exclude of crashk_res and crashk_cma memory on powerpc
are almost identical to the generic crash_exclude_core_ranges().

By introducing the architecture-specific arch_crash_exclude_mem_range()
function with a default implementation of crash_exclude_mem_range(),
and using crash_exclude_mem_range_guarded as powerpc's separate
implementation, the generic crash_exclude_core_ranges() helper function
can be reused.

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/powerpc/include/asm/kexec_ranges.h |  3 ---
 arch/powerpc/kexec/crash.c              |  2 +-
 arch/powerpc/kexec/ranges.c             | 16 ++++------------
 include/linux/crash_core.h              |  4 ++++
 kernel/crash_core.c                     | 19 +++++++++++++------
 5 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/include/asm/kexec_ranges.h b/arch/powerpc/include/asm/kexec_ranges.h
index ad95e3792d10..8489e844b447 100644
--- a/arch/powerpc/include/asm/kexec_ranges.h
+++ b/arch/powerpc/include/asm/kexec_ranges.h
@@ -7,9 +7,6 @@
 void sort_memory_ranges(struct crash_mem *mrngs, bool merge);
 struct crash_mem *realloc_mem_ranges(struct crash_mem **mem_ranges);
 int add_mem_range(struct crash_mem **mem_ranges, u64 base, u64 size);
-int crash_exclude_mem_range_guarded(struct crash_mem **mem_ranges,
-				    unsigned long long mstart,
-				    unsigned long long mend);
 int get_exclude_memory_ranges(struct crash_mem **mem_ranges);
 int get_reserved_memory_ranges(struct crash_mem **mem_ranges);
 int get_crash_memory_ranges(struct crash_mem **mem_ranges);
diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
index 898742a5205c..e59e909c369d 100644
--- a/arch/powerpc/kexec/crash.c
+++ b/arch/powerpc/kexec/crash.c
@@ -451,7 +451,7 @@ static void update_crash_elfcorehdr(struct kimage *image, struct memory_notify *
 		base_addr = PFN_PHYS(mn->start_pfn);
 		size = mn->nr_pages * PAGE_SIZE;
 		end = base_addr + size - 1;
-		ret = crash_exclude_mem_range_guarded(&cmem, base_addr, end);
+		ret = arch_crash_exclude_mem_range(&cmem, base_addr, end);
 		if (ret) {
 			pr_err("Failed to remove hot-unplugged memory from crash memory ranges\n");
 			goto out;
diff --git a/arch/powerpc/kexec/ranges.c b/arch/powerpc/kexec/ranges.c
index 6c58bcc3e130..e5fea23b191b 100644
--- a/arch/powerpc/kexec/ranges.c
+++ b/arch/powerpc/kexec/ranges.c
@@ -553,9 +553,9 @@ int get_usable_memory_ranges(struct crash_mem **mem_ranges)
 #endif /* CONFIG_KEXEC_FILE */
 
 #ifdef CONFIG_CRASH_DUMP
-int crash_exclude_mem_range_guarded(struct crash_mem **mem_ranges,
-					   unsigned long long mstart,
-					   unsigned long long mend)
+int arch_crash_exclude_mem_range(struct crash_mem **mem_ranges,
+				 unsigned long long mstart,
+				 unsigned long long mend)
 {
 	struct crash_mem *tmem = *mem_ranges;
 
@@ -604,18 +604,10 @@ int get_crash_memory_ranges(struct crash_mem **mem_ranges)
 			sort_memory_ranges(*mem_ranges, true);
 	}
 
-	/* Exclude crashkernel region */
-	ret = crash_exclude_mem_range_guarded(mem_ranges, crashk_res.start, crashk_res.end);
+	ret = crash_exclude_core_ranges(mem_ranges);
 	if (ret)
 		goto out;
 
-	for (i = 0; i < crashk_cma_cnt; ++i) {
-		ret = crash_exclude_mem_range_guarded(mem_ranges, crashk_cma_ranges[i].start,
-					      crashk_cma_ranges[i].end);
-		if (ret)
-			goto out;
-	}
-
 	/*
 	 * FIXME: For now, stay in parity with kexec-tools but if RTAS/OPAL
 	 *        regions are exported to save their context at the time of
diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 033b20204aca..dbec826dc53b 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -68,6 +68,7 @@ extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_ma
 				       void **addr, unsigned long *sz);
 extern int crash_prepare_headers(int need_kernel_map, void **addr,
 				 unsigned long *sz, unsigned long *nr_mem_ranges);
+extern int crash_exclude_core_ranges(struct crash_mem **cmem);
 
 struct kimage;
 struct kexec_segment;
@@ -88,6 +89,9 @@ extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
 extern unsigned int arch_get_system_nr_ranges(void);
 extern int arch_crash_populate_cmem(struct crash_mem *cmem);
 extern int arch_crash_exclude_ranges(struct crash_mem *cmem);
+extern int arch_crash_exclude_mem_range(struct crash_mem **mem,
+					unsigned long long mstart,
+					unsigned long long mend);
 
 #else /* !CONFIG_CRASH_DUMP*/
 struct pt_regs;
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 96a96e511f5a..300d44ad5471 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -287,24 +287,31 @@ unsigned int __weak arch_get_system_nr_ranges(void) { return 0; }
 int __weak arch_crash_populate_cmem(struct crash_mem *cmem) { return -1; }
 int __weak arch_crash_exclude_ranges(struct crash_mem *cmem) { return 0; }
 
-static int crash_exclude_core_ranges(struct crash_mem *cmem)
+int __weak arch_crash_exclude_mem_range(struct crash_mem **mem,
+					unsigned long long mstart,
+					unsigned long long mend)
+{
+	return crash_exclude_mem_range(*mem, mstart, mend);
+}
+
+int crash_exclude_core_ranges(struct crash_mem **cmem)
 {
 	int ret, i;
 
 	/* Exclude crashkernel region */
-	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
+	ret = arch_crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
 	if (ret)
 		return ret;
 
 	if (crashk_low_res.end) {
-		ret = crash_exclude_mem_range(cmem, crashk_low_res.start, crashk_low_res.end);
+		ret = arch_crash_exclude_mem_range(cmem, crashk_low_res.start, crashk_low_res.end);
 		if (ret)
 			return ret;
 	}
 
 	for (i = 0; i < crashk_cma_cnt; ++i) {
-		ret = crash_exclude_mem_range(cmem, crashk_cma_ranges[i].start,
-					      crashk_cma_ranges[i].end);
+		ret = arch_crash_exclude_mem_range(cmem, crashk_cma_ranges[i].start,
+						   crashk_cma_ranges[i].end);
 		if (ret)
 			return ret;
 	}
@@ -331,7 +338,7 @@ int crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
 	if (ret)
 		goto out;
 
-	ret = crash_exclude_core_ranges(cmem);
+	ret = crash_exclude_core_ranges(&cmem);
 	if (ret)
 		goto out;
 
-- 
2.34.1


