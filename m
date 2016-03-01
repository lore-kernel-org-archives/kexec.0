Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aaf5j-0002R9-5Y
 for kexec@lists.infradead.org; Tue, 01 Mar 2016 07:51:36 +0000
Message-ID: <56D5499E.10809@cn.fujitsu.com>
Date: Tue, 1 Mar 2016 15:49:50 +0800
From: =?ISO-2022-JP?B?Ilpob3UsIFdlbmppYW4vGyRCPH5KOBsoQj8i?=
 <zhouwj-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2] Improve the performance of --num-threads -d 31
References: <1455692739-14878-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <BE691E4CBA06214BB0FA8EEFC7C61A4D0180CCEE@BPXM02GP.gisp.nec.co.jp>
 <56CBD5D1.5060407@cn.fujitsu.com>
 <BE691E4CBA06214BB0FA8EEFC7C61A4D0180D50E@BPXM02GP.gisp.nec.co.jp>
 <56CC187F.3000300@cn.fujitsu.com>
 <BE691E4CBA06214BB0FA8EEFC7C61A4D0180E77E@BPXM02GP.gisp.nec.co.jp>
In-Reply-To: <BE691E4CBA06214BB0FA8EEFC7C61A4D0180E77E@BPXM02GP.gisp.nec.co.jp>
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
To: Minoru Usui <min-usui@ti.jp.nec.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hi,

On 02/24/2016 08:45 AM, Minoru Usui wrote:
>>>>>>
>>>>>> -		/*
>>>>>> -		 * check pfn first without mutex locked to reduce the time
>>>>>> -		 * trying to lock the mutex
>>>>>> -		 */
>>>>>> -		if (page_data_buf[index].pfn != consuming_pfn)
>>>>>> -			continue;
>>>>>> +					info->page_flag_buf[i]->ready = FLAG_UNUSED;
>>>>>>
>>>>>> -		if (pthread_mutex_trylock(&page_data_buf[index].mutex) != 0)
>>>>>> -			continue;
>>>>>> +					info->current_pfn = end_pfn;
>>>>>
>>>>> This part doesn't get info->current_pfn_mutex.
>>>>> It becomes bigger than end_pfn at the end of producer thread in following case.
>>>>>
>>>>> ===
>>>>>      producer                   Consumer
>>>>> ---------------------------------------------------------
>>>>>      pthread_mutex_lock()
>>>>>      pfn = info->current_pfn
>>>>>                                 info->current_pfn = end_pfn
>>>>>      info->current_pfn++
>>>>>        -> end_pfn + 1
>>>>>      pthread_mutex_unlock()
>>>>> ===
>>>>>
>>>>> But I know, if this race is happened, processing other producer thread and consumer thread works well
>>>>> in current cycle.
>>>>> Because each thread checks whether info->current_pfn >= end_pfn.
>>>>>
>>>>> On the other hand, info->current_pfn is initialized to cycle->start_pfn before pthread_create()
>>>>> in write_kdump_pages_parallel_cyclic().
>>>>> This means it does not cause a problem in next cycle, too.
>>>>>
>>>>> In other words, my point is following.
>>>>>
>>>>>      a) When info->current_pfn changes, you have to get info->current_pfn_mutex.
>>>>>      b) If you allow info->current_pfn is bigger than end_pfn at the end of each cycle,
>>>>>         "info->current_pfn = end_pfn;" is unnecessary.
>>>>>
>>>>> Honestly, I don't like approach b).
>>>>
>>>> You're right. Some thing I thought is wrong.
>>>> But I don't like lock if I have other choice.
>>>> I will set info->current_pfn before returning.
>>>> How about it?
>>>
>>> If you mean you set info->current_pfn by producer side,
>>> this race will occur between producer A and producer B.
>>>
>>> I think you can't avoid getting mutex lock, if you will change info->current_pfn.
>>>
>>
>> I mean setting it by consumer.
> 
> I'm sorry, I can't imagine your proposal.
> What do you change?
> 
> Please show me the code.
> 

At that time, I meant setting the current_pfn at the end of the function
write_kdump_pages_parallel_cyclic().
But I don't think it is good choice now.

>>>>> ===
>>>>>      producer                   Consumer
>>>>> ---------------------------------------------------------
>>>>>      pthread_mutex_lock()
>>>>>      pfn = info->current_pfn
>>>>>                                 info->current_pfn = end_pfn
>>>>>      info->current_pfn++
>>>>>        -> end_pfn + 1
>>>>>      pthread_mutex_unlock()
>>>>> ===

How about just changing "info->current_pfn = end_pfn" to "info->current_pfn--" ?
Just like the first version of the patch.

-- 
Thanks
Zhou



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
