Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cdkMc-0002vA-01
 for kexec@lists.infradead.org; Tue, 14 Feb 2017 21:10:30 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
Subject: [PATCH v4 08/11] crashdump/ppc64: Add get_crash_kernel_load_range()
 function
Date: Tue, 14 Feb 2017 15:09:20 -0600
Message-Id: <1487106563-722-9-git-send-email-eric.devolder@oracle.com>
In-Reply-To: <1487106563-722-1-git-send-email-eric.devolder@oracle.com>
References: <1487106563-722-1-git-send-email-eric.devolder@oracle.com>
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
To: horms@verge.net.au, kexec@lists.infradead.org, andrew.cooper3@citrix.com, dyoung@redhat.com, panand@redhat.com
Cc: daniel.kiper@oracle.com, konrad.wilk@oracle.com

From: Daniel Kiper <daniel.kiper@oracle.com>

Implement get_crash_kernel_load_range() in support of
print crash kernel region size option.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>
---
v4: Incorporated feedback:
    - changes for coding convention and formatting
v3: Incorporated feedback:
    - changes for coding convention and formatting
    - restructured to introduce get_crash_kernel_load_range() for each
      architecture, and then a single function in kexec/kexec.c to call
      the per-architecture get_crash_kernel_load_range() and print the
      result.
    - changed print_crashkernel_region_size() to get_crash_kernel_load_range()
    - introduced get_devtree_value()
v2: Incorporated feedback:
    - utilize the is_crashkernel_mem_reserved() function common in all archs
    - utilize device-tree values to print size
v1: Posted to kexec-tools mailing list
---
 kexec/arch/ppc64/crashdump-ppc64.c | 27 ++++++++++++++++++++++++++-
 kexec/arch/ppc64/kexec-ppc64.c     | 28 ++++++++++++++++++++++++++++
 kexec/arch/ppc64/kexec-ppc64.h     |  2 ++
 3 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/ppc64/crashdump-ppc64.c b/kexec/arch/ppc64/crashdump-ppc64.c
index f62b159..3d7565d 100644
--- a/kexec/arch/ppc64/crashdump-ppc64.c
+++ b/kexec/arch/ppc64/crashdump-ppc64.c
@@ -36,6 +36,9 @@
 #include "../../fs2dt.h"
 #include "crashdump-ppc64.h"
 
+#define DEVTREE_CRASHKERNEL_BASE "/proc/device-tree/chosen/linux,crashkernel-base"
+#define DEVTREE_CRASHKERNEL_SIZE "/proc/device-tree/chosen/linux,crashkernel-size"
+
 static struct crash_elf_info elf_info64 =
 {
 	class: ELFCLASS64,
@@ -526,11 +529,33 @@ void add_usable_mem_rgns(unsigned long long base, unsigned long long size)
 		usablemem_rgns.size, base, size);
 }
 
+int get_crash_kernel_load_range(uint64_t *start, uint64_t *end)
+{
+	unsigned long long value;
+	int ret = 0;
+
+	if (!get_devtree_value(DEVTREE_CRASHKERNEL_BASE, &value))
+		*start = value;
+	else {
+		*start = 0;
+		ret = -1;
+	}
+
+	if (!get_devtree_value(DEVTREE_CRASHKERNEL_SIZE, &value))
+		*end = *start + value - 1;
+	else {
+		*end = 0;
+		ret = -1;
+	}
+
+	return ret;
+}
+
 int is_crashkernel_mem_reserved(void)
 {
 	int fd;
 
-	fd = open("/proc/device-tree/chosen/linux,crashkernel-base", O_RDONLY);
+	fd = open(DEVTREE_CRASHKERNEL_BASE, O_RDONLY);
 	if (fd < 0)
 		return 0;
 	close(fd);
diff --git a/kexec/arch/ppc64/kexec-ppc64.c b/kexec/arch/ppc64/kexec-ppc64.c
index 09ee025..85c9868 100644
--- a/kexec/arch/ppc64/kexec-ppc64.c
+++ b/kexec/arch/ppc64/kexec-ppc64.c
@@ -356,6 +356,34 @@ void scan_reserved_ranges(unsigned long kexec_flags, int *range_index)
 	*range_index = i;
 }
 
+int get_devtree_value(const char *fname, unsigned long long *pvalue)
+{
+	/* Return 0 if fname/value valid, -1 otherwise */
+	FILE *file;
+	char buf[MAXBYTES];
+	int ret = 0, n = -1;
+	unsigned long long value = 0;
+
+	if ((file = fopen(fname, "r"))) {
+		n = fread(buf, 1, MAXBYTES, file);
+		fclose(file);
+	}
+
+	if (n == sizeof(uint32_t))
+		value = ((uint32_t *)buf)[0];
+	else if (n == sizeof(uint64_t))
+		value = ((uint64_t *)buf)[0];
+	else {
+		fprintf(stderr, "%s node has invalid size: %d\n", fname, n);
+		ret = -1;
+	}
+
+	if (pvalue)
+		*pvalue = value;
+
+	return ret;
+}
+
 /* Get devtree details and create exclude_range array
  * Also create usablemem_ranges for KEXEC_ON_CRASH
  */
diff --git a/kexec/arch/ppc64/kexec-ppc64.h b/kexec/arch/ppc64/kexec-ppc64.h
index 89ee942..633ae77 100644
--- a/kexec/arch/ppc64/kexec-ppc64.h
+++ b/kexec/arch/ppc64/kexec-ppc64.h
@@ -14,6 +14,8 @@
 #define HAVE_DYNAMIC_MEMORY
 #define NEED_RESERVE_DTB
 
+extern int get_devtree_value(const char *fname, unsigned long long *pvalue);
+
 int setup_memory_ranges(unsigned long kexec_flags);
 
 int elf_ppc64_probe(const char *buf, off_t len);
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
