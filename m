Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp03.au.ibm.com ([202.81.18.172])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1LA1K6-0002FE-Rs
	for kexec@lists.infradead.org; Tue, 09 Dec 2008 12:04:19 +0000
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id mB9C2nLp006972
	for <kexec@lists.infradead.org>; Tue, 9 Dec 2008 23:02:49 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mB9BxEY1227180
	for <kexec@lists.infradead.org>; Tue, 9 Dec 2008 22:59:14 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mB9BxEZD002627
	for <kexec@lists.infradead.org>; Tue, 9 Dec 2008 22:59:14 +1100
From: Chandru <chandru@in.ibm.com>
Subject: Re: kdump: quad core Opteron
Date: Tue, 9 Dec 2008 17:29:16 +0530
References: <48EB5B68.8010401@in.ibm.com>
	<200812082126.16680.chandru@in.ibm.com>
	<1228779316.3428.367.camel@amd.troyhebe>
In-Reply-To: <1228779316.3428.367.camel@amd.troyhebe>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200812091729.16182.chandru@in.ibm.com>
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
To: bob.montgomery@hp.com
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Vivek Goyal <vgoyal@redhat.com>

On Tuesday 09 December 2008 05:05:16 Bob Montgomery wrote:
> On Mon, 2008-12-08 at 15:56 +0000, Chandru wrote:
> > Hi Bob,
> >
> > This problem was recently reported on a LS42 blade and the patch given by
> > you also resolved the issue here too.  However I made couple of changes
> > to kexec-tools to ignore GART memory region and not have elf headers
> > created to it.  This patch also seemed to work on a LS21.
> >
> > Thanks,
> > Chandru
>
> Hi Chandru,
>
> I tried your patch on kexec-tools, and I'm seeing a zero-length section
> in /proc/vmcore (using readelf -e /proc/vmcore) right after the GART
> hole:
>
> /proc/iomem in the main kernel shows:
>   01000000-08ffffff : Crash kernel
>   20000000-23ffffff : GART
> cfe4e000-cfe55fff : ACPI Tables
>
> And readelf -e /proc/vmcore in the kdump kernel shows:
>
> Program Headers:
>   Type           Offset             VirtAddr           PhysAddr
>                  FileSiz            MemSiz              Flags  Align
> ...
>   LOAD           0x000000000144d99c 0xffff810009000000 0x0000000009000000
>                  0x0000000017000000 0x0000000017000000  RWE    0
>   LOAD           0x000000001844d99c 0xffff810024000000 0x0000000024000000
>                  0x00000000abe4e000 0x00000000abe4e000  RWE    0
>   LOAD           0x00000000c429b99c 0xffff810024000000 0x0000000024000000
>                  0x0000000000000000 0x0000000000000000  RWE    0
> ...
>
> The first LOAD shown covers 09000000-20000000, the System RAM between
> the Crash kernel and the GART.
> The next LOAD covers 24000000-cfe4e000, which is the System RAM between
> the GART and the ACPI Tables.  So that all looks good.
>
> Then the next LOAD is also at 24000000 with a 0 in the size fields.
> I haven't had a chance to check the code yet.
>
> Bob Montgomery

Whoops, a 'continue' was missing in the patch. Here is the updated patch...


Exclude GART memory region and make kexec-tools to not create elf headers to 
it.  Currently it seems like the dump analysis tools do not need a copy of the 
GART memory region, hence ignoring it in kexec-tools. 

Signed-off-by: Chandru S <chandru@in.ibm.com>
---

--- kexec-tools/kexec/arch/x86_64/crashdump-x86_64.c.orig	2008-12-08 
01:50:41.000000000 -0600
+++ kexec-tools/kexec/arch/x86_64/crashdump-x86_64.c	2008-12-08 
22:01:50.000000000 -0600
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
 /* Removes crash reserve region from list of memory chunks for whom elf 
program
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
