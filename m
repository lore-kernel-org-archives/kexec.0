Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16FBF8D753
	for <kexec@archiver.kernel.org>; Thu, 16 Apr 2026 15:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0hD33l6NeAodFbLOBu/cQL2Ziw2Dhq18nL8kGZwsI+M=; b=LjipzP7nQUZNkDjFetnn3sP+dv
	mrESvQBaIsHF9nZ01efV7i+gJ5p8QmbYq+eDbcPRquY5Eq/DndajgnvlZAjo2ClBwuNPX2d2/e2D0
	xjayclH+Ex/7RoXaE0d+k3wRduP1ydPhBLdgbDwF0JpBoionDdlJvIXp+WuvIyNDNmaATqZfWiH+0
	0Wf4FDbSB7OBwj5q+7KJ3xiPWvxleOUWlrCD7Vtz709MMXhkmjpLUxoUU8xCgYAmnOYm1mPiFFYW+
	QYOnSRfKxyf8nrxVsocQG/4EpnCEOdwEfwfZfzTQsgjJnfsz7RNUlDgJJVyZGBbc+hnqwNNZPMlIy
	/90jYYuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDOCz-00000002afc-2uXB;
	Thu, 16 Apr 2026 15:00:45 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDOCx-00000002aex-2uUm
	for kexec@lists.infradead.org;
	Thu, 16 Apr 2026 15:00:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7D3EC40327;
	Thu, 16 Apr 2026 15:00:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B3FC2BCAF;
	Thu, 16 Apr 2026 15:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776351642;
	bh=JUgUGNgPbhEBAHbcpHrlNrJNbNlPc7RtPYnZIl6AaJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UwSbvBSi8VF3f3Tq5qpdorKIGcCcVEyMQn5IR0/uhNUFHF44DXbV9J7RD7w2qdGp3
	 g7H+22JhxJTIT68QSarpWVwYMG6oILD9LlwLOPEcJ90KdS7912K3NJX2ukivcEw21s
	 +e5Oi3qWujsjPr/V8KeFR8iszmfR2eLfsSPe00GI26iidvTiHRmNl8+wuiWJ0YCDGx
	 +I9Xdku6QxtYuUlgrBYG4FfAHUbGwLht+n+vwHGt2EgMlA5ouC6LZ5GDdUpqNehuzw
	 6ZgOqrJbVuj59hNB9qcd9DpJcBpJlsSoUwJGnOgcqb4bOB0Et4/z6FolG56MMiyb3/
	 zqIK4vTquolsA==
Date: Thu, 16 Apr 2026 18:00:33 +0300
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
Subject: Re: [PATCH v8 0/2] kho: add support for deferred struct page init
Message-ID: <aeD5kboEdzwuR4P_@kernel.org>
References: <20260416110654.247398-1-mclapinski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416110654.247398-1-mclapinski@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260416_080043_769995_1C328CCB 
X-CRM114-Status: GOOD (  20.41  )
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

On Thu, Apr 16, 2026 at 01:06:52PM +0200, Michal Clapinski wrote:
> When CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled, struct page
> initialization is deferred to parallel kthreads that run later in
> the boot process.
> 
> Currently, KHO is incompatible with DEFERRED.
> This series fixes that incompatibility.
> ---
> v8:
> - moved overriding the migratetype from init_pageblock_migratetype
>   to callsites
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

Any chance you can clean that monster and send it as patch 3?
There's no real difference between core_initcall() and module_init() with
respect to that deferred page initialization, they both run after the
memory map is fully initialized.

> This patch probably doesn't apply onto anything currently.
> It's based on mm-new with
> "memblock: move reserve_bootmem_range() to memblock.c and make it static"
> cherrypicked from rppt/memblock.

You can base on for-next in the memblock tree:
https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock

> Evangelos Petrongonas (1):
>   kho: make preserved pages compatible with deferred struct page init
> 
> Michal Clapinski (1):
>   kho: fix deferred initialization of scratch areas
> 
>  include/linux/memblock.h           |  7 ++--
>  kernel/liveupdate/Kconfig          |  2 --
>  kernel/liveupdate/kexec_handover.c | 52 +++++++++++++++---------------
>  mm/memblock.c                      | 41 +++++++++++------------
>  mm/mm_init.c                       | 27 +++++++++++-----
>  5 files changed, 69 insertions(+), 60 deletions(-)
> 
> -- 
> 2.54.0.rc1.555.g9c883467ad-goog
> 

-- 
Sincerely yours,
Mike.

