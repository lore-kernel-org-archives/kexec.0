Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XjmLG-0006oT-8J
 for kexec@lists.infradead.org; Thu, 30 Oct 2014 09:48:30 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
 [127.0.0.1])
 by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s9U9ltul026667
 for <kexec@lists.infradead.org>; Thu, 30 Oct 2014 17:47:58 +0800
From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Subject: [PATCH V3 1/5] Add support for splitblock
Date: Thu, 30 Oct 2014 17:45:05 +0800
Message-ID: <1414662309-15241-2-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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

When --split option is specified, fair I/O workloads shoud be assigned
for each process. So the start and end pfn of each dumpfile should be
calculated with excluding unnecessary pages. However, it costs a lot of
time to execute excluding for the whole memory. That is why struct
SplitBlock exists. Struct SplitBlock is designed to manage memory, mainly
for recording the number of dumpable pages. We can use the number of
dumpable pages to calculate start and end pfn instead of execute excluding
for the whole memory.

The char array *table in struct SplitBlock is used to record the number of
dumpable pages.
The table entry size is calculated as
                        divideup(log2(splitblock_size / page_size), 8) bytes
The table entry size is calculated, so that the
space table taken will be small enough. And the code will also have a
good performence when the number of pages in one splitblock is big enough.

Signed-off-by: Qiao Nuohan <qiaonuohan@cn.fujitsu.com>
Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
---
 makedumpfile.c |   31 +++++++++++++++++++++++++++++++
 makedumpfile.h |   14 ++++++++++++++
 2 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index b4d43d8..7017943 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -34,6 +34,7 @@ struct srcfile_table	srcfile_table;
 
 struct vm_table		vt = { 0 };
 struct DumpInfo		*info = NULL;
+struct SplitBlock		*splitblock = NULL;
 
 char filename_stdout[] = FILENAME_STDOUT;
 
@@ -5685,6 +5686,36 @@ out:
 	return ret;
 }
 
+/*
+ * cyclic_split mode:
+ *	manage memory by splitblocks,
+ *	divide memory into splitblocks
+ *	use splitblock_table to record numbers of dumpable pages in each
+ *	splitblock
+ */
+
+/*
+ * calculate entry size based on the amount of pages in one splitblock
+ */
+int
+calculate_entry_size(void)
+{
+	int entry_num = 1;
+	int count = 1;
+	int entry_size;
+
+	while (entry_num < splitblock->page_per_splitblock){
+		entry_num = entry_num << 1;
+		count++;
+	}
+
+	entry_size = count / BITPERBYTE;
+	if (count % BITPERBYTE)
+		entry_size++;
+
+	return entry_size;
+}
+
 mdf_pfn_t
 get_num_dumpable(void)
 {
diff --git a/makedumpfile.h b/makedumpfile.h
index 96830b0..7d9c2e6 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1168,10 +1168,24 @@ struct DumpInfo {
 	 */
 	int (*page_is_buddy)(unsigned long flags, unsigned int _mapcount,
 			     unsigned long private, unsigned int _count);
+	/*
+	 * for cyclic_splitting mode, setup splitblock_size
+	 */
+	long long splitblock_size;
 };
 extern struct DumpInfo		*info;
 
 /*
+ * for cyclic_splitting mode,Manage memory by splitblock
+ */
+struct SplitBlock{
+        char *table;
+        long long num;
+        long long page_per_splitblock;
+        int entry_size;                 /* counted by byte */
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
