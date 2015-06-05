Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z0mYI-0005sM-O8
 for kexec@lists.infradead.org; Fri, 05 Jun 2015 08:00:31 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
 [127.0.0.1])
 by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t557wW80029014
 for <kexec@lists.infradead.org>; Fri, 5 Jun 2015 15:58:32 +0800
From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Subject: [PATCH RFC 05/11] Add function to initial bitmap for parallel use
Date: Fri, 5 Jun 2015 15:56:59 +0800
Message-ID: <1433491025-7291-6-git-send-email-zhouwj-fnst@cn.fujitsu.com>
In-Reply-To: <1433491025-7291-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
References: <1433491025-7291-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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
Cc: Qiao Nuohan <qiaonuohan@cn.fujitsu.com>

From: Qiao Nuohan <qiaonuohan@cn.fujitsu.com>

initialize_bitmap_memory_parallel and initialize_2nd_bitmap_parallel
is used for parallel process to avoid conflict on bitmap.

Signed-off-by: Qiao Nuohan <qiaonuohan@cn.fujitsu.com>
---
 makedumpfile.c |   20 ++++++++++++++++++++
 makedumpfile.h |   18 ++++++++++++++++++
 2 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 8a69321..05859a3 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3398,6 +3398,16 @@ initialize_bitmap_memory(void)
 	return TRUE;
 }
 
+void
+initialize_bitmap_memory_parallel(struct dump_bitmap *bitmap, int thread_num)
+{
+	bitmap->fd = FD_BITMAP_MEMORY_PARALLEL(thread_num);
+	bitmap->file_name = info->name_memory;
+	bitmap->no_block = -1;
+	memset(bitmap->buf, 0, BUFSIZE_BITMAP);
+	bitmap->offset = info->bitmap_memory->offset;
+}
+
 int
 calibrate_machdep_info(void)
 {
@@ -3713,6 +3723,16 @@ initialize_2nd_bitmap(struct dump_bitmap *bitmap)
 	bitmap->offset = info->len_bitmap / 2;
 }
 
+void
+initialize_2nd_bitmap_parallel(struct dump_bitmap *bitmap, int thread_num)
+{
+	bitmap->fd = FD_BITMAP_PARALLEL(thread_num);
+	bitmap->file_name = info->name_bitmap;
+	bitmap->no_block = -1;
+	memset(bitmap->buf, 0, BUFSIZE_BITMAP);
+	bitmap->offset = info->len_bitmap / 2;
+}
+
 int
 set_bitmap(struct dump_bitmap *bitmap, mdf_pfn_t pfn, int val)
 {
diff --git a/makedumpfile.h b/makedumpfile.h
index 939850f..b1ff561 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -429,6 +429,11 @@ do { \
 #define SPLITTING_SIZE_EI(i)	info->splitting_info[i].size_eraseinfo
 
 /*
+ * Macro for getting parallel info.
+ */
+#define FD_BITMAP_MEMORY_PARALLEL(i)	info->parallel_info[i].fd_bitmap_memory
+#define FD_BITMAP_PARALLEL(i)		info->parallel_info[i].fd_bitmap
+/*
  * kernel version
  *
  * NOTE: the format of kernel_version is as follows
@@ -957,6 +962,18 @@ struct splitting_info {
 	unsigned long		size_eraseinfo;
 } splitting_info_t;
 
+struct parallel_info {
+	int			fd_memory;
+	int 			fd_bitmap_memory;
+	int			fd_bitmap;
+	unsigned char		*buf;
+	unsigned char 		*buf_out;
+	struct mmap_cache	*mmap_cache;
+#ifdef USELZO
+	lzo_bytep		wrkmem;
+#endif
+} parallel_info_t;
+
 struct ppc64_vmemmap {
 	unsigned long		phys;
 	unsigned long		virt;
@@ -1093,6 +1110,7 @@ struct DumpInfo {
 	char			*name_dumpfile;
 	int			num_dumpfile;
 	struct splitting_info	*splitting_info;
+	struct parallel_info	*parallel_info;
 
 	/*
 	 * bitmap info:
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
