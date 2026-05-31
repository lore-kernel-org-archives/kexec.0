Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73C7CD6E56
	for <kexec@archiver.kernel.org>; Sun, 31 May 2026 18:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gDniEbMiB4BenIn/IEHnw5RVCpuSrlVy3WIRuPpMhNc=; b=t24ArGPt+EH0hW/HrZszleG9Pn
	KfXudWNCeTP1DOAeq+TZ5iLF2eplWW4+7lhQKRr4dJmPvZGP7eZTCbRdxJZVLfENd5awUrGhNPcIR
	g1+oQmdItGKIMjhD/DZ6JEKX3GlyJEZP6XJgObualSWqdEdC56g6ysA7101E2vPJ2wmYnq1RrN2q4
	0JRv02rVJhN/BICUHRtte0U8es5lrc5CnWSzH2TFu+6Vb1trJhai9eSuM9QXhyasIc5D7FhvEKB7J
	4vhAA2KI0o23vrL+0p6vB+/QbEKwNYSQYM0LpaPbgpWElSnzdSqIl6QNsYrLpe3ARoA4UnNuEZgRI
	75ap9C9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTl58-00000009pKF-3A0f;
	Sun, 31 May 2026 18:40:18 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTl56-00000009pJr-2qp2
	for kexec@lists.infradead.org;
	Sun, 31 May 2026 18:40:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8FC2042D61;
	Sun, 31 May 2026 18:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C921F00893;
	Sun, 31 May 2026 18:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780252815;
	bh=gDniEbMiB4BenIn/IEHnw5RVCpuSrlVy3WIRuPpMhNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EfEXoBUSjPod8EiHuVf9Lmqp1p4/N3NVQlW5lhUe0FyWBvAktt2PWa624j/IOePkn
	 0Ewu+Agvw+xgJUP1FX3jaxtxBh4l4ZEIHu/P767mkGRGv+d/L0vBSmquJZ0DNd4G2S
	 L0Vw2YD1OmSRoghPver90S6gJIFsTqVfmEIFMKmwtELvbyQRz48Wj/WkWjbuBx62zW
	 NziZEd9RUrErHU38a2ERl7/PFegHNGF2rUikdBUOD3gFdSKn79Z5/9tMz8YG62/lMB
	 x9/lSQ3C4QTa8Nd2lIQi7Tq3/70a0zbjjtGb9wGeAyHy7iEPCmwXeBcBBIhjSl/zPW
	 jwwu4bwp5UgXw==
Date: Sun, 31 May 2026 21:40:07 +0300
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
Subject: Re: [PATCH 12/12] mm/hugetlb: make bootmem allocation work with KHO
Message-ID: <ahyAhyVGzXdrigIw@kernel.org>
References: <20260429133928.850721-1-pratyush@kernel.org>
 <20260429133928.850721-13-pratyush@kernel.org>
 <agmS5yZRflzN1M8U@kernel.org>
 <2vxzo6i37bs6.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzo6i37bs6.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260531_114016_762218_86ADEECA 
X-CRM114-Status: GOOD (  12.90  )
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

On Mon, May 25, 2026 at 05:24:09PM +0200, Pratyush Yadav wrote:
> On Sun, May 17 2026, Mike Rapoport wrote:
> > On Wed, Apr 29, 2026 at 03:39:14PM +0200, Pratyush Yadav wrote:
> >> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> 
> So, in summary, I would like to pursue option 1 and try to make it more
> appetizing. But I would like to at least know if you hate the "extended
> scratch" (ignore the name) as a concept or only the code it results in.

Let's retry this one :)

I looked more closely, and it seems that mixing SCRATCH and SCRATCH_EXT
should be a lesser headache than going with option 4.

Tracking the changes in gigantic pages in hugetlb also does not seem
something we'd like to pursue especially considering that memory from freed
or demoted gigantic pages could be reserved.

If we add a dedicated memblock_something to allocate gigantic pages, we
can reduce branching in alloc_bootmem() to

	if (cma)
		do_cma()
	else
		do_memblock()

For hugetlb_cma we might want to teach CMA to create pre-allocated areas
and then it could reuse the same memblock API. This seems useful even
regardless of KHO.
 
-- 
Sincerely yours,
Mike.

