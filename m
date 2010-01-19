Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from chamillionaire.breakpoint.cc ([85.10.199.196])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1NXN3O-0006tS-QP
	for kexec@lists.infradead.org; Tue, 19 Jan 2010 23:00:16 +0000
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: [PATCH 4/5] powerpc32: add support to fixup the dtb
Date: Tue, 19 Jan 2010 23:59:44 +0100
Message-Id: <1263941985-18856-5-git-send-email-sebastian@breakpoint.cc>
In-Reply-To: <1263941985-18856-1-git-send-email-sebastian@breakpoint.cc>
References: <1263941985-18856-1-git-send-email-sebastian@breakpoint.cc>
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
To: kexec@lists.infradead.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Kumar Gala <galak@kernel.crashing.org>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

A few device nodes are dynamically determined by the bootloader (MAC address,
memory size, ..) and are not part of the device tree. The kernel command line
is also read from dtb and usually not part of the device tree.
With the libfdt it is now easy to add/replace nodes in the device tree.
The user may specify "--reuse-node=/memory/reg" to update the memory/reg
node to what ever is now. This requires the kernel to export the device
tree via the procfs in /proc/device-tree.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kexec/arch/ppc/fixup_dtb.c     |  105 ++++++++++++++++++++++++++++++++++++++++
 kexec/arch/ppc/fixup_dtb.h     |    6 ++
 kexec/arch/ppc/kexec-elf-ppc.c |   29 ++++++++++--
 3 files changed, 136 insertions(+), 4 deletions(-)
 create mode 100644 kexec/arch/ppc/fixup_dtb.c
 create mode 100644 kexec/arch/ppc/fixup_dtb.h

diff --git a/kexec/arch/ppc/fixup_dtb.c b/kexec/arch/ppc/fixup_dtb.c
new file mode 100644
index 0000000..40e9350
--- /dev/null
+++ b/kexec/arch/ppc/fixup_dtb.c
@@ -0,0 +1,105 @@
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+
+#include "../../kexec.h"
+#include <libfdt.h>
+#include "ops.h"
+#include "page.h"
+#include "fixup_dtb.h"
+
+const char proc_dts[] = "/proc/device-tree";
+
+static void fixup_nodes(char *nodes[])
+{
+	int index = 0;
+	char *fname;
+	char *prop_name;
+	char *node_name;
+	void *node;
+	int len;
+	char *content;
+	off_t content_size;
+	int ret;
+
+	while (nodes[index]) {
+
+		len = asprintf(&fname, "%s%s", proc_dts, nodes[index]);
+		if (len < 0)
+			fatal("asprintf() failed\n");
+
+		content = slurp_file(fname, &content_size);
+		if (!content) {
+			fprintf(stderr, "Can't open %s: %s\n",
+					fname, strerror(errno));
+			exit(1);
+		}
+
+		prop_name = fname + len;
+		while (*prop_name != '/')
+			prop_name--;
+
+		*prop_name = '\0';
+		prop_name++;
+
+		node_name = fname + sizeof(proc_dts) - 1;
+
+		node = finddevice(node_name);
+		if (!node)
+			node = create_node(NULL, node_name + 1);
+
+		ret = setprop(node, prop_name, content, content_size);
+		if (ret < 0)
+			fatal("setprop of %s/%s size: %ld failed: %s\n",
+					node_name, prop_name, content_size,
+					fdt_strerror(ret));
+
+		free(content);
+		free(fname);
+		index++;
+	};
+}
+
+/*
+ * command line priority:
+ * - use the supplied command line
+ * - if none available use the command line from .dtb
+ * - if not available use the current command line
+ */
+static void fixup_cmdline(const char *cmdline)
+{
+	void *chosen;
+	char *fixup_cmd_node[] = {
+		"/chosen/bootargs",
+		NULL,
+	};
+
+	chosen = finddevice("/chosen");
+
+	if (!cmdline) {
+		if (!chosen)
+			fixup_nodes(fixup_cmd_node);
+	} else {
+		if (!chosen)
+			chosen = create_node(NULL, "chosen");
+		setprop_str(chosen, "bootargs", cmdline);
+	}
+	return;
+}
+
+char *fixup_dtb_nodes(char *blob_buf, off_t *blob_size, char *nodes[], char *cmdline)
+{
+	fdt_init(blob_buf);
+
+	fixup_nodes(nodes);
+	fixup_cmdline(cmdline);
+
+	blob_buf = (char *)dt_ops.finalize();
+	*blob_size = fdt_totalsize(blob_buf);
+	return blob_buf;
+}
diff --git a/kexec/arch/ppc/fixup_dtb.h b/kexec/arch/ppc/fixup_dtb.h
new file mode 100644
index 0000000..0ff981e
--- /dev/null
+++ b/kexec/arch/ppc/fixup_dtb.h
@@ -0,0 +1,6 @@
+#ifndef __FIXUP_DTB_H
+#define __FIXUP_DTB_H
+
+char *fixup_dtb_nodes(char *blob_buf, off_t *blob_size, char *nodes[], char *cmdline);
+
+#endif
diff --git a/kexec/arch/ppc/kexec-elf-ppc.c b/kexec/arch/ppc/kexec-elf-ppc.c
index 03b8a94..a54a5d5 100644
--- a/kexec/arch/ppc/kexec-elf-ppc.c
+++ b/kexec/arch/ppc/kexec-elf-ppc.c
@@ -25,6 +25,7 @@
 #include <arch/options.h>
 
 #include "config.h"
