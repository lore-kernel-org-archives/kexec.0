Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F2C0E92FDA
	for <kexec@archiver.kernel.org>; Mon, 29 Dec 2025 21:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rMhW+yvu6/id7BU+qbP/QMxlZM8OS62LLd4CPdduSgM=; b=ue6McQW7ON2b0v7QlP6eep3rtL
	RdIubB94Ker8k76YEDIGdtFjq+s/4B5SnaWdJSi9QGdK3Wyuo9JPr4LOLlVYBk9xZcVLOPkErcTIK
	+ZkkHsroiVFDv5D2kX8Wd2REkcv8q9OgummuSKiuBijMjQoKIonoclC3axWq3E6g9jVDbj98prpVL
	VxA/Br/BnDgN0c3s4vhXp00ZlUhCEuHAXaQXLxlrDfTPrXTivQpfJqx5vaZzenT6DVEVTWF1VEozi
	rWG8h0ym7putY4sGxeHMjNVyVI4uHS4AFxljroRpsZS34c/c41E0yEa6qrPi5dqkAnHDTHohI2/CL
	L2jPkJNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vaKOw-000000044KD-1ZfE;
	Mon, 29 Dec 2025 21:03:38 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vaKOu-000000044Js-0JVR
	for kexec@lists.infradead.org;
	Mon, 29 Dec 2025 21:03:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 42B7242D96;
	Mon, 29 Dec 2025 21:03:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4CB9C4CEF7;
	Mon, 29 Dec 2025 21:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767042215;
	bh=St9yHtoKNuj5bzirR5MFx8mFlGV9iQWRLtL5pw8U1Rk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gcteyj3Aoc5PX26BhXK+qvnvHIoGLumGj7KNLWYAS9qrMZaTabT3TzDsz1qmvaNR7
	 gHgb0Vq/WkeSwQRlePt6owfLz6Tpv/cJeX0ly0fJppDzVresb9CrJpFaZUSfqd3/jD
	 +AICONZ9pdTfnghCwA1keMfK0XLuFas7tmBh1rGbXg0bT0QlePOEo2WRWkuZsTETiG
	 eKy2+Hn0Ig7lDRMr/YieSPY7P3loWFk3XmCCG8eiQWHkTpC2GwbWNzMFTQr00d0GQk
	 GRA3RAPioimWdTRIYKe3OZ63IQVNkKrhc3EdgM+ZJ7s0504aeEaST4qKerm+3nt618
	 JrUsV0mI+ZWXA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Mike Rapoport <rppt@kernel.org>,
  Evangelos Petrongonas <epetron@amazon.de>,  Alexander Graf
 <graf@amazon.com>,  Andrew Morton <akpm@linux-foundation.org>,  Jason Miu
 <jasonmiu@google.com>,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  nh-open-source@amazon.com
