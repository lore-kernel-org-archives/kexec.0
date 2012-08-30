Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T6zfI-0001wD-4a
 for kexec@lists.infradead.org; Thu, 30 Aug 2012 07:59:48 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.193])
 by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id q7U7xkVg003453
 for <kexec@lists.infradead.org>; Thu, 30 Aug 2012 16:59:46 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id q7U7xja24681 for kexec@lists.infradead.org;
 Thu, 30 Aug 2012 16:59:45 +0900 (JST)
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
 by mailsv4.nec.co.jp (8.13.8/8.13.4) with ESMTP id q7U7xj4g016762
 for <kexec@lists.infradead.org>; Thu, 30 Aug 2012 16:59:45 +0900 (JST)
Date: Thu, 30 Aug 2012 16:51:13 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [PATCH 07/16] [PATCH v3 7/12] Add function to get number of PT_LOAD
 for cyclic mode.
Message-Id: <20120830165113.86aae390453a3119f5a58399@mxc.nes.nec.co.jp>
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
Date: Thu, 23 Aug 2012 17:54:08 +0900
Subject: [PATCH 07/16] [PATCH v3 7/12] Add function to get number of PT_LOAD for cyclic mode.

get_loads_dumpfile_cyclic() gets the final number of PT_LOAD for cyclic mode.
This function is necessary to decide the offset of PT_LOAD for writing ELF format.

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 makedumpfile.c |   84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 makedumpfile.h |    2 ++
 2 files changed, 86 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index 6bd888c..f31a3aa 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -4891,6 +4891,90 @@ read_pfn(unsigned long long pfn, unsigned char *buf)
 }
 
 int
+get_loads_dumpfile_cyclic(void)
+{
+	int i, phnum, num_new_load = 0;
+	long page_size = info->page_size;
+	unsigned char buf[info->page_size];
+	unsigned long long pfn, pfn_start, pfn_end, num_excluded;
+	unsigned long frac_head, frac_tail;
+	Elf64_Phdr load;
+
+	/*
+	 * Initialize target reggion and bitmap.
+	 */
+	info->cyclic_start_pfn = 0;
+	info->cyclic_end_pfn = PFN_CYCLIC;
+	if (!create_1st_bitmap_cyclic())
+		return FALSE;
+	if (!exclude_unnecessary_pages_cyclic())
+		return FALSE;
+
+	if (!(phnum = get_phnum_memory()))
+		return FALSE;
+
+	for (i = 0; i < phnum; i++) {
+		if (!get_phdr_memory(i, &load))
+			return FALSE;
+		if (load.p_type != PT_LOAD)
+			continue;
+
+		pfn_start = paddr_to_pfn(load.p_paddr);
+		pfn_end = paddr_to_pfn(load.p_paddr + load.p_memsz);
+		frac_head = page_size - (load.p_paddr % page_size);
+		frac_tail = (load.p_paddr + load.p_memsz) % page_size;
+
+		num_new_load++;
+		num_excluded = 0;
+
+		if (frac_head && (frac_head != page_size))
+			pfn_start++;
+		if (frac_tail)
+			pfn_end++;
+
+		for (pfn = pfn_start; pfn < pfn_end; pfn++) {
+			/*
+			 * Update target region and bitmap
+			 */
+			if (!is_cyclic_region(pfn)) {
+				if (!update_cyclic_region(pfn))
+					return FALSE;
+			}
+
+			if (!is_dumpable_cyclic(info->partial_bitmap2, pfn)) {
+				num_excluded++;
+				continue;
+			}
+
+			/*
+			 * Exclude zero pages.
+			 */
+			if (info->dump_level & DL_EXCLUDE_ZERO) {
+				if (!read_pfn(pfn, buf))
+					return FALSE;
+				if (is_zero_page(buf, page_size)) {
+					num_excluded++;
+					continue;
+				}
+			}
+
+			info->num_dumpable++;
+
+			/*
+			 * If the number of the contiguous pages to be excluded
+			 * is 256 or more, those pages are excluded really.
+			 * And a new PT_LOAD segment is created.
+			 */
+			if (num_excluded >= PFN_EXCLUDED) {
+				num_new_load++;
+			}
+			num_excluded = 0;
+		}
+	}
+	return num_new_load;
+}
+
+int
 write_kdump_pages(struct cache_data *cd_header, struct cache_data *cd_page)
 {
  	unsigned long long pfn, per, num_dumpable, num_dumped = 0;
diff --git a/makedumpfile.h b/makedumpfile.h
index e336814..77b824e 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1516,5 +1516,7 @@ struct elf_prstatus {
  * Function Prototype.
  */
 unsigned long long get_num_dumpable_cyclic(void);
+int get_loads_dumpfile_cyclic(void);
+
 
 #endif /* MAKEDUMPFILE_H */
-- 
1.7.9.2

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
