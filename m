Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from outbound-dub.frontbridge.com ([213.199.154.16]
	helo=outbound1-dub-R.bigfish.com)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HwLe1-0004Qd-Ib
	for kexec@lists.infradead.org; Thu, 07 Jun 2007 13:19:39 -0400
Message-ID: <46683C9F.1020903@am.sony.com>
Date: Thu, 07 Jun 2007 10:13:03 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
Subject: [RFC] kexec: Build 32 bit kexec for ppc64
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: David Woodhouse <dwmw2@infradead.org>

Enable building a 32 bit binary for ppc64 platforms.

Based on
http://cvs.fedora.redhat.com/viewcvs/rpms/kexec-tools/devel/kexec-tools-1.101-ppc-boots-ppc64.patch?rev=1.2&view=auto

64 bit: OK
32 bit: purgatory build fails

From: David Woodhouse <dwmw2@infradead.org>
Work-in-progress-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 kexec/arch/ppc64/crashdump-ppc64.h     |    4 ++--
 kexec/arch/ppc64/kexec-elf-ppc64.c     |   26 +++++++++++++-------------
 kexec/arch/ppc64/kexec-elf-rel-ppc64.c |    4 ++--
 kexec/arch/ppc64/kexec-ppc64.c         |   18 +++++++++---------
 kexec/arch/ppc64/kexec-ppc64.h         |    2 +-
 kexec/kexec-sha256.h                   |    4 ++--
 purgatory/arch/ppc64/Makefile          |    2 ++
 purgatory/purgatory.c                  |    2 ++
 8 files changed, 33 insertions(+), 29 deletions(-)

