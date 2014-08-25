Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XLl3m-0000N7-Qw
 for kexec@lists.infradead.org; Mon, 25 Aug 2014 03:35:11 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v4 2/8] functions to get crashkernel memory range
Date: Mon, 25 Aug 2014 11:33:06 +0800
Message-Id: <1408937592-2609-3-git-send-email-bhe@redhat.com>
In-Reply-To: <1408937592-2609-1-git-send-email-bhe@redhat.com>
References: <1408937592-2609-1-git-send-email-bhe@redhat.com>
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
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, Baoquan He <bhe@redhat.com>, vgoyal@redhat.com

These functions are used to parse /proc/iomem code and get memory
ranges of specific type. They are implemented in kexec-tools and
borrowed here to get the crashkernel memory range. Since crashkernel
memory range should be excluded from dumpable memory ranges.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 makedumpfile.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 makedumpfile.h |  7 +++++
 2 files changed, 89 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index a01703e..44cf26f 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -9043,6 +9043,88 @@ calculate_cyclic_buffer_size(void) {
 	return TRUE;
 }
 
+
+
+//#define CRASH_RESERVED_MEM_NR   8
+struct memory_range crash_reserved_mem[CRASH_RESERVED_MEM_NR];
+int crash_reserved_mem_nr;
+
+/*
+ * iomem_for_each_line()
+ *
+ * Iterate over each line in the file returned by proc_iomem(). If match is
+ * NULL or if the line matches with our match-pattern then call the
+ * callback if non-NULL.
+ *
+ * Return the number of lines matched.
+ */
+int iomem_for_each_line(char *match,
+			      int (*callback)(void *data,
+					      int nr,
+					      char *str,
+					      unsigned long base,
+					      unsigned long length),
+			      void *data)
+{
+	const char iomem[] = "/proc/iomem";
+	char line[BUFSIZE_FGETS];
+	FILE *fp;
+	unsigned long long start, end, size;
+	char *str;
+	int consumed;
+	int count;
+	int nr = 0;
+
+	fp = fopen(iomem, "r");
+	if (!fp) {
+		ERRMSG("Cannot open %s\n", iomem);
+		return nr;
+	}
+
+	while(fgets(line, sizeof(line), fp) != 0) {
+		count = sscanf(line, "%Lx-%Lx : %n", &start, &end, &consumed);
+		if (count != 2)
+			continue;
+		str = line + consumed;
+		size = end - start + 1;
+		if (!match || memcmp(str, match, strlen(match)) == 0) {
+			if (callback
+			    && callback(data, nr, str, start, size) < 0) {
+				break;
+			}
+			nr++;
+		}
+	}
+
+	fclose(fp);
+
+	return nr;
+}
+
+static int crashkernel_mem_callback(void *data, int nr,
+                                          char *str,
+                                          unsigned long base,
+                                          unsigned long length)
+{
+        if (nr >= CRASH_RESERVED_MEM_NR)
+                return 1;
+
+        crash_reserved_mem[nr].start = base;
+        crash_reserved_mem[nr].end   = base + length - 1;
+        return 0;
+}
+
+int is_crashkernel_mem_reserved(void)
+{
+        int ret;
+
+        ret = iomem_for_each_line("Crash kernel\n",
+                                        crashkernel_mem_callback, NULL);
+        crash_reserved_mem_nr = ret;
+
+        return !!crash_reserved_mem_nr;
+}
+
 static struct option longopts[] = {
 	{"split", no_argument, NULL, OPT_SPLIT},
 	{"reassemble", no_argument, NULL, OPT_REASSEMBLE},
diff --git a/makedumpfile.h b/makedumpfile.h
index 9f90b53..ed584af 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1540,6 +1540,13 @@ extern struct array_table	array_table;
 extern struct number_table	number_table;
 extern struct srcfile_table	srcfile_table;
 
+struct memory_range {
+        unsigned long long start, end;
+};
+
+#define CRASH_RESERVED_MEM_NR   8
+struct memory_range crash_reserved_mem[CRASH_RESERVED_MEM_NR];
+int crash_reserved_mem_nr;
 
 int readmem(int type_addr, unsigned long long addr, void *bufptr, size_t size);
 int get_str_osrelease_from_vmlinux(void);
-- 
1.8.5.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
