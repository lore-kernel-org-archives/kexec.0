Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YpG1x-0005WR-Vp
 for kexec@lists.infradead.org; Mon, 04 May 2015 13:03:30 +0000
From: Pratyush Anand <panand@redhat.com>
Subject: [PATCH RFC 2/3] arm64: Pass RAM boundary to purgatory
Date: Mon,  4 May 2015 18:32:50 +0530
Message-Id: <04a2b7bb55bfee0495cc39796846adf8d6a313bc.1430742915.git.panand@redhat.com>
In-Reply-To: <cover.1430742915.git.panand@redhat.com>
References: <cover.1430742915.git.panand@redhat.com>
In-Reply-To: <cover.1430742915.git.panand@redhat.com>
References: <cover.1430742915.git.panand@redhat.com>
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
To: geoff@infradead.org
Cc: Pratyush Anand <panand@redhat.com>, takahiro.akashi@linaro.org, kexec@lists.infradead.org

RAM boundary which includes all the sections is needed for creating
identity page mapping and to enable d-cache for those areas.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 kexec/arch/arm64/include/types.h | 16 ++++++++++++++++
 kexec/arch/arm64/kexec-arm64.c   | 16 +++++++++++++++-
 purgatory/arch/arm64/entry.S     | 10 ++++++++++
 3 files changed, 41 insertions(+), 1 deletion(-)
 create mode 100644 kexec/arch/arm64/include/types.h

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
index 12c589f8001c..8ce4a61fc9c2 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -28,6 +28,7 @@
 #include "fs2dt.h"
 #include "kexec-syscall.h"
 #include "arch/options.h"
+#include "types.h"
 
 /* Global varables the core kexec routines expect. */
 
@@ -588,9 +589,11 @@ static uint64_t read_sink(const char *command_line)
 int arm64_load_other_segments(struct kexec_info *info,
 	unsigned long kernel_entry, char *option)
 {
-	int result;
+	int result, i;
 	struct mem_ehdr ehdr;
 	unsigned long dtb_base;
+	unsigned long arm64_ram_start = -1;
+	unsigned long arm64_ram_end = 0;
 	unsigned long hole_min, hole_max;
 	char *initrd_buf = NULL;
 	uint64_t purgatory_sink;
@@ -720,6 +723,17 @@ int arm64_load_other_segments(struct kexec_info *info,
 
 		elf_rel_set_symbol(&info->rhdr, "arm64_dtb_addr", &dtb_base,
 				sizeof(dtb_base));
+		for (i = 0; i < info->nr_segments; i++) {
+			arm64_ram_start = min(arm64_ram_start,
+					(unsigned long)info->segment[i].mem);
+			arm64_ram_end = max(arm64_ram_end,
+				((unsigned long)info->segment[i].mem + 
+				info->segment[i].memsz));
+		}
+		elf_rel_set_symbol(&info->rhdr, "arm64_ram_start",
+				&arm64_ram_start, sizeof(arm64_ram_start));
+		elf_rel_set_symbol(&info->rhdr, "arm64_ram_end",
+				&arm64_ram_end, sizeof(arm64_ram_end));
 	}
 
 	return 0;
diff --git a/purgatory/arch/arm64/entry.S b/purgatory/arch/arm64/entry.S
index 140e91d87ab1..0713ccdec4ad 100644
--- a/purgatory/arch/arm64/entry.S
+++ b/purgatory/arch/arm64/entry.S
@@ -52,3 +52,13 @@ size arm64_kernel_entry
 arm64_dtb_addr:
 	.quad	0
 size arm64_dtb_addr
+
+.globl arm64_ram_start
+arm64_ram_start:
+	.quad	0
+size arm64_ram_start
+
+.globl arm64_ram_end
+arm64_ram_end:
+	.quad	0
+size arm64_ram_end
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
