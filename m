Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from chamillionaire.breakpoint.cc ([85.10.199.196])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Kx7Ry-0002bk-5U
	for kexec@lists.infradead.org; Mon, 03 Nov 2008 21:59:06 +0000
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: [PATCH 4/4] powerpc32: add support to fixup the dtb
Date: Mon,  3 Nov 2008 22:59:03 +0100
Message-Id: <1225749543-32683-5-git-send-email-sebastian@breakpoint.cc>
In-Reply-To: <1225749543-32683-1-git-send-email-sebastian@breakpoint.cc>
References: <1225749543-32683-1-git-send-email-sebastian@breakpoint.cc>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
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
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

A few device nodes are dynamically determined by the bootloader (MAC address,
memory size, ..) and are not part of the device tree. The kernel command line
is also read from dtb and usually not part of the device tree.
With the libfdt it is now easy to add/replace nodes in the device tree.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kexec/arch/ppc/fixup_dtb.c     |  105 ++++++++++++++++++++++++++++++++++++++++
 kexec/arch/ppc/fixup_dtb.h     |    6 ++
 kexec/arch/ppc/kexec-elf-ppc.c |   38 +++++++++++++--
 3 files changed, 145 insertions(+), 4 deletions(-)
 create mode 100644 kexec/arch/ppc/fixup_dtb.c
 create mode 100644 kexec/arch/ppc/fixup_dtb.h

diff --git a/kexec/arch/ppc/fixup_dtb.c b/kexec/arch/ppc/fixup_dtb.c
new file mode 100644
index 0000000..24e7e82
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
+static void fixup_cmdline(const char *cmdline)
+{
+	void *chosen;
+
+	if (!cmdline)
+		return;
+
+	chosen = finddevice("/chosen");
+	if (!chosen)
+		chosen = create_node(NULL, "chosen");
+
+	setprop_str(chosen, "bootargs", cmdline);
+}
+
+char *fixup_dtb_nodes(char *blob_buf, off_t *blob_size, char *nodes[], char *cmdline)
+{
+
+	fdt_init(blob_buf);
+
+	fixup_nodes(nodes);
+	fixup_cmdline(cmdline);
+
+	blob_buf = (char *)dt_ops.finalize();
+	*blob_size = fdt_totalsize(blob_buf);
+#if 0
+	{
+		int fd;
+
+		fd = open("out.dtb", O_WRONLY | O_CREAT, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+		if (fd < 0)
+			fatal("Can't create file: %s\n", strerror(errno));
+
+		write(fd, blob_buf, *blob_size);
+		close(fd);
+	}
+#endif
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
index d58c4b5..ae72a8f 100644
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
 
@@ -182,13 +190,34 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
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
 
+	if (!command_line) {
+		if (cur_fixup >= FIXUP_ENTRYS) {
+			fprintf(stderr, "Need one fixup entry for command line\n");
+			exit(1);
+		}
+		fixup_nodes[cur_fixup] = "/chosen/bootargs";
+		cur_fixup++;
+	}
+
+	fixup_nodes[cur_fixup] = NULL;
+
 	/* Parse the Elf file */
 	result = build_elf_exec_info(buf, len, &ehdr, 0);
 	if (result < 0) {
@@ -247,12 +276,13 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 
 		/* Grab device tree from buffer */
 		blob_buf = slurp_file(dtb, &blob_size);
+		if (!blob_buf || !blob_size)
+			die("Device tree seems to be an empty file.\n");
+		blob_buf = fixup_dtb_nodes(blob_buf, &blob_size, fixup_nodes, command_line);
 		dtb_addr = add_buffer(info, blob_buf, blob_size, blob_size, 0, 0,
 				elf_max_addr(&ehdr), -1);
-		if (command_line)
-			die("Don't consider command line because dtb is supplied\n");
 	} else {
-		die("Missing dtb.\n");
+		dtb_addr = 0;
 	}
 
 	/* set various variables for the purgatory */
-- 
1.6.0.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
