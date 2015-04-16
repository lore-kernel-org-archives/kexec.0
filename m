Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Yimxn-00086y-GR
 for kexec@lists.infradead.org; Thu, 16 Apr 2015 16:48:28 +0000
From: Pratyush Anand <panand@redhat.com>
Subject: [PATCH RFC 4/6] arm64: support reuse-cmdline option
Date: Thu, 16 Apr 2015 22:17:20 +0530
Message-Id: <191650f31b8e4d7368f2a2562666e4e94976806b.1429201849.git.panand@redhat.com>
In-Reply-To: <cover.1429201849.git.panand@redhat.com>
References: <cover.1429201849.git.panand@redhat.com>
In-Reply-To: <cover.1429201849.git.panand@redhat.com>
References: <cover.1429201849.git.panand@redhat.com>
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
To: kexec@lists.fedoraproject.org, kexec@lists.infradead.org
Cc: Pratyush Anand <panand@redhat.com>

--reuse-cmdline uses cmdline argument of primary kernel. Support this
feature for ARM64.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 kexec/arch/arm64/include/arch/options.h | 7 +++++--
 kexec/arch/arm64/kexec-arm64.c          | 8 +++++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/kexec/arch/arm64/include/arch/options.h b/kexec/arch/arm64/include/arch/options.h
index 0d5987b18a25..afe3e9827ff3 100644
--- a/kexec/arch/arm64/include/arch/options.h
+++ b/kexec/arch/arm64/include/arch/options.h
@@ -6,7 +6,8 @@
 #define OPT_INITRD	((OPT_MAX)+2)
 #define OPT_LITE	((OPT_MAX)+3)
 #define OPT_PORT	((OPT_MAX)+4)
-#define OPT_ARCH_MAX	((OPT_MAX)+5)
+#define OPT_REUSE_CMDLINE	((OPT_MAX+5))
+#define OPT_ARCH_MAX	((OPT_MAX)+6)
 
 #define KEXEC_ARCH_OPTIONS \
 	KEXEC_OPTIONS \
@@ -17,6 +18,7 @@
 	{ "lite",         0, NULL, OPT_LITE }, \
 	{ "port",         1, NULL, OPT_PORT }, \
 	{ "ramdisk",      1, NULL, OPT_INITRD }, \
+	{ "reuse-cmdline", 0, NULL, OPT_REUSE_CMDLINE }, \
 
 #define KEXEC_ARCH_OPT_STR KEXEC_OPT_STR /* Only accept long arch options. */
 #define KEXEC_ALL_OPTIONS KEXEC_ARCH_OPTIONS
@@ -29,7 +31,8 @@ static const char arm64_opts_usage[] __attribute__ ((unused)) =
 "     --initrd=FILE         Use FILE as the kernel initial ramdisk.\n"
 "     --lite                Fast reboot, no memory integrity checks.\n"
 "     --port=ADDRESS        Purgatory output to port ADDRESS.\n"
-"     --ramdisk=FILE        Use FILE as the kernel initial ramdisk.\n";
+"     --ramdisk=FILE        Use FILE as the kernel initial ramdisk.\n"
+"     --reuse-cmdline       Use command line arg of primary kernel.\n";
 
 struct arm64_opts {
 	const char *command_line;
diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 391fec1fa161..34e4ebf1eb23 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -74,13 +74,18 @@ int arch_process_options(int argc, char **argv)
 		{ 0 }
 	};
 	int opt;
+	const char *append = NULL;
+	char *tmp_cmdline = NULL;
 
 	for (opt = 0; opt != -1; ) {
 		opt = getopt_long(argc, argv, short_options, options, 0);
 
 		switch (opt) {
 		case OPT_APPEND:
-			arm64_opts.command_line = optarg;
+			append = optarg;
+			break;
+		case OPT_REUSE_CMDLINE:
+			tmp_cmdline = get_command_line();
 			break;
 		case OPT_DTB:
 			arm64_opts.dtb = optarg;
@@ -99,6 +104,7 @@ int arch_process_options(int argc, char **argv)
 		}
 	}
 
+	arm64_opts.command_line = concat_cmdline(tmp_cmdline, append);
 	kexec_debug = 1; // FIXME: for debugging only.
 
 	dbgprintf("%s:%d: command_line: %s\n", __func__, __LINE__,
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
