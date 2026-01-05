Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D4C6C79FA8
	for <kexec@archiver.kernel.org>; Mon,  5 Jan 2026 16:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O6uql0bLfHwBs9J3kz8aAHuHYtLc0x/EW/OxsewkLIE=; b=34jRH3xOCWD+lLHrCcxdXOaJ9w
	ZVN1aZLYLsfNRZkqgQIHRXgKhtlmQPywj1jcLxb6K1/Lse4Zwpnuvorp0NySa9dg80m5H2tHu4kdm
	CMJTo7Yvkzi52NpP2tIZVGcRcCviOyDfB4JWwga+gzWnYVS+9nZUJijZ5tYtuW81upci0QrbRKGX9
	8uSB0C4Rk/TtRS2+bIi+D8smVH/6rqySlIt6CQ9gO9IqLMKd0eLwRLjWmQShDls/4wSbbDK7+uuuM
	hHd4I2e+UYPu3+P3Rk5MTb54sgDBySg6PeHXrhvOxeKciyZEA4kdsmU4/3SZaPrfByOXnCdUUXuAS
	sKfjSN4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcnv7-0000000BluQ-3Pru;
	Mon, 05 Jan 2026 16:59:05 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcnv4-0000000BlsU-3p9t
	for kexec@lists.infradead.org;
	Mon, 05 Jan 2026 16:59:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7DA57442B3;
	Mon,  5 Jan 2026 16:59:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A333EC116D0;
	Mon,  5 Jan 2026 16:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767632342;
	bh=QTDOXlDkJ9zjosm6c2byYq1FFwdNTP66U6TS3FlcQAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mLdJ/2QigjyxI/687tX4wJJHUg/g+xM9qRziqOdeCMKXjHvYGZ/RPEItvGyk0TjO9
	 tZtUeVEppUO7uuGKDGXnR9qYC5tma+7WWeSfc0WfBW8VPvADBguWvO3rVQRc97vHZ5
	 3fy12UHVS0LjyjVAT3HnIRomitNYuYIq1ye2QW10hQoYWeq6aSe2qhOEX1z1gE4FHh
	 NZMHKSSQ1y5GrNjI9vxtictW53/yVTPKMkpPxIM7eZb/CcN6srBmz3a0Iy8eVJpuK/
	 CntEedtZrEgPrCwbsMG70iJ+KFxsT7Ab94+1mZr1po+bm2BNjYBZD3zmK8/p8dHCpT
	 RCIqGHj25QzNQ==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Graf <graf@amazon.com>,
	Jason Miu <jasonmiu@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	kexec@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 5/6] kho: Relocate vmalloc preservation structure to KHO ABI header
Date: Mon,  5 Jan 2026 18:58:38 +0200
Message-ID: <20260105165839.285270-6-rppt@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105165839.285270-1-rppt@kernel.org>
References: <20260105165839.285270-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260105_085903_280917_F686152D 
X-CRM114-Status: GOOD (  21.01  )
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

From: Jason Miu <jasonmiu@google.com>

The `struct kho_vmalloc` defines the in-memory layout for preserving
vmalloc regions across kexec. This layout is a contract between kernels
and part of the KHO ABI.

To reflect this relationship, the related structs and helper macros are
relocated to the ABI header, `include/linux/kho/abi/kexec_handover.h`.
This move places the structure's definition under the protection of the
KHO_FDT_COMPATIBLE version string.

The structure and its components are now also documented within the
ABI header to describe the contract and prevent ABI breaks.

Signed-off-by: Jason Miu <jasonmiu@google.com>
Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 Documentation/core-api/kho/abi.rst     |  6 ++
 include/linux/kexec_handover.h         | 27 +--------
 include/linux/kho/abi/kexec_handover.h | 78 ++++++++++++++++++++++++++
 include/linux/kho/abi/memfd.h          |  2 +-
 kernel/liveupdate/kexec_handover.c     | 15 -----
 lib/test_kho.c                         |  1 +
 6 files changed, 88 insertions(+), 41 deletions(-)

