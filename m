Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from shell.v3.sk ([195.168.3.45])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VMGjR-00089R-Vn
 for kexec@lists.infradead.org; Wed, 18 Sep 2013 12:19:50 +0000
From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2] dump-dmesg: Understand >= v3.11-rc4 dmesg
Date: Wed, 18 Sep 2013 14:19:14 +0200
Message-Id: <1379506754-24222-1-git-send-email-lkundrak@v3.sk>
In-Reply-To: <522979FA.7090409@mxc.nes.nec.co.jp>
References: <522979FA.7090409@mxc.nes.nec.co.jp>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, kexec@lists.infradead.org
Cc: Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>, Minoru Usui <usui@mxm.nes.nec.co.jp>, Lubomir Rintel <lkundrak@v3.sk>, Masaki Tachibana <tachibana@mxm.nes.nec.co.jp>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, Louis Bouchard <louis.bouchard@canonical.com>

Symbol name changed with the following commit:
62e32ac printk: rename struct log to struct printk_log

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Cc: Louis Bouchard <louis.bouchard@canonical.com>
Cc: Masaki Tachibana <tachibana@mxm.nes.nec.co.jp>
Cc: Minoru Usui <usui@mxm.nes.nec.co.jp>
Cc: Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>
Cc: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
So, the change did make it into 3.11.
Does this make sense?

Changes for v2:
  * Only back values for symbol names we did actually read; either "log"
    or "printk_log"

 makedumpfile.c |   66 ++++++++++++++++++++++++++++++++++++++++---------------
 makedumpfile.h |    5 ++-
 2 files changed, 51 insertions(+), 20 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index b42565c..6f00167 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -49,6 +49,7 @@ unsigned long long pfn_hwpoison;
 
 unsigned long long num_dumped;
 
+int use_printk_log;	/* did we read printk_log symbol name? */
 int retcd = FAILED;	/* return code */
 
 #define INITIALIZE_LONG_TABLE(table, value) \
@@ -1389,10 +1390,19 @@ get_structure_info(void)
 	OFFSET_INIT(elf64_phdr.p_paddr, "elf64_phdr", "p_paddr");
 	OFFSET_INIT(elf64_phdr.p_memsz, "elf64_phdr", "p_memsz");
 
-	SIZE_INIT(log, "log");
-	OFFSET_INIT(log.ts_nsec, "log", "ts_nsec");
-	OFFSET_INIT(log.len, "log", "len");
-	OFFSET_INIT(log.text_len, "log", "text_len");
+	SIZE_INIT(printk_log, "printk_log");
+	if (SIZE(printk_log) != NOT_FOUND_STRUCTURE) {
+		use_printk_log = 1;
+		OFFSET_INIT(printk_log.ts_nsec, "printk_log", "ts_nsec");
+		OFFSET_INIT(printk_log.len, "printk_log", "len");
+		OFFSET_INIT(printk_log.text_len, "printk_log", "text_len");
+	} else {
+		use_printk_log = 0;
+		SIZE_INIT(printk_log, "log");
+		OFFSET_INIT(printk_log.ts_nsec, "log", "ts_nsec");
+		OFFSET_INIT(printk_log.len, "log", "len");
+		OFFSET_INIT(printk_log.text_len, "log", "text_len");
+	}
 
 	return TRUE;
 }
@@ -1593,7 +1603,10 @@ write_vmcoreinfo_data(void)
 	WRITE_STRUCTURE_SIZE("node_memblk_s", node_memblk_s);
 	WRITE_STRUCTURE_SIZE("nodemask_t", nodemask_t);
 	WRITE_STRUCTURE_SIZE("pageflags", pageflags);
-	WRITE_STRUCTURE_SIZE("log", log);
+	if (use_printk_log)
+		WRITE_STRUCTURE_SIZE("printk_log", printk_log);
+	else
+		WRITE_STRUCTURE_SIZE("log", printk_log);
 
 	/*
 	 * write the member offset of 1st kernel
@@ -1628,9 +1641,16 @@ write_vmcoreinfo_data(void)
 	WRITE_MEMBER_OFFSET("vm_struct.addr", vm_struct.addr);
 	WRITE_MEMBER_OFFSET("vmap_area.va_start", vmap_area.va_start);
 	WRITE_MEMBER_OFFSET("vmap_area.list", vmap_area.list);
-	WRITE_MEMBER_OFFSET("log.ts_nsec", log.ts_nsec);
-	WRITE_MEMBER_OFFSET("log.len", log.len);
-	WRITE_MEMBER_OFFSET("log.text_len", log.text_len);
+	if (use_printk_log) {
+		WRITE_MEMBER_OFFSET("printk_log.ts_nsec", printk_log.ts_nsec);
+		WRITE_MEMBER_OFFSET("printk_log.len", printk_log.len);
+		WRITE_MEMBER_OFFSET("printk_log.text_len", printk_log.text_len);
+	} else {
+		/* Compatibility with pre-3.11-rc4 */
+		WRITE_MEMBER_OFFSET("log.ts_nsec", printk_log.ts_nsec);
+		WRITE_MEMBER_OFFSET("log.len", printk_log.len);
+		WRITE_MEMBER_OFFSET("log.text_len", printk_log.text_len);
+	}
 
 	if (SYMBOL(node_data) != NOT_FOUND_SYMBOL)
 		WRITE_ARRAY_LENGTH("node_data", node_data);
