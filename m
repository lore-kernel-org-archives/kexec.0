Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail7.hitachi.co.jp ([133.145.228.42])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aXpAn-0001pe-Gi
 for kexec@lists.infradead.org; Mon, 22 Feb 2016 12:01:14 +0000
Subject: [RFC v2 PATCH 3/7] purgatory/ipmi: Support IPMI KCS interface
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Date: Mon, 22 Feb 2016 20:56:23 +0900
Message-ID: <20160222115623.4231.23153.stgit@softrs>
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

This patch adds an interface to BMC for purgatory.  While IPMI defines
various interfaces to BMC, this patch supports only KCS (Keyboard
Style Controller) interface which is implemented in the most of recent
enterprise class servers with BMC.

Normally, I/O port 0xca2 and 0xca3 are used for KCS interface, but it
varies depending on servers.  In this case, you can specify the I/O
ports by --ipmi-kcs-ports option.

To guarantee that the second kernel starts to boot in fixed seconds,
polling-based timeout check is performed.  Timeout counting starts
when calling ipmi_init_timeout(), and it expires after 5 seconds by
default.

Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
---
 kexec/kexec.c      |   22 ++++
 kexec/kexec.h      |    4 +
 purgatory/Makefile |    1 
 purgatory/ipmi.c   |  256 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 282 insertions(+), 1 deletion(-)
 create mode 100644 purgatory/ipmi.c

diff --git a/kexec/kexec.c b/kexec/kexec.c
index f0bd527..f051ca0 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -57,6 +57,7 @@ static unsigned long kexec_flags = 0;
 /* Flags for kexec file (fd) based syscall */
 static unsigned long kexec_file_flags = 0;
 int kexec_debug = 0;
+int opt_ipmi_ports[2];
 
 void dbgprint_mem_range(const char *prefix, struct memory_range *mr, int nr_mr)
 {
@@ -643,6 +644,14 @@ static void update_purgatory(struct kexec_info *info)
 	if (!info->rhdr.e_shdr) {
 		return;
 	}
+
+	if (opt_ipmi_ports[0] != 0 && opt_ipmi_ports[1] != 0) {
+		elf_rel_set_symbol(&info->rhdr, "kcs_port_data",
+			&opt_ipmi_ports[0], sizeof(opt_ipmi_ports[0]));
+		elf_rel_set_symbol(&info->rhdr, "kcs_port_cmd",
+			&opt_ipmi_ports[1], sizeof(opt_ipmi_ports[1]));
+	}
+
 	arch_update_purgatory(info);
 	memset(region, 0, sizeof(region));
 	sha256_starts(&ctx);
@@ -969,6 +978,8 @@ void usage(void)
 	       "                      preserve context)\n"
 	       "                      to original kernel.\n"
 	       " -s, --kexec-file-syscall Use file based syscall for kexec operation\n"
+	       "     --ipmi-kcs-ports=<port1>,<port2> Specify Data_In/Out port to port1 and\n"
+	       "                      Status/Command port to port2. Default is 0xca2,0xca3.\n"
 	       " -d, --debug           Enable debugging to help spot a failure.\n"
 	       "\n"
 	       "Supported kernel file types and options: \n");
@@ -1215,6 +1226,7 @@ int main(int argc, char *argv[])
 		{ 0, 0, 0, 0},
 	};
 	static const char short_options[] = KEXEC_ALL_OPT_STR;
+	int ret;
 
 	/*
 	 * First check if --use-kexec-file-syscall is set. That changes lot of
@@ -1345,6 +1357,16 @@ int main(int argc, char *argv[])
 		case OPT_KEXEC_FILE_SYSCALL:
 			/* We already parsed it. Nothing to do. */
 			break;
+		case OPT_IPMI_KCS_PORTS:
+			ret = sscanf(optarg, "%i,%i",
+				     &opt_ipmi_ports[0], &opt_ipmi_ports[1]);
+			if (ret != 2) {
+				fprintf(stderr, "Bad option value in "
+					"--ipmi-kcs-ports=%s\n", optarg);
+				usage();
+				return 1;
+			}
+			break;
 		default:
 			break;
 		}
diff --git a/kexec/kexec.h b/kexec/kexec.h
index c02ac8f..5eab478 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -224,7 +224,8 @@ extern int file_types;
 #define OPT_LOAD_PRESERVE_CONTEXT 259
 #define OPT_LOAD_JUMP_BACK_HELPER 260
 #define OPT_ENTRY		261
