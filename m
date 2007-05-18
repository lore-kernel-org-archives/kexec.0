Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Hozzc-0001MS-5z
	for kexec@lists.infradead.org; Fri, 18 May 2007 06:47:30 -0400
Date: Fri, 18 May 2007 12:47:15 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH] [makedumpfile] Fix ELF output with overlapping sections
Message-ID: <20070518104715.GD16227@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: kexec@lists.infradead.org

I have a core dump with following program headers on IA64:

  LOAD           0x0000000000001f4c 0xa000000100000000 0x0000000004000000
                 0x000000000055c4a0 0x000000000055c4a0  RWE    0
...
  LOAD           0x00000000044fc3ec 0xe000000004000000 0x0000000004000000
                 0x0000000000c92000 0x0000000000c92000  RWE    0

The interesting thing is the overlap in the physical address space.
write_elf_pages() assumes that there's no overlap because it looks only
for the file offset according to the physical start address and silently
assumes that the length matches.

This patch tries to address that problem. At least it works here. Before
I could not read the dump file with `crash' because MAGIC_START was missing
(it's in the 0x4000000 section).


Signed-off-by: Bernhard Walle <bwalle@suse.de>
---
 makedumpfile.c |   50 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 5 deletions(-)

--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -64,6 +64,43 @@ paddr_to_offset(struct DumpInfo *info, u
 	return offset;
 }
 
+/**
+ * Sames as paddr_to_offset() but makes sure that the complete range is covered
+ * by the segment
+ */
+off_t
+paddr_to_offset_range(struct DumpInfo *info, unsigned long long paddr, unsigned long len)
+{
+	int i;
+	off_t offset;
+	struct pt_load_segment *pls;
+
+	for (i = offset = 0; i < info->num_load_memory; i++) {
+		pls = &info->pt_load_segments[i];
+		if ((paddr >= pls->phys_start)
+		    && (paddr <= pls->phys_end)) {
+
+			/* check the length and also consider adjacent sections */
+			unsigned long long end = pls->phys_end;
+			int j = i+1;
+
+			while (j < info->num_load_memory &&
+					(info->pt_load_segments[j-1].phys_end
+					 == info->pt_load_segments[j].phys_start)) {
+				end = info->pt_load_segments[j].phys_end;
+				j++;
+			}
+
+			if (paddr + len <= end) {
+				offset = (off_t)(paddr - pls->phys_start) +
+					pls->file_offset;
+				break;
+			}
+		}
+	}
+	return offset;
+}
+
 unsigned long long
 vaddr_to_paddr(struct DumpInfo *info, unsigned long long vaddr)
 {
@@ -3777,6 +3814,7 @@ write_elf_pages(struct DumpInfo *info)
 			pfn_end++;
 
 		for (pfn = pfn_start; pfn < pfn_end; pfn++) {
+
 			if (!is_dumpable(&bitmap2, pfn)) {
 				num_excluded++;
 				if ((pfn == pfn_end - 1) && frac_tail)
@@ -3934,13 +3972,19 @@ write_elf_pages(struct DumpInfo *info)
 				goto out;
 		}
 
+		if (info->flag_elf64) /* ELF64 */
+			bufsz_remain = load64.p_filesz;
+		else                  /* ELF32 */
+			bufsz_remain = load32.p_filesz;
+
 		/*
 		 * Write a PT_LOAD segment.
 		 */
-		off_memory = paddr_to_offset(info, paddr);
+		off_memory = paddr_to_offset_range(info, paddr, bufsz_remain);
 		if (!off_memory) {
 			ERRMSG("Can't convert physaddr(%llx) to a offset.\n",
 			    paddr);
+			printf("paddr = 0x%llx, bufsz_remain=%lld\n", paddr, bufsz_remain);
 			goto out;
 		}
 		if (lseek(info->fd_memory, off_memory, SEEK_SET)
@@ -3949,10 +3993,6 @@ write_elf_pages(struct DumpInfo *info)
 			    info->name_memory, strerror(errno));
 			goto out;
 		}
-		if (info->flag_elf64) /* ELF64 */
-			bufsz_remain = load64.p_filesz;
-		else                  /* ELF32 */
-			bufsz_remain = load32.p_filesz;
 
 		while (bufsz_remain > 0) {
 			if ((num_dumped % per) == 0)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
