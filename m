Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from outbound-sin.frontbridge.com ([207.46.51.80]
	helo=SG2EHSOBE001.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KdbB6-0005Nx-H4
	for kexec@lists.infradead.org; Thu, 11 Sep 2008 01:41:01 +0000
Message-ID: <48C8771E.40502@am.sony.com>
Date: Wed, 10 Sep 2008 18:40:46 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
Subject: [kexec patch 2/2] Fix ppc64 build warnings
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: horms@verge.net.au
Cc: kexec@lists.infradead.org, Cell Broadband Engine OSS Development <cbe-oss-dev@ozlabs.org>

Fix these ppc64 32 bit build warnings:

 kexec/arch/ppc64/kexec-zImage-ppc64.c: In function 'zImage_ppc64_load':
 kexec/arch/ppc64/kexec-zImage-ppc64.c:164: warning: cast to pointer from integer of different size
 kexec/arch/ppc64/kexec-elf-ppc64.c: In function 'elf_ppc64_load':
 kexec/arch/ppc64/kexec-elf-ppc64.c:121: warning: integer constant is too large for 'unsigned long' type
 kexec/arch/ppc64/kexec-elf-ppc64.c:237: warning: cast from pointer to integer of different size
 kexec/arch/ppc64/kexec-elf-ppc64.c:276: warning: cast from pointer to integer of different size
 kexec/arch/ppc64/kexec-elf-ppc64.c:283: warning: cast from pointer to integer of different size
 kexec/arch/ppc64/kexec-elf-ppc64.c:287: warning: cast from pointer to integer of different size
 kexec/arch/ppc64/kexec-elf-ppc64.c:341: warning: format '%lx' expects type 'long unsigned int', but argument 3 has type 'uint64_t'
 kexec/arch/ppc64/kexec-elf-ppc64.c:352: warning: format '%ld' expects type 'long int', but argument 5 has type 'size_t'
 kexec/arch/ppc64/crashdump-ppc64.c:45: warning: integer constant is too large for 'long' type
 kexec/arch/ppc64/crashdump-ppc64.c:46: warning: integer constant is too large for 'long' type
 kexec/arch/ppc64/crashdump-ppc64.c:56: warning: integer constant is too large for 'long' type
 kexec/arch/ppc64/crashdump-ppc64.c:57: warning: integer constant is too large for 'long' type

Tested on PS3 (ppc64) with 32 and 64 bit builds. 

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 kexec/arch/ppc64/crashdump-ppc64.h    |    4 ++--
 kexec/arch/ppc64/kexec-elf-ppc64.c    |   26 ++++++++++++++------------
 kexec/arch/ppc64/kexec-zImage-ppc64.c |    2 +-
 3 files changed, 17 insertions(+), 15 deletions(-)

--- a/kexec/arch/ppc64/crashdump-ppc64.h
+++ b/kexec/arch/ppc64/crashdump-ppc64.h
@@ -6,9 +6,9 @@ int load_crashdump_segments(struct kexec
 				uint64_t max_addr, unsigned long min_base);
 void add_usable_mem_rgns(unsigned long long base, unsigned long long size);
 
-#define PAGE_OFFSET     0xC000000000000000
+#define PAGE_OFFSET     0xC000000000000000ULL
 #define KERNELBASE      PAGE_OFFSET
-#define VMALLOCBASE     0xD000000000000000
+#define VMALLOCBASE     0xD000000000000000ULL
 
 #define __pa(x)         ((unsigned long)(x)-PAGE_OFFSET)
 #define MAXMEM          (-KERNELBASE-VMALLOCBASE)
--- a/kexec/arch/ppc64/kexec-elf-ppc64.c
+++ b/kexec/arch/ppc64/kexec-elf-ppc64.c
@@ -118,7 +118,7 @@ int elf_ppc64_load(int argc, char **argv
 	cmdline = 0;
 	ramdisk = 0;
 	devicetreeblob = 0;
-	max_addr = 0xFFFFFFFFFFFFFFFFUL;
+	max_addr = 0xFFFFFFFFFFFFFFFFULL;
 	hole_addr = 0;
 
 	while ((opt = getopt_long(argc, argv, short_options,
@@ -233,7 +233,7 @@ int elf_ppc64_load(int argc, char **argv
 		}
 		seg_buf = (unsigned char *)slurp_file(ramdisk, &seg_size);
 		add_buffer(info, seg_buf, seg_size, seg_size, 0, 0, max_addr, 1);
-		hole_addr = (uint64_t)
+		hole_addr = (uintptr_t)
 			info->segment[info->nr_segments-1].mem;
 		initrd_base = hole_addr;
 		initrd_size = (uint64_t)
@@ -272,7 +272,7 @@ int elf_ppc64_load(int argc, char **argv
 	while (*rsvmap_ptr || *(rsvmap_ptr+1))
 		rsvmap_ptr += 2;
 	rsvmap_ptr -= 2;
-	*rsvmap_ptr = (uint64_t)(
+	*rsvmap_ptr = (uintptr_t)(
 		info->segment[(info->nr_segments)-1].mem);
 	rsvmap_ptr++;
 	*rsvmap_ptr = (uint64_t)bb_ptr->totalsize;
@@ -280,11 +280,11 @@ int elf_ppc64_load(int argc, char **argv
 	nr_segments = info->nr_segments;
 
 	/* Set kernel */
-	my_kernel = (uint64_t)info->segment[0].mem;
+	my_kernel = (uintptr_t)info->segment[0].mem;
 	elf_rel_set_symbol(&info->rhdr, "kernel", &my_kernel, sizeof(my_kernel));
 
 	/* Set dt_offset */
-	my_dt_offset = (uint64_t)info->segment[nr_segments-1].mem;
+	my_dt_offset = (uintptr_t)info->segment[nr_segments-1].mem;
 	elf_rel_set_symbol(&info->rhdr, "dt_offset", &my_dt_offset,
 				sizeof(my_dt_offset));
 
@@ -338,17 +338,19 @@ int elf_ppc64_load(int argc, char **argv
 				sizeof(toc_addr));
 
 	fprintf(stderr, "info->entry is %p\n", info->entry);
-	fprintf(stderr, "kernel is %lx\n", my_kernel);
-	fprintf(stderr, "dt_offset is %lx\n", my_dt_offset);
+	fprintf(stderr, "kernel is %llx\n", (unsigned long long)my_kernel);
+	fprintf(stderr, "dt_offset is %llx\n",
+		(unsigned long long)my_dt_offset);
 	fprintf(stderr, "panic_kernel is %x\n", my_panic_kernel);
-	fprintf(stderr, "backup_start is %lx\n", my_backup_start);
-	fprintf(stderr, "stack is %lx\n", my_stack);
-	fprintf(stderr, "toc_addr is %lx\n", toc_addr);
-	fprintf(stderr, "purgatory size is %lu\n", purgatory_size);
+	fprintf(stderr, "backup_start is %llx\n",
+		(unsigned long long)my_backup_start);
+	fprintf(stderr, "stack is %llx\n", (unsigned long long)my_stack);
+	fprintf(stderr, "toc_addr is %llx\n", (unsigned long long)toc_addr);
+	fprintf(stderr, "purgatory size is %zu\n", purgatory_size);
 #endif
 
 	for (i = 0; i < nr_segments; i++)
-		fprintf(stderr, "segment[%d].mem:%p memsz:%ld\n", i,
+		fprintf(stderr, "segment[%d].mem:%p memsz:%zu\n", i,
 			info->segment[i].mem, info->segment[i].memsz);
 
 	return 0;
--- a/kexec/arch/ppc64/kexec-zImage-ppc64.c
+++ b/kexec/arch/ppc64/kexec-zImage-ppc64.c
@@ -161,7 +161,7 @@ int zImage_ppc64_load(FILE *file, int ar
 	segment->mem = (void *) load_loc;
 	segment->memsz = memsize;
 	segment->bufsz = filesize;
-	*ret_entry = (void *)((uint64_t)elf.e_entry);
+	*ret_entry = (void *)(uintptr_t)elf.e_entry;
 	*ret_nr_segments = i - 1;
 	free(ph);
 	return 0;




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