-#define OPT_MAX			262
+#define OPT_IPMI_KCS_PORTS	262
+#define OPT_MAX			263
 #define KEXEC_OPTIONS \
 	{ "help",		0, 0, OPT_HELP }, \
 	{ "version",		0, 0, OPT_VERSION }, \
@@ -244,6 +245,7 @@ extern int file_types;
 	{ "reuseinitrd",	0, 0, OPT_REUSE_INITRD }, \
 	{ "kexec-file-syscall",	0, 0, OPT_KEXEC_FILE_SYSCALL }, \
 	{ "debug",		0, 0, OPT_DEBUG }, \
+	{ "ipmi-kcs-ports",	1, 0, OPT_IPMI_KCS_PORTS }, \
 
 #define KEXEC_OPT_STR "h?vdfxyluet:ps"
 
diff --git a/purgatory/Makefile b/purgatory/Makefile
index 4a30b94..80caeab 100644
--- a/purgatory/Makefile
+++ b/purgatory/Makefile
@@ -9,6 +9,7 @@
 
 PURGATORY = purgatory/purgatory.ro
 PURGATORY_SRCS =
+PURGATORY_SRCS += purgatory/ipmi.c
 PURGATORY_SRCS += purgatory/purgatory.c
 PURGATORY_SRCS += purgatory/printf.c
 PURGATORY_SRCS += purgatory/string.c