--- a/kexec/arch/ppc64/crashdump-ppc64.h
+++ b/kexec/arch/ppc64/crashdump-ppc64.h
@@ -23,8 +23,8 @@ void add_usable_mem_rgns(unsigned long l
 #define _ALIGN_UP(addr,size)	(((addr)+((size)-1))&(~((size)-1)))
 #define _ALIGN_DOWN(addr,size)	((addr)&(~((size)-1)))
 
-extern unsigned long long crash_base;
-extern unsigned long long crash_size;
+extern uint64_t crash_base;
+extern uint64_t crash_size;
 extern unsigned int rtas_base;
 extern unsigned int rtas_size;
 
--- a/kexec/arch/ppc64/kexec-elf-ppc64.c
+++ b/kexec/arch/ppc64/kexec-elf-ppc64.c
@@ -42,7 +42,7 @@
 #define BOOTLOADER         "kexec"
 #define BOOTLOADER_VERSION VERSION
 
-unsigned long initrd_base, initrd_size;
+uint64_t initrd_base, initrd_size;
 unsigned char reuse_initrd = 0;
 const char *ramdisk;
 
@@ -83,19 +83,19 @@ int elf_ppc64_load(int argc, char **argv
 	char *cmdline, *modified_cmdline;
 	const char *devicetreeblob;
 	int cmdline_len, modified_cmdline_len;
-	unsigned long long max_addr, hole_addr;
+	uint64_t max_addr, hole_addr;
 	unsigned char *seg_buf = NULL;
 	off_t seg_size = 0;
 	struct mem_phdr *phdr;
 	size_t size;
-	unsigned long long *rsvmap_ptr;
+	uint64_t *rsvmap_ptr;
 	struct bootblock *bb_ptr;
 	unsigned int nr_segments, i;
 	int result, opt;
-	unsigned long my_kernel, my_dt_offset;
+	uint64_t my_kernel, my_dt_offset;
 	unsigned int my_panic_kernel;
-	unsigned long my_stack, my_backup_start;
-	unsigned long toc_addr;
+	uint64_t my_stack, my_backup_start;
+	uint64_t toc_addr;
 	unsigned int slave_code[256/sizeof (unsigned int)], master_entry;
 
 #define OPT_APPEND     (OPT_ARCH_MAX+0)
@@ -237,10 +237,10 @@ int elf_ppc64_load(int argc, char **argv
 		}
 		seg_buf = (unsigned char *)slurp_file(ramdisk, &seg_size);
 		add_buffer(info, seg_buf, seg_size, seg_size, 0, 0, max_addr, 1);
-		hole_addr = (unsigned long long)
+		hole_addr = (uint64_t)
 			info->segment[info->nr_segments-1].mem;
 		initrd_base = hole_addr;
-		initrd_size = (unsigned long long)
+		initrd_size = (uint64_t)
 			info->segment[info->nr_segments-1].memsz;
 	} /* ramdisk */
 
@@ -270,25 +270,25 @@ int elf_ppc64_load(int argc, char **argv
 	 */
 	bb_ptr = (struct bootblock *)(
 		(unsigned char *)info->segment[(info->nr_segments)-1].buf);
-	rsvmap_ptr = (unsigned long long *)(
+	rsvmap_ptr = (uint64_t *)(
 		(unsigned char *)info->segment[(info->nr_segments)-1].buf +
 		bb_ptr->off_mem_rsvmap);
 	while (*rsvmap_ptr || *(rsvmap_ptr+1))
 		rsvmap_ptr += 2;
 	rsvmap_ptr -= 2;
-	*rsvmap_ptr = (unsigned long long)(
+	*rsvmap_ptr = (uint64_t)(
 		info->segment[(info->nr_segments)-1].mem);
 	rsvmap_ptr++;
-	*rsvmap_ptr = (unsigned long long)bb_ptr->totalsize;
+	*rsvmap_ptr = (uint64_t)bb_ptr->totalsize;
 
 	nr_segments = info->nr_segments;
 
 	/* Set kernel */
-	my_kernel = (unsigned long )info->segment[0].mem;
+	my_kernel = (uint64_t)info->segment[0].mem;
 	elf_rel_set_symbol(&info->rhdr, "kernel", &my_kernel, sizeof(my_kernel));
 
 	/* Set dt_offset */
-	my_dt_offset = (unsigned long )info->segment[nr_segments-1].mem;
+	my_dt_offset = (uint64_t)info->segment[nr_segments-1].mem;
 	elf_rel_set_symbol(&info->rhdr, "dt_offset", &my_dt_offset,
 				sizeof(my_dt_offset));
 
--- a/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
+++ b/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
@@ -101,10 +101,10 @@ void machine_apply_elf_rel(struct mem_eh
 		break;
 
 	case R_PPC64_ADDR16_HIGHEST:
-		*(uint16_t *)location = ((value>>48)  & 0xffff);
+		*(uint16_t *)location = (((uint64_t)value>>48)  & 0xffff);
 		break;
 	case R_PPC64_ADDR16_HIGHER:
-		*(uint16_t *)location = ((value>>32)  & 0xffff);
+		*(uint16_t *)location = (((uint64_t)value>>32)  & 0xffff);
 		break;
 
 	default:
--- a/kexec/arch/ppc64/kexec-ppc64.c
+++ b/kexec/arch/ppc64/kexec-ppc64.c
@@ -203,10 +203,10 @@ static int get_base_ranges(void)
 				break;
 			}
 			base_memory_range[local_memory_ranges].start =
-				((unsigned long long *)buf)[0];
+				((uint64_t *)buf)[0];
 			base_memory_range[local_memory_ranges].end  =
 				base_memory_range[local_memory_ranges].start +
-				((unsigned long long *)buf)[1];
+				((uint64_t *)buf)[1];
 			base_memory_range[local_memory_ranges].type = RANGE_RAM;
 			local_memory_ranges++;
 			dbgprintf("%016llx-%016llx : %x\n",
@@ -231,7 +231,7 @@ static int get_base_ranges(void)
 static int sort_ranges(void)
 {
 	int i, j;
-	unsigned long long tstart, tend;
+	uint64_t tstart, tend;
 	for (i = 0; i < nr_exclude_ranges - 1; i++) {
 		for (j = 0; j < nr_exclude_ranges - i - 1; j++) {
 			if (exclude_range[j].start > exclude_range[j+1].start) {
@@ -292,7 +292,7 @@ static int get_devtree_details(unsigned 
 				perror(fname);
 				goto error_opencdir;
 			}
-			if (fread(&kernel_end, sizeof(unsigned long), 1, file) != 1) {
+			if (fread(&kernel_end, sizeof(uint64_t), 1, file) != 1) {
 				perror(fname);
 				goto error_openfile;
 			}
@@ -312,7 +312,7 @@ static int get_devtree_details(unsigned 
 					perror(fname);
 					goto error_opencdir;
 				}
-				if (fread(&crash_base, sizeof(unsigned long), 1,
+				if (fread(&crash_base, sizeof(uint64_t), 1,
 						file) != 1) {
 					perror(fname);
 					goto error_openfile;
@@ -327,7 +327,7 @@ static int get_devtree_details(unsigned 
 					perror(fname);
 					goto error_opencdir;
 				}
-				if (fread(&crash_size, sizeof(unsigned long), 1,
+				if (fread(&crash_size, sizeof(uint64_t), 1,
 						file) != 1) {
 					perror(fname);
 					goto error_openfile;
@@ -356,7 +356,7 @@ static int get_devtree_details(unsigned 
 				perror(fname);
 				goto error_opendir;
 			}
-			if (fread(&htab_base, sizeof(unsigned long), 1, file) != 1) {
+			if (fread(&htab_base, sizeof(uint64_t), 1, file) != 1) {
 				perror(fname);
 				goto error_openfile;
 			}
@@ -368,7 +368,7 @@ static int get_devtree_details(unsigned 
 				perror(fname);
 				goto error_opencdir;
 			}
-			if (fread(&htab_size, sizeof(unsigned long), 1, file) != 1) {
+			if (fread(&htab_size, sizeof(uint64_t), 1, file) != 1) {
 				perror(fname);
 				goto error_openfile;
 			}
@@ -487,7 +487,7 @@ static int get_devtree_details(unsigned 
 				perror(fname);
 				goto error_opendir;
 			}
-			if (fread(&tce_base, sizeof(unsigned long), 1, file) != 1) {
+			if (fread(&tce_base, sizeof(uint64_t), 1, file) != 1) {
 				perror(fname);
 				goto error_openfile;
 				return -1;
--- a/kexec/arch/ppc64/kexec-ppc64.h
+++ b/kexec/arch/ppc64/kexec-ppc64.h
@@ -14,7 +14,7 @@ int elf_ppc64_load(int argc, char **argv
 void elf_ppc64_usage(void);
 void reserve(unsigned long long where, unsigned long long length);
 
-extern unsigned long initrd_base, initrd_size;
+extern uint64_t initrd_base, initrd_size;
 extern int max_memory_ranges;
 extern unsigned char reuse_initrd;
 
--- a/kexec/kexec-sha256.h
+++ b/kexec/kexec-sha256.h
@@ -2,8 +2,8 @@
 #define KEXEC_SHA256_H
 
 struct sha256_region {
-	const void *start;
-	unsigned long len;
+	uint64_t start;
+	uint64_t len;
 };
 
 #define SHA256_REGIONS 16
--- a/purgatory/arch/ppc64/Makefile
+++ b/purgatory/arch/ppc64/Makefile
@@ -6,3 +6,5 @@ PURGATORY_S_SRCS+= purgatory/arch/ppc64/
 PURGATORY_C_SRCS += purgatory/arch/ppc64/purgatory-ppc64.c
 PURGATORY_C_SRCS += purgatory/arch/ppc64/console-ppc64.c
 PURGATORY_C_SRCS += purgatory/arch/ppc64/crashdump_backup.c
+
+PCFLAGS += -m64 -mcall-aixdesc
--- a/purgatory/purgatory.c
+++ b/purgatory/purgatory.c
@@ -46,3 +46,5 @@ void purgatory(void)
 	verify_sha256_digest();
 	post_verification_setup_arch();
 }
+
+#include "../util_lib/sha256.c"


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
