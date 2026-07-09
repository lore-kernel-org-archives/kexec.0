Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821C7C43458
	for <kexec@archiver.kernel.org>; Thu,  9 Jul 2026 10:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TrELcVwRYyz8Jzkrxkj7A9TvS/0MDDsv0mFX1UjuUEg=; b=LEDHT6e3lDZgDQVSUVbub5XoY/
	w+8959XXmk9ydB4Fc2LN4O/U6EdMpWV/O1rwlKkyReM8HOzfvoICO6XXv8tejFCPQjsJhzPayA5ST
	IsjHq00lwk+TgscdOiG9SdDPp4QbwbUBiJdSLZUEodzRKscTeqwqOp2FTqpyg42TRO7hiP0rrM5Ur
	yvzfSx/zW8BbrsmKRU8bi4vOpmhw+GuaGYWM1DlLqDM7BUKt2m7HGveSgKEB8U4hTmitUClygBtWR
	K3I+k9KNCfY1XdCHP4telxWcRdx4y3z0Wc8Zln22y95rHSWtnQ2OBxhegX19AU/IccrO0bE/rwEZ/
	EzM8JR4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whlYS-00000001qy8-1RXM;
	Thu, 09 Jul 2026 10:00:28 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whlYQ-00000001qx9-2zPw
	for kexec@lists.infradead.org;
	Thu, 09 Jul 2026 10:00:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2D8E561372;
	Thu,  9 Jul 2026 10:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE771F000E9;
	Thu,  9 Jul 2026 10:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783591225;
	bh=TrELcVwRYyz8Jzkrxkj7A9TvS/0MDDsv0mFX1UjuUEg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=StbkFvHzawMhF0L4yrlgXoQknDDCvW45GVgyVKeSATD3sS6xlFsVQp7trQfrDH5P7
	 04NV94a2lyluspknNz3Ow/hXxTzu1AZG5xcF+7x8NiHfTl3hGVbXMlDFGbQpUjBJWK
	 VqKp9WEudr61e0Lf1pkXWy/00IKakbMp1yjPoEESVsLJGJWAHWzgOy6r4VEihNUBCi
	 WzwuugtweWvwWEfScgbUOvL33bhVQstQb2CWC74iWnlkFPG8BhNmaeaqEeSIDrTmqM
	 jiTcOnrjI/YYKDAZkBw9ylWcyZSmDd6LTWZY0zDczecZXYpxuMs9rhvTe+FdzpZgbP
	 kFURq7j8z28Bw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 09 Jul 2026 13:00:04 +0300
Subject: [PATCH v2 2/3] mm: split out sparse declarations from internal.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-internal-h-v2-2-695631425968@kernel.org>
References: <20260709-internal-h-v2-0-695631425968@kernel.org>
In-Reply-To: <20260709-internal-h-v2-0-695631425968@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, 
 Alexander Potapenko <glider@google.com>, 
 Brendan Jackman <jackmanb@google.com>, Christoph Lameter <cl@gentwo.org>, 
 Dennis Zhou <dennis@kernel.org>, Dmitry Vyukov <dvyukov@google.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Marco Elver <elver@google.com>, Michal Hocko <mhocko@suse.com>, 
 Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Zi Yan <ziy@nvidia.com>, kasan-dev@googlegroups.com, 
 kexec@lists.infradead.org, linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailer: b4 0.16-dev
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

mm/internal.h becomes more and more bloated.

Move declarations related to SPARSE and SPARSE_VMEMMAP memory models to
a new mm/sparse.h header.

No functional changes.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Muchun Song <muchun.song@linux.dev>
---
 MAINTAINERS         |  1 +
 mm/internal.h       | 52 -------------------------------------------
 mm/mm_init.c        |  1 +
 mm/sparse-vmemmap.c |  1 +
 mm/sparse.c         |  1 +
 mm/sparse.h         | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 67 insertions(+), 52 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 33cef4d8e1ee..5c1aed067656 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16999,6 +16999,7 @@ F:	mm/pgtable-generic.c
 F:	mm/ptdump.c
 F:	mm/sparse-vmemmap.c
 F:	mm/sparse.c
+F:	mm/sparse.h
 F:	mm/util.c
 F:	mm/vmpressure.c
 F:	mm/vmstat.c
diff --git a/mm/internal.h b/mm/internal.h
index 59adb140fc7a..a29a7dab2e6c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -807,58 +807,6 @@ static inline void init_compound_tail(struct page *tail,
 	prep_compound_tail(tail, head, order);
 }
 
