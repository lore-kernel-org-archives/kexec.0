Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T6zdG-0001r1-5t
 for kexec@lists.infradead.org; Thu, 30 Aug 2012 07:57:43 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.192])
 by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id q7U7vehK008564
 for <kexec@lists.infradead.org>; Thu, 30 Aug 2012 16:57:40 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id q7U7veF20051 for kexec@lists.infradead.org;
 Thu, 30 Aug 2012 16:57:40 +0900 (JST)
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
 by mailsv4.nec.co.jp (8.13.8/8.13.4) with ESMTP id q7U7vNkR015456
 for <kexec@lists.infradead.org>; Thu, 30 Aug 2012 16:57:39 +0900 (JST)
Date: Thu, 30 Aug 2012 16:48:37 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [PATCH 05/16] [PATCH v3 5/12] Add function to get num_dumpable for
 cyclic mode.
Message-Id: <20120830164837.ebf555e6090599ebb90b4095@mxc.nes.nec.co.jp>
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
Date: Thu, 23 Aug 2012 17:53:59 +0900
Subject: [PATCH 05/16] [PATCH v3 5/12] Add function to get num_dumpable for cyclic mode.

get_num_dumpable_cyclic() gets the number of dumpable pages with cyclic mode.
This function is used to get info->num_dumpable and it is necessary to decide
the offset of kdump-compressed page data.

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 makedumpfile.c |   17 +++++++++++++++++
 makedumpfile.h |    6 ++++++
 2 files changed, 23 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index 64bc031..d007aea 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -4110,6 +4110,8 @@ create_dump_bitmap(void)
 	if (info->flag_cyclic) {
 		if (!prepare_bitmap_buffer_cyclic())
 			goto out;
+
+		info->num_dumpable = get_num_dumpable_cyclic();
 	} else {
 		if (!prepare_bitmap_buffer())
 			goto out;
@@ -4571,6 +4573,21 @@ get_num_dumpable(void)
 	return num_dumpable;
 }
 
+unsigned long long
+get_num_dumpable_cyclic(void)
+{
+	unsigned long long pfn, num_dumpable=0;
+
+	for (pfn = 0; pfn < info->max_mapnr; pfn++) {
+		if (!update_cyclic_region(pfn))
+			return FALSE;
+
+		if (is_dumpable_cyclic(info->partial_bitmap2, pfn))
+			num_dumpable++;
+	}
+
+	return num_dumpable;
+}
 
 int
 write_elf_load_segment(struct cache_data *cd_page, unsigned long long paddr,
diff --git a/makedumpfile.h b/makedumpfile.h
index 1a49aa2..e336814 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -938,6 +938,7 @@ struct DumpInfo {
 	char               *partial_bitmap2;
 	unsigned long long cyclic_start_pfn;
 	unsigned long long cyclic_end_pfn;  
+	unsigned long long num_dumpable;
 
 	/*
 	 * sadump info:
@@ -1511,4 +1512,9 @@ struct elf_prstatus {
 
 #endif
 
+/*
+ * Function Prototype.
+ */
+unsigned long long get_num_dumpable_cyclic(void);
+
 #endif /* MAKEDUMPFILE_H */
-- 
1.7.9.2

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
