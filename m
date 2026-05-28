Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5303ECD6E4B
	for <kexec@archiver.kernel.org>; Thu, 28 May 2026 00:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0yKWet6irofp6Dygz5hKnYjBExq95hNouOEHl1lcaYA=; b=ibB0LM8wwhYHfVWEPoPhx9ss4+
	0avudbgQVS6g5mlRUhy2xer6vuf7wcxhSKUApzsL9S4prYRrhkl41O1Pk4Uo9hFA9s8HrhNLAa32Z
	J+9Erx8sdTeL92t2TIO5vrCg52qL3dsNnOA9CUyN9Qw9PxZSWNZp6khk6CAvDJAF/JGAaRa/6h8UA
	Vp0OkOMFuJsbB1nNGUPXYfN2UQWfyYJJdsEh2nNSczdow8ZSkl1W3VjPiEEpS5mksSNxmVvMW2uow
	3/HFEyEl/4pUAeWqo/n5E2lHezWEhaQTqT3CPSWh8UPe5RL93Lc0rw71ewZMGWYMQrpyl+fl3JEq3
	zVVdMYag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSOqF-00000004tAT-3apm;
	Thu, 28 May 2026 00:43:19 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSOpY-00000004s4F-257T;
	Thu, 28 May 2026 00:42:37 +0000
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id C2BE920B7186; Wed, 27 May 2026 17:42:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C2BE920B7186
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779928945;
	bh=0yKWet6irofp6Dygz5hKnYjBExq95hNouOEHl1lcaYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FHsBi+OYZ9jOcAKcU2N4XgtTRa3DLo/5xpdPQ0VrR5ozMbaqTHr4GszSWV4T/H9ki
	 7ytnnjuF1mEcG+QD8rrmG5BehOPAJhT0V5AyAw2dJe45d31pNsyjIl5QyHdtmMrzf8
	 FP7l0XKJtLFJkM48S1NZyz3bc1EfsdeGKLqW7j4U=
From: Jork Loeser <jloeser@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-mm@kvack.org,
	kexec@lists.infradead.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Jason Miu <jasonmiu@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Baoquan He <bhe@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kees Cook <kees@kernel.org>,
	Ran Xiaokai <ran.xiaokai@zte.com.cn>,
	Justinien Bouron <jbouron@amazon.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Pingfan Liu <piliu@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>,
	Jork Loeser <jloeser@linux.microsoft.com>
Subject: [RFC PATCH 18/20] mshv: Exclude Hyper-V donated pages from crash dump collection
Date: Wed, 27 May 2026 17:42:00 -0700
Message-ID: <20260528004204.1484584-19-jloeser@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260528004204.1484584-1-jloeser@linux.microsoft.com>
References: <20260528004204.1484584-1-jloeser@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_174236_606913_219B03AB 
X-CRM114-Status: GOOD (  21.36  )
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

Pages donated to Hyper-V must not be read during crash dump collection.
They are not ordinary RAM and accessing them can hang or corrupt the
crash kernel.

Use the KHO radix tree of preserved pages to drive a vmcore pfn_is_ram()
callback. The radix tree root PA is passed to the crash kernel via
Hyper-V crash MSR P2, since the old kernel's KHO FDT is not accessible
from the crash kernel's direct map.

Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
---
 drivers/hv/mshv_page_preserve.c | 80 +++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/hv/mshv_page_preserve.c b/drivers/hv/mshv_page_preserve.c
index bc3a3a688f5b..e16fb946790d 100644
--- a/drivers/hv/mshv_page_preserve.c
+++ b/drivers/hv/mshv_page_preserve.c
@@ -11,6 +11,7 @@
 #define pr_fmt(fmt) "mshv: " fmt
 
 #include <asm/mshyperv.h>
+#include <linux/crash_dump.h>
 #include <linux/kexec.h>
 #include <linux/kexec_handover.h>
 #include <linux/kho_radix_tree.h>
@@ -327,6 +328,57 @@ static int __init alloc_tree(void)
 	return 0;
 }
 
+#ifdef CONFIG_CRASH_DUMP
+static struct kho_radix_crash_tree crash_preserved_pages_tree;
+
+/**
+ * restore_crash_tree() - Set up the crash tree for dump-time page exclusion.
+ *
+ * In the crash kernel, the old kernel's memory is not in the direct map.
+ * The old kernel stashes the radix tree root PA in Hyper-V crash MSR P2
+ * so we can retrieve it without touching the old kernel's FDT.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+static int __init restore_crash_tree(void)
+{
+	phys_addr_t root_pa;
+
+	root_pa = hv_get_msr(HV_MSR_CRASH_P2);
+	if (!root_pa)
+		return -ENOENT;
+
+	/*
+	 * The MSR may contain stale data from a previous
+	 * hyperv_report_panic().  Sanity-check that it looks like a
+	 * page-aligned physical address within the architectural limit.
+	 */
+	if (!PAGE_ALIGNED(root_pa) || root_pa >> MAX_POSSIBLE_PHYSMEM_BITS) {
+		pr_warn("Invalid crash tree root PA: 0x%llx\n",
+			(unsigned long long)root_pa);
+		return -EINVAL;
+	}
+
+	return kho_radix_crash_init(&crash_preserved_pages_tree, root_pa);
+}
+
+static bool mshv_vmcore_pfn_is_ram(struct vmcore_cb *cb, unsigned long pfn)
+{
+	/*
+	 * MSHV-owned pages must not be read during crash dump collection.
+	 * Currently all pages are registered at order 0. If higher-order
+	 * registrations are added, this lookup will need to handle them
+	 * (e.g. by querying multiple orders or using a range-based API).
+	 */
+	return !kho_radix_crash_contains_page(&crash_preserved_pages_tree,
+					      pfn, 0);
+}
+
+static struct vmcore_cb mshv_vmcore_cb = {
+	.pfn_is_ram = mshv_vmcore_pfn_is_ram,
+};
+#endif
+
 static struct notifier_block reboot_notifier = {
 	.notifier_call = reboot_cb,
 	.priority = 0,
@@ -347,6 +399,24 @@ int __init mshv_preserve_init(void)
 {
 	int err;
 
+#ifdef CONFIG_CRASH_DUMP
+	if (is_kdump_kernel()) {
+		/*
+		 * Crash kernel only needs the pfn_is_ram callback to exclude
+		 * MSHV-owned pages from the dump.  No page restoration, no
+		 * reboot notifier — the crash kernel reboots after collection.
+		 */
+		err = restore_crash_tree();
+		if (err) {
+			pr_err("Could not set up crash page tree: %d; MSHV pages may appear in dump\n",
+			       err);
+			return 0;
+		}
+		register_vmcore_cb(&mshv_vmcore_cb);
+		return 0;
+	}
+#endif
+
 	if (!kho_is_enabled()) {
 		pr_err("KHO is disabled; page deposits will fail.\n");
 		return 0;
@@ -383,5 +453,15 @@ int __init mshv_preserve_init(void)
 		 */
 		panic("Could not register reboot notification: %d\n", err);
 
+	/*
+	 * Stash the radix tree root PA in crash MSR P2 so the crash
+	 * kernel can retrieve it without touching the old kernel's FDT
+	 * (which is not in the crash kernel's direct map).  The root
+	 * pointer is stable once the tree is initialized — pages are
+	 * added/removed within the existing tree structure.
+	 */
+	hv_set_msr(HV_MSR_CRASH_P2,
+		   virt_to_phys(preserved_pages_tree.root));
+
 	return 0;
 }
-- 
2.43.0


