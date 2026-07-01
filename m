Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A07C43458
	for <kexec@archiver.kernel.org>; Wed,  1 Jul 2026 11:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ieMgPSS1eIBfAPTWcoeMePMwN2vKLGAwkXUol+yS3JM=; b=c4t1rYEfg7SysdyjSCYcmPV9fL
	vM5VZIHcWxSMjo4e4Dmj7dyPnwTmnOll90wzdIcyayKKQGkijKMXr7c4UFc+meNi18qZG1QHrc07l
	dMHk0Hm19XW7xO2qarwaOzCzOmv0VzhgbFXxs5fNBweDMHfO+dvuYe6sjr7vKE2PPTqH+UbJy6eqk
	5562q7b1MSjdjNTAXLohscmc++NnywcGJvUDs6WLxGGlgv51O7Vjm5swuYQv7GRxpcqG9gEV95hQa
	e3Pf/OdiYwtrzhiOdYfbyvuhjp74KCzpgohfe3YjmdIh5HtTw8HN4fUt1YKi7g2nbeF70AebEL8HL
	JrKTIefw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weso5-00000001QSk-241B;
	Wed, 01 Jul 2026 11:08:41 +0000
Received: from out-170.mta0.migadu.com ([91.218.175.170])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weso1-00000001QRM-2iqN
	for kexec@lists.infradead.org;
	Wed, 01 Jul 2026 11:08:39 +0000
Message-ID: <0efcc0a9-a51d-4de8-8406-b8fa536a91b7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782904099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ieMgPSS1eIBfAPTWcoeMePMwN2vKLGAwkXUol+yS3JM=;
	b=QRnvYhKi7ifn2CAOqwrrTALRRhFuKdBNRY4USBSzQESgxOH79yyPbWsw+wvjxJGm9pDQu3
	75wHltVABewcdEultw97xVO9Srux+vxmHLrM1y3qkyY8Qi8RlcbW/19L2d+jmEkSOqKAw5
	8d3ZpLHm3o4fEt3mWUbZ+Ie+mvfoBxk=
Date: Wed, 1 Jul 2026 19:07:22 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/7] list: Add mutable iterator variants
To: Jani Nikula <jani.nikula@linux.intel.com>,
 David Laight <david.laight.linux@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Tejun Heo <tj@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Paul Moore <paul@paul-moore.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, David Howells <dhowells@redhat.com>,
 Simona Vetter <simona.vetter@ffwll.ch>, Randy Dunlap
 <rdunlap@infradead.org>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Philipp Stanner <phasta@kernel.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-ntfs-dev@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, audit@vger.kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kexec@lists.infradead.org, live-patching@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-pm@vger.kernel.org, rcu@vger.kernel.org, sched-ext@lists.linux.dev,
 linux-mm@kvack.org, virtualization@lists.linux.dev, damon@lists.linux.dev,
 llvm@lists.linux.dev, Kaitao Cheng <chengkaitao@kylinos.cn>,
 Muchun Song <muchun.song@linux.dev>
References: <20260622040533.29824-1-kaitao.cheng@linux.dev>
 <20260622040533.29824-2-kaitao.cheng@linux.dev>
 <20260622094242.64531b9a@pumpkin>
 <351a6b67-b394-4c58-aee2-88b6c8089ad5@linux.dev>
 <cf8467c7-b98f-44a5-9cf9-60b43b5da711@amd.com>
 <20260624152324.3def88ce@pumpkin>
 <0ed6b5c3-e955-46e2-9fc6-075a0dfd1c4f@linux.dev>
 <734f66ca51485ee3ec9788c0eaaead681e00664b@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kaitao Cheng <kaitao.cheng@linux.dev>
