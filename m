Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7EEF3C263
	for <kexec@archiver.kernel.org>; Mon,  9 Mar 2026 13:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=blrIoTJexK9V0SlE9m9/WXlOitlTxjozBKun7UC+eh8=; b=TmsNTFUh1D0iKmBC84PANvPWKS
	0Wa5kau+vRV4i6+uhWRKxDjrNBRWbqV1phfp/RtfqZ7rtHU/Ncb5esTEuC6/G4rA6MNhLBedsVhFB
	iCttC0L3zxueYp6FH+h5HTyyn3VL14ZhRDjb5Ds9X0RB+CGZCT7TjUFm2MYzG8m2CVyj44adp/Mky
	l8ubP8Ni/o4uDfpjpwejxV+izxQR8xom/H3qH43r+0dhm0VQpGcxMPVM6JNjhoANOzjbyOSOv6pr3
	ZzCILzrZcRln3VHDpoz34wF7RyQ/cNwIyDq2vJwYkA7eis2ovzb5Ch8uzpB/+msHhqrzSUweSl4O+
	URDI7Zow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzasg-00000007QG3-0zxf;
	Mon, 09 Mar 2026 13:42:46 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzase-00000007QEA-1Pe1
	for kexec@lists.infradead.org;
	Mon, 09 Mar 2026 13:42:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=blrIoTJexK9V0SlE9m9/WXlOitlTxjozBKun7UC+eh8=; b=FHCl0ihtv2OIcDfxgAcjQsZ13S
	bVrK4lbShDHCpY4HOHDe31fGqD+MOaqYf3HJ7OmAqhsUpH4+BAQMhGTBQu4+eI6rhKzskHaaVVdPS
	x9mV9YDX+NbL4UuTcA51fXuaTqIPHTospvcWEvNxzNRNBM1eWSGg21jrA0TWAvKdz4dy+fczghxT0
	Z/rC61fvjGn8FclbAMdRIqihWnChq3jI+6NerOwUI6G6D/dOtSEaZ9jDkO/iQNt54EJ/Cu3/+UeRA
	1VK++OJP8t60D5Lj4+uQYvhrrwjH5kuersshZWVI5wEib2AtpWJUL97dHbu+Xh6iqp9Q62PR9bAWz
	Mi3YgEBA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vzasW-002G47-HZ; Mon, 09 Mar 2026 13:42:36 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 09 Mar 2026 06:41:48 -0700
Subject: [PATCH v8 5/6] kho: kexec-metadata: track previous kernel chain
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-kho-v8-5-c3abcf4ac750@debian.org>
References: <20260309-kho-v8-0-c3abcf4ac750@debian.org>
In-Reply-To: <20260309-kho-v8-0-c3abcf4ac750@debian.org>
To: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-mm@kvack.org, usamaarif642@gmail.com, 
 Breno Leitao <leitao@debian.org>, SeongJae Park <sj@kernel.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-363b9
X-Developer-Signature: v=1; a=openpgp-sha256; l=6984; i=leitao@debian.org;
 h=from:subject:message-id; bh=wFUQv960bxV6n7TCJD4FMZFCiB/JTLz1Skv4YLrEGDo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBprs4zTCZed02jaYw/bWAOKaoOVGmOZXpy/X8YT
 cQPE+vNHfOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaa7OMwAKCRA1o5Of/Hh3
 bQbPD/9aJTG4urF72fJIr1nRxjL5YeMpUnN/2wI3qvPGXyebkyYTLLxD4GTqj7rLxkiqYrTtDRl
 t276tDdGD2Vl0S9X62sPgZagsEa2nMAyTmq03uZE/TXjM5dyVvKGIyZW1Y5GFgmLskD+t+uzrqE
 nuZYh78BaRoT2Ni0pnyUyL3vx0mSGW9wC2pdF3rFf7HrTM9AuVXFgHs0toqaQaPvZlda2YLLnfp
 j1ZcC9pBMeQhAl8vZUghV9QdRgfmEjsMJx/ybghubXZOS+I4nB5pqAo22+vu/3YhF1vK8M0d43e
 g1Spk+6JWdxlsPG3fu37hWB6U20KtmJPGikbDDjv5pgxs6kgg2JI6zFGp+QXBVXT6FNSc4YCn1T
 SuCXUhcRCAVXVmWM9tl4gC2JAa1dqe9V/SOK8dvu7gGVlsBd0ltaB7poT3PFPp/NrqFSMCdDG7j
 AXSKMy98e7jxuyi2bkfN/oCMGeN65GP2hYQT3Efa305saMqySSvVHbt6m8bSSIiIYAICaUk8O3H
 7tVoxzfWlaxbQNmfJsoU1GPWNonwpZBWWE7jkWpalUOiccl+Esti2716A5CbTxxwI1zO+GzUYDf
 gtiwrWEm23A8t1rLFapudKYYH/8qnAgCEtzfI5RBC5wd4pvIlte29UdlqY0RYjvVrxCPdY5DFwX
 W5/izPj42rd01kA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260309_064244_550310_F3C555F6 
