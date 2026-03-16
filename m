Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19725F46455
	for <kexec@archiver.kernel.org>; Mon, 16 Mar 2026 11:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GilGYiXFEL76/A5yC5soz5ziXjKLkl4hsXD/ZnoWJGs=; b=fCMdZUOpzZYTVTsFCNuR9L1APS
	StQI2O7TZCfxJ9iPAKVlOG+Xsv2mCHhrlXhs9cNPNa0ucHuy3kkmo8LOM2KTyDrKd5qintOOWBTV/
	ECfb5fAmWJ6yLAc9wB8sCqepnguzdQK+5PW2tAYrSMZIGW0eJHb5nldmIck58fGOkUSHnLtdSnzb2
	nKuCVrdjBOfeV2RHtj6ckj03A2Str9m5TvQQe+wxyS8pFh4wpcNnkvfs7aKA9KbLr1qIRuH8jnqGD
	3O3Azgp3xyfVyvypX8bsKuX8h3cgxaQjyYXIWDRC/g28r9DvpyySoeETrXm4xZlmJXwZfXhkSeB6e
	dEQeHNxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w26Ym-00000003s59-2BiU;
	Mon, 16 Mar 2026 11:56:36 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w26Yj-00000003s2p-2sb1
	for kexec@lists.infradead.org;
	Mon, 16 Mar 2026 11:56:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=GilGYiXFEL76/A5yC5soz5ziXjKLkl4hsXD/ZnoWJGs=; b=TTPcz3cRNvzA+rHOyuiYGIboVE
	WtSIPkoTsqzN6WS/sracHHi0KUAo47COASqazwz3B5H+gHhRxLBukk6Csu0giu0QDyPC+ZPlbTOe7
	L4KKHoscTl8Q31H+kZLFOlBQItp5J+jHkw5PLIqv83VPEe9otyTGFxbRagm9m61q2ZTV32W84jx+T
	vJ4vXuoHSC1axHqM5bSL7q094qh9djTdXeVNf9rdx//qglGoVfGWivHqw9A4H6e+jx8yZH+7mLqN8
	4FSQjg2LJaVyRefX6DHMx/zotUuqUYnFoLM8hiNduz8unQzR+hMP8U5bT4QxVFwoVWf/0k5cDiMhw
	XDEuG9og==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w26Yd-0025zn-On; Mon, 16 Mar 2026 11:56:26 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 16 Mar 2026 04:54:35 -0700
Subject: [PATCH v9 5/6] kho: kexec-metadata: track previous kernel chain
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-kho-v9-5-ed6dcd951988@debian.org>
References: <20260316-kho-v9-0-ed6dcd951988@debian.org>
In-Reply-To: <20260316-kho-v9-0-ed6dcd951988@debian.org>
To: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-mm@kvack.org, usama.arif@linux.dev, Breno Leitao <leitao@debian.org>, 
 SeongJae Park <sj@kernel.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-363b9
X-Developer-Signature: v=1; a=openpgp-sha256; l=7860; i=leitao@debian.org;
 h=from:subject:message-id; bh=tZwmah9BwtjUspXeFH3zT9+1gw6bedkgV6HPu8Vqbko=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpt+/QA8hvw9tAeJC0GPMFyUiMS98yYS/pGL7EV
 S8guHU/ruuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCabfv0AAKCRA1o5Of/Hh3
 bblEEACq5FaVAJomTjfoBm/Hwr0UxRWUirk6zQ0J2Lp4mJXqqO4z9S5EmGMfCTPbO8r+qyvd4vo
 U2VmjtWUhU0bmjz2y5XOl5q24OjHkjAXs/xRR/t4YjxvY/DdWYnPyO4PQ/hbg6OBm7CWdwv/YKI
 AfZaVkVk3EBOz+B5EHDzj/e8TUSSG9b7nT1lTzsptPpQWeojhP/x7LPw8lZiG43HnKdMv+fhQRh
 kwLAGAGg1uFTfGTjWrik1D8RLy9SF17itY+dP1Xe8MtZZcBu9NI6qQNUv1+u1vkoPS14586DW6w
 R210D+m83BFI8F6wpesvoD6NyupCKECdyz/WTwtjQBOvWv6GkDFihCULgTE9IiyKmHpy+3CnUXI
 HVd0+2TRnt6vodWr2P3jDBYCUGcQP3vQ27HOubL0yBZh5ai0V/Wzk3Rw/gQHwgOvpUWgXARxUNf
 N8DECkzSG0dJDC5pO3z9ZCVl/i4QSKGZISkN6WCDVTFL69vhIO0APFzKNLOlbcbYc6jqoVwowOB
 v+xVIb8VRMcUCtTdELd9dE1iorZIQu1VAhq7jKS/CSY4jPP81AoNeQzsTAba1PbIlQKHG5EDhPS
 7ooG3lzYYPnGkb+xWl3VKoWgxTNTY3/8FQ76eaY6tAzB5XLnKVhqMICCMszyP0PgZCvYfxNJuDS
 y1lvLFqxGOeuu2w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260316_045633_952880_1582CB2F 
