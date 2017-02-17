Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cerKt-0001xG-4R
 for kexec@lists.infradead.org; Fri, 17 Feb 2017 22:49:12 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
Subject: [PATCH v5 11/11] kexec: Add option to get crash kernel region size
Date: Fri, 17 Feb 2017 16:47:25 -0600
Message-Id: <1487371645-8299-12-git-send-email-eric.devolder@oracle.com>
In-Reply-To: <1487371645-8299-1-git-send-email-eric.devolder@oracle.com>
References: <1487371645-8299-1-git-send-email-eric.devolder@oracle.com>
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
To: kexec@lists.infradead.org, horms@verge.net.au, andrew.cooper3@citrix.com
Cc: daniel.kiper@oracle.com, konrad.wilk@oracle.com

From: Daniel Kiper <daniel.kiper@oracle.com>

Crash kernel region size is available via sysfs on Linux running on
bare metal. However, this does not work when Linux runs as Xen dom0.
In this case Xen crash kernel region size should be established using
__HYPERVISOR_kexec_op hypercall (Linux kernel kexec functionality does
not make a lot of sense in Xen dom0). Sadly hypercalls are not easily
accessible using shell scripts or something like that. Potentially we
can check "xl dmesg" output for crashkernel option but this is not nice.
So, let's add this functionality, for Linux running on bare metal and
as Xen dom0, to kexec-tools. This way kdump scripts may establish crash
kernel region size in one way regardless of platform. All burden of
platform detection lies on kexec-tools.

Figure (and unit) displayed by this new kexec-tools functionality is
the same as one taken from /sys/kernel/kexec_crash_size.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>
---
v5: Incorporated feedback:
    - Fixed indentation in print_crash_kernel_load_range()
    - changes for coding convention and formatting
v4: Incorporated feedback:
    - changes for coding convention and formatting
    - Changed commit description to make it clear that
      get_crash_kernel_load_range() is a stub on some archs
v3: Incorporated feedback:
    - changes for coding convention and formatting
    - restructured to introduce get_crash_kernel_load_range() for each
      architecture, and then a single function in kexec/kexec.c to call
      the per-architecture get_crash_kernel_load_range() and print the
      result.
v2: Incorporated feedback:
    - utilize the is_crashkernel_mem_reserved() function common in all archs
    - for ppc and ppc64, utilize device-tree values to print size
    - for unsupported architectures, print appropriate message
v1: Posted to kexec-tools mailing list
---
 kexec/kexec.8 |  3 +++
 kexec/kexec.c | 16 ++++++++++++++++
 kexec/kexec.h |  4 +++-
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/kexec/kexec.8 b/kexec/kexec.8
index f4b39a6..e0131b4 100644
--- a/kexec/kexec.8
+++ b/kexec/kexec.8
@@ -179,6 +179,9 @@ Load a helper image to jump back to original kernel.
 .TP
 .BI \-\-reuseinitrd
 Reuse initrd from first boot.
+.TP
+.BI \-\-print-ckr-size
+Print crash kernel region size, if available.
 
 
 .SH SUPPORTED KERNEL FILE TYPES AND OPTIONS
diff --git a/kexec/kexec.c b/kexec/kexec.c
index a2ba79d..cfd837c 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -995,6 +995,7 @@ void usage(void)
 	       "     --mem-max=<addr> Specify the highest memory address to\n"
 	       "                      load code into.\n"
 	       "     --reuseinitrd    Reuse initrd from first boot.\n"
+	       "     --print-ckr-size Print crash kernel region size.\n"
 	       "     --load-preserve-context Load the new kernel and preserve\n"
 	       "                      context of current kernel during kexec.\n"
 	       "     --load-jump-back-helper Load a helper image to jump back\n"
@@ -1218,6 +1219,18 @@ static int do_kexec_file_load(int fileind, int argc, char **argv,
 	return ret;
 }
 
+static void print_crashkernel_region_size(void)
+{
+	uint64_t start = 0, end = 0;
+
+	if (is_crashkernel_mem_reserved() &&
+	    get_crash_kernel_load_range(&start, &end)) {
+		fprintf(stderr, "get_crash_kernel_load_range() failed.\n");
+		return;
+	}
+
+	printf("%lu\n", (start != end) ? (end - start + 1) : 0UL);
+}
 
 int main(int argc, char *argv[])
 {
@@ -1375,6 +1388,9 @@ int main(int argc, char *argv[])
 		case OPT_STATUS:
 			do_status = 1;
 			break;
+		case OPT_PRINT_CKR_SIZE:
+			print_crashkernel_region_size();
+			return 0;
 		default:
 			break;
 		}
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 2b06f59..52bef9b 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -226,7 +226,8 @@ extern int file_types;
 #define OPT_LOAD_PRESERVE_CONTEXT 259
 #define OPT_LOAD_JUMP_BACK_HELPER 260
 #define OPT_ENTRY		261
-#define OPT_MAX			262
+#define OPT_PRINT_CKR_SIZE	262
+#define OPT_MAX			263
 #define KEXEC_OPTIONS \
 	{ "help",		0, 0, OPT_HELP }, \
 	{ "version",		0, 0, OPT_VERSION }, \
@@ -247,6 +248,7 @@ extern int file_types;
 	{ "kexec-file-syscall",	0, 0, OPT_KEXEC_FILE_SYSCALL }, \
 	{ "debug",		0, 0, OPT_DEBUG }, \
 	{ "status",		0, 0, OPT_STATUS }, \
+	{ "print-ckr-size",     0, 0, OPT_PRINT_CKR_SIZE }, \
 
 #define KEXEC_OPT_STR "h?vdfxyluet:psS"
 
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
