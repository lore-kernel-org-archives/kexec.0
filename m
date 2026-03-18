Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E59C10854BE
	for <kexec@archiver.kernel.org>; Wed, 18 Mar 2026 09:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S30lli5ggsqIyJZJNjukotF0gHOe/hhFfpeT7wWOM3U=; b=ERoL+eLnqrrzmkF8R3KVle0Pu0
	KrCxo6W+zZnQyHnmYxV58M4r0wCZh7slAX7ovnEsODT3BBMVvIzRKy9/x53FfVCCnuQk2Wg00U/4B
	wXFHPX++4EAAvBwJfEvfcJGBuy2NDS8r1XSA/H7tJk4jPJVfFTL/AZOqZYQiecGd43nMGo2HSBVCQ
	TeKZCQKXNqmJVRtzMTbyat2JPqHk8Hp313RMBD+hYGmL3VOHyLEgub0EnLiocdRJ/xvjYSjWtNKLx
	ziJQe6/g/xx1V7ztTYl4wE24W+nTtqvbWrMpSaYA5KXii2evfCvSCNg/qeGMKft2S4ryiz0GfwiDt
	2WA9koMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2n3Q-000000087XX-2MUq;
	Wed, 18 Mar 2026 09:19:04 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2n3P-000000087XN-2NYy
	for kexec@lists.infradead.org;
	Wed, 18 Mar 2026 09:19:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 98965600AE;
	Wed, 18 Mar 2026 09:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFBAC19424;
	Wed, 18 Mar 2026 09:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773825542;
	bh=0JD2z9hbWyZ4tnmpCj9vi532auXFmzldAoMxVsPMnJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zvb2MB6S69hYoIHPGZ0bJZwkuTFepjTX/yV5EVd7ToI/nxFmvKEcFi3O+uZrzUw4R
	 zfNlhlNJeA+Dm77J9IwPwb3h7rDGehR1yRgiEYgzxvubydT6yVFBUO51ZOq4y+RmLo
	 nfA6XrFcP/0Qu1qRjfxonLvnckW4ZoumlxlkvCxvGLr3MnnO5mQZTj1msRe5vc+GSj
	 //lu61VMUjxdMWpMEP0WeUN9qIqDYzEcYmhmOjtVWnQ9EdvxOo0Fp5ZXCt5Xtl90ax
	 s1eh6eCKRzUS5NOHPlbqCXt6WlsV/hm0lcaZFGIR6PQ/GArZV9rp30G/tnA5oU9/s1
	 TTELR8V/h0c1Q==
Date: Wed, 18 Mar 2026 11:18:55 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Michal Clapinski <mclapinski@google.com>
Cc: Evangelos Petrongonas <epetron@amazon.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v7 0/3] kho: add support for deferred struct page init
Message-ID: <abpt_-9jxmK-N6Nu@kernel.org>
References: <20260317141534.815634-1-mclapinski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317141534.815634-1-mclapinski@google.com>
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

Hi Michal,

On Tue, Mar 17, 2026 at 03:15:31PM +0100, Michal Clapinski wrote:
> When CONFIG_DEFERRED_STRUCT_PAGE_INIT (hereinafter DEFERRED) is
> enabled, struct page initialization is deferred to parallel kthreads
> that run later in the boot process.
> 
> Currently, KHO is incompatible with DEFERRED.
> This series fixes that incompatibility.
> ---
> v7:
> - reimplemented the initialization of kho scratch again
> v6:
> - reimplemented the initialization of kho scratch
> v5:
> - rebased
> v4:
> - added a new commit to fix deferred init of kho scratch
> - switched to ulong when refering to pfn
> v3:
> - changed commit msg
> - don't invoke early_pfn_to_nid if CONFIG_DEFERRED_STRUCT_PAGE_INIT=n
> v2:
> - updated a comment
> 
> I took Evangelos's test code:
> https://git.infradead.org/?p=users/vpetrog/linux.git;a=shortlog;h=refs/heads/kho-deferred-struct-page-init
> and then modified it to this monster test that does 2 allocations:
> at core_initcall (early) and at module_init (late). Then kexec, then
> 2 more allocations at these points, then restore the original 2, then
> kexec, then restore the other 2. Basically I test preservation of early
> and late allocation both on cold and on warm boot.
> Tested it both with and without DEFERRED.
> 
> Evangelos Petrongonas (1):
>   kho: make preserved pages compatible with deferred struct page init
> 
> Michal Clapinski (2):
>   kho: make kho_scratch_overlap usable outside debugging
>   kho: fix deferred init of kho scratch
> 
>  include/linux/kexec_handover.h              |  6 ++
>  include/linux/memblock.h                    |  2 -
>  kernel/liveupdate/Kconfig                   |  2 -
>  kernel/liveupdate/Makefile                  |  1 -
>  kernel/liveupdate/kexec_handover.c          | 65 ++++++++++++++++++---
>  kernel/liveupdate/kexec_handover_debug.c    | 25 --------
>  kernel/liveupdate/kexec_handover_internal.h |  7 ++-
>  mm/memblock.c                               | 22 -------
>  mm/page_alloc.c                             |  7 +++

Although it's a small change, page_alloc maintainers should be CC'ed
Adding them now.

>  9 files changed, 74 insertions(+), 63 deletions(-)
>  delete mode 100644 kernel/liveupdate/kexec_handover_debug.c
> 
> -- 
> 2.53.0.851.ga537e3e6e9-goog
> 

-- 
Sincerely yours,
Mike.

