Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HhISU-0003kP-9l
	for kexec@lists.infradead.org; Fri, 27 Apr 2007 00:53:28 -0400
From: Michael Neuling <mikey@neuling.org>
Date: Fri, 27 Apr 2007 14:53:18 +1000
Subject: [PATCH 1/2] kexec: Added generic --reuseinitrd option
In-Reply-To: <13112.1177317015@neuling.org>
Message-Id: <1177649598.976491.841801585564.qpush@coopers>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>
Cc: Milton Miller <miltonm@bga.com>

Adds a generic --reuseinitrd option and performs some sanity checks on
it.  Can be used with the retain_initrd kernel option.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---

This series reserves the memory region so kexec doesn't
attempt to use it for something else.  Noticed by Milton.

---

 kexec/kexec.c |   33 +++++++++++++++++++++++++++++++++
 kexec/kexec.h |    2 ++
 2 files changed, 35 insertions(+)

Index: kexec-tools-testing/kexec/kexec.c
===================================================================
--- kexec-tools-testing.orig/kexec/kexec.c
+++ kexec-tools-testing/kexec/kexec.c
@@ -748,6 +748,7 @@ void usage(void)
 	       "                      load code into.\n"
 	       "     --mem-max=<addr> Specify the highest memory address to\n"
 	       "                      load code into.\n"
+	       "     --reuseinird     Reuse initrd from first boot.\n"
 	       "\n"
 	       "Supported kernel file types and options: \n");
 	for (i = 0; i < file_types; i++) {
@@ -772,6 +773,29 @@ static int kexec_loaded(void)
 	return ret;
 }
 
+/* check we retained the initrd */
+void check_reuse_initrd(void)
+{
+	FILE * fp;
+	char * line = NULL;
+	size_t len = 0;
+	ssize_t read;
+
+	fp = fopen("/proc/cmdline", "r");
+	if (fp == NULL)
+		die("unable to open /proc/cmdline\n");
+	read = getline(&line, &len, fp);
+	if (strstr(line, "retain_initrd") == NULL)
+		die("unrecoverable error: current boot didn't "
+		    "retain the initrd for reuse.\n");
+}
+
+/* Arch hook for reuse_initrd */
+void __attribute__((weak)) arch_reuse_initrd(void)
+{
+	die("--reuseinitrd not implemented on this architecture\n");
+}
+
 int main(int argc, char *argv[])
 {
 	int do_load = 1;
@@ -780,6 +804,7 @@ int main(int argc, char *argv[])
 	int do_sync = 1;
 	int do_ifdown = 0;
 	int do_unload = 0;
+	int do_reuse_initrd = 0;
 	unsigned long kexec_flags = 0;
 	char *type = 0;
 	char *endptr;
@@ -860,6 +885,9 @@ int main(int argc, char *argv[])
 				return 1;
 			}
 			break;
+		case OPT_REUSE_INITRD:
+			do_reuse_initrd = 1;
+			break;
 		default:
 			break;
 		}
@@ -890,6 +918,11 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (do_reuse_initrd){
+		check_reuse_initrd();
+		arch_reuse_initrd();
+	}
+
 	if (do_unload) {
 		result = k_unload(kexec_flags);
 	}
Index: kexec-tools-testing/kexec/kexec.h
===================================================================
--- kexec-tools-testing.orig/kexec/kexec.h
+++ kexec-tools-testing/kexec/kexec.h
@@ -163,6 +163,7 @@ extern int file_types;
 #define OPT_MEM_MIN             256
 #define OPT_MEM_MAX             257
 #define OPT_MAX			258
+#define OPT_REUSE_INITRD	259
 #define KEXEC_OPTIONS \
 	{ "help",		0, 0, OPT_HELP }, \
 	{ "version",		0, 0, OPT_VERSION }, \
@@ -175,6 +176,7 @@ extern int file_types;
 	{ "load-panic",         0, 0, OPT_PANIC }, \
 	{ "mem-min",		1, 0, OPT_MEM_MIN }, \
 	{ "mem-max",		1, 0, OPT_MEM_MAX }, \
+	{ "reuseinitrd",	0, 0, OPT_REUSE_INITRD }, \
 
 #define KEXEC_OPT_STR "hvdfxluet:p"
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
