Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17296CAC592
	for <kexec@archiver.kernel.org>; Mon, 15 Sep 2025 16:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kVfY8snGhae1gNVF6XV+gVpmXREYRrkvAAv7AFGFTJ0=; b=kpMhs/Lr584dkmfD/quE8+ic/Z
	8dmTMALxUvm7ZsLlZT9Ojso1Bl149J8rOYh8erociz5Jrh4hk+qw8nvsHutPviJE/KLPuZTI8DA7R
	s5wOwVSiZNxRIvnx/rIi8nex4zXq8yAMCdRpZs1Y61dKaed/rWS2CYsTSlcBTnVi3hPxKZTahU1wp
	Fyoo5pXVYPmY++BKNKsg6VxMw80sTYvOcQ3Nvbrxwn2i3BHz6NoHMEuf4ppnzEpkuD2nP6udfibwz
	OjIdmeZCgYTwJ8MbIoyD8o1TC7fI3a//Co+e5EQCSrGByR2xkFsvGPSQenGiJ+cT9cn6exQyIuEho
	ecA4gKsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyCBv-000000058Uc-2r41;
	Mon, 15 Sep 2025 16:36:35 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyCBt-000000058UF-1eRQ
	for kexec@lists.infradead.org;
	Mon, 15 Sep 2025 16:36:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1148043797;
	Mon, 15 Sep 2025 16:36:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC6DC4CEF1;
	Mon, 15 Sep 2025 16:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757954192;
	bh=sFKlwRvnlnlP6/mO1ynOhYF6GOBs7Psz7KEyq9qFIiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iBuxdliijQWhpI3RVo+U8XJ/DnLZLfEukHRGl5721bxVKLIRHJVBjVfEKt6DfjfDS
	 whr5dFX9GZ6VWpSc7K8qe7RgRSh8AXt/Q9HJ1GOX6YTcO1FC3RNKjKiHZwf8/HVKE2
	 3IS/132qNOkP3R4c+xN7DObUcd757ZWC0tV0bAEPWBtvibWJzv3Vo7rHUchhvjxPpE
	 yR0ebyLV07fhRUVR22SpSRPYQCADdXGxUyGjlbPrZ8H5U/+j5jG67Q+Q6uG22akisP
	 uiJSaBX5O+jYoSOPl+t1jkI+dfk5sXJv05nhJq47C05CIAauKvtVfNqS9SVy8s1ptQ
	 m7BXo/kR5iHyw==
Date: Mon, 15 Sep 2025 19:36:25 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pratyush Yadav <me@yadavpratyush.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>, Chris Li <chrisl@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] kho: add support for preserving vmalloc
 allocations
Message-ID: <aMhAiR6qnXMA-c8r@kernel.org>
References: <20250908103528.2179934-1-rppt@kernel.org>
 <20250908103528.2179934-2-rppt@kernel.org>
 <mafs0ldmon784.fsf@kernel.org>
 <mafs0ldmnlmq0.fsf@yadavpratyush.com>
 <aMgey9qEC_XUejXm@kernel.org>
 <20250915144335.GL1024672@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915144335.GL1024672@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_093633_454075_BD5CC828 
X-CRM114-Status: GOOD (  14.34  )
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

On Mon, Sep 15, 2025 at 11:43:35AM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 15, 2025 at 05:12:27PM +0300, Mike Rapoport wrote:
> > > I don't suppose I'd insist on it, but something to consider since you
> > > are likely going to do another revision anyway.
> > 
> > I think vmalloc is as basic as folio.
> 
> vmalloc() ultimately calls vm_area_alloc_pages() -> alloc_pages_bulk_node_noprof()
> 
> KHO should have functions that clearly pair with the low level
> allocators struct page related allocators, alloc_pages(order),
> folio_alloc(), etc etc
> 
> ie if you call this allocator X then you call this kho preserve, this
> kho restore, and this free function Y.
> 
> Under the covers it all uses the generic folio based code we already
> have, but we should have appropriate wrappers around that code that
> make clear these patterns.

Right, but that does not mean that vmalloc preserve/restore should use the
public KHO APIs and avoid using internal methods.
 
> Jason

-- 
Sincerely yours,
Mike.

