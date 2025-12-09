Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A865BD3B7FB
	for <kexec@archiver.kernel.org>; Tue,  9 Dec 2025 02:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:From:Subject
	:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7YniVUU6/+lQD/EVhfTXqpFE+9KZzpnPEHhqtMsCQi8=; b=O8KyeraQl/mu2av/yTwEGGfaNv
	pVOW7G/tsyZbsQaYm3Z0fP2G3gFxkLX60PY+qXXZIjudmWXQ3s6orsVj24vhAf2n8QfGpGNpB+T18
	4aoDh7JYfpx19n4OLarmQjPysOkKi9FeqQXAehSZvZr/kTzsyBgdBxCbXlb+TTVbSCn8BofUya6W0
	ned85i1KfiqmZxtyxb0Hd1LuDDX7DpAUunAcHaqWU/O07DQFol/R59uQJUTpFbu+dXCVMH5OmZIwd
	kzAsyYHQ8EouABrDcL6A5x1teNbUGLNND36nzq5xvcdiEWxK56j6D55dKrggDXtUibccFGAFLz8XN
	6Addb/SQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSnr0-0000000DkZ5-0HaU;
	Tue, 09 Dec 2025 02:53:30 +0000
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSnqx-0000000DkWv-0pFl
	for kexec@lists.infradead.org;
	Tue, 09 Dec 2025 02:53:28 +0000
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-b9b9e8b0812so7880640a12.0
        for <kexec@lists.infradead.org>; Mon, 08 Dec 2025 18:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765248806; x=1765853606; darn=lists.infradead.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7YniVUU6/+lQD/EVhfTXqpFE+9KZzpnPEHhqtMsCQi8=;
        b=CUyfXdjFs6idgP6YeixP6nXdOXvAlvXZxjId2RHl035KhFjXTcG5VTeCL8o8GUCsUK
         htCJxUBIjBe78EKcMkd6zct4DJ+x5KG+YQyrKidQHwP7nayRzpkQexeQ/wUyQ3kdU80p
         oqGYN9/xsE5vCyZ0JPcNrUgIgiqbyF+EPIp+xQXZjq9XtfWlHS/wA6TLP0In2xxSzuMS
         rIb4Ak6b6r9eD0qN4+qt8l14sROaO1cuNlHEYMo2XFqg6LhuLUykJs3mk+3OfDh2JHvj
         TW8aPNwLRylLcrPn8yUYR35fJSLOQUaYoxwODkYhG7XKSF2sedmLqrbiyUH19f0SB8+N
         mDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765248806; x=1765853606;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7YniVUU6/+lQD/EVhfTXqpFE+9KZzpnPEHhqtMsCQi8=;
        b=Fz1oush5GEYzrvWi/8d2P4NaGyjDPx5CZm4t2dqDu4RXb/clqhXATGQMnMgw4tUK/c
         aDT3Q6A1ZNvHCRdNF7jEK/sU1UE0lTjqZa7A2w+ZfCg4eSpuTigEt9O+ioyVz/frGjJ5
         qL4SXEoeiADdCDABWpnml7tVdF/G4CGEBPXzp5aGJtzUokaiBr+BHdOBVyhCkjhGrNhX
         oim4d9dGUwM4GOkkqpLH4i9ZJJVvqIuCdI01aJT4ITAmL+rPEhiKWewbGJQ/PIWo96lB
         XWb2/0XIwOfJMWr2h7uiedT4yzUmEH6VDJDvb2ILlW1odn7IV8dklF+w38EV00xBOjUz
         9CHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsMfm4MH8obTcPqVS88njuoWNtpS7xja3U3sgXynq8rExRrDuqeI8kDmmOcOpBTh4fqXjpDg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxI4kXdsX2p8vaZ+YOO0W9KgxTdOyyhe6cD9hnzYgZeJoPDcEqg
	ybc0GSS6eIICPxQaistAUMRyzWXa6y3ZrlM5/YdvnocDaFu3szvMdPIAiTxXvxTOXVN0DXYysbg
	N/ngkQjZP/LkfIA==
X-Google-Smtp-Source: AGHT+IEE2+RzFDmhYi3sZJMC5POuF7uEYIA0RYOQQ5LbZQGlmWpKy+l52MCfZMJi+695a5er1FB0tS6NzuXitg==
X-Received: from dychz10.prod.google.com ([2002:a05:7301:860a:b0:2a4:7a56:1730])
 (user=jasonmiu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:6589:b0:2a4:3594:72d7 with SMTP id 5a478bee46e88-2abc710d8f1mr7325213eec.6.1765248806192;
 Mon, 08 Dec 2025 18:53:26 -0800 (PST)
Date: Mon,  8 Dec 2025 18:53:14 -0800
In-Reply-To: <20251209025317.3846938-1-jasonmiu@google.com>
Mime-Version: 1.0
References: <20251209025317.3846938-1-jasonmiu@google.com>
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251209025317.3846938-3-jasonmiu@google.com>
Subject: [PATCH v3 2/4] kho: Relocate vmalloc preservation structure to KHO
 ABI header
From: Jason Miu <jasonmiu@google.com>
To: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Miu <jasonmiu@google.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251208_185327_236933_ACCF1C61 
X-CRM114-Status: GOOD (  20.72  )
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
---
 Documentation/core-api/kho/fdt.rst     |  6 ++
 include/linux/kexec_handover.h         | 27 +--------
 include/linux/kho/abi/kexec_handover.h | 78 ++++++++++++++++++++++++++
 include/linux/kho/abi/memfd.h          |  2 +-
 kernel/liveupdate/kexec_handover.c     | 15 -----
 lib/test_kho.c                         |  1 +
 6 files changed, 88 insertions(+), 41 deletions(-)

diff --git a/Documentation/core-api/kho/fdt.rst b/Documentation/core-api/kho/fdt.rst
index 4e080ccc420e..4202b67fcdf9 100644
--- a/Documentation/core-api/kho/fdt.rst
+++ b/Documentation/core-api/kho/fdt.rst
@@ -14,6 +14,12 @@ directly in the ABI header file.
 .. kernel-doc:: include/linux/kho/abi/kexec_handover.h
    :doc: Kexec Handover ABI
 
+Kexec Handover ABI for vmalloc Preservation
+===========================================
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
index d78df2d44cb6..74f4fa67e458 100644
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
@@ -81,4 +83,80 @@
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
+ * The preservation is managed through a main descriptor struct (`kho_vmalloc`),
+ * which points to a linked list of `kho_vmalloc_chunk` structures. These
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
index da7d063474a1..1af4c9dc5a06 100644
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
2.52.0.223.gf5cc29aaa4-goog


