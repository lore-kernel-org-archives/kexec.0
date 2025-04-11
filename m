Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB676C36010
	for <kexec@archiver.kernel.org>; Fri, 11 Apr 2025 05:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eMaXaCye5JvtI4iyq2OlhLRAarHJFPgt7ym62C9j544=; b=roqoUMfgApKh7cf1oOtwrqhMfN
	pJ03PheHKE0easPwiC00FBEhjATQD8ttUBLyfTPfJggRwcKbr4FP3tNyH6ZwYyP3ye2l9XveDwpvF
	ZuW0xjkTeVobQmZJqsbnRVnDw7ytsyTNasognNJtR98g+LPbPKbTZirQztyN7Y94z3fiX2PtcIwxp
	8WX9d1X3TIFnzqy91pSvcoL0f6pX1fqS4G0I1dDGBw2v6Aks6/ZCHIgxnx/rqFi03DL6BEp3hR03K
	d7ty/A7wZeD0/eDIDSx0pb0fAdvB6kbzYOJOzd6mdrG6jijGoWpv3OV5EaEftLx2EmjLNa2KNCw2Q
	5jDYe5xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u37D4-0000000Cazg-2Qpx;
	Fri, 11 Apr 2025 05:45:50 +0000
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u375u-0000000CYOC-2tYg
	for kexec@lists.infradead.org;
	Fri, 11 Apr 2025 05:38:28 +0000
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-2240a7aceeaso14915955ad.0
        for <kexec@lists.infradead.org>; Thu, 10 Apr 2025 22:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744349905; x=1744954705; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eMaXaCye5JvtI4iyq2OlhLRAarHJFPgt7ym62C9j544=;
        b=06teY/C40j84l8W8abeMOBTiZ+P+3BonMkK+DNprgU2x7AhXAHk4oMrYojPkS0WIuk
         wRWZkSnjhL3mDAjBjihHuIgUHBwrlxFJjGGddnb4iHIuSNmao7P1DXNiB+HS+/NGyfeA
         YTbU60WpnTIZCrN9Q2uHcG1gcdGNsp3zb32ExCEqMd+ZDtxcQDKLO/MZWZEZJPUvzD8x
         DaQGytWWd5Gnof0IE5tcUNITxJtIDJcn42Byo9iOSz4aerLxXdULJ8WVQXXmw9zLfc8p
         JOYoL1tfr0oat3+Dk9/hINFdEup6yRzfFqbMjrQAwFiq4nDXOomyDNc21BIJdVLVGW4Z
         6ilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744349905; x=1744954705;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eMaXaCye5JvtI4iyq2OlhLRAarHJFPgt7ym62C9j544=;
        b=mHfH7WViczqGIGqtUt6Zq5MvsekMKKP0LlEqDL/dlqGohhrfJRo0U3a+1JMO90qub2
         vo+/3OOlPVv73f+Us2su61ds4T8wa05hM3dv6VhTkEGFLkf12LquYQjNb9y6lLaN+QOf
         pzIuUJxVWu21JWLBniNCBIOUI9Rl7FLkce0C4CIK1nOgDJ31TjAxpLRxFx2Roy9G/utp
         oI0em0/RFrHCOndHjLShaSn2GvfacPwsvu49pHUYbXpx8XyhYZ+kR0j3tSWqPCYIebPA
         G7nHiBsiBSAXCOTEYVrcTBk5/ozB8rT/C/m8CP77SypJQAu/pUVAV8z0uI6saSdudBe1
         N8hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQkqELEPP42mnHh1gesRaiN/i41JFFSsNBZXyrLMPWeXTWB3PMHrJOWYl7xGPHMFV2Y13ESQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx13mfFG/HqaPYoCqpy0lNS9hqWqRFvrtvX37dxPgH+D0XsRUGY
	EIAlC94Ha7dYP1BZFYIqfyaf7c2cmOBLu0qH8OtFSOu5pxh4ZBqvZkBsVNjmMVKovtmD3w75zvy
	rYIQgL3EpiHvpXcNQrw==
