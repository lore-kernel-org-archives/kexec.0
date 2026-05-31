Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B38CD6E52
	for <kexec@archiver.kernel.org>; Sun, 31 May 2026 18:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FAxCb8wt4MDofHdr7bDysjYqqW+0dO2zfePgF4EMiLc=; b=2mv4TIDzcF/wGCifLJUzjYw3hc
	rDxrRfUBAGLomS7mp1iVwV4v35Vo20mDRqH/AOY1TjVaj4iV1jntGaAlx/7vrmrJlGCH6QrZMS+H7
	CLBRmYSh2o4jaLYMMJSqcjLL3IRkXUe8vh0P8cwrPB1AoXWDFDopzxaBBfBg5480h17t48Ss1o+WE
	oSaEg2lKjDrpJyOQfpn1JoEoEXiH8uTTg29B5Clbdv4NyVNDj9muudmyCtvNqm1TNO0Zy9Jju5Ei3
	HzkaN+jx9dRFqrWRA84sv1s4EdI8ZMAm/dDpwyEW0KyiVzOnVKPq+jtweO8hGzuCzMZp6f63WJaSh
	6RtdI3tA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTlFp-00000009pal-2XxO;
	Sun, 31 May 2026 18:51:21 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTlFn-00000009pae-3hWG
	for kexec@lists.infradead.org;
	Sun, 31 May 2026 18:51:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 736826008A;
	Sun, 31 May 2026 18:51:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E041F00893;
	Sun, 31 May 2026 18:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780253477;
	bh=FAxCb8wt4MDofHdr7bDysjYqqW+0dO2zfePgF4EMiLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G+RQr4XcxsfKqn/e3SCfS3h9uirQNGVtyU7yFFUFtiaMRwqJpqhfubECNmUCiGK8P
	 YRX5pdjgi775fLQnPYtqhj26Lye5uqnK6D5co+pxhbEIfh1NlRlA1QGfLxlYTVUxKO
	 KhvpfEzmKfkvYVUhJgR21RNGCsHz24aAwBlNjDY6wQ6rBBuNOeDL3Q8dU2e56E8M4q
	 pDJrM3jMgyDlbzB+Q3tELtdfGg7ZrnSoE3Ht4caejeMbAt2e5hbvbpdjt0fnbGKM4w
	 6JYGnMwpbOlQdzWvpfqSL194r6Tq0eE+YauGMYOh5UD9qOapZm6PoN83BK6DXX02kw
	 V5xsWw1ScHvnQ==
Date: Sun, 31 May 2026 21:51:09 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Miu <jasonmiu@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] memblock: introduce MEMBLOCK_KHO_SCRATCH_EXT
Message-ID: <ahyDHVSH5eLsnp3C@kernel.org>
References: <20260429133928.850721-1-pratyush@kernel.org>
 <20260429133928.850721-10-pratyush@kernel.org>
 <agHGOxSnP_VraH1M@kernel.org>
 <2vxzecjhc2s8.fsf@kernel.org>
 <ag-a4ru9bMkDMthO@plex>
 <2vxzse7j7ai9.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzse7j7ai9.fsf@kernel.org>
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

On Fri, May 22, 2026 at 05:02:38PM +0200, Pratyush Yadav wrote:
> On Fri, May 22 2026, Pasha Tatashin wrote:
> 
> > On 05-11 18:46, Pratyush Yadav wrote:
> >> On Mon, May 11 2026, Mike Rapoport wrote:
> >> 
> >> > On Wed, Apr 29, 2026 at 03:39:11PM +0200, Pratyush Yadav wrote:
> >> >> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> >> >> 
> >> >> In the upcoming commits, the KHO will learn how to discover free blocks
> >> >> of memory by walking the KHO radix tree. It will then mark those regions
> >> >> as scratch to allow memory allocation in case scratch runs low.
> >> >> 
> >> >> To differentiate the extended scratch areas from the main scratch areas,
> >> >> introduce MEMBLOCK_KHO_SCRATCH_EXT. Use it when choosing memblock flags
> >> >> for allocations during scratch-only. Teach should_skip_region() to check
> >> >> for both flags before deciding if the region should be skipped.
> >> >
> >> > Why there's a need to differentiate SCRATCH and SCRATCH_EXT?
> >> > SCRATCH (I still hate the name) means "memory memblock can safely use for
> >
> >  +1000
> >
> > I also strongly dislike this name and mentioned it in another thread
> > earlier today.
> >
> > If we ever decide to s/scratch/something-else/ globally, that should be a
> > separate cleanup effort. However, since we are introducing a brand new flag
> > here, we can discuss a better name for the _ext portion to avoid overloading
> > the "scratch" concept.
> >
> >> > the allocations". Initially this memory comes from the reservations in the
> >> > first kernel, but if the second kernel can find more memory to extend it,
> >> > why that additional memory should be treated differently? 
> >> 
> >> Two reasons:
> >> 
> >> 1. We mark SCRATCH as MIGRATE_CMA. We don't want to do that for
> >>    SCRATCH_EXT since this memory can be used for non-movable
> >>    allocations.
> >> 
> >> 2. Gigantic (1G) huge pages can not be allocated from scratch. They can
> >>    be preserved memory and thus should not be allocated from SCRATCH.
> >>    See patch 12 that does allocations for gigantic huge pages only from
> >>    SCRATCH_EXT.
> >> 
> >> I will add this in the commit message for the next version.
> >> 
> >> Naming is hard, so if you have any better names I'm all ears :-)
> >
> > IMO, this scratch_ext is not "scratch" in the traditional KHO sense at all.
> > The traditional KHO scratch is what is passed from kernel to kernel and is
> > guaranteed to contain zero preserved memory. This new memory is not passed
> > from kernel to kernel and can contain preserved memory at runtime. It's
> > essentially just memory that we identify as currently unpreserved and release
> > early to the system.
> >
> > If we want to keep the naming aligned with the existing codebase for now:
> > MEMBLOCK_KHO_SCRATCH      -> original scratch
> > MEMBLOCK_KHO_UNPRESERVED  -> for the new memory (instead of SCRATCH_EXT)
> 
> UNPRESERVED sounds good to me. I will use that for the next revision
> unless Mike objects.
 
Can we make it shorter? ;-)

UNPRESERVED makes sense, although I'd love to completely remove KHO_ notion
and make the name reflect how it's used by memblock. I was toying with
PREFERRED instead of SCRATCH, but it didn't feel right enough.
With two of them that surely won't work :)

> > Alternatively, if we do want to tackle the global rename of "scratch" later:
> > MEMBLOCK_KHO_BOOTSTRAP    -> for the original scratch
> > MEMBLOCK_KHO_UNPRESERVED  -> for this new dynamic memory
> 
> Or perhaps BOOTMEM? I suppose either of the two are somewhat better than
> scratch.

Well, if we have BOOTMEM_HVO, we can have BOOTMEM_KHO as well :)

> Anyway, can we please do the SCRATCH rename as a separate series? I

Sure. We can continue bikeshedding in parallel.

> would like this series to not get muddled in the naming discussion. I
> will use UNPRESERVED for the new concept in v2 though.

That might warrant v3 even if everything else is perfect :)
 
> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.

