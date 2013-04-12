Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UQXkq-00050E-Uq
 for kexec@lists.infradead.org; Fri, 12 Apr 2013 06:46:38 +0000
Date: Fri, 12 Apr 2013 15:19:19 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [PATCH 2/2] Fix the issue which can happen around overlapping
Message-Id: <20130412151919.2e45dcd5c2a466e716b035da@mxc.nes.nec.co.jp>
In-Reply-To: <20130412151718.dc8eaa97cf73eddfea74edc0@mxc.nes.nec.co.jp>
References: <20130412151718.dc8eaa97cf73eddfea74edc0@mxc.nes.nec.co.jp>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: ptesarik@suse.cz

From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Date: Thu, 11 Apr 2013 10:33:59 +0900
Subject: [PATCH 2/2] Fix the issue which can happen around overlapping
 segments.

If reading the separated page on different PT_LOAD segments,
we have to read the page data from both segments and read_pfn()
was introduced for such cases.
(Please see the comment of read_pfn() for details.)

But read_pfn() hasn't worked as expected since the caching
feature was introduced.
The current call stack can be broken into as follows:

  read_pfn()
    readmem()
      readpage_elf()
        read(2)

If the target of read_pfn() is separated page, readmem() is called
twice as for the former part and later part of the page.
But readpage_elf() always try to read a whole page and cache it
without consideration for separated page. As the result, readmem()
can get the same invalid data in both readmem().

So, the code for separated page should be moved from read_pfn()
to readpage_elf().

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 makedumpfile.c | 126 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 62 insertions(+), 64 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 725100b..50bb089 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -231,30 +231,82 @@ read_page_desc(unsigned long long paddr, page_desc_t *pd)
 	return TRUE;
 }
 
