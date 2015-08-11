Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZOyZi-0003Ng-IE
 for kexec@lists.infradead.org; Tue, 11 Aug 2015 01:42:01 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
 [127.0.0.1])
 by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t7B1cTFu001067
 for <kexec@lists.infradead.org>; Tue, 11 Aug 2015 09:38:29 +0800
From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Subject: [PATCH v5 07/10] Add write_kdump_pages_parallel to allow parallel
 process
Date: Tue, 11 Aug 2015 09:35:19 +0800
Message-ID: <1439256922-8781-8-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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

Use several threads to read and compress pages and one thread to write
the produced pages into dumpfile. The produced pages will be stored in
a buffer, then the consumer thread will get pages from this buffer.

Signed-off-by: Qiao Nuohan <qiaonuohan@cn.fujitsu.com>
Signed-off-by: Zhou wenjian <zhouwj-fnst@cn.fujitsu.com>
---
 makedumpfile.c | 430 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 makedumpfile.h |  46 ++++++
 2 files changed, 476 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index 9c5da35..a1d1148 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -235,6 +235,31 @@ is_in_same_page(unsigned long vaddr1, unsigned long vaddr2)
 	return FALSE;
 }
 
+static inline unsigned long
+calculate_len_buf_out(long page_size)
+{
+	unsigned long len_buf_out_zlib, len_buf_out_lzo, len_buf_out_snappy;
+	unsigned long len_buf_out;
+
+	len_buf_out_zlib = len_buf_out_lzo = len_buf_out_snappy = 0;
+
+#ifdef USELZO
+	len_buf_out_lzo = page_size + page_size / 16 + 64 + 3;
+#endif
+
+#ifdef USESNAPPY
+	len_buf_out_snappy = snappy_max_compressed_length(page_size);
+#endif
+
+	len_buf_out_zlib = compressBound(page_size);
+
+	len_buf_out = MAX(len_buf_out_zlib,
+			  MAX(len_buf_out_lzo,
+			      len_buf_out_snappy));
+
+	return len_buf_out;
+}
+
 #define BITMAP_SECT_LEN 4096
 static inline int is_dumpable(struct dump_bitmap *, mdf_pfn_t, struct cycle *cycle);
 unsigned long
@@ -6671,6 +6696,411 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 	return TRUE;
 }
 
