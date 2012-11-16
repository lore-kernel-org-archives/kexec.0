Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TZUxl-0005lw-BQ
 for kexec@lists.infradead.org; Fri, 16 Nov 2012 23:04:45 +0000
From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 3/8] add mem64_min/max control
Date: Fri, 16 Nov 2012 15:04:22 -0800
Message-Id: <1353107067-14564-4-git-send-email-yinghai@kernel.org>
In-Reply-To: <1353107067-14564-1-git-send-email-yinghai@kernel.org>
References: <1353107067-14564-1-git-send-email-yinghai@kernel.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>, "H. Peter Anvin" <hpa@zytor.com>, Vivek Goyal <vgoyal@redhat.com>, Haren Myneni <hbabu@us.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Yinghai Lu <yinghai@kernel.org>, kexec@lists.infradead.org

So could limit range for 4g above buffers.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 kexec/kexec.c |   26 ++++++++++++++++++++++++++
 kexec/kexec.h |    9 ++++++++-
 2 files changed, 34 insertions(+), 1 deletions(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index 8928be0..00f90f5 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -50,6 +50,8 @@
 
 unsigned long long mem_min = 0;
 unsigned long long mem_max = ULONG_MAX;
+unsigned long long mem64_min = 1ULL<32;
+unsigned long long mem64_max = ULLONG_MAX;
 static unsigned long kexec_flags = 0;
 int kexec_debug = 0;
 
@@ -900,6 +902,10 @@ void usage(void)
 	       "                      load code into.\n"
 	       "     --mem-max=<addr> Specify the highest memory address to\n"
 	       "                      load code into.\n"
+	       "     --mem64-min=<addr> Specify the lowest memory address \n"
+	       "                      above 4G to load code into.\n"
+	       "     --mem64-max=<addr> Specify the highest memory address \n"
+	       "                      above 4G to load code into.\n"
 	       "     --reuseinitrd    Reuse initrd from first boot.\n"
 	       "     --load-preserve-context Load the new kernel and preserve\n"
 	       "                      context of current kernel during kexec.\n"
@@ -1165,6 +1171,26 @@ int main(int argc, char *argv[])
 				return 1;
 			}
 			break;
+		case OPT_MEM64_MIN:
+			mem64_min = strtoul(optarg, &endptr, 0);
+			if (*endptr) {
+				fprintf(stderr,
+					"Bad option value in --mem64-min=%s\n",
+					optarg);
+				usage();
+				return 1;
+			}
+			break;
+		case OPT_MEM64_MAX:
+			mem64_max = strtoul(optarg, &endptr, 0);
+			if (*endptr) {
+				fprintf(stderr,
+					"Bad option value in --mem64-max=%s\n",
+					optarg);
+				usage();
+				return 1;
+			}
+			break;
 		case OPT_REUSE_INITRD:
 			do_reuse_initrd = 1;
 			break;
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 35b0b10..2e0e5f2 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -113,6 +113,7 @@ do { \
         _x > _y ? _x : _y; })
 
 extern unsigned long long mem_min, mem_max;
+extern unsigned long long mem64_min, mem64_max;
 extern int kexec_debug;
 
 #define dbgprintf(...) \
@@ -211,7 +212,11 @@ extern int file_types;
 #define OPT_LOAD_PRESERVE_CONTEXT 259
 #define OPT_LOAD_JUMP_BACK_HELPER 260
 #define OPT_ENTRY		261
-#define OPT_MAX			262
+#define OPT_MEM64_MIN           262
+#define OPT_MEM64_MAX           263
+
+#define OPT_MAX			264
+
 #define KEXEC_OPTIONS \
 	{ "help",		0, 0, OPT_HELP }, \
 	{ "version",		0, 0, OPT_VERSION }, \
@@ -227,6 +232,8 @@ extern int file_types;
 	{ "load-panic",         0, 0, OPT_PANIC }, \
 	{ "mem-min",		1, 0, OPT_MEM_MIN }, \
 	{ "mem-max",		1, 0, OPT_MEM_MAX }, \
+	{ "mem64-min",		1, 0, OPT_MEM64_MIN }, \
+	{ "mem64-max",		1, 0, OPT_MEM64_MAX }, \
 	{ "reuseinitrd",	0, 0, OPT_REUSE_INITRD }, \
 	{ "debug",		0, 0, OPT_DEBUG }, \
 
-- 
1.7.7


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
