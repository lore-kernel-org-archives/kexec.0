Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1agnJ8-0008Fk-PR
 for kexec@lists.infradead.org; Fri, 18 Mar 2016 05:50:53 +0000
Message-ID: <56EB96B8.7010103@cn.fujitsu.com>
Date: Fri, 18 Mar 2016 13:48:40 +0800
From: =?UTF-8?B?Ilpob3UsIFdlbmppYW4v5ZGo5paH5YmRIg==?=
 <zhouwj-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v4] Improve the performance of --num-threads -d 31
References: <1457483231-2092-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <20160315063430.GA12981@dhcp-128-25.nay.redhat.com>
 <56EB6C06.30205@cn.fujitsu.com>
 <20160318041622.GB29025@dhcp-128-25.nay.redhat.com>
In-Reply-To: <20160318041622.GB29025@dhcp-128-25.nay.redhat.com>
Content-Type: multipart/mixed; boundary="------------030304090200080901080101"
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

--------------030304090200080901080101
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

On 03/18/2016 12:16 PM, Minfei Huang wrote:
> On 03/18/16 at 10:46am, "Zhou, Wenjian/周文剑" wrote:
>> Hello Minfei,
>>
>> Since I can't produce the bug, I reviewed the patch and wrote an increment patch.
>> Though there are some bugs in the increment patch,
>> I wonder if the previous bug still exists with this patch.
>> Could you help me confirm it?
>
> Ok. I will help verify this increasing patch.
>

Thank you very much.

>>
>> And I have another question.
>> Did it only occur in patch v4?
>
> This issue doesn't exist in v3. I have pasted the test result with
> --num-thread 32 in that thread.
>
> applied makedumpfile with option -d 31 --num-threads 32
> real    3m3.533s

Oh, then the patch in the previous mail may not work.

I'm appreciated if you can also test the patch in this letter.

I introduced semaphore to fix the bug in the v3.
So I want to know if it is this which affects the result.
The attached patch is based on v4, used to remove semaohore.

-- 
Thanks
Zhou

