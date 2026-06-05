Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 187DCCD6E79
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 03:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gH8mRD7OHBJqm1quLMa7hgev2fQ64GiB6Pr4Gxty2sM=; b=EzeXFhvrx3IPM6pzj2866wFVCO
	MPkEov/seWlmyX5EJpdFgT2dsuNE5Ne4UPyQSxQaAs3vjVWHWP1T4vNbqDi09Q8xLjTnj+FisYqr2
	n5r24/nEQdxrTTUL+zMdXtUxh0HANutJJqrvtTk95v/shOupaU9mO4gK/r126zAS9/o1Yt7SlsXCf
	n6DJP9om1BRvI9iVNtoVUkqUT7Y79fkyzS23t27/5BbGNaaS4yTeHwd/H2IRWuD538Ny0dXjQTXwV
	tOggKuitmykF8zCxLCbDHtwmsd+EdhALJ4tFm5jUJbYEzml8PCD7SlXIKiOia3tdlOz/1QI2zP3tI
	zrpdfdeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVLJ7-00000000231-0VP9;
	Fri, 05 Jun 2026 03:33:17 +0000
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVLJ3-0000000021z-3uNs
	for kexec@lists.infradead.org;
	Fri, 05 Jun 2026 03:33:15 +0000
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-51778077b28so16225371cf.1
        for <kexec@lists.infradead.org>; Thu, 04 Jun 2026 20:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780630393; x=1781235193; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gH8mRD7OHBJqm1quLMa7hgev2fQ64GiB6Pr4Gxty2sM=;
        b=LwmiDh+kP4BllBI/An+zTe4NOcitTA3nHebVtd6sLKE/DmB/OxWMRFmWC6ETgb9hVv
         6qKU9vBA9kuLLQRVZJyyA5iB8qzVQaImh89CYUDYX/8HjKICSt6gUxN/CBbbyoNPGI3H
         7NZWWr8+ogmuYGxEMrrnF7SY94GqWLP1gbc4GTJL4A8buDNuFA//Yqd25L4jTd8x3LC0
         TbJBRm1waHxkdQ3opdTA56lq2zaJGNitbrc3BP6cNGV6+9PBTPxHX5DZhf/HcEa8CasH
         USmU/4CK6ZV8iMy9u+G78bmGzuo+mglcHIiy4U7AnUX+j0LDnIIBh/Tqir8/Maef/NnE
         tqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780630393; x=1781235193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gH8mRD7OHBJqm1quLMa7hgev2fQ64GiB6Pr4Gxty2sM=;
        b=gWGv0VWkH2zDzwjrdgi6pDJ3FiEzJUXiTo6M0mHlDOcIUjj5Nd8GzMCF/v3jzx79VX
         ZN2lmgZJCZg2lmRR2atSd/irCoi5XF7TYO/P1XilBCN2grmNwt6teoKeb9quRQnhQw5n
         5rMbK7+V7S6lL4buiOw2OFg0ksoxOPGo+QNfhcRyhyCGWefJaDqIUN8Jagmq/nrKLmMi
         5Vm+/O+gQQcb7s3O59p1aOcKAXvtCM1nXgoIh6NA2bsQZ8hg3En11GMwNHsMU43dk21a
         YF9No2TfnQE6IPlBxTxhxwPgQpV1LdQ+TlYlYnvQl5GxGusQhU7s7zkOZiVjMUC22FQp
         OLTg==
X-Forwarded-Encrypted: i=1; AFNElJ/xPKtqsB0nAEj/s6Tf8HHjHwCmidg+haIwMnhIDGDOxMGvYXWuuFJKnL7//c+cF4b6wjeLaQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwrrYDvvuUnyZifigldz2bSAZyYIwVTRofXcRRlqwZ1S/VQzF6J
	N5YgeKDI1Ukhv84uyiKfLnuwnFnRsD8vonY3KsGlC4Wi2v2ZstcCtjckxP/jHuUiNHU=
