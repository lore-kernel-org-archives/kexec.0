Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-iy0-f177.google.com ([209.85.210.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1S5X1E-0001RU-Rr
 for kexec@lists.infradead.org; Thu, 08 Mar 2012 06:40:09 +0000
Received: by mail-iy0-f177.google.com with SMTP id y10so310005iak.36
 for <kexec@lists.infradead.org>; Wed, 07 Mar 2012 22:40:08 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
Subject: [PATCH 4/5] mips: move DEBUG code to --debug
Date: Thu,  8 Mar 2012 14:39:41 +0800
Message-Id: <1331188782-10912-4-git-send-email-xiyou.wangcong@gmail.com>
In-Reply-To: <1331188782-10912-1-git-send-email-xiyou.wangcong@gmail.com>
References: <1331188782-10912-1-git-send-email-xiyou.wangcong@gmail.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Simon Horman <horms@verge.net.au>

Like patch 1/5, this one moves code under #if DEBUG to --debug
on mips arch.

Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 kexec/arch/mips/crashdump-mips.c |   16 +++++-----------
 1 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/kexec/arch/mips/crashdump-mips.c b/kexec/arch/mips/crashdump-mips.c
index e90b362..f988698 100644
--- a/kexec/arch/mips/crashdump-mips.c
+++ b/kexec/arch/mips/crashdump-mips.c
@@ -60,9 +60,7 @@ static int get_kernel_paddr(struct crash_elf_info *elf_info)
 
 	if (parse_iomem_single("Kernel code\n", &start, NULL) == 0) {
 		elf_info->kern_paddr_start = start;
-#ifdef DEBUG
-		printf("kernel load physical addr start = 0x%lx\n", start);
-#endif
+		dbgprintf("kernel load physical addr start = 0x%lx\n", start);
 		return 0;
 	}
 
@@ -82,12 +80,10 @@ static int get_kernel_vaddr_and_size(struct crash_elf_info *elf_info,
 					start_offset;
 	if (parse_iomem_single("Kernel data\n", NULL, &end) == 0) {
 		elf_info->kern_size = end - elf_info->kern_paddr_start;
-#ifdef DEBUG
-		printf("kernel_vaddr= 0x%llx paddr %llx\n",
+		dbgprintf("kernel_vaddr= 0x%llx paddr %llx\n",
 				elf_info->kern_vaddr_start,
 				elf_info->kern_paddr_start);
-		printf("kernel size = 0x%llx\n", elf_info->kern_size);
-#endif
+		dbgprintf("kernel size = 0x%llx\n", elf_info->kern_size);
 		return 0;
 		}
 	fprintf(stderr, "Cannot determine kernel virtual load addr and  size\n");
@@ -400,11 +396,9 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 	cmdline_add_elfcorehdr(mod_cmdline, elfcorehdr);
 	cmdline_add_savemaxmem(mod_cmdline, saved_max_mem);
 
-#ifdef DEBUG
-	printf("CRASH MEMORY RANGES:\n");
-	printf("%016Lx-%016Lx\n", crash_reserved_mem.start,
+	dbgprintf("CRASH MEMORY RANGES:\n");
+	dbgprintf("%016Lx-%016Lx\n", crash_reserved_mem.start,
 			crash_reserved_mem.end);
-#endif
 	return 0;
 }
 
-- 
1.7.7.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
