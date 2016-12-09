Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cFDeL-0005rI-Cl
 for kexec@lists.infradead.org; Fri, 09 Dec 2016 05:23:14 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1481164674-42775-1-git-send-email-zhongjiang@huawei.com>
 <58492ADC.4070305@redhat.com> <584A3D84.6040004@huawei.com>
Date: Fri, 09 Dec 2016 18:19:37 +1300
In-Reply-To: <584A3D84.6040004@huawei.com> (zhong jiang's message of "Fri, 9
 Dec 2016 13:13:40 +0800")
Message-ID: <87inqtn0gm.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2] kexec: add cond_resched into
 kimage_alloc_crash_control_pages
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
To: zhong jiang <zhongjiang@huawei.com>
Cc: Xunlei Pang <xpang@redhat.com>, akpm@linux-foundation.org, xlpang@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

zhong jiang <zhongjiang@huawei.com> writes:

> On 2016/12/8 17:41, Xunlei Pang wrote:
>> On 12/08/2016 at 10:37 AM, zhongjiang wrote:
>>> From: zhong jiang <zhongjiang@huawei.com>
>>>
[snip]
>>> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
>>> index 5616755..bfc9621 100644
>>> --- a/kernel/kexec_core.c
>>> +++ b/kernel/kexec_core.c
>>> @@ -441,6 +441,8 @@ static struct page *kimage_alloc_crash_control_pages(struct kimage *image,
>>>  	while (hole_end <= crashk_res.end) {
>>>  		unsigned long i;
>>>  
>>> +		cond_resched();
>>> +
>> I can't see why it would take a long time to loop inside, the job it does is simply to find a control area
>> not overlapped with image->segment[], you can see the loop "for (i = 0; i < image->nr_segments; i++)",
>> @hole_end will be advanced to the end of its next nearby segment once overlap was detected each loop,
>> also there are limited (<=16) segments, so it won't take long to locate the right area.
>>
>> Am I missing something?
>>
>> Regards,
>> Xunlei
>   if the crashkernel = auto is set in cmdline.  it represent crashk_res.end will exceed to 4G, the first allocate control pages will
>   loop  million times. if we set crashk_res.end to the higher value
>   manually,  you can image....

Or in short the cond_resched is about keeping things reasonable when the
loop has worst case behavior.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
