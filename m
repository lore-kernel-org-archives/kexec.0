Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12308CD6E75
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 03:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CGemO6oM+fzlXtG0xc8ivWmdV7Y8sG7GsOK7Le1P9V4=; b=JIfurr97+6hqC5reji0ys4XGc0
	vz5IhhCq2JRQJ1akdyiXs9DhCzyPvnV28uiKOd7CW+R4exXUB8U3ldSB33a9Ir6TfqsGukLMjHj2d
	ivdLYI0+px7K5J70eomct1MrzWwAnPGHSVVxpVYxDSeuXzYtFR3+6fkOwoBE+pVDyVjcQiZvxncKf
	BAsXhRPugUxyAzE+rwI5gz4qRFmWnb7GX7DeymRWMKt2l1aXiU5tfkWPhgK1d3u3PMsvJS2RdTipm
	077iU4Drdlc2rubq0/Oo+bF7O+Pvd0pHFt70utf7/ItsSvqjp0ly5n1iZgvfn/wgh57uICfz4ybAj
	EUHHUjLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVLIy-00000000205-06mG;
	Fri, 05 Jun 2026 03:33:08 +0000
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVLIs-000000001yE-0Bsn
	for kexec@lists.infradead.org;
	Fri, 05 Jun 2026 03:33:06 +0000
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-9157b949fc7so188282585a.3
        for <kexec@lists.infradead.org>; Thu, 04 Jun 2026 20:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780630381; x=1781235181; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CGemO6oM+fzlXtG0xc8ivWmdV7Y8sG7GsOK7Le1P9V4=;
        b=akTKwKw4R+S5V1qzFzXgwUrnxTWWFe7Lbyj5YrjWYKMZ+z5nLZGDvRze4UbrG2PKI/
         XO/pw6+jhFUHzxHnOu66qe3emTlUklYr41nUI8usaOzPPKqJ5ASJd6RHC/X6tMnu+fXb
         fgkH8197wBtbRRTz+1FL+UGdUZCowYzYrExBY9rWHy7VuaezoKmnqML2YNNPdAYApBuH
         sU02WgJE4HnRCDCx0LHJTEhOWVGjyKTpHEpdbs5xctHmxXpmpJtR1ZmahJs7X32uVDi7
         JaxHSk3lH9K90FZSrdUgTxFkZdfsciPNTYp4VEbU1Szwb6dZCXRnYxrPX5O+I2nZQYQj
         3c/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780630381; x=1781235181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CGemO6oM+fzlXtG0xc8ivWmdV7Y8sG7GsOK7Le1P9V4=;
        b=rFsx09xgoWn7hkh1a0yvDyo1uJl9cSY9kKEA3lWp1gppgUEIulIvHwp0DWVe/CLdzP
         tLhcPM0KbDTh+hjjI6uleGn7YQEokiE9ah1By4G5371723VapD/SkrWurPvamE+5dVK0
         nW9900zdljMZ9/ptar4CC0pIR9k/NLdJ27fkFZ4r+PGIwS/bZIjxDSRmDl3fCpjxd9oX
         AhKQTFeZoHANU7k6EHgD8DFSzd911+WBL6TOuxdLkpWlYu72oUnXskx7Me1bjFSf8z5i
         CNsfl9KHAr49HZ1OITKlE0YBdH5vYcpZup6KT0kiajcAw53ys5KpnOlGGLljRNSK+Jmd
         iXSw==
X-Forwarded-Encrypted: i=1; AFNElJ/B/ORPDMb/QAmF5Z4cWnp+ffTFtipCaGoBY4ZIcHJhlphVkgw5tlx1G5KZxFaTqIhQ3a/BIg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyJUn+e9OlKRrTcSRPY4UuuopEM1vbKyuLjYs9GqSn0rWI0g9rK
	xG6jdlxVuo27+0yKdO3QMzHL9IFDvk9gagNXRhUe7XA10JDSR6v42fGNsP0iCQnV77o=
