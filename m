Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1acqSg-0002Z6-38
 for kexec@lists.infradead.org; Mon, 07 Mar 2016 08:24:20 +0000
Message-ID: <56DD3A3E.1000402@cn.fujitsu.com>
Date: Mon, 7 Mar 2016 16:22:22 +0800
From: =?ISO-2022-JP?B?Ilpob3UsIFdlbmppYW4vGyRCPH5KOBsoQj8i?=
 <zhouwj-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3] Improve the performance of --num-threads -d 31
References: <1457080544-16469-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <20160307070458.GA6016@dhcp-128-25.nay.redhat.com>
 <BE691E4CBA06214BB0FA8EEFC7C61A4D0181E2B9@BPXM02GP.gisp.nec.co.jp>
In-Reply-To: <BE691E4CBA06214BB0FA8EEFC7C61A4D0181E2B9@BPXM02GP.gisp.nec.co.jp>
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
To: Minoru Usui <min-usui@ti.jp.nec.com>
Cc: Minfei Huang <mhuang@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On 03/07/2016 03:36 PM, Minoru Usui wrote:
> Hi, Minfei, Zhou
> 
>> -----Original Message-----
>> From: kexec [mailto:kexec-bounces@lists.infradead.org] On Behalf Of Minfei Huang
>> Sent: Monday, March 07, 2016 4:05 PM
>> To: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
>> Cc: kexec@lists.infradead.org
>> Subject: Re: [PATCH v3] Improve the performance of --num-threads -d 31
>>
>> Hi, Wenjian.
>>
>> Since your patch applied Minoru Usui's draft patch, I have vierified it.
>> And it works well under 4T memory.
>>
>> applied makedumpfile with option -d 31
>> real    3m48.681s
>>
>> applied makedumpfile with option -d 31 --num-threads 32
>> real    3m3.533s
>>
>> original makedumpfile with option -d 31
>> real    3m57.163s
>>
>> Now with or without option --num-thread, it takes almost same time.
> 
> Thank you for your test on big memory machine.
> I am relieved to see your test results.
> 
> Zhou, my patch may not be sophisticated,
> but getting mutex logic is robust, it works well and its performance is not bad.
> I think it reaches the goal of the original purpose.
> I understand you don't like getting mutex, but if you are debugging now, could you apply my approach?
> 
> Thanks,
> Minoru Usui
> 
> 

Hi Minoru,

I have test your patch since you post.
I can get a failure easily.
If you run it several times, the dumpfile it produces may be different from the correct one.

+			info->current_pfn = pfn + 1;
+			pthread_mutex_unlock(&info->current_pfn_mutex);
+			page_flag_buf->pfn = pfn;
+			page_flag_buf->ready = FLAG_FILLING;
The above code should be changed to the following:

+			info->current_pfn = pfn + 1;
+			page_flag_buf->pfn = pfn;
+			page_flag_buf->ready = FLAG_FILLING;
+			pthread_mutex_unlock(&info->current_pfn_mutex);

I haven't run your code with the bug fixed.
I'll try now.

By the way, with my patch v3, I can't get an error dumpfile until run it by 5000 times.

-- 
Thanks
Zhou

