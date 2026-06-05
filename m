Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 430C8CD6E6B
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 03:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=burVgKt+U0bNdZ+S4i+8PCamSBgPUcyGmVaC5AfN7II=; b=WCtmal9lLIbkHzuL4YilcCH4aK
	9eZrCDfwZmbiF/n91mr+X9KJXm0kUiewL+vRzmEZfplwpRvtwlhXV/Cy17ncdK5SCqqCEygO7sdmv
	5bF20D7+tgEjoptBLmXQdq1ujwt+rwfmx8AuJz0P9hwb8ZSlXDjBKhUEoxxqlatcTuKKqC//iud+M
	1xmxnQsc+2s1ASX5kM2zRQ1WCcOB7dn0c1OOK5f6VqiMMbeJ6SDg5Io9znhMOmz3TZYAk0SNh/icg
	2YgU3/2TMOC8Wk88vhXw3NIqhV87Tvt9KrYnF+G7GJXJLRSeTJ9Rjfpy9YleTXeTIG2lXFCm1Dj1D
	db70Gy2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVLJI-0000000025X-12mL;
	Fri, 05 Jun 2026 03:33:28 +0000
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVLJF-0000000024n-2Kch
	for kexec@lists.infradead.org;
	Fri, 05 Jun 2026 03:33:26 +0000
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-8cc0ef7c306so12836086d6.3
        for <kexec@lists.infradead.org>; Thu, 04 Jun 2026 20:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780630404; x=1781235204; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=burVgKt+U0bNdZ+S4i+8PCamSBgPUcyGmVaC5AfN7II=;
        b=Bt3SwN5irT5p30dftemGmH82daBxy5tsHJENGc6wjS5DUQIa6NuCC6CTvclOycpTvY
         4v0M3aWJR1FW10QEKRAe0wus5gew6MMMko0M6z6s47KAWXXfV9MZOE/uptxrItwo3p0N
         F5BEsQS+zD5DCZFHs0SaYwldPijFeid60WdHKnREz5OgpU7YQks0KLoRXwgJSVGf/ndP
         ChESZZsgMCvGu1yiz5rXClZQ0yVU/VrXA458Cd3ZolXNlxYSNjFqwUFfaBNRp+uTaxJ0
         qcig4a3KRfMhZ05hA5Qr+ZojNWb6iGXgtbkpSEz1wUqsL6vXIZM5P/5S06+Ts0MrFNG1
         pnxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780630404; x=1781235204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=burVgKt+U0bNdZ+S4i+8PCamSBgPUcyGmVaC5AfN7II=;
        b=sjS9N2WJ+mhycf17Otxsp7PIafMY2WRIs7sBTmZqNfiEf3/bRvK3HPSy+fas/192+/
         8poQLi1dXHHf9LDvI52YZ/v2n1B0OgV2kDFXrvgkSBDzmyWDcU//TnAjsL15SVHJC3pl
         XiUTW3PuLvXdoU2aTwjeoe7juYLNnOolFb9bZYe8lyMKNAvgUQSoHfVY+l2/to8AV/TN
         0V5Vm+yJwIvd/IgXUx/BXU3rvUTaOyhr45K8Ut5A1HvgTLwor/MpeD+21qjGyQYCqf1o
         7iuuE5az5IItRCEDJeSf1nMAFsm74/Fnon/EjtzwN03Ddk4odfdvdlR6/2WN0e7AI1DH
         lCLA==
X-Forwarded-Encrypted: i=1; AFNElJ8GzyRasnwDLBZi5XLSJpAZrQDngtP58Uz+IAhPJBEWs6396QHRPX+6YVkqZTIoKoaEbT6QxQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwPZZnxp8j9PBk+beR3AHY+sZ2wr73O/rdeZwlA7xxxW3u4GGhd
	Yb8VnpfCmtMpLW5/TCKAKmxRqiIy4h3KwSGpxpNCvqnkf66ZwkPRCmdzJBnGK6HiwoU=
