Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kOLKq-0003gb-Ev
 for kexec@lists.infradead.org; Fri, 02 Oct 2020 13:42:57 +0000
From: matthias.bgg@kernel.org
Subject: [PATCH v4] arm64: Add purgatory printing
Date: Fri,  2 Oct 2020 15:42:48 +0200
Message-Id: <20201002134248.21006-1-matthias.bgg@kernel.org>
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
To: kexec@lists.infradead.org, horms@verge.net.au
Cc: geoff@infradead.org, bhupesh.linux@gmail.com, Matthias Brugger <mbrugger@suse.com>, matthias.bgg@kernel.org

From: Matthias Brugger <mbrugger@suse.com>

Add option to allow purgatory printing on arm64 hardware
by passing the console name which should be used.
Based on a patch by Geoff Levand.

Cc: Geoff Levand <geoff@infradead.org>
Signed-off-by: Matthias Brugger <mbrugger@suse.com>

---

Changes in v4:
- fix snprintf error handling

Changes in v3:
- check return value of snprintf

Changes in v2:
- use sizeof(buffer)
- user serial command option instead of console
- reduce buffer to size 10
- use snprintf
- fix error handling for wrong serial console parameter
- Update help information

 kexec/arch/arm64/include/arch/options.h |  6 ++-
 kexec/arch/arm64/kexec-arm64.c          | 71 +++++++++++++++++++++++++
 purgatory/arch/arm64/purgatory-arm64.c  | 17 +++++-
 3 files changed, 92 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/arm64/include/arch/options.h b/kexec/arch/arm64/include/arch/options.h
index a17d933..8c695f3 100644
--- a/kexec/arch/arm64/include/arch/options.h
+++ b/kexec/arch/arm64/include/arch/options.h
@@ -5,7 +5,8 @@
 #define OPT_DTB			((OPT_MAX)+1)
 #define OPT_INITRD		((OPT_MAX)+2)
 #define OPT_REUSE_CMDLINE	((OPT_MAX)+3)
-#define OPT_ARCH_MAX		((OPT_MAX)+4)
+#define OPT_SERIAL		((OPT_MAX)+4)
+#define OPT_ARCH_MAX		((OPT_MAX)+5)
 
 #define KEXEC_ARCH_OPTIONS \
 	KEXEC_OPTIONS \
@@ -13,6 +14,7 @@
 	{ "command-line",  1, NULL, OPT_APPEND }, \
 	{ "dtb",           1, NULL, OPT_DTB }, \
 	{ "initrd",        1, NULL, OPT_INITRD }, \
+	{ "serial",        1, NULL, OPT_SERIAL }, \
 	{ "ramdisk",       1, NULL, OPT_INITRD }, \
 	{ "reuse-cmdline", 0, NULL, OPT_REUSE_CMDLINE }, \
 
@@ -25,6 +27,7 @@ static const char arm64_opts_usage[] __attribute__ ((unused)) =
 "     --command-line=STRING Set the kernel command line to STRING.\n"
 "     --dtb=FILE            Use FILE as the device tree blob.\n"
 "     --initrd=FILE         Use FILE as the kernel initial ramdisk.\n"
+"     --serial=STRING       Name of console used for purgatory printing. (e.g. ttyAMA0)\n"
 "     --ramdisk=FILE        Use FILE as the kernel initial ramdisk.\n"
 "     --reuse-cmdline       Use kernel command line from running system.\n";
 
@@ -32,6 +35,7 @@ struct arm64_opts {
 	const char *command_line;
 	const char *dtb;
 	const char *initrd;
+	const char *console;
 };
 
 extern struct arm64_opts arm64_opts;
diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 45ebc54..6f572ed 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -165,6 +165,8 @@ int arch_process_options(int argc, char **argv)
 			break;
 		case OPT_KEXEC_FILE_SYSCALL:
 			do_kexec_file_syscall = 1;
+		case OPT_SERIAL:
+			arm64_opts.console = optarg;
 			break;
 		default:
 			break; /* Ignore core and unknown options. */
@@ -180,12 +182,72 @@ int arch_process_options(int argc, char **argv)
 	dbgprintf("%s:%d: dtb: %s\n", __func__, __LINE__,
 		(do_kexec_file_syscall && arm64_opts.dtb ? "(ignored)" :
 							arm64_opts.dtb));
+	dbgprintf("%s:%d: console: %s\n", __func__, __LINE__,
+		arm64_opts.console);
+
 	if (do_kexec_file_syscall)
 		arm64_opts.dtb = NULL;
 
 	return 0;
 }
 
