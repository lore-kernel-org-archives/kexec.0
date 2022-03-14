From: Philipp Rudo <prudo@redhat.com>
Date: Mon, 14 Mar 2022 17:04:29 +0100
Subject: [PATCH v2 1/4] makedumpfile: add generic cycle detection
In-Reply-To: <20220314160432.9414-1-prudo@redhat.com>
References: <20220314160432.9414-1-prudo@redhat.com>
Message-ID: <20220314160432.9414-2-prudo@redhat.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

In order to work makedumpfile needs to interpret data read from the
dump. This can cause problems as the data from the dump cannot be
trusted (otherwise the kernel wouldn't have panicked in the first
place). This also means that every loop which stop condition depend on
data read from the dump has a chance to loop forever. Thus add a generic
cycle detection mechanism that allows to detect and handle such
situations appropriately.

For cycle detection use Brent's algorithm [1] as it has constant memory
usage. With this it can also be used in the kdump kernel without the
danger that it runs oom when iterating large data structures.
Furthermore it only depends on some pointer arithmetic. Thus the
performance impact (as long as no cycle was detected) should be
comparatively small.

[1] https://en.wikipedia.org/wiki/Cycle_detection#Brent's_algorithm

Suggested-by: Dave Wysochanski <dwysocha@redhat.com>
Signed-off-by: Philipp Rudo <prudo@redhat.com>
---
 Makefile       |  2 +-
 detect_cycle.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++++++
 detect_cycle.h | 40 ++++++++++++++++++++
 3 files changed, 140 insertions(+), 1 deletion(-)
 create mode 100644 detect_cycle.c
 create mode 100644 detect_cycle.h

diff --git a/Makefile b/Makefile
index f118b31..3441364 100644
--- a/Makefile
+++ b/Makefile
@@ -45,7 +45,7 @@ CFLAGS_ARCH += -m32
 endif
 
 SRC_BASE = makedumpfile.c makedumpfile.h diskdump_mod.h sadump_mod.h sadump_info.h
-SRC_PART = print_info.c dwarf_info.c elf_info.c erase_info.c sadump_info.c cache.c tools.c printk.c
+SRC_PART = print_info.c dwarf_info.c elf_info.c erase_info.c sadump_info.c cache.c tools.c printk.c detect_cycle.c
 OBJ_PART=$(patsubst %.c,%.o,$(SRC_PART))
 SRC_ARCH = arch/arm.c arch/arm64.c arch/x86.c arch/x86_64.c arch/ia64.c arch/ppc64.c arch/s390x.c arch/ppc.c arch/sparc64.c arch/mips64.c
 OBJ_ARCH=$(patsubst %.c,%.o,$(SRC_ARCH))
diff --git a/detect_cycle.c b/detect_cycle.c
new file mode 100644
index 0000000..6b551a7
--- /dev/null
+++ b/detect_cycle.c
@@ -0,0 +1,99 @@
+/*
+ * detect_cycle.c  --  Generic cycle detection using Brent's algorithm
+ *
+ * Created by: Philipp Rudo <prudo@redhat.com>
+ *
+ * Copyright (c) 2022 Red Hat, Inc. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <stdlib.h>
+
+#include "detect_cycle.h"
+
+struct detect_cycle {
+	/* First entry of the list */
+	void *head;
+
+	/* Variables required by Brent's algorithm */
+	void *fast_p;
+	void *slow_p;
+	unsigned long length;
+	unsigned long power;
+
+	/* Function to get the next entry in the list */
+	dc_next_t next;
+
+	/* Private data passed to next */
+	void *data;
+};
+
+struct detect_cycle *dc_init(void *head, void *data, dc_next_t next)
+{
+	struct detect_cycle *new;
+
+	new = malloc(sizeof(*new));
+	if (!new)
+		return NULL;
+
+	new->next = next;
+	new->data = data;
+
+	new->head = head;
+	new->slow_p = head;
+	new->fast_p = head;
+	new->length = 0;
+	new->power  = 2;
+
+	return new;
+}
+
+int dc_next(struct detect_cycle *dc, void **next)
+{
+
+	if (dc->length == dc->power) {
+		dc->length = 0;
+		dc->power *= 2;
+		dc->slow_p = dc->fast_p;
+	}
+
+	dc->fast_p = dc->next(dc->fast_p, dc->data);
+	dc->length++;
+
+	if (dc->slow_p == dc->fast_p)
+		return 1;
+
+	*next = dc->fast_p;
+	return 0;
+}
+
+void dc_find_start(struct detect_cycle *dc, void **first, unsigned long *len)
+{
+	void *slow_p, *fast_p;
+	unsigned long tmp;
+
+	slow_p = fast_p = dc->head;
+	tmp = dc->length;
+
+	while (tmp) {
+		fast_p = dc->next(fast_p, dc->data);
+		tmp--;
+	}
+
+	while (slow_p != fast_p) {
+		slow_p = dc->next(slow_p, dc->data);
+		fast_p = dc->next(fast_p, dc->data);
+	}
+
+	*first = slow_p;
+	*len = dc->length;
+}
diff --git a/detect_cycle.h b/detect_cycle.h
new file mode 100644
index 0000000..2ca75c7
--- /dev/null
+++ b/detect_cycle.h
@@ -0,0 +1,40 @@
+/*
+ * detect_cycle.h  --  Generic cycle detection using Brent's algorithm
+ *
+ * Created by: Philipp Rudo <prudo@redhat.com>
+ *
+ * Copyright (c) 2022 Red Hat, Inc. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+struct detect_cycle;
+
+typedef void *(*dc_next_t)(void *prev, void *data);
+
+/*
+ * Initialize cycle detection.
+ * Returns a pointer to allocated struct detect_cycle. The caller is
+ * responsible to free the memory after use.
+ */
+struct detect_cycle *dc_init(void *head, void *data, dc_next_t next);
+
+/*
+ * Get next entry in the list using dc->next.
+ * Returns 1 when cycle was detected, 0 otherwise.
+ */
+int dc_next(struct detect_cycle *dc, void **next);
+
+/*
+ * Get the start and length of the cycle. Must only be called after cycle was
+ * detected by dc_next.
+ */
+void dc_find_start(struct detect_cycle *dc, void **first, unsigned long *len);
-- 
2.35.1