Subject: Re: [PATCH] kho: add support for deferred struct page init
In-Reply-To: <CA+CK2bCjJWZG_rPoPsHWSxirmUCTOuFQzTCss2AKf9UqpThrdw@mail.gmail.com>
	(Pasha Tatashin's message of "Tue, 23 Dec 2025 12:37:34 -0500")
References: <20251216084913.86342-1-epetron@amazon.de>
	<aUFJH9xzJXYOt_X8@kernel.org>
	<CA+CK2bDGvgcGJijAtSSa2k_FWjnZXm2jRiFd6Z9-XjEQ-Y68DQ@mail.gmail.com>
	<aUF4fsWwD9BswkFh@kernel.org>
	<CA+CK2bB2mn5b0N9gs1UavYLUQhbpVvdo702oHZa15E9OaZkKWg@mail.gmail.com>
	<aUUYprAotKYMiEs0@kernel.org>
	<CA+CK2bD101cSC_7+OWkMei2QvUVjSaRLy+LboLe8Sz7KS3by4g@mail.gmail.com>
	<861pkpkffh.fsf@kernel.org>
	<CA+CK2bA1kYCf0BwhX3Sg9Ur82nK-7HPzs0sg6xbVWFAJaZLhpw@mail.gmail.com>
	<86jyyecyzh.fsf@kernel.org>
	<CA+CK2bDxnTEe9Ohq5zLuyF-jqgD0DPhfdq6z=yztUsXU5p5fSQ@mail.gmail.com>
	<863452cwns.fsf@kernel.org>
	<CA+CK2bCjJWZG_rPoPsHWSxirmUCTOuFQzTCss2AKf9UqpThrdw@mail.gmail.com>
Date: Mon, 29 Dec 2025 22:03:29 +0100
Message-ID: <864ip99f1a.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251229_130336_163623_9DC36F29 
X-CRM114-Status: GOOD (  50.23  )
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

On Tue, Dec 23 2025, Pasha Tatashin wrote:

>> > if (WARN_ON_ONCE(info.magic != KHO_PAGE_MAGIC || info.order > MAX_PAGE_ORDER))
>> > return NULL;
>>
>> See my patch that drops this restriction:
>> https://lore.kernel.org/linux-mm/20251206230222.853493-2-pratyush@kernel.org/
>>
>> I think it was wrong to add it in the first place.
>
> Agree, the restriction can be removed. Indeed, it is wrong as it is
> not enforced during preservation.
>
> However, I think we are going to be in a world of pain if we allow
> preserving memory from different topologies within the same order. In
> kho_preserve_pages(), we have to check if the first and last page are
> from the same nid; if not, reduce the order by 1 and repeat until they
> are. It is just wrong to intermix different memory into the same
> order, so in addition to removing that restriction, I think we should
> implement this enforcement.

Sure, makes sense.

>
> Also, perhaps we should pass the NID in the Jason's radix tree
> together with the order. We could have a single tree that encodes both
> order and NID information in the top level, or we can have one tree
> per NID. It does not really matter to me, but that should help us with
> faster struct page initialization.

Can we use NIDs in ABI? Do they stay stable across reboots? I never
looked at how NIDs actually get assigned.

Not sure if we should target it for the initial merge of the radix tree,
but I think this is something we can try to figure out later down the
line.

>
>> >> To get the nid, you would need to call early_pfn_to_nid(). This takes a
>> >> spinlock and searches through all memblock memory regions. I don't think
>> >> it is too expensive, but it isn't free either. And all this would be
>> >> done serially. With the zone search, you at least have some room for
>> >> concurrency.
>> >>
>> >> I think either approach only makes a difference when we have a large
>> >> number of low-order preservations. If we have a handful of high-order
>> >> preservations, I suppose the overhead of nid search would be negligible.
>> >
>> > We should be targeting a situation where the vast majority of the
>> > preserved memory is HugeTLB, but I am still worried about lower order
>> > preservation efficiency for IOMMU page tables, etc.
>>
>> Yep. Plus we might get VMMs stashing some of their state in a memfd too.
>
> Yes, that is true, but hopefully those are tiny compared to everything else.
>
>> >> Long term, I think we should hook this into page_alloc_init_late() so
>> >> that all the KHO pages also get initalized along with all the other
>> >> pages. This will result in better integration of KHO with rest of MM
>> >> init, and also have more consistent page restore performance.
>> >
>> > But we keep KHO as reserved memory, and hooking it up into
>> > page_alloc_init_late() would make it very different, since that memory
>> > is part of the buddy allocator memory...
>>
>> The idea I have is to have a separate call in page_alloc_init_late()
>> that initalizes KHO pages. It would traverse the radix tree (probably in
>> parallel by distributing the address space across multiple threads?) and
>> initialize all the pages. Then kho_restore_page() would only have to
>> double-check the magic and it can directly return the page.
>
> I kind of do not like relying on magic to decide whether to initialize
> the struct page. I would prefer to avoid this magic marker altogether:
> i.e. struct page is either initialized or not, not halfway
> initialized, etc.

The magic is purely sanity checking. It is not used to decide anything
other than to make sure this is actually a KHO page. I don't intend to
change that. My point is, if we make sure the KHO pages are properly
initialized during MM init, then restoring can actually be a very cheap
operation, where you only do the sanity checking. You can even put the
magic check behind CONFIG_KEXEC_HANDOVER_DEBUG if you want, but I think
it is useful enough to keep in production systems too.

>
> Magic is not reliable. During machine reset in many firmware
> implementations, and in every kexec reboot, memory is not zeroed. The
> kernel usually allocates vmemmap using exactly the same pages, so
> there is just too high a chance of getting magic values accidentally
> inherited from the previous boot.

I don't think that can happen. All the pages are zeroed when
initialized, which will clear the magic. We should only be setting the
magic on an initialized struct page.

>
>> Radix tree makes parallelism easier than the linked lists we have now.
>
> Agree, radix tree can absolutely help with parallelism.
>
>> >> Jason's radix tree patches will make that a bit easier to do I think.
>> >> The zone search will scale better I reckon.
>> >
>> > It could, perhaps early in boot we should reserve the radix tree, and
>> > use it as a source of truth look-ups later in boot?
>>
>> Yep. I think the radix tree should mark its own pages as preserved too
>> so they stick around later in boot.
>
> Unfortunately, this can only be done in the new kernel, not in the old
> kernel; otherwise we can end up with a recursive dependency that may
> never be satisfied.

Right. It shouldn't be too hard to do in the new kernel though. We will
walk the whole tree anyway.

-- 
Regards,
Pratyush Yadav