X-CRM114-Status: GOOD (  24.63  )
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

 * eb2266312507 ("x86/boot: Fix page table access in 5-level to 4-level paging transition")
 * 77d48d39e991 ("efistub/tpm: Use ACPI reclaim memory for event log to avoid corruption")
 * 64b45dd46e15 ("x86/efi: skip memattr table on kexec boot")

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
 include/linux/kho/abi/kexec_handover.h | 31 ++++++++++++++
 kernel/liveupdate/kexec_handover.c     | 75 ++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/abi/kexec_handover.h
index 7e847a2339b09..832390f96f49c 100644
--- a/include/linux/kho/abi/kexec_handover.h
+++ b/include/linux/kho/abi/kexec_handover.h
@@ -14,6 +14,7 @@
 #include <linux/log2.h>
 #include <linux/math.h>
 #include <linux/types.h>
+#include <linux/utsname.h>
 
 #include <asm/page.h>
 
@@ -101,6 +102,36 @@
 /* The FDT property for the size of preserved data blobs. */
 #define KHO_SUB_TREE_SIZE_PROP_NAME "blob-size"
 
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
+ */
+
+/**
+ * struct kho_kexec_metadata - Kexec metadata passed between kernels
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
+	char previous_release[__NEW_UTS_LEN + 1];
+	u32 kexec_count;
+} __packed;
+
+#define KHO_METADATA_NODE_NAME "kexec-metadata"
+
 /**
  * DOC: Kexec Handover ABI for vmalloc Preservation
  *
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 1f22705d5d246..7bac80e9a29a4 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -18,6 +18,7 @@
 #include <linux/kexec.h>
 #include <linux/kexec_handover.h>
 #include <linux/kho_radix_tree.h>
+#include <linux/utsname.h>
 #include <linux/kho/abi/kexec_handover.h>
 #include <linux/libfdt.h>
 #include <linux/list.h>
@@ -1285,6 +1286,8 @@ EXPORT_SYMBOL_GPL(kho_restore_free);
 struct kho_in {
 	phys_addr_t fdt_phys;
 	phys_addr_t scratch_phys;
+	char previous_release[__NEW_UTS_LEN + 1];
+	u32 kexec_count;
 	struct kho_debugfs dbg;
 };
 
@@ -1408,6 +1411,74 @@ static __init int kho_out_fdt_setup(void)
 	return err;
 }
 
+static void __init kho_in_kexec_metadata(void)
+{
+	struct kho_kexec_metadata *metadata;
+	phys_addr_t metadata_phys;
+	int err;
+
+	err = kho_retrieve_subtree(KHO_METADATA_NODE_NAME, &metadata_phys,
+				   NULL);
+	if (err)
+		/* This is fine, previous kernel didn't export metadata */
+		return;
+	metadata = phys_to_virt(metadata_phys);
+
+	/*
+	 * Copy data to the kernel structure that will persist during
+	 * kernel lifetime.
+	 */
+	kho_in.kexec_count = metadata->kexec_count;
+	strscpy(kho_in.previous_release, metadata->previous_release,
+		sizeof(kho_in.previous_release));
+
+	pr_info("exec from: %s (count %u)\n", kho_in.previous_release,
+					      kho_in.kexec_count);
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
@@ -1441,6 +1512,10 @@ static __init int kho_init(void)
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
2.47.3