X-Gm-Gg: Acq92OFR7EL8p/6Bj22+UfquWsiXcSO9JtJSPqKwA35hlJgybFfzGq1tzeXTVn40WsA
	FSoU0ZnbekwDlX3SDipQ10hd3F9eCF3Swocenneg+PWzdwkoY31qwWZ/1EcOdhAO4F8S4z2qS1/
	/oLslkmqqK5epTKKBtLp1hsxmtebABBQ/Nlcp58BV3DP4zjpsfjuOmVbH7FzuquuL+YTHj6cJGj
	FQgT4TcdrYmoktw5b/9FavVEMQi87Vv9Wp8iW/czVBR6GbeBsECLE5ijlPKRb6yDHtpTrysjuRs
	DWzAzkUUsqrSvu/RMF2WdIj6/rACAkLI/736zPahrnrGQ3WmHbEWCx1kZHDhl8pO2USX4ER/yda
	uKyUeCOYx2aoRHUmLKv6IdUkyACYtNo5lA+dKkv2X8DjRoLPdmctj3Fymz124BLOC2Zn7z5mPHU
	4tqq56R+dLQbt1Mgt0T3enHUayYzZD/ui3DE2gfcJZbPnDY5oDKwNkfgXlHkNLPIDTqeBLTRgI
X-Received: by 2002:a05:6214:2d07:b0:8cc:f882:2562 with SMTP id 6a1803df08f44-8cee61497cdmr30262576d6.39.1780630404187;
        Thu, 04 Jun 2026 20:33:24 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd263003sm71383816d6.42.2026.06.04.20.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 20:33:23 -0700 (PDT)
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
Subject: [RFC v1 4/9] kho: split vmalloc headers out of kexec_handover.h
Date: Fri,  5 Jun 2026 03:32:30 +0000
Message-ID: <20260605033235.717351-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605033235.717351-1-pasha.tatashin@soleen.com>
References: <20260605033235.717351-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260604_203325_626698_BFD92F12 
X-CRM114-Status: GOOD (  26.96  )
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

Split the vmalloc-related ABI definitions and header declarations out
of the monolithic kexec_handover.h header into a dedicated header
file (vmalloc.h).

This is a pure code movement patch; no logic or functional changes are
introduced.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 Documentation/core-api/kho/abi.rst     |  3 +-
 include/linux/kexec_handover.h         | 18 -----
 include/linux/kho/abi/kexec_handover.h | 77 +-------------------
 include/linux/kho/abi/memfd.h          |  3 +-
 include/linux/kho/abi/vmalloc.h        | 99 ++++++++++++++++++++++++++
 include/linux/kho/vmalloc.h            | 34 +++++++++
 6 files changed, 137 insertions(+), 97 deletions(-)
 create mode 100644 include/linux/kho/abi/vmalloc.h
 create mode 100644 include/linux/kho/vmalloc.h

diff --git a/Documentation/core-api/kho/abi.rst b/Documentation/core-api/kho/abi.rst
index da5c6636bb17..b61363679829 100644
--- a/Documentation/core-api/kho/abi.rst
+++ b/Documentation/core-api/kho/abi.rst
@@ -13,8 +13,7 @@ Core Kexec Handover ABI
 vmalloc preservation ABI
 ========================
 
-.. kernel-doc:: include/linux/kho/abi/kexec_handover.h
-   :doc: Kexec Handover ABI for vmalloc Preservation
+.. kernel-doc:: include/linux/kho/abi/vmalloc.h
 
 memblock preservation ABI
 =========================
diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 8968c56d2d73..518fdab2a4d1 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -11,8 +11,6 @@ struct kho_scratch {
 	phys_addr_t size;
 };
 
-struct kho_vmalloc;
-
 struct folio;
 struct page;
 
@@ -24,14 +22,11 @@ int kho_preserve_folio(struct folio *folio);
 void kho_unpreserve_folio(struct folio *folio);
 int kho_preserve_pages(struct page *page, unsigned long nr_pages);
 void kho_unpreserve_pages(struct page *page, unsigned long nr_pages);
-int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation);
-void kho_unpreserve_vmalloc(struct kho_vmalloc *preservation);
 void *kho_alloc_preserve(size_t size);
 void kho_unpreserve_free(void *mem);
 void kho_restore_free(void *mem);
 struct folio *kho_restore_folio(phys_addr_t phys);
 struct page *kho_restore_pages(phys_addr_t phys, unsigned long nr_pages);
