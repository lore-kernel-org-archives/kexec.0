Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F3CC02192
	for <kexec@archiver.kernel.org>; Mon,  3 Feb 2025 19:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l74eF+4+r695BFOwyov/kRxEW4Z5jvFKpT/pUDEgh3Q=; b=VkzPFdTudYZUh4w9y4ieFnqzDk
	ORnTXuK9NnNTc+WpsECUcJh+JDyZG1qdDhbj8Sb/O4n1ZudATpABFO/OwHoNXEv76Nr5Z4IVDGx9e
	Sq9ta9WSBslL+P/yYRxZ9+vDndfTTr0qHG+5zRbbZVzCGhJA9Pvoir+Nv254+UjSfeDRVOteeiDRE
	PpKB/cR5A6W1j8o3T8vPShwBjHhecvmTz1HmMd4p4etTHSFgN/GnvPXw4qIrMMuPz+UiBOkJxE5BP
	HnicKKPiFRC6Eu8zw59ZZJqLCa3G9jtzaqp3JehOlpmX9pvKiYwzRtX46vVBoYRN21Sy1KMTLAqrB
	+GQlDgYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tf1g7-0000000GMWS-344u;
	Mon, 03 Feb 2025 19:00:15 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tf1PV-0000000GInb-2QpN
	for kexec@lists.infradead.org;
	Mon, 03 Feb 2025 18:43:07 +0000
Received: from localhost.localdomain (unknown [167.220.59.4])
	by linux.microsoft.com (Postfix) with ESMTPSA id 346972054938;
	Mon,  3 Feb 2025 10:43:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 346972054938
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738608184;
	bh=l74eF+4+r695BFOwyov/kRxEW4Z5jvFKpT/pUDEgh3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nXqgAAht6jT01pU7JPYfhksyK7TVNJFMaqlOrI/jiibAqJH5enZoJpMdov4u/s9Z/
	 AhmtKylAk2jLZLjSBLz/m9cdR+n0tZqJ2ZQRfAjOJVOst3K2Cq220hNXTfQOPUW4Tv
	 vD+XmLH4sB+oTGkUXfU04ucBTkE8QnItoeIHYPh8=
From: steven chen <chenste@linux.microsoft.com>
To: zohar@linux.ibm.com,
	stefanb@linux.ibm.com,
	roberto.sassu@huaweicloud.com,
	roberto.sassu@huawei.com,
	eric.snowberg@oracle.com,
	ebiederm@xmission.com,
	paul@paul-moore.com,
	code@tyhicks.com,
	bauermann@kolabnow.com,
	inux-integrity@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenste@linux.microsoft.com
Cc: madvenka@linux.microsoft.com,
	nramas@linux.microsoft.com,
	James.Bottomley@HansenPartnership.com
Subject: [PATCH v7 2/7] kexec: define functions to map and unmap segments
Date: Mon,  3 Feb 2025 10:42:51 -0800
Message-Id: <20250203184256.61285-3-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250203184256.61285-1-chenste@linux.microsoft.com>
References: <20250203184256.61285-1-chenste@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250203_104305_678836_F7D10872 
X-CRM114-Status: GOOD (  16.41  )
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

Currently, the mechanism to map and unmap segments to the kimage
structure is not available to the subsystems outside of kexec.  This
functionality is needed when IMA is allocating the memory segments
during kexec 'load' operation.  Implement functions to map and unmap
segments to kimage.

Implement kimage_map_segment() to enable mapping of IMA buffer source
pages to the kimage structure post kexec 'load'.  This function,
accepting a kimage pointer, an address, and a size, will gather the
source pages within the specified address range, create an array of page
pointers, and map these to a contiguous virtual address range.  The
function returns the start of this range if successful, or NULL if
unsuccessful.

Implement kimage_unmap_segment() for unmapping segments
using vunmap().

From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Signed-off-by: steven chen <chenste@linux.microsoft.com>
---
 include/linux/kexec.h |  7 ++++++
 kernel/kexec_core.c   | 54 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index f0e9f8eda7a3..f8413ea5c8c8 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -467,6 +467,9 @@ extern bool kexec_file_dbg_print;
 #define kexec_dprintk(fmt, arg...) \
         do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0)
 
+extern void *kimage_map_segment(struct kimage *image,
+					unsigned long addr, unsigned long size);
+extern void kimage_unmap_segment(void *buffer);
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
@@ -474,6 +477,10 @@ static inline void __crash_kexec(struct pt_regs *regs) { }
 static inline void crash_kexec(struct pt_regs *regs) { }
 static inline int kexec_should_crash(struct task_struct *p) { return 0; }
 static inline int kexec_crash_loaded(void) { return 0; }
+static inline void *kimage_map_segment(struct kimage *image,
+					unsigned long addr, unsigned long size)
+{ return NULL; }
+static inline void kimage_unmap_segment(void *buffer) { }
 #define kexec_in_progress false
 #endif /* CONFIG_KEXEC_CORE */
 
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index c0caa14880c3..4029df8f6860 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -867,6 +867,60 @@ int kimage_load_segment(struct kimage *image,
 	return result;
 }
 
+void *kimage_map_segment(struct kimage *image,
+			 unsigned long addr, unsigned long size)
+{
+	unsigned long eaddr = addr + size;
+	unsigned long src_page_addr, dest_page_addr;
+	unsigned int npages;
+	struct page **src_pages;
+	int i;
+	kimage_entry_t *ptr, entry;
+	void *vaddr = NULL;
+
+	/*
+	 * Collect the source pages and map them in a contiguous VA range.
+	 */
+	npages = PFN_UP(eaddr) - PFN_DOWN(addr);
+	src_pages = kmalloc_array(npages, sizeof(*src_pages), GFP_KERNEL);
+	if (!src_pages) {
+		pr_err("Could not allocate ima pages array.\n");
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
+				src_pages[i++] =
+					virt_to_page(__va(src_page_addr));
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
+	kfree(src_pages);
+
+	if (!vaddr)
+		pr_err("Could not map ima buffer.\n");
+
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


