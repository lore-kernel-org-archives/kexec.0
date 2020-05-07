Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWUf0-0001sS-Ms
 for kexec@lists.infradead.org; Thu, 07 May 2020 00:45:25 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC 30/43] memblock: add for_each_reserved_mem_range()
Date: Wed,  6 May 2020 17:41:56 -0700
Message-Id: <1588812129-8596-31-git-send-email-anthony.yznaga@oracle.com>
In-Reply-To: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
References: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, linux-doc@vger.kernel.org, gustavo@embeddedor.com, peterz@infradead.org, kexec@lists.infradead.org, paul.c.lai@intel.com, dave.hansen@linux.intel.com, mhocko@kernel.org, lei.l.li@intel.com, nivedita@alum.mit.edu, ziqian.lzq@antfin.com, hpa@zytor.com, ardb@kernel.org, ashok.raj@intel.com, bhe@redhat.com, corbet@lwn.net, masahiroy@kernel.org, rafael.j.wysocki@intel.com, hughd@google.com, willy@infradead.org, rppt@linux.ibm.com, mingo@redhat.com, vdavydov.dev@gmail.com, ying.huang@intel.com, Thomas.Lendacky@amd.com, kevin.tian@intel.com, jroedel@suse.de, keescook@chromium.org, dan.j.williams@intel.com, bp@alien8.de, zhiyuan.lv@intel.com, luto@kernel.org, tglx@linutronix.de, andriy.shevchenko@linux.intel.com, dima@golovin.in, yang.shi@linux.alibaba.com, ndesaulniers@google.com, zhenzhong.duan@oracle.com, guro@fb.com, minchan@kernel.org, ebiederm@xmission.com, jason.zeng@intel.com, hannes@cmpxchg.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, daniel.kiper@oracle.com

To support deferred initialization of page structs for preserved
pages, add an iterator of the memblock reserved list that can select or
exclude ranges based on memblock flags.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/memblock.h | 10 ++++++++++
 mm/memblock.c            | 51 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 27ab2b30ae1d..f348ebb750c9 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -145,6 +145,11 @@ void __next_mem_range_rev(u64 *idx, int nid, enum memblock_flags flags,
 void __next_reserved_mem_region(u64 *idx, phys_addr_t *out_start,
 				phys_addr_t *out_end);
 
+void __next_reserved_mem_range(u64 *idx, enum memblock_flags flags,
+			       enum memblock_flags exclflags,
+			       phys_addr_t *out_start, phys_addr_t *out_end,
+			       int *out_nid);
+
 void __memblock_free_late(phys_addr_t base, phys_addr_t size);
 
 /**
@@ -202,6 +207,11 @@ void __memblock_free_late(phys_addr_t base, phys_addr_t size);
 	     i != (u64)ULLONG_MAX;					\
 	     __next_reserved_mem_region(&i, p_start, p_end))
 
+#define for_each_reserved_mem_range(i, flags, exclflags, p_start, p_end, p_nid)\
+	for (i = 0UL, __next_reserved_mem_range(&i, flags, exclflags, p_start, p_end, p_nid);	\
+	     i != (u64)ULLONG_MAX;					\
+	     __next_reserved_mem_range(&i, flags, exclflags, p_start, p_end, p_nid))
+
 static inline bool memblock_is_hotpluggable(struct memblock_region *m)
 {
 	return m->flags & MEMBLOCK_HOTPLUG;
diff --git a/mm/memblock.c b/mm/memblock.c
index 1a9a2055ed11..33597f352dc0 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -987,6 +987,55 @@ void __init_memblock __next_reserved_mem_region(u64 *idx,
 	*idx = ULLONG_MAX;
 }
 
+/**
+ * __next_reserved_mem_range - next function for for_each_reserved_range()
+ * @idx: pointer to u64 loop variable
+ * @flags: pick blocks based on memory attributes
+ * @exclflags: exclude blocks based on memory attributes
+ * @out_start: ptr to phys_addr_t for start address of the range, can be %NULL
+ * @out_end: ptr to phys_addr_t for end address of the range, can be %NULL
+ * @out_nid: ptr to int for nid of the range, can be %NULL
+ *
+ * Iterate over all reserved memory ranges.
+ */
+void __init_memblock __next_reserved_mem_range(u64 *idx,
+					   enum memblock_flags flags,
+					   enum memblock_flags exclflags,
+					   phys_addr_t *out_start,
+					   phys_addr_t *out_end, int *out_nid)
+{
+	struct memblock_type *type = &memblock.reserved;
+	int _idx = *idx;
+
+	for (; _idx < type->cnt; _idx++) {
+		struct memblock_region *r = &type->regions[_idx];
+		phys_addr_t base = r->base;
+		phys_addr_t size = r->size;
+
+		/* skip preserved pages */
+		if ((exclflags & MEMBLOCK_PRESERVED) && memblock_is_preserved(r))
+			continue;
+
+		/* skip non-preserved pages */
+		if ((flags & MEMBLOCK_PRESERVED) && !memblock_is_preserved(r))
+			continue;
+
+		if (out_start)
+			*out_start = base;
+		if (out_end)
+			*out_end = base + size - 1;
+		if (out_nid)
+			*out_nid = r->nid;
+
+		_idx++;
+		*idx = (u64)_idx;
+		return;
+	}
+
+	/* signal end of iteration */
+	*idx = ULLONG_MAX;
+}
+
 static bool should_skip_region(struct memblock_region *m, int nid, int flags)
 {
 	int m_nid = memblock_get_region_node(m);
@@ -1011,7 +1060,7 @@ static bool should_skip_region(struct memblock_region *m, int nid, int flags)
 }
 
 /**
- * __next_mem_range - next function for for_each_free_mem_range() etc.
+ * __next__mem_range - next function for for_each_free_mem_range() etc.
  * @idx: pointer to u64 loop variable
  * @nid: node selector, %NUMA_NO_NODE for all nodes
  * @flags: pick from blocks based on memory attributes
-- 
2.13.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
