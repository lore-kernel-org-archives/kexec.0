Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Txt5R-00008N-Il
 for kexec@lists.infradead.org; Wed, 23 Jan 2013 05:41:27 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.192])
 by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id r0N5fMAt025913
 for <kexec@lists.infradead.org>; Wed, 23 Jan 2013 14:41:22 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id r0N5fMj14028 for kexec@lists.infradead.org;
 Wed, 23 Jan 2013 14:41:22 +0900 (JST)
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
 by mailsv3.nec.co.jp (8.13.8/8.13.4) with ESMTP id r0N5fMn0008126
 for <kexec@lists.infradead.org>; Wed, 23 Jan 2013 14:41:22 +0900 (JST)
Date: Wed, 23 Jan 2013 14:31:02 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [PATCH] makedumpfile: Fix cyclic mode to scrub data with -E option.
Message-Id: <20130123143102.6135a4b2add12bbd7c4b9c2a@mxc.nes.nec.co.jp>
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

Hello,

I found a bug in cyclic mode, I'll merge this patch to next version.


Thanks
Atsushi Kumagai

--
In cyclic mode, get_loads_dumpfile_cyclic() is called as setup for
writing phase. But get_loads_dumpfile_cyclic() calls filter_data_buffer()
via read_pfn(), then filter_info is consumed. As a result, filter_info
doesn't exist at the moment when it is actually necessary to scrub data.

That's why --config option doesn't work correctly in cyclic mode
with -E option.

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 makedumpfile.c |   14 ++++++++++++--
 1 files changed, 12 insertios(+), 2 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index ebdc31a..4187b84 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -5207,6 +5207,7 @@ get_loads_dumpfile_cyclic(void)
 	long page_size = info->page_size;
 	unsigned char buf[info->page_size];
 	unsigned long long pfn, pfn_start, pfn_end, num_excluded;
+	unsigned long long paddr;
 	unsigned long frac_head, frac_tail;
 	Elf64_Phdr load;
 
@@ -5260,8 +5261,12 @@ get_loads_dumpfile_cyclic(void)
 			 * Exclude zero pages.
 			 */
 			if (info->dump_level & DL_EXCLUDE_ZERO) {
-				if (!read_pfn(pfn, buf))
+				paddr = pfn_to_paddr(pfn);
+				if (!readmem(PADDR, paddr, buf, page_size)) {
+					ERRMSG("Can't get the page data(pfn:%llx,max_mapnr:%llx).\n",
+					       pfn, info->max_mapnr);
 					return FALSE;
+				}
 				if (is_zero_page(buf, page_size)) {
 					num_excluded++;
 					continue;
@@ -5291,6 +5296,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 	long page_size = info->page_size;
 	unsigned char buf[info->page_size];
 	unsigned long long pfn, pfn_start, pfn_end, paddr, num_excluded;
+	unsigned long long paddr_buf;
 	unsigned long long num_dumpable, per;
 	unsigned long long memsz, filesz;
 	unsigned long frac_head, frac_tail;
@@ -5370,8 +5376,12 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 			 * Exclude zero pages.
 			 */
 			if (info->dump_level & DL_EXCLUDE_ZERO) {
-				if (!read_pfn(pfn, buf))
+				paddr_buf = pfn_to_paddr(pfn);
+				if (!readmem(PADDR, paddr_buf, buf, page_size)) {
+					ERRMSG("Can't get the page data(pfn:%llx max_mapnr:%llx).\n",
+					       pfn, info->max_mapnr);
 					return FALSE;
+				}
 				if (is_zero_page(buf, page_size)) {
 					pfn_zero++;
 					num_excluded++;
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
