Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from xenotime.net ([66.160.160.81])
	by canuck.infradead.org with smtp (Exim 4.63 #1 (Red Hat Linux))
	id 1ISf8Y-0000Jq-FD
	for kexec@lists.infradead.org; Tue, 04 Sep 2007 16:36:45 -0400
Received: from midway.site ([96.225.192.201]) by xenotime.net for
	<kexec@lists.infradead.org>; Tue, 4 Sep 2007 13:36:36 -0700
Date: Tue, 4 Sep 2007 13:36:36 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
Subject: [patch] makedumpfile: fix comments and other strings
Message-Id: <20070904133636.de36ca67.rdunlap@xenotime.net>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, tachibana@mxm.nes.nec.co.jp

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix comment typos and usage messages in makedumpfile.c.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 makedumpfile.c |   46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

--- makedumpfile-1.1.6.orig/makedumpfile.c
+++ makedumpfile-1.1.6/makedumpfile.c
@@ -38,7 +38,7 @@ show_version()
 }
 
 /*
- * Convert Physical Address to File Offest.
+ * Convert Physical Address to File Offset.
  *  If this function returns 0x0, File Offset isn't found.
  *  The File Offset 0x0 is in the ELF header.
  *  It is not in the memory image.
@@ -82,7 +82,7 @@ vaddr_to_paddr(unsigned long long vaddr)
 }
 
 /*
- * Convert Virtual Address to File Offest.
+ * Convert Virtual Address to File Offset.
  *  If this function returns 0x0, File Offset isn't found.
  *  The File Offset 0x0 is the ELF header.
  *  It is not in the memory image.
@@ -337,7 +337,7 @@ print_usage()
 	MSG("  Outputting the dump data in the flattened format to the standard output:\n");
 	MSG("  # makedumpfile -F [-c|-E] [-d DL] [-x VMLINUX|-i VMCOREINFO] VMCORE\n");
 	MSG("\n");
-	MSG("  Re-arranging the dump data in the flattened format to a readable DUMPFILE:\n");
+	MSG("  Rearranging the dump data in the flattened format to a readable DUMPFILE:\n");
 	MSG("  # makedumpfile -R DUMPFILE\n");
 	MSG("\n");
 	MSG("  Generating VMCOREINFO:\n");
@@ -390,7 +390,7 @@ print_usage()
 	MSG("      Specify VMCOREINFO instead of VMLINUX for analyzing the first kernel's\n");
 	MSG("      memory usage.\n");
 	MSG("      VMCOREINFO should be made beforehand by makedumpfile with -g option,\n");
-	MSG("      and it containes the first kernel's information. If Dump_Level is 2 or\n");
+	MSG("      and it contains the first kernel's information. If Dump_Level is 2 or\n");
 	MSG("      more and [-x VMLINUX] is not specified, this option is necessary.\n");
 	MSG("\n");
 	MSG("  [-g VMCOREINFO]:\n");
@@ -404,22 +404,22 @@ print_usage()
 	MSG("      Output the dump data in the flattened format to the standard output\n");
 	MSG("      for transporting the dump data by SSH.\n");
 	MSG("      Analysis tools cannot read the flattened format directly. For analysis,\n");
-	MSG("      the dump data in the flattened format should be re-arranged to a readable\n");
+	MSG("      the dump data in the flattened format should be rearranged to a readable\n");
 	MSG("      DUMPFILE by -R option.\n");
 	MSG("\n");
 	MSG("  [-R]:\n");
-	MSG("      Re-arrange the dump data in the flattened format from the standard input\n");
+	MSG("      Rearrange the dump data in the flattened format from the standard input\n");
 	MSG("      to a readable DUMPFILE.\n");
 	MSG("\n");
 	MSG("  [--xen-syms XEN-SYMS]:\n");
-	MSG("      Specify the XEN-SYMS to analyze the xen's memory usage.\n");
+	MSG("      Specify the XEN-SYMS to analyze Xen's memory usage.\n");
 	MSG("\n");
 	MSG("  [--xen-vmcoreinfo VMCOREINFO]:\n");
-	MSG("      Specify the VMCOREINFO of xen to analyze the xen's memory usage.\n");
+	MSG("      Specify the VMCOREINFO of Xen to analyze Xen's memory usage.\n");
 	MSG("\n");
 	MSG("  [--message-level ML]:\n");
 	MSG("      Specify the message types.\n");
-	MSG("      Users can restrict outputs printed by specifying Message_Level (ML) with\n");
+	MSG("      Users can restrict output printed by specifying Message_Level (ML) with\n");
 	MSG("      this option. The message type marked with an X in the following table is\n");
 	MSG("      printed to standard error output. For example, according to the table,\n");
 	MSG("      specifying 7 as ML means progress indicator, common message, and error\n");
@@ -463,8 +463,8 @@ print_usage()
 	MSG("\n");
 	MSG("  XEN-SYMS:\n");
 	MSG("      This is a pathname to the xen-syms.\n");
-	MSG("      This file must have the debug information of the xen to analyze the\n");
-	MSG("      xen's memory usage.\n");
+	MSG("      This file must have the debug information of Xen to analyze\n");
+	MSG("      Xen's memory usage.\n");
 	MSG("\n");
 }
 
@@ -580,7 +580,7 @@ open_files_for_generating_vmcoreinfo()
 }
 
 /*
- * Open the following file when it re-arranges the dump data.
+ * Open the following file when it rearranges the dump data.
  * - dump file
  */
 int
