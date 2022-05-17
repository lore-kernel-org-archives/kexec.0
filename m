From: Stephen Brennan <stephen.s.brennan@oracle.com>
Date: Mon, 16 May 2022 17:05:08 -0700
Subject: [PATCH 2/2] vmcoreinfo: Include kallsyms symbols
In-Reply-To: <20220517000508.777145-1-stephen.s.brennan@oracle.com>
References: <20220517000508.777145-1-stephen.s.brennan@oracle.com>
Message-ID: <20220517000508.777145-3-stephen.s.brennan@oracle.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

The internal kallsyms tables contain information which could be quite
useful to a debugging tool in the absence of other debuginfo. If
kallsyms is enabled, then a debugging tool could parse it and use it as
a fallback symbol table. Combined with BTF data, live & post-mortem
debuggers can support basic operations without needing a large DWARF
debuginfo file available. As many as five symbols are necessary to
properly parse kallsyms names and addresses.  Add these to the
vmcoreinfo note.

CONFIG_KALLSYMS_ABSOLUTE_PERCPU does impact the computation of symbol
addresses. However, a debugger can infer this configuration value by
comparing the address of _stext in the vmcoreinfo with the address
computed via kallsyms. So there's no need to include information about
this config value in the vmcoreinfo note.

To verify that we're still well below the maximum of 4096 bytes, I
created a script[1] to compute a rough upper bound on the possible size
of vmcoreinfo. On v5.18-rc7, the script reports 3106 bytes, and with
this patch, the maximum become 3370 bytes.

[1]: https://github.com/brenns10/kernel_stuff/blob/master/vmcoreinfosize/

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 kernel/crash_core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 256cf6db573c..b9c89b80856d 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -15,6 +15,8 @@
 
 #include <crypto/sha1.h>
 
+#include "kallsyms_internal.h"
+
 /* vmcoreinfo stuff */
 unsigned char *vmcoreinfo_data;
 size_t vmcoreinfo_size;
@@ -484,6 +486,18 @@ static int __init crash_save_vmcoreinfo_init(void)
 	VMCOREINFO_NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE);
 #endif
 
+#ifdef CONFIG_KALLSYMS
+	VMCOREINFO_SYMBOL(kallsyms_names);
+	VMCOREINFO_SYMBOL(kallsyms_token_table);
+	VMCOREINFO_SYMBOL(kallsyms_token_index);
+#ifdef CONFIG_KALLSYMS_BASE_RELATIVE
+	VMCOREINFO_SYMBOL(kallsyms_offsets);
+	VMCOREINFO_SYMBOL(kallsyms_relative_base);
+#else
+	VMCOREINFO_SYMBOL(kallsyms_addresses);
+#endif /* CONFIG_KALLSYMS_BASE_RELATIVE */
+#endif /* CONFIG_KALLSYMS */
+
 	arch_crash_save_vmcoreinfo();
 	update_vmcoreinfo_note();
 
-- 
2.30.2


