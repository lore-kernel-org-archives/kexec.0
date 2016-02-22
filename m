Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail9.hitachi.co.jp ([133.145.228.44])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aXpAn-0001pa-EH
 for kexec@lists.infradead.org; Mon, 22 Feb 2016 12:01:12 +0000
Subject: [RFC v2 PATCH 4/7] purgatory/ipmi: Support BMC watchdog timer
 start/stop in purgatory
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Date: Mon, 22 Feb 2016 20:56:25 +0900
Message-ID: <20160222115625.4231.20262.stgit@softrs>
In-Reply-To: <20160222115617.4231.50041.stgit@softrs>
References: <20160222115617.4231.50041.stgit@softrs>
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
To: Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, Corey Minyard <minyard@acm.org>

This patch adds a functionality to start/stop BMC watchdog timer in
purgatory.  Starting the watchdog timer is useful to automatically
reboot the server when we fail to boot the second kernel.  Stopping
the watchdog timer is useful to prevent the second kernel from being
stopped by the watchdog timer enabled while the first kernel is
running.

If you specify --ipmi-wdt-start or --ipmi-wdt-stop option to kexec
command, BMC's watchdog timer will start or stop respectively while
executing purgatory.  You can't specify the both options at the same
time.  The start operation doesn't change the parameters of the
watchdog timer such as initial counter and action.  You need to set
those parameters in the first OS beforehand.  On the other hand, the
stop operation changes the parameters.  You need to reset them when
you reuse the watchdog timer later.

Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
---
 kexec/ipmi.h                             |    9 +++++
 kexec/kexec.c                            |   21 +++++++++++
 kexec/kexec.h                            |    6 +++
 purgatory/arch/x86_64/purgatory-x86_64.c |   10 +++++
 purgatory/include/purgatory.h            |    4 ++
 purgatory/ipmi.c                         |   58 ++++++++++++++++++++++++++++++
 6 files changed, 106 insertions(+), 2 deletions(-)
 create mode 100644 kexec/ipmi.h

diff --git a/kexec/ipmi.h b/kexec/ipmi.h
new file mode 100644
index 0000000..395a2c7
--- /dev/null
+++ b/kexec/ipmi.h
@@ -0,0 +1,9 @@
+#ifndef IPMI_H
+#define IPMI_H
+
+/* Options for IPMI code excuted in purgatory */
+#define IPMI_WDT_DO_NOTHING	0
+#define IPMI_WDT_START		(1 << 0)
+#define IPMI_WDT_STOP		(1 << 1)
+
+#endif /* IPMI_H */
diff --git a/kexec/kexec.c b/kexec/kexec.c
index f051ca0..d9d21e8 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -49,6 +49,7 @@
 #include "kexec-sha256.h"
 #include "kexec-zlib.h"
 #include "kexec-lzma.h"
+#include "ipmi.h"
 #include <arch/options.h>
 
 unsigned long long mem_min = 0;
@@ -57,6 +58,7 @@ static unsigned long kexec_flags = 0;
 /* Flags for kexec file (fd) based syscall */
 static unsigned long kexec_file_flags = 0;
 int kexec_debug = 0;
+int opt_ipmi_wdt = IPMI_WDT_DO_NOTHING;
 int opt_ipmi_ports[2];
 
 void dbgprint_mem_range(const char *prefix, struct memory_range *mr, int nr_mr)
@@ -645,6 +647,9 @@ static void update_purgatory(struct kexec_info *info)
 		return;
 	}
 
