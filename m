Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aIrGk-0004ui-Jk
 for kexec@lists.infradead.org; Tue, 12 Jan 2016 05:13:23 +0000
From: Pratyush Anand <panand@redhat.com>
Subject: [PATCH RFC V2 2/2] arm64: Pass RAM boundary and enable-dcache flag to
 purgatory
Date: Tue, 12 Jan 2016 10:42:51 +0530
Message-Id: <062475cf4f3fbe34c4165e58ebad5a370e3a3b8b.1452572612.git.panand@redhat.com>
In-Reply-To: <cover.1452572612.git.panand@redhat.com>
References: <cover.1452572612.git.panand@redhat.com>
In-Reply-To: <cover.1452572612.git.panand@redhat.com>
References: <cover.1452572612.git.panand@redhat.com>
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
Cc: geoff@infradead.org, takahiro.akashi@linaro.org, horms@verge.net.au, james.morse@arm.com, jk@ozlabs.org, scottwood@freescale.com, dyoung@redhat.com, vgoyal@redhat.com, ebiederm@xmission.com

When "enable-dcache" is passed to the kexec() command line, kexec-tools
passes this information to purgatory, which in turn enables cache during
sha-256 verification.

RAM boundary which includes all the sections is needed for creating
identity page mapping and to enable d-cache for those areas. Therefore
these informations are passed to purgatory as well.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 kexec/arch/arm64/include/arch/options.h |  6 +++++-
 kexec/arch/arm64/include/types.h        | 16 ++++++++++++++++
 kexec/arch/arm64/kexec-arm64.c          | 24 +++++++++++++++++++++++-
 purgatory/arch/arm64/entry.S            | 15 +++++++++++++++
 purgatory/arch/arm64/purgatory-arm64.c  | 10 +++++++++-
 5 files changed, 68 insertions(+), 3 deletions(-)
 create mode 100644 kexec/arch/arm64/include/types.h

diff --git a/kexec/arch/arm64/include/arch/options.h b/kexec/arch/arm64/include/arch/options.h
index fbe17de595a9..3d84bb12ee37 100644
--- a/kexec/arch/arm64/include/arch/options.h
+++ b/kexec/arch/arm64/include/arch/options.h
@@ -8,7 +8,8 @@
 #define OPT_PORT		((OPT_MAX)+4)
 #define OPT_REUSE_CMDLINE	((OPT_MAX)+5)
 #define OPT_PORT_LSR		((OPT_MAX)+6)
-#define OPT_ARCH_MAX		((OPT_MAX)+7)
+#define OPT_ENABLE_DCACHE	((OPT_MAX)+7)
+#define OPT_ARCH_MAX		((OPT_MAX)+8)
 
 #define KEXEC_ARCH_OPTIONS \
 	KEXEC_OPTIONS \
@@ -20,6 +21,7 @@
 	{ "port",         1, NULL, OPT_PORT }, \
 	{ "port-lsr",     1, NULL, OPT_PORT_LSR }, \
 	{ "ramdisk",      1, NULL, OPT_INITRD }, \
+	{ "enable-dcache", 0, NULL, OPT_ENABLE_DCACHE }, \
 	{ "reuse-cmdline", 0, NULL, OPT_REUSE_CMDLINE }, \
 
 #define KEXEC_ARCH_OPT_STR KEXEC_OPT_STR /* Only accept long arch options. */
@@ -33,6 +35,7 @@ static const char arm64_opts_usage[] __attribute__ ((unused)) =
 "     --initrd=FILE         Use FILE as the kernel initial ramdisk.\n"
 "     --port=ADDRESS        Purgatory output to port ADDRESS.\n"
 "     --port-lsr=ADDR,VAL   Purgatory output port line status address and TX Empty Bit Field.\n"
+"     --enable-dcache       Enable D-Cache in Purgatory for faster SHA verification.\n"
 "     --ramdisk=FILE        Use FILE as the kernel initial ramdisk.\n"
 "     --reuse-cmdline       Use command line arg of primary kernel.\n";
 
@@ -44,6 +47,7 @@ struct arm64_opts {
 	uint64_t port;
 	uint64_t port_lsr;
 	uint32_t port_lsr_val;
+	uint32_t enable_dcache;
 };
 
 extern struct arm64_opts arm64_opts;
diff --git a/kexec/arch/arm64/include/types.h b/kexec/arch/arm64/include/types.h
new file mode 100644
index 000000000000..08f833a6d585
--- /dev/null
+++ b/kexec/arch/arm64/include/types.h
@@ -0,0 +1,16 @@
+#ifndef _TYPES_H_
+#define _TYPES_H_
+
+#define min(x,y) ({ \
+	typeof(x) _x = (x);	\
+	typeof(y) _y = (y);	\
+	(void) (&_x == &_y);	\
+	_x < _y ? _x : _y; })
+
+#define max(x,y) ({ \
+	typeof(x) _x = (x);	\
+	typeof(y) _y = (y);	\
+	(void) (&_x == &_y);	\
+	_x > _y ? _x : _y; })
+
+#endif /* _TYPES_H_ */
diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index be9170af06e8..9b78b481f4a0 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -29,6 +29,7 @@
 #include "fs2dt.h"
 #include "kexec-syscall.h"
 #include "arch/options.h"
+#include "types.h"
 
 /* Global varables the core kexec routines expect. */
 
@@ -103,6 +104,9 @@ int arch_process_options(int argc, char **argv)
 			arm64_opts.port_lsr_val = strtoul(strtok(NULL, ","),
 							NULL, 0);
 			break;
