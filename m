Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aQ8L1-000838-Hb
 for kexec@lists.infradead.org; Mon, 01 Feb 2016 06:51:52 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH] makedumpfile: readpage_elf: handle 0-pages not stored
 in the ELF file
Date: Mon, 1 Feb 2016 06:48:13 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E1B252@BPXM01GP.gisp.nec.co.jp>
References: <20160122233514.GA25777@ycc.fr>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E19AFB@BPXM01GP.gisp.nec.co.jp>
 <20160127085821.3be424e1@hananiah.suse.cz>
 <20160127103741.0e4fec81@hananiah.suse.cz>
In-Reply-To: <20160127103741.0e4fec81@hananiah.suse.cz>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Petr Tesarik <ptesarik@suse.cz>
Cc: Ivan Delalande <colona@arista.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Petr,

> handle 0-pages not stored in the ELF file
>
>Resent to the list.
>
>The list does not like attachments, it seems.
>
>Petr T
>
>On Wed, 27 Jan 2016 08:58:21 +0100
>Petr Tesarik <ptesarik@suse.cz> wrote:
>
>> Hello Atsushi-san,
>>
>> On Wed, 27 Jan 2016 02:21:57 +0000
>> Atsushi Kumagai <ats-kumagai@wm.jp.nec.com> wrote:
>>
>> > Hello Ivan,
>> >
>> > >Handle pages filled with zeros that are not stored in the ELF file
>> > >directly, but have addresses between p_filesz and p_memsz of a segment.
>> >
>> > This fix looks reasonable, thanks for your work.
>> >
>> > >This allows makedumpfile to dump-dmesg from a previously makedumpfile-ed
>> > >vmcore where all 0-pages were excluded (dump_level & 1) for example.
>> >
>> > I have some comments below:
>>
>> Actually, I have already hit another issue with filtered ELF files.
>> When refiltering an ELF file that had already been filtered, the memory
>> size vs. file size can cause wrong max_mapnr calculation for a
>> compressed file. In turn, if some pages were removed at the end of
>> physical memory, those pages are not marked as filtered in the output
>> file, but instead the total RAM appears to be smaller by that amount.
>>
>> I don't think my patch addresses the same issue that Ivan found, but it
>> definitely touches the same area. Please have a look.

Good catch, thanks for your report.

>> Petr Tesarik
>
>From: Petr Tesarik <ptesarik@suse.cz>
>Date: Thu Aug 20 10:43:22 2015 +0200
>Subject: Keep segment memory size when re-filtering ELF dumps
>
>Originally, makedumpfile was designed to read from /proc/vmcore, where
>each segment's p_memsz is equal to its p_filesz. However, makedumpfile
>can also be used to re-filter an already filtered ELF dump file, where
>memory size may be larger than file size. In that case the memory size
>should be used as the size of the segment. This affects:

Does this problem occur only if makedumpfile has done filtering ?
According to the man 5 elf, even the original ELF file can have
"unstored zero pages".

   PT_LOAD     The array element specifies a loadable segment, described  by  p_filesz  and  p_memsz.
               The  bytes  from  the  file are mapped to the beginning of the memory segment.  If the
               segment's memory size p_memsz is larger than the file size p_filesz, the "extra" bytes
               are  defined  to  hold  the value 0 and to follow the segment's initialized area.

If unstored pages will be made only by makedumpfile, what I said
Below has no meaning.

>1. max_mapnr
>   This value is computed as the highest phys_end. If the last segment
>   was filtered, max_mapnr may be too small, and the crash utility will
>   refuse to read that memory (even with --zero_excluded).

Yes, should be computed based on p_memsz.

>2. p_memsz field in ELF dumps
>   The resulting ELF segment p_memsz will be capped to original file's
>   p_filesz, ignoring the original p_memsz.

Yes, should be fixed.

>3. memory holes in KDUMP dumps
>   Pages excluded in the original ELF dump will be appear as memory
>   holes in the resulting KDUMP file's first bitmap.

 a. If an unstored page is a just zero page, it is neither on a memory hole
    nor a filtered page. 
 b. If an unstored page is the result of makedumpfile filtering, it should be
    handled as a filtered page. 

However, I think it's impossible to distinguish whether former or latter
after filtering.

>4. vtop translation
>   Virtual addresses that were filtered out in the original ELF file
>   cannot be translated to physical addresses using the generic vtop
>   translation.

Exactly, should refer to p_memsz for it as you did.

>My fix uses p_memsz to set physical and virtual extents of ELF segments,
>because this is the actual size. However, file size is important when
>accessing page data, so it must be stored separately and checked where
>appropriate. Last but not least, pages that were filtered in the original
>dump file must also be filtered in the destination file, i.e. pages
>between p_filesz and p_memsz must have their corresponding bit cleared in
>the 2nd bitmap.

As I said above, I suspect not all of unstored pages are filtered pages,
I'm not sure exclude_nodata_pages() does right things.
As Ivan's patch does, I guess reading them as zero pages fits ELF's format
specification.


Thanks,
Atsushi Kumagai

