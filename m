Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6751D3B7F8
	for <kexec@archiver.kernel.org>; Tue,  9 Dec 2025 02:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:From:Subject
	:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fWGLthrm17VZY/kZ1kLIqDTWzrsbdUmIFsSZPiZHtvE=; b=PPVp18kvoVaoE0qyz8MeqQJ4zH
	Nz/YCGodjOSyleqZqKc1eA44VwTD8qvnJbqpap95hoL/dPKyW9QVQ9Gg2BkGXc5KRb14xEywlqnIp
	fUH/8wCEtD+VvDwSnMFEkk4ynWo6Xha+7350w9ldGD7ElH8UaDjPRguBeTR2ov2aXUfLZOEBA67gs
	UHoPFb+XDWPjABcHuDWZF8DCHGNk6uuHGXNjaCv20sva404GmRrRhIalpaBocfo/4S+sXEuWZiDzY
	UN+qvDVfNLzYk+3BP9rjjlgB9C5fi4zTk0i163h7KaNz3gOu+97t+rlXvnh4g+UOrxe+kQh408eYd
	Lb/LWWsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSnqx-0000000DkXG-26LY;
	Tue, 09 Dec 2025 02:53:27 +0000
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSnqv-0000000DkWD-35V2
	for kexec@lists.infradead.org;
	Tue, 09 Dec 2025 02:53:26 +0000
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-bdced916ad0so4923895a12.0
        for <kexec@lists.infradead.org>; Mon, 08 Dec 2025 18:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765248804; x=1765853604; darn=lists.infradead.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fWGLthrm17VZY/kZ1kLIqDTWzrsbdUmIFsSZPiZHtvE=;
        b=V5jyLuma+rFi9APuknOh/DA5WIutOmc0G2nPpnZq65St1rE/CJyCEiI7a2ykbvGDNH
         StaC6F0wGRuN7N993o6KGkfrwTOqffADchAKJwgt+Qj1cLC+lehL/dFrCf0yzeR/wEZI
         TH373KbTkmjVfuFWfbHHbsRj4z6B5uTf1wNHMlHiEvNxIULrim6zRaK97kakRUgmIB5D
         stFy/HuXkX4Hx4xqAhjESvl7aVnbTER8ygtsTnAgRJx0nFxCDsKE7ACG4JmjNpBcPbwT
         iodKEu5Lbm2E2h5sTQd3+EvapgNZn89p7O8N+7dpZQKUGyLRFULWSCFQ9q46Aaq4N6RX
         ZVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765248804; x=1765853604;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fWGLthrm17VZY/kZ1kLIqDTWzrsbdUmIFsSZPiZHtvE=;
        b=nXtOMfaCsdOHHwZJ4BzBbjHLefTY/2SP6E1/iWtioq60kRoRPP4K64T0Iq3cVw/4Gr
         ucLQxRN5V7uwXr9tA8u/kwMBHUTVSqtza6k+jOoF0Nygkq7t2+0Xr1ph8ZpqJ2AwlBef
         6hPRu7DMWFsrsqXvYjtS9vKZ02AQ9TBBgZ0FxkvUeWE3s7og+4IwsIYjprwFL+TiQzZy
         boqTSjdxE2yz9AyvWaQtmwlh9mbnaH7h05VNc45SsolsvynRBROynVhqGf33GkPh6Es8
         AkAR6YD7QXDNCchWf2MrCv0vO9ISY4ioDpVL/BiV2zFKW+E/7XwJEEKfhT9IymdUSStK
         5/Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVJZdntzaogYM5g4hnWMFFz3o1mbjzIUUiMNC0YrLQyHVGT/HwduIswEmORTfxASwqlo4JXwQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzjIvIpPCbKD7HxGL53xEj1cKxFViqXl6nQNHYYAYUE5o2DEb21
	HZckevlB4TW5q0RaUUgRKewEAEG20Utj0GNnE5ahJGDfV/a9Zjbw8T1JWjYfivHP8Z/xAwUVpXR
	yNL+sIw1SniTFOg==
