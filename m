Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77742CD98DE
	for <kexec@archiver.kernel.org>; Mon, 15 Jun 2026 13:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uUFCxSXn77xBdFdSa9gDApYhBo9jSYuSz5ASxlKKY7Q=; b=cP2j56I/ttyxwgg9Ucd9FU3F98
	dA2gIaksreltuhThdwOWlH8AC3ZfWFqUKDqsP3fyevOW++dpUnTxiPQmp+2Vjpzf5kROnUldXL4xj
	PKkNaX5HS3QhK1z1361F1BPXCl5hJvwxSh+Ca2RFRk6DsVltDL0xd0enGXqomNI1Gz77QHeHcCs+u
	H45iuSbtBae1u+9KBgLLkvVAbDf6oLcPMLBVA8Wi4GQGLchqevLXjpZqQQBl5Vi7YS5InFNXIMIFr
	+FXKJwoCJyL5RXyivq6ZHY2Quc56Qs5guDw7wCt/3wfZcBnwvhh4PBpNm2bN0Hne2YKrXxACJ8BJI
	8dEvqRjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZ7Te-0000000EJYl-2T1t;
	Mon, 15 Jun 2026 13:35:46 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZ7Tb-0000000EJYT-3FnO
	for kexec@lists.infradead.org;
	Mon, 15 Jun 2026 13:35:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id F181D6008A;
	Mon, 15 Jun 2026 13:35:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8A51F000E9;
	Mon, 15 Jun 2026 13:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781530542;
	bh=uUFCxSXn77xBdFdSa9gDApYhBo9jSYuSz5ASxlKKY7Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=BlW1Jx+RJJPWKOuK2BiPu12UqEMM/0i9SqlIuUO8sktQdXHgZfF5/AVYlbU9km0AC
	 CVXiobcnUzhC7Mqe/gAkNn8f7BFLyztRpIbj7yvyMgp/zy4nxulzodpOsJu8QqWxqU
	 WAInfd+vR+vgM5GyHybLyVd9XvunckQ+3NlxcfzVhYnLuDheQ8+SY4ApjlSAP+1h7M
	 ZuucmK2QuzfQ9TeQnl4iR+657mqzMtBmuflMzNXGfEImVPdA4V7LBFQMdb604EaEvq
	 KdbFlKAnkYuJ5ZtzK74U7MERy+c84vIOOJt/12WkHsKJq5NCndA/hsKA5xJJp+iH0j
	 VSOz1LY8W/F5w==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Alexander Graf <graf@amazon.com>,  Muchun
 Song <muchun.song@linux.dev>,  Oscar Salvador <osalvador@suse.de>,  David
 Hildenbrand <david@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Jason Miu <jasonmiu@google.com>,  Jork
 Loeser <jloeser@linux.microsoft.com>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 16/18] memblock: make HugeTLB bootmem allocation work
 with KHO
In-Reply-To: <178143855120.2123877.5431342391381982046.b4-review@b4> (Mike
	Rapoport's message of "Sun, 14 Jun 2026 15:02:31 +0300")
References: <20260605183501.3884950-1-pratyush@kernel.org>
	<20260605183501.3884950-17-pratyush@kernel.org>
	<178143855120.2123877.5431342391381982046.b4-review@b4>
Date: Mon, 15 Jun 2026 15:35:39 +0200
Message-ID: <2vxzpl1soris.fsf@kernel.org>
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

On Sun, Jun 14 2026, Mike Rapoport wrote:

> On Fri, 05 Jun 2026 20:34:49 +0200, Pratyush Yadav <pratyush@kernel.org> wrote:
>> Gigantic huge page allocation is somewhat broken currently when KHO is
>> used.
>> 
>> Firstly, they break KHO scratch size accounting. RSRV_KERN is used to
>> track how much memory is reserved for use by the kernel. Since
>> alloc_bootmem() calls the memblock_alloc*() APIs, the hugepages
>
> hugetlb::alloc_bootmem()

ACK.

>
>> [...]
>> First, it does not use mirrored memory for hugetlb. Mirrored memory is a
>> limited resource that is best saved for kernel data structures, not user
>> memory.
>> 
>> Second, if the memory found overlaps with KHO scratch areas, it discards
>> the memory and retries.
>
> This sentence is somewhat hard to parse.

Okay, let me retry:

    Second, if the free memory area found by memblock_find_in_range_node()
    is a part of a KHO scratch area, the free area is not used. Allocation
    is retried starting after the free area to ensure no hugepages come from
    KHO scratch.

Any better?

>
>>
>>
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index 6349c48154f4..131e54dd5d8d 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -1756,6 +1761,69 @@ void * __init memblock_alloc_try_nid_raw(
>> [ ... skip 51 lines ... ]
>> +		if (memblock_bottom_up())
>> +			start = addr + size;
>> +		else
>> +			start = addr - size;
>> +
>> +		goto retry;
>
> Hmm, two goto retry don't seem nice :/
> Although I can't see how to imporove it really.

Dunno, looked easy enough to understand to me.

>
> Maybe add a helper for going the node fallback?

There is a small downside. There will then be no way to know the
fallback was tried already, so if a retry is done because of scratch
overlap, the fallback needs to be done again.

I don't think it should be too bad, so if you still prefer this then I
can do it.

-- 
Regards,
Pratyush Yadav

