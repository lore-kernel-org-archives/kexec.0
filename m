Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC95CDE005
	for <kexec@archiver.kernel.org>; Wed, 24 Jun 2026 13:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jm5h4EGMu1/G65UxgDlhva2Uqze8a2QIkXsB3xVvPew=; b=yUrVRSs3ZC7ntJRjXfXMdKTtAQ
	nIG2bKZG2b71t5Bpejo4EiR1PP/16iHyY35Vqr+GJLFa00Z13Ig4tQNKZrVLPLjYi9FylmZElGPLr
	qwiGFqBzneXO6BqeDkKTQGFU3x3L5GGzZeMT8FjrmXESBzm7+W7VV2Gi/zYJq4cHNAHqHqiYHkALJ
	8QFeP2NhkWTvttUQm7wd3SXy/KtI4YlnFczruRRLA53R9bLTrVvsHUTHU8x8V/bQMP6RMsPdV9l6q
	ImxX9quEW3HdiP94fMXx5npJPP0wHF2eghABIcLl3cf2Ij5nGMZws1jdLMvKGEHzncz0M0OpK4X34
	BnmXOO+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcNRr-00000007o88-3AuJ;
	Wed, 24 Jun 2026 13:15:23 +0000
Received: from out-180.mta0.migadu.com ([2001:41d0:1004:224b::b4])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcNRn-00000007o7A-2d12
	for kexec@lists.infradead.org;
	Wed, 24 Jun 2026 13:15:21 +0000
Message-ID: <351a6b67-b394-4c58-aee2-88b6c8089ad5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782306914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jm5h4EGMu1/G65UxgDlhva2Uqze8a2QIkXsB3xVvPew=;
	b=Kz4Q9rbh7etgj8euhlBLWO3TzYATCTCfu6njur0dxfGVJdMqB9UP/InGWtI0bOGTstOlHl
	POIMRyO3mRJBT5/BeQDQV44BuugXQiS1AZGuvJ0EWei9+7fme1gtEeTZSwt1IwIDM7n5ZK
	H6199we71vGASxf1nAZQvllBRzYOKVU=
Date: Wed, 24 Jun 2026 21:14:50 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/7] list: Add mutable iterator variants
To: David Laight <david.laight.linux@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Tejun Heo <tj@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Paul Moore <paul@paul-moore.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Howells <dhowells@redhat.com>, Simona Vetter <simona.vetter@ffwll.ch>,
 Randy Dunlap <rdunlap@infradead.org>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
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
 llvm@lists.linux.dev, Kaitao Cheng <chengkaitao@kylinos.cn>
References: <20260622040533.29824-1-kaitao.cheng@linux.dev>
 <20260622040533.29824-2-kaitao.cheng@linux.dev>
 <20260622094242.64531b9a@pumpkin>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kaitao Cheng <kaitao.cheng@linux.dev>
In-Reply-To: <20260622094242.64531b9a@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260624_061519_812614_C51425AB 
X-CRM114-Status: GOOD (  28.18  )
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



