Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cUcc6-0007DM-Pm
 for kexec@lists.infradead.org; Fri, 20 Jan 2017 17:04:38 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
Subject: [PATCH v2] kexec: implemented XEN KEXEC STATUS to determine if an
 image is loaded
Date: Fri, 20 Jan 2017 11:03:54 -0600
Message-Id: <1484931834-21060-1-git-send-email-eric.devolder@oracle.com>
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
To: simon@horms.net, andrew.cooper3@citrix.com, kexec@lists.infradead.org, xen-devel@lists.xenproject.org
Cc: daniel.kiper@oracle.com, konrad.wilk@oracle.com

Instead of the scripts having to poke at various fields we can
provide that functionality via the -S parameter.

Returns 0 if the payload is loaded. Can be used in combination
with -l or -p to get the state of the proper kexec image.

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
Note: The corresponding Xen changes have been committed
to the Xen staging branch. Follow this thread:
https://lists.xenproject.org/archives/html/xen-devel/2017-01/msg01570.html

CC: Andrew Cooper <andrew.cooper3@citrix.com>
CC: kexec@lists.infradead.org
CC: xen-devel@lists.xenproject.org
CC: Daniel Kiper <daniel.kiper@oracle.com>

v0: First version (internal product).
v1: Posted on kexec mailing list. Changed -s to -S
v2: Incorporated feedback from kexec mailing list
---
 configure.ac      |  8 ++++++-
 kexec/kexec-xen.c | 26 +++++++++++++++++++++++
 kexec/kexec.8     |  6 ++++++
 kexec/kexec.c     | 62 ++++++++++++++++++++++++++++++++++++++++++++++++-------
 kexec/kexec.h     |  5 ++++-
 5 files changed, 98 insertions(+), 9 deletions(-)

