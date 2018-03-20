Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1eyJcq-0006qw-Mj
 for kexec@lists.infradead.org; Tue, 20 Mar 2018 15:56:41 +0000
From: Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH v5 4/5] kexec: Add option to fall back to KEXEC_LOAD when
 KEXEC_FILE_LOAD is not supported
Date: Tue, 20 Mar 2018 16:56:19 +0100
Message-Id: <9db6c165a0832796faf88b0cef8f296a896f5fa8.1521561315.git.msuchanek@suse.de>
In-Reply-To: <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1521561315.git.msuchanek@suse.de>
References: <20180316114714.4tmf4gr3d6boowi5@verge.net.au>
 <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1521561315.git.msuchanek@suse.de>
In-Reply-To: <20180302091706.GA15374@dhcp-128-65.nay.redhat.com>
References: <20180302091706.GA15374@dhcp-128-65.nay.redhat.com>
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
v3: instead of changing the deafult add extra option
v4: actually check -ENOSYS as well
v5: add missing break
---
 kexec/kexec.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 kexec/kexec.h |  6 +++++-
 2 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index 68ae0594d4a7..44042345a16e 100644
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
@@ -1367,6 +1368,15 @@ int main(int argc, char *argv[])
 			break;
 		case OPT_KEXEC_FILE_SYSCALL:
 			do_kexec_file_syscall = 1;
+			do_kexec_fallback = 0;
+			break;
+		case OPT_KEXEC_SYSCALL:
+			do_kexec_file_syscall = 0;
+			do_kexec_fallback = 0;
+			break;
+		case OPT_KEXEC_SYSCALL_AUTO:
+			do_kexec_file_syscall = 1;
+			do_kexec_fallback = 1;
 			break;
 		case OPT_STATUS:
 			do_status = 1;
@@ -1433,7 +1443,7 @@ int main(int argc, char *argv[])
 		}
 	}
 	if (do_kexec_file_syscall) {
-		if (do_load_jump_back_helper)
+		if (do_load_jump_back_helper && !do_kexec_fallback)
 			die("--load-jump-back-helper not supported with kexec_file_load\n");
 		if (kexec_flags & KEXEC_PRESERVE_CONTEXT)
 			die("--load-preserve-context not supported with kexec_file_load\n");
@@ -1447,16 +1457,54 @@ int main(int argc, char *argv[])
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
+				case -ENOSYS: /* not implemented */
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
index 26225d2c002a..d445fbe3e486 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -219,6 +219,8 @@ extern int file_types;
 #define OPT_TYPE		't'
 #define OPT_PANIC		'p'
 #define OPT_KEXEC_FILE_SYSCALL	's'
+#define OPT_KEXEC_SYSCALL	'c'
+#define OPT_KEXEC_SYSCALL_AUTO	'a'
 #define OPT_STATUS		'S'
 #define OPT_MEM_MIN             256
 #define OPT_MEM_MAX             257
@@ -246,11 +248,13 @@ extern int file_types;
 	{ "mem-max",		1, 0, OPT_MEM_MAX }, \
 	{ "reuseinitrd",	0, 0, OPT_REUSE_INITRD }, \
 	{ "kexec-file-syscall",	0, 0, OPT_KEXEC_FILE_SYSCALL }, \
+	{ "kexec-syscall",	0, 0, OPT_KEXEC_SYSCALL }, \
+	{ "kexec-syscall-auto",	0, 0, OPT_KEXEC_SYSCALL_AUTO }, \
 	{ "debug",		0, 0, OPT_DEBUG }, \
 	{ "status",		0, 0, OPT_STATUS }, \
 	{ "print-ckr-size",     0, 0, OPT_PRINT_CKR_SIZE }, \
 
-#define KEXEC_OPT_STR "h?vdfxyluet:psS"
+#define KEXEC_OPT_STR "h?vdfxyluet:pscaS"
 
 extern void dbgprint_mem_range(const char *prefix, struct memory_range *mr, int nr_mr);
 extern void die(const char *fmt, ...)
-- 
2.13.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