-/*
- * mm/sparse.c
- */
-#ifdef CONFIG_SPARSEMEM
-void sparse_init(void);
-int sparse_index_init(unsigned long section_nr, int nid);
-
-static inline void sparse_init_one_section(struct mem_section *ms,
-		unsigned long pnum, struct page *mem_map,
-		struct mem_section_usage *usage, unsigned long flags)
-{
-	unsigned long coded_mem_map;
-
-	BUILD_BUG_ON(SECTION_MAP_LAST_BIT > PFN_SECTION_SHIFT);
-
-	/*
-	 * We encode the start PFN of the section into the mem_map such that
-	 * page_to_pfn() on !CONFIG_SPARSEMEM_VMEMMAP can simply subtract it
-	 * from the page pointer to obtain the PFN.
-	 */
-	coded_mem_map = (unsigned long)(mem_map - section_nr_to_pfn(pnum));
-	VM_WARN_ON_ONCE(coded_mem_map & ~SECTION_MAP_MASK);
-
-	ms->section_mem_map &= ~SECTION_MAP_MASK;
-	ms->section_mem_map |= coded_mem_map;
-	ms->section_mem_map |= flags | SECTION_HAS_MEM_MAP;
-	ms->usage = usage;
-}
-
-static inline void __section_mark_present(struct mem_section *ms,
-		unsigned long section_nr)
-{
-	if (section_nr > __highest_present_section_nr)
-		__highest_present_section_nr = section_nr;
-
-	ms->section_mem_map |= SECTION_MARKED_PRESENT;
-}
-#else
-static inline void sparse_init(void) {}
-#endif /* CONFIG_SPARSEMEM */
-
-/*
- * mm/sparse-vmemmap.c
- */
-#ifdef CONFIG_SPARSEMEM_VMEMMAP
-void sparse_init_subsection_map(void);
-#else
-static inline void sparse_init_subsection_map(void)
-{
-}
-#endif /* CONFIG_SPARSEMEM_VMEMMAP */
-
 #if defined CONFIG_COMPACTION || defined CONFIG_CMA
 
 /*
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 39583c028e34..b557e5fe35f3 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -35,6 +35,7 @@
 #include "internal.h"
 #include "mm_init.h"
 #include "page_alloc.h"
+#include "sparse.h"
 #include "slab.h"
 #include "shuffle.h"
 
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 10dd4a9b591b..458b0b9570ff 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -42,6 +42,7 @@
 
 #include "internal.h"
 #include "mm_init.h"
+#include "sparse.h"
 
 /*
  * Allocate a block of memory to be used to back the virtual memory map
diff --git a/mm/sparse.c b/mm/sparse.c
index d54e30f58b93..704a9dec2b9a 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -16,6 +16,7 @@
 #include <linux/vmstat.h>
 #include "internal.h"
 #include "mm_init.h"
+#include "sparse.h"
 #include <asm/dma.h>
 
 /*
diff --git a/mm/sparse.h b/mm/sparse.h
new file mode 100644
index 000000000000..95aa031213f2
--- /dev/null
+++ b/mm/sparse.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * sparse.h:
+ *
+ * mm/ internal sparse and sparse-vmemmap declarations
+ */
+
+#ifndef __MM_SPARSE_H
+#define __MM_SPARSE_H
+
+#include <linux/mmzone.h>
+
+/*
+ * mm/sparse.c
+ */
+#ifdef CONFIG_SPARSEMEM
+void sparse_init(void);
+int sparse_index_init(unsigned long section_nr, int nid);
+
+static inline void sparse_init_one_section(struct mem_section *ms,
+		unsigned long pnum, struct page *mem_map,
+		struct mem_section_usage *usage, unsigned long flags)
+{
+	unsigned long coded_mem_map;
+
+	BUILD_BUG_ON(SECTION_MAP_LAST_BIT > PFN_SECTION_SHIFT);
+
+	/*
+	 * We encode the start PFN of the section into the mem_map such that
+	 * page_to_pfn() on !CONFIG_SPARSEMEM_VMEMMAP can simply subtract it
+	 * from the page pointer to obtain the PFN.
+	 */
+	coded_mem_map = (unsigned long)(mem_map - section_nr_to_pfn(pnum));
+	VM_WARN_ON_ONCE(coded_mem_map & ~SECTION_MAP_MASK);
+
+	ms->section_mem_map &= ~SECTION_MAP_MASK;
+	ms->section_mem_map |= coded_mem_map;
+	ms->section_mem_map |= flags | SECTION_HAS_MEM_MAP;
+	ms->usage = usage;
+}
+
+static inline void __section_mark_present(struct mem_section *ms,
+		unsigned long section_nr)
+{
+	if (section_nr > __highest_present_section_nr)
+		__highest_present_section_nr = section_nr;
+
+	ms->section_mem_map |= SECTION_MARKED_PRESENT;
+}
+#else
+static inline void sparse_init(void) {}
+#endif /* CONFIG_SPARSEMEM */
+
+/*
+ * mm/sparse-vmemmap.c
+ */
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+void sparse_init_subsection_map(void);
+#else
+static inline void sparse_init_subsection_map(void) {}
+#endif /* CONFIG_SPARSEMEM_VMEMMAP */
+
+#endif /* __MM_SPARSE_H */

-- 
2.53.0


