Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XYV4k-0006YL-Bu
 for kexec@lists.infradead.org; Mon, 29 Sep 2014 07:08:50 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
 [127.0.0.1])
 by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s8T78PtS024428
 for <kexec@lists.infradead.org>; Mon, 29 Sep 2014 15:08:26 +0800
From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Subject: [PATCH v1 3/5] makedumpfile: Add module of generating table
Date: Mon, 29 Sep 2014 15:06:25 +0800
Message-ID: <1411974387-10839-4-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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

set block size and generate basic information of block table

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Signed-off-by: Qiao Nuohan <qiaonuohan@cn.fujitsu.com>
Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
---
 makedumpfile.c |   86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 86 insertions(+), 0 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index a4cb9b6..c6ea635 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -5731,6 +5731,52 @@ read_value_from_block_table(char *block_inner)
 	return ret;
 }
 
+/*
+ * The block size is specified as Kbyte with --block-size <size> option.
+ * if not specified ,set default value
+ */
+int
+check_block_size(void)
+{
+	if (info->block_size){
+		info->block_size <<= 10;
+		if (info->block_size < info->page_size) {
+			ERRMSG("The block size could not be smaller than page_size. %s.\n",
+									strerror(errno));
+		return FALSE;
+		}
+	}
+	else{
+		// set default 1GB
+		info->block_size = 1 << 30;
+	}
+	return TRUE;
+}
+
+int
+prepare_block_table(void)
+{
+	check_block_size();
+	if ((block = calloc(1, sizeof(struct Block))) == NULL) {
+		ERRMSG("Can't allocate memory for the block. %s.\n", strerror(errno));
+		return FALSE;
+	}
+	block->page_per_block = info->block_size/info->page_size;
+	/*
+	 *divide memory into blocks.
+	 *if there is a remainder, called it memory not managed by block
+	 *and it will be also dealt with in function calculate_end_pfn_by_block()
+	 */
+	block->num = info->max_mapnr/block->page_per_block;
+	block->entry_size = calculate_entry_size();
+	if ((block->table = (char *)calloc(sizeof(char),(block->entry_size * block->num)))
+										== NULL) {
+		ERRMSG("Can't allocate memory for the block_table. %s.\n", strerror(errno));
+		return FALSE;
+	}
+	return TRUE;
+}
+
 mdf_pfn_t
 get_num_dumpable(void)
 {
@@ -5746,9 +5792,43 @@ get_num_dumpable(void)
 	return num_dumpable;
 }
 
+/*
+ * generate block_table
+ * modified from function get_num_dumpable_cyclic
+ */
+mdf_pfn_t
+get_num_dumpable_cyclic_withsplit(void)
+{
+	mdf_pfn_t pfn, num_dumpable = 0;
+	mdf_pfn_t dumpable_pfn_num = 0, pfn_num = 0;
+	struct cycle cycle = {0};
+	int pos = 0;
+	prepare_block_table();
+	for_each_cycle(0, info->max_mapnr, &cycle) {
+		if (!exclude_unnecessary_pages_cyclic(&cycle))
+			return FALSE;
+		for (pfn = cycle.start_pfn; pfn < cycle.end_pfn; pfn++) {
+			if (is_dumpable_cyclic(info->partial_bitmap2, pfn, &cycle)) {
+				num_dumpable++;
+				dumpable_pfn_num++;
+			}
+			if (++pfn_num >= block->page_per_block) {
+				write_value_into_block_table(block->table + pos, dumpable_pfn_num);
+				pos += block->entry_size;
+				pfn_num = 0;
+				dumpable_pfn_num = 0;
+			}
+		}
+	}
+	return num_dumpable;
+}
+
 mdf_pfn_t
 get_num_dumpable_cyclic(void)
 {
+	if(info->flag_split)
+		return get_num_dumpable_cyclic_withsplit();
+
 	mdf_pfn_t pfn, num_dumpable=0;
 	struct cycle cycle = {0};
 
@@ -9703,6 +9783,12 @@ out:
 		if (info->page_buf != NULL)
 			free(info->page_buf);
 		free(info);
+
+		if (block) {
+			if (block->table)
+				free(block->table);
+		free(block);
+		}
 	}
 	free_elf_info();
 
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