diff --git a/configure.ac b/configure.ac
index 3044185..c6e864b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -165,8 +165,14 @@ fi
 dnl find Xen control stack libraries
 if test "$with_xen" = yes ; then
 	AC_CHECK_HEADER(xenctrl.h,
-		[AC_CHECK_LIB(xenctrl, xc_kexec_load, ,
+		[AC_CHECK_LIB(xenctrl, xc_kexec_load, [ have_xenctrl_h=yes ],
 		AC_MSG_NOTICE([Xen support disabled]))])
+if test "$have_xenctrl_h" = yes ; then
+	AC_CHECK_LIB(xenctrl, xc_kexec_status,
+		AC_DEFINE(HAVE_KEXEC_CMD_STATUS, 1,
+			[The kexec_status call is available]),
+		AC_MSG_NOTICE([The kexec_status call is not available]))
+fi
 fi
 
 dnl ---Sanity checks
diff --git a/kexec/kexec-xen.c b/kexec/kexec-xen.c
index 24a4191..2b448d3 100644
--- a/kexec/kexec-xen.c
+++ b/kexec/kexec-xen.c
@@ -105,6 +105,27 @@ int xen_kexec_unload(uint64_t kexec_flags)
 	return ret;
 }
 
+int xen_kexec_status(uint64_t kexec_flags)
+{
+	xc_interface *xch;
+	uint8_t type;
+	int ret = -1;
+
+#ifdef HAVE_KEXEC_CMD_STATUS
+	xch = xc_interface_open(NULL, NULL, 0);
+	if (!xch)
+		return -1;
+
+	type = (kexec_flags & KEXEC_ON_CRASH) ? KEXEC_TYPE_CRASH : KEXEC_TYPE_DEFAULT;
+
+	ret = xc_kexec_status(xch, type);
+
+	xc_interface_close(xch);
+#endif
+
+	return ret;
+}
+
 void xen_kexec_exec(void)
 {
 	xc_interface *xch;
@@ -130,6 +151,11 @@ int xen_kexec_unload(uint64_t kexec_flags)
 	return -1;
 }
 
+int xen_kexec_status(uint64_t kexec_flags)
+{
+	return -1;
+}
+
 void xen_kexec_exec(void)
 {
 }
diff --git a/kexec/kexec.8 b/kexec/kexec.8
index 4d0c1d1..f4b39a6 100644
--- a/kexec/kexec.8
+++ b/kexec/kexec.8
@@ -107,6 +107,12 @@ command:
 .B \-d\ (\-\-debug)
 Enable debugging messages.
 .TP
+.B \-S\ (\-\-status)
+Return 0 if the type (by default crash) is loaded. Can be used in conjuction
+with -l or -p to toggle the type. Note this option supersedes other options
+and it will
+.BR not\ load\ or\ unload\ the\ kernel.
+.TP
 .B \-e\ (\-\-exec)
 Run the currently loaded kernel. Note that it will reboot into the loaded kernel without calling shutdown(8).
 .TP
diff --git a/kexec/kexec.c b/kexec/kexec.c
index 500e5a9..defbbe3 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -51,6 +51,9 @@
 #include "kexec-lzma.h"
 #include <arch/options.h>
 
+#define KEXEC_LOADED_PATH "/sys/kernel/kexec_loaded"
+#define KEXEC_CRASH_LOADED_PATH "/sys/kernel/kexec_crash_loaded"
+
 unsigned long long mem_min = 0;
 unsigned long long mem_max = ULONG_MAX;
 static unsigned long kexec_flags = 0;
@@ -58,6 +61,8 @@ static unsigned long kexec_flags = 0;
 static unsigned long kexec_file_flags = 0;
 int kexec_debug = 0;
 
+static int kexec_loaded(const char *file);
+
 void dbgprint_mem_range(const char *prefix, struct memory_range *mr, int nr_mr)
 {
 	int i;
@@ -890,8 +895,6 @@ static int my_exec(void)
 	return -1;
 }
 
-static int kexec_loaded(void);
-
 static int load_jump_back_helper_image(unsigned long kexec_flags, void *entry)
 {
 	int result;
@@ -909,7 +912,7 @@ static int my_load_jump_back_helper(unsigned long kexec_flags, void *entry)
 {
 	int result;
 
-	if (kexec_loaded()) {
+	if (kexec_loaded(KEXEC_LOADED_PATH)) {
 		fprintf(stderr, "There is kexec kernel loaded, make sure "
 			"you are in kexeced kernel.\n");
 		return -1;
@@ -970,6 +973,7 @@ void usage(void)
 	       "                      to original kernel.\n"
 	       " -s, --kexec-file-syscall Use file based syscall for kexec operation\n"
 	       " -d, --debug           Enable debugging to help spot a failure.\n"
+	       " -S, --status         Return 0 if the type (by default crash) is loaded.\n"
 	       "\n"
 	       "Supported kernel file types and options: \n");
 	for (i = 0; i < file_types; i++) {
@@ -981,7 +985,7 @@ void usage(void)
 	printf("\n");
 }
 
-static int kexec_loaded(void)
+static int kexec_loaded(const char *file)
 {
 	long ret = -1;
 	FILE *fp;
@@ -992,7 +996,7 @@ static int kexec_loaded(void)
 	if (xen_present())
 		return 1;
 
-	fp = fopen("/sys/kernel/kexec_loaded", "r");
+	fp = fopen(file, "r");
 	if (fp == NULL)
 		return -1;
 
@@ -1015,6 +1019,30 @@ static int kexec_loaded(void)
 	return (int)ret;
 }
 
+static int k_status(unsigned long kexec_flags)
+{
+	int result;
+	long native_arch;
+
+	/* set the arch */
+	native_arch = physical_arch();
+	if (native_arch < 0) {
+		return -1;
+	}
+	kexec_flags |= native_arch;
+
+	if (xen_present())
+		result = xen_kexec_status(kexec_flags);
+	else {
+		if (kexec_flags & KEXEC_ON_CRASH)
+			result = kexec_loaded(KEXEC_CRASH_LOADED_PATH);
+		else
+			result = kexec_loaded(KEXEC_LOADED_PATH);
+	}
+	return result;
+}
+
+
 /*
  * Remove parameter from a kernel command line. Helper function by get_command_line().
  */
@@ -1204,6 +1232,7 @@ int main(int argc, char *argv[])
 	int do_unload = 0;
 	int do_reuse_initrd = 0;
 	int do_kexec_file_syscall = 0;
+	int do_status = 0;
 	void *entry = 0;
 	char *type = 0;
 	char *endptr;
@@ -1345,6 +1374,9 @@ int main(int argc, char *argv[])
 		case OPT_KEXEC_FILE_SYSCALL:
 			/* We already parsed it. Nothing to do. */
 			break;
+		case OPT_STATUS:
+			do_status = 1;
+			break;
 		default:
 			break;
 		}
@@ -1355,6 +1387,20 @@ int main(int argc, char *argv[])
 	if (skip_sync)
 		do_sync = 0;
 
+	if (do_status) {
+		if (kexec_flags == 0)
+			kexec_flags = KEXEC_ON_CRASH;
+		do_load = 0;
+		do_reuse_initrd = 0;
+		do_unload = 0;
+		do_load = 0;
+		do_shutdown = 0;
+		do_sync = 0;
+		do_ifdown = 0;
+		do_exec = 0;
+		do_load_jump_back_helper = 0;
+	}
+
 	if (do_load && (kexec_flags & KEXEC_ON_CRASH) &&
 	    !is_crashkernel_mem_reserved()) {
 		die("Memory for crashkernel is not reserved\n"
@@ -1392,7 +1438,9 @@ int main(int argc, char *argv[])
 		check_reuse_initrd();
 		arch_reuse_initrd();
 	}
-
+	if (do_status) {
+		result = k_status(kexec_flags);
+	}
 	if (do_unload) {
 		if (do_kexec_file_syscall)
 			result = kexec_file_unload(kexec_file_flags);
@@ -1408,7 +1456,7 @@ int main(int argc, char *argv[])
 						kexec_flags, entry);
 	}
 	/* Don't shutdown unless there is something to reboot to! */
-	if ((result == 0) && (do_shutdown || do_exec) && !kexec_loaded()) {
+	if ((result == 0) && (do_shutdown || do_exec) && !kexec_loaded(KEXEC_LOADED_PATH)) {
 		die("Nothing has been loaded!\n");
 	}
 	if ((result == 0) && do_shutdown) {
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 9194f1c..2b06f59 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -219,6 +219,7 @@ extern int file_types;
 #define OPT_TYPE		't'
 #define OPT_PANIC		'p'
 #define OPT_KEXEC_FILE_SYSCALL	's'
+#define OPT_STATUS		'S'
 #define OPT_MEM_MIN             256
 #define OPT_MEM_MAX             257
 #define OPT_REUSE_INITRD	258
@@ -245,8 +246,9 @@ extern int file_types;
 	{ "reuseinitrd",	0, 0, OPT_REUSE_INITRD }, \
 	{ "kexec-file-syscall",	0, 0, OPT_KEXEC_FILE_SYSCALL }, \
 	{ "debug",		0, 0, OPT_DEBUG }, \
+	{ "status",		0, 0, OPT_STATUS }, \
 
-#define KEXEC_OPT_STR "h?vdfxyluet:ps"
+#define KEXEC_OPT_STR "h?vdfxyluet:psS"
 
 extern void dbgprint_mem_range(const char *prefix, struct memory_range *mr, int nr_mr);
 extern void die(const char *fmt, ...)
@@ -311,5 +313,6 @@ int xen_present(void);
 int xen_kexec_load(struct kexec_info *info);
 int xen_kexec_unload(uint64_t kexec_flags);
 void xen_kexec_exec(void);
+int xen_kexec_status(uint64_t kexec_flags);
 
 #endif /* KEXEC_H */
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
