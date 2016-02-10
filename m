Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aTPY9-0000XV-O4
 for kexec@lists.infradead.org; Wed, 10 Feb 2016 07:50:59 +0000
Date: Wed, 10 Feb 2016 08:49:41 +0100
From: Petr Tesarik <ptesarik@suse.cz>
Subject: [PATCH 2/3] makedumpfile: Mark unstored ELF pages as filtered
Message-ID: <20160210084941.026830dc@hananiah.suse.cz>
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

Pages that were filtered in the original dump file should also be filtered
in the destination file, i.e. pages between p_filesz and p_memsz must have
their corresponding bit cleared in the 2nd bitmap. Note that in theory,
such ELF segments might not refer to filtered pages, because the crash
kernel copies the program headers verbatim from elfcorehdr=. However, all
common sources of /proc/vmcore program headers use the same value for each
p_memsz and p_filesz:

a. kexec(8)
   Program headers are created in two places, but in both cases the value
   of p_memsz is equal to p_filesz.
   Reference: kexec/crashdump-elf.c in kexec-tools

b. kexec_file_load(2)
   Conceptually the same code as kexec(8): two places, both set p_filesz
   and p_memsz to the same value.
   Reference: kexec/crashdump-elf.c in Linux kernel

c. created in the crash kernel (s390)
   On s390, program headers are created in the crash kernel, but both
   p_filesz and p_memsz are set to "end - start", i.e. the same value.
   Reference: arch/s390/kernel/crash_dump.c in Linux kernel

The above means that p_memsz > p_filesz only in ELF files that were
processed by makedumpfile, hence it can be safely assumed that pages
between p_filesz and p_memsz were filtered out.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>

---
 elf_info.c     |   26 ++++++++++++++++++++++++++
 elf_info.h     |    5 +++++
 makedumpfile.c |   32 ++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)

--- a/elf_info.c
+++ b/elf_info.c
@@ -1096,6 +1096,32 @@ get_pt_load(int idx,
 	return TRUE;
 }
 
+int
+get_pt_load_extents(int idx,
+	unsigned long long *phys_start,
+	unsigned long long *phys_end,
+	off_t *file_offset,
+	off_t *file_size)
+{
+	struct pt_load_segment *pls;
+
+	if (num_pt_loads <= idx)
+		return FALSE;
+
+	pls = &pt_loads[idx];
+
+	if (phys_start)
+		*phys_start  = pls->phys_start;
+	if (phys_end)
+		*phys_end    = pls->phys_end;
+	if (file_offset)
+		*file_offset = pls->file_offset;
+	if (file_size)
+		*file_size   = pls->file_size;
+
+	return TRUE;
+}
+
 unsigned int
 get_num_pt_loads(void)
 {
--- a/elf_info.h
+++ b/elf_info.h
@@ -61,6 +61,11 @@ int get_pt_load(int idx,
 	unsigned long long *phys_end,
 	unsigned long long *virt_start,
 	unsigned long long *virt_end);
+int get_pt_load_extents(int idx,
+	unsigned long long *phys_start,
+	unsigned long long *phys_end,
+	off_t *file_offset,
+	off_t *file_size);
 unsigned int get_num_pt_loads(void);
 
 void set_nr_cpus(int num);
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -4395,6 +4395,32 @@ read_start_flat_header(void)
 	return TRUE;
 }
 
+static void
+exclude_nodata_pages(struct cycle *cycle)
+{
+	int i;
+	unsigned long long phys_start, phys_end;
+	off_t file_size;
+
+	i = 0;
+	while (get_pt_load_extents(i, &phys_start, &phys_end,
+				   NULL, &file_size)) {
+		unsigned long long pfn, pfn_end;
+
+		pfn = paddr_to_pfn(phys_start + file_size);
+		pfn_end = paddr_to_pfn(phys_end);
+		if (pfn < cycle->start_pfn)
+			pfn = cycle->start_pfn;
+		if (pfn_end >= cycle->end_pfn)
+			pfn_end = cycle->end_pfn - 1;
+		while (pfn <= pfn_end) {
+			clear_bit_on_2nd_bitmap(pfn, cycle);
+			++pfn;
+		}
+		++i;
+	}
+}
+
 int
 read_flat_data_header(struct makedumpfile_data_header *fdh)
 {
@@ -6087,6 +6113,12 @@ create_2nd_bitmap(struct cycle *cycle)
 	}
 
 	/*
+	 * If re-filtering ELF dump, exclude pages that were already
+	 * excluded in the original file.
+	 */
+	exclude_nodata_pages(cycle);
+
+	/*
 	 * Exclude cache pages, cache private pages, user data pages,
 	 * and hwpoison pages.
 	 */

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