X-Gm-Gg: Acq92OEZD0xcFLfPpUx4AC9HtZrjt7SNt5cFoOo8iTW/wbZHrG2E+QIg6cj4kr2+t+a
	0eIcmr/GsLwlijCO969f+a3H5z3SjAwXGpESe9v3d3ILBrz2BZz9ZNlcb/EmJqBTzGPe+rWv6hz
	PGqkW0I7R9mcZbHWee0ieZNqsqhu0sO2N8pxZp/A5xz1GfGjEEmIeBe5La1+cXtBzYEgNAuE/oC
	OYT6ZP9zB/K0WGlAxuchVljnFBBFDnrwaZGe+xcdJlrveW49u0lOWX2FJLcdywnXxYZCo4f2xJl
	RfoheZyP1+c0GtzyKiBitROtVgWyD1bc87fDhN+wNko89lRnjzhFot8k3Pbsk+J1tJ4wL/hR97v
	hb95ik00WQCwIIASupOgNbSHfqNuCJWgum6aZsri62tUuRtgtcBws1DjYd360PcDTF8fvWi07wp
	Q7837M8OlwHTha05rcaEeFZfMQgN6+sJ9PuCD0BeoYbn4mosPLv78tasnyO8KjSA==
X-Received: by 2002:a05:620a:1709:b0:914:cc9d:e29 with SMTP id af79cd13be357-915a9cadf6fmr346442685a.21.1780630380676;
        Thu, 04 Jun 2026 20:33:00 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccdb915csm70807166d6.14.2026.06.04.20.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 20:33:00 -0700 (PDT)
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
Subject: [RFC v1 2/9] kho: split radix tree headers out of kexec_handover.h
Date: Fri,  5 Jun 2026 03:32:28 +0000
Message-ID: <20260605033235.717351-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605033235.717351-1-pasha.tatashin@soleen.com>
References: <20260605033235.717351-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260604_203302_151942_F3AEC8AB 
X-CRM114-Status: GOOD (  29.73  )
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

Split the radix tree tracker-related ABI definitions and header
declarations out of the monolithic kexec_handover.h header into a
dedicated header file (radix_tree.h).

Additionally, rename kho_radix_tree.h to kho/radix_tree.h, organizing it
within the existing kho directory structure as more KHO data structures
are introduced.

This is a pure code movement patch; no logic or functional changes are
introduced.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 Documentation/core-api/kho/abi.rst            |   3 +-
 Documentation/core-api/kho/index.rst          |   2 +-
 include/linux/kho/abi/kexec_handover.h        | 114 ---------------
 include/linux/kho/abi/radix_tree.h            | 131 ++++++++++++++++++
 .../{kho_radix_tree.h => kho/radix_tree.h}    |   5 +-
 kernel/liveupdate/kexec_handover.c            |   2 +-
 kernel/liveupdate/kho_radix.c                 |   2 +-
 7 files changed, 137 insertions(+), 122 deletions(-)
 create mode 100644 include/linux/kho/abi/radix_tree.h
 rename include/linux/{kho_radix_tree.h => kho/radix_tree.h} (96%)

diff --git a/Documentation/core-api/kho/abi.rst b/Documentation/core-api/kho/abi.rst
index edeb5b311963..da5c6636bb17 100644
--- a/Documentation/core-api/kho/abi.rst
+++ b/Documentation/core-api/kho/abi.rst
@@ -25,8 +25,7 @@ memblock preservation ABI
 KHO persistent memory tracker ABI
 =================================
 
-.. kernel-doc:: include/linux/kho/abi/kexec_handover.h
-  :doc: KHO persistent memory tracker
+.. kernel-doc:: include/linux/kho/abi/radix_tree.h
 
 KHO serialization block ABI
 ===========================
diff --git a/Documentation/core-api/kho/index.rst b/Documentation/core-api/kho/index.rst
index a9892c671ec3..f69367d217cf 100644
--- a/Documentation/core-api/kho/index.rst
+++ b/Documentation/core-api/kho/index.rst
@@ -74,7 +74,7 @@ the next KHO, because kexec can overwrite even the original kernel.
 Kexec Handover Radix Tree
 =========================
 
-.. kernel-doc:: include/linux/kho_radix_tree.h
+.. kernel-doc:: include/linux/kho/radix_tree.h
   :doc: Kexec Handover Radix Tree
 
 Public API
diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/abi/kexec_handover.h
index 5e2eb8519bda..99e4a53d4e35 100644
--- a/include/linux/kho/abi/kexec_handover.h
+++ b/include/linux/kho/abi/kexec_handover.h
@@ -4,15 +4,10 @@
  * Copyright (C) 2023 Alexander Graf <graf@amazon.com>
  * Copyright (C) 2025 Microsoft Corporation, Mike Rapoport <rppt@kernel.org>
  * Copyright (C) 2025 Google LLC, Changyuan Lyu <changyuanl@google.com>
