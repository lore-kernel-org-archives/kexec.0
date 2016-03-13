Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aezFW-0000Qp-Cp
 for kexec@lists.infradead.org; Sun, 13 Mar 2016 06:11:35 +0000
Subject: Re: [PATCH V2] proc-vmcore: wrong data type casting fix
References: <20160311084248.GA9417@dhcp-128-65.nay.redhat.com>
 <20160311122711.f738d878070641f113dfd348@linux-foundation.org>
 <20160312044934.GA3173@dhcp-128-65.nay.redhat.com>
 <56E40EF7.1050000@redhat.com> <20160312135932.GA3649@x1.redhat.com>
From: Xunlei Pang <xpang@redhat.com>
Message-ID: <56E5047A.6030007@redhat.com>
Date: Sun, 13 Mar 2016 14:11:06 +0800
MIME-Version: 1.0
In-Reply-To: <20160312135932.GA3649@x1.redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: xlpang@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Baoquan He <bhe@redhat.com>, xlpang@redhat.com
Cc: mhuang@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, nasa4836@gmail.com, d.hatayama@jp.fujitsu.com, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, vgoyal@redhat.com

On 2016/03/12 at 21:59, Baoquan He wrote:
> On 03/12/16 at 08:43pm, Xunlei Pang wrote:
>> On 2016/03/12 at 12:49, Dave Young wrote:
>>> Hi, Andrew
>>>
>>> On 03/11/16 at 12:27pm, Andrew Morton wrote:
>>>> On Fri, 11 Mar 2016 16:42:48 +0800 Dave Young <dyoung@redhat.com> wrote:
>>>>
>>>>> On i686 PAE enabled machine the contiguous physical area could be large
>>>>> and it can cause trimming down variables in below calculation in
>>>>> read_vmcore() and mmap_vmcore():
>>>>>
>>>>> 	tsz = min_t(size_t, m->offset + m->size - *fpos, buflen);
>>>>>
>>>>> Then the real size passed down is not correct any more.
>>>>> Suppose m->offset + m->size - *fpos being truncated to 0, buflen >0 then
>>>>> we will get tsz = 0. It is of course not an expected result.
>>>> I don't really understand this.
>>>>
>>>> vmcore.offset if loff_t which is 64-bit
>>>> vmcore.size is long long
>>>> *fpos is loff_t
>>>>
>>>> so the expression should all be done with 64-bit arithmetic anyway.
>>> #define min_t(type, x, y) ({                    \
>>>         type __min1 = (x);                      \
>>>         type __min2 = (y);                      \
>>>         __min1 < __min2 ? __min1: __min2; })
>>>
>>> Here x = m->offset + m->size - *fpos; the expression is done with 64bit
>>> arithmetic, it is true. But x will be cast to size_t then compare x with y
>>> The casting will cause problem.
>>>
>>>> Maybe buflen (size_t) has the wrong type, but the result of the other
>>>> expression should be in-range by the time we come to doing the
>>>> comparison.
>>>>
>>>>> During our tests there are two problems caused by it:
>>>>> 1) read_vmcore will refuse to continue so makedumpfile fails.
>>>>> 2) mmap_vmcore will trigger BUG_ON() in remap_pfn_range().
>>>>>
>>>>> Use unsigned long long in min_t instead so that the variables are not
>>>>> truncated.
>>>>>
>>>>> Signed-off-by: Baoquan He <bhe@redhat.com>
>>>>> Signed-off-by: Dave Young <dyoung@redhat.com>
>>>> I think we'll need a cc:stable here.
>>> Agreed. Do you think I need repost for this?
>>>
>>>>> --- linux-x86.orig/fs/proc/vmcore.c
>>>>> +++ linux-x86/fs/proc/vmcore.c
>>>>> @@ -231,7 +231,9 @@ static ssize_t __read_vmcore(char *buffe
>>>>>  
>>>>>  	list_for_each_entry(m, &vmcore_list, list) {
>>>>>  		if (*fpos < m->offset + m->size) {
>>>>> -			tsz = min_t(size_t, m->offset + m->size - *fpos, buflen);
>>>>> +			tsz = (size_t)min_t(unsigned long long,
>>>>> +					    m->offset + m->size - *fpos,
>>>>> +					    buflen);
>>>> This is rather a mess.  Can we please try to fix this bug by choosing
>>>> appropriate types rather than all the typecasting?
>>> file read/mmap buflen is size_t, so tsz is alwyas less then buflen unless
>>> m->offset + m->size - *fpos < buflen. The only problem is we need avoid large
>>> value of m->offset + m->size - *fpos being casted thus it will mistakenly be
>>> less than buflen.
>> *
>> Can we use "tsz = min(m->offset + m->size - *fpos, buflen)" instead?
>> I think it's ok for this case (both have positive values), nothing will go wrong,
>> also can make the code cleaner.
> We can't. Macro min() has a type checking. min_t is necessary here.


You're right, missed that :-)

Regards,
Xunlei

>
>> *
>>>>>  			start = m->paddr + *fpos - m->offset;
>>>>>  			tmp = read_from_oldmem(buffer, tsz, &start, userbuf);
>>>>>  			if (tmp < 0)
>>>>> @@ -461,7 +463,8 @@ static int mmap_vmcore(struct file *file
>>>>>  		if (start < m->offset + m->size) {
>>>>>  			u64 paddr = 0;
>>>>>  
>>>>> -			tsz = min_t(size_t, m->offset + m->size - start, size);
>>>>> +			tsz = (size_t)min_t(unsigned long long,
>>>>> +					    m->offset + m->size - start, size);
>>>>>  			paddr = m->paddr + start - m->offset;
>>>>>  			if (vmcore_remap_oldmem_pfn(vma, vma->vm_start + len,
>>>>>  						    paddr >> PAGE_SHIFT, tsz,
>>> Thanks
>>> Dave
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
