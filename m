Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bU3tJ-0002TP-SS
 for kexec@lists.infradead.org; Mon, 01 Aug 2016 03:27:48 +0000
From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Subject: [PATCH] makedumpfile: Change num_threads to num_producers
Date: Mon, 1 Aug 2016 11:26:06 +0800
Message-ID: <1470021966-15485-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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
Cc: ats-kumagai@wm.jp.nec.com

Currently, num_threads means the producer number. The main thread
is not included. However, num_threads is specified by the option
"--num-threads". So this may make user confused why it still has
performance degradation when the value by "--num-threads" equals
the usable cpu number.

I think it will be more nature to make "--num-threads" be producer
number + 1. In other words, "--num-threads" should include the
main thread.

In this patch, num_threads has been change to the prodecer_num.
And the num_producers is calculated by "--num-threads" - 1;

In addition, thread_num is changed to producer_num.

Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
---
 makedumpfile.c | 108 ++++++++++++++++++++++++++++-----------------------------
 makedumpfile.h |   4 +--
 2 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 21784e8..19019a4 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1407,13 +1407,13 @@ open_dump_bitmap(void)
 		}
 	}
 
-	if (info->num_threads) {
+	if (info->num_producers) {
 		/*
 		 * Reserve file descriptors of bitmap for creating dumpfiles
 		 * parallelly, because a bitmap file will be unlinked just after
 		 * this and it is not possible to open a bitmap file later.
 		 */
-		for (i = 0; i < info->num_threads; i++) {
+		for (i = 0; i < info->num_producers; i++) {
 			if ((fd = open(info->name_bitmap, O_RDONLY)) < 0) {
 				ERRMSG("Can't open the bitmap file(%s). %s\n",
 				    info->name_bitmap, strerror(errno));
@@ -3495,9 +3495,9 @@ initialize_bitmap_memory(void)
 }
 
 void
-initialize_bitmap_memory_parallel(struct dump_bitmap *bitmap, int thread_num)
+initialize_bitmap_memory_parallel(struct dump_bitmap *bitmap, int producer_num)
 {
-	bitmap->fd = FD_BITMAP_MEMORY_PARALLEL(thread_num);
+	bitmap->fd = FD_BITMAP_MEMORY_PARALLEL(producer_num);
 	bitmap->file_name = info->name_memory;
 	bitmap->no_block = -1;
 	memset(bitmap->buf, 0, BUFSIZE_BITMAP);
@@ -3529,24 +3529,24 @@ initial_for_parallel()
 	/*
 	 * allocate memory for threads
 	 */
-	if ((info->threads = malloc(sizeof(pthread_t *) * info->num_threads))
+	if ((info->threads = malloc(sizeof(pthread_t *) * info->num_producers))
 	    == NULL) {
 		MSG("Can't allocate memory for threads. %s\n",
 				strerror(errno));
 		return FALSE;
 	}
-	memset(info->threads, 0, sizeof(pthread_t *) * info->num_threads);
+	memset(info->threads, 0, sizeof(pthread_t *) * info->num_producers);
 
 	if ((info->kdump_thread_args =
-			malloc(sizeof(struct thread_args) * info->num_threads))
+			malloc(sizeof(struct thread_args) * info->num_producers))
 	    == NULL) {
 		MSG("Can't allocate memory for arguments of threads. %s\n",
 				strerror(errno));
 		return FALSE;
 	}
-	memset(info->kdump_thread_args, 0, sizeof(struct thread_args) * info->num_threads);
+	memset(info->kdump_thread_args, 0, sizeof(struct thread_args) * info->num_producers);
 
-	for (i = 0; i < info->num_threads; i++) {
+	for (i = 0; i < info->num_producers; i++) {
 		if ((info->threads[i] = malloc(sizeof(pthread_t))) == NULL) {
 			MSG("Can't allocate memory for thread %d. %s",
 					i, strerror(errno));
@@ -3592,7 +3592,7 @@ initial_for_parallel()
 #endif
 	}
 
-	info->num_buffers = PAGE_DATA_NUM * info->num_threads;
+	info->num_buffers = PAGE_DATA_NUM * info->num_producers;
 
 	/*
 	 * allocate memory for page_data
@@ -3615,17 +3615,17 @@ initial_for_parallel()
 	}
 
 	/*
-	 * initial page_flag for each thread
+	 * initial page_flag for each producer thread
 	 */
-	if ((info->page_flag_buf = malloc(sizeof(void *) * info->num_threads))
+	if ((info->page_flag_buf = malloc(sizeof(void *) * info->num_producers))
 	    == NULL) {
 		MSG("Can't allocate memory for page_flag_buf. %s\n",
 				strerror(errno));
 		return FALSE;
 	}
-	memset(info->page_flag_buf, 0, sizeof(void *) * info->num_threads);
+	memset(info->page_flag_buf, 0, sizeof(void *) * info->num_producers);
 
-	for (i = 0; i < info->num_threads; i++) {
+	for (i = 0; i < info->num_producers; i++) {
 		if ((info->page_flag_buf[i] = calloc(1, sizeof(struct page_flag))) == NULL) {
 			MSG("Can't allocate memory for page_flag. %s\n",
 				strerror(errno));
@@ -3645,9 +3645,9 @@ initial_for_parallel()
 	}
 
 	/*
-	 * initial fd_memory for threads
+	 * initial fd_memory for producer threads
 	 */
-	for (i = 0; i < info->num_threads; i++) {
+	for (i = 0; i < info->num_producers; i++) {
 		if ((FD_MEMORY_PARALLEL(i) = open(info->name_memory, O_RDONLY))
 									< 0) {
 			ERRMSG("Can't open the dump memory(%s). %s\n",
@@ -3673,7 +3673,7 @@ free_for_parallel()
 	struct page_flag *current;
 
 	if (info->threads != NULL) {
-		for (i = 0; i < info->num_threads; i++) {
+		for (i = 0; i < info->num_producers; i++) {
 			if (info->threads[i] != NULL)
 				free(info->threads[i]);
 
@@ -3714,7 +3714,7 @@ free_for_parallel()
 	}
 
 	if (info->page_flag_buf != NULL) {
-		for (i = 0; i < info->num_threads; i++) {
+		for (i = 0; i < info->num_producers; i++) {
 			for (j = 0; j < PAGE_FLAG_NUM; j++) {
 				if (info->page_flag_buf[i] != NULL) {
 					current = info->page_flag_buf[i];
@@ -3729,7 +3729,7 @@ free_for_parallel()
 	if (info->parallel_info == NULL)
 		return;
 
-	for (i = 0; i < info->num_threads; i++) {
+	for (i = 0; i < info->num_producers; i++) {
 		if (FD_MEMORY_PARALLEL(i) > 0)
 			close(FD_MEMORY_PARALLEL(i));
 
@@ -3936,7 +3936,7 @@ out:
 		DEBUG_MSG("Buffer size for the cyclic mode: %ld\n", info->bufsize_cyclic);
 	}
 
-	if (info->num_threads) {
+	if (info->num_producers) {
 		if (is_xen_memory()) {
 			MSG("'--num-threads' option is disable,\n");
 			MSG("because %s is Xen's memory core image.\n",
@@ -4066,9 +4066,9 @@ initialize_2nd_bitmap(struct dump_bitmap *bitmap)
 }
 
 void
-initialize_2nd_bitmap_parallel(struct dump_bitmap *bitmap, int thread_num)
+initialize_2nd_bitmap_parallel(struct dump_bitmap *bitmap, int producer_num)
 {
-	bitmap->fd = FD_BITMAP_PARALLEL(thread_num);
+	bitmap->fd = FD_BITMAP_PARALLEL(producer_num);
 	bitmap->file_name = info->name_bitmap;
 	bitmap->no_block = -1;
 	memset(bitmap->buf, 0, BUFSIZE_BITMAP);
@@ -7558,7 +7558,7 @@ kdump_thread_function_cyclic(void *arg) {
 	volatile struct page_flag *page_flag_buf = kdump_thread_args->page_flag_buf;
 	struct cycle *cycle = kdump_thread_args->cycle;
 	mdf_pfn_t pfn = cycle->start_pfn;
-	int index = kdump_thread_args->thread_num;
+	int index = kdump_thread_args->producer_num;
 	int buf_ready;
 	int dumpable;
 	int fd_memory = 0;
@@ -7566,21 +7566,21 @@ kdump_thread_function_cyclic(void *arg) {
 	struct dump_bitmap bitmap_memory_parallel = {0};
 	unsigned char *buf = NULL, *buf_out = NULL;
 	struct mmap_cache *mmap_cache =
-			MMAP_CACHE_PARALLEL(kdump_thread_args->thread_num);
+			MMAP_CACHE_PARALLEL(kdump_thread_args->producer_num);
 	unsigned long size_out;
-	z_stream *stream = &ZLIB_STREAM_PARALLEL(kdump_thread_args->thread_num);
+	z_stream *stream = &ZLIB_STREAM_PARALLEL(kdump_thread_args->producer_num);
 #ifdef USELZO
-	lzo_bytep wrkmem = WRKMEM_PARALLEL(kdump_thread_args->thread_num);
+	lzo_bytep wrkmem = WRKMEM_PARALLEL(kdump_thread_args->producer_num);
 #endif
 #ifdef USESNAPPY
 	unsigned long len_buf_out_snappy =
 				snappy_max_compressed_length(info->page_size);
 #endif
 
-	buf = BUF_PARALLEL(kdump_thread_args->thread_num);
-	buf_out = BUF_OUT_PARALLEL(kdump_thread_args->thread_num);
+	buf = BUF_PARALLEL(kdump_thread_args->producer_num);
+	buf_out = BUF_OUT_PARALLEL(kdump_thread_args->producer_num);
 
-	fd_memory = FD_MEMORY_PARALLEL(kdump_thread_args->thread_num);
+	fd_memory = FD_MEMORY_PARALLEL(kdump_thread_args->producer_num);
 
 	if (info->fd_bitmap) {
 		bitmap_parallel.buf = malloc(BUFSIZE_BITMAP);
@@ -7590,7 +7590,7 @@ kdump_thread_function_cyclic(void *arg) {
 			goto fail;
 		}
 		initialize_2nd_bitmap_parallel(&bitmap_parallel,
-					kdump_thread_args->thread_num);
+					kdump_thread_args->producer_num);
 	}
 
 	if (info->flag_refiltering) {
@@ -7601,7 +7601,7 @@ kdump_thread_function_cyclic(void *arg) {
 			goto fail;
 		}
 		initialize_bitmap_memory_parallel(&bitmap_memory_parallel,
-						kdump_thread_args->thread_num);
+						kdump_thread_args->producer_num);
 	}
 
 	/*
@@ -7802,8 +7802,8 @@ write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
 	for (i = 0; i < page_buf_num; i++)
 		page_data_buf[i].used = FALSE;
 
-	for (i = 0; i < info->num_threads; i++) {
-		kdump_thread_args[i].thread_num = i;
+	for (i = 0; i < info->num_producers; i++) {
+		kdump_thread_args[i].producer_num = i;
 		kdump_thread_args[i].len_buf_out = len_buf_out;
 		kdump_thread_args[i].page_data_buf = page_data_buf;
 		kdump_thread_args[i].page_flag_buf = info->page_flag_buf[i];
@@ -7843,13 +7843,13 @@ write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
 			 * consuming is used for recording in which thread the pfn is the smallest.
 			 * current_pfn is used for recording the value of pfn when checking the pfn.
 			 */
-			for (i = 0; i < info->num_threads; i++) {
+			for (i = 0; i < info->num_producers; i++) {
 				if (info->page_flag_buf[i]->ready == FLAG_UNUSED)
 					continue;
 				temp_pfn = info->page_flag_buf[i]->pfn;
 
 				/*
-				 * count how many threads have reached the end.
+				 * count how many producer threads have reached the end.
 				 */
 				if (temp_pfn >= end_pfn) {
 					info->page_flag_buf[i]->ready = FLAG_UNUSED;
@@ -7865,9 +7865,9 @@ write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
 			}
 
 			/*
-			 * If all the threads have reached the end, we will finish writing.
+			 * If all producer threads have reached the end, we will finish writing.
 			 */
-			if (end_count >= info->num_threads)
+			if (end_count >= info->num_producers)
 				goto finish;
 
 			/*
@@ -7930,7 +7930,7 @@ finish:
 
 out:
 	if (threads != NULL) {
-		for (i = 0; i < info->num_threads; i++) {
+		for (i = 0; i < info->num_producers; i++) {
 			if (threads[i] != NULL) {
 				res = pthread_cancel(*threads[i]);
 				if (res != 0 && res != ESRCH)
@@ -7939,7 +7939,7 @@ out:
 			}
 		}
 
-		for (i = 0; i < info->num_threads; i++) {
+		for (i = 0; i < info->num_producers; i++) {
 			if (threads[i] != NULL) {
 				res = pthread_join(*threads[i], &thread_result);
 				if (res != 0)
@@ -8553,7 +8553,7 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
 		if (!write_kdump_bitmap2(&cycle))
 			return FALSE;
 
-		if (info->num_threads) {
+		if (info->num_producers) {
 			if (!write_kdump_pages_parallel_cyclic(cd_header,
 							cd_page, &pd_zero,
 							&offset_data, &cycle))
@@ -10531,7 +10531,7 @@ check_param_for_creating_dumpfile(int argc, char *argv[])
 	if (info->flag_sadump_diskset && !sadump_is_supported_arch())
 		return FALSE;
 
-	if (info->num_threads) {
+	if (info->num_producers) {
 		if (info->flag_split) {
 			MSG("--num-threads cannot used with --split.\n");
 			return FALSE;
@@ -10607,16 +10607,16 @@ check_param_for_creating_dumpfile(int argc, char *argv[])
 	} else
 		return FALSE;
 
-	if (info->num_threads) {
+	if (info->num_producers) {
 		if ((info->parallel_info =
-		     malloc(sizeof(parallel_info_t) * info->num_threads))
+		     malloc(sizeof(parallel_info_t) * info->num_producers))
 		    == NULL) {
 			MSG("Can't allocate memory for parallel_info.\n");
 			return FALSE;
 		}
 
 		memset(info->parallel_info, 0, sizeof(parallel_info_t)
-							* info->num_threads);
+							* info->num_producers);
 	}
 
 	return TRUE;
@@ -10721,20 +10721,20 @@ calculate_cyclic_buffer_size(void) {
 	limit_size = get_free_memory_size() * 0.6;
 
 	/*
-	 * Recalculate the limit_size according to num_threads.
-	 * And reset num_threads if there is not enough memory.
+	 * Recalculate the limit_size according to num_producers.
+	 * And reset --num-threads if there is not enough memory.
 	 */
-	if (info->num_threads > 0) {
+	if (info->num_producers > 0) {
 		if (limit_size <= maximum_size) {
 			MSG("There isn't enough memory for multi-threads.\n");
-			info->num_threads = 0;
+			info->num_producers = 0;
 		}
-		else if ((limit_size - maximum_size) / info->num_threads < THREAD_REGION) {
-			MSG("There isn't enough memory for %d threads.\n", info->num_threads);
-			info->num_threads = (limit_size - maximum_size) / THREAD_REGION;
-			MSG("--num_threads is set to %d.\n", info->num_threads);
+		else if ((limit_size - maximum_size) / info->num_producers < THREAD_REGION) {
+			MSG("There isn't enough memory for %d threads.\n", info->num_producers + 1);
+			info->num_producers = (limit_size - maximum_size) / THREAD_REGION;
+			MSG("--num-threads is set to %d.\n", info->num_producers + 1);
 
-			limit_size = limit_size - THREAD_REGION * info->num_threads;
+			limit_size = limit_size - THREAD_REGION * info->num_producers;
 		}
 	}
 
@@ -11103,7 +11103,7 @@ main(int argc, char *argv[])
 			info->working_dir = optarg;
 			break;
 		case OPT_NUM_THREADS:
-			info->num_threads = MAX(atoi(optarg), 0);
+			info->num_producers = MAX(atoi(optarg), 1) - 1;
 			break;
 		case '?':
 			MSG("Commandline parameter is invalid.\n");
diff --git a/makedumpfile.h b/makedumpfile.h
index 533e5b8..6a0f51e 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1004,7 +1004,7 @@ struct page_data
 };
 
 struct thread_args {
-	int thread_num;
+	int producer_num;
 	unsigned long len_buf_out;
 	struct cycle *cycle;
 	struct page_data *page_data_buf;
@@ -1294,7 +1294,7 @@ struct DumpInfo {
 	/*
 	 * for parallel process
 	 */
-	int num_threads;
+	int num_producers;
 	int num_buffers;
 	pthread_t **threads;
 	struct thread_args *kdump_thread_args;
-- 
1.8.3.1




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