-void *kho_restore_vmalloc(const struct kho_vmalloc *preservation);
 int kho_add_subtree(const char *name, void *blob, size_t size);
 void kho_remove_subtree(void *blob);
 int kho_retrieve_subtree(const char *name, phys_addr_t *phys, size_t *size);
@@ -65,14 +60,6 @@ static inline int kho_preserve_pages(struct page *page, unsigned int nr_pages)
 
 static inline void kho_unpreserve_pages(struct page *page, unsigned int nr_pages) { }
 
-static inline int kho_preserve_vmalloc(void *ptr,
-				       struct kho_vmalloc *preservation)
-{
-	return -EOPNOTSUPP;
-}
-
-static inline void kho_unpreserve_vmalloc(struct kho_vmalloc *preservation) { }
-
 static inline void *kho_alloc_preserve(size_t size)
 {
 	return ERR_PTR(-EOPNOTSUPP);
@@ -92,11 +79,6 @@ static inline struct page *kho_restore_pages(phys_addr_t phys,
 	return NULL;
 }
 
-static inline void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
-{
-	return NULL;
-}
-
 static inline int kho_add_subtree(const char *name, void *blob, size_t size)
 {
 	return -EOPNOTSUPP;
diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/abi/kexec_handover.h
index 99e4a53d4e35..c893b5045078 100644
--- a/include/linux/kho/abi/kexec_handover.h
+++ b/include/linux/kho/abi/kexec_handover.h
@@ -96,80 +96,5 @@
 /* The FDT property for the size of preserved data blobs. */
 #define KHO_SUB_TREE_SIZE_PROP_NAME "blob-size"
 
-/**
- * DOC: Kexec Handover ABI for vmalloc Preservation
- *
- * The Kexec Handover ABI for preserving vmalloc'ed memory is defined by
- * a set of structures and helper macros. The layout of these structures is a
- * stable contract between kernels and is versioned by the KHO_FDT_COMPATIBLE
- * string.
- *
- * The preservation is managed through a main descriptor &struct kho_vmalloc,
- * which points to a linked list of &struct kho_vmalloc_chunk structures. These
- * chunks contain the physical addresses of the preserved pages, allowing the
- * next kernel to reconstruct the vmalloc area with the same content and layout.
- * Helper macros are also defined for storing and loading pointers within
- * these structures.
- */
-
-/* Helper macro to define a union for a serializable pointer. */
-#define DECLARE_KHOSER_PTR(name, type)	\
-	union {                        \
-		u64 phys;              \
-		type ptr;              \
-	} name
-
-/* Stores the physical address of a serializable pointer. */
-#define KHOSER_STORE_PTR(dest, val)               \
-	({                                        \
-		typeof(val) v = val;              \
-		typecheck(typeof((dest).ptr), v); \
-		(dest).phys = virt_to_phys(v);    \
-	})
-
-/* Loads the stored physical address back to a pointer. */
-#define KHOSER_LOAD_PTR(src)						\
-	({                                                                   \
-		typeof(src) s = src;                                         \
-		(typeof((s).ptr))((s).phys ? phys_to_virt((s).phys) : NULL); \
-	})
-
-/*
- * This header is embedded at the beginning of each `kho_vmalloc_chunk`
- * and contains a pointer to the next chunk in the linked list,
- * stored as a physical address for handover.
- */
-struct kho_vmalloc_hdr {
-	DECLARE_KHOSER_PTR(next, struct kho_vmalloc_chunk *);
-};
-
-#define KHO_VMALLOC_SIZE				\
-	((PAGE_SIZE - sizeof(struct kho_vmalloc_hdr)) / \
-	 sizeof(u64))
-
-/*
- * Each chunk is a single page and is part of a linked list that describes
- * a preserved vmalloc area. It contains the header with the link to the next
- * chunk and a zero terminated array of physical addresses of the pages that
- * make up the preserved vmalloc area.
- */
-struct kho_vmalloc_chunk {
-	struct kho_vmalloc_hdr hdr;
-	u64 phys[KHO_VMALLOC_SIZE];
-};
-
-static_assert(sizeof(struct kho_vmalloc_chunk) == PAGE_SIZE);
-
-/*
- * Describes a preserved vmalloc memory area, including the
- * total number of pages, allocation flags, page order, and a pointer to the
- * first chunk of physical page addresses.
- */
-struct kho_vmalloc {
-	DECLARE_KHOSER_PTR(first, struct kho_vmalloc_chunk *);
-	unsigned int total_pages;
-	unsigned short flags;
-	unsigned short order;
-};
-
 #endif	/* _LINUX_KHO_ABI_KEXEC_HANDOVER_H */
+
diff --git a/include/linux/kho/abi/memfd.h b/include/linux/kho/abi/memfd.h
index 08b10fea2afc..af310c0c9fdf 100644
--- a/include/linux/kho/abi/memfd.h
+++ b/include/linux/kho/abi/memfd.h
@@ -11,8 +11,9 @@
 #ifndef _LINUX_KHO_ABI_MEMFD_H
 #define _LINUX_KHO_ABI_MEMFD_H
 
-#include <linux/types.h>
 #include <linux/kho/abi/kexec_handover.h>
+#include <linux/kho/abi/vmalloc.h>
+#include <linux/types.h>
 
 /**
  * DOC: memfd Live Update ABI
diff --git a/include/linux/kho/abi/vmalloc.h b/include/linux/kho/abi/vmalloc.h
new file mode 100644
index 000000000000..87650e1dd774
--- /dev/null
+++ b/include/linux/kho/abi/vmalloc.h
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2025 Microsoft Corporation, Mike Rapoport <rppt@kernel.org>
+ * Copyright (C) 2025 Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+/**
+ * DOC: Kexec Handover ABI for vmalloc Preservation
+ *
+ * The Kexec Handover ABI for preserving vmalloc'ed memory is defined by
+ * a set of structures and helper macros. The layout of these structures is a
+ * stable contract between kernels and is versioned by the KHO_FDT_COMPATIBLE
+ * string.
+ *
+ * This interface is a contract. Any modification to the structure fields,
+ * compatible strings, or the layout of the serialization structures defined
+ * here constitutes a breaking change. Such changes require incrementing the
+ * version number in the `KHO_FDT_COMPATIBLE` string to prevent a new kernel
+ * from misinterpreting data from an old kernel.
+ *
+ * Changes are allowed provided the compatibility version is incremented;
+ * however, backward/forward compatibility is only guaranteed for kernels
+ * supporting the same ABI version.
+ *
+ * The preservation is managed through a main descriptor &struct kho_vmalloc,
+ * which points to a linked list of &struct kho_vmalloc_chunk structures. These
+ * chunks contain the physical addresses of the preserved pages, allowing the
+ * next kernel to reconstruct the vmalloc area with the same content and layout.
+ * Helper macros are also defined for storing and loading pointers within
+ * these structures.
+ */
+
+#ifndef _LINUX_KHO_ABI_VMALLOC_H
+#define _LINUX_KHO_ABI_VMALLOC_H
+
+#include <linux/types.h>
+#include <asm/page.h>
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
+ * chunk and a zero terminated array of physical addresses of the pages that
+ * make up the preserved vmalloc area.
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
+#endif /* _LINUX_KHO_ABI_VMALLOC_H */
diff --git a/include/linux/kho/vmalloc.h b/include/linux/kho/vmalloc.h
new file mode 100644
index 000000000000..2d1b5d282a93
--- /dev/null
+++ b/include/linux/kho/vmalloc.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_KHO_VMALLOC_H
+#define _LINUX_KHO_VMALLOC_H
+
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/kho/abi/vmalloc.h>
+
+struct page;
+
+#ifdef CONFIG_KEXEC_HANDOVER
+
+int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation);
+void kho_unpreserve_vmalloc(struct kho_vmalloc *preservation);
+void *kho_restore_vmalloc(const struct kho_vmalloc *preservation);
+
+#else /* CONFIG_KEXEC_HANDOVER */
+
+static inline int kho_preserve_vmalloc(void *ptr,
+				       struct kho_vmalloc *preservation)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void kho_unpreserve_vmalloc(struct kho_vmalloc *preservation) { }
+
+static inline void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
+{
+	return NULL;
+}
+
+#endif /* CONFIG_KEXEC_HANDOVER */
+
+#endif /* _LINUX_KHO_VMALLOC_H */
-- 
2.53.0


