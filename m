Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A68CD6E6A
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 15:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j9XfifB+qCFiWXjFgjGAVxxf9YxSLc/J0SqjfD1KNYc=; b=HuWt55BzAPe84iIlsoumvFS6V3
	d4dT5perTsPpdoAXwQg8FCr85Ss2XP1nhTZSiQPYJ2rci/PAslHsggXmPXJOQxw0DLaqUTfTSH1aH
	wTtD+d3tRRIurSkLelzY/kaylVDJXAWrj8CGvn7ZdJiF1Oezmkk++C1WVMyHaF5fGRqGn8b3wvM9k
	ynJYcLCvYJeNsRQvUS6QdX7H6a+FxiY9uzDF4jD843rACbuPZvMVbUI1L5FrViqurNszQhCneWwus
	SO+yOQjGRNAICbTB354VdL81lemPQBUlOclvFrZ51PYws59R0OQBTWSKTNG3H12cPsVHtElzkRWYQ
	muC/ZkvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUQrp-0000000DIRK-2qpy;
	Tue, 02 Jun 2026 15:17:21 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRR1l-0000000Gik5-0B3p;
	Mon, 25 May 2026 08:51:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Content-Transfer-Encoding
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=j9XfifB+qCFiWXjFgjGAVxxf9YxSLc/J0SqjfD1KNYc=; b=UF9bOebYgIFMBiBeapDT1rMdem
	DORjn/AhMC5MbIlz3Nw2tkyMOFo7AlgylAwhFZwDiESt/Je4dS73NS6EPceN4lvIlmwWmL+8Ls+Rr
	zyWjE/a+/lZXjYilibxsUlyjgUvfZmCyQUqJR1CcAAYeA7Vdjxuz7qqLew5ttiWdL5mjLfqO+pSWX
	v+TvduweaXklmGj64p0tFjgI+lCh6/BbT3RAGgyv9gTK5Xm80qbexIaxYBcYckITkWowbGpR0m676
	ijoz6XU8iWffsydbGAaxw6DALqIdTHPAjlZekbGh7jdEUheu7cAZvNN0jsfFcbT6/MLlwpjiQEZ+F
	O068G4kA==;
Received: from canpmsgout12.his.huawei.com ([113.46.200.227])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRR1h-00000008oVa-0lFA;
	Mon, 25 May 2026 08:51:11 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=j9XfifB+qCFiWXjFgjGAVxxf9YxSLc/J0SqjfD1KNYc=;
	b=WVWhXTBCaob4Ly9peOxmC/DpO8+2cRtSw1oRRvYPafqNoda/oCbp/Do07gbAApMt1/8OwoFkV
	8qxu9coWPqn2Rq9eNX4O8KGuI0qdbrHTa6iqp/CwZJyCyvA2XhgFMT5YSjlWCvV+Q1Tha2QmHgv
	cIFBhQ3Dyyz5c5EEIaoVvcc=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gP8Xq65ptznTV7;
	Mon, 25 May 2026 16:43:07 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 2440D40538;
	Mon, 25 May 2026 16:51:06 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 25 May
 2026 16:51:02 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <robh@kernel.org>, <saravanak@kernel.org>,
	<akpm@linux-foundation.org>, <bhe@redhat.com>, <rppt@kernel.org>,
	<pasha.tatashin@soleen.com>, <pratyush@kernel.org>, <ruirui.yang@linux.dev>,
	<rdunlap@infradead.org>, <pmladek@suse.com>, <feng.tang@linux.alibaba.com>,
	<dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <elver@google.com>,
	<kuba@kernel.org>, <lirongqing@baidu.com>, <ebiggers@kernel.org>,
	<paulmck@kernel.org>, <thuth@redhat.com>, <ardb@kernel.org>,
	<masahiroy@kernel.org>, <mark.rutland@arm.com>, <maz@kernel.org>,
	<james.morse@arm.com>, <leitao@debian.org>, <sourabhjain@linux.ibm.com>,
	<yeoreum.yun@arm.com>, <coxu@redhat.com>, <jbohac@suse.cz>,
	<ryan.roberts@arm.com>, <cfsworks@gmail.com>, <tangyouling@kylinos.cn>,
	<ritesh.list@gmail.com>, <songshuaishuai@tinylab.org>,
	<junhui.liu@pigmoral.tech>, <vishal.moola@gmail.com>, <kas@kernel.org>,
	<debug@rivosinc.com>, <namcao@linutronix.de>, <liaoyuanhong@vivo.com>,
	<fuqiang.wang@easystack.cn>, <seanjc@google.com>, <guoren@kernel.org>,
	<chenjiahao16@huawei.com>, <hbathini@linux.ibm.com>, <bgwin@google.com>,
	<takahiro.akashi@linaro.org>, <lizhengyu3@huawei.com>, <x86@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v14 14/17] crash: Use crash_exclude_core_ranges() on powerpc
Date: Mon, 25 May 2026 16:49:29 +0800
Message-ID: <20260525084932.934910-15-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260525084932.934910-1-ruanjinjie@huawei.com>
References: <20260525084932.934910-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260525_095110_348282_CC2CC552 
X-CRM114-Status: GOOD (  16.18  )
X-Mailman-Approved-At: Tue, 02 Jun 2026 08:17:11 -0700
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

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
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
index d634db67becc..775895f31037 100644
--- a/arch/powerpc/kexec/crash.c
+++ b/arch/powerpc/kexec/crash.c
@@ -513,7 +513,7 @@ static void update_crash_elfcorehdr(struct kimage *image, struct memory_notify *
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
index d69c4c7c1f5e..0f4ea7ffd066 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -63,6 +63,7 @@ extern int crash_prepare_headers(int need_kernel_map, void **addr,
 				 unsigned long *sz, unsigned long *nr_mem_ranges);
 extern int crash_prepare_headers_locked(int need_kernel_map, void **addr,
 					unsigned long *sz, unsigned long *nr_mem_ranges);
+extern int crash_exclude_core_ranges(struct crash_mem **cmem);
 
 struct kimage;
 struct kexec_segment;
@@ -83,6 +84,9 @@ extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
 extern unsigned int arch_get_system_nr_ranges(void);
 extern int arch_crash_populate_cmem(struct crash_mem *cmem);
 extern int arch_crash_exclude_ranges(struct crash_mem *cmem);
+extern int arch_crash_exclude_mem_range(struct crash_mem **mem,
+					unsigned long long mstart,
+					unsigned long long mend);
 
 #else /* !CONFIG_CRASH_DUMP*/
 struct pt_regs;
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index e84f3b63e79d..33e945da6776 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -286,24 +286,31 @@ unsigned int __weak arch_get_system_nr_ranges(void) { return 0; }
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
@@ -330,7 +337,7 @@ int crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
 	if (ret)
 		goto out;
 
-	ret = crash_exclude_core_ranges(cmem);
+	ret = crash_exclude_core_ranges(&cmem);
 	if (ret)
 		goto out;
 
-- 
2.34.1


