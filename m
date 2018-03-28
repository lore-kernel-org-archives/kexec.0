Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f1AvW-0002DO-9V
 for kexec@lists.infradead.org; Wed, 28 Mar 2018 13:15:48 +0000
From: Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH v6 4/5] kexec: Add option to revert -s
Date: Wed, 28 Mar 2018 15:15:17 +0200
Message-Id: <a8639a304b7b62384fc1c747c35eee7728ce583f.1522242915.git.msuchanek@suse.de>
In-Reply-To: <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1522242915.git.msuchanek@suse.de>
References: <20180327095955.GB4681@dhcp-128-65.nay.redhat.com>
 <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1522242915.git.msuchanek@suse.de>
In-Reply-To: <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1522242915.git.msuchanek@suse.de>
References: <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1522242915.git.msuchanek@suse.de>
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

The undocumented -s option selects KEXEC_FILE_LOAD syscall but there is
no option to select KEXEC_LOAD syscall. Add it so -s can be reverted.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
v6: add description to help text
---
 kexec/kexec.c | 5 +++++
 kexec/kexec.h | 4 +++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index 68ae0594d4a7..87689311af2f 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1005,6 +1005,8 @@ void usage(void)
 	       "                      preserve context)\n"
 	       "                      to original kernel.\n"
 	       " -s, --kexec-file-syscall Use file based syscall for kexec operation\n"
+	       " -c, --kexec-syscall  Use the kexec_load syscall for for compatibility\n"
+	       "                      with systems that don't support -s (default)\n"
 	       " -d, --debug          Enable debugging to help spot a failure.\n"
 	       " -S, --status         Return 0 if the type (by default crash) is loaded.\n"
 	       "\n"
@@ -1368,6 +1370,9 @@ int main(int argc, char *argv[])
 		case OPT_KEXEC_FILE_SYSCALL:
 			do_kexec_file_syscall = 1;
 			break;
+		case OPT_KEXEC_SYSCALL:
+			do_kexec_file_syscall = 0;
+			break;
 		case OPT_STATUS:
 			do_status = 1;
 			break;
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 26225d2c002a..9fd0355eacd0 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -219,6 +219,7 @@ extern int file_types;
 #define OPT_TYPE		't'
 #define OPT_PANIC		'p'
 #define OPT_KEXEC_FILE_SYSCALL	's'
+#define OPT_KEXEC_SYSCALL	'c'
 #define OPT_STATUS		'S'
 #define OPT_MEM_MIN             256
 #define OPT_MEM_MAX             257
@@ -246,11 +247,12 @@ extern int file_types;
 	{ "mem-max",		1, 0, OPT_MEM_MAX }, \
 	{ "reuseinitrd",	0, 0, OPT_REUSE_INITRD }, \
 	{ "kexec-file-syscall",	0, 0, OPT_KEXEC_FILE_SYSCALL }, \
+	{ "kexec-syscall",	0, 0, OPT_KEXEC_SYSCALL }, \
 	{ "debug",		0, 0, OPT_DEBUG }, \
 	{ "status",		0, 0, OPT_STATUS }, \
 	{ "print-ckr-size",     0, 0, OPT_PRINT_CKR_SIZE }, \
 
-#define KEXEC_OPT_STR "h?vdfxyluet:psS"
+#define KEXEC_OPT_STR "h?vdfxyluet:pscS"
 
 extern void dbgprint_mem_range(const char *prefix, struct memory_range *mr, int nr_mr);
 extern void die(const char *fmt, ...)
-- 
2.13.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
