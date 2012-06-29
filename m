Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SkQpe-0008F9-H6
 for kexec@lists.infradead.org; Fri, 29 Jun 2012 02:21:15 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.160])
 by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id q5T2L96F008619
 for <kexec@lists.infradead.org>; Fri, 29 Jun 2012 11:21:09 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id q5T2L9D21018 for kexec@lists.infradead.org;
 Fri, 29 Jun 2012 11:21:09 +0900 (JST)
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
 by mailsv3.nec.co.jp (8.13.8/8.13.4) with ESMTP id q5T2KrBM024174
 for <kexec@lists.infradead.org>; Fri, 29 Jun 2012 11:21:08 +0900 (JST)
Date: Fri, 29 Jun 2012 11:19:55 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [RFC PATCH v2 5/10] Add function to get num_dumpable for cyclic
 processing.
Message-Id: <20120629111955.89ce90cc.kumagai-atsushi@mxc.nes.nec.co.jp>
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

get_num_dumpable_cyclic() gets the number of dumpable pages with cyclic processing.
This function is used to get info->num_dumpable and it is necessary to decide
the offset of kdump-compressed page data.

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 makedumpfile.c |   17 +++++++++++++++++
 makedumpfile.h |    6 ++++++
 2 files changed, 23 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index 67b3499..30857e3 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -4094,6 +4094,8 @@ create_dump_bitmap(void)
 	if (info->flag_cyclic) {
 		if (!prepare_bitmap_buffer_cyclic())
 			goto out;
+
+		info->num_dumpable = get_num_dumpable_cyclic();
 	} else {
 		if (!prepare_bitmap_buffer())
 			goto out;
@@ -4555,6 +4557,21 @@ get_num_dumpable(void)
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
