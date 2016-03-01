Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aaeJZ-0007be-9K
 for kexec@lists.infradead.org; Tue, 01 Mar 2016 07:01:53 +0000
Message-ID: <56D53DEA.1080307@cn.fujitsu.com>
Date: Tue, 1 Mar 2016 14:59:54 +0800
From: =?UTF-8?B?Ilpob3UsIFdlbmppYW4v5ZGo5paH5YmRIg==?=
 <zhouwj-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2] Improve the performance of --num-threads -d 31
References: <1455692739-14878-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <20160222165817.GA20170@dhcp-128-25.nay.redhat.com>
 <20160223052616.GA19420@dhcp-128-25.nay.redhat.com>
 <56CBF266.8070107@cn.fujitsu.com>
 <20160224014323.GA23058@dhcp-128-25.nay.redhat.com>
 <56CD1369.3050905@cn.fujitsu.com>
 <A315254E-BB2A-46C0-B3C7-0BDAAF89883C@redhat.com>
In-Reply-To: <A315254E-BB2A-46C0-B3C7-0BDAAF89883C@redhat.com>
Content-Type: multipart/mixed; boundary="------------020809020703000206040804"
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Minfei Huang <mhuang@redhat.com>
Cc: kexec@lists.infradead.org

--------------020809020703000206040804
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Hi Minfei,

Could you help me test the patch in the attachment?

I have run it a thousand times and haven't got a failure.
Previously, I can always get a failure after running hundreds of times.

But I'm not sure if it is the same problem you have met.

-- 
Thanks
Zhou

On 02/24/2016 10:24 AM, Minfei Huang wrote:
>
>> On Feb 24, 2016, at 10:20, Zhou, Wenjian/周文剑 <zhouwj-fnst@cn.fujitsu.com> wrote:
>>
>> Hi,
>>
>> On 02/24/2016 09:43 AM, Minfei Huang wrote:
>>> On 02/23/16 at 01:47pm, "Zhou, Wenjian/周文剑" wrote:
>>>> Hello, Minfei,
>>>>
>>>> Does it occur every time?
>>>> If not, I think I have known the reason.
>>>
>>> Hi, Wenjian.
>>>
>>> This patch is applied directly on version 1.5.9. And makedumpfile hangs
>>> if option num-thread is appended.
>>>
>>
>> I see.
>> I'm working on it.
>>
>> BTW, did you only test it with --num-threads 128?
>> How is it with --num-threads 32(or smaller value)?
>
> Yes. I have tested with num-thread 1, 2, 8 and 32. Except for —num-threads 1,
> all of the test fail.
>
> Thanks
> Minfei
>>
>
>
>



--------------020809020703000206040804
Content-Type: text/x-patch; name="0001-improve-the-performance.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-improve-the-performance.patch"

From 42239fea17e5b4b19d9a9210bb335e5984b32aea Mon Sep 17 00:00:00 2001
From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Date: Tue, 1 Mar 2016 13:35:00 +0800
Subject: [PATCH] improve the performance

---
 makedumpfile.c | 271 ++++++++++++++++++++++++++++++++++++++-------------------
 makedumpfile.h |  36 +++++---
 2 files changed, 207 insertions(+), 100 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index fa0b779..c437f77 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3483,7 +3483,8 @@ initial_for_parallel()
 	unsigned long page_data_buf_size;
 	unsigned long limit_size;
 	int page_data_num;
-	int i;
+	struct page_flag *current;
+	int i, j;
 
 	len_buf_out = calculate_len_buf_out(info->page_size);
 
@@ -3562,8 +3563,10 @@ initial_for_parallel()
 		      - MAP_REGION * info->num_threads) * 0.6;
 
 	page_data_num = limit_size / page_data_buf_size;
+	info->num_buffers = 3 * info->num_threads;
 
-	info->num_buffers = MIN(NUM_BUFFERS, page_data_num);
+	info->num_buffers = MAX(info->num_buffers, NUM_BUFFERS);
+	info->num_buffers = MIN(info->num_buffers, page_data_num);
 
 	DEBUG_MSG("Number of struct page_data for produce/consume: %d\n",
 			info->num_buffers);
