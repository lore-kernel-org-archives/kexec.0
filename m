Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90679CAC597
	for <kexec@archiver.kernel.org>; Mon, 15 Sep 2025 14:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xy5GXthPruk62ZFe8cTV3mdpr8J0Bk8I8JUuAq9hXaQ=; b=BqzsVO4NVuWxt3BRYFgqxa+fbJ
	Cj5gkwmX0xfVg/mQQqmVD91yCZ3Hbw0QGsIBdC5Joxk4v1/SwckKyHIo1eBy0scted51P/7fztBME
	92onOpQU6NqxAcdzSYBqO9toDME8F/TR0GW1Iq3oVRtYZE0V68b9UYQ0bDtGk63HPuC9kSOUhj212
	Fbm2bUNn4Sy3jmCrZfqNoGiSZxfg7e9Zz29wE+gKDT9Toz0omAAwAEvY1Fx8CtzkpsSOyw3zd08jP
	s5VCJuIeB4lqItn3bT1ItvCUonxs0gerAgK58OgCK2vpgR4VYfJlzCjJR5MqysPK5Mqzi6BfMd9j8
	Qe+Ey0zA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy9wc-00000004d5p-34Nl;
	Mon, 15 Sep 2025 14:12:38 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy9wa-00000004d4n-0Lg3
	for kexec@lists.infradead.org;
	Mon, 15 Sep 2025 14:12:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4FF3043EAA;
	Mon, 15 Sep 2025 14:12:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C51C4CEF7;
	Mon, 15 Sep 2025 14:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757945555;
	bh=7vkrO2WxsSWGdp6lM9Hcz4HCTPOoXFcwzPiEHHmzBQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xu/aNln+imqUsri9j70nV1KvIF4p98dag6M1lNrYGxFUCD6+B9Q9QdE+IbvcpraDj
	 +tvp2RSzHST/mVvGyQn8g8yRaufswSezFjAc4r0HllLrMgfd/7TBLoajKncb+rOgnx
	 yf07xYdO5umarJHmhwO/k1CpW/xc7Regd+H6FDUHfeGUpyQiv7VCYgn3gZfQSlySgg
	 jo9tLBPVco4L9uJ32BP50/ILm8XYr79T7+QRJ+dL7fplFJsRWgRZAlnTz+9afjJrA5
	 3xlojUa5SVh4qtR6CZGxV/bxvIjXFPfqfcTczB+NwgfPFp4F4u0eDokpq/HrcukpXn
	 ggk/7yST2yjAQ==
Date: Mon, 15 Sep 2025 17:12:27 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <me@yadavpratyush.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>, Chris Li <chrisl@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] kho: add support for preserving vmalloc
 allocations
Message-ID: <aMgey9qEC_XUejXm@kernel.org>
References: <20250908103528.2179934-1-rppt@kernel.org>
 <20250908103528.2179934-2-rppt@kernel.org>
 <mafs0ldmon784.fsf@kernel.org>
 <mafs0ldmnlmq0.fsf@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs0ldmnlmq0.fsf@yadavpratyush.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_071236_140535_BCD094CA 
X-CRM114-Status: GOOD (  22.83  )
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

On Tue, Sep 09, 2025 at 04:33:27PM +0200, Pratyush Yadav wrote:
> Hi Mike,
> 
> Couple more thoughts.
> 
> On Mon, Sep 08 2025, Pratyush Yadav wrote:
> > On Mon, Sep 08 2025, Mike Rapoport wrote:
> >> +
> >> +	while (chunk) {
> >> +		struct page *page;
> >> +
> >> +		for (int i = 0; i < chunk->hdr.num_elms; i++) {
> >> +			phys_addr_t phys = chunk->phys[i];
> >> +
> >> +			for (int j = 0; j < (1 << order); j++) {
> >> +				page = phys_to_page(phys);
> >> +				kho_restore_page(page, 0);
> >> +				pages[idx++] = page;
> >
> > This can buffer-overflow if the previous kernel was buggy and added too
> > many pages. Perhaps keep check for this?
> 
> Thinking about this a bit more, I think this should check that we found
> _exactly_ chunk->hdr.total_pages pages, and should error out otherwise.
> If too few are found, pages array will contain bogus data, if too many,
> buffer overflow.

Sure, I can add the checks, but it feels superfluous to me.
 
> Also, I am not a fan of using kho_restore_page() directly. I think the
> vmalloc preservation is a layer above core KHO, and it should use the
> public KHO APIs. It really doesn't need to poke into internal APIs. If
> any of the public APIs are insufficient, we should add new ones.
> 
> I don't suppose I'd insist on it, but something to consider since you
> are likely going to do another revision anyway.

I think vmalloc is as basic as folio. At some point we probably converge to 
kho_preserve(void *) that will choose the right internal handler. like
folio, vmalloc, kmalloc etc.

> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.

