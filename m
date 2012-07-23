Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from nat.scz.novell.com ([213.151.88.252] helo=nathan.suse.cz)
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1StHdZ-0003Z5-UQ
 for kexec@lists.infradead.org; Mon, 23 Jul 2012 12:21:23 +0000
Message-Id: <20120723113255.368838158@suse.cz>
Date: Mon, 23 Jul 2012 13:32:51 +0200
From: ptesarik@suse.cz
Subject: [PATCH 7/8] Update the algorithm to find unused Xen pages for Xen4
References: <20120723113244.751777873@suse.cz>
Content-Disposition: inline; filename=makedumpfile-xen4-page-usage.patch
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
Cc: Petr Tesarik <ptesarik@suse.cz>

Xen3 used to maintain a bitmap of used/unused pages, which no longer exists in
Xen4. Instead, we have to inspect page flags in frame_table[].

To maintain backward compatibility, the bitmap is used if found, but if the
alloc_bitmap symbol doesn't exist, the new code assumes that it is reading a
Xen4 crashdump.

Signed-off-by: Petr Tesarik <ptesarik@suse.cz>

---
 makedumpfile.c |   13 +++++++------
 makedumpfile.h |    7 +++++++
 2 files changed, 14 insertions(+), 6 deletions(-)

--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -5325,11 +5325,8 @@ get_xen_info(void)
 	if (!get_xen_basic_info_arch())
 		return FALSE;
 
-	if (SYMBOL(alloc_bitmap) == NOT_FOUND_SYMBOL) {
-		ERRMSG("Can't get the symbol of alloc_bitmap.\n");
-		return FALSE;
-	}
-	if (!readmem(VADDR_XEN, SYMBOL(alloc_bitmap), &info->alloc_bitmap,
+	if (SYMBOL(alloc_bitmap) != NOT_FOUND_SYMBOL &&
+	    !readmem(VADDR_XEN, SYMBOL(alloc_bitmap), &info->alloc_bitmap,
 	      sizeof(info->alloc_bitmap))) {
 		ERRMSG("Can't get the value of alloc_bitmap.\n");
 		return FALSE;
@@ -5689,7 +5686,7 @@ exclude_xen_user_domain(void)
 			print_progress(PROGRESS_XEN_DOMAIN, j + (size * i),
 					size * num_pt_loads);
 
-			if (!allocated_in_map(pfn)) {
+			if (info->alloc_bitmap && !allocated_in_map(pfn)) {
 				clear_bit_on_2nd_bitmap(pfn);
 				continue;
 			}
@@ -5701,6 +5698,10 @@ exclude_xen_user_domain(void)
 				clear_bit_on_2nd_bitmap(pfn);
 				continue;	/* page_info may not exist */
 			}
+			if (!info->alloc_bitmap && page_state_is(count_info, free)) {
+				clear_bit_on_2nd_bitmap(pfn);
+				continue;
+			}
 			if (!readmem(VADDR_XEN,
 			      page_info_addr + OFFSET(page_info._domain),
 			      &_domain, sizeof(_domain))) {
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -83,6 +83,13 @@ int get_mem_type(void);
 #define PG_shift(idx)	(BITS_PER_LONG - (idx))
 #define PG_mask(x, idx)	(x ## UL << PG_shift(idx))
 #define PGC_xen_heap        PG_mask(1, 2)
+ /* Mutually-exclusive page states: { inuse, offlining, offlined, free }. */
+#define PGC_state           PG_mask(3, 9)
+#define PGC_state_inuse     PG_mask(0, 9)
+#define PGC_state_offlining PG_mask(1, 9)
+#define PGC_state_offlined  PG_mask(2, 9)
+#define PGC_state_free      PG_mask(3, 9)
+#define page_state_is(count_info, st) (((count_info)&PGC_state) == PGC_state_##st)
 
 /*
  * Memory flags



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
