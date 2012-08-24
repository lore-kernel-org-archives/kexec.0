Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T4w2n-0002Iv-Ty
 for kexec@lists.infradead.org; Fri, 24 Aug 2012 15:43:35 +0000
Subject: [PATCHv3 9/9] Do not fail for symbols removed in Xen4
From: Petr Tesarik <ptesarik@suse.cz>
Date: Fri, 24 Aug 2012 17:43:30 +0200
MIME-Version: 1.0
Message-Id: <201208241743.30621.ptesarik@suse.cz>
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
To: kexec@lists.infradead.org
Cc: Norbert Trapp <Norbert.Trapp@ts.fujitsu.com>

Xen-4.0+ removes some of the symbols that were necessary to process dump
files on Xen-3, and makedumpfile fails if they are not found.

Since most of these symbols are not needed for Xen4, we can simply remove
the checks. The only exception is "frame_table". This used to be a global
variable holding the address of the array of struct page_info. In Xen-4.0
the array is always located at a fixed address in virtual address space.
Xen adds a compatibility symbol for VMCOREINFO, but a "frame_table" symbol
does not exist as such, so we must use the fixed address instead.

Signed-off-by: Norbert Trapp <norbert.trapp@ts.fujitsu.com>
Signed-off-by: Petr Tesarik <ptesarik@suse.cz>

---
 arch/ia64.c    |   41 ++++++++++++++++++++++-------------------
 arch/x86.c     |   49 ++++++++++++++++++++++++++-----------------------
 arch/x86_64.c  |   49 ++++++++++++++++++++++++++-----------------------
 makedumpfile.c |   37 ++++++++++++++++++++-----------------
 4 files changed, 94 insertions(+), 82 deletions(-)

--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -5377,23 +5377,26 @@ get_xen_info(void)
 	if (!get_xen_basic_info_arch())
 		return FALSE;
 