- * Copyright (C) 2025 Google LLC, Jason Miu <jasonmiu@google.com>
  */
 
 #ifndef _LINUX_KHO_ABI_KEXEC_HANDOVER_H
 #define _LINUX_KHO_ABI_KEXEC_HANDOVER_H
-
-#include <linux/bits.h>
-#include <linux/log2.h>
-#include <linux/math.h>
 #include <linux/types.h>
 
 #include <asm/page.h>
@@ -177,113 +172,4 @@ struct kho_vmalloc {
 	unsigned short order;
 };
 
-/**
- * DOC: KHO persistent memory tracker
- *
- * KHO tracks preserved memory using a radix tree data structure. Each node of
- * the tree is exactly a single page. The leaf nodes are bitmaps where each set
- * bit is a preserved page of any order. The intermediate nodes are tables of
- * physical addresses that point to a lower level node.
- *
- * The tree hierarchy is shown below::
- *
- *   root
- *   +-------------------+
- *   |     Level 5       | (struct kho_radix_node)
- *   +-------------------+
- *     |
- *     v
- *   +-------------------+
- *   |     Level 4       | (struct kho_radix_node)
- *   +-------------------+
- *     |
- *     | ... (intermediate levels)
- *     |
- *     v
- *   +-------------------+
- *   |      Level 0      | (struct kho_radix_leaf)
- *   +-------------------+
- *
- * The tree is traversed using a key that encodes the page's physical address
- * (pa) and its order into a single unsigned long value. The encoded key value
- * is composed of two parts: the 'order bit' in the upper part and the
- * 'shifted physical address' in the lower part.::
- *
- *   +------------+-----------------------------+--------------------------+
- *   | Page Order | Order Bit                   | Shifted Physical Address |
- *   +------------+-----------------------------+--------------------------+
- *   | 0          | ...000100 ... (at bit 52)   | pa >> (PAGE_SHIFT + 0)   |
- *   | 1          | ...000010 ... (at bit 51)   | pa >> (PAGE_SHIFT + 1)   |
- *   | 2          | ...000001 ... (at bit 50)   | pa >> (PAGE_SHIFT + 2)   |
- *   | ...        | ...                         | ...                      |
- *   +------------+-----------------------------+--------------------------+
- *
- * Shifted Physical Address:
- * The 'shifted physical address' is the physical address normalized for its
- * order. It effectively represents the PFN shifted right by the order.
- *
- * Order Bit:
- * The 'order bit' encodes the page order by setting a single bit at a
- * specific position. The position of this bit itself represents the order.
- *
- * For instance, on a 64-bit system with 4KB pages (PAGE_SHIFT = 12), the
- * maximum range for the shifted physical address (for order 0) is 52 bits
- * (64 - 12). This address occupies bits [0-51]. For order 0, the order bit is
- * set at position 52.
- *
- * The following diagram illustrates how the encoded key value is split into
- * indices for the tree levels, with PAGE_SIZE of 4KB::
- *
- *        63:60   59:51    50:42    41:33    32:24    23:15         14:0
- *   +---------+--------+--------+--------+--------+--------+-----------------+
- *   |    0    |  Lv 5  |  Lv 4  |  Lv 3  |  Lv 2  |  Lv 1  |  Lv 0 (bitmap)  |
- *   +---------+--------+--------+--------+--------+--------+-----------------+
- *
- * The radix tree stores pages of all orders in a single 6-level hierarchy. It
- * efficiently shares higher tree levels, especially due to common zero top
- * address bits, allowing a single, efficient algorithm to manage all
- * pages. This bitmap approach also offers memory efficiency; for example, a
- * 512KB bitmap can cover a 16GB memory range for 0-order pages with PAGE_SIZE =
- * 4KB.
- *
- * The data structures defined here are part of the KHO ABI. Any modification
- * to these structures that breaks backward compatibility must be accompanied by
- * an update to the "compatible" string. This ensures that a newer kernel can
- * correctly interpret the data passed by an older kernel.
- */
-
-/*
- * Defines constants for the KHO radix tree structure, used to track preserved
- * memory. These constants govern the indexing, sizing, and depth of the tree.
- */
-enum kho_radix_consts {
-	/*
-	 * The bit position of the order bit (and also the length of the
-	 * shifted physical address) for an order-0 page.
-	 */
-	KHO_ORDER_0_LOG2 = 64 - PAGE_SHIFT,
-
-	/* Size of the table in kho_radix_node, in log2 */
-	KHO_TABLE_SIZE_LOG2 = const_ilog2(PAGE_SIZE / sizeof(phys_addr_t)),
-
-	/* Number of bits in the kho_radix_leaf bitmap, in log2 */
-	KHO_BITMAP_SIZE_LOG2 = PAGE_SHIFT + const_ilog2(BITS_PER_BYTE),
-
-	/*
-	 * The total tree depth is the number of intermediate levels
-	 * and 1 bitmap level.
-	 */
-	KHO_TREE_MAX_DEPTH =
-		DIV_ROUND_UP(KHO_ORDER_0_LOG2 - KHO_BITMAP_SIZE_LOG2 + 1,
-			     KHO_TABLE_SIZE_LOG2) + 1,
-};
-
-struct kho_radix_node {
-	u64 table[1 << KHO_TABLE_SIZE_LOG2];
-};
-
-struct kho_radix_leaf {
-	DECLARE_BITMAP(bitmap, 1 << KHO_BITMAP_SIZE_LOG2);
-};
-
 #endif	/* _LINUX_KHO_ABI_KEXEC_HANDOVER_H */
