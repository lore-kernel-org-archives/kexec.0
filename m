Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eqeze-0001LU-7R
 for kexec@lists.infradead.org; Tue, 27 Feb 2018 13:08:32 +0000
Received: by mail-pl0-x244.google.com with SMTP id f23so11322458plr.10
 for <kexec@lists.infradead.org>; Tue, 27 Feb 2018 05:08:19 -0800 (PST)
Subject: Re: [PATCH] makedumpfile: Fix a bug when multi-threads feature meets
 enospace
References: <1517230479-8440-1-git-send-email-zhouwj.fi@gmail.com>
 <3d76898d-66a2-c733-73e0-6aa8e9854179@gmail.com>
 <61D4E5D821F1674CB87C99F080A210BE0117C360@BPXM01GP.gisp.nec.co.jp>
From: Zhou Wenjian <zhouwj.fi@gmail.com>
Message-ID: <30252ca7-b704-2fd1-e3f0-3348f8741004@gmail.com>
Date: Tue, 27 Feb 2018 21:08:03 +0800
MIME-Version: 1.0
In-Reply-To: <61D4E5D821F1674CB87C99F080A210BE0117C360@BPXM01GP.gisp.nec.co.jp>
Content-Language: en-US
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
To: Masaki Tachibana <mas-tachibana@vf.jp.nec.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Cc: Masahiko Hayashi <mas-hayashi@tg.jp.nec.com>

Hi Tachibana,

Thanks for your reply.

And I do appreciate Kumagai-san's help these years.


On 02/16/2018 10:45 AM, Masaki Tachibana wrote:
> Hi,
>
> Atsushi Kumagai has retired, so other members will maintain makedumpfile.
>
>
> Wenjian
>
> Sorry for the late reply.
> Your patch looks good to me.
> I'll merge it into V1.6.4.
>
> Thanks
> tachibana
>
>
>> -----Original Message-----
>> From: kexec [mailto:kexec-bounces@lists.infradead.org] On Behalf Of Zhou Wenjian
>> Sent: Thursday, February 08, 2018 8:53 PM
>> To: kexec@lists.infradead.org
>> Cc: Kumagai Atsushi() <ats-kumagai@wm.jp.nec.com>; Suzuki Keiichirou() <kei-suzuki@xr.jp.nec.com>
>> Subject: Re: [PATCH] makedumpfile: Fix a bug when multi-threads feature meets enospace
>>
>> ping...
>>
>>
>> On 01/29/2018 08:54 PM, Zhou Wenjian wrote:
>>> Currently, when multi-threads feature meets enospace error,
>>> the main thread will call pthread_join(). However, there is one
>>> thread doing while{} and won't stop.
>>>
>>>                   pthread_mutex_lock(&info->page_data_mutex);
>>>                   while (page_data_buf[index].used != FALSE) {
>>>                           index = (index + 1) % info->num_buffers;
>>>                   }
>>>                   page_data_buf[index].used = TRUE;
>>>                   pthread_mutex_unlock(&info->page_data_mutex);
>>>
>>> Then makedumpfile hangs.
>>>
>>> This patch add a cancel point in while{}.
>>>
>>> Signed-off-by: Zhou Wenjian <zhouwj.fi@gmail.com>
>>> ---
>>>    makedumpfile.c | 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/makedumpfile.c b/makedumpfile.c
>>> index ed138d3..f7ad50c 100644
>>> --- a/makedumpfile.c
>>> +++ b/makedumpfile.c
>>> @@ -7731,11 +7731,13 @@ kdump_thread_function_cyclic(void *arg) {
>>>    		buf_ready = FALSE;
>>>
>>>    		pthread_mutex_lock(&info->page_data_mutex);
>>> +		pthread_cleanup_push(pthread_mutex_unlock, &info->page_data_mutex);
>>>    		while (page_data_buf[index].used != FALSE) {
>>> +			pthread_testcancel();
>>>    			index = (index + 1) % info->num_buffers;
>>>    		}
>>>    		page_data_buf[index].used = TRUE;
>>> -		pthread_mutex_unlock(&info->page_data_mutex);
>>> +		pthread_cleanup_pop(1);
>>>
>>>    		while (buf_ready == FALSE) {
>>>    			pthread_testcancel();
>> --
>> Thanks
>> Zhou
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>

-- 
Thanks
Zhou


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
