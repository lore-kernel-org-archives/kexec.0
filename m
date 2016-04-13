Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aq8ra-0007z3-Js
 for kexec@lists.infradead.org; Wed, 13 Apr 2016 00:41:00 +0000
Message-ID: <570D951D.3080703@cn.fujitsu.com>
Date: Wed, 13 Apr 2016 08:38:53 +0800
From: =?gbk?Q?=22Zhou=2C_Wenjian/=D6=DC=CE=C4=BD=A3=22?=
 <zhouwj-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH V5] Improve the performance of --num-threads -d 31
References: <1460103601-5418-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <570C68B5.2000605@cn.fujitsu.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E39AA0@BPXM01GP.gisp.nec.co.jp>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701E39AA0@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On 04/12/2016 04:25 PM, Atsushi Kumagai wrote:
> Hello Zhou,
>
>> Hello Atsushi and Minfei,
>>
>> How about this version?
>
> Thanks for making v5 patch.
> I agree with the concept, but I have comments.
>
>>> @@ -10223,6 +10281,20 @@ calculate_cyclic_buffer_size(void) {
>>>    	 *  free memory for safety.
>>>    	 */
>>>    	limit_size = get_free_memory_size() * 0.6;
>>> +
>>> +	/*
>>> +	 * Recalculate the limit_size according to num_threads.
>>> +	 * And reset num_threads if there is not enough memory.
>>> +	 */
>>> +	if (limit_size < MAP_REGION * info->num_threads) {
>>> +		MSG("There isn't enough memory for %d threads.\n", info->num_threads);
>
> You assume only MAP_REGION is the extra memory consumption for multi thread.
> However, there are other stuff allocated in each thread, e.g. BUF_PARALLEL(i)
> and the buffer for compression calculated by calculate_len_buf_out().
>
> Shouldn't we consider them ?
>

Yes.
Previously, I thought we don't need the accurate value.
But now I think it will lead to some failures sometime.

>>> +
>>> +		info->num_threads = MIN(info->num_threads % 2, limit_size % MAP_REGION);
>>> +		MSG("--num_threads is set to %d.\n", info->num_threads);
>
> What does "info->num_threads % 2" mean ?
>

Something I thought is wrong. I will remove it.

>>> +	}
>>> +
>>> +	limit_size = limit_size - MAP_REGION * info->num_threads;
>>> +
>
> This patch prioritizes the memory for multi thread since it is reserved first,
> but I think enough cyclic buffer should be reserved first because it's for more
> fundamental feature than multi-threading.
>

I'm not sure what is the proper value of cyclic buffer size.
Should we leave 4MB for it?
Or calculate according to the bitmap_size?

-- 
Thanks
Zhou
>
> Thanks,
> Atsushi Kumagai
>
>>>    	/* Try to keep both 1st and 2nd bitmap at the same time. */
>>>    	bitmap_size = info->max_mapnr * 2 / BITPERBYTE;
>>>
>>> diff --git a/makedumpfile.h b/makedumpfile.h
>>> index e0b5bbf..4b315c0 100644
>>> --- a/makedumpfile.h
>>> +++ b/makedumpfile.h
>>> @@ -44,6 +44,7 @@
>>>    #include "print_info.h"
>>>    #include "sadump_mod.h"
>>>    #include <pthread.h>
>>> +#include <semaphore.h>
>>>
>>>    /*
>>>     * Result of command
>>> @@ -977,7 +978,7 @@ typedef unsigned long long int ulonglong;
>>>    #define PAGE_DATA_NUM	(50)
>>>    #define WAIT_TIME	(60 * 10)
>>>    #define PTHREAD_FAIL	((void *)-2)
>>> -#define NUM_BUFFERS	(50)
>>> +#define NUM_BUFFERS	(20)
>>>
>>>    struct mmap_cache {
>>>    	char	*mmap_buf;
>>> @@ -985,28 +986,33 @@ struct mmap_cache {
>>>    	off_t   mmap_end_offset;
>>>    };
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
>>>    struct page_data
>>>    {
>>> -	mdf_pfn_t pfn;
>>> -	int dumpable;
>>> -	int zero;
>>> -	unsigned int flags;
>>>    	long size;
>>>    	unsigned char *buf;
>>> -	pthread_mutex_t mutex;
>>> -	/*
>>> -	 * whether the page_data is ready to be consumed
>>> -	 */
>>> -	int ready;
>>> +	int flags;
>>> +	int used;
>>>    };
>>>
>>>    struct thread_args {
>>>    	int thread_num;
>>>    	unsigned long len_buf_out;
>>> -	mdf_pfn_t start_pfn, end_pfn;
>>> -	int page_data_num;
>>>    	struct cycle *cycle;
>>>    	struct page_data *page_data_buf;
>>> +	struct page_flag *page_flag_buf;
>>>    };
>>>
>>>    /*
>>> @@ -1295,11 +1301,12 @@ struct DumpInfo {
>>>    	pthread_t **threads;
>>>    	struct thread_args *kdump_thread_args;
>>>    	struct page_data *page_data_buf;
>>> +	struct page_flag **page_flag_buf;
>>> +	sem_t page_flag_buf_sem;
>>>    	pthread_rwlock_t usemmap_rwlock;
>>>    	mdf_pfn_t current_pfn;
>>>    	pthread_mutex_t current_pfn_mutex;
>>> -	mdf_pfn_t consumed_pfn;
>>> -	pthread_mutex_t consumed_pfn_mutex;
>>> +	pthread_mutex_t page_data_mutex;
>>>    	pthread_mutex_t filter_mutex;
>>>    };
>>>    extern struct DumpInfo		*info;
>>>
>>
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
