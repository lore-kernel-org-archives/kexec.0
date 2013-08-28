Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from relay2.sgi.com ([192.48.179.30] helo=relay.sgi.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VEnv2-0002CH-GS
 for kexec@lists.infradead.org; Wed, 28 Aug 2013 22:08:53 +0000
Subject: [PATCH] makedumpfile: search for a debug vmlinux
Message-Id: <E1VEnuJ-0000KR-TT@eag09.americas.sgi.com>
From: Cliff Wickman <cpw@sgi.com>
Date: Wed, 28 Aug 2013 17:08:07 -0500
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
To: d.hatayama@jp.fujitsu.com, kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org

From: Cliff Wickman <cpw@sgi.com>


makedumpfile needs the debug info from either /proc/vmcore or in vmlinux
to know how to find free pages using the buddy method.

The distro procedures do not pass the vmlinux (with the -x option), so
add a search for a debug vmlinux in the usual locations.
It's not needed if the page info is in vmcore.  But warn if it is found
in neither place.

Diffed against makedumpfile-1.5.4
Signed-off-by: Cliff Wickman <cpw@sgi.com>
---
 makedumpfile.c |   97 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

Index: makedumpfile-1.5.4/makedumpfile.c
===================================================================
--- makedumpfile-1.5.4.orig/makedumpfile.c
+++ makedumpfile-1.5.4/makedumpfile.c
@@ -23,6 +23,7 @@
 #include <stddef.h>
 #include <ctype.h>
 #include <sys/time.h>
+#include <sys/stat.h>
 
 struct symbol_table	symbol_table;
 struct size_table	size_table;
@@ -33,6 +34,7 @@ struct srcfile_table	srcfile_table;
 
 struct vm_table		vt = { 0 };
 struct DumpInfo		*info = NULL;
+struct utsname		utsname;
 
 char filename_stdout[] = FILENAME_STDOUT;
 
@@ -62,6 +64,7 @@ unsigned long long num_dumped;
 int retcd = FAILED;	/* return code */
 int aflag = 0;
 int total_cycles = 0;
+static int no_vmlinux;
 
 #define INITIALIZE_LONG_TABLE(table, value) \
 do { \
@@ -2987,6 +2990,9 @@ initial(void)
 		if (!read_vmcoreinfo_from_vmcore(offset, size, FALSE))
 			return FALSE;
 		debug_info = TRUE;
+		if ((OFFSET(page.private) == NOT_FOUND_STRUCTURE) &&
+		    no_vmlinux)
+			PROGRESS_MSG("No vmlinux and no page info in vmcore\n");
 	}
 
 out:
@@ -7799,6 +7805,7 @@ create_dumpfile(void)
 		return FALSE;
 
 	if (!info->flag_refiltering && !info->flag_sadump) {
+		/* cpw: we get debug info from /proc/vmcore here */
 		if (!get_elf_info(info->fd_memory, info->name_memory))
 			return FALSE;
 	}
@@ -8740,6 +8747,91 @@ static struct option longopts[] = {
 	{0, 0, 0, 0}
 };
 
+/*
+ * Look for a debug vmlinux in the usual places.
+ */
+void
+find_vmlinux()
+{
+	int ret;
+	char pathname[200];
+	struct stat stat_buf;
+
+	ret = uname(&utsname);
+	if (ret < 0) {
+		fprintf(stderr, "uname failed; errno %d", errno);
+	}
+
+	/* these may work if the crash kernel is in multi-user mode */
+	sprintf(pathname, "/usr/lib/debug/lib/modules/%s/vmlinux",
+		utsname.release);
+	if (stat(pathname, &stat_buf) == 0) {
+		info->name_vmlinux = pathname;
+		PROGRESS_MSG("Using %s.\n", pathname);
+		return;
+	}
+	sprintf(pathname, "/usr/lib/debug/boot/vmlinux-%s.debug",
+		utsname.release);
+	if (stat(pathname, &stat_buf) == 0) {
+		info->name_vmlinux = pathname;
+		PROGRESS_MSG("Using %s.\n", pathname);
+		return;
+	}
+	sprintf(pathname, "/boot/vmlinux-%s", utsname.release);
+	if (stat(pathname, &stat_buf) == 0) {
+		info->name_vmlinux = pathname;
+		PROGRESS_MSG("Using %s.\n", pathname);
+		return;
+	}
+
+	/*
+	 * the crash kernel normally runs with the root device mounted
+	 * as /root or /mnt
+	 */
+	sprintf(pathname, "/root/usr/lib/debug/lib/modules/%s/vmlinux",
+		utsname.release);
+	if (stat(pathname, &stat_buf) == 0) {
+		info->name_vmlinux = pathname;
+		PROGRESS_MSG("Using %s.\n", pathname);
+		return;
+	}
+	sprintf(pathname, "/root/usr/lib/debug/boot/vmlinux-%s.debug",
+		utsname.release);
+	if (stat(pathname, &stat_buf) == 0) {
+		info->name_vmlinux = pathname;
+		PROGRESS_MSG("Using %s.\n", pathname);
+		return;
+	}
+	sprintf(pathname, "/root/boot/vmlinux-%s", utsname.release);
+	if (stat(pathname, &stat_buf) == 0) {
+		info->name_vmlinux = pathname;
+		PROGRESS_MSG("Using %s.\n", pathname);
+		return;
+	}
+	sprintf(pathname, "/mnt/usr/lib/debug/lib/modules/%s/vmlinux",
+		utsname.release);
+	if (stat(pathname, &stat_buf) == 0) {
+		info->name_vmlinux = pathname;
+		PROGRESS_MSG("Using %s.\n", pathname);
+		return;
+	}
+	sprintf(pathname, "/mnt/usr/lib/debug/boot/vmlinux-%s.debug",
+		utsname.release);
+	if (stat(pathname, &stat_buf) == 0) {
+		info->name_vmlinux = pathname;
+		PROGRESS_MSG("Using %s.\n", pathname);
+		return;
+	}
+	sprintf(pathname, "/mnt/boot/vmlinux-%s", utsname.release);
+	if (stat(pathname, &stat_buf) == 0) {
+		info->name_vmlinux = pathname;
+		PROGRESS_MSG("Using %s.\n", pathname);
+		return;
+	}
+
+	no_vmlinux = 1;
+}
+
 int
 main(int argc, char *argv[])
 {
@@ -8888,6 +8980,11 @@ main(int argc, char *argv[])
 	if (flag_debug)
 		message_level |= ML_PRINT_DEBUG_MSG;
 
+	if (!info->flag_read_vmcoreinfo && !info->name_vmlinux) {
+		/* -x not specified, so look in standard places */
+		find_vmlinux();
+	}
+
 	if (info->flag_show_usage) {
 		print_usage();
 		return COMPLETED;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
