Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UQGbV-00085n-Fx
 for kexec@lists.infradead.org; Thu, 11 Apr 2013 12:27:52 +0000
From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 3/5] kexec: X86: Do not exclude memory regions in each
 get_xy_memory_range() func
Date: Thu, 11 Apr 2013 14:26:45 +0200
Message-Id: <1365683207-42425-4-git-send-email-trenn@suse.de>
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

This allows further code cleanup later.

CC: Simon Horman <horms@verge.net.au>
CC: kexec@lists.infradead.org

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Thomas Renninger <Thomas Renninger" trenn@suse.de>
---
 kexec/arch/i386/crashdump-x86.c |   47 +++++++++++++++------------------------
 1 files changed, 18 insertions(+), 29 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 3f8593d..a22768b 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -181,7 +181,6 @@ static int get_kernel_vaddr_and_size(struct kexec_info *UNUSED(info),
 
 /* Forward Declaration. */
 static void segregate_lowmem_region(int *nr_ranges, unsigned long lowmem_limit);
-static int exclude_region(int *nr_ranges, uint64_t start, uint64_t end);
 
 /* Stores a sorted list of RAM memory ranges for which to create elf headers.
  * A separate program header is created for backup region */
@@ -207,11 +206,10 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
 				   int kexec_flags, unsigned long lowmem_limit)
 {
 	const char *iomem = proc_iomem();
-	int memory_ranges = 0, gart = 0;
+	int memory_ranges = 0;
 	char line[MAX_LINE];
 	FILE *fp;
 	unsigned long long start, end;
-	uint64_t gart_start = 0, gart_end = 0;
 
 	fp = fopen(iomem, "r");
 	if (!fp) {
@@ -249,11 +247,6 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
 			type = RANGE_ACPI_NVS;
 		} else if(memcmp(str,"reserved\n", 9) == 0 ) {
 			type = RANGE_RESERVED;
-		} else if (memcmp(str, "GART\n", 5) == 0) {
-			gart_start = start;
-			gart_end = end;
-			gart = 1;
-			continue;
 		} else {
 			continue;
 		}
@@ -284,18 +277,6 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
 		crash_reserved_mem.end = mem_max;
 		crash_reserved_mem.type = RANGE_RAM;
 	}
-	if (exclude_region(&memory_ranges, crash_reserved_mem.start,
-				crash_reserved_mem.end) < 0)
-		return -1;
-	if (crash_reserved_low_mem.start &&
-	    exclude_region(&memory_ranges, crash_reserved_low_mem.start,
-				crash_reserved_low_mem.end) < 0)
-		return -1;
-	if (gart) {
-		/* exclude GART region if the system has one */
-		if (exclude_region(&memory_ranges, gart_start, gart_end) < 0)
-			return -1;
-	}
 	*range = crash_memory_range;
 	*ranges = memory_ranges;
 
@@ -351,10 +332,6 @@ static int get_crash_memory_ranges_xen(struct memory_range **range,
 
 	qsort(*range, *ranges, sizeof(struct memory_range), compare_ranges);
 
-	if (exclude_region(ranges, crash_reserved_mem.start,
-						crash_reserved_mem.end) < 0)
-		goto err;
-
 	ret = 0;
 
 err:
@@ -434,10 +411,6 @@ static int get_crash_memory_ranges_xen(struct memory_range **range,
 
 	qsort(*range, *ranges, sizeof(struct memory_range), compare_ranges);
 
-	if (exclude_region(ranges, crash_reserved_mem.start,
-						crash_reserved_mem.end) < 0)
-		goto err;
-
 	ret = 0;
 
 err:
@@ -941,6 +914,7 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 	struct memory_range *mem_range, *memmap_p;
 	struct crash_elf_info elf_info;
 	unsigned kexec_arch;
+	uint64_t start, end;
 
 	memset(&elf_info, 0x0, sizeof(elf_info));
 
@@ -973,11 +947,26 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 		if (get_crash_memory_ranges_xen(&mem_range, &nr_ranges,
 						elf_info.lowmem_limit) < 0)
 			return -1;
-	} else
+	} else {
 		if (get_crash_memory_ranges(&mem_range, &nr_ranges,
 						info->kexec_flags,
 						elf_info.lowmem_limit) < 0)
 			return -1;
+	}
+
+	if (exclude_region(&nr_ranges, crash_reserved_mem.start,
+				crash_reserved_mem.end) < 0)
+		return -1;
+	if (crash_reserved_low_mem.start &&
+	    exclude_region(&nr_ranges, crash_reserved_low_mem.start,
+				crash_reserved_low_mem.end) < 0)
+		return -1;
+
+	if (!parse_iomem_single("GART\n", &start, &end)) {
+		/* exclude GART region if the system has one */
+		if (exclude_region(&nr_ranges, start, end) < 0)
+			return -1;
+	}
 
 	get_backup_area(info, mem_range, nr_ranges);
 
-- 
1.7.6.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