X-CRM114-Status: GOOD (  27.37  )
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

Use Kexec Handover (KHO) to pass the previous kernel's version string
and the number of kexec reboots since the last cold boot to the next
kernel, and print it at boot time.

Example output:
    [    0.000000] KHO: exec from: 6.19.0-rc4-next-20260107 (count 1)

Motivation
==========

Bugs that only reproduce when kexecing from specific kernel versions
are difficult to diagnose. These issues occur when a buggy kernel
kexecs into a new kernel, with the bug manifesting only in the second
kernel.

Recent examples include the following commits:

 * commit eb2266312507 ("x86/boot: Fix page table access in
   5-level to 4-level paging transition")
 * commit 77d48d39e991 ("efistub/tpm: Use ACPI reclaim memory
   for event log to avoid corruption")
 * commit 64b45dd46e15 ("x86/efi: skip memattr table on kexec
   boot")

As kexec-based reboots become more common, these version-dependent bugs
are appearing more frequently. At scale, correlating crashes to the
previous kernel version is challenging, especially when issues only
occur in specific transition scenarios.

Implementation
==============

The kexec metadata is stored as a plain C struct (struct kho_kexec_metadata)
rather than FDT format, for simplicity and direct field access. It is
registered via kho_add_subtree() as a separate subtree, keeping it
independent from the core KHO ABI. This design choice:

 - Keeps the core KHO ABI minimal and stable
 - Allows the metadata format to evolve independently
 - Avoids requiring version bumps for all KHO consumers (LUO, etc.)
   when the metadata format changes

The struct kho_kexec_metadata contains two fields:
 - previous_release: The kernel version that initiated the kexec
 - kexec_count: Number of kexec boots since last cold boot

On cold boot, kexec_count starts at 0 and increments with each kexec.
The count helps identify issues that only manifest after multiple
consecutive kexec reboots.

Acked-by: SeongJae Park <sj@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/kho/abi/kexec_metadata.h | 46 ++++++++++++++++
 kernel/liveupdate/kexec_handover.c     | 98 ++++++++++++++++++++++++++++++++++
 2 files changed, 144 insertions(+)

diff --git a/include/linux/kho/abi/kexec_metadata.h b/include/linux/kho/abi/kexec_metadata.h
new file mode 100644
index 0000000000000..e9e3f7e38a7c4
--- /dev/null
+++ b/include/linux/kho/abi/kexec_metadata.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/**
+ * DOC: Kexec Metadata ABI
+ *
+ * The "kexec-metadata" subtree stores optional metadata about the kexec chain.
+ * It is registered via kho_add_subtree(), keeping it independent from the core
+ * KHO ABI. This allows the metadata format to evolve without affecting other
+ * KHO consumers.
+ *
+ * The metadata is stored as a plain C struct rather than FDT format for
+ * simplicity and direct field access.
+ *
+ * Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2026 Breno Leitao <leitao@debian.org>
+ */
+
+#ifndef _LINUX_KHO_ABI_KEXEC_METADATA_H
+#define _LINUX_KHO_ABI_KEXEC_METADATA_H
+
+#include <linux/types.h>
+#include <linux/utsname.h>
+
+#define KHO_KEXEC_METADATA_VERSION 1
+
+/**
+ * struct kho_kexec_metadata - Kexec metadata passed between kernels
+ * @version: ABI version of this struct (must be first field)
+ * @previous_release: Kernel version string that initiated the kexec
+ * @kexec_count: Number of kexec boots since last cold boot
+ *
+ * This structure is preserved across kexec and allows the new kernel to
+ * identify which kernel it was booted from and how many kexec reboots
+ * have occurred.
+ *
+ * __NEW_UTS_LEN is part of uABI, so it safe to use it in here.
+ */
+struct kho_kexec_metadata {
+	u32 version;
+	char previous_release[__NEW_UTS_LEN + 1];
+	u32 kexec_count;
+} __packed;
+
+#define KHO_METADATA_NODE_NAME "kexec-metadata"
+
+#endif /* _LINUX_KHO_ABI_KEXEC_METADATA_H */
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index b768fb7b41280..2eb9e47558ccb 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -18,7 +18,9 @@
 #include <linux/kexec.h>
 #include <linux/kexec_handover.h>
 #include <linux/kho_radix_tree.h>
+#include <linux/utsname.h>
 #include <linux/kho/abi/kexec_handover.h>
+#include <linux/kho/abi/kexec_metadata.h>
 #include <linux/libfdt.h>
 #include <linux/list.h>
 #include <linux/memblock.h>
@@ -1285,6 +1287,8 @@ EXPORT_SYMBOL_GPL(kho_restore_free);
 struct kho_in {
 	phys_addr_t fdt_phys;
 	phys_addr_t scratch_phys;
+	char previous_release[__NEW_UTS_LEN + 1];
+	u32 kexec_count;
 	struct kho_debugfs dbg;
 };
 
@@ -1409,6 +1413,96 @@ static __init int kho_out_fdt_setup(void)
 	return err;
 }
 
+static void __init kho_in_kexec_metadata(void)
+{
+	struct kho_kexec_metadata *metadata;
+	phys_addr_t metadata_phys;
+	size_t blob_size;
+	int err;
+
+	err = kho_retrieve_subtree(KHO_METADATA_NODE_NAME, &metadata_phys,
+				   &blob_size);
+	if (err)
+		/* This is fine, previous kernel didn't export metadata */
+		return;
+
+	/* Check that, at least, "version" is present */
+	if (blob_size < sizeof(u32)) {
+		pr_warn("kexec-metadata blob too small (%zu bytes)\n",
+			blob_size);
+		return;
+	}
+
+	metadata = phys_to_virt(metadata_phys);
+
+	if (metadata->version != KHO_KEXEC_METADATA_VERSION) {
+		pr_warn("kexec-metadata version %u not supported (expected %u)\n",
+			metadata->version, KHO_KEXEC_METADATA_VERSION);
+		return;
+	}
+
+	if (blob_size < sizeof(*metadata)) {
+		pr_warn("kexec-metadata blob too small for v%u (%zu < %zu)\n",
+			metadata->version, blob_size, sizeof(*metadata));
+		return;
+	}
+
+	/*
+	 * Copy data to the kernel structure that will persist during
+	 * kernel lifetime.
+	 */
+	kho_in.kexec_count = metadata->kexec_count;
+	strscpy(kho_in.previous_release, metadata->previous_release,
+		sizeof(kho_in.previous_release));
+
+	pr_info("exec from: %s (count %u)\n",
+		kho_in.previous_release, kho_in.kexec_count);
+}
+
+/*
+ * Create kexec metadata to pass kernel version and boot count to the
+ * next kernel. This keeps the core KHO ABI minimal and allows the
+ * metadata format to evolve independently.
+ */
+static __init int kho_out_kexec_metadata(void)
+{
+	struct kho_kexec_metadata *metadata;
+	int err;
+
+	metadata = kho_alloc_preserve(sizeof(*metadata));
+	if (IS_ERR(metadata))
+		return PTR_ERR(metadata);
+
+	metadata->version = KHO_KEXEC_METADATA_VERSION;
+	strscpy(metadata->previous_release, init_uts_ns.name.release,
+		sizeof(metadata->previous_release));
+	/* kho_in.kexec_count is set to 0 on cold boot */
+	metadata->kexec_count = kho_in.kexec_count + 1;
+
+	err = kho_add_subtree(KHO_METADATA_NODE_NAME, metadata,
+			      sizeof(*metadata));
+	if (err)
+		kho_unpreserve_free(metadata);
+
+	return err;
+}
+
+static int __init kho_kexec_metadata_init(const void *fdt)
+{
+	int err;
+
+	if (fdt)
+		kho_in_kexec_metadata();
+
+	/* Populate kexec metadata for the possible next kexec */
+	err = kho_out_kexec_metadata();
+	if (err)
+		pr_warn("failed to initialize kexec-metadata subtree: %d\n",
+			err);
+
+	return err;
+}
+
 static __init int kho_init(void)
 {
 	struct kho_radix_tree *tree = &kho_out.radix_tree;
@@ -1442,6 +1536,10 @@ static __init int kho_init(void)
 	if (err)
 		goto err_free_fdt;
 
+	err = kho_kexec_metadata_init(fdt);
+	if (err)
+		goto err_free_fdt;
+
 	for (int i = 0; i < kho_scratch_cnt; i++) {
 		unsigned long base_pfn = PHYS_PFN(kho_scratch[i].addr);
 		unsigned long count = kho_scratch[i].size >> PAGE_SHIFT;

-- 
2.52.0


