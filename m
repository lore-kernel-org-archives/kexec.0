Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0663C5DF6D
	for <kexec@archiver.kernel.org>; Sat, 15 Aug 2026 07:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o2MfIbIpab6sBV5thXVrF9AYDGvnd3HG9zD/Hp4jR/4=; b=uuWEGp48UWccyqCiZI78wX4SYQ
	lqZAQ7VNmEJLzHntQecCcmI0FXfSSmPVAcqhucXnoUt67uXdlE1itxiIz3bMQffssumVUHe3XYpAW
	MH7sJoeoilXX6QCnX8K46zCLdTdUA8BnbY8REJkPELq3wC1Jko6s4sKirTWEste4mgweygWBcFrt4
	oyNWyFssAfL9bw2n/fKK+qX6uoCcT84Wt+iI8DXRHqZukr/P5ZxlysojwHk9zTUAXJPTU/V694qsV
	EM4NHj5JmJBCHMy5ODPCFvUuF6ddCctigBnxYp6R9VbgEuipxARjbofX9FvGjFcgM9VVm5jf5mNrY
	QIZGuilQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wv95L-00000003cxN-1Y8D;
	Sat, 15 Aug 2026 07:45:43 +0000
Received: from canpmsgout02.his.huawei.com ([113.46.200.217])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1we8ar-0000000EEKy-2meL;
	Mon, 29 Jun 2026 09:47:59 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=o2MfIbIpab6sBV5thXVrF9AYDGvnd3HG9zD/Hp4jR/4=;
	b=MKsW01v71lyzHBKuxcUCGXDG3iC+LjXlgBljdiGZ5GNea3mwcKjmTJ3Sna5AEeAIXHbUyKd7I
	FfGFcBsOdG4OwgLPgjq9m/d4R5wCaqfhOVZrxcAR19U5sPQm8CYu8Of5fG2WJvOnTcVHE47Biyz
	xff7YUvgHUdXIRUyeUgoNLE=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gph7H3CS9zcZyF;
	Mon, 29 Jun 2026 17:39:07 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 2C79A203C1;
	Mon, 29 Jun 2026 17:47:54 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 29 Jun
 2026 17:47:51 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <robh@kernel.org>, <saravanak@kernel.org>,
	<akpm@linux-foundation.org>, <baoquan.he@linux.dev>, <rppt@kernel.org>,
	<pasha.tatashin@soleen.com>, <pratyush@kernel.org>, <ruirui.yang@linux.dev>,
	<rdunlap@infradead.org>, <peterz@infradead.org>,
	<feng.tang@linux.alibaba.com>, <dapeng1.mi@linux.intel.com>,
	<elver@google.com>, <enelsonmoore@gmail.com>, <kuba@kernel.org>,
	<ebiggers@kernel.org>, <lirongqing@baidu.com>, <leitao@debian.org>,
	<kees@kernel.org>, <coxu@redhat.com>, <cfsworks@gmail.com>, <jbohac@suse.cz>,
	<osandov@fb.com>, <ryan.roberts@arm.com>, <tangyouling@kylinos.cn>,
	<sourabhjain@linux.ibm.com>, <ritesh.list@gmail.com>, <gaohan@iscas.ac.cn>,
	<david@kernel.org>, <wangruikang@iscas.ac.cn>, <muchun.song@linux.dev>,
	<vishal.moola@gmail.com>, <junhui.liu@pigmoral.tech>, <guoren@kernel.org>,
	<namcao@linutronix.de>, <rick.p.edgecombe@intel.com>, <djbw@kernel.org>,
	<liaoyuanhong@vivo.com>, <fuqiang.wang@easystack.cn>,
	<vishal.l.verma@intel.com>, <chenjiahao16@huawei.com>, <x86@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v17 03/10] crash: Add crash_prepare_headers() to exclude crash kernel memory
Date: Mon, 29 Jun 2026 17:47:39 +0800
Message-ID: <20260629094746.191843-4-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629094746.191843-1-ruanjinjie@huawei.com>
References: <20260629094746.191843-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260629_024758_023709_CB3097B5 
X-CRM114-Status: GOOD (  16.16  )
X-Mailman-Approved-At: Sat, 15 Aug 2026 00:45:39 -0700
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