在 2026/6/22 16:42, David Laight 写道:
> On Mon, 22 Jun 2026 12:05:31 +0800
> Kaitao Cheng <kaitao.cheng@linux.dev> wrote:
> 
>> From: Kaitao Cheng <chengkaitao@kylinos.cn>
>>
>> The list_for_each*_safe() helpers are used when the loop body may
>> remove the current entry.  Their API exposes the temporary cursor at
>> every call site, even though most users only need it for the iterator
>> implementation and never reference it in the loop body.
>>
>> Add *_mutable() variants for list and hlist iteration.  The new helpers
>> support both forms: callers may keep passing an explicit temporary cursor
>> when they need to inspect or reset it, or omit it and let the helper use
>> a unique internal cursor.
> 
> I'm not really sure 'mutable' means anything either.
> It is possible to make it valid for the loop body (or even other threads)
> to delete arbitrary list items - but that needs significant extra overheads.
> 
> It might be worth doing something that doesn't need the extra variable,
> but there is little point doing all the churn just to rename things.
> 
>>
>> This makes call sites that only mutate the list through the current entry
>> less noisy, while keeping the existing *_safe() helpers available for
>> compatibility.
>>
>> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
>> ---
>>  include/linux/list.h | 269 +++++++++++++++++++++++++++++++++++++------
>>  1 file changed, 231 insertions(+), 38 deletions(-)
>>
>> diff --git a/include/linux/list.h b/include/linux/list.h
>> index 09d979976b3b..1081def7cea9 100644
>> --- a/include/linux/list.h
>> +++ b/include/linux/list.h
>> @@ -7,6 +7,7 @@
>>  #include <linux/stddef.h>
>>  #include <linux/poison.h>
>>  #include <linux/const.h>
>> +#include <linux/args.h>
>>  
>>  #include <asm/barrier.h>
>>  
>> @@ -763,28 +764,72 @@ static inline void list_splice_tail_init(struct list_head *list,
>>  #define list_for_each_prev(pos, head) \
>>  	for (pos = (head)->prev; !list_is_head(pos, (head)); pos = pos->prev)
>>  
>> -/**
>> - * list_for_each_safe - iterate over a list safe against removal of list entry
>> - * @pos:	the &struct list_head to use as a loop cursor.
>> - * @n:		another &struct list_head to use as temporary storage
>> - * @head:	the head for your list.
>> +/*
>> + * list_for_each_safe is an old interface, use list_for_each_mutable instead.
>>   */
>>  #define list_for_each_safe(pos, n, head) \
>>  	for (pos = (head)->next, n = pos->next; \
>>  	     !list_is_head(pos, (head)); \
>>  	     pos = n, n = pos->next)
>>  
>> +#define __list_for_each_mutable_internal(pos, tmp, head)		\
>> +	for (typeof(pos) tmp = (pos = (head)->next)->next;		\
> 
> Use auto
> 
>> +	     !list_is_head(pos, (head));				\
>> +	     pos = tmp, tmp = pos->next)
>> +
>> +#define __list_for_each_mutable1(pos, head)				\
>> +	__list_for_each_mutable_internal(pos, __UNIQUE_ID(next), head)
>> +
>> +#define __list_for_each_mutable2(pos, next, head)			\
>> +	list_for_each_safe(pos, next, head)
>> +
>>  /**
>> - * list_for_each_prev_safe - iterate over a list backwards safe against removal of list entry
>> + * list_for_each_mutable - iterate over a list safe against entry removal
>>   * @pos:	the &struct list_head to use as a loop cursor.
>> - * @n:		another &struct list_head to use as temporary storage
>> - * @head:	the head for your list.
>> + * @...:	either (head) or (next, head)
>> + *
>> + * next:	another &struct list_head to use as optional temporary storage.
>> + *		The temporary cursor is internal unless explicitly supplied by
>> + *		the caller.
>> + * head:	the head for your list.
>> + */
>> +#define list_for_each_mutable(pos, ...)					\
>> +	CONCATENATE(__list_for_each_mutable, COUNT_ARGS(__VA_ARGS__))	\
>> +		(pos, __VA_ARGS__)
> 
> The variable argument count logic really just slows down compilation.
> Maybe there aren't enough copies of this code to make that significant.
> But just because you can do it doesn't mean it is a gooD idea.
> I'm also not sure it really adds anything to the readability.
> 
> And, it you are going to make the middle argument optional there is
> no need to change the macro name.

Christian König and Jani Nikula also disagree with the variadic-argument
implementation approach. If we abandon that method, it means we will
inevitably need to add some new macros. If mutable is not a good name,
suggestions for better alternatives would be welcome; coming up with a
suitable name is indeed rather tricky.

-- 
Thanks
Kaitao Cheng


