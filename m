Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b9y2B-0005XB-Kw
 for kexec@lists.infradead.org; Mon, 06 Jun 2016 17:09:54 +0000
In-Reply-To: <20160606164129.GM1041@n2100.armlinux.org.uk>
References: <20160606164129.GM1041@n2100.armlinux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH kexec-tools v2 27/32] arm: add support for multiple reserved
 regions
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1b9xtf-0003u2-5t@e0050434b2927.dyn.armlinux.org.uk>
Date: Mon, 06 Jun 2016 18:01:03 +0100
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: Pratyush Anand <panand@redhat.com>, Baoquan He <bhe@redhat.com>

Add support for reserving multiple memory regions rather than just a
single region.

Reviewed-by: Pratyush Anand <panand@redhat.com>
Signed-off-by: Russell King <rmk@arm.linux.org.uk>
---
 kexec/arch/arm/crashdump-arm.c | 66 ++++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 41 deletions(-)

diff --git a/kexec/arch/arm/crashdump-arm.c b/kexec/arch/arm/crashdump-arm.c
index 1a6ab88..9113f5e 100644
--- a/kexec/arch/arm/crashdump-arm.c
+++ b/kexec/arch/arm/crashdump-arm.c
@@ -55,6 +55,14 @@ struct memory_ranges usablemem_rgns = {
 /* memory range reserved for crashkernel */
 static struct memory_range crash_kernel_mem;
 
+/* reserved regions */
+#define CRASH_MAX_RESERVED_RANGES 2
+static struct memory_range crash_reserved_ranges[CRASH_MAX_RESERVED_RANGES];
+static struct memory_ranges crash_reserved_rgns = {
+	.max_size = CRASH_MAX_RESERVED_RANGES,
+	.ranges = crash_reserved_ranges,
+};
+
 static struct crash_elf_info elf_info = {
 	.class		= ELFCLASS32,
 	.data		= ELFDATANATIVE,
@@ -133,44 +141,6 @@ static int get_kernel_page_offset(struct kexec_info *info,
 }
 
 /**
- * crash_exclude_range() - excludes memory region reserved for crashkernel
- *
- * Function locates where crashkernel reserved memory is and removes that region
- * from the available memory regions.
- */
-static void crash_exclude_range(void)
-{
-	const struct memory_range *range = &crash_kernel_mem;
-	int i;
-
-	for (i = 0; i < usablemem_rgns.size; i++) {
-		struct memory_range *r = usablemem_rgns.ranges + i;
-
-		/*
-		 * We assume that crash area is fully contained in
-		 * some larger memory area.
-		 */
-		if (r->start <= range->start && r->end >= range->end) {
-			struct memory_range *new;
-			/*
-			 * Let's split this area into 2 smaller ones and
-			 * remove excluded range from between. First create
-			 * new entry for the remaining area.
-			 */
-			new = usablemem_rgns.ranges + usablemem_rgns.size;
-			new->start = range->end + 1;
-			new->end = r->end;
-			usablemem_rgns.size++;
-			/*
-			 * Next update this area to end before excluded range.
-			 */
-			r->end = range->start - 1;
-			break;
-		}
-	}
-}
-
-/**
  * crash_get_memory_ranges() - read system physical memory
  *
  * Function reads through system physical memory and stores found memory regions
@@ -181,16 +151,28 @@ static void crash_exclude_range(void)
  */
 static int crash_get_memory_ranges(void)
 {
+	int i;
+
 	if (usablemem_rgns.size < 1) {
 		errno = EINVAL;
 		return -1;
 	}
 
 	/*
-	 * Exclude memory reserved for crashkernel (this may result a split memory
-	 * region).
+	 * Exclude all reserved memory from the usable memory regions.
+	 * We want to avoid dumping the crashkernel region itself.  Note
+	 * that this may result memory regions in usablemem_rgns being
+	 * split.
 	 */
-	crash_exclude_range();
+	for (i = 0; i < crash_reserved_rgns.size; i++) {
+		if (mem_regions_exclude(&usablemem_rgns,
+					&crash_reserved_rgns.ranges[i])) {
+			fprintf(stderr,
+				"Error: Number of crash memory ranges excedeed the max limit\n");
+			errno = ENOMEM;
+			return -1;
+		}
+	}
 
 	/*
 	 * Make sure that the memory regions are sorted.
@@ -388,6 +370,8 @@ static int iomem_range_callback(void *UNUSED(data), int UNUSED(nr),
 		crash_kernel_mem.start = base;
 		crash_kernel_mem.end = base + length - 1;
 		crash_kernel_mem.type = RANGE_RAM;
+		return mem_regions_add(&crash_reserved_rgns,
+				       base, length, RANGE_RAM);
 	}
 	else if (strncmp(str, SYSTEM_RAM, strlen(SYSTEM_RAM)) == 0) {
 		return mem_regions_add(&usablemem_rgns,
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