>
> Thanks
> Minfei
>
>> The previous patches almost have the same logic.
>>
>> --
>> Thanks
>> Zhou
>>
>> On 03/15/2016 02:34 PM, Minfei Huang wrote:
>>> Hi, Zhou.
>>>
>>> I have applied this patch base on 1.5.9. There are several testcases I
>>> have tested.
>>>
>>> - makedumpfile --num-threads 64 -d 31
>>>      real    0m0.010s
>>>      user    0m0.002s
>>>      sys 0m0.009s
>>>
>>> - makedumpfile --num-threads 31 -d 31
>>>      real    2m40.915s
>>>      user    10m50.900s
>>>      sys 23m9.664s
>>>
>>> makedumpfile --num-threads 30 -d 31
>>>      real    0m0.006s
>>>      user    0m0.002s
>>>      sys 0m0.004s
>>>
>>> makedumpfile --num-threads 32 -d 31
>>>      real    0m0.007s
>>>      user    0m0.002s
>>>      sys 0m0.005s
>>>
>>> - makedumpfile --num-threads 8 -d 31
>>>      real    2m32.692s
>>>      user    7m4.630s
>>>      sys 2m0.369s
>>>
>>> - makedumpfile --num-threads 1 -d 31
>>>      real    4m42.423s
>>>      user    7m27.153s
>>>      sys 0m22.490s
>>>
>>> - makedumpfile.orig -d 31
>>>      real    4m1.297s
>>>      user    3m39.696s
>>>      sys 0m15.200s
>>>
>>> This patch has a huge increment to the filter performance under 31. But
>>> it is not stable, since makedumpfile fails to dump vmcore intermittently.
>>> You can find the above test result, makedumpfile fails to dump vmcore
>>> with option --num-threads 64, also it may occur with option
>>> --number-threads 8.
>>>
>>> Thanks
>>> Minfei
>>>
>>> On 03/09/16 at 08:27am, Zhou Wenjian wrote:
>>>> v4:
>>>>          1. fix a bug caused by the logic
>>>> v3:
>>>>          1. remove some unused variables
>>>>          2. fix a bug caused by the wrong logic
>>>>          3. fix a bug caused by optimising
>>>>          4. improve more performance by using Minoru Usui's code
>>>>
>>>> multi-threads implementation will introduce extra cost when handling
>>>> each page. The origin implementation will also do the extra work for
>>>> filtered pages. So there is a big performance degradation in
>>>> --num-threads -d 31.
>>>> The new implementation won't do the extra work for filtered pages any
>>>> more. So the performance of -d 31 is close to that of serial processing.
>>>>
>>>> The new implementation is just like the following:
>>>>          * The basic idea is producer producing page and consumer writing page.
>>>>          * Each producer have a page_flag_buf list which is used for storing
>>>>            page's description.
>>>>          * The size of page_flag_buf is little so it won't take too much memory.
>>>>          * And all producers will share a page_data_buf array which is
>>>>            used for storing page's compressed data.
>>>>          * The main thread is the consumer. It will find the next pfn and write
>>>>            it into file.
>>>>          * The next pfn is smallest pfn in all page_flag_buf.
>>>>
>>>> Signed-off-by: Minoru Usui <min-usui@ti.jp.nec.com>
>>>> Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
>>>> ---
>>>>   makedumpfile.c | 298 +++++++++++++++++++++++++++++++++++----------------------
>>>>   makedumpfile.h |  35 ++++---
>>>>   2 files changed, 202 insertions(+), 131 deletions(-)
>>>>
>>>> diff --git a/makedumpfile.c b/makedumpfile.c
>>>> index fa0b779..2b0864a 100644
>>>> --- a/makedumpfile.c
>>>> +++ b/makedumpfile.c
>>>> @@ -3483,7 +3483,8 @@ initial_for_parallel()
>>>>   	unsigned long page_data_buf_size;
>>>>   	unsigned long limit_size;
>>>>   	int page_data_num;
>>>> -	int i;
>>>> +	struct page_flag *current;
>>>> +	int i, j;
>>>>
>>>>   	len_buf_out = calculate_len_buf_out(info->page_size);
>>>>
>>>> @@ -3560,10 +3561,16 @@ initial_for_parallel()
>>>>
>>>>   	limit_size = (get_free_memory_size()
>>>>   		      - MAP_REGION * info->num_threads) * 0.6;
>>>> +	if (limit_size < 0) {
>>>> +		MSG("Free memory is not enough for multi-threads\n");
>>>> +		return FALSE;
>>>> +	}
>>>>
>>>>   	page_data_num = limit_size / page_data_buf_size;
>>>> +	info->num_buffers = 3 * info->num_threads;
>>>>
>>>> -	info->num_buffers = MIN(NUM_BUFFERS, page_data_num);
>>>> +	info->num_buffers = MAX(info->num_buffers, NUM_BUFFERS);
>>>> +	info->num_buffers = MIN(info->num_buffers, page_data_num);
>>>>
>>>>   	DEBUG_MSG("Number of struct page_data for produce/consume: %d\n",
>>>>   			info->num_buffers);
>>>> @@ -3588,6 +3595,36 @@ initial_for_parallel()
>>>>   	}
>>>>
>>>>   	/*
>>>> +	 * initial page_flag for each thread
>>>> +	 */
>>>> +	if ((info->page_flag_buf = malloc(sizeof(void *) * info->num_threads))
>>>> +	    == NULL) {
>>>> +		MSG("Can't allocate memory for page_flag_buf. %s\n",
>>>> +				strerror(errno));
>>>> +		return FALSE;
>>>> +	}
>>>> +	memset(info->page_flag_buf, 0, sizeof(void *) * info->num_threads);
>>>> +
>>>> +	for (i = 0; i < info->num_threads; i++) {
>>>> +		if ((info->page_flag_buf[i] = calloc(1, sizeof(struct page_flag))) == NULL) {
>>>> +			MSG("Can't allocate memory for page_flag. %s\n",
>>>> +				strerror(errno));
>>>> +			return FALSE;
>>>> +		}
>>>> +		current = info->page_flag_buf[i];
>>>> +
>>>> +		for (j = 1; j < NUM_BUFFERS; j++) {
>>>> +			if ((current->next = calloc(1, sizeof(struct page_flag))) == NULL) {
>>>> +				MSG("Can't allocate memory for page_flag. %s\n",
>>>> +					strerror(errno));
>>>> +				return FALSE;
>>>> +			}
>>>> +			current = current->next;
>>>> +		}
>>>> +		current->next = info->page_flag_buf[i];
>>>> +	}
>>>> +
>>>> +	/*
>>>>   	 * initial fd_memory for threads
>>>>   	 */
>>>>   	for (i = 0; i < info->num_threads; i++) {
>>>> @@ -3612,7 +3649,8 @@ initial_for_parallel()
>>>>   void
>>>>   free_for_parallel()
>>>>   {
>>>> -	int i;
>>>> +	int i, j;
>>>> +	struct page_flag *current;
>>>>
>>>>   	if (info->threads != NULL) {
>>>>   		for (i = 0; i < info->num_threads; i++) {
>>>> @@ -3655,6 +3693,19 @@ free_for_parallel()
>>>>   		free(info->page_data_buf);
>>>>   	}
>>>>
>>>> +	if (info->page_flag_buf != NULL) {
>>>> +		for (i = 0; i < info->num_threads; i++) {
>>>> +			for (j = 0; j < NUM_BUFFERS; j++) {
>>>> +				if (info->page_flag_buf[i] != NULL) {
>>>> +					current = info->page_flag_buf[i];
>>>> +					info->page_flag_buf[i] = current->next;
>>>> +					free(current);
>>>> +				}
>>>> +			}
>>>> +		}
>>>> +		free(info->page_flag_buf);
>>>> +	}
>>>> +
>>>>   	if (info->parallel_info == NULL)
>>>>   		return;
>>>>
>>>> @@ -7075,11 +7126,11 @@ void *
>>>>   kdump_thread_function_cyclic(void *arg) {
>>>>   	void *retval = PTHREAD_FAIL;
>>>>   	struct thread_args *kdump_thread_args = (struct thread_args *)arg;
>>>> -	struct page_data *page_data_buf = kdump_thread_args->page_data_buf;
>>>> +	volatile struct page_data *page_data_buf = kdump_thread_args->page_data_buf;
>>>> +	volatile struct page_flag *page_flag_buf = kdump_thread_args->page_flag_buf;
>>>>   	struct cycle *cycle = kdump_thread_args->cycle;
>>>> -	int page_data_num = kdump_thread_args->page_data_num;
>>>> -	mdf_pfn_t pfn;
>>>> -	int index;
>>>> +	mdf_pfn_t pfn = cycle->start_pfn;
>>>> +	int index = kdump_thread_args->thread_num;
>>>>   	int buf_ready;
>>>>   	int dumpable;
>>>>   	int fd_memory = 0;
>>>> @@ -7125,47 +7176,48 @@ kdump_thread_function_cyclic(void *arg) {
>>>>   						kdump_thread_args->thread_num);
>>>>   	}
>>>>
>>>> -	while (1) {
>>>> -		/* get next pfn */
>>>> -		pthread_mutex_lock(&info->current_pfn_mutex);
>>>> -		pfn = info->current_pfn;
>>>> -		info->current_pfn++;
>>>> -		pthread_mutex_unlock(&info->current_pfn_mutex);
>>>> -
>>>> -		if (pfn >= kdump_thread_args->end_pfn)
>>>> -			break;
>>>> -
>>>> -		index = -1;
>>>> +	/*
>>>> +	 * filtered page won't take anything
>>>> +	 * unfiltered zero page will only take a page_flag_buf
>>>> +	 * unfiltered non-zero page will take a page_flag_buf and a page_data_buf
>>>> +	 */
>>>> +	while (pfn < cycle->end_pfn) {
>>>>   		buf_ready = FALSE;
>>>>
>>>> +		pthread_mutex_lock(&info->page_data_mutex);
>>>> +		while (page_data_buf[index].used != FALSE) {
>>>> +			index = (index + 1) % info->num_buffers;
>>>> +		}
>>>> +		page_data_buf[index].used = TRUE;
>>>> +		pthread_mutex_unlock(&info->page_data_mutex);
>>>> +
>>>>   		while (buf_ready == FALSE) {
>>>>   			pthread_testcancel();
>>>> -
>>>> -			index = pfn % page_data_num;
>>>> -
>>>> -			if (pfn - info->consumed_pfn > info->num_buffers)
>>>> +			if (page_flag_buf->ready == FLAG_READY)
>>>>   				continue;
>>>>
>>>> -			if (page_data_buf[index].ready != 0)
>>>> -				continue;
>>>> -
>>>> -			pthread_mutex_lock(&page_data_buf[index].mutex);
>>>> -
>>>> -			if (page_data_buf[index].ready != 0)
>>>> -				goto unlock;
>>>> -
>>>> -			buf_ready = TRUE;
>>>> +			/* get next dumpable pfn */
>>>> +			pthread_mutex_lock(&info->current_pfn_mutex);
>>>> +			for (pfn = info->current_pfn; pfn < cycle->end_pfn; pfn++) {
>>>> +				dumpable = is_dumpable(
>>>> +					info->fd_bitmap ? &bitmap_parallel : info->bitmap2,
>>>> +					pfn,
>>>> +					cycle);
>>>> +				if (dumpable)
>>>> +					break;
>>>> +			}
>>>> +			info->current_pfn = pfn + 1;
>>>>
>>>> -			page_data_buf[index].pfn = pfn;
>>>> -			page_data_buf[index].ready = 1;
>>>> +			page_flag_buf->pfn = pfn;
>>>> +			page_flag_buf->ready = FLAG_FILLING;
>>>> +			pthread_mutex_unlock(&info->current_pfn_mutex);
>>>> +			sem_post(&info->page_flag_buf_sem);
>>>>
>>>> -			dumpable = is_dumpable(
>>>> -				info->fd_bitmap ? &bitmap_parallel : info->bitmap2,
>>>> -				pfn,
>>>> -				cycle);
>>>> -			page_data_buf[index].dumpable = dumpable;
>>>> -			if (!dumpable)
>>>> -				goto unlock;
>>>> +			if (pfn >= cycle->end_pfn) {
>>>> +				info->current_pfn = cycle->end_pfn;
>>>> +				page_data_buf[index].used = FALSE;
>>>> +				break;
>>>> +			}
>>>>
>>>>   			if (!read_pfn_parallel(fd_memory, pfn, buf,
>>>>   					       &bitmap_memory_parallel,
>>>> @@ -7178,11 +7230,11 @@ kdump_thread_function_cyclic(void *arg) {
>>>>
>>>>   			if ((info->dump_level & DL_EXCLUDE_ZERO)
>>>>   			    && is_zero_page(buf, info->page_size)) {
>>>> -				page_data_buf[index].zero = TRUE;
>>>> -				goto unlock;
>>>> +				page_flag_buf->zero = TRUE;
>>>> +				goto next;
>>>>   			}
>>>>
>>>> -			page_data_buf[index].zero = FALSE;
>>>> +			page_flag_buf->zero = FALSE;
>>>>
>>>>   			/*
>>>>   			 * Compress the page data.
>>>> @@ -7210,6 +7262,7 @@ kdump_thread_function_cyclic(void *arg) {
>>>>   				page_data_buf[index].flags =
>>>>   							DUMP_DH_COMPRESSED_LZO;
>>>>   				page_data_buf[index].size  = size_out;
>>>> +
>>>>   				memcpy(page_data_buf[index].buf, buf_out, size_out);
>>>>   #endif
>>>>   #ifdef USESNAPPY
>>>> @@ -7232,12 +7285,14 @@ kdump_thread_function_cyclic(void *arg) {
>>>>   				page_data_buf[index].size  = info->page_size;
>>>>   				memcpy(page_data_buf[index].buf, buf, info->page_size);
>>>>   			}
>>>> -unlock:
>>>> -			pthread_mutex_unlock(&page_data_buf[index].mutex);
>>>> +			page_flag_buf->index = index;
>>>> +			buf_ready = TRUE;
>>>> +next:
>>>> +			page_flag_buf->ready = FLAG_READY;
>>>> +			page_flag_buf = page_flag_buf->next;
>>>>
>>>>   		}
>>>>   	}
>>>> -
>>>>   	retval = NULL;
>>>>
>>>>   fail:
>>>> @@ -7265,14 +7320,15 @@ write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
>>>>   	struct page_desc pd;
>>>>   	struct timeval tv_start;
>>>>   	struct timeval last, new;
>>>> -	unsigned long long consuming_pfn;
>>>>   	pthread_t **threads = NULL;
>>>>   	struct thread_args *kdump_thread_args = NULL;
>>>>   	void *thread_result;
>>>> -	int page_data_num;
>>>> +	int page_buf_num;
>>>>   	struct page_data *page_data_buf = NULL;
>>>>   	int i;
>>>>   	int index;
>>>> +	int end_count, consuming, check_count;
>>>> +	mdf_pfn_t current_pfn, temp_pfn;
>>>>
>>>>   	if (info->flag_elf_dumpfile)
>>>>   		return FALSE;
>>>> @@ -7284,13 +7340,6 @@ write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
>>>>   		goto out;
>>>>   	}
>>>>
>>>> -	res = pthread_mutex_init(&info->consumed_pfn_mutex, NULL);
>>>> -	if (res != 0) {
>>>> -		ERRMSG("Can't initialize consumed_pfn_mutex. %s\n",
>>>> -				strerror(res));
>>>> -		goto out;
>>>> -	}
>>>> -
>>>>   	res = pthread_mutex_init(&info->filter_mutex, NULL);
>>>>   	if (res != 0) {
>>>>   		ERRMSG("Can't initialize filter_mutex. %s\n", strerror(res));
>>>> @@ -7314,36 +7363,23 @@ write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
>>>>   	end_pfn   = cycle->end_pfn;
>>>>
>>>>   	info->current_pfn = start_pfn;
>>>> -	info->consumed_pfn = start_pfn - 1;
>>>>
>>>>   	threads = info->threads;
>>>>   	kdump_thread_args = info->kdump_thread_args;
>>>>
>>>> -	page_data_num = info->num_buffers;
>>>> +	page_buf_num = info->num_buffers;
>>>>   	page_data_buf = info->page_data_buf;
>>>> +	pthread_mutex_init(&info->page_data_mutex, NULL);
>>>> +	sem_init(&info->page_flag_buf_sem, 0, 0);
>>>>
>>>> -	for (i = 0; i < page_data_num; i++) {
>>>> -		/*
>>>> -		 * producer will use pfn in page_data_buf to decide the
>>>> -		 * consumed pfn
>>>> -		 */
>>>> -		page_data_buf[i].pfn = start_pfn - 1;
>>>> -		page_data_buf[i].ready = 0;
>>>> -		res = pthread_mutex_init(&page_data_buf[i].mutex, NULL);
>>>> -		if (res != 0) {
>>>> -			ERRMSG("Can't initialize mutex of page_data_buf. %s\n",
>>>> -					strerror(res));
>>>> -			goto out;
>>>> -		}
>>>> -	}
>>>> +	for (i = 0; i < page_buf_num; i++)
>>>> +		page_data_buf[i].used = FALSE;
>>>>
>>>>   	for (i = 0; i < info->num_threads; i++) {
>>>>   		kdump_thread_args[i].thread_num = i;
>>>>   		kdump_thread_args[i].len_buf_out = len_buf_out;
>>>> -		kdump_thread_args[i].start_pfn = start_pfn;
>>>> -		kdump_thread_args[i].end_pfn = end_pfn;
>>>> -		kdump_thread_args[i].page_data_num = page_data_num;
>>>>   		kdump_thread_args[i].page_data_buf = page_data_buf;
>>>> +		kdump_thread_args[i].page_flag_buf = info->page_flag_buf[i];
>>>>   		kdump_thread_args[i].cycle = cycle;
>>>>
>>>>   		res = pthread_create(threads[i], NULL,
>>>> @@ -7356,55 +7392,88 @@ write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
>>>>   		}
>>>>   	}
>>>>
>>>> -	consuming_pfn = start_pfn;
>>>> -	index = -1;
>>>> +	end_count = 0;
>>>> +	while (1) {
>>>> +		consuming = 0;
>>>> +		check_count = 0;
>>>>
>>>> -	gettimeofday(&last, NULL);
>>>> +		/*
>>>> +		 * The basic idea is producer producing page and consumer writing page.
>>>> +		 * Each producer have a page_flag_buf list which is used for storing page's description.
>>>> +		 * The size of page_flag_buf is little so it won't take too much memory.
>>>> +		 * And all producers will share a page_data_buf array which is used for storing page's compressed data.
>>>> +		 * The main thread is the consumer. It will find the next pfn and write it into file.
>>>> +		 * The next pfn is smallest pfn in all page_flag_buf.
>>>> +		 */
>>>> +		sem_wait(&info->page_flag_buf_sem);
>>>> +		gettimeofday(&last, NULL);
>>>> +		while (1) {
>>>> +			current_pfn = end_pfn;
>>>>
>>>> -	while (consuming_pfn < end_pfn) {
>>>> -		index = consuming_pfn % page_data_num;
>>>> +			/*
>>>> +			 * page_flag_buf is in circular linked list.
>>>> +			 * The array info->page_flag_buf[] records the current page_flag_buf in each thread's
>>>> +			 * page_flag_buf list.
>>>> +			 * consuming is used for recording in which thread the pfn is the smallest.
>>>> +			 * current_pfn is used for recording the value of pfn when checking the pfn.
>>>> +			 */
>>>> +			for (i = 0; i < info->num_threads; i++) {
>>>> +				if (info->page_flag_buf[i]->ready == FLAG_UNUSED)
>>>> +					continue;
>>>> +				temp_pfn = info->page_flag_buf[i]->pfn;
>>>>
>>>> -		gettimeofday(&new, NULL);
>>>> -		if (new.tv_sec - last.tv_sec > WAIT_TIME) {
>>>> -			ERRMSG("Can't get data of pfn %llx.\n", consuming_pfn);
>>>> -			goto out;
>>>> -		}
>>>> +				/*
>>>> +				 * count how many threads have reached the end.
>>>> +				 */
>>>> +				if (temp_pfn >= end_pfn) {
>>>> +					info->page_flag_buf[i]->ready = FLAG_UNUSED;
>>>> +					end_count++;
>>>> +					continue;
>>>> +				}
>>>>
>>>> -		/*
>>>> -		 * check pfn first without mutex locked to reduce the time
>>>> -		 * trying to lock the mutex
>>>> -		 */
>>>> -		if (page_data_buf[index].pfn != consuming_pfn)
>>>> -			continue;
>>>> +				if (current_pfn < temp_pfn)
>>>> +					continue;
>>>>
>>>> -		if (pthread_mutex_trylock(&page_data_buf[index].mutex) != 0)
>>>> -			continue;
>>>> +				check_count++;
>>>> +				consuming = i;
>>>> +				current_pfn = temp_pfn;
>>>> +			}
>>>>
>>>> -		/* check whether the found one is ready to be consumed */
>>>> -		if (page_data_buf[index].pfn != consuming_pfn ||
>>>> -		    page_data_buf[index].ready != 1) {
>>>> -			goto unlock;
>>>> +			/*
>>>> +			 * If all the threads have reached the end, we will finish writing.
>>>> +			 */
>>>> +			if (end_count >= info->num_threads)
>>>> +				goto finish;
>>>> +
>>>> +			/*
>>>> +			 * If the page_flag_buf is not ready, the pfn recorded may be changed.
>>>> +			 * So we should recheck.
>>>> +			 */
>>>> +			if (info->page_flag_buf[consuming]->ready != FLAG_READY) {
>>>> +				gettimeofday(&new, NULL);
>>>> +				if (new.tv_sec - last.tv_sec > WAIT_TIME) {
>>>> +					ERRMSG("Can't get data of pfn.\n");
>>>> +					goto out;
>>>> +				}
>>>> +				continue;
>>>> +			}
>>>> +
>>>> +			if (current_pfn == info->page_flag_buf[consuming]->pfn)
>>>> +				break;
>>>>   		}
>>>>
>>>>   		if ((num_dumped % per) == 0)
>>>>   			print_progress(PROGRESS_COPY, num_dumped, info->num_dumpable);
>>>>
>>>> -		/* next pfn is found, refresh last here */
>>>> -		last = new;
>>>> -		consuming_pfn++;
>>>> -		info->consumed_pfn++;
>>>> -		page_data_buf[index].ready = 0;
>>>> -
>>>> -		if (page_data_buf[index].dumpable == FALSE)
>>>> -			goto unlock;
>>>> -
>>>>   		num_dumped++;
>>>>
>>>> -		if (page_data_buf[index].zero == TRUE) {
>>>> +
>>>> +		if (info->page_flag_buf[consuming]->zero == TRUE) {
>>>>   			if (!write_cache(cd_header, pd_zero, sizeof(page_desc_t)))
>>>>   				goto out;
>>>>   			pfn_zero++;
>>>>   		} else {
>>>> +			index = info->page_flag_buf[consuming]->index;
>>>>   			pd.flags      = page_data_buf[index].flags;
>>>>   			pd.size       = page_data_buf[index].size;
>>>>   			pd.page_flags = 0;
>>>> @@ -7420,12 +7489,12 @@ write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
>>>>   			 */
>>>>   			if (!write_cache(cd_page, page_data_buf[index].buf, pd.size))
>>>>   				goto out;
>>>> -
>>>> +			page_data_buf[index].used = FALSE;
>>>>   		}
>>>> -unlock:
>>>> -		pthread_mutex_unlock(&page_data_buf[index].mutex);
>>>> +		info->page_flag_buf[consuming]->ready = FLAG_UNUSED;
>>>> +		info->page_flag_buf[consuming] = info->page_flag_buf[consuming]->next;
>>>>   	}
>>>> -
>>>> +finish:
>>>>   	ret = TRUE;
>>>>   	/*
>>>>   	 * print [100 %]
>>>> @@ -7463,15 +7532,9 @@ out:
>>>>   		}
>>>>   	}
>>>>
>>>> -	if (page_data_buf != NULL) {
>>>> -		for (i = 0; i < page_data_num; i++) {
>>>> -			pthread_mutex_destroy(&page_data_buf[i].mutex);
>>>> -		}
>>>> -	}
>>>> -
>>>> +	sem_destroy(&info->page_flag_buf_sem);
>>>>   	pthread_rwlock_destroy(&info->usemmap_rwlock);
>>>>   	pthread_mutex_destroy(&info->filter_mutex);
>>>> -	pthread_mutex_destroy(&info->consumed_pfn_mutex);
>>>>   	pthread_mutex_destroy(&info->current_pfn_mutex);
>>>>
>>>>   	return ret;
>>>> @@ -7564,6 +7627,7 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
>>>>   		num_dumped++;
>>>>   		if (!read_pfn(pfn, buf))
>>>>   			goto out;
>>>> +
>>>>   		filter_data_buffer(buf, pfn_to_paddr(pfn), info->page_size);
>>>>
>>>>   		/*
>>>> diff --git a/makedumpfile.h b/makedumpfile.h
>>>> index e0b5bbf..4b315c0 100644
>>>> --- a/makedumpfile.h
>>>> +++ b/makedumpfile.h
>>>> @@ -44,6 +44,7 @@
>>>>   #include "print_info.h"
>>>>   #include "sadump_mod.h"
>>>>   #include <pthread.h>
>>>> +#include <semaphore.h>
>>>>
>>>>   /*
>>>>    * Result of command
>>>> @@ -977,7 +978,7 @@ typedef unsigned long long int ulonglong;
>>>>   #define PAGE_DATA_NUM	(50)
>>>>   #define WAIT_TIME	(60 * 10)
>>>>   #define PTHREAD_FAIL	((void *)-2)
>>>> -#define NUM_BUFFERS	(50)
>>>> +#define NUM_BUFFERS	(20)
>>>>
>>>>   struct mmap_cache {
>>>>   	char	*mmap_buf;
>>>> @@ -985,28 +986,33 @@ struct mmap_cache {
>>>>   	off_t   mmap_end_offset;
>>>>   };
>>>>
>>>> +enum {
>>>> +	FLAG_UNUSED,
>>>> +	FLAG_READY,
>>>> +	FLAG_FILLING
>>>> +};
>>>> +struct page_flag {
>>>> +	mdf_pfn_t pfn;
>>>> +	char zero;
>>>> +	char ready;
>>>> +	short index;
>>>> +	struct page_flag *next;
>>>> +};
>>>> +
>>>>   struct page_data
>>>>   {
>>>> -	mdf_pfn_t pfn;
>>>> -	int dumpable;
>>>> -	int zero;
>>>> -	unsigned int flags;
>>>>   	long size;
>>>>   	unsigned char *buf;
>>>> -	pthread_mutex_t mutex;
>>>> -	/*
>>>> -	 * whether the page_data is ready to be consumed
>>>> -	 */
>>>> -	int ready;
>>>> +	int flags;
>>>> +	int used;
>>>>   };
>>>>
>>>>   struct thread_args {
>>>>   	int thread_num;
>>>>   	unsigned long len_buf_out;
>>>> -	mdf_pfn_t start_pfn, end_pfn;
>>>> -	int page_data_num;
>>>>   	struct cycle *cycle;
>>>>   	struct page_data *page_data_buf;
>>>> +	struct page_flag *page_flag_buf;
>>>>   };
>>>>
>>>>   /*
>>>> @@ -1295,11 +1301,12 @@ struct DumpInfo {
>>>>   	pthread_t **threads;
>>>>   	struct thread_args *kdump_thread_args;
>>>>   	struct page_data *page_data_buf;
>>>> +	struct page_flag **page_flag_buf;
>>>> +	sem_t page_flag_buf_sem;
>>>>   	pthread_rwlock_t usemmap_rwlock;
>>>>   	mdf_pfn_t current_pfn;
>>>>   	pthread_mutex_t current_pfn_mutex;
>>>> -	mdf_pfn_t consumed_pfn;
>>>> -	pthread_mutex_t consumed_pfn_mutex;
>>>> +	pthread_mutex_t page_data_mutex;
>>>>   	pthread_mutex_t filter_mutex;
>>>>   };
>>>>   extern struct DumpInfo		*info;
>>>> --
>>>> 1.8.3.1
>>>>
>>>>
>>>>
>>>>
>>>> _______________________________________________
>>>> kexec mailing list
>>>> kexec@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/kexec
>>
>>
>>
>
>>  From 1d7ad5dbbc29efe58171b1023ab0df09eb2815bf Mon Sep 17 00:00:00 2001
>> From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
>> Date: Fri, 18 Mar 2016 10:35:35 +0800
>> Subject: [PATCH] increment
>>
>> ---
>>   makedumpfile.c | 107 ++++++++++++++++++++++++++++++++++++++++++---------------
>>   makedumpfile.h |  12 +++++--
>>   2 files changed, 89 insertions(+), 30 deletions(-)
>>
>> diff --git a/makedumpfile.c b/makedumpfile.c
>> index 2b0864a..a304a61 100644
>> --- a/makedumpfile.c
>> +++ b/makedumpfile.c
>> @@ -3477,6 +3477,42 @@ calibrate_machdep_info(void)
>>   }
>>
>>   int
>> +initial_parallel_area(int page_data_buf_size)
>> +{
>> +	int i, j;
>> +	struct page_flag *current;
>> +	info->page_data_buf = info->parallel_area;
>> +	void *page_data_buf = info->parallel_area + sizeof(struct page_data) * info->num_buffers;
>> +	void *page_flag_list = page_data_buf + page_data_buf_size * info->num_buffers;
>> +
>> +	for (i = 0; i < info->num_buffers; i++) {
>> +		info->page_data_buf[i].buf = page_data_buf + page_data_buf_size * i;
>> +	}
>> +
>> +
>> +	if ((info->page_flag_list = malloc(sizeof(struct page_flag_list) * info->num_threads))
>> +	    == NULL) {
>> +		MSG("Can't allocate memory for page_flag_buf. %s\n",
>> +				strerror(errno));
>> +		return FALSE;
>> +	}
>> +
>> +	for (i = 0; i < info->num_threads; i++) {
>> +		info->page_flag_list[i].header = page_flag_list + sizeof(struct page_flag) * info->num_buffers * i;
>> +		info->page_flag_list[i].current = 0;
>> +	/*	
>> +		current = info->page_flag_buf[i];
>> +		for (j = 1; j < info->num_buffers; j++) {
>> +			current->next = current + sizeof(struct page_flag);
>> +			current = current->next;
>> +		}
>> +		current->next = info->page_flag_buf[i];
>> +*/
>> +	}
>> +
>> +}
>> +
>> +int
>>   initial_for_parallel()
>>   {
>>   	unsigned long len_buf_out;
>> @@ -3575,9 +3611,15 @@ initial_for_parallel()
>>   	DEBUG_MSG("Number of struct page_data for produce/consume: %d\n",
>>   			info->num_buffers);
>>
>> -	/*
>> -	 * allocate memory for page_data
>> -	 */
>> +	if ((info->parallel_area = calloc(info->num_buffers, sizeof(struct page_data)+page_data_buf_size + sizeof(struct page_flag)*info->num_threads))
>> +		==NULL) {
>> +		MSG("Can't allocate memory for page_data_buf. %s\n",
>> +				strerror(errno));
>> +		return FALSE;
>> +	}
>> +
>> +	initial_parallel_area(page_data_buf_size);
>> +/*
>>   	if ((info->page_data_buf = malloc(sizeof(struct page_data) * info->num_buffers))
>>   	    == NULL) {
>>   		MSG("Can't allocate memory for page_data_buf. %s\n",
>> @@ -3594,9 +3636,6 @@ initial_for_parallel()
>>   		}
>>   	}
>>
>> -	/*
>> -	 * initial page_flag for each thread
>> -	 */
>>   	if ((info->page_flag_buf = malloc(sizeof(void *) * info->num_threads))
>>   	    == NULL) {
>>   		MSG("Can't allocate memory for page_flag_buf. %s\n",
>> @@ -3623,7 +3662,7 @@ initial_for_parallel()
>>   		}
>>   		current->next = info->page_flag_buf[i];
>>   	}
>> -
>> +*/
>>   	/*
>>   	 * initial fd_memory for threads
>>   	 */
>> @@ -3685,6 +3724,15 @@ free_for_parallel()
>>   	if (info->kdump_thread_args != NULL)
>>   		free(info->kdump_thread_args);
>>
>> +	if (info->page_flag_list != NULL) {
>> +		free(info->page_flag_list);
>> +	}
>> +
>> +	if (info->parallel_area != NULL) {
>> +		free(info->parallel_area);
>> +	}
>> +
>> +/*
>>   	if (info->page_data_buf != NULL) {
>>   		for (i = 0; i < info->num_buffers; i++) {
>>   			if (info->page_data_buf[i].buf != NULL)
>> @@ -3705,7 +3753,7 @@ free_for_parallel()
>>   		}
>>   		free(info->page_flag_buf);
>>   	}
>> -
>> +*/
>>   	if (info->parallel_info == NULL)
>>   		return;
>>
>> @@ -7122,12 +7170,14 @@ int finalize_zlib(z_stream *stream)
>>   	return err;
>>   }
>>
>> +#define CURRENT_FLAG page_flag_header[current_page_flag]
>>   void *
>>   kdump_thread_function_cyclic(void *arg) {
>>   	void *retval = PTHREAD_FAIL;
>>   	struct thread_args *kdump_thread_args = (struct thread_args *)arg;
>>   	volatile struct page_data *page_data_buf = kdump_thread_args->page_data_buf;
>> -	volatile struct page_flag *page_flag_buf = kdump_thread_args->page_flag_buf;
>> +	struct page_flag *page_flag_header = kdump_thread_args->page_flag_list->header;
>> +	int current_page_flag = kdump_thread_args->page_flag_list->current;
>>   	struct cycle *cycle = kdump_thread_args->cycle;
>>   	mdf_pfn_t pfn = cycle->start_pfn;
>>   	int index = kdump_thread_args->thread_num;
>> @@ -7193,7 +7243,7 @@ kdump_thread_function_cyclic(void *arg) {
>>
>>   		while (buf_ready == FALSE) {
>>   			pthread_testcancel();
>> -			if (page_flag_buf->ready == FLAG_READY)
>> +			if (CURRENT_FLAG.ready == FLAG_READY)
>>   				continue;
>>
>>   			/* get next dumpable pfn */
>> @@ -7208,8 +7258,8 @@ kdump_thread_function_cyclic(void *arg) {
>>   			}
>>   			info->current_pfn = pfn + 1;
>>
>> -			page_flag_buf->pfn = pfn;
>> -			page_flag_buf->ready = FLAG_FILLING;
>> +			CURRENT_FLAG.pfn = pfn;
>> +			CURRENT_FLAG.ready = FLAG_FILLING;
>>   			pthread_mutex_unlock(&info->current_pfn_mutex);
>>   			sem_post(&info->page_flag_buf_sem);
>>
>> @@ -7230,11 +7280,11 @@ kdump_thread_function_cyclic(void *arg) {
>>
>>   			if ((info->dump_level & DL_EXCLUDE_ZERO)
>>   			    && is_zero_page(buf, info->page_size)) {
>> -				page_flag_buf->zero = TRUE;
>> +				CURRENT_FLAG.zero = TRUE;
>>   				goto next;
>>   			}
>>
>> -			page_flag_buf->zero = FALSE;
>> +			CURRENT_FLAG.zero = FALSE;
>>
>>   			/*
>>   			 * Compress the page data.
>> @@ -7285,11 +7335,11 @@ kdump_thread_function_cyclic(void *arg) {
>>   				page_data_buf[index].size  = info->page_size;
>>   				memcpy(page_data_buf[index].buf, buf, info->page_size);
>>   			}
>> -			page_flag_buf->index = index;
>> +			CURRENT_FLAG.index = index;
>>   			buf_ready = TRUE;
>>   next:
>> -			page_flag_buf->ready = FLAG_READY;
>> -			page_flag_buf = page_flag_buf->next;
>> +			CURRENT_FLAG.ready = FLAG_READY;
>> +			current_page_flag = (current_page_flag + 1) % info->num_buffers;
>>
>>   		}
>>   	}
>> @@ -7306,6 +7356,8 @@ fail:
>>   	pthread_exit(retval);
>>   }
>>
>> +#define CURRENT_PAGE_FLAG(i) (info->page_flag_list[i].header)[info->page_flag_list[i].current]
>> +
>>   int
>>   write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
>>   				  struct cache_data *cd_page,
>> @@ -7379,7 +7431,7 @@ write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
>>   		kdump_thread_args[i].thread_num = i;
>>   		kdump_thread_args[i].len_buf_out = len_buf_out;
>>   		kdump_thread_args[i].page_data_buf = page_data_buf;
>> -		kdump_thread_args[i].page_flag_buf = info->page_flag_buf[i];
>> +		kdump_thread_args[i].page_flag_list = &(info->page_flag_list[i]);
>>   		kdump_thread_args[i].cycle = cycle;
>>
>>   		res = pthread_create(threads[i], NULL,
>> @@ -7418,15 +7470,15 @@ write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
>>   			 * current_pfn is used for recording the value of pfn when checking the pfn.
>>   			 */
>>   			for (i = 0; i < info->num_threads; i++) {
>> -				if (info->page_flag_buf[i]->ready == FLAG_UNUSED)
>> +				if (CURRENT_PAGE_FLAG(i).ready == FLAG_UNUSED)
>>   					continue;
>> -				temp_pfn = info->page_flag_buf[i]->pfn;
>> +				temp_pfn = CURRENT_PAGE_FLAG(i).pfn;
>>
>>   				/*
>>   				 * count how many threads have reached the end.
>>   				 */
>>   				if (temp_pfn >= end_pfn) {
>> -					info->page_flag_buf[i]->ready = FLAG_UNUSED;
>> +					CURRENT_PAGE_FLAG(i).ready = FLAG_UNUSED;
>>   					end_count++;
>>   					continue;
>>   				}
>> @@ -7449,7 +7501,7 @@ write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
>>   			 * If the page_flag_buf is not ready, the pfn recorded may be changed.
>>   			 * So we should recheck.
>>   			 */
>> -			if (info->page_flag_buf[consuming]->ready != FLAG_READY) {
>> +			if (CURRENT_PAGE_FLAG(consuming).ready != FLAG_READY) {
>>   				gettimeofday(&new, NULL);
>>   				if (new.tv_sec - last.tv_sec > WAIT_TIME) {
>>   					ERRMSG("Can't get data of pfn.\n");
>> @@ -7458,7 +7510,7 @@ write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
>>   				continue;
>>   			}
>>
>> -			if (current_pfn == info->page_flag_buf[consuming]->pfn)
>> +			if (current_pfn == CURRENT_PAGE_FLAG(consuming).pfn)
>>   				break;
>>   		}
>>
>> @@ -7468,12 +7520,12 @@ write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
>>   		num_dumped++;
>>
>>
>> -		if (info->page_flag_buf[consuming]->zero == TRUE) {
>> +		if (CURRENT_PAGE_FLAG(consuming).zero == TRUE) {
>>   			if (!write_cache(cd_header, pd_zero, sizeof(page_desc_t)))
>>   				goto out;
>>   			pfn_zero++;
>>   		} else {
>> -			index = info->page_flag_buf[consuming]->index;
>> +			index = CURRENT_PAGE_FLAG(consuming).index;
>>   			pd.flags      = page_data_buf[index].flags;
>>   			pd.size       = page_data_buf[index].size;
>>   			pd.page_flags = 0;
>> @@ -7491,8 +7543,9 @@ write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
>>   				goto out;
>>   			page_data_buf[index].used = FALSE;
>>   		}
>> -		info->page_flag_buf[consuming]->ready = FLAG_UNUSED;
>> -		info->page_flag_buf[consuming] = info->page_flag_buf[consuming]->next;
>> +		CURRENT_PAGE_FLAG(consuming).ready = FLAG_UNUSED;
>> +		info->page_flag_list[consuming].current += 1;
>> +		info->page_flag_list[consuming].current %= info->num_buffers;
>>   	}
>>   finish:
>>   	ret = TRUE;
>> diff --git a/makedumpfile.h b/makedumpfile.h
>> index 4b315c0..8c4bc1a 100644
>> --- a/makedumpfile.h
>> +++ b/makedumpfile.h
>> @@ -996,7 +996,12 @@ struct page_flag {
>>   	char zero;
>>   	char ready;
>>   	short index;
>> -	struct page_flag *next;
>> +//	struct page_flag *next;
>> +};
>> +
>> +struct page_flag_list {
>> +	struct page_flag *header;
>> +	int current;
>>   };
>>
>>   struct page_data
>> @@ -1012,7 +1017,7 @@ struct thread_args {
>>   	unsigned long len_buf_out;
>>   	struct cycle *cycle;
>>   	struct page_data *page_data_buf;
>> -	struct page_flag *page_flag_buf;
>> +	struct page_flag_list *page_flag_list;
>>   };
>>
>>   /*
>> @@ -1298,10 +1303,11 @@ struct DumpInfo {
>>   	 */
>>   	int num_threads;
>>   	int num_buffers;
>> +	void *parallel_area;
>>   	pthread_t **threads;
>>   	struct thread_args *kdump_thread_args;
>>   	struct page_data *page_data_buf;
>> -	struct page_flag **page_flag_buf;
>> +	struct page_flag_list *page_flag_list;
>>   	sem_t page_flag_buf_sem;
>>   	pthread_rwlock_t usemmap_rwlock;
>>   	mdf_pfn_t current_pfn;
>> --
>> 1.8.3.1
>>




--------------030304090200080901080101
Content-Type: text/x-patch; name="0001-remove-sem.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="0001-remove-sem.patch"

From 1dbf68c21a2bbc7b454c1a742c1e3ff00bb85829 Mon Sep 17 00:00:00 2001
From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Date: Fri, 18 Mar 2016 13:36:57 +0800
Subject: [PATCH] remove sem

---
 makedumpfile.c | 8 ++++----
 makedumpfile.h | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 2b0864a..8de5e1d 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -7211,7 +7211,7 @@ kdump_thread_function_cyclic(void *arg) {
 			page_flag_buf->pfn = pfn;
 			page_flag_buf->ready = FLAG_FILLING;
 			pthread_mutex_unlock(&info->current_pfn_mutex);
-			sem_post(&info->page_flag_buf_sem);
+//			sem_post(&info->page_flag_buf_sem);
 
 			if (pfn >= cycle->end_pfn) {
 				info->current_pfn = cycle->end_pfn;
@@ -7370,7 +7370,7 @@ write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
 	page_buf_num = info->num_buffers;
 	page_data_buf = info->page_data_buf;
 	pthread_mutex_init(&info->page_data_mutex, NULL);
-	sem_init(&info->page_flag_buf_sem, 0, 0);
+//	sem_init(&info->page_flag_buf_sem, 0, 0);
 
 	for (i = 0; i < page_buf_num; i++)
 		page_data_buf[i].used = FALSE;
@@ -7405,7 +7405,7 @@ write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
 		 * The main thread is the consumer. It will find the next pfn and write it into file.
 		 * The next pfn is smallest pfn in all page_flag_buf.
 		 */
-		sem_wait(&info->page_flag_buf_sem);
+//		sem_wait(&info->page_flag_buf_sem);
 		gettimeofday(&last, NULL);
 		while (1) {
 			current_pfn = end_pfn;
@@ -7532,7 +7532,7 @@ out:
 		}
 	}
 
-	sem_destroy(&info->page_flag_buf_sem);
+//	sem_destroy(&info->page_flag_buf_sem);
 	pthread_rwlock_destroy(&info->usemmap_rwlock);
 	pthread_mutex_destroy(&info->filter_mutex);
 	pthread_mutex_destroy(&info->current_pfn_mutex);
diff --git a/makedumpfile.h b/makedumpfile.h
index 4b315c0..7627286 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -44,7 +44,7 @@
 #include "print_info.h"
 #include "sadump_mod.h"
 #include <pthread.h>
-#include <semaphore.h>
+//#include <semaphore.h>
 
 /*
  * Result of command
@@ -1302,7 +1302,7 @@ struct DumpInfo {
 	struct thread_args *kdump_thread_args;
 	struct page_data *page_data_buf;
 	struct page_flag **page_flag_buf;
-	sem_t page_flag_buf_sem;
+//	sem_t page_flag_buf_sem;
 	pthread_rwlock_t usemmap_rwlock;
 	mdf_pfn_t current_pfn;
 	pthread_mutex_t current_pfn_mutex;
-- 
1.8.3.1


--------------030304090200080901080101
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--------------030304090200080901080101--