X-Google-Smtp-Source: AGHT+IGwSu9aNWfQIOBnQbdZr+ygz4y4oMysfSRpcImKsShqnahENQw9VGbWNqaJvvzzPUBBp+sxjKZowmWc7RK0
X-Received: from plpn16.prod.google.com ([2002:a17:902:9690:b0:220:c59b:c80d])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:41c2:b0:224:3db:a296 with SMTP id d9443c01a7336-22bea49e9e4mr18763355ad.2.1744349905261;
 Thu, 10 Apr 2025 22:38:25 -0700 (PDT)
Date: Thu, 10 Apr 2025 22:37:35 -0700
In-Reply-To: <20250411053745.1817356-1-changyuanl@google.com>
Mime-Version: 1.0
References: <20250411053745.1817356-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250411053745.1817356-5-changyuanl@google.com>
Subject: [PATCH v6 04/14] kexec: add Kexec HandOver (KHO) generation helpers
From: Changyuan Lyu <changyuanl@google.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, anthony.yznaga@oracle.com, arnd@arndb.de, 
	ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de, 
	catalin.marinas@arm.com, corbet@lwn.net, dave.hansen@linux.intel.com, 
	devicetree@vger.kernel.org, dwmw2@infradead.org, ebiederm@xmission.com, 
	graf@amazon.com, hpa@zytor.com, jgowans@amazon.com, kexec@lists.infradead.org, 
	krzk@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org, 
	mark.rutland@arm.com, mingo@redhat.com, pasha.tatashin@soleen.com, 
	pbonzini@redhat.com, peterz@infradead.org, ptyadav@amazon.de, robh@kernel.org, 
	rostedt@goodmis.org, rppt@kernel.org, saravanak@google.com, 
	skinsburskii@linux.microsoft.com, tglx@linutronix.de, thomas.lendacky@amd.com, 
	will@kernel.org, x86@kernel.org, Changyuan Lyu <changyuanl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_223826_741663_1D5DB12E 
X-CRM114-Status: GOOD (  32.74  )
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

From: Alexander Graf <graf@amazon.com>

Add the infrastructure to generate Kexec HandOver metadata. Kexec
HandOver is a mechanism that allows Linux to preserve state - arbitrary
properties as well as memory locations - across kexec.

It does so using 2 concepts:

  1) KHO FDT - Every KHO kexec carries a KHO specific flattened device tree
     blob that describes preserved memory regions. Device drivers can
     register to KHO to serialize and preserve their states before kexec.

  2) Scratch Regions - CMA regions that we allocate in the first kernel.
     CMA gives us the guarantee that no handover pages land in those
     regions, because handover pages must be at a static physical memory
     location. We use these regions as the place to load future kexec
     images so that they won't collide with any handover data.

Signed-off-by: Alexander Graf <graf@amazon.com>
Co-developed-by: Pratyush Yadav <ptyadav@amazon.de>
Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Co-developed-by: Changyuan Lyu <changyuanl@google.com>
Signed-off-by: Changyuan Lyu <changyuanl@google.com>
---
 MAINTAINERS                    |   9 +
 include/linux/kexec_handover.h |  58 ++++
 kernel/Makefile                |   1 +
 kernel/kexec_handover.c        | 557 +++++++++++++++++++++++++++++++++
 mm/mm_init.c                   |   8 +
 5 files changed, 633 insertions(+)
 create mode 100644 include/linux/kexec_handover.h
 create mode 100644 kernel/kexec_handover.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 96b8270495018..5f33e18385cbc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13117,6 +13117,15 @@ F:	include/linux/kexec.h
 F:	include/uapi/linux/kexec.h
 F:	kernel/kexec*
 
+KEXEC HANDOVER (KHO)
+M:	Alexander Graf <graf@amazon.com>
+M:	Mike Rapoport <rppt@kernel.org>
+M:	Changyuan Lyu <changyuanl@google.com>
+L:	kexec@lists.infradead.org
+S:	Maintained
+F:	include/linux/kexec_handover.h
+F:	kernel/kexec_handover.c
+
 KEYS-ENCRYPTED
 M:	Mimi Zohar <zohar@linux.ibm.com>
 L:	linux-integrity@vger.kernel.org
diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
new file mode 100644
index 0000000000000..593ea842a5b61
--- /dev/null
+++ b/include/linux/kexec_handover.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef LINUX_KEXEC_HANDOVER_H
+#define LINUX_KEXEC_HANDOVER_H
+
+#include <linux/types.h>
+
+struct kho_scratch {
+	phys_addr_t addr;
+	phys_addr_t size;
+};
+
+/* KHO Notifier index */
+enum kho_event {
+	KEXEC_KHO_FINALIZE = 0,
+	KEXEC_KHO_ABORT = 1,
+};
+
+struct notifier_block;
+
+struct kho_serialization;
+
+#ifdef CONFIG_KEXEC_HANDOVER
+bool kho_is_enabled(void);
+
+int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt);
+
+int register_kho_notifier(struct notifier_block *nb);
+int unregister_kho_notifier(struct notifier_block *nb);
+
+void kho_memory_init(void);
+#else
+static inline bool kho_is_enabled(void)
+{
+	return false;
+}
+
+static inline int kho_add_subtree(struct kho_serialization *ser,
+				  const char *name, void *fdt)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int register_kho_notifier(struct notifier_block *nb)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int unregister_kho_notifier(struct notifier_block *nb)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void kho_memory_init(void)
+{
+}
+#endif /* CONFIG_KEXEC_HANDOVER */
+
+#endif /* LINUX_KEXEC_HANDOVER_H */
diff --git a/kernel/Makefile b/kernel/Makefile
index 434929de17ef2..97c09847db42f 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -80,6 +80,7 @@ obj-$(CONFIG_CRASH_DUMP) += crash_core.o
 obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_KEXEC_FILE) += kexec_file.o
 obj-$(CONFIG_KEXEC_ELF) += kexec_elf.o
