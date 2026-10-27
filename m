Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B85606A338
	for <kexec@archiver.kernel.org>; Tue, 27 Oct 2026 09:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2Xgn9ee2;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oKfzWY26
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=gIudMcxLM3PAXcDR9AP1Q8SoYHkkEJyeOudQMB7zZi4=; b=2Xgn9ee2ZqFxy17I9kg99cjhyy
	fS3cySr2m6rwWbZiQfHrqGgFHernzXMvhzaSlrWqXsHgqZW+xEqiExTev6Orae/uiUta6AZIEp7oi
	qcv1s4B6BAsCNvAYUTPB6MrS3B+r3cIskCIwTOjF1WsVIsRffhPZNjUARi1SOUDNjxoXL8zh0se+G
	17LNRir7t1P3PNVQ2h02e175Avssk9Y7+x9A0Idb2OvwFn1nZ5MISLqmgkrkYxTiyNn562jELViF0
	DUuIC6umFSv+d6eYG5gJYQAkyevhRIBHBy1t31p7YoZ92R7dZ7gLEatcjIurZdhjiFf/HqKvUjR2e
	26h64wvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLdZ0-00000004AfI-18h1;
	Tue, 27 Oct 2026 09:33:50 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLdYy-00000004Aey-3cIX
	for kexec@lists.infradead.org;
	Tue, 27 Oct 2026 09:33:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0D5AC60136;
	Tue, 27 Oct 2026 09:33:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095811F031E4;
	Tue, 27 Oct 2026 09:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793093627;
	bh=gIudMcxLM3PAXcDR9AP1Q8SoYHkkEJyeOudQMB7zZi4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oKfzWY26WKA+bbXl616ae0oQzbA1G0xH9l9xh1gCxq3JDpe8yv97IXYdyOfHQ4eJr
	 t81Po39gxIf/641f8WvuMrH0lH9eqiO320Dz8AtVuz8iZU3projZTXWMccoEocNd/6
	 dh/GTbiarJBXfnd4LASC1pYnYHmLhWpnrmbzH4mHnkutHY5LYB08EzCW/mDgGMPsGa
	 qOAll772fgvtDpz0InhCuO+wST7Gz+w1BkWkocfnh9yOov6hzmvFdgw6+D2H+bUwyj
	 Zopnno5uue65TWC1px1FoMLDq3bw/n2ASl+8B3UapPHEfEcHiQNOqE7pRfjn9OD0/j
	 SZDcHaIh8SkjQ==
Date: Tue, 27 Oct 2026 09:33:31 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Hugh Dickins <hughd@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 27/46] mm/mmu_notifier: finish non-blocking interval
 invalidation on error
Message-ID: <auBvqDY8yyLk_UTm@gremlin>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-27-6f74bec9a5bb@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027-fixes_core-v1-27-6f74bec9a5bb@kernel.org>
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 12:17:47AM +0100, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
>
> When an ordinary MMU notifier rejects a non-blocking invalidation, the
> interval invalidation started beforehand is left unfinished: the caller
> skips mmu_notifier_invalidate_range_end(). Subsequent interval notifier
> operations can then wait forever.
>
> The only in-tree trigger is nouveau SVM, which uses both notifier types
> and rejects non-blocking invalidations. Reaping via the OOM reaper or
> process_mrelease() can therefore leave the GPU fault worker stuck,
> holding a reference that prevents the dying process's address space
> and memory from being freed.
>
> End the interval invalidation when an ordinary notifier fails a
> non-blocking invalidation, like mn_itree_invalidate() already does when
> an interval notifier fails. Make that handling clearer in the
> documentation of mmu_notifier_invalidate_range_start_nonblock().
>
> Fix generated by an LLM and sent by Josef Bacik in private.
>
> Fixes: 99cb252f5e68 ("mm/mmu_notifier: add an interval tree notifier")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: simplify description, update function doc ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  include/linux/mmu_notifier.h |  3 ++-
>  mm/mmu_notifier.c            | 17 +++++++++++++----
>  2 files changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
> index a11a44eef521e..5db78e5761c5c 100644
> --- a/include/linux/mmu_notifier.h
> +++ b/include/linux/mmu_notifier.h
> @@ -483,7 +483,8 @@ mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
>  /*
>   * This version of mmu_notifier_invalidate_range_start() avoids blocking, but it
>   * can return an error if a notifier can't proceed without blocking, in which
> - * case you're not allowed to modify PTEs in the specified range.
> + * case you're not allowed to modify PTEs in the specified range or call
> + * mmu_notifier_invalidate_range_end().
>   *
>   * This is mainly intended for OOM handling.
>   */
> diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
> index df69ba6e797f7..2e20f88e162d7 100644
> --- a/mm/mmu_notifier.c
> +++ b/mm/mmu_notifier.c
> @@ -569,16 +569,25 @@ int __mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
>  {
>  	struct mmu_notifier_subscriptions *subscriptions =
>  		range->mm->notifier_subscriptions;
> -	int ret;
> +	const bool has_itree = subscriptions->has_itree;
> +	int ret = 0;
>
> -	if (subscriptions->has_itree) {
> +	if (has_itree) {
>  		ret = mn_itree_invalidate(subscriptions, range);
>  		if (ret)
>  			return ret;
>  	}
>  	if (!hlist_empty(&subscriptions->list))
> -		return mn_hlist_invalidate_range_start(subscriptions, range);
> -	return 0;
> +		ret = mn_hlist_invalidate_range_start(subscriptions, range);
> +
> +	/*
> +	 * On error, the non-blocking caller is not allowed to call
> +	 * invalidate_range_end(), as in mn_itree_invalidate().
> +	 */
> +	if (ret && has_itree && !mmu_notifier_range_blockable(range))
> +		mn_itree_inv_end(subscriptions);
> +
> +	return ret;
>  }
>
>  static void
>
> --
> 2.43.0
>

--
Cheers, Lorenzo

