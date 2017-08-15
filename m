Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by casper.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dhWHx-0004kt-Ay
 for kexec@lists.infradead.org; Tue, 15 Aug 2017 07:29:23 +0000
From: Pingfan Liu <piliu@redhat.com>
Subject: [PATCH 2/2] makedumpfile/ppc64: get the info of mem reserved for
 crashkernel
Date: Tue, 15 Aug 2017 15:21:06 +0800
Message-Id: <1502781666-20987-3-git-send-email-piliu@redhat.com>
In-Reply-To: <1502781666-20987-1-git-send-email-piliu@redhat.com>
References: <1502781666-20987-1-git-send-email-piliu@redhat.com>
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
 makedumpfile.c | 10 ++++++++++
 makedumpfile.h |  4 ++++
 3 files changed, 50 insertions(+)

diff --git a/arch/ppc64.c b/arch/ppc64.c
index 3fd6002..360590e 100644
--- a/arch/ppc64.c
+++ b/arch/ppc64.c
@@ -617,4 +617,40 @@ vaddr_to_paddr_ppc64(unsigned long vaddr)
 	return ppc64_vtop_level4(vaddr);
 }
 
+int arch_crashkernel_mem_size()
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
index f85003a..c599b91 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -10921,10 +10921,20 @@ static int crashkernel_mem_callback(void *data, int nr,
 	return 0;
 }
 
+#if !defined(HAVE_ARCH_CRASHKERNEL_MEM_SIZE)
+int arch_crashkernel_mem_size()
+{
+	return FALSE;
+}
+#endif
+
 int is_crashkernel_mem_reserved(void)
 {
 	int ret;
 
+	if (arch_crashkernel_mem_size())
+		return TRUE;
+
 	ret = iomem_for_each_line("Crash kernel\n",
 					crashkernel_mem_callback, NULL);
 	crash_reserved_mem_nr = ret;
diff --git a/makedumpfile.h b/makedumpfile.h
index 8a05794..48c1423 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -987,6 +987,8 @@ unsigned long long vaddr_to_paddr_ppc64(unsigned long vaddr);
 #define get_kaslr_offset(X)	stub_false()
 #define vaddr_to_paddr(X)	vaddr_to_paddr_ppc64(X)
 #define is_phys_addr(X)		stub_true_ul(X)
+
+#define HAVE_ARCH_CRASHKERNEL_MEM_SIZE
 #endif          /* powerpc64 */
 
 #ifdef __powerpc32__ /* powerpc32 */
@@ -1939,6 +1941,8 @@ int iomem_for_each_line(char *match, int (*callback)(void *data, int nr,
 						     unsigned long base,
 						     unsigned long length),
 			void *data);
+int is_bigendian(void);
+int arch_crashkernel_mem_size(void);
 
 
 /*
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
