Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail7.hitachi.co.jp ([133.145.228.42])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aXpAn-0001pg-H0
 for kexec@lists.infradead.org; Mon, 22 Feb 2016 12:01:10 +0000
Subject: [RFC v2 PATCH 5/7] purgatory/ipmi: Add an option for purgatory to
 handle panic event with IPMI
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Date: Mon, 22 Feb 2016 20:56:27 +0900
Message-ID: <20160222115627.4231.44196.stgit@softrs>
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

This patch adds --ipmi-handle-panic option which enables panic event
handling in purgatory.  At this point, if you specify the option, an
"OS Stop" event is generated in the panic case.  As the result, BMC
may log the event to SEL.  Furthermore, you can make the BMC issue an
SNMP trap by configuring PEF alerting of the BMC in advance.

In the future, other actions to inform or record the panic event will
be added.

Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
---
 kexec/kexec.c                            |    8 ++++++++
 kexec/kexec.h                            |    4 +++-
 purgatory/arch/x86_64/purgatory-x86_64.c |   13 +++++++++++--
 purgatory/include/purgatory.h            |    4 ++++
 purgatory/ipmi.c                         |   23 +++++++++++++++++++++++
 5 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index d9d21e8..62e228d 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -59,6 +59,7 @@ static unsigned long kexec_flags = 0;
 static unsigned long kexec_file_flags = 0;
 int kexec_debug = 0;
 int opt_ipmi_wdt = IPMI_WDT_DO_NOTHING;
+uint8_t opt_ipmi_handle_panic = 0;
 int opt_ipmi_ports[2];
 
 void dbgprint_mem_range(const char *prefix, struct memory_range *mr, int nr_mr)
@@ -649,6 +650,9 @@ static void update_purgatory(struct kexec_info *info)
 
 	elf_rel_set_symbol(&info->rhdr, "ipmi_wdt", &opt_ipmi_wdt,
 			   sizeof(opt_ipmi_wdt));
+	elf_rel_set_symbol(&info->rhdr, "ipmi_handle_panic",
+			   &opt_ipmi_handle_panic,
+			   sizeof(opt_ipmi_handle_panic));
 
 	if (opt_ipmi_ports[0] != 0 && opt_ipmi_ports[1] != 0) {
 		elf_rel_set_symbol(&info->rhdr, "kcs_port_data",
@@ -989,6 +993,7 @@ void usage(void)
 	       "                      starting the second kernel\n"
 	       "     --ipmi-wdt-stop  Stop BMC's watchdog timer in panic case before starting\n"
 	       "                      the second kernel\n"
+	       "     --ipmi-handle-panic Inform/record the panic event via IPMI\n"
 	       " -d, --debug           Enable debugging to help spot a failure.\n"
 	       "\n"
 	       "Supported kernel file types and options: \n");
@@ -1382,6 +1387,9 @@ int main(int argc, char *argv[])
 				return 1;
 			}
 			break;
+		case OPT_IPMI_HANDLE_PANIC:
+			opt_ipmi_handle_panic = 1;
+			break;
 		default:
 			break;
 		}
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 6fb8fba..2faab91 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -227,7 +227,8 @@ extern int file_types;
 #define OPT_IPMI_KCS_PORTS	262
 #define OPT_IPMI_WDT_START	263
 #define OPT_IPMI_WDT_STOP	264
-#define OPT_MAX			265
+#define OPT_IPMI_HANDLE_PANIC	265
+#define OPT_MAX			266
 #define KEXEC_OPTIONS \
 	{ "help",		0, 0, OPT_HELP }, \
 	{ "version",		0, 0, OPT_VERSION }, \
@@ -250,6 +251,7 @@ extern int file_types;
 	{ "ipmi-kcs-ports",	1, 0, OPT_IPMI_KCS_PORTS }, \
 	{ "ipmi-wdt-start",	0, 0, OPT_IPMI_WDT_START }, \
 	{ "ipmi-wdt-stop",	0, 0, OPT_IPMI_WDT_STOP }, \
