Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B71EC5DF87
	for <kexec@archiver.kernel.org>; Fri, 21 Aug 2026 10:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Da1CWZALucIaRBUeETb+igOf65zQLydAHdg2K0GnubI=; b=nCHrDwDUNnxwSquuraVFpqV6oL
	H5bugnmTPESCMKzigsn1InHhN/i/A/miGXLbnXIUx+BlpJhFNRwGjadCshQd1kSGLhpI7sXIipCav
	cZJPxh/3EUuHykhxFs2Bt0/QtAlRbljAF2YVi8uxPMWExJ6WbOSimJPydqzkyJqYsdePt5LO1L/RR
	Xk8HhSs5/au26WZxJELf+uxoqmCJTpC2SUaRGKyO3JmFLphgdM+PkYtuSZfe6FOl77cN2Px71CEHQ
	xKhC2+4cy1FP5H/0Zm9Wv4+aJf+lHUjPY3BIvkaECWO/+NJTilWKZq0ggVX4mESubJDK4mclenfJJ
	YZvbaZ6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxM9G-0000000D1Xy-2AOi;
	Fri, 21 Aug 2026 10:06:54 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxM99-0000000D1T5-2eb1
	for kexec@lists.infradead.org;
	Fri, 21 Aug 2026 10:06:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=Da1CWZALucIaRBUeETb+igOf65zQLydAHdg2K0GnubI=; b=mKXagGDKJLVneYlwEdigYndfQw
	1mEFjLB9WKlOEcBzknkiea42hyXZun3ERd29AthAl/3Aw4rbOHdv28xtug/V4e7y9pVZ62dcnCMyZ
	eTTBTIo/nX8l++3Fs1yagZAdSjAesjdbpns5gWeYtFxj8blWazG5AKmvPFpK2PUwIEzLycWHf+Ewj
	/N1+8W8GicZYDbFapUYUiiBWA3c2KQOodGCesHjgrN7cIX+IYOk0PLbkKPtrQsiZ/fyH4uZf2OEm6
	d9BuIchhIxKcUx5t2ytHBA0uj/94nBcGy9d4iLWyyhVbmapQte1KQxEBFfrvQ2n9dTsLXQwjWLFjW
	oCTPSoTA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wxM97-00BGBw-2h;
	Fri, 21 Aug 2026 10:06:46 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 21 Aug 2026 03:06:05 -0700
Subject: [PATCH v2 5/6] efi: record hardware-poisoned frames into the
 poisoned-memory table
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-hwpoison-kho-v2-5-5743791e48e6@debian.org>
References: <20260821-hwpoison-kho-v2-0-5743791e48e6@debian.org>
In-Reply-To: <20260821-hwpoison-kho-v2-0-5743791e48e6@debian.org>
To: Ard Biesheuvel <ardb@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, rmikey@meta.com, kas@kernel.org, riel@surriel.com, 
 kexec@lists.infradead.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=6912; i=leitao@debian.org;
 h=from:subject:message-id; bh=lWWIEjhuVgXrSedCC6Ci+SxjCAerQM0bIwFhF7iWBwk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqiCMagImGhYCNupSzFcmMTFpU0hwmHaEe+j5ab
 QCBtZQBztyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaogjGgAKCRA1o5Of/Hh3
 bdlKD/0R0D67QRzyfCB/qpVSpAVO6PMBhhDYOyWsLrycnJcm98PDAO68wuR9JXf/04LbHxJaKUx
 GXWLPITI60/ULF6LdZCzpYaUf4rpnK6vraM9t4M0bpqUkF14+lc6HxjcKo59OgtacBxcVlJhFXx
 g7OO5swDEgwkcgVHq0Ig810rGo2ZscSgtX8Di52kdRnbFd5gLMJBev8bL6uPQuel5VXwUNaeuVN
 Ca9jj3mhO9czJAvTmb0ITOQS/V3/cKoewetvWvoi223H8bx7nOy1QOsvRTecq5ifuAzhmmGuDrv
 lNucuKLFJAy61TNdGHxmGbqbusYwNMgVvOihC9Br0VnUWQeMDi6UwESzDcXnFT+qiF4sFD5ooHc
 aexaH2V+h4tTbJ2s2+w+fwoKhE1yExSRdAwLrUqG95xC9LecO8mf5AQlsPV3R1dyh0r9G/rNlHm
 5LJtAIfiaa2rDS37nOyK5UOuHz3AUX75oe2ylckY5P46YEtj79/nmN7PYQWucNr7Z6DCZZQTbWV
 tVkU7ofwJ4heMBCDgEYr+zg8L0ZoOtfe8xs8x84xIZGI8deQ+m10aAVL02DqP0fey9RRrWspZOr
 t0YygL2bI7CT21rF+ZamVC3w/vG4kLHuMzFNqEWdMCL2Hqci0SO2d2NchiqC8v2FirssI0O6ITu
 6xsFQY2jdQSCUkA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260821_030647_850538_015E5A0B 