>Signed-off-by: Petr Tesarik <ptesarik@suse.com>
>
>---
> elf_info.c     |   37 ++++++++++++++++++++++++++++++-------
> elf_info.h     |    4 ++++
> makedumpfile.c |   26 ++++++++++++++++++++++++++
> 3 files changed, 60 insertions(+), 7 deletions(-)
>
>--- a/elf_info.c
>+++ b/elf_info.c
>@@ -38,6 +38,7 @@
>
> struct pt_load_segment {
> 	off_t			file_offset;
>+	off_t			file_size;
> 	unsigned long long	phys_start;
> 	unsigned long long	phys_end;
> 	unsigned long long	virt_start;
>@@ -162,10 +163,11 @@ dump_Elf_load(Elf64_Phdr *prog, int num_
>
> 	pls = &pt_loads[num_load];
> 	pls->phys_start  = prog->p_paddr;
>-	pls->phys_end    = pls->phys_start + prog->p_filesz;
>+	pls->phys_end    = pls->phys_start + prog->p_memsz;
> 	pls->virt_start  = prog->p_vaddr;
>-	pls->virt_end    = pls->virt_start + prog->p_filesz;
>+	pls->virt_end    = pls->virt_start + prog->p_memsz;
> 	pls->file_offset = prog->p_offset;
>+	pls->file_size   = prog->p_filesz;
>
> 	DEBUG_MSG("LOAD (%d)\n", num_load);
> 	DEBUG_MSG("  phys_start : %llx\n", pls->phys_start);
>@@ -462,7 +464,7 @@ paddr_to_offset(unsigned long long paddr
> 	for (i = offset = 0; i < num_pt_loads; i++) {
> 		pls = &pt_loads[i];
> 		if ((paddr >= pls->phys_start)
>-		    && (paddr < pls->phys_end)) {
>+		    && (paddr < pls->phys_start + pls->file_size)) {
> 			offset = (off_t)(paddr - pls->phys_start) +
> 				pls->file_offset;
> 			break;
>@@ -480,16 +482,14 @@ paddr_to_offset2(unsigned long long padd
> {
> 	int i;
> 	off_t offset;
>-	unsigned long long len;
> 	struct pt_load_segment *pls;
>
> 	for (i = offset = 0; i < num_pt_loads; i++) {
> 		pls = &pt_loads[i];
>-		len = pls->phys_end - pls->phys_start;
> 		if ((paddr >= pls->phys_start)
>-		    && (paddr < pls->phys_end)
>+		    && (paddr < pls->phys_start + pls->file_size)
> 		    && (hint >= pls->file_offset)
>-		    && (hint < pls->file_offset + len)) {
>+		    && (hint < pls->file_offset + pls->file_size)) {
> 			offset = (off_t)(paddr - pls->phys_start) +
> 				pls->file_offset;
> 			break;
>@@ -1095,6 +1095,29 @@ get_pt_load(int idx,
>
> 	return TRUE;
> }
>+
>+int
>+get_pt_extents(int idx,
>+	unsigned long long *phys_start,
>+	unsigned long long *phys_end,
>+	off_t *file_size)
>+{
>+	struct pt_load_segment *pls;
>+
>+	if (num_pt_loads <= idx)
>+		return FALSE;
>+
>+	pls = &pt_loads[idx];
>+
>+	if (phys_start)
>+		*phys_start = pls->phys_start;
>+	if (phys_end)
>+		*phys_end   = pls->phys_end;
>+	if (file_size)
>+		*file_size = pls->file_size;
>+
>+	return TRUE;
>+}
>
> unsigned int
> get_num_pt_loads(void)
>--- a/elf_info.h
>+++ b/elf_info.h
>@@ -61,6 +61,10 @@ int get_pt_load(int idx,
> 	unsigned long long *phys_end,
> 	unsigned long long *virt_start,
> 	unsigned long long *virt_end);
>+int get_pt_extents(int idx,
>+	unsigned long long *phys_start,
>+	unsigned long long *phys_end,
>+	off_t *file_size);
> unsigned int get_num_pt_loads(void);
>
> void set_nr_cpus(int num);
>--- a/makedumpfile.c
>+++ b/makedumpfile.c
>@@ -4395,6 +4395,26 @@ read_start_flat_header(void)
> 	return TRUE;
> }
>
>+static void
>+exclude_nodata_pages(void)
>+{
>+	int i;
>+	unsigned long long phys_start, phys_end;
>+	off_t file_size;
>+
>+	i = 0;
>+	while (get_pt_extents(i, &phys_start, &phys_end, &file_size)) {
>+		unsigned long long pfn, pfn_end;
>+
>+		pfn = paddr_to_pfn(phys_start + file_size);
>+		pfn_end = paddr_to_pfn(phys_end);
>+		while (pfn <= pfn_end)
>+			clear_bit_on_2nd_bitmap(pfn);
>+			++pfn;
>+		++i;
>+	}
>+}
>+
> int
> read_flat_data_header(struct makedumpfile_data_header *fdh)
> {
>@@ -6087,6 +6107,12 @@ create_2nd_bitmap(struct cycle *cycle)
> 	}
>
> 	/*
>+	 * If re-filtering ELF dump, exclude pages that were already
>+	 * excluded in the original file.
>+	 */
>+	exclude_nodata_pages();
>+
>+	/*
> 	 * Exclude cache pages, cache private pages, user data pages,
> 	 * and hwpoison pages.
> 	 */
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
