Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B874C88E53
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 12:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TyC2gpsaXN4JBLWKNmm7J702tnSFqXToNgpiVHAQLkg=; b=vKWB6wRFRH2krDnS7Zy1kYLzPU
	UKLTDK15juWz1u+xPfINGgpdwQ2/EjxQiXHXEdP/xgsjjqzkhN8CG0JDYp6MLoeGsm3XsO3X6j9Vh
	80rF8l6j4UelKHEbcdAhVN/bj70OJO0tUWqnnqqmslY4mON9BvO7Ra64YoIBOK4c6ibdkUcY+XToO
	W9ozkzTbZdfmcsmAVQbrhS7dm4aI8F/KhuFUT6FAoi1cmRURkjczVGQXty58YdbzeaWYvk4iJLNS0
	8kbD7Qcv+QaiNhQcF5WezcGpgaq9fyWA+GyHQgRVeQqNnZQuk7GdxOQ3ebeVIH3YOPpcb4fkSvJKI
	nYM/Gcsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6S1x-00000006QNe-2wMP;
	Tue, 15 Sep 2026 12:12:57 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6S1x-00000006QNL-0zvy
	for kexec@lists.infradead.org;
	Tue, 15 Sep 2026 12:12:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 91133600D1;
	Tue, 15 Sep 2026 12:12:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8041F000FF;
	Tue, 15 Sep 2026 12:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474376;
	bh=TyC2gpsaXN4JBLWKNmm7J702tnSFqXToNgpiVHAQLkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dMecOfkGD9IVBc5A1wOJ7RaGIcLenu0fPPaNj6ULgetn0QKiid3SmCobziHh5dth/
	 nsDFEIkSHNG8yfPhdRtOGhuiglEEp7ZCUa/9k5QBoF5PdykrhfAZSEXZHUgx1U1BVK
	 xGkTFAq/PNyGxR26wFeby3W2dyLnU3iQBk2jD4P50ZyW+dlHVBfMUvzMpwJaiHHOfs
	 K2RpX/7yFozlGNknDOJ672FQSl3wdlWEAAzJJOS7dXtYw4h5/AJzF587NEwZ4BMyPj
	 9pfv4RMOw/V3LIbDZ0K3TuOXdj2r4FW+lleHFXb0J74YtGlz0qeP1Rx8Bjz9BMVApD
	 0vMrkjCKJ1HWA==
Date: Tue, 15 Sep 2026 13:12:54 +0100
From: Harry Yoo <harry@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>, kexec@lists.infradead.org, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rmikey@meta.com, riel@surriel.com, kernel-team@meta.com
Subject: Re: [PATCH v4 2/5] mm/memory-failure: libstub: install the
 poisoned-memory EFI table
Message-ID: <aqkyT0Ui9h5KWuzn@thinkstation>
References: <20260909-hwpoison-kho-v4-0-359313564495@debian.org>
 <20260909-hwpoison-kho-v4-2-359313564495@debian.org>
 <2c9a7bef-3189-4f78-a6cb-61d2f7afd643@app.fastmail.com>
 <aqKhgPKzRf0e22s3@gmail.com>
 <aqkIdVhoG2wwVBtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqkIdVhoG2wwVBtb@gmail.com>
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

On Tue, Sep 15, 2026 at 02:03:48AM -0700, Breno Leitao wrote:
> On Thu, Sep 10, 2026 at 06:11:53AM -0700, Breno Leitao wrote:
> > So I'd say we have two options:
> >
> > 1) Keep it similar to unaccepted memory, with 2M granularity.
> >    - Pro : Similar mental model as unnacepted memory
> >    - Cons: 2 MB might be a bit wasteful
> >
> > 2) Move to a linked list like the RFC, keeping it outside of the EFI
> >    table.
> >    - Pro: Reduce the memory granularities to page instead of 2M blocs.
> >    - Cons: Another way of passing memory information between kexec
> >      kernels.
> >
> > Any any other option or strong preference?
> 
> Since nobody voiced a strong preference, I will stick with option (1),
> the bitmap, for these reasons:

Not sure if this was discussed already, but perhaps we need to have
a chain of struct linux_efi_poisoned_memory rather than a single
bitmap, to easily add support for hot-added memory later?

Also, I wonder if some architectures have a scattered set of pfn
ranges so that the span from the start pfn to the end pfn being much
larger than the actual physical memory size.

If so it might make more sense to have a bitmap for each pfn range.

-- 
Cheers,
Harry / Hyeonggon

> 1) It follows the same mental model as unaccepted memory, which people
>    are already familiar with.
> 
> 2) It is simpler to query at boot time, especially as the number of
>    poisoned memory regions grows. Walking a bitmap is easier than
>    walking a linked list when freeing memory back to the buddy
>    allocator.

