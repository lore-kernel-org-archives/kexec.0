Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1adGHw-0003dz-Un
 for kexec@lists.infradead.org; Tue, 08 Mar 2016 11:58:58 +0000
Date: Tue, 8 Mar 2016 12:58:32 +0100
From: Petr Tesarik <ptesarik@suse.cz>
Subject: [PATCH] makedumpfile: Fix several issues with reading ELF pages
Message-ID: <20160308125832.68ceffc2@hananiah.suse.cz>
In-Reply-To: <20160229204051.2f4d238d@hananiah.suse.cz>
References: <20160210084737.3060fb5a@hananiah.suse.cz>
 <20160210085009.4df4d14d@hananiah.suse.cz>
 <20160229195514.335108c9@hananiah.suse.cz>
 <20160229195952.47c1738b@hananiah.suse.cz>
 <20160229204051.2f4d238d@hananiah.suse.cz>
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: kexec mailing list <kexec@lists.infradead.org>

While adopting the algorithm for libkdumpfile, several corner cases
were found by a test case:

  1. If the last part of a page is not present in the ELF file, it
     should be replaced with zeroes. However, the check is incorrect.

  2. If the beginning of a page is not present, following data is
     read from an incorrect file offset.

  3. If the page is split among several segments, the current
     position in the buffer is not always taken into account.

Case 1 is a simple typo/braino (writing bufptr instead of endp).

To fix cases 2 and 3, it is best to update the paddr variable so that
it always corresponds to the current read position in the buffer.

I have tested the new code with a specially crafted ELF dump where one
page had the following (artificial) layout:

  #  PAGE RANGE    STORED IN   DATA
  --------------------------------------------------
  1  0x000-0x007   nowhere     fake zero
  2  0x008-0x067   LOAD #1     read from file
  3  0x068-0x06f   nowhere     fake zero
  4  0x070-0x13f   LOAD #2     read from file
  5  0x140-0x147   LOAD #2     zero (memsz > filesz)
  6  0x148-0xff7   LOAD #3     read from file
  7  0xff8-0xfff   nowhere     fake zero

Case 1 tests the conditional right after get_pt_load_extents().
Case 2 tests file read after missing data.
Case 3 tests the conditional from case 1 with non-zero buffer position.
Case 5 tests the last conditional in the loop (p < endp).
Case 6 tests exact match in get_pt_load_extents().
Case 7 tests the final conditional after the loop.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>

---
 makedumpfile.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -656,14 +656,15 @@ readpage_elf(unsigned long long paddr, v
 	p = bufptr;
 	endp = p + info->page_size;
 	while (p < endp) {
-		idx = closest_pt_load(paddr + (p - bufptr), endp - p);
+		idx = closest_pt_load(paddr, endp - p);
 		if (idx < 0)
 			break;
 
 		get_pt_load_extents(idx, &phys_start, &phys_end, &offset, &size);
-		if (phys_start > paddr + (p - bufptr)) {
+		if (phys_start > paddr) {
 			memset(p, 0, phys_start - paddr);
 			p += phys_start - paddr;
+			paddr = phys_start;
 		}
 
 		offset += paddr - phys_start;
@@ -677,6 +678,7 @@ readpage_elf(unsigned long long paddr, v
 				return FALSE;
 			}
 			p += size;
+			paddr += size;
 		}
 		if (p < endp) {
 			size = phys_end - paddr;
@@ -684,6 +686,7 @@ readpage_elf(unsigned long long paddr, v
 				size = endp - p;
 			memset(p, 0, size);
 			p += size;
+			paddr += size;
 		}
 	}
 
@@ -691,7 +694,7 @@ readpage_elf(unsigned long long paddr, v
 		ERRMSG("Attempt to read non-existent page at 0x%llx.\n",
 		       paddr);
 		return FALSE;
-	} else if (p < bufptr)
+	} else if (p < endp)
 		memset(p, 0, endp - p);
 
 	return TRUE;
@@ -708,14 +711,15 @@ readpage_elf_parallel(int fd_memory, uns
 	p = bufptr;
 	endp = p + info->page_size;
 	while (p < endp) {
-		idx = closest_pt_load(paddr + (p - bufptr), endp - p);
+		idx = closest_pt_load(paddr, endp - p);
 		if (idx < 0)
 			break;
 
 		get_pt_load_extents(idx, &phys_start, &phys_end, &offset, &size);
-		if (phys_start > paddr + (p - bufptr)) {
+		if (phys_start > paddr) {
 			memset(p, 0, phys_start - paddr);
 			p += phys_start - paddr;
+			paddr = phys_start;
 		}
 
 		offset += paddr - phys_start;
@@ -730,6 +734,7 @@ readpage_elf_parallel(int fd_memory, uns
 				return FALSE;
 			}
 			p += size;
+			paddr += size;
 		}
 		if (p < endp) {
 			size = phys_end - paddr;
@@ -737,6 +742,7 @@ readpage_elf_parallel(int fd_memory, uns
 				size = endp - p;
 			memset(p, 0, size);
 			p += size;
+			paddr += size;
 		}
 	}
 
@@ -744,7 +750,7 @@ readpage_elf_parallel(int fd_memory, uns
 		ERRMSG("Attempt to read non-existent page at 0x%llx.\n",
 		       paddr);
 		return FALSE;
-	} else if (p < bufptr)
+	} else if (p < endp)
 		memset(p, 0, endp - p);
 
 	return TRUE;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
