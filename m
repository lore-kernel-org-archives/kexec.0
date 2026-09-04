Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA95C79F80
	for <kexec@archiver.kernel.org>; Fri,  4 Sep 2026 16:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xPOe/7eOih/6tRK4rDomL1afIgbcko+lODATuyUauVo=; b=fD2X3MDKrvKs6lkPC+E/gxXf+2
	iJ2vQ9676286EXjytAS+xud5UKdp6xrjGIw6l4kPSfZ0Vco885UdofWW/rkQBsBTOlDsumJKG35SA
	nFfIwu4j3EX3iXkNzmYPtkyZD2cbN4v0jiP1gEHpD/ixy6AWBT+VEQ6NArpiKTOG96/CCDqD4llnY
	niqrEVqh5nnPe+G18/HgltTfGuzjaWvgInrJkXdGooUvjWg5RLevZvyhJ68JkkvWhaPNg4ae/Kl55
	Fze/U0gCDe280SyM1QOqUjwZV7Ugacsxe7MGxPdT75N7f45MHUl+VGcA9oufFdVNg862Y7725qvXG
	2eYX6RDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2WgM-00000002ifa-0rj2;
	Fri, 04 Sep 2026 16:22:26 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2WgK-00000002ifS-0T6g
	for kexec@lists.infradead.org;
	Fri, 04 Sep 2026 16:22:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 80CCE41484;
	Fri,  4 Sep 2026 16:22:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089DC1F00A3E;
	Fri,  4 Sep 2026 16:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788538943;
	bh=xPOe/7eOih/6tRK4rDomL1afIgbcko+lODATuyUauVo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=LYEp4MHx8CCVpuzPJhMpRehbafg1thO+a5Qz1toktPjX4lzWjkVLkew6JjFyGc5nU
	 0ZXzae2eW47rc15K0GTaMsY76WAAdTFIR2vNc8Ud+3o//CzfS/LeLk00LRcVoKf1iH
	 Z1ED8Sj99Lw1A8HzkxEUBVEeOFlB+b9YuAphcpjJXymMsIeqKkDlZJQTgyqmdmaNuI
	 aBvoq6LxrFcS+KvmLmFKosMZG6xUQ6MuHoZUTdK5FWkuPPwBeMgFI3EoWWQFh5GIr2
	 pj5uoyg6w8ekwioiCTTrdrAx0ebI1p2Uz9StOyAT/aR9Oku+c14NjvbqhoeKaUH0Ex
	 BqSSxXLhmSxpw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  linuxppc-dev@lists.ozlabs.org,
  Aditya Gupta <adityag@linux.ibm.com>,  Alexander Graf <graf@amazon.com>,
  Andrew Morton <akpm@linux-foundation.org>,  Baoquan He
 <baoquan.he@linux.dev>,  "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>,  Hari Bathini <hbathini@linux.ibm.com>,  Madhavan
 Srinivasan <maddy@linux.ibm.com>,  Mahesh Salgaonkar
 <mahesh@linux.ibm.com>,  Michael Ellerman <mpe@ellerman.id.au>,  Mike
 Rapoport <rppt@kernel.org>,  Nicholas Piggin <npiggin@gmail.com>,  Pasha
 Tatashin <pasha.tatashin@soleen.com>,  "Ritesh Harjani (IBM)"
 <ritesh.list@gmail.com>,  Shivang Upadhyay <shivangu@linux.ibm.com>,
  Shrikanth Hegde <sshegde@linux.ibm.com>,  kexec@lists.infradead.org,
  linux-kernel@vger.kernel.org, Tarun Sahu <tarunsahu@google.com>
