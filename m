Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TnPwW-0005uE-1D
 for kexec@lists.infradead.org; Tue, 25 Dec 2012 08:33:00 +0000
Message-ID: <50D96423.8000606@cn.fujitsu.com>
Date: Tue, 25 Dec 2012 16:30:27 +0800
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [PATCH] kexec: fix some compiler warnings
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: horms@verge.net.au
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

I got the following warnings when I compiled kexec-tools:

kexec/kexec-elf-rel.c: In function 'elf_rel_load':
kexec/kexec-elf-rel.c:367: warning: format '%lx' expects type 'long unsigned int', but argument 6 has type 'unsigned int'
kexec/kexec-elf-rel.c:367: warning: format '%lx' expects type 'long unsigned int', but argument 7 has type 'long long unsigned int'
kexec/kexec-elf-rel.c:367: warning: format '%lx' expects type 'long unsigned int', but argument 8 has type 'long long unsigned int'
kexec/arch/i386/crashdump-x86.c: In function 'get_kernel_paddr':
kexec/arch/i386/crashdump-x86.c:99: warning: format '%016Lx' expects type 'long long unsigned int', but argument 3 has type 'uint64_t'
kexec/arch/i386/crashdump-x86.c: In function 'get_kernel_vaddr_and_size':
kexec/arch/i386/crashdump-x86.c:171: warning: format '%lx' expects type 'long unsigned int', but argument 3 has type 'long long unsigned int'
kexec/arch/i386/crashdump-x86.c: In function 'get_crash_notes':
kexec/arch/i386/crashdump-x86.c:781: warning: format '%Lx' expects type 'long long unsigned int', but argument 3 has type 'uint64_t'
kexec/arch/i386/crashdump-x86.c: In function 'load_crashdump_segments':
kexec/arch/i386/crashdump-x86.c:905: warning: 'nr_ranges' may be used uninitialized in this function

The patch fix above warnings.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kexec/arch/i386/crashdump-x86.c |   10 ++++++----
 kexec/crashdump.c               |    3 ++-
 kexec/kexec-elf-rel.c           |    2 +-
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 63f6b2b..d1c2d80 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -96,7 +96,8 @@ static int get_kernel_paddr(struct kexec_info *UNUSED(info),
 
 	if (parse_iomem_single("Kernel code\n", &start, NULL) == 0) {
 		elf_info->kern_paddr_start = start;
-		dbgprintf("kernel load physical addr start = 0x%016Lx\n", start);
+		dbgprintf("kernel load physical addr start = 0x%016Lx\n",
+			  (unsigned long long)start);
 		return 0;
 	}
 
@@ -168,7 +169,7 @@ static int get_kernel_vaddr_and_size(struct kexec_info *UNUSED(info),
 				/* Align size to page size boundary. */
 				size = (size + align - 1) & (~(align - 1));
 				elf_info->kern_size = size;
-				dbgprintf("kernel vaddr = 0x%lx size = 0x%llx\n",
+				dbgprintf("kernel vaddr = 0x%llx size = 0x%llx\n",
 					saddr, size);
 				return 0;
 			}
@@ -771,7 +772,8 @@ static int get_crash_notes(int cpu, uint64_t *addr, uint64_t *len)
 		*addr = x86__pa(vaddr + (cpu * MAX_NOTE_BYTES));
 		*len = MAX_NOTE_BYTES;
 
-		dbgprintf("crash_notes addr = %Lx\n", *addr);
+		dbgprintf("crash_notes addr = %Lx\n",
+			  (unsigned long long)*addr);
 
 		fclose(fp);
 		return 0;
@@ -895,7 +897,7 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 {
 	void *tmp;
 	unsigned long sz, bufsz, memsz, elfcorehdr;
-	int nr_ranges, align = 1024, i;
+	int nr_ranges = 0, align = 1024, i;
 	struct memory_range *mem_range, *memmap_p;
 	struct crash_elf_info elf_info;
 	unsigned kexec_arch;
diff --git a/kexec/crashdump.c b/kexec/crashdump.c
index cdd3ef6..70817b8 100644
--- a/kexec/crashdump.c
+++ b/kexec/crashdump.c
@@ -103,7 +103,8 @@ int get_crash_notes_per_cpu(int cpu, uint64_t *addr, uint64_t *len)
 	*addr = (uint64_t) temp;
 	*len = MAX_NOTE_BYTES; /* we should get this from the kernel instead */
 
-	dbgprintf("%s: crash_notes addr = %Lx\n", __FUNCTION__, *addr);
+	dbgprintf("%s: crash_notes addr = %Lx\n", __FUNCTION__,
+		  (unsigned long long)*addr);
 
 	fclose(fp);
 	return 0;
diff --git a/kexec/kexec-elf-rel.c b/kexec/kexec-elf-rel.c
index fc90e42..8880c8b 100644
--- a/kexec/kexec-elf-rel.c
+++ b/kexec/kexec-elf-rel.c
@@ -364,7 +364,7 @@ int elf_rel_load(struct mem_ehdr *ehdr, struct kexec_info *info,
 				name += ehdr->e_shdr[sym.st_shndx].sh_name;
 			}
 
-			dbgprintf("sym: %10s info: %02x other: %02x shndx: %lx value: %lx size: %lx\n",
+			dbgprintf("sym: %10s info: %02x other: %02x shndx: %x value: %llx size: %llx\n",
 				name,
 				sym.st_info,
 				sym.st_other,
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
