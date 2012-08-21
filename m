Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T3qO3-0002t7-Cd
 for kexec@lists.infradead.org; Tue, 21 Aug 2012 15:29:00 +0000
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 7F251A3DD6
 for <kexec@lists.infradead.org>; Tue, 21 Aug 2012 17:28:58 +0200 (CEST)
Resent-To: kexec@lists.infradead.org
Resent-Message-ID: <201208211728.58251.ptesarik@suse.cz>
Message-Id: <20120821084453.057322083@azariah.suse.cz>
Date: Tue, 21 Aug 2012 10:44:59 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: [patch 8/9] Add support for filtering out user pages under Xen4
References: <20120821084451.587187471@azariah.suse.cz>
Content-Disposition: inline; filename=08-xen4-exclude-user.patch
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
To: kexec@lists.infradead.org
Cc: Petr Tesarik <ptesarik@suse.cz>, Norbert Trapp <norbert.trapp@ts.fujitsu.com>

In Xen-4.0+, usage of a page must be determined from its PGC_xxx
flags, which are stored in the highest bits of the _count field
of struct page_info.

Let's keep the original function for Xen3 only and add a new
function for walking the pages under Xen4. This avoids adding many
new conditionals to the inner loop and also makes the logic easier
to follow for all Xen versions.

Signed-off-by: Norbert Trapp <norbert.trapp@ts.fujitsu.com>
Signed-off-by: Petr Tesarik <ptesarik@suse.cz>

---
 makedumpfile.c |  103 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
 makedumpfile.h |   25 +++++++++++++
 2 files changed, 122 insertions(+), 6 deletions(-)

--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -78,6 +78,31 @@ int get_mem_type(void);
 #define LSEEKED_PDATA	(3)
 
 /*
+ * Xen page flags
+ */
+#define BITS_PER_BYTE (8)
+#define BITS_PER_LONG (BITS_PER_BYTE * sizeof(long))
+#define PG_shift(idx)	(BITS_PER_LONG - (idx))
+#define PG_mask(x, idx)	(x ## UL << PG_shift(idx))
+ /* Cleared when the owning guest 'frees' this page. */
+#define PGC_allocated       PG_mask(1, 1)
+ /* Page is Xen heap? */
+#define PGC_xen_heap        PG_mask(1, 2)
+ /* Page is broken? */
+#define PGC_broken          PG_mask(1, 7)
+ /* Mutually-exclusive page states: { inuse, offlining, offlined, free }. */
+#define PGC_state           PG_mask(3, 9)
+#define PGC_state_inuse     PG_mask(0, 9)
+#define PGC_state_offlining PG_mask(1, 9)
+#define PGC_state_offlined  PG_mask(2, 9)
+#define PGC_state_free      PG_mask(3, 9)
+#define page_state_is(ci, st) (((ci)&PGC_state) == PGC_state_##st)
+
+ /* Count of references to this frame. */
+#define PGC_count_width   PG_shift(9)
+#define PGC_count_mask    ((1UL<<PGC_count_width)-1)
+
+/*
  * Memory flags
  */
 #define MEMORY_PAGETABLE_4L	(1 << 0)
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -5719,7 +5719,7 @@ is_select_domain(unsigned int id)
 }
 
 int
-exclude_xen_user_domain(void)
+exclude_xen3_user_domain(void)
 {
 	int i;
 	unsigned int count_info, _domain;
@@ -5728,9 +5728,6 @@ exclude_xen_user_domain(void)
 	unsigned long long phys_start, phys_end;
 	unsigned long long pfn, pfn_end;
 	unsigned long long j, size;
-	struct timeval tv_start;
-
-	gettimeofday(&tv_start, NULL);
 
 	/*
 	 * NOTE: the first half of bitmap is not used for Xen extraction
@@ -5781,13 +5778,107 @@ exclude_xen_user_domain(void)
 		}
 	}
 
+	return TRUE;
+}
+
+int
+exclude_xen4_user_domain(void)
+{
+	int i;
+	unsigned long count_info;
+	unsigned int  _domain;
+	unsigned int num_pt_loads = get_num_pt_loads();
+	unsigned long page_info_addr;
+	unsigned long long phys_start, phys_end;
+	unsigned long long pfn, pfn_end;
+	unsigned long long j, size;
+
+	/*
+	 * NOTE: the first half of bitmap is not used for Xen extraction
+	 */
+	for (i = 0; get_pt_load(i, &phys_start, &phys_end, NULL, NULL); i++) {
+
+		print_progress(PROGRESS_XEN_DOMAIN, i, num_pt_loads);
+
+		pfn     = paddr_to_pfn(phys_start);
+		pfn_end = paddr_to_pfn(phys_end);
+		size    = pfn_end - pfn;
+
+		for (j = 0; pfn < pfn_end; pfn++, j++) {
+			print_progress(PROGRESS_XEN_DOMAIN, j + (size * i),
+					size * num_pt_loads);
+
+			page_info_addr = info->frame_table_vaddr + pfn * SIZE(page_info);
+			if (!readmem(VADDR_XEN,
+			      page_info_addr + OFFSET(page_info.count_info),
+		 	      &count_info, sizeof(count_info))) {
+				clear_bit_on_2nd_bitmap(pfn);
+				continue;	/* page_info may not exist */
+			}
+
+			/* delete free and offlined pages
+			 * Note: Broken pages also get offlined
+			 */
+			if (page_state_is(count_info, free) ||
+			    page_state_is(count_info, offlined)) {
+				clear_bit_on_2nd_bitmap(pfn);
+				continue;
+			}
+
+			/* always keep Xen heap pages */
+			if (count_info & PGC_xen_heap)
+				continue;
+
+			/* delete pages not allocated to any domain */
+			if (! (count_info & PGC_allocated)) {
+				clear_bit_on_2nd_bitmap(pfn);
+				continue;
+			}
+
+			if (!readmem(VADDR_XEN,
+			      page_info_addr + OFFSET(page_info._domain),
+			      &_domain, sizeof(_domain))) {
+				ERRMSG("Can't get page_info._domain.\n");
+				return FALSE;
+			}
+
+			/*
+			 * keep:
+			 *  - anonymous (_domain == 0), or
+			 *  - selected domain page
+			 */
+			if (_domain == 0)
+				continue;
+			if (is_select_domain(_domain))
+				continue;
+			clear_bit_on_2nd_bitmap(pfn);
+		}
+	}
+
+	return TRUE;
+}
+
+int
+exclude_xen_user_domain(void)
+{
+	struct timeval tv_start;
+	int ret;
+
+	gettimeofday(&tv_start, NULL);
+
+	if (info->xen_crash_info.com &&
+	    info->xen_crash_info.com->xen_major_version >= 4)
+		ret = exclude_xen4_user_domain();
+	else
+		ret = exclude_xen3_user_domain();
+
 	/*
 	 * print [100 %]
 	 */
-	print_progress(PROGRESS_XEN_DOMAIN, num_pt_loads, num_pt_loads);
+	print_progress(PROGRESS_XEN_DOMAIN, 1, 1);
 	print_execution_time(PROGRESS_XEN_DOMAIN, &tv_start);
 
-	return TRUE;
+	return ret;
 }
 
 int



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