+void *
+kdump_thread_function_cyclic(void *arg) {
+	void *retval = PTHREAD_FAIL;
+	struct thread_args *kdump_thread_args = (struct thread_args *)arg;
+	struct page_data *page_data_buf = kdump_thread_args->page_data_buf;
+	struct cycle *cycle = kdump_thread_args->cycle;
+	int page_data_num = kdump_thread_args->page_data_num;
+	mdf_pfn_t pfn;
+	int index;
+	int buf_ready;
+	int dumpable;
+	int fd_memory = 0;
+	struct dump_bitmap bitmap_parallel = {0};
+	struct dump_bitmap bitmap_memory_parallel = {0};
+	unsigned char *buf = NULL, *buf_out = NULL;
+	struct mmap_cache *mmap_cache =
+			MMAP_CACHE_PARALLEL(kdump_thread_args->thread_num);
+	unsigned long size_out;
+#ifdef USELZO
+	lzo_bytep wrkmem = WRKMEM_PARALLEL(kdump_thread_args->thread_num);
+#endif
+#ifdef USESNAPPY
+	unsigned long len_buf_out_snappy =
+				snappy_max_compressed_length(info->page_size);
+#endif
+
+	buf = BUF_PARALLEL(kdump_thread_args->thread_num);
+	buf_out = BUF_OUT_PARALLEL(kdump_thread_args->thread_num);
+
+	fd_memory = FD_MEMORY_PARALLEL(kdump_thread_args->thread_num);
+
+	if (info->fd_bitmap) {
+		bitmap_parallel.buf = malloc(BUFSIZE_BITMAP);
+		if (bitmap_parallel.buf == NULL){
+			ERRMSG("Can't allocate memory for bitmap_parallel.buf. %s\n",
+			strerror(errno));
+			goto fail;
+		}
+		initialize_2nd_bitmap_parallel(&bitmap_parallel,
+					kdump_thread_args->thread_num);
+	}
+
+	if (info->flag_refiltering) {
+		bitmap_memory_parallel.buf = malloc(BUFSIZE_BITMAP);
+		if (bitmap_memory_parallel.buf == NULL){
+			ERRMSG("Can't allocate memory for bitmap_memory_parallel.buf. %s\n",
+			strerror(errno));
+			goto fail;
+		}
+		initialize_bitmap_memory_parallel(&bitmap_memory_parallel,
+						kdump_thread_args->thread_num);
+	}
+
+	while (1) {
+		/* get next pfn */
+		pthread_mutex_lock(&info->current_pfn_mutex);
+		pfn = info->current_pfn;
+		info->current_pfn++;
+		pthread_mutex_unlock(&info->current_pfn_mutex);
+
+		if (pfn >= kdump_thread_args->end_pfn)
+			break;
+
+		index = -1;
+		buf_ready = FALSE;
+
+		while (buf_ready == FALSE) {
+			pthread_testcancel();
+
+			index = pfn % page_data_num;
+
+			if (pfn - info->consumed_pfn > info->num_buffers)
+				continue;
+
+			if (page_data_buf[index].ready != 0)
+				continue;
+
+			pthread_mutex_lock(&page_data_buf[index].mutex);
+
+			if (page_data_buf[index].ready != 0)
+				goto unlock;
+
+			buf_ready = TRUE;
+
+			page_data_buf[index].pfn = pfn;
+			page_data_buf[index].ready = 1;
+
+			dumpable = is_dumpable(
+				info->fd_bitmap ? &bitmap_parallel : info->bitmap2,
+				pfn,
+				cycle);
+			page_data_buf[index].dumpable = dumpable;
+			if (!dumpable)
+				goto unlock;
+
+			if (!read_pfn_parallel(fd_memory, pfn, buf,
+					       &bitmap_memory_parallel,
+					       mmap_cache))
+					goto fail;
+
+			filter_data_buffer_parallel(buf, pfn_to_paddr(pfn),
+							info->page_size,
+							&info->filter_mutex);
+
+			if ((info->dump_level & DL_EXCLUDE_ZERO)
+			    && is_zero_page(buf, info->page_size)) {
+				page_data_buf[index].zero = TRUE;
+				goto unlock;
+			}
+
+			page_data_buf[index].zero = FALSE;
+
+			/*
+			 * Compress the page data.
+			 */
+			size_out = kdump_thread_args->len_buf_out;
+			if ((info->flag_compress & DUMP_DH_COMPRESSED_ZLIB)
+			    && ((size_out = kdump_thread_args->len_buf_out),
+				compress2(buf_out, &size_out, buf,
+					  info->page_size,
+					  Z_BEST_SPEED) == Z_OK)
+			    && (size_out < info->page_size)) {
+				page_data_buf[index].flags =
+							DUMP_DH_COMPRESSED_ZLIB;
+				page_data_buf[index].size  = size_out;
+				memcpy(page_data_buf[index].buf, buf_out, size_out);
+#ifdef USELZO
+			} else if (info->flag_lzo_support
+				   && (info->flag_compress
+				       & DUMP_DH_COMPRESSED_LZO)
+				   && ((size_out = info->page_size),
+				       lzo1x_1_compress(buf, info->page_size,
+							buf_out, &size_out,
+							wrkmem) == LZO_E_OK)
+				   && (size_out < info->page_size)) {
+				page_data_buf[index].flags =
+							DUMP_DH_COMPRESSED_LZO;
+				page_data_buf[index].size  = size_out;
+				memcpy(page_data_buf[index].buf, buf_out, size_out);
+#endif
+#ifdef USESNAPPY
+			} else if ((info->flag_compress
+				    & DUMP_DH_COMPRESSED_SNAPPY)
+				   && ((size_out = len_buf_out_snappy),
+				       snappy_compress((char *)buf,
+						       info->page_size,
+						       (char *)buf_out,
+						       (size_t *)&size_out)
+				       == SNAPPY_OK)
+				   && (size_out < info->page_size)) {
+				page_data_buf[index].flags =
+						DUMP_DH_COMPRESSED_SNAPPY;
+				page_data_buf[index].size  = size_out;
+				memcpy(page_data_buf[index].buf, buf_out, size_out);
+#endif
+			} else {
+				page_data_buf[index].flags = 0;
+				page_data_buf[index].size  = info->page_size;
+				memcpy(page_data_buf[index].buf, buf, info->page_size);
+			}
+unlock:
+			pthread_mutex_unlock(&page_data_buf[index].mutex);
+
+		}
+	}
+
+	retval = NULL;
+
+fail:
+	if (bitmap_memory_parallel.fd > 0)
+		close(bitmap_memory_parallel.fd);
+	if (bitmap_parallel.buf != NULL)
+		free(bitmap_parallel.buf);
+	if (bitmap_memory_parallel.buf != NULL)
+		free(bitmap_memory_parallel.buf);
+
+	pthread_exit(retval);
+}
+
+int
+write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
+				  struct cache_data *cd_page,
+				  struct page_desc *pd_zero,
+				  off_t *offset_data, struct cycle *cycle)
+{
+	int ret = FALSE;
+	int res;
+	unsigned long len_buf_out;
+	mdf_pfn_t per;
+	mdf_pfn_t start_pfn, end_pfn;
+	struct page_desc pd;
+	struct timeval tv_start;
+	struct timeval last, new;
+	unsigned long long consuming_pfn;
+	pthread_t **threads = NULL;
+	struct thread_args *kdump_thread_args = NULL;
+	void *thread_result;
+	int page_data_num;
+	struct page_data *page_data_buf = NULL;
+	int i;
+	int index;
+
+	if (info->flag_elf_dumpfile)
+		return FALSE;
+
+	res = pthread_mutex_init(&info->current_pfn_mutex, NULL);
+	if (res != 0) {
+		ERRMSG("Can't initialize current_pfn_mutex. %s\n",
+				strerror(res));
+		goto out;
+	}
+
+	res = pthread_mutex_init(&info->consumed_pfn_mutex, NULL);
+	if (res != 0) {
+		ERRMSG("Can't initialize consumed_pfn_mutex. %s\n",
+				strerror(res));
+		goto out;
+	}
+
+	res = pthread_mutex_init(&info->filter_mutex, NULL);
+	if (res != 0) {
+		ERRMSG("Can't initialize filter_mutex. %s\n", strerror(res));
+		goto out;
+	}
+
+	res = pthread_rwlock_init(&info->usemmap_rwlock, NULL);
+	if (res != 0) {
+		ERRMSG("Can't initialize usemmap_rwlock. %s\n", strerror(res));
+		goto out;
+	}
+
+	len_buf_out = calculate_len_buf_out(info->page_size);
+
+	per = info->num_dumpable / 10000;
+	per = per ? per : 1;
+
+	gettimeofday(&tv_start, NULL);
+
+	start_pfn = cycle->start_pfn;
+	end_pfn   = cycle->end_pfn;
+
+	info->current_pfn = start_pfn;
+	info->consumed_pfn = start_pfn - 1;
+
+	threads = info->threads;
+	kdump_thread_args = info->kdump_thread_args;
+
+	page_data_num = info->num_buffers;
+	page_data_buf = info->page_data_buf;
+
+	for (i = 0; i < page_data_num; i++) {
+		/*
+		 * producer will use pfn in page_data_buf to decide the
+		 * consumed pfn
+		 */
+		page_data_buf[i].pfn = start_pfn - 1;
+		page_data_buf[i].ready = 0;
+		res = pthread_mutex_init(&page_data_buf[i].mutex, NULL);
+		if (res != 0) {
+			ERRMSG("Can't initialize mutex of page_data_buf. %s\n",
+					strerror(res));
+			goto out;
+		}
+	}
+
+	for (i = 0; i < info->num_threads; i++) {
+		kdump_thread_args[i].thread_num = i;
+		kdump_thread_args[i].len_buf_out = len_buf_out;
+		kdump_thread_args[i].start_pfn = start_pfn;
+		kdump_thread_args[i].end_pfn = end_pfn;
+		kdump_thread_args[i].page_data_num = page_data_num;
+		kdump_thread_args[i].page_data_buf = page_data_buf;
+		kdump_thread_args[i].cycle = cycle;
+
+		res = pthread_create(threads[i], NULL,
+				     kdump_thread_function_cyclic,
+				     (void *)&kdump_thread_args[i]);
+		if (res != 0) {
+			ERRMSG("Can't create thread %d. %s\n",
+					i, strerror(res));
+			goto out;
+		}
+	}
+
+	consuming_pfn = start_pfn;
+	index = -1;
+
+	gettimeofday(&last, NULL);
+
+	while (consuming_pfn < end_pfn) {
+		index = consuming_pfn % page_data_num;
+
+		gettimeofday(&new, NULL);
+		if (new.tv_sec - last.tv_sec > WAIT_TIME) {
+			ERRMSG("Can't get data of pfn %llx.\n", consuming_pfn);
+			goto out;
+		}
+
+		/*
+		 * check pfn first without mutex locked to reduce the time
+		 * trying to lock the mutex
+		 */
+		if (page_data_buf[index].pfn != consuming_pfn)
+			continue;
+
+		if (pthread_mutex_trylock(&page_data_buf[index].mutex) != 0)
+			continue;
+
+		/* check whether the found one is ready to be consumed */
+		if (page_data_buf[index].pfn != consuming_pfn ||
+		    page_data_buf[index].ready != 1) {
+			goto unlock;
+		}
+
+		if ((num_dumped % per) == 0)
+			print_progress(PROGRESS_COPY, num_dumped, info->num_dumpable);
+
+		/* next pfn is found, refresh last here */
+		last = new;
+		consuming_pfn++;
+		info->consumed_pfn++;
+		page_data_buf[index].ready = 0;
+
+		if (page_data_buf[index].dumpable == FALSE)
+			goto unlock;
+
+		num_dumped++;
+
+		if (page_data_buf[index].zero == TRUE) {
+			if (!write_cache(cd_header, pd_zero, sizeof(page_desc_t)))
+				goto out;
+			pfn_zero++;
+		} else {
+			pd.flags      = page_data_buf[index].flags;
+			pd.size       = page_data_buf[index].size;
+			pd.page_flags = 0;
+			pd.offset     = *offset_data;
+			*offset_data  += pd.size;
+			/*
+			 * Write the page header.
+			 */
+			if (!write_cache(cd_header, &pd, sizeof(page_desc_t)))
+				goto out;
+			/*
+			 * Write the page data.
+			 */
+			if (!write_cache(cd_page, page_data_buf[index].buf, pd.size))
+				goto out;
+
+		}
+unlock:
+		pthread_mutex_unlock(&page_data_buf[index].mutex);
+	}
+
+	ret = TRUE;
+	/*
+	 * print [100 %]
+	 */
+	print_progress(PROGRESS_COPY, num_dumped, info->num_dumpable);
+	print_execution_time(PROGRESS_COPY, &tv_start);
+	PROGRESS_MSG("\n");
+
+out:
+	if (threads != NULL) {
+		for (i = 0; i < info->num_threads; i++) {
+			if (threads[i] != NULL) {
+				res = pthread_cancel(*threads[i]);
+				if (res != 0 && res != ESRCH)
+					ERRMSG("Can't cancel thread %d. %s\n",
+							i, strerror(res));
+			}
+		}
+
+		for (i = 0; i < info->num_threads; i++) {
+			if (threads[i] != NULL) {
+				res = pthread_join(*threads[i], &thread_result);
+				if (res != 0)
+					ERRMSG("Can't join with thread %d. %s\n",
+							i, strerror(res));
+
+				if (thread_result == PTHREAD_CANCELED)
+					DEBUG_MSG("Thread %d is cancelled.\n", i);
+				else if (thread_result == PTHREAD_FAIL)
+					DEBUG_MSG("Thread %d fails.\n", i);
+				else
+					DEBUG_MSG("Thread %d finishes.\n", i);
+
+			}
+		}
+	}
+
+	if (page_data_buf != NULL) {
+		for (i = 0; i < page_data_num; i++) {
+			pthread_mutex_destroy(&page_data_buf[i].mutex);
+		}
+	}
+
+	pthread_rwlock_destroy(&info->usemmap_rwlock);
+	pthread_mutex_destroy(&info->filter_mutex);
+	pthread_mutex_destroy(&info->consumed_pfn_mutex);
+	pthread_mutex_destroy(&info->current_pfn_mutex);
+
+	return ret;
+}
+
 int
 write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page,
 			 struct page_desc *pd_zero, off_t *offset_data, struct cycle *cycle)
