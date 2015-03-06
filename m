Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YTsv9-0005pj-I0
 for kexec@lists.infradead.org; Fri, 06 Mar 2015 14:08:08 +0000
Message-Id: <6f7f78c2a5a4e6fae97c8004e963fcda481077ba.1425650592.git.ptesarik@suse.cz>
In-Reply-To: <cover.1425650592.git.ptesarik@suse.cz>
References: <cover.1425650592.git.ptesarik@suse.cz>
From: Petr Tesarik <ptesarik@suse.cz>
Date: Fri, 6 Mar 2015 14:28:34 +0100
Subject: [PATCH v2 8/8] cleanup: remove unused page_is_fractional
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: kexec mailing list <kexec@lists.infradead.org>, Jan Willeke <willeke@de.ibm.com>

This function is no longer needed, because mappage_elf() now checks
whether the region is contiguous both in physical addresses and in
file offsets.

Signed-off-by: Petr Tesarik <ptesarik@suse.cz>
---
 elf_info.c | 16 ----------------
 elf_info.h |  2 --
 2 files changed, 18 deletions(-)

diff --git a/elf_info.c b/elf_info.c
index 8bce942..f584393 100644
--- a/elf_info.c
+++ b/elf_info.c
@@ -583,22 +583,6 @@ offset_to_pt_load_end(off_t offset)
 	return pt_load_end;
 }
 
-/*
- * Judge whether the page is fractional or not.
- */
-int
-page_is_fractional(off_t page_offset)
-{
-	if (page_offset % info->page_size != 0)
-		return TRUE;
-
-	if (offset_to_pt_load_end(page_offset) - page_offset
-	    < info->page_size)
-		return TRUE;
-
-	return FALSE;
-}
-
 unsigned long long
 vaddr_to_paddr_general(unsigned long long vaddr)
 {
diff --git a/elf_info.h b/elf_info.h
index e712253..7ae6bf8 100644
--- a/elf_info.h
+++ b/elf_info.h
@@ -40,8 +40,6 @@ unsigned long long vaddr_to_paddr_general(unsigned long long vaddr);
 off_t vaddr_to_offset_slow(int fd, char *filename, unsigned long long vaddr);
 unsigned long long get_max_paddr(void);
 
-int page_is_fractional(off_t page_offset);
-
 int get_elf64_ehdr(int fd, char *filename, Elf64_Ehdr *ehdr);
 int get_elf32_ehdr(int fd, char *filename, Elf32_Ehdr *ehdr);
 int get_elf_info(int fd, char *filename);
-- 
1.8.4.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
