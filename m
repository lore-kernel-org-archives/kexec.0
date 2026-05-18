Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C280ACD4F4A
	for <kexec@archiver.kernel.org>; Mon, 18 May 2026 17:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TFyT3UWzWYujR4kZY23IgiSR6K+8qDTcItkUP4ECz8s=; b=emlPrzWwkg1CY2QgX4wZ8jF0IE
	uxVoxpOkIWDDKjVewNUHDkV5sYxtsvfMfiDeOvrtylilTDOzN7exDVHDOmqLi1gVPzhF0JUTSdECe
	baWBy+JFUNZk6GoXaSDTDKg0JSLmL+F+UJm/n8vpJy7ug0bFAwYrzB+UczYVIr5MniXXY7vFG52Z4
	o1IWduI8QGONDI1WWPSKTnybM0hTwXUxrlWAQNzjdxOMZz+HtxDydh8oHYktMhW1oUbM3sqQgIY0a
	4A34r5akrGofuvRd1EhlkSB7eSAEmtjOpn0U/VgZEnm/qF/RSMd48AzGR3eLxz4EQa4UNJbjFAQ5W
	7QPmChbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wP1Ol-0000000GMx3-3S9s;
	Mon, 18 May 2026 17:04:59 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wP1Ok-0000000GMwo-18Cl
	for kexec@lists.infradead.org;
	Mon, 18 May 2026 17:04:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 82737600CB;
	Mon, 18 May 2026 17:04:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40798C2BCC6;
	Mon, 18 May 2026 17:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779123897;
	bh=oF5fCKa8TBaLbZmUFVSl67crcxZy4IiTCrZvTFlW8Vc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NvDNMnTKzFj1hZuOpHHB4xghuVeBxnwoO6sXwaSIdz4MZOGRMHCJRMa0pyIsavGA4
	 ufe8NNH7VYDgF31DkRarC/2x5lLc1LGk62rP9Vk41HmSCLljA2qapXIOf8b6ZThm/n
	 m1jqsdhTYLaJfWsWscw/LX4kDN/41E5bAfuqAv0FxZueFgHFR1flpEimM7R80iKM6/
	 HKKCiI1RJX3ONvr6kN2E/4g/JZ2ifYb8m0ihlj1DO8RMyqXc+vSfbXE5MDAsxOlftn
	 hNWRp6XXJjWuRtGRu6Cni/USftVNufnssIdcambJ4YwcGoTg8itfUoT8yUD0mTfbaO
	 qRCT8Pre9fpuA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Alexander Graf <graf@amazon.com>,  Muchun
 Song <muchun.song@linux.dev>,  Oscar Salvador <osalvador@suse.de>,  David
 Hildenbrand <david@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Jason Miu <jasonmiu@google.com>,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/12] kho: extended scratch
In-Reply-To: <agmVzhvF8cxFu1PK@kernel.org> (Mike Rapoport's message of "Sun,
	17 May 2026 13:17:50 +0300")
References: <20260429133928.850721-1-pratyush@kernel.org>
	<20260429133928.850721-11-pratyush@kernel.org>
	<agmVzhvF8cxFu1PK@kernel.org>
Date: Mon, 18 May 2026 19:04:53 +0200
Message-ID: <2vxzjyt08x8q.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Sun, May 17 2026, Mike Rapoport wrote:

> On Wed, Apr 29, 2026 at 03:39:12PM +0200, Pratyush Yadav wrote:
>> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>>
>> Methodology
>> ===========
>> 
>> Introduce extended scratch areas. These areas are discovered at boot by
>> walking the preserved memory radix tree and looking for free blocks of
>> memory. They then marked as scratch to allow allocations from them. This
>> makes KHO more resilient to memory pressure and allows supporting huge
>> page preservation.
>> 
>> Since the preserved memory radix tree mixes both physical address and
>> order into a single key, and does not track table pages, it is difficult
>> to identify free areas from it directly. Walk the tree and digest it
>> down into another radix tree. The latter tracks blocks of
>> KHO_EXT_SHIFT (1 GiB as of now) granularity. Then walk the digested tree
>> and mark the areas between the present keys as scratch.
>>
>> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
>> ---
>>  include/linux/kexec_handover.h     |   1 +
>>  kernel/liveupdate/kexec_handover.c | 148 +++++++++++++++++++++++++----
>>  mm/mm_init.c                       |   1 +
>>  3 files changed, 133 insertions(+), 17 deletions(-)
>> 
>> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
>> index 1a04e089f779..c2b843a5fb28 100644
>> --- a/kernel/liveupdate/kexec_handover.c
>> +++ b/kernel/liveupdate/kexec_handover.c
>> @@ -840,6 +857,120 @@ static void __init kho_reserve_scratch(void)
>>  	kho_enable = false;
>>  }
>>  
>> +#define KHO_EXT_SHIFT 30 /* 1 GiB */
>
> arm64 does not necessarily use 1G gigantic pages and worse, it can have 2
> gigantic hstates.
>
> I think this should take into account what actual gigantic page sizes are
> in use for the general case.

This has nothing to with the gigantic page sizes. This is simply the
granularity at which KHO looks for free blocks. Making this larger means
less memory usage and better performance at the cost of amount of memory
recovered. Making this smaller does the opposite.

I picked 1G because it "feels" the right balance. Mostly gut feeling
without real science behind the number. I can make it smaller or larger
if you'd like.

-- 
Regards,
Pratyush Yadav

