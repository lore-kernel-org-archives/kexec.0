Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from shell.v3.sk ([195.168.3.45])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VGDsY-0000VP-Mu
 for kexec@lists.infradead.org; Sun, 01 Sep 2013 20:04:12 +0000
From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] dump-dmesg: Understand >= v3.11-rc4 dmesg
Date: Sun,  1 Sep 2013 22:05:00 +0200
Message-Id: <1378065900-20513-1-git-send-email-lkundrak@v3.sk>
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
To: kexec@lists.infradead.org
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
 makedumpfile.c |   56 ++++++++++++++++++++++++++++++++++++++------------------
 makedumpfile.h |    6 +++---
 2 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index b42565c..5b04048 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1389,10 +1389,17 @@ get_structure_info(void)
 	OFFSET_INIT(elf64_phdr.p_paddr, "elf64_phdr", "p_paddr");
 	OFFSET_INIT(elf64_phdr.p_memsz, "elf64_phdr", "p_memsz");
 
-	SIZE_INIT(log, "log");
-	OFFSET_INIT(log.ts_nsec, "log", "ts_nsec");
-	OFFSET_INIT(log.len, "log", "len");
-	OFFSET_INIT(log.text_len, "log", "text_len");
+	SIZE_INIT(printk_log, "printk_log");
+	if (SIZE(printk_log) != NOT_FOUND_STRUCTURE) {
+		OFFSET_INIT(printk_log.ts_nsec, "printk_log", "ts_nsec");
+		OFFSET_INIT(printk_log.len, "printk_log", "len");
+		OFFSET_INIT(printk_log.text_len, "printk_log", "text_len");
+	} else {
+		SIZE_INIT(printk_log, "log");
+		OFFSET_INIT(printk_log.ts_nsec, "log", "ts_nsec");
+		OFFSET_INIT(printk_log.len, "log", "len");
+		OFFSET_INIT(printk_log.text_len, "log", "text_len");
+	}
 
 	return TRUE;
 }
@@ -1593,7 +1600,8 @@ write_vmcoreinfo_data(void)
 	WRITE_STRUCTURE_SIZE("node_memblk_s", node_memblk_s);
 	WRITE_STRUCTURE_SIZE("nodemask_t", nodemask_t);
 	WRITE_STRUCTURE_SIZE("pageflags", pageflags);
-	WRITE_STRUCTURE_SIZE("log", log);
+	WRITE_STRUCTURE_SIZE("printk_log", printk_log);
+	WRITE_STRUCTURE_SIZE("log", printk_log); /* compat */
 
 	/*
 	 * write the member offset of 1st kernel
@@ -1628,9 +1636,13 @@ write_vmcoreinfo_data(void)
 	WRITE_MEMBER_OFFSET("vm_struct.addr", vm_struct.addr);
 	WRITE_MEMBER_OFFSET("vmap_area.va_start", vmap_area.va_start);
 	WRITE_MEMBER_OFFSET("vmap_area.list", vmap_area.list);
-	WRITE_MEMBER_OFFSET("log.ts_nsec", log.ts_nsec);
-	WRITE_MEMBER_OFFSET("log.len", log.len);
-	WRITE_MEMBER_OFFSET("log.text_len", log.text_len);
+	WRITE_MEMBER_OFFSET("printk_log.ts_nsec", printk_log.ts_nsec);
+	WRITE_MEMBER_OFFSET("printk_log.len", printk_log.len);
+	WRITE_MEMBER_OFFSET("printk_log.text_len", printk_log.text_len);
+	/* Compatibility with pre-3.11-rc4 */
+	WRITE_MEMBER_OFFSET("log.ts_nsec", printk_log.ts_nsec);
+	WRITE_MEMBER_OFFSET("log.len", printk_log.len);
+	WRITE_MEMBER_OFFSET("log.text_len", printk_log.text_len);
 
 	if (SYMBOL(node_data) != NOT_FOUND_SYMBOL)
 		WRITE_ARRAY_LENGTH("node_data", node_data);
@@ -1909,7 +1921,6 @@ read_vmcoreinfo(void)
 	READ_STRUCTURE_SIZE("node_memblk_s", node_memblk_s);
 	READ_STRUCTURE_SIZE("nodemask_t", nodemask_t);
 	READ_STRUCTURE_SIZE("pageflags", pageflags);
-	READ_STRUCTURE_SIZE("log", log);
 
 	READ_MEMBER_OFFSET("page.flags", page.flags);
 	READ_MEMBER_OFFSET("page._count", page._count);
@@ -1940,9 +1951,18 @@ read_vmcoreinfo(void)
 	READ_MEMBER_OFFSET("vm_struct.addr", vm_struct.addr);
 	READ_MEMBER_OFFSET("vmap_area.va_start", vmap_area.va_start);
 	READ_MEMBER_OFFSET("vmap_area.list", vmap_area.list);
-	READ_MEMBER_OFFSET("log.ts_nsec", log.ts_nsec);
-	READ_MEMBER_OFFSET("log.len", log.len);
-	READ_MEMBER_OFFSET("log.text_len", log.text_len);
+
+	READ_STRUCTURE_SIZE("printk_log", printk_log);
+	if (SIZE(printk_log) != NOT_FOUND_STRUCTURE) {
+		READ_MEMBER_OFFSET("printk_log.ts_nsec", printk_log.ts_nsec);
+		READ_MEMBER_OFFSET("printk_log.len", printk_log.len);
+		READ_MEMBER_OFFSET("printk_log.text_len", printk_log.text_len);
+	} else {
+		READ_STRUCTURE_SIZE("log", printk_log);
+		READ_MEMBER_OFFSET("log.ts_nsec", printk_log.ts_nsec);
+		READ_MEMBER_OFFSET("log.len", printk_log.len);
+		READ_MEMBER_OFFSET("log.text_len", printk_log.text_len);
+	}
 
 	READ_ARRAY_LENGTH("node_data", node_data);
 	READ_ARRAY_LENGTH("pgdat_list", pgdat_list);
@@ -3705,13 +3725,13 @@ dump_log_entry(char *logptr, int fp)
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
 
@@ -3749,7 +3769,7 @@ log_from_idx(unsigned int idx, char *logbuf)
 	 * the buffer.
 	 */
 
-	msglen = USHORT(logptr + OFFSET(log.len));
+	msglen = USHORT(logptr + OFFSET(printk_log.len));
 	if (!msglen)
 		logptr = logbuf;
 
@@ -3770,9 +3790,9 @@ log_next(unsigned int idx, char *logbuf)
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
index a5826e0..5b96c11 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1198,7 +1198,7 @@ struct size_table {
 	long	cpumask_t;
 	long	kexec_segment;
 	long	elf64_hdr;
-	long	log;
+	long	printk_log;
 
 	long	pageflags;
 };
@@ -1337,11 +1337,11 @@ struct offset_table {
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
