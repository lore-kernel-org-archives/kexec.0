Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xdc4X-0007W1-Uv
 for kexec@lists.infradead.org; Mon, 13 Oct 2014 09:37:46 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
 [127.0.0.1])
 by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s9D9amSf007505
 for <kexec@lists.infradead.org>; Mon, 13 Oct 2014 17:36:48 +0800
From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Subject: [PATCH v2 3/5] Add module of generating table
Date: Mon, 13 Oct 2014 17:34:24 +0800
Message-ID: <1413192866-28140-4-git-send-email-zhouwj-fnst@cn.fujitsu.com>
In-Reply-To: <1413192866-28140-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
References: <1413192866-28140-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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
 makedumpfile.c |   95 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 makedumpfile.h |    2 +
 2 files changed, 96 insertions(+), 1 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index a8d86f6..a6f0be4 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -5208,7 +5208,13 @@ create_dump_bitmap(void)
 	if (info->flag_cyclic) {
 		if (!prepare_bitmap2_buffer_cyclic())
 			goto out;
-		info->num_dumpable = get_num_dumpable_cyclic();
+		if (info->flag_split){
+			if(!prepare_splitblock_table())
+				goto out;
+			info->num_dumpable = get_num_dumpable_cyclic_withsplit();
+		}
+		else
+			info->num_dumpable = get_num_dumpable_cyclic();
 
 		if (!info->flag_elf_dumpfile)
 			free_bitmap2_buffer_cyclic();
@@ -5731,6 +5737,57 @@ read_value_from_splitblock_table(char *splitblock_inner)
 	return ret;
 }
 
+/*
+ * The splitblock size is specified as Kbyte with --splitblock-size <size> option.
+ * if not specified ,set default value
+ */
+int
+check_splitblock_size(void)
+{
+	if (info->splitblock_size){
+		info->splitblock_size <<= 10;
+		if (info->splitblock_size == 0) {
+			ERRMSG("The splitblock size could not be 0. %s.\n", strerror(errno));
+			return FALSE;
+		}
+		if (info->splitblock_size % info->page_size != 0) {
+			ERRMSG("The splitblock size must be align to page_size. %s.\n",
+									strerror(errno));
+			return FALSE;
+		}
+	}
+	else{
+		// set default 1GB
+		info->splitblock_size = 1 << 30;
+	}
+	return TRUE;
+}
+
+int
+prepare_splitblock_table(void)
+{
+	if(!check_splitblock_size())
+		return FALSE;
+	if ((splitblock = calloc(1, sizeof(struct SplitBlock))) == NULL) {
+		ERRMSG("Can't allocate memory for the splitblock. %s.\n", strerror(errno));
+		return FALSE;
+	}
+	splitblock->page_per_splitblock = info->splitblock_size / info->page_size;
+	/*
+	 *divide memory into splitblocks.
+	 *if there is a remainder, called it memory not managed by splitblock
+	 *and it will be also dealt with in function calculate_end_pfn_by_splitblock()
+	 */
+	splitblock->num = info->max_mapnr/splitblock->page_per_splitblock;
+	splitblock->entry_size = calculate_entry_size();
+	if ((splitblock->table = (char *)calloc(sizeof(char), (splitblock->entry_size * splitblock->num)))
+										== NULL) {
+		ERRMSG("Can't allocate memory for the splitblock_table. %s.\n", strerror(errno));
+		return FALSE;
+	}
+	return TRUE;
+}
+
 mdf_pfn_t
 get_num_dumpable(void)
 {
@@ -5746,6 +5803,36 @@ get_num_dumpable(void)
 	return num_dumpable;
 }
 
+/*
+ * generate splitblock_table
+ * modified from function get_num_dumpable_cyclic
+ */
+mdf_pfn_t
+get_num_dumpable_cyclic_withsplit(void)
+{
+	mdf_pfn_t pfn, num_dumpable = 0;
+	mdf_pfn_t dumpable_pfn_num = 0, pfn_num = 0;
+	struct cycle cycle = {0};
+	int pos = 0;
+	for_each_cycle(0, info->max_mapnr, &cycle) {
+		if (!exclude_unnecessary_pages_cyclic(&cycle))
+			return FALSE;
+		for (pfn = cycle.start_pfn; pfn < cycle.end_pfn; pfn++) {
+			if (is_dumpable_cyclic(info->partial_bitmap2, pfn, &cycle)) {
+				num_dumpable++;
+				dumpable_pfn_num++;
+			}
+			if (++pfn_num >= splitblock->page_per_splitblock) {
+				write_value_into_splitblock_table(splitblock->table + pos, dumpable_pfn_num);
+				pos += splitblock->entry_size;
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
@@ -9703,6 +9790,12 @@ out:
 		if (info->page_buf != NULL)
 			free(info->page_buf);
 		free(info);
+
+		if (splitblock) {
+			if (splitblock->table)
+				free(splitblock->table);
+		free(splitblock);
+		}
 	}
 	free_elf_info();
 
diff --git a/makedumpfile.h b/makedumpfile.h
index 98b8404..60e6f2f 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1888,9 +1888,11 @@ struct elf_prstatus {
  * Function Prototype.
  */
 mdf_pfn_t get_num_dumpable_cyclic(void);
+mdf_pfn_t get_num_dumpable_cyclic_withsplit(void);
 int get_loads_dumpfile_cyclic(void);
 int initial_xen(void);
 unsigned long long get_free_memory_size(void);
 int calculate_cyclic_buffer_size(void);
+int prepare_splitblock_table(void);
 
 #endif /* MAKEDUMPFILE_H */
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
