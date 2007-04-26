Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Hh9mw-0003v7-OO
	for kexec@lists.infradead.org; Thu, 26 Apr 2007 15:38:00 -0400
Date: Thu, 26 Apr 2007 21:37:25 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH] [makedumpfile] Implement memory regions on IA64
Message-ID: <20070426193725.GA2586@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Kexec Mailing List <kexec@lists.infradead.org>
Cc: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>

This patch fixes an error in vaddr_to_offset_ia64() which happened on
a SGI machine here while retrieving the utsname from the kernel dump
image. It implements memory region support for IA64.

The code is mainly from crash (http://people.redhat.com/~anderson/).

Signed-off-by: Bernhard Walle <bwalle@suse.de>

---
 ia64.c         |   57 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 makedumpfile.c |    4 ++++
 makedumpfile.h |    9 ++++++++-
 3 files changed, 69 insertions(+), 1 deletion(-)

--- a/ia64.c
+++ b/ia64.c
@@ -23,6 +23,8 @@ get_phys_base_ia64(struct DumpInfo *info
 	int i;
 	struct pt_load_segment *pls;
 
+	info->phys_base = 0;
+
 	/*
 	 *  Default to 64MB.
 	 */
@@ -48,5 +50,60 @@ get_machdep_info_ia64(struct DumpInfo *i
 	return TRUE;
 }
 
+/*
+ * Convert Virtual Address to File Offest.
+ */
+off_t
+vaddr_to_offset_ia64(struct DumpInfo *info, unsigned long long vaddr)
+{
+	int i;
+	off_t offset;
+	struct pt_load_segment *pls;
+	unsigned long paddr;
+
+
+	switch (VADDR_REGION(vaddr)) {
+		case KERNEL_CACHED_REGION:
+			paddr = vaddr - (ulong)(KERNEL_CACHED_BASE);
+			break;
+
+		case KERNEL_UNCACHED_REGION:
+			paddr = vaddr - (ulong)(KERNEL_UNCACHED_BASE);
+			break;
+
+		case KERNEL_VMALLOC_REGION:
+			paddr = vaddr - info->kernel_start +
+				(info->phys_base & KERNEL_TR_PAGE_MASK);
+			break;
+
+		default:
+			ERRMSG("Unknown region (%d)\n", VADDR_REGION(vaddr));
+			return 0;
+	}
+
+	for (i = offset = 0; i < info->num_load_memory; i++) {
+		pls = &info->pt_load_segments[i];
+		if ((paddr >= pls->phys_start)
+		    && (paddr < pls->phys_end)) {
+			offset = (off_t)(paddr - pls->phys_start) +
+				pls->file_offset;
+				break;
+		}
+	}
+
+	return offset;
+}
+
+int
+get_machdep_kernel_start_ia64(struct DumpInfo *info)
+{
+	if (SYMBOL(_stext) != NOT_FOUND_SYMBOL)
+		info->kernel_start = SYMBOL(_stext);
+
+	/* TODO: fallback */
+
+	return TRUE;
+}
+
 #endif /* ia64 */
 
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2206,6 +2206,10 @@ initial(struct DumpInfo *info)
 		if (!get_structure_info(info))
 			return FALSE;
 	}
+
+	if (!get_machdep_kernel_start(info))
+		return FALSE;
+
 	if (!check_release(info))
 		return FALSE;
 
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -377,6 +377,7 @@ int get_machdep_info_x86();
 #define get_phys_base(X)	TRUE
 #define get_machdep_info(X)	get_machdep_info_x86(X)
 #define vaddr_to_offset(X, Y)	vaddr_to_offset_general(X,Y)
+#define get_machdep_kernel_start(X)	TRUE
 #endif /* x86 */
 
 #ifdef __x86_64__
@@ -386,6 +387,7 @@ off_t vaddr_to_offset_x86_64();
 #define get_phys_base(X)	get_phys_base_x86_64(X)
 #define get_machdep_info(X)	get_machdep_info_x86_64(X)
 #define vaddr_to_offset(X, Y)	vaddr_to_offset_x86_64(X, Y)
+#define get_machdep_kernel_start(X)	TRUE
 #endif /* x86_64 */
 
 #ifdef __powerpc__ /* powerpc */
@@ -393,14 +395,18 @@ int get_machdep_info_ppc64();
 #define get_machdep_info(X)	get_machdep_info_ppc64(X)
 #define get_phys_base(X)	TRUE
 #define vaddr_to_offset(X, Y)	vaddr_to_offset_general(X, Y)
+#define get_machdep_kernel_start(X)	TRUE
 #endif          /* powerpc */
 
 #ifdef __ia64__ /* ia64 */
 int get_phys_base_ia64();
 int get_machdep_info_ia64();
+int get_machdep_kernel_start_ia64();
+off_t vaddr_to_offset_ia64();
 #define get_machdep_info(X)	get_machdep_info_ia64(X)
 #define get_phys_base(X)	get_phys_base_ia64(X)
-#define vaddr_to_offset(X, Y)	vaddr_to_offset_general(X, Y)
+#define get_machdep_kernel_start(X)	get_machdep_kernel_start_ia64(X)
+#define vaddr_to_offset(X, Y)	vaddr_to_offset_ia64(X, Y)
 #define VADDR_REGION(X)		((X) >> REGION_SHIFT)
 #endif          /* ia64 */
 
@@ -491,6 +497,7 @@ struct DumpInfo {
 	unsigned long   max_physmem_bits;
 	unsigned long   sections_per_root;
 	unsigned long	phys_base;
+	unsigned long   kernel_start;
 
 	/*
 	 * diskdimp info:

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
