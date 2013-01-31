Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1U0scs-0005b8-Da
 for kexec@lists.infradead.org; Thu, 31 Jan 2013 11:48:19 +0000
Received: from 171.136.114.78.rev.sfr.net ([78.114.136.171]
 helo=localhost.localdomain)
 by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <louis.bouchard@canonical.com>)
 id 1U0scr-00044r-7a
 for kexec@lists.infradead.org; Thu, 31 Jan 2013 11:48:17 +0000
From: Louis Bouchard <louis.bouchard@canonical.com>
Subject: [PATCH] --dump-dmesg fix for post 3.5 kernels
Date: Thu, 31 Jan 2013 12:48:08 +0100
Message-Id: <1359632888-11345-2-git-send-email-louis.bouchard@canonical.com>
In-Reply-To: <1359632888-11345-1-git-send-email-louis.bouchard@canonical.com>
References: <1359632888-11345-1-git-send-email-louis.bouchard@canonical.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

       This patch enable the --dump-dmesg functionality that
       was broken with post 3.5 kernel which use the variable-length
       record format for the kernel log buffer.

Signed-off-by: Louis Bouchard <louis.bouchard@canonical.com>
---
 makedumpfile.c |  242 +++++++++++++++++++++++++++++++++++++++++++++-----------
 makedumpfile.h |   16 ++++
 2 files changed, 213 insertions(+), 45 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 715ca6e..a5180f6 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -20,6 +20,7 @@
 #include "erase_info.h"
 #include "sadump_info.h"
 #include <stddef.h>
+#include <ctype.h>
 #include <sys/time.h>
 
 struct symbol_table	symbol_table;
@@ -848,6 +849,8 @@ get_symbol_info(void)
 	SYMBOL_INIT(log_buf, "log_buf");
 	SYMBOL_INIT(log_buf_len, "log_buf_len");
 	SYMBOL_INIT(log_end, "log_end");
+	SYMBOL_INIT(log_first_idx, "log_first_idx");
+	SYMBOL_INIT(log_next_idx, "log_next_idx");
 	SYMBOL_INIT(max_pfn, "max_pfn");
 	SYMBOL_INIT(modules, "modules");
 	SYMBOL_INIT(high_memory, "high_memory");
@@ -1176,6 +1179,13 @@ get_structure_info(void)
 	OFFSET_INIT(elf64_phdr.p_paddr, "elf64_phdr", "p_paddr");
 	OFFSET_INIT(elf64_phdr.p_memsz, "elf64_phdr", "p_memsz");
 
+	SIZE_INIT(log, "log");
+	OFFSET_INIT(log.ts_nsec, "log", "ts_nsec");
+	OFFSET_INIT(log.len, "log", "len");
+	OFFSET_INIT(log.text_len, "log", "text_len");
+	OFFSET_INIT(log.dict_len, "log", "dict_len");
+	OFFSET_INIT(log.dict_len, "log", "level");
+
 	return TRUE;
 }
 
@@ -1354,6 +1364,8 @@ write_vmcoreinfo_data(void)
 	WRITE_SYMBOL("log_buf", log_buf);
 	WRITE_SYMBOL("log_buf_len", log_buf_len);
 	WRITE_SYMBOL("log_end", log_end);
+	WRITE_SYMBOL("log_first_idx", log_first_idx);
+	WRITE_SYMBOL("log_next_idx", log_next_idx);
 	WRITE_SYMBOL("max_pfn", max_pfn);
 	WRITE_SYMBOL("high_memory", high_memory);
 	WRITE_SYMBOL("node_remap_start_vaddr", node_remap_start_vaddr);
@@ -1404,6 +1416,10 @@ write_vmcoreinfo_data(void)
 	WRITE_MEMBER_OFFSET("node_memblk_s.size", node_memblk_s.size);
 	WRITE_MEMBER_OFFSET("node_memblk_s.nid", node_memblk_s.nid);
 	WRITE_MEMBER_OFFSET("vm_struct.addr", vm_struct.addr);
+	WRITE_MEMBER_OFFSET("log.ts_nsec",log.ts_nsec);
+	WRITE_MEMBER_OFFSET("log.len",log.len);
+	WRITE_MEMBER_OFFSET("log.text_len",log.text_len);
+	WRITE_MEMBER_OFFSET("log.dict_len",log.dict_len);
 
 	if (SYMBOL(node_data) != NOT_FOUND_SYMBOL)
 		WRITE_ARRAY_LENGTH("node_data", node_data);
@@ -1664,6 +1680,8 @@ read_vmcoreinfo(void)
 	READ_SYMBOL("log_buf", log_buf);
 	READ_SYMBOL("log_buf_len", log_buf_len);
 	READ_SYMBOL("log_end", log_end);
