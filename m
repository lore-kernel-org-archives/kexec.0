Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UQGbV-00085o-Fq
 for kexec@lists.infradead.org; Thu, 11 Apr 2013 12:27:55 +0000
From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 4/5] kexec: X86: make crash_memory_range global and store its
 no of elements in crash_ranges
Date: Thu, 11 Apr 2013 14:26:46 +0200
Message-Id: <1365683207-42425-5-git-send-email-trenn@suse.de>
In-Reply-To: <1365683207-42425-1-git-send-email-trenn@suse.de>
References: <1365683207-42425-1-git-send-email-trenn@suse.de>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: horms@verge.net.au
Cc: kexec@lists.infradead.org, Thomas Renninger <trenn@suse.de>

Then exclude_region does not need nr_ranges to get passed.

Also reduce CRASH_MAX_MEMORY_RANGES which currently is:
MAX_MEMORY_RANGES + 2
to MAX_MEMORY_RANGES
MAX_MEMORY_RANGES is 1024 which is a way too big for the e820 table.
Also for the commandline 1024 memmap= parameters would have been a way too
big...

CC: Simon Horman <horms@verge.net.au>
CC: kexec@lists.infradead.org

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Thomas Renninger <Thomas Renninger" trenn@suse.de>
---
 kexec/arch/i386/crashdump-x86.c |   61 ++++++++++++++++++++-------------------
 kexec/arch/i386/crashdump-x86.h |    1 -
 kexec/arch/i386/kexec-x86.h     |    2 +
 3 files changed, 33 insertions(+), 31 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index a22768b..f7821bc 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -184,7 +184,8 @@ static void segregate_lowmem_region(int *nr_ranges, unsigned long lowmem_limit);
 
 /* Stores a sorted list of RAM memory ranges for which to create elf headers.
  * A separate program header is created for backup region */
-static struct memory_range crash_memory_range[CRASH_MAX_MEMORY_RANGES];
+struct memory_range crash_memory_range[MAX_MEMORY_RANGES];
+int crash_ranges;
 
 /* Memory region reserved for storing panic kernel and other data. */
 static struct memory_range crash_reserved_mem;
@@ -222,7 +223,7 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
 		char *str;
 		int type, consumed, count;
 
-		if (memory_ranges >= CRASH_MAX_MEMORY_RANGES)
+		if (memory_ranges >= MAX_MEMORY_RANGES)
 			break;
 		count = sscanf(line, "%Lx-%Lx : %n",
 			&start, &end, &consumed);
