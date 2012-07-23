Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from nat.scz.novell.com ([213.151.88.252] helo=nathan.suse.cz)
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1StHdQ-0001nY-DU
 for kexec@lists.infradead.org; Mon, 23 Jul 2012 12:21:15 +0000
Message-Id: <20120723113254.493541207@suse.cz>
Date: Mon, 23 Jul 2012 13:32:46 +0200
From: ptesarik@suse.cz
Subject: [PATCH 2/8] Split early Xen setup from late Xen setup
References: <20120723113244.751777873@suse.cz>
Content-Disposition: inline; filename=makedumpfile-split-xen-setup.patch
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

Previously, get_xen_info_arch() was called after initializing the generic Xen
variables. This is necessary, because the arch-specific code translates domain
addresses to pickled domain IDs, and the domain list is initialized by the
generic code.

Now, Xen4 on x86_64 changed the virtual memory layout, and this initialization
should ideally be done in the arch-specific code. Unfortunately, the generic
code must know the virtual address space to perform readmem of type XEN_VADDR,
so there is no working ordering, and instead we must provide hooks for "early"
arch-specific initialization to set up data needed by the generic code, and
"late" arch-specific initialization to do stuff that depends on data set by
the generic code (currently only the domain_list).

Signed-off-by: Petr Tesarik <ptesarik@suse.cz>

---
 arch/ia64.c    |   14 +++++++++++---
 arch/x86.c     |   24 ++++++++++++++++++++++--
 arch/x86_64.c  |   24 ++++++++++++++++++++++--
 makedumpfile.c |   27 ++++++---------------------
 makedumpfile.h |    9 +++++++++
 5 files changed, 70 insertions(+), 28 deletions(-)

--- a/arch/x86.c
+++ b/arch/x86.c
@@ -291,11 +291,24 @@ kvtop_xen_x86(unsigned long kvaddr)
 	return entry;
 }
 