diff --git a/makedumpfile.h b/makedumpfile.h
index 4b0709c..7f9773a 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -431,8 +431,15 @@ do { \
 /*
  * Macro for getting parallel info.
  */
+#define FD_MEMORY_PARALLEL(i)		info->parallel_info[i].fd_memory
 #define FD_BITMAP_MEMORY_PARALLEL(i)	info->parallel_info[i].fd_bitmap_memory
 #define FD_BITMAP_PARALLEL(i)		info->parallel_info[i].fd_bitmap
+#define BUF_PARALLEL(i)			info->parallel_info[i].buf
+#define BUF_OUT_PARALLEL(i)		info->parallel_info[i].buf_out
+#define MMAP_CACHE_PARALLEL(i)		info->parallel_info[i].mmap_cache
+#ifdef USELZO
+#define WRKMEM_PARALLEL(i)		info->parallel_info[i].wrkmem
+#endif
 /*
  * kernel version
  *
@@ -964,12 +971,41 @@ typedef unsigned long long int ulonglong;
 /*
  * for parallel process
  */
+
+#define WAIT_TIME	(60 * 10)
+#define PTHREAD_FAIL	((void *)-2)
+#define NUM_BUFFERS	(50)
+
 struct mmap_cache {
 	char	*mmap_buf;
 	off_t	mmap_start_offset;
 	off_t   mmap_end_offset;
 };
 
+struct page_data
+{
+	mdf_pfn_t pfn;
+	int dumpable;
+	int zero;
+	unsigned int flags;
+	long size;
+	unsigned char *buf;
+	pthread_mutex_t mutex;
+	/*
+	 * whether the page_data is ready to be consumed
+	 */
+	int ready;
+};
+
+struct thread_args {
+	int thread_num;
+	unsigned long len_buf_out;
+	mdf_pfn_t start_pfn, end_pfn;
+	int page_data_num;
+	struct cycle *cycle;
+	struct page_data *page_data_buf;
+};
+
 /*
  * makedumpfile header
  *   For re-arranging the dump data on different architecture, all the
@@ -1250,7 +1286,17 @@ struct DumpInfo {
 	/*
 	 * for parallel process
 	 */
+	int num_threads;
+	int num_buffers;
+	pthread_t **threads;
+	struct thread_args *kdump_thread_args;
+	struct page_data *page_data_buf;
 	pthread_rwlock_t usemmap_rwlock;
+	mdf_pfn_t current_pfn;
+	pthread_mutex_t current_pfn_mutex;
+	mdf_pfn_t consumed_pfn;
+	pthread_mutex_t consumed_pfn_mutex;
+	pthread_mutex_t filter_mutex;
 };
 extern struct DumpInfo		*info;
 
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
