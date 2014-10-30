Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XjmLa-0006qw-Ne
 for kexec@lists.infradead.org; Thu, 30 Oct 2014 09:48:51 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
 [127.0.0.1])
 by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s9U9m1q7026679
 for <kexec@lists.infradead.org>; Thu, 30 Oct 2014 17:48:01 +0800
From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Subject: [PATCH V3 4/5] Add module of calculating start_pfn and end_pfn in
 each dumpfile
Date: Thu, 30 Oct 2014 17:45:08 +0800
Message-ID: <1414662309-15241-5-git-send-email-zhouwj-fnst@cn.fujitsu.com>
In-Reply-To: <1414662309-15241-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
References: <1414662309-15241-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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
To: kexec@lists.infradead.org

When --split is specified in cyclic mode, start_pfn and end_pfn of each dumpfile
will be calculated to make each dumpfile have the same size.

Signed-off-by: Qiao Nuohan <qiaonuohan@cn.fujitsu.com>
Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
---
 makedumpfile.c |   71 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 66 insertions(+), 5 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 9ead207..1468566 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -8218,6 +8218,63 @@ out:
 		return ret;
 }
 
+/*
+ * calculate end_pfn of one dumpfile.
+ * try to make every output file have the same size.
+ * splitblock_table is used to reduce calculate time.
+ */
+
+#define CURRENT_SPLITBLOCK_PFN_NUM (*cur_splitblock_num * splitblock->page_per_splitblock)
+mdf_pfn_t
+calculate_end_pfn_by_splitblock(mdf_pfn_t start_pfn,
+				 int *cur_splitblock_num)
+{
+	if (start_pfn >= info->max_mapnr)
+		return info->max_mapnr;
+
+	mdf_pfn_t end_pfn;
+	long long pfn_needed, offset;
+	char *splitblock_value_offset;
+
+	pfn_needed = info->num_dumpable / info->num_dumpfile;
+	offset = *cur_splitblock_num * splitblock->entry_size;
+	splitblock_value_offset = splitblock->table + offset;
+	end_pfn = start_pfn;
+
+	while (*cur_splitblock_num < splitblock->num && pfn_needed > 0) {
+		pfn_needed -= read_from_splitblock_table(splitblock_value_offset);
+		splitblock_value_offset += splitblock->entry_size;
+		++*cur_splitblock_num;
+	}
+
+	end_pfn = CURRENT_SPLITBLOCK_PFN_NUM;
+	if (end_pfn > info->max_mapnr)
+		end_pfn = info->max_mapnr;
+
+	return end_pfn;
+}
+
+/*
+ * calculate start_pfn and end_pfn in each output file.
+ */
+static int setup_splitting_cyclic(void)
+{
+	int i;
+	mdf_pfn_t start_pfn, end_pfn;
+	int cur_splitblock_num = 0;
+	start_pfn = end_pfn = 0;
+
+	for (i = 0; i < info->num_dumpfile; i++) {
+		start_pfn = end_pfn;
+		end_pfn = calculate_end_pfn_by_splitblock(start_pfn,
+							  &cur_splitblock_num);
+		SPLITTING_START_PFN(i) = start_pfn;
+		SPLITTING_END_PFN(i) = end_pfn;
+	}
+
+	return TRUE;
+}
+
 int
 setup_splitting(void)
 {
@@ -8231,12 +8288,16 @@ setup_splitting(void)
 		return FALSE;
 
 	if (info->flag_cyclic) {
-		for (i = 0; i < info->num_dumpfile; i++) {
-			SPLITTING_START_PFN(i) = divideup(info->max_mapnr, info->num_dumpfile) * i;
-			SPLITTING_END_PFN(i)   = divideup(info->max_mapnr, info->num_dumpfile) * (i + 1);
+		int ret = FALSE;
+
+		if(!prepare_bitmap2_buffer_cyclic()){
+			free_bitmap_buffer();
+			return ret;
 		}
-		if (SPLITTING_END_PFN(i-1) > info->max_mapnr)
-			SPLITTING_END_PFN(i-1) = info->max_mapnr;
+		ret = setup_splitting_cyclic();
+		free_bitmap2_buffer_cyclic();
+
+		return ret;
         } else {
 		initialize_2nd_bitmap(&bitmap2);
 
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
