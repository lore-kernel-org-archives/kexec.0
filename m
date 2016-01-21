Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aMLcz-0004VL-RA
 for kexec@lists.infradead.org; Thu, 21 Jan 2016 20:14:49 +0000
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH] xen: Add support for dom0 with Linux kernel 3.19 and newer
Date: Thu, 21 Jan 2016 21:13:51 +0100
Message-Id: <1453407231-25432-1-git-send-email-daniel.kiper@oracle.com>
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
To: crash-utility@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: jgross@suse.com, olaf@aepfle.de, keir@xen.org, jbeulich@suse.com, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, ptesarik@suse.cz, dslutz@verizon.com, anderson@redhat.com, david.vrabel@citrix.com, dmair@suse.com, boris.ostrovsky@oracle.com

Linux kernel commit 054954eb051f35e74b75a566a96fe756015352c8
(xen: switch to linear virtual mapped sparse p2m list), which
appeared in 3.19, introduced linear virtual mapped sparse p2m
list. If readmem() reads p2m then it access this list using
physical addresses. Sadly, VMA to physical address translation
in crash requires access to p2m list. This means that we have
a chicken and egg problem. In general this issue must be solved
by introducing some changes in libxl, Linux kernel and crash
(I have added this task to my long TODO list). However, in dom0
case we can use crash_xen_info_t.dom0_pfn_to_mfn_frame_list_list
which is available out of the box. So, let's use it and make
at least some users happy.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 kernel.c   |   81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++------
 xen_dom0.c |    3 ++-
 xen_dom0.h |    2 ++
 3 files changed, 77 insertions(+), 9 deletions(-)

diff --git a/kernel.c b/kernel.c
index 5ce2fb9..b07149e 100644
--- a/kernel.c
+++ b/kernel.c
@@ -17,6 +17,7 @@
 
 #include "defs.h"
 #include "xen_hyper_defs.h"
+#include "xen_dom0.h"
 #include <elf.h>
 #include <libgen.h>
 #include <ctype.h>
@@ -61,6 +62,7 @@ static int restore_stack(struct bt_info *);
 static ulong __xen_m2p(ulonglong, ulong);
 static ulong __xen_pvops_m2p_l2(ulonglong, ulong);
 static ulong __xen_pvops_m2p_l3(ulonglong, ulong);
+static ulong __xen_pvops_m2p_hyper(ulonglong, ulong);
 static int search_mapping_page(ulong, ulong *, ulong *, ulong *);
 static void read_in_kernel_config_err(int, char *);
 static void BUG_bytes_init(void);
@@ -175,6 +177,9 @@ kernel_init()
 						&kt->pvops_xen.p2m_mid_missing);
 			get_symbol_data("p2m_missing", sizeof(ulong),
 						&kt->pvops_xen.p2m_missing);
+		} else if (symbol_exists("xen_p2m_addr")) {
+			if (!XEN_CORE_DUMPFILE())
+				error(FATAL, "p2m array in new format is unreadable.");
 		} else {
 			kt->pvops_xen.p2m_top_entries = get_array_length("p2m_top", NULL, 0);
 			kt->pvops_xen.p2m_top = symbol_value("p2m_top");
@@ -5850,12 +5855,14 @@ no_cpu_flags:
 	else
 		fprintf(fp, "\n");
 
-	fprintf(fp, "              pvops_xen:\n");
-	fprintf(fp, "                    p2m_top: %lx\n", kt->pvops_xen.p2m_top);
-	fprintf(fp, "            p2m_top_entries: %d\n", kt->pvops_xen.p2m_top_entries);
-	if (symbol_exists("p2m_mid_missing"))
-		fprintf(fp, "            p2m_mid_missing: %lx\n", kt->pvops_xen.p2m_mid_missing);
-	fprintf(fp, "                p2m_missing: %lx\n", kt->pvops_xen.p2m_missing);
+	if (!symbol_exists("xen_p2m_addr")) {
+		fprintf(fp, "              pvops_xen:\n");
+		fprintf(fp, "                    p2m_top: %lx\n", kt->pvops_xen.p2m_top);
+		fprintf(fp, "            p2m_top_entries: %d\n", kt->pvops_xen.p2m_top_entries);
+		if (symbol_exists("p2m_mid_missing"))
+			fprintf(fp, "            p2m_mid_missing: %lx\n", kt->pvops_xen.p2m_mid_missing);
+		fprintf(fp, "                p2m_missing: %lx\n", kt->pvops_xen.p2m_missing);
+	}
 }
 
 /*
@@ -8873,6 +8880,12 @@ __xen_m2p(ulonglong machine, ulong mfn)
 	ulong c, i, kmfn, mapping, p, pfn;
 	ulong start, end;
 	ulong *mp = (ulong *)kt->m2p_page;
+	int memtype;
+
+	if (XEN_CORE_DUMPFILE() && symbol_exists("xen_p2m_addr"))
+		memtype = PHYSADDR;
+	else
+		memtype = KVADDR;
 
 	/*
 	 *  Check the FIFO cache first.
@@ -8883,13 +8896,19 @@ __xen_m2p(ulonglong machine, ulong mfn)
 		     (mfn <= kt->p2m_mapping_cache[c].end))) { 
 
 			if (kt->p2m_mapping_cache[c].mapping != kt->last_mapping_read) {
-                        	if (!readmem(kt->p2m_mapping_cache[c].mapping, KVADDR, 
+				if (memtype == PHYSADDR)
+					pc->curcmd_flags |= XEN_MACHINE_ADDR;
+
+				if (!readmem(kt->p2m_mapping_cache[c].mapping, memtype,
 			       	    mp, PAGESIZE(), "phys_to_machine_mapping page (cached)", 
 			    	    RETURN_ON_ERROR))
                                 	error(FATAL, "cannot access "
                                     	    "phys_to_machine_mapping page\n");
 				else
 					kt->last_mapping_read = kt->p2m_mapping_cache[c].mapping;
+
+				if (memtype == PHYSADDR)
+					pc->curcmd_flags &= ~XEN_MACHINE_ADDR;
 			} else
 				kt->p2m_page_cache_hits++;
 
@@ -8919,11 +8938,13 @@ __xen_m2p(ulonglong machine, ulong mfn)
 	if (PVOPS_XEN()) {
 		/*
 		 *  The machine address was not cached, so search from the
-		 *  beginning of the p2m_top array, caching the contiguous
+		 *  beginning of the p2m tree/array, caching the contiguous
 		 *  range containing the found machine address.
 		 */
 		if (symbol_exists("p2m_mid_missing"))
 			pfn = __xen_pvops_m2p_l3(machine, mfn);
