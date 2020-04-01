Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp-fw-4101.amazon.com ([72.21.198.25])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJggW-0006u0-Jw
 for kexec@lists.infradead.org; Wed, 01 Apr 2020 16:57:50 +0000
Received: from EX13MTAUEB002.ant.amazon.com
 (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
 by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (Postfix) with ESMTPS
 id 56EAEA2257
 for <kexec@lists.infradead.org>; Wed,  1 Apr 2020 16:57:31 +0000 (UTC)
From: Varad Gautam <vrd@amazon.de>
Subject: [PATCH v2 3/3] kexec-xen: Introduce --exec-live-update to trigger a
 live update
Date: Wed, 1 Apr 2020 18:57:17 +0200
Message-ID: <1585760237-26924-3-git-send-email-vrd@amazon.de>
In-Reply-To: <1585760237-26924-1-git-send-email-vrd@amazon.de>
References: <1585760237-26924-1-git-send-email-vrd@amazon.de>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Varad Gautam <vrd@amazon.de>, dwmw@amazon.co.uk

This signals xen to do a KEXEC_TYPE_LIVE_UPDATE kexec operation.

Signed-off-by: Varad Gautam <vrd@amazon.de>
---
 kexec/kexec-xen.c | 12 ++++++++----
 kexec/kexec.c     | 11 ++++++++++-
 kexec/kexec.h     |  6 ++++--
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/kexec/kexec-xen.c b/kexec/kexec-xen.c
index 83629ba..da514d0 100644
--- a/kexec/kexec-xen.c
+++ b/kexec/kexec-xen.c
@@ -242,15 +242,19 @@ int xen_kexec_status(uint64_t kexec_flags)
 	return ret;
 }
 
-void xen_kexec_exec(void)
+void xen_kexec_exec(uint64_t kexec_flags)
 {
 	xc_interface *xch;
-	
+	uint8_t type = KEXEC_TYPE_DEFAULT;
+
 	xch = xc_interface_open(NULL, NULL, 0);
 	if (!xch)
 		return;
 
-	xc_kexec_exec(xch, KEXEC_TYPE_DEFAULT);
+	if (kexec_flags & KEXEC_LIVE_UPDATE)
+		type = KEXEC_TYPE_LIVE_UPDATE;
+
+	xc_kexec_exec(xch, type);
 
 	xc_interface_close(xch);
 }
@@ -277,7 +281,7 @@ int xen_kexec_status(uint64_t kexec_flags)
 	return -1;
 }
 
-void xen_kexec_exec(void)
+void xen_kexec_exec(uint64_t kexec_flags)
 {
 }
 
diff --git a/kexec/kexec.c b/kexec/kexec.c
index da61d6d..7ef3d2a 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -906,7 +906,7 @@ static int my_shutdown(void)
 static int my_exec(void)
 {
 	if (xen_present())
-		xen_kexec_exec();
+		xen_kexec_exec(kexec_flags);
 	else
 		reboot(LINUX_REBOOT_CMD_KEXEC);
 	/* I have failed if I make it here */
@@ -1012,6 +1012,8 @@ void usage(void)
 	       "                      If capture kernel is being unloaded\n"
 	       "                      specify -p with -u.\n"
 	       " -e, --exec           Execute a currently loaded kernel.\n"
+               "     --exec-live-update Execute a currently loaded xen image after\n"
+                                      "storing the state required to live update.\n"
 	       " -t, --type=TYPE      Specify the new kernel is of this type.\n"
 	       "     --mem-min=<addr> Specify the lowest memory address to\n"
 	       "                      load code into.\n"
@@ -1397,6 +1399,13 @@ int main(int argc, char *argv[])
 			do_unload = 1;
 			kexec_file_flags |= KEXEC_FILE_UNLOAD;
 			break;
+                case OPT_EXEC_LIVE_UPDATE:
+			if ( !xen_present() ) {
+				fprintf(stderr, "--exec-live-update only works under xen.\n");
+                                return 1;
+                        }
+			kexec_flags |= KEXEC_LIVE_UPDATE;
+			/* fallthrough */
 		case OPT_EXEC:
 			do_load = 0;
 			do_shutdown = 0;
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 8021f39..f0f347d 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -234,7 +234,8 @@ extern int file_types;
 #define OPT_ENTRY		261
 #define OPT_PRINT_CKR_SIZE	262
 #define OPT_LOAD_LIVE_UPDATE	263
-#define OPT_MAX			264
+#define OPT_EXEC_LIVE_UPDATE	264
+#define OPT_MAX			265
 #define KEXEC_OPTIONS \
 	{ "help",		0, 0, OPT_HELP }, \
 	{ "version",		0, 0, OPT_VERSION }, \
@@ -245,6 +246,7 @@ extern int file_types;
 	{ "load",		0, 0, OPT_LOAD }, \
 	{ "unload",		0, 0, OPT_UNLOAD }, \
 	{ "exec",		0, 0, OPT_EXEC }, \
+	{ "exec-live-update",	0, 0, OPT_EXEC_LIVE_UPDATE}, \
 	{ "load-preserve-context", 0, 0, OPT_LOAD_PRESERVE_CONTEXT}, \
 	{ "load-jump-back-helper", 0, 0, OPT_LOAD_JUMP_BACK_HELPER }, \
 	{ "load-live-update", 0, 0, OPT_LOAD_LIVE_UPDATE }, \
@@ -326,7 +328,7 @@ void cmdline_add_liveupdate(char **base);
 int xen_present(void);
 int xen_kexec_load(struct kexec_info *info);
 int xen_kexec_unload(uint64_t kexec_flags);
-void xen_kexec_exec(void);
+void xen_kexec_exec(uint64_t kexec_flags);
 int xen_kexec_status(uint64_t kexec_flags);
 
 extern unsigned long long get_kernel_sym(const char *text);
-- 
2.7.4




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
