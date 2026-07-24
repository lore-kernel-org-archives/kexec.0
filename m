Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D0D1C531C9
	for <kexec@archiver.kernel.org>; Fri, 24 Jul 2026 16:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8ngNj00jBqy/OPE2x8gfNCz+K4mGYeO4wn+LIqAYX40=; b=LVbMz4LE2HBi8O5rJ49LlEyHEp
	5NlQuylly6wqFILt+sN+mYv6UOL3IID5GW+A+KPLU2ZlqA+OOYdqhUcNzSTnTF4bZlPbn0v56MDcx
	4QJWa1dv31yaIQ7DLJGXYNTq3fpNYlUzF2W9AQCvM44xtj9DwH2KgSRWbbf7V7adS3YZq94Rvxdp+
	5mYMq7omkP+o9oHlS/iUH1jZMaNWih1Esi0LQiOQnuXEU8Ty/ivkKj1DxT1K/YWHhywRDAtZGFoQK
	Rck1M4XF9KE9YVw8qJq0CZgTy3QuFCiEbvrFFxEgn4osd36jWz8qialrMxlanftDCQleiT5bpbYGX
	60T51aXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnJ80-0000000Gswz-3smQ;
	Fri, 24 Jul 2026 16:52:04 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnJ80-0000000Gswq-0HeY
	for kexec@lists.infradead.org;
	Fri, 24 Jul 2026 16:52:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 275D3600AD;
	Fri, 24 Jul 2026 16:52:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F5B1F000E9;
	Fri, 24 Jul 2026 16:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784911922;
	bh=8ngNj00jBqy/OPE2x8gfNCz+K4mGYeO4wn+LIqAYX40=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=BnN5DFd3+HUO0URnrf7glzg2MxJZ4hQc/rAx0VF1TTyw4cWJf4M+zPfDRm0K6rgLP
	 D7ZXKfEo0rwOlqwS2eEjwp1k1PE8liEVNI88xmhFIqyM0f7k5Z1SEleH9wmDmEKC4E
	 NQGU35qrnod7x9vxPDibBlFsl/t8WFgAb/GlB8cWE7l9UnUc2hWo/5miGU1M2PO1O1
	 E/8+wsMAocXb1giQzlW8vq1CR7ycV3LNp8J2cX28vduXhjbD3i8GIemLb7hidgS4JP
	 yncPIynrFhezOSH6SSAu2kQm7KE+/aB0MbG9O04kCOVlr6jM51HADEev3/hIoVajQT
	 IUXF5ZA0g1l7A==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Alexander Graf <graf@amazon.com>,  Muchun
 Song <muchun.song@linux.dev>,  Oscar Salvador <osalvador@suse.de>,  David
 Hildenbrand <david@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Jason Miu <jasonmiu@google.com>,  Jork
 Loeser <jloeser@linux.microsoft.com>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 19/21] memblock: make HugeTLB bootmem allocation work
 with KHO
