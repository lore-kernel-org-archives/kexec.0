Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a6QI0-0001hy-QD
 for kexec@lists.infradead.org; Tue, 08 Dec 2015 21:59:17 +0000
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH 14/14] kexec: Add option to get crash kernel region size
Date: Tue,  8 Dec 2015 22:57:47 +0100
Message-Id: <1449611867-15672-15-git-send-email-daniel.kiper@oracle.com>
In-Reply-To: <1449611867-15672-1-git-send-email-daniel.kiper@oracle.com>
References: <1449611867-15672-1-git-send-email-daniel.kiper@oracle.com>
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
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: andrew.cooper3@citrix.com, horms@verge.net.au, keir@xen.org, david.vrabel@citrix.com, konrad.wilk@oracle.com

Here print_crashkernel_region_size() function is available on all archs (even
if the functionality is not implemented on some). So, we can safely use it in
arch independent code and export the functionality to the user space.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 kexec/kexec.8 |    3 +++
 kexec/kexec.c |    4 ++++
 kexec/kexec.h |    5 ++++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/kexec/kexec.8 b/kexec/kexec.8
index 4d0c1d1..e65345e 100644
--- a/kexec/kexec.8
+++ b/kexec/kexec.8
@@ -173,6 +173,9 @@ Load a helper image to jump back to original kernel.
 .TP
 .BI \-\-reuseinitrd
 Reuse initrd from first boot.
+.TP
+.BI \-\-print-ckr-size
+Print crash kernel region size. -1 means that this functionality is not implemented.
 
 
 .SH SUPPORTED KERNEL FILE TYPES AND OPTIONS
diff --git a/kexec/kexec.c b/kexec/kexec.c
index 20dd93d..a27f596 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -960,6 +960,7 @@ void usage(void)
 	       "     --mem-max=<addr> Specify the highest memory address to\n"
 	       "                      load code into.\n"
 	       "     --reuseinitrd    Reuse initrd from first boot.\n"
+	       "     --print-ckr-size Print crash kernel region size.\n"
 	       "     --load-preserve-context Load the new kernel and preserve\n"
 	       "                      context of current kernel during kexec.\n"
 	       "     --load-jump-back-helper Load a helper image to jump back\n"
@@ -1345,6 +1346,9 @@ int main(int argc, char *argv[])
 		case OPT_KEXEC_FILE_SYSCALL:
 			/* We already parsed it. Nothing to do. */
 			break;
+		case OPT_PRINT_CKR_SIZE:
+			print_crashkernel_region_size();
+			return 0;
 		default:
 			break;
 		}
diff --git a/kexec/kexec.h b/kexec/kexec.h
index c02ac8f..42a602d 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -224,7 +224,8 @@ extern int file_types;
 #define OPT_LOAD_PRESERVE_CONTEXT 259
 #define OPT_LOAD_JUMP_BACK_HELPER 260
 #define OPT_ENTRY		261
-#define OPT_MAX			262
+#define OPT_PRINT_CKR_SIZE	262
+#define OPT_MAX			263
 #define KEXEC_OPTIONS \
 	{ "help",		0, 0, OPT_HELP }, \
 	{ "version",		0, 0, OPT_VERSION }, \
@@ -244,6 +245,7 @@ extern int file_types;
 	{ "reuseinitrd",	0, 0, OPT_REUSE_INITRD }, \
 	{ "kexec-file-syscall",	0, 0, OPT_KEXEC_FILE_SYSCALL }, \
 	{ "debug",		0, 0, OPT_DEBUG }, \
+	{ "print-ckr-size",	0, 0, OPT_PRINT_CKR_SIZE }, \
 
 #define KEXEC_OPT_STR "h?vdfxyluet:ps"
 
@@ -290,6 +292,7 @@ int arch_compat_trampoline(struct kexec_info *info);
 void arch_update_purgatory(struct kexec_info *info);
 int is_crashkernel_mem_reserved(void);
 int get_crash_kernel_load_range(uint64_t *start, uint64_t *end);
+void print_crashkernel_region_size(void);
 char *get_command_line(void);
 
 int kexec_iomem_for_each_line(char *match,
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