+		else if (symbol_exists("xen_p2m_addr"))
+			pfn = __xen_pvops_m2p_hyper(machine, mfn);
 		else
 			pfn = __xen_pvops_m2p_l2(machine, mfn);
 
@@ -9088,6 +9109,50 @@ __xen_pvops_m2p_l3(ulonglong machine, ulong mfn)
 	return XEN_MFN_NOT_FOUND;
 }
 
+static ulong
+__xen_pvops_m2p_hyper(ulonglong machine, ulong mfn)
+{
+	ulong c, end, i, mapping, p, pfn, start;
+
+	for (p = 0;
+	     p < xkd->p2m_frames;
+	     ++p) {
+
+		mapping = PTOB(xkd->p2m_mfn_frame_list[p]);
+
+		if (mapping != kt->last_mapping_read) {
+			pc->curcmd_flags |= XEN_MACHINE_ADDR;
+			if (!readmem(mapping, PHYSADDR, (void *)kt->m2p_page,
+					PAGESIZE(), "p2m_mfn_frame_list page", RETURN_ON_ERROR))
+				error(FATAL, "cannot access p2m_mfn_frame_list[] page\n");
+
+			pc->curcmd_flags &= ~XEN_MACHINE_ADDR;
+			kt->last_mapping_read = mapping;
+		}
+
+		kt->p2m_pages_searched++;
+
+		if (search_mapping_page(mfn, &i, &start, &end)) {
+			pfn = p * XEN_PFNS_PER_PAGE + i;
+			if (CRASHDEBUG(1))
+			    console("pages: %d mfn: %lx (%llx) p: %ld"
+				" i: %ld pfn: %lx (%llx)\n", p + 1, mfn, machine,
+				p, i, pfn, XEN_PFN_TO_PSEUDO(pfn));
+
+			c = kt->p2m_cache_index;
+			kt->p2m_mapping_cache[c].start = start;
+			kt->p2m_mapping_cache[c].end = end;
+			kt->p2m_mapping_cache[c].mapping = mapping;
+			kt->p2m_mapping_cache[c].pfn = p * XEN_PFNS_PER_PAGE;
+			kt->p2m_cache_index = (c+1) % P2M_MAPPING_CACHE;
+
+			return pfn;
+		}
+	}
+
+	return XEN_MFN_NOT_FOUND;
+}
+
 /*
  *  Search for an mfn in the current mapping page, and if found, 
  *  determine the range of contiguous mfns that it's contained
diff --git a/xen_dom0.c b/xen_dom0.c
index 6abb443..6770fd4 100644
--- a/xen_dom0.c
+++ b/xen_dom0.c
@@ -20,7 +20,8 @@
 #include "xen_dom0.h"
 
 static struct xen_kdump_data xen_kdump_data = { 0 };
-static struct xen_kdump_data *xkd = &xen_kdump_data;
+
+struct xen_kdump_data *xkd = &xen_kdump_data;
 
 void
 dump_xen_kdump_data(FILE *fp)
diff --git a/xen_dom0.h b/xen_dom0.h
index 4f0ff53..963c75c 100644
--- a/xen_dom0.h
+++ b/xen_dom0.h
@@ -68,6 +68,8 @@ struct xen_kdump_data {
 
 #define P2M_FAILURE ((physaddr_t)(0xffffffffffffffffLL))
 
+extern struct xen_kdump_data *xkd;
+
 void dump_xen_kdump_data(FILE *);
 struct xen_kdump_data *get_xen_kdump_data(void);
 
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
