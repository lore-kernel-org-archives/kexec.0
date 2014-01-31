Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W941N-0004QO-JA
 for kexec@lists.infradead.org; Fri, 31 Jan 2014 02:40:00 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH v2] vmcore: copy fractional pages into buffers in the
 kdump 2nd kernel
Date: Fri, 31 Jan 2014 02:36:13 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971E47E1@BPXM01GP.gisp.nec.co.jp>
References: <52A579EE.6090107@jp.fujitsu.com>
In-Reply-To: <52A579EE.6090107@jp.fujitsu.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello HATAYAMA-san,

On 2013/12/09 17:06:18, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
> This is a patch for fixing mmap failure due to fractional page issue.
> 
> This patch might be still a bit too large as a single patch and might need to split.
> If you think patch refactoring is needed, please suggest.
> 
> Change Log:
> 
> v1 => v2)
> 
> - Copy fractional pages from 1st kernel to 2nd kernel to reduce read
>   to the fractional pages for reliability.
> 
> - Deal with the case where multiple System RAM areas are contained in
>   a single fractional page.
> 
> Test:
> 
> Tested on X86_64. Fractional pages are created using memmap= kernel
> parameter on the kdump 1st kernel.

Could you tell me more details about how to reproduce this ?
I tried to create such fractional pages to test the patch at
the end of this mail, by using memmap= kernel parameter as you said
like below:

  # cat /proc/iomem
  ...
  100000000-10fff57ff : System RAM
  10fff5800-1100057ff : reserved
  110005800-11fffffff : System RAM

However, I couldn't face the mmap() failure and makedumpfile worked
normally even using mmap() on linux-3.12.1. What am I missing here ?


Thanks
Atsushi Kumagai


From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Date: Thu, 23 Jan 2014 16:06:38 +0900
Subject: [PATCH] Restrict the mapping range to avoid mmap() failure.

Now, we know that mmap() on /proc/vmcore for fractional pages
will fail due to a sanity check in remap_pfn_range().
In that case, current makedumpfile can fall back to read() mode,
but it's still desirable to use mmap() as much as possible for
performance.
This patch restricts the range of mmap() to avoid the fall back.

The original kernel issue was reported in:

  https://lkml.org/lkml/2013/11/13/439

and it will be fixed in kernel 3.14.

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 elf_info.c     | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 elf_info.h     |  4 ++++
 makedumpfile.c | 19 ++++++++++++-----
 3 files changed, 83 insertions(+), 5 deletions(-)

diff --git a/elf_info.c b/elf_info.c
index e350b99..b277f69 100644
--- a/elf_info.c
+++ b/elf_info.c
@@ -488,6 +488,71 @@ page_head_to_phys_end(unsigned long long head_paddr)
 	return 0;
 }
 
