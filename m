Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x231.google.com ([2607:f8b0:400e:c03::231])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YHanh-00045S-45
 for kexec@lists.infradead.org; Sat, 31 Jan 2015 16:21:37 +0000
Received: by mail-pa0-f49.google.com with SMTP id fa1so64465705pad.8
 for <kexec@lists.infradead.org>; Sat, 31 Jan 2015 08:21:16 -0800 (PST)
From: Yousong Zhou <yszhou4tech@gmail.com>
Subject: [PATCH 3/3] Fix a few compilation warnings.
Date: Sun,  1 Feb 2015 00:10:08 +0800
Message-Id: <1422720608-28700-3-git-send-email-yszhou4tech@gmail.com>
In-Reply-To: <1422720608-28700-1-git-send-email-yszhou4tech@gmail.com>
References: <1422720608-28700-1-git-send-email-yszhou4tech@gmail.com>
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
Cc: Yousong Zhou <yszhou4tech@gmail.com>, horms@verge.net.au


Signed-off-by: Yousong Zhou <yszhou4tech@gmail.com>
---
 kexec/arch/mips/crashdump-mips.c |    3 ++-
 kexec/arch/mips/kexec-elf-mips.c |    2 +-
 kexec/kexec-elf-rel.c            |    3 +++
 kexec/kexec.h                    |    2 +-
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/kexec/arch/mips/crashdump-mips.c b/kexec/arch/mips/crashdump-mips.c
index e7840e0..98c9f7c 100644
--- a/kexec/arch/mips/crashdump-mips.c
+++ b/kexec/arch/mips/crashdump-mips.c
@@ -22,6 +22,7 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <limits.h>
+#include <inttypes.h>
 #include <elf.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -52,7 +53,7 @@ static int get_kernel_paddr(struct crash_elf_info *elf_info)
 
 	if (parse_iomem_single("Kernel code\n", &start, NULL) == 0) {
 		elf_info->kern_paddr_start = start;
-		dbgprintf("kernel load physical addr start = 0x%lx\n", start);
+		dbgprintf("kernel load physical addr start = 0x%" PRIu64 "\n", start);
 		return 0;
 	}
 
diff --git a/kexec/arch/mips/kexec-elf-mips.c b/kexec/arch/mips/kexec-elf-mips.c
index a27d986..8a6419a 100644
--- a/kexec/arch/mips/kexec-elf-mips.c
+++ b/kexec/arch/mips/kexec-elf-mips.c
@@ -158,7 +158,7 @@ int elf_mips_load(int argc, char **argv, const char *buf, off_t len,
 	if (info->kexec_flags & KEXEC_ON_CRASH)
 		/* In case of crashdump segment[0] is kernel.
 		 * Put cmdline just after it. */
-		cmdline_addr = info->segment[0].mem +
+		cmdline_addr = (unsigned long)info->segment[0].mem +
 				info->segment[0].memsz;
 	else
 		cmdline_addr = 0;
diff --git a/kexec/kexec-elf-rel.c b/kexec/kexec-elf-rel.c
index c625f30..5a5fcd1 100644
--- a/kexec/kexec-elf-rel.c
+++ b/kexec/kexec-elf-rel.c
@@ -347,6 +347,9 @@ int elf_rel_load(struct mem_ehdr *ehdr, struct kexec_info *info,
 			else if (shdr->sh_type == SHT_RELA) {
 				rel = elf_rela(ehdr, ptr);
 			}
+			else {
+				die("Unexpected sh_type: %d\n", shdr->sh_type);
+			}
 			/* the location to change */
 			location = section->sh_data + rel.r_offset;
 
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 4be2b2f..2c85052 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -245,7 +245,7 @@ extern int file_types;
 
 extern void dbgprint_mem_range(const char *prefix, struct memory_range *mr, int nr_mr);
 extern void die(const char *fmt, ...)
-	__attribute__ ((format (printf, 1, 2)));
+	__attribute__ ((format (printf, 1, 2), noreturn));
 extern void *xmalloc(size_t size);
 extern void *xrealloc(void *ptr, size_t size);
 extern char *slurp_file(const char *filename, off_t *r_size);
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
