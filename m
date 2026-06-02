Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CF5CD6E68
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 13:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cIFsvZ8o1klM9coqPWB+8+5GuojIlmrjo3nZO0SjZgY=; b=Z37Iz+yu5r2eykbo7Tz5XtlU3q
	PF0MH5ObqhC9i+ZWLieu2BT09Q2gQq1kvhvt8PGAQQ+7+kahB4JPMjtDoBY96UTo8oaUYp9emIEBw
	SDcYOxUUBuDUSirh2l0LmjYLnp/WizTN12V0htsepivXAdGddWVvquFSqm1z3zk+nSNhrkoH8Hx82
	8Fy0ONBeUlQ5A4IlqFAcwg1DgO+Org1Zs2OXEkLqMH/VQ3BNWlQJkZ1lrYpgkJZH2Z6qWl3fktxPy
	VvCbCN7cJWRIcyrQt+7xr9nqacOPcN8ie1aewt8E5BHAlVADPaLlxKLgCFMbQBRNzeL6dR5Z+0kRv
	e7psaNDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUPHb-0000000D7lU-0KUY;
	Tue, 02 Jun 2026 13:35:51 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUPHY-0000000D7lI-2dgp
	for kexec@lists.infradead.org;
	Tue, 02 Jun 2026 13:35:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D702A60123;
	Tue,  2 Jun 2026 13:35:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25F01F00893;
	Tue,  2 Jun 2026 13:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780407347;
	bh=cIFsvZ8o1klM9coqPWB+8+5GuojIlmrjo3nZO0SjZgY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=nFQVeFrO5qWsMa3rkGphURuuAJAkKJpVFsxhAS00xM2iY6Xa4CocSyrWIeK+pUzW7
	 9Df0aHNWngtOsJfkaqKnenGpysTrZa+Hp8sGt4qKTmPrKxkTwxdKM94fkhfZWEc0TZ
	 Ks4iNkbGI5vIlAHXND8JluSSRXTaZvzl9muh85TqxIz+GhpKgLyBSBGCUSO6v+xgad
	 lqqIrX6sS9hf5yOus/I4fOyWvH0kYnjk/5xxqsaEkwAR2KP7Y29uc+porWx7LMeReS
	 N7l8mfCMZBxJf+HfOPjNFrawGaeCVtlru1mFpNxoa3116/fEVbQG+6p2/XIrpEQHnU
	 nDuwvVpdeF/dg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Alexander Graf <graf@amazon.com>,  Muchun
 Song <muchun.song@linux.dev>,  Oscar Salvador <osalvador@suse.de>,  David
 Hildenbrand <david@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Jason Miu <jasonmiu@google.com>,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/12] mm/hugetlb: make bootmem allocation work with KHO
In-Reply-To: <ahyAhyVGzXdrigIw@kernel.org> (Mike Rapoport's message of "Sun,
	31 May 2026 21:40:07 +0300")
References: <20260429133928.850721-1-pratyush@kernel.org>
	<20260429133928.850721-13-pratyush@kernel.org>
	<agmS5yZRflzN1M8U@kernel.org> <2vxzo6i37bs6.fsf@kernel.org>
	<ahyAhyVGzXdrigIw@kernel.org>
Date: Tue, 02 Jun 2026 15:35:44 +0200
Message-ID: <2vxzpl29dpzj.fsf@kernel.org>
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

On Sun, May 31 2026, Mike Rapoport wrote:

> On Mon, May 25, 2026 at 05:24:09PM +0200, Pratyush Yadav wrote:
>> On Sun, May 17 2026, Mike Rapoport wrote:
>> > On Wed, Apr 29, 2026 at 03:39:14PM +0200, Pratyush Yadav wrote:
>> >> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>> 
>> So, in summary, I would like to pursue option 1 and try to make it more
>> appetizing. But I would like to at least know if you hate the "extended
>> scratch" (ignore the name) as a concept or only the code it results in.
>
> Let's retry this one :)
>
> I looked more closely, and it seems that mixing SCRATCH and SCRATCH_EXT
> should be a lesser headache than going with option 4.

I also had some time to ruminate on this. I still think option 1 has the
most promise, but my opinion on option 4 has improved a bit. While I
still am not sure adding a 3rd phase to struct page/MM init (early ->
deferred -> KHO reserved blocks) is a good idea, I think it might not be
as bad as I first thought. Dunno...

Anyway, for now I think I will try to make option 1 more appetizing.

Here's an idea I want to try out: I get rid of SCRATCH_EXT and mark the
free blocks as SCRATCH. For HugeTLB, I can teach the special
memblock_alloc_hugetlb_something() function to exclude scratch areas
when looking for free memory ranges. So core memblock does not get a new
memory type, and the complexity of hugepage allocation does not leak
into memblock.

How does that sound?

>
> Tracking the changes in gigantic pages in hugetlb also does not seem
> something we'd like to pursue especially considering that memory from freed
> or demoted gigantic pages could be reserved.
>
> If we add a dedicated memblock_something to allocate gigantic pages, we
> can reduce branching in alloc_bootmem() to
>
> 	if (cma)
> 		do_cma()
> 	else
> 		do_memblock()
>
> For hugetlb_cma we might want to teach CMA to create pre-allocated areas
> and then it could reuse the same memblock API. This seems useful even
> regardless of KHO.

Sorry, I don't get what you mean by this. What pre-allocated areas? When
creating CMA areas it calls cma_alloc_mem() which calls into memblock.
What would we change about this?

-- 
Regards,
Pratyush Yadav