diff --git a/include/linux/kho/abi/radix_tree.h b/include/linux/kho/abi/radix_tree.h
new file mode 100644
index 000000000000..f4cc5c02f37a
--- /dev/null
+++ b/include/linux/kho/abi/radix_tree.h
@@ -0,0 +1,131 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2025 Google LLC, Jason Miu <jasonmiu@google.com>
+ * Copyright (C) 2026 Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+#ifndef _LINUX_KHO_ABI_RADIX_TREE_H
+#define _LINUX_KHO_ABI_RADIX_TREE_H
+
+#include <linux/types.h>
+#include <asm/page.h>
+
+/**
+ * DOC: KHO persistent memory tracker
+ *
+ * Subsystems using the KHO persistent memory tracker rely on the stable
+ * Application Binary Interface defined below to pass serialized state from a
+ * pre-update kernel to a post-update kernel.
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
+ * KHO tracks preserved memory using a radix tree data structure. Each node of
+ * the tree is exactly a single page. The leaf nodes are bitmaps where each set
+ * bit is a preserved page of any order. The intermediate nodes are tables of
+ * physical addresses that point to a lower level node.
+ *
+ * The tree hierarchy is shown below::
+ *
+ *   root
+ *   +-------------------+
+ *   |     Level 5       | (struct kho_radix_node)
+ *   +-------------------+
+ *     |
+ *     v
+ *   +-------------------+
+ *   |     Level 4       | (struct kho_radix_node)
+ *   +-------------------+
+ *     |
+ *     | ... (intermediate levels)
+ *     |
+ *     v
+ *   +-------------------+
+ *   |      Level 0      | (struct kho_radix_leaf)
+ *   +-------------------+
+ *
+ * The tree is traversed using a key that encodes the page's physical address
+ * (pa) and its order into a single unsigned long value. The encoded key value
+ * is composed of two parts: the 'order bit' in the upper part and the
+ * 'shifted physical address' in the lower part.::
+ *
+ *   +------------+-----------------------------+--------------------------+
+ *   | Page Order | Order Bit                   | Shifted Physical Address |
+ *   +------------+-----------------------------+--------------------------+
+ *   | 0          | ...000100 ... (at bit 52)   | pa >> (PAGE_SHIFT + 0)   |
+ *   | 1          | ...000010 ... (at bit 51)   | pa >> (PAGE_SHIFT + 1)   |
+ *   | 2          | ...000001 ... (at bit 50)   | pa >> (PAGE_SHIFT + 2)   |
+ *   | ...        | ...                         | ...                      |
+ *   +------------+-----------------------------+--------------------------+
+ *
+ * Shifted Physical Address:
+ * The 'shifted physical address' is the physical address normalized for its
+ * order. It effectively represents the PFN shifted right by the order.
+ *
+ * Order Bit:
+ * The 'order bit' encodes the page order by setting a single bit at a
+ * specific position. The position of this bit itself represents the order.
+ *
+ * For instance, on a 64-bit system with 4KB pages (PAGE_SHIFT = 12), the
+ * maximum range for the shifted physical address (for order 0) is 52 bits
+ * (64 - 12). This address occupies bits [0-51]. For order 0, the order bit is
+ * set at position 52.
+ *
+ * The following diagram illustrates how the encoded key value is split into
+ * indices for the tree levels, with PAGE_SIZE of 4KB::
+ *
+ *        63:60   59:51    50:42    41:33    32:24    23:15         14:0
+ *   +---------+--------+--------+--------+--------+--------+-----------------+
+ *   |    0    |  Lv 5  |  Lv 4  |  Lv 3  |  Lv 2  |  Lv 1  |  Lv 0 (bitmap)  |
+ *   +---------+--------+--------+--------+--------+--------+-----------------+
+ *
+ * The radix tree stores pages of all orders in a single 6-level hierarchy. It
+ * efficiently shares higher tree levels, especially due to common zero top
+ * address bits, allowing a single, efficient algorithm to manage all
+ * pages. This bitmap approach also offers memory efficiency; for example, a
+ * 512KB bitmap can cover a 16GB memory range for 0-order pages with PAGE_SIZE =
+ * 4KB.
+ */
+
+/*
+ * Defines constants for the KHO radix tree structure, used to track preserved
+ * memory. These constants govern the indexing, sizing, and depth of the tree.
+ */
+enum kho_radix_consts {
+	/*
+	 * The bit position of the order bit (and also the length of the
+	 * shifted physical address) for an order-0 page.
+	 */
+	KHO_ORDER_0_LOG2 = 64 - PAGE_SHIFT,
+
+	/* Size of the table in kho_radix_node, in log2 */
+	KHO_TABLE_SIZE_LOG2 = const_ilog2(PAGE_SIZE / sizeof(phys_addr_t)),
+
+	/* Number of bits in the kho_radix_leaf bitmap, in log2 */
+	KHO_BITMAP_SIZE_LOG2 = PAGE_SHIFT + const_ilog2(BITS_PER_BYTE),
+
+	/*
+	 * The total tree depth is the number of intermediate levels
+	 * and 1 bitmap level.
+	 */
+	KHO_TREE_MAX_DEPTH =
+		DIV_ROUND_UP(KHO_ORDER_0_LOG2 - KHO_BITMAP_SIZE_LOG2 + 1,
+			     KHO_TABLE_SIZE_LOG2) + 1,
+};
+
+struct kho_radix_node {
+	u64 table[1 << KHO_TABLE_SIZE_LOG2];
+};
+
+struct kho_radix_leaf {
+	DECLARE_BITMAP(bitmap, 1 << KHO_BITMAP_SIZE_LOG2);
+};
+
+#endif /* _LINUX_KHO_ABI_RADIX_TREE_H */
diff --git a/include/linux/kho_radix_tree.h b/include/linux/kho/radix_tree.h
similarity index 96%
rename from include/linux/kho_radix_tree.h
rename to include/linux/kho/radix_tree.h
index 84e918b96e53..1e337e73deba 100644
--- a/include/linux/kho_radix_tree.h
+++ b/include/linux/kho/radix_tree.h
@@ -5,6 +5,7 @@
 
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/kho/abi/radix_tree.h>
 #include <linux/mutex_types.h>
 #include <linux/types.h>
 
