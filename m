Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWUgF-0004NG-0R
 for kexec@lists.infradead.org; Thu, 07 May 2020 00:46:41 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC 17/43] PKRAM: provide a way to check if a memory range has
 preserved pages
Date: Wed,  6 May 2020 17:41:43 -0700
Message-Id: <1588812129-8596-18-git-send-email-anthony.yznaga@oracle.com>
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

When a kernel is loaded for kexec the address ranges where the kexec
segments will be copied to may conflict with pages already set to be
preserved. Provide a way to determine if preserved pages exist in a
specified range.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/pkram.h |  2 ++
 mm/pkram.c            | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index 1ba48442ef8e..1cd518843d7a 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -70,11 +70,13 @@ extern unsigned long pkram_reserved_pages;
 void pkram_reserve(void);
 void pkram_free_pgt(void);
 void pkram_ban_region(unsigned long start, unsigned long end);
+int pkram_has_preserved_pages(unsigned long start, unsigned long end);
 #else
 #define pkram_reserved_pages 0UL
 static inline void pkram_reserve(void) { }
 static inline void pkram_free_pgt(void) { }
 static inline void pkram_ban_region(unsigned long start, unsigned long end) { }
+static inline int pkram_has_preserved_pages(unsigned long start, unsigned long end) { return 0; }
 #endif
 
 #endif /* _LINUX_PKRAM_H */
diff --git a/mm/pkram.c b/mm/pkram.c
index 60863c8ecbab..0aaaf9b79682 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -1499,3 +1499,28 @@ phys_addr_t __init_memblock pkram_memblock_find_in_range(phys_addr_t start,
 
 	return st.retval;
 }
+
+static int pkram_has_preserved_pages_cb(struct pkram_pg_state *st, unsigned long base, unsigned long size)
+{
+	st->retval = 1;
+	return 1;
+}
+
+/*
+ * Check whether the memory range [start, end) contains preserved pages.
+ */
+int pkram_has_preserved_pages(unsigned long start, unsigned long end)
+{
+	struct pkram_pg_state st = {
+		.range_cb = pkram_has_preserved_pages_cb,
+		.min_addr = start,
+		.max_addr = end,
+	};
+
+	if (!pkram_pgd)
+		return 0;
+
+	pkram_walk_pgt_rev(&st, pkram_pgd);
+
+	return st.retval;
+}
-- 
2.13.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
