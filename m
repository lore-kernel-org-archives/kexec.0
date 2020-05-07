Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWUgr-0004no-C8
 for kexec@lists.infradead.org; Thu, 07 May 2020 00:47:12 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC 29/43] memblock: PKRAM: mark memblocks that contain preserved
 pages
Date: Wed,  6 May 2020 17:41:55 -0700
Message-Id: <1588812129-8596-30-git-send-email-anthony.yznaga@oracle.com>
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

To support deferred initialization of page structs for preserved pages,
separate memblocks containing preserved pages by setting a new flag
when adding them to the memblock reserved list.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/memblock.h | 7 +++++++
 mm/memblock.c            | 8 +++++++-
 mm/pkram.c               | 4 ++--
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 6bc37a731d27..27ab2b30ae1d 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -37,6 +37,7 @@ enum memblock_flags {
 	MEMBLOCK_HOTPLUG	= 0x1,	/* hotpluggable region */
 	MEMBLOCK_MIRROR		= 0x2,	/* mirrored region */
 	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
+	MEMBLOCK_PRESERVED	= 0x8,	/* preserved pages region */
 };
 
 /**
@@ -111,6 +112,7 @@ void memblock_allow_resize(void);
 int memblock_add_node(phys_addr_t base, phys_addr_t size, int nid);
 int memblock_add(phys_addr_t base, phys_addr_t size);
 int memblock_remove(phys_addr_t base, phys_addr_t size);
+int __memblock_reserve(phys_addr_t base, phys_addr_t size, enum memblock_flags flags);
 int memblock_free(phys_addr_t base, phys_addr_t size);
 int memblock_reserve(phys_addr_t base, phys_addr_t size);
 #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
@@ -215,6 +217,11 @@ static inline bool memblock_is_nomap(struct memblock_region *m)
 	return m->flags & MEMBLOCK_NOMAP;
 }
 
+static inline bool memblock_is_preserved(struct memblock_region *m)
+{
+	return m->flags & MEMBLOCK_PRESERVED;
+}
+
 #ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
 int memblock_search_pfn_nid(unsigned long pfn, unsigned long *start_pfn,
 			    unsigned long  *end_pfn);
diff --git a/mm/memblock.c b/mm/memblock.c
index 69ae883b8d21..1a9a2055ed11 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -831,6 +831,12 @@ int __init_memblock memblock_free(phys_addr_t base, phys_addr_t size)
 	return memblock_remove_range(&memblock.reserved, base, size);
 }
 
+int __init_memblock __memblock_reserve(phys_addr_t base, phys_addr_t size,
+					enum memblock_flags flags)
+{
+	return memblock_add_range(&memblock.reserved, base, size, MAX_NUMNODES, flags);
+}
+
 int __init_memblock memblock_reserve(phys_addr_t base, phys_addr_t size)
 {
 	phys_addr_t end = base + size - 1;
@@ -838,7 +844,7 @@ int __init_memblock memblock_reserve(phys_addr_t base, phys_addr_t size)
 	memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
 		     &base, &end, (void *)_RET_IP_);
 
-	return memblock_add_range(&memblock.reserved, base, size, MAX_NUMNODES, 0);
+	return __memblock_reserve(base, size, 0);
 }
 
 #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
diff --git a/mm/pkram.c b/mm/pkram.c
index 97a7dd0a5b7d..b83d31740619 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -170,7 +170,7 @@ static int __init pkram_reserve_page(unsigned long pfn)
 	size = PAGE_SIZE;
 
 	if (memblock_is_region_reserved(base, size) ||
-	    memblock_reserve(base, size) < 0)
+	    __memblock_reserve(base, size, MEMBLOCK_PRESERVED) < 0)
 		err = -EBUSY;
 
 	if (!err)
@@ -1446,7 +1446,7 @@ static void pkram_remove_identity_map(struct page *page)
 static int __init pkram_reserve_range_cb(struct pkram_pg_state *st, unsigned long base, unsigned long size)
 {
 	if (memblock_is_region_reserved(base, size) ||
-	    memblock_reserve(base, size) < 0) {
+	    __memblock_reserve(base, size, MEMBLOCK_PRESERVED) < 0) {
 		pr_warn("PKRAM: reservations exist in [0x%lx,0x%lx]\n", base, base + size - 1);
 		/*
 		 * Set a lower bound so another walk can undo the earlier,
-- 
2.13.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
