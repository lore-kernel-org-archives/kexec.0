Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6147CA100C
	for <kexec@archiver.kernel.org>; Wed,  3 Sep 2025 06:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HWZwFYnc9AbNVc+pd/rQ/Kr2nKuVQa6MiB8177P1n/U=; b=RAcuUjUvgAiFcXqVl75AUc4ZVp
	nxEffqQmjibMZ9SAVhX6ip9i+UnQN+qU4MDTP1EW6IQA1z9q2fZBOyxp6UUY0dv/H85fxJISNRdc+
	jCk5iBKwYrCxl5xzGmxcUq+7HMLZPbb0CDCnI/W61Qv6Qh90ss0vEpPVyKXEPNvgLg1wG8zo5H0Ju
	KxPXqNIhXrOG0lSnRHrbaxmkamfLVZwqUT0hPbQz2h/s/Ro2D9kV3yiBoPoqV3V6GqAuYtUWgJw3T
	ov/GByIrJ0eF1yzdidRsYZLKLEKEHToqhkbEA+twyVcG52o+tFcN3OYCUUXFLWhV637KeQoWHrddv
	4PpI4XGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uth6C-00000004h9J-1ZJS;
	Wed, 03 Sep 2025 06:36:04 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uth0o-00000004edd-0Mrt
	for kexec@lists.infradead.org;
	Wed, 03 Sep 2025 06:30:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7BEE860239;
	Wed,  3 Sep 2025 06:30:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1168CC4CEF1;
	Wed,  3 Sep 2025 06:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756881029;
	bh=71VhAKjgW0E1aO+puSjE7uBqc/1v+0Vas8jZUkLzLuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K12YYfWJlksaS+EWHjzH/MCzJZAzvwF42oeLtOIsRgk4D+3RztSI8WhbMfCjqJxmR
	 eplt3hMq0MVq+NIojWepYjQWaRZCMARGfsRSr0854+nCxMqRFbm6F9rDv/cbfQSrqT
	 ys8u6+IBxtZD8sD9pLU/HvRfwzXwsf5Pr036ogTFzG8vV+vA0QwH+iQhpi5oUxZLC5
	 7sGTLV9Bj+sgMH/SG8aLnDrKZXk2f/NvNptrTHkZjXgEawFmwf/cwC/jR7DIft+I9F
	 MBfH3Jt3v/VWqh1CkKzm1zgoqSXV8eDEb4vhx9rwaWivag2I3VH47wVc3MPjRYlRZa
	 7wbfsptG8q5MQ==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Graf <graf@amazon.com>,
	Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>,
	Chris Li <chrisl@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kho: add support for preserving vmalloc allocations
Date: Wed,  3 Sep 2025 09:30:17 +0300
Message-ID: <20250903063018.3346652-2-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250903063018.3346652-1-rppt@kernel.org>
References: <20250903063018.3346652-1-rppt@kernel.org>
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
---
 include/linux/kexec_handover.h |  12 +++
 kernel/kexec_handover.c        | 140 +++++++++++++++++++++++++++++++++
 2 files changed, 152 insertions(+)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 348844cffb13..b7bf3bf11019 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -42,8 +42,10 @@ struct kho_serialization;
 bool kho_is_enabled(void);
 
 int kho_preserve_folio(struct folio *folio);
+int kho_preserve_vmalloc(void *ptr, phys_addr_t *preservation);
 int kho_preserve_phys(phys_addr_t phys, size_t size);
 struct folio *kho_restore_folio(phys_addr_t phys);
+void *kho_restore_vmalloc(phys_addr_t preservation);
 int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt);
 int kho_retrieve_subtree(const char *name, phys_addr_t *phys);
 
@@ -70,11 +72,21 @@ static inline int kho_preserve_phys(phys_addr_t phys, size_t size)
 	return -EOPNOTSUPP;
 }
 
+static inline int kho_preserve_vmalloc(void *ptr, phys_addr_t *preservation)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline struct folio *kho_restore_folio(phys_addr_t phys)
 {
 	return NULL;
 }
 
+static inline void *kho_restore_vmalloc(phys_addr_t preservation)
+{
+	return NULL;
+}
+
 static inline int kho_add_subtree(struct kho_serialization *ser,
 				  const char *name, void *fdt)
 {
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index ecd1ac210dbd..a11ae79d6bc9 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -18,6 +18,7 @@
 #include <linux/memblock.h>
 #include <linux/notifier.h>
 #include <linux/page-isolation.h>
+#include <linux/vmalloc.h>
 
 #include <asm/early_ioremap.h>
 
@@ -733,6 +734,145 @@ int kho_preserve_phys(phys_addr_t phys, size_t size)
 }
 EXPORT_SYMBOL_GPL(kho_preserve_phys);
 