+	elf_rel_set_symbol(&info->rhdr, "ipmi_wdt", &opt_ipmi_wdt,
+			   sizeof(opt_ipmi_wdt));
+
 	if (opt_ipmi_ports[0] != 0 && opt_ipmi_ports[1] != 0) {
 		elf_rel_set_symbol(&info->rhdr, "kcs_port_data",
 			&opt_ipmi_ports[0], sizeof(opt_ipmi_ports[0]));
@@ -980,6 +985,10 @@ void usage(void)
 	       " -s, --kexec-file-syscall Use file based syscall for kexec operation\n"
 	       "     --ipmi-kcs-ports=<port1>,<port2> Specify Data_In/Out port to port1 and\n"
 	       "                      Status/Command port to port2. Default is 0xca2,0xca3.\n"
+	       "     --ipmi-wdt-start Start BMC's watchdog timer in panic case before\n"
+	       "                      starting the second kernel\n"
+	       "     --ipmi-wdt-stop  Stop BMC's watchdog timer in panic case before starting\n"
+	       "                      the second kernel\n"
 	       " -d, --debug           Enable debugging to help spot a failure.\n"
 	       "\n"
 	       "Supported kernel file types and options: \n");
@@ -1357,6 +1366,12 @@ int main(int argc, char *argv[])
 		case OPT_KEXEC_FILE_SYSCALL:
 			/* We already parsed it. Nothing to do. */
 			break;
+		case OPT_IPMI_WDT_START:
+			opt_ipmi_wdt |= IPMI_WDT_START;
+			break;
+		case OPT_IPMI_WDT_STOP:
+			opt_ipmi_wdt |= IPMI_WDT_STOP;
+			break;
 		case OPT_IPMI_KCS_PORTS:
 			ret = sscanf(optarg, "%i,%i",
 				     &opt_ipmi_ports[0], &opt_ipmi_ports[1]);
@@ -1392,6 +1407,12 @@ int main(int argc, char *argv[])
 		    "\"--mem-max\" parameter\n");
 	}
 
+	if ((opt_ipmi_wdt & IPMI_WDT_START) &&
+	    (opt_ipmi_wdt & IPMI_WDT_STOP)) {
+		die("You can't specify both --ipmi-wdt-start and "
+		    "--ipmi-wdt-stop\n");
+	}
+
 	fileind = optind;
 	/* Reset getopt for the next pass; called in other source modules */
 	opterr = 1;
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 5eab478..6fb8fba 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -225,7 +225,9 @@ extern int file_types;
 #define OPT_LOAD_JUMP_BACK_HELPER 260
 #define OPT_ENTRY		261
 #define OPT_IPMI_KCS_PORTS	262
-#define OPT_MAX			263
+#define OPT_IPMI_WDT_START	263
+#define OPT_IPMI_WDT_STOP	264
+#define OPT_MAX			265
 #define KEXEC_OPTIONS \
 	{ "help",		0, 0, OPT_HELP }, \
 	{ "version",		0, 0, OPT_VERSION }, \
@@ -246,6 +248,8 @@ extern int file_types;
 	{ "kexec-file-syscall",	0, 0, OPT_KEXEC_FILE_SYSCALL }, \
 	{ "debug",		0, 0, OPT_DEBUG }, \
 	{ "ipmi-kcs-ports",	1, 0, OPT_IPMI_KCS_PORTS }, \
+	{ "ipmi-wdt-start",	0, 0, OPT_IPMI_WDT_START }, \
+	{ "ipmi-wdt-stop",	0, 0, OPT_IPMI_WDT_STOP }, \
 
 #define KEXEC_OPT_STR "h?vdfxyluet:ps"
 
diff --git a/purgatory/arch/x86_64/purgatory-x86_64.c b/purgatory/arch/x86_64/purgatory-x86_64.c
index c25a9c2..87433a2 100644
--- a/purgatory/arch/x86_64/purgatory-x86_64.c
+++ b/purgatory/arch/x86_64/purgatory-x86_64.c
@@ -25,6 +25,14 @@ void x86_setup_jump_back_entry(void)
 /* This function can be used to execute after the SHA256 verification. */
 void post_verification_setup_arch(void)
 {
-	if (panic_kernel)    crashdump_backup_memory();
+	if (panic_kernel) {
+		crashdump_backup_memory();
+
+		if (ipmi_wdt) {
+			ipmi_init_timeout();
+			ipmi_wdt_start_stop();
+		}
+	}
+
 	if (jump_back_entry) x86_setup_jump_back_entry();
 }
