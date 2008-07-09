Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns1.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KGXZ2-0003n0-5L
	for kexec@lists.infradead.org; Wed, 09 Jul 2008 11:10:25 +0000
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id ECAE2416E0
	for <kexec@lists.infradead.org>; Wed,  9 Jul 2008 13:10:21 +0200 (CEST)
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH 2/3] Remove redundancy between get_memory_ranges_proc_iomem()
	and get_memory_ranges_sysfs()
Date: Wed,  9 Jul 2008 13:11:01 +0200
Message-Id: <1215601862-21748-3-git-send-email-bwalle@suse.de>
In-Reply-To: <20080709004138.GD13710@verge.net.au>
References: <20080709004138.GD13710@verge.net.au>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Bernhard Walle <bwalle@suse.de>

With the previous patch, we have a duplication between that both functions
for following tasks:

 - don't report the interrupt table as RAM,
 - set the mem_min and mem_max limits for kdump.

This patch removes that redundancy into the function get_memory_ranges()
that calls both functions internally.


Signed-off-by: Bernhard Walle <bwalle@suse.de>
---
 kexec/arch/i386/kexec-x86.c |   96 ++++++++++++++++---------------------------
 1 files changed, 36 insertions(+), 60 deletions(-)

diff --git a/kexec/arch/i386/kexec-x86.c b/kexec/arch/i386/kexec-x86.c
index 554c154..d5b6737 100644
--- a/kexec/arch/i386/kexec-x86.c
+++ b/kexec/arch/i386/kexec-x86.c
@@ -41,13 +41,10 @@ static struct memory_range memory_range[MAX_MEMORY_RANGES];
  * @param[out] range pointer that will be set to an array that holds the
  *             memory ranges
  * @param[out] ranges number of ranges valid in @p range
- * @param[in]  kexec_flags the kexec_flags to determine if we load a normal
- *             or a crashdump kernel
  *
  * @return 0 on success, any other value on failure.
  */
-static int get_memory_ranges_proc_iomem(struct memory_range **range, int *ranges,
-					unsigned long kexec_flags)
+static int get_memory_ranges_proc_iomem(struct memory_range **range, int *ranges)
 {
 	const char *iomem= proc_iomem();
 	int memory_ranges = 0;
@@ -89,27 +86,9 @@ static int get_memory_ranges_proc_iomem(struct memory_range **range, int *ranges
 		else if (memcmp(str, "ACPI Non-volatile Storage\n", 26) == 0) {
 			type = RANGE_ACPI_NVS;
 		}
-		else if (memcmp(str, "Crash kernel\n", 13) == 0) {
-		/* Redefine the memory region boundaries if kernel
-		 * exports the limits and if it is panic kernel.
-		 * Override user values only if kernel exported values are
-		 * subset of user defined values.
-		 */
-			if (kexec_flags & KEXEC_ON_CRASH) {
-				if (start > mem_min)
-					mem_min = start;
-				if (end < mem_max)
-					mem_max = end;
-			}
-			continue;
-		}
 		else {
 			continue;
 		}
-		/* Don't report the interrupt table as ram */
-		if (type == RANGE_RAM && (start < 0x100)) {
-			start = 0x100;
-		}
 		memory_range[memory_ranges].start = start;
 		memory_range[memory_ranges].end = end;
 		memory_range[memory_ranges].type = type;
@@ -132,52 +111,19 @@ static int get_memory_ranges_proc_iomem(struct memory_range **range, int *ranges
  * @param[out] range pointer that will be set to an array that holds the
  *             memory ranges
  * @param[out] ranges number of ranges valid in @p range
- * @param[in]  kexec_flags the kexec_flags to determine if we load a normal
- *             or a crashdump kernel
  *
  * @return 0 on success, any other value on failure.
  */
-static int get_memory_ranges_sysfs(struct memory_range **range, int *ranges,
-				   unsigned long kexec_flags)
+static int get_memory_ranges_sysfs(struct memory_range **range, int *ranges)
 {
 	int ret;
-	size_t i;
 	size_t range_number = MAX_MEMORY_RANGES;
-	unsigned long long start, end;
 
 	ret = get_firmware_memmap_ranges(memory_range, &range_number);
 	if (ret != 0) {
 		fprintf(stderr, "Parsing the /sys/firmware memory map failed. "
 			"Falling back to /proc/iomem.\n");
-		return get_memory_ranges_proc_iomem(range, ranges, kexec_flags);
-	}
-
-	/* Don't report the interrupt table as ram */
-	for (i = 0; i < range_number; i++) {
-		if (memory_range[i].type == RANGE_RAM &&
-				(memory_range[i].start < 0x100)) {
-			memory_range[i].start = 0x100;
-			break;
-		}
-	}
-
-	/*
-	 * Redefine the memory region boundaries if kernel
-	 * exports the limits and if it is panic kernel.
-	 * Override user values only if kernel exported values are
-	 * subset of user defined values.
-	 */
-	if (kexec_flags & KEXEC_ON_CRASH) {
-		ret = parse_iomem_single("Crash kernel\n", &start, &end);
-		if (ret != 0) {
-			fprintf(stderr, "parse_iomem_single failed.\n");
-			return -1;
-		}
-
-		if (start > mem_min)
-			mem_min = start;
-		if (end < mem_max)
-			mem_max = end;
+		return get_memory_ranges_proc_iomem(range, ranges);
 	}
 
 	*range = memory_range;
@@ -203,12 +149,12 @@ static int get_memory_ranges_sysfs(struct memory_range **range, int *ranges,
 int get_memory_ranges(struct memory_range **range, int *ranges,
 		      unsigned long kexec_flags)
 {
-	int ret;
+	int ret, i;
 
 	if (have_sys_firmware_memmap())
-		ret = get_memory_ranges_sysfs(range, ranges,kexec_flags);
+		ret = get_memory_ranges_sysfs(range, ranges);
 	else
-		ret = get_memory_ranges_proc_iomem(range, ranges, kexec_flags);
+		ret = get_memory_ranges_proc_iomem(range, ranges);
 
 	/*
 	 * both get_memory_ranges_sysfs() and get_memory_ranges_proc_iomem()
@@ -217,6 +163,36 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
 	if (ret != 0)
 		return ret;
 
+	/* Don't report the interrupt table as ram */
+	for (i = 0; i < *ranges; i++) {
+		if ((*range)[i].type == RANGE_RAM &&
+				((*range)[i].start < 0x100)) {
+			(*range)[i].start = 0x100;
+			break;
+		}
+	}
+
+	/*
+	 * Redefine the memory region boundaries if kernel
+	 * exports the limits and if it is panic kernel.
+	 * Override user values only if kernel exported values are
+	 * subset of user defined values.
+	 */
+	if (kexec_flags & KEXEC_ON_CRASH) {
+		unsigned long long start, end;
+
+		ret = parse_iomem_single("Crash kernel\n", &start, &end);
+		if (ret != 0) {
+			fprintf(stderr, "parse_iomem_single failed.\n");
+			return -1;
+		}
+
+		if (start > mem_min)
+			mem_min = start;
+		if (end < mem_max)
+			mem_max = end;
+	}
+
 	/* just set 0 to 1 to enable printing for debugging */
 #if 0
 	{
-- 
1.5.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
