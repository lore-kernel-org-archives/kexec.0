Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UFpVe-0006LC-8D
 for kexec@lists.infradead.org; Wed, 13 Mar 2013 17:30:38 +0000
Received: by mail-pb0-f43.google.com with SMTP id md12so1251047pbc.2
 for <kexec@lists.infradead.org>; Wed, 13 Mar 2013 10:30:35 -0700 (PDT)
Message-ID: <5140B7B3.2010300@gmail.com>
Date: Thu, 14 Mar 2013 01:30:27 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH 07/13] kexec: ia64: use _ALIGN* to make the logic clear
References: <5140B511.7020109@gmail.com>
In-Reply-To: <5140B511.7020109@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

By replacing all the explicit align opertion with marco _ALIGN*,
the code logic could be simplified.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kexec/arch/ia64/crashdump-ia64.c |    6 +++---
 kexec/arch/ia64/kexec-elf-ia64.c |    2 +-
 kexec/arch/ia64/kexec-ia64.c     |    6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kexec/arch/ia64/crashdump-ia64.c b/kexec/arch/ia64/crashdump-ia64.c
index 782f49e..726c9f4 100644
--- a/kexec/arch/ia64/crashdump-ia64.c
+++ b/kexec/arch/ia64/crashdump-ia64.c
@@ -83,7 +83,7 @@ static void add_loaded_segments_info(struct mem_ehdr *ehdr)
 		}
 
 		loaded_segments[loaded_segments_num].start =
-			phdr->p_paddr & ~(ELF_PAGE_SIZE-1);
+			_ALIGN_DOWN(phdr->p_paddr, ELF_PAGE_SIZE);
                 loaded_segments[loaded_segments_num].end =
 			loaded_segments[loaded_segments_num].start;
 
@@ -97,8 +97,8 @@ static void add_loaded_segments_info(struct mem_ehdr *ehdr)
 	                if (phdr->p_type != PT_LOAD)
 	                        break;
 			loaded_segments[loaded_segments_num].end =
-				(phdr->p_paddr + phdr->p_memsz +
-				ELF_PAGE_SIZE - 1) & ~(ELF_PAGE_SIZE - 1);
+				_ALIGN(phdr->p_paddr + phdr->p_memsz,
+				       ELF_PAGE_SIZE);
 			i++;
 		}
 		loaded_segments_num++;
diff --git a/kexec/arch/ia64/kexec-elf-ia64.c b/kexec/arch/ia64/kexec-elf-ia64.c
index 8da061e..7303c03 100644
--- a/kexec/arch/ia64/kexec-elf-ia64.c
+++ b/kexec/arch/ia64/kexec-elf-ia64.c
@@ -264,7 +264,7 @@ int elf_ia64_load(int argc, char **argv, const char *buf, off_t len,
 			strcat(cmdline, buf);
 		}
 
-		command_line_len = (command_line_len + 15)&(~15);
+		command_line_len = _ALIGN(command_line_len, 16);
 		command_line_base = add_buffer(info, cmdline,
 				command_line_len, command_line_len,
 				getpagesize(), 0UL,
diff --git a/kexec/arch/ia64/kexec-ia64.c b/kexec/arch/ia64/kexec-ia64.c
index aa510a9..418d997 100644
--- a/kexec/arch/ia64/kexec-ia64.c
+++ b/kexec/arch/ia64/kexec-ia64.c
@@ -50,8 +50,8 @@ static int split_range(int range, unsigned long start, unsigned long end)
 	unsigned int type = memory_range[range - 1].type;
 	int i;
 	//align end and start to page size of EFI
-	start = start & ~((1UL<<12) - 1);
-	end = (end + (1UL<<12) - 1)& ~((1UL<<12) - 1);
+	start = _ALIGN_DOWN(start, 1UL<<12);
+	end = _ALIGN(end, 1UL<<12);
 	for (i = 0; i < range; i++)
 		if(memory_range[i].start <= start && memory_range[i].end >=end)
 			break;
@@ -230,7 +230,7 @@ int update_loaded_segments(struct mem_ehdr *ehdr)
 	for (i = 0; i < memory_ranges; i++) {
 		if (memory_range[i].type != RANGE_RAM)
 			continue;
-		start = (memory_range[i].start + align - 1) & ~(align - 1);
+		start = _ALIGN(memory_range[i].start, align);
 		end = memory_range[i].end;
 		if (end > start && (end - start) > (end_addr - start_addr)) {
 		    move_loaded_segments(ehdr, start);
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
