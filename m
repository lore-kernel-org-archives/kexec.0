Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iIIDn-0001tR-SI
 for kexec@lists.infradead.org; Wed, 09 Oct 2019 20:06:10 +0000
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: makedumpfile: ELF format issues (RE: makedumpfile: Fix divide by
 zero in print_report())
Date: Wed, 9 Oct 2019 20:03:51 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC03591761@BPXM09GP.gisp.nec.co.jp>
Content-Language: en-US
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
To: Dave Jones <davej@codemonkey.org.uk>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hi Dave,

Thank you for the information.

> -----Original Message-----

> Common case seems to be:
> 
> <F28>ELF Header:
>   Magic:   7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00
>   Class:                             ELF64
>   Data:                              2's complement, little endian
>   Version:                           1 (current)
>   OS/ABI:                            UNIX - System V
>   ABI Version:                       0
>   Type:                              CORE (Core file)
>   Machine:                           Advanced Micro Devices X86-64
>   Version:                           0x1
>   Entry point address:               0x0
>   Start of program headers:          64 (bytes into file)
>   Start of section headers:          0 (bytes into file)
>   Flags:                             0x0
>   Size of this header:               64 (bytes)
>   Size of program headers:           56 (bytes)
>   Number of program headers:         23881
>   Size of section headers:           0 (bytes)
>   Number of section headers:         0
>   Section header string table index: 0
> 
> There are no sections in this file.
> 
> There are no sections to group in this file.
> 
> Program Headers:
>   Type           Offset             VirtAddr           PhysAddr
>                  FileSiz            MemSiz              Flags  Align
>   NULL           0x0000000000000000 0x0000000000000000 0x0000000000000000
>                  0x0000000000000000 0x0000000000000000         0
>   NULL           0x0000000000000000 0x0000000000000000 0x0000000000000000
>                  0x0000000000000000 0x0000000000000000         0
>   NULL           0x0000000000000000 0x0000000000000000 0x0000000000000000
>                  0x0000000000000000 0x0000000000000000         0
>   NULL           0x0000000000000000 0x0000000000000000 0x0000000000000000
>                  0x0000000000000000 0x0000000000000000         0
>   NULL           0x0000000000000000 0x0000000000000000 0x0000000000000000
>                  0x0000000000000000 0x0000000000000000         0
>   NULL           0x0000000000000000 0x0000000000000000 0x0000000000000000
>                  0x0000000000000000 0x0000000000000000         0
>   NULL           0x0000000000000000 0x0000000000000000 0x0000000000000000
>                  0x0000000000000000 0x0000000000000000         0
>   NULL           0x0000000000000000 0x0000000000000000 0x0000000000000000
>                  0x0000000000000000 0x0000000000000000         0
>   NULL           0x0000000000000000 0x0000000000000000 0x0000000000000000
>                  0x0000000000000000 0x0000000000000000         0
>   NULL           0x0000000000000000 0x0000000000000000 0x0000000000000000
> ... <repeats for thousands of lines>
>   NULL           0x0000000000000000 0x0000000000000000 0x0000000000000000
>                  0x0000000000000000 0x0000000000000000         0
>   NULL           0x0000000000000000 0x0000000000000000 0x0000000000000000
>                  0x0000000000000000 0x0000000000000000         0
> 

In this case, was the "makedumpfile Completed." message emitted?
It looks like the buffer of program headers was not written to the file..

Anyway, a debugging patch attached below.

> There are some other failure cases with non-null data, so maybe there's >1 bug here.
> I've not seen an obvious pattern to this. eg...
> 
> https://pastebin.com/2uM4sBCF
> 

As for this case, I suspect that Elf64_Ehdr.e_phnum overflows
(i.e. num_loads_dumpfile > 65535):

 6851         /*
 6852          * Get the PT_LOAD number of the dumpfile.
 6853          */
 6854         if (!(num_loads_dumpfile = get_loads_dumpfile_cyclic())) {
 6855                 ERRMSG("Can't get a number of PT_LOAD.\n");
 6856                 goto out;
 6857         }
 6858 
 6859         if (is_elf64_memory()) { /* ELF64 */
 6860                 if (!get_elf64_ehdr(info->fd_memory,
 6861                                     info->name_memory, &ehdr64)) {
 6862                         ERRMSG("Can't get ehdr64.\n");
 6863                         goto out;
 6864                 }
 6865                 /*
 6866                  * PT_NOTE(1) + PT_LOAD(1+)
 6867                  */
 6868                 ehdr64.e_phnum = 1 + num_loads_dumpfile;

because e_phnum is uint16_t and the last LOAD of the dumpfile doesn't
reach up to the one of /proc/vmcore at all.

  LOAD           0x00000000726029d4 0xffff88037ba10000 0x000000037ba10000 <<-- paddr
                 0x00000000001c5000 0x00000000004a9000  RWE    0

[   12.743942] LOAD[ 6]        100000000       4080000000 <<-- phys_end

If that is the case, it seems that we need to set it to PN_XNUM (0xffff)
and have an entry in section header table according to elf(5)..

> I'll put your patch on some of the affected hosts and see if this
> changes behaviour in any way.

If you can try the patch below, which includes the previous patch,
please show me:
- the debugging output of makedumpfile
- readelf -a vmcore
- ls -ls vmcore

Thanks,
Kazu


diff --git a/makedumpfile.c b/makedumpfile.c
index de0973f9e763..797386375b87 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -56,6 +56,9 @@ static void first_cycle(mdf_pfn_t start, mdf_pfn_t max, struct cycle *cycle)
 	if (cycle->end_pfn > max)
 		cycle->end_pfn = max;
 
+	if (info->flag_elf_dumpfile && cycle->start_pfn < start)
+		cycle->start_pfn = start;
+
 	cycle->exclude_pfn_start = 0;
 	cycle->exclude_pfn_end = 0;
 }
