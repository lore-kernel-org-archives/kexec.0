Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZOyZl-0003Ng-Oe
 for kexec@lists.infradead.org; Tue, 11 Aug 2015 01:42:02 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
 [127.0.0.1])
 by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t7B1cUo2001070
 for <kexec@lists.infradead.org>; Tue, 11 Aug 2015 09:38:30 +0800
From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Subject: [PATCH v5 08/10] Initial and free data used for parallel process
Date: Tue, 11 Aug 2015 09:35:20 +0800
Message-ID: <1439256922-8781-9-git-send-email-zhouwj-fnst@cn.fujitsu.com>
In-Reply-To: <1439256922-8781-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
References: <1439256922-8781-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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

This patch is used to initial/free data for parallel process and
the memory limit is concerned in this function.

Signed-off-by: Qiao Nuohan <qiaonuohan@cn.fujitsu.com>
Signed-off-by: Zhou wenjian <zhouwj-fnst@cn.fujitsu.com>
---
 makedumpfile.c | 202 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 makedumpfile.h |   1 +
 2 files changed, 203 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index a1d1148..cd423e6 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1432,6 +1432,23 @@ open_dump_bitmap(void)
 			SPLITTING_FD_BITMAP(i) = fd;
 		}
 	}
+
+	if (info->num_threads) {
+		/*
+		 * Reserve file descriptors of bitmap for creating dumpfiles
+		 * parallelly, because a bitmap file will be unlinked just after
+		 * this and it is not possible to open a bitmap file later.
+		 */
+		for (i = 0; i < info->num_threads; i++) {
+			if ((fd = open(info->name_bitmap, O_RDONLY)) < 0) {
+				ERRMSG("Can't open the bitmap file(%s). %s\n",
+				    info->name_bitmap, strerror(errno));
+				return FALSE;
+			}
+			FD_BITMAP_PARALLEL(i) = fd;
+		}
+	}
+
 	unlink(info->name_bitmap);
 
 	return TRUE;
@@ -3459,6 +3476,191 @@ calibrate_machdep_info(void)
 }
 
 int
