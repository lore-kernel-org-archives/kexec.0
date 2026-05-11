Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ACFDCD4F25
	for <kexec@archiver.kernel.org>; Tue, 12 May 2026 17:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/Z8pSXRPzgFbDuL6GrhVOKi8FQUjYKB06M0JUN2M3+4=; b=QvN7ZZln876jn3MBbd+LI4xsLD
	2RTzeq5NmzNH+EHTWRbFn0UNZd3VI8Aif9hzyYcU15uAtLHQm1vExhAu2e50Z7Pp+ouTv7Tf3J3G9
	VzQOce7Uap0i7KYwHWnjT++RgMtx9WzeH6XlhRKngq82EC4uPON9mz/hVfqev2PTAMTamLUuGcPVk
	22qGtmD+cOPQggn/EmdUgTniHGLaIh1/FjawFlLIUlTPPKliXb1GF1ZEkFyMnyiE/ODHgzwnh91ty
	mCKVBiEsBNoI4kiw+oPnlgcNErCyBonHHCDTSOqoHpL296FhuSKZggI627SXQwO5SItG4g4hISP+K
	O1XfqWFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMrLL-0000000019g-1dn4;
	Tue, 12 May 2026 17:56:31 +0000
Received: from canpmsgout06.his.huawei.com ([113.46.200.221])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMGyB-0000000C6mP-0ZIs;
	Mon, 11 May 2026 03:06:17 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=/Z8pSXRPzgFbDuL6GrhVOKi8FQUjYKB06M0JUN2M3+4=;
	b=sPOsEoErWK5rzBoDWe8ea8ZkE87/O3kOGzjrTg9xtwYmBf0RJI27gLreHOVi6bwmN7TCiAYjB
	4swPogecu7WxgmwCrca9O/Pwb9vcQXQ4fMB4pN6cW59sNLhzn2AlCLH/o+yRAlRa3hl1USGh271
	xhRqrYZ5eg0RYGlI/fvU2Jo=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gDPYj2yTgzRhWv;
	Mon, 11 May 2026 10:58:33 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id BF3F740572;
	Mon, 11 May 2026 11:06:08 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 11 May
 2026 11:06:05 +0800
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
	<rdunlap@infradead.org>, <pmladek@suse.com>, <dapeng1.mi@linux.intel.com>,
	<kees@kernel.org>, <elver@google.com>, <kuba@kernel.org>,
	<ebiggers@kernel.org>, <lirongqing@baidu.com>, <paulmck@kernel.org>,
	<ruanjinjie@huawei.com>, <sourabhjain@linux.ibm.com>, <coxu@redhat.com>,
	<leitao@debian.org>, <jbohac@suse.cz>, <ryan.roberts@arm.com>,
	<osandov@fb.com>, <cfsworks@gmail.com>, <tangyouling@kylinos.cn>,
	<ritesh.list@gmail.com>, <adityag@linux.ibm.com>, <guoren@kernel.org>,
	<songshuaishuai@tinylab.org>, <kevin.brodsky@arm.com>,
	<vishal.moola@gmail.com>, <junhui.liu@pigmoral.tech>,
	<wangruikang@iscas.ac.cn>, <namcao@linutronix.de>, <chao.gao@intel.com>,
	<seanjc@google.com>, <fuqiang.wang@easystack.cn>, <ardb@kernel.org>,
	<chenjiahao16@huawei.com>, <hbathini@linux.ibm.com>,
	<takahiro.akashi@linaro.org>, <james.morse@arm.com>, <lizhengyu3@huawei.com>,
	<x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<kexec@lists.infradead.org>
Subject: [PATCH v13 08/15] crash: Add crash_prepare_headers() to exclude crash kernel memory
Date: Mon, 11 May 2026 11:04:47 +0800
Message-ID: <20260511030454.1730881-9-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511030454.1730881-1-ruanjinjie@huawei.com>
References: <20260511030454.1730881-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260510_200611_597482_0276A474 
X-CRM114-Status: GOOD (  16.69  )
X-Mailman-Approved-At: Tue, 12 May 2026 10:56:26 -0700
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
 kernel/crash_core.c        | 91 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 93 insertions(+), 3 deletions(-)

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
index 4f21fc3b108b..d28be3890efb 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -16,6 +16,7 @@
 #include <linux/mm.h>
 #include <linux/cpuhotplug.h>
 #include <linux/memblock.h>
+#include <linux/memory_hotplug.h>
 #include <linux/kmemleak.h>
 #include <linux/crash_core.h>
 #include <linux/reboot.h>
@@ -168,9 +169,6 @@ static inline resource_size_t crash_resource_size(const struct resource *res)
 	return !res->end ? 0 : resource_size(res);
 }
 
-
-
-
 int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 			  void **addr, unsigned long *sz)
 {
@@ -272,6 +270,93 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
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
+	get_online_mems();
+	max_nr_ranges = arch_get_system_nr_ranges();
+	if (!max_nr_ranges) {
+		put_online_mems();
+		return -ENOMEM;
+	}
+
+	cmem = alloc_cmem(max_nr_ranges);
+	if (!cmem) {
+		put_online_mems();
+		return -ENOMEM;
+	}
+
+	ret = arch_crash_populate_cmem(cmem);
+	if (ret) {
+		put_online_mems();
+		goto out;
+	}
+
+	put_online_mems();
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


