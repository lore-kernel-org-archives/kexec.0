Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T4w1b-0001vd-Rt
 for kexec@lists.infradead.org; Fri, 24 Aug 2012 15:42:20 +0000
Subject: [PATCHv3 4/9] Split Xen setup into early and late
From: Petr Tesarik <ptesarik@suse.cz>
Date: Fri, 24 Aug 2012 17:42:15 +0200
MIME-Version: 1.0
Message-Id: <201208241742.16144.ptesarik@suse.cz>
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

Previously, get_xen_info_arch() was called after initializing the generic
Xen variables. This is necessary, because the arch-specific code translates
domain addresses to pickled domain IDs, and the domain list is initialized
by the generic code.

Now, the virtual memory layout on x86_64 was changed in Xen4, and this
initialization should ideally be done in the arch-specific code.
Unfortunately, the generic code must know the virtual address space to
perform readmem of type XEN_VADDR, so there is no working ordering, and
instead we must provide hooks for "early" arch-specific initialization
to set up data needed by the generic code, and "late" arch-specific
initialization to do stuff that depends on data set by the generic code
(currently only the domain_list).

Signed-off-by: Petr Tesarik <ptesarik@suse.cz>

---
 arch/ia64.c    |   14 +++++++++++---
 arch/x86.c     |   10 ++++++++--
 arch/x86_64.c  |   10 ++++++++--
 makedumpfile.c |    6 ++++++
 makedumpfile.h |    9 +++++++++
 5 files changed, 42 insertions(+), 7 deletions(-)

--- a/arch/x86.c
+++ b/arch/x86.c
@@ -291,11 +291,10 @@ kvtop_xen_x86(unsigned long kvaddr)
 	return entry;
 }
 
-int get_xen_info_x86(void)
+int get_xen_basic_info_x86(void)
 {
 	unsigned long frame_table_vaddr;
 	unsigned long xen_end;
-	int i;
 
 	if (SYMBOL(pgd_l2) == NOT_FOUND_SYMBOL &&
 	    SYMBOL(pgd_l3) == NOT_FOUND_SYMBOL) {
@@ -331,6 +330,13 @@ int get_xen_info_x86(void)
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
@@ -356,11 +356,10 @@ kvtop_xen_x86_64(unsigned long kvaddr)
 	return entry;
 }
 
-int get_xen_info_x86_64(void)
+int get_xen_basic_info_x86_64(void)
 {
 	unsigned long frame_table_vaddr;
 	unsigned long xen_end;
-	int i;
 
 	if (SYMBOL(pgd_l4) == NOT_FOUND_SYMBOL) {
 		ERRMSG("Can't get pml4.\n");
@@ -390,6 +389,13 @@ int get_xen_info_x86_64(void)
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
@@ -5385,6 +5385,12 @@ get_xen_info(void)
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
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1321,6 +1321,7 @@ struct domain_list {
 
 #ifdef __arm__
 #define kvtop_xen(X)	FALSE
+#define get_xen_basic_info_arch(X) FALSE
 #define get_xen_info_arch(X) FALSE
 #endif	/* arm */
 
@@ -1339,6 +1340,8 @@ struct domain_list {
 unsigned long long kvtop_xen_x86(unsigned long kvaddr);
 #define kvtop_xen(X)	kvtop_xen_x86(X)
 
+int get_xen_basic_info_x86(void);
+#define get_xen_basic_info_arch(X) get_xen_basic_info_x86(X)
 int get_xen_info_x86(void);
 #define get_xen_info_arch(X) get_xen_info_x86(X)
 
@@ -1366,6 +1369,8 @@ int get_xen_info_x86(void);
 unsigned long long kvtop_xen_x86_64(unsigned long kvaddr);
 #define kvtop_xen(X)	kvtop_xen_x86_64(X)
 
+int get_xen_basic_info_x86_64(void);
+#define get_xen_basic_info_arch(X) get_xen_basic_info_x86_64(X)
 int get_xen_info_x86_64(void);
 #define get_xen_info_arch(X) get_xen_info_x86_64(X)
 
@@ -1401,6 +1406,8 @@ int get_xen_info_x86_64(void);
 unsigned long long kvtop_xen_ia64(unsigned long kvaddr);
 #define kvtop_xen(X)	kvtop_xen_ia64(X)
 
+int get_xen_basic_info_ia64(void);
+#define get_xen_basic_info_arch(X) get_xen_basic_info_ia64(X)
 int get_xen_info_ia64(void);
 #define get_xen_info_arch(X) get_xen_info_ia64(X)
 
@@ -1408,11 +1415,13 @@ int get_xen_info_ia64(void);
 
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
 
 	info->frame_table_vaddr = VIRT_FRAME_TABLE_ADDR; /* "frame_table" is same 
value */
 
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
