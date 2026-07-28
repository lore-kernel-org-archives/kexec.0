Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 279C0C54F4D
	for <kexec@archiver.kernel.org>; Tue, 28 Jul 2026 14:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZDkk7PDtexhsBzVT9GWHhsxn7eilb1XwsTmiTnabsNY=; b=pK3ZkUzBvU59vusTnkQ5aaJ6Vf
	RWUed6qPwBWBcJpapRdn8t4Jg9djTickF5HrOtkQjOK8hkDq9qTGezc4MLjH6e/MIBR8dz1prG6fM
	2mNQM2qdD5u7Hjh8Ba0y+OewysfkWoTsW/wDpcJpXqVBYmoQUnFydqofXnJNN+UkZdm00GpETLY2w
	Ygbj/qvqKwM3oEutNb6yC7LklNReFIBFovQLutwNGaXAgt89NHLVft8EppHf42KOoHTnVPVd/nXU2
	S/EDrROG6bkdGfbPJipc7fv7PXOtz7o1YNyJn7ExXv6m4gkoQrOqmadZ01OGVdmIwiBX7xEv9OAp/
	ew8pww5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woiw0-00000005WTx-0xg3;
	Tue, 28 Jul 2026 14:37:32 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woivz-00000005WTe-0olp
	for kexec@lists.infradead.org;
	Tue, 28 Jul 2026 14:37:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9C95E4034E;
	Tue, 28 Jul 2026 14:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CAA61F000E9;
	Tue, 28 Jul 2026 14:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785249450;
	bh=ZDkk7PDtexhsBzVT9GWHhsxn7eilb1XwsTmiTnabsNY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=nc26FOHPHYa9+8isLzyk0zxQfzaTb0OA2pPhKpbyYczQVTRy6FuWreWujR95MzVdg
	 8V5iMwIzJWE8pVxklYHkEBbw9SMYalKGI8aWBEmO/813/x/QKcOZVsf4OKFcMviYu6
	 F7BHRI2q+YBxtJsLz7B6DfQqqYINP84nYofCR1Y4mPeRUb4MatyytBNFpT8K28Ishv
	 OFcq8cMmk5AHLuJag0dHBnurSCJ0ACBEYb6XJACN3TB2nSwVJvVvabEMSgOPe4dU0n
	 HZsS3IgfHeKSx4blTi7u63QzixOnTAxG9B2N2TNrRS67Fu/3ZIsLCN8hszAm3my6x4
	 2QFGKWdOJKihQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Alexander Graf <graf@amazon.com>,  Muchun
 Song <muchun.song@linux.dev>,  Oscar Salvador <osalvador@suse.de>,  David
 Hildenbrand <david@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Jason Miu <jasonmiu@google.com>,  Jork
 Loeser <jloeser@linux.microsoft.com>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/21] kho: make boot time huge page allocation work
 nicely with KHO
In-Reply-To: <amiwLSEi8cczamP1@kernel.org> (Mike Rapoport's message of "Tue,
	28 Jul 2026 16:35:41 +0300")
References: <20260725172133.4018491-1-pratyush@kernel.org>
	<amiwLSEi8cczamP1@kernel.org>
Date: Tue, 28 Jul 2026 16:37:26 +0200
Message-ID: <2vxzecgn89jt.fsf@kernel.org>
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

On Tue, Jul 28 2026, Mike Rapoport wrote:

> On Sat, Jul 25, 2026 at 07:21:00PM +0200, Pratyush Yadav wrote:
>> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>> 
>> Hi,
>> 
>> Gigantic huge page allocation is somewhat broken currently with KHO.
>> 
>> First, they break scratch size accounting. Since they are allocated
>> using the memblock alloc APIs, they count towards RSRV_KERN, and this
>> scratch size when using scratch_scale. This means if huge pages take a
>> large enough chunk of system memory scratch size will blow up and fail
>> to allocate.
>> 
>> Second, scratch can not contain preserved memory, and if hugepages are
>> allocated from scratch, they will fail to be preserved with the upcoming
>> hugetlb preservation series [0].
>> 
>> Fix this by introducing the concept of extended scratch areas. They are
>> areas that the kernel discovers on boot by walking the radix tree and
>> finding free memory ranges. See patch 10 for more details.
>> 
>> Muchun Song (1):
>>   mm/mm_init: simplify deferred_free_pages() migratetype init
>> 
>> Pratyush Yadav (Google) (20):
>>   kho: generalize radix tree APIs
>>   kho: make radix max key width more obvious
>>   kho: disallow wide keys in radix tree
>>   kho: return virtual address of mem_map from kho_get_mem_map()
>>   kho: store incoming radix tree in kho_in
>>   kho: move all memory retrieval logic to kho_mem_retrieve()
>>   kho: add a struct for radix callbacks
>>   kho: add callback for table pages
>>   kho: add data argument to radix walk callback
>>   kho: allow early-boot usage of the KHO radix tree
>>   kho: allow destroying KHO radix tree
>>   kho: add kho_radix_init_tree()
>>   kho: expose kho_scratch_overlap() to kexec_handover.h
>>   kho: initialize kho_scratch pointer earlier in boot
>>   kho: initialize preserved memory map radix tree earlier
>>   mm/mm_init: don't rely on memblock to get KHO scratch migratetype
>>   kho: extend scratch
>>   memblock: make HugeTLB bootmem allocation work with KHO
>>   memblock: add memblock_reserved_hugetlb_size()
>>   kho: exclude hugetlb memory from scratch size calculation
>
> I added it to the liveupdate tree.

Thanks!

>
> Please take a look at Sashiko comments, we might need v5 if it has valid
> (not pre-existing) points.

I took a quick look and the only valid points I can see are the ones on
patch 19/21 "memblock: make HugeTLB bootmem allocation work with KHO".

All others are pre-existing problems.

Is it okay if I send a single follow up patch to fix 19/21? Or would you
prefer a full respin?

Also, general thing, but I should go and fix all the pre-existing
problems too at some point. I sent a fix for a really simple one
already, but Sashiko has found other problems too...

-- 
Regards,
Pratyush Yadav