@@ -1909,7 +1929,6 @@ read_vmcoreinfo(void)
 	READ_STRUCTURE_SIZE("node_memblk_s", node_memblk_s);
 	READ_STRUCTURE_SIZE("nodemask_t", nodemask_t);
 	READ_STRUCTURE_SIZE("pageflags", pageflags);
-	READ_STRUCTURE_SIZE("log", log);
 
 	READ_MEMBER_OFFSET("page.flags", page.flags);
 	READ_MEMBER_OFFSET("page._count", page._count);
@@ -1940,9 +1959,20 @@ read_vmcoreinfo(void)
 	READ_MEMBER_OFFSET("vm_struct.addr", vm_struct.addr);
 	READ_MEMBER_OFFSET("vmap_area.va_start", vmap_area.va_start);
 	READ_MEMBER_OFFSET("vmap_area.list", vmap_area.list);
-	READ_MEMBER_OFFSET("log.ts_nsec", log.ts_nsec);
-	READ_MEMBER_OFFSET("log.len", log.len);
-	READ_MEMBER_OFFSET("log.text_len", log.text_len);
+
+	READ_STRUCTURE_SIZE("printk_log", printk_log);
+	if (SIZE(printk_log) != NOT_FOUND_STRUCTURE) {
+		use_printk_log = 1;
+		READ_MEMBER_OFFSET("printk_log.ts_nsec", printk_log.ts_nsec);
+		READ_MEMBER_OFFSET("printk_log.len", printk_log.len);
+		READ_MEMBER_OFFSET("printk_log.text_len", printk_log.text_len);
+	} else {
+		use_printk_log = 0;
+		READ_STRUCTURE_SIZE("log", printk_log);
+		READ_MEMBER_OFFSET("log.ts_nsec", printk_log.ts_nsec);
+		READ_MEMBER_OFFSET("log.len", printk_log.len);
+		READ_MEMBER_OFFSET("log.text_len", printk_log.text_len);
+	}
 
 	READ_ARRAY_LENGTH("node_data", node_data);
 	READ_ARRAY_LENGTH("pgdat_list", pgdat_list);
@@ -3705,13 +3735,13 @@ dump_log_entry(char *logptr, int fp)
 	ulonglong nanos;
 	ulong rem;
 
-	text_len = USHORT(logptr + OFFSET(log.text_len));
-	ts_nsec = ULONGLONG(logptr + OFFSET(log.ts_nsec));
+	text_len = USHORT(logptr + OFFSET(printk_log.text_len));
+	ts_nsec = ULONGLONG(logptr + OFFSET(printk_log.ts_nsec));
 
 	nanos = (ulonglong)ts_nsec / (ulonglong)1000000000;
 	rem = (ulonglong)ts_nsec % (ulonglong)1000000000;
 
-	msg = logptr + SIZE(log);
+	msg = logptr + SIZE(printk_log);
 
 	sprintf(buf, "[%5lld.%06ld] ", nanos, rem/1000);
 
@@ -3749,7 +3779,7 @@ log_from_idx(unsigned int idx, char *logbuf)
 	 * the buffer.
 	 */
 
-	msglen = USHORT(logptr + OFFSET(log.len));
+	msglen = USHORT(logptr + OFFSET(printk_log.len));
 	if (!msglen)
 		logptr = logbuf;
 
@@ -3770,9 +3800,9 @@ log_next(unsigned int idx, char *logbuf)
 	 * return the one after that.
 	 */
 
-	msglen = USHORT(logptr + OFFSET(log.len));
+	msglen = USHORT(logptr + OFFSET(printk_log.len));
 	if (!msglen) {
-		msglen = USHORT(logbuf + OFFSET(log.len));
+		msglen = USHORT(logbuf + OFFSET(printk_log.len));
 		return msglen;
 	}
 
diff --git a/makedumpfile.h b/makedumpfile.h
index a5826e0..c33852a 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1198,6 +1198,7 @@ struct size_table {
 	long	cpumask_t;
 	long	kexec_segment;
 	long	elf64_hdr;
+	long	printk_log;
 	long	log;
 
 	long	pageflags;
@@ -1337,11 +1338,11 @@ struct offset_table {
 		long	p_memsz;
 	} elf64_phdr;
 
-	struct log_s {
+	struct printk_log_s {
 		long ts_nsec;
 		long len;
 		long text_len;
-	} log;
+	} printk_log;
 
 };
 
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
