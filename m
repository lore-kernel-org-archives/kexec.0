Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eqHSj-0007a1-AC
 for kexec@lists.infradead.org; Mon, 26 Feb 2018 12:01:02 +0000
From: Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH 4/5] kexec: fallback to KEXEC_LOAD when KEXEC_FILE_LOAD is not
 supported.
Date: Mon, 26 Feb 2018 13:00:37 +0100
Message-Id: <ebc4bc6f1dc7d62ba5c81f40c7f7d83a8ae3eb5d.1519646210.git.msuchanek@suse.de>
In-Reply-To: <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1519646210.git.msuchanek@suse.de>
References: <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1519646210.git.msuchanek@suse.de>
In-Reply-To: <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1519646210.git.msuchanek@suse.de>
References: <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1519646210.git.msuchanek@suse.de>
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
To: msuchanek@suse.de, kexec@lists.infradead.org
Cc: Tony Jones <tonyj@suse.com>, horms@verge.net.au, Petr Tesarik <ptesarik@suse.cz>

Not all architectures implement KEXEC_FILE_LOAD. However, on some
archiectures KEXEC_FILE_LOAD is required when secure boot is enabled in
locked-down mode. Previously users had to select the KEXEC_FILE_LOAD
syscall with undocumented -s option. However, if they did pass the
option kexec would fail on architectures that do not support it.

When no option is passed to select one syscall or the other try
KEXEC_FILE_LOAD and fall back to KEXEC_LOAD when not suported.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 kexec/kexec.c | 43 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index a95cfb473d6b..14f56e466a95 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1243,6 +1243,7 @@ int main(int argc, char *argv[])
 	int do_unload = 0;
 	int do_reuse_initrd = 0;
 	int do_kexec_file_syscall = 0;
+	int do_kexec_fallback = 1;
 	int do_status = 0;
 	void *entry = 0;
 	char *type = 0;
@@ -1367,9 +1368,11 @@ int main(int argc, char *argv[])
 			break;
 		case OPT_KEXEC_FILE_SYSCALL:
 			do_kexec_file_syscall = 1;
+			do_kexec_fallback = 0;
 			break;
 		case OPT_KEXEC_SYSCALL:
 			do_kexec_file_syscall = 0;
+			do_kexec_fallback = 0;
 			break;
 		case OPT_STATUS:
 			do_status = 1;
@@ -1442,16 +1445,48 @@ int main(int argc, char *argv[])
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
+				case -ENOTSUPP:
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
+					do_kexec_file_syscall = 0;
+					break;
+			}
+		}
+		if (!do_kexec_file_syscall)
 			result = my_load(type, fileind, argc, argv,
 						kexec_flags, entry);
 	}
-- 
2.13.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
