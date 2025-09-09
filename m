Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B71CAC583
	for <kexec@archiver.kernel.org>; Tue,  9 Sep 2025 17:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bHuTpuFDBTx6I41iJVGaHiW2V3hZpXsUAkeGb/SFsyE=; b=do0AcA3XvEWnN0lR3YxMH8ovaw
	gPImMOwUA31jbJaN4TeAmxaSXeFACptpqo6QKtSOZwFP9Kk8qTzT2guK1i1WXxEglB0gICjbFoczL
	G0zQ5pWJyHIiw/gvJA7Ivnvn0mF5qg6ySRJbJMjYRhMVV+xdtQSYJkLSR6liLG3rh+sL29DYq8w65
	kUkup+NSqSeFxO0wH7K8spapixbefqeaVfmSSW4zwo+qs9SWxMoTa4mqOiW4TWRDJgVLiNeQ2ptgn
	5Rzn3VHxnnBibWE0nBCkk1WpUaeiNX1X3oTRn2f+D7O8AtckS4iXUi8j0OROyTZkAXWFB0M/NtOBC
	B3kt9i8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw21w-00000008xkO-11CC;
	Tue, 09 Sep 2025 17:21:20 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvzaP-00000007p7v-1gtY
	for kexec@lists.infradead.org;
	Tue, 09 Sep 2025 14:44:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C273C6022D;
	Tue,  9 Sep 2025 14:44:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547C8C4CEFC;
	Tue,  9 Sep 2025 14:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757429084;
	bh=R58t8Ck7gaCyPwSxTfKs4rf/zne/bpphAKyTAFsHSEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nTeyXhqaog50wiTHSSHI/usuM6Lz1jubOhD0MerikJmeK4c/dobUWCoKgpcwy2wFK
	 Lb39k544yz4KwqKbBp7ObMKBgessNF88sW9kNtV3Ueo704WFmO60mTKjH0CrO62j2O
	 HdVlqYH1A3Y42pMDsi8xJAc9FsgOPyNeayWGFy1Wd6wgpbDhyiUjCPscw9EP/5yrSi
	 tVhcWdijota3s2Uc6HG8jMDzcVTXp1inUWpKioo0B3Dj28uWySSwbWDLOIe8VwGI0j
	 8IqLOJNwnFkzlz3AxXHJiIA4jQt3cWdaBsmtSeyUztA1fDXjqYXiEOiWJnuxVX7HlF
	 uHD9wGZNDLPpw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Chris Li <chrisl@kernel.org>,
	Jason Miu <jasonmiu@google.com>,
	David Matlack <dmatlack@google.com>,
	David Rientjes <rientjes@google.com>
Cc: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 3/4] kho: add support for preserving vmalloc allocations
Date: Tue,  9 Sep 2025 16:44:23 +0200
Message-ID: <20250909144426.33274-4-pratyush@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909144426.33274-1-pratyush@kernel.org>
References: <20250909144426.33274-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

A vmalloc allocation is preserved using binary structure similar to
global KHO memory tracker. It's a linked list of pages where each page
is an array of physical address of pages in vmalloc area.

kho_preserve_vmalloc() hands out the physical address of the head page
to the caller. This address is used as the argument to
kho_vmalloc_restore() to restore the mapping in the vmalloc address
space and populate it with the preserved pages.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
[pratyush@kernel.org: use KHO array instead of linked list of pages to
track physical addresses]
Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
---
 include/linux/kexec_handover.h |  21 +++++
 kernel/kexec_handover.c        | 143 +++++++++++++++++++++++++++++++++
 2 files changed, 164 insertions(+)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 348844cffb136..633f94cec1a35 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/errno.h>
+#include <linux/kho_array.h>
 
 struct kho_scratch {
 	phys_addr_t addr;
@@ -37,13 +38,23 @@ struct notifier_block;
 	})
 
 struct kho_serialization;
+struct kho_vmalloc;
 
 #ifdef CONFIG_KEXEC_HANDOVER
+struct kho_vmalloc {
+	struct kho_array ka;
+	unsigned int total_pages;
+	unsigned int flags;
+	unsigned short order;
+};
+
 bool kho_is_enabled(void);
 
 int kho_preserve_folio(struct folio *folio);
+int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation);
 int kho_preserve_phys(phys_addr_t phys, size_t size);
 struct folio *kho_restore_folio(phys_addr_t phys);
+void *kho_restore_vmalloc(struct kho_vmalloc *preservation);
 int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt);
 int kho_retrieve_subtree(const char *name, phys_addr_t *phys);
 
@@ -70,11 +81,21 @@ static inline int kho_preserve_phys(phys_addr_t phys, size_t size)
 	return -EOPNOTSUPP;
 }
 
+static inline int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline struct folio *kho_restore_folio(phys_addr_t phys)
 {
 	return NULL;
 }
 
+static inline void *kho_restore_vmalloc(struct kho_vmalloc *preservation)
+{
+	return NULL;
+}
+
 static inline int kho_add_subtree(struct kho_serialization *ser,
 				  const char *name, void *fdt)
 {
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 26f9f5295f07d..5f89134ceeee0 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -19,6 +19,7 @@
 #include <linux/notifier.h>
 #include <linux/page-isolation.h>
 #include <linux/kho_array.h>
+#include <linux/vmalloc.h>
 
 #include <asm/early_ioremap.h>
 
@@ -723,6 +724,148 @@ int kho_preserve_phys(phys_addr_t phys, size_t size)
 }
 EXPORT_SYMBOL_GPL(kho_preserve_phys);
 