diff --git a/purgatory/ipmi.c b/purgatory/ipmi.c
new file mode 100644
index 0000000..5a73b93
--- /dev/null
+++ b/purgatory/ipmi.c
@@ -0,0 +1,256 @@
+#include <stdint.h>
+#include <sys/io.h>
+#include <purgatory.h>
+#include "time.h"
+
+#define KCS_PORT_DATA_DEFAULT	0xca2
+#define KCS_PORT_CMD_DEFAULT	0xca3
+#define KCS_PORT_DATA		(kcs_port_data)
+#define KCS_PORT_STATUS		(kcs_port_cmd)
+#define KCS_PORT_CMD		(kcs_port_cmd)
+
+#define KCS_STATUS_OBF		0x1
+#define KCS_STATUS_IBF		0x2
+
+#define KCS_CMD_WRITE_START	0x61
+#define KCS_CMD_WRITE_END	0x62
+#define KCS_CMD_READ		0x68
+
+#define GET_STATUS_STATE(status) (((status) >> 6) & 0x03)
+#define KCS_IDLE_STATE	0x0
+#define KCS_READ_STATE	0x1
+#define KCS_WRITE_STATE	0x2
+#define KCS_ERROR_STATE	0x3
+
+int kcs_port_cmd = KCS_PORT_CMD_DEFAULT;
+int kcs_port_data = KCS_PORT_DATA_DEFAULT;
+
+/* Total timeout for IPMI operations */
+static struct timeout_info ipmi_to = {
+	.end = INT64_MAX, /* never time out */
+};
+
+static inline unsigned char read_status(void)
+{
+	return inb(KCS_PORT_STATUS);
+}
+
+unsigned char wait_out(void)
+{
+	unsigned char status;
+	static int count = 0;
+
+	do {
+		count++;
+		if (count % 1024 == 0)
+			EXIT_ON_TIMEOUT(&ipmi_to, 1);
+
+		status = read_status();
+	} while ((status & KCS_STATUS_OBF) == 0);
+
+	return status;
+
+timed_out:
+	return 0xff;
+}
+
+unsigned char wait_in(void)
+{
+	unsigned char status;
+	static int count = 0;
+
+	do {
+		count++;
+		if (count % 1024 == 0)
+			EXIT_ON_TIMEOUT(&ipmi_to, 1);
+
+		status = read_status();
+	} while (status & KCS_STATUS_IBF);
+
+	return status;
+
+timed_out:
+	return 0xff;
+}
+
+unsigned char read_data(void)
+{
+	wait_out();
+	EXIT_ON_TIMEOUT(&ipmi_to, 0);
+
+	return inb(KCS_PORT_DATA);
+
+timed_out:
+	return 0xff;
+}
+
+void clear_obf(void)
+{
+	if (inb(KCS_PORT_STATUS) & KCS_STATUS_OBF)
+		read_data();
+}
+
+unsigned char write_data(unsigned char byte)
+{
+	clear_obf();
+	outb(byte, KCS_PORT_DATA);
+	return wait_in();
+}
+
+unsigned char write_cmd(unsigned char byte)
+{
+	clear_obf();
+	outb(byte, KCS_PORT_CMD);
+	return wait_in();
+}
+
+/*
+ * Issue a given IPMI command via KCS I/F.
+ *
+ * Return 0 on success, otherwise -1.
+ */
+int write_ipmi_cmd(const unsigned char *cmd, int size)
+{
+	unsigned char status;
+	int i;
+
+	wait_in();
+	EXIT_ON_TIMEOUT(&ipmi_to, 0);
+
+	status = write_cmd(KCS_CMD_WRITE_START);
+	EXIT_ON_TIMEOUT(&ipmi_to, 0);
+
+	if (GET_STATUS_STATE(status) != KCS_WRITE_STATE)
+		return -1;
+
+	for (i = 0; i < size - 1; i++) {
+		status = write_data(cmd[i]);
+		EXIT_ON_TIMEOUT(&ipmi_to, 0);
+
+		if (GET_STATUS_STATE(status) != KCS_WRITE_STATE)
+			return -1;
+	}
+
+	/* last write */
+	status = write_cmd(KCS_CMD_WRITE_END);
+	EXIT_ON_TIMEOUT(&ipmi_to, 0);
+
+	if (GET_STATUS_STATE(status) != KCS_WRITE_STATE)
+		return -1;
+
+	write_data(cmd[i]);
+	EXIT_ON_TIMEOUT(&ipmi_to, 0);
+
+	return 0;
+
+timed_out:
+	return -1;
+}
+
+/*
+ * Read result bytes for the previously issued IPMI command.
+ *
+ * Return the completion code, which is 0 on success.  Otherwise, return
+ * non-zero value.
+ */
+unsigned char read_result(void)
+{
+	unsigned char state;
+	unsigned char data[4] = { 0 };
+	int count = 0;
+
+	while (1) {
+		state = GET_STATUS_STATE(wait_in());
+		EXIT_ON_TIMEOUT(&ipmi_to, 0);
+
+		if (state == KCS_READ_STATE) {
+			data[count] = read_data();
+			EXIT_ON_TIMEOUT(&ipmi_to, 0);
+
+			outb(KCS_CMD_READ, KCS_PORT_DATA);
+		} else if (state == KCS_IDLE_STATE) {
+			data[count] = read_data();
+			EXIT_ON_TIMEOUT(&ipmi_to, 0);
+
+			break;
+		} else {
+			/*
+			 * Error! Set 0xff (unspecified error) as the
+			 * completion code.
+			 */
+			data[2] = 0xff;
+			break;
+		}
+
+		/*
+		 * We are interested only in the completion code in the
+		 * 3rd byte. Skip the following bytes.
+		 */
+		if (count < 3)
+			count++;
+	}
+
+	return data[2]; /* Return completion code */
+
+timed_out:
+	return 0xff;
+}
+
+/*
+ * Issue one IPMI command and check the result.
+ *
+ * Return 0 on success, otherwise -1.
+ */
+int issue_ipmi_cmd(const unsigned char *cmd, int size)
+{
+	int i, ret;
+	unsigned char comp_code;
+
+	/*
+	 * Try 3 times at most on error.
+	 *
+	 * WRITE_START KCS command issued by write_ipmi_cmd() at the beginning
+	 * aborts the ongoing IPMI command and starts new one.  So, it's no
+	 * problem even if the first kernel was processing IPMI command via
+	 * KCS I/F.
+	 *
+	 * However, WRITE_START can fail on some buggy BMC depending on its
+	 * KCS I/F state and get ERROR_STATE form the status register.  In
+	 * this situation, we can recover it from the error state by issuing
+	 * WRITE_START command.  So, just retrying is sufficient.
+	 */
+	for (i = 0; i < 3; i++) {
+		ret = write_ipmi_cmd(cmd, size);
+		EXIT_ON_TIMEOUT(&ipmi_to, 0);
+
+		if (ret < 0)
+			/*
+			 * We detected ERROR_STATE or unexpected state.  In
+			 * this case, IPMI specification instructs us to issue
+			 * GET_STATUS command to request the reason of the
+			 * error or simply retry the command.
+			 *
+			 * Since we are not interested in the reason, simply
+			 * retry here.  Just for the record, the process to
+			 * obtain the reason of errors doesn't work properly
+			 * on some major BMCs.
+			 */
+			continue;
+
+		comp_code = read_result();
+		EXIT_ON_TIMEOUT(&ipmi_to, 0);
+
+		if (comp_code == 0)
+			break; /* succeeded */
+	}
+
+	return (i < 3) ? 0 : -1;
+
+timed_out:
+	return -1;
+}
+
+void ipmi_init_timeout(void)
+{
+	init_timeout(&ipmi_to, 5);
+}



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