-int get_xen_info_x86(void)
+int get_xen_basic_info_x86(void)
 {
 	unsigned long frame_table_vaddr;
 	unsigned long xen_end;
-	int i;
+
+	if (!info->xen_phys_start) {
+		unsigned long size_xen_crash_info;
+		crash_xen_info_v2_t *xen_crash_info;
+
+		xen_crash_info = get_xen_crash_info(&size_xen_crash_info);
+		if (!xen_crash_info ||
+		    size_xen_crash_info < sizeof(crash_xen_info_v2_t)) {
+			ERRMSG("Can't get Xen physical start address.\n"
+			       "Please use the --xen_phys_start option.");
+			return FALSE;
+		}
+		info->xen_phys_start = xen_crash_info->xen_phys_start;
+	}
 
 	if (SYMBOL(pgd_l2) == NOT_FOUND_SYMBOL &&
 	    SYMBOL(pgd_l3) == NOT_FOUND_SYMBOL) {
@@ -331,6 +344,13 @@ int get_xen_info_x86(void)
 	info->xen_heap_start = 0;
 	info->xen_heap_end   = paddr_to_pfn(xen_end);
 
+	return TRUE;
+}
+
+int get_xen_info_x86(void)
+{
+	int i;
+
 	/*
 	 * pickled_id == domain addr for x86
 	 */
--- a/arch/x86_64.c
+++ b/arch/x86_64.c
@@ -338,11 +338,24 @@ kvtop_xen_x86_64(unsigned long kvaddr)
 	return entry;
 }
 
-int get_xen_info_x86_64(void)
+int get_xen_basic_info_x86_64(void)
 {
 	unsigned long frame_table_vaddr;
 	unsigned long xen_end;
-	int i;
+
+	if (!info->xen_phys_start) {
+		unsigned long size_xen_crash_info;
+		crash_xen_info_v2_t *xen_crash_info;
+
+		xen_crash_info = get_xen_crash_info(&size_xen_crash_info);
+		if (!xen_crash_info ||
+		    size_xen_crash_info < sizeof(crash_xen_info_v2_t)) {
+			ERRMSG("Can't get Xen physical start address.\n"
+			       "Please use the --xen_phys_start option.");
+			return FALSE;
+		}
+		info->xen_phys_start = xen_crash_info->xen_phys_start;
+	}
 
 	if (SYMBOL(pgd_l4) == NOT_FOUND_SYMBOL) {
 		ERRMSG("Can't get pml4.\n");
@@ -372,6 +385,13 @@ int get_xen_info_x86_64(void)
 	info->xen_heap_start = 0;
 	info->xen_heap_end   = paddr_to_pfn(xen_end);
 
+	return TRUE;
+}
+
+int get_xen_info_x86_64(void)
+{
+	int i;
+
 	/*
 	 * pickled_id == domain addr for x86_64
 	 */
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -5313,31 +5313,18 @@ get_structure_info_xen(void)
 }
 
 int
-get_xen_phys_start(void)
-{
-	unsigned long size_xen_crash_info;
-	crash_xen_info_v2_t *xen_crash_info;
-
-	if (info->xen_phys_start)
-		return TRUE;
-
-#if defined(__x86__) || defined(__x86_64__)
-	xen_crash_info = get_xen_crash_info(&size_xen_crash_info);
-	if (xen_crash_info &&
-	    size_xen_crash_info >= sizeof(crash_xen_info_v2_t))
-		info->xen_phys_start = xen_crash_info->xen_phys_start;
-#endif
-
-	return TRUE;
-}
-
-int
 get_xen_info(void)
 {
 	unsigned long domain;
 	unsigned int domain_id;
 	int num_domain;
 
+	/*
+	 * Get architecture specific basic data
+	 */
+	if (!get_xen_basic_info_arch())
+		return FALSE;
+
 	if (SYMBOL(alloc_bitmap) == NOT_FOUND_SYMBOL) {
 		ERRMSG("Can't get the symbol of alloc_bitmap.\n");
 		return FALSE;
@@ -5816,8 +5803,6 @@ initial_xen(void)
 		if (!read_vmcoreinfo_from_vmcore(offset, size, TRUE))
 			return FALSE;
 	}
-	if (!get_xen_phys_start())
-		return FALSE;
 	if (!get_xen_info())
 		return FALSE;
 
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1274,6 +1274,7 @@ struct domain_list {
 
 #ifdef __arm__
 #define kvtop_xen(X)	FALSE
+#define get_xen_basic_info_arch(X) FALSE
 #define get_xen_info_arch(X) FALSE
 #endif	/* arm */
 
@@ -1292,6 +1293,8 @@ struct domain_list {
 unsigned long long kvtop_xen_x86(unsigned long kvaddr);
 #define kvtop_xen(X)	kvtop_xen_x86(X)
 
+int get_xen_basic_info_x86(void);
+#define get_xen_basic_info_arch(X) get_xen_basic_info_x86(X)
 int get_xen_info_x86(void);
 #define get_xen_info_arch(X) get_xen_info_x86(X)
 
@@ -1319,6 +1322,8 @@ int get_xen_info_x86(void);
 unsigned long long kvtop_xen_x86_64(unsigned long kvaddr);
 #define kvtop_xen(X)	kvtop_xen_x86_64(X)
 
+int get_xen_basic_info_x86_64(void);
+#define get_xen_basic_info_arch(X) get_xen_basic_info_x86_64(X)
 int get_xen_info_x86_64(void);
 #define get_xen_info_arch(X) get_xen_info_x86_64(X)
 
@@ -1354,6 +1359,8 @@ int get_xen_info_x86_64(void);
 unsigned long long kvtop_xen_ia64(unsigned long kvaddr);
 #define kvtop_xen(X)	kvtop_xen_ia64(X)
 
+int get_xen_basic_info_ia64(void);
+#define get_xen_basic_info_arch(X) get_xen_basic_info_ia64(X)
 int get_xen_info_ia64(void);
 #define get_xen_info_arch(X) get_xen_info_ia64(X)
 
@@ -1361,11 +1368,13 @@ int get_xen_info_ia64(void);
 
 #if defined(__powerpc64__) || defined(__powerpc32__) /* powerpcXX */
 #define kvtop_xen(X)	FALSE
+#define get_xen_basic_info_arch(X) FALSE
 #define get_xen_info_arch(X) FALSE
 #endif	/* powerpcXX */
 
 #ifdef __s390x__ /* s390x */
 #define kvtop_xen(X)	FALSE
+#define get_xen_basic_info_arch(X) FALSE
 #define get_xen_info_arch(X) FALSE
 #endif	/* s390x */
 
--- a/arch/ia64.c
+++ b/arch/ia64.c
@@ -329,10 +329,9 @@ kvtop_xen_ia64(unsigned long kvaddr)
 }
 
 int
-get_xen_info_ia64(void)
+get_xen_basic_info_ia64(void)
 {
-	unsigned long xen_start, xen_end, xen_heap_start;
-	int i;
+	unsigned long xen_start, xen_end;
 
 	info->frame_table_vaddr = VIRT_FRAME_TABLE_ADDR; /* "frame_table" is same value */
 
@@ -357,6 +356,15 @@ get_xen_info_ia64(void)
 	info->xen_heap_start = paddr_to_pfn(xen_start);
 	info->xen_heap_end   = paddr_to_pfn(xen_end);
 
+	return TRUE;
+}
+
+int
+get_xen_info_ia64(void)
+{
+	unsigned long xen_heap_start;
+	int i;
+
 	if (SYMBOL(xen_heap_start) == NOT_FOUND_SYMBOL) {
 		ERRMSG("Can't get the symbol of xen_heap_start.\n");
 		return FALSE;



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
