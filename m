Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E6C606A324
	for <kexec@archiver.kernel.org>; Sun, 25 Oct 2026 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HFMrOH07;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=V3wEZsVG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Cd4NBiUaZHjhgQI6f1triFkm5VKVfeLrpjHZ+ms4srE=; b=HFMrOH075g0Bqz
	lAWs+NXTmEpvrDkDRJ7lT0Bz19CAmSXuYS7Rb+v5ecBV6KX4drsQqyC6ePgbsSzQKDrJ6HNjotFbZ
	qNywlf9Ok72BXLWMK7y+utA8M8ynfTlUiW+rV13JCRoB51KJIaDTze/xJDdBPNaRWvNUKyybkCNTJ
	LwItRzsrjXvjQm6QUr3koKOpaJrjfYInJxmoH426qhYCgrNfDB4DjqjFZzo3rru26NG0Lqgd4gd1L
	6f8MAFgoraHJh+YsWIP73/x8CL2ByEoBrlSmKP5uRaPzaylkTsq0WaJfdT0fPdsfdPDjE7iC5ZaQv
	0m4UX4Xezch6yselG/GA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL2Ct-00000001Eyl-0rfq;
	Sun, 25 Oct 2026 17:40:31 +0000
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL2Cp-00000001Esz-2NuV
	for kexec@lists.infradead.org;
	Sun, 25 Oct 2026 17:40:29 +0000
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-5eabf7d5bbeso2386680e0c.1
        for <kexec@lists.infradead.org>; Sun, 25 Oct 2026 10:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792950026; x=1793554826; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Cd4NBiUaZHjhgQI6f1triFkm5VKVfeLrpjHZ+ms4srE=;
        b=V3wEZsVGfTawUOeoYyLsoSy8TSatCoVc+27M+2fsFlBYwj2IqVoA9RRTI7AgKWY6qD
         GGhTy8g3Dpv5VMzt+bsoxwimjhiun3u4Us8rhJ+IqCRG1v08wGdzY1LNSEGX12jl1vV0
         lDYb9fV92aN51k+OSPBv0lR9H2sMqvaf+tD8ZuoWVPsU86SMOTr8BQNwBxQ+95U7dxaC
         /Yk7As8KJbDBJ7XEJ0VbR8isou19Mtp0pwAJFB0s5igALJz7N8zr4xKkaLWxBSN6HrWO
         UFAn5QcbA8uPe+bOjADEpYht4WuKjvYcQe4DJ9+5wtavYryLywhJ6Q4R9KfDzeaWwQbq
         sd/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792950026; x=1793554826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Cd4NBiUaZHjhgQI6f1triFkm5VKVfeLrpjHZ+ms4srE=;
        b=WzWqnGniHY589K18ndr3Z+gnVHPLSF2BC1wCNHhjJUFdw5XgnlPtgu7+WcYNQQGvww
         9NXJa6eAznIDZtEgFgxH7jSzNhsYgDtvXXsVnxvjIDGI7TlJHT3+o7gCmBfHNJpE86kp
         24WEeoNM8s1GQGQjXIJyDaHRoXsVaIkgutgsMgXddgZvg/s3bLfuFC0tpHd4xZxl0gTk
         N3lhwvcvkXYlHb605qSSlaM+oa8C4V9QVNkbeqZrqZSwtFmMupnY5/gzoWLq0nIRrUBS
         +iS+7C+sl3vTxp/uOXLlR7kmL1Gm6wPM7n8gTRA6jn404YC674TYeAw2kWgjnB48thro
         dQ7g==
X-Forwarded-Encrypted: i=1; AKwUvBx2/0Iknjrh0WCULmzxq7AN3EMBqICuOD2TzsQZ2ks1jQYA8Sgvt6nsgTne27LMTUEv1K6vXw==@lists.infradead.org
X-Gm-Message-State: AFq9FYLqIYSdfnWHg4iTgIcdbS7Hw+kbSmNL3tDljuLji7TIJVnoPAVN
	iv8vTKFn+2MROsE2G10JnzTSxr5yhKjLQ66eJhXbvhZwEyzN5Qhnd7yWDj1lsMsWLSM=
