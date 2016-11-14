Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c6PVK-00008A-PW
 for kexec@lists.infradead.org; Mon, 14 Nov 2016 22:13:32 +0000
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH v1 2/2] kexec: Support -S paramter to return whether the kexec
 payload is loaded.
Date: Mon, 14 Nov 2016 17:12:53 -0500
Message-Id: <1479161573-12671-3-git-send-email-konrad.wilk@oracle.com>
In-Reply-To: <1479161573-12671-1-git-send-email-konrad.wilk@oracle.com>
References: <1479161573-12671-1-git-send-email-konrad.wilk@oracle.com>
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
To: david.vrabel@citrix.com, xen-devel@lists.xenproject.org, kexec@lists.infradead.org
Cc: elena.ufimtseva@oracle.com, daniel.kiper@oracle.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Instead of the scripts having to poke at various fields we can
provide that functionality via the -S parameter.

Returns 0 if the payload is loaded. Can be used in combination
with -l or -p to get the state of the proper kexec image.

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
v0: First version (internal product).
v1: Posted on kexec mailing list. Changed -s to -S

CC: kexec@lists.infradead.org
CC: xen-devel@lists.xenproject.org
CC: Daniel Kiper <daniel.kiper@oracle.com>
---
 kexec/kexec-xen.c | 20 ++++++++++++++++++
 kexec/kexec.8     |  5 +++++
 kexec/kexec.c     | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
 kexec/kexec.h     |  5 ++++-
 4 files changed, 85 insertions(+), 6 deletions(-)

diff --git a/kexec/kexec-xen.c b/kexec/kexec-xen.c
index 24a4191..5a1e9d2 100644
--- a/kexec/kexec-xen.c
+++ b/kexec/kexec-xen.c
@@ -105,6 +105,26 @@ int xen_kexec_unload(uint64_t kexec_flags)
 	return ret;
 }
 
+int xen_kexec_status(uint64_t kexec_flags)
+{
+	xc_interface *xch;
+	uint8_t type;
+	int ret;
+
+	xch = xc_interface_open(NULL, NULL, 0);
+	if (!xch)
+		return -1;
+
+	type = (kexec_flags & KEXEC_ON_CRASH) ? KEXEC_TYPE_CRASH
+		: KEXEC_TYPE_DEFAULT;
+
+	ret = xc_kexec_status(xch, type);
+
+	xc_interface_close(xch);
+
+	return ret;
+}
+
 void xen_kexec_exec(void)
 {
 	xc_interface *xch;
diff --git a/kexec/kexec.8 b/kexec/kexec.8
index 4d0c1d1..02f4ccf 100644
--- a/kexec/kexec.8
+++ b/kexec/kexec.8
@@ -107,6 +107,11 @@ command:
 .B \-d\ (\-\-debug)
 Enable debugging messages.
 .TP
+.B \-D\ (\-\-status)
+Return 0 if the type (by default crash) is loaded. Can be used in conjuction
+with -l or -p to toggle the type. Note it will
+.BR not\ load\ the\ kernel.
+.TP
 .B \-e\ (\-\-exec)
 Run the currently loaded kernel. Note that it will reboot into the loaded kernel without calling shutdown(8).
 .TP
diff --git a/kexec/kexec.c b/kexec/kexec.c
index 500e5a9..bc72688 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -855,6 +855,32 @@ static int k_unload (unsigned long kexec_flags)
 	return result;
 }
 
+static int kexec_loaded(void);
+static int __kexec_loaded(const char *f);
+
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
+			result = __kexec_loaded("/sys/kernel/kexec_crash_loaded");
+		else
+			result = kexec_loaded();
+	}
+	return result;
+}
+
 /*
  *	Start a reboot.
  */
@@ -890,8 +916,6 @@ static int my_exec(void)
 	return -1;
 }
 
-static int kexec_loaded(void);
-
 static int load_jump_back_helper_image(unsigned long kexec_flags, void *entry)
 {
 	int result;
@@ -970,6 +994,7 @@ void usage(void)
 	       "                      to original kernel.\n"
 	       " -s, --kexec-file-syscall Use file based syscall for kexec operation\n"
 	       " -d, --debug           Enable debugging to help spot a failure.\n"
+	       " -S, --status         Return 0 if the type (by default crash) is loaded.\n"
 	       "\n"
 	       "Supported kernel file types and options: \n");
 	for (i = 0; i < file_types; i++) {
@@ -981,7 +1006,7 @@ void usage(void)
 	printf("\n");
 }
 
-static int kexec_loaded(void)
+static int __kexec_loaded(const char *file)
 {
 	long ret = -1;
 	FILE *fp;
@@ -992,7 +1017,7 @@ static int kexec_loaded(void)
 	if (xen_present())
 		return 1;
 
-	fp = fopen("/sys/kernel/kexec_loaded", "r");
+	fp = fopen(file, "r");
 	if (fp == NULL)
 		return -1;
 
@@ -1015,6 +1040,12 @@ static int kexec_loaded(void)
 	return (int)ret;
 }
 
+static int kexec_loaded(void)
+{
+	return __kexec_loaded("/sys/kernel/kexec_loaded");
+}
+
+
 /*
  * Remove parameter from a kernel command line. Helper function by get_command_line().
  */
@@ -1204,6 +1235,7 @@ int main(int argc, char *argv[])
 	int do_unload = 0;
 	int do_reuse_initrd = 0;
 	int do_kexec_file_syscall = 0;
+	int do_status = 0;
 	void *entry = 0;
 	char *type = 0;
 	char *endptr;
@@ -1345,6 +1377,9 @@ int main(int argc, char *argv[])
 		case OPT_KEXEC_FILE_SYSCALL:
 			/* We already parsed it. Nothing to do. */
 			break;
+		case OPT_STATUS:
+			do_status = 1;
+			break;
 		default:
 			break;
 		}
@@ -1355,6 +1390,20 @@ int main(int argc, char *argv[])
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
@@ -1392,7 +1441,9 @@ int main(int argc, char *argv[])
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
2.5.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
