Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D86606A334
	for <kexec@archiver.kernel.org>; Tue, 27 Oct 2026 08:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vfte8Ljy;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cLX5cty9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=lc0U5Ze+hBCT9T6cAf8QTcqfqTu5UwDLhLRH+Lp9NjM=; b=vfte8LjylkejJ2pqIv4SOOISGw
	Q0QcDYUW2QFQqIDeOOLTiHeig0nlLkBYTFwAZEv/L290wlIgQrhBJjsLRocFPqv1dg0rucJTyOuFF
	62SODePLUs66s3VzS/os+nR4ohUR11af9DmaGDVfU1CHYQw4+Zmg92lACx1uX640zKhpA1pH+otfs
	noSkDY2g1kaIURgj3c7OhLCwEAaXFsJ2ErU8I/shx3FkdLMnbaknM0Dswg3hJPcfLH6qsR4ly60Gl
	6ruId5GnAT1zAMUfwM1b1ioyYc0jq+z2+ZGYkSmlmAzfFm57bDXf7Rl5A2Tm5SvY8hh3xS/eVXZrj
	vvBmkG8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLcte-000000046Cj-24uF;
	Tue, 27 Oct 2026 08:51:06 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLctd-000000046CN-3BeX
	for kexec@lists.infradead.org;
	Tue, 27 Oct 2026 08:51:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 54517601F9;
	Tue, 27 Oct 2026 08:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370ED1F01825;
	Tue, 27 Oct 2026 08:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793091064;
	bh=lc0U5Ze+hBCT9T6cAf8QTcqfqTu5UwDLhLRH+Lp9NjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cLX5cty9Fes4nyGOhdTXTwUi4CjHh2d6Exjv+rOUNmJ1hOpq301ah/59VYJa3KAfa
	 0JAFnIYv5q6uCZJiWZ7/JnzC3pOPhPL5VdEq05fzYEQAfU8x5PjoaLGCbo4oJkSshy
	 aEyuswfa3kOJCEFW345rfcWjsyhvaijqqaHgik6uB7QOrxdB7sJV1oJ6I3Q0c1V+Ry
	 Cf3Ekq4j3MW2BWPpctWVOXD4r4MRy4tI0wpG7A71nGLVk4q5d74j9EcT8h6eyujZ5T
	 xnvfCFG95f/Qz4H2P0ATu2ppTZylFpdC3r3f636dunxIG7AvtZ7dC6rCzDfglAN4g9
	 pK7u8ZerdMAkQ==
Date: Tue, 27 Oct 2026 08:50:46 +0000
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
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, Chris Mason <mason@kernel.org>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 28/46] mm/mmu_notifier: set ->mm only after mmgrab()
Message-ID: <auBl3iJyp0RQ-tEA@gremlin>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-28-6f74bec9a5bb@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027-fixes_core-v1-28-6f74bec9a5bb@kernel.org>
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

On Tue, Oct 27, 2026 at 12:17:48AM +0100, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
>
> Radeon uses a non-NULL notifier->mm to decide whether to call
> mmu_interval_notifier_remove() when freeing a buffer object.
> __mmu_interval_notifier_insert() sets ->mm before validating the range,
> so a wrapping userptr range can leave ->mm set after insertion fails.
> Cleanup then tries to remove an unregistered notifier for which no mm
> reference was acquired.
>
> Set ->mm only after mmgrab(), once insertion can no longer fail. While
> we could fix radeon's code instead, setting ->mm on success only makes
> the code more robust.
>
> Fix generated by an LLM and sent by Chris Mason in private.
>
> Fixes: 3506ff69c3ec ("drm/radeon: use mmu_interval_notifier_insert")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: simplify description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  mm/mmu_notifier.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
> index 2e20f88e162d7..a7bae5de5fedc 100644
> --- a/mm/mmu_notifier.c
> +++ b/mm/mmu_notifier.c
> @@ -947,7 +947,6 @@ static int __mmu_interval_notifier_insert(
>  	struct mmu_notifier_subscriptions *subscriptions, unsigned long start,
>  	unsigned long length, const struct mmu_interval_notifier_ops *ops)
>  {
> -	interval_sub->mm = mm;
>  	interval_sub->ops = ops;
>  	RB_CLEAR_NODE(&interval_sub->interval_tree.rb);
>  	interval_sub->interval_tree.start = start;
> @@ -964,8 +963,12 @@ static int __mmu_interval_notifier_insert(
>  	if (WARN_ON(atomic_read(&mm->mm_users) <= 0))
>  		return -EINVAL;
>
> -	/* pairs with mmdrop in mmu_interval_notifier_remove() */
> +	/*
> +	 * Pairs with mmdrop in mmu_interval_notifier_remove(). Drivers take a
> +	 * non-NULL ->mm for "registered", so set it only with the reference.
> +	 */
>  	mmgrab(mm);
> +	interval_sub->mm = mm;
>
>  	/*
>  	 * If some invalidate_range_start/end region is going on in parallel
>
> --
> 2.43.0
>

--
Cheers, Lorenzo