diff --git a/Documentation/core-api/kho/abi.rst b/Documentation/core-api/kho/abi.rst
index a1ee0f481727..1d9916adee23 100644
--- a/Documentation/core-api/kho/abi.rst
+++ b/Documentation/core-api/kho/abi.rst
@@ -10,6 +10,12 @@ Core Kexec Handover ABI
 .. kernel-doc:: include/linux/kho/abi/kexec_handover.h
    :doc: Kexec Handover ABI
 
+vmalloc preservation ABI
+========================
+
+.. kernel-doc:: include/linux/kho/abi/kexec_handover.h
+   :doc: Kexec Handover ABI for vmalloc Preservation
+
 See Also
 ========
 
diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 5f7b9de97e8d..a56ff3ffaf17 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -11,34 +11,11 @@ struct kho_scratch {
 	phys_addr_t size;
 };
 
+struct kho_vmalloc;
+
 struct folio;
 struct page;
 
-#define DECLARE_KHOSER_PTR(name, type) \
-	union {                        \
-		phys_addr_t phys;      \
-		type ptr;              \
-	} name
-#define KHOSER_STORE_PTR(dest, val)               \
-	({                                        \
-		typeof(val) v = val;              \
-		typecheck(typeof((dest).ptr), v); \
-		(dest).phys = virt_to_phys(v);    \
-	})
-#define KHOSER_LOAD_PTR(src)                                                 \
-	({                                                                   \
-		typeof(src) s = src;                                         \
-		(typeof((s).ptr))((s).phys ? phys_to_virt((s).phys) : NULL); \
-	})
-
-struct kho_vmalloc_chunk;
-struct kho_vmalloc {
-	DECLARE_KHOSER_PTR(first, struct kho_vmalloc_chunk *);
-	unsigned int total_pages;
-	unsigned short flags;
-	unsigned short order;
-};
-
 #ifdef CONFIG_KEXEC_HANDOVER
 bool kho_is_enabled(void);
 bool is_kho_boot(void);
diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/abi/kexec_handover.h
index af9fa8c134c7..285eda8a36e4 100644
--- a/include/linux/kho/abi/kexec_handover.h
+++ b/include/linux/kho/abi/kexec_handover.h
@@ -10,6 +10,8 @@
 #ifndef _LINUX_KHO_ABI_KEXEC_HANDOVER_H
 #define _LINUX_KHO_ABI_KEXEC_HANDOVER_H
 
+#include <linux/types.h>
+
 /**
  * DOC: Kexec Handover ABI
  *
@@ -82,4 +84,80 @@
 /* The FDT property for sub-FDTs. */
 #define KHO_FDT_SUB_TREE_PROP_NAME "fdt"
 