diff --git a/purgatory/include/purgatory.h b/purgatory/include/purgatory.h
index 788ce49..5cfbea1 100644
--- a/purgatory/include/purgatory.h
+++ b/purgatory/include/purgatory.h
@@ -1,11 +1,15 @@
 #ifndef PURGATORY_H
 #define PURGATORY_H
 
+extern int ipmi_wdt;
+
 void putchar(int ch);
 void sprintf(char *buffer, const char *fmt, ...)
 	__attribute__ ((format (printf, 2, 3)));
 void printf(const char *fmt, ...) __attribute__ ((format (printf, 1, 2)));
 void setup_arch(void);
 void post_verification_setup_arch(void);
+void ipmi_init_timeout(void);
+void ipmi_wdt_start_stop(void);
 
 #endif /* PURGATORY_H */
diff --git a/purgatory/ipmi.c b/purgatory/ipmi.c
index 5a73b93..780fc67 100644
--- a/purgatory/ipmi.c
+++ b/purgatory/ipmi.c
@@ -1,6 +1,7 @@
 #include <stdint.h>
 #include <sys/io.h>
 #include <purgatory.h>
+#include "../kexec/ipmi.h"
 #include "time.h"
 
 #define KCS_PORT_DATA_DEFAULT	0xca2
@@ -24,6 +25,25 @@
 
 int kcs_port_cmd = KCS_PORT_CMD_DEFAULT;
 int kcs_port_data = KCS_PORT_DATA_DEFAULT;
+int ipmi_wdt = IPMI_WDT_DO_NOTHING;
+
+/* IPMI command to start BMC watchdog timer */
+const unsigned char cmd_start_wdt[] = {
+	0x06 << 2,	/* App */
+	0x22,		/* Reset Watchdog Timer */
+};
+
+/* IPMI command to stop BMC watchdog timer */
+const unsigned char cmd_stop_wdt[] = {
+	0x06 << 2,	/* App */
+	0x24,		/* Set Watchdog Timer Command */
+	0x84,		/* Timer Use: don't log, and SMS/OS use */
+	0x00,		/* Timer Actions: no action */
+	0x00,		/* Pre-timeout interval: 0 */
+	0x10,		/* Timer Use Expiration flag clear: SMS/OS */
+	0xff,		/* Initial countdown value: 0xffff */
+	0xff,
+};
 
 /* Total timeout for IPMI operations */
 static struct timeout_info ipmi_to = {
@@ -250,7 +270,45 @@ int issue_ipmi_cmd(const unsigned char *cmd, int size)
 	return -1;
 }
 
+static int do_start_wdt(void)
+{
+	int ret;
+
+	printf("IPMI: starting watchdog timer...");
+	ret = issue_ipmi_cmd(cmd_start_wdt, sizeof(cmd_start_wdt));
+
+	if (ret == 0)
+		printf("done\n");
+	else
+		printf("failed\n");
+
+	return ret;
+}
+
+static int do_stop_wdt(void)
+{
+	int ret;
+
+	printf("IPMI: stopping watchdog timer...");
+	ret = issue_ipmi_cmd(cmd_stop_wdt, sizeof(cmd_stop_wdt));
+
+	if (ret == 0)
+		printf("done\n");
+	else
+		printf("failed\n");
+
+	return ret;
+}
+
 void ipmi_init_timeout(void)
 {
 	init_timeout(&ipmi_to, 5);
 }
+
+void ipmi_wdt_start_stop(void)
+{
+	if (ipmi_wdt & IPMI_WDT_START)
+		do_start_wdt();
+	else if (ipmi_wdt & IPMI_WDT_STOP)
+		do_stop_wdt();
+}



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
