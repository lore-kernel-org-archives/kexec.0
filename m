Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cVwZD-0008DA-36
 for kexec@lists.infradead.org; Tue, 24 Jan 2017 08:35:04 +0000
Received: by mail-pg0-f46.google.com with SMTP id 14so53182429pgg.1
 for <kexec@lists.infradead.org>; Tue, 24 Jan 2017 00:34:43 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v5 2/9] kexec: generalize and rename get_kernel_stext_sym()
Date: Tue, 24 Jan 2017 17:33:24 +0900
Message-Id: <20170124083331.3468-3-takahiro.akashi@linaro.org>
In-Reply-To: <20170124083331.3468-1-takahiro.akashi@linaro.org>
References: <20170124083331.3468-1-takahiro.akashi@linaro.org>
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
To: horms@verge.net.au
Cc: geoff@infradead.org, panand@redhat.com, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>

From: Pratyush Anand <panand@redhat.com>

get_kernel_stext_sym() has been defined for both arm and i386. Other
architecture might need some other kernel symbol address. Therefore rewrite
this function as generic function to get any kernel symbol address.

More over, kallsyms is not arch specific representation, therefore have
common function for all arches.

Signed-off-by: Pratyush Anand <panand@redhat.com>
[created symbols.c]
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 kexec/Makefile                  |  1 +
 kexec/arch/arm/crashdump-arm.c  | 40 +---------------------------------------
 kexec/arch/i386/crashdump-x86.c | 29 -----------------------------
 kexec/kexec.h                   |  2 ++
 kexec/symbols.c                 | 41 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 45 insertions(+), 68 deletions(-)
 create mode 100644 kexec/symbols.c

diff --git a/kexec/Makefile b/kexec/Makefile
index 39f365f..2b4fb3d 100644
--- a/kexec/Makefile
+++ b/kexec/Makefile
@@ -26,6 +26,7 @@ KEXEC_SRCS_base += kexec/kernel_version.c
 KEXEC_SRCS_base += kexec/lzma.c
 KEXEC_SRCS_base += kexec/zlib.c
 KEXEC_SRCS_base += kexec/kexec-xen.c
+KEXEC_SRCS_base += kexec/symbols.c
 
 KEXEC_GENERATED_SRCS += $(PURGATORY_HEX_C)
 
diff --git a/kexec/arch/arm/crashdump-arm.c b/kexec/arch/arm/crashdump-arm.c
index 4a89b5e..245c21a 100644
--- a/kexec/arch/arm/crashdump-arm.c
+++ b/kexec/arch/arm/crashdump-arm.c
@@ -73,48 +73,10 @@ static struct crash_elf_info elf_info = {
 
 extern unsigned long long user_page_offset;
 
-/* Retrieve kernel _stext symbol virtual address from /proc/kallsyms */
-static unsigned long long get_kernel_stext_sym(void)
-{
-	const char *kallsyms = "/proc/kallsyms";
-	const char *stext = "_stext";
-	char sym[128];
-	char line[128];
-	FILE *fp;
-	unsigned long long vaddr = 0;
-	char type;
-
-	fp = fopen(kallsyms, "r");
-	if (!fp) {
-		fprintf(stderr, "Cannot open %s\n", kallsyms);
-		return 0;
-	}
-
-	while(fgets(line, sizeof(line), fp) != NULL) {
-		unsigned long long addr;
-
-		if (sscanf(line, "%Lx %c %s", &addr, &type, sym) != 3)
-			continue;
-
-		if (strcmp(sym, stext) == 0) {
-			dbgprintf("kernel symbol %s vaddr = %#llx\n", stext, addr);
-			vaddr = addr;
-			break;
-		}
-	}
-
-	fclose(fp);
-
-	if (vaddr == 0)
-		fprintf(stderr, "Cannot get kernel %s symbol address\n", stext);
-
-	return vaddr;
-}
-
 static int get_kernel_page_offset(struct kexec_info *info,
 		struct crash_elf_info *elf_info)
 {
-	unsigned long long stext_sym_addr = get_kernel_stext_sym();
+	unsigned long long stext_sym_addr = get_kernel_sym("_stext");
 	if (stext_sym_addr == 0) {
 		if (user_page_offset != (-1ULL)) {
 			elf_info->page_offset = user_page_offset;
diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 88aeee3..a324c6c 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -102,35 +102,6 @@ static int get_kernel_paddr(struct kexec_info *UNUSED(info),
 	return -1;
 }
 
-/* Retrieve kernel symbol virtual address from /proc/kallsyms */
-static unsigned long long get_kernel_sym(const char *symbol)
-{
-	const char *kallsyms = "/proc/kallsyms";
-	char sym[128];
-	char line[128];
-	FILE *fp;
-	unsigned long long vaddr;
-	char type;
-
-	fp = fopen(kallsyms, "r");
-	if (!fp) {
-		fprintf(stderr, "Cannot open %s\n", kallsyms);
-		return 0;
-	}
-
-	while(fgets(line, sizeof(line), fp) != NULL) {
-		if (sscanf(line, "%Lx %c %s", &vaddr, &type, sym) != 3)
-			continue;
-		if (strcmp(sym, symbol) == 0) {
-			dbgprintf("kernel symbol %s vaddr = %16llx\n", symbol, vaddr);
-			return vaddr;
-		}
-	}
-
-	fprintf(stderr, "Cannot get kernel %s symbol address\n", symbol);
-	return 0;
-}
-
 /* Retrieve info regarding virtual address kernel has been compiled for and
  * size of the kernel from /proc/kcore. Current /proc/kcore parsing from
  * from kexec-tools fails because of malformed elf notes. A kernel patch has
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 9194f1c..b4fafad 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -312,4 +312,6 @@ int xen_kexec_load(struct kexec_info *info);
 int xen_kexec_unload(uint64_t kexec_flags);
 void xen_kexec_exec(void);
 
+extern unsigned long long get_kernel_sym(const char *text);
+
 #endif /* KEXEC_H */
diff --git a/kexec/symbols.c b/kexec/symbols.c
new file mode 100644
index 0000000..ea6e327
--- /dev/null
+++ b/kexec/symbols.c
@@ -0,0 +1,41 @@
+#include <stdio.h>
+#include <string.h>
+#include "kexec.h"
+
+/* Retrieve kernel symbol virtual address from /proc/kallsyms */
+unsigned long long get_kernel_sym(const char *text)
+{
+	const char *kallsyms = "/proc/kallsyms";
+	char sym[128];
+	char line[128];
+	FILE *fp;
+	unsigned long long vaddr = 0;
+	char type;
+
+	fp = fopen(kallsyms, "r");
+	if (!fp) {
+		fprintf(stderr, "Cannot open %s\n", kallsyms);
+		return 0;
+	}
+
+	while (fgets(line, sizeof(line), fp) != NULL) {
+		unsigned long long addr;
+
+		if (sscanf(line, "%Lx %c %s", &addr, &type, sym) != 3)
+			continue;
+
+		if (strcmp(sym, text) == 0) {
+			dbgprintf("kernel symbol %s vaddr = %#llx\n",
+								text, addr);
+			vaddr = addr;
+			break;
+		}
+	}
+
+	fclose(fp);
+
+	if (vaddr == 0)
+		fprintf(stderr, "Cannot get kernel %s symbol address\n", text);
+
+	return vaddr;
+}
-- 
2.11.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