Subject: Re: [RFC PATCH 2/3] powerpc: add support for Kexec HandOver (KHO)
In-Reply-To: <8fa790a7-f387-48f6-ac76-11cf71ef5589@linux.ibm.com> (Sourabh
	Jain's message of "Fri, 4 Sep 2026 20:20:38 +0530")
References: <20260821105609.983622-1-sourabhjain@linux.ibm.com>
	<20260821105609.983622-3-sourabhjain@linux.ibm.com>
	<2vxza4qfznyo.fsf@kernel.org>
	<7bb84b8a-c394-4895-9e22-632dc506cbb6@linux.ibm.com>
	<2vxz5x0ox7p9.fsf@kernel.org>
	<8fa790a7-f387-48f6-ac76-11cf71ef5589@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Fri, 04 Sep 2026 18:22:18 +0200
Message-ID: <2vxzwlt1vvet.fsf@kernel.org>
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

On Fri, Sep 04 2026, Sourabh Jain wrote:

> On 02/09/26 16:04, Pratyush Yadav wrote:
>> On Sun, Aug 23 2026, Sourabh Jain wrote:
>>
>>> On 21/08/26 17:26, Pratyush Yadav wrote:
>>>> On Fri, Aug 21 2026, Sourabh Jain wrote:
[...]
>>> I agree that this is one way to work around the low-memory reservation problem.
>>> However, there are a few things that come into play here:
>>>
>>> 1. On powerpc, the crashkernel reservation can go up to 64 GB for kdump. With
>>> the
>>>     current default scratch memory reservation policy, this could result in
>>> reserving
>>>     up to 256 GB of scratch memory: 200% for the high-memory reservation and
>>> another
>>>     200% for per-node memory.
>> That calculation looks off. It _should_ be 200% once not twice. So 128
>> GB total. If the allocation came out via the global area, it should
>> _only_ be accounted to the global scratch size. Similarly, only the
>> allocations made specifically on that node should be counted for the
>> per-node scratch size.
>
> For example, if a system has only one node and 64 GB is allocated from
> that node before the kernel starts calculating the per-node and global
> allocations for scratch memory, wouldn't the per-node allocation also be 64 GB?
>
> If so, wouldn't that result in 200% of 64 GB being allocated for the global
> area and another 200% of 64 GB for the per-node area, resulting in 256 GB
> of total scratch memory allocation? Or am I missing something here?

It shouldn't. If the 64 GB of allocation was done with NUMA_NO_NODE, and
it _happened_ to land on node X, it should not be counted for per-node
sizing. It should count towards the global pool. Only allocations that
were explicitly requested with node X should be count for that node's
scratch size.

So on a one node system where 64G of memory is allocated with
NUMA_NO_NODE and 8G is allocated with node X, we should get 128G of
global scratch and 16G of per-node scratch, giving us a total of 144G.

I took a quick look and it looks like the problem might be that the
calculation for global scratch includes _all_ nodes in it. See
memblock_reserved_kern_size():

	for_each_reserved_mem_region(r) {
		...
                
		if (nid == memblock_get_region_node(r) || !numa_valid_node(nid))
			if (r->flags & MEMBLOCK_RSRV_KERN)
				total += size;
	}

And for global scratch we pass nid as NUMA_NO_NODE.

For KHO we could just drop the || !numa_valid_node(), but
memblock_estimated_nr_free_pages() seems to depend on that behaviour. It
wants to get _all_ allocations across all nodes. KHO only wants
allocations explicitly made with NUMA_NO_NODE.

But disclaimer: all this is from reading the code for maybe 15 minutes.
I didn't run anything and might be missing something. So please
double-check what I am saying.

Not sure how to fix this. Since memblock_estimated_nr_free_pages() needs
all the reservations anyway, perhaps open code a simple counting loop
there? And the drop the || !numa_valid_node() from
memblock_reserved_kern_size().

But yeah, it would be much appreciated if you'd care to fix this.

The fix should be a separete patch, since it fixes problems on all
platforms, and not just PowerPC.

>> But I have also noticed this problem on some of the systems Google has.
>> Which makes me wonder if scratch_size_update() is broken and
>> over-calculating. I have this on my TODO list and have been meaning to
>> look into it, but other things keep intervening.
>>
>> If you are interested, feel free to take it off my hands.
>
> Yes, I can take this up and propose patches to make crashkernel and
> scratch reservations work together.
>
> Based on my current testing, a Linux partition (powerpc) with 16 CPUs and 30 GB
> of RAM needs only 16 MB of scratch memory in the low-memory area when
> crashkernel=xxM is not specified.
>
> 16 MB is not much. I am also trying to get a larger Linux partition with 1000+
> CPUs to get a better idea of the limits for low-memory reservations.
>
> BTW, do you know the rationale behind the 200% value?
>
> I couldn't find any explanation for it in the commit message of
> 3dc92c311498c ("kexec: add Kexec HandOver (KHO) generation helpers")

We need to ask Alex (or maybe Mike?; I forget who added this).

But if I were to guess, I don't think there is much science involved
behind the number. Since the scratch lives across all kexecs, it needs
to be large enough in case the next kernel uses more memory. 200% sounds
"large enough".

>>>     For fadump, which is the powerpc-specific memory dump capture mechanism, the
>>> crashkernel
>>>     reservation can go up to 180 GB. In this case, we could end up reserving up
>>> to 720 GB of
>>>     scratch memory, which is too much. I agree that users can tune this, but I
>>> think the
>>>     default scale should be more reasonable for powerpc.
>> Once we fix scratch_size_update() to actually use 200% and not 400%,
>> perhaps that alone will be enough? If not, we can discuss reducing the
>> default scratch scale to maybe 150%. But I'd rather do it for all
>> platforms if we do it at all, because this problem doesn't seem specific
>> to PowerPC.
>
> Yes, it makes sense to have a general fix that works for all architectures.
>
> BTW, I was able to reproduce this issue on x86 as well. Please have a
> look at this:
>
> https://lore.kernel.org/all/008fe00e-fd52-4010-86ca-f0ab80a65a46@linux.ibm.com/
>
> I have also suggested an approach to handle this issue which is similar how you
> handle
> huge pages. Please share your thoughts on it.

I missed this.

We can exclude HugeTLB pages from scratch accounting because the series
updates HugeTLB to use a new routine called memblock_alloc_hugetlb() to
allocate pages. This special allocator makes sure the pages are
_outside_ of scratch even if scratch-only mode is used. Since HugeTLB
pages come outside of scratch, they don't get counted in scratch sizing.

We need to do this for HugeTLB mainly because we want to preserve
HugeTLB pages in the future, and pages from scratch can't be preserved.

We could perhaps do so for crash as well, but I need to think more about
this.

But at first glance, if you need to allocate crash super early, perhaps
memblock won't be able to cope. Because allocating crash outside of
scratch would depend on kho_extend_scratch() and that needs
memblock_allow_resize() to be called to be able to cope with multiple
memory regions.

[...]
>>> Could you please elaborate a bit on what makes the ordering tricky and what the
>>> main tradeoffs are between crash reservations and KHO? It would help me better
>>> understand the concerns here.
>> The problem today is that kho_preserved_memory_reserve() (called by
>> kho_mem_retrieve()) does a memblock_reserve() for each preserved folio.
>> So if you have a lot of order-0 (or, 4k) folios, you end up with a lot
>> of reservations in memblock. The large number of reservations can slow
>> down later memblock operations like allocations too since memblock might
>> have to walk through a lot of ranges to find free memory.
>>
>> We kind of work around this problem by calling kho_mem_retrieve() as
>> pretty much the last thing in the MM init. So all allocations prior to
>> this have already been fulfilled from scratch without any of the
>> reservations added, so it should be pretty fast. You only take the
>> performance hit at the end, where the only thing left is to release
>> pages to buddy.
>
> Ah, okay, that makes sense. Thanks for the clarification.
>
>
>> Even then, the memblock reservations can get pretty damn slow. In some
>> of my testing with under-load systems, preserving a 2G memfd with 4k
>> pages can go over **5 minutes** in only kho_mem_retrieve() if the folios
>> of the memfd are fragmented enough. Plus there is the memory overhead of
>> the regions in memblock.reserved.
>
> 5 minutes in kho_mem_retrieve(), which is primarily marking a bunch
> of memory as reserved using memblock, seems like quite a lot. If you
> have the test case handy somewhere, I would be interested in trying it
> myself, just to get a better feel for the issue.

I do, but unfortunately based on downstream code so it is neither useful
to you nor something I can share I think.

But your friendly neighbourhood LLM can help here. Ask it to preserve
you a memfd but fragment/shatter buddy blocks first. That's pretty much
how I wrote my test.

But also see [0] which fixes the problem. Maybe Tarun (+Cc) has a test
based on upstream that he can share?

[0] https://lore.kernel.org/kexec/20260903155907.1065681-1-tarunsahu@google.com/

>
> Regardless, I understand the concern now. From my perspective also, the
> current ordering of crashkernel and scratch memory reservations seems
> reasonable, because crashkernel is not as flexible as scratch reservation
> atleast on powerpc.
>
> On powerpc, the crashkernel offset is determined first, and the
> corresponding memory region is reserved. To make sure that no
> other reservation falls within the crashkernel region, the crashkernel
> reservation is one of the first reservations we make on powerpc.
>
> If we change this ordering, there is a possibility that a scratch
> reservation could end up in a region where the crashkernel is supposed
> to be placed. That would lead to crashkernel reservation failure.
>
> Also, reserving scratch memory at a location where the crashkernel
> cannot be placed could be problematic. Each architecture has its own
> constraints on where the crashkernel can be placed, so the available
> memory for scratch reservation may need to account for those constraints.
> Which I think too much to take care off...

That's a real problem. But I am hoping the restrictions are something
along the lines of "crash kernel must be in lowmem", so the lowmem
scratch already solves that problem?

>
> And, of course, moving kho_mem_retrieve()earlier during boot would
> also mean taking the performance hit you mentioned earlier.
>
> So let's keep the current ordering and find a way to make both
> reservations work with it: reserve the crashkernel first, and then
> reserve the scratch memory.
[...]

-- 
Regards,
Pratyush Yadav

