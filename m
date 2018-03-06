Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1etCRw-000187-UW
 for kexec@lists.infradead.org; Tue, 06 Mar 2018 13:16:14 +0000
From: Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH v4 3/5] kexec: add option to revert -s
Date: Tue,  6 Mar 2018 14:15:54 +0100
Message-Id: <1b9aab1f9562e9de4eb77e6b70f75f9788577834.1520342150.git.msuchanek@suse.de>
In-Reply-To: <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1520342150.git.msuchanek@suse.de>
References: <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1520342150.git.msuchanek@suse.de>
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

The undocumented -s option selects KEXEC_FILE_LOAD syscall but there is
no option to select KEXEC_LOAD syscall so add it. It is generally good
idea and in followup patch the default will be changed so it will be
needed to get KEXEC_LOAD functionality.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 kexec/kexec.c | 3 +++
 kexec/kexec.h | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index 9ea102e1565a..a95cfb473d6b 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1368,6 +1368,9 @@ int main(int argc, char *argv[])
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