+#include "fixup_dtb.h"
 
 static const int probe_debug = 0;
 
@@ -115,12 +116,14 @@ static void gamecube_hack_addresses(struct mem_ehdr *ehdr)
 #define OPT_APPEND	(OPT_ARCH_MAX+0)
 #define OPT_GAMECUBE	(OPT_ARCH_MAX+1)
 #define OPT_DTB		(OPT_ARCH_MAX+2)
+#define OPT_NODES	(OPT_ARCH_MAX+3)
 static const struct option options[] = {
 	KEXEC_ARCH_OPTIONS
 	{"command-line", 1, 0, OPT_APPEND},
 	{"append",       1, 0, OPT_APPEND},
 	{"gamecube",     1, 0, OPT_GAMECUBE},
 	{"dtb",     1, 0, OPT_DTB},
+	{"reuse-node",     1, 0, OPT_NODES},
 	{0, 0, 0, 0},
 };
 static const char short_options[] = KEXEC_ARCH_OPT_STR "d";
@@ -132,7 +135,9 @@ void elf_ppc_usage(void)
 	     "    --append=STRING       Set the kernel command line to STRING.\n"
 	     "    --gamecube=1|0        Enable/disable support for ELFs with changed\n"
 	     "                          addresses suitable for the GameCube.\n"
-	     "     --dtb=<filename> Specify device tree blob file.\n"
+	     "     --dtb=<filename>     Specify device tree blob file.\n"
+	     "     --reuse-node=node    Specify nodes which should be taken from /proc/device-tree.\n"
+	     "                          Can be set multiple times.\n"
 	     );
 }
 
@@ -157,6 +162,9 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 	int target_is_gamecube = 0;
 	unsigned int addr;
 	unsigned long dtb_addr;
+#define FIXUP_ENTRYS	(20)
+	char *fixup_nodes[FIXUP_ENTRYS + 1];
+	int cur_fixup = 0;
 #endif
 	int opt;
 
@@ -182,13 +190,25 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 		case OPT_DTB:
 			dtb = optarg;
 			break;
+
+		case OPT_NODES:
+			if (cur_fixup >= FIXUP_ENTRYS) {
+				fprintf(stderr, "The number of entries for the fixup is too large\n");
+				exit(1);
+			}
+			fixup_nodes[cur_fixup] = optarg;
+			cur_fixup++;
+			break;
 		}
 	}
+
 	command_line_len = 0;
 	if (command_line) {
 		command_line_len = strlen(command_line) + 1;
 	}
 
+	fixup_nodes[cur_fixup] = NULL;
+
 	/* Parse the Elf file */
 	result = build_elf_exec_info(buf, len, &ehdr, 0);
 	if (result < 0) {
@@ -247,12 +267,13 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 
 		/* Grab device tree from buffer */
 		blob_buf = slurp_file(dtb, &blob_size);
+		if (!blob_buf || !blob_size)
+			die("Device tree seems to be an empty file.\n");
+		blob_buf = fixup_dtb_nodes(blob_buf, &blob_size, fixup_nodes, command_line);
 		dtb_addr = add_buffer(info, blob_buf, blob_size, blob_size, 0, 0,
 				KERNEL_ACCESS_TOP, -1);
-		if (command_line)
-			die("Don't consider command line because dtb is supplied\n");
 	} else {
-		die("Missing dtb.\n");
+		dtb_addr = 0;
 	}
 
 	/* set various variables for the purgatory */
-- 
1.6.5.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
