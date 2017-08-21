Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1djdKH-0004bZ-9H
 for kexec@lists.infradead.org; Mon, 21 Aug 2017 03:24:31 +0000
From: Pingfan Liu <piliu@redhat.com>
Subject: [PATCH v2 2/2] makedumpfile/ppc64: get the info of mem reserved for
 crashkernel
Date: Mon, 21 Aug 2017 11:24:06 +0800
Message-Id: <1503285846-11432-3-git-send-email-piliu@redhat.com>
In-Reply-To: <1503285846-11432-1-git-send-email-piliu@redhat.com>
References: <1503285846-11432-1-git-send-email-piliu@redhat.com>
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
To: kexec@lists.infradead.org
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>, Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>

In kernel, ppc64 does not export the mem layout by ioresource. So we
need to get the mem info for crashkernel from device tree.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
---
 arch/ppc64.c   | 36 ++++++++++++++++++++++++++++++++++++
 makedumpfile.c |  3 +++
 makedumpfile.h | 11 +++++++++++
 3 files changed, 50 insertions(+)

diff --git a/arch/ppc64.c b/arch/ppc64.c
index 3fd6002..bacac77 100644
--- a/arch/ppc64.c
+++ b/arch/ppc64.c
@@ -617,4 +617,40 @@ vaddr_to_paddr_ppc64(unsigned long vaddr)
 	return ppc64_vtop_level4(vaddr);
 }
 
+int arch_crashkernel_mem_size_ppc64()
+{
+	const char f_crashsize[] = "/proc/device-tree/chosen/linux,crashkernel-size";
+	const char f_crashbase[] = "/proc/device-tree/chosen/linux,crashkernel-base";
+	unsigned long crashk_sz_be, crashk_sz;
+	unsigned long crashk_base_be, crashk_base;
+	uint swap;
+	FILE *fp, *fpb;
+
+	fp = fopen(f_crashsize, "r");
+	if (!fp) {
+		ERRMSG("Cannot open %s\n", f_crashsize);
+		return FALSE;
+	}
+	fpb = fopen(f_crashbase, "r");
+	if (!fp) {
+		ERRMSG("Cannot open %s\n", f_crashbase);
+		fclose(fp);
+		return FALSE;
+	}
+
+	fread(&crashk_sz_be, sizeof(crashk_sz_be), 1, fp);
+	fread(&crashk_base_be, sizeof(crashk_base_be), 1, fpb);
+	fclose(fp);
+	fclose(fpb);
+	/* dev tree is always big endian */
+	swap = !is_bigendian();
+	crashk_sz = swap64(crashk_sz_be, swap);
+	crashk_base = swap64(crashk_base_be, swap);
+	crash_reserved_mem_nr = 1;
+	crash_reserved_mem[0].start = crashk_base;
+	crash_reserved_mem[0].end   = crashk_base + crashk_sz - 1;
+
+	return TRUE;
+}
+
 #endif /* powerpc64 */