X-Google-Smtp-Source: AGHT+IHyxGM7ePub6HtjfYLSj9a32LyEArxp8bNWTTEEpgKO73sIN1+lLEyaFKDD5eGgrDeN43lBdlTkHO7++g==
X-Received: from dlbui24.prod.google.com ([2002:a05:7022:3d18:b0:11d:cdd1:432c])
 (user=jasonmiu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:689c:b0:119:e56b:9582 with SMTP id a92af1059eb24-11e0315e218mr6523139c88.7.1765248804236;
 Mon, 08 Dec 2025 18:53:24 -0800 (PST)
Date: Mon,  8 Dec 2025 18:53:13 -0800
In-Reply-To: <20251209025317.3846938-1-jasonmiu@google.com>
Mime-Version: 1.0
References: <20251209025317.3846938-1-jasonmiu@google.com>
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251209025317.3846938-2-jasonmiu@google.com>
Subject: [PATCH v3 1/4] kho: Introduce KHO FDT ABI header
From: Jason Miu <jasonmiu@google.com>
To: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Miu <jasonmiu@google.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251208_185325_779548_E2012AE4 
X-CRM114-Status: GOOD (  30.22  )
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

Introduce the `include/linux/kho/abi/kexec_handover.h` header file,
which defines the stable ABI for the KHO mechanism. This header specifies
how preserved data is passed between kernels using an FDT.

The ABI contract includes the FDT structure, node properties, and the
"kho-v1" compatible string. By centralizing these definitions, this
header serves as the foundational agreement for inter-kernel
communication of preserved states, ensuring forward compatibility and
preventing misinterpretation of data across kexec transitions.

Since the ABI definitions are now centralized in the header files, the
YAML files that previously described the FDT interfaces are
redundant. These redundant files have therefore been removed.

Signed-off-by: Jason Miu <jasonmiu@google.com>
---
 Documentation/core-api/kho/bindings/kho.yaml  | 43 ----------
 .../core-api/kho/bindings/sub-fdt.yaml        | 27 ------
 Documentation/core-api/kho/concepts.rst       | 13 +++
 Documentation/core-api/kho/fdt.rst            | 79 +++--------------
 include/linux/kho/abi/kexec_handover.h        | 84 +++++++++++++++++++
 kernel/liveupdate/kexec_handover.c            | 19 ++---
 6 files changed, 116 insertions(+), 149 deletions(-)
 delete mode 100644 Documentation/core-api/kho/bindings/kho.yaml
 delete mode 100644 Documentation/core-api/kho/bindings/sub-fdt.yaml
 create mode 100644 include/linux/kho/abi/kexec_handover.h

diff --git a/Documentation/core-api/kho/bindings/kho.yaml b/Documentation/core-api/kho/bindings/kho.yaml
deleted file mode 100644
index 11e8ab7b219d..000000000000
--- a/Documentation/core-api/kho/bindings/kho.yaml
+++ /dev/null
@@ -1,43 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-title: Kexec HandOver (KHO) root tree
-
-maintainers:
-  - Mike Rapoport <rppt@kernel.org>
-  - Changyuan Lyu <changyuanl@google.com>
-
-description: |
-  System memory preserved by KHO across kexec.
-
-properties:
-  compatible:
-    enum:
-      - kho-v1
-
-  preserved-memory-map:
-    description: |
-      physical address (u64) of an in-memory structure describing all preserved
-      folios and memory ranges.
-
-patternProperties:
-  "$[0-9a-f_]+^":
-    $ref: sub-fdt.yaml#
-    description: physical address of a KHO user's own FDT.
-
-required:
-  - compatible
-  - preserved-memory-map
-
-additionalProperties: false
-
-examples:
-  - |
-    kho {
-        compatible = "kho-v1";
-        preserved-memory-map = <0xf0be16 0x1000000>;
-
-        memblock {
-                fdt = <0x80cc16 0x1000000>;
-        };
-    };
diff --git a/Documentation/core-api/kho/bindings/sub-fdt.yaml b/Documentation/core-api/kho/bindings/sub-fdt.yaml
deleted file mode 100644
index b9a3d2d24850..000000000000
--- a/Documentation/core-api/kho/bindings/sub-fdt.yaml
+++ /dev/null
@@ -1,27 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-title: KHO users' FDT address
-
-maintainers:
-  - Mike Rapoport <rppt@kernel.org>
-  - Changyuan Lyu <changyuanl@google.com>
-
-description: |
-  Physical address of an FDT blob registered by a KHO user.
-
-properties:
-  fdt:
-    description: |
-      physical address (u64) of an FDT blob.
-
-required:
-  - fdt
-
-additionalProperties: false
-
-examples:
-  - |
-    memblock {
-            fdt = <0x80cc16 0x1000000>;
-    };
diff --git a/Documentation/core-api/kho/concepts.rst b/Documentation/core-api/kho/concepts.rst
index d626d1dbd678..e96893937286 100644
--- a/Documentation/core-api/kho/concepts.rst
+++ b/Documentation/core-api/kho/concepts.rst
@@ -72,3 +72,16 @@ Public API
 ==========
 .. kernel-doc:: kernel/liveupdate/kexec_handover.c
    :export:
+
+Internal API
+============
+.. kernel-doc:: kernel/liveupdate/kexec_handover_internal.h
+
+.. kernel-doc:: kernel/liveupdate/kexec_handover.c
+   :internal:
+
+.. kernel-doc:: kernel/liveupdate/kexec_handover_debugfs.c
+   :internal:
+
+.. kernel-doc:: kernel/liveupdate/kexec_handover_debug.c
+   :internal:
diff --git a/Documentation/core-api/kho/fdt.rst b/Documentation/core-api/kho/fdt.rst
index 62505285d60d..4e080ccc420e 100644
--- a/Documentation/core-api/kho/fdt.rst
+++ b/Documentation/core-api/kho/fdt.rst
@@ -4,77 +4,18 @@
 KHO FDT
 =======
 
-KHO uses the flattened device tree (FDT) container format and libfdt
-library to create and parse the data that is passed between the
-kernels. The properties in KHO FDT are stored in native format.
-It includes the physical address of an in-memory structure describing
-all preserved memory regions, as well as physical addresses of KHO users'
-own FDTs. Interpreting those sub FDTs is the responsibility of KHO users.
+Kexec Handover ABI
+==================
 
-KHO nodes and properties
-========================
+KHO uses the FDT to pass data between kernels. The exact structure of
+this FDT is a stable contract between kernels and is documented
+directly in the ABI header file.
 
-Property ``preserved-memory-map``
----------------------------------
+.. kernel-doc:: include/linux/kho/abi/kexec_handover.h
+   :doc: Kexec Handover ABI
 
-KHO saves a special property named ``preserved-memory-map`` under the root node.
-This node contains the physical address of an in-memory structure for KHO to
-preserve memory regions across kexec.
-
-Property ``compatible``
------------------------
-
-The ``compatible`` property determines compatibility between the kernel
-that created the KHO FDT and the kernel that attempts to load it.
-If the kernel that loads the KHO FDT is not compatible with it, the entire
-KHO process will be bypassed.
-
-Property ``fdt``
-----------------
-
-Generally, a KHO user serialize its state into its own FDT and instructs
-KHO to preserve the underlying memory, such that after kexec, the new kernel
-can recover its state from the preserved FDT.
-
-A KHO user thus can create a node in KHO root tree and save the physical address
-of its own FDT in that node's property ``fdt`` .
-
-Examples
+See Also
 ========
 
-The following example demonstrates KHO FDT that preserves two memory
-regions created with ``reserve_mem`` kernel command line parameter::
-
-  /dts-v1/;
-
-  / {
-  	compatible = "kho-v1";
-
-	preserved-memory-map = <0x40be16 0x1000000>;
-
-  	memblock {
-		fdt = <0x1517 0x1000000>;
-  	};
-  };
-
-where the ``memblock`` node contains an FDT that is requested by the
-subsystem memblock for preservation. The FDT contains the following
-serialized data::
-
-  /dts-v1/;
-
-  / {
-  	compatible = "memblock-v1";
-
-  	n1 {
-  		compatible = "reserve-mem-v1";
-  		start = <0xc06b 0x4000000>;
-  		size = <0x04 0x00>;
-  	};
-
-  	n2 {
-  		compatible = "reserve-mem-v1";
-  		start = <0xc067 0x4000000>;
-  		size = <0x04 0x00>;
-  	};
-  };
+- :doc:`/admin-guide/mm/kho`
+- :doc:`/core-api/kho/concepts`
diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/abi/kexec_handover.h
new file mode 100644
index 000000000000..d78df2d44cb6
--- /dev/null
+++ b/include/linux/kho/abi/kexec_handover.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/*
+ * Copyright (C) 2023 Alexander Graf <graf@amazon.com>
+ * Copyright (C) 2025 Microsoft Corporation, Mike Rapoport <rppt@kernel.org>
+ * Copyright (C) 2025 Google LLC, Changyuan Lyu <changyuanl@google.com>
+ * Copyright (C) 2025 Google LLC, Jason Miu <jasonmiu@google.com>
+ */
+
+#ifndef _LINUX_KHO_ABI_KEXEC_HANDOVER_H
+#define _LINUX_KHO_ABI_KEXEC_HANDOVER_H
+
+/**
+ * DOC: Kexec Handover ABI
+ *
+ * This header defines the stable ABI for passing preserved data from one kernel
+ * to the next using a Flattened Device Tree (FDT). The first kernel creates an
+ * FDT which is then passed to the next kernel during a kexec handover.
+ *
+ * This interface is a contract. Any modification to the FDT structure, node
+ * properties, compatible string, or the layout of the data structures
+ * referenced here constitutes a breaking change. Such changes require
+ * incrementing the version number in KHO_FDT_COMPATIBLE to prevent a new kernel
+ * from misinterpreting data from an older kernel. Changes are allowed provided
+ * the compatibility version is incremented; however, backward/forward
+ * compatibility is only guaranteed for kernels supporting the same ABI version.
+ *
+ * FDT Structure Overview:
+ *   The FDT serves as a central registry for physical
+ *   addresses of preserved data structures and sub-FDTs. The first kernel
+ *   populates this FDT with references to memory regions and other FDTs that
+ *   need to persist across the kexec transition. The subsequent kernel then
+ *   parses this FDT to locate and restore the preserved data.::
+ *
+ *     / {
+ *         compatible = "kho-v1";
+ *
+ *         preserved-memory-map = <0x...>;
+ *
+ *         <subnode-name-1> {
+ *             fdt = <0x...>;
+ *         };
+ *
+ *         <subnode-name-2> {
+ *             fdt = <0x...>;
+ *         };
+ *               ... ...
+ *         <subnode-name-N> {
+ *             fdt = <0x...>;
+ *         };
+ *     };
+ *
+ *   Root KHO Node (/):
+ *     - compatible: "kho-v1"
+ *
+ *       Indentifies the overall KHO ABI version.
+ *
+ *     - preserved-memory-map: u64
+ *
+ *       Physical memory address pointing to the root of the
+ *       preserved memory map data structure.
+ *
+ *   Subnodes (<subnode-name-N>):
+ *     Subnodes can also be added to the root node to
+ *     describe other preserved data blobs. The <subnode-name-N>
+ *     is provided by the subsystem that uses KHO for preserving its
+ *     data.
+ *
+ *     - fdt: u64
+ *
+ *       Physical address pointing to a subnode FDT blob that is also
+ *       being preserved.
+ */
+
+/* The compatible string for the KHO FDT root node. */
+#define KHO_FDT_COMPATIBLE "kho-v1"
+
+/* The FDT property for the preserved memory map. */
+#define KHO_FDT_MEMORY_MAP_PROP_NAME "preserved-memory-map"
+
+/* The FDT property for sub-FDTs. */
+#define KHO_FDT_SUB_TREE_PROP_NAME "fdt"
+
+#endif	/* _LINUX_KHO_ABI_KEXEC_HANDOVER_H */
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 9dc51fab604f..d3d02a9ea391 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -15,6 +15,7 @@
 #include <linux/count_zeros.h>
 #include <linux/kexec.h>
 #include <linux/kexec_handover.h>
+#include <linux/kho/abi/kexec_handover.h>
 #include <linux/libfdt.h>
 #include <linux/list.h>
 #include <linux/memblock.h>
@@ -33,10 +34,7 @@
 #include "../kexec_internal.h"
 #include "kexec_handover_internal.h"
 
-#define KHO_FDT_COMPATIBLE "kho-v1"
-#define PROP_PRESERVED_MEMORY_MAP "preserved-memory-map"
-#define PROP_SUB_FDT "fdt"
-
+/* The magic token for preserved pages */
 #define KHO_PAGE_MAGIC 0x4b484f50U /* ASCII for 'KHOP' */
 
 /*
@@ -378,7 +376,7 @@ static void kho_update_memory_map(struct khoser_mem_chunk *first_chunk)
 	void *ptr;
 	u64 phys;
 
-	ptr = fdt_getprop_w(kho_out.fdt, 0, PROP_PRESERVED_MEMORY_MAP, NULL);
+	ptr = fdt_getprop_w(kho_out.fdt, 0, KHO_FDT_MEMORY_MAP_PROP_NAME, NULL);
 
 	/* Check and discard previous memory map */
 	phys = get_unaligned((u64 *)ptr);
@@ -468,7 +466,7 @@ static bool __init kho_mem_deserialize(const void *fdt)
 	u64 mem;
 	int len;
 
-	mem_ptr = fdt_getprop(fdt, 0, PROP_PRESERVED_MEMORY_MAP, &len);
+	mem_ptr = fdt_getprop(fdt, 0, KHO_FDT_MEMORY_MAP_PROP_NAME, &len);
 	if (!mem_ptr || len != sizeof(u64)) {
 		pr_err("failed to get preserved memory bitmaps\n");
 		return false;
@@ -733,7 +731,8 @@ int kho_add_subtree(const char *name, void *fdt)
 		goto out_pack;
 	}
 
-	err = fdt_setprop(root_fdt, off, PROP_SUB_FDT, &phys, sizeof(phys));
+	err = fdt_setprop(root_fdt, off, KHO_FDT_SUB_TREE_PROP_NAME,
+			  &phys, sizeof(phys));
 	if (err < 0)
 		goto out_pack;
 
@@ -764,7 +763,7 @@ void kho_remove_subtree(void *fdt)
 		const u64 *val;
 		int len;
 
-		val = fdt_getprop(root_fdt, off, PROP_SUB_FDT, &len);
+		val = fdt_getprop(root_fdt, off, KHO_FDT_SUB_TREE_PROP_NAME, &len);
 		if (!val || len != sizeof(phys_addr_t))
 			continue;
 
@@ -1310,7 +1309,7 @@ int kho_retrieve_subtree(const char *name, phys_addr_t *phys)
 	if (offset < 0)
 		return -ENOENT;
 
-	val = fdt_getprop(fdt, offset, PROP_SUB_FDT, &len);
+	val = fdt_getprop(fdt, offset, KHO_FDT_SUB_TREE_PROP_NAME, &len);
 	if (!val || len != sizeof(*val))
 		return -EINVAL;
 
@@ -1330,7 +1329,7 @@ static __init int kho_out_fdt_setup(void)
 	err |= fdt_finish_reservemap(root);
 	err |= fdt_begin_node(root, "");
 	err |= fdt_property_string(root, "compatible", KHO_FDT_COMPATIBLE);
-	err |= fdt_property(root, PROP_PRESERVED_MEMORY_MAP, &empty_mem_map,
+	err |= fdt_property(root, KHO_FDT_MEMORY_MAP_PROP_NAME, &empty_mem_map,
 			    sizeof(empty_mem_map));
 	err |= fdt_end_node(root);
 	err |= fdt_finish(root);
-- 
2.52.0.223.gf5cc29aaa4-goog