The crash memory alloc, and the exclude of crashk_res, crashk_low_res
and crashk_cma memory are almost identical across different architectures,
handling them in the crash core would eliminate a lot of duplication, so
add crash_prepare_headers() helper to handle them in the common code.

To achieve the above goal, three architecture-specific functions are
introduced:

- arch_get_system_nr_ranges(). Pre-counts the max number of memory ranges.

- arch_crash_populate_cmem(). Collects the memory ranges and fills them
  into cmem.

- arch_crash_exclude_ranges(). Architecture's additional crash memory
  ranges exclusion, defaulting to empty.

Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 include/linux/crash_core.h |  5 +++
 kernel/crash_core.c        | 82 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 84 insertions(+), 3 deletions(-)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index c1dee3f971a9..583ffcc703d4 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -59,6 +59,8 @@ extern int crash_exclude_mem_range(struct crash_mem *mem,
 				   unsigned long long mend);
 extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 				       void **addr, unsigned long *sz);
+extern int crash_prepare_headers(int need_kernel_map, void **addr,
+				 unsigned long *sz, unsigned long *nr_mem_ranges);
 
 struct kimage;
 struct kexec_segment;
@@ -76,6 +78,9 @@ int kexec_should_crash(struct task_struct *p);
 int kexec_crash_loaded(void);
 void crash_save_cpu(struct pt_regs *regs, int cpu);
 extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
+extern unsigned int arch_get_system_nr_ranges(void);
+extern int arch_crash_populate_cmem(struct crash_mem *cmem);
+extern int arch_crash_exclude_ranges(struct crash_mem *cmem);
 
 #else /* !CONFIG_CRASH_DUMP*/
 struct pt_regs;
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 4f21fc3b108b..481babc29131 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -168,9 +168,6 @@ static inline resource_size_t crash_resource_size(const struct resource *res)
 	return !res->end ? 0 : resource_size(res);
 }
 
-
-
-
 int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 			  void **addr, unsigned long *sz)
 {
@@ -272,6 +269,85 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 	return 0;
 }
 
+static struct crash_mem *alloc_cmem(unsigned int nr_ranges)
+{
+	struct crash_mem *cmem;
+
+	cmem = kvzalloc_flex(*cmem, ranges, nr_ranges);
+	if (!cmem)
+		return NULL;
+
+	cmem->max_nr_ranges = nr_ranges;
+	return cmem;
+}
+
+unsigned int __weak arch_get_system_nr_ranges(void) { return 0; }
+int __weak arch_crash_populate_cmem(struct crash_mem *cmem) { return -1; }
+int __weak arch_crash_exclude_ranges(struct crash_mem *cmem) { return 0; }
+
+static int crash_exclude_core_ranges(struct crash_mem *cmem)
+{
+	int ret, i;
+
+	/* Exclude crashkernel region */
+	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
+	if (ret)
+		return ret;
+
+	if (crashk_low_res.end) {
+		ret = crash_exclude_mem_range(cmem, crashk_low_res.start, crashk_low_res.end);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < crashk_cma_cnt; ++i) {
+		ret = crash_exclude_mem_range(cmem, crashk_cma_ranges[i].start,
+					      crashk_cma_ranges[i].end);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
+			  unsigned long *nr_mem_ranges)
+{
+	unsigned int max_nr_ranges;
+	struct crash_mem *cmem;
+	int ret;
+
+	max_nr_ranges = arch_get_system_nr_ranges();
+	if (!max_nr_ranges)
+		return -ENOMEM;
+
+	cmem = alloc_cmem(max_nr_ranges);
+	if (!cmem)
+		return -ENOMEM;
+
+	ret = arch_crash_populate_cmem(cmem);
+	if (ret)
+		goto out;
+
+	ret = crash_exclude_core_ranges(cmem);
+	if (ret)
+		goto out;
+
+	ret = arch_crash_exclude_ranges(cmem);
+	if (ret)
+		goto out;
+
+	/* Return the computed number of memory ranges, for hotplug usage */
+	if (nr_mem_ranges)
+		*nr_mem_ranges = cmem->nr_ranges;
+
+	ret = crash_prepare_elf64_headers(cmem, need_kernel_map, addr, sz);
+
+out:
+	kvfree(cmem);
+	return ret;
+}
+
 /**
  * crash_exclude_mem_range - exclude a mem range for existing ranges
  * @mem: mem->range contains an array of ranges sorted in ascending order
-- 
2.34.1