In-Reply-To: <734f66ca51485ee3ec9788c0eaaead681e00664b@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260701_040837_890669_7A8A915A 
X-CRM114-Status: GOOD (  41.74  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

在 2026/6/25 19:00, Jani Nikula 写道:
> On Thu, 25 Jun 2026, Kaitao Cheng <kaitao.cheng@linux.dev> wrote:
>> 在 2026/6/24 22:23, David Laight 写道:
>>> On Wed, 24 Jun 2026 15:23:47 +0200
>>> Christian König <christian.koenig@amd.com> wrote:
>>>> On 6/24/26 15:14, Kaitao Cheng wrote:
>>>>> 在 2026/6/22 16:42, David Laight 写道:  
>>>>>> On Mon, 22 Jun 2026 12:05:31 +0800
>>>>>> Kaitao Cheng <kaitao.cheng@linux.dev> wrote:
>>>>>>  
>>>>>>> From: Kaitao Cheng <chengkaitao@kylinos.cn>
>>>>>>>
>>>>>>> The list_for_each*_safe() helpers are used when the loop body may
>>>>>>> remove the current entry.  Their API exposes the temporary cursor at
>>>>>>> every call site, even though most users only need it for the iterator
>>>>>>> implementation and never reference it in the loop body.
>>>>>>>
>>>>>>> Add *_mutable() variants for list and hlist iteration.  The new helpers
>>>>>>> support both forms: callers may keep passing an explicit temporary cursor
>>>>>>> when they need to inspect or reset it, or omit it and let the helper use
>>>>>>> a unique internal cursor.  
>>>>>>
>>>>>> I'm not really sure 'mutable' means anything either.
>>>>>> It is possible to make it valid for the loop body (or even other threads)
>>>>>> to delete arbitrary list items - but that needs significant extra overheads.
>>>>>>
>>>>>> It might be worth doing something that doesn't need the extra variable,
>>>>>> but there is little point doing all the churn just to rename things.
>>>>>>  
>>>>>>>
>>>>>>> This makes call sites that only mutate the list through the current entry
>>>>>>> less noisy, while keeping the existing *_safe() helpers available for
>>>>>>> compatibility.
>>>>>>>
>>>>>>> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
>>>>>>> ---
>>>>>>>  include/linux/list.h | 269 +++++++++++++++++++++++++++++++++++++------
>>>>>>>  1 file changed, 231 insertions(+), 38 deletions(-)
>>>>>>>
>>>>>>> diff --git a/include/linux/list.h b/include/linux/list.h
>>>>>>> index 09d979976b3b..1081def7cea9 100644
>>>>>>> --- a/include/linux/list.h
>>>>>>> +++ b/include/linux/list.h
>>>>>>> @@ -7,6 +7,7 @@
>>>>>>>  #include <linux/stddef.h>
>>>>>>>  #include <linux/poison.h>
>>>>>>>  #include <linux/const.h>
>>>>>>> +#include <linux/args.h>
>>>>>>>  
>>>>>>>  #include <asm/barrier.h>
>>>>>>>  
>>>>>>> @@ -763,28 +764,72 @@ static inline void list_splice_tail_init(struct list_head *list,
>>>>>>>  #define list_for_each_prev(pos, head) \
>>>>>>>  	for (pos = (head)->prev; !list_is_head(pos, (head)); pos = pos->prev)
>>>>>>>  
>>>>>>> -/**
>>>>>>> - * list_for_each_safe - iterate over a list safe against removal of list entry
>>>>>>> - * @pos:	the &struct list_head to use as a loop cursor.
>>>>>>> - * @n:		another &struct list_head to use as temporary storage
>>>>>>> - * @head:	the head for your list.
>>>>>>> +/*
>>>>>>> + * list_for_each_safe is an old interface, use list_for_each_mutable instead.
>>>>>>>   */
>>>>>>>  #define list_for_each_safe(pos, n, head) \
>>>>>>>  	for (pos = (head)->next, n = pos->next; \
>>>>>>>  	     !list_is_head(pos, (head)); \
>>>>>>>  	     pos = n, n = pos->next)
>>>>>>>  
>>>>>>> +#define __list_for_each_mutable_internal(pos, tmp, head)		\
>>>>>>> +	for (typeof(pos) tmp = (pos = (head)->next)->next;		\  
>>>>>>
>>>>>> Use auto
>>>>>>  
>>>>>>> +	     !list_is_head(pos, (head));				\
>>>>>>> +	     pos = tmp, tmp = pos->next)
>>>>>>> +
>>>>>>> +#define __list_for_each_mutable1(pos, head)				\
>>>>>>> +	__list_for_each_mutable_internal(pos, __UNIQUE_ID(next), head)
>>>>>>> +
>>>>>>> +#define __list_for_each_mutable2(pos, next, head)			\
>>>>>>> +	list_for_each_safe(pos, next, head)
>>>>>>> +
>>>>>>>  /**
>>>>>>> - * list_for_each_prev_safe - iterate over a list backwards safe against removal of list entry
>>>>>>> + * list_for_each_mutable - iterate over a list safe against entry removal
>>>>>>>   * @pos:	the &struct list_head to use as a loop cursor.
>>>>>>> - * @n:		another &struct list_head to use as temporary storage
>>>>>>> - * @head:	the head for your list.
>>>>>>> + * @...:	either (head) or (next, head)
>>>>>>> + *
>>>>>>> + * next:	another &struct list_head to use as optional temporary storage.
>>>>>>> + *		The temporary cursor is internal unless explicitly supplied by
>>>>>>> + *		the caller.
>>>>>>> + * head:	the head for your list.
>>>>>>> + */
>>>>>>> +#define list_for_each_mutable(pos, ...)					\
>>>>>>> +	CONCATENATE(__list_for_each_mutable, COUNT_ARGS(__VA_ARGS__))	\
>>>>>>> +		(pos, __VA_ARGS__)  
>>>>>>
>>>>>> The variable argument count logic really just slows down compilation.
>>>>>> Maybe there aren't enough copies of this code to make that significant.
>>>>>> But just because you can do it doesn't mean it is a gooD idea.
>>>>>> I'm also not sure it really adds anything to the readability.
>>>>>>
>>>>>> And, it you are going to make the middle argument optional there is
>>>>>> no need to change the macro name.  
>>>>>
>>>>> Christian König and Jani Nikula also disagree with the variadic-argument
>>>>> implementation approach. If we abandon that method, it means we will
>>>>> inevitably need to add some new macros. If mutable is not a good name,
>>>>> suggestions for better alternatives would be welcome; coming up with a
>>>>> suitable name is indeed rather tricky.  
>>>>
>>>> I don't think you need to add a new macro for the specific use case that people want to modify the next element of the iteration.
>>>>
>>>> If I remember your numbers correctly that is a really corner case and keeping using the existing *_safe() macros for that sounds perfectly fine to me.
>>>
>>> IIRC currently you have a choice of either:
>>> 	define               Item that can't be deleted
>>> 	list_for_each()	     The current item.
>>> 	list_for_each_safe() The next item.
>>> There is also likely to be code that updates the variables to allow
>>> for other scenarios.
>>>
>>> Note that if increase a reference count and release a lock then list_for_each()
>>> is likely safer than list_for_each_safe() :-)
>>>
>>> list.h has 9 variants of the 'safe' loop.
>>> The bloat of another 9 is getting excessive.
>>>
>>> It has to be said that this is one of my least favourite type of list...
>>
>> Hi Christian König, David Laight, Jani Nikula, David Hildenbrand,
>> Andy Shevchenko, Alexei Starovoitov
>>
>> For ease of discussion, I need to summarize the currently possible
>> approaches and briefly describe their respective pros and cons,
>> using the list_for_each_entry* interfaces as examples.
>>
>> 1. Add list_for_each_entry_mutable, while keeping list_for_each_entry
>> and list_for_each_entry_safe unchanged. list_for_each_entry_mutable
>> would be used specifically for safe deletion scenarios that do not
>> need to expose the temporary cursor externally. The code can refer to
>> the v1 version.
>>
>> Pros: Does not depend on immediate per-subsystem adaptation and can be
>>       merged directly.
>> Cons: Requires adding a whole set of mutable interfaces, which makes the
>>       code somewhat redundant.
> 
> Seems fine, and the original _safe naming is ambiguous anyway.
> 
>> 2. Directly optimize away the temporary cursor in list_for_each_entry_safe
>> and define it inside the loop instead, changing the interface from four
>> arguments to three.
>>
>> Pros: Does not add redundant interfaces.
>> Cons: (1) Users need to manually update special cases that use the
>>       traversal variable of list_for_each_entry_safe, the new
>>       list_for_each_entry_safe would no longer apply there and would
>>       need to be open-coded.
>>       (2) Because the macro arguments changes, all list_for_each_entry_safe
>>       callers would need to be modified and merged together, making it
>>       difficult to merge such a large amount of code at once.
> 
> This won't fly because there are literally thousands of
> list_for_each_entry_safe() users.
> 
>> 3. Use a variadic macro approach to optimize list_for_each_entry_safe,
>> so that it supports both three and four arguments.
>>
>> Pros: (1) Does not add redundant interfaces.
>>       (2) Does not depend on immediate per-subsystem adaptation and can
>>       be merged directly.
>> Cons: (1) Increases compile time.
>>       (2) Makes the interface harder for users to use.
> 
> Basically I'm against any variadic macro tricks where the optional
> argument is not the last argument. That's just way too surprising, and
> goes against common practice in just about all other languages.
> 
>> 4. Optimize list_for_each_entry by defining the temporary cursor internally,
>> making it compatible with the functionality of list_for_each_entry_safe.
>> The code can refer to the v2 version.
>>
>> Pros: (1) Does not add redundant interfaces.
>>       (2) The number of externally visible arguments of list_for_each_entry
>>       remains unchanged, still three.
>> Cons: (1) list_for_each_entry and list_for_each_entry_safe would be merged
>>       into one, and list_for_each_entry_safe would gradually be deprecated.
>>       (2) Users need to manually update special cases that use the traversal
>>       variable of list_for_each_entry, the new list_for_each_entry would no
>>       longer apply there and would need to be open-coded. There are 15 such
>>       cases in total.
> 
> This sounds good to me, though I take it there's some code size increase
> and/or performance penalty?
> 
> Maybe the 15 cases are questionable anyway?
> 
>> 5. Use a variadic macro approach to optimize list_for_each_entry, so that
>> it supports both three and four arguments.
>>
>> Pros: (1) Does not add redundant interfaces.
>>       (2) Does not depend on immediate per-subsystem adaptation and can be
>>       merged directly.
>> Cons: (1) Increases compile time.
>>       (2) list_for_each_entry and list_for_each_entry_safe would be merged
>>       into one, and list_for_each_entry_safe would gradually be deprecated.
> 
> Please don't do the macro tricks.
> 
>> 6. Make no changes, keep the current logic unchanged, and close the current
>> email discussion.
> 
> I like hiding the temporary stuff when possible.
> 
> BR,
> Jani.

Hi all,
If there are no objections, I will make the changes using the first approach.


Hi David Laight,
You previously expressed a different opinion. Do you have any further comments
on the current proposed approach?

-- 
Thanks
Kaitao Cheng


