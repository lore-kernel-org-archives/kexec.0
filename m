Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aTPY9-0000XW-O3
 for kexec@lists.infradead.org; Wed, 10 Feb 2016 07:50:59 +0000
Date: Wed, 10 Feb 2016 08:49:08 +0100
From: Petr Tesarik <ptesarik@suse.cz>
Subject: [PATCH 1/3] makedumpfile: Keep segment memory size when
 re-filtering ELF dumps
Message-ID: <20160210084908.54a96cd2@hananiah.suse.cz>
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

Originally, makedumpfile was designed to read from /proc/vmcore, where
each segment's p_memsz is equal to its p_filesz (see below). However,
makedumpfile can also be used to re-filter an already filtered ELF dump
file, where memory size may be larger than file size. In that case the
memory size should be used as the size of the segment. This affects:

1. max_mapnr
   This value is computed as the highest phys_end. If the last segment
   was filtered, max_mapnr may be too small, and the crash utility will
   refuse to read that memory (even with --zero_excluded).

2. p_memsz field in ELF dumps
   The resulting ELF segment p_memsz will be capped to original file's
   p_filesz, ignoring the original p_memsz.

3. memory holes in KDUMP dumps
   Pages excluded in the original ELF dump will be appear as memory
   holes in the resulting KDUMP file's first bitmap.

4. vtop translation
   Virtual addresses that were filtered out in the original ELF file
   cannot be translated to physical addresses using the generic vtop
   translation.

My fix uses p_memsz to set physical and virtual extents of ELF segments,
because this is their actual size. However, file size is important when
accessing page data, so it must be stored separately and checked when
translating a physical address to a file offset.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>

---
 elf_info.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/elf_info.c
+++ b/elf_info.c
@@ -38,6 +38,7 @@
 
 struct pt_load_segment {
 	off_t			file_offset;
+	off_t			file_size;
 	unsigned long long	phys_start;
 	unsigned long long	phys_end;
 	unsigned long long	virt_start;
@@ -162,10 +163,11 @@ dump_Elf_load(Elf64_Phdr *prog, int num_
 
 	pls = &pt_loads[num_load];
 	pls->phys_start  = prog->p_paddr;
-	pls->phys_end    = pls->phys_start + prog->p_filesz;
+	pls->phys_end    = pls->phys_start + prog->p_memsz;
 	pls->virt_start  = prog->p_vaddr;
-	pls->virt_end    = pls->virt_start + prog->p_filesz;
+	pls->virt_end    = pls->virt_start + prog->p_memsz;
 	pls->file_offset = prog->p_offset;
+	pls->file_size   = prog->p_filesz;
 
 	DEBUG_MSG("LOAD (%d)\n", num_load);
 	DEBUG_MSG("  phys_start : %llx\n", pls->phys_start);
@@ -462,7 +464,7 @@ paddr_to_offset(unsigned long long paddr
 	for (i = offset = 0; i < num_pt_loads; i++) {
 		pls = &pt_loads[i];
 		if ((paddr >= pls->phys_start)
-		    && (paddr < pls->phys_end)) {
+		    && (paddr < pls->phys_start + pls->file_size)) {
 			offset = (off_t)(paddr - pls->phys_start) +
 				pls->file_offset;
 			break;
@@ -480,16 +482,14 @@ paddr_to_offset2(unsigned long long padd
 {
 	int i;
 	off_t offset;
-	unsigned long long len;
 	struct pt_load_segment *pls;
 
 	for (i = offset = 0; i < num_pt_loads; i++) {
 		pls = &pt_loads[i];
-		len = pls->phys_end - pls->phys_start;
 		if ((paddr >= pls->phys_start)
-		    && (paddr < pls->phys_end)
+		    && (paddr < pls->phys_start + pls->file_size)
 		    && (hint >= pls->file_offset)
-		    && (hint < pls->file_offset + len)) {
+		    && (hint < pls->file_offset + pls->file_size)) {
 			offset = (off_t)(paddr - pls->phys_start) +
 				pls->file_offset;
 			break;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
