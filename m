Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga03-in.huawei.com ([119.145.14.66])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cFEBt-0002DT-60
 for kexec@lists.infradead.org; Fri, 09 Dec 2016 05:57:56 +0000
Message-ID: <584A47A2.1040001@huawei.com>
Date: Fri, 9 Dec 2016 13:56:50 +0800
From: zhong jiang <zhongjiang@huawei.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2] kexec: add cond_resched into
 kimage_alloc_crash_control_pages
References: <1481164674-42775-1-git-send-email-zhongjiang@huawei.com>
 <58492ADC.4070305@redhat.com> <584A3D84.6040004@huawei.com>
 <87inqtn0gm.fsf@xmission.com>
In-Reply-To: <87inqtn0gm.fsf@xmission.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Xunlei Pang <xpang@redhat.com>, akpm@linux-foundation.org, xlpang@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On 2016/12/9 13:19, Eric W. Biederman wrote:
> zhong jiang <zhongjiang@huawei.com> writes:
>
>> On 2016/12/8 17:41, Xunlei Pang wrote:
>>> On 12/08/2016 at 10:37 AM, zhongjiang wrote:
>>>> From: zhong jiang <zhongjiang@huawei.com>
>>>>
> [snip]
>>>> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
>>>> index 5616755..bfc9621 100644
>>>> --- a/kernel/kexec_core.c
>>>> +++ b/kernel/kexec_core.c
>>>> @@ -441,6 +441,8 @@ static struct page *kimage_alloc_crash_control_pages(struct kimage *image,
>>>>  	while (hole_end <= crashk_res.end) {
>>>>  		unsigned long i;
>>>>  
>>>> +		cond_resched();
>>>> +
>>> I can't see why it would take a long time to loop inside, the job it does is simply to find a control area
>>> not overlapped with image->segment[], you can see the loop "for (i = 0; i < image->nr_segments; i++)",
>>> @hole_end will be advanced to the end of its next nearby segment once overlap was detected each loop,
>>> also there are limited (<=16) segments, so it won't take long to locate the right area.
>>>
>>> Am I missing something?
>>>
>>> Regards,
>>> Xunlei
>>   if the crashkernel = auto is set in cmdline.  it represent crashk_res.end will exceed to 4G, the first allocate control pages will
>>   loop  million times. if we set crashk_res.end to the higher value
>>   manually,  you can image....
> Or in short the cond_resched is about keeping things reasonable when the
> loop has worst case behavior.
>
> Eric
>
>
  Yes,   Thank you reply and comment.

  Regards,
  zhongjiang


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