X-CRM114-Status: GOOD (  25.41  )
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

action_result() is where memory_failure() reports the outcome of a hard
offline, so hook it to set the frame's bit in the
LINUX_EFI_POISONED_MEMORY bitmap.

Soft-offlined pages reach num_poisoned_pages_inc() through
page_handle_poison() and are deliberately left out: they are still
functional and were offlined predictively, so recording them would turn
a prediction into a permanent loss for every kernel further down the
kexec chain.

A bit is only ever set, never cleared, given that multiple pages can set
the same bit, and it is not trivial to decide if the bit should be unset
when a page is unrecorded.

Unpoisoning a frame therefore does not hand its unit back to the next
kernel. That is a known limitation.

memory_failure() has already taken the frame out of this kernel's
allocator, so only the cross-kexec record happens here.

Suggested-by: Kiryl Shutsemau <kas@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/firmware/efi/Makefile |   1 +
 drivers/firmware/efi/poison.c | 130 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/efi.h           |   6 ++
 mm/memory-failure.c           |   3 +
 4 files changed, 140 insertions(+)

diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index 8efbcf699e4ff..05d0a490923e5 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -43,4 +43,5 @@ obj-$(CONFIG_EFI_EARLYCON)		+= earlycon.o
 obj-$(CONFIG_UEFI_CPER_ARM)		+= cper-arm.o
 obj-$(CONFIG_UEFI_CPER_X86)		+= cper-x86.o
 obj-$(CONFIG_UNACCEPTED_MEMORY)		+= unaccepted_memory.o
+obj-$(CONFIG_EFI_POISONED_MEMORY)	+= poison.o
 obj-$(CONFIG_TEE_STMM_EFI)		+= stmm/tee_stmm_efi.o