+/**
+ * DOC: Kexec Handover ABI for vmalloc Preservation
+ *
+ * The Kexec Handover ABI for preserving vmalloc'ed memory is defined by
+ * a set of structures and helper macros. The layout of these structures is a
+ * stable contract between kernels and is versioned by the KHO_FDT_COMPATIBLE
+ * string.
+ *
+ * The preservation is managed through a main descriptor &struct kho_vmalloc,
+ * which points to a linked list of &struct kho_vmalloc_chunk structures. These
+ * chunks contain the physical addresses of the preserved pages, allowing the
+ * next kernel to reconstruct the vmalloc area with the same content and layout.
+ * Helper macros are also defined for storing and loading pointers within
+ * these structures.
+ */
+
+/* Helper macro to define a union for a serializable pointer. */
+#define DECLARE_KHOSER_PTR(name, type)	\
+	union {                        \
+		u64 phys;              \
+		type ptr;              \
+	} name
+
+/* Stores the physical address of a serializable pointer. */
+#define KHOSER_STORE_PTR(dest, val)               \
+	({                                        \
+		typeof(val) v = val;              \
+		typecheck(typeof((dest).ptr), v); \
+		(dest).phys = virt_to_phys(v);    \
+	})
+
+/* Loads the stored physical address back to a pointer. */
+#define KHOSER_LOAD_PTR(src)						\
+	({                                                                   \
+		typeof(src) s = src;                                         \
+		(typeof((s).ptr))((s).phys ? phys_to_virt((s).phys) : NULL); \
+	})
+
+/*
+ * This header is embedded at the beginning of each `kho_vmalloc_chunk`
+ * and contains a pointer to the next chunk in the linked list,
+ * stored as a physical address for handover.
+ */
+struct kho_vmalloc_hdr {
+	DECLARE_KHOSER_PTR(next, struct kho_vmalloc_chunk *);
+};
+
+#define KHO_VMALLOC_SIZE				\
+	((PAGE_SIZE - sizeof(struct kho_vmalloc_hdr)) / \
+	 sizeof(u64))
+
+/*
+ * Each chunk is a single page and is part of a linked list that describes
+ * a preserved vmalloc area. It contains the header with the link to the next
+ * chunk and an array of physical addresses of the pages that make up the
+ * preserved vmalloc area.
+ */
+struct kho_vmalloc_chunk {
+	struct kho_vmalloc_hdr hdr;
+	u64 phys[KHO_VMALLOC_SIZE];
+};
+
+static_assert(sizeof(struct kho_vmalloc_chunk) == PAGE_SIZE);
+
+/*
+ * Describes a preserved vmalloc memory area, including the
+ * total number of pages, allocation flags, page order, and a pointer to the
+ * first chunk of physical page addresses.
+ */
+struct kho_vmalloc {
+	DECLARE_KHOSER_PTR(first, struct kho_vmalloc_chunk *);
+	unsigned int total_pages;
+	unsigned short flags;
+	unsigned short order;
+};
+
 #endif	/* _LINUX_KHO_ABI_KEXEC_HANDOVER_H */
diff --git a/include/linux/kho/abi/memfd.h b/include/linux/kho/abi/memfd.h
index c211c31334a3..68cb6303b846 100644
--- a/include/linux/kho/abi/memfd.h
+++ b/include/linux/kho/abi/memfd.h
@@ -12,7 +12,7 @@
 #define _LINUX_KHO_ABI_MEMFD_H
 
 #include <linux/types.h>
-#include <linux/kexec_handover.h>
+#include <linux/kho/abi/kexec_handover.h>
 
 /**
  * DOC: memfd Live Update ABI
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index d3d02a9ea391..a180b3367e8f 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -882,21 +882,6 @@ void kho_unpreserve_pages(struct page *page, unsigned int nr_pages)
 }
 EXPORT_SYMBOL_GPL(kho_unpreserve_pages);
 
-struct kho_vmalloc_hdr {
-	DECLARE_KHOSER_PTR(next, struct kho_vmalloc_chunk *);
-};
-
-#define KHO_VMALLOC_SIZE				\
-	((PAGE_SIZE - sizeof(struct kho_vmalloc_hdr)) / \
-	 sizeof(phys_addr_t))
-
-struct kho_vmalloc_chunk {
-	struct kho_vmalloc_hdr hdr;
-	phys_addr_t phys[KHO_VMALLOC_SIZE];
-};
-
-static_assert(sizeof(struct kho_vmalloc_chunk) == PAGE_SIZE);
-
 /* vmalloc flags KHO supports */
 #define KHO_VMALLOC_SUPPORTED_FLAGS	(VM_ALLOC | VM_ALLOW_HUGE_VMAP)
 
diff --git a/lib/test_kho.c b/lib/test_kho.c
index 47de56280795..3431daca6968 100644
--- a/lib/test_kho.c
+++ b/lib/test_kho.c
@@ -19,6 +19,7 @@
 #include <linux/printk.h>
 #include <linux/vmalloc.h>
 #include <linux/kexec_handover.h>
+#include <linux/kho/abi/kexec_handover.h>
 
 #include <net/checksum.h>
 
-- 
2.51.0