+initial_for_parallel()
+{
+	unsigned long len_buf_out;
+	unsigned long page_data_buf_size;
+	unsigned long limit_size;
+	int page_data_num;
+	int i;
+
+	len_buf_out = calculate_len_buf_out(info->page_size);
+
+	/*
+	 * allocate memory for threads
+	 */
+	if ((info->threads = malloc(sizeof(pthread_t *) * info->num_threads))
+	    == NULL) {
+		MSG("Can't allocate memory for threads. %s\n",
+				strerror(errno));
+		return FALSE;
+	}
+	memset(info->threads, 0, sizeof(pthread_t *) * info->num_threads);
+
+	if ((info->kdump_thread_args =
+			malloc(sizeof(struct thread_args) * info->num_threads))
+	    == NULL) {
+		MSG("Can't allocate memory for arguments of threads. %s\n",
+				strerror(errno));
+		return FALSE;
+	}
+	memset(info->kdump_thread_args, 0, sizeof(struct thread_args) * info->num_threads);
+
+	for (i = 0; i < info->num_threads; i++) {
+		if ((info->threads[i] = malloc(sizeof(pthread_t))) == NULL) {
+			MSG("Can't allocate memory for thread %d. %s",
+					i, strerror(errno));
+			return FALSE;
+		}
+
+		if ((BUF_PARALLEL(i) = malloc(info->page_size)) == NULL) {
+			MSG("Can't allocate memory for the memory buffer. %s\n",
+					strerror(errno));
+			return FALSE;
+		}
+
+		if ((BUF_OUT_PARALLEL(i) = malloc(len_buf_out)) == NULL) {
+			MSG("Can't allocate memory for the compression buffer. %s\n",
+					strerror(errno));
+			return FALSE;
+		}
+
+		if ((MMAP_CACHE_PARALLEL(i) = malloc(sizeof(struct mmap_cache))) == NULL) {
+			MSG("Can't allocate memory for mmap_cache. %s\n",
+					strerror(errno));
+			return FALSE;
+		}
+
+		/*
+		 * initial for mmap_cache
+		 */
+		MMAP_CACHE_PARALLEL(i)->mmap_buf = MAP_FAILED;
+		MMAP_CACHE_PARALLEL(i)->mmap_start_offset = 0;
+		MMAP_CACHE_PARALLEL(i)->mmap_end_offset = 0;
+
+#ifdef USELZO
+		if ((WRKMEM_PARALLEL(i) = malloc(LZO1X_1_MEM_COMPRESS)) == NULL) {
+			MSG("Can't allocate memory for the working memory. %s\n",
+					strerror(errno));
+			return FALSE;
+		}
+#endif
+	}
+
+	/*
+	 * get a safe number of page_data
+	 */
+	page_data_buf_size = MAX(len_buf_out, info->page_size);
+
+	limit_size = (get_free_memory_size()
+		      - MAP_REGION * info->num_threads) * 0.6;
+
+	page_data_num = limit_size / page_data_buf_size;
+
+	info->num_buffers = MIN(NUM_BUFFERS, page_data_num);
+
+	DEBUG_MSG("Number of struct page_data for produce/consume: %d\n",
+			info->num_buffers);
+
+	/*
+	 * allocate memory for page_data
+	 */
+	if ((info->page_data_buf = malloc(sizeof(struct page_data) * info->num_buffers))
+	    == NULL) {
+		MSG("Can't allocate memory for page_data_buf. %s\n",
+				strerror(errno));
+		return FALSE;
+	}
+	memset(info->page_data_buf, 0, sizeof(struct page_data) * info->num_buffers);
+
+	for (i = 0; i < info->num_buffers; i++) {
+		if ((info->page_data_buf[i].buf = malloc(page_data_buf_size)) == NULL) {
+			MSG("Can't allocate memory for buf of page_data_buf. %s\n",
+					strerror(errno));
+			return FALSE;
+		}
+	}
+
+	/*
+	 * initial fd_memory for threads
+	 */
+	for (i = 0; i < info->num_threads; i++) {
+		if ((FD_MEMORY_PARALLEL(i) = open(info->name_memory, O_RDONLY))
+									< 0) {
+			ERRMSG("Can't open the dump memory(%s). %s\n",
+					info->name_memory, strerror(errno));
+			return FALSE;
+		}
+
+		if ((FD_BITMAP_MEMORY_PARALLEL(i) =
+				open(info->name_memory, O_RDONLY)) < 0) {
+			ERRMSG("Can't open the dump memory(%s). %s\n",
+					info->name_memory, strerror(errno));
+			return FALSE;
+		}
+	}
+
+	return TRUE;
+}
+
+void
+free_for_parallel()
+{
+	int i;
+
+	if (info->threads != NULL) {
+		for (i = 0; i < info->num_threads; i++) {
+			if (info->threads[i] != NULL)
+				free(info->threads[i]);
+
+			if (BUF_PARALLEL(i) != NULL)
+				free(BUF_PARALLEL(i));
+
+			if (BUF_OUT_PARALLEL(i) != NULL)
+				free(BUF_OUT_PARALLEL(i));
+
+			if (MMAP_CACHE_PARALLEL(i) != NULL) {
+				if (MMAP_CACHE_PARALLEL(i)->mmap_buf !=
+								MAP_FAILED)
+					munmap(MMAP_CACHE_PARALLEL(i)->mmap_buf,
+					       MMAP_CACHE_PARALLEL(i)->mmap_end_offset
+					       - MMAP_CACHE_PARALLEL(i)->mmap_start_offset);
+
+				free(MMAP_CACHE_PARALLEL(i));
+			}
+#ifdef USELZO
+			if (WRKMEM_PARALLEL(i) != NULL)
+				free(WRKMEM_PARALLEL(i));
+#endif
+
+		}
+		free(info->threads);
+	}
+
+	if (info->kdump_thread_args != NULL)
+		free(info->kdump_thread_args);
+
+	if (info->page_data_buf != NULL) {
+		for (i = 0; i < info->num_buffers; i++) {
+			if (info->page_data_buf[i].buf != NULL)
+				free(info->page_data_buf[i].buf);
+		}
+		free(info->page_data_buf);
+	}
+
+	if (info->parallel_info == NULL)
+		return;
+
+	for (i = 0; i < info->num_threads; i++) {
+		if (FD_MEMORY_PARALLEL(i) > 0)
+			close(FD_MEMORY_PARALLEL(i));
+
+		if (FD_BITMAP_MEMORY_PARALLEL(i) > 0)
+			close(FD_BITMAP_MEMORY_PARALLEL(i));
+	}
+}
+
+int
 initial(void)
 {
 	off_t offset;
diff --git a/makedumpfile.h b/makedumpfile.h
index 7f9773a..1f5bd7f 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -972,6 +972,7 @@ typedef unsigned long long int ulonglong;
  * for parallel process
  */
 
+#define PAGE_DATA_NUM	(50)
 #define WAIT_TIME	(60 * 10)
 #define PTHREAD_FAIL	((void *)-2)
 #define NUM_BUFFERS	(50)
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
