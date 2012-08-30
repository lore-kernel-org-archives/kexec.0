Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T6zbC-0001nT-Fh
 for kexec@lists.infradead.org; Thu, 30 Aug 2012 07:55:35 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.192])
 by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id q7U7tWJ5007021
 for <kexec@lists.infradead.org>; Thu, 30 Aug 2012 16:55:32 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id q7U7tWO16293 for kexec@lists.infradead.org;
 Thu, 30 Aug 2012 16:55:32 +0900 (JST)
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
 by mailsv4.nec.co.jp (8.13.8/8.13.4) with ESMTP id q7U7tWJ5014021
 for <kexec@lists.infradead.org>; Thu, 30 Aug 2012 16:55:32 +0900 (JST)
Date: Thu, 30 Aug 2012 16:47:40 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [PATCH 04/16] [PATCH v3 4/12] Add function to update target region.
Message-Id: <20120830164740.339af9370f72ace28afc687e@mxc.nes.nec.co.jp>
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
Date: Thu, 23 Aug 2012 17:53:55 +0900
Subject: [PATCH 04/16] [PATCH v3 4/12] Add function to update target region.

update_cyclic_region() updates target region with recalculating partial bitmap
when traverse target region.
This function helps cyclic mode to update partial bitmap for target region.

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 makedumpfile.c |   21 +++++++++++++++++++++
 makedumpfile.h |    9 +++++++++
 2 files changed, 30 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index f706e29..64bc031 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3894,6 +3894,27 @@ exclude_unnecessary_pages_cyclic(void)
 }
 
 int
+update_cyclic_region(unsigned long long pfn)
+{
+	if (is_cyclic_region(pfn))
+		return TRUE;
+
+	info->cyclic_start_pfn = round(pfn, PFN_CYCLIC);
+	info->cyclic_end_pfn = info->cyclic_start_pfn + PFN_CYCLIC;
+
+	if (info->cyclic_end_pfn > info->max_mapnr)
+		info->cyclic_end_pfn = info->max_mapnr;
+
+	if (!create_1st_bitmap_cyclic())
+		return FALSE;
+
+	if (!exclude_unnecessary_pages_cyclic())
+		return FALSE;
+
+	return TRUE;
+}
+
+int
 copy_bitmap(void)
 {
 	off_t offset;
diff --git a/makedumpfile.h b/makedumpfile.h
index bf5dd43..1a49aa2 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1418,6 +1418,15 @@ is_dumpable_cyclic(char *bitmap, unsigned long long pfn)
 }
 
 static inline int
+is_cyclic_region(unsigned long long pfn)
+{
+	if (pfn < info->cyclic_start_pfn || info->cyclic_end_pfn <= pfn)
+		return FALSE;
+	else
+		return TRUE;
+}
+
+static inline int
 is_zero_page(unsigned char *buf, long page_size)
 {
 	size_t i;
-- 
1.7.9.2

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