@@ -3588,6 +3591,36 @@ initial_for_parallel()
 	}
 
 	/*
+	 * initial page_flag for each thread
+	 */
+	if ((info->page_flag_buf = malloc(sizeof(void *) * info->num_threads))
+	    == NULL) {
+		MSG("Can't allocate memory for page_flag_buf. %s\n",
+				strerror(errno));
+		return FALSE;
+	}
+	memset(info->page_flag_buf, 0, sizeof(void *) * info->num_threads);
+
+	for (i = 0; i < info->num_threads; i++) {
+		if ((info->page_flag_buf[i] = calloc(1, sizeof(struct page_flag))) == NULL) {
+			MSG("Can't allocate memory for page_flag. %s\n",
+				strerror(errno));
+			return FALSE;
+		}
+		current = info->page_flag_buf[i];
+
+		for (j = 1; j < NUM_BUFFERS; j++) {
+			if ((current->next = calloc(1, sizeof(struct page_flag))) == NULL) {
+				MSG("Can't allocate memory for page_flag. %s\n",
+					strerror(errno));
+				return FALSE;
+			}
+			current = current->next;
+		}
+		current->next = info->page_flag_buf[i];
+	}
+
+	/*
 	 * initial fd_memory for threads
 	 */
 	for (i = 0; i < info->num_threads; i++) {
@@ -3612,7 +3645,8 @@ initial_for_parallel()
 void
 free_for_parallel()
 {
-	int i;
+	int i, j;
+	struct page_flag *current;
 
 	if (info->threads != NULL) {
 		for (i = 0; i < info->num_threads; i++) {
@@ -3655,6 +3689,19 @@ free_for_parallel()
 		free(info->page_data_buf);
 	}
 
+	if (info->page_flag_buf != NULL) {
+		for (i = 0; i < info->num_threads; i++) {
+			for (j = 0; j < NUM_BUFFERS; j++) {
+				if (info->page_flag_buf[i] != NULL) {
+					current = info->page_flag_buf[i];
+					info->page_flag_buf[i] = current->next;
+					free(current);
+				}
+			}
+		}
+		free(info->page_flag_buf);
+	}
+
 	if (info->parallel_info == NULL)
 		return;
 
@@ -7075,11 +7122,11 @@ void *
 kdump_thread_function_cyclic(void *arg) {
 	void *retval = PTHREAD_FAIL;
 	struct thread_args *kdump_thread_args = (struct thread_args *)arg;
-	struct page_data *page_data_buf = kdump_thread_args->page_data_buf;
+	struct page_data *page_data_buf = kdump_thread_args->page_data_buf;
+	struct page_flag *page_flag_buf = kdump_thread_args->page_flag_buf;
 	struct cycle *cycle = kdump_thread_args->cycle;
-	int page_data_num = kdump_thread_args->page_data_num;
-	mdf_pfn_t pfn;
-	int index;
+	mdf_pfn_t pfn = cycle->start_pfn;
+	int index = kdump_thread_args->thread_num;
 	int buf_ready;
 	int dumpable;
 	int fd_memory = 0;
@@ -7125,47 +7172,46 @@ kdump_thread_function_cyclic(void *arg) {
 						kdump_thread_args->thread_num);
 	}
 
-	while (1) {
-		/* get next pfn */
-		pthread_mutex_lock(&info->current_pfn_mutex);
-		pfn = info->current_pfn;
-		info->current_pfn++;
-		pthread_mutex_unlock(&info->current_pfn_mutex);
-
-		if (pfn >= kdump_thread_args->end_pfn)
-			break;
-
-		index = -1;
+	/*
+	 * filtered page won't take anything
+	 * unfiltered zero page will only take a page_flag_buf
+	 * unfiltered non-zero page will take a page_flag_buf and a page_data_buf
+	 */
+	while (pfn < kdump_thread_args->end_pfn) {
 		buf_ready = FALSE;
 
+		pthread_mutex_lock(&info->page_data_mutex);
+		while (page_data_buf[index].used != FALSE) {
+			index = (index + 1) % info->num_buffers;
+		}
+		page_data_buf[index].used = TRUE;
+		pthread_mutex_unlock(&info->page_data_mutex);
+
 		while (buf_ready == FALSE) {
 			pthread_testcancel();
-
-			index = pfn % page_data_num;
-
-			if (pfn - info->consumed_pfn > info->num_buffers)
-				continue;
-
-			if (page_data_buf[index].ready != 0)
+			if (page_flag_buf->ready == FLAG_READY)
 				continue;
 
-			pthread_mutex_lock(&page_data_buf[index].mutex);
+			/* get next pfn */
+			pthread_mutex_lock(&info->current_pfn_mutex);
+			pfn = info->current_pfn;
+			info->current_pfn++;
+			page_flag_buf->ready = FLAG_FILLING;
+			pthread_mutex_unlock(&info->current_pfn_mutex);
 
-			if (page_data_buf[index].ready != 0)
-				goto unlock;
+			page_flag_buf->pfn = pfn;
 
-			buf_ready = TRUE;
-
-			page_data_buf[index].pfn = pfn;
-			page_data_buf[index].ready = 1;
+			if (pfn >= kdump_thread_args->end_pfn) {
+				page_data_buf[index].used = FALSE;
+				break;
+			}
 
 			dumpable = is_dumpable(
 				info->fd_bitmap ? &bitmap_parallel : info->bitmap2,
 				pfn,
 				cycle);
-			page_data_buf[index].dumpable = dumpable;
 			if (!dumpable)
-				goto unlock;
+				continue;
 
 			if (!read_pfn_parallel(fd_memory, pfn, buf,
 					       &bitmap_memory_parallel,
@@ -7178,11 +7224,11 @@ kdump_thread_function_cyclic(void *arg) {
 
 			if ((info->dump_level & DL_EXCLUDE_ZERO)
 			    && is_zero_page(buf, info->page_size)) {
-				page_data_buf[index].zero = TRUE;
-				goto unlock;
+				page_flag_buf->zero = TRUE;
+				goto next;
 			}
 
-			page_data_buf[index].zero = FALSE;
+			page_flag_buf->zero = FALSE;
 
 			/*
 			 * Compress the page data.
@@ -7210,6 +7256,8 @@ kdump_thread_function_cyclic(void *arg) {
 				page_data_buf[index].flags =
 							DUMP_DH_COMPRESSED_LZO;
 				page_data_buf[index].size  = size_out;
+			page_data_buf[index].pre=page_data_buf[index].pfn;
+			page_data_buf[index].pfn=pfn;
 				memcpy(page_data_buf[index].buf, buf_out, size_out);
 #endif
 #ifdef USESNAPPY
@@ -7230,14 +7278,20 @@ kdump_thread_function_cyclic(void *arg) {
 			} else {
 				page_data_buf[index].flags = 0;
 				page_data_buf[index].size  = info->page_size;
+			page_data_buf[index].pre=page_data_buf[index].pfn;
+			page_data_buf[index].pfn=pfn;
 				memcpy(page_data_buf[index].buf, buf, info->page_size);
 			}
-unlock:
-			pthread_mutex_unlock(&page_data_buf[index].mutex);
+			page_flag_buf->index = index;
+			buf_ready = TRUE;
+next:
+			page_flag_buf->ready = FLAG_READY;
+			page_flag_buf = page_flag_buf->next;
 
 		}
-	}
 
+		pthread_mutex_unlock(&page_data_buf[index].mutex);
+	}
 	retval = NULL;
 
 fail:
@@ -7265,14 +7319,15 @@ write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
 	struct page_desc pd;
 	struct timeval tv_start;
 	struct timeval last, new;
-	unsigned long long consuming_pfn;
 	pthread_t **threads = NULL;
 	struct thread_args *kdump_thread_args = NULL;
 	void *thread_result;
-	int page_data_num;
+	int page_buf_num;
 	struct page_data *page_data_buf = NULL;
 	int i;
 	int index;
+	int end_count, consuming, check_count;
+	mdf_pfn_t current_pfn, temp_pfn;
 
 	if (info->flag_elf_dumpfile)
 		return FALSE;
@@ -7319,16 +7374,12 @@ write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
 	threads = info->threads;
 	kdump_thread_args = info->kdump_thread_args;
 
-	page_data_num = info->num_buffers;
+	page_buf_num = info->num_buffers;
 	page_data_buf = info->page_data_buf;
+	pthread_mutex_init(&info->page_data_mutex, NULL);
 
-	for (i = 0; i < page_data_num; i++) {
-		/*
-		 * producer will use pfn in page_data_buf to decide the
-		 * consumed pfn
-		 */
-		page_data_buf[i].pfn = start_pfn - 1;
-		page_data_buf[i].ready = 0;
+	for (i = 0; i < page_buf_num; i++) {
+		page_data_buf[i].used = FALSE;
 		res = pthread_mutex_init(&page_data_buf[i].mutex, NULL);
 		if (res != 0) {
 			ERRMSG("Can't initialize mutex of page_data_buf. %s\n",
@@ -7342,8 +7393,9 @@ write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
 		kdump_thread_args[i].len_buf_out = len_buf_out;
 		kdump_thread_args[i].start_pfn = start_pfn;
 		kdump_thread_args[i].end_pfn = end_pfn;
-		kdump_thread_args[i].page_data_num = page_data_num;
+		kdump_thread_args[i].page_buf_num = page_buf_num;
 		kdump_thread_args[i].page_data_buf = page_data_buf;
+		kdump_thread_args[i].page_flag_buf = info->page_flag_buf[i];
 		kdump_thread_args[i].cycle = cycle;
 
 		res = pthread_create(threads[i], NULL,
@@ -7356,60 +7408,102 @@ write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
 		}
 	}
 
-	consuming_pfn = start_pfn;
-	index = -1;
+	end_count = 0;
+	while (1) {
+		consuming = 0;
+		check_count = 0;
 
-	gettimeofday(&last, NULL);
+		/*
+		 * The basic idea is producer producing page and consumer writing page.
+		 * Each producer have a page_flag_buf list which is used for storing page's description.
+		 * The size of page_flag_buf is little so it won't take too much memory.
+		 * And all producers will share a page_data_buf array which is used for storing page's compressed data.
+		 * The main thread is the consumer. It will find the next pfn and write it into file.
+		 * The next pfn is smallest pfn in all page_flag_buf.
+		 */
+		gettimeofday(&last, NULL);
+		while (1) {
+			current_pfn = end_pfn;
 
-	while (consuming_pfn < end_pfn) {
-		index = consuming_pfn % page_data_num;
+			/*
+			 * page_flag_buf is in circular linked list.
+			 * The array info->page_flag_buf[] records the current page_flag_buf in each thread's
+			 * page_flag_buf list.
+			 * consuming is used for recording in which thread the pfn is the smallest.
+			 * current_pfn is used for recording the value of pfn when checking the pfn.
+			 */
+			for (i = 0; i < info->num_threads; i++) {
+				if (info->page_flag_buf[i]->ready == FLAG_UNUSED)
+					continue;
+				temp_pfn = info->page_flag_buf[i]->pfn;
 
-		gettimeofday(&new, NULL);
-		if (new.tv_sec - last.tv_sec > WAIT_TIME) {
-			ERRMSG("Can't get data of pfn %llx.\n", consuming_pfn);
-			goto out;
-		}
+				/*
+				 * count how many threads have reached the end.
+				 */
+				if (temp_pfn >= end_pfn) {
+					info->page_flag_buf[i]->ready = FLAG_UNUSED;
 
-		/*
-		 * check pfn first without mutex locked to reduce the time
-		 * trying to lock the mutex
-		 */
-		if (page_data_buf[index].pfn != consuming_pfn)
-			continue;
+					info->current_pfn = end_pfn;
+					end_count++;
+					continue;
+				}
 
-		if (pthread_mutex_trylock(&page_data_buf[index].mutex) != 0)
-			continue;
+				if (current_pfn < temp_pfn)
+					continue;
 
-		/* check whether the found one is ready to be consumed */
-		if (page_data_buf[index].pfn != consuming_pfn ||
-		    page_data_buf[index].ready != 1) {
-			goto unlock;
+				check_count++;
+				consuming = i;
+				current_pfn = temp_pfn;
+			}
+
+			/*
+			 * If all the threads have reached the end, we will finish writing.
+			 */
+			if (end_count >= info->num_threads)
+				goto finish;
+
+			/*
+			 * Since it has the probabilty that there is no page_flag_buf being ready,
+			 * we should recheck if it happens.
+			 */
+			if (check_count == 0)
+				continue;
+
+			/*
+			 * If the page_flag_buf is not ready, the pfn recorded may be changed.
+			 * So we should recheck.
+			 */
+			if (info->page_flag_buf[consuming]->ready != FLAG_READY) {
+				gettimeofday(&new, NULL);
+				if (new.tv_sec - last.tv_sec > WAIT_TIME) {
+					ERRMSG("Can't get data of pfn.\n");
+					goto out;
+				}
+				continue;
+			}
+
+			if (current_pfn == info->page_flag_buf[consuming]->pfn)
+				break;
 		}
 
 		if ((num_dumped % per) == 0)
 			print_progress(PROGRESS_COPY, num_dumped, info->num_dumpable);
 
-		/* next pfn is found, refresh last here */
-		last = new;
-		consuming_pfn++;
-		info->consumed_pfn++;
-		page_data_buf[index].ready = 0;
-
-		if (page_data_buf[index].dumpable == FALSE)
-			goto unlock;
-
 		num_dumped++;
 
-		if (page_data_buf[index].zero == TRUE) {
+
+		if (info->page_flag_buf[consuming]->zero == TRUE) {
 			if (!write_cache(cd_header, pd_zero, sizeof(page_desc_t)))
 				goto out;
 			pfn_zero++;
 		} else {
+			index = info->page_flag_buf[consuming]->index;
 			pd.flags      = page_data_buf[index].flags;
 			pd.size       = page_data_buf[index].size;
 			pd.page_flags = 0;
 			pd.offset     = *offset_data;
 			*offset_data  += pd.size;
+//MSG("expectpfn:%d pfn:%d, pd.size:%d, pre:%d\n", info->page_flag_buf[consuming]->pfn, page_data_buf[index].pfn, pd.size, page_data_buf[index].pre);
 			/*
 			 * Write the page header.
 			 */
@@ -7420,12 +7514,12 @@ write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
 			 */
 			if (!write_cache(cd_page, page_data_buf[index].buf, pd.size))
 				goto out;
-
+			page_data_buf[index].used = FALSE;
 		}
-unlock:
-		pthread_mutex_unlock(&page_data_buf[index].mutex);
+		info->page_flag_buf[consuming]->ready = FLAG_UNUSED;
+		info->page_flag_buf[consuming] = info->page_flag_buf[consuming]->next;
 	}
-
+finish:
 	ret = TRUE;
 	/*
 	 * print [100 %]
@@ -7464,7 +7558,7 @@ out:
 	}
 
 	if (page_data_buf != NULL) {
-		for (i = 0; i < page_data_num; i++) {
+		for (i = 0; i < page_buf_num; i++) {
 			pthread_mutex_destroy(&page_data_buf[i].mutex);
 		}
 	}
@@ -7564,6 +7658,7 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
 		num_dumped++;
 		if (!read_pfn(pfn, buf))
 			goto out;
+
 		filter_data_buffer(buf, pfn_to_paddr(pfn), info->page_size);
 
 		/*
diff --git a/makedumpfile.h b/makedumpfile.h
index e0b5bbf..2de6afe 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -977,7 +977,7 @@ typedef unsigned long long int ulonglong;
 #define PAGE_DATA_NUM	(50)
 #define WAIT_TIME	(60 * 10)
 #define PTHREAD_FAIL	((void *)-2)
-#define NUM_BUFFERS	(50)
+#define NUM_BUFFERS	(20)
 
 struct mmap_cache {
 	char	*mmap_buf;
@@ -985,28 +985,38 @@ struct mmap_cache {
 	off_t   mmap_end_offset;
 };
 
+enum {
+	FLAG_UNUSED,
+	FLAG_READY,
+	FLAG_FILLING
+};
+struct page_flag {
+	mdf_pfn_t pfn;
+	char zero;
+	char ready;
+	short index;
+	struct page_flag *next;
+};
+
 struct page_data
 {
-	mdf_pfn_t pfn;
-	int dumpable;
-	int zero;
-	unsigned int flags;
+	pthread_mutex_t mutex;
 	long size;
 	unsigned char *buf;
-	pthread_mutex_t mutex;
-	/*
-	 * whether the page_data is ready to be consumed
-	 */
-	int ready;
+	int flags;
+	int used;
+mdf_pfn_t pfn;
+mdf_pfn_t pre;
 };
 
 struct thread_args {
 	int thread_num;
 	unsigned long len_buf_out;
 	mdf_pfn_t start_pfn, end_pfn;
-	int page_data_num;
+	int page_buf_num;
 	struct cycle *cycle;
 	struct page_data *page_data_buf;
+	struct page_flag *page_flag_buf;
 };
 
 /*
@@ -1294,10 +1304,12 @@ struct DumpInfo {
 	int num_buffers;
 	pthread_t **threads;
 	struct thread_args *kdump_thread_args;
-	struct page_data *page_data_buf;
+	struct page_data *page_data_buf;
+	struct page_flag **page_flag_buf;
 	pthread_rwlock_t usemmap_rwlock;
 	mdf_pfn_t current_pfn;
 	pthread_mutex_t current_pfn_mutex;
+	pthread_mutex_t page_data_mutex;
 	mdf_pfn_t consumed_pfn;
 	pthread_mutex_t consumed_pfn_mutex;
 	pthread_mutex_t filter_mutex;
-- 
1.8.3.1


--------------020809020703000206040804
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--------------020809020703000206040804--