X-Gm-Gg: Acq92OH9XQ3Sxd9RFgMvsBL7FmRVbYfP9nDi3KbYoBjR8SdrWLnGKTaGDjzv3iHyyqi
	/xziPYgHC6PoUc9k6zRXhWkXXaUCrAX31FFOMftC1a5fQS5qxZV4WqulwXNwvrh3cr9GZCMSMUl
	gxltKonNoO5Qkl+dG5nQsik2VLnfo1KRDXzvN8caedjwPSaYnUXfByz3OGXpH1jxSdh9+3lBnZ0
	eNIAltSd5bogPLQI5VUM3OlwVl4nCHnsF7a7PpFcfoK12OMHOlTjxlunh4GUIjNSNyr/84uQDpa
	3Q/LDoNNXVkeYw456ipJzK6QnQy63UxcgsFao/oGVx7gfuN0xS3OFCDANd0IM2wOTvzxcDHApHv
	ed0MQpFM45t05ScbJDN5TzZWPSWS7x7ybDvtJOlL6e9qZLPCk9mq3B7Ymr36svh1JbPJ6S0kV2g
	vpfbMjqHIyGiflEabzuQWCNdVhmxZ0Aqz+EUUmqcssZM9KcoVYxrMBoSL7CbRTCQ==
X-Received: by 2002:a05:622a:4390:b0:517:7b11:70ea with SMTP id d75a77b69052e-51795bbf9bbmr20136841cf.31.1780630392493;
        Thu, 04 Jun 2026 20:33:12 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775dcf367sm70258631cf.25.2026.06.04.20.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 20:33:12 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	shuah@kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	jasonmiu@google.com,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	ran.xiaokai@zte.com.cn,
	pasha.tatashin@soleen.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	graf@amazon.com
Subject: [RFC v1 3/9] kho: split out vmalloc preservation into kho_vmalloc.c
Date: Fri,  5 Jun 2026 03:32:29 +0000
Message-ID: <20260605033235.717351-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605033235.717351-1-pasha.tatashin@soleen.com>
References: <20260605033235.717351-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260604_203314_046253_B8E55629 
X-CRM114-Status: GOOD (  26.59  )
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

Move the vmalloc serialization and preservation implementation out of the
core KHO code into its own dedicated file (kho_vmalloc.c).

This is a pure code movement patch; no logic or functional changes are
introduced.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 Documentation/core-api/kho/index.rst |   3 +
 kernel/liveupdate/Makefile           |   3 +-
 kernel/liveupdate/kexec_handover.c   | 258 +------------------------
 kernel/liveupdate/kho_vmalloc.c      | 274 +++++++++++++++++++++++++++
 lib/test_kho.c                       |   1 +
 mm/memfd_luo.c                       |   1 +
 6 files changed, 282 insertions(+), 258 deletions(-)
 create mode 100644 kernel/liveupdate/kho_vmalloc.c

diff --git a/Documentation/core-api/kho/index.rst b/Documentation/core-api/kho/index.rst
index f69367d217cf..a10b10700fb9 100644
--- a/Documentation/core-api/kho/index.rst
+++ b/Documentation/core-api/kho/index.rst
@@ -86,6 +86,9 @@ Public API
 .. kernel-doc:: kernel/liveupdate/kho_radix.c
   :export:
 
+.. kernel-doc:: kernel/liveupdate/kho_vmalloc.c
+  :export:
+
 KHO Serialization Blocks API
 ============================
 
diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
index a3ee8a5c27a2..b481e21a311a 100644
--- a/kernel/liveupdate/Makefile
+++ b/kernel/liveupdate/Makefile
@@ -9,7 +9,8 @@ luo-y :=								\
 
 kho-y :=								\
 		kexec_handover.o					\
-		kho_radix.o
+		kho_radix.o						\
+		kho_vmalloc.o
 
 obj-$(CONFIG_KEXEC_HANDOVER)		+= kho.o
 obj-$(CONFIG_KEXEC_HANDOVER_DEBUG)	+= kexec_handover_debug.o
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 4a3d6a54a17f..6672bc168e57 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -13,7 +13,6 @@
 #include <linux/cma.h>
 #include <linux/kmemleak.h>
 #include <linux/count_zeros.h>
-#include <linux/kasan.h>
 #include <linux/kexec.h>
 #include <linux/kexec_handover.h>
 #include <linux/kho/radix_tree.h>
@@ -23,11 +22,7 @@
 #include <linux/libfdt.h>
 #include <linux/list.h>
 #include <linux/memblock.h>
