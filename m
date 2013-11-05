Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VdgrL-000291-MV
 for kexec@lists.infradead.org; Tue, 05 Nov 2013 13:39:56 +0000
Subject: [PATCH] kexec: export hugepage data structure into vmcoreinfo
From: Jingbai Ma <jingbai.ma@hp.com>
Date: Tue, 05 Nov 2013 21:39:28 +0800
Message-ID: <20131105133928.31933.37076.stgit@k.asiapacific.hpqcorp.net>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: ptesarik@suse.cz, d.hatayama@jp.fujitsu.com, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, vgoyal@redhat.com
Cc: bhe@redhat.com, tom.vaden@hp.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, anderson@redhat.com

This patch exports hstates data structure into vmcoreinfo when
CONFIG_HUGETLB_PAGE is defined. makedumpfile needs to read information of
hugepage related data structure.

We introduce a function into "makedumpfile" to exclude hugepage from vmcore
dump.  In order to introduce this function, the hstates data structure has
to export into vmcoreinfo.

This patch based on Linux 3.12.

The patch set for makedumpfile to filter hugepage will be sent separately.

Signed-off-by: Jingbai Ma <jingbai.ma@hp.com>
---
 kernel/kexec.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 2a74f30..766c7c8 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -38,6 +38,9 @@
 #include <asm/io.h>
 #include <asm/sections.h>
 
+#include <linux/hugetlb.h>
+
+
 /* Per cpu memory for storing cpu states in case of system crash. */
 note_buf_t __percpu *crash_notes;
 
@@ -1578,11 +1581,17 @@ static int __init crash_save_vmcoreinfo_init(void)
 	VMCOREINFO_STRUCT_SIZE(mem_section);
 	VMCOREINFO_OFFSET(mem_section, section_mem_map);
 #endif
+#ifdef CONFIG_HUGETLB_PAGE
+	VMCOREINFO_SYMBOL(hstates);
+#endif
 	VMCOREINFO_STRUCT_SIZE(page);
 	VMCOREINFO_STRUCT_SIZE(pglist_data);
 	VMCOREINFO_STRUCT_SIZE(zone);
 	VMCOREINFO_STRUCT_SIZE(free_area);
 	VMCOREINFO_STRUCT_SIZE(list_head);
+#ifdef CONFIG_HUGETLB_PAGE
+	VMCOREINFO_STRUCT_SIZE(hstate);
+#endif
 	VMCOREINFO_SIZE(nodemask_t);
 	VMCOREINFO_OFFSET(page, flags);
 	VMCOREINFO_OFFSET(page, _count);
@@ -1606,9 +1615,19 @@ static int __init crash_save_vmcoreinfo_init(void)
 	VMCOREINFO_OFFSET(list_head, prev);
 	VMCOREINFO_OFFSET(vmap_area, va_start);
 	VMCOREINFO_OFFSET(vmap_area, list);
+#ifdef CONFIG_HUGETLB_PAGE
+	VMCOREINFO_OFFSET(hstate, order);
+	VMCOREINFO_OFFSET(hstate, nr_huge_pages);
+	VMCOREINFO_OFFSET(hstate, free_huge_pages);
+	VMCOREINFO_OFFSET(hstate, hugepage_activelist);
+	VMCOREINFO_OFFSET(hstate, hugepage_freelists);
+#endif
 	VMCOREINFO_LENGTH(zone.free_area, MAX_ORDER);
 	log_buf_kexec_setup();
 	VMCOREINFO_LENGTH(free_area.free_list, MIGRATE_TYPES);
+#ifdef CONFIG_HUGETLB_PAGE
+	VMCOREINFO_LENGTH(hstate.hugepage_freelists, MAX_NUMNODES);
+#endif
 	VMCOREINFO_NUMBER(NR_FREE_PAGES);
 	VMCOREINFO_NUMBER(PG_lru);
 	VMCOREINFO_NUMBER(PG_private);
@@ -1618,6 +1637,9 @@ static int __init crash_save_vmcoreinfo_init(void)
 	VMCOREINFO_NUMBER(PG_hwpoison);
 #endif
 	VMCOREINFO_NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE);
+#ifdef CONFIG_HUGETLB_PAGE
+	VMCOREINFO_NUMBER(HUGE_MAX_HSTATE);
+#endif
 
 	arch_crash_save_vmcoreinfo();
 	update_vmcoreinfo_note();


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
