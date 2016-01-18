Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aL25j-0000oB-Ny
 for kexec@lists.infradead.org; Mon, 18 Jan 2016 05:11:02 +0000
Message-ID: <569C7373.60504@cn.fujitsu.com>
Date: Mon, 18 Jan 2016 13:09:07 +0800
From: =?UTF-8?B?Ilpob3UsIFdlbmppYW4v5ZGo5paH5YmRIg==?=
 <zhouwj-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH RFC] Improve the performance of --num-threads -d 31
References: <1453082405-28847-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
In-Reply-To: <1453082405-28847-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Chao Fan <cfan@redhat.com>, Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>, Dave Young <dyoung@redhat.com>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>

Hello,

Several weeks ago, we talked about the performance degradation of --num-threads 1.
I found in the origin implementation, handling filtered page and zero page spends more
time than without num-threads.
I think that's why --num-threads 1 is so different from --num-threads 0.

I rewrite the logic in this patch. And the new implementation can resolve the degradation
of -d 31. It can reduce the time of handling filtered page.
But it seems not effective for handling zero page.

-- 
Thanks
Zhou

On 01/18/2016 10:00 AM, Zhou Wenjian wrote:
> The origin implementation of --num-threads wastes a lot of time
> dealing with the filtered pages. So it has a great performance degradation
> when -d 31 is specified.
> The new implementation is just like the following:
> 	* The basic idea is producer producing page and consumer writing page.
> 	* Each producer have a page_flag_buf list which is used for storing page's description.
> 	* The size of page_flag_buf is little so it won't take too much memory.
> 	* And all producers will share a page_data_buf array which is used for storing page's compressed data.
> 	* The main thread is the consumer. It will find the next pfn and write it into file.
> 	* The next pfn is smallest pfn in all page_flag_buf.
> It won't waste time and memory for filtered page. So it has a good behaviour in -d 31.
>
> Some tests results:
>
>        -l                                   -c
> -d 31: 2.6                                 11.3 (without num-threads)
>         num-threads    origin    new        origin    new
>         1              13.2      2.9        22.4      13.2
>         2              11.6      2.46       15.3      7.3
>         4              10.4      3.2        12.3      5.7
> -d 0:  32.7                                151.2(without num-threads)
>         1              43.3      45.3       158.9     159.4
>         2              21.2      23.0       81.8      83.2
>         4              18.2      21.4       46.1      47.5
>
> These tests are executed in the second kernel with /proc/vmcore.
> ---
>   makedumpfile.c | 266 +++++++++++++++++++++++++++++++++++++++------------------
>   makedumpfile.h |  26 +++---
>   2 files changed, 196 insertions(+), 96 deletions(-)
>
> diff --git a/makedumpfile.c b/makedumpfile.c
> index fa0b779..8cf274b 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -3483,7 +3483,8 @@ initial_for_parallel()
>   	unsigned long page_data_buf_size;
>   	unsigned long limit_size;
>   	int page_data_num;
> -	int i;
> +	struct page_flag *current;
> +	int i, j;
>
>   	len_buf_out = calculate_len_buf_out(info->page_size);
>
> @@ -3562,8 +3563,10 @@ initial_for_parallel()
>   		      - MAP_REGION * info->num_threads) * 0.6;
>
>   	page_data_num = limit_size / page_data_buf_size;
> +	info->num_buffers = 3 * info->num_threads;
>
> -	info->num_buffers = MIN(NUM_BUFFERS, page_data_num);
> +	info->num_buffers = MAX(info->num_buffers, NUM_BUFFERS);
> +	info->num_buffers = MIN(info->num_buffers, page_data_num);
>
>   	DEBUG_MSG("Number of struct page_data for produce/consume: %d\n",
>   			info->num_buffers);
> @@ -3588,6 +3591,36 @@ initial_for_parallel()
>   	}
>
>   	/*
> +	 * initial page_flag for each thread
> +	 */
> +	if ((info->page_flag_buf = malloc(sizeof(void *) * info->num_threads))
> +	    == NULL) {
> +		MSG("Can't allocate memory for page_flag_buf. %s\n",
> +				strerror(errno));
> +		return FALSE;
> +	}
> +	memset(info->page_flag_buf, 0, sizeof(void *) * info->num_threads);
> +
> +	for (i = 0; i < info->num_threads; i++) {
> +		if ((info->page_flag_buf[i] = malloc(sizeof(struct page_flag))) == NULL) {
> +			MSG("Can't allocate memory for page_flag_buf. %s\n",
> +				strerror(errno));
> +			return FALSE;
> +		}
> +		current = info->page_flag_buf[i];
> +
> +		for (j = 1; j < NUM_BUFFERS; j++) {
> +			if ((current->next = calloc(0, sizeof(struct page_flag))) == NULL) {
> +				MSG("Can't allocate memory for data of page_data_buf. %s\n",
> +					strerror(errno));
> +				return FALSE;
> +			}
> +			current = current->next;
> +		}
> +		current->next = info->page_flag_buf[i];
> +	}
> +
> +	/*
>   	 * initial fd_memory for threads
>   	 */
>   	for (i = 0; i < info->num_threads; i++) {
> @@ -3612,7 +3645,8 @@ initial_for_parallel()
>   void
>   free_for_parallel()
>   {
> -	int i;
> +	int i, j;
> +	struct page_flag *current;
>
>   	if (info->threads != NULL) {
>   		for (i = 0; i < info->num_threads; i++) {
> @@ -3655,6 +3689,19 @@ free_for_parallel()
>   		free(info->page_data_buf);
>   	}
>
> +	if (info->page_flag_buf != NULL) {
> +		for (i = 0; i < info->num_threads; i++) {
> +			for (j = 0; j < NUM_BUFFERS; j++) {
> +				if (info->page_flag_buf[i] != NULL) {
> +					current = info->page_flag_buf[i];
> +					info->page_flag_buf[i] = current->next;
> +					free(current);
> +				}
> +			}
> +		}
> +		free(info->page_flag_buf);
> +	}
> +
>   	if (info->parallel_info == NULL)
>   		return;
>
> @@ -7076,10 +7123,10 @@ kdump_thread_function_cyclic(void *arg) {
>   	void *retval = PTHREAD_FAIL;
>   	struct thread_args *kdump_thread_args = (struct thread_args *)arg;
>   	struct page_data *page_data_buf = kdump_thread_args->page_data_buf;
> +	struct page_flag *page_flag_buf = kdump_thread_args->page_flag_buf;
>   	struct cycle *cycle = kdump_thread_args->cycle;
> -	int page_data_num = kdump_thread_args->page_data_num;
>   	mdf_pfn_t pfn;
> -	int index;
> +	int index = kdump_thread_args->thread_num;
>   	int buf_ready;
>   	int dumpable;
>   	int fd_memory = 0;
> @@ -7125,47 +7172,48 @@ kdump_thread_function_cyclic(void *arg) {
>   						kdump_thread_args->thread_num);
>   	}
>
> -	while (1) {
> -		/* get next pfn */
> -		pthread_mutex_lock(&info->current_pfn_mutex);
> -		pfn = info->current_pfn;
> -		info->current_pfn++;
> -		pthread_mutex_unlock(&info->current_pfn_mutex);
> +	/* filtered page won't take anything
> +	 * unfiltered zero page will only take a page_flag_buf
> +	 * unfiltered non-zero page will take a page_flag_buf and a page_data_buf
> +	 */
> +	while (page_flag_buf->pfn < kdump_thread_args->end_pfn) {
> +		buf_ready = FALSE;
>
> -		if (pfn >= kdump_thread_args->end_pfn)
> -			break;
> +		while (page_data_buf[index].used != 0 ||
> +				pthread_mutex_trylock(&page_data_buf[index].mutex) != 0)
> +			index = (index + 1) % info->num_buffers;
>
> -		index = -1;
> -		buf_ready = FALSE;
> +		page_data_buf[index].used = 1;
>
>   		while (buf_ready == FALSE) {
>   			pthread_testcancel();
> -
> -			index = pfn % page_data_num;
> -
> -			if (pfn - info->consumed_pfn > info->num_buffers)
> -				continue;
> -
> -			if (page_data_buf[index].ready != 0)
> +			/* 1 means page_flag_buf is ready to be used */
> +			if (page_flag_buf->ready == 1)
>   				continue;
>
> -			pthread_mutex_lock(&page_data_buf[index].mutex);
> +			/* get next pfn */
> +			pthread_mutex_lock(&info->current_pfn_mutex);
> +			pfn = info->current_pfn;
> +			info->current_pfn++;
> +			/* 2 means page_flag_buf is being filled */
> +			page_flag_buf->ready = 2;
> +			pthread_mutex_unlock(&info->current_pfn_mutex);
>
> -			if (page_data_buf[index].ready != 0)
> -				goto unlock;
> +			page_flag_buf->pfn = pfn;
>
> -			buf_ready = TRUE;
> -
> -			page_data_buf[index].pfn = pfn;
> -			page_data_buf[index].ready = 1;
> +			if (pfn >= kdump_thread_args->end_pfn) {
> +				page_data_buf[index].used = 0;
> +				page_flag_buf->ready = 1;
> +				info->current_pfn--;
> +				break;
> +			}
>
>   			dumpable = is_dumpable(
>   				info->fd_bitmap ? &bitmap_parallel : info->bitmap2,
>   				pfn,
>   				cycle);
> -			page_data_buf[index].dumpable = dumpable;
>   			if (!dumpable)
> -				goto unlock;
> +				continue;
>
>   			if (!read_pfn_parallel(fd_memory, pfn, buf,
>   					       &bitmap_memory_parallel,
> @@ -7178,11 +7226,11 @@ kdump_thread_function_cyclic(void *arg) {
>
>   			if ((info->dump_level & DL_EXCLUDE_ZERO)
>   			    && is_zero_page(buf, info->page_size)) {
> -				page_data_buf[index].zero = TRUE;
> -				goto unlock;
> +				page_flag_buf->zero = TRUE;
> +				goto next;
>   			}
>
> -			page_data_buf[index].zero = FALSE;
> +			page_flag_buf->zero = FALSE;
>
>   			/*
>   			 * Compress the page data.
> @@ -7232,12 +7280,16 @@ kdump_thread_function_cyclic(void *arg) {
>   				page_data_buf[index].size  = info->page_size;
>   				memcpy(page_data_buf[index].buf, buf, info->page_size);
>   			}
> -unlock:
> -			pthread_mutex_unlock(&page_data_buf[index].mutex);
> +			page_flag_buf->index = index;
> +			buf_ready = TRUE;
> +next:
> +			page_flag_buf->ready = 1;
> +			page_flag_buf = page_flag_buf->next;
>
>   		}
> -	}
>
> +		pthread_mutex_unlock(&page_data_buf[index].mutex);
> +	}
>   	retval = NULL;
>
>   fail:
> @@ -7265,14 +7317,15 @@ write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
>   	struct page_desc pd;
>   	struct timeval tv_start;
>   	struct timeval last, new;
> -	unsigned long long consuming_pfn;
>   	pthread_t **threads = NULL;
>   	struct thread_args *kdump_thread_args = NULL;
>   	void *thread_result;
> -	int page_data_num;
> +	int page_buf_num;
>   	struct page_data *page_data_buf = NULL;
>   	int i;
>   	int index;
> +	int end_count, consuming, check_count;
> +	mdf_pfn_t current_pfn, temp_pfn;
>
>   	if (info->flag_elf_dumpfile)
>   		return FALSE;
> @@ -7319,16 +7372,11 @@ write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
>   	threads = info->threads;
>   	kdump_thread_args = info->kdump_thread_args;
>
> -	page_data_num = info->num_buffers;
> +	page_buf_num = info->num_buffers;
>   	page_data_buf = info->page_data_buf;
>
> -	for (i = 0; i < page_data_num; i++) {
> -		/*
> -		 * producer will use pfn in page_data_buf to decide the
> -		 * consumed pfn
> -		 */
> -		page_data_buf[i].pfn = start_pfn - 1;
> -		page_data_buf[i].ready = 0;
> +	for (i = 0; i < page_buf_num; i++) {
> +		page_data_buf[i].used = 0;
>   		res = pthread_mutex_init(&page_data_buf[i].mutex, NULL);
>   		if (res != 0) {
>   			ERRMSG("Can't initialize mutex of page_data_buf. %s\n",
> @@ -7342,8 +7390,9 @@ write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
>   		kdump_thread_args[i].len_buf_out = len_buf_out;
>   		kdump_thread_args[i].start_pfn = start_pfn;
>   		kdump_thread_args[i].end_pfn = end_pfn;
> -		kdump_thread_args[i].page_data_num = page_data_num;
> +		kdump_thread_args[i].page_buf_num = page_buf_num;
>   		kdump_thread_args[i].page_data_buf = page_data_buf;
> +		kdump_thread_args[i].page_flag_buf = info->page_flag_buf[i];
>   		kdump_thread_args[i].cycle = cycle;
>
>   		res = pthread_create(threads[i], NULL,
> @@ -7356,55 +7405,101 @@ write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
>   		}
>   	}
>
> -	consuming_pfn = start_pfn;
> -	index = -1;
> +	while (1) {
> +		consuming = 0;
> +		check_count = 0;
>
> -	gettimeofday(&last, NULL);
> +		/*
> +		 * The basic idea is producer producing page and consumer writing page.
> +		 * Each producer have a page_flag_buf list which is used for storing page's description.
> +		 * The size of page_flag_buf is little so it won't take too much memory.
> +		 * And all producers will share a page_data_buf array which is used for storing page's compressed data.
> +		 * The main thread is the consumer. It will find the next pfn and write it into file.
> +		 * The next pfn is smallest pfn in all page_flag_buf.
> +		 */
> +		/*
> +		 *
> +		 */
> +		while (1) {
> +			current_pfn = end_pfn;
> +			end_count = 0;
>
> -	while (consuming_pfn < end_pfn) {
> -		index = consuming_pfn % page_data_num;
> +			/*
> +			 * page_flag_buf is in circular linked list.
> +			 * The array info->page_flag_buf[] records the current page_flag_buf in each thread's
> +			 * page_flag_buf list.
> +			 * consuming is used for recording in which thread the pfn is the smallest.
> +			 * current_pfn is used for recording the value of pfn when checking the pfn.
> +			 */
> +			for (i = 0; i < info->num_threads; i++) {
>
> -		gettimeofday(&new, NULL);
> -		if (new.tv_sec - last.tv_sec > WAIT_TIME) {
> -			ERRMSG("Can't get data of pfn %llx.\n", consuming_pfn);
> -			goto out;
> -		}
> +				/*
> +				 * ready == 0 means the page_flag_buf haven't been used.
> +				 * So we will skip it.
> +				 */
> +				if (info->page_flag_buf[i]->ready == 0)
> +					continue;
> +				temp_pfn = info->page_flag_buf[i]->pfn;
>
> -		/*
> -		 * check pfn first without mutex locked to reduce the time
> -		 * trying to lock the mutex
> -		 */
> -		if (page_data_buf[index].pfn != consuming_pfn)
> -			continue;
> +				/*
> +				 * count how many threads have reached the end.
> +				 */
> +				if (temp_pfn >= end_pfn) {
> +					end_count++;
> +					continue;
> +				}
>
> -		if (pthread_mutex_trylock(&page_data_buf[index].mutex) != 0)
> -			continue;
> +				if (current_pfn < temp_pfn)
> +					continue;
>
> -		/* check whether the found one is ready to be consumed */
> -		if (page_data_buf[index].pfn != consuming_pfn ||
> -		    page_data_buf[index].ready != 1) {
> -			goto unlock;
> +				check_count++;
> +				consuming = i;
> +				current_pfn = temp_pfn;
> +			}
> +
> +			/*
> +			 * If all the threads have reached the end, we will finish writing.
> +			 */
> +			if (end_count >= info->num_threads)
> +				goto finish;
> +
> +			/*
> +			 * Since it has the probabilty that there is no page_flag_buf being ready,
> +			 * we should recheck if it happens.
> +			 */
> +			if (check_count == 0)
> +				continue;
> +
> +			/*
> +			 * When we check the pfn in page_flag_buf, it may be being produced.
> +			 * So we should wait until it is ready to use. And if the pfn is
> +			 * different from the value when we check, we should rechoose the buf.
> +			 */
> +			gettimeofday(&last, NULL);
> +			while (info->page_flag_buf[consuming]->ready != 1) {
> +				gettimeofday(&new, NULL);
> +				if (new.tv_sec - last.tv_sec > WAIT_TIME) {
> +					ERRMSG("Can't get data of pfn.\n");
> +					goto out;
> +				}
> +			}
> +
> +			if (current_pfn == info->page_flag_buf[consuming]->pfn)
> +				break;
>   		}
>
>   		if ((num_dumped % per) == 0)
>   			print_progress(PROGRESS_COPY, num_dumped, info->num_dumpable);
>
> -		/* next pfn is found, refresh last here */
> -		last = new;
> -		consuming_pfn++;
> -		info->consumed_pfn++;
> -		page_data_buf[index].ready = 0;
> -
> -		if (page_data_buf[index].dumpable == FALSE)
> -			goto unlock;
> -
>   		num_dumped++;
>
> -		if (page_data_buf[index].zero == TRUE) {
> +
> +		if (info->page_flag_buf[consuming]->zero == TRUE) {
>   			if (!write_cache(cd_header, pd_zero, sizeof(page_desc_t)))
>   				goto out;
>   			pfn_zero++;
>   		} else {
> +			index = info->page_flag_buf[consuming]->index;
>   			pd.flags      = page_data_buf[index].flags;
>   			pd.size       = page_data_buf[index].size;
>   			pd.page_flags = 0;
> @@ -7420,12 +7515,12 @@ write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
>   			 */
>   			if (!write_cache(cd_page, page_data_buf[index].buf, pd.size))
>   				goto out;
> -
> +			page_data_buf[index].used = 0;
>   		}
> -unlock:
> -		pthread_mutex_unlock(&page_data_buf[index].mutex);
> +		info->page_flag_buf[consuming]->ready = 0;
> +		info->page_flag_buf[consuming] = info->page_flag_buf[consuming]->next;
>   	}
> -
> +finish:
>   	ret = TRUE;
>   	/*
>   	 * print [100 %]
> @@ -7464,7 +7559,7 @@ out:
>   	}
>
>   	if (page_data_buf != NULL) {
> -		for (i = 0; i < page_data_num; i++) {
> +		for (i = 0; i < page_buf_num; i++) {
>   			pthread_mutex_destroy(&page_data_buf[i].mutex);
>   		}
>   	}
> @@ -7564,6 +7659,7 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
>   		num_dumped++;
>   		if (!read_pfn(pfn, buf))
>   			goto out;
> +
>   		filter_data_buffer(buf, pfn_to_paddr(pfn), info->page_size);
>
>   		/*
> diff --git a/makedumpfile.h b/makedumpfile.h
> index e0b5bbf..7452e24 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -977,7 +977,7 @@ typedef unsigned long long int ulonglong;
>   #define PAGE_DATA_NUM	(50)
>   #define WAIT_TIME	(60 * 10)
>   #define PTHREAD_FAIL	((void *)-2)
> -#define NUM_BUFFERS	(50)
> +#define NUM_BUFFERS	(20)
>
>   struct mmap_cache {
>   	char	*mmap_buf;
> @@ -985,28 +985,31 @@ struct mmap_cache {
>   	off_t   mmap_end_offset;
>   };
>
> +struct page_flag {
> +	mdf_pfn_t pfn;
> +	char zero;
> +	char ready;
> +	short index;
> +	struct page_flag *next;
> +};
> +
>   struct page_data
>   {
> -	mdf_pfn_t pfn;
> -	int dumpable;
> -	int zero;
> -	unsigned int flags;
> +	pthread_mutex_t mutex;
>   	long size;
>   	unsigned char *buf;
> -	pthread_mutex_t mutex;
> -	/*
> -	 * whether the page_data is ready to be consumed
> -	 */
> -	int ready;
> +	int flags;
> +	int used;
>   };
>
>   struct thread_args {
>   	int thread_num;
>   	unsigned long len_buf_out;
>   	mdf_pfn_t start_pfn, end_pfn;
> -	int page_data_num;
> +	int page_buf_num;
>   	struct cycle *cycle;
>   	struct page_data *page_data_buf;
> +	struct page_flag *page_flag_buf;
>   };
>
>   /*
> @@ -1295,6 +1298,7 @@ struct DumpInfo {
>   	pthread_t **threads;
>   	struct thread_args *kdump_thread_args;
>   	struct page_data *page_data_buf;
> +	struct page_flag **page_flag_buf;
>   	pthread_rwlock_t usemmap_rwlock;
>   	mdf_pfn_t current_pfn;
>   	pthread_mutex_t current_pfn_mutex;
>



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