+		case OPT_ENABLE_DCACHE:
+			arm64_opts.enable_dcache = 1;
+			break;
 		case OPT_PAGE_OFFSET:
 			arm64_opts.page_offset = strtoull(optarg, NULL, 0);
 			break;
@@ -591,12 +595,15 @@ static uint64_t read_sink(const char *command_line)
 int arm64_load_other_segments(struct kexec_info *info,
 	uint64_t kernel_entry, char *option)
 {
-	int result;
+	int result, i;
 	uint64_t dtb_base;
+	unsigned long arm64_ram_start = -1;
+	unsigned long arm64_ram_end = 0;
 	unsigned long hole_min, hole_max;
 	uint64_t purgatory_sink;
 	uint64_t purgatory_sink_lsr;
 	uint32_t purgatory_sink_lsr_val;
+	uint32_t purgatory_enable_dcache;
 	struct mem_ehdr ehdr;
 	char *initrd_buf = NULL;
 	struct dtb dtb_1 = {.name = "dtb_1"};
@@ -621,6 +628,7 @@ int arm64_load_other_segments(struct kexec_info *info,
 
 	purgatory_sink_lsr = arm64_opts.port_lsr;
 	purgatory_sink_lsr_val = arm64_opts.port_lsr_val;
+	purgatory_enable_dcache = arm64_opts.enable_dcache;
 
 	if (arm64_opts.dtb) {
 		dtb_2.buf = slurp_file(arm64_opts.dtb, &dtb_2.size);
@@ -724,11 +732,25 @@ int arm64_load_other_segments(struct kexec_info *info,
 	elf_rel_set_symbol(&info->rhdr, "arm64_sink_lsr_val",
 		&purgatory_sink_lsr_val, sizeof(purgatory_sink_lsr_val));
 
+	elf_rel_set_symbol(&info->rhdr, "arm64_enable_dcache",
+		&purgatory_enable_dcache, sizeof(purgatory_enable_dcache));
+
 	elf_rel_set_symbol(&info->rhdr, "arm64_kernel_entry", &kernel_entry,
 		sizeof(kernel_entry));
 
 	elf_rel_set_symbol(&info->rhdr, "arm64_dtb_addr", &dtb_base,
 		sizeof(dtb_base));
+	for (i = 0; i < info->nr_segments; i++) {
+		arm64_ram_start = min(arm64_ram_start,
+				(unsigned long)info->segment[i].mem);
+		arm64_ram_end = max(arm64_ram_end,
+				((unsigned long)info->segment[i].mem +
+				 info->segment[i].memsz));
+	}
+	elf_rel_set_symbol(&info->rhdr, "arm64_ram_start",
+			&arm64_ram_start, sizeof(arm64_ram_start));
+	elf_rel_set_symbol(&info->rhdr, "arm64_ram_end",
+			&arm64_ram_end, sizeof(arm64_ram_end));
 
 	return 0;
 }
diff --git a/purgatory/arch/arm64/entry.S b/purgatory/arch/arm64/entry.S
index be184e9a7469..d5563459d078 100644
--- a/purgatory/arch/arm64/entry.S
+++ b/purgatory/arch/arm64/entry.S
@@ -63,7 +63,22 @@ arm64_kexec_lite:
 	.quad	0
 size arm64_kexec_lite
 
+.globl arm64_ram_start
+arm64_ram_start:
+	.quad	0
+size arm64_ram_start
+
+.globl arm64_ram_end
+arm64_ram_end:
+	.quad	0
+size arm64_ram_end
+
 .globl arm64_sink_lsr_val
 arm64_sink_lsr_val:
 	.long	0
 size arm64_sink_lsr_val
+
+.globl arm64_enable_dcache
+arm64_enable_dcache:
+	.long	0
+size arm64_enable_dcache
diff --git a/purgatory/arch/arm64/purgatory-arm64.c b/purgatory/arch/arm64/purgatory-arm64.c
index bca802e0504d..70c01aee46e0 100644
--- a/purgatory/arch/arm64/purgatory-arm64.c
+++ b/purgatory/arch/arm64/purgatory-arm64.c
@@ -4,14 +4,18 @@
 
 #include <stdint.h>
 #include <purgatory.h>
+#include "cache.h"
 
 /* Symbols set by kexec. */
 
 extern uint32_t *arm64_sink;
 extern uint32_t *arm64_sink_lsr;
 extern uint32_t arm64_sink_lsr_val;
+extern uint32_t arm64_enable_dcache;
 extern void (*arm64_kernel_entry)(uint64_t, uint64_t, uint64_t, uint64_t);
 extern uint64_t arm64_dtb_addr;
+extern uint64_t arm64_ram_start;
+extern uint64_t arm64_ram_end;
 
 static void wait_for_xmit_complete(void)
 {
@@ -44,6 +48,8 @@ void putchar(int ch)
 
 void post_verification_setup_arch(void)
 {
+	if (arm64_enable_dcache)
+		disable_dcache(arm64_ram_start, arm64_ram_end);
 	arm64_kernel_entry(arm64_dtb_addr, 0, 0, 0);
 }
 
@@ -51,5 +57,7 @@ void setup_arch(void)
 {
 	printf("purgatory: entry=%lx\n", (unsigned long)arm64_kernel_entry);
 	printf("purgatory: dtb=%lx\n", arm64_dtb_addr);
-}
 
+	if (arm64_enable_dcache)
+		enable_dcache(arm64_ram_start, arm64_ram_end, (uint64_t)arm64_sink);
+}
-- 
2.5.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
