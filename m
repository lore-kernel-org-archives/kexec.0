Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TWil7-00035n-As
 for kexec@lists.infradead.org; Fri, 09 Nov 2012 07:12:13 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.195])
 by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id qA97C7vO004526
 for <kexec@lists.infradead.org>; Fri, 9 Nov 2012 16:12:07 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id qA97C6428669 for kexec@lists.infradead.org;
 Fri, 9 Nov 2012 16:12:06 +0900 (JST)
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
 by mailsv4.nec.co.jp (8.13.8/8.13.4) with ESMTP id qA97C6fN022359
 for <kexec@lists.infradead.org>; Fri, 9 Nov 2012 16:12:06 +0900 (JST)
Date: Fri, 9 Nov 2012 16:02:53 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [PATCH 1/3] Add get_free_memory_size() to get the amount of free
 memory.
Message-Id: <20121109160253.868fb6911c63fe7caeb4dfe2@mxc.nes.nec.co.jp>
In-Reply-To: <20121109160214.afe15ee1a047ff7354471ba0@mxc.nes.nec.co.jp>
References: <20121109160214.afe15ee1a047ff7354471ba0@mxc.nes.nec.co.jp>
Mime-Version: 1.0
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

get_free_memory_size() reads /proc/meminfo and consider "MemFree:"
the amount of free memory.

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 makedumpfile.c | 34 ++++++++++++++++++++++++++++++++++
 makedumpfile.h |  1 +
 2 files changed, 35 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index 1183330..73a466e 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -7972,6 +7972,40 @@ out:
 	return ret;
 }
 
+/*
+ * Get the amount of free memory from /proc/meminfo.
+ */
+unsigned long long
+get_free_memory_size(void) {
+	char buf[BUFSIZE_FGETS];
+	char unit[4];
+	unsigned long long free_size = 0;
+	char *name_meminfo = "/proc/meminfo";
+	FILE *file_meminfo;
+
+	if ((file_meminfo = fopen(name_meminfo, "r")) == NULL) {
+		ERRMSG("Can't open the %s. %s\n", name_meminfo, strerror(errno));
+		return FALSE;
+	}
+
+	while (fgets(buf, BUFSIZE_FGETS, file_meminfo) != NULL) {
+		if (sscanf(buf, "MemFree: %llu %s", &free_size, unit) == 2) {
+			if (strcmp(unit, "kB") == 0) {
+				free_size *= 1024;
+				goto out;
+			}
+		}
+	}
+
+	ERRMSG("Can't get free memory size.\n");
+	free_size = 0;
+out:
+	if (fclose(file_meminfo) < 0)
+		ERRMSG("Can't close the %s. %s\n", name_meminfo, strerror(errno));
+
+	return free_size;
+}
+
 static struct option longopts[] = {
 	{"split", no_argument, NULL, 's'}, 
 	{"reassemble", no_argument, NULL, 'r'},
diff --git a/makedumpfile.h b/makedumpfile.h
index 97aca2a..c91b4e9 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1611,5 +1611,6 @@ struct elf_prstatus {
 unsigned long long get_num_dumpable_cyclic(void);
 int get_loads_dumpfile_cyclic(void);
 int initial_xen(void);
+unsigned long long get_free_memory_size(void);
 
 #endif /* MAKEDUMPFILE_H */
-- 
1.7.11

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
