Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rcsinet15.oracle.com ([148.87.113.117])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SzpIa-0004sn-S4
 for kexec@lists.infradead.org; Fri, 10 Aug 2012 13:30:46 +0000
Date: Fri, 10 Aug 2012 15:29:22 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH v2 6/6] xen: Add support for 3 level P2M tree
Message-ID: <20120810132922.GG2576@host-192-168-1-59.local.net-space.pl>
MIME-Version: 1.0
Content-Disposition: inline
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
To: anderson@redhat.com, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, olaf@aepfle.de, jbeulich@suse.com, ptesarik@suse.cz, crash-utility@redhat.com, kexec@lists.infradead.org, xen-devel@lists.xensource.com

Linux Kernel commit 58e05027b530ff081ecea68e38de8d59db8f87e0 (xen: convert
p2m to a 3 level tree) introduced 3 level P2M tree. Add support for this.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>

diff -Npru crash-6.0.8.orig/defs.h crash-6.0.8/defs.h
--- crash-6.0.8.orig/defs.h	2012-06-29 16:59:18.000000000 +0200
+++ crash-6.0.8/defs.h	2012-08-06 23:32:31.000000000 +0200
@@ -595,6 +595,10 @@ struct new_utsname {
 
 #define XEN_MACHADDR_NOT_FOUND   (~0ULL) 
 
+#define XEN_P2M_PER_PAGE	(PAGESIZE() / sizeof(unsigned long))
+#define XEN_P2M_MID_PER_PAGE	(PAGESIZE() / sizeof(unsigned long *))
+#define XEN_P2M_TOP_PER_PAGE	(PAGESIZE() / sizeof(unsigned long **))
+
 struct kernel_table {                   /* kernel data */
 	ulong flags;
 	ulong stext;
@@ -655,6 +659,7 @@ struct kernel_table {                   
 	struct pvops_xen_info {
 		int p2m_top_entries;
 		ulong p2m_top;
+		ulong p2m_mid_missing;
 		ulong p2m_missing;
 	} pvops_xen;
 	int highest_irq;
diff -Npru crash-6.0.8.orig/kernel.c crash-6.0.8/kernel.c
--- crash-6.0.8.orig/kernel.c	2012-06-29 16:59:18.000000000 +0200
+++ crash-6.0.8/kernel.c	2012-08-07 13:44:12.000000000 +0200
@@ -49,6 +49,8 @@ static void verify_namelist(void);
 static char *debug_kernel_version(char *);
 static int restore_stack(struct bt_info *);
 static ulong __xen_m2p(ulonglong, ulong);
+static ulong __xen_pvops_m2p_l2(ulonglong, ulong);
+static ulong __xen_pvops_m2p_l3(ulonglong, ulong);
 static int search_mapping_page(ulong, ulong *, ulong *, ulong *);
 static void read_in_kernel_config_err(int, char *);
 static void BUG_bytes_init(void);
@@ -147,9 +149,19 @@ kernel_init()
                 if ((kt->m2p_page = (char *)malloc(PAGESIZE())) == NULL)
                        	error(FATAL, "cannot malloc m2p page.");
 
-		kt->pvops_xen.p2m_top_entries = get_array_length("p2m_top", NULL, 0);
-		kt->pvops_xen.p2m_top = symbol_value("p2m_top");
-		kt->pvops_xen.p2m_missing = symbol_value("p2m_missing");
+		if (symbol_exists("p2m_mid_missing")) {
+			kt->pvops_xen.p2m_top_entries = XEN_P2M_TOP_PER_PAGE;
+			get_symbol_data("p2m_top", sizeof(ulong),
+						&kt->pvops_xen.p2m_top);
+			get_symbol_data("p2m_mid_missing", sizeof(ulong),
+						&kt->pvops_xen.p2m_mid_missing);
+			get_symbol_data("p2m_missing", sizeof(ulong),
+						&kt->pvops_xen.p2m_missing);
+		} else {
+			kt->pvops_xen.p2m_top_entries = get_array_length("p2m_top", NULL, 0);
+			kt->pvops_xen.p2m_top = symbol_value("p2m_top");
+			kt->pvops_xen.p2m_missing = symbol_value("p2m_missing");
+		}
 	}
 
 	if (symbol_exists("smp_num_cpus")) {
@@ -5044,6 +5056,8 @@ no_cpu_flags:
 	fprintf(fp, "              pvops_xen:\n");
 	fprintf(fp, "                    p2m_top: %lx\n", kt->pvops_xen.p2m_top);
 	fprintf(fp, "            p2m_top_entries: %d\n", kt->pvops_xen.p2m_top_entries);
+	if (symbol_exists("p2m_mid_missing"))
+		fprintf(fp, "            p2m_mid_missing: %lx\n", kt->pvops_xen.p2m_mid_missing);
 	fprintf(fp, "                p2m_missing: %lx\n", kt->pvops_xen.p2m_missing);
 }
 
@@ -7391,15 +7405,9 @@ xen_m2p(ulonglong machine)
 static ulong
 __xen_m2p(ulonglong machine, ulong mfn)
 {
-	ulong mapping, p2m, kmfn, pfn, p, i, e, c;
+	ulong c, i, kmfn, mapping, p, pfn;
 	ulong start, end;
-	ulong *mp;
-
-	mp = (ulong *)kt->m2p_page;
-	if (PVOPS_XEN())
-		mapping = UNINITIALIZED;
-	else
-		mapping = kt->phys_to_machine_mapping;
+	ulong *mp = (ulong *)kt->m2p_page;
 
 	/*
 	 *  Check the FIFO cache first.
@@ -7449,55 +7457,21 @@ __xen_m2p(ulonglong machine, ulong mfn)
 		 *  beginning of the p2m_top array, caching the contiguous
 		 *  range containing the found machine address.
 		 */
-		for (e = p = 0, p2m = kt->pvops_xen.p2m_top;
-		     e < kt->pvops_xen.p2m_top_entries; 
-		     e++, p += XEN_PFNS_PER_PAGE, p2m += sizeof(void *)) {
-
-			if (!readmem(p2m, KVADDR, &mapping,
-			    sizeof(void *), "p2m_top", RETURN_ON_ERROR))
-				error(FATAL, "cannot access p2m_top[] entry\n");
-
-			if (mapping != kt->last_mapping_read) {
-				if (mapping != kt->pvops_xen.p2m_missing) {
-					if (!readmem(mapping, KVADDR, mp, 
-					    PAGESIZE(), "p2m_top page", 
-					    RETURN_ON_ERROR))
-						error(FATAL, 
-				     	    	    "cannot access "
-						    "p2m_top[] page\n");
-					kt->last_mapping_read = mapping;
-				}
-			}
-
-			if (mapping == kt->pvops_xen.p2m_missing)
-				continue;
-
-			kt->p2m_pages_searched++;
+		if (symbol_exists("p2m_mid_missing"))
+			pfn = __xen_pvops_m2p_l3(machine, mfn);
+		else
+			pfn = __xen_pvops_m2p_l2(machine, mfn);
 
-			if (search_mapping_page(mfn, &i, &start, &end)) {
-				pfn = p + i;
-				if (CRASHDEBUG(1))
-				    console("pages: %d mfn: %lx (%llx) p: %ld"
-					" i: %ld pfn: %lx (%llx)\n",
-					(p/XEN_PFNS_PER_PAGE)+1, mfn, machine,
-					p, i, pfn, XEN_PFN_TO_PSEUDO(pfn));
-	
-				c = kt->p2m_cache_index;
-				kt->p2m_mapping_cache[c].start = start;
-				kt->p2m_mapping_cache[c].end = end;
-				kt->p2m_mapping_cache[c].mapping = mapping;
-				kt->p2m_mapping_cache[c].pfn = p;
-				kt->p2m_cache_index = (c+1) % P2M_MAPPING_CACHE;
-	
-				return pfn;
-			}
-		}
+		if (pfn != XEN_MFN_NOT_FOUND)
+			return pfn;
 	} else {
 		/*
 		 *  The machine address was not cached, so search from the
 		 *  beginning of the phys_to_machine_mapping array, caching
 		 *  the contiguous range containing the found machine address.
 		 */
+		mapping = kt->phys_to_machine_mapping;
+
 		for (p = 0; p < kt->p2m_table_size; p += XEN_PFNS_PER_PAGE) 
 		{
 			if (mapping != kt->last_mapping_read) {
@@ -7540,6 +7514,115 @@ __xen_m2p(ulonglong machine, ulong mfn)
 	return (XEN_MFN_NOT_FOUND);
 }
 
+static ulong
+__xen_pvops_m2p_l2(ulonglong machine, ulong mfn)
+{
+	ulong c, e, end, i, mapping, p, p2m, pfn, start;
+
+	for (e = p = 0, p2m = kt->pvops_xen.p2m_top;
+	     e < kt->pvops_xen.p2m_top_entries;
+	     e++, p += XEN_PFNS_PER_PAGE, p2m += sizeof(void *)) {
+
+		if (!readmem(p2m, KVADDR, &mapping, sizeof(void *),
+						"p2m_top", RETURN_ON_ERROR))
+			error(FATAL, "cannot access p2m_top[] entry\n");
+
+		if (mapping == kt->pvops_xen.p2m_missing)
+			continue;
+
+		if (mapping != kt->last_mapping_read) {
+			if (!readmem(mapping, KVADDR, (void *)kt->m2p_page,
+					PAGESIZE(), "p2m_top page", RETURN_ON_ERROR))
+				error(FATAL, "cannot access p2m_top[] page\n");
+
+			kt->last_mapping_read = mapping;
+		}
+
+		kt->p2m_pages_searched++;
+
+		if (search_mapping_page(mfn, &i, &start, &end)) {
+			pfn = p + i;
+			if (CRASHDEBUG(1))
+			    console("pages: %d mfn: %lx (%llx) p: %ld"
+				" i: %ld pfn: %lx (%llx)\n",
+				(p/XEN_PFNS_PER_PAGE)+1, mfn, machine,
+				p, i, pfn, XEN_PFN_TO_PSEUDO(pfn));
+
+			c = kt->p2m_cache_index;
+			kt->p2m_mapping_cache[c].start = start;
+			kt->p2m_mapping_cache[c].end = end;
+			kt->p2m_mapping_cache[c].mapping = mapping;
+			kt->p2m_mapping_cache[c].pfn = p;
+			kt->p2m_cache_index = (c+1) % P2M_MAPPING_CACHE;
+
+			return pfn;
+		}
+	}
+
+	return XEN_MFN_NOT_FOUND;
+}
+
+static ulong
+__xen_pvops_m2p_l3(ulonglong machine, ulong mfn)
+{
+	ulong c, end, i, j, k, mapping, p;
+	ulong p2m_mid, p2m_top, pfn, start;
+
+	p2m_top = kt->pvops_xen.p2m_top;
+
+	for (i = 0; i < XEN_P2M_TOP_PER_PAGE; ++i, p2m_top += sizeof(void *)) {
+		if (!readmem(p2m_top, KVADDR, &mapping,
+				sizeof(void *), "p2m_top", RETURN_ON_ERROR))
+			error(FATAL, "cannot access p2m_top[] entry\n");
+
+		if (mapping == kt->pvops_xen.p2m_mid_missing)
+			continue;
+
+		p2m_mid = mapping;
+
+		for (j = 0; j < XEN_P2M_MID_PER_PAGE; ++j, p2m_mid += sizeof(void *)) {
+			if (!readmem(p2m_mid, KVADDR, &mapping,
+					sizeof(void *), "p2m_mid", RETURN_ON_ERROR))
+				error(FATAL, "cannot access p2m_mid[] entry\n");
+
+			if (mapping == kt->pvops_xen.p2m_missing)
+				continue;
+
+			if (mapping != kt->last_mapping_read) {
+				if (!readmem(mapping, KVADDR, (void *)kt->m2p_page,
+						PAGESIZE(), "p2m_mid page", RETURN_ON_ERROR))
+					error(FATAL, "cannot access p2m_mid[] page\n");
+
+				kt->last_mapping_read = mapping;
+			}
+
+			if (!search_mapping_page(mfn, &k, &start, &end))
+				continue;
+
+			p = i * XEN_P2M_MID_PER_PAGE * XEN_P2M_PER_PAGE;
+			p += j * XEN_P2M_PER_PAGE;
+			pfn = p + k;
+
+			if (CRASHDEBUG(1))
+				console("pages: %d mfn: %lx (%llx) p: %ld"
+					" i: %ld j: %ld k: %ld pfn: %lx (%llx)\n",
+					(p / XEN_P2M_PER_PAGE) + 1, mfn, machine,
+					p, i, j, k, pfn, XEN_PFN_TO_PSEUDO(pfn));
+
+			c = kt->p2m_cache_index;
+			kt->p2m_mapping_cache[c].start = start;
+			kt->p2m_mapping_cache[c].end = end;
+			kt->p2m_mapping_cache[c].mapping = mapping;
+			kt->p2m_mapping_cache[c].pfn = p;
+			kt->p2m_cache_index = (c + 1) % P2M_MAPPING_CACHE;
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
diff -Npru crash-6.0.8.orig/x86.c crash-6.0.8/x86.c
--- crash-6.0.8.orig/x86.c	2012-06-29 16:59:18.000000000 +0200
+++ crash-6.0.8/x86.c	2012-08-07 13:26:27.000000000 +0200
@@ -1024,6 +1024,8 @@ static void x86_init_kernel_pgd(void);
 static ulong xen_m2p_nonPAE(ulong);
 static int x86_xendump_p2m_create(struct xendump_data *);
 static int x86_pvops_xendump_p2m_create(struct xendump_data *);
+static int x86_pvops_xendump_p2m_l2_create(struct xendump_data *);
+static int x86_pvops_xendump_p2m_l3_create(struct xendump_data *);
 static void x86_debug_dump_page(FILE *, char *, char *);
 static int x86_xen_kdump_p2m_create(struct xen_kdump_data *);
 static char *x86_xen_kdump_load_page(ulong, char *);
@@ -4969,7 +4971,7 @@ x86_xendump_p2m_create(struct xendump_da
 static int 
 x86_pvops_xendump_p2m_create(struct xendump_data *xd)
 {
-	int i, p, idx;
+	int i;
 	ulong mfn, kvaddr, ctrlreg[8], ctrlreg_offset;
 	ulong *up;
 	ulonglong *ulp;
@@ -5040,21 +5042,29 @@ x86_pvops_xendump_p2m_create(struct xend
 	    malloc(xd->xc_core.p2m_frames * sizeof(int))) == NULL)
         	error(FATAL, "cannot malloc p2m_frame_index_list");
 
+	if (symbol_exists("p2m_mid_missing"))
+		return x86_pvops_xendump_p2m_l3_create(xd);
+	else
+		return x86_pvops_xendump_p2m_l2_create(xd);
+}
+
+static int x86_pvops_xendump_p2m_l2_create(struct xendump_data *xd)
+{
+	int i, idx, p;
+	ulong kvaddr, *up;
+
 	machdep->last_ptbl_read = BADADDR;
 	machdep->last_pmd_read = BADADDR;
+
 	kvaddr = symbol_value("p2m_top");
 
 	for (p = 0; p < xd->xc_core.p2m_frames; p += XEN_PFNS_PER_PAGE) {
 		if (!x86_xendump_load_page(kvaddr, xd->page))
 			return FALSE;
 
-		if ((idx = x86_xendump_page_index(kvaddr)) == MFN_NOT_FOUND)
-			return FALSE;
-
-		if (CRASHDEBUG(7)) {
-			x86_debug_dump_page(xd->ofp, xd->page,
-				"contents of page:");
-		}
+		if (CRASHDEBUG(7))
+ 			x86_debug_dump_page(xd->ofp, xd->page,
+                       		"contents of page:");
 
 		up = (ulong *)(xd->page);
 
@@ -5067,7 +5077,7 @@ x86_pvops_xendump_p2m_create(struct xend
 		}
 
 		kvaddr += PAGESIZE();
-        }
+	}
 
 	machdep->last_ptbl_read = 0;
 	machdep->last_pmd_read = 0;
@@ -5075,6 +5085,94 @@ x86_pvops_xendump_p2m_create(struct xend
 	return TRUE;
 }
 
+static int x86_pvops_xendump_p2m_l3_create(struct xendump_data *xd)
+{
+	int i, idx, j, p2m_frame, ret = FALSE;
+	ulong kvaddr, *p2m_mid, p2m_mid_missing, p2m_missing, *p2m_top;
+
+	machdep->last_ptbl_read = BADADDR;
+	machdep->last_pmd_read = BADADDR;
+
+	kvaddr = symbol_value("p2m_missing");
+
+	if (!x86_xendump_load_page(kvaddr, xd->page))
+		goto err;
+
+	p2m_missing = *(ulong *)(xd->page + PAGEOFFSET(kvaddr));
+
+	kvaddr = symbol_value("p2m_mid_missing");
+
+	if (!x86_xendump_load_page(kvaddr, xd->page))
+		goto err;
+
+	p2m_mid_missing = *(ulong *)(xd->page + PAGEOFFSET(kvaddr));
+
+	kvaddr = symbol_value("p2m_top");
+
+	if (!x86_xendump_load_page(kvaddr, xd->page))
+		goto err;
+
+	kvaddr = *(ulong *)(xd->page + PAGEOFFSET(kvaddr));
+
+	if (!x86_xendump_load_page(kvaddr, xd->page))
+		goto err;
+
+	if (CRASHDEBUG(7))
+		x86_debug_dump_page(xd->ofp, xd->page,
+					"contents of p2m_top page:");
+
+	p2m_top = malloc(PAGESIZE());
+
+	if (!p2m_top)
+		error(FATAL, "cannot malloc p2m_top");
+
+	memcpy(p2m_top, xd->page, PAGESIZE());
+
+	for (i = 0; i < XEN_P2M_TOP_PER_PAGE; ++i) {
+		p2m_frame = i * XEN_P2M_MID_PER_PAGE;
+
+		if (p2m_frame >= xd->xc_core.p2m_frames)
+			break;
+
+		if (p2m_top[i] == p2m_mid_missing)
+			continue;
+
+		if (!x86_xendump_load_page(p2m_top[i], xd->page))
+			goto err;
+
+		if (CRASHDEBUG(7))
+			x86_debug_dump_page(xd->ofp, xd->page,
+						"contents of p2m_mid page:");
+
+		p2m_mid = (ulong *)xd->page;
+
+		for (j = 0; j < XEN_P2M_MID_PER_PAGE; ++j, ++p2m_frame) {
+			if (p2m_frame >= xd->xc_core.p2m_frames)
+				break;
+
+			if (p2m_mid[j] == p2m_missing)
+				continue;
+
+			idx = x86_xendump_page_index(p2m_mid[j]);
+
+			if (idx == MFN_NOT_FOUND)
+				goto err;
+
+			xd->xc_core.p2m_frame_index_list[p2m_frame] = idx;
+		}
+	}
+
+	machdep->last_ptbl_read = 0;
+	machdep->last_pmd_read = 0;
+
+	ret = TRUE;
+
+err:
+	free(p2m_top);
+
+	return ret;
+}
+
 static void
 x86_debug_dump_page(FILE *ofp, char *page, char *name)
 {
diff -Npru crash-6.0.8.orig/x86_64.c crash-6.0.8/x86_64.c
--- crash-6.0.8.orig/x86_64.c	2012-06-29 16:59:18.000000000 +0200
+++ crash-6.0.8/x86_64.c	2012-08-07 13:32:34.000000000 +0200
@@ -91,6 +91,8 @@ static void x86_64_framepointer_init(voi
 static int x86_64_virt_phys_base(void);
 static int x86_64_xendump_p2m_create(struct xendump_data *);
 static int x86_64_pvops_xendump_p2m_create(struct xendump_data *);
+static int x86_64_pvops_xendump_p2m_l2_create(struct xendump_data *);
+static int x86_64_pvops_xendump_p2m_l3_create(struct xendump_data *);
 static char *x86_64_xendump_load_page(ulong, struct xendump_data *);
 static int x86_64_xendump_page_index(ulong, struct xendump_data *);
 static int x86_64_xen_kdump_p2m_create(struct xen_kdump_data *);
@@ -6078,7 +6080,7 @@ x86_64_xendump_p2m_create(struct xendump
 static int 
 x86_64_pvops_xendump_p2m_create(struct xendump_data *xd)
 {
-	int i, p, idx;
+	int i;
 	ulong mfn, kvaddr, ctrlreg[8], ctrlreg_offset;
 	ulong *up;
 	off_t offset; 
@@ -6138,20 +6140,28 @@ x86_64_pvops_xendump_p2m_create(struct x
 	    malloc(xd->xc_core.p2m_frames * sizeof(ulong))) == NULL)
         	error(FATAL, "cannot malloc p2m_frame_list");
 
+	if (symbol_exists("p2m_mid_missing"))
+		return x86_64_pvops_xendump_p2m_l3_create(xd);
+	else
+		return x86_64_pvops_xendump_p2m_l2_create(xd);
+}
+
+static int x86_64_pvops_xendump_p2m_l2_create(struct xendump_data *xd)
+{
+	int i, idx, p;
+	ulong kvaddr, *up;
+
 	machdep->last_ptbl_read = BADADDR;
+
 	kvaddr = symbol_value("p2m_top");
 
 	for (p = 0; p < xd->xc_core.p2m_frames; p += XEN_PFNS_PER_PAGE) {
 		if (!x86_64_xendump_load_page(kvaddr, xd))
 			return FALSE;
 
-		if ((idx = x86_64_xendump_page_index(kvaddr, xd)) == MFN_NOT_FOUND)
-			return FALSE;
-
-		if (CRASHDEBUG(7)) {
+		if (CRASHDEBUG(7))
  			x86_64_debug_dump_page(xd->ofp, xd->page,
                        		"contents of page:");
-		}
 
 		up = (ulong *)(xd->page);
 
@@ -6160,17 +6170,103 @@ x86_64_pvops_xendump_p2m_create(struct x
 				break;
 			if ((idx = x86_64_xendump_page_index(*up, xd)) == MFN_NOT_FOUND)
 				return FALSE;
-			xd->xc_core.p2m_frame_index_list[p+i] = idx; 
+			xd->xc_core.p2m_frame_index_list[p+i] = idx;
 		}
 
 		kvaddr += PAGESIZE();
 	}
-	
+
 	machdep->last_ptbl_read = 0;
 
 	return TRUE;
 }
 
+static int x86_64_pvops_xendump_p2m_l3_create(struct xendump_data *xd)
+{
+	int i, idx, j, p2m_frame, ret = FALSE;
+	ulong kvaddr, *p2m_mid, p2m_mid_missing, p2m_missing, *p2m_top;
+
+	machdep->last_ptbl_read = BADADDR;
+
+	kvaddr = symbol_value("p2m_missing");
+
+	if (!x86_64_xendump_load_page(kvaddr, xd))
+		goto err;
+
+	p2m_missing = *(ulong *)(xd->page + PAGEOFFSET(kvaddr));
+
+	kvaddr = symbol_value("p2m_mid_missing");
+
+	if (!x86_64_xendump_load_page(kvaddr, xd))
+		goto err;
+
+	p2m_mid_missing = *(ulong *)(xd->page + PAGEOFFSET(kvaddr));
+
+	kvaddr = symbol_value("p2m_top");
+
+	if (!x86_64_xendump_load_page(kvaddr, xd))
+		goto err;
+
+	kvaddr = *(ulong *)(xd->page + PAGEOFFSET(kvaddr));
+
+	if (!x86_64_xendump_load_page(kvaddr, xd))
+		goto err;
+
+	if (CRASHDEBUG(7))
+		x86_64_debug_dump_page(xd->ofp, xd->page,
+					"contents of p2m_top page:");
+
+	p2m_top = malloc(PAGESIZE());
+
+	if (!p2m_top)
+		error(FATAL, "cannot malloc p2m_top");
+
+	memcpy(p2m_top, xd->page, PAGESIZE());
+
+	for (i = 0; i < XEN_P2M_TOP_PER_PAGE; ++i) {
+		p2m_frame = i * XEN_P2M_MID_PER_PAGE;
+
+		if (p2m_frame >= xd->xc_core.p2m_frames)
+			break;
+
+		if (p2m_top[i] == p2m_mid_missing)
+			continue;
+
+		if (!x86_64_xendump_load_page(p2m_top[i], xd))
+			goto err;
+
+		if (CRASHDEBUG(7))
+			x86_64_debug_dump_page(xd->ofp, xd->page,
+						"contents of p2m_mid page:");
+
+		p2m_mid = (ulong *)xd->page;
+
+		for (j = 0; j < XEN_P2M_MID_PER_PAGE; ++j, ++p2m_frame) {
+			if (p2m_frame >= xd->xc_core.p2m_frames)
+				break;
+
+			if (p2m_mid[j] == p2m_missing)
+				continue;
+
+			idx = x86_64_xendump_page_index(p2m_mid[j], xd);
+
+			if (idx == MFN_NOT_FOUND)
+				goto err;
+
+			xd->xc_core.p2m_frame_index_list[p2m_frame] = idx;
+		}
+	}
+
+	machdep->last_ptbl_read = 0;
+
+	ret = TRUE;
+
+err:
+	free(p2m_top);
+
+	return ret;
+}
+
 static void
 x86_64_debug_dump_page(FILE *ofp, char *page, char *name)
 {

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