-#include <linux/page-isolation.h>
 #include <linux/unaligned.h>
-#include <linux/vmalloc.h>
-
-#include <asm/early_ioremap.h>
 
 /*
  * KHO is tightly coupled with mm init and needs access to some of mm
@@ -84,6 +79,7 @@ static struct kho_out kho_out = {
 };
 
 
+
 /* For physically contiguous 0-order pages. */
 static void kho_init_pages(struct page *page, unsigned long nr_pages)
 {
@@ -702,259 +698,7 @@ void kho_unpreserve_pages(struct page *page, unsigned long nr_pages)
 }
 EXPORT_SYMBOL_GPL(kho_unpreserve_pages);
 
-/* vmalloc flags KHO supports */
-#define KHO_VMALLOC_SUPPORTED_FLAGS	(VM_ALLOC | VM_ALLOW_HUGE_VMAP)
-
-/* KHO internal flags for vmalloc preservations */
-#define KHO_VMALLOC_ALLOC	0x0001
-#define KHO_VMALLOC_HUGE_VMAP	0x0002
-
-static unsigned short vmalloc_flags_to_kho(unsigned int vm_flags)
-{
-	unsigned short kho_flags = 0;
-
-	if (vm_flags & VM_ALLOC)
-		kho_flags |= KHO_VMALLOC_ALLOC;
-	if (vm_flags & VM_ALLOW_HUGE_VMAP)
-		kho_flags |= KHO_VMALLOC_HUGE_VMAP;
-
-	return kho_flags;
-}
-
-static unsigned int kho_flags_to_vmalloc(unsigned short kho_flags)
-{
-	unsigned int vm_flags = 0;
-
-	if (kho_flags & KHO_VMALLOC_ALLOC)
-		vm_flags |= VM_ALLOC;
-	if (kho_flags & KHO_VMALLOC_HUGE_VMAP)
-		vm_flags |= VM_ALLOW_HUGE_VMAP;
-
-	return vm_flags;
-}
-
-static struct kho_vmalloc_chunk *new_vmalloc_chunk(struct kho_vmalloc_chunk *cur)
-{
-	struct kho_vmalloc_chunk *chunk;
-	int err;
-
-	chunk = (struct kho_vmalloc_chunk *)get_zeroed_page(GFP_KERNEL);
-	if (!chunk)
-		return NULL;
-
-	err = kho_preserve_pages(virt_to_page(chunk), 1);
-	if (err)
-		goto err_free;
-	if (cur)
-		KHOSER_STORE_PTR(cur->hdr.next, chunk);
-	return chunk;
-
-err_free:
-	free_page((unsigned long)chunk);
-	return NULL;
-}
-
-static void kho_vmalloc_unpreserve_chunk(struct kho_vmalloc_chunk *chunk,
-					 unsigned short order)
-{
-	struct kho_radix_tree *tree = &kho_out.radix_tree;
-	unsigned long pfn = PHYS_PFN(virt_to_phys(chunk));
-
-	__kho_unpreserve(tree, pfn, pfn + 1);
-
-	for (int i = 0; i < ARRAY_SIZE(chunk->phys) && chunk->phys[i]; i++) {
-		pfn = PHYS_PFN(chunk->phys[i]);
-		__kho_unpreserve(tree, pfn, pfn + (1 << order));
-	}
-}
-
-/**
- * kho_preserve_vmalloc - preserve memory allocated with vmalloc() across kexec
- * @ptr: pointer to the area in vmalloc address space
- * @preservation: placeholder for preservation metadata
- *
- * Instructs KHO to preserve the area in vmalloc address space at @ptr. The
- * physical pages mapped at @ptr will be preserved and on successful return
- * @preservation will hold the physical address of a structure that describes
- * the preservation.
- *
- * NOTE: The memory allocated with vmalloc_node() variants cannot be reliably
- * restored on the same node
- *
- * Return: 0 on success, error code on failure
- */
-int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation)
-{
-	struct kho_vmalloc_chunk *chunk;
-	struct vm_struct *vm = find_vm_area(ptr);
-	unsigned int order, flags, nr_contig_pages;
-	unsigned int idx = 0;
-	int err;
-
-	if (!vm)
-		return -EINVAL;
-
-	if (vm->flags & ~KHO_VMALLOC_SUPPORTED_FLAGS)
-		return -EOPNOTSUPP;
-
-	flags = vmalloc_flags_to_kho(vm->flags);
-	order = get_vm_area_page_order(vm);
-
-	chunk = new_vmalloc_chunk(NULL);
-	if (!chunk)
-		return -ENOMEM;
-	KHOSER_STORE_PTR(preservation->first, chunk);
-
-	nr_contig_pages = (1 << order);
-	for (int i = 0; i < vm->nr_pages; i += nr_contig_pages) {
-		phys_addr_t phys = page_to_phys(vm->pages[i]);
-
-		err = kho_preserve_pages(vm->pages[i], nr_contig_pages);
-		if (err)
-			goto err_free;
-
-		chunk->phys[idx++] = phys;
-		if (idx == ARRAY_SIZE(chunk->phys)) {
-			chunk = new_vmalloc_chunk(chunk);
-			if (!chunk) {
-				err = -ENOMEM;
-				goto err_free;
-			}
-			idx = 0;
-		}
-	}
-
-	preservation->total_pages = vm->nr_pages;
-	preservation->flags = flags;
-	preservation->order = order;
-
-	return 0;
-
-err_free:
-	kho_unpreserve_vmalloc(preservation);
-	return err;
-}
-EXPORT_SYMBOL_GPL(kho_preserve_vmalloc);
-
-/**
- * kho_unpreserve_vmalloc - unpreserve memory allocated with vmalloc()
- * @preservation: preservation metadata returned by kho_preserve_vmalloc()
- *
- * Instructs KHO to unpreserve the area in vmalloc address space that was
- * previously preserved with kho_preserve_vmalloc().
- */
-void kho_unpreserve_vmalloc(struct kho_vmalloc *preservation)
-{
-	struct kho_vmalloc_chunk *chunk = KHOSER_LOAD_PTR(preservation->first);
-
-	while (chunk) {
-		struct kho_vmalloc_chunk *tmp = chunk;
-
-		kho_vmalloc_unpreserve_chunk(chunk, preservation->order);
-
-		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
-		free_page((unsigned long)tmp);
-	}
-}
-EXPORT_SYMBOL_GPL(kho_unpreserve_vmalloc);
-
-/**
- * kho_restore_vmalloc - recreates and populates an area in vmalloc address
- * space from the preserved memory.
- * @preservation: preservation metadata.
- *
- * Recreates an area in vmalloc address space and populates it with memory that
- * was preserved using kho_preserve_vmalloc().
- *
- * Return: pointer to the area in the vmalloc address space, NULL on failure.
- */
-void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
-{
-	struct kho_vmalloc_chunk *chunk = KHOSER_LOAD_PTR(preservation->first);
-	kasan_vmalloc_flags_t kasan_flags = KASAN_VMALLOC_PROT_NORMAL;
-	unsigned int align, order, shift, vm_flags;
-	unsigned long total_pages, contig_pages;
-	unsigned long addr, size;
-	struct vm_struct *area;
-	struct page **pages;
-	unsigned int idx = 0;
-	int err;
-
-	vm_flags = kho_flags_to_vmalloc(preservation->flags);
-	if (vm_flags & ~KHO_VMALLOC_SUPPORTED_FLAGS)
-		return NULL;
-
-	total_pages = preservation->total_pages;
-	pages = kvmalloc_objs(*pages, total_pages);
-	if (!pages)
-		return NULL;
-	order = preservation->order;
-	contig_pages = (1 << order);
-	shift = PAGE_SHIFT + order;
-	align = 1 << shift;
-
-	while (chunk) {
-		struct page *page;
-
-		for (int i = 0; i < ARRAY_SIZE(chunk->phys) && chunk->phys[i]; i++) {
-			phys_addr_t phys = chunk->phys[i];
-
-			if (idx + contig_pages > total_pages)
-				goto err_free_pages_array;
-
-			page = kho_restore_pages(phys, contig_pages);
-			if (!page)
-				goto err_free_pages_array;
-
-			for (int j = 0; j < contig_pages; j++)
-				pages[idx++] = page + j;
-
-			phys += contig_pages * PAGE_SIZE;
-		}
-
-		page = kho_restore_pages(virt_to_phys(chunk), 1);
-		if (!page)
-			goto err_free_pages_array;
-		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
-		__free_page(page);
-	}
-
-	if (idx != total_pages)
-		goto err_free_pages_array;
-
-	area = __get_vm_area_node(total_pages * PAGE_SIZE, align, shift,
-				  vm_flags | VM_UNINITIALIZED,
-				  VMALLOC_START, VMALLOC_END,
-				  NUMA_NO_NODE, GFP_KERNEL,
-				  __builtin_return_address(0));
-	if (!area)
-		goto err_free_pages_array;
-
-	addr = (unsigned long)area->addr;
-	size = get_vm_area_size(area);
-	err = vmap_pages_range(addr, addr + size, PAGE_KERNEL, pages, shift);
-	if (err)
-		goto err_free_vm_area;
 
-	area->nr_pages = total_pages;
-	area->pages = pages;
-
-	if (vm_flags & VM_ALLOC)
-		kasan_flags |= KASAN_VMALLOC_VM_ALLOC;
-
-	area->addr = kasan_unpoison_vmalloc(area->addr, total_pages * PAGE_SIZE,
-					    kasan_flags);
-	clear_vm_uninitialized_flag(area);
-
-	return area->addr;
-
-err_free_vm_area:
-	free_vm_area(area);
-err_free_pages_array:
-	kvfree(pages);
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(kho_restore_vmalloc);
 
 /**
  * kho_alloc_preserve - Allocate, zero, and preserve memory.
diff --git a/kernel/liveupdate/kho_vmalloc.c b/kernel/liveupdate/kho_vmalloc.c
new file mode 100644
index 000000000000..84c17b7a81ae
--- /dev/null
+++ b/kernel/liveupdate/kho_vmalloc.c
@@ -0,0 +1,274 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * kho_vmalloc.c - KHO vmalloc space serialization/preservation
+ * Copyright (C) 2025 Microsoft Corporation, Mike Rapoport <rppt@kernel.org>
+ * Copyright (C) 2025 Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+#include <linux/errno.h>
+#include <linux/gfp.h>
+#include <linux/io.h>
+#include <linux/kasan.h>
+#include <linux/kexec_handover.h>
+#include <linux/kho/abi/kexec_handover.h>
+#include <linux/kho/vmalloc.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+
+
+#include "../../mm/internal.h"
+#include "kexec_handover_internal.h"
+
+/* vmalloc flags KHO supports */
+#define KHO_VMALLOC_SUPPORTED_FLAGS	(VM_ALLOC | VM_ALLOW_HUGE_VMAP)
+
+/* KHO internal flags for vmalloc preservations */
+#define KHO_VMALLOC_ALLOC	0x0001
+#define KHO_VMALLOC_HUGE_VMAP	0x0002
+
+static unsigned short vmalloc_flags_to_kho(unsigned int vm_flags)
+{
+	unsigned short kho_flags = 0;
+
+	if (vm_flags & VM_ALLOC)
+		kho_flags |= KHO_VMALLOC_ALLOC;
+	if (vm_flags & VM_ALLOW_HUGE_VMAP)
+		kho_flags |= KHO_VMALLOC_HUGE_VMAP;
+
+	return kho_flags;
+}
+
+static unsigned int kho_flags_to_vmalloc(unsigned short kho_flags)
+{
+	unsigned int vm_flags = 0;
+
+	if (kho_flags & KHO_VMALLOC_ALLOC)
+		vm_flags |= VM_ALLOC;
+	if (kho_flags & KHO_VMALLOC_HUGE_VMAP)
+		vm_flags |= VM_ALLOW_HUGE_VMAP;
+
+	return vm_flags;
+}
+
+static struct kho_vmalloc_chunk *new_vmalloc_chunk(struct kho_vmalloc_chunk *cur)
+{
+	struct kho_vmalloc_chunk *chunk;
+	int err;
+
+	chunk = (struct kho_vmalloc_chunk *)get_zeroed_page(GFP_KERNEL);
+	if (!chunk)
+		return NULL;
+
+	err = kho_preserve_pages(virt_to_page(chunk), 1);
+	if (err)
+		goto err_free;
+	if (cur)
+		KHOSER_STORE_PTR(cur->hdr.next, chunk);
+	return chunk;
+
+err_free:
+	free_page((unsigned long)chunk);
+	return NULL;
+}
+
+static void kho_vmalloc_unpreserve_chunk(struct kho_vmalloc_chunk *chunk,
+					 unsigned short order)
+{
+	unsigned long pfn = PHYS_PFN(virt_to_phys(chunk));
+
+	kho_unpreserve_pages(pfn_to_page(pfn), 1);
+
+	for (int i = 0; i < ARRAY_SIZE(chunk->phys) && chunk->phys[i]; i++) {
+		pfn = PHYS_PFN(chunk->phys[i]);
+		kho_unpreserve_pages(pfn_to_page(pfn), 1 << order);
+	}
+}
+
+/**
+ * kho_preserve_vmalloc - preserve memory allocated with vmalloc() across kexec
+ * @ptr: pointer to the area in vmalloc address space
+ * @preservation: placeholder for preservation metadata
+ *
+ * Instructs KHO to preserve the area in vmalloc address space at @ptr. The
+ * physical pages mapped at @ptr will be preserved and on successful return
+ * @preservation will hold the physical address of a structure that describes
+ * the preservation.
+ *
+ * NOTE: The memory allocated with vmalloc_node() variants cannot be reliably
+ * restored on the same node
+ *
+ * Return: 0 on success, error code on failure
+ */
+int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation)
+{
+	struct kho_vmalloc_chunk *chunk;
+	struct vm_struct *vm = find_vm_area(ptr);
+	unsigned int order, flags, nr_contig_pages;
+	unsigned int idx = 0;
+	int err;
+
+	if (!vm)
+		return -EINVAL;
+
+	if (vm->flags & ~KHO_VMALLOC_SUPPORTED_FLAGS)
+		return -EOPNOTSUPP;
+
+	flags = vmalloc_flags_to_kho(vm->flags);
+	order = get_vm_area_page_order(vm);
+
+	chunk = new_vmalloc_chunk(NULL);
+	if (!chunk)
+		return -ENOMEM;
+	KHOSER_STORE_PTR(preservation->first, chunk);
+
+	nr_contig_pages = (1 << order);
+	for (int i = 0; i < vm->nr_pages; i += nr_contig_pages) {
+		phys_addr_t phys = page_to_phys(vm->pages[i]);
+
+		err = kho_preserve_pages(vm->pages[i], nr_contig_pages);
+		if (err)
+			goto err_free;
+
+		chunk->phys[idx++] = phys;
+		if (idx == ARRAY_SIZE(chunk->phys)) {
+			chunk = new_vmalloc_chunk(chunk);
+			if (!chunk) {
+				err = -ENOMEM;
+				goto err_free;
+			}
+			idx = 0;
+		}
+	}
+
+	preservation->total_pages = vm->nr_pages;
+	preservation->flags = flags;
+	preservation->order = order;
+
+	return 0;
+
+err_free:
+	kho_unpreserve_vmalloc(preservation);
+	return err;
+}
+EXPORT_SYMBOL_GPL(kho_preserve_vmalloc);
+
+/**
+ * kho_unpreserve_vmalloc - unpreserve memory allocated with vmalloc()
+ * @preservation: preservation metadata returned by kho_preserve_vmalloc()
+ *
+ * Instructs KHO to unpreserve the area in vmalloc address space that was
+ * previously preserved with kho_preserve_vmalloc().
+ */
+void kho_unpreserve_vmalloc(struct kho_vmalloc *preservation)
+{
+	struct kho_vmalloc_chunk *chunk = KHOSER_LOAD_PTR(preservation->first);
+
+	while (chunk) {
+		struct kho_vmalloc_chunk *tmp = chunk;
+
+		kho_vmalloc_unpreserve_chunk(chunk, preservation->order);
+
+		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
+		free_page((unsigned long)tmp);
+	}
+}
+EXPORT_SYMBOL_GPL(kho_unpreserve_vmalloc);
+
+/**
+ * kho_restore_vmalloc - recreates and populates an area in vmalloc address
+ * space from the preserved memory.
+ * @preservation: preservation metadata.
+ *
+ * Recreates an area in vmalloc address space and populates it with memory that
+ * was preserved using kho_preserve_vmalloc().
+ *
+ * Return: pointer to the area in the vmalloc address space, NULL on failure.
+ */
+void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
+{
+	struct kho_vmalloc_chunk *chunk = KHOSER_LOAD_PTR(preservation->first);
+	kasan_vmalloc_flags_t kasan_flags = KASAN_VMALLOC_PROT_NORMAL;
+	unsigned int align, order, shift, vm_flags;
+	unsigned long total_pages, contig_pages;
+	unsigned long addr, size;
+	struct vm_struct *area;
+	struct page **pages;
+	unsigned int idx = 0;
+	int err;
+
+	vm_flags = kho_flags_to_vmalloc(preservation->flags);
+	if (vm_flags & ~KHO_VMALLOC_SUPPORTED_FLAGS)
+		return NULL;
+
+	total_pages = preservation->total_pages;
+	pages = kvmalloc_objs(*pages, total_pages);
+	if (!pages)
+		return NULL;
+	order = preservation->order;
+	contig_pages = (1 << order);
+	shift = PAGE_SHIFT + order;
+	align = 1 << shift;
+
+	while (chunk) {
+		struct page *page;
+
+		for (int i = 0; i < ARRAY_SIZE(chunk->phys) && chunk->phys[i]; i++) {
+			phys_addr_t phys = chunk->phys[i];
+
+			if (idx + contig_pages > total_pages)
+				goto err_free_pages_array;
+
+			page = kho_restore_pages(phys, contig_pages);
+			if (!page)
+				goto err_free_pages_array;
+
+			for (int j = 0; j < contig_pages; j++)
+				pages[idx++] = page + j;
+
+			phys += contig_pages * PAGE_SIZE;
+		}
+
+		page = kho_restore_pages(virt_to_phys(chunk), 1);
+		if (!page)
+			goto err_free_pages_array;
+		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
+		__free_page(page);
+	}
+
+	if (idx != total_pages)
+		goto err_free_pages_array;
+
+	area = __get_vm_area_node(total_pages * PAGE_SIZE, align, shift,
+				  vm_flags | VM_UNINITIALIZED,
+				  VMALLOC_START, VMALLOC_END,
+				  NUMA_NO_NODE, GFP_KERNEL,
+				  __builtin_return_address(0));
+	if (!area)
+		goto err_free_pages_array;
+
+	addr = (unsigned long)area->addr;
+	size = get_vm_area_size(area);
+	err = vmap_pages_range(addr, addr + size, PAGE_KERNEL, pages, shift);
+	if (err)
+		goto err_free_vm_area;
+
+	area->nr_pages = total_pages;
+	area->pages = pages;
+
+	if (vm_flags & VM_ALLOC)
+		kasan_flags |= KASAN_VMALLOC_VM_ALLOC;
+
+	area->addr = kasan_unpoison_vmalloc(area->addr, total_pages * PAGE_SIZE,
+					    kasan_flags);
+	clear_vm_uninitialized_flag(area);
+
+	return area->addr;
+
+err_free_vm_area:
+	free_vm_area(area);
+err_free_pages_array:
+	kvfree(pages);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(kho_restore_vmalloc);
diff --git a/lib/test_kho.c b/lib/test_kho.c
index aa6a0956bb8b..6907e09688dd 100644
--- a/lib/test_kho.c
+++ b/lib/test_kho.c
@@ -20,6 +20,7 @@
 #include <linux/vmalloc.h>
 #include <linux/kexec_handover.h>
 #include <linux/kho/abi/kexec_handover.h>
+#include <linux/kho/vmalloc.h>
 
 #include <net/checksum.h>
 
diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index 59de210bee5f..ade2aa24c7b8 100644
--- a/mm/memfd_luo.c
+++ b/mm/memfd_luo.c
@@ -76,6 +76,7 @@
 #include <linux/io.h>
 #include <linux/kexec_handover.h>
 #include <linux/kho/abi/memfd.h>
+#include <linux/kho/vmalloc.h>
 #include <linux/liveupdate.h>
 #include <linux/shmem_fs.h>
 #include <linux/vmalloc.h>
-- 
2.53.0


