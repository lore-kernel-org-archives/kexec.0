Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1STnbd-0001jX-Db
 for kexec@lists.infradead.org; Mon, 14 May 2012 05:14:06 +0000
Date: Mon, 14 May 2012 14:10:15 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: a bug of "arch/x86_64.c"
Message-Id: <20120514141015.b202a4dd.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20120514083911.7c5b9d24.oomichi@mxs.nes.nec.co.jp>
References: <001201cd2ea5$7bb58e70$7320ab50$%zhang@huawei.com>
 <20120514083911.7c5b9d24.oomichi@mxs.nes.nec.co.jp>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, fngw.zhang@huawei.com, oomichi@mxs.nes.nec.co.jp
Cc: Norbert.Trapp@ts.fujitsu.com

Hello,

On Mon, 14 May 2012 08:39:11 +0900
"Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp> wrote:

> 
> Hi Zhangfengwei,
> 
> Thank you for your patch.
> I'm out of makedumpfile development, and the maintainer is Kumagai-San now.
> So he will review this patch.
> 
> Kumagai-San, can you review this patch ?

Thank you for your work, Zhangfengwei.
However, to be honest, Xen 4 isn't supported now.

About a year ago, Norbert posted the patch below for Xen 4, but I can't
review it yet.
I'm afraid that I don't know much about Xen and the patch is too big to
review, so I need someone who divides the patch into several parts to make
reviews easy.

Would you give me a hand ?


Thanks.
Atsushi Kumagai.

-----------------------------------------------------------------
From: "Trapp, Norbert" <norbert.trapp@ts.fujitsu.com>
To: "tachibana@mxm.nes.nec.co.jp" <tachibana@mxm.nes.nec.co.jp>
Date: Tue, 14 Jun 2011 16:17:00 +0200
Subject: makedumpfile -X and Xen 4


Dear Tachibana-san,

About half a year ago I asked Igawa-san about plans to
adapt "makedumpfile -X" to the new version 4 of Xen.
There were no such plans at the time and so we decided
to try and do it ourselves. I can now offer to transfer
the changes to the current version of makedumpfile and
I asked Igawa-san for assistance. He answered that I
should contact you since you are the main maintainer
meanwhile. It would be nice if you could review the patch
mail I plan to send to the kexec mailing list. With
review I mean the way I implemented and represented the
changes, not necessarily the content. This is the first
time for me to suggest an open source patch.

With kind regards,
Norbert Trapp

[PATCH] makedumpfile: make makedumpfile -X run with Xen 4

Hello,

"makedumpfile -X" for Xen is a good idea to quickly
restart a machine after a crash but still save the information
needed to analyse the cause of the crash in almost all cases.

But in order to use "makedumpfile -X" with the current version
of Xen, i.e. Xen 4, it needs to be adapted.

I did so using SLES 11 with makedumpfile version 1.3.1 and
managed a drastic reduction of the restart time when a machine
with a huge amount of domU memory crashes.

If you are interested we can try to transfer the changes to the
makedumpfile project.

So far I only implemented the Xen 4 interface for X86_64 and in
order to reduce the restart time I changed a bit more than just
finding out the dom0 pages.

I have no experience with supplying patches to sourceforge or any
other open source communities. So I just start with sending the diffs.

List of changes:

* makedumpfile.h
    * Increase LATEST_VERSION KERNEL_VERSION from 2.6.36 to 2.6.37
    * added elf_machine and xen_version info to struct DumpInfo
    * added Xen 4 Memory layout information (copy of xen config)
* makedumpfile.c
    * determine elf_machine and xen_version info for struct DumpInfo
    * added print_progress_always function because the print_progress
      function did not show progress for a long time and always calling
      the time function took too much time.
    * renamed exclude_xen_user_domain to exclude_xen3_user_domain and
      added a function exclude_xen4_user_domain. Added exclude_xen_user_domain
      function that calls either of the above functions depending on
      the Xen version found in the dumpfile. Left exclude_xen3_user_domain
      as it was and implemented exclude_xen4_user_domain function to
      identify dom0 pages in Xen 4. Additionally modified the implementation
      to save time.
* x86_64.c
    * implemented differences in Xen 3 and Xen 4 regarding vaddr, direct and
      text addresses as well as domain list pickled ids.

With kind regards,
Norbert Trapp

