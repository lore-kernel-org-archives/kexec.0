Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from nat.scz.novell.com ([213.151.88.252] helo=nathan.suse.cz)
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1StHdS-0001oU-VK
 for kexec@lists.infradead.org; Mon, 23 Jul 2012 12:21:16 +0000
Message-Id: <20120723113255.195911521@suse.cz>
Date: Mon, 23 Jul 2012 13:32:50 +0200
From: ptesarik@suse.cz
Subject: [PATCH 6/8] Handle Xen4 heap pages
References: <20120723113244.751777873@suse.cz>
Content-Disposition: inline; filename=makedumpfile-xen4-heap.patch
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

In Xen3, heap pages were allocated in a fixed range, so they could be
recognized by their address. This is no longer the case with Xen4. Instead, we
have to look at the page flags and check if PGC_xen_heap is set.

Signed-off-by: Petr Tesarik <ptesarik@suse.cz>

---
 arch/ia64.c    |   36 +++++++++++++++++-------------------
 arch/x86_64.c  |   18 ++++++++----------
 makedumpfile.c |    6 +++++-
 makedumpfile.h |    1 +
 4 files changed, 31 insertions(+), 30 deletions(-)

--- a/arch/ia64.c
+++ b/arch/ia64.c
@@ -335,26 +335,24 @@ get_xen_basic_info_ia64(void)
 
 	info->frame_table_vaddr = VIRT_FRAME_TABLE_ADDR; /* "frame_table" is same value */
 
-	if (SYMBOL(xenheap_phys_end) == NOT_FOUND_SYMBOL) {
-		ERRMSG("Can't get the symbol of xenheap_phys_end.\n");
-		return FALSE;
+	if (SYMBOL(xenheap_phys_end) != NOT_FOUND_SYMBOL) {
+		if (!readmem(VADDR_XEN, SYMBOL(xenheap_phys_end), &xen_end,
+		      sizeof(xen_end))) {
+			ERRMSG("Can't get the value of xenheap_phys_end.\n");
+			return FALSE;
+		}
+		if (SYMBOL(xen_pstart) == NOT_FOUND_SYMBOL) {
+			ERRMSG("Can't get the symbol of xen_pstart.\n");
+			return FALSE;
+		}
+		if (!readmem(VADDR_XEN, SYMBOL(xen_pstart), &xen_start,
+		    sizeof(xen_start))) {
+			ERRMSG("Can't get the value of xen_pstart.\n");
+			return FALSE;
+		}
+		info->xen_heap_start = paddr_to_pfn(xen_start);
+		info->xen_heap_end   = paddr_to_pfn(xen_end);
 	}
-	if (!readmem(VADDR_XEN, SYMBOL(xenheap_phys_end), &xen_end,
-	      sizeof(xen_end))) {
-		ERRMSG("Can't get the value of xenheap_phys_end.\n");
-		return FALSE;
-	}
-	if (SYMBOL(xen_pstart) == NOT_FOUND_SYMBOL) {
-		ERRMSG("Can't get the symbol of xen_pstart.\n");
-		return FALSE;
-	}
-	if (!readmem(VADDR_XEN, SYMBOL(xen_pstart), &xen_start,
-	    sizeof(xen_start))) {
-		ERRMSG("Can't get the value of xen_pstart.\n");
-		return FALSE;
-	}
-	info->xen_heap_start = paddr_to_pfn(xen_start);
-	info->xen_heap_end   = paddr_to_pfn(xen_end);
 
 	return TRUE;
 }
--- a/arch/x86_64.c
+++ b/arch/x86_64.c
@@ -385,17 +385,15 @@ int get_xen_basic_info_x86_64(void)
 	}
 	info->frame_table_vaddr = frame_table_vaddr;
 
-	if (SYMBOL(xenheap_phys_end) == NOT_FOUND_SYMBOL) {
-		ERRMSG("Can't get the symbol of xenheap_phys_end.\n");
-		return FALSE;
+	if (SYMBOL(xenheap_phys_end) != NOT_FOUND_SYMBOL) {
+		if (!readmem(VADDR_XEN, SYMBOL(xenheap_phys_end), &xen_end,
+		    sizeof(xen_end))) {
+			ERRMSG("Can't get the value of xenheap_phys_end.\n");
+			return FALSE;
+		}
+		info->xen_heap_start = 0;
+		info->xen_heap_end   = paddr_to_pfn(xen_end);
 	}
-	if (!readmem(VADDR_XEN, SYMBOL(xenheap_phys_end), &xen_end,
-	    sizeof(xen_end))) {
-		ERRMSG("Can't get the value of xenheap_phys_end.\n");
-		return FALSE;
-	}
-	info->xen_heap_start = 0;
-	info->xen_heap_end   = paddr_to_pfn(xen_end);
 
 	return TRUE;
 }
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -5715,7 +5715,11 @@ exclude_xen_user_domain(void)
 			 */
 			if (_domain == 0)
 				continue;
-			if (info->xen_heap_start <= pfn && pfn < info->xen_heap_end)
+			if (!info->xen_heap_end) {
+				if (count_info & PGC_xen_heap)
+					continue;
+			} else if (info->xen_heap_start <= pfn &&
+				   pfn < info->xen_heap_end)
 				continue;
 			if ((count_info & 0xffff) && is_select_domain(_domain))
 				continue;
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -82,6 +82,7 @@ int get_mem_type(void);
  */
 #define PG_shift(idx)	(BITS_PER_LONG - (idx))
 #define PG_mask(x, idx)	(x ## UL << PG_shift(idx))
+#define PGC_xen_heap        PG_mask(1, 2)
 
 /*
  * Memory flags



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
