Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1J4Y7m-0008E7-1l
	for kexec@lists.infradead.org; Tue, 18 Dec 2007 08:48:36 +0000
MIME-Version: 1.0
Subject: [PATCH 1/8] Enable building a 32 bit binary for ppc64 platforms.
Message-Id: <1197967675.855616.615518870292.1.gpush@pokey>
In-Reply-To: <1197967675.854275.930419561848.0.gpush@pokey>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Tue, 18 Dec 2007 17:47:55 +0900
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

From: David Woodhouse <dwmw2@infradead.org>

Based on
http://cvs.fedora.redhat.com/viewcvs/rpms/kexec-tools/devel/kexec-tools-1.101-ppc-boots-ppc64.patch?rev=1.2&view=auto

64 bit: OK
32 bit: purgatory build fails

Work-in-progress-by: Geoff Levand <geoffrey.levand@am.sony.com>
Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 kexec/arch/ppc64/crashdump-ppc64.h     |    4 ++--
 kexec/arch/ppc64/kexec-elf-ppc64.c     |   26 +++++++++++++-------------
 kexec/arch/ppc64/kexec-elf-rel-ppc64.c |    4 ++--
 kexec/arch/ppc64/kexec-ppc64.c         |   20 ++++++++++----------
 kexec/arch/ppc64/kexec-ppc64.h         |    2 +-
 kexec/kexec-sha256.h                   |    4 ++--
 purgatory/arch/ppc64/Makefile          |    2 ++
 purgatory/purgatory.c                  |    2 ++
 8 files changed, 34 insertions(+), 30 deletions(-)

diff --git a/kexec/arch/ppc64/crashdump-ppc64.h b/kexec/arch/ppc64/crashdump-ppc64.h
index 583338a..0ce9c46 100644
--- a/kexec/arch/ppc64/crashdump-ppc64.h
+++ b/kexec/arch/ppc64/crashdump-ppc64.h
@@ -23,8 +23,8 @@ void add_usable_mem_rgns(unsigned long long base, unsigned long long size);
 #define _ALIGN_UP(addr,size)	(((addr)+((size)-1))&(~((size)-1)))
 #define _ALIGN_DOWN(addr,size)	((addr)&(~((size)-1)))
 
-extern unsigned long long crash_base;
-extern unsigned long long crash_size;
+extern uint64_t crash_base;
+extern uint64_t crash_size;
 extern unsigned int rtas_base;
 extern unsigned int rtas_size;
 
diff --git a/kexec/arch/ppc64/kexec-elf-ppc64.c b/kexec/arch/ppc64/kexec-elf-ppc64.c
index 65f289b..165a0f6 100644
--- a/kexec/arch/ppc64/kexec-elf-ppc64.c
+++ b/kexec/arch/ppc64/kexec-elf-ppc64.c
@@ -42,7 +42,7 @@
 #define BOOTLOADER         "kexec"
 #define BOOTLOADER_VERSION VERSION
 
-unsigned long initrd_base, initrd_size;
+uint64_t initrd_base, initrd_size;
 unsigned char reuse_initrd = 0;
 const char *ramdisk;
 
@@ -83,19 +83,19 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
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
@@ -237,10 +237,10 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
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
 
@@ -270,25 +270,25 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
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
 
diff --git a/kexec/arch/ppc64/kexec-elf-rel-ppc64.c b/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
index c5fd561..1c9fce5 100644
--- a/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
+++ b/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
@@ -101,10 +101,10 @@ void machine_apply_elf_rel(struct mem_ehdr *ehdr, unsigned long r_type,
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
diff --git a/kexec/arch/ppc64/kexec-ppc64.c b/kexec/arch/ppc64/kexec-ppc64.c
index 3d233cf..9333f29 100644
--- a/kexec/arch/ppc64/kexec-ppc64.c
+++ b/kexec/arch/ppc64/kexec-ppc64.c
@@ -41,7 +41,7 @@ static struct memory_range *base_memory_range = NULL;
 static unsigned long long rmo_top;
 unsigned long long memory_max = 0;
 static int nr_memory_ranges, nr_exclude_ranges;
-unsigned long long crash_base, crash_size;
+uint64_t crash_base, crash_size;
 unsigned int rtas_base, rtas_size;
 int max_memory_ranges;
 
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
@@ -292,7 +292,7 @@ static int get_devtree_details(unsigned long kexec_flags)
 				perror(fname);
 				goto error_opencdir;
 			}
