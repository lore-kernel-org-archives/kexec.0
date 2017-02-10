Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1ccJMa-0004hj-PA
 for kexec@lists.infradead.org; Fri, 10 Feb 2017 22:08:26 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
Subject: [PATCH v3 07/11] crashdump/ppc: Add get_crash_kernel_load_range()
 function
Date: Fri, 10 Feb 2017 16:07:38 -0600
Message-Id: <1486764462-14176-8-git-send-email-eric.devolder@oracle.com>
In-Reply-To: <1486764462-14176-1-git-send-email-eric.devolder@oracle.com>
References: <1486764462-14176-1-git-send-email-eric.devolder@oracle.com>
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
---
 kexec/arch/ppc/crashdump-powerpc.c | 22 +++++++++++++++++++++-
 kexec/arch/ppc/kexec-ppc.c         | 27 +++++++++++++++++++++++++++
 kexec/arch/ppc/kexec-ppc.h         |  1 +
 3 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/ppc/crashdump-powerpc.c b/kexec/arch/ppc/crashdump-powerpc.c
index 3dc35eb..fc5d70c 100644
--- a/kexec/arch/ppc/crashdump-powerpc.c
+++ b/kexec/arch/ppc/crashdump-powerpc.c
@@ -397,6 +397,27 @@ void add_usable_mem_rgns(unsigned long long base, unsigned long long size)
 		usablemem_rgns.size, base, size);
 }
 
+int get_crash_kernel_load_range(uint64_t *start, uint64_t *end)
+{
+	unsigned long long value;
+	int ret = 0;
+
+	if (get_devtree_value("/proc/device-tree/chosen/linux,crashkernel-base", &value))
+		*start = value;
+	else {
+		*start = 0;
+		ret = -1;
+	}
+	if (get_devtree_value("/proc/device-tree/chosen/linux,crashkernel-size", &value))
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
@@ -407,4 +428,3 @@ int is_crashkernel_mem_reserved(void)
 	close(fd);
 	return 1;
 }
-
diff --git a/kexec/arch/ppc/kexec-ppc.c b/kexec/arch/ppc/kexec-ppc.c
index d046110..d9cdb9c 100644
--- a/kexec/arch/ppc/kexec-ppc.c
+++ b/kexec/arch/ppc/kexec-ppc.c
@@ -423,6 +423,33 @@ err_out:
 	return -1;
 }
 
+int get_devtree_value(const char *fname, unsigned long long *pvalue)
+{
+	/* Return 1 if fname/value valid, 0 otherwise */
+	FILE *file;
+	char buf[MAXBYTES];
+	int ret = 1, n = -1;
+	unsigned long long value = 0;
+
+	if ((file = fopen(fname, "r"))) {
+		n = fread(buf, 1, MAXBYTES, file);
+		fclose(file);
+	}
+
+	if (n == sizeof(uint32_t))
+		value = ((uint32_t *)buf)[0];
+	else if (n == sizeof(uint64_t)) {
+		value = ((uint64_t *)buf)[0];
+	else {
+		fprintf(stderr, "%s node has invalid size: %d\n", fname, n);
+		ret = 0;
+	}
+
+	if (pvalue)
+		*pvalue = value;
+	return ret;
+}
+
 /* Get devtree details and create exclude_range array
  * Also create usablemem_ranges for KEXEC_ON_CRASH
  */
diff --git a/kexec/arch/ppc/kexec-ppc.h b/kexec/arch/ppc/kexec-ppc.h
index 904cf48..0e52d18 100644
--- a/kexec/arch/ppc/kexec-ppc.h
+++ b/kexec/arch/ppc/kexec-ppc.h
@@ -75,6 +75,7 @@ extern unsigned long dt_address_cells, dt_size_cells;
 extern int init_memory_region_info(void);
 extern int read_memory_region_limits(int fd, unsigned long long *start,
 					unsigned long long *end);
+extern int get_devtree_value (const char *fname, unsigned long long *pvalue);
 #define COMMAND_LINE_SIZE	512 /* from kernel */
 /*fs2dt*/
 void reserve(unsigned long long where, unsigned long long length);
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
