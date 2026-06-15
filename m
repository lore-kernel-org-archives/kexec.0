Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C61CD98CF
	for <kexec@archiver.kernel.org>; Mon, 15 Jun 2026 19:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h7B8DczUlZvoXStP+g9L9ex1t6hea3WLt+N+VMfAkwQ=; b=cO0VRrp0E6J3bVxJfZANM5kSFT
	6mA/zsCktPiTbP3Ka/mmWb6peLhYQJpyMsvrYgEQfFPTrGS+2z5n4vFxAeJ//sMLdOayE7oDOsmq1
	LOA15sudIS5BjEOGBDFmmg491nS0RBgv9/Mni2HnAEm1Sx3FUT1PFuLIIxhAectFl96dgs2Ma3i5u
	I74DQWEc8Px6bqunTRuwfqpwSDuD6lNR7PWn7McF+j+A6nSmWgIVPNTMq7yhiBx0Gt4qaz4X0zGBc
	cZUUMWJVtf4X/1CUotHGfg79MfAgt0HLY8ub/vlPAvvTyA81boMNfTNFnRSoVYI5eXFS438gWFHXU
	52gp4ysA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZDAH-0000000EmmI-2YLm;
	Mon, 15 Jun 2026 19:40:09 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZDAG-0000000EmmA-2B6y
	for kexec@lists.infradead.org;
	Mon, 15 Jun 2026 19:40:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D37FA40AAA;
	Mon, 15 Jun 2026 19:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C251F000E9;
	Mon, 15 Jun 2026 19:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781552407;
	bh=h7B8DczUlZvoXStP+g9L9ex1t6hea3WLt+N+VMfAkwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WKQue0AH0htjX4UnzX+Hx1GmH8vKLOTbqpeJ7AM4DBR/0gN8Lz3FXAQtOwe0fysZY
	 +6C81/uwDS4zGXp7VX5qIkE8+MraetDUvRtVpm5Wz3LiSS7TXWi6GH3fhFrNlFI5UN
	 4I7339GVUqdaNYa/SMZ9Hg1K+aB8gXDwIgPG4AYl/1GS2xwkXnmDLC9ZSbkWTMWLvb
	 snXbil0WlO5o6bCGeqAkOAMKayAT+77FzegUGxIekv+Ho6iASyP9CXNnnrS1bdiV+/
	 7Pb2XnLtIB1fo3koDUQ9pd+XgQwqi5VnPipybsMlwvUov2Y5uBd7mppz9OI/Y2ZgIz
	 pEC8BIWKh32bw==
Date: Mon, 15 Jun 2026 22:40:00 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Miu <jasonmiu@google.com>,
	Jork Loeser <jloeser@linux.microsoft.com>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 16/18] memblock: make HugeTLB bootmem allocation work
 with KHO
Message-ID: <ajBVELPz_tLKex8P@kernel.org>
References: <20260605183501.3884950-1-pratyush@kernel.org>
 <20260605183501.3884950-17-pratyush@kernel.org>
 <178143855120.2123877.5431342391381982046.b4-review@b4>
 <2vxzpl1soris.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzpl1soris.fsf@kernel.org>
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

On Mon, Jun 15, 2026 at 03:35:39PM +0200, Pratyush Yadav wrote:
> On Sun, Jun 14 2026, Mike Rapoport wrote:
> > On Fri, 05 Jun 2026 20:34:49 +0200, Pratyush Yadav <pratyush@kernel.org> wrote:
> >
> >> First, it does not use mirrored memory for hugetlb. Mirrored memory is a
> >> limited resource that is best saved for kernel data structures, not user
> >> memory.
> >> 
> >> Second, if the memory found overlaps with KHO scratch areas, it discards
> >> the memory and retries.
> >
> > This sentence is somewhat hard to parse.
> 
> Okay, let me retry:
> 
>     Second, if the free memory area found by memblock_find_in_range_node()
>     is a part of a KHO scratch area, the free area is not used. Allocation
>     is retried starting after the free area to ensure no hugepages come from
>     KHO scratch.
> 
> Any better?

Yep :)
 
> >
> >>
> >>
> >> diff --git a/mm/memblock.c b/mm/memblock.c
> >> index 6349c48154f4..131e54dd5d8d 100644
> >> --- a/mm/memblock.c
> >> +++ b/mm/memblock.c
> >> @@ -1756,6 +1761,69 @@ void * __init memblock_alloc_try_nid_raw(
> >> [ ... skip 51 lines ... ]
> >> +		if (memblock_bottom_up())
> >> +			start = addr + size;
> >> +		else
> >> +			start = addr - size;
> >> +
> >> +		goto retry;
> >
> > Hmm, two goto retry don't seem nice :/
> > Although I can't see how to imporove it really.
> 
> Dunno, looked easy enough to understand to me.
> >
> > Maybe add a helper for going the node fallback?
> 
> There is a small downside. There will then be no way to know the
> fallback was tried already, so if a retry is done because of scratch
> overlap, the fallback needs to be done again.
> 
> I don't think it should be too bad, so if you still prefer this then I
> can do it.

Let's keep it for now, maybe will find something smarter later.
 
> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.