@@ -289,7 +290,7 @@ static int get_crash_memory_ranges_xen(struct memory_range **range,
 					int *ranges, unsigned long lowmem_limit)
 {
 	int j, rc, ret = -1;
-	struct e820entry e820entries[CRASH_MAX_MEMORY_RANGES];
+	struct e820entry e820entries[MAX_MEMORY_RANGES];
 	unsigned int i;
 #ifdef XENCTRL_HAS_XC_INTERFACE
 	xc_interface *xc;
@@ -313,14 +314,14 @@ static int get_crash_memory_ranges_xen(struct memory_range **range,
 	}
 #endif
 
-	rc = xc_get_machine_memory_map(xc, e820entries, CRASH_MAX_MEMORY_RANGES);
+	rc = xc_get_machine_memory_map(xc, e820entries, MAX_MEMORY_RANGES);
 
 	if (rc < 0) {
 		fprintf(stderr, "%s: xc_get_machine_memory_map: %s\n", __func__, strerror(-rc));
 		goto err;
 	}
 
-	for (i = 0, j = 0; i < rc && j < CRASH_MAX_MEMORY_RANGES; ++i, ++j) {
+	for (i = 0, j = 0; i < rc && j < MAX_MEMORY_RANGES; ++i, ++j) {
 		crash_memory_range[j].start = e820entries[i].addr;
 		crash_memory_range[j].end = e820entries[i].addr + e820entries[i].size - 1;
 		crash_memory_range[j].type = xen_e820_to_kexec_type(e820entries[i].type);
@@ -357,7 +358,7 @@ static int get_crash_memory_ranges_xen(struct memory_range **range,
 	}
 
 	rc = posix_memalign((void **)&e820entries, getpagesize(),
-			    sizeof(struct e820entry) * CRASH_MAX_MEMORY_RANGES);
+			    sizeof(struct e820entry) * MAX_MEMORY_RANGES);
 
 	if (rc) {
 		fprintf(stderr, "%s: posix_memalign(e820entries): %s\n", __func__, strerror(rc));
@@ -374,7 +375,7 @@ static int get_crash_memory_ranges_xen(struct memory_range **range,
 		goto err;
 	}
 
-	if (mlock(e820entries, sizeof(struct e820entry) * CRASH_MAX_MEMORY_RANGES) == -1) {
+	if (mlock(e820entries, sizeof(struct e820entry) * MAX_MEMORY_RANGES) == -1) {
 		fprintf(stderr, "%s: mlock(e820entries): %m\n", __func__);
 		goto err;
 	}
@@ -384,7 +385,7 @@ static int get_crash_memory_ranges_xen(struct memory_range **range,
 		goto err;
 	}
 
-	xen_memory_map->nr_entries = CRASH_MAX_MEMORY_RANGES;
+	xen_memory_map->nr_entries = MAX_MEMORY_RANGES;
 	set_xen_guest_handle(xen_memory_map->buffer, e820entries);
 
 	hypercall.op = __HYPERVISOR_memory_op;
@@ -399,7 +400,7 @@ static int get_crash_memory_ranges_xen(struct memory_range **range,
 	}
 
 	for (i = 0, j = 0; i < xen_memory_map->nr_entries &&
-				j < CRASH_MAX_MEMORY_RANGES; ++i, ++j) {
+				j < MAX_MEMORY_RANGES; ++i, ++j) {
 		crash_memory_range[j].start = e820entries[i].addr;
 		crash_memory_range[j].end = e820entries[i].addr + e820entries[i].size - 1;
 		crash_memory_range[j].type = xen_e820_to_kexec_type(e820entries[i].type);
@@ -415,7 +416,7 @@ static int get_crash_memory_ranges_xen(struct memory_range **range,
 
 err:
 	munlock(xen_memory_map, sizeof(struct xen_memory_map));
-	munlock(e820entries, sizeof(struct e820entry) * CRASH_MAX_MEMORY_RANGES);
+	munlock(e820entries, sizeof(struct e820entry) * MAX_MEMORY_RANGES);
 	free(xen_memory_map);
 	free(e820entries);
 	close(fd);
@@ -445,7 +446,7 @@ static void segregate_lowmem_region(int *nr_ranges, unsigned long lowmem_limit)
 
 	crash_memory_range[*nr_ranges].end = lowmem_limit - 1;
 
-	if (*nr_ranges >= CRASH_MAX_MEMORY_RANGES - 1)
+	if (*nr_ranges >= MAX_MEMORY_RANGES - 1)
 		return;
 
 	++*nr_ranges;
@@ -458,13 +459,13 @@ static void segregate_lowmem_region(int *nr_ranges, unsigned long lowmem_limit)
 /* Removes crash reserve region from list of memory chunks for whom elf program
  * headers have to be created. Assuming crash reserve region to be a single
  * continuous area fully contained inside one of the memory chunks */
-static int exclude_region(int *nr_ranges, uint64_t start, uint64_t end)
+static int exclude_region(uint64_t start, uint64_t end)
 {
 	int i, j, tidx = -1;
 	struct memory_range temp_region = {0, 0, 0};
 
 
-	for (i = 0; i < (*nr_ranges); i++) {
+	for (i = 0; i < (crash_ranges); i++) {
 		unsigned long long mstart, mend;
 		mstart = crash_memory_range[i].start;
 		mend = crash_memory_range[i].end;
@@ -484,16 +485,16 @@ static int exclude_region(int *nr_ranges, uint64_t start, uint64_t end)
 	}
 	/* Insert split memory region, if any. */
 	if (tidx >= 0) {
-		if (*nr_ranges == CRASH_MAX_MEMORY_RANGES) {
+		if (crash_ranges == MAX_MEMORY_RANGES) {
 			/* No space to insert another element. */
 			fprintf(stderr, "Error: Number of crash memory ranges"
 					" excedeed the max limit\n");
 			return -1;
 		}
-		for (j = (*nr_ranges - 1); j >= tidx; j--)
+		for (j = (crash_ranges - 1); j >= tidx; j--)
 			crash_memory_range[j+1] = crash_memory_range[j];
 		crash_memory_range[tidx] = temp_region;
-		(*nr_ranges)++;
+		(crash_ranges)++;
 	}
 	return 0;
 }
@@ -910,7 +911,7 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 {
 	void *tmp;
 	unsigned long sz, bufsz, memsz, elfcorehdr;
-	int nr_ranges = 0, align = 1024, i;
+	int align = 1024, i;
 	struct memory_range *mem_range, *memmap_p;
 	struct crash_elf_info elf_info;
 	unsigned kexec_arch;
@@ -944,35 +945,35 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 	}
 
 	if (xen_present()) {
-		if (get_crash_memory_ranges_xen(&mem_range, &nr_ranges,
+		if (get_crash_memory_ranges_xen(&mem_range, &crash_ranges,
 						elf_info.lowmem_limit) < 0)
 			return -1;
 	} else {
-		if (get_crash_memory_ranges(&mem_range, &nr_ranges,
+		if (get_crash_memory_ranges(&mem_range, &crash_ranges,
 						info->kexec_flags,
 						elf_info.lowmem_limit) < 0)
 			return -1;
 	}
 
-	if (exclude_region(&nr_ranges, crash_reserved_mem.start,
-				crash_reserved_mem.end) < 0)
+	if (exclude_region(crash_reserved_mem.start,
+			   crash_reserved_mem.end) < 0)
 		return -1;
 	if (crash_reserved_low_mem.start &&
-	    exclude_region(&nr_ranges, crash_reserved_low_mem.start,
-				crash_reserved_low_mem.end) < 0)
+	    exclude_region(crash_reserved_low_mem.start,
+			   crash_reserved_low_mem.end) < 0)
 		return -1;
 
 	if (!parse_iomem_single("GART\n", &start, &end)) {
 		/* exclude GART region if the system has one */
-		if (exclude_region(&nr_ranges, start, end) < 0)
+		if (exclude_region(start, end) < 0)
 			return -1;
 	}
 
-	get_backup_area(info, mem_range, nr_ranges);
+	get_backup_area(info, mem_range, crash_ranges);
 
 	dbgprintf("CRASH MEMORY RANGES\n");
 
-	for(i = 0; i < nr_ranges; ++i)
+	for(i = 0; i < crash_ranges; ++i)
 		dbgprintf("%016Lx-%016Lx (%d)\n", mem_range[i].start,
 			  mem_range[i].end, mem_range[i].type);
 
@@ -982,7 +983,7 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 	 */
 	if (arch_options.core_header_type == CORE_TYPE_UNDEF) {
 		arch_options.core_header_type =
-			get_core_type(&elf_info, mem_range, nr_ranges);
+			get_core_type(&elf_info, mem_range, crash_ranges);
 	}
 	/* Get the elf class... */
 	elf_info.class = ELFCLASS32;
@@ -1031,13 +1032,13 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 	/* Create elf header segment and store crash image data. */
 	if (arch_options.core_header_type == CORE_TYPE_ELF64) {
 		if (crash_create_elf64_headers(info, &elf_info, mem_range,
-						nr_ranges, &tmp, &bufsz,
+						crash_ranges, &tmp, &bufsz,
 						ELF_CORE_HEADER_ALIGN) < 0)
 			return EFAILED;
 	}
 	else {
 		if (crash_create_elf32_headers(info, &elf_info, mem_range,
-						nr_ranges, &tmp, &bufsz,
+						crash_ranges, &tmp, &bufsz,
 						ELF_CORE_HEADER_ALIGN) < 0)
 			return EFAILED;
 	}
@@ -1067,7 +1068,7 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 	cmdline_add_elfcorehdr(mod_cmdline, elfcorehdr);
 
 	/* Inform second kernel about the presence of ACPI tables. */
-	for (i = 0; i < CRASH_MAX_MEMORY_RANGES; i++) {
+	for (i = 0; i < MAX_MEMORY_RANGES; i++) {
 		unsigned long start, end;
 		if ( !( mem_range[i].type == RANGE_ACPI
 			|| mem_range[i].type == RANGE_ACPI_NVS
diff --git a/kexec/arch/i386/crashdump-x86.h b/kexec/arch/i386/crashdump-x86.h
index b61cf0a..ad389c9 100644
--- a/kexec/arch/i386/crashdump-x86.h
+++ b/kexec/arch/i386/crashdump-x86.h
@@ -21,7 +21,6 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline,
 #define X86_64_KERNEL_TEXT_SIZE  (512UL*1024*1024)
 
 #define CRASH_MAX_MEMMAP_NR	(KEXEC_MAX_SEGMENTS + 1)
-#define CRASH_MAX_MEMORY_RANGES	(MAX_MEMORY_RANGES + 2)
 
 /* Backup Region, First 640K of System RAM. */
 #define BACKUP_SRC_START	0x00000000
diff --git a/kexec/arch/i386/kexec-x86.h b/kexec/arch/i386/kexec-x86.h
index 5aa2a46..5b554dd 100644
--- a/kexec/arch/i386/kexec-x86.h
+++ b/kexec/arch/i386/kexec-x86.h
@@ -2,6 +2,8 @@
 #define KEXEC_X86_H
 
 #define MAX_MEMORY_RANGES 1024
+extern struct memory_range crash_memory_range[MAX_MEMORY_RANGES];
+extern int crash_ranges;
 
 enum coretype {
 	CORE_TYPE_UNDEF = 0,
-- 
1.7.6.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