X-Gm-Gg: AYBFou1QxK5ISaI9zbPnnaLvZGuw7awG83vIF46TVsq8Qy6N4ioVGwHHnVJSaooR/+c
	nVsiUU5XFUuZlKyV9R8xk6jRh2TZnYbNf8D0C+BpeStrxdzvLkBI+SLe87NzaitfQ5cAk0ctfru
	qPPQxKctYMNX5qkjlcSvja2Yl6uGfY9po5jYwqLyh1PHpHGqCmAu1irhACob1nVU+wG1ZRA79Gs
	SlHAdKVfS9qIAdY7fuQhtV+73x8Lvp7iOAuX0BWhIwGJtNo8ngWnfg42T4I2YeCMG6EdnW7R2uw
	qFzex5ysg9hK7UJrsUtWPr0xNH8biVb4ddWvCP0MOkRChOmgqOeI7H01ZgYWGfKyuaI3OJRC31p
	dKlCcA9U4ISV/MKfcWbUbloWpDAZWjbPTlZZvYDCN9Ft2Tz5VISeiDxZvWSyNyKvNzY4tdIPqxa
	4XQpFOWPEt8yKfDTESMkEQCIRCZyODD1Mzz+wmxCEjBKapT1OZtQ1m82uTbgk1RXa4mV5eEZAOo
	vomCs6QA5GxTYBcPxiznFf8VwLZCLy5q1bzq3/NDEMNDl1gnzSkWeWkKDr/fG6jMc3MloI5YjGV
	/QKEAVQ7p56K1IjuzuddwdkLVWPmC+U1JWdMXjU+lrDX3bFn8YTreFFvPCtUG5zK/Eyyfnw9QGv
	9
X-Received: by 2002:a05:6122:78b:b0:5ea:c874:6c4 with SMTP id 71dfb90a1353d-5ec232c784dmr1663615e0c.16.1792950026456;
        Sun, 25 Oct 2026 10:40:26 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec234673ebsm5783333e0c.13.2026.10.25.10.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 10:40:26 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	kuba@kernel.org,
	enelsonmoore@gmail.com,
	bp@alien8.de,
	shuah@kernel.org,
	david@kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	mhocko@suse.com,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	vbabka@kernel.org,
	dapeng1.mi@linux.intel.com,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	surenb@google.com,
	pasha.tatashin@soleen.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	elver@google.com,
	graf@amazon.com,
	lirongqing@baidu.com,
	liam@infradead.org,
	jlayton@kernel.org