+/*
+ * This function is specific for reading page from ELF.
+ *
+ * If reading the separated page on different PT_LOAD segments,
+ * this function gets the page data from both segments. This is
+ * worthy of ia64 /proc/vmcore. In ia64 /proc/vmcore, region 5
+ * segment is overlapping to region 7 segment. The following is
+ * example (page_size is 16KBytes):
+ *
+ *  region |       paddr        |       memsz
+ * --------+--------------------+--------------------
+ *     5   | 0x0000000004000000 | 0x0000000000638ce0
+ *     7   | 0x0000000004000000 | 0x0000000000db3000
+ *
+ * In the above example, the last page of region 5 is 0x4638000
+ * and the segment does not contain complete data of this page.
+ * Then this function gets the data of 0x4638000 - 0x4638ce0
+ * from region 5, and gets the remaining data from region 7.
+ */
 static int
 readpage_elf(unsigned long long paddr, void *bufptr)
 {
 	const off_t failed = (off_t)-1;
-	off_t offset = 0;
+	off_t offset1, offset2;
+	size_t size1, size2;
 
-	if (!(offset = paddr_to_offset(paddr))) {
-		ERRMSG("Can't convert a physical address(%llx) to offset.\n",
-		       paddr);
-		return FALSE;
+	offset1 = paddr_to_offset(paddr);
+	offset2 = paddr_to_offset(paddr + info->page_size);
+
+	/*
+         * Check the separated page on different PT_LOAD segments.
+	 */
+	if (offset1 + info->page_size == offset2) {
+		size1 = info->page_size;
+	} else {
+		for (size1 = 1; size1 < info->page_size; size1++) {
+			offset2 = paddr_to_offset(paddr + size1);
+			if (offset1 + size1 != offset2)
+				break;
+		}
 	}
 
-	if (lseek(info->fd_memory, offset, SEEK_SET) == failed) {
+	if (lseek(info->fd_memory, offset1, SEEK_SET) == failed) {
 		ERRMSG("Can't seek the dump memory(%s). (offset: %llx) %s\n",
-		       info->name_memory, (unsigned long long)offset, strerror(errno));
+		       info->name_memory, (unsigned long long)offset1, strerror(errno));
 		return FALSE;
 	}
 
-	if (read(info->fd_memory, bufptr, info->page_size) != info->page_size) {
+	if (read(info->fd_memory, bufptr, size1) != size1) {
 		ERRMSG("Can't read the dump memory(%s). %s\n",
 		       info->name_memory, strerror(errno));
 		return FALSE;
 	}
 
+	if (size1 != info->page_size) {
+		size2 = info->page_size - size1;
+		if (!offset2) {
+			memset(bufptr + size1, 0, size2);
+		} else {
+			offset2 = paddr_to_offset(paddr + size1);
+
+			if (lseek(info->fd_memory, offset2, SEEK_SET) == failed) {
+				ERRMSG("Can't seek the dump memory(%s). (offset: %llx) %s\n",
+				       info->name_memory, (unsigned long long)offset2,
+				       strerror(errno));
+				return FALSE;
+			}
+
+			if (read(info->fd_memory, bufptr + size1, size2) != size2) {
+				ERRMSG("Can't read the dump memory(%s). %s\n",
+				       info->name_memory, strerror(errno));
+				return FALSE;
+			}
+		}
+	}
+
 	return TRUE;
 }
 
@@ -5305,71 +5357,17 @@ write_elf_pages(struct cache_data *cd_header, struct cache_data *cd_page)
 	return TRUE;
 }
 
-/*
- * This function is specific for reading page.
- *
- * If reading the separated page on different PT_LOAD segments,
- * this function gets the page data from both segments. This is
- * worthy of ia64 /proc/vmcore. In ia64 /proc/vmcore, region 5
- * segment is overlapping to region 7 segment. The following is
- * example (page_size is 16KBytes):
- *
- *  region |       paddr        |       memsz
- * --------+--------------------+--------------------
- *     5   | 0x0000000004000000 | 0x0000000000638ce0
- *     7   | 0x0000000004000000 | 0x0000000000db3000
- *
- * In the above example, the last page of region 5 is 0x4638000
- * and the segment does not contain complete data of this page.
- * Then this function gets the data of 0x4638000 - 0x4638ce0
- * from region 5, and gets the remaining data from region 7.
- */
 int
 read_pfn(unsigned long long pfn, unsigned char *buf)
 {
 	unsigned long long paddr;
-	off_t offset1, offset2;
-	size_t size1, size2;
 
 	paddr = pfn_to_paddr(pfn);
-	if (info->flag_refiltering || info->flag_sadump) {
-		if (!readmem(PADDR, paddr, buf, info->page_size)) {
-			ERRMSG("Can't get the page data.\n");
-			return FALSE;
-		}
-		return TRUE;
-	}
-
-	offset1 = paddr_to_offset(paddr);
-	offset2 = paddr_to_offset(paddr + info->page_size);
-
-	/*
-	 * Check the separated page on different PT_LOAD segments.
-	 */
-	if (offset1 + info->page_size == offset2) {
-		size1 = info->page_size;
-	} else {
-		for (size1 = 1; size1 < info->page_size; size1++) {
-			offset2 = paddr_to_offset(paddr + size1);
-			if (offset1 + size1 != offset2)
-				break;
-		}
-	}
-	if (!readmem(PADDR, paddr, buf, size1)) {
+	if (!readmem(PADDR, paddr, buf, info->page_size)) {
 		ERRMSG("Can't get the page data.\n");
 		return FALSE;
 	}
-	if (size1 != info->page_size) {
-		size2 = info->page_size - size1;
-		if (!offset2) {
-			memset(buf + size1, 0, size2);
-		} else {
-			if (!readmem(PADDR, paddr + size1, buf + size1, size2)) {
-				ERRMSG("Can't get the page data.\n");
-				return FALSE;
-			}
-		}
-	}
+
 	return TRUE;
 }
 
-- 
1.8.0.2

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
