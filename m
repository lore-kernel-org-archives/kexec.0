Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U7fOm-0000iP-2a
 for kexec@lists.infradead.org; Tue, 19 Feb 2013 05:05:49 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id C8F833EE0B5
 for <kexec@lists.infradead.org>; Tue, 19 Feb 2013 14:05:40 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id AE93545DEBA
 for <kexec@lists.infradead.org>; Tue, 19 Feb 2013 14:05:40 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 8C3BC45DEB7
 for <kexec@lists.infradead.org>; Tue, 19 Feb 2013 14:05:40 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 7EA3FE18001
 for <kexec@lists.infradead.org>; Tue, 19 Feb 2013 14:05:40 +0900 (JST)
Received: from g01jpexchyt03.g01.fujitsu.local
 (g01jpexchyt03.g01.fujitsu.local [10.128.194.42])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 2DCCFE18002
 for <kexec@lists.infradead.org>; Tue, 19 Feb 2013 14:05:40 +0900 (JST)
From: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>
Subject: [PATCH] makedumpfile: clean up readmem() by removing its recursive
 call
Date: Tue, 19 Feb 2013 05:05:39 +0000
Message-ID: <33710E6CAA200E4583255F4FB666C4E20AC9A180@G01JPEXMBYT03>
Content-Language: ja-JP
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Atsushi Kumagai (kumagai-atsushi@mxc.nes.nec.co.jp)" <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Currently, readmem() calls itself recursively and its depth grows in
proportin to the number of requested pages.

For example, in __exclude_unnecessary_pages(), PGMM_CACHED is defined
as 512 and page structure is of 56 bytes on x86_64, so size of page
cache on x86_64 is now 56 * 512 = 28KiB, and this is 7 pages. This
means that on the existing implementation readmem() is called
recursively 7 times when reading mem_map array, but 6 of the 7 are
in fact unnecessary.

This patch cleans up readmem() by removing the recursive
call. Instead, readmem() proceeds to the processing for next page by
jump.

Also, by this change, read operation is done in increasing order. This
is more natural than the existing implementation in decreasing order.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---
 makedumpfile.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index acb1b21..0bc8e1c 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -337,13 +337,12 @@ readpage_kdump_compressed(unsigned long long paddr, void *bufptr)
 int
 readmem(int type_addr, unsigned long long addr, void *bufptr, size_t size)
 {
-	size_t read_size, next_size;
-	unsigned long long next_addr;
+	size_t read_size, size_orig = size;
 	unsigned long long paddr, maddr = NOT_PADDR;
 	unsigned long long pgaddr;
 	void *pgbuf;
-	char *next_ptr;
 
+next_page:
 	switch (type_addr) {
 	case VADDR:
 		if ((paddr = vaddr_to_paddr(addr)) == NOT_PADDR) {
@@ -386,21 +385,14 @@ readmem(int type_addr, unsigned long long addr, void *bufptr, size_t size)
 		goto error;
 	}
 
-	read_size = size;
-
 	/*
 	 * Read each page, because pages are not necessarily continuous.
 	 * Ex) pages in vmalloc area
 	 */
-	if (!is_in_same_page(addr, addr + size - 1)) {
-		read_size = info->page_size - (addr % info->page_size);
-		next_addr = roundup(addr + 1, info->page_size);
-		next_size = size - read_size;
-		next_ptr  = (char *)bufptr + read_size;
+	read_size = info->page_size - PAGEOFFSET(paddr);
 
-		if (!readmem(type_addr, next_addr, next_ptr, next_size))
-			goto error;
-	}
+	if (read_size > size)
+		read_size = size;
 
 	pgaddr = PAGEBASE(paddr);
 	pgbuf = cache_search(pgaddr);
@@ -423,7 +415,15 @@ readmem(int type_addr, unsigned long long addr, void *bufptr, size_t size)
 	}
 
 	memcpy(bufptr, pgbuf + PAGEOFFSET(paddr), read_size);
-	return size;
+
+	addr += read_size;
+	bufptr += read_size;
+	size -= read_size;
+
+	if (size > 0)
+		goto next_page;
+
+	return size_orig;
 
 error:
 	ERRMSG("type_addr: %d, addr:%llx, size:%zd\n", type_addr, addr, size);
-- 
1.7.7.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
