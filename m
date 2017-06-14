Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from prod-mx.aristanetworks.com ([162.210.130.12])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dKweY-0001Rc-QE
 for kexec@lists.infradead.org; Wed, 14 Jun 2017 00:59:24 +0000
Date: Tue, 13 Jun 2017 17:58:54 -0700
From: Ivan Delalande <colona@arista.com>
Subject: [makedumpfile PATCH v2] Add the --partial-dmesg option to dump only
 non-cleared dmesg
Message-ID: <20170614005854.GA32055@visor>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170613010046.GA25025@visor>
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: kexec@lists.infradead.org

This option will make --dump-dmesg save only the part of the dmesg
buffer since it was last cleared on the crashed kernel (with
dmesg --clear and such) instead of the whole buffer since boot or
wrap-around. It works on kernels with commit f468908bb55a ("printk:
add clear_idx symbol to vmcoreinfo") merged in v4.6 and otherwise
will default to the regular behavior.

Signed-off-by: Ivan Delalande <colona@arista.com>
---
 makedumpfile.8 |  8 +++++++-
 makedumpfile.c | 24 ++++++++++++++++++++++--
 makedumpfile.h |  3 +++
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/makedumpfile.8 b/makedumpfile.8
index 9932364..76a8d6e 100644
--- a/makedumpfile.8
+++ b/makedumpfile.8
@@ -20,7 +20,7 @@ makedumpfile \- make a small dumpfile of kdump
 .br
 \fBmakedumpfile\fR    [\fIOPTION\fR] [\-\-xen-syms \fIXEN-SYMS\fR|\-\-xen-vmcoreinfo \fIVMCOREINFO\fR] \fIVMCORE\fR \fIDUMPFILE\fR
 .br
-\fBmakedumpfile\fR \-\-dump-dmesg [\-x \fIVMLINUX\fR|\-i \fIVMCOREINFO\fR] \fIVMCORE\fR \fILOGFILE\fR
+\fBmakedumpfile\fR \-\-dump-dmesg [\-\-partial-dmesg] [\-x \fIVMLINUX\fR|\-i \fIVMCOREINFO\fR] \fIVMCORE\fR \fILOGFILE\fR
 .br
 \fBmakedumpfile\fR    [\fIOPTION\fR] \-x \fIVMLINUX\fR \-\-diskset=\fIVMCORE1\fR \-\-diskset=\fIVMCORE2\fR [\-\-diskset=\fIVMCORE3\fR ..] \fIDUMPFILE\fR
 .br
@@ -586,6 +586,12 @@ it is necessary to specfiy [\-x \fIVMLINUX\fR] or [\-i \fIVMCOREINFO\fR].
 
 
 .TP
+\fB\-\-partial-dmesg\fR
+This option will make --dump-dmesg extract only dmesg logs since that buffer was
+last cleared on the crashed kernel, through "dmesg --clear" for example.
+
+
+.TP
 \fB\-\-mem-usage\fR
 This option is only for x86_64.
 This option is used to show the page numbers of current system in different
diff --git a/makedumpfile.c b/makedumpfile.c
index 95cc5ef..6c5fa4c 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1498,6 +1498,7 @@ get_symbol_info(void)
 	SYMBOL_INIT(log_buf_len, "log_buf_len");
 	SYMBOL_INIT(log_end, "log_end");
 	SYMBOL_INIT(log_first_idx, "log_first_idx");
+	SYMBOL_INIT(clear_idx, "clear_idx");
 	SYMBOL_INIT(log_next_idx, "log_next_idx");
 	SYMBOL_INIT(max_pfn, "max_pfn");
 	SYMBOL_INIT(modules, "modules");
@@ -2115,6 +2116,7 @@ write_vmcoreinfo_data(void)
 	WRITE_SYMBOL("log_buf_len", log_buf_len);
 	WRITE_SYMBOL("log_end", log_end);
 	WRITE_SYMBOL("log_first_idx", log_first_idx);
+	WRITE_SYMBOL("clear_idx", clear_idx);
 	WRITE_SYMBOL("log_next_idx", log_next_idx);
 	WRITE_SYMBOL("max_pfn", max_pfn);
 	WRITE_SYMBOL("high_memory", high_memory);
@@ -2509,6 +2511,7 @@ read_vmcoreinfo(void)
 	READ_SYMBOL("log_buf_len", log_buf_len);
 	READ_SYMBOL("log_end", log_end);
 	READ_SYMBOL("log_first_idx", log_first_idx);
+	READ_SYMBOL("clear_idx", clear_idx);
 	READ_SYMBOL("log_next_idx", log_next_idx);
 	READ_SYMBOL("max_pfn", max_pfn);
 	READ_SYMBOL("high_memory", high_memory);
@@ -5025,6 +5028,7 @@ dump_dmesg()
 	int log_buf_len, length_log, length_oldlog, ret = FALSE;
 	unsigned long index, log_buf, log_end;
 	unsigned int idx, log_first_idx, log_next_idx;
+	unsigned long long first_idx_sym;
 	unsigned long log_end_2_6_24;
 	unsigned      log_end_2_6_25;
 	char *log_buffer = NULL, *log_ptr = NULL;
@@ -5058,7 +5062,13 @@ dump_dmesg()
 			ERRMSG("Can't find variable-length record symbols");
 			return FALSE;
 		} else {
-			if (!readmem(VADDR, SYMBOL(log_first_idx), &log_first_idx,
+			if (info->flag_partial_dmesg
+			    && SYMBOL(clear_idx) != NOT_FOUND_SYMBOL)
+				first_idx_sym = SYMBOL(clear_idx);
+			else
+				first_idx_sym = SYMBOL(log_first_idx);
+
+			if (!readmem(VADDR, first_idx_sym, &log_first_idx,
 			    sizeof(log_first_idx))) {
 				ERRMSG("Can't get log_first_idx.\n");
 				return FALSE;
@@ -5102,7 +5112,10 @@ dump_dmesg()
 	DEBUG_MSG("log_buf       : %lx\n", log_buf);
 	DEBUG_MSG("log_end       : %lx\n", log_end);
 	DEBUG_MSG("log_buf_len   : %d\n", log_buf_len);
-	DEBUG_MSG("log_first_idx : %u\n", log_first_idx);
+	if (info->flag_partial_dmesg)
+		DEBUG_MSG("clear_idx : %u\n", log_first_idx);
+	else
+		DEBUG_MSG("log_first_idx : %u\n", log_first_idx);
 	DEBUG_MSG("log_next_idx  : %u\n", log_next_idx);
 
 	if ((log_buffer = malloc(log_buf_len)) == NULL) {
@@ -10618,6 +10631,9 @@ check_param_for_creating_dumpfile(int argc, char *argv[])
 		}
 	}
 
+	if (info->flag_partial_dmesg && !info->flag_dmesg)
+		return FALSE;
+
 	if ((argc == optind + 2) && !info->flag_flatten
 				 && !info->flag_split
 				 && !info->flag_sadump_diskset) {
@@ -11022,6 +11038,7 @@ static struct option longopts[] = {
 	{"message-level", required_argument, NULL, OPT_MESSAGE_LEVEL},
 	{"vtop", required_argument, NULL, OPT_VTOP},
 	{"dump-dmesg", no_argument, NULL, OPT_DUMP_DMESG},
+	{"partial-dmesg", no_argument, NULL, OPT_PARTIAL_DMESG},
 	{"config", required_argument, NULL, OPT_CONFIG},
 	{"help", no_argument, NULL, OPT_HELP},
 	{"diskset", required_argument, NULL, OPT_DISKSET},
@@ -11135,6 +11152,9 @@ main(int argc, char *argv[])
 		case OPT_DUMP_DMESG:
 			info->flag_dmesg = 1;
 			break;
+		case OPT_PARTIAL_DMESG:
+			info->flag_partial_dmesg = 1;
+			break;
 		case OPT_MEM_USAGE:
 		       info->flag_mem_usage = 1;
 		       break;
diff --git a/makedumpfile.h b/makedumpfile.h
index 6ea8cc4..d3b7532 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1241,6 +1241,7 @@ struct DumpInfo {
 	int		flag_force;	     /* overwrite existing stuff */
 	int		flag_exclude_xen_dom;/* exclude Domain-U from xen-kdump */
 	int             flag_dmesg;          /* dump the dmesg log out of the vmcore file */
+	int             flag_partial_dmesg;  /* dmesg dump only from the last cleared index*/
 	int             flag_mem_usage;  /*show the page number of memory in different use*/
 	int		flag_use_printk_log; /* did we read printk_log symbol name? */
 	int		flag_nospace;	     /* the flag of "No space on device" error */
@@ -1529,6 +1530,7 @@ struct symbol_table {
 	unsigned long long	log_buf_len;
 	unsigned long long	log_end;
 	unsigned long long	log_first_idx;
+	unsigned long long	clear_idx;
 	unsigned long long	log_next_idx;
 	unsigned long long	max_pfn;
 	unsigned long long	node_remap_start_vaddr;
@@ -2268,6 +2270,7 @@ struct elf_prstatus {
 #define OPT_SPLITBLOCK_SIZE	OPT_START+14
 #define OPT_WORKING_DIR         OPT_START+15
 #define OPT_NUM_THREADS	OPT_START+16
+#define OPT_PARTIAL_DMESG	OPT_START+17
 
 /*
  * Function Prototype.
-- 
2.13.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
