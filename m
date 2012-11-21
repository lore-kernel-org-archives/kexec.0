Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay1.sgi.com ([192.48.179.29] helo=relay.sgi.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TbGZf-0001pC-Eh
 for kexec@lists.infradead.org; Wed, 21 Nov 2012 20:07:09 +0000
Subject: [PATCH v2] makedumpfile: request the kernel do page scans
Message-Id: <E1TbGZV-0008DR-Tb@eag09.americas.sgi.com>
From: Cliff Wickman <cpw@sgi.com>
Date: Wed, 21 Nov 2012 14:06:57 -0600
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: d.hatayama@jp.fujitsu.com, kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org

From: Cliff Wickman <cpw@sgi.com>

I've been experimenting with asking the kernel to scan the page tables
instead of reading all those page structures through /proc/vmcore.
The results are rather dramatic.
On a small, idle UV: about 4 sec. versus about 40 sec.
On a 8TB UV the unnecessary page scan takes 4 minutes, vs. about 200 min
through /proc/vmcore.

This patch incorporates this scheme into version 1.5.1, so that the cyclic
processing can use the kernel scans.
It also uses the page_is_buddy logic to speed the finding of free pages.
And also allows makedumpfile to work as before with a kernel that does
not provide /proc/vmcore_pfn_lists.

This patch:
  - writes requests to new kernel file /proc/vmcore_pfn_lists
  - makes request PL_REQUEST_MEMMAP to pass the crash kernel information about
    the boot kernel
  - makes requests PL_REQUEST_FREE and PL_REQUEST_EXCLUDE, asking the kernel
    to return lists of PFNs
  - adds page scan timing options -n -o and -t

The patch [PATCH] makedumpfile: fix to exclude_unnecessary_pages_cyclic
is re-done by the below, so that patch should not be applied.

This patch depends on a kernel patch, so I'm also sending one that applies
to a 3.0.13 kernel:
   [PATCH] scan page tables for makedumpfile, 3.0.13 kernel

Diffed against makedumpfile-1.5.1

Signed-off-by: Cliff Wickman <cpw@sgi.com>
---
 dwarf_info.c   |    2 
 makedumpfile.c |  429 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 makedumpfile.h |   91 +++++++++++-
 print_info.c   |    5 
 print_info.h   |    3 
 5 files changed, 507 insertions(+), 23 deletions(-)


Index: makedumpfile-1.5.1/makedumpfile.h
===================================================================
--- makedumpfile-1.5.1.orig/makedumpfile.h
+++ makedumpfile-1.5.1/makedumpfile.h
@@ -421,7 +421,8 @@ do { \
 #define KVER_MIN_SHIFT 16
 #define KERNEL_VERSION(x,y,z) (((x) << KVER_MAJ_SHIFT) | ((y) << KVER_MIN_SHIFT) | (z))
 #define OLDEST_VERSION		KERNEL_VERSION(2, 6, 15)/* linux-2.6.15 */
-#define LATEST_VERSION		KERNEL_VERSION(3, 4, 8)/* linux-3.4.8 */
+//define LATEST_VERSION		KERNEL_VERSION(3, 4, 8)/* linux-3.4.8 */
+#define LATEST_VERSION		KERNEL_VERSION(3, 7, 8)/* linux-3.4.8 */
 
 /*
  * vmcoreinfo in /proc/vmcore
@@ -797,9 +798,20 @@ typedef struct {
 } xen_crash_info_v2_t;
 
 struct mem_map_data {
+	/*
+	 * pfn_start/pfn_end are the pfn's represented by this mem_map entry.
+	 * mem_map is the virtual address of the array of page structures
+	 * that represent this pages.
+	 * paddr is the physical address of that array of structures.
+	 * ending_paddr would be (pfn_end - pfn_start) * sizeof(struct page).
+	 * section_vaddr is the address we get from ioremap_cache().
+	 */
 	unsigned long long	pfn_start;
 	unsigned long long	pfn_end;
-	unsigned long	mem_map;
+	unsigned long		mem_map;
+	unsigned long long	paddr;		/* filled in by makedumpfile */
+	unsigned long long	ending_paddr;	/* filled in by kernel */
+	void 			*section_vaddr;	/* filled in by kernel */
 };
 
 struct dump_bitmap {
@@ -878,6 +890,7 @@ struct DumpInfo {
 	int		flag_rearrange;      /* flag of creating dumpfile from
 						flattened format */
 	int		flag_split;	     /* splitting vmcore */
+	int		flag_use_kernel_lists;
   	int		flag_cyclic;	     /* cyclic processing to keep memory consumption */
 	int		flag_reassemble;     /* reassemble multiple dumpfiles into one */
 	int		flag_refiltering;    /* refilter from kdump-compressed file */
@@ -1393,6 +1406,80 @@ struct domain_list {
 	unsigned int  pickled_id;
 };
 
+#define PL_REQUEST_FREE		1	/* request for a list of free pages */
+#define PL_REQUEST_EXCLUDE	2	/* request for a list of excludable
+					   pages */
+#define PL_REQUEST_MEMMAP	3	/* request to pass in the makedumpfile
+					   mem_map_data table */
+/*
+ * limit the size of the pfn list to this many pfn_element structures
+ */
+#define MAX_PFN_LIST 10000
+
+/*
+ * one element in the pfn_list
+ */
+struct pfn_element {
+	unsigned long pfn;
+	unsigned long order;
+};
+
+/*
+ * a request for finding pfn's that can be excluded from the dump
+ * they may be pages of particular types or free pages
+ */
+struct pfn_list_request {
+	int request;		/* PL_REQUEST_FREE PL_REQUEST_EXCLUDE or */
+				/* PL_REQUEST_MEMMAP */
+	int debug;
+	unsigned long paddr;	/* mem_map address for PL_REQUEST_EXCLUDE */
+	unsigned long pfn_start;/* pfn represented by paddr */
+	unsigned long pgdat_paddr; /* for PL_REQUEST_FREE */
+	unsigned long pgdat_vaddr; /* for PL_REQUEST_FREE */
+	int node;		/* for PL_REQUEST_FREE */
+	int exclude_bits;	/* for PL_REQUEST_EXCLUDE */
+	int count;		/* for PL_REQUEST_EXCLUDE */
+	void *reply_ptr;	/* address of user's pfn_reply, for reply */
+	void *pfn_list_ptr;	/* address of user's pfn array (*pfn_list) */
+	int map_count;		/* for PL_REQUEST_MEMMAP; elements */
+	int map_size;		/* for PL_REQUEST_MEMMAP; bytes in table */
+	void *map_ptr;		/* for PL_REQUEST_MEMMAP; address of table */
+	long list_size;		/* for PL_REQUEST_MEMMAP negotiation */
+	/* resume info: */
+	int more;		/* 0 for done, 1 for "there's more" */
+				/* PL_REQUEST_EXCLUDE: */
+	int map_index;		/* slot in the mem_map array of page structs */
+				/* PL_REQUEST_FREE: */
+	int zone_index;		/* zone within the node's pgdat_list */
+	int freearea_index;	/* free_area within the zone */
+	int type_index;		/* free_list within the free_area */
+	int list_ct;		/* page within the list */
+};
+
+/*
+ * the reply from a pfn_list_request
+ * the list of pfn's itself is pointed to by pfn_list
+ */
+struct pfn_reply {
+	long pfn_list_elements;	/* negoiated on PL_REQUEST_MEMMAP */
+	long in_pfn_list;	/* returned by PL_REQUEST_EXCLUDE and
+				   PL_REQUEST_FREE */
+	/* resume info */
+	int more;		/* 0 == done, 1 == there is more */
+				/* PL_REQUEST_MEMMAP: */
+	int map_index;		/* slot in the mem_map array of page structs */
+				/* PL_REQUEST_FREE: */
+	int zone_index;		/* zone within the node's pgdat_list */
+	int freearea_index;	/* free_area within the zone */
+	int type_index;		/* free_list within the free_area */
+	int list_ct;		/* page within the list */
+	/* statistic counters: */
+	unsigned long long pfn_cache;		/* PL_REQUEST_EXCLUDE */
+	unsigned long long pfn_cache_private;	/* PL_REQUEST_EXCLUDE */
+	unsigned long long pfn_user;		/* PL_REQUEST_EXCLUDE */
+	unsigned long long pfn_free;		/* PL_REQUEST_FREE */
+};
+
 #define PAGES_PER_MAPWORD 	(sizeof(unsigned long) * 8)
 #define MFNS_PER_FRAME		(info->page_size / sizeof(unsigned long))
 
Index: makedumpfile-1.5.1/dwarf_info.c
===================================================================
--- makedumpfile-1.5.1.orig/dwarf_info.c
+++ makedumpfile-1.5.1/dwarf_info.c
@@ -350,6 +350,8 @@ get_data_member_location(Dwarf_Die *die,
 	return TRUE;
 }
 
+int dwarf_formref(Dwarf_Attribute *, Dwarf_Off *);
+
 static int
 get_die_type(Dwarf_Die *die, Dwarf_Die *die_type)
 {
Index: makedumpfile-1.5.1/print_info.c
===================================================================
--- makedumpfile-1.5.1.orig/print_info.c
+++ makedumpfile-1.5.1/print_info.c
@@ -244,6 +244,11 @@ print_usage(void)
 	MSG("  [-f]:\n");
 	MSG("      Overwrite DUMPFILE even if it already exists.\n");
 	MSG("\n");
+	MSG("  [-o]:\n");
+	MSG("      Read page structures from /proc/vmcore in the scan for\n");
+	MSG("      free and excluded pages regardless of whether\n");
+	MSG("      /proc/vmcore_pfn_lists is present.\n");
+	MSG("\n");
 	MSG("  [-h]:\n");
 	MSG("      Show help message and LZO/snappy support status (enabled/disabled).\n");
 	MSG("\n");
Index: makedumpfile-1.5.1/print_info.h
===================================================================
--- makedumpfile-1.5.1.orig/print_info.h
+++ makedumpfile-1.5.1/print_info.h
@@ -43,7 +43,8 @@ void print_execution_time(char *step_nam
  */
 #define MIN_MSG_LEVEL		(0)
 #define MAX_MSG_LEVEL		(31)
-#define DEFAULT_MSG_LEVEL	(7)	/* Print the progress indicator, the
+// cpw: was 7  but add x10 for testing
+#define DEFAULT_MSG_LEVEL	(23)	/* Print the progress indicator, the
 					   common message, the error message */
 #define ML_PRINT_PROGRESS	(0x001) /* Print the progress indicator */
 #define ML_PRINT_COMMON_MSG	(0x002)	/* Print the common message */
Index: makedumpfile-1.5.1/makedumpfile.c
===================================================================
--- makedumpfile-1.5.1.orig/makedumpfile.c
+++ makedumpfile-1.5.1/makedumpfile.c
@@ -13,6 +13,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  */
+#define _GNU_SOURCE
+#include <stdio.h>
 #include "makedumpfile.h"
 #include "print_info.h"
 #include "dwarf_info.h"
@@ -31,6 +33,13 @@ struct srcfile_table	srcfile_table;
 
 struct vm_table		vt = { 0 };
 struct DumpInfo		*info = NULL;
+int pfn_list_fd;
+struct pfn_element *pfn_list;
+int nflag = 0;
+int oflag = 0;
+int tflag = 0;
+struct timeval scan_start;
+int max_pfn_list;
 
 char filename_stdout[] = FILENAME_STDOUT;
 
@@ -420,6 +429,7 @@ get_kernel_version(char *release)
 	/*
 	 * This method checks that vmlinux and vmcore are same kernel version.
 	 */
+release = "3.0.0";
 	start = release;
 	maj = strtol(start, &end, 10);
 	if (maj == LONG_MAX)
@@ -2423,6 +2433,9 @@ get_mm_sparsemem(void)
 	unsigned long long pfn_start, pfn_end;
 	unsigned long section, mem_map;
 	unsigned long *mem_sec = NULL;
+	int i;
+	int num_mem_map;
+	struct mem_map_data *mmd;
 
 	int ret = FALSE;
 
@@ -2467,6 +2480,21 @@ get_mm_sparsemem(void)
 		dump_mem_map(pfn_start, pfn_end, mem_map, section_nr);
 	}
 	ret = TRUE;
+
+	/* add paddr to the table */
+	mmd = &info->mem_map_data[0];
+	num_mem_map = info->num_mem_map;
+	for (i = 0; i < num_mem_map; i++) {
+		if (mmd[i].mem_map == 0) {
+			mmd[i].paddr = 0;
+		} else {
+			mmd[i].paddr = vaddr_to_paddr(mmd[i].mem_map);
+			if (mmd[i].paddr == 0)
+				printf("! can't translate %#lx to paddr\n",
+					mmd[i].mem_map);
+		}
+	}
+
 out:
 	if (mem_sec != NULL)
 		free(mem_sec);
@@ -2841,7 +2869,14 @@ out:
 	if (!get_value_for_old_linux())
 		return FALSE;
 
-	if (info->flag_cyclic && (info->dump_level & DL_EXCLUDE_FREE))
+	/*
+	 * page_is_buddy will tell us whether to find free pages
+	 * in a separate pass, whether cyclic or not.
+	 * With non-cyclic -o we always do a separate free pages pass, so
+	 * do not set up page_is_buddy in that case.
+	 */
+ 	if ((info->flag_cyclic || !oflag) &&
+	    (info->dump_level & DL_EXCLUDE_FREE))
 		setup_page_is_buddy();
 
 	return TRUE;
@@ -3557,6 +3592,65 @@ out:
 	return ret;
 }
 
+/*
+ * let the kernel find excludable pages from one node
+ */
+void
+__exclude_free_pages_kernel(unsigned long pgdat, int node)
+{
+	int i, j, ret, pages;
+	unsigned long pgdat_paddr;
+	struct pfn_list_request request;
+	struct pfn_reply reply;
+	struct pfn_element *pe;
+
+	if ((pgdat_paddr = vaddr_to_paddr(pgdat)) == NOT_PADDR) {
+		ERRMSG("Can't convert virtual address(%#lx) to physical.\n",
+			pgdat);
+		return;
+	}
+
+	/*
+	 * Get the list of free pages.
+	 * This may be broken up into MAX_PFN_list arrays of PFNs.
+	 */
+	memset(&request, 0, sizeof(request));
+	request.request = PL_REQUEST_FREE;
+	request.node = node;
+	request.pgdat_paddr = pgdat_paddr;
+	request.pgdat_vaddr = pgdat;
+	request.reply_ptr = (void *)&reply;
+	request.pfn_list_ptr = (void *)pfn_list;
+	memset(&reply, 0, sizeof(reply));
+
+	do {
+		request.more = 0;
+		if (reply.more) {
+			/* this is to be a continuation of the last request */
+			request.more = 1;
+			request.zone_index = reply.zone_index;
+			request.freearea_index = reply.freearea_index;
+			request.type_index = reply.type_index;
+			request.list_ct = reply.list_ct;
+		}
+		ret = write(pfn_list_fd, &request, sizeof(request));
+		if (ret != sizeof(request)) {
+			printf("PL_REQUEST_FREE failed\n");
+			return;
+		}
+		pfn_free += reply.pfn_free;
+
+		for (i = 0; i < reply.in_pfn_list; i++) {
+			pe = &pfn_list[i];
+			pages = (1 << pe->order);
+                        for (j = 0; j < pages; j++) {
+				clear_bit_on_2nd_bitmap_for_kernel(pe->pfn + j);
+			}
+		}
+	} while (reply.more);
+
+	return;
+}
 
 int
 _exclude_free_page(void)
@@ -3576,7 +3670,24 @@ _exclude_free_page(void)
 	gettimeofday(&tv_start, NULL);
 
 	for (num_nodes = 1; num_nodes <= vt.numnodes; num_nodes++) {
-
+		if (!info->flag_cyclic && info->flag_use_kernel_lists) {
+			node_zones = pgdat + OFFSET(pglist_data.node_zones);
+			if (!readmem(VADDR,
+				pgdat + OFFSET(pglist_data.nr_zones),
+				&nr_zones, sizeof(nr_zones))) {
+					ERRMSG("Can't get nr_zones.\n");
+				return FALSE;
+			}
+			print_progress(PROGRESS_FREE_PAGES, num_nodes - 1,
+								vt.numnodes);
+			/* ask the kernel to do one node */
+			__exclude_free_pages_kernel(pgdat, node);
+			goto next_pgdat;
+		}
+		/*
+		 * kernel does not have the pfn_list capability
+		 * use the old way
+		 */
 		print_progress(PROGRESS_FREE_PAGES, num_nodes - 1, vt.numnodes);
 
 		node_zones = pgdat + OFFSET(pglist_data.node_zones);
@@ -3603,6 +3714,7 @@ _exclude_free_page(void)
 			if (!reset_bitmap_of_free_pages(zone))
 				return FALSE;
 		}
+	next_pgdat:
 		if (num_nodes < vt.numnodes) {
 			if ((node = next_online_node(node + 1)) < 0) {
 				ERRMSG("Can't get next online node.\n");
@@ -3620,6 +3732,8 @@ _exclude_free_page(void)
 	 */
 	print_progress(PROGRESS_FREE_PAGES, vt.numnodes, vt.numnodes);
 	print_execution_time(PROGRESS_FREE_PAGES, &tv_start);
+	if (tflag)
+		print_execution_time("Total time", &scan_start);
 
 	return TRUE;
 }
@@ -3780,7 +3894,6 @@ setup_page_is_buddy(void)
 		}
 	} else
 		info->page_is_buddy = page_is_buddy_v2;
-
 out:
 	if (!info->page_is_buddy)
 		DEBUG_MSG("Can't select page_is_buddy handler; "
@@ -3989,10 +4102,77 @@ exclude_zero_pages(void)
 	return TRUE;
 }
 
+/*
+ * let the kernel find excludable pages from one mem_section
+ */
+int
+__exclude_unnecessary_pages_kernel(int mm, struct mem_map_data *mmd)
+{
+	unsigned long long pfn_start = mmd->pfn_start;
+	unsigned long long pfn_end = mmd->pfn_end;
+	int i, j, ret, pages;
+	struct pfn_list_request request;
+	struct pfn_reply reply;
+	struct pfn_element *pe;
+
+	/*
+	 * Get the list of to-be-excluded pages in this section.
+	 * It may be broken up by groups of max_pfn_list size.
+	 */
+	memset(&request, 0, sizeof(request));
+	request.request = PL_REQUEST_EXCLUDE;
+	request.paddr = mmd->paddr; /* phys addr of mem_map */
+	request.reply_ptr = (void *)&reply;
+	request.pfn_list_ptr = (void *)pfn_list;
+	request.exclude_bits = 0;
+	request.pfn_start = pfn_start;
+	request.count = pfn_end - pfn_start;
+	if (info->dump_level & DL_EXCLUDE_CACHE)
+	 	request.exclude_bits |= DL_EXCLUDE_CACHE;
+	if (info->dump_level & DL_EXCLUDE_CACHE_PRI)
+	 	request.exclude_bits |= DL_EXCLUDE_CACHE_PRI;
+	if (info->dump_level & DL_EXCLUDE_USER_DATA)
+	 	request.exclude_bits |= DL_EXCLUDE_USER_DATA;
+	if (info->dump_level & DL_EXCLUDE_FREE)
+	 	request.exclude_bits |= DL_EXCLUDE_FREE;
+	memset(&reply, 0, sizeof(reply));
+
+	do {
+		/* pfn represented by paddr */
+		request.more = 0;
+		if (reply.more) {
+			/* this is to be a continuation of the last request */
+			request.more = 1;
+			request.map_index = reply.map_index;
+		}
+
+		ret = write(pfn_list_fd, &request, sizeof(request));
+		if (ret != sizeof(request))
+			return FALSE;
+
+		pfn_cache += reply.pfn_cache;
+		pfn_cache_private += reply.pfn_cache_private;
+		pfn_user += reply.pfn_user;
+		pfn_free += reply.pfn_free;
+
+		for (i = 0; i < reply.in_pfn_list; i++) {
+			pe = &pfn_list[i];
+			pages = (1 << pe->order);
+                        for (j = 0; j < pages; j++) {
+				clear_bit_on_2nd_bitmap_for_kernel(pe->pfn + j);
+			}
+		}
+	} while (reply.more);
+
+	return TRUE;
+}
+
 int
-__exclude_unnecessary_pages(unsigned long mem_map,
-    unsigned long long pfn_start, unsigned long long pfn_end)
+__exclude_unnecessary_pages(int mm, struct mem_map_data *mmd)
 {
+	unsigned long long pfn_start = mmd->pfn_start;
+	unsigned long long pfn_end = mmd->pfn_end;
+	unsigned long mem_map = mmd->mem_map;
 	unsigned long long pfn, pfn_mm, maddr;
 	unsigned long long pfn_read_start, pfn_read_end, index_pg;
 	unsigned char page_cache[SIZE(page) * PGMM_CACHED];
@@ -4000,6 +4180,12 @@ __exclude_unnecessary_pages(unsigned lon
 	unsigned int _count, _mapcount = 0;
 	unsigned long flags, mapping, private = 0;
 
+	if (info->flag_use_kernel_lists) {
+		if (__exclude_unnecessary_pages_kernel(mm, mmd) == FALSE)
+			return FALSE;
+		return TRUE;
+	}
+
 	/*
 	 * Refresh the buffer of struct page, when changing mem_map.
 	 */
@@ -4110,19 +4296,175 @@ __exclude_unnecessary_pages(unsigned lon
 	return TRUE;
 }
 
+/*
+ * construct a version of the mem_map_data table to pass to the kernel
+ */
+void *
+make_kernel_mmap(int *kmap_elements, int *kmap_size)
+{
+	int i, j;
+	int elements = 0;
+	int page_structs;
+	int elem;
+	unsigned long base_end_pfn;
+	unsigned long end_paddr;
+	struct mem_map_data *mmdo, *mmdn;
+	struct mem_map_data *mmdbase, *mmdnext, *mmdend, *mmdwork;
+	struct mem_map_data temp_mmd;
+	struct mem_map_data *mmap;
+
+	mmap = malloc(info->num_mem_map * sizeof(struct mem_map_data));
+	if (mmap == NULL) {
+		ERRMSG("Can't allocate memory kernel map\n");
+		return NULL;
+	}
+	for (i = 0, mmdn = mmap, mmdo = &info->mem_map_data[0];
+				i < info->num_mem_map; i++, mmdo++) {
+		if (mmdo->mem_map && mmdo->paddr) {
+			*mmdn = *mmdo;
+			mmdn++;
+			elements++;
+		}
+	}
+
+	/* make sure it is sorted by mem_map (it should be already) */
+	mmdn = mmap;
+	for (i = 0; i < elements - 1; i++) {
+		for (j = i + 1; j < elements; j++) {
+			if (mmdn[j].mem_map < mmdn[i].mem_map) {
+				temp_mmd = mmdn[j];
+				mmdn[j] = mmdn[i];
+				mmdn[i] = temp_mmd;
+			}
+		}
+	}
+
+	/*
+	 * consolidate those mem_map's with occupying consecutive physical
+	 * addresses
+	 *  pages represented by these pages structs:       addr of page struct
+	 * pfns 0x1000000-1008000 mem_map 0xffffea0038000000 paddr 0x11f7e00000
+	 * pfns 0x1008000-1010000 mem_map 0xffffea00381c0000 paddr 0x11f7fc0000
+	 * pfns 0x1010000-1018000 mem_map 0xffffea0038380000 paddr 0x11f8180000
+	 *           8000 increments                             inc's:  1c0000
+	 *        8000000 of memory (128M)                    8000 page structs
+	 *
+	 */
+	mmdbase = mmap;
+	mmdnext = mmap + 1;
+	mmdend = mmap + elements;
+	while (mmdnext < mmdend) {
+		elem = mmdend - mmdnext;
+		/*  test mmdbase vs. mmdwork and onward: */
+		for (i = 0, mmdwork = mmdnext; i < elem; i++, mmdwork++) {
+			base_end_pfn = mmdbase->pfn_end;
+			if (base_end_pfn == mmdwork->pfn_start) {
+				page_structs = (mmdbase->pfn_end -
+							mmdbase->pfn_start);
+				end_paddr = (page_structs * SIZE(page))
+							+ mmdbase->paddr;
+				if (mmdwork->paddr == end_paddr) {
+					/* extend base by the work one */
+					mmdbase->pfn_end = mmdwork->pfn_end;
+					/* next is where to begin next time */
+					mmdnext = mmdwork + 1;
+				} else {
+					/* gap in address of page
+					   structs; end of section */
+					mmdbase++;
+					if (mmdwork - mmdbase > 0)
+						*mmdbase = *mmdwork;
+					mmdnext = mmdwork + 1;
+					break;
+				}
+			} else {
+				/* gap in pfns; end of section */
+				mmdbase++;
+				if (mmdwork - mmdbase > 0)
+					*mmdbase = *mmdwork;
+				mmdnext = mmdwork + 1;
+				break;
+			}
+		}
+	}
+	elements = (mmdbase - mmap) + 1;
+	*kmap_elements = elements;
+	*kmap_size = elements * sizeof(struct mem_map_data);
+	return mmap;
+}
+
+/*
+ * Pass in the mem_map_data table.
+ * Must do this once, and before doing PL_REQUEST_FREE or PL_REQUEST_EXCLUDE.
+ */
+int
+setup_kernel_mmap()
+{
+	int ret;
+	int kmap_elements, kmap_size;
+	long malloc_size;
+	void *kmap_addr;
+	struct pfn_list_request request;
+	struct pfn_reply reply;
+
+	kmap_addr = make_kernel_mmap(&kmap_elements, &kmap_size);
+	if (kmap_addr == NULL)
+		return FALSE;
+	memset(&request, 0, sizeof(request));
+	request.request = PL_REQUEST_MEMMAP;
+	request.map_ptr = kmap_addr;
+	request.reply_ptr = (void *)&reply;
+	request.map_count = kmap_elements;
+	request.map_size = kmap_size;
+	request.list_size = MAX_PFN_LIST;
+
+	ret = write(pfn_list_fd, &request, sizeof(request));
+	if (ret < 0) {
+		fprintf(stderr, "PL_REQUEST_MEMMAP returned %d\n", ret);
+		return FALSE;
+	}
+	/* the reply tells us how long the kernel's list actually is */
+	max_pfn_list = reply.pfn_list_elements;
+	if (max_pfn_list <= 0) {
+		fprintf(stderr,
+			"PL_REQUEST_MEMMAP returned max_pfn_list %d\n",
+			max_pfn_list);
+		return FALSE;
+	}
+	if (max_pfn_list < MAX_PFN_LIST) {
+		printf("length of pfn list dropped from %d to %d\n",
+			MAX_PFN_LIST, max_pfn_list);
+	}
+	free(kmap_addr);
+	/*
+	 * Allocate the buffer for the PFN list (just once).
+	 */
+	malloc_size = max_pfn_list * sizeof(struct pfn_element);
+	if ((pfn_list = (struct pfn_element *)malloc(malloc_size)) == NULL) {
+		ERRMSG("Can't allocate pfn_list of %ld\n", malloc_size);
+		return FALSE;
+	}
+	return TRUE;
+}
+
 int
 exclude_unnecessary_pages(void)
 {
-	unsigned int mm;
-	struct mem_map_data *mmd;
-	struct timeval tv_start;
+ 	unsigned int mm;
+ 	struct mem_map_data *mmd;
+ 	struct timeval tv_start;
 
 	if (is_xen_memory() && !info->dom0_mapnr) {
 		ERRMSG("Can't get max domain-0 PFN for excluding pages.\n");
 		return FALSE;
 	}
 
+	if (!info->flag_cyclic && info->flag_use_kernel_lists) {
+		if (setup_kernel_mmap() == FALSE)
+			return FALSE;
+	}
 	gettimeofday(&tv_start, NULL);
+	gettimeofday(&scan_start, NULL);
 
 	for (mm = 0; mm < info->num_mem_map; mm++) {
 		print_progress(PROGRESS_UNN_PAGES, mm, info->num_mem_map);
@@ -4131,9 +4473,9 @@ exclude_unnecessary_pages(void)
 
 		if (mmd->mem_map == NOT_MEMMAP_ADDR)
 			continue;
-
-		if (!__exclude_unnecessary_pages(mmd->mem_map,
-						 mmd->pfn_start, mmd->pfn_end))
+		if (mmd->paddr == 0)
+			continue;
+		if (!__exclude_unnecessary_pages(mm, mmd))
 			return FALSE;
 	}
 
@@ -4187,9 +4529,10 @@ exclude_unnecessary_pages_cyclic(void)
 			if (mmd->mem_map == NOT_MEMMAP_ADDR)
 				continue;
 
-			if (mmd->pfn_end >= info->cyclic_start_pfn || mmd->pfn_start <= info->cyclic_end_pfn) {
-				if (!__exclude_unnecessary_pages(mmd->mem_map,
-								 mmd->pfn_start, mmd->pfn_end))
+			if (mmd->pfn_end >= info->cyclic_start_pfn &&
+			    mmd->pfn_start <= info->cyclic_end_pfn) {
+				if (__exclude_unnecessary_pages(mm, mmd)
+								== FALSE)
 					return FALSE;
 			}
 		}
@@ -4219,7 +4562,7 @@ update_cyclic_region(unsigned long long 
 	if (!create_1st_bitmap_cyclic())
 		return FALSE;
 
-	if (!exclude_unnecessary_pages_cyclic())
+	if (exclude_unnecessary_pages_cyclic() == FALSE)
 		return FALSE;
 
 	return TRUE;
@@ -4279,16 +4622,17 @@ create_2nd_bitmap(void)
 	if (info->dump_level & DL_EXCLUDE_CACHE ||
 	    info->dump_level & DL_EXCLUDE_CACHE_PRI ||
 	    info->dump_level & DL_EXCLUDE_USER_DATA) {
-		if (!exclude_unnecessary_pages()) {
+		if (exclude_unnecessary_pages() == FALSE) {
 			ERRMSG("Can't exclude unnecessary pages.\n");
 			return FALSE;
 		}
 	}
 
 	/*
-	 * Exclude free pages.
+	 * Exclude free pages. (no separate pass is needed if pages can be
+	 *                      identified as part of the buddy system)
 	 */
-	if (info->dump_level & DL_EXCLUDE_FREE)
+	if ((info->dump_level & DL_EXCLUDE_FREE) && !info->page_is_buddy)
 		if (!exclude_free_page())
 			return FALSE;
 
@@ -4419,6 +4763,10 @@ create_dump_bitmap(void)
 	int ret = FALSE;
 
 	if (info->flag_cyclic) {
+		if (info->flag_use_kernel_lists) {
+			if (setup_kernel_mmap() == FALSE)
+				goto out;
+		}
 		if (!prepare_bitmap_buffer_cyclic())
 			goto out;
 
@@ -4896,6 +5244,7 @@ get_num_dumpable_cyclic(void)
 {
 	unsigned long long pfn, num_dumpable=0;
 
+	gettimeofday(&scan_start, NULL);
 	for (pfn = 0; pfn < info->max_mapnr; pfn++) {
 		if (!update_cyclic_region(pfn))
 			return FALSE;
@@ -5225,7 +5574,7 @@ get_loads_dumpfile_cyclic(void)
 	info->cyclic_end_pfn = info->pfn_cyclic;
 	if (!create_1st_bitmap_cyclic())
 		return FALSE;
-	if (!exclude_unnecessary_pages_cyclic())
+	if (exclude_unnecessary_pages_cyclic() == FALSE)
 		return FALSE;
 
 	if (!(phnum = get_phnum_memory()))
@@ -5792,6 +6141,7 @@ write_kdump_pages_cyclic(struct cache_da
 	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
 
 		if ((num_dumped % per) == 0)
+
 			print_progress(PROGRESS_COPY, num_dumped, info->num_dumpable);
 
 		/*
@@ -6232,6 +6582,8 @@ write_kdump_pages_and_bitmap_cyclic(stru
 		if (!update_cyclic_region(pfn))
                         return FALSE;
 
+		if (tflag)
+			print_execution_time("Total time", &scan_start);
 		if (!write_kdump_pages_cyclic(cd_header, cd_page, &pd_zero, &offset_data))
 			return FALSE;
 
@@ -7365,6 +7717,11 @@ retry:
 		if ((status = writeout_multiple_dumpfiles()) == FALSE)
 			return FALSE;
 	} else {
+		if (nflag) { /* a bit too early for the cyclic case */
+			printf("\n");
+			print_report();
+			return TRUE;
+		}
 		if ((status = writeout_dumpfile()) == FALSE)
 			return FALSE;
 	}
@@ -8257,6 +8614,22 @@ static struct option longopts[] = {
 	{0, 0, 0, 0}
 };
 
+/*
+ * test for the presence of capability in the kernel to provide lists
+ * of pfn's:
+ *   /proc/vmcore_pfn_lists
+ * return 1 for present
+ * return 0 for not present
+ */
+int
+test_kernel_pfn_lists(void)
+{
+	if ((pfn_list_fd = open("/proc/vmcore_pfn_lists", O_WRONLY)) < 0) {
+		return 0;
+	}
+	return 1;
+}
+
 int
 main(int argc, char *argv[])
 {
@@ -8282,7 +8655,7 @@ main(int argc, char *argv[])
 	
 	info->block_order = DEFAULT_ORDER;
 	message_level = DEFAULT_MSG_LEVEL;
-	while ((opt = getopt_long(argc, argv, "b:cDd:EFfg:hi:lMpRrsvXx:", longopts,
+	while ((opt = getopt_long(argc, argv, "b:cDd:EFfg:hi:MnoRrstVvXx:Y", longopts,
 	    NULL)) != -1) {
 		switch (opt) {
 		case 'b':
@@ -8340,6 +8713,13 @@ main(int argc, char *argv[])
 		case 'M':
 			info->flag_dmesg = 1;
 			break;
+		case 'n':
+			/* -n undocumented, for testing page scanning time */
+			nflag = 1;
+			break;
+		case 'o':
+			oflag = 1;
+			break;
 		case 'p':
 			info->flag_compress = DUMP_DH_COMPRESSED_SNAPPY;
 			break;
@@ -8358,6 +8738,9 @@ main(int argc, char *argv[])
 		case 'r':
 			info->flag_reassemble = 1;
 			break;
+		case 't':
+			tflag = 1;
+			break;
 		case 'V':
 			info->vaddr_for_vtop = strtoul(optarg, NULL, 0);
 			break;
@@ -8389,6 +8772,12 @@ main(int argc, char *argv[])
 			goto out;
 		}
 	}
+
+	if (oflag)
+		info->flag_use_kernel_lists = 0;
+	else
+		info->flag_use_kernel_lists = test_kernel_pfn_lists();
+
 	if (flag_debug)
 		message_level |= ML_PRINT_DEBUG_MSG;
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