-			if (fread(&kernel_end, sizeof(unsigned long), 1, file) != 1) {
+			if (fread(&kernel_end, sizeof(uint64_t), 1, file) != 1) {
 				perror(fname);
 				goto error_openfile;
 			}
@@ -312,7 +312,7 @@ static int get_devtree_details(unsigned long kexec_flags)
 					perror(fname);
 					goto error_opencdir;
 				}
-				if (fread(&crash_base, sizeof(unsigned long), 1,
+				if (fread(&crash_base, sizeof(uint64_t), 1,
 						file) != 1) {
 					perror(fname);
 					goto error_openfile;
@@ -327,7 +327,7 @@ static int get_devtree_details(unsigned long kexec_flags)
 					perror(fname);
 					goto error_opencdir;
 				}
-				if (fread(&crash_size, sizeof(unsigned long), 1,
+				if (fread(&crash_size, sizeof(uint64_t), 1,
 						file) != 1) {
 					perror(fname);
 					goto error_openfile;
@@ -356,7 +356,7 @@ static int get_devtree_details(unsigned long kexec_flags)
 				perror(fname);
 				goto error_opendir;
 			}
-			if (fread(&htab_base, sizeof(unsigned long), 1, file) != 1) {
+			if (fread(&htab_base, sizeof(uint64_t), 1, file) != 1) {
 				perror(fname);
 				goto error_openfile;
 			}
@@ -368,7 +368,7 @@ static int get_devtree_details(unsigned long kexec_flags)
 				perror(fname);
 				goto error_opencdir;
 			}
-			if (fread(&htab_size, sizeof(unsigned long), 1, file) != 1) {
+			if (fread(&htab_size, sizeof(uint64_t), 1, file) != 1) {
 				perror(fname);
 				goto error_openfile;
 			}
@@ -487,7 +487,7 @@ static int get_devtree_details(unsigned long kexec_flags)
 				perror(fname);
 				goto error_opendir;
 			}
-			if (fread(&tce_base, sizeof(unsigned long), 1, file) != 1) {
+			if (fread(&tce_base, sizeof(uint64_t), 1, file) != 1) {
 				perror(fname);
 				goto error_openfile;
 				return -1;
diff --git a/kexec/arch/ppc64/kexec-ppc64.h b/kexec/arch/ppc64/kexec-ppc64.h
index 26c70ba..242947b 100644
--- a/kexec/arch/ppc64/kexec-ppc64.h
+++ b/kexec/arch/ppc64/kexec-ppc64.h
@@ -14,7 +14,7 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 void elf_ppc64_usage(void);
 void reserve(unsigned long long where, unsigned long long length);
 
-extern unsigned long initrd_base, initrd_size;
+extern uint64_t initrd_base, initrd_size;
 extern int max_memory_ranges;
 extern unsigned char reuse_initrd;
 
diff --git a/kexec/kexec-sha256.h b/kexec/kexec-sha256.h
index d414ec5..b4bb856 100644
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
diff --git a/purgatory/arch/ppc64/Makefile b/purgatory/arch/ppc64/Makefile
index 82b1654..0406278 100644
--- a/purgatory/arch/ppc64/Makefile
+++ b/purgatory/arch/ppc64/Makefile
@@ -6,3 +6,5 @@ PURGATORY_S_SRCS+= purgatory/arch/ppc64/v2wrap.S
 PURGATORY_C_SRCS += purgatory/arch/ppc64/purgatory-ppc64.c
 PURGATORY_C_SRCS += purgatory/arch/ppc64/console-ppc64.c
 PURGATORY_C_SRCS += purgatory/arch/ppc64/crashdump_backup.c
+
+PCFLAGS += -m64 -mcall-aixdesc
diff --git a/purgatory/purgatory.c b/purgatory/purgatory.c
index ad0cac2..aacbb3b 100644
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
