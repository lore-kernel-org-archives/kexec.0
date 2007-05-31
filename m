Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1HtaMb-0003DO-8t
	for kexec@lists.infradead.org; Wed, 30 May 2007 22:26:12 -0400
Subject: Re: [PATCH] [makedumpfile] Fix ELF output with overlapping sections
In-reply-to: <20070518104715.GD16227@suse.de>
Message-Id: <20070531112608oomichi@mail.jp.nec.com>
References: <20070518104715.GD16227@suse.de>
Mime-Version: 1.0
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Date: Thu, 31 May 2007 11:26:08 +0900
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
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org


Hi Bernhard,

2007/05/18 12:47:15 +0200, Bernhard Walle <bwalle@suse.de> wrote:
>I have a core dump with following program headers on IA64:
>
>  LOAD           0x0000000000001f4c 0xa000000100000000 0x0000000004000000
>                 0x000000000055c4a0 0x000000000055c4a0  RWE    0
>...
>  LOAD           0x00000000044fc3ec 0xe000000004000000 0x0000000004000000
>                 0x0000000000c92000 0x0000000000c92000  RWE    0
>
>The interesting thing is the overlap in the physical address space.
>write_elf_pages() assumes that there's no overlap because it looks only
>for the file offset according to the physical start address and silently
>assumes that the length matches.

Thank you for the patch.
I'm worry that the overlapping spaces may have the same p_filesz.
I think it is certain to check it by p_offset, and created the
attached patch. Please let me know your opinion.


BTW, I don't know the reason why your system's /proc/vmcore has the
overlapping physical address. If you know it, please let me know.


Thanks
Ken'ichi Ohmichi

------------------------------------------------------------


Signed-off-by: Bernhard Walle <bwalle@suse.de>
Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
---

diff -puN backup/v1.1.3/makedumpfile.c a/makedumpfile.c
--- backup/v1.1.3/makedumpfile.c	2007-04-13 15:44:55.000000000 +0900
+++ a/makedumpfile.c	2007-05-31 11:18:04.000000000 +0900
@@ -2561,6 +2561,33 @@ out:
 	return ret;
 }
 
+/*
+ * Sames as paddr_to_offset() but makes sure that the specified offset (hint)
+ * in the segment.
+ */
+off_t
+paddr_to_offset2(struct DumpInfo *info, unsigned long long paddr, off_t hint)
+{
+	int i;
+	off_t offset;
+	unsigned long long len;
+	struct pt_load_segment *pls;
+
+	for (i = offset = 0; i < info->num_load_memory; i++) {
+		pls = &info->pt_load_segments[i];
+		len = pls->phys_end - pls->phys_start;
+		if ((paddr >= pls->phys_start)
+		    && (paddr < pls->phys_end)
+		    && (hint >= pls->file_offset)
+		    && (hint < pls->file_offset + len)) {
+			offset = (off_t)(paddr - pls->phys_start) +
+				pls->file_offset;
+				break;
+		}
+	}
+	return offset;
+}
+
 unsigned long long
 page_to_pfn(struct DumpInfo *info, unsigned long page)
 {
@@ -3462,7 +3489,6 @@ write_elf_pages(struct DumpInfo *info)
 
 	off_seg_load  = info->offset_load_dumpfile;
 	cd_seg.offset = info->offset_load_dumpfile;
-	off_memory = 0;
 
 	if (info->flag_elf64) { /* ELF64 */
 		cd_hdr.offset = sizeof(Elf64_Ehdr) + sizeof(Elf64_Phdr);
@@ -3488,7 +3514,7 @@ write_elf_pages(struct DumpInfo *info)
 			}
 			if (load64.p_type != PT_LOAD)
 				continue;
-
+			off_memory= load64.p_offset;
 			paddr     = load64.p_paddr;
 			pfn_start = load64.p_paddr / page_size;
 			pfn_end   = (load64.p_paddr+ load64.p_memsz)/page_size;
@@ -3501,6 +3527,7 @@ write_elf_pages(struct DumpInfo *info)
 			}
 			if (load32.p_type != PT_LOAD)
 				continue;
+			off_memory= load32.p_offset;
 			paddr     = load32.p_paddr;
 			pfn_start = load32.p_paddr / page_size;
 			pfn_end   = (load32.p_paddr+ load32.p_memsz)/page_size;
@@ -3588,7 +3615,7 @@ write_elf_pages(struct DumpInfo *info)
 			/*
 			 * Write a PT_LOAD segment.
 			 */
-			off_memory = paddr_to_offset(info, paddr);
+			off_memory = paddr_to_offset2(info, paddr, off_memory);
 			if (!off_memory) {
 				ERRMSG("Can't convert physaddr(%llx) to a offset.\n",
 				    paddr);
@@ -3680,7 +3707,7 @@ write_elf_pages(struct DumpInfo *info)
 		/*
 		 * Write a PT_LOAD segment.
 		 */
-		off_memory = paddr_to_offset(info, paddr);
+		off_memory = paddr_to_offset2(info, paddr, off_memory);
 		if (!off_memory) {
 			ERRMSG("Can't convert physaddr(%llx) to a offset.\n",
 			    paddr);
_

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