+#define KHO_VMALLOC_FLAGS_MASK	(VM_ALLOC | VM_ALLOW_HUGE_VMAP)
+
+/**
+ * kho_preserve_vmalloc - preserve memory allocated with vmalloc() across kexec
+ * @ptr: pointer to the area in vmalloc address space
+ * @preservation: pointer to metadata for preserved data.
+ *
+ * Instructs KHO to preserve the area in vmalloc address space at @ptr. The
+ * physical pages mapped at @ptr will be preserved and on successful return
+ * @preservation will hold the structure that describes the metadata for the
+ * preserved pages. @preservation itself is not KHO-preserved. The caller must
+ * do that.
+ *
+ * NOTE: The memory allocated with vmalloc_node() variants cannot be reliably
+ * restored on the same node
+ *
+ * Return: 0 on success, error code on failure
+ */
+int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation)
+{
+	struct kho_mem_track *track = &kho_out.ser.track;
+	struct vm_struct *vm = find_vm_area(ptr);
+	unsigned int order, flags;
+	struct ka_iter iter;
+	int err;
+
+	if (!vm)
+		return -EINVAL;
+
+	if (vm->flags & ~KHO_VMALLOC_FLAGS_MASK)
+		return -EOPNOTSUPP;
+
+	flags = vm->flags & KHO_VMALLOC_FLAGS_MASK;
+	order = get_vm_area_page_order(vm);
+
+	preservation->total_pages = vm->nr_pages;
+	preservation->flags = flags;
+	preservation->order = order;
+
+	ka_iter_init_write(&iter, &preservation->ka);
+
+	for (int i = 0, pos = 0; i < vm->nr_pages; i += (1 << order), pos++) {
+		phys_addr_t phys = page_to_phys(vm->pages[i]);
+
+		err = __kho_preserve_order(track, PHYS_PFN(phys), order);
+		if (err)
+			goto err_free;
+
+		err = ka_iter_setpos(&iter, pos);
+		if (err)
+			goto err_free;
+
+		err = ka_iter_setentry(&iter, ka_mk_value(phys));
+		if (err)
+			goto err_free;
+	}
+
+	err = kho_array_preserve(&preservation->ka);
+	if (err)
+		goto err_free;
+
+	return 0;
+
+err_free:
+	kho_array_destroy(&preservation->ka);
+	return err;
+}
+EXPORT_SYMBOL_GPL(kho_preserve_vmalloc);
+
+/**
+ * kho_restore_vmalloc - recreates and populates an area in vmalloc address
+ * space from the preserved memory.
+ * @preservation: the preservation metadata.
+ *
+ * Recreates an area in vmalloc address space and populates it with memory that
+ * was preserved using kho_preserve_vmalloc().
+ *
+ * Return: pointer to the area in the vmalloc address space, NULL on failure.
+ */
+void *kho_restore_vmalloc(struct kho_vmalloc *preservation)
+{
+	unsigned int align, order, shift, flags;
+	unsigned int idx = 0, nr;
+	unsigned long addr, size;
+	struct vm_struct *area;
+	struct page **pages;
+	struct ka_iter iter;
+	void *entry;
+	int err;
+
+	flags = preservation->flags;
+	if (flags & ~KHO_VMALLOC_FLAGS_MASK)
+		return NULL;
+
+	err = ka_iter_init_restore(&iter, &preservation->ka);
+	if (err)
+		return NULL;
+
+	nr = preservation->total_pages;
+	pages = kvmalloc_array(nr, sizeof(*pages), GFP_KERNEL);
+	if (!pages)
+		goto err_ka_destroy;
+	order = preservation->order;
+	shift = PAGE_SHIFT + order;
+	align = 1 << shift;
+
+	ka_iter_for_each(&iter, entry) {
+		phys_addr_t phys = ka_to_value(entry);
+		struct page *page;
+
+		page = phys_to_page(phys);
+		kho_restore_page(page, 0);
+		pages[idx++] = page;
+		phys += PAGE_SIZE;
+	}
+
+	area = __get_vm_area_node(nr * PAGE_SIZE, align, shift, flags,
+				  VMALLOC_START, VMALLOC_END, NUMA_NO_NODE,
+				  GFP_KERNEL, __builtin_return_address(0));
+	if (!area)
+		goto err_free_pages_array;
+
+	addr = (unsigned long)area->addr;
+	size = get_vm_area_size(area);
+	err = vmap_pages_range(addr, addr + size, PAGE_KERNEL, pages, shift);
+	if (err)
+		goto err_free_vm_area;
+
+	kho_array_destroy(&preservation->ka);
+
+	return area->addr;
+
+err_free_vm_area:
+	free_vm_area(area);
+err_free_pages_array:
+	kvfree(pages);
+err_ka_destroy:
+	kho_array_destroy(&preservation->ka);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(kho_restore_vmalloc);
+
 /* Handling for debug/kho/out */
 
 static struct dentry *debugfs_root;
-- 
2.47.3