+struct kho_vmalloc_chunk;
+
+struct kho_vmalloc_hdr {
+	DECLARE_KHOSER_PTR(next, struct kho_vmalloc_chunk *);
+	unsigned int total_pages;	/* only valid in the first chunk */
+	unsigned int num_elms;
+};
+
+#define KHO_VMALLOC_SIZE				\
+	((PAGE_SIZE - sizeof(struct kho_vmalloc_hdr)) / \
+	 sizeof(phys_addr_t))
+
+struct kho_vmalloc_chunk {
+	struct kho_vmalloc_hdr hdr;
+	phys_addr_t phys[KHO_VMALLOC_SIZE];
+};
+
+static_assert(sizeof(struct kho_vmalloc_chunk) == PAGE_SIZE);
+
+static struct kho_vmalloc_chunk *new_vmalloc_chunk(struct kho_vmalloc_chunk *cur)
+{
+	struct kho_vmalloc_chunk *chunk;
+	int err;
+
+	chunk = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!chunk)
+		return NULL;
+
+	err = kho_preserve_phys(virt_to_phys(chunk), PAGE_SIZE);
+	if (err)
+		goto err_free;
+	if (cur)
+		KHOSER_STORE_PTR(cur->hdr.next, chunk);
+	return chunk;
+
+err_free:
+	kfree(chunk);
+	return NULL;
+}
+
+static void kho_vmalloc_free_chunks(struct kho_vmalloc_chunk *first_chunk)
+{
+	struct kho_mem_track *track = &kho_out.ser.track;
+	struct kho_vmalloc_chunk *chunk = first_chunk;
+
+	while (chunk) {
+		unsigned long pfn = PHYS_PFN(virt_to_phys(chunk));
+		struct kho_vmalloc_chunk *tmp = chunk;
+
+		__kho_unpreserve(track, pfn, pfn + 1);
+
+		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
+		kfree(tmp);
+	}
+}
+
+int kho_preserve_vmalloc(void *ptr, phys_addr_t *preservation)
+{
+	struct kho_vmalloc_chunk *chunk, *first_chunk;
+	struct vm_struct *vm = find_vm_area(ptr);
+	int err;
+
+	if (!vm)
+		return -EINVAL;
+
+	/* we don't support HUGE_VMAP yet */
+	if (get_vm_area_page_order(vm))
+		return -EOPNOTSUPP;
+
+	chunk = new_vmalloc_chunk(NULL);
+	if (!chunk)
+		return -ENOMEM;
+	first_chunk = chunk;
+	first_chunk->hdr.total_pages = vm->nr_pages;
+
+	for (int i = 0; i < vm->nr_pages; i++) {
+		phys_addr_t phys = page_to_phys(vm->pages[i]);
+
+		err = kho_preserve_phys(phys, PAGE_SIZE);
+		if (err)
+			goto err_free;
+
+		chunk->phys[chunk->hdr.num_elms] = phys;
+		chunk->hdr.num_elms++;
+		if (chunk->hdr.num_elms == ARRAY_SIZE(chunk->phys)) {
+			chunk = new_vmalloc_chunk(chunk);
+			if (!chunk)
+				goto err_free;
+		}
+	}
+
+	*preservation = virt_to_phys(first_chunk);
+	return 0;
+
+err_free:
+	kho_vmalloc_free_chunks(first_chunk);
+	return err;
+}
+EXPORT_SYMBOL_GPL(kho_preserve_vmalloc);
+
+void *kho_restore_vmalloc(phys_addr_t preservation)
+{
+	struct kho_vmalloc_chunk *chunk = phys_to_virt(preservation);
+	unsigned int idx = 0, nr = 0;
+	struct page **pages;
+	void *ptr;
+
+	nr = chunk->hdr.total_pages;
+	pages = kvmalloc_array(nr, sizeof(*pages), GFP_KERNEL);
+	if (!pages)
+		return NULL;
+
+	while (chunk) {
+		struct page *page;
+
+		for (int i = 0; i < chunk->hdr.num_elms; i++) {
+			page = phys_to_page(chunk->phys[i]);
+			kho_restore_page(page, 0);
+			pages[idx++] = page;
+		}
+
+		page = virt_to_page(chunk);
+		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
+		kho_restore_page(page, 0);
+		__free_page(page);
+	}
+
+	ptr = vmap(pages, nr, VM_MAP_PUT_PAGES, PAGE_KERNEL);
+	if (!ptr)
+		goto err_free_pages_array;
+
+	return ptr;
+
+err_free_pages_array:
+	kvfree(pages);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(kho_restore_vmalloc);
+
 /* Handling for debug/kho/out */
 
 static struct dentry *debugfs_root;
-- 
2.50.1