@@ -24,11 +25,9 @@
  * Client code is responsible for allocating the root node of the tree,
  * initializing the mutex lock, and managing its lifecycle. It must use the
  * tree data structures defined in the KHO ABI,
- * `include/linux/kho/abi/kexec_handover.h`.
+ * `include/linux/kho/abi/radix_tree.h`.
  */
 
-struct kho_radix_node;
-
 struct kho_radix_tree {
 	struct kho_radix_node *root;
 	struct mutex lock; /* protects the tree's structure and root pointer */
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 041efff7ca11..4a3d6a54a17f 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -16,7 +16,7 @@
 #include <linux/kasan.h>
 #include <linux/kexec.h>
 #include <linux/kexec_handover.h>
-#include <linux/kho_radix_tree.h>
+#include <linux/kho/radix_tree.h>
 #include <linux/utsname.h>
 #include <linux/kho/abi/kexec_handover.h>
 #include <linux/kho/abi/kexec_metadata.h>
diff --git a/kernel/liveupdate/kho_radix.c b/kernel/liveupdate/kho_radix.c
index c836783a1376..f48088847264 100644
--- a/kernel/liveupdate/kho_radix.c
+++ b/kernel/liveupdate/kho_radix.c
@@ -11,7 +11,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/kho/abi/kexec_handover.h>
-#include <linux/kho_radix_tree.h>
+#include <linux/kho/radix_tree.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
 #include <linux/types.h>
-- 
2.53.0


