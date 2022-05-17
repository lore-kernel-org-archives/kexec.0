From: Stephen Brennan <stephen.s.brennan@oracle.com>
Date: Mon, 16 May 2022 17:05:07 -0700
Subject: [PATCH 1/2] kallsyms: Move declarations to internal header
In-Reply-To: <20220517000508.777145-1-stephen.s.brennan@oracle.com>
References: <20220517000508.777145-1-stephen.s.brennan@oracle.com>
Message-ID: <20220517000508.777145-2-stephen.s.brennan@oracle.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

To include kallsyms data in the vmcoreinfo note, we must make the symbol
declarations visible outside of kallsyms.c. Move these to a new internal
header file.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 kernel/kallsyms.c          | 23 +----------------------
 kernel/kallsyms_internal.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 22 deletions(-)
 create mode 100644 kernel/kallsyms_internal.h

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 79f2eb617a62..42373ff69cac 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -30,28 +30,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 
-/*
- * These will be re-linked against their real values
- * during the second link stage.
- */
-extern const unsigned long kallsyms_addresses[] __weak;
-extern const int kallsyms_offsets[] __weak;
-extern const u8 kallsyms_names[] __weak;
-
-/*
- * Tell the compiler that the count isn't in the small data section if the arch
- * has one (eg: FRV).
- */
-extern const unsigned int kallsyms_num_syms
-__section(".rodata") __attribute__((weak));
-
-extern const unsigned long kallsyms_relative_base
-__section(".rodata") __attribute__((weak));
-
-extern const char kallsyms_token_table[] __weak;
-extern const u16 kallsyms_token_index[] __weak;
-
-extern const unsigned int kallsyms_markers[] __weak;
+#include "kallsyms_internal.h"
 
 /*
  * Expand a compressed symbol data into the resulting uncompressed string,
diff --git a/kernel/kallsyms_internal.h b/kernel/kallsyms_internal.h
new file mode 100644
index 000000000000..2d0c6f2f0243
--- /dev/null
+++ b/kernel/kallsyms_internal.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef LINUX_KALLSYMS_INTERNAL_H_
+#define LINUX_KALLSYMS_INTERNAL_H_
+
+#include <linux/types.h>
+
+/*
+ * These will be re-linked against their real values
+ * during the second link stage.
+ */
+extern const unsigned long kallsyms_addresses[] __weak;
+extern const int kallsyms_offsets[] __weak;
+extern const u8 kallsyms_names[] __weak;
+
+/*
+ * Tell the compiler that the count isn't in the small data section if the arch
+ * has one (eg: FRV).
+ */
+extern const unsigned int kallsyms_num_syms
+__section(".rodata") __attribute__((weak));
+
+extern const unsigned long kallsyms_relative_base
+__section(".rodata") __attribute__((weak));
+
+extern const char kallsyms_token_table[] __weak;
+extern const u16 kallsyms_token_index[] __weak;
+
+extern const unsigned int kallsyms_markers[] __weak;
+
+#endif // LINUX_KALLSYMS_INTERNAL_H_
-- 
2.30.2


