Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84323C001E0
	for <kexec@archiver.kernel.org>; Mon,  3 Jul 2023 21:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=h/IXgBmbSM0XUddrb9PRl9C9ug4UAO7k7k1bZdsbsDI=; b=m14PGgv6FRJkUY
	7Ykvhpuq8dOATiwszxYbPlrZjso55faneJCJsoJoZgVZMomwuNax0Q3kfe8Z0Lr7Fjyeu6PNshK1e
	NHE5u1mJt/HDtWhX7nmyfkRbfor1GFU76GKylRmdQUBrEOkL2yqeVvWPb+XEg0cLC1Vm5iBjHAFRK
	42I4UK0r4PawUYx6hildxKkCFr0rwLOaQuAIluP89kMvPUHJB3xID0Ml/dY02Is35ERAL1pn2nICW
	GCk2hhlvn+hBeMn0RUltvydIaSbnBgJKiOucgO58w4jEDtMutxuVEGtuHpg8CyTM2zTCELuKRJeVr
	Z9lTJpPn5AZ2mNmqTTUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGRY0-00BVyV-2l;
	Mon, 03 Jul 2023 21:57:28 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGRXu-00BVuM-13
	for kexec@lists.infradead.org;
	Mon, 03 Jul 2023 21:57:24 +0000
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 271E320C08F5;
	Mon,  3 Jul 2023 14:57:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 271E320C08F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1688421439;
	bh=BnPDGoJ+Z3iQQP7eWODZlOLENbnPQ+oha3+R2NPMATc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KJr/eV5NllbZREhRLWnmcF6pDsWGV9BgJoBaZK3m5vqn790u32+rAl3fdTIT3IPiM
	 kqQYfP25uCWai5+GtqA7peHixgQapDF0aUq/w3NlsyGlhn8EGyChlSQCQC5vrt2VLJ
	 pQR5Nf0c7E3mtL2uoCq0xjgkqHVzb4oqLJ4NKV2U=
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
To: zohar@linux.ibm.com,
	noodles@fb.com,
	bauermann@kolabnow.com,
	kexec@lists.infradead.org,
	linux-integrity@vger.kernel.org
Cc: code@tyhicks.com,
	nramas@linux.microsoft.com,
	paul@paul-moore.com
Subject: [PATCH 05/10] kexec: implement functions to map and unmap segment to kimage
Date: Mon,  3 Jul 2023 14:57:04 -0700
Message-Id: <20230703215709.1195644-6-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230703_145722_413701_FE9813D4 
X-CRM114-Status: GOOD (  20.61  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Currently, there's no mechanism to map and unmap segments to the kimage
structure.  This functionality is needed when dealing with memory segments
in the context of a kexec operation.

The patch adds two new functions: kimage_map_segment() and
kimage_unmap_segment().

Implement kimage_map_segment() which takes a kimage pointer, an address,
and a size.  Ensures that the entire segment is being mapped by comparing
the given address and size to each segment in the kimage's segment array.
Collect the source pages that correspond to the given address range,
allocate an array of pointers to these pages, and map them to a contiguous
range of virtual addresses.  If the mapping operation is successful, the
function returns the start of this range.  Otherwise, it frees the page
pointer array and returns NULL.

Implement kimage_unmap_segment() that takes a pointer to a segment buffer
and unmaps it using vunmap().

Finally, move for_each_kimage_entry() macro to kexec.h.

Note: Use kimage_map_segment() and kimage_unmap_segment() carefully to
avoid memory leaks and ensure that all mapped segments are properly
unmapped when they're no longer needed.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 include/linux/kexec.h | 13 ++++++++
 kernel/kexec_core.c   | 72 ++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 80 insertions(+), 5 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 22b5cd24f581..e00b8101b53b 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -490,6 +490,15 @@ static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, g
 static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) { }
 #endif
 
