Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T6zi7-00024k-SO
 for kexec@lists.infradead.org; Thu, 30 Aug 2012 08:02:44 +0000
Received: from mailgate4.nec.co.jp ([10.7.69.184])
 by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id q7U82c6N006505
 for <kexec@lists.infradead.org>; Thu, 30 Aug 2012 17:02:38 +0900 (JST)
Received: (from root@localhost) by mailgate4.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id q7U82cY00953 for kexec@lists.infradead.org;
 Thu, 30 Aug 2012 17:02:38 +0900 (JST)
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
 by mailsv3.nec.co.jp (8.13.8/8.13.4) with ESMTP id q7U82bVp004457
 for <kexec@lists.infradead.org>; Thu, 30 Aug 2012 17:02:37 +0900 (JST)
Date: Thu, 30 Aug 2012 16:54:25 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [PATCH 10/16] [PATCH v3 10/12] Change num_dumped value to global
 for debug messages.
Message-Id: <20120830165425.e543df047ce4625c844c739f@mxc.nes.nec.co.jp>
In-Reply-To: <20120830164422.8d05cbcdd650398d5d5cbad9@mxc.nes.nec.co.jp>
References: <20120830164422.8d05cbcdd650398d5d5cbad9@mxc.nes.nec.co.jp>
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

From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Date: Thu, 23 Aug 2012 17:54:21 +0900
Subject: [PATCH 10/16] [PATCH v3 10/12] Change num_dumped value to global for debug messages.

num_dumped value is used to count the number of dumped pages.
The value is defined as local value and doesn't work correctly for cyclic
mode. (Because the value will be initialized by each cycle.)

This patch fix the above issue.

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 makedumpfile.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 6dfd397..cc90d39 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -44,6 +44,8 @@ unsigned long long pfn_cache_private;
 unsigned long long pfn_user;
 unsigned long long pfn_free;
 
+unsigned long long num_dumped;
+
 int retcd = FAILED;	/* return code */
 
 #define INITIALIZE_LONG_TABLE(table, value) \
@@ -4643,7 +4645,7 @@ write_elf_pages(struct cache_data *cd_header, struct cache_data *cd_page)
 	int i, phnum;
 	long page_size = info->page_size;
 	unsigned long long pfn, pfn_start, pfn_end, paddr, num_excluded;
-	unsigned long long num_dumpable, num_dumped = 0, per;
+	unsigned long long num_dumpable, per;
 	unsigned long long memsz, filesz;
 	unsigned long frac_head, frac_tail;
 	off_t off_seg_load, off_memory;
@@ -4988,7 +4990,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 	long page_size = info->page_size;
 	unsigned char buf[info->page_size];
 	unsigned long long pfn, pfn_start, pfn_end, paddr, num_excluded;
-	unsigned long long num_dumpable, per, num_dumped=0;
+	unsigned long long num_dumpable, per;
 	unsigned long long memsz, filesz;
 	unsigned long frac_head, frac_tail;
 	off_t off_seg_load, off_memory;
@@ -5205,7 +5207,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 int
 write_kdump_pages(struct cache_data *cd_header, struct cache_data *cd_page)
 {
- 	unsigned long long pfn, per, num_dumpable, num_dumped = 0;
+ 	unsigned long long pfn, per, num_dumpable;
 	unsigned long long start_pfn, end_pfn;
 	unsigned long size_out;
 	struct page_desc pd, pd_zero;
@@ -5399,7 +5401,6 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
 	struct page_desc pd;
 	unsigned char buf[info->page_size], *buf_out = NULL;
 	unsigned long len_buf_out;
-	unsigned long long num_dumped=0;
 	const off_t failed = (off_t)-1;
 
 	int ret = FALSE;
@@ -7295,7 +7296,7 @@ reassemble_kdump_pages(void)
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
