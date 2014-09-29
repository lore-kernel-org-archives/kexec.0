Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XYV4j-0006YL-2C
 for kexec@lists.infradead.org; Mon, 29 Sep 2014 07:08:49 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
 [127.0.0.1])
 by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s8T78NF9024422
 for <kexec@lists.infradead.org>; Mon, 29 Sep 2014 15:08:23 +0800
From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Subject: [PATCH v1 1/5] makedumpfile: Add support for block
Date: Mon, 29 Sep 2014 15:06:23 +0800
Message-ID: <1411974387-10839-2-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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

When --split option is specified, fair I/O workloads shoud be assigned
for each process. So the start and end pfn of each dumpfile should be
calculated with excluding unnecessary pages. However, it costs a lot of
time to execute excluding for the whole memory. That is why struct Block
exists. Struct Block is designed to manage memory, mainly for recording
the number of dumpable pages. We can use the number of dumpable pages to
calculate start and end pfn instead of execute excluding for the whole
memory.

The char array *table in struct Block is used to record the number of
dumpable pages.
The table entry size is calculated as
			divideup(log2(block_size / page_size), 8) bytes
The table entry size is calculated, so that the
space table taken will be small enough. And the code will also have a
good performence when the number of pages in one block is big enough.

Signed-off-by: Qiao Nuohan <qiaonuohan@cn.fujitsu.com>
Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
---
 makedumpfile.c |   23 +++++++++++++++++++++++
 makedumpfile.h |   14 ++++++++++++++
 2 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index b4d43d8..2feda01 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -34,6 +34,7 @@ struct srcfile_table	srcfile_table;
 
 struct vm_table		vt = { 0 };
 struct DumpInfo		*info = NULL;
+struct Block		*block = NULL;
 
 char filename_stdout[] = FILENAME_STDOUT;
 
@@ -5685,6 +5686,28 @@ out:
 	return ret;
 }
 
+/*
+ * cyclic_split mode:
+ *	manage memory by blocks,
+ *	divide memory into blocks
+ *	use block_table to record numbers of dumpable pages in each block
+ */
+
+//calculate entry size based on the amount of pages in one block
+int
+calculate_entry_size(void){
+	int entry_num = 1, count = 1;
+	int entry_size;
+	while (entry_num < block->page_per_block){
+		entry_num = entry_num << 1;
+		count++;
+	}
+	entry_size = count/BITPERBYTE;
+	if (count %BITPERBYTE)
+		entry_size++;
+	return entry_size;
+}
+
 mdf_pfn_t
 get_num_dumpable(void)
 {
diff --git a/makedumpfile.h b/makedumpfile.h
index 96830b0..ed4f799 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1168,10 +1168,24 @@ struct DumpInfo {
 	 */
 	int (*page_is_buddy)(unsigned long flags, unsigned int _mapcount,
 			     unsigned long private, unsigned int _count);
+	/*
+	 *for cyclic_splitting mode, setup block_size
+	 */
+	long long block_size;
 };
 extern struct DumpInfo		*info;
 
 /*
+ *for cyclic_splitting mode,Manage memory by block
+ */
+struct Block{
+        char *table;
+        long long num;
+        long long page_per_block;
+        int entry_size;                 //counted by byte
+};
+
+/*
  * kernel VM-related data
  */
 struct vm_table {
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
