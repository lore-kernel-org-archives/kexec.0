Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B234F606A31A
	for <kexec@archiver.kernel.org>; Tue, 27 Oct 2026 08:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bZhb6zKw;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EBNUrHgp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=LLjeyafLWq906e/KlV7udPCtdijPfLEIi8SSit6QWfU=; b=bZhb6zKwXqBq6ySy1H/92RsjfO
	S7L0v7NuW73otRWylWYxn3fHDWC89NFgmQfaGOKXyivM1GxdmbSg6ousUwLsY6rmUWYvtMgsxvZnl
	eHT+MvH5hID5Lm15YS088T7oHV1GFKLwZ2C3+RWj2049owHjxvUSzNpgIBO1VvP2gyAgUFRUh5lZe
	UvHTEttIPSrQxYgrIRCi25RykSxvXAalzNb+pShjFJmS3L0hn5anGungQRU1V1ZQEMeXc3FbUgEQY
	tYvCJpm1xIsJwnwaW0CKGvBinOvZftHYlGgFyDrZDudCnkAz/qG7ABc0h981AOmlCE49WEAIZUi9f
	1AxE4Y9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLcyf-000000046ia-0yUu;
	Tue, 27 Oct 2026 08:56:17 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLcyd-000000046iT-2pjG
	for kexec@lists.infradead.org;
	Tue, 27 Oct 2026 08:56:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 54FED405EF;
	Tue, 27 Oct 2026 08:56:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDEAE1F01828;
	Tue, 27 Oct 2026 08:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793091375;
	bh=LLjeyafLWq906e/KlV7udPCtdijPfLEIi8SSit6QWfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EBNUrHgpyjuV+uDWfTfjiZjrVUSiaANjjrfsc3nkFZWTw82J+OqHpWvLIciRV9TNx
	 2ZYRqlKawGk39ZaulprNCM2tNwh2zki3TsMiowIH13vcslKJA7833dN8riI4s3kDAM
	 Q3qfXOkNFX5VxnUmiQtmg5QWQCqFP+dYzLxz19uSTgl5bash6cqoBqqOskiaRk2/C6
	 RL8HDc2rNHtv0XIn1ejrOpB1M3CI9bhEBJhZRP1bllfI+FRzWtybU61jzIzwI0z0Od
	 /meOw5AGq2fgtE0iXpBuP7zSuxszxjxhbNpF90J6AdO/j7okIvx+jpqUI1F2fZM2tZ
	 5wOIAvJFgckew==
Date: Tue, 27 Oct 2026 08:55:58 +0000
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
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 44/46] mm/cma: don't release CMA pages still in use
Message-ID: <auBmRQDzFPea5FeS@gremlin>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-44-6f74bec9a5bb@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027-fixes_core-v1-44-6f74bec9a5bb@kernel.org>
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

On Tue, Oct 27, 2026 at 12:18:04AM +0100, David Hildenbrand (Arm) wrote:
> From: Rik van Riel <riel@surriel.com>
>
> When a driver calls dma_free_contiguous() before quiescing DMA, the
> page might still have a reference from the device.
> put_page_testzero() there returns false, WARN fires, but the code proceeds
> to free_contig_frozen_range() putting a live page onto buddy and clearing
> the bitmap. A subsequent allocation can hand the same PFN to a new
> owner while the original holder still references it.
>
> A concurrent put_page() that drops the last reference between the
> testzero loop and free_contig_frozen_range() can double-queue the page
> via page->lru, corrupting buddy lists.
>
> Avoid the corruption by not freeing a CMA region if any of the
> pages inside are still in use.
>
> Make it explicit in the warning that the driver allowed a leak.
>
> While at it, use page_ref_freeze() to make the semantics clearer and
> switch to pr_warn_ratelimited().
>
> Fixes: 9bda131c6093 ("mm: cma: add cma_alloc_frozen{_compound}()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Link: https://patch.msgid.link/20260811132045.5f114772@fangorn
> [ david: use page_ref_freeze() + pr_warn_ratelimited() ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  mm/cma.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/mm/cma.c b/mm/cma.c
> index a10ea37a261da..871f95c9ae9f0 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -1020,7 +1020,7 @@ bool cma_release(struct cma *cma, const struct page *pages,
>  		 unsigned long count)
>  {
>  	struct cma_memrange *cmr;
> -	unsigned long ret = 0;
> +	unsigned long leaked = 0;
>  	unsigned long i, pfn;
>
>  	cmr = find_cma_memrange(cma, pages, count);
> @@ -1029,9 +1029,13 @@ bool cma_release(struct cma *cma, const struct page *pages,
>
>  	pfn = page_to_pfn(pages);
>  	for (i = 0; i < count; i++, pfn++)
> -		ret += !put_page_testzero(pfn_to_page(pfn));
> +		leaked += !page_ref_freeze(pfn_to_page(pfn), 1);
>
> -	WARN(ret, "%lu pages are still in use!\n", ret);
> +	if (leaked) {
> +		pr_warn_ratelimited("%lu pages are still in use, not freeing CMA region!\n",
> +				   leaked);
> +		return true;
> +	}
>
>  	__cma_release_frozen(cma, cmr, pages, count);
>
>
> --
> 2.43.0
>

--
Cheers, Lorenzo

