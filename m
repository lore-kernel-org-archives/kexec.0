Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga01.intel.com ([192.55.52.88])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NIBcg-0007eF-GF
	for kexec@lists.infradead.org; Wed, 09 Dec 2009 01:45:51 +0000
Subject: [PATCH] kexec jump support for x86_64
From: Huang Ying <ying.huang@intel.com>
Date: Wed, 09 Dec 2009 09:45:42 +0800
Message-ID: <1260323142.13131.45.camel@yhuang-dev.sh.intel.com>
Mime-Version: 1.0
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

x86_64 specific support, including crash memory range and purgatory setup.
Corresponding kernel support has been merged already.

Signed-off-by: Huang Ying <ying.huang@intel.com>

---
 kexec/arch/x86_64/crashdump-x86_64.c     |   48 ++++++++++++++++++++++---------
 purgatory/arch/x86_64/purgatory-x86_64.c |   11 ++++++-
 purgatory/arch/x86_64/setup-x86_64.S     |    3 +
 3 files changed, 48 insertions(+), 14 deletions(-)

--- a/kexec/arch/x86_64/crashdump-x86_64.c
+++ b/kexec/arch/x86_64/crashdump-x86_64.c
@@ -161,7 +161,8 @@ static struct memory_range crash_reserve
  * to look into down the line. May be something like /proc/kernelmem or may
  * be zone data structures exported from kernel.
  */
-static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
+static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
+				   int kexec_flags)
 {
 	const char *iomem= proc_iomem();
 	int memory_ranges = 0, gart = 0;
@@ -179,10 +180,12 @@ static int get_crash_memory_ranges(struc
 
 	/* First entry is for first 640K region. Different bios report first
 	 * 640K in different manner hence hardcoding it */
-	crash_memory_range[0].start = 0x00000000;
-	crash_memory_range[0].end = 0x0009ffff;
-	crash_memory_range[0].type = RANGE_RAM;
-	memory_ranges++;
+	if (!(kexec_flags & KEXEC_PRESERVE_CONTEXT)) {
+		crash_memory_range[0].start = 0x00000000;
+		crash_memory_range[0].end = 0x0009ffff;
+		crash_memory_range[0].type = RANGE_RAM;
+		memory_ranges++;
+	}
 
 	while(fgets(line, sizeof(line), fp) != 0) {
 		char *str;
@@ -239,6 +242,22 @@ static int get_crash_memory_ranges(struc
 		memory_ranges++;
 	}
 	fclose(fp);
+	if (kexec_flags & KEXEC_PRESERVE_CONTEXT) {
+		int i;
+		for (i = 0; i < memory_ranges; i++) {
+			if (crash_memory_range[i].end > 0x0009ffff) {
+				crash_reserved_mem.start = \
+					crash_memory_range[i].start;
+				break;
+			}
+		}
+		if (crash_reserved_mem.start >= mem_max) {
+			fprintf(stderr, "Too small mem_max: 0x%llx.\n", mem_max);
+			return -1;
+		}
+		crash_reserved_mem.end = mem_max;
+		crash_reserved_mem.type = RANGE_RAM;
+	}
 	if (exclude_region(&memory_ranges, crash_reserved_mem.start,
 				crash_reserved_mem.end) < 0)
 		return -1;
@@ -590,7 +609,8 @@ int load_crashdump_segments(struct kexec
 	if (get_kernel_vaddr_and_size(info))
 		return -1;
 
-	if (get_crash_memory_ranges(&mem_range, &nr_ranges) < 0)
+	if (get_crash_memory_ranges(&mem_range, &nr_ranges,
+				    info->kexec_flags) < 0)
 		return -1;
 
 	/* Memory regions which panic kernel can safely use to boot into */
@@ -602,13 +622,15 @@ int load_crashdump_segments(struct kexec
 	add_memmap(memmap_p, crash_reserved_mem.start, sz);
 
 	/* Create a backup region segment to store backup data*/
-	sz = (BACKUP_SRC_SIZE + align - 1) & ~(align - 1);
-	tmp = xmalloc(sz);
-	memset(tmp, 0, sz);
-	info->backup_start = add_buffer(info, tmp, sz, sz, align,
-				0, max_addr, 1);
-	if (delete_memmap(memmap_p, info->backup_start, sz) < 0)
-		return -1;
+	if (!(info->kexec_flags & KEXEC_PRESERVE_CONTEXT)) {
+		sz = (BACKUP_SRC_SIZE + align - 1) & ~(align - 1);
+		tmp = xmalloc(sz);
+		memset(tmp, 0, sz);
+		info->backup_start = add_buffer(info, tmp, sz, sz, align,
+						0, max_addr, 1);
+		if (delete_memmap(memmap_p, info->backup_start, sz) < 0)
+			return -1;
+	}
 
 	/* Create elf header segment and store crash image data. */
 	if (crash_create_elf64_headers(info, &elf_info,
--- a/purgatory/arch/x86_64/purgatory-x86_64.c
+++ b/purgatory/arch/x86_64/purgatory-x86_64.c
@@ -6,6 +6,7 @@
 uint8_t reset_vga = 0;
 uint8_t legacy_pic = 0;
 uint8_t panic_kernel = 0;
+unsigned long jump_back_entry = 0;
 char *cmdline_end = NULL;
 
 void setup_arch(void)
@@ -14,8 +15,16 @@ void setup_arch(void)
 	if (legacy_pic)   x86_setup_legacy_pic();
 }
 
+void x86_setup_jump_back_entry(void)
+{
+	if (cmdline_end)
+		sprintf(cmdline_end, " kexec_jump_back_entry=0x%lx",
+			jump_back_entry);
+}
+
 /* This function can be used to execute after the SHA256 verification. */
 void post_verification_setup_arch(void)
 {
-	 if (panic_kernel)   crashdump_backup_memory();
+	if (panic_kernel)    crashdump_backup_memory();
+	if (jump_back_entry) x86_setup_jump_back_entry();
 }
--- a/purgatory/arch/x86_64/setup-x86_64.S
+++ b/purgatory/arch/x86_64/setup-x86_64.S
@@ -41,6 +41,9 @@ purgatory_start:
 
 	/* In 64bit mode the code segment is meaningless */
 
+	movq	0(%rsp), %rax
+	movq	%rax, jump_back_entry
+
 	/* Setup a stack */
 	movq	$lstack_end, %rsp
 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
