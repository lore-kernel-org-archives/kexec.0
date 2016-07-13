Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga03-in.huawei.com ([119.145.14.66])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bNEJp-000261-51
 for kexec@lists.infradead.org; Wed, 13 Jul 2016 07:10:55 +0000
Message-ID: <5785E8A3.7060109@huawei.com>
Date: Wed, 13 Jul 2016 15:07:15 +0800
From: zhong jiang <zhongjiang@huawei.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] kexec: remove unnecessary unusable_pages
References: <1468299403-27954-1-git-send-email-zhongjiang@huawei.com>
 <87poqi3muo.fsf@x220.int.ebiederm.org> <5785BEA6.2060404@huawei.com>
 <87lh16unw9.fsf@x220.int.ebiederm.org>
In-Reply-To: <87lh16unw9.fsf@x220.int.ebiederm.org>
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
Cc: dyoung@redhat.com, kexec@lists.infradead.org, linux-mm@kvack.org, horms@verge.net.au, akpm@linux-foundation.org, yinghai@kernel.org, vgoyal@redhat.com

On 2016/7/13 13:07, Eric W. Biederman wrote:
> zhong jiang <zhongjiang@huawei.com> writes:
>
>> On 2016/7/12 23:19, Eric W. Biederman wrote:
>>> zhongjiang <zhongjiang@huawei.com> writes:
>>>
>>>> From: zhong jiang <zhongjiang@huawei.com>
>>>>
>>>> In general, kexec alloc pages from buddy system, it cannot exceed
>>>> the physical address in the system.
>>>>
>>>> The patch just remove this unnecessary code, no functional change.
>>> On 32bit systems with highmem support kexec can very easily receive a
>>> page from the buddy allocator that can exceed 4GiB.  This doesn't show
>>> up on 64bit systems as typically the memory limits are less than the
>>> address space.  But this code is very necessary on some systems and
>>> removing it is not ok.
>>>
>>> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
>>>
>>   This viewpoint is as opposed to me,  32bit systems architectural decide it can not
>>   access exceed 4GiB whether the highmem or not.   but there is one exception, 
>>   when PAE enable, its physical address should be extended to 36,  new paging  mechanism
>>   established for it.  therefore, the  page from the buddy allocator
>>   can exceed 4GiB.
> Exactly.  And I was dealing with PAE systems in 2001 or so with > 4GiB
> of RAM.  Which is where the unusable_pages work comes from.
>
> Other architectures such as ARM also followed a similar path, so
> it isn't just x86 that has 32bit systems with > 32 address lines.
>
>>   moreover,  on 32bit systems I can not understand why KEXEC_SOURCE_MEMORY_LIMIT
>>   is defined to -1UL. therefore, kimge_aloc_page allocate page will always add to unusable_pages.
> -1UL is a short way of writing 0xffffffffUL  Which is as close as you
> can get to writing 0x100000000UL in 32bits.
>
> kimage_alloc_page won't always add to unusable_pages as there is memory
> below 4GiB but it isn't easily found so there may temporarily be a
> memory shortage, as it allocates it's way there.  Unfortunately whenever
> I have looked there are memory zones that line up with the memory the
> kexec is looking for.  So it does a little bit of a weird dance to get
> the memory it needs and to discard the memory it can't use.
>
> Eric
>
  Thanks , I get it.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