+	READ_SYMBOL("log_first_idx",log_first_idx);
+	READ_SYMBOL("log_next_idx",log_next_idx);
 	READ_SYMBOL("max_pfn", max_pfn);
 	READ_SYMBOL("high_memory", high_memory);
 	READ_SYMBOL("node_remap_start_vaddr", node_remap_start_vaddr);
@@ -1679,6 +1697,7 @@ read_vmcoreinfo(void)
 	READ_STRUCTURE_SIZE("node_memblk_s", node_memblk_s);
 	READ_STRUCTURE_SIZE("nodemask_t", nodemask_t);
 	READ_STRUCTURE_SIZE("pageflags", pageflags);
+	READ_STRUCTURE_SIZE("log", log);
 
 	READ_MEMBER_OFFSET("page.flags", page.flags);
 	READ_MEMBER_OFFSET("page._count", page._count);
@@ -1707,6 +1726,10 @@ read_vmcoreinfo(void)
 	READ_MEMBER_OFFSET("node_memblk_s.size", node_memblk_s.size);
 	READ_MEMBER_OFFSET("node_memblk_s.nid", node_memblk_s.nid);
 	READ_MEMBER_OFFSET("vm_struct.addr", vm_struct.addr);
+	READ_MEMBER_OFFSET("log.ts_nsec",log.ts_nsec);
+	READ_MEMBER_OFFSET("log.len",log.len);
+	READ_MEMBER_OFFSET("log.text_len",log.text_len);
+	READ_MEMBER_OFFSET("log.dict_len",log.dict_len);
 
 	READ_ARRAY_LENGTH("node_data", node_data);
 	READ_ARRAY_LENGTH("pgdat_list", pgdat_list);
@@ -3448,14 +3471,99 @@ reset_bitmap_of_free_pages(unsigned long node_zones)
 	return TRUE;
 }
 
