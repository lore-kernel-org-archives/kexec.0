Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aaxyZ-0003nS-0H
 for kexec@lists.infradead.org; Wed, 02 Mar 2016 04:01:27 +0000
Message-ID: <56D6651D.2050705@cn.fujitsu.com>
Date: Wed, 2 Mar 2016 11:59:25 +0800
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
 <56D5499E.10809@cn.fujitsu.com>
 <BE691E4CBA06214BB0FA8EEFC7C61A4D0181914F@BPXM02GP.gisp.nec.co.jp>
In-Reply-To: <BE691E4CBA06214BB0FA8EEFC7C61A4D0181914F@BPXM02GP.gisp.nec.co.jp>
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

On 03/02/2016 11:05 AM, Minoru Usui wrote:
> Hi, Zhou
> 
>>>>>>> ===
>>>>>>>       producer                   Consumer
>>>>>>> ---------------------------------------------------------
>>>>>>>       pthread_mutex_lock()
>>>>>>>       pfn = info->current_pfn
>>>>>>>                                  info->current_pfn = end_pfn
>>>>>>>       info->current_pfn++
>>>>>>>         -> end_pfn + 1
>>>>>>>       pthread_mutex_unlock()
>>>>>>> ===
>>
>> How about just changing "info->current_pfn = end_pfn" to "info->current_pfn--" ?
>> Just like the first version of the patch.
> 
> If you don't get mutex lock in consumer side, this change is meaningless.
> Of course, info->current_pfn may equal to end_pfn at the end of the cycle,
> but there is a timing that info->current_pfn is bigger than end_pfn in processing producer thread.
> 
> The root cause is producer increments info->current_pfn everytime, even if info->current_pfn == end_pfn
> in following code.
> 

Actually, I didn't get what you mean exactly until this letter...

I think there is no problem if the info->current_pfn is larger than the end_pfn
in the function write_kdump_pages_parallel_cyclic(), for no other one will use
current_pfn here.
Since we can't and needn't prevent using info->current_pfn outside the function,
we should keep info->current_pfn correct before returning from the function.

> ===
>>>>> +			/* get next pfn */
>>>>> +			pthread_mutex_lock(&info->current_pfn_mutex);
>>>>> +			pfn = info->current_pfn;
>>>>> +			info->current_pfn++;                        # increment everytime
>>>>> +			page_flag_buf->ready = FLAG_FILLING;
>>>>> +			pthread_mutex_unlock(&info->current_pfn_mutex);
>>>>>
>>>>> -			buf_ready = TRUE;
>>>>> +			page_flag_buf->pfn = pfn;
>>>>>
>>>>> -			page_data_buf[index].pfn = pfn;
>>>>> -			page_data_buf[index].ready = 1;
>>>>> +			if (pfn >= kdump_thread_args->end_pfn) {
>>>>> +				page_data_buf[index].used = FALSE;
>>>>> +				page_flag_buf->ready = FLAG_READY;
>>>>> +				break;                             # not decrement
>>>>> +			}
> ===
> 
> If you don't allow info->current_pfn is bigger than end_pfn,
> you don't need to increment info->current_pfn when pfn >= kdump_thread_args->end_pfn like following.
> 
> ===
>                          /* get next pfn */
>                          pthread_mutex_lock(&info->current_pfn_mutex);
>                          pfn = info->current_pfn;
>                          page_flag_buf->pfn = pfn;
>                          if (pfn >= kdump_thread_args->end_pfn) {
>                                  page_data_buf[index].used = FALSE;
>                                  page_flag_buf->ready = FLAG_READY;
>                                  pthread_mutex_unlock(&info->current_pfn_mutex);
>                                  break;
>                          }
>                          page_flag_buf->ready = FLAG_FILLING;
>                          info->current_pfn++;
>                          pthread_mutex_unlock(&info->current_pfn_mutex);
> ===
> 
> If you allow info->current_pfn is bigger than end_pfn, producer doesn't need to change info->current_pfn.
> 

I also have thought about it.
It can keep current_pfn never larger than the end.
But it also makes the code a bit more complex.
If there aren't any special reason, I don't think it's worth to do it.

-- 
Thanks
Zhou



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