+obj-$(CONFIG_KEXEC_HANDOVER) += kexec_handover.o
 obj-$(CONFIG_BACKTRACE_SELF_TEST) += backtracetest.o
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_CGROUPS) += cgroup/
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
new file mode 100644
index 0000000000000..e541d3d5003d1
--- /dev/null
+++ b/kernel/kexec_handover.c
@@ -0,0 +1,557 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * kexec_handover.c - kexec handover metadata processing
+ * Copyright (C) 2023 Alexander Graf <graf@amazon.com>
+ * Copyright (C) 2025 Microsoft Corporation, Mike Rapoport <rppt@kernel.org>
+ * Copyright (C) 2025 Google LLC, Changyuan Lyu <changyuanl@google.com>
+ */
+
+#define pr_fmt(fmt) "KHO: " fmt
+
+#include <linux/cma.h>
+#include <linux/debugfs.h>
+#include <linux/kexec.h>
+#include <linux/kexec_handover.h>
+#include <linux/libfdt.h>
+#include <linux/list.h>
+#include <linux/memblock.h>
+#include <linux/notifier.h>
+#include <linux/page-isolation.h>
+/*
+ * KHO is tightly coupled with mm init and needs access to some of mm
+ * internal APIs.
+ */
+#include "../mm/internal.h"
+
+#define KHO_FDT_COMPATIBLE "kho-v1"
+#define PROP_PRESERVED_MEMORY_MAP "preserved-memory-map"
+#define PROP_SUB_FDT "fdt"
+
+static bool kho_enable __ro_after_init;
+
+bool kho_is_enabled(void)
+{
+	return kho_enable;
+}
+EXPORT_SYMBOL_GPL(kho_is_enabled);
+
+static int __init kho_parse_enable(char *p)
+{
+	return kstrtobool(p, &kho_enable);
+}
+early_param("kho", kho_parse_enable);
+
+struct kho_serialization {
+	struct page *fdt;
+	struct list_head fdt_list;
+	struct dentry *sub_fdt_dir;
+};
+
+/*
+ * With KHO enabled, memory can become fragmented because KHO regions may
+ * be anywhere in physical address space. The scratch regions give us a
+ * safe zones that we will never see KHO allocations from. This is where we
+ * can later safely load our new kexec images into and then use the scratch
+ * area for early allocations that happen before page allocator is
+ * initialized.
+ */
+static struct kho_scratch *kho_scratch;
+static unsigned int kho_scratch_cnt;
+
+/*
+ * The scratch areas are scaled by default as percent of memory allocated from
+ * memblock. A user can override the scale with command line parameter:
+ *
+ * kho_scratch=N%
+ *
+ * It is also possible to explicitly define size for a lowmem, a global and
+ * per-node scratch areas:
+ *
+ * kho_scratch=l[KMG],n[KMG],m[KMG]
+ *
+ * The explicit size definition takes precedence over scale definition.
+ */
+static unsigned int scratch_scale __initdata = 200;
+static phys_addr_t scratch_size_global __initdata;
+static phys_addr_t scratch_size_pernode __initdata;
+static phys_addr_t scratch_size_lowmem __initdata;
+
+static int __init kho_parse_scratch_size(char *p)
+{
+	size_t len;
+	unsigned long sizes[3];
+	int i;
+
+	if (!p)
+		return -EINVAL;
+
+	len = strlen(p);
+	if (!len)
+		return -EINVAL;
+
+	/* parse nn% */
+	if (p[len - 1] == '%') {
+		/* unsigned int max is 4,294,967,295, 10 chars */
+		char s_scale[11] = {};
+		int ret = 0;
+
+		if (len > ARRAY_SIZE(s_scale))
+			return -EINVAL;
+
+		memcpy(s_scale, p, len - 1);
+		ret = kstrtouint(s_scale, 10, &scratch_scale);
+		if (!ret)
+			pr_notice("scratch scale is %d%%\n", scratch_scale);
+		return ret;
+	}
+
+	/* parse ll[KMG],mm[KMG],nn[KMG] */
+	for (i = 0; i < ARRAY_SIZE(sizes); i++) {
+		char *endp = p;
+
+		if (i > 0) {
+			if (*p != ',')
+				return -EINVAL;
+			p += 1;
+		}
+
+		sizes[i] = memparse(p, &endp);
+		if (!sizes[i] || endp == p)
+			return -EINVAL;
+		p = endp;
+	}
+
+	scratch_size_lowmem = sizes[0];
+	scratch_size_global = sizes[1];
+	scratch_size_pernode = sizes[2];
+	scratch_scale = 0;
+
+	pr_notice("scratch areas: lowmem: %lluMiB global: %lluMiB pernode: %lldMiB\n",
+		  (u64)(scratch_size_lowmem >> 20),
+		  (u64)(scratch_size_global >> 20),
+		  (u64)(scratch_size_pernode >> 20));
+
+	return 0;
+}
+early_param("kho_scratch", kho_parse_scratch_size);
+
+static void __init scratch_size_update(void)
+{
+	phys_addr_t size;
+
+	if (!scratch_scale)
+		return;
+
+	size = memblock_reserved_kern_size(ARCH_LOW_ADDRESS_LIMIT,
+					   NUMA_NO_NODE);
+	size = size * scratch_scale / 100;
+	scratch_size_lowmem = round_up(size, CMA_MIN_ALIGNMENT_BYTES);
+
+	size = memblock_reserved_kern_size(MEMBLOCK_ALLOC_ANYWHERE,
+					   NUMA_NO_NODE);
+	size = size * scratch_scale / 100 - scratch_size_lowmem;
+	scratch_size_global = round_up(size, CMA_MIN_ALIGNMENT_BYTES);
+}
+
+static phys_addr_t __init scratch_size_node(int nid)
+{
+	phys_addr_t size;
+
+	if (scratch_scale) {
+		size = memblock_reserved_kern_size(MEMBLOCK_ALLOC_ANYWHERE,
+						   nid);
+		size = size * scratch_scale / 100;
+	} else {
+		size = scratch_size_pernode;
+	}
+
+	return round_up(size, CMA_MIN_ALIGNMENT_BYTES);
+}
+
+/**
+ * kho_reserve_scratch - Reserve a contiguous chunk of memory for kexec
+ *
+ * With KHO we can preserve arbitrary pages in the system. To ensure we still
+ * have a large contiguous region of memory when we search the physical address
+ * space for target memory, let's make sure we always have a large CMA region
+ * active. This CMA region will only be used for movable pages which are not a
+ * problem for us during KHO because we can just move them somewhere else.
+ */
+static void __init kho_reserve_scratch(void)
+{
+	phys_addr_t addr, size;
+	int nid, i = 0;
+
+	if (!kho_enable)
+		return;
+
+	scratch_size_update();
+
+	/* FIXME: deal with node hot-plug/remove */
+	kho_scratch_cnt = num_online_nodes() + 2;
+	size = kho_scratch_cnt * sizeof(*kho_scratch);
+	kho_scratch = memblock_alloc(size, PAGE_SIZE);
+	if (!kho_scratch)
+		goto err_disable_kho;
+
+	/*
+	 * reserve scratch area in low memory for lowmem allocations in the
+	 * next kernel
+	 */
+	size = scratch_size_lowmem;
+	addr = memblock_phys_alloc_range(size, CMA_MIN_ALIGNMENT_BYTES, 0,
+					 ARCH_LOW_ADDRESS_LIMIT);
+	if (!addr)
+		goto err_free_scratch_desc;
+
+	kho_scratch[i].addr = addr;
+	kho_scratch[i].size = size;
+	i++;
+
+	/* reserve large contiguous area for allocations without nid */
+	size = scratch_size_global;
+	addr = memblock_phys_alloc(size, CMA_MIN_ALIGNMENT_BYTES);
+	if (!addr)
+		goto err_free_scratch_areas;
+
+	kho_scratch[i].addr = addr;
+	kho_scratch[i].size = size;
+	i++;
+
+	for_each_online_node(nid) {
+		size = scratch_size_node(nid);
+		addr = memblock_alloc_range_nid(size, CMA_MIN_ALIGNMENT_BYTES,
+						0, MEMBLOCK_ALLOC_ACCESSIBLE,
+						nid, true);
+		if (!addr)
+			goto err_free_scratch_areas;
+
+		kho_scratch[i].addr = addr;
+		kho_scratch[i].size = size;
+		i++;
+	}
+
+	return;
+
+err_free_scratch_areas:
+	for (i--; i >= 0; i--)
+		memblock_phys_free(kho_scratch[i].addr, kho_scratch[i].size);
+err_free_scratch_desc:
+	memblock_free(kho_scratch, kho_scratch_cnt * sizeof(*kho_scratch));
+err_disable_kho:
+	kho_enable = false;
+}
+
+struct fdt_debugfs {
+	struct list_head list;
+	struct debugfs_blob_wrapper wrapper;
+	struct dentry *file;
+};
+
+static int kho_debugfs_fdt_add(struct list_head *list, struct dentry *dir,
+			       const char *name, const void *fdt)
+{
+	struct fdt_debugfs *f;
+	struct dentry *file;
+
+	f = kmalloc(sizeof(*f), GFP_KERNEL);
+	if (!f)
+		return -ENOMEM;
+
+	f->wrapper.data = (void *)fdt;
+	f->wrapper.size = fdt_totalsize(fdt);
+
+	file = debugfs_create_blob(name, 0400, dir, &f->wrapper);
+	if (IS_ERR(file)) {
+		kfree(f);
+		return PTR_ERR(file);
+	}
+
+	f->file = file;
+	list_add(&f->list, list);
+
+	return 0;
+}
+
+/**
+ * kho_add_subtree - record the physical address of a sub FDT in KHO root tree.
+ * @ser: serialization control object passed by KHO notifiers.
+ * @name: name of the sub tree.
+ * @fdt: the sub tree blob.
+ *
+ * Creates a new child node named @name in KHO root FDT and records
+ * the physical address of @fdt. The pages of @fdt must also be preserved
+ * by KHO for the new kernel to retrieve it after kexec.
+ *
+ * A debugfs blob entry is also created at
+ * ``/sys/kernel/debug/kho/out/sub_fdts/@name``.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt)
+{
+	int err = 0;
+	u64 phys = (u64)virt_to_phys(fdt);
+	void *root = page_to_virt(ser->fdt);
+
+	err |= fdt_begin_node(root, name);
+	err |= fdt_property(root, PROP_SUB_FDT, &phys, sizeof(phys));
+	err |= fdt_end_node(root);
+
+	if (err)
+		return err;
+
+	return kho_debugfs_fdt_add(&ser->fdt_list, ser->sub_fdt_dir, name, fdt);
+}
+EXPORT_SYMBOL_GPL(kho_add_subtree);
+
+struct kho_out {
+	struct blocking_notifier_head chain_head;
+
+	struct dentry *dir;
+
+	struct mutex lock; /* protects KHO FDT finalization */
+
+	struct kho_serialization ser;
+	bool finalized;
+};
+
+static struct kho_out kho_out = {
+	.chain_head = BLOCKING_NOTIFIER_INIT(kho_out.chain_head),
+	.lock = __MUTEX_INITIALIZER(kho_out.lock),
+	.ser = {
+		.fdt_list = LIST_HEAD_INIT(kho_out.ser.fdt_list),
+	},
+	.finalized = false,
+};
+
+int register_kho_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&kho_out.chain_head, nb);
+}
+EXPORT_SYMBOL_GPL(register_kho_notifier);
+
+int unregister_kho_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&kho_out.chain_head, nb);
+}
+EXPORT_SYMBOL_GPL(unregister_kho_notifier);
+
+/* Handling for debug/kho/out */
+
+static struct dentry *debugfs_root;
+
+static int kho_out_update_debugfs_fdt(void)
+{
+	int err = 0;
+	struct fdt_debugfs *ff, *tmp;
+
+	if (kho_out.finalized) {
+		err = kho_debugfs_fdt_add(&kho_out.ser.fdt_list, kho_out.dir,
+					  "fdt", page_to_virt(kho_out.ser.fdt));
+	} else {
+		list_for_each_entry_safe(ff, tmp, &kho_out.ser.fdt_list, list) {
+			debugfs_remove(ff->file);
+			list_del(&ff->list);
+			kfree(ff);
+		}
+	}
+
+	return err;
+}
+
+static int kho_abort(void)
+{
+	int err;
+
+	err = blocking_notifier_call_chain(&kho_out.chain_head, KEXEC_KHO_ABORT,
+					   NULL);
+	err = notifier_to_errno(err);
+
+	if (err)
+		pr_err("Failed to abort KHO finalization: %d\n", err);
+
+	return err;
+}
+
+static int kho_finalize(void)
+{
+	int err = 0;
+	void *fdt = page_to_virt(kho_out.ser.fdt);
+
+	err |= fdt_create(fdt, PAGE_SIZE);
+	err |= fdt_finish_reservemap(fdt);
+	err |= fdt_begin_node(fdt, "");
+	err |= fdt_property_string(fdt, "compatible", KHO_FDT_COMPATIBLE);
+	if (err)
+		goto abort;
+
+	err = blocking_notifier_call_chain(&kho_out.chain_head,
+					   KEXEC_KHO_FINALIZE, &kho_out.ser);
+	err = notifier_to_errno(err);
+	if (err)
+		goto abort;
+
+	err |= fdt_end_node(fdt);
+	err |= fdt_finish(fdt);
+
+abort:
+	if (err) {
+		pr_err("Failed to convert KHO state tree: %d\n", err);
+		kho_abort();
+	}
+
+	return err;
+}
+
+static int kho_out_finalize_get(void *data, u64 *val)
+{
+	mutex_lock(&kho_out.lock);
+	*val = kho_out.finalized;
+	mutex_unlock(&kho_out.lock);
+
+	return 0;
+}
+
+static int kho_out_finalize_set(void *data, u64 _val)
+{
+	int ret = 0;
+	bool val = !!_val;
+
+	mutex_lock(&kho_out.lock);
+
+	if (val == kho_out.finalized) {
+		if (kho_out.finalized)
+			ret = -EEXIST;
+		else
+			ret = -ENOENT;
+		goto unlock;
+	}
+
+	if (val)
+		ret = kho_finalize();
+	else
+		ret = kho_abort();
+
+	if (ret)
+		goto unlock;
+
+	kho_out.finalized = val;
+	ret = kho_out_update_debugfs_fdt();
+
+unlock:
+	mutex_unlock(&kho_out.lock);
+	return ret;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_kho_out_finalize, kho_out_finalize_get,
+			 kho_out_finalize_set, "%llu\n");
+
+static int scratch_phys_show(struct seq_file *m, void *v)
+{
+	for (int i = 0; i < kho_scratch_cnt; i++)
+		seq_printf(m, "0x%llx\n", kho_scratch[i].addr);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(scratch_phys);
+
+static int scratch_len_show(struct seq_file *m, void *v)
+{
+	for (int i = 0; i < kho_scratch_cnt; i++)
+		seq_printf(m, "0x%llx\n", kho_scratch[i].size);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(scratch_len);
+
+static __init int kho_out_debugfs_init(void)
+{
+	struct dentry *dir, *f, *sub_fdt_dir;
+
+	dir = debugfs_create_dir("out", debugfs_root);
+	if (IS_ERR(dir))
+		return -ENOMEM;
+
+	sub_fdt_dir = debugfs_create_dir("sub_fdts", dir);
+	if (IS_ERR(sub_fdt_dir))
+		goto err_rmdir;
+
+	f = debugfs_create_file("scratch_phys", 0400, dir, NULL,
+				&scratch_phys_fops);
+	if (IS_ERR(f))
+		goto err_rmdir;
+
+	f = debugfs_create_file("scratch_len", 0400, dir, NULL,
+				&scratch_len_fops);
+	if (IS_ERR(f))
+		goto err_rmdir;
+
+	f = debugfs_create_file("finalize", 0600, dir, NULL,
+				&fops_kho_out_finalize);
+	if (IS_ERR(f))
+		goto err_rmdir;
+
+	kho_out.dir = dir;
+	kho_out.ser.sub_fdt_dir = sub_fdt_dir;
+	return 0;
+
+err_rmdir:
+	debugfs_remove_recursive(dir);
+	return -ENOENT;
+}
+
+static __init int kho_init(void)
+{
+	int err = 0;
+
+	if (!kho_enable)
+		return 0;
+
+	kho_out.ser.fdt = alloc_page(GFP_KERNEL);
+	if (!kho_out.ser.fdt) {
+		err = -ENOMEM;
+		goto err_free_scratch;
+	}
+
+	debugfs_root = debugfs_create_dir("kho", NULL);
+	if (IS_ERR(debugfs_root)) {
+		err = -ENOENT;
+		goto err_free_fdt;
+	}
+
+	err = kho_out_debugfs_init();
+	if (err)
+		goto err_free_fdt;
+
+	for (int i = 0; i < kho_scratch_cnt; i++) {
+		unsigned long base_pfn = PHYS_PFN(kho_scratch[i].addr);
+		unsigned long count = kho_scratch[i].size >> PAGE_SHIFT;
+		unsigned long pfn;
+
+		for (pfn = base_pfn; pfn < base_pfn + count;
+		     pfn += pageblock_nr_pages)
+			init_cma_reserved_pageblock(pfn_to_page(pfn));
+	}
+
+	return 0;
+
+err_free_fdt:
+	put_page(kho_out.ser.fdt);
+	kho_out.ser.fdt = NULL;
+err_free_scratch:
+	for (int i = 0; i < kho_scratch_cnt; i++) {
+		void *start = __va(kho_scratch[i].addr);
+		void *end = start + kho_scratch[i].size;
+
+		free_reserved_area(start, end, -1, "");
+	}
+	kho_enable = false;
+	return err;
+}
+late_initcall(kho_init);
+
+void __init kho_memory_init(void)
+{
+	kho_reserve_scratch();
+}
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 1451cb250fd3f..9ed4a0dda6e39 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -30,6 +30,7 @@
 #include <linux/crash_dump.h>
 #include <linux/execmem.h>
 #include <linux/vmstat.h>
+#include <linux/kexec_handover.h>
 #include <linux/hugetlb.h>
 #include "internal.h"
 #include "slab.h"
@@ -2770,6 +2771,13 @@ void __init mm_core_init(void)
 	report_meminit();
 	kmsan_init_shadow();
 	stack_depot_early_init();
+
+	/*
+	 * KHO memory setup must happen while memblock is still active, but
+	 * as close as possible to buddy initialization
+	 */
+	kho_memory_init();
+
 	memblock_free_all();
 	mem_init();
 	kmem_cache_init();
-- 
2.49.0.604.gff1f9ca942-goog