+static int
+dump_log_entry(char *logptr, int fp)
+{
+	char *msg, *p;
+	unsigned int i, text_len;
+	unsigned long long ts_nsec;
+	char buf[BUFSIZE];
+	ulonglong nanos; 
+	ulong rem;
+
+	text_len = USHORT(logptr + OFFSET(log.text_len));
+	ts_nsec = ULONGLONG(logptr + OFFSET(log.ts_nsec));
+
+	nanos = (ulonglong)ts_nsec / (ulonglong)1000000000;
+	rem = (ulonglong)ts_nsec % (ulonglong)1000000000;
+
+	msg = logptr + SIZE(log);
+
+	sprintf(buf,"[%5lld.%06ld] ",nanos,rem/1000);
+
+        for (i = 0, p = msg; i < text_len; i++, p++) {
+                if (*p == '\n')
+                       sprintf(buf,"%s.",buf);
+                else if (isprint(*p) || isspace(*p))
+                       sprintf(buf,"%s%c",buf,*p);
+                else
+                       sprintf(buf,"%s.",buf);
+        }
+
+        sprintf(buf,"%s\n",buf);
+
+	if (write(info->fd_dumpfile, buf, strlen(buf)) < 0)
+		return FALSE;
+	else
+		return TRUE;
+}
+
+/* 
+ * get log record by index; idx must point to valid message.
+ */
+static char *
+log_from_idx(unsigned int idx, char *logbuf)
+{
+	char *logptr;
+	unsigned int msglen;
+
+	logptr = logbuf + idx;
+
+	/*
+	 * A length == 0 record is the end of buffer marker. 
+	 * Wrap around and return the message at the start of 
+	 * the buffer.
+	 */
+
+	msglen = USHORT(logptr + OFFSET(log.len));
+	if (!msglen)
+		logptr = logbuf;
+
+	return logptr;
+}
+
+static long 
+log_next(unsigned int idx, char *logbuf)
+{
+	char *logptr;
+	unsigned int msglen;
+
+	logptr = logbuf + idx;
+
+	/*
+	 * A length == 0 record is the end of buffer marker. Wrap around and
+	 * read the message at the start of the buffer as *this* one, and
+	 * return the one after that.
+	 */
+
+	msglen = USHORT(logptr + OFFSET(log.len));
+	if (!msglen) {
+		msglen = USHORT(logbuf + OFFSET(log.len));
+		return msglen;
+	}
+
+        return idx + msglen;
+}
+
 int
 dump_dmesg()
 {
 	int log_buf_len, length_log, length_oldlog, ret = FALSE;
-	unsigned long log_buf, log_end, index;
+	unsigned long index, log_buf, log_end;
+	unsigned int idx, log_first_idx, log_next_idx;
 	unsigned long log_end_2_6_24;
 	unsigned      log_end_2_6_25;
-	char *log_buffer = NULL;
+	char *log_buffer = NULL, *log_ptr = NULL;
 
 	/*
 	 * log_end has been changed to "unsigned" since linux-2.6.25.
@@ -3473,29 +3581,51 @@ dump_dmesg()
 		return FALSE;
 
 	if ((SYMBOL(log_buf) == NOT_FOUND_SYMBOL)
-	    || (SYMBOL(log_buf_len) == NOT_FOUND_SYMBOL)
-	    || (SYMBOL(log_end) == NOT_FOUND_SYMBOL)) {
+	    || (SYMBOL(log_buf_len) == NOT_FOUND_SYMBOL)) {
 		ERRMSG("Can't find some symbols for log_buf.\n");
 		return FALSE;
 	}
+	/*
+	* kernel 3.5 variable-length record buffer structure
+	*/
+	if (SYMBOL(log_end) == NOT_FOUND_SYMBOL) {
+		if ((SYMBOL(log_first_idx) == NOT_FOUND_SYMBOL)
+		   || (SYMBOL(log_next_idx) == NOT_FOUND_SYMBOL)){
+		   ERRMSG("Can't find variable-length record symbols");
+		   return FALSE;
+		} else {
+			if (!readmem(VADDR, SYMBOL(log_first_idx), &log_first_idx,
+	    		sizeof(log_first_idx))) {
+				ERRMSG("Can't get log_first_idx.\n");
+				return FALSE;
+				}
+			if (!readmem(VADDR, SYMBOL(log_next_idx), &log_next_idx,
+	    		sizeof(log_next_idx))) {
+				ERRMSG("Can't get log_next_idx.\n");
+				return FALSE;
+				}
+			}
+		}
 	if (!readmem(VADDR, SYMBOL(log_buf), &log_buf, sizeof(log_buf))) {
 		ERRMSG("Can't get log_buf.\n");
 		return FALSE;
 	}
-	if (info->kernel_version >= KERNEL_VERSION(2, 6, 25)) {
-		if (!readmem(VADDR, SYMBOL(log_end), &log_end_2_6_25,
-		    sizeof(log_end_2_6_25))) {
-			ERRMSG("Can't to get log_end.\n");
-			return FALSE;
-		}
-		log_end = log_end_2_6_25;
-	} else {
-		if (!readmem(VADDR, SYMBOL(log_end), &log_end_2_6_24,
-		    sizeof(log_end_2_6_24))) {
-			ERRMSG("Can't to get log_end.\n");
-			return FALSE;
+	if (info->kernel_version < KERNEL_VERSION(3, 5, 0)) {
+		if (info->kernel_version >= KERNEL_VERSION(2, 6, 25)) {
+			if (!readmem(VADDR, SYMBOL(log_end), &log_end_2_6_25,
+			    sizeof(log_end_2_6_25))) {
+				ERRMSG("Can't to get log_end.\n");
+				return FALSE;
+			}
+			log_end = log_end_2_6_25;
+		} else {
+			if (!readmem(VADDR, SYMBOL(log_end), &log_end_2_6_24,
+			    sizeof(log_end_2_6_24))) {
+				ERRMSG("Can't to get log_end.\n");
+				return FALSE;
+			}
+			log_end = log_end_2_6_24;
 		}
-		log_end = log_end_2_6_24;
 	}
 	if (!readmem(VADDR, SYMBOL(log_buf_len), &log_buf_len,
 	    sizeof(log_buf_len))) {
@@ -3503,47 +3633,69 @@ dump_dmesg()
 		return FALSE;
 	}
 	DEBUG_MSG("\n");
-	DEBUG_MSG("log_buf      : %lx\n", log_buf);
-	DEBUG_MSG("log_end      : %lx\n", log_end);
-	DEBUG_MSG("log_buf_len  : %d\n", log_buf_len);
+	DEBUG_MSG("log_buf       : %lx\n", log_buf);
+	DEBUG_MSG("log_end       : %lx\n", log_end);
+	DEBUG_MSG("log_buf_len   : %d\n", log_buf_len);
+	DEBUG_MSG("log_first_idx : %u\n", log_first_idx);
+	DEBUG_MSG("log_next_idx  : %u\n", log_next_idx);
 
 	if ((log_buffer = malloc(log_buf_len)) == NULL) {
 		ERRMSG("Can't allocate memory for log_buf. %s\n",
-		    strerror(errno));
+			   strerror(errno));
 		return FALSE;
 	}
-
-	if (log_end < log_buf_len) {
-		length_log = log_end;
-		if(!readmem(VADDR, log_buf, log_buffer, length_log)) {
-			ERRMSG("Can't read dmesg log.\n");
+	
+	if (info->kernel_version < KERNEL_VERSION(3, 5,0)) {
+		if (log_end < log_buf_len) {
+			length_log = log_end;
+			if(!readmem(VADDR, log_buf, log_buffer, length_log)) {
+				ERRMSG("Can't read dmesg log.\n");
+				goto out;
+			}
+		} else {
+			index = log_end & (log_buf_len - 1);
+			DEBUG_MSG("index        : %lx\n", index);
+			length_log = log_buf_len;
+			length_oldlog = log_buf_len - index;
+			if(!readmem(VADDR, log_buf + index, log_buffer, length_oldlog)) {
+				ERRMSG("Can't read old dmesg log.\n");
+				goto out;
+			}
+			if(!readmem(VADDR, log_buf, log_buffer + length_oldlog, index)) {
+				ERRMSG("Can't read new dmesg log.\n");
+				goto out;
+			}
+		}
+		DEBUG_MSG("length_log   : %d\n", length_log);
+	
+		if (!open_dump_file()) {
+			ERRMSG("Can't open output file.\n");
 			goto out;
 		}
+		if (write(info->fd_dumpfile, log_buffer, length_log) < 0)
+			goto out;
+	
+		if (!close_files_for_creating_dumpfile())
+			goto out;
 	} else {
-		index = log_end & (log_buf_len - 1);
-		DEBUG_MSG("index        : %lx\n", index);
-		length_log = log_buf_len;
-		length_oldlog = log_buf_len - index;
-		if(!readmem(VADDR, log_buf + index, log_buffer, length_oldlog)) {
-			ERRMSG("Can't read old dmesg log.\n");
+		if(!readmem(VADDR, log_buf, log_buffer, log_buf_len)) {
+			ERRMSG("Can't read indexed dmesg log.\n");
 			goto out;
 		}
-		if(!readmem(VADDR, log_buf, log_buffer + length_oldlog, index)) {
-			ERRMSG("Can't read new dmesg log.\n");
+		if (!open_dump_file()) {
+			ERRMSG("Can't open output file.\n");
 			goto out;
 		}
+		idx = log_first_idx;
+		while (idx != log_next_idx ) {
+			log_ptr = log_from_idx(idx, log_buffer);
+			if (!dump_log_entry(log_ptr,info->fd_dumpfile))
+				goto out;
+			idx = log_next(idx, log_buffer);
+		}
+		if (!close_files_for_creating_dumpfile())
+			goto out;
 	}
-	DEBUG_MSG("length_log   : %d\n", length_log);
-
-	if (!open_dump_file()) {
-		ERRMSG("Can't open output file.\n");
-		goto out;
-	}
-	if (write(info->fd_dumpfile, log_buffer, length_log) < 0)
-		goto out;
-
-	if (!close_files_for_creating_dumpfile())
-		goto out;
 
 	ret = TRUE;
 out:
diff --git a/makedumpfile.h b/makedumpfile.h
index 4c4d201..b36c529 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -206,6 +206,7 @@ isAnon(unsigned long mapping)
 #define FILENAME_BITMAP		"kdump_bitmapXXXXXX"
 #define FILENAME_STDOUT		"STDOUT"
 
+
 /*
  * Minimam vmcore has 2 ProgramHeaderTables(PT_NOTE and PT_LOAD).
  */
@@ -223,6 +224,8 @@ static inline int string_exists(char *s) { return (s ? TRUE : FALSE); }
 #define USHORT(ADDR)	*((unsigned short *)(ADDR))
 #define UINT(ADDR)	*((unsigned int *)(ADDR))
 #define ULONG(ADDR)	*((unsigned long *)(ADDR))
+#define ULONGLONG(ADDR)	*((unsigned long long *)(ADDR))
+
 
 /*
  * for symbol
@@ -819,6 +822,8 @@ struct cache_data {
 	size_t	cache_size;
 	off_t	offset;
 };
+typedef unsigned long int ulong;
+typedef unsigned long long int ulonglong;
 
 /*
  * makedumpfile header
@@ -1094,6 +1099,8 @@ struct symbol_table {
 	unsigned long long	log_buf;
 	unsigned long long	log_buf_len;
 	unsigned long long	log_end;
+	unsigned long long	log_first_idx;
+	unsigned long long	log_next_idx;
 	unsigned long long	max_pfn;
 	unsigned long long	node_remap_start_vaddr;
 	unsigned long long	node_remap_end_vaddr;
@@ -1173,6 +1180,7 @@ struct size_table {
 	long	cpumask_t;
 	long	kexec_segment;
 	long	elf64_hdr;
+	long	log;
 
 	long	pageflags;
 };
@@ -1306,6 +1314,14 @@ struct offset_table {
 		long	p_paddr;
 		long	p_memsz;
 	} elf64_phdr;
+
+	struct log_s {
+        	long ts_nsec;
+        	long len;
+        	long text_len;
+        	long dict_len;
+	} log;
+
 };
 
 /*
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
