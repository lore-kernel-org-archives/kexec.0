Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TnPxk-0005wX-IO
 for kexec@lists.infradead.org; Tue, 25 Dec 2012 08:34:17 +0000
Message-ID: <50D96474.3080309@cn.fujitsu.com>
Date: Tue, 25 Dec 2012 16:31:48 +0800
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [PATCH] kexec,x86: code optimization and adjustment for add_memmap
 and delete_memmap
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
To: horms@verge.net.au
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kexec/arch/i386/crashdump-x86.c |   93 ++++++++++++++++++---------------------
 1 files changed, 43 insertions(+), 50 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 245402c..63f6b2b 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -518,21 +518,22 @@ static int exclude_region(int *nr_ranges, uint64_t start, uint64_t end)
 
 /* Adds a segment from list of memory regions which new kernel can use to
  * boot. Segment start and end should be aligned to 1K boundary. */
-static int add_memmap(struct memory_range *memmap_p, unsigned long long addr,
-								size_t size)
+static int add_memmap(struct memory_range *memmap_p,
+		      unsigned long long addr,
+		      size_t size)
 {
 	int i, j, nr_entries = 0, tidx = 0, align = 1024;
 	unsigned long long mstart, mend;
 
 	/* Do alignment check. */
-	if ((addr%align) || (size%align))
+	if ((addr % align) || (size % align))
 		return -1;
 
 	/* Make sure at least one entry in list is free. */
-	for (i = 0; i < CRASH_MAX_MEMMAP_NR;  i++) {
+	for (i = 0; i < CRASH_MAX_MEMMAP_NR; i++) {
 		mstart = memmap_p[i].start;
 		mend = memmap_p[i].end;
-		if (!mstart  && !mend)
+		if (!mstart && !mend)
 			break;
 		else
 			nr_entries++;
@@ -540,31 +541,29 @@ static int add_memmap(struct memory_range *memmap_p, unsigned long long addr,
 	if (nr_entries == CRASH_MAX_MEMMAP_NR)
 		return -1;
 
-	for (i = 0; i < CRASH_MAX_MEMMAP_NR;  i++) {
+	for (i = 0; i < nr_entries; i++) {
 		mstart = memmap_p[i].start;
 		mend = memmap_p[i].end;
-		if (mstart == 0 && mend == 0)
-			break;
-		if (mstart <= (addr+size-1) && mend >=addr)
+
+		if (mstart <= (addr + size - 1) && mend >= addr)
 			/* Overlapping region. */
 			return -1;
 		else if (addr > mend)
-			tidx = i+1;
+			tidx = i + 1;
 	}
-		/* Insert the memory region. */
-		for (j = nr_entries-1; j >= tidx; j--)
-			memmap_p[j+1] = memmap_p[j];
-		memmap_p[tidx].start = addr;
-		memmap_p[tidx].end = addr + size - 1;
+
+	/* Insert the memory region. */
+	for (j = nr_entries - 1; j >= tidx; j--)
+		memmap_p[j+1] = memmap_p[j];
+	memmap_p[tidx].start = addr;
+	memmap_p[tidx].end = addr + size - 1;
+	nr_entries++;
 
 	dbgprintf("Memmap after adding segment\n");
-	for (i = 0; i < CRASH_MAX_MEMMAP_NR;  i++) {
+	for (i = 0; i < nr_entries; i++) {
 		mstart = memmap_p[i].start;
 		mend = memmap_p[i].end;
-		if (mstart == 0 && mend == 0)
-			break;
-		dbgprintf("%016llx - %016llx\n",
-			mstart, mend);
+		dbgprintf("%016llx - %016llx\n", mstart, mend);
 	}
 
 	return 0;
@@ -572,19 +571,20 @@ static int add_memmap(struct memory_range *memmap_p, unsigned long long addr,
 
 /* Removes a segment from list of memory regions which new kernel can use to
  * boot. Segment start and end should be aligned to 1K boundary. */
-static int delete_memmap(struct memory_range *memmap_p, unsigned long long addr,
-								size_t size)
+static int delete_memmap(struct memory_range *memmap_p,
+			 unsigned long long addr,
+			 size_t size)
 {
 	int i, j, nr_entries = 0, tidx = -1, operation = 0, align = 1024;
 	unsigned long long mstart, mend;
 	struct memory_range temp_region;
 
 	/* Do alignment check. */
-	if ((addr%align) || (size%align))
+	if ((addr % align) || (size % align))
 		return -1;
 
 	/* Make sure at least one entry in list is free. */
-	for (i = 0; i < CRASH_MAX_MEMMAP_NR;  i++) {
+	for (i = 0; i < CRASH_MAX_MEMMAP_NR; i++) {
 		mstart = memmap_p[i].start;
 		mend = memmap_p[i].end;
 		if (!mstart  && !mend)
@@ -596,20 +596,16 @@ static int delete_memmap(struct memory_range *memmap_p, unsigned long long addr,
 		/* List if full */
 		return -1;
 
-	for (i = 0; i < CRASH_MAX_MEMMAP_NR;  i++) {
+	for (i = 0; i < nr_entries; i++) {
 		mstart = memmap_p[i].start;
 		mend = memmap_p[i].end;
-		if (mstart == 0 && mend == 0)
-			/* Did not find the segment in the list. */
-			return -1;
+
 		if (mstart <= addr && mend >= (addr + size - 1)) {
 			if (mstart == addr && mend == (addr + size - 1)) {
 				/* Exact match. Delete region */
 				operation = -1;
 				tidx = i;
-				break;
-			}
-			if (mstart != addr && mend != (addr + size - 1)) {
+			} else if (mstart != addr && mend != (addr + size - 1)) {
 				/* Split in two */
 				memmap_p[i].end = addr - 1;
 				temp_region.start = addr + size;
@@ -617,41 +613,38 @@ static int delete_memmap(struct memory_range *memmap_p, unsigned long long addr,
 				temp_region.type = memmap_p[i].type;
 				operation = 1;
 				tidx = i;
-				break;
-			}
-
-			/* No addition/deletion required. Adjust the existing.*/
-			if (mstart != addr) {
-				memmap_p[i].end = addr - 1;
-				break;
 			} else {
-				memmap_p[i].start = addr + size;
-				break;
+				/* No addition/deletion required. Adjust the existing.*/
+				if (mstart != addr)
+					memmap_p[i].end = addr - 1;
+				else
+					memmap_p[i].start = addr + size;
 			}
+			break;
 		}
 	}
-	if ((operation == 1) && tidx >=0) {
+
+	if (operation == 1 && tidx >= 0) {
 		/* Insert the split memory region. */
-		for (j = nr_entries-1; j > tidx; j--)
+		for (j = nr_entries - 1; j > tidx; j--)
 			memmap_p[j+1] = memmap_p[j];
 		memmap_p[tidx+1] = temp_region;
+		nr_entries++;
 	}
-	if ((operation == -1) && tidx >=0) {
+
+	if (operation == -1 && tidx >= 0) {
 		/* Delete the exact match memory region. */
-		for (j = i+1; j < CRASH_MAX_MEMMAP_NR; j++)
+		for (j = i + 1; j < nr_entries; j++)
 			memmap_p[j-1] = memmap_p[j];
 		memmap_p[j-1].start = memmap_p[j-1].end = 0;
+		nr_entries--;
 	}
 
 	dbgprintf("Memmap after deleting segment\n");
-	for (i = 0; i < CRASH_MAX_MEMMAP_NR;  i++) {
+	for (i = 0; i < nr_entries; i++) {
 		mstart = memmap_p[i].start;
 		mend = memmap_p[i].end;
-		if (mstart == 0 && mend == 0) {
-			break;
-		}
-		dbgprintf("%016llx - %016llx\n",
-			mstart, mend);
+		dbgprintf("%016llx - %016llx\n", mstart, mend);
 	}
 
 	return 0;
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
