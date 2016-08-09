Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x233.google.com ([2607:f8b0:400e:c03::233])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bWwH7-00008T-MC
 for kexec@lists.infradead.org; Tue, 09 Aug 2016 01:56:19 +0000
Received: by mail-pa0-x233.google.com with SMTP id fi15so187687pac.1
 for <kexec@lists.infradead.org>; Mon, 08 Aug 2016 18:55:52 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v2 6/7] kexec: generalize and rename get_kernel_stext_sym()
Date: Tue,  9 Aug 2016 11:00:31 +0900
Message-Id: <20160809020032.28654-7-takahiro.akashi@linaro.org>
In-Reply-To: <20160809020032.28654-1-takahiro.akashi@linaro.org>
References: <20160809020032.28654-1-takahiro.akashi@linaro.org>
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
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 kexec/arch/arm/crashdump-arm.c  | 40 +---------------------------------------
 kexec/arch/i386/crashdump-x86.c | 32 +-------------------------------
 kexec/crashdump.c               | 37 +++++++++++++++++++++++++++++++++++++
 kexec/crashdump.h               |  1 +
 4 files changed, 40 insertions(+), 70 deletions(-)

diff --git a/kexec/arch/arm/crashdump-arm.c b/kexec/arch/arm/crashdump-arm.c
index 4a89b5e..2bc898b 100644
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
+	unsigned long long stext_sym_addr = get_kernel_sym("stext");
 	if (stext_sym_addr == 0) {
 		if (user_page_offset != (-1ULL)) {
 			elf_info->page_offset = user_page_offset;
diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index bbc0f35..664eb3b 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -102,36 +102,6 @@ static int get_kernel_paddr(struct kexec_info *UNUSED(info),
 	return -1;
 }
 
-/* Retrieve kernel _stext symbol virtual address from /proc/kallsyms */
-static unsigned long long get_kernel_stext_sym(void)
-{
-	const char *kallsyms = "/proc/kallsyms";
-	const char *stext = "_stext";
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
-		if (strcmp(sym, stext) == 0) {
-			dbgprintf("kernel symbol %s vaddr = %16llx\n", stext, vaddr);
-			return vaddr;
-		}
-	}
-
-	fprintf(stderr, "Cannot get kernel %s symbol address\n", stext);
-	return 0;
-}
-
 /* Retrieve info regarding virtual address kernel has been compiled for and
  * size of the kernel from /proc/kcore. Current /proc/kcore parsing from
  * from kexec-tools fails because of malformed elf notes. A kernel patch has
@@ -182,7 +152,7 @@ static int get_kernel_vaddr_and_size(struct kexec_info *UNUSED(info),
 
 	/* Traverse through the Elf headers and find the region where
 	 * _stext symbol is located in. That's where kernel is mapped */
-	stext_sym = get_kernel_stext_sym();
+	stext_sym = get_kernel_sym("stext");
 	for(phdr = ehdr.e_phdr; stext_sym && phdr != end_phdr; phdr++) {
 		if (phdr->p_type == PT_LOAD) {
 			unsigned long long saddr = phdr->p_vaddr;
diff --git a/kexec/crashdump.c b/kexec/crashdump.c
index 15c1105..3688965 100644
--- a/kexec/crashdump.c
+++ b/kexec/crashdump.c
@@ -157,3 +157,40 @@ int get_kernel_vmcoreinfo(uint64_t *addr, uint64_t *len)
 {
 	return get_vmcoreinfo("/sys/kernel/vmcoreinfo", addr, len);
 }
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
+	while(fgets(line, sizeof(line), fp) != NULL) {
+		unsigned long long addr;
+
+		if (sscanf(line, "%Lx %c %s", &addr, &type, sym) != 3)
+			continue;
+
+		if (strcmp(sym, text) == 0) {
+			dbgprintf("kernel symbol %s vaddr = %#llx\n", text, addr);
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
diff --git a/kexec/crashdump.h b/kexec/crashdump.h
index 96219a8..887fdb7 100644
--- a/kexec/crashdump.h
+++ b/kexec/crashdump.h
@@ -5,6 +5,7 @@ int get_crashkernel_region(uint64_t *start, uint64_t *end);
 extern int get_crash_notes_per_cpu(int cpu, uint64_t *addr, uint64_t *len);
 extern int get_kernel_vmcoreinfo(uint64_t *addr, uint64_t *len);
 extern int get_xen_vmcoreinfo(uint64_t *addr, uint64_t *len);
+extern unsigned long long get_kernel_sym(const char *text);
 
 /* Need to find a better way to determine per cpu notes section size. */
 #define MAX_NOTE_BYTES		1024
-- 
2.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