diff --git a/drivers/firmware/efi/poison.c b/drivers/firmware/efi/poison.c
new file mode 100644
index 0000000000000..2f47293a4e45f
--- /dev/null
+++ b/drivers/firmware/efi/poison.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Runtime handling for the LINUX_EFI_POISONED_MEMORY configuration table: a
+ * bitmap with one bit per EFI_POISON_UNIT_SIZE of physical memory that records
+ * hardware-poisoned frames so the next kexec kernel can keep them out of its
+ * allocator. The stub installs the (empty) bitmap; this kernel sets bits at
+ * runtime.
+ *
+ * Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2026 Breno Leitao <leitao@debian.org>
+ */
+
+#define pr_fmt(fmt) "efi: " fmt
+
+#include <linux/bitmap.h>
+#include <linux/efi.h>
+#include <linux/io.h>
+#include <linux/log2.h>
+#include <linux/mm.h>
+#include <linux/overflow.h>
+
+static struct linux_efi_poisoned_memory *efi_poison __ro_after_init;
+
+/* A non-empty bitmap on a power-of-2 grid that phys_base actually sits on. */
+static bool __init
+efi_poison_geometry_valid(const struct linux_efi_poisoned_memory *pm)
+{
+	if (!pm->size)
+		return false;
+	if (pm->unit_size < PAGE_SIZE || !is_power_of_2(pm->unit_size))
+		return false;
+
+	return IS_ALIGNED(pm->phys_base, pm->unit_size);
+}
+
+/* The range the bitmap claims to describe has to fit in a u64. */
+static bool __init
+efi_poison_range_valid(const struct linux_efi_poisoned_memory *pm)
+{
+	u64 nbits, span;
+
+	if (check_mul_overflow(pm->size, (u64)BITS_PER_BYTE, &nbits))
+		return false;
+	if (check_mul_overflow(nbits, (u64)pm->unit_size, &span))
+		return false;
+
+	return !check_add_overflow(pm->phys_base, span, &span);
+}
+
+/*
+ * The table may have been installed by an earlier kernel in the kexec chain,
+ * so check its geometry before doing any arithmetic with it.
+ */
+static bool __init
+efi_poison_table_valid(const struct linux_efi_poisoned_memory *pm)
+{
+	if (pm->version != 1) {
+		pr_warn("Ignoring poisoned-memory table with version %u\n",
+			pm->version);
+		return false;
+	}
+
+	if (!efi_poison_geometry_valid(pm) || !efi_poison_range_valid(pm)) {
+		pr_warn("Ignoring malformed poisoned-memory table\n");
+		return false;
+	}
+
+	return true;
+}
+
+static int __init efi_poison_init(void)
+{
+	struct linux_efi_poisoned_memory *pm;
+	u64 size;
+
+	if (efi.poisoned_memory == EFI_INVALID_TABLE_ADDR)
+		return 0;
+
+	/* Map the header to learn the bitmap size, then map the whole table. */
+	pm = memremap(efi.poisoned_memory, sizeof(*pm), MEMREMAP_WB);
+	if (WARN_ON_ONCE(!pm))
+		return 0;
+	if (!efi_poison_table_valid(pm)) {
+		memunmap(pm);
+		return 0;
+	}
+	size = pm->size;
+	memunmap(pm);
+
+	efi_poison = memremap(efi.poisoned_memory, sizeof(*pm) + size,
+			      MEMREMAP_WB);
+	WARN_ON_ONCE(!efi_poison);
+	return 0;
+}
+early_initcall(efi_poison_init);
+
+/* Bitmap unit covering @pfn, or -1 if the pfn falls outside the table. */
+static long efi_poison_unit(unsigned long pfn)
+{
+	phys_addr_t addr = PFN_PHYS(pfn);
+	u64 unit;
+
+	if (addr < efi_poison->phys_base)
+		return -1;
+	unit = (addr - efi_poison->phys_base) / efi_poison->unit_size;
+	if (unit >= (u64)efi_poison->size * BITS_PER_BYTE)
+		return -1;
+	return unit;
+}
+
+/*
+ * Record a hardware-poisoned frame so the next kernel keeps its unit out of the
+ * allocator. memory_failure() has already removed the frame from this kernel.
+ *
+ * A bit is never cleared: one bit stands for a whole EFI_POISON_UNIT_SIZE, so
+ * an unpoison cannot tell whether the unit as a whole is good again.
+ */
+void efi_hwpoison_record_pfn(unsigned long pfn)
+{
+	long unit;
+
+	if (!efi_poison)
+		return;
+
+	unit = efi_poison_unit(pfn);
+	if (unit < 0)
+		return;
+
+	set_bit(unit, efi_poison->bitmap);
+}
diff --git a/include/linux/efi.h b/include/linux/efi.h
index ce0980a5bb81b..f03b1bb576133 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1284,6 +1284,12 @@ struct linux_efi_poisoned_memory {
 
 #define EFI_POISON_UNIT_SIZE	SZ_2M
 
+#ifdef CONFIG_EFI_POISONED_MEMORY
+void efi_hwpoison_record_pfn(unsigned long pfn);
+#else
+static inline void efi_hwpoison_record_pfn(unsigned long pfn) { }
+#endif
+
 void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size);
 
 /*
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index aaf14608b30e2..357a72ffda625 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -43,6 +43,7 @@
 #include <linux/sched/signal.h>
 #include <linux/sched/task.h>
 #include <linux/dax.h>
+#include <linux/efi.h>
 #include <linux/ksm.h>
 #include <linux/rmap.h>
 #include <linux/export.h>
@@ -1286,6 +1287,8 @@ static int action_result(unsigned long pfn, enum mf_action_page_type type,
 	if (type != MF_MSG_ALREADY_POISONED && type != MF_MSG_PFN_MAP) {
 		num_poisoned_pages_inc(pfn);
 		update_per_node_mf_stats(pfn, result);
+		/* Only hard offlines are carried over to the next kernel. */
+		efi_hwpoison_record_pfn(pfn);
 	}
 
 	pr_err("%#lx: recovery action for %s: %s\n",

-- 
2.53.0-Meta