>> Thanks
>> Minfei
>>
>> On 03/04/16 at 04:35pm, Zhou Wenjian wrote:
>>> v3:
>>>          1. remove some unused variables
>>> 	2. fix a bug caused by the wrong logic
>>> 	3. fix a bug caused by optimising
>>> 	4. improve more performance by using Minoru Usui's code
>>>
>>> multi-threads implementation will introduce extra cost when handling
>>> each page. The origin implementation will also do the extra work for
>>> filtered pages. So there is a big performance degradation in
>>> --num-threads -d 31.
>>> The new implementation won't do the extra work for filtered pages any
>>> more. So the performance of -d 31 is close to that of serial processing.
>>>
>>> The new implementation is just like the following:
>>>          * The basic idea is producer producing page and consumer writing page.
>>>          * Each producer have a page_flag_buf list which is used for storing
>>>            page's description.
>>>          * The size of page_flag_buf is little so it won't take too much memory.
>>>          * And all producers will share a page_data_buf array which is
>>>            used for storing page's compressed data.
>>>          * The main thread is the consumer. It will find the next pfn and write
>>>            it into file.
>>>          * The next pfn is smallest pfn in all page_flag_buf.
>>>
>>> Signed-off-by: Minoru Usui <min-usui@ti.jp.nec.com>
>>> Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
>>> ---
>>>   makedumpfile.c | 300 +++++++++++++++++++++++++++++++++++----------------------
>>>   makedumpfile.h |  33 ++++---
>>>   2 files changed, 203 insertions(+), 130 deletions(-)
>>>
>>> diff --git a/makedumpfile.c b/makedumpfile.c
>>> index fa0b779..d75f7f7 100644
>>> --- a/makedumpfile.c
>>> +++ b/makedumpfile.c
>>> @@ -3483,7 +3483,8 @@ initial_for_parallel()
>>>   	unsigned long page_data_buf_size;
>>>   	unsigned long limit_size;
>>>   	int page_data_num;
>>> -	int i;
>>> +	struct page_flag *current;
>>> +	int i, j;
>>>
>>>   	len_buf_out = calculate_len_buf_out(info->page_size);
>>>
>>> @@ -3560,10 +3561,16 @@ initial_for_parallel()
>>>
>>>   	limit_size = (get_free_memory_size()
>>>   		      - MAP_REGION * info->num_threads) * 0.6;
>>> +	if (limit_size < 0) {
>>> +		MSG("Free memory is not enough for multi-threads\n");
>>> +		return FALSE;
>>> +	}
>>>
>>>   	page_data_num = limit_size / page_data_buf_size;
>>> +	info->num_buffers = 3 * info->num_threads;
>>>
>>> -	info->num_buffers = MIN(NUM_BUFFERS, page_data_num);
>>> +	info->num_buffers = MAX(info->num_buffers, NUM_BUFFERS);
>>> +	info->num_buffers = MIN(info->num_buffers, page_data_num);
>>>
>>>   	DEBUG_MSG("Number of struct page_data for produce/consume: %d\n",
>>>   			info->num_buffers);
>>> @@ -3588,6 +3595,36 @@ initial_for_parallel()
>>>   	}
>>>
>>>   	/*
>>> +	 * initial page_flag for each thread
>>> +	 */
>>> +	if ((info->page_flag_buf = malloc(sizeof(void *) * info->num_threads))
>>> +	    == NULL) {
>>> +		MSG("Can't allocate memory for page_flag_buf. %s\n",
>>> +				strerror(errno));
>>> +		return FALSE;
>>> +	}
>>> +	memset(info->page_flag_buf, 0, sizeof(void *) * info->num_threads);
>>> +
>>> +	for (i = 0; i < info->num_threads; i++) {
>>> +		if ((info->page_flag_buf[i] = calloc(1, sizeof(struct page_flag))) == NULL) {
>>> +			MSG("Can't allocate memory for page_flag. %s\n",
>>> +				strerror(errno));
>>> +			return FALSE;
>>> +		}
>>> +		current = info->page_flag_buf[i];
>>> +
>>> +		for (j = 1; j < NUM_BUFFERS; j++) {
>>> +			if ((current->next = calloc(1, sizeof(struct page_flag))) == NULL) {
>>> +				MSG("Can't allocate memory for page_flag. %s\n",
>>> +					strerror(errno));
>>> +				return FALSE;
>>> +			}
>>> +			current = current->next;
>>> +		}
>>> +		current->next = info->page_flag_buf[i];
>>> +	}
>>> +
>>> +	/*
>>>   	 * initial fd_memory for threads
>>>   	 */
>>>   	for (i = 0; i < info->num_threads; i++) {
>>> @@ -3612,7 +3649,8 @@ initial_for_parallel()
>>>   void
>>>   free_for_parallel()
>>>   {
>>> -	int i;
>>> +	int i, j;
>>> +	struct page_flag *current;
>>>
>>>   	if (info->threads != NULL) {
>>>   		for (i = 0; i < info->num_threads; i++) {
>>> @@ -3655,6 +3693,19 @@ free_for_parallel()
>>>   		free(info->page_data_buf);
>>>   	}
>>>
>>> +	if (info->page_flag_buf != NULL) {
>>> +		for (i = 0; i < info->num_threads; i++) {
>>> +			for (j = 0; j < NUM_BUFFERS; j++) {
>>> +				if (info->page_flag_buf[i] != NULL) {
>>> +					current = info->page_flag_buf[i];
>>> +					info->page_flag_buf[i] = current->next;
>>> +					free(current);
>>> +				}
>>> +			}
>>> +		}
>>> +		free(info->page_flag_buf);
>>> +	}
>>> +
>>>   	if (info->parallel_info == NULL)
>>>   		return;
>>>
>>> @@ -7075,11 +7126,11 @@ void *
>>>   kdump_thread_function_cyclic(void *arg) {
>>>   	void *retval = PTHREAD_FAIL;
>>>   	struct thread_args *kdump_thread_args = (struct thread_args *)arg;
>>> -	struct page_data *page_data_buf = kdump_thread_args->page_data_buf;
>>> +	volatile struct page_data *page_data_buf = kdump_thread_args->page_data_buf;
>>> +	volatile struct page_flag *page_flag_buf = kdump_thread_args->page_flag_buf;
>>>   	struct cycle *cycle = kdump_thread_args->cycle;
>>> -	int page_data_num = kdump_thread_args->page_data_num;
>>> -	mdf_pfn_t pfn;
>>> -	int index;
>>> +	mdf_pfn_t pfn = cycle->start_pfn;
>>> +	int index = kdump_thread_args->thread_num;
>>>   	int buf_ready;
>>>   	int dumpable;
>>>   	int fd_memory = 0;
>>> @@ -7125,47 +7176,48 @@ kdump_thread_function_cyclic(void *arg) {
>>>   						kdump_thread_args->thread_num);
>>>   	}
>>>
>>> -	while (1) {
>>> -		/* get next pfn */
>>> -		pthread_mutex_lock(&info->current_pfn_mutex);
>>> -		pfn = info->current_pfn;
>>> -		info->current_pfn++;
>>> -		pthread_mutex_unlock(&info->current_pfn_mutex);
>>> -
>>> -		if (pfn >= kdump_thread_args->end_pfn)
>>> -			break;
>>> -
>>> -		index = -1;
>>> +	/*
>>> +	 * filtered page won't take anything
>>> +	 * unfiltered zero page will only take a page_flag_buf
>>> +	 * unfiltered non-zero page will take a page_flag_buf and a page_data_buf
>>> +	 */
>>> +	while (pfn < cycle->end_pfn) {
>>>   		buf_ready = FALSE;
>>>
>>> +		pthread_mutex_lock(&info->page_data_mutex);
>>> +		while (page_data_buf[index].used != FALSE) {
>>> +			index = (index + 1) % info->num_buffers;
>>> +		}
>>> +		page_data_buf[index].used = TRUE;
>>> +		pthread_mutex_unlock(&info->page_data_mutex);
>>> +
>>>   		while (buf_ready == FALSE) {
>>>   			pthread_testcancel();
>>> -
>>> -			index = pfn % page_data_num;
>>> -
>>> -			if (pfn - info->consumed_pfn > info->num_buffers)
>>> -				continue;
>>> -
>>> -			if (page_data_buf[index].ready != 0)
>>> +			if (page_flag_buf->ready == FLAG_READY)
>>>   				continue;
>>>
>>> -			pthread_mutex_lock(&page_data_buf[index].mutex);
>>> -
>>> -			if (page_data_buf[index].ready != 0)
>>> -				goto unlock;
>>> +			/* get next dumpable pfn */
>>> +			pthread_mutex_lock(&info->current_pfn_mutex);
>>> +			for (pfn = info->current_pfn; pfn <= cycle->end_pfn; pfn++) {
>>> +				dumpable = is_dumpable(
>>> +					info->fd_bitmap ? &bitmap_parallel : info->bitmap2,
>>> +					pfn,
>>> +					cycle);
>>> +				if (dumpable)
>>> +					break;
>>> +			}
>>> +			info->current_pfn = pfn + 1;
>>>
>>> -			buf_ready = TRUE;
>>> +			page_flag_buf->pfn = pfn;
>>> +			page_flag_buf->ready = FLAG_FILLING;
>>> +			pthread_mutex_unlock(&info->current_pfn_mutex);
>>>
>>> -			page_data_buf[index].pfn = pfn;
>>> -			page_data_buf[index].ready = 1;
>>>
>>> -			dumpable = is_dumpable(
>>> -				info->fd_bitmap ? &bitmap_parallel : info->bitmap2,
>>> -				pfn,
>>> -				cycle);
>>> -			page_data_buf[index].dumpable = dumpable;
>>> -			if (!dumpable)
>>> -				goto unlock;
>>> +			if (pfn >= cycle->end_pfn) {
>>> +				info->current_pfn = cycle->end_pfn;
>>> +				page_data_buf[index].used = FALSE;
>>> +				break;
>>> +			}
>>>
>>>   			if (!read_pfn_parallel(fd_memory, pfn, buf,
>>>   					       &bitmap_memory_parallel,
>>> @@ -7178,11 +7230,11 @@ kdump_thread_function_cyclic(void *arg) {
>>>
>>>   			if ((info->dump_level & DL_EXCLUDE_ZERO)
>>>   			    && is_zero_page(buf, info->page_size)) {
>>> -				page_data_buf[index].zero = TRUE;
>>> -				goto unlock;
>>> +				page_flag_buf->zero = TRUE;
>>> +				goto next;
>>>   			}
>>>
>>> -			page_data_buf[index].zero = FALSE;
>>> +			page_flag_buf->zero = FALSE;
>>>
>>>   			/*
>>>   			 * Compress the page data.
>>> @@ -7210,6 +7262,7 @@ kdump_thread_function_cyclic(void *arg) {
>>>   				page_data_buf[index].flags =
>>>   							DUMP_DH_COMPRESSED_LZO;
>>>   				page_data_buf[index].size  = size_out;
>>> +
>>>   				memcpy(page_data_buf[index].buf, buf_out, size_out);
>>>   #endif
>>>   #ifdef USESNAPPY
>>> @@ -7232,12 +7285,14 @@ kdump_thread_function_cyclic(void *arg) {
>>>   				page_data_buf[index].size  = info->page_size;
>>>   				memcpy(page_data_buf[index].buf, buf, info->page_size);
>>>   			}
>>> -unlock:
>>> -			pthread_mutex_unlock(&page_data_buf[index].mutex);
>>> +			page_flag_buf->index = index;
>>> +			buf_ready = TRUE;
>>> +next:
>>> +			page_flag_buf->ready = FLAG_READY;
>>> +			page_flag_buf = page_flag_buf->next;
>>>
>>>   		}
>>>   	}
>>> -
>>>   	retval = NULL;
>>>
>>>   fail:
>>> @@ -7265,14 +7320,15 @@ write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
>>>   	struct page_desc pd;
>>>   	struct timeval tv_start;
>>>   	struct timeval last, new;
>>> -	unsigned long long consuming_pfn;
>>>   	pthread_t **threads = NULL;
>>>   	struct thread_args *kdump_thread_args = NULL;
>>>   	void *thread_result;
>>> -	int page_data_num;
>>> +	int page_buf_num;
>>>   	struct page_data *page_data_buf = NULL;
>>>   	int i;
>>>   	int index;
>>> +	int end_count, consuming, check_count;
>>> +	mdf_pfn_t current_pfn, temp_pfn;
>>>
>>>   	if (info->flag_elf_dumpfile)
>>>   		return FALSE;
>>> @@ -7284,13 +7340,6 @@ write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
>>>   		goto out;
>>>   	}
>>>
>>> -	res = pthread_mutex_init(&info->consumed_pfn_mutex, NULL);
>>> -	if (res != 0) {
>>> -		ERRMSG("Can't initialize consumed_pfn_mutex. %s\n",
>>> -				strerror(res));
>>> -		goto out;
>>> -	}
>>> -
>>>   	res = pthread_mutex_init(&info->filter_mutex, NULL);
>>>   	if (res != 0) {
>>>   		ERRMSG("Can't initialize filter_mutex. %s\n", strerror(res));
>>> @@ -7314,36 +7363,22 @@ write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
>>>   	end_pfn   = cycle->end_pfn;
>>>
>>>   	info->current_pfn = start_pfn;
>>> -	info->consumed_pfn = start_pfn - 1;
>>>
>>>   	threads = info->threads;
>>>   	kdump_thread_args = info->kdump_thread_args;
>>>
>>> -	page_data_num = info->num_buffers;
>>> +	page_buf_num = info->num_buffers;
>>>   	page_data_buf = info->page_data_buf;
>>> +	pthread_mutex_init(&info->page_data_mutex, NULL);
>>>
>>> -	for (i = 0; i < page_data_num; i++) {
>>> -		/*
>>> -		 * producer will use pfn in page_data_buf to decide the
>>> -		 * consumed pfn
>>> -		 */
>>> -		page_data_buf[i].pfn = start_pfn - 1;
>>> -		page_data_buf[i].ready = 0;
>>> -		res = pthread_mutex_init(&page_data_buf[i].mutex, NULL);
>>> -		if (res != 0) {
>>> -			ERRMSG("Can't initialize mutex of page_data_buf. %s\n",
>>> -					strerror(res));
>>> -			goto out;
>>> -		}
>>> -	}
>>> +	for (i = 0; i < page_buf_num; i++)
>>> +		page_data_buf[i].used = FALSE;
>>>
>>>   	for (i = 0; i < info->num_threads; i++) {
>>>   		kdump_thread_args[i].thread_num = i;
>>>   		kdump_thread_args[i].len_buf_out = len_buf_out;
>>> -		kdump_thread_args[i].start_pfn = start_pfn;
>>> -		kdump_thread_args[i].end_pfn = end_pfn;
>>> -		kdump_thread_args[i].page_data_num = page_data_num;
>>>   		kdump_thread_args[i].page_data_buf = page_data_buf;
>>> +		kdump_thread_args[i].page_flag_buf = info->page_flag_buf[i];
>>>   		kdump_thread_args[i].cycle = cycle;
>>>
>>>   		res = pthread_create(threads[i], NULL,
>>> @@ -7356,55 +7391,94 @@ write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
>>>   		}
>>>   	}
>>>
>>> -	consuming_pfn = start_pfn;
>>> -	index = -1;
>>> +	end_count = 0;
>>> +	while (1) {
>>> +		consuming = 0;
>>> +		check_count = 0;
>>>
>>> -	gettimeofday(&last, NULL);
>>> +		/*
>>> +		 * The basic idea is producer producing page and consumer writing page.
>>> +		 * Each producer have a page_flag_buf list which is used for storing page's description.
>>> +		 * The size of page_flag_buf is little so it won't take too much memory.
>>> +		 * And all producers will share a page_data_buf array which is used for storing page's compressed data.
>>> +		 * The main thread is the consumer. It will find the next pfn and write it into file.
>>> +		 * The next pfn is smallest pfn in all page_flag_buf.
>>> +		 */
>>> +		gettimeofday(&last, NULL);
>>> +		while (1) {
>>> +			current_pfn = end_pfn;
>>>
>>> -	while (consuming_pfn < end_pfn) {
>>> -		index = consuming_pfn % page_data_num;
>>> +			/*
>>> +			 * page_flag_buf is in circular linked list.
>>> +			 * The array info->page_flag_buf[] records the current page_flag_buf in each thread's
>>> +			 * page_flag_buf list.
>>> +			 * consuming is used for recording in which thread the pfn is the smallest.
>>> +			 * current_pfn is used for recording the value of pfn when checking the pfn.
>>> +			 */
>>> +			for (i = 0; i < info->num_threads; i++) {
>>> +				if (info->page_flag_buf[i]->ready == FLAG_UNUSED)
>>> +					continue;
>>> +				temp_pfn = info->page_flag_buf[i]->pfn;
>>>
>>> -		gettimeofday(&new, NULL);
>>> -		if (new.tv_sec - last.tv_sec > WAIT_TIME) {
>>> -			ERRMSG("Can't get data of pfn %llx.\n", consuming_pfn);
>>> -			goto out;
>>> -		}
>>> +				/*
>>> +				 * count how many threads have reached the end.
>>> +				 */
>>> +				if (temp_pfn >= end_pfn) {
>>> +					info->page_flag_buf[i]->ready = FLAG_UNUSED;
>>> +					end_count++;
>>> +					continue;
>>> +				}
>>>
>>> -		/*
>>> -		 * check pfn first without mutex locked to reduce the time
>>> -		 * trying to lock the mutex
>>> -		 */
>>> -		if (page_data_buf[index].pfn != consuming_pfn)
>>> -			continue;
>>> +				if (current_pfn < temp_pfn)
>>> +					continue;
>>>
>>> -		if (pthread_mutex_trylock(&page_data_buf[index].mutex) != 0)
>>> -			continue;
>>> +				check_count++;
>>> +				consuming = i;
>>> +				current_pfn = temp_pfn;
>>> +			}
>>> +
>>> +			/*
>>> +			 * If all the threads have reached the end, we will finish writing.
>>> +			 */
>>> +			if (end_count >= info->num_threads)
>>> +				goto finish;
>>> +
>>> +			/*
>>> +			 * Since it has the probabilty that there is no page_flag_buf being ready,
>>> +			 * we should recheck if it happens.
>>> +			 */
>>> +			if (check_count == 0)
>>> +				continue;
>>> +
>>> +			/*
>>> +			 * If the page_flag_buf is not ready, the pfn recorded may be changed.
>>> +			 * So we should recheck.
>>> +			 */
>>> +			if (info->page_flag_buf[consuming]->ready != FLAG_READY) {
>>> +				gettimeofday(&new, NULL);
>>> +				if (new.tv_sec - last.tv_sec > WAIT_TIME) {
>>> +					ERRMSG("Can't get data of pfn.\n");
>>> +					goto out;
>>> +				}
>>> +				continue;
>>> +			}
>>>
>>> -		/* check whether the found one is ready to be consumed */
>>> -		if (page_data_buf[index].pfn != consuming_pfn ||
>>> -		    page_data_buf[index].ready != 1) {
>>> -			goto unlock;
>>> +			if (current_pfn == info->page_flag_buf[consuming]->pfn)
>>> +				break;
>>>   		}
>>>
>>>   		if ((num_dumped % per) == 0)
>>>   			print_progress(PROGRESS_COPY, num_dumped, info->num_dumpable);
>>>
>>> -		/* next pfn is found, refresh last here */
>>> -		last = new;
>>> -		consuming_pfn++;
>>> -		info->consumed_pfn++;
>>> -		page_data_buf[index].ready = 0;
>>> -
>>> -		if (page_data_buf[index].dumpable == FALSE)
>>> -			goto unlock;
>>> -
>>>   		num_dumped++;
>>>
>>> -		if (page_data_buf[index].zero == TRUE) {
>>> +
>>> +		if (info->page_flag_buf[consuming]->zero == TRUE) {
>>>   			if (!write_cache(cd_header, pd_zero, sizeof(page_desc_t)))
>>>   				goto out;
>>>   			pfn_zero++;
>>>   		} else {
>>> +			index = info->page_flag_buf[consuming]->index;
>>>   			pd.flags      = page_data_buf[index].flags;
>>>   			pd.size       = page_data_buf[index].size;
>>>   			pd.page_flags = 0;
>>> @@ -7420,12 +7494,12 @@ write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
>>>   			 */
>>>   			if (!write_cache(cd_page, page_data_buf[index].buf, pd.size))
>>>   				goto out;
>>> -
>>> +			page_data_buf[index].used = FALSE;
>>>   		}
>>> -unlock:
>>> -		pthread_mutex_unlock(&page_data_buf[index].mutex);
>>> +		info->page_flag_buf[consuming]->ready = FLAG_UNUSED;
>>> +		info->page_flag_buf[consuming] = info->page_flag_buf[consuming]->next;
>>>   	}
>>> -
>>> +finish:
>>>   	ret = TRUE;
>>>   	/*
>>>   	 * print [100 %]
>>> @@ -7463,15 +7537,8 @@ out:
>>>   		}
>>>   	}
>>>
>>> -	if (page_data_buf != NULL) {
>>> -		for (i = 0; i < page_data_num; i++) {
>>> -			pthread_mutex_destroy(&page_data_buf[i].mutex);
>>> -		}
>>> -	}
>>> -
>>>   	pthread_rwlock_destroy(&info->usemmap_rwlock);
>>>   	pthread_mutex_destroy(&info->filter_mutex);
>>> -	pthread_mutex_destroy(&info->consumed_pfn_mutex);
>>>   	pthread_mutex_destroy(&info->current_pfn_mutex);
>>>
>>>   	return ret;
>>> @@ -7564,6 +7631,7 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
>>>   		num_dumped++;
>>>   		if (!read_pfn(pfn, buf))
>>>   			goto out;
>>> +
>>>   		filter_data_buffer(buf, pfn_to_paddr(pfn), info->page_size);
>>>
>>>   		/*
>>> diff --git a/makedumpfile.h b/makedumpfile.h
>>> index e0b5bbf..5865827 100644
>>> --- a/makedumpfile.h
>>> +++ b/makedumpfile.h
>>> @@ -977,7 +977,7 @@ typedef unsigned long long int ulonglong;
>>>   #define PAGE_DATA_NUM	(50)
>>>   #define WAIT_TIME	(60 * 10)
>>>   #define PTHREAD_FAIL	((void *)-2)
>>> -#define NUM_BUFFERS	(50)
>>> +#define NUM_BUFFERS	(20)
>>>
>>>   struct mmap_cache {
>>>   	char	*mmap_buf;
>>> @@ -985,28 +985,33 @@ struct mmap_cache {
>>>   	off_t   mmap_end_offset;
>>>   };
>>>
>>> +enum {
>>> +	FLAG_UNUSED,
>>> +	FLAG_READY,
>>> +	FLAG_FILLING
>>> +};
>>> +struct page_flag {
>>> +	mdf_pfn_t pfn;
>>> +	char zero;
>>> +	char ready;
>>> +	short index;
>>> +	struct page_flag *next;
>>> +};
>>> +
>>>   struct page_data
>>>   {
>>> -	mdf_pfn_t pfn;
>>> -	int dumpable;
>>> -	int zero;
>>> -	unsigned int flags;
>>>   	long size;
>>>   	unsigned char *buf;
>>> -	pthread_mutex_t mutex;
>>> -	/*
>>> -	 * whether the page_data is ready to be consumed
>>> -	 */
>>> -	int ready;
>>> +	int flags;
>>> +	int used;
>>>   };
>>>
>>>   struct thread_args {
>>>   	int thread_num;
>>>   	unsigned long len_buf_out;
>>> -	mdf_pfn_t start_pfn, end_pfn;
>>> -	int page_data_num;
>>>   	struct cycle *cycle;
>>>   	struct page_data *page_data_buf;
>>> +	struct page_flag *page_flag_buf;
>>>   };
>>>
>>>   /*
>>> @@ -1295,11 +1300,11 @@ struct DumpInfo {
>>>   	pthread_t **threads;
>>>   	struct thread_args *kdump_thread_args;
>>>   	struct page_data *page_data_buf;
>>> +	struct page_flag **page_flag_buf;
>>>   	pthread_rwlock_t usemmap_rwlock;
>>>   	mdf_pfn_t current_pfn;
>>>   	pthread_mutex_t current_pfn_mutex;
>>> -	mdf_pfn_t consumed_pfn;
>>> -	pthread_mutex_t consumed_pfn_mutex;
>>> +	pthread_mutex_t page_data_mutex;
>>>   	pthread_mutex_t filter_mutex;
>>>   };
>>>   extern struct DumpInfo		*info;
>>> --
>>> 1.8.3.1
>>>
>>>
>>>
>>>
>>> _______________________________________________
>>> kexec mailing list
>>> kexec@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/kexec
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
