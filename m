Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aTPY9-0000XY-O2
 for kexec@lists.infradead.org; Wed, 10 Feb 2016 07:51:00 +0000
Date: Wed, 10 Feb 2016 08:50:09 +0100
From: Petr Tesarik <ptesarik@suse.cz>
Subject: [PATCH 3/3] makedumpfile: Rewrite readpage_elf
Message-ID: <20160210085009.4df4d14d@hananiah.suse.cz>
In-Reply-To: <20160210084737.3060fb5a@hananiah.suse.cz>
References: <20160210084737.3060fb5a@hananiah.suse.cz>
MIME-Version: 1.0
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>, Ivan Delalande <colona@arista.com>
Cc: kexec mailing list <kexec@lists.infradead.org>

The current code in readpage_elf (and readpage_elf_parallel) is extremely
hard to follow. Additionally, it still does not cover all possible cases.
For example, attempts to read outside of any ELF segment will end up with
phys_start being 0, frac_head a negative number, interpreted as a large
positive number by memset() and write past buffer end.

Instead of trying to handle even more "corner cases", I rewrote the
algorithm from scratch. The basic idea is simple: set a goal to fill the
page buffer with data, then work towards that goal by:

  - filling holes with zeroes (see Note below),
  - p_filesz portions with file data and
  - remaining p_memsz portions again with zeroes.

Repeat this method for each LOAD until the goal is achieved, or an error
occurs. In most cases, the loop runs only once.

Note: A "hole" is data at a physical address that is not covered by any
ELF LOAD program header. In other words, the ELF file does not specify
any data for such a hole (not even zeroes). So, why does makedumpfile
fill them with zeroes? It's because makedumpfile works with page
granularity (the compressed format does not even have a way to store
a partial page), so if only part of a page is stored, a complete page
must be provided to make this partial data accessible.

Credits to Ivan Delalande <colona@arista.com> who first found the
problem and wrote the original fix.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>

---
 elf_info.c     |   28 +++++++
 elf_info.h     |    1 
 makedumpfile.c |  208 ++++++++++++++++++++++-----------------------------------
 3 files changed, 110 insertions(+), 127 deletions(-)

--- a/elf_info.c
+++ b/elf_info.c
@@ -691,6 +691,34 @@ get_max_paddr(void)
 	return max_paddr;
 }
 