In-Reply-To: <178410811939.820181.7248948033992831535.b4-review@b4> (Mike
	Rapoport's message of "Wed, 15 Jul 2026 12:35:19 +0300")
References: <20260709173821.429921-1-pratyush@kernel.org>
	<20260709173821.429921-20-pratyush@kernel.org>
	<178410811939.820181.7248948033992831535.b4-review@b4>
Date: Fri, 24 Jul 2026 18:51:59 +0200
Message-ID: <2vxzo6fwgwk0.fsf@kernel.org>
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

On Wed, Jul 15 2026, Mike Rapoport wrote:

>> Gigantic huge page allocation is somewhat broken currently when KHO is
>> used.
>> 
>> Firstly, they break KHO scratch size accounting. RSRV_KERN is used to
>> track how much memory is reserved for use by the kernel. Since
>> hugetlb::alloc_bootmem() calls the memblock_alloc*() APIs, the hugepages
>> allocated also get marked as RSRV_KERN.
>> 
>> Allocations marked RSRV_KERN are used by KHO to calculate how much
>> scratch space it should reserve to make sure the next kernel has enough
>> memory to boot when it is in scratch-only phase. Counting hugepages in
>> that blows up scratch size, and can lead to the scratch allocation
>> failing, making KHO unusable. This will show up when huge pages make up
>> more than 50% of the system, which is a fairly common use case.
>> 
>> Secondly, while not supported right now, huge pages are user memory and
>> can be preserved via KHO. The scratch spaces should not have any
>> preserved memory. Allocating hugepages from scratch (on a KHO boot) can
>> lead to them being un-preservable.
>> 
>> Introduce memblock_alloc_hugetlb(). This lets memblock tailor to the
>> needs of hugetb without exposing those details to the general allocation
>> routines.
>> 
>> First, it does not use mirrored memory for hugetlb. Mirrored memory is a
>> limited resource that is best saved for kernel data structures, not user
>> memory.
>> 
>> Second, if the free memory area found by memblock_find_in_range_node()
>> is a part of a KHO scratch area, the free area is not used. Allocation
>> is retried starting after the free area to ensure no hugepages come from
>> KHO scratch.
>> 
>> Third, it simplifies the argument list by baking in some hugetlb
>> assumptions like alignment and exact_nid. This also simplifies
>> allocation logic in alloc_bootmem().
>> 
>> Also introduce MEMBLOCK_RSRV_HUGETLB to mark reservations made for
>> HugeTLB. This will be used by KHO in future patches to correctly
>> calculate scratch sizes.
>> 
>> Refactor some of the preparation logic like kmemleak tracking and
>> accepting memory into a separate helper memblock_prep_allocation(), and
>> use it from both memblock_alloc_hugetlb() and the usual
>> memblock_alloc_range_nid().
>> 
>> Add a stub for kho_scratch_overlap to memblock tests to make sure it
>> compiles.
>> 
>> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
[...]
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index 8b2e551435ae9..ba6d887ea18eb 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -1506,6 +1506,32 @@ int __init_memblock memblock_set_node(phys_addr_t base, phys_addr_t size,
>>  	return 0;
>>  }
>>  
>> +static void memblock_prep_allocation(phys_addr_t start, phys_addr_t size,
>> +				     bool leaktrace)
>
> Let's call this kmemleak_trace

ACK.

>
>> +{
>> +	/*
>> +	 * Skip kmemleak for those places like kasan_init() and
>> +	 * early_pgtable_alloc() due to high volume.
>> +	 */
>> +	if (leaktrace)
>> +		/*
>> +		 * Memblock allocated blocks are never reported as
>> +		 * leaks. This is because many of these blocks are
>> +		 * only referred via the physical address which is
>> +		 * not looked up by kmemleak.
>> +		 */
>> +		kmemleak_alloc_phys(start, size, 0);
[...]
>> diff --git a/tools/testing/memblock/internal.h b/tools/testing/memblock/internal.h
>> index b6b1d147fd750..e86bb9000b22f 100644
>> --- a/tools/testing/memblock/internal.h
>> +++ b/tools/testing/memblock/internal.h
>> @@ -66,4 +66,9 @@ static inline void init_deferred_page(unsigned long pfn, int nid)
>>  
>>  #define __SetPageReserved(p)	((void)(p))
>>  
>> +static inline bool kho_scratch_overlap(phys_addr_t phys, size_t size)
>> +{
>> +	return false;
>> +}
>> +
>
> This should be in the patch that exposes kho_scratch_overlap() to kexec_handover.h

Hm, sure, why not. I added it here because _this patch_ uses
kho_scratch_overlap() for the first time on memblock.c, and with that
breaks build of the memblock tests. So I recokned it makes sense to have
it in the place that broke it.

But I don't mind, I can move it to the other patch as well.

-- 
Regards,
Pratyush Yadav

