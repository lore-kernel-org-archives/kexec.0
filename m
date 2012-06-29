Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SkQp1-0008E4-Ra
 for kexec@lists.infradead.org; Fri, 29 Jun 2012 02:20:39 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.160])
 by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id q5T2KOgX007247
 for <kexec@lists.infradead.org>; Fri, 29 Jun 2012 11:20:24 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id q5T2KOM18737 for kexec@lists.infradead.org;
 Fri, 29 Jun 2012 11:20:24 +0900 (JST)
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
 by mailsv.nec.co.jp (8.13.8/8.13.4) with ESMTP id q5T2KOYT022364
 for <kexec@lists.infradead.org>; Fri, 29 Jun 2012 11:20:24 +0900 (JST)
Date: Fri, 29 Jun 2012 11:18:52 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [RFC PATCH v2 4/10] Add function to update target region.
Message-Id: <20120629111852.0c82c294.kumagai-atsushi@mxc.nes.nec.co.jp>
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

update_cyclic_region() updates target region with recalculating partial bitmap
when traverse target region.
This function helps cyclic processing to update partial bitmap for target region.

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 makedumpfile.c |   21 +++++++++++++++++++++
 makedumpfile.h |    9 +++++++++
 2 files changed, 30 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index e7c9f5e..67b3499 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3878,6 +3878,27 @@ exclude_unnecessary_pages_cyclic(void)
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