diff -Naur makedumpfile-1.3.8/makedumpfile.c makedumpfile-1.3.8_ntr/makedumpfile.c
--- makedumpfile-1.3.8/makedumpfile.c   2011-06-02 04:19:12.000000000 +0200
+++ makedumpfile-1.3.8_ntr/makedumpfile.c       2011-06-14 14:26:44.660000048 +0200
@@ -1264,6 +1264,7 @@
        (*num_load) = 0;
        if ((ehdr64.e_ident[EI_CLASS] == ELFCLASS64)
            && (ehdr32.e_ident[EI_CLASS] != ELFCLASS32)) {
+               info->elf_machine = ehdr64.e_machine;
                (*phnum) = ehdr64.e_phnum;
                for (i = 0; i < ehdr64.e_phnum; i++) {
                        if (!get_elf64_phdr(fd, filename, i, &load64)) {
@@ -1277,6 +1278,7 @@

        } else if ((ehdr64.e_ident[EI_CLASS] != ELFCLASS64)
            && (ehdr32.e_ident[EI_CLASS] == ELFCLASS32)) {
+               info->elf_machine = ehdr32.e_machine;
                (*phnum) = ehdr32.e_phnum;
                for (i = 0; i < ehdr32.e_phnum; i++) {
                        if (!get_elf32_phdr(fd, filename, i, &load32)) {
@@ -2154,7 +2156,8 @@
 }

 long
-get_enum_number(char *enum_name) {
+get_enum_number(char *enum_name)
+{

        dwarf_info.cmd         = DWARF_INFO_GET_ENUM_NUMBER;
        dwarf_info.enum_name   = enum_name;
@@ -3746,15 +3749,13 @@
 get_mem_map(void)
 {
        int ret;
-
-       if (vt.mem_flags & MEMORY_XEN) {
+       if (info->elf_machine != EM_X86_64) {
                if (!get_dom0_mapnr()) {
                        ERRMSG("Can't domain-0 pfn.\n");
                        return FALSE;
                }
                DEBUG_MSG("domain-0 pfn : %llx\n", info->dom0_mapnr);
        }
-
        switch (get_mem_type()) {
        case SPARSEMEM:
                DEBUG_MSG("\n");
@@ -5342,7 +5343,7 @@
 }

 int
-write_start_flat_header()
+write_start_flat_header(void)
 {
        char buf[MAX_SIZE_MDF_HEADER];
        struct makedumpfile_header fh;
@@ -5647,6 +5648,21 @@
 }

 void
+print_progress_always(const char *msg, unsigned long current, unsigned long end)
+{
+       int progress;
+
+       if (current < end) {
+               progress = current * 100 / end;
+       } else
+               progress = 100;
+
+       PROGRESS_MSG("\r");
+       PROGRESS_MSG("%-" PROGRESS_MAXLEN "s: [%3d %%] ", msg, progress);
+       fflush(stderr);
+}
+
+void
 print_progress(const char *msg, unsigned long current, unsigned long end)
 {
        int progress;
@@ -5683,12 +5699,15 @@

 int
 write_elf_load_segment(struct cache_data *cd_page, unsigned long long paddr,
-                      off_t off_memory, long long size)
+                      off_t off_memory, long long size, unsigned long long num_dumped, unsigned long long num_dumpable)
 {
        long page_size = info->page_size;
        long long bufsz_write;
        char buf[info->page_size];
+       unsigned long long per_dumped;
+       int idx;

+       per_dumped = num_dumpable / 100;
        off_memory = paddr_to_offset2(paddr, off_memory);
        if (!off_memory) {
                ERRMSG("Can't convert physaddr(%llx) to an offset.\n",
@@ -5701,7 +5720,12 @@
                return FALSE;
        }

+       idx = 0;
        while (size > 0) {
+               idx++;
+               if ((num_dumped + idx) % per_dumped == 0) {
+                       print_progress_always(PROGRESS_COPY, num_dumped + idx, num_dumpable);
+               }
                if (size >= page_size)
                        bufsz_write = page_size;
                else
@@ -5726,7 +5750,7 @@
        int i, phnum;
        long page_size = info->page_size;
        unsigned long long pfn, pfn_start, pfn_end, paddr, num_excluded;
-       unsigned long long num_dumpable, num_dumped = 0, per;
+       unsigned long long num_dumpable, num_dumped = 0, num_dumped_prev = 0, per;
        unsigned long long memsz, filesz;
        unsigned long frac_head, frac_tail;
        off_t off_seg_load, off_memory;
@@ -5750,6 +5774,7 @@

        gettimeofday(&tv_start, NULL);

+       print_progress_always(PROGRESS_COPY, 0, 1);
        for (i = 0; i < phnum; i++) {
                if (!get_elf_phdr_memory(i, &load))
                        return FALSE;
@@ -5785,10 +5810,8 @@
                                        memsz += page_size;
                                continue;
                        }
-
-                       if ((num_dumped % per) == 0)
-                               print_progress(PROGRESS_COPY, num_dumped, num_dumpable);
-
+                       //if ((num_dumped % per) == 0)
+                       //      print_progress(PROGRESS_COPY, num_dumped, num_dumpable);
                        num_dumped++;

                        /*
@@ -5808,6 +5831,8 @@
                         * is 255 or less, those pages are not excluded.
                         */
                        } else if (num_excluded < PFN_EXCLUDED) {
+                               num_dumpable += num_excluded;
+                               per = num_dumpable / 100;
                                if ((pfn == pfn_end - 1) && frac_tail) {
                                        memsz  += frac_tail;
                                        filesz += (page_size*num_excluded
@@ -5840,8 +5865,10 @@
                         * Write a PT_LOAD segment.
                         */
                        if (!write_elf_load_segment(cd_page, paddr, off_memory,
-                           load.p_filesz))
+                           load.p_filesz, num_dumped_prev, num_dumpable)) {
                                return FALSE;
+                       }
+                       num_dumped_prev = num_dumped;

                        load.p_paddr += load.p_memsz;
 #ifdef __x86__
@@ -5878,9 +5905,11 @@
                /*
                 * Write a PT_LOAD segment.
                 */
-               if (!write_elf_load_segment(cd_page, paddr, off_memory, load.p_filesz))
+               if (!write_elf_load_segment(cd_page, paddr, off_memory, load.p_filesz, num_dumped_prev, num_dumpable))
                        return FALSE;

+               num_dumped_prev = num_dumped;
+
                off_seg_load += load.p_filesz;
        }
        if (!write_cache_bufsz(cd_header))
@@ -5891,7 +5920,7 @@
        /*
         * print [100 %]
         */
-       print_progress(PROGRESS_COPY, num_dumpable, num_dumpable);
+       print_progress_always(PROGRESS_COPY, num_dumpable, num_dumpable);
        print_execution_time(PROGRESS_COPY, &tv_start);
        PROGRESS_MSG("\n");

@@ -6332,6 +6361,46 @@
 }

 int
+get_xen_version(void)
+{
+       unsigned long   xen_major_version;
+       unsigned long   xen_minor_version;
+       unsigned long   xen_extra_version;
+       const off_t             failed = (off_t)-1;
+
+       if (info->xen_major_version && info->xen_minor_version && info->xen_extra_version)
+               return TRUE;
+
+       if (lseek(info->fd_memory, info->offset_xen_crash_info, SEEK_SET) == failed) {
+               ERRMSG("Can't seek the dump memory(%s). %s\n",
+                   info->name_memory, strerror(errno));
+               return FALSE;
+       }
+       if (read(info->fd_memory, &xen_major_version, sizeof(unsigned long))
+           != sizeof(unsigned long)) {
+               ERRMSG("Can't read the dump memory(%s). %s\n",
+                   info->name_memory, strerror(errno));
+               return FALSE;
+       }
+       if (read(info->fd_memory, &xen_minor_version, sizeof(unsigned long))
+           != sizeof(unsigned long)) {
+               ERRMSG("Can't read the dump memory(%s). %s\n",
+                   info->name_memory, strerror(errno));
+               return FALSE;
+       }
+       if (read(info->fd_memory, &xen_extra_version, sizeof(unsigned long))
+           != sizeof(unsigned long)) {
+               ERRMSG("Can't read the dump memory(%s). %s\n",
+                   info->name_memory, strerror(errno));
+               return FALSE;
+       }
+       info->xen_major_version = xen_major_version;
+       info->xen_minor_version = xen_minor_version;
+       info->xen_extra_version = xen_extra_version;
+       return TRUE;
+}
+
+int
 get_xen_phys_start(void)
 {
        off_t offset;
@@ -6368,23 +6437,25 @@
        unsigned int domain_id;
        int num_domain;

-       if (SYMBOL(alloc_bitmap) == NOT_FOUND_SYMBOL) {
-               ERRMSG("Can't get the symbol of alloc_bitmap.\n");
-               return FALSE;
-       }
-       if (!readmem(VADDR_XEN, SYMBOL(alloc_bitmap), &info->alloc_bitmap,
-             sizeof(info->alloc_bitmap))) {
-               ERRMSG("Can't get the value of alloc_bitmap.\n");
-               return FALSE;
-       }
-       if (SYMBOL(max_page) == NOT_FOUND_SYMBOL) {
-               ERRMSG("Can't get the symbol of max_page.\n");
-               return FALSE;
-       }
-       if (!readmem(VADDR_XEN, SYMBOL(max_page), &info->max_page,
-           sizeof(info->max_page))) {
-               ERRMSG("Can't get the value of max_page.\n");
-               return FALSE;
+       if (info->xen_major_version <= 3) {
+               if (SYMBOL(alloc_bitmap) == NOT_FOUND_SYMBOL) {
+                       ERRMSG("Can't get the symbol of alloc_bitmap.\n");
+                       return FALSE;
+               }
+               if (!readmem(VADDR_XEN, SYMBOL(alloc_bitmap), &info->alloc_bitmap,
+                   sizeof(info->alloc_bitmap))) {
+                       ERRMSG("Can't get the value of alloc_bitmap.\n");
+                       return FALSE;
+               }
+               if (SYMBOL(max_page) == NOT_FOUND_SYMBOL) {
+                       ERRMSG("Can't get the symbol of max_page.\n");
+                       return FALSE;
+               }
+               if (!readmem(VADDR_XEN, SYMBOL(max_page), &info->max_page,
+                   sizeof(info->max_page))) {
+                       ERRMSG("Can't get the value of max_page.\n");
+                       return FALSE;
+               }
        }

        /*
@@ -6521,6 +6592,9 @@
        MSG("OFFSET(domain.next_in_list): %ld\n", OFFSET(domain.next_in_list));

        MSG("\n");
+       MSG("xen_major_version: %lx\n", info->xen_major_version);
+       MSG("xen_minor_version: %lx\n", info->xen_minor_version);
+       MSG("xen_extra_version: %lx\n", info->xen_extra_version);
        MSG("xen_phys_start: %lx\n", info->xen_phys_start);
        MSG("frame_table_vaddr: %lx\n", info->frame_table_vaddr);
        MSG("xen_heap_start: %lx\n", info->xen_heap_start);
@@ -6658,6 +6732,10 @@

        READ_MEMBER_OFFSET("page_info.count_info", page_info.count_info);
        READ_MEMBER_OFFSET("page_info._domain", page_info._domain);
+       if ((info->xen_major_version < 4) || ((info->xen_major_version == 4) && (info->xen_minor_version < 1))) {
+               if (info->elf_machine == EM_X86_64)
+                       offset_table.page_info._domain = 24;
+       }
        READ_MEMBER_OFFSET("domain.domain_id", domain.domain_id);
        READ_MEMBER_OFFSET("domain.next_in_list", domain.next_in_list);

@@ -6704,7 +6782,7 @@
 }

 int
-exclude_xen_user_domain(void)
+exclude_xen3_user_domain(void)
 {
        int i;
        unsigned int count_info, _domain;
@@ -6775,6 +6853,169 @@
        return TRUE;
 }

+#define BITS_PER_LONG 64
+#define PG_shift(idx) (BITS_PER_LONG - (idx))
+#define PG_mask(x, idx) (x ## UL << PG_shift(idx))
+#define PGC_xen_heap PG_mask(1, 2)
+#define PGC_allocated PG_mask(1, 1)
+#define is_xen_heap_page(page) ((page)->count_info & PGC_xen_heap)
+#define PGC_count_width PG_shift(9)
+#define PGC_count_mask ((1UL<<PGC_count_width)-1)
+#define PGC_state_offlined PG_mask(2, 9)
+#define PGC_state_free    PG_mask(3, 9)
+#define PGC_state         PG_mask(3, 9)
+#define PGC_state_inuse PG_mask(0, 9)
+#define PGC_state_offlining PG_mask(1, 9)
+#define PGC_state_offlined PG_mask(2, 9)
+
+int
+exclude_xen4_user_domain(void)
+{
+       int i;
+       unsigned long long count_info;
+       unsigned int  _domain;
+       unsigned long page_info_addr, first_page_info_addr;
+       unsigned long long pfn, pfn_end;
+       unsigned long long first_pfn, pfn_walker;
+       unsigned long long j, size, total_size, done_size, per_size;
+       struct pt_load_segment *pls;
+       int idx;
+       char *page_info;
+       char *page_info_mem;
+       int page_info_cntr = 0;
+       int retval;
+       unsigned long long paddr;
+       off_t offset = 0;
+       const off_t failed = (off_t)-1;
+       struct timeval tv_start;
+
+       gettimeofday(&tv_start, NULL);
+
+       /*
+        * NOTE: the first half of bitmap is not used for Xen extraction
+        */
+
+       first_pfn = 0;
+       idx = 0;
+
+       if ((page_info_mem = (char *)malloc(SIZE(page_info) * 128)) == NULL) {
+               ERRMSG("Can't allocate memory for the page_info memory. %s\n", strerror(errno));
+               return FALSE;
+       }
+       print_progress(PROGRESS_XEN_DOMAIN, 0, 1);
+       done_size = 0;
+       total_size = 0;
+       for (i = 0; i < info->num_load_memory; i++) {
+               pls = &info->pt_load_segments[i];
+               pfn     = paddr_to_pfn(pls->phys_start);
+               pfn_end = paddr_to_pfn(pls->phys_end);
+               total_size += pfn_end - pfn;
+       }
+       per_size = total_size / 100;
+       for (i = 0; i < info->num_load_memory; i++) {
+               pls = &info->pt_load_segments[i];
+               pfn     = paddr_to_pfn(pls->phys_start);
+               pfn_end = paddr_to_pfn(pls->phys_end);
+               size    = pfn_end - pfn;
+               page_info_cntr = 0;
+               first_page_info_addr = info->frame_table_vaddr + pfn * SIZE(page_info);
+               for (j = 0; pfn < pfn_end; pfn++, j++) {
+                       done_size++;
+                       if ((done_size % per_size) == 0)
+                               print_progress(PROGRESS_XEN_DOMAIN, done_size, total_size);
+                       page_info_addr = info->frame_table_vaddr + pfn * SIZE(page_info);
+                       if (page_info_cntr == 0) {
+                               first_pfn = pfn;
+                               first_page_info_addr = info->frame_table_vaddr + pfn * SIZE(page_info);
+                       }
+                       if (is_in_same_page(first_page_info_addr, page_info_addr + SIZE(page_info))) {
+                               page_info_cntr++;
+                               if (page_info_cntr < 128) {
+                                       continue;
+                               }
+                       }
+                       while (1 == 1) {
+                               paddr = kvtop_xen(first_page_info_addr);
+                               if (paddr == NOT_PADDR) {
+                                       retval = FALSE;
+                                       break;
+                               }
+                               if (!(offset = paddr_to_offset(paddr))) {
+                                       ERRMSG("Can't convert a physical address(%llx) to offset.\n", paddr);
+                                       retval = FALSE;
+                                       break;
+                               }
+                               if (lseek(info->fd_memory, offset, SEEK_SET) == failed) {
+                                       ERRMSG("Can't seek the dump memory(%s). %s\n", info->name_memory, strerror(errno
));
+                                       retval = FALSE;
+                                       break;
+                               }
+
+                               if (read(info->fd_memory, page_info_mem, SIZE(page_info) * (page_info_cntr + 1)) != SIZE
(page_info) * (page_info_cntr + 1)) {
+                                       ERRMSG("Can't read the dump memory(%s). %s\n", info->name_memory, strerror(errno
));
+                                       retval = FALSE;
+                                       break;
+                               }
+                               retval = TRUE;
+                               break;
+                       }
+                       if (retval == FALSE) {
+                               page_info_cntr = 0;
+                               for (pfn_walker = first_pfn; pfn_walker <= pfn; pfn_walker++) {
+                                       clear_bit_on_2nd_bitmap(pfn_walker);
+                               }
+                               continue;
+                       }
+
+                       page_info_cntr = 0;
+                       idx = 0;
+                       for (pfn_walker = first_pfn; pfn_walker <= pfn; pfn_walker++) {
+                               page_info = page_info_mem + SIZE(page_info) * idx;
+                               idx++;
+                               count_info = *((unsigned long long *)(page_info + OFFSET(page_info.count_info)));
+                               _domain = *((unsigned int *)(page_info + OFFSET(page_info._domain)));
+                               if (count_info & PGC_state_free) {
+                                       clear_bit_on_2nd_bitmap(pfn_walker);
+                                       continue;
+                               }
+                               if (count_info & PGC_xen_heap) {
+                                       continue;
+                               }
+                               if (count_info & PGC_allocated) {
+                                       if (_domain == 0) {
+                                               continue;
+                                       }
+                                       if (is_select_domain(_domain)) {
+                                               continue;
+                                       } else {
+                                               clear_bit_on_2nd_bitmap(pfn_walker);
+                                               continue;
+                                       }
+                               }
+                               if (count_info == PGC_state_inuse) {
+                                       continue;
+                               }
+                               clear_bit_on_2nd_bitmap(pfn_walker);
+                       }
+               }
+       }
+       /*
+        * print [100 %]
+        */
+       print_progress(PROGRESS_XEN_DOMAIN, 1, 1);
+       print_execution_time(PROGRESS_XEN_DOMAIN, &tv_start);
+       return TRUE;
+}
+
+int
+exclude_xen_user_domain(void)
+{
+       if (info->xen_major_version < 4)
+           return exclude_xen3_user_domain();
+       else
+           return exclude_xen4_user_domain();
+}
+
 int
 initial_xen(void)
 {
@@ -6843,6 +7084,8 @@
                    info->size_vmcoreinfo_xen, TRUE))
                        return FALSE;
        }
+       if (!get_xen_version())
+               return FALSE;
        if (!get_xen_phys_start())
                return FALSE;
        if (!get_xen_info())
diff -Naur makedumpfile-1.3.8/makedumpfile.h makedumpfile-1.3.8_ntr/makedumpfile.h
--- makedumpfile-1.3.8/makedumpfile.h   2011-06-02 04:19:12.000000000 +0200
+++ makedumpfile-1.3.8_ntr/makedumpfile.h       2011-06-14 11:58:24.400000036 +0200
@@ -447,7 +447,7 @@
 #define KVER_MIN_SHIFT 16
 #define KERNEL_VERSION(x,y,z) (((x) << KVER_MAJ_SHIFT) | ((y) << KVER_MIN_SHIFT) | (z))
 #define OLDEST_VERSION         KERNEL_VERSION(2, 6, 15)/* linux-2.6.15 */
-#define LATEST_VERSION         KERNEL_VERSION(2, 6, 36)/* linux-2.6.36 */
+#define LATEST_VERSION         KERNEL_VERSION(2, 6, 37)/* linux-2.6.37 */

 /*
  * vmcoreinfo in /proc/vmcore
@@ -900,6 +900,7 @@
        /*
         * ELF header info:
         */
+       int                     elf_machine;
        unsigned int            num_load_memory;
        unsigned int            num_load_dumpfile;
        size_t                  offset_load_memory;
@@ -972,6 +973,9 @@
                                              * Different from max_mapnr.
                                              * max_mapnr is the number of page
                                              * in system. */
+       unsigned long xen_major_version;
+       unsigned long xen_minor_version;
+       unsigned long xen_extra_version;
        unsigned long xen_phys_start;
        unsigned long xen_heap_start;   /* start mfn of xen heap area */
        unsigned long xen_heap_end;     /* end mfn(+1) of xen heap area */
@@ -1261,18 +1265,128 @@
 #define MAX_X86_64_FRAMES      (info->page_size / sizeof(unsigned long))

 #define PAGE_OFFSET_XEN_DOM0  (0xffff880000000000) /* different from linux */
-#define HYPERVISOR_VIRT_START (0xffff800000000000)
-#define HYPERVISOR_VIRT_END   (0xffff880000000000)
-#define DIRECTMAP_VIRT_START  (0xffff830000000000)
-#define DIRECTMAP_VIRT_END    (0xffff840000000000)
-#define XEN_VIRT_START        (0xffff828c80000000)
+#define HYPERVISOR_VIRT_START_XEN3 (0xffff800000000000)
+#define HYPERVISOR_VIRT_END_XEN3   (0xffff880000000000)
+#define DIRECTMAP_VIRT_START_XEN3  (0xffff830000000000)
+#define DIRECTMAP_VIRT_END_XEN3    (0xffff840000000000)
+#define XEN_VIRT_START_XEN3        (0xffff828c80000000)
+
+/* copied from xen-4.0.0/xen/include/asm-x86/config.h */
+
+/*
+ * Memory layout:
+ *  0x0000000000000000 - 0x00007fffffffffff [128TB, 2^47 bytes, PML4:0-255]
+ *    Guest-defined use (see below for compatibility mode guests).
+ *  0x0000800000000000 - 0xffff7fffffffffff [16EB]
+ *    Inaccessible: current arch only supports 48-bit sign-extended VAs.
+ *  0xffff800000000000 - 0xffff803fffffffff [256GB, 2^38 bytes, PML4:256]
+ *    Read-only machine-to-phys translation table (GUEST ACCESSIBLE).
+ *  0xffff804000000000 - 0xffff807fffffffff [256GB, 2^38 bytes, PML4:256]
+ *    Reserved for future shared info with the guest OS (GUEST ACCESSIBLE).
+ *  0xffff808000000000 - 0xffff80ffffffffff [512GB, 2^39 bytes, PML4:257]
+ *    ioremap for PCI mmconfig space
+ *  0xffff810000000000 - 0xffff817fffffffff [512GB, 2^39 bytes, PML4:258]
+ *    Guest linear page table.
+ *  0xffff818000000000 - 0xffff81ffffffffff [512GB, 2^39 bytes, PML4:259]
+ *    Shadow linear page table.
+ *  0xffff820000000000 - 0xffff827fffffffff [512GB, 2^39 bytes, PML4:260]
+ *    Per-domain mappings (e.g., GDT, LDT).
+ *  0xffff828000000000 - 0xffff82bfffffffff [256GB, 2^38 bytes, PML4:261]
+ *    Machine-to-phys translation table.
+ *  0xffff82c000000000 - 0xffff82c3ffffffff [16GB,  2^34 bytes, PML4:261]
+ *    ioremap()/fixmap area.
+ *  0xffff82c400000000 - 0xffff82c43fffffff [1GB,   2^30 bytes, PML4:261]
+ *    Compatibility machine-to-phys translation table.
+ *  0xffff82c440000000 - 0xffff82c47fffffff [1GB,   2^30 bytes, PML4:261]
+ *    High read-only compatibility machine-to-phys translation table.
+ *  0xffff82c480000000 - 0xffff82c4bfffffff [1GB,   2^30 bytes, PML4:261]
+ *    Xen text, static data, bss.
+ *  0xffff82c4c0000000 - 0xffff82f5ffffffff [197GB,             PML4:261]
+ *    Reserved for future use.
+ *  0xffff82f600000000 - 0xffff82ffffffffff [40GB,  2^38 bytes, PML4:261]
+ *    Page-frame information array.
+ *  0xffff830000000000 - 0xffff87ffffffffff [5TB, 5*2^40 bytes, PML4:262-271]
+ *    1:1 direct mapping of all physical memory.
+ *  0xffff880000000000 - 0xffffffffffffffff [120TB, PML4:272-511]
+ *    Guest-defined use.
+ *
+ * Compatibility guest area layout:
+ *  0x0000000000000000 - 0x00000000f57fffff [3928MB,            PML4:0]
+ *    Guest-defined use.
+ *  0x00000000f5800000 - 0x00000000ffffffff [168MB,             PML4:0]
+ *    Read-only machine-to-phys translation table (GUEST ACCESSIBLE).
+ *  0x0000000100000000 - 0x0000007fffffffff [508GB,             PML4:0]
+ *    Unused.
+ *  0x0000008000000000 - 0x000000ffffffffff [512GB, 2^39 bytes, PML4:1]
+ *    Hypercall argument translation area.
+ *  0x0000010000000000 - 0x00007fffffffffff [127TB, 2^46 bytes, PML4:2-255]
+ *    Reserved for future use.
+ */
+
+
+#define PML4_ENTRY_BITS 39
+#define PML4_ENTRY_BYTES (1UL << PML4_ENTRY_BITS)
+#define GB(_gb) (_gb ## UL << 30)
+
+#define PML4_ADDR(_slot)        \
+    ((((_slot ## UL) >> 8) * 0xffff000000000000UL) | \
+    (_slot ## UL << PML4_ENTRY_BITS))
+
+#define HYPERVISOR_VIRT_START   (PML4_ADDR(256))
+#define HYPERVISOR_VIRT_END     (HYPERVISOR_VIRT_START + PML4_ENTRY_BYTES*16)
+/* Slot 256: read-only guest-accessible machine-to-phys translation table. */
+#define RO_MPT_VIRT_START       (PML4_ADDR(256))
+#define MPT_VIRT_SIZE           (PML4_ENTRY_BYTES / 2)
+#define RO_MPT_VIRT_END         (RO_MPT_VIRT_START + MPT_VIRT_SIZE)
+/* Slot 257: ioremap for PCI mmconfig space for 2048 segments (512GB)
+ *     - full 16-bit segment support needs 44 bits
+ *     - since PML4 slot has 39 bits, we limit segments to 2048 (11-bits)
+ */
+#define PCI_MCFG_VIRT_START     (PML4_ADDR(257))
+#define PCI_MCFG_VIRT_END       (PCI_MCFG_VIRT_START + PML4_ENTRY_BYTES)
+/* Slot 258: linear page table (guest table). */
+#define LINEAR_PT_VIRT_START    (PML4_ADDR(258))
+#define LINEAR_PT_VIRT_END      (LINEAR_PT_VIRT_START + PML4_ENTRY_BYTES)
+/* Slot 259: linear page table (shadow table). */
+#define SH_LINEAR_PT_VIRT_START (PML4_ADDR(259))
+#define SH_LINEAR_PT_VIRT_END   (SH_LINEAR_PT_VIRT_START + PML4_ENTRY_BYTES)
+/* Slot 260: per-domain mappings. */
+#define PERDOMAIN_VIRT_START    (PML4_ADDR(260))
+#define PERDOMAIN_VIRT_END      (PERDOMAIN_VIRT_START + (PERDOMAIN_MBYTES<<20))
+#define PERDOMAIN_MBYTES        (PML4_ENTRY_BYTES >> (20 + PAGETABLE_ORDER))
+/* Slot 261: machine-to-phys conversion table (256GB). */
+#define RDWR_MPT_VIRT_START     (PML4_ADDR(261))
+#define RDWR_MPT_VIRT_END       (RDWR_MPT_VIRT_START + MPT_VIRT_SIZE)
+/* Slot 261: ioremap()/fixmap area (16GB). */
+#define IOREMAP_VIRT_START      RDWR_MPT_VIRT_END
+#define IOREMAP_VIRT_END        (IOREMAP_VIRT_START + GB(16))
+/* Slot 261: compatibility machine-to-phys conversion table (1GB). */
+#define RDWR_COMPAT_MPT_VIRT_START IOREMAP_VIRT_END
+#define RDWR_COMPAT_MPT_VIRT_END (RDWR_COMPAT_MPT_VIRT_START + GB(1))
+/* Slot 261: high read-only compat machine-to-phys conversion table (1GB). */
+#define HIRO_COMPAT_MPT_VIRT_START RDWR_COMPAT_MPT_VIRT_END
+#define HIRO_COMPAT_MPT_VIRT_END (HIRO_COMPAT_MPT_VIRT_START + GB(1))
+/* Slot 261: xen text, static data and bss (1GB). */
+#define XEN_VIRT_START          (HIRO_COMPAT_MPT_VIRT_END)
+#define XEN_VIRT_END            (XEN_VIRT_START + GB(1))
+/* Slot 261: page-frame information array (40GB). */
+#define FRAMETABLE_VIRT_END     DIRECTMAP_VIRT_START
+#define FRAMETABLE_SIZE         ((DIRECTMAP_SIZE >> PAGE_SHIFT) * \
+                                 sizeof(struct page_info))
+#define FRAMETABLE_VIRT_START   (FRAMETABLE_VIRT_END - FRAMETABLE_SIZE)
+/* Slot 262-271: A direct 1:1 mapping of all of physical memory. */
+#define DIRECTMAP_VIRT_START    (PML4_ADDR(262))
+#define DIRECTMAP_SIZE          (PML4_ENTRY_BYTES*10)
+#define DIRECTMAP_VIRT_END      (DIRECTMAP_VIRT_START + DIRECTMAP_SIZE)

+#ifndef __x86_64__
 #define is_xen_vaddr(x) \
         ((x) >= HYPERVISOR_VIRT_START && (x) < HYPERVISOR_VIRT_END)
 #define is_direct(x) \
         ((x) >= DIRECTMAP_VIRT_START && (x) < DIRECTMAP_VIRT_END)
 #define is_xen_text(x) \
         ((x) >= XEN_VIRT_START && (x) < DIRECTMAP_VIRT_START)
+#endif

 unsigned long long kvtop_xen_x86_64(unsigned long kvaddr);
 #define kvtop_xen(X)   kvtop_xen_x86_64(X)
diff -Naur makedumpfile-1.3.8/x86_64.c makedumpfile-1.3.8_ntr/x86_64.c
--- makedumpfile-1.3.8/x86_64.c 2011-06-02 04:19:12.000000000 +0200
+++ makedumpfile-1.3.8_ntr/x86_64.c     2011-06-14 12:23:38.636000144 +0200
@@ -276,6 +276,45 @@
        return paddr;
 }

+int
+is_xen_vaddr(unsigned long kvaddr)
+{
+       int retval;
+
+       if (info->xen_major_version < 4) {
+           retval = (kvaddr >= HYPERVISOR_VIRT_START_XEN3 && kvaddr < HYPERVISOR_VIRT_END_XEN3);
+           return retval;
+       }
+       retval = (kvaddr >= HYPERVISOR_VIRT_START && kvaddr < HYPERVISOR_VIRT_END);
+       return retval;
+}
+
+int
+is_direct(unsigned long kvaddr)
+{
+       int retval;
+
+       if (info->xen_major_version < 4) {
+           retval = (kvaddr >= DIRECTMAP_VIRT_START_XEN3 && kvaddr < DIRECTMAP_VIRT_END_XEN3);
+           return retval;
+       }
+       retval = (kvaddr >= DIRECTMAP_VIRT_START && kvaddr < DIRECTMAP_VIRT_END);
+       return retval;
+}
+
+int
+is_xen_text(unsigned long kvaddr)
+{
+       int retval;
+
+       if (info->xen_major_version < 4) {
+           retval = (kvaddr >= XEN_VIRT_START_XEN3 && kvaddr < DIRECTMAP_VIRT_START_XEN3);
+           return retval;
+       }
+       retval = (kvaddr >= XEN_VIRT_START && kvaddr < XEN_VIRT_START + GB(1));
+       return retval;
+}
+
 /*
  * for Xen extraction
  */
@@ -287,11 +326,19 @@
        if (!is_xen_vaddr(kvaddr))
                return NOT_PADDR;

-       if (is_xen_text(kvaddr))
-               return (unsigned long)kvaddr - XEN_VIRT_START + info->xen_phys_start;
+       if (is_xen_text(kvaddr)) {
+               if (info->xen_major_version < 4)
+                   return (unsigned long)kvaddr - XEN_VIRT_START_XEN3 + info->xen_phys_start;
+               else
+                   return (unsigned long)kvaddr - XEN_VIRT_START + info->xen_phys_start;
+       }

-       if (is_direct(kvaddr))
-               return (unsigned long)kvaddr - DIRECTMAP_VIRT_START;
+       if (is_direct(kvaddr)) {
+               if (info->xen_major_version < 4)
+                   return (unsigned long)kvaddr - DIRECTMAP_VIRT_START_XEN3;
+               else
+                   return (unsigned long)kvaddr - DIRECTMAP_VIRT_START;
+       }

        if ((dirp = kvtop_xen_x86_64(SYMBOL(pgd_l4))) == NOT_PADDR)
                return NOT_PADDR;
@@ -358,24 +405,32 @@
        }
        info->frame_table_vaddr = frame_table_vaddr;

-       if (SYMBOL(xenheap_phys_end) == NOT_FOUND_SYMBOL) {
-               ERRMSG("Can't get the symbol of xenheap_phys_end.\n");
-               return FALSE;
-       }
-       if (!readmem(VADDR_XEN, SYMBOL(xenheap_phys_end), &xen_end,
-           sizeof(xen_end))) {
-               ERRMSG("Can't get the value of xenheap_phys_end.\n");
-               return FALSE;
-       }
-       info->xen_heap_start = 0;
-       info->xen_heap_end   = paddr_to_pfn(xen_end);
-
-       /*
-        * pickled_id == domain addr for x86_64
-        */
-       for (i = 0; i < info->num_domain; i++) {
-               info->domain_list[i].pickled_id =
-                       info->domain_list[i].domain_addr;
+       if (info->xen_major_version < 4) {
+               if (SYMBOL(xenheap_phys_end) == NOT_FOUND_SYMBOL) {
+                       ERRMSG("Can't get the symbol of xenheap_phys_end.\n");
+                       return FALSE;
+               }
+               if (!readmem(VADDR_XEN, SYMBOL(xenheap_phys_end), &xen_end,
+                   sizeof(xen_end))) {
+                       ERRMSG("Can't get the value of xenheap_phys_end.\n");
+                       return FALSE;
+               }
+               info->xen_heap_start = 0;
+               info->xen_heap_end   = paddr_to_pfn(xen_end);
+
+               /*
+                * pickled_id == domain addr for x86_64
+                */
+               for (i = 0; i < info->num_domain; i++) {
+                       info->domain_list[i].pickled_id =
+                               info->domain_list[i].domain_addr;
+               }
+       } else {
+               for (i = 0; i < info->num_domain; i++) {
+                       info->domain_list[i].pickled_id =
+                               ((unsigned long)info->domain_list[i].domain_addr -
+                               DIRECTMAP_VIRT_START) >> PAGESHIFT();
+               }
        }

        return TRUE;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