@@ -901,8 +901,8 @@ get_elf_info()
 
 	/*
 	 * FIXME
-	 *   If the page_size of 1st-kernel is different from the one of
-	 *   capture(2nd)-kernel, the problem will happen.
+	 *   If the page_size of 1st kernel is different from the one of
+	 *   capture(2nd) kernel, the problem will happen.
 	 */
 	info->page_size = sysconf(_SC_PAGE_SIZE);
 	info->page_shift = ffs(info->page_size) - 1;
@@ -2768,7 +2768,7 @@ get_mm_discontigmem()
 			/*
 			 * For some ia64 NUMA systems.
 			 * On some systems, a node has the separated memory.
-			 * And pglist_data(s) have the dumplicated memory range
+			 * And pglist_data(s) have the duplicated memory range
 			 * like following:
 			 *
 			 * Nid:      Physical address
@@ -3104,7 +3104,7 @@ initial()
 	 */
 	} else {
 		/*
-		 * Check weather /proc/vmcore contains vmcoreinfo,
+		 * Check whether /proc/vmcore contains vmcoreinfo,
 		 * and get both the offset and the size.
 		 */
 		if (!is_vmcoreinfo_in_vmcore(&vmcoreinfo_in_vmcore))
@@ -3338,7 +3338,7 @@ read_buf_from_stdin(void *buf, int buf_s
 		} else if (0 == tmp_read_size) {
 			/*
 			 * If it cannot get any data from a standard input
-			 * while long time, break this loop.
+			 * for a long time, break this loop.
 			 */
 			tm = time(NULL);
 			if (TIMEOUT_STDIN < (tm - last_time)) {
@@ -3436,7 +3436,7 @@ rearrange_dumpdata()
 	}
 
 	if ((buf = malloc(buf_size)) == NULL) {
-		ERRMSG("Can't allocate memory for buffer of flattend format. %s\n",
+		ERRMSG("Can't allocate memory for buffer of flattened format. %s\n",
 		    strerror(errno));
 		return FALSE;
 	}
@@ -3493,7 +3493,7 @@ out:
 }
 
 /*
- * Sames as paddr_to_offset() but makes sure that the specified offset (hint)
+ * Same as paddr_to_offset() but makes sure that the specified offset (hint)
  * in the segment.
  */
 off_t
@@ -3721,7 +3721,7 @@ exclude_free_page(struct cache_data *bm2
 {
 
 	/*
-	 * Check having neccesary information.
+	 * Check having necessary information.
 	 */
 	if ((SYMBOL(node_data) == NOT_FOUND_SYMBOL)
 	    && (SYMBOL(pgdat_list) == NOT_FOUND_SYMBOL)
@@ -4188,7 +4188,7 @@ write_elf_header()
 	}
 
 	/*
-	 * Write a ELF header.
+	 * Write an ELF header.
 	 */
 	if (info->flag_elf64) { /* ELF64 */
 		if (!write_buffer(info->fd_dumpfile, 0, &ehdr64, sizeof(ehdr64),
@@ -5071,7 +5071,7 @@ close_files_for_generating_vmcoreinfo()
 }
 
 /*
- * Close the following file when it re-arranges the dump data.
+ * Close the following file when it rearranges the dump data.
  * - dump file
  */
 int
@@ -5816,7 +5816,7 @@ main(int argc, char *argv[])
 		    && !info->flag_elf_dumpfile) {
 			/*
 			 * Parameters for creating dumpfile from the dump data
-			 * of flattened format by re-arranging the dump data.
+			 * of flattened format by rearranging the dump data.
 			 */
 			info->name_dumpfile = argv[optind];
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