+/**
+ * find_purgatory_sink - Find a sink for purgatory output.
+ */
+
+static uint64_t find_purgatory_sink(const char *console)
+{
+	int fd, ret;
+	char device[255], mem[255];
+	struct stat sb;
+	char buffer[10];
+	uint64_t iomem = 0x0;
+
+	if (!console)
+		return 0;
+
+	ret = snprintf(device, sizeof(device), "/sys/class/tty/%s", console);
+	if (ret < 0 || ret >= sizeof(device)) {
+		fprintf(stderr, "snprintf failed: %s\n", strerror(errno));
+		return 0;
+	}
+
+	if (stat(device, &sb) || !S_ISDIR(sb.st_mode)) {
+		fprintf(stderr, "kexec: %s: No valid console found for %s\n",
+			__func__, device);
+		return 0;
+	}
+
+	ret = snprintf(mem, sizeof(mem), "%s%s", device, "/iomem_base");
+	if (ret < 0 || ret >= sizeof(mem)) {
+		fprintf(stderr, "snprintf failed: %s\n", strerror(errno));
+		return 0;
+	}
+
+	printf("console memory read from %s\n", mem);
+
+	fd = open(mem, O_RDONLY);
+	if (fd < 0) {
+		fprintf(stderr, "kexec: %s: No able to open %s\n",
+			__func__, mem);
+		return 0;
+	}
+
+	memset(buffer, '\0', sizeof(buffer));
+	ret = read(fd, buffer, sizeof(buffer));
+	if (ret < 0) {
+		fprintf(stderr, "kexec: %s: not able to read fd\n", __func__);
+		close(fd);
+		return 0;
+	}
+
+	sscanf(buffer, "%lx", &iomem);
+	printf("console memory is at %#lx\n", iomem);
+
+	close(fd);
+	return iomem;
+}
+
 /**
  * struct dtb - Info about a binary device tree.
  *
@@ -637,6 +699,7 @@ int arm64_load_other_segments(struct kexec_info *info,
 	unsigned long hole_min;
 	unsigned long hole_max;
 	unsigned long initrd_end;
+	uint64_t purgatory_sink;
 	char *initrd_buf = NULL;
 	struct dtb dtb;
 	char command_line[COMMAND_LINE_SIZE] = "";
@@ -654,6 +717,11 @@ int arm64_load_other_segments(struct kexec_info *info,
 		command_line[sizeof(command_line) - 1] = 0;
 	}
 
+	purgatory_sink = find_purgatory_sink(arm64_opts.console);
+
+	dbgprintf("%s:%d: purgatory sink: 0x%" PRIx64 "\n", __func__, __LINE__,
+		purgatory_sink);
+
 	if (arm64_opts.dtb) {
 		dtb.name = "dtb_user";
 		dtb.buf = slurp_file(arm64_opts.dtb, &dtb.size);
@@ -742,6 +810,9 @@ int arm64_load_other_segments(struct kexec_info *info,
 
 	info->entry = (void *)elf_rel_get_addr(&info->rhdr, "purgatory_start");
 
+	elf_rel_set_symbol(&info->rhdr, "arm64_sink", &purgatory_sink,
+		sizeof(purgatory_sink));
+
 	elf_rel_set_symbol(&info->rhdr, "arm64_kernel_entry", &image_base,
 		sizeof(image_base));
 
diff --git a/purgatory/arch/arm64/purgatory-arm64.c b/purgatory/arch/arm64/purgatory-arm64.c
index fe50fcf..b4d8578 100644
--- a/purgatory/arch/arm64/purgatory-arm64.c
+++ b/purgatory/arch/arm64/purgatory-arm64.c
@@ -5,15 +5,30 @@
 #include <stdint.h>
 #include <purgatory.h>
 
+/* Symbols set by kexec. */
+
+uint8_t *arm64_sink __attribute__ ((section ("data")));
+extern void (*arm64_kernel_entry)(uint64_t, uint64_t, uint64_t, uint64_t);
+extern uint64_t arm64_dtb_addr;
+
 void putchar(int ch)
 {
-	/* Nothing for now */
+	if (!arm64_sink)
+		return;
+
+	*arm64_sink = ch;
+
+	if (ch == '\n')
+		*arm64_sink = '\r';
 }
 
 void post_verification_setup_arch(void)
 {
+	printf("purgatory: booting kernel now\n");
 }
 
 void setup_arch(void)
 {
+	printf("purgatory: entry=%lx\n", (unsigned long)arm64_kernel_entry);
+	printf("purgatory: dtb=%lx\n", arm64_dtb_addr);
 }
-- 
2.28.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