-	if (SYMBOL(alloc_bitmap) == NOT_FOUND_SYMBOL) {
-		ERRMSG("Can't get the symbol of alloc_bitmap.\n");
-		return FALSE;
-	}
-	if (!readmem(VADDR_XEN, SYMBOL(alloc_bitmap), &info->alloc_bitmap,
-	      sizeof(info->alloc_bitmap))) {
-		ERRMSG("Can't get the value of alloc_bitmap.\n");
-		return FALSE;
-	}
-	if (SYMBOL(max_page) == NOT_FOUND_SYMBOL) {
-		ERRMSG("Can't get the symbol of max_page.\n");
-		return FALSE;
-	}
-	if (!readmem(VADDR_XEN, SYMBOL(max_page), &info->max_page,
-	    sizeof(info->max_page))) {
-		ERRMSG("Can't get the value of max_page.\n");
-		return FALSE;
+	if (!info->xen_crash_info.com ||
+	    info->xen_crash_info.com->xen_major_version < 4) {
+		if (SYMBOL(alloc_bitmap) == NOT_FOUND_SYMBOL) {
+			ERRMSG("Can't get the symbol of alloc_bitmap.\n");
+			return FALSE;
+		}
+		if (!readmem(VADDR_XEN, SYMBOL(alloc_bitmap), &info->alloc_bitmap,
+		      sizeof(info->alloc_bitmap))) {
+			ERRMSG("Can't get the value of alloc_bitmap.\n");
+			return FALSE;
+		}
+		if (SYMBOL(max_page) == NOT_FOUND_SYMBOL) {
+			ERRMSG("Can't get the symbol of max_page.\n");
+			return FALSE;
+		}
+		if (!readmem(VADDR_XEN, SYMBOL(max_page), &info->max_page,
+		    sizeof(info->max_page))) {
+			ERRMSG("Can't get the value of max_page.\n");
+			return FALSE;
+		}
 	}
 
 	/*
--- a/arch/ia64.c
+++ b/arch/ia64.c
@@ -335,26 +335,29 @@ get_xen_basic_info_ia64(void)
 
 	info->frame_table_vaddr = VIRT_FRAME_TABLE_ADDR; /* "frame_table" is same 
value */
 
-	if (SYMBOL(xenheap_phys_end) == NOT_FOUND_SYMBOL) {
-		ERRMSG("Can't get the symbol of xenheap_phys_end.\n");
-		return FALSE;
+	if (!info->xen_crash_info.com ||
+	    info->xen_crash_info.com->xen_major_version < 4) {
+		if (SYMBOL(xenheap_phys_end) == NOT_FOUND_SYMBOL) {
+			ERRMSG("Can't get the symbol of xenheap_phys_end.\n");
+			return FALSE;
+		}
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
@@ -358,9 +358,6 @@ kvtop_xen_x86_64(unsigned long kvaddr)
 
 int get_xen_basic_info_x86_64(void)
 {
-	unsigned long frame_table_vaddr;
-	unsigned long xen_end;
-
  	if (!info->xen_phys_start) {
 		if (info->xen_crash_info_v < 2) {
 			ERRMSG("Can't get Xen physical start address.\n"
@@ -384,28 +381,34 @@ int get_xen_basic_info_x86_64(void)
 		return FALSE;
 	}
 
-	if (SYMBOL(frame_table) == NOT_FOUND_SYMBOL) {
-		ERRMSG("Can't get the symbol of frame_table.\n");
-		return FALSE;
-	}
-	if (!readmem(VADDR_XEN, SYMBOL(frame_table), &frame_table_vaddr,
-	    sizeof(frame_table_vaddr))) {
-		ERRMSG("Can't get the value of frame_table.\n");
-		return FALSE;
-	}
-	info->frame_table_vaddr = frame_table_vaddr;
+	if (SYMBOL(frame_table) != NOT_FOUND_SYMBOL) {
+		unsigned long frame_table_vaddr;
 
-	if (SYMBOL(xenheap_phys_end) == NOT_FOUND_SYMBOL) {
-		ERRMSG("Can't get the symbol of xenheap_phys_end.\n");
-		return FALSE;
-	}
-	if (!readmem(VADDR_XEN, SYMBOL(xenheap_phys_end), &xen_end,
-	    sizeof(xen_end))) {
-		ERRMSG("Can't get the value of xenheap_phys_end.\n");
-		return FALSE;
+		if (!readmem(VADDR_XEN, SYMBOL(frame_table),
+		    &frame_table_vaddr, sizeof(frame_table_vaddr))) {
+			ERRMSG("Can't get the value of frame_table.\n");
+			return FALSE;
+		}
+		info->frame_table_vaddr = frame_table_vaddr;
+	} else
+		info->frame_table_vaddr = FRAMETABLE_VIRT_START;
+
+	if (!info->xen_crash_info.com ||
+	    info->xen_crash_info.com->xen_major_version < 4) {
+		unsigned long xen_end;
+
+		if (SYMBOL(xenheap_phys_end) == NOT_FOUND_SYMBOL) {
+			ERRMSG("Can't get the symbol of xenheap_phys_end.\n");
+			return FALSE;
+		}
+		if (!readmem(VADDR_XEN, SYMBOL(xenheap_phys_end), &xen_end,
+		    sizeof(xen_end))) {
+			ERRMSG("Can't get the value of xenheap_phys_end.\n");
+			return FALSE;
+		}
+		info->xen_heap_start = 0;
+		info->xen_heap_end   = paddr_to_pfn(xen_end);
 	}
-	info->xen_heap_start = 0;
-	info->xen_heap_end   = paddr_to_pfn(xen_end);
 
 	return TRUE;
 }
--- a/arch/x86.c
+++ b/arch/x86.c
@@ -293,9 +293,6 @@ kvtop_xen_x86(unsigned long kvaddr)
 
 int get_xen_basic_info_x86(void)
 {
-	unsigned long frame_table_vaddr;
-	unsigned long xen_end;
-
 	if (!info->xen_phys_start) {
 		if (info->xen_crash_info_v < 2) {
 			ERRMSG("Can't get Xen physical start address.\n"
@@ -316,28 +313,34 @@ int get_xen_basic_info_x86(void)
 		return FALSE;
 	}
 
-	if (SYMBOL(frame_table) == NOT_FOUND_SYMBOL) {
-		ERRMSG("Can't get the symbol of frame_table.\n");
-		return FALSE;
-	}
-	if (!readmem(VADDR_XEN, SYMBOL(frame_table), &frame_table_vaddr,
-	    sizeof(frame_table_vaddr))) {
-		ERRMSG("Can't get the value of frame_table.\n");
-		return FALSE;
-	}
-	info->frame_table_vaddr = frame_table_vaddr;
+	if (SYMBOL(frame_table) != NOT_FOUND_SYMBOL) {
+		unsigned long frame_table_vaddr;
 
-	if (SYMBOL(xenheap_phys_end) == NOT_FOUND_SYMBOL) {
-		ERRMSG("Can't get the symbol of xenheap_phys_end.\n");
-		return FALSE;
-	}
-	if (!readmem(VADDR_XEN, SYMBOL(xenheap_phys_end), &xen_end,
-	    sizeof(xen_end))) {
-		ERRMSG("Can't get the value of xenheap_phys_end.\n");
-		return FALSE;
+		if (!readmem(VADDR_XEN, SYMBOL(frame_table),
+		    &frame_table_vaddr, sizeof(frame_table_vaddr))) {
+			ERRMSG("Can't get the value of frame_table.\n");
+			return FALSE;
+		}
+		info->frame_table_vaddr = frame_table_vaddr;
+	} else
+		info->frame_table_vaddr = FRAMETABLE_VIRT_START;
+
+	if (!info->xen_crash_info.com ||
+	    info->xen_crash_info.com->xen_major_version < 4) {
+		unsigned long xen_end;
+
+		if (SYMBOL(xenheap_phys_end) == NOT_FOUND_SYMBOL) {
+			ERRMSG("Can't get the symbol of xenheap_phys_end.\n");
+			return FALSE;
+		}
+		if (!readmem(VADDR_XEN, SYMBOL(xenheap_phys_end), &xen_end,
+		    sizeof(xen_end))) {
+			ERRMSG("Can't get the value of xenheap_phys_end.\n");
+			return FALSE;
+		}
+		info->xen_heap_start = 0;
+		info->xen_heap_end   = paddr_to_pfn(xen_end);
 	}
-	info->xen_heap_start = 0;
-	info->xen_heap_end   = paddr_to_pfn(xen_end);
 
 	return TRUE;
 }



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
