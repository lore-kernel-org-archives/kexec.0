Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from flmx07.ccur.com ([12.192.68.12])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1NB8nq-0003N2-0H
	for kexec@lists.infradead.org; Thu, 19 Nov 2009 15:20:14 +0000
Message-ID: <4B056230.6000006@ccur.com>
Date: Thu, 19 Nov 2009 09:20:16 -0600
From: John Blackwood <john.blackwood@ccur.com>
MIME-Version: 1.0
Subject: Re: Kdump issue with percpu_alloc=lpage
References: <4AE8B612.9080103@ccur.com> <4B03BD7A.9040500@kernel.org>
	<20091119143343.GB8741@redhat.com> <4B055A05.2010205@kernel.org>
	<20091119150512.GC8741@redhat.com>
In-Reply-To: <20091119150512.GC8741@redhat.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Vivek Goyal wrote:
> On Thu, Nov 19, 2009 at 11:45:25PM +0900, Tejun Heo wrote:
>> Hello,
>>
>> 11/19/2009 11:33 PM, Vivek Goyal wrote:
>>> I did load a kdump kernel on 32-rc7 and it worked fine. But I guess in
>>> this case memory might have come from linearly mapped region.
>>>
>>> If the default per cpu allocator can get memory from vmalloc region
>>> also, then I think we will need this function which can map virtual
>>> address to physical address.
>> I see.
>>
>>> Are there multiple allocators now? If yes, what are the command line
>>> options and I can try to use some other allocator and see if I can force
>>> the condition where memory comes from vmalloc region and I observe the
>>> crash.
>>>
>>> Once I can reproduce it, I can also send you the fix you suggested.
>> Now there are two allocators - embed (default) and page.  You can
>> choose using percpu_alloc= parameter.  Embed allocator will put the
>> first chunk in linear mapping area while page will put the first chunk
>> in vmalloc area too but regardless of the allocator from the second
>> chunk it will always be in the vmalloc area.  So, either using
>> percpu_alloc=page or allocating some amount of percpu memory using
>> __alloc_percpu() - a thousand 4k blocks will always be enough - should
>> do it.
> 
> Looks like with percpu_alloc=page, I am getting bogus physical addresses in
> /sys/devices/system/cpu<N>/crash_notes.
> 
> With percpu_alloc=page
> 
> cpu0 60fffff49800
> cpu1 60fffff60800
> cpu2 60fffff77800
> 
> with percpu_alloc=embed
> 
> cpu0 28219800
> cpu1 28259800
> cpu2 28299800
> 
> I got 4G of RAM in my box. "embed" seems to be fine.

That sounds right to me.  In previous kernels, 'embed' was o.k. also.

Thanks for looking into this Vivek.
I've been too busy right now to try this out.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