+/*
+ * Find the LOAD segment which is closest to the requested
+ * physical address within a given distance.
+ *  If there is no such segment, return a negative number.
+ */
+int
+closest_pt_load(unsigned long long paddr, unsigned long distance)
+{
+	int i, bestidx;
+	struct pt_load_segment *pls;
+	unsigned long bestdist;
+
+	bestdist = distance;
+	bestidx = -1;
+	for (i = 0; i < num_pt_loads; ++i) {
+		pls = &pt_loads[i];
+		if (paddr >= pls->phys_end)
+			continue;
+		if (paddr >= pls->phys_start)
+			return i;	/* Exact match */
+		if (bestdist > pls->phys_start - paddr) {
+			bestdist = pls->phys_start - paddr;
+			bestidx = i;
+		}
+	}
+	return bestidx;
+}
+
 int
 get_elf64_ehdr(int fd, char *filename, Elf64_Ehdr *ehdr)
 {
--- a/elf_info.h
+++ b/elf_info.h
@@ -39,6 +39,7 @@ off_t offset_to_pt_load_end(off_t offset
 unsigned long long vaddr_to_paddr_general(unsigned long long vaddr);
 off_t vaddr_to_offset_slow(int fd, char *filename, unsigned long long vaddr);
 unsigned long long get_max_paddr(void);
+int closest_pt_load(unsigned long long paddr, unsigned long distance);
 
 int page_is_fractional(off_t page_offset);
 
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -648,73 +648,51 @@ read_from_vmcore_parallel(int fd_memory,
 static int
 readpage_elf(unsigned long long paddr, void *bufptr)
 {
-	off_t offset1, offset2;
-	size_t size1, size2;
-	unsigned long long phys_start, phys_end, frac_head = 0;
-
-	offset1 = paddr_to_offset(paddr);
-	offset2 = paddr_to_offset(paddr + info->page_size);
-	phys_start = paddr;
-	phys_end = paddr + info->page_size;
-
-	/*
-	 * Check the case phys_start isn't aligned by page size like below:
-	 *
-	 *                           phys_start
-	 *                           = 0x40ffda7000
-	 *         |<-- frac_head -->|------------- PT_LOAD -------------
-	 *     ----+-----------------------+---------------------+----
-	 *         |         pfn:N         |       pfn:N+1       | ...
-	 *     ----+-----------------------+---------------------+----
-	 *         |
-	 *     pfn_to_paddr(pfn:N)               # page size = 16k
-	 *     = 0x40ffda4000
-	 */
-	if (!offset1) {
-		phys_start = page_head_to_phys_start(paddr);
-		offset1 = paddr_to_offset(phys_start);
-		frac_head = phys_start - paddr;
-		memset(bufptr, 0, frac_head);
-	}
-
-	/*
-	 * Check the case phys_end isn't aligned by page size like the
-	 * phys_start's case.
-	 */
-	if (!offset2) {
-		phys_end = page_head_to_phys_end(paddr);
-		offset2 = paddr_to_offset(phys_end);
-		memset(bufptr + (phys_end - paddr), 0, info->page_size - (phys_end - paddr));
-	}
+	int idx;
+	off_t offset, size;
+	void *p, *endp;
+	unsigned long long phys_start, phys_end;
+
+	p = bufptr;
+	endp = p + info->page_size;
+	while (p < endp) {
+		idx = closest_pt_load(paddr + (p - bufptr), endp - p);
+		if (idx < 0)
+			break;
+
+		get_pt_load_extents(idx, &phys_start, &phys_end, &offset, &size);
+		if (phys_start > paddr + (p - bufptr)) {
+			memset(p, 0, phys_start - paddr);
+			p += phys_start - paddr;
+		}
 
-	/*
-	 * Check the separated page on different PT_LOAD segments.
-	 */
-	if (offset1 + (phys_end - phys_start) == offset2) {
-		size1 = phys_end - phys_start;
-	} else {
-		for (size1 = 1; size1 < info->page_size - frac_head; size1++) {
-			offset2 = paddr_to_offset(phys_start + size1);
-			if (offset1 + size1 != offset2)
-				break;
+		offset += paddr - phys_start;
+		if (size > paddr - phys_start) {
+			size -= paddr - phys_start;
+			if (size > endp - p)
+				size = endp - p;
+			if (!read_from_vmcore(offset, p, size)) {
+				ERRMSG("Can't read the dump memory(%s).\n",
+				       info->name_memory);
+				return FALSE;
+			}
+			p += size;
+		}
+		if (p < endp) {
+			size = phys_end - paddr;
+			if (size > endp - p)
+				size = endp - p;
+			memset(p, 0, size);
+			p += size;
 		}
 	}
 
-	if(!read_from_vmcore(offset1, bufptr + frac_head, size1)) {
-		ERRMSG("Can't read the dump memory(%s).\n",
-		       info->name_memory);
+	if (p == bufptr) {
+		ERRMSG("Attempt to read non-existent page at 0x%llx.\n",
+		       paddr);
 		return FALSE;
-	}
-
-	if (size1 + frac_head != info->page_size) {
-		size2 = phys_end - (phys_start + size1);
-
-		if(!read_from_vmcore(offset2, bufptr + frac_head + size1, size2)) {
-			ERRMSG("Can't read the dump memory(%s).\n",
-			       info->name_memory);
-			return FALSE;
-		}
-	}
+	} else if (p < bufptr)
+		memset(p, 0, endp - p);
 
 	return TRUE;
 }
@@ -722,76 +700,52 @@ readpage_elf(unsigned long long paddr, v
 static int
 readpage_elf_parallel(int fd_memory, unsigned long long paddr, void *bufptr)
 {
-	off_t offset1, offset2;
-	size_t size1, size2;
-	unsigned long long phys_start, phys_end, frac_head = 0;
-
-	offset1 = paddr_to_offset(paddr);
-	offset2 = paddr_to_offset(paddr + info->page_size);
-	phys_start = paddr;
-	phys_end = paddr + info->page_size;
-
-	/*
-	 * Check the case phys_start isn't aligned by page size like below:
-	 *
-	 *                           phys_start
-	 *                           = 0x40ffda7000
-	 *         |<-- frac_head -->|------------- PT_LOAD -------------
-	 *     ----+-----------------------+---------------------+----
-	 *         |         pfn:N         |       pfn:N+1       | ...
-	 *     ----+-----------------------+---------------------+----
-	 *         |
-	 *     pfn_to_paddr(pfn:N)               # page size = 16k
-	 *     = 0x40ffda4000
-	 */
-	if (!offset1) {
-		phys_start = page_head_to_phys_start(paddr);
-		offset1 = paddr_to_offset(phys_start);
-		frac_head = phys_start - paddr;
-		memset(bufptr, 0, frac_head);
-	}
-
-	/*
-	 * Check the case phys_end isn't aligned by page size like the
-	 * phys_start's case.
-	 */
-	if (!offset2) {
-		phys_end = page_head_to_phys_end(paddr);
-		offset2 = paddr_to_offset(phys_end);
-		memset(bufptr + (phys_end - paddr), 0, info->page_size
-							- (phys_end - paddr));
-	}
+	int idx;
+	off_t offset, size;
+	void *p, *endp;
+	unsigned long long phys_start, phys_end;
+
+	p = bufptr;
+	endp = p + info->page_size;
+	while (p < endp) {
+		idx = closest_pt_load(paddr + (p - bufptr), endp - p);
+		if (idx < 0)
+			break;
+
+		get_pt_load_extents(idx, &phys_start, &phys_end, &offset, &size);
+		if (phys_start > paddr + (p - bufptr)) {
+			memset(p, 0, phys_start - paddr);
+			p += phys_start - paddr;
+		}
 
-	/*
-	 * Check the separated page on different PT_LOAD segments.
-	 */
-	if (offset1 + (phys_end - phys_start) == offset2) {
-		size1 = phys_end - phys_start;
-	} else {
-		for (size1 = 1; size1 < info->page_size - frac_head; size1++) {
-			offset2 = paddr_to_offset(phys_start + size1);
-			if (offset1 + size1 != offset2)
-				break;
+		offset += paddr - phys_start;
+		if (size > paddr - phys_start) {
+			size -= paddr - phys_start;
+			if (size > endp - p)
+				size = endp - p;
+			if (!read_from_vmcore_parallel(fd_memory, offset, bufptr,
+						       size)) {
+				ERRMSG("Can't read the dump memory(%s).\n",
+				       info->name_memory);
+				return FALSE;
+			}
+			p += size;
+		}
+		if (p < endp) {
+			size = phys_end - paddr;
+			if (size > endp - p)
+				size = endp - p;
+			memset(p, 0, size);
+			p += size;
 		}
 	}
 
-	if(!read_from_vmcore_parallel(fd_memory, offset1, bufptr + frac_head,
-								size1)) {
-		ERRMSG("Can't read the dump memory(%s).\n",
-		       info->name_memory);
+	if (p == bufptr) {
+		ERRMSG("Attempt to read non-existent page at 0x%llx.\n",
+		       paddr);
 		return FALSE;
-	}
-
-	if (size1 + frac_head != info->page_size) {
-		size2 = phys_end - (phys_start + size1);
-
-		if(!read_from_vmcore_parallel(fd_memory, offset2,
-					bufptr + frac_head + size1, size2)) {
-			ERRMSG("Can't read the dump memory(%s).\n",
-			       info->name_memory);
-			return FALSE;
-		}
-	}
+	} else if (p < bufptr)
+		memset(p, 0, endp - p);
 
 	return TRUE;
 }

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
