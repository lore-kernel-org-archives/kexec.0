Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aaxC4-00070f-Dk
 for kexec@lists.infradead.org; Wed, 02 Mar 2016 03:11:23 +0000
From: Minoru Usui <min-usui@ti.jp.nec.com>
Subject: Re: [PATCH v2] Improve the performance of --num-threads -d 31
Date: Wed, 2 Mar 2016 03:05:55 +0000
Message-ID: <BE691E4CBA06214BB0FA8EEFC7C61A4D0181914F@BPXM02GP.gisp.nec.co.jp>
References: <1455692739-14878-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <BE691E4CBA06214BB0FA8EEFC7C61A4D0180CCEE@BPXM02GP.gisp.nec.co.jp>
 <56CBD5D1.5060407@cn.fujitsu.com>
 <BE691E4CBA06214BB0FA8EEFC7C61A4D0180D50E@BPXM02GP.gisp.nec.co.jp>
 <56CC187F.3000300@cn.fujitsu.com>
 <BE691E4CBA06214BB0FA8EEFC7C61A4D0180E77E@BPXM02GP.gisp.nec.co.jp>
 <56D5499E.10809@cn.fujitsu.com>
In-Reply-To: <56D5499E.10809@cn.fujitsu.com>
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
To: =?iso-2022-jp?B?Ilpob3UsIFdlbmppYW4vGyRCPH5KOBsoQj8i?= <zhouwj-fnst@cn.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hi, Zhou

> >>>>> ===
> >>>>>      producer                   Consumer
> >>>>> ---------------------------------------------------------
> >>>>>      pthread_mutex_lock()
> >>>>>      pfn = info->current_pfn
> >>>>>                                 info->current_pfn = end_pfn
> >>>>>      info->current_pfn++
> >>>>>        -> end_pfn + 1
> >>>>>      pthread_mutex_unlock()
> >>>>> ===
> 
> How about just changing "info->current_pfn = end_pfn" to "info->current_pfn--" ?
> Just like the first version of the patch.

If you don't get mutex lock in consumer side, this change is meaningless.
Of course, info->current_pfn may equal to end_pfn at the end of the cycle,
but there is a timing that info->current_pfn is bigger than end_pfn in processing producer thread.

The root cause is producer increments info->current_pfn everytime, even if info->current_pfn == end_pfn 
in following code.

===
>>>> +			/* get next pfn */
>>>> +			pthread_mutex_lock(&info->current_pfn_mutex);
>>>> +			pfn = info->current_pfn;
>>>> +			info->current_pfn++;                        # increment everytime
>>>> +			page_flag_buf->ready = FLAG_FILLING;
>>>> +			pthread_mutex_unlock(&info->current_pfn_mutex);
>>>>
>>>> -			buf_ready = TRUE;
>>>> +			page_flag_buf->pfn = pfn;
>>>>
>>>> -			page_data_buf[index].pfn = pfn;
>>>> -			page_data_buf[index].ready = 1;
>>>> +			if (pfn >= kdump_thread_args->end_pfn) {
>>>> +				page_data_buf[index].used = FALSE;
>>>> +				page_flag_buf->ready = FLAG_READY;
>>>> +				break;                             # not decrement
>>>> +			}
===

If you don't allow info->current_pfn is bigger than end_pfn,
you don't need to increment info->current_pfn when pfn >= kdump_thread_args->end_pfn like following.

===
                        /* get next pfn */
                        pthread_mutex_lock(&info->current_pfn_mutex);
                        pfn = info->current_pfn;
                        page_flag_buf->pfn = pfn;
                        if (pfn >= kdump_thread_args->end_pfn) {
                                page_data_buf[index].used = FALSE;
                                page_flag_buf->ready = FLAG_READY;
                                pthread_mutex_unlock(&info->current_pfn_mutex);
                                break;
                        }
                        page_flag_buf->ready = FLAG_FILLING;
                        info->current_pfn++;
                        pthread_mutex_unlock(&info->current_pfn_mutex);
===

If you allow info->current_pfn is bigger than end_pfn, producer doesn't need to change info->current_pfn.

---
Thanks
Minoru Usui

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