@@ -6855,6 +6858,7 @@ write_elf_header(struct cache_data *cd_header)
 		ERRMSG("Can't get a number of PT_LOAD.\n");
 		goto out;
 	}
+	DEBUG_MSG("num_loads_dumpfile=%d\n", num_loads_dumpfile);
 
 	if (is_elf64_memory()) { /* ELF64 */
 		if (!get_elf64_ehdr(info->fd_memory,
@@ -6866,6 +6870,7 @@ write_elf_header(struct cache_data *cd_header)
 		 * PT_NOTE(1) + PT_LOAD(1+)
 		 */
 		ehdr64.e_phnum = 1 + num_loads_dumpfile;
+		DEBUG_MSG("ehdr64.e_phnum=%hu\n", ehdr64.e_phnum);
 	} else {                /* ELF32 */
 		if (!get_elf32_ehdr(info->fd_memory,
 				    info->name_memory, &ehdr32)) {
@@ -6934,6 +6939,7 @@ write_elf_header(struct cache_data *cd_header)
 	offset_note_memory = note.p_offset;
 	note.p_offset      = offset_note_dumpfile;
 	size_note          = note.p_filesz;
+	DEBUG_MSG("note.p_offset=0x%lx .p_filesz=0x%lx\n", note.p_offset, note.p_filesz);
 
 	/*
 	 * Reserve a space to store the whole program headers.
@@ -6955,6 +6961,7 @@ write_elf_header(struct cache_data *cd_header)
 					roundup(size_eraseinfo, 4);
 	}
 
+	DEBUG_MSG("note cd_header->offset=0x%lx\n", cd_header->offset);
 	if (!write_elf_phdr(cd_header, &note))
 		goto out;
 
@@ -7499,7 +7506,7 @@ get_loads_dumpfile_cyclic(void)
 				if (!create_2nd_bitmap(&cycle))
 					return FALSE;
 			}
-			for (pfn = MAX(pfn_start, cycle.start_pfn); pfn < cycle.end_pfn; pfn++) {
+			for (pfn = cycle.start_pfn; pfn < cycle.end_pfn; pfn++) {
 				if (!is_dumpable(info->bitmap2, pfn, &cycle)) {
 					num_excluded++;
 					continue;
@@ -7585,6 +7592,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 		if (frac_tail)
 			pfn_end++;
 
+		DEBUG_MSG("pS:  %10llx pE:%10llx\n", pfn_start, pfn_end);
 		for_each_cycle(pfn_start, pfn_end, &cycle) {
 			/*
 			 * Update target region and partial bitmap if necessary.
@@ -7594,7 +7602,11 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 					return FALSE;
 			}
 
-			for (pfn = MAX(pfn_start, cycle.start_pfn); pfn < cycle.end_pfn; pfn++) {
+			DEBUG_MSG("  cS:%10llx cE:%10llx\n", cycle.start_pfn, cycle.end_pfn);
+			for (pfn = cycle.start_pfn; pfn < cycle.end_pfn; pfn++) {
+				if (info->flag_cyclic)
+					pfn_memhole--;
+
 				if (!is_dumpable(info->bitmap2, pfn, &cycle)) {
 					num_excluded++;
 					if ((pfn == pfn_end - 1) && frac_tail)
@@ -7659,16 +7671,20 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 				/*
 				 * Write a PT_LOAD header.
 				 */
+				DEBUG_MSG("    head->off=%10lx load.p_addr=%10lx .p_off=%10lx .filesz=%10lx .memsz=%10lx",
+					cd_header->offset, load.p_paddr, load.p_offset, load.p_filesz, load.p_memsz);
 				if (!write_elf_phdr(cd_header, &load))
 					return FALSE;
 
 				/*
 				 * Write a PT_LOAD segment.
 				 */
-				if (load.p_filesz)
+				if (load.p_filesz) {
+					DEBUG_MSG(" page->off=%10lx\n", cd_page->offset);
 					if (!write_elf_load_segment(cd_page, paddr,
 								    off_memory, load.p_filesz))
 						return FALSE;
+				} else { DEBUG_MSG("\n"); }
 
 				load.p_paddr += load.p_memsz;
 #ifdef __x86__
@@ -7701,16 +7717,20 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 		/*
 		 * Write a PT_LOAD header.
 		 */
+		DEBUG_MSG("  head->off=%10lx load.p_addr=%10lx .p_off=%10lx .filesz=%10lx .memsz=%10lx",
+			cd_header->offset, load.p_paddr, load.p_offset, load.p_filesz, load.p_memsz);
 		if (!write_elf_phdr(cd_header, &load))
 			return FALSE;
 
 		/*
 		 * Write a PT_LOAD segment.
 		 */
-		if (load.p_filesz)
+		if (load.p_filesz) {
+			DEBUG_MSG(" page->off=%10lx\n", cd_page->offset);
 			if (!write_elf_load_segment(cd_page, paddr,
 						    off_memory, load.p_filesz))
 				return FALSE;
+		} else { DEBUG_MSG("\n"); }
 
 		off_seg_load += load.p_filesz;
 	}
@@ -7718,6 +7738,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 		return FALSE;
 	if (!write_cache_bufsz(cd_page))
 		return FALSE;
+	DEBUG_MSG("head->off=%10lx page->off=%10lx\n", cd_header->offset, cd_page->offset);
 
 	free_bitmap2_buffer();



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