+#define for_each_kimage_entry(image, ptr, entry) \
+	for (ptr = &image->head; (entry = *ptr) && !(entry & IND_DONE); \
+		ptr = (entry & IND_INDIRECTION) ? \
+			boot_phys_to_virt((entry & PAGE_MASK)) : ptr + 1)
+
+extern void *kimage_map_segment(struct kimage *image,
+				unsigned long addr, unsigned long size);
+extern void kimage_unmap_segment(void *buffer);
+
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
@@ -497,6 +506,10 @@ static inline void __crash_kexec(struct pt_regs *regs) { }
 static inline void crash_kexec(struct pt_regs *regs) { }
 static inline int kexec_should_crash(struct task_struct *p) { return 0; }
 static inline int kexec_crash_loaded(void) { return 0; }
+static inline void *kimage_map_segment(struct kimage *image,
+				       unsigned long addr, unsigned long size)
+{ return NULL; }
+static inline void kimage_unmap_segment(void *buffer) { }
 #define kexec_in_progress false
 #endif /* CONFIG_KEXEC_CORE */
 
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 3d578c6fefee..424e303fce25 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -594,11 +594,6 @@ void kimage_terminate(struct kimage *image)
 	*image->entry = IND_DONE;
 }
 
-#define for_each_kimage_entry(image, ptr, entry) \
-	for (ptr = &image->head; (entry = *ptr) && !(entry & IND_DONE); \
-		ptr = (entry & IND_INDIRECTION) ? \
-			boot_phys_to_virt((entry & PAGE_MASK)) : ptr + 1)
-
 static void kimage_free_entry(kimage_entry_t entry)
 {
 	struct page *page;
@@ -921,6 +916,73 @@ int kimage_load_segment(struct kimage *image,
 	return result;
 }
 
+void *kimage_map_segment(struct kimage *image,
+			 unsigned long addr, unsigned long size)
+{
+	unsigned long eaddr = addr + size;
+	unsigned long src_page_addr, dest_page_addr;
+	struct page **src_pages;
+	int i, npages;
+	kimage_entry_t *ptr, entry;
+	void *vaddr = NULL;
+
+	/*
+	 * Make sure that we are mapping a whole segment.
+	 */
+	for (i = 0; i < image->nr_segments; i++) {
+		if (addr == image->segment[i].mem &&
+		    size == image->segment[i].memsz) {
+			break;
+		}
+	}
+
+	if (i == image->nr_segments) {
+		pr_err("%s: No segment matching [%lx, %lx)\n", __func__,
+		       addr, eaddr);
+		return NULL;
+	}
+
+	/*
+	 * Collect the source pages and map them in a contiguous VA range.
+	 */
+	npages = PFN_UP(eaddr) - PFN_DOWN(addr);
+	src_pages = kmalloc(sizeof(*src_pages) * npages, GFP_KERNEL);
+	if (!src_pages) {
+		pr_err("%s: Could not allocate ima pages array.\n", __func__);
+		return NULL;
+	}
+
+	i = 0;
+	for_each_kimage_entry(image, ptr, entry) {
+		if (entry & IND_DESTINATION)
+			dest_page_addr = entry & PAGE_MASK;
+		else if (entry & IND_SOURCE) {
+			if (dest_page_addr >= addr && dest_page_addr < eaddr) {
+				src_page_addr = entry & PAGE_MASK;
+				src_pages[i++] = phys_to_page(src_page_addr);
+				if (i == npages)
+					break;
+				dest_page_addr += PAGE_SIZE;
+			}
+		}
+	}
+
+	/* Sanity check. */
+	WARN_ON(i < npages);
+
+	vaddr = vmap(src_pages, npages, VM_MAP, PAGE_KERNEL);
+	if (!vaddr) {
+		pr_err("%s: Could not map imap buffer.\n", __func__);
+		kfree(src_pages);
+	}
+	return vaddr;
+}
+
+void kimage_unmap_segment(void *segment_buffer)
+{
+	vunmap(segment_buffer);
+}
+
 struct kexec_load_limit {
 	/* Mutex protects the limit count. */
 	struct mutex mutex;
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
