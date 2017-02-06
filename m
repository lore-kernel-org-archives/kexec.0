Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cap8x-0000IW-IK
 for kexec@lists.infradead.org; Mon, 06 Feb 2017 19:40:12 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
Subject: [PATCH v2 08/12] crashdump/ppc64: Add print_crashkernel_region_size()
 function
Date: Mon,  6 Feb 2017 13:42:20 -0600
Message-Id: <1486410144-28595-9-git-send-email-eric.devolder@oracle.com>
In-Reply-To: <1486410144-28595-1-git-send-email-eric.devolder@oracle.com>
References: <1486410144-28595-1-git-send-email-eric.devolder@oracle.com>
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
To: horms@verge.net.au, kexec@lists.infradead.org, andrew.cooper3@citrix.com, dyoung@redhat.com
Cc: daniel.kiper@oracle.com, konrad.wilk@oracle.com

From: Daniel Kiper <daniel.kiper@oracle.com>

Follow similar x86 patch.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>

note
---
 kexec/arch/ppc64/crashdump-ppc64.c | 33 +++++++++++++++++++++++++++------
 kexec/arch/ppc64/kexec-ppc64.c     | 23 +++++++++++++++++++++++
 kexec/arch/ppc64/kexec-ppc64.h     |  2 ++
 3 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/kexec/arch/ppc64/crashdump-ppc64.c b/kexec/arch/ppc64/crashdump-ppc64.c
index f62b159..0f4fd77 100644
--- a/kexec/arch/ppc64/crashdump-ppc64.c
+++ b/kexec/arch/ppc64/crashdump-ppc64.c
@@ -526,15 +526,36 @@ void add_usable_mem_rgns(unsigned long long base, unsigned long long size)
 		usablemem_rgns.size, base, size);
 }
 
+int get_crash_kernel_load_range(uint64_t *start, uint64_t *end)
+{
+	unsigned long long value;
+	if (get_devtree_value("/proc/device-tree/chosen/linux,crashkernel-base", &value)) {
+		*start = value;
+	}
+	else
+		*start = 0;
+	if (get_devtree_value("/proc/device-tree/chosen/linux,crashkernel-size", &value)) {
+		*end = *start + value - 1;
+	}
+	else
+		*end = 0;
+	return 0;
+}
+
 int is_crashkernel_mem_reserved(void)
 {
-	int fd;
+	return get_devtree_value("/proc/device-tree/chosen/linux,crashkernel-base", NULL);
+}
 
-	fd = open("/proc/device-tree/chosen/linux,crashkernel-base", O_RDONLY);
-	if (fd < 0)
-		return 0;
-	close(fd);
-	return 1;
+void print_crashkernel_region_size(void)
+{
+        uint64_t start = 0, end = 0;
+
+        if (is_crashkernel_mem_reserved()) {
+                get_crash_kernel_load_range(&start, &end);
+                printf("%llu\n", end - start + 1);
+        } else
+                printf("0\n");
 }
 
 #if 0
diff --git a/kexec/arch/ppc64/kexec-ppc64.c b/kexec/arch/ppc64/kexec-ppc64.c
index 09ee025..dd0fc67 100644
--- a/kexec/arch/ppc64/kexec-ppc64.c
+++ b/kexec/arch/ppc64/kexec-ppc64.c
@@ -356,6 +356,29 @@ void scan_reserved_ranges(unsigned long kexec_flags, int *range_index)
 	*range_index = i;
 }
 
+int get_devtree_value (const char *fname, unsigned long long *pvalue)
+{
+	/* Return 1 if fname/value valid, 0 otherwise */
+	FILE *file;
+	char buf[MAXBYTES];
+	int rcode = 1, n = -1;
+	unsigned long long value = 0;
+	if ((file = fopen(fname, "r"))) {
+		n = fread(buf, 1, MAXBYTES, file);
+		fclose(file);
+	}
+	if (n == sizeof(uint32_t)) {
+		value = ((uint32_t *)buf)[0];
+	} else if (n == sizeof(uint64_t)) {
+		value = ((uint64_t *)buf)[0];
+	} else {
+		fprintf(stderr, "%s node has invalid size: %d\n", fname, n);
+		rcode = 0;
+	}
+	if (pvalue) *pvalue = value;
+	return rcode;
+}
+
 /* Get devtree details and create exclude_range array
  * Also create usablemem_ranges for KEXEC_ON_CRASH
  */
diff --git a/kexec/arch/ppc64/kexec-ppc64.h b/kexec/arch/ppc64/kexec-ppc64.h
index 89ee942..3d20419 100644
--- a/kexec/arch/ppc64/kexec-ppc64.h
+++ b/kexec/arch/ppc64/kexec-ppc64.h
@@ -14,6 +14,8 @@
 #define HAVE_DYNAMIC_MEMORY
 #define NEED_RESERVE_DTB
 
+extern int get_devtree_value (const char *fname, unsigned long long *pvalue);
+
 int setup_memory_ranges(unsigned long kexec_flags);
 
 int elf_ppc64_probe(const char *buf, off_t len);
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
