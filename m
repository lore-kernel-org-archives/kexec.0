Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aqFtH-0004yA-MG
 for kexec@lists.infradead.org; Wed, 13 Apr 2016 08:11:12 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH V5] Improve the performance of --num-threads -d 31
Date: Wed, 13 Apr 2016 08:07:43 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E3A0AF@BPXM01GP.gisp.nec.co.jp>
References: <1460103601-5418-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <570C68B5.2000605@cn.fujitsu.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E39AA0@BPXM01GP.gisp.nec.co.jp>
 <570D951D.3080703@cn.fujitsu.com>
In-Reply-To: <570D951D.3080703@cn.fujitsu.com>
Content-Language: ja-JP
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
To: =?gb2312?B?Ilpob3UsIFdlbmppYW4v1tzOxL2jIg==?= <zhouwj-fnst@cn.fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>>>> +	}
>>>> +
>>>> +	limit_size = limit_size - MAP_REGION * info->num_threads;
>>>> +
>>
>> This patch prioritizes the memory for multi thread since it is reserved first,
>> but I think enough cyclic buffer should be reserved first because it's for more
>> fundamental feature than multi-threading.
>>
>
>I'm not sure what is the proper value of cyclic buffer size.
>Should we leave 4MB for it?
>Or calculate according to the bitmap_size?

In commit:0b7328280, we decided 4MB is enough, please leave it.

BTW, mmap() in 2nd kernel doesn't consume MAP_REGION(4MB) of physical memory
since the target region is mapped directly to the old memory(/proc/vmcore).
If 4MB region is mapped, 8KB of page table for the region will be created,
*this* is the memory footprint of mmap().

OTOH, mmap() in 1st kernel will consume physical memory to copy file data
from disk to memory by page fault. However, 1st kernel environment must have
enough free memory, we don't need to worry too much about it.

So now I don't think MAP_REGION should be considered as memory footprint.
How about you ?


Thanks,
Atsushi Kumagai

>--
>Thanks
>Zhou
>>
>> Thanks,
>> Atsushi Kumagai
>>
>>>>    	/* Try to keep both 1st and 2nd bitmap at the same time. */
>>>>    	bitmap_size = info->max_mapnr * 2 / BITPERBYTE;
>>>>
>>>> diff --git a/makedumpfile.h b/makedumpfile.h
>>>> index e0b5bbf..4b315c0 100644
>>>> --- a/makedumpfile.h
>>>> +++ b/makedumpfile.h
>>>> @@ -44,6 +44,7 @@
>>>>    #include "print_info.h"
>>>>    #include "sadump_mod.h"
>>>>    #include <pthread.h>
>>>> +#include <semaphore.h>
>>>>
>>>>    /*
>>>>     * Result of command
>>>> @@ -977,7 +978,7 @@ typedef unsigned long long int ulonglong;
>>>>    #define PAGE_DATA_NUM	(50)
>>>>    #define WAIT_TIME	(60 * 10)
>>>>    #define PTHREAD_FAIL	((void *)-2)
>>>> -#define NUM_BUFFERS	(50)
>>>> +#define NUM_BUFFERS	(20)
>>>>
>>>>    struct mmap_cache {
>>>>    	char	*mmap_buf;
>>>> @@ -985,28 +986,33 @@ struct mmap_cache {
>>>>    	off_t   mmap_end_offset;
>>>>    };
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
>>>>    struct page_data
>>>>    {
>>>> -	mdf_pfn_t pfn;
>>>> -	int dumpable;
>>>> -	int zero;
>>>> -	unsigned int flags;
>>>>    	long size;
>>>>    	unsigned char *buf;
>>>> -	pthread_mutex_t mutex;
>>>> -	/*
>>>> -	 * whether the page_data is ready to be consumed
>>>> -	 */
>>>> -	int ready;
>>>> +	int flags;
>>>> +	int used;
>>>>    };
>>>>
>>>>    struct thread_args {
>>>>    	int thread_num;
>>>>    	unsigned long len_buf_out;
>>>> -	mdf_pfn_t start_pfn, end_pfn;
>>>> -	int page_data_num;
>>>>    	struct cycle *cycle;
>>>>    	struct page_data *page_data_buf;
>>>> +	struct page_flag *page_flag_buf;
>>>>    };
>>>>
>>>>    /*
>>>> @@ -1295,11 +1301,12 @@ struct DumpInfo {
>>>>    	pthread_t **threads;
>>>>    	struct thread_args *kdump_thread_args;
>>>>    	struct page_data *page_data_buf;
>>>> +	struct page_flag **page_flag_buf;
>>>> +	sem_t page_flag_buf_sem;
>>>>    	pthread_rwlock_t usemmap_rwlock;
>>>>    	mdf_pfn_t current_pfn;
>>>>    	pthread_mutex_t current_pfn_mutex;
>>>> -	mdf_pfn_t consumed_pfn;
>>>> -	pthread_mutex_t consumed_pfn_mutex;
>>>> +	pthread_mutex_t page_data_mutex;
>>>>    	pthread_mutex_t filter_mutex;
>>>>    };
>>>>    extern struct DumpInfo		*info;
>>>>
>>>
>>>
>>>
>>> _______________________________________________
>>> kexec mailing list
>>> kexec@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/kexec
>
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
