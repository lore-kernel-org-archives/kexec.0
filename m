Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XYV53-0006aA-HZ
 for kexec@lists.infradead.org; Mon, 29 Sep 2014 07:09:10 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
 [127.0.0.1])
 by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s8T78RJM024431
 for <kexec@lists.infradead.org>; Mon, 29 Sep 2014 15:08:27 +0800
From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Subject: [PATCH v1 4/5] makedumpfile: Add module of calculating start_pfn and
 end_pfn in each dumpfile
Date: Mon, 29 Sep 2014 15:06:26 +0800
Message-ID: <1411974387-10839-5-git-send-email-zhouwj-fnst@cn.fujitsu.com>
In-Reply-To: <1411974387-10839-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
References: <1411974387-10839-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Signed-off-by: Qiao Nuohan <qiaonuohan@cn.fujitsu.com>
Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
---
 makedumpfile.c |  109 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 104 insertions(+), 5 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index c6ea635..3e66346 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -8183,6 +8183,103 @@ out:
 		return ret;
 }
 
+/*
+ * calculate end pfn in incomplete block or memory not managed by block
+ */
+mdf_pfn_t
+calculate_end_pfn_in_cycle(mdf_pfn_t start, mdf_pfn_t max,
+			    mdf_pfn_t end_pfn, long long pfn_needed_by_per_dumpfile)
+{
+	struct cycle cycle;
+	for_each_cycle(start,max,&cycle) {
+		if (!exclude_unnecessary_pages_cyclic(&cycle))
+			return FALSE;
+		while (end_pfn < cycle.end_pfn) {
+			end_pfn++;
+			if (is_dumpable_cyclic(info->partial_bitmap2, end_pfn, &cycle)){
+				if (--pfn_needed_by_per_dumpfile <= 0)
+					return ++end_pfn;
+			}
+		}
+	}
+	return ++end_pfn;
+}
+
+/*
+ * calculate end_pfn of one dumpfile.
+ * try to make every output file have the same size.
+ * block_table is used to reduce calculate time.
+ */
+
+#define CURRENT_BLOCK_PFN_NUM (*current_block * block->page_per_block)
+mdf_pfn_t
+calculate_end_pfn_by_block(mdf_pfn_t start_pfn,
+			   int *current_block,
+			   long long *current_block_pfns){
+	mdf_pfn_t end_pfn;
+	long long pfn_needed_by_per_dumpfile,offset;
+	pfn_needed_by_per_dumpfile = info->num_dumpable / info->num_dumpfile;
+	offset = *current_block * block->entry_size;
+	end_pfn = start_pfn;
+	char *block_inner = block->table + offset;
+	//calculate the part containing complete block
+	while (*current_block < block->num && pfn_needed_by_per_dumpfile > 0) {
+		if (*current_block_pfns > 0) {
+			pfn_needed_by_per_dumpfile -= *current_block_pfns ;
+			*current_block_pfns = 0 ;
+		}
+		else
+		pfn_needed_by_per_dumpfile -= read_value_from_block_table(block_inner);
+		block_inner += block->entry_size;
+		++*current_block;
+	}
+	//deal with complete block
+	if (pfn_needed_by_per_dumpfile == 0)
+		end_pfn = CURRENT_BLOCK_PFN_NUM;
+	//deal with incomplete block
+	if (pfn_needed_by_per_dumpfile < 0) {
+		--*current_block;
+		block_inner -= block->entry_size;
+		end_pfn = CURRENT_BLOCK_PFN_NUM;
+		*current_block_pfns = (-1) * pfn_needed_by_per_dumpfile;
+		pfn_needed_by_per_dumpfile += read_value_from_block_table(block_inner);
+		end_pfn = calculate_end_pfn_in_cycle(CURRENT_BLOCK_PFN_NUM,
+						     CURRENT_BLOCK_PFN_NUM+block->page_per_block,
+						     end_pfn,pfn_needed_by_per_dumpfile);
+	}
+	//deal with memory not managed by block
+	if (pfn_needed_by_per_dumpfile > 0 && *current_block >= block->num) {
+		mdf_pfn_t cycle_start_pfn = MAX(CURRENT_BLOCK_PFN_NUM,end_pfn);
+		end_pfn=calculate_end_pfn_in_cycle(cycle_start_pfn,
+						   info->max_mapnr,
+						   end_pfn,
+						   pfn_needed_by_per_dumpfile);
+	}
+	return end_pfn;
+}
+/*
+ * calculate start_pfn and end_pfn in each output file.
+ */
+static int setup_splitting_cyclic(void)
+{
+	int i;
+	mdf_pfn_t start_pfn, end_pfn;
+	long long current_block_pfns = 0;
+	int current_block = 0;
+	start_pfn = end_pfn = 0;
+	for (i = 0; i < info->num_dumpfile - 1; i++) {
+		start_pfn = end_pfn;
+		end_pfn = calculate_end_pfn_by_block(start_pfn,
+						     &current_block,
+						     &current_block_pfns);
+		SPLITTING_START_PFN(i) = start_pfn;
+		SPLITTING_END_PFN(i) = end_pfn;
+	}
+	SPLITTING_START_PFN(info->num_dumpfile - 1) = end_pfn;
+	SPLITTING_END_PFN(info->num_dumpfile - 1) = info->max_mapnr;
+	return TRUE;
+}
+
 int
 setup_splitting(void)
 {
@@ -8196,12 +8293,14 @@ setup_splitting(void)
 		return FALSE;
 
 	if (info->flag_cyclic) {
-		for (i = 0; i < info->num_dumpfile; i++) {
-			SPLITTING_START_PFN(i) = divideup(info->max_mapnr, info->num_dumpfile) * i;
-			SPLITTING_END_PFN(i)   = divideup(info->max_mapnr, info->num_dumpfile) * (i + 1);
+		int ret = FALSE;
+		if(!prepare_bitmap2_buffer_cyclic()){
+			free_bitmap_buffer();
+			return ret;
 		}
-		if (SPLITTING_END_PFN(i-1) > info->max_mapnr)
-			SPLITTING_END_PFN(i-1) = info->max_mapnr;
+		ret = setup_splitting_cyclic();
+		free_bitmap2_buffer_cyclic();
+		return ret;
         } else {
 		initialize_2nd_bitmap(&bitmap2);
 
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