diff --git a/makedumpfile.c b/makedumpfile.c
index f85003a..4ed4936 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -10925,6 +10925,9 @@ int is_crashkernel_mem_reserved(void)
 {
 	int ret;
 
+	if (arch_crashkernel_mem_size())
+		return TRUE;
+
 	ret = iomem_for_each_line("Crash kernel\n",
 					crashkernel_mem_callback, NULL);
 	crash_reserved_mem_nr = ret;
diff --git a/makedumpfile.h b/makedumpfile.h
index 8a05794..d01d79a 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -933,6 +933,7 @@ int get_xen_info_arm64(void);
 #define get_xen_basic_info_arch(X) get_xen_basic_info_arm64(X)
 #define get_xen_info_arch(X) get_xen_info_arm64(X)
 #define is_phys_addr(X)		stub_true_ul(X)
+#define arch_crashkernel_mem_size()	stub_false()
 #endif /* aarch64 */
 
 #ifdef __arm__
@@ -946,6 +947,7 @@ unsigned long long vaddr_to_paddr_arm(unsigned long vaddr);
 #define get_kaslr_offset(X)	stub_false()
 #define vaddr_to_paddr(X)	vaddr_to_paddr_arm(X)
 #define is_phys_addr(X)		stub_true_ul(X)
+#define arch_crashkernel_mem_size()	stub_false()
 #endif /* arm */
 
 #ifdef __x86__
@@ -959,6 +961,7 @@ unsigned long long vaddr_to_paddr_x86(unsigned long vaddr);
 #define get_kaslr_offset(X)	stub_false()
 #define vaddr_to_paddr(X)	vaddr_to_paddr_x86(X)
 #define is_phys_addr(X)		stub_true_ul(X)
+#define arch_crashkernel_mem_size()	stub_false()
 #endif /* x86 */
 
 #ifdef __x86_64__
@@ -974,12 +977,14 @@ unsigned long long vtop4_x86_64(unsigned long vaddr);
 #define get_kaslr_offset(X)	get_kaslr_offset_x86_64(X)
 #define vaddr_to_paddr(X)	vtop4_x86_64(X)
 #define is_phys_addr(X)		stub_true_ul(X)
+#define arch_crashkernel_mem_size()	stub_false()
 #endif /* x86_64 */
 
 #ifdef __powerpc64__ /* powerpc64 */
 int get_machdep_info_ppc64(void);
 int get_versiondep_info_ppc64(void);
 unsigned long long vaddr_to_paddr_ppc64(unsigned long vaddr);
+int arch_crashkernel_mem_size_ppc64(void);
 #define find_vmemmap()		stub_false()
 #define get_phys_base()		stub_true()
 #define get_machdep_info()	get_machdep_info_ppc64()
@@ -987,6 +992,7 @@ unsigned long long vaddr_to_paddr_ppc64(unsigned long vaddr);
 #define get_kaslr_offset(X)	stub_false()
 #define vaddr_to_paddr(X)	vaddr_to_paddr_ppc64(X)
 #define is_phys_addr(X)		stub_true_ul(X)
+#define arch_crashkernel_mem_size()	arch_crashkernel_mem_size_ppc64()
 #endif          /* powerpc64 */
 
 #ifdef __powerpc32__ /* powerpc32 */
@@ -999,6 +1005,7 @@ unsigned long long vaddr_to_paddr_ppc(unsigned long vaddr);
 #define get_kaslr_offset(X)	stub_false()
 #define vaddr_to_paddr(X)	vaddr_to_paddr_ppc(X)
 #define is_phys_addr(X)		stub_true_ul(X)
+#define arch_crashkernel_mem_size()	stub_false()
 #endif          /* powerpc32 */
 
 #ifdef __s390x__ /* s390x */
@@ -1012,6 +1019,7 @@ int is_iomem_phys_addr_s390x(unsigned long addr);
 #define get_kaslr_offset(X)	stub_false()
 #define vaddr_to_paddr(X)	vaddr_to_paddr_s390x(X)
 #define is_phys_addr(X)		is_iomem_phys_addr_s390x(X)
+#define arch_crashkernel_mem_size()	stub_false()
 #endif          /* s390x */
 
 #ifdef __ia64__ /* ia64 */
@@ -1026,6 +1034,7 @@ unsigned long long vaddr_to_paddr_ia64(unsigned long vaddr);
 #define vaddr_to_paddr(X)	vaddr_to_paddr_ia64(X)
 #define VADDR_REGION(X)		(((unsigned long)(X)) >> REGION_SHIFT)
 #define is_phys_addr(X)		stub_true_ul(X)
+#define arch_crashkernel_mem_size()	stub_false()
 #endif          /* ia64 */
 
 #ifdef __sparc64__ /* sparc64 */
@@ -1038,6 +1047,7 @@ unsigned long long vaddr_to_paddr_sparc64(unsigned long vaddr);
 #define get_versiondep_info()   get_versiondep_info_sparc64()
 #define vaddr_to_paddr(X)       vaddr_to_paddr_sparc64(X)
 #define is_phys_addr(X)		stub_true_ul(X)
+#define arch_crashkernel_mem_size()	stub_false()
 #endif		/* sparc64 */
 
 typedef unsigned long long mdf_pfn_t;
@@ -1939,6 +1949,7 @@ int iomem_for_each_line(char *match, int (*callback)(void *data, int nr,
 						     unsigned long base,
 						     unsigned long length),
 			void *data);
+int is_bigendian(void);
 
 
 /*
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
