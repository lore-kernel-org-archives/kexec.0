Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fBDte-0006Mg-Qq
 for kexec@lists.infradead.org; Wed, 25 Apr 2018 06:27:21 +0000
Received: by mail-pg0-x242.google.com with SMTP id b9so12603210pgf.6
 for <kexec@lists.infradead.org>; Tue, 24 Apr 2018 23:27:08 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v9 04/11] arm64: kexec_file: allocate memory walking through
 memblock list
Date: Wed, 25 Apr 2018 15:26:22 +0900
Message-Id: <20180425062629.29404-5-takahiro.akashi@linaro.org>
In-Reply-To: <20180425062629.29404-1-takahiro.akashi@linaro.org>
References: <20180425062629.29404-1-takahiro.akashi@linaro.org>
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
To: catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com, vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com, arnd@arndb.de
Cc: ard.biesheuvel@linaro.org, bhsharma@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, james.morse@arm.com, linux-arm-kernel@lists.infradead.org

We need to prevent firmware-reserved memory regions, particularly EFI
memory map as well as ACPI tables, from being corrupted by loading
kernel/initrd (or other kexec buffers). We also want to support memory
allocation in top-down manner in addition to default bottom-up.
So let's have arm64 specific arch_kexec_walk_mem() which will search
for available memory ranges in usable memblock list,
i.e. !NOMAP & !reserved, instead of system resource tree.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/Makefile             |  3 +-
 arch/arm64/kernel/machine_kexec_file.c | 57 ++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kernel/machine_kexec_file.c

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index bf825f38d206..2f2b2757ae7a 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -48,8 +48,9 @@ arm64-obj-$(CONFIG_ARM64_ACPI_PARKING_PROTOCOL)	+= acpi_parking_protocol.o
 arm64-obj-$(CONFIG_PARAVIRT)		+= paravirt.o
 arm64-obj-$(CONFIG_RANDOMIZE_BASE)	+= kaslr.o
 arm64-obj-$(CONFIG_HIBERNATION)		+= hibernate.o hibernate-asm.o
-arm64-obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o	\
+arm64-obj-$(CONFIG_KEXEC_CORE)		+= machine_kexec.o relocate_kernel.o	\
 					   cpu-reset.o
+arm64-obj-$(CONFIG_KEXEC_FILE)		+= machine_kexec_file.o
 arm64-obj-$(CONFIG_ARM64_RELOC_TEST)	+= arm64-reloc-test.o
 arm64-reloc-test-y := reloc_test_core.o reloc_test_syms.o
 arm64-obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
new file mode 100644
index 000000000000..f9ebf54ca247
--- /dev/null
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * kexec_file for arm64
+ *
+ * Copyright (C) 2018 Linaro Limited
+ * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
+ *
+ * Most code is derived from arm64 port of kexec-tools
+ */
+
+#define pr_fmt(fmt) "kexec_file: " fmt
+
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/kexec.h>
+#include <linux/memblock.h>
+
+int arch_kexec_walk_mem(struct kexec_buf *kbuf,
+				int (*func)(struct resource *, void *))
+{
+	phys_addr_t start, end;
+	struct resource res;
+	u64 i;
+	int ret = 0;
+
+	if (kbuf->image->type == KEXEC_TYPE_CRASH)
+		return func(&crashk_res, kbuf);
+
+	if (kbuf->top_down)
+		for_each_mem_range_rev(i, &memblock.memory, &memblock.reserved,
+				NUMA_NO_NODE, MEMBLOCK_NONE,
+				&start, &end, NULL) {
+			if (!memblock_is_map_memory(start))
+				continue;
+
+			res.start = start;
+			res.end = end;
+			ret = func(&res, kbuf);
+			if (ret)
+				break;
+		}
+	else
+		for_each_mem_range(i, &memblock.memory, &memblock.reserved,
+				NUMA_NO_NODE, MEMBLOCK_NONE,
+				&start, &end, NULL) {
+			if (!memblock_is_map_memory(start))
+				continue;
+
+			res.start = start;
+			res.end = end;
+			ret = func(&res, kbuf);
+			if (ret)
+				break;
+		}
+
+	return ret;
+}
-- 
2.17.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
