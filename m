Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.loongson.cn ([114.242.206.163] helo=loongson.cn)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGuW7-0004FL-JU
 for kexec@lists.infradead.org; Sat, 12 Sep 2020 01:39:52 +0000
From: Youling Tang <tangyouling@loongson.cn>
Subject: [PATCH] kexec-tools: Add some missing free() calls
Date: Sat, 12 Sep 2020 09:39:49 +0800
Message-Id: <1599874789-7042-1-git-send-email-tangyouling@loongson.cn>
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
To: Simon Horman <horms@verge.net.au>, Khalid Aziz <khalid@gonehiking.org>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org

Add some missing free() calls.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 kexec/arch/i386/crashdump-x86.c    | 22 +++++++++++++++++-----
 kexec/arch/mips/crashdump-mips.c   |  5 ++++-
 kexec/arch/ppc64/crashdump-ppc64.c |  8 ++++++--
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index c79791f..d5b5b68 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -913,8 +913,11 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 	add_memmap(memmap_p, &nr_memmap, info->backup_src_start, info->backup_src_size, RANGE_RAM);
 	for (i = 0; i < crash_reserved_mem_nr; i++) {
 		sz = crash_reserved_mem[i].end - crash_reserved_mem[i].start +1;
-		if (add_memmap(memmap_p, &nr_memmap, crash_reserved_mem[i].start, sz, RANGE_RAM) < 0)
+		if (add_memmap(memmap_p, &nr_memmap, crash_reserved_mem[i].start,
+				sz, RANGE_RAM) < 0) {
+			free(memmap_p);
 			return ENOCRASHKERNEL;
+		}
 	}
 
 	/* Create a backup region segment to store backup data*/
@@ -926,22 +929,29 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 						0, max_addr, -1);
 		dbgprintf("Created backup segment at 0x%lx\n",
 			  info->backup_start);
-		if (delete_memmap(memmap_p, &nr_memmap, info->backup_start, sz) < 0)
+		if (delete_memmap(memmap_p, &nr_memmap, info->backup_start, sz) < 0) {
+			free(tmp);
+			free(memmap_p);
 			return EFAILED;
+		}
 	}
 
 	/* Create elf header segment and store crash image data. */
 	if (arch_options.core_header_type == CORE_TYPE_ELF64) {
 		if (crash_create_elf64_headers(info, &elf_info, mem_range,
 						nr_ranges, &tmp, &bufsz,
-						ELF_CORE_HEADER_ALIGN) < 0)
+						ELF_CORE_HEADER_ALIGN) < 0) {
+			free(memmap_p);
 			return EFAILED;
+		}
 	}
 	else {
 		if (crash_create_elf32_headers(info, &elf_info, mem_range,
 						nr_ranges, &tmp, &bufsz,
-						ELF_CORE_HEADER_ALIGN) < 0)
+						ELF_CORE_HEADER_ALIGN) < 0) {
+			free(memmap_p);
 			return EFAILED;
+		}
 	}
 	/* the size of the elf headers allocated is returned in 'bufsz' */
 
@@ -962,8 +972,10 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 	elfcorehdr = add_buffer(info, tmp, bufsz, memsz, align, min_base,
 							max_addr, -1);
 	dbgprintf("Created elf header segment at 0x%lx\n", elfcorehdr);
-	if (delete_memmap(memmap_p, &nr_memmap, elfcorehdr, memsz) < 0)
+	if (delete_memmap(memmap_p, &nr_memmap, elfcorehdr, memsz) < 0) {
+		free(memmap_p);
 		return -1;
+		}
 	if (!bzImage_support_efi_boot || arch_options.noefi ||
 	    !sysfs_efi_runtime_map_exist())
 		cmdline_add_efi(mod_cmdline);
diff --git a/kexec/arch/mips/crashdump-mips.c b/kexec/arch/mips/crashdump-mips.c
index fc92e64..c1603d9 100644
--- a/kexec/arch/mips/crashdump-mips.c
+++ b/kexec/arch/mips/crashdump-mips.c
@@ -387,8 +387,11 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 				crash_reserved_mem.end, -1);
 
 	if (crash_create(info, elf_info, crash_memory_range, nr_ranges,
-			 &tmp, &sz, ELF_CORE_HEADER_ALIGN) < 0)
+			 &tmp, &sz, ELF_CORE_HEADER_ALIGN) < 0) {
+		free(tmp);
 		return -1;
+	}
+
 	elfcorehdr = add_buffer(info, tmp, sz, sz, align,
 		crash_reserved_mem.start,
 		crash_reserved_mem.end, -1);
diff --git a/kexec/arch/ppc64/crashdump-ppc64.c b/kexec/arch/ppc64/crashdump-ppc64.c
index b2787d5..26f9a01 100644
--- a/kexec/arch/ppc64/crashdump-ppc64.c
+++ b/kexec/arch/ppc64/crashdump-ppc64.c
@@ -535,15 +535,19 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 		if (crash_create_elf64_headers(info, &elf_info64,
 					       crash_memory_range, nr_ranges,
 					       &tmp, &sz,
-					       ELF_CORE_HEADER_ALIGN) < 0)
+					       ELF_CORE_HEADER_ALIGN) < 0) {
+			free (tmp);
 			return -1;
+		}
 	}
 	else {
 		if (crash_create_elf32_headers(info, &elf_info32,
 					       crash_memory_range, nr_ranges,
 					       &tmp, &sz,
-					       ELF_CORE_HEADER_ALIGN) < 0)
+					       ELF_CORE_HEADER_ALIGN) < 0) {
+			free(tmp);
 			return -1;
+		}
 	}
 
 	elfcorehdr = add_buffer(info, tmp, sz, sz, align, min_base,
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
