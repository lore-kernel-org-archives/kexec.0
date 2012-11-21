Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Tb5Na-0004gM-5q
 for kexec@lists.infradead.org; Wed, 21 Nov 2012 08:09:57 +0000
Date: Wed, 21 Nov 2012 17:02:47 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [PATCH] Add the values related to buddy system for filtering free
 pages
Message-Id: <20121121170247.6b57465f2fc1d7f91cd1cddf@mxc.nes.nec.co.jp>
Mime-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, kexec@lists.infradead.org

This patch adds the values related to buddy system to vmcoreinfo data
so that makedumpfile (dump filtering command) can filter out all free
pages with the new logic.
It's faster than the current logic because it can distinguish free page
by analyzing page structure at the same time as filtering for other
unnecessary pages (e.g. anonymous page).
OTOH, the current logic has to trace free_list to distinguish free 
pages while analyzing page structure to filter out other unnecessary
pages.

The new logic uses the fact that buddy page is marked by _mapcount == 
PAGE_BUDDY_MAPCOUNT_VALUE. The values below are required to distinguish
it.

Required values:
  - OFFSET(page._mapcount)
  - OFFSET(page.private)
  - SIZE(pageflags)
  - NUMBER(PG_slab)
  - NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE)
  
What's makedumpfile:
  makedumpfile creates a small dumpfile by excluding unnecessary pages
  for the analysis. To distinguish unnecessary pages, makedumpfile gets
  the vmcoreinfo data which has the minimum debugging information only
  for dump filtering.

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 include/linux/kexec.h | 3 +++
 kernel/kexec.c        | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index d0b8458..a90b148 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -158,6 +158,9 @@ unsigned long paddr_vmcoreinfo_note(void);
 #define VMCOREINFO_STRUCT_SIZE(name) \
        vmcoreinfo_append_str("SIZE(%s)=%lu\n", #name, \
                              (unsigned long)sizeof(struct name))
+#define VMCOREINFO_ENUM_SIZE(name) \
+       vmcoreinfo_append_str("SIZE(%s)=%lu\n", #name, \
+                             (unsigned long)sizeof(enum name))
 #define VMCOREINFO_OFFSET(name, field) \
        vmcoreinfo_append_str("OFFSET(%s.%s)=%lu\n", #name, #field, \
                              (unsigned long)offsetof(struct name, field))
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 5e4bd78..511151b 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1485,10 +1485,13 @@ static int __init crash_save_vmcoreinfo_init(void)
        VMCOREINFO_STRUCT_SIZE(zone);
        VMCOREINFO_STRUCT_SIZE(free_area);
        VMCOREINFO_STRUCT_SIZE(list_head);
+       VMCOREINFO_ENUM_SIZE(pageflags);
        VMCOREINFO_SIZE(nodemask_t);
        VMCOREINFO_OFFSET(page, flags);
        VMCOREINFO_OFFSET(page, _count);
        VMCOREINFO_OFFSET(page, mapping);
+       VMCOREINFO_OFFSET(page, _mapcount);
+       VMCOREINFO_OFFSET(page, private);
        VMCOREINFO_OFFSET(page, lru);
        VMCOREINFO_OFFSET(pglist_data, node_zones);
        VMCOREINFO_OFFSET(pglist_data, nr_zones);
@@ -1512,6 +1515,8 @@ static int __init crash_save_vmcoreinfo_init(void)
        VMCOREINFO_NUMBER(PG_lru);
        VMCOREINFO_NUMBER(PG_private);
        VMCOREINFO_NUMBER(PG_swapcache);
+       VMCOREINFO_NUMBER(PG_slab);
+       VMCOREINFO_NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE);

        arch_crash_save_vmcoreinfo();
        update_vmcoreinfo_note();
--
1.7.11

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