+/*
+ *  Calculate a start File Offset of PT_LOAD from a File Offset
+ *  of a page. If this function returns 0x0, the input page is
+ *  not in the memory image.
+ */
+off_t
+offset_to_pt_load_start(off_t offset)
+{
+	int i;
+	off_t pt_load_start;
+	struct pt_load_segment *pls;
+
+	for (i = pt_load_start = 0; i < num_pt_loads; i++) {
+		pls = &pt_loads[i];
+		if ((offset >= pls->file_offset)
+		    && (offset < pls->file_offset +
+			(pls->phys_end - pls->phys_start))) {
+			pt_load_start = pls->file_offset;
+			break;
+		}
+	}
+	return pt_load_start;
+}
+
+/*
+ *  Calculate a end File Offset of PT_LOAD from a File Offset
+ *  of a page. If this function returns 0x0, the input page is
+ *  not in the memory image.
+ */
+off_t
+offset_to_pt_load_end(off_t offset)
+{
+	int i;
+	off_t pt_load_end;
+	struct pt_load_segment *pls;
+
+	for (i = pt_load_end = 0; i < num_pt_loads; i++) {
+		pls = &pt_loads[i];
+		if ((offset >= pls->file_offset)
+		    && (offset < pls->file_offset +
+			(pls->phys_end - pls->phys_start))) {
+			pt_load_end = (off_t)(pls->file_offset +
+					      (pls->phys_end - pls->phys_start));
+			break;
+		}
+	}
+	return pt_load_end;
+}
+
+/*
+ * Judge whether the page is fractional or not.
+ */
+int
+page_is_fractional(off_t page_offset)
+{
+	if (page_offset % info->page_size != 0)
+		return TRUE;
+
+	if (offset_to_pt_load_end(page_offset) - page_offset
+	    < info->page_size)
+		return TRUE;
+
+	return FALSE;
+}
+
 unsigned long long
 vaddr_to_paddr_general(unsigned long long vaddr)
 {
diff --git a/elf_info.h b/elf_info.h
index a60fef3..801faff 100644
--- a/elf_info.h
+++ b/elf_info.h
@@ -32,10 +32,14 @@ off_t paddr_to_offset(unsigned long long paddr);
 off_t paddr_to_offset2(unsigned long long paddr, off_t hint);
 unsigned long long page_head_to_phys_start(unsigned long long head_paddr);
 unsigned long long page_head_to_phys_end(unsigned long long head_paddr);
+off_t offset_to_pt_load_start(off_t offset);
+off_t offset_to_pt_load_end(off_t offset);
 unsigned long long vaddr_to_paddr_general(unsigned long long vaddr);
 off_t vaddr_to_offset_slow(int fd, char *filename, unsigned long long vaddr);
 unsigned long long get_max_paddr(void);
 
+int page_is_fractional(off_t page_offset);
+
 int get_elf64_ehdr(int fd, char *filename, Elf64_Ehdr *ehdr);
 int get_elf32_ehdr(int fd, char *filename, Elf32_Ehdr *ehdr);
 int get_elf_info(int fd, char *filename);
diff --git a/makedumpfile.c b/makedumpfile.c
index 7536274..4dce1e2 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -237,9 +237,10 @@ read_page_desc(unsigned long long paddr, page_desc_t *pd)
 
 static int
 update_mmap_range(off_t offset, int initial) {
-	off_t start_offset;
+	off_t start_offset, end_offset;
 	off_t map_size;
 	off_t max_offset = get_max_file_offset();
+	off_t pt_load_end = offset_to_pt_load_end(offset);
 
 	munmap(info->mmap_buf,
 	       info->mmap_end_offset - info->mmap_start_offset);
@@ -247,9 +248,13 @@ update_mmap_range(off_t offset, int initial) {
 	/*
 	 * offset for mmap() must be page aligned.
 	 */
-	start_offset = round(offset, info->page_size);
+	start_offset = roundup(offset, info->page_size);
+	end_offset = MIN(max_offset, round(pt_load_end, info->page_size));
 
-	map_size = MIN(max_offset - start_offset, info->mmap_region_size);
+	if (!pt_load_end || (end_offset - start_offset) <= 0)
+		return FALSE;
+
+	map_size = MIN(end_offset - start_offset, info->mmap_region_size);
 
 	info->mmap_buf = mmap(NULL, map_size, PROT_READ, MAP_PRIVATE,
 				     info->fd_memory, start_offset);
@@ -282,9 +287,12 @@ is_mapped_with_mmap(off_t offset) {
 
 int
 initialize_mmap(void) {
+	unsigned long long phys_start;
 	info->mmap_region_size = MAP_REGION;
 	info->mmap_buf = MAP_FAILED;
-	if (!update_mmap_range(0, 1))
+
+	get_pt_load(0, &phys_start, NULL, NULL, NULL);
+	if (!update_mmap_range(phys_start, 1))
 		return FALSE;
 
 	return TRUE;
@@ -320,7 +328,8 @@ read_from_vmcore(off_t offset, void *bufptr, unsigned long size)
 {
 	const off_t failed = (off_t)-1;
 
-	if (info->flag_usemmap == MMAP_ENABLE) {
+	if (info->flag_usemmap == MMAP_ENABLE &&
+	    page_is_fractional(offset) == FALSE) {
 		if (!read_with_mmap(offset, bufptr, size)) {
 			ERRMSG("Can't read the dump memory(%s) with mmap().\n",
 			       info->name_memory);
-- 
1.8.0.2

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
