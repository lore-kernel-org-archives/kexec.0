Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1LUkfj-0008L5-30
	for kexec@lists.infradead.org; Wed, 04 Feb 2009 16:32:22 +0000
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp08.au.ibm.com (8.13.1/8.13.1) with ESMTP id n14GWE8d020565
	for <kexec@lists.infradead.org>; Thu, 5 Feb 2009 03:32:14 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n14GWVoS344200
	for <kexec@lists.infradead.org>; Thu, 5 Feb 2009 03:32:31 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n14GWDvd022729
	for <kexec@lists.infradead.org>; Thu, 5 Feb 2009 03:32:13 +1100
From: Chandru <chandru@in.ibm.com>
Subject: [PATCH] x86_64 : exclude gart memory region in kexec tools
Date: Wed, 4 Feb 2009 22:02:03 +0530
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200902042202.03966.chandru@in.ibm.com>
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
To: kexec@lists.infradead.org, horms@verge.net.au

The following patch was discussed sometime back on kexec-tools mailing list.
http://lists.infradead.org/pipermail/kexec/2008-December/003096.html
Sending it here again for inclusion into kexec-tools. thanks
====================================


Exclude GART memory region and make kexec-tools to not create elf headers to 
it.  Currently it seems like the dump analysis tools do not need a copy of the 
GART memory region, hence ignoring it in kexec-tools. Symtoms of accessing
this region in kdump kernel included hangs, spurious restarts, and MCE
(Machine Check Exception) panics in some AMD Opteron systems

Signed-off-by: Chandru S <chandru@in.ibm.com>
---

 kexec/arch/x86_64/crashdump-x86_64.c |   39 ++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 16 deletions(-)

--- a/kexec/arch/x86_64/crashdump-x86_64.c
+++ b/kexec/arch/x86_64/crashdump-x86_64.c
@@ -47,7 +47,7 @@ static struct crash_elf_info elf_info =
 };
 
 /* Forward Declaration. */
-static int exclude_crash_reserve_region(int *nr_ranges);
+static int exclude_region(int *nr_ranges, uint64_t start, uint64_t end);
 
 #define KERN_VADDR_ALIGN	0x100000	/* 1MB */
 
@@ -164,10 +164,11 @@ static struct memory_range crash_reserve
 static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 {
 	const char *iomem= proc_iomem();
-	int memory_ranges = 0;
+	int memory_ranges = 0, gart = 0;
 	char line[MAX_LINE];
 	FILE *fp;
 	unsigned long long start, end;
+	uint64_t gart_start = 0, gart_end = 0;
 
 	fp = fopen(iomem, "r");
 	if (!fp) {
@@ -219,6 +220,11 @@ static int get_crash_memory_ranges(struc
 			type = RANGE_ACPI;
 		} else if(memcmp(str,"ACPI Non-volatile Storage\n",26) == 0 ) {
 			type = RANGE_ACPI_NVS;
+		} else if (memcmp(str, "GART\n", 5) == 0) {
+			gart_start = start;
+			gart_end = end;
+			gart = 1;
+			continue;
 		} else {
 			continue;
 		}
@@ -233,8 +239,14 @@ static int get_crash_memory_ranges(struc
 		memory_ranges++;
 	}
 	fclose(fp);
-	if (exclude_crash_reserve_region(&memory_ranges) < 0)
+	if (exclude_region(&memory_ranges, crash_reserved_mem.start,
+				crash_reserved_mem.end) < 0)
 		return -1;
+	if (gart) {
+		/* exclude GART region if the system has one */
+		if (exclude_region(&memory_ranges, gart_start, gart_end) < 0)
+			return -1;
+	}
 	*range = crash_memory_range;
 	*ranges = memory_ranges;
 #ifdef DEBUG
@@ -252,32 +264,27 @@ static int get_crash_memory_ranges(struc
 /* Removes crash reserve region from list of memory chunks for whom elf program
  * headers have to be created. Assuming crash reserve region to be a single
  * continuous area fully contained inside one of the memory chunks */
-static int exclude_crash_reserve_region(int *nr_ranges)
+static int exclude_region(int *nr_ranges, uint64_t start, uint64_t end)
 {
 	int i, j, tidx = -1;
-	unsigned long long cstart, cend;
 	struct memory_range temp_region;
 
-	/* Crash reserved region. */
-	cstart = crash_reserved_mem.start;
-	cend = crash_reserved_mem.end;
-
 	for (i = 0; i < (*nr_ranges); i++) {
 		unsigned long long mstart, mend;
 		mstart = crash_memory_range[i].start;
 		mend = crash_memory_range[i].end;
-		if (cstart < mend && cend > mstart) {
-			if (cstart != mstart && cend != mend) {
+		if (start < mend && end > mstart) {
+			if (start != mstart && end != mend) {
 				/* Split memory region */
-				crash_memory_range[i].end = cstart - 1;
-				temp_region.start = cend + 1;
+				crash_memory_range[i].end = start - 1;
+				temp_region.start = end + 1;
 				temp_region.end = mend;
 				temp_region.type = RANGE_RAM;
 				tidx = i+1;
-			} else if (cstart != mstart)
-				crash_memory_range[i].end = cstart - 1;
+			} else if (start != mstart)
+				crash_memory_range[i].end = start - 1;
 			else
-				crash_memory_range[i].start = cend + 1;
+				crash_memory_range[i].start = end + 1;
 		}
 	}
 	/* Insert split memory region, if any. */



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