+	{ "ipmi-handle-panic",	0, 0, OPT_IPMI_HANDLE_PANIC }, \
 
 #define KEXEC_OPT_STR "h?vdfxyluet:ps"
 
diff --git a/purgatory/arch/x86_64/purgatory-x86_64.c b/purgatory/arch/x86_64/purgatory-x86_64.c
index 87433a2..fb238a3 100644
--- a/purgatory/arch/x86_64/purgatory-x86_64.c
+++ b/purgatory/arch/x86_64/purgatory-x86_64.c
@@ -28,10 +28,19 @@ void post_verification_setup_arch(void)
 	if (panic_kernel) {
 		crashdump_backup_memory();
 
-		if (ipmi_wdt) {
+		if (ipmi_handle_panic || ipmi_wdt)
 			ipmi_init_timeout();
+
+		/*
+		 * You can make the BMC send an SNMP trap here by configuring
+		 * PEF alerting beforehand.  Do this first to inform the
+		 * panic event ASAP.
+		 */
+		if (ipmi_handle_panic)
+			ipmi_send_panic_event();
+
+		if (ipmi_wdt)
 			ipmi_wdt_start_stop();
-		}
 	}
 
 	if (jump_back_entry) x86_setup_jump_back_entry();
diff --git a/purgatory/include/purgatory.h b/purgatory/include/purgatory.h
index 5cfbea1..7afa890 100644
--- a/purgatory/include/purgatory.h
+++ b/purgatory/include/purgatory.h
@@ -1,7 +1,10 @@
 #ifndef PURGATORY_H
 #define PURGATORY_H
 
+#include <stdint.h>
+
 extern int ipmi_wdt;
+extern uint8_t ipmi_handle_panic;
 
 void putchar(int ch);
 void sprintf(char *buffer, const char *fmt, ...)
@@ -11,5 +14,6 @@ void setup_arch(void);
 void post_verification_setup_arch(void);
 void ipmi_init_timeout(void);
 void ipmi_wdt_start_stop(void);
+void ipmi_send_panic_event(void);
 
 #endif /* PURGATORY_H */
diff --git a/purgatory/ipmi.c b/purgatory/ipmi.c
index 780fc67..59c0366 100644
--- a/purgatory/ipmi.c
+++ b/purgatory/ipmi.c
@@ -26,6 +26,7 @@
 int kcs_port_cmd = KCS_PORT_CMD_DEFAULT;
 int kcs_port_data = KCS_PORT_DATA_DEFAULT;
 int ipmi_wdt = IPMI_WDT_DO_NOTHING;
+uint8_t ipmi_handle_panic = 0;
 
 /* IPMI command to start BMC watchdog timer */
 const unsigned char cmd_start_wdt[] = {
@@ -45,6 +46,23 @@ const unsigned char cmd_stop_wdt[] = {
 	0xff,
 };
 
+/*
+ * IPMI command to generate an event to inform a kernel panic happend.
+ * All fixed parameters are same as that of IPMI driver for Linux.
+ */
+const unsigned char cmd_panic_event[] = {
+	0x04 << 2,	/* Sensor/Event */
+	0x02,		/* Platform Event Command */
+	0x41,		/* Generator ID: System Management Software */
+	0x03,		/* Event Message Rev.: comply with IPMI 1.0 */
+	0x20,		/* Sensor Type: OS Stop */
+	0x00,		/* Sensor # */
+	0x6f,		/* Event Type: Sensor specific */
+	0xa1,		/* Data 1: Run-time Stop. Data 2 & 3 are OEM defined */
+	0x00,		/* Data 2 */
+	0x00,		/* Data 3 */
+};
+
 /* Total timeout for IPMI operations */
 static struct timeout_info ipmi_to = {
 	.end = INT64_MAX, /* never time out */
@@ -312,3 +330,8 @@ void ipmi_wdt_start_stop(void)
 	else if (ipmi_wdt & IPMI_WDT_STOP)
 		do_stop_wdt();
 }
+
+void ipmi_send_panic_event(void)
+{
+	issue_ipmi_cmd(cmd_panic_event, sizeof(cmd_panic_event));
+}



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
