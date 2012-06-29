Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SkQvJ-0008Ip-Pq
 for kexec@lists.infradead.org; Fri, 29 Jun 2012 02:27:08 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.195])
 by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id q5T2QxWC014736
 for <kexec@lists.infradead.org>; Fri, 29 Jun 2012 11:26:59 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id q5T2Qxc06626 for kexec@lists.infradead.org;
 Fri, 29 Jun 2012 11:26:59 +0900 (JST)
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
 by mailsv3.nec.co.jp (8.13.8/8.13.4) with ESMTP id q5T2QxlR028861
 for <kexec@lists.infradead.org>; Fri, 29 Jun 2012 11:26:59 +0900 (JST)
Date: Fri, 29 Jun 2012 11:25:48 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [RFC PATCH v2 10/10] Change num_dumped value to global for debug
 messages.
Message-Id: <20120629112548.0f70d6ac.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20120629111320.694ec85b.kumagai-atsushi@mxc.nes.nec.co.jp>
References: <20120629111320.694ec85b.kumagai-atsushi@mxc.nes.nec.co.jp>
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
To: kexec@lists.infradead.org

num_dumped value is used to count the number of dumped pages.
The value is defined as local value and doesn't work correctly for cyclic
processing. (Because the value will be initialized by each cycle.)

This patch fix the above issue.

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 makedumpfile.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index be0e15e..67e3727 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -44,6 +44,8 @@ unsigned long long pfn_cache_private;
 unsigned long long pfn_user;
 unsigned long long pfn_free;
 
+unsigned long long num_dumped;
+
 int retcd = FAILED;	/* return code */
 
 #define INITIALIZE_LONG_TABLE(table, value) \
@@ -4627,7 +4629,7 @@ write_elf_pages(struct cache_data *cd_header, struct cache_data *cd_page)
 	int i, phnum;
 	long page_size = info->page_size;
 	unsigned long long pfn, pfn_start, pfn_end, paddr, num_excluded;
-	unsigned long long num_dumpable, num_dumped = 0, per;
+	unsigned long long num_dumpable, per;
 	unsigned long long memsz, filesz;
 	unsigned long frac_head, frac_tail;
 	off_t off_seg_load, off_memory;
@@ -4972,7 +4974,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 	long page_size = info->page_size;
 	unsigned char buf[info->page_size];
 	unsigned long long pfn, pfn_start, pfn_end, paddr, num_excluded;
-	unsigned long long num_dumpable, per, num_dumped=0;
+	unsigned long long num_dumpable, per;
 	unsigned long long memsz, filesz;
 	unsigned long frac_head, frac_tail;
 	off_t off_seg_load, off_memory;
@@ -5189,7 +5191,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 int
 write_kdump_pages(struct cache_data *cd_header, struct cache_data *cd_page)
 {
- 	unsigned long long pfn, per, num_dumpable, num_dumped = 0;
+ 	unsigned long long pfn, per, num_dumpable;
 	unsigned long long start_pfn, end_pfn;
 	unsigned long size_out;
 	struct page_desc pd, pd_zero;
@@ -5383,7 +5385,6 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
 	struct page_desc pd;
 	unsigned char buf[info->page_size], *buf_out = NULL;
 	unsigned long len_buf_out;
-	unsigned long long num_dumped=0;
 	struct timeval tv_start;
 	const off_t failed = (off_t)-1;
 
@@ -7279,7 +7280,7 @@ reassemble_kdump_pages(void)
 	off_t offset_first_ph, offset_ph_org, offset_eraseinfo;
 	off_t offset_data_new, offset_zero_page = 0;
 	unsigned long long pfn, start_pfn, end_pfn;
-	unsigned long long num_dumpable, num_dumped;
+	unsigned long long num_dumpable;
 	unsigned long size_eraseinfo;
 	struct dump_bitmap bitmap2;
 	struct disk_dump_header dh;
-- 
1.7.9.2

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
