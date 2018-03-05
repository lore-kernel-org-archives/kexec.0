Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1espcA-0005wY-KB
 for kexec@lists.infradead.org; Mon, 05 Mar 2018 12:53:16 +0000
From: Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH] kexec: add option to fall back to KEXEC_LOAD when
 KEXEC_FILE_LOAD is not supported.
Date: Mon,  5 Mar 2018 13:52:52 +0100
Message-Id: <20180305125252.4953-1-msuchanek@suse.de>
In-Reply-To: <3b910afee8763a7fd64358884ce3fd4d43e98675.1519997533.git.msuchanek@suse.de>
References: <3b910afee8763a7fd64358884ce3fd4d43e98675.1519997533.git.msuchanek@suse.de>
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
To: kexec@lists.infradead.org
Cc: Tony Jones <tonyj@suse.com>, Dave Young <dyoung@redhat.com>, Michal Suchanek <msuchanek@suse.de>, Petr Tesarik <ptesarik@suse.cz>, horms@verge.net.au

Not all architectures implement KEXEC_FILE_LOAD. However, on some
archiectures KEXEC_FILE_LOAD is required when secure boot is enabled in
locked-down mode. Previously users had to select the KEXEC_FILE_LOAD
syscall with undocumented -s option. However, if they did pass the
option kexec would fail on architectures that do not support it.

So add an -a option that tries KEXEC_FILE_LOAD and when it is not
supported tries KEXEC_LOAD.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 kexec/kexec.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++----
 kexec/kexec.h |  4 +++-
 2 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index a95cfb473d6b..c7aaf8ac147f 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1243,6 +1243,7 @@ int main(int argc, char *argv[])
 	int do_unload = 0;
 	int do_reuse_initrd = 0;
 	int do_kexec_file_syscall = 0;
+	int do_kexec_fallback = 0;
 	int do_status = 0;
 	void *entry = 0;
 	char *type = 0;
@@ -1367,10 +1368,15 @@ int main(int argc, char *argv[])
 			break;
 		case OPT_KEXEC_FILE_SYSCALL:
 			do_kexec_file_syscall = 1;
+			do_kexec_fallback = 0;
 			break;
 		case OPT_KEXEC_SYSCALL:
 			do_kexec_file_syscall = 0;
+			do_kexec_fallback = 0;
 			break;
+		case OPT_KEXEC_SYSCALL_AUTO:
+			do_kexec_file_syscall = 1;
+			do_kexec_fallback = 1;
 		case OPT_STATUS:
 			do_status = 1;
 			break;
@@ -1442,16 +1448,53 @@ int main(int argc, char *argv[])
 		result = k_status(kexec_flags);
 	}
 	if (do_unload) {
-		if (do_kexec_file_syscall)
+		if (do_kexec_file_syscall) {
 			result = kexec_file_unload(kexec_file_flags);
-		else
+			if ((result == -ENOSYS) && do_kexec_fallback)
+				do_kexec_file_syscall = 0;
+		}
+		if (!do_kexec_file_syscall)
 			result = k_unload(kexec_flags);
 	}
 	if (do_load && (result == 0)) {
-		if (do_kexec_file_syscall)
+		if (do_kexec_file_syscall) {
 			result = do_kexec_file_load(fileind, argc, argv,
 						 kexec_file_flags);
-		else
+			if (do_kexec_fallback) switch (result) {
+				/*
+				 * Something failed with signature verification.
+				 * Reject the image.
+				 */
+				case -ELIBBAD:
+				case -EKEYREJECTED:
+				case -ENOPKG:
+				case -ENOKEY:
+				case -EBADMSG:
+				case -EMSGSIZE:
+					/*
+					 * By default reject or do nothing if
+					 * succeded
+					 */
+				default: break;
+					/*
+					 * Parsing image or other options failed
+					 * The image may be invalid or image
+					 * type may not supported by kernel so
+					 * retry parsing in kexec-tools.
+					 */
+				case -EINVAL:
+				case -ENOEXEC:
+					 /*
+					  * ENOTSUPP can be unsupported image
+					  * type or unsupported PE signature
+					  * wrapper type, duh
+					  */
+				case -ENOTSUP:
+					do_kexec_file_syscall = 0;
+					break;
+			}
+		}
+		if (!do_kexec_file_syscall)
 			result = my_load(type, fileind, argc, argv,
 						kexec_flags, entry);
 	}
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 9fd0355eacd0..d445fbe3e486 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -220,6 +220,7 @@ extern int file_types;
 #define OPT_PANIC		'p'
 #define OPT_KEXEC_FILE_SYSCALL	's'
 #define OPT_KEXEC_SYSCALL	'c'
+#define OPT_KEXEC_SYSCALL_AUTO	'a'
 #define OPT_STATUS		'S'
 #define OPT_MEM_MIN             256
 #define OPT_MEM_MAX             257
@@ -248,11 +249,12 @@ extern int file_types;
 	{ "reuseinitrd",	0, 0, OPT_REUSE_INITRD }, \
 	{ "kexec-file-syscall",	0, 0, OPT_KEXEC_FILE_SYSCALL }, \
 	{ "kexec-syscall",	0, 0, OPT_KEXEC_SYSCALL }, \
+	{ "kexec-syscall-auto",	0, 0, OPT_KEXEC_SYSCALL_AUTO }, \
 	{ "debug",		0, 0, OPT_DEBUG }, \
 	{ "status",		0, 0, OPT_STATUS }, \
 	{ "print-ckr-size",     0, 0, OPT_PRINT_CKR_SIZE }, \
 
-#define KEXEC_OPT_STR "h?vdfxyluet:pscS"
+#define KEXEC_OPT_STR "h?vdfxyluet:pscaS"
 
 extern void dbgprint_mem_range(const char *prefix, struct memory_range *mr, int nr_mr);
 extern void die(const char *fmt, ...)
-- 
2.13.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
