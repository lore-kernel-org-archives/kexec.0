Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XD7LA-0000d2-6f
 for kexec@lists.infradead.org; Fri, 01 Aug 2014 07:33:24 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [Patch v3 2/7] functions to get crashkernel memory range
Date: Fri, 1 Aug 2014 07:32:01 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE97246701@BPXM01GP.gisp.nec.co.jp>
References: <1406535606-16303-1-git-send-email-bhe@redhat.com>
 <1406535606-16303-3-git-send-email-bhe@redhat.com>
In-Reply-To: <1406535606-16303-3-git-send-email-bhe@redhat.com>
Content-Language: ja-JP
MIME-Version: 1.0
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "bhe@redhat.com" <bhe@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "vgoyal@redhat.com" <vgoyal@redhat.com>

>These functions are used to parse /proc/iomem code and get memory
>ranges of specific type. They are implemented in kexec-tools and
>borrowed here to get the crashkernel memory range. Since crashkernel
>memory range should be excluded from dumpable memory ranges.
>
>Signed-off-by: Baoquan He <bhe@redhat.com>
>---
> makedumpfile.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> makedumpfile.h |  7 +++++
> 2 files changed, 89 insertions(+)
>
>diff --git a/makedumpfile.c b/makedumpfile.c
>index 760bfd1..220570e 100644
>--- a/makedumpfile.c
>+++ b/makedumpfile.c
>@@ -8980,6 +8980,88 @@ calculate_cyclic_buffer_size(void) {
> 	return TRUE;
> }
>
>+
>+
>+//#define CRASH_RESERVED_MEM_NR   8
>+struct memory_range crash_reserved_mem[CRASH_RESERVED_MEM_NR];
>+int crash_reserved_mem_nr;
>+
>+/*
>+ * iomem_for_each_line()
>+ *
>+ * Iterate over each line in the file returned by proc_iomem(). If match is
>+ * NULL or if the line matches with our match-pattern then call the
>+ * callback if non-NULL.
>+ *
>+ * Return the number of lines matched.
>+ */
>+int iomem_for_each_line(char *match,
>+			      int (*callback)(void *data,
>+					      int nr,
>+					      char *str,
>+					      unsigned long base,
>+					      unsigned long length),
>+			      void *data)
>+{
>+	const char iomem[] = "/proc/iomem";
>+	char line[BUFSIZE_FGETS];
>+	FILE *fp;
>+	unsigned long long start, end, size;
>+	char *str;
>+	int consumed;
>+	int count;
>+	int nr = 0;
>+
>+	fp = fopen(iomem, "r");
>+	if (!fp) {
>+		ERRMSG("Cannot open %s\n", iomem);
>+		exit(1);
>+	}

Could you change this to return ERROR and handle it in the
caller side? It's a coding style of makedumpfile.


Thanks
Atsushi Kumagai

>+
>+	while(fgets(line, sizeof(line), fp) != 0) {
>+		count = sscanf(line, "%Lx-%Lx : %n", &start, &end, &consumed);
>+		if (count != 2)
>+			continue;
>+		str = line + consumed;
>+		size = end - start + 1;
>+		if (!match || memcmp(str, match, strlen(match)) == 0) {
>+			if (callback
>+			    && callback(data, nr, str, start, size) < 0) {
>+				break;
>+			}
>+			nr++;
>+		}
>+	}
>+
>+	fclose(fp);
>+
>+	return nr;
>+}
>+
>+static int crashkernel_mem_callback(void *data, int nr,
>+                                          char *str,
>+                                          unsigned long base,
>+                                          unsigned long length)
>+{
>+        if (nr >= CRASH_RESERVED_MEM_NR)
>+                return 1;
>+
>+        crash_reserved_mem[nr].start = base;
>+        crash_reserved_mem[nr].end   = base + length - 1;
>+        return 0;
>+}
>+
>+int is_crashkernel_mem_reserved(void)
>+{
>+        int ret;
>+
>+        ret = iomem_for_each_line("Crash kernel\n",
>+                                        crashkernel_mem_callback, NULL);
>+        crash_reserved_mem_nr = ret;
>+
>+        return !!crash_reserved_mem_nr;
>+}
>+
> static struct option longopts[] = {
> 	{"split", no_argument, NULL, OPT_SPLIT},
> 	{"reassemble", no_argument, NULL, OPT_REASSEMBLE},
>diff --git a/makedumpfile.h b/makedumpfile.h
>index 9402f05..7ffa1ee 100644
>--- a/makedumpfile.h
>+++ b/makedumpfile.h
>@@ -1452,6 +1452,13 @@ extern struct array_table	array_table;
> extern struct number_table	number_table;
> extern struct srcfile_table	srcfile_table;
>
>+struct memory_range {
>+        unsigned long long start, end;
>+};
>+
>+#define CRASH_RESERVED_MEM_NR   8
>+struct memory_range crash_reserved_mem[CRASH_RESERVED_MEM_NR];
>+int crash_reserved_mem_nr;
>
> int readmem(int type_addr, unsigned long long addr, void *bufptr, size_t size);
> int get_str_osrelease_from_vmlinux(void);
>--
>1.8.5.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