Subject: [PATCH v2 5/9] kho: add read-only Kexec Handover mode
Date: Sun, 25 Oct 2026 13:40:12 -0400
Message-ID: <20261025174017.3870481-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
In-Reply-To: <20261025174017.3870481-1-pasha.tatashin@soleen.com>
References: <20261025174017.3870481-1-pasha.tatashin@soleen.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261025_104027_719325_F8BA9767 
X-CRM114-Status: GOOD (  25.86  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Kernels that inspect preserved KHO state without taking ownership of
preserved memory need a way to traverse the KHO FDT, radix tree, and
vmalloc chains in place while leaving the underlying physical pages and
metadata unmodified.

Add CONFIG_KEXEC_HANDOVER_READONLY and the 'kho_ro=<pa>' kernel
command-line parameter so both regular KHO and read-only KHO can be
compiled into the same kernel image and activated via the command line.
Map and validate the incoming KHO FDT once in an early_initcall, and
cache radix-tree node, leaf, folio, and vmalloc mappings in a unified
RCU-protected hash table (kho_ro_map_ht) for the lifetime of the
read-only KHO kernel.

Also export kho_is_ro(), kho_ro_lookup_folio_order(),
kho_ro_map_folio(), and kho_ro_map_vmalloc() so callers can check if
read-only KHO mode is active and map preserved folios and vmalloc
regions verified against the KHO radix tree.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 .../admin-guide/kernel-parameters.txt         |   8 +
 Documentation/core-api/kho/index.rst          |   3 +
 include/linux/kexec_handover.h                |  44 +-
 kernel/liveupdate/Kconfig                     |  10 +
 kernel/liveupdate/Makefile                    |   1 +
 kernel/liveupdate/kexec_handover_internal.h   |  13 +
 kernel/liveupdate/kexec_handover_ro.c         | 429 ++++++++++++++++++
 7 files changed, 501 insertions(+), 7 deletions(-)
 create mode 100644 kernel/liveupdate/kexec_handover_ro.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3b89b54db550..887a4b14cf40 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3051,6 +3051,14 @@ Kernel parameters
 			bootmem areas.  The form "nn%" defines scale factor
 			(in percents) of memory that was used during boot.
 
+	kho_ro=		[KEXEC,EARLY]
+			Format: <phys_addr>
+			Enables read-only Kexec HandOver mode, pointing to the
+			page-aligned physical address of a preserved KHO FDT
+			blob, and disables regular KHO. The FDT and preserved
+			memory must not be part of this kernel's System RAM.
+			Requires CONFIG_KEXEC_HANDOVER_READONLY.
+
 	kmac=		[MIPS] Korina ethernet MAC address.
 			Configure the RouterBoard 532 series on-chip
 			Ethernet adapter MAC address.
diff --git a/Documentation/core-api/kho/index.rst b/Documentation/core-api/kho/index.rst
index bce7fe281194..803e5dfc3caf 100644
--- a/Documentation/core-api/kho/index.rst
+++ b/Documentation/core-api/kho/index.rst
@@ -86,6 +86,9 @@ Public API
 .. kernel-doc:: kernel/liveupdate/kexec_handover_common.c
   :export:
 
+.. kernel-doc:: kernel/liveupdate/kexec_handover_ro.c
+  :export:
+
 KHO Serialization Blocks API
 ============================
 
diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index ef2b188c8ed0..bdb8dc3c3f54 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -13,6 +13,43 @@ struct kho_vmalloc;
 struct folio;
 struct page;
 
+#if defined(CONFIG_KEXEC_HANDOVER) || defined(CONFIG_KEXEC_HANDOVER_READONLY)
+int kho_retrieve_subtree(const char *name, phys_addr_t *phys, size_t *size);
+#else
+static inline int kho_retrieve_subtree(const char *name, phys_addr_t *phys,
+				       size_t *size)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_KEXEC_HANDOVER || CONFIG_KEXEC_HANDOVER_READONLY */
+
+#ifdef CONFIG_KEXEC_HANDOVER_READONLY
+bool kho_is_ro(void);
+int kho_ro_lookup_folio_order(phys_addr_t pa);
+void *kho_ro_map_folio(phys_addr_t pa, pgprot_t prot);
+const void *kho_ro_map_vmalloc(const struct kho_vmalloc *preservation);
+#else
+static inline bool kho_is_ro(void)
+{
+	return false;
+}
+
+static inline int kho_ro_lookup_folio_order(phys_addr_t pa)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void *kho_ro_map_folio(phys_addr_t pa, pgprot_t prot)
+{
+	return NULL;
+}
+
+static inline const void *kho_ro_map_vmalloc(const struct kho_vmalloc *preservation)
+{
+	return NULL;
+}
+#endif /* CONFIG_KEXEC_HANDOVER_READONLY */
+
 #ifdef CONFIG_KEXEC_HANDOVER
 bool kho_is_enabled(void);
 bool is_kho_boot(void);
@@ -31,7 +68,6 @@ struct page *kho_restore_pages(phys_addr_t phys, unsigned long nr_pages);
 void *kho_restore_vmalloc(const struct kho_vmalloc *preservation);
 int kho_add_subtree(const char *name, void *blob, size_t size);
 void kho_remove_subtree(void *blob);
-int kho_retrieve_subtree(const char *name, phys_addr_t *phys, size_t *size);
 
 void kho_memory_init(void);
 void kho_memory_init_early(void);
@@ -112,12 +148,6 @@ static inline int kho_add_subtree(const char *name, void *blob, size_t size)
 
 static inline void kho_remove_subtree(void *blob) { }
 
-static inline int kho_retrieve_subtree(const char *name, phys_addr_t *phys,
-				       size_t *size)
-{
-	return -EOPNOTSUPP;
-}
-
 static inline void kho_memory_init(void) { }
 
 static inline void kho_memory_init_early(void) { }
diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
index f50daee8eff0..d633e4c9197d 100644
--- a/kernel/liveupdate/Kconfig
+++ b/kernel/liveupdate/Kconfig
@@ -48,6 +48,16 @@ config KEXEC_HANDOVER_ENABLE_DEFAULT
 	  The default behavior can still be overridden at boot time by
 	  passing 'kho=off'.
 
+config KEXEC_HANDOVER_READONLY
+	bool "Read-only kexec handover"
+	depends on ARCH_SUPPORTS_KEXEC_HANDOVER
+	select LIBFDT
+	help
+	  Enable read-only Kexec Handover ('kho_ro=<pa>'). This allows a
+	  kernel to traverse preserved KHO subtrees, radix trees, and
+	  metadata by mapping them in place without taking ownership of
+	  or modifying the preserved KHO state.
+
 config LIVEUPDATE
 	bool "Live Update Orchestrator"
 	depends on KEXEC_HANDOVER
diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
index f6bed6bcd380..74a584e6bb43 100644
--- a/kernel/liveupdate/Makefile
+++ b/kernel/liveupdate/Makefile
@@ -8,6 +8,7 @@ luo-y :=								\
 		luo_session.o
 
 obj-$(CONFIG_KEXEC_HANDOVER)		+= kexec_handover.o kexec_handover_common.o
+obj-$(CONFIG_KEXEC_HANDOVER_READONLY)	+= kexec_handover_ro.o kexec_handover_common.o
 obj-$(CONFIG_KEXEC_HANDOVER_DEBUGFS)	+= kexec_handover_debugfs.o
 
 obj-$(CONFIG_LIVEUPDATE)		+= luo.o
diff --git a/kernel/liveupdate/kexec_handover_internal.h b/kernel/liveupdate/kexec_handover_internal.h
index dd79e5006562..39e85d0e2c7d 100644
--- a/kernel/liveupdate/kexec_handover_internal.h
+++ b/kernel/liveupdate/kexec_handover_internal.h
@@ -18,7 +18,20 @@ struct kho_vmalloc_walk_ops {
 	int (*entry)(phys_addr_t pa, void *priv);
 };
 
+#ifdef CONFIG_KEXEC_HANDOVER
 const void *kho_get_fdt(void);
+#else
+static inline const void *kho_get_fdt(void) { return NULL; }
+#endif
+
+#ifdef CONFIG_KEXEC_HANDOVER_READONLY
+const void *kho_ro_get_fdt(void);
+bool kho_ro_cmdline_enabled(void);
+#else
+static inline const void *kho_ro_get_fdt(void) { return NULL; }
+static inline bool kho_ro_cmdline_enabled(void) { return false; }
+#endif
+
 bool kho_vmalloc_validate(const struct kho_vmalloc *preservation,
 			  unsigned int *vm_flags);
 int kho_vmalloc_walk(const struct kho_vmalloc *preservation,
diff --git a/kernel/liveupdate/kexec_handover_ro.c b/kernel/liveupdate/kexec_handover_ro.c
new file mode 100644
index 000000000000..fbf6d2ec8395
--- /dev/null
+++ b/kernel/liveupdate/kexec_handover_ro.c
@@ -0,0 +1,429 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * kexec_handover_ro.c - Read-Only Kexec Handover backend
+ *
+ * Copyright (c) 2026, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ *
+ * Implements the read-only KHO backend (kho_ro=<pa>). In read-only mode, KHO
+ * is not enabled for outgoing or incoming page ownership transfer and makes no
+ * changes to boot or struct page initialization. Instead, when subsystems
+ * retrieve preserved state, this backend traverses the KHO FDT, radix tree,
+ * and preserved metadata by mapping physical pages read-only (PAGE_KERNEL_RO)
+ * without modifying or freeing the KHO metadata or reclaiming the preserved
+ * pages.
+ *
+ * The preserved KHO FDT, radix tree, and folio/vmalloc metadata are assumed to
+ * remain static for the lifetime of the read-only KHO kernel: the FDT is
+ * mapped at early_initcall time, and radix-tree nodes, leaves, and
+ * folio/vmalloc mappings are cached on first access. If a caller needs
+ * read-write access to preserved folio contents outside of KHO metadata, it
+ * can map them with PAGE_KERNEL via kho_ro_map_folio().
+ */
+
+#define pr_fmt(fmt) "KHO-RO: " fmt
+
+#include <linux/bitops.h>
+#include <linux/cleanup.h>
+#include <linux/hashtable.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/kexec_handover.h>
+#include <linux/kho/abi/kexec_handover.h>
+#include <linux/minmax.h>
+#include <linux/mm.h>
+#include <linux/moduleparam.h>
+#include <linux/mutex.h>
+#include <linux/rcupdate.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/vmalloc.h>
+
+#include <asm/setup.h>
+
+#include "kexec_handover_internal.h"
+
+#define KHO_RO_MAP_HASH_BITS 10
+
+/*
+ * In read-only KHO mode, the preserved KHO tree and memory must reside outside
+ * of the kernel's direct map so they do not conflict with the kernel that owns
+ * the KHO state. Virtual mappings used to access the tree and preserved memory
+ * are stored in an RCU-protected hash table (kho_ro_map_ht) that remains
+ * static for the lifetime of the kernel and is never unmapped, allowing fast
+ * lockless multi-threaded lookups under rcu_read_lock() during traversal while
+ * serializing insertions on cache misses with kho_ro_lock.
+ *
+ * Entries are keyed by (pa, size, prot):
+ * - Radix-tree nodes/leaves and preserved folios use their physical address,
+ *   mapped byte size (PAGE_SIZE << order), and pgprot_t.
+ * - Preserved kho_vmalloc regions use preservation->first.phys with size = 0
+ *   and PAGE_KERNEL_RO so a discontiguous vmalloc mapping never collides with
+ *   a direct page/folio mapping (which always has size > 0).
+ */
+struct kho_ro_map_entry {
+	struct hlist_node node;
+	phys_addr_t pa;
+	size_t size;
+	pgprot_t prot;
+	void *vaddr;
+};
+
+static bool kho_ro __ro_after_init;
+static phys_addr_t kho_ro_fdt_phys __ro_after_init;
+static phys_addr_t kho_ro_mem_map_phys __ro_after_init;
+static const void *kho_ro_fdt __ro_after_init;
+static DEFINE_MUTEX(kho_ro_lock);
+static DEFINE_HASHTABLE(kho_ro_map_ht, KHO_RO_MAP_HASH_BITS);
+
+/**
+ * kho_is_ro - Check if KHO is operating in read-only mode.
+ *
+ * Return: true if read-only KHO mode is active, false otherwise.
+ */
+bool kho_is_ro(void)
+{
+	return kho_ro;
+}
+EXPORT_SYMBOL_GPL(kho_is_ro);
+
+static int __init kho_parse_ro(char *p)
+{
+	unsigned long long pa;
+
+	if (!p || kstrtoull(p, 0, &pa) || !pa || !PAGE_ALIGNED(pa))
+		return -EINVAL;
+
+	kho_ro_fdt_phys = pa;
+	kho_ro = true;
+	pr_info_once("Read-only mode enabled with FDT at %pa\n",
+		     &kho_ro_fdt_phys);
+	return 0;
+}
+early_param("kho_ro", kho_parse_ro);
+
+static int __init kho_ro_early_parse(char *param, char *val,
+				     const char *unused, void *arg)
+{
+	if (parameq(param, "kho_ro"))
+		kho_parse_ro(val);
+	return 0;
+}
+
+bool __init kho_ro_cmdline_enabled(void)
+{
+	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
+
+	if (!kho_ro) {
+		strscpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
+		parse_args("kho_ro", tmp_cmdline, NULL, 0, 0, 0, NULL,
+			   kho_ro_early_parse);
+	}
+
+	return kho_ro;
+}
+
+static int kho_ro_map_range(unsigned long vaddr, phys_addr_t pa, size_t size,
+			    pgprot_t prot)
+{
+	if (!pa || !size || !PAGE_ALIGNED(pa | size) || pa + size - 1 < pa)
+		return -EINVAL;
+
+	if (region_intersects(pa, size, IORESOURCE_SYSTEM_RAM,
+			      IORES_DESC_NONE) != REGION_DISJOINT) {
+		pr_warn_once("Cannot map System RAM at %pa (size 0x%zx)\n",
+			     &pa, size);
+		return -EINVAL;
+	}
+
+	return vmap_page_range(vaddr, vaddr + size, pa, prot);
+}
+
+static void *kho_ro_map(phys_addr_t pa, size_t size, pgprot_t prot)
+{
+	struct vm_struct *area;
+
+	area = get_vm_area_caller(size, VM_IOREMAP, __builtin_return_address(0));
+	if (!area)
+		return NULL;
+
+	area->phys_addr = pa;
+	if (kho_ro_map_range((unsigned long)area->addr, pa, size, prot)) {
+		vunmap(area->addr);
+		return NULL;
+	}
+
+	return area->addr;
+}
+
+static int __init kho_ro_init(void)
+{
+	phys_addr_t mem_map_phys;
+	const void *fdt;
+
+	if (!kho_ro)
+		return 0;
+
+	fdt = kho_ro_map(kho_ro_fdt_phys, PAGE_SIZE, PAGE_KERNEL_RO);
+	if (!fdt) {
+		pr_err("Failed to map FDT at %pa\n", &kho_ro_fdt_phys);
+		goto err_disable;
+	}
+
+	if (kho_check_fdt(fdt, kho_ro_fdt_phys))
+		goto err_unmap;
+
+	mem_map_phys = kho_get_mem_map_phys(fdt);
+	if (!mem_map_phys)
+		goto err_unmap;
+
+	kho_ro_fdt = fdt;
+	kho_ro_mem_map_phys = mem_map_phys;
+	return 0;
+
+err_unmap:
+	vunmap(fdt);
+err_disable:
+	pr_warn("Disabling read-only mode\n");
+	kho_ro = false;
+	return -EINVAL;
+}
+early_initcall(kho_ro_init);
+
+const void *kho_ro_get_fdt(void)
+{
+	return kho_ro_fdt;
+}
+
+static void *kho_ro_lookup_cached(phys_addr_t pa, size_t size, pgprot_t prot)
+{
+	struct kho_ro_map_entry *entry;
+	void *vaddr = NULL;
+
+	rcu_read_lock();
+	hash_for_each_possible_rcu(kho_ro_map_ht, entry, node, pa) {
+		if (entry->pa == pa && entry->size == size &&
+		    pgprot_val(entry->prot) == pgprot_val(prot)) {
+			vaddr = entry->vaddr;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return vaddr;
+}
+
+static void *kho_ro_insert_cached(phys_addr_t pa, size_t size, pgprot_t prot,
+				  void *vaddr)
+{
+	struct kho_ro_map_entry *entry;
+	void *existing;
+
+	guard(mutex)(&kho_ro_lock);
+	existing = kho_ro_lookup_cached(pa, size, prot);
+	if (existing)
+		return existing;
+
+	entry = kzalloc_obj(*entry);
+	if (!entry)
+		return NULL;
+
+	entry->pa = pa;
+	entry->size = size;
+	entry->prot = prot;
+	entry->vaddr = vaddr;
+	hash_add_rcu(kho_ro_map_ht, &entry->node, pa);
+
+	return vaddr;
+}
+
+static void *kho_ro_map_cached(phys_addr_t pa, size_t size, pgprot_t prot)
+{
+	void *vaddr, *cached;
+
+	vaddr = kho_ro_lookup_cached(pa, size, prot);
+	if (vaddr)
+		return vaddr;
+
+	vaddr = kho_ro_map(pa, size, prot);
+	if (!vaddr)
+		return NULL;
+
+	cached = kho_ro_insert_cached(pa, size, prot, vaddr);
+	if (cached != vaddr)
+		vunmap(vaddr);
+
+	return cached;
+}
+
+static void *kho_ro_map_radix(phys_addr_t pa)
+{
+	return kho_ro_map_cached(pa, PAGE_SIZE, PAGE_KERNEL_RO);
+}
+
+static bool kho_ro_radix_key_exists(unsigned long key)
+{
+	const struct kho_radix_leaf *leaf;
+
+	leaf = kho_radix_find_leaf(kho_ro_mem_map_phys, key, kho_ro_map_radix);
+	if (!leaf)
+		return false;
+
+	return test_bit(kho_radix_get_bitmap_index(key), leaf->bitmap);
+}
+
+/**
+ * kho_ro_lookup_folio_order - Look up the preserved order of a physical page in KHO.
+ * @pa: Page-aligned physical address of the preserved folio.
+ *
+ * Queries the preserved KHO memory radix tree in read-only mode to determine
+ * the order at which @pa was preserved.
+ *
+ * Return: Non-negative page order on success, -ENOENT if @pa is not preserved,
+ * or -EOPNOTSUPP if read-only KHO is not active.
+ */
+int kho_ro_lookup_folio_order(phys_addr_t pa)
+{
+	unsigned int order, max_order;
+
+	might_sleep();
+	if (!kho_ro)
+		return -EOPNOTSUPP;
+	if (!pa || !PAGE_ALIGNED(pa) || !kho_ro_mem_map_phys)
+		return -ENOENT;
+
+	max_order = min_t(unsigned int, __ffs64(pa >> PAGE_SHIFT),
+			  KHO_RADIX_KEY_WIDTH - 2);
+
+	for (order = 0; order <= max_order; order++) {
+		if (kho_ro_radix_key_exists(kho_encode_radix_key(pa, order)))
+			return (int)order;
+	}
+
+	return -ENOENT;
+}
+EXPORT_SYMBOL_GPL(kho_ro_lookup_folio_order);
+
+/**
+ * kho_ro_map_folio - Map a preserved KHO folio into kernel virtual address space.
+ * @pa:   Page-aligned physical address of the preserved folio.
+ * @prot: Page protection flags for the mapping (e.g. PAGE_KERNEL_RO or PAGE_KERNEL).
+ *
+ * Looks up @pa in the preserved KHO radix tree to determine its folio order,
+ * maps the entire folio (PAGE_SIZE << order) into kernel virtual address
+ * space with @prot permissions, and caches the mapping (keyed by @pa, size,
+ * and @prot) for the lifetime of the read-only KHO kernel.
+ *
+ * Return: Virtual pointer to the mapped folio on success, or NULL on failure.
+ */
+void *kho_ro_map_folio(phys_addr_t pa, pgprot_t prot)
+{
+	int order;
+
+	might_sleep();
+	order = kho_ro_lookup_folio_order(pa);
+	if (order < 0)
+		return NULL;
+
+	return kho_ro_map_cached(pa, PAGE_SIZE << order, prot);
+}
+EXPORT_SYMBOL_GPL(kho_ro_map_folio);
+
+struct kho_ro_vmalloc_ctx {
+	unsigned long vaddr;
+	size_t contig_size;
+	unsigned int order;
+};
+
+static const struct kho_vmalloc_chunk *kho_ro_vmalloc_get_chunk(phys_addr_t pa)
+{
+	if (kho_ro_lookup_folio_order(pa) != 0)
+		return NULL;
+
+	return kho_ro_map(pa, PAGE_SIZE, PAGE_KERNEL_RO);
+}
+
+static void kho_ro_vmalloc_put_chunk(const struct kho_vmalloc_chunk *chunk)
+{
+	vunmap(chunk);
+}
+
+static int kho_ro_vmalloc_map_entry(phys_addr_t pa, void *priv)
+{
+	struct kho_ro_vmalloc_ctx *ctx = priv;
+	int err;
+
+	if (kho_ro_lookup_folio_order(pa) != ctx->order)
+		return -EINVAL;
+
+	err = kho_ro_map_range(ctx->vaddr, pa, ctx->contig_size,
+			       PAGE_KERNEL_RO);
+	if (err)
+		return err;
+
+	ctx->vaddr += ctx->contig_size;
+	return 0;
+}
+
+static const struct kho_vmalloc_walk_ops kho_ro_vmalloc_ops = {
+	.get_chunk = kho_ro_vmalloc_get_chunk,
+	.put_chunk = kho_ro_vmalloc_put_chunk,
+	.entry = kho_ro_vmalloc_map_entry,
+};
+
+/**
+ * kho_ro_map_vmalloc - Map a preserved vmalloc region read-only in place.
+ * @preservation: Pointer to the KHO vmalloc preservation metadata.
+ *
+ * Allocates a VM_IOREMAP virtual address range, validates each chunk header and
+ * preserved page order in the cached KHO radix tree, maps the preserved
+ * physical pages directly with read-only permissions (PAGE_KERNEL_RO) with
+ * zero RAM allocation or memcpy overhead, and caches the mapping for the
+ * lifetime of the read-only KHO kernel.
+ *
+ * Return: Read-only virtual pointer on success, or NULL on failure.
+ */
+const void *kho_ro_map_vmalloc(const struct kho_vmalloc *preservation)
+{
+	struct kho_ro_vmalloc_ctx ctx;
+	struct vm_struct *area;
+	unsigned int vm_flags;
+	size_t total_size;
+	void *cached;
+
+	might_sleep();
+	if (!kho_ro || !kho_vmalloc_validate(preservation, &vm_flags))
+		return NULL;
+
+	/* Use size 0 in the cache key to distinguish vmalloc from folios. */
+	cached = kho_ro_lookup_cached(preservation->first.phys, 0,
+				      PAGE_KERNEL_RO);
+	if (cached)
+		return cached;
+
+	total_size = (size_t)preservation->total_pages * PAGE_SIZE;
+	area = get_vm_area_caller(total_size, VM_IOREMAP,
+				  __builtin_return_address(0));
+	if (!area)
+		return NULL;
+
+	ctx = (struct kho_ro_vmalloc_ctx){
+		.vaddr = (unsigned long)area->addr,
+		.contig_size = PAGE_SIZE << preservation->order,
+		.order = preservation->order,
+	};
+
+	if (kho_vmalloc_walk(preservation, &kho_ro_vmalloc_ops, &ctx)) {
+		vunmap(area->addr);
+		return NULL;
+	}
+
+	cached = kho_ro_insert_cached(preservation->first.phys, 0,
+				      PAGE_KERNEL_RO, area->addr);
+	if (cached != area->addr)
+		vunmap(area->addr);
+
+	return cached;
+}
+EXPORT_SYMBOL_GPL(kho_ro_map_vmalloc);
-- 
2.56.0.307.g5fe7bd680c-goog


