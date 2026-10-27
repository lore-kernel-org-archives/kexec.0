Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CEF606A31B
	for <kexec@archiver.kernel.org>; Tue, 27 Oct 2026 09:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=O5o/J06T;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U7+fBT3l
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=+rNSdhvOTHmuEN3Ml/bfsrTqF8UwvJdcqDi4DNQ6sTg=; b=O5o/J06TZlSPQ/TwnR5f0sf9qc
	GyBTkJ1lWRmnzMiguNFwMoCT5xEOfW6xxK7I9EJCV7ERiDXdAy4mNs3ZB7ruZ9wEyEBbjfw/B/KbJ
	I73dqlrRPU1uAc7XocJXT589pnDWHZyYxivtwSyJ0L4qkd7PAeiZpVLwct/K8PcK7sJO8tz4vB6/v
	2f962l8vWhPm3zAbowHPNAdnPIuqcUcWRSRbGBE6dHTFhdNZsQR+s2foPDgkvB43MR0mIRDMKGsYH
	Tc+LN99cJKcGABoE6aT2Uyeef80LuUgZ8aqy7LP1+pXweppS7FXNEMV7Wl/w048DnSntS7jkUaEUo
	iaBiwYvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLdcw-00000004BSy-42e4;
	Tue, 27 Oct 2026 09:37:54 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLdcv-00000004BSj-04on
	for kexec@lists.infradead.org;
	Tue, 27 Oct 2026 09:37:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6CCF042CE9;
	Tue, 27 Oct 2026 09:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490C11F01825;
	Tue, 27 Oct 2026 09:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793093872;
	bh=+rNSdhvOTHmuEN3Ml/bfsrTqF8UwvJdcqDi4DNQ6sTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U7+fBT3lehpQpFc3uJKZHtVpRgi1GtGHT6z3b8kE2S6FeF6bFDBDYsG/DhyOz1wlU
	 gkZvgV/b8GwC5hBF2vuMNqTpih+mBOGm/magVJ+5tlmYMUc8rC0HgDbxkq4C2ZdX7/
	 ykFSl8AC+Hlev3LyWJ5Ey8IgtYvUDz6NSxnqxhKKoOE4gmRJYKRD4ktRxpkFHa/N0B
	 GZx6g/C9Es4dpnIsGGa84PHZ4w1B6j/LHsH9niHHf9ry4zHK8ev9PN5ziVl0zIXEG7
	 p4yl/pvZrQHfp2KrQDErkAMPWJNescqIgRyziMHz4MrRviwMpP912C23Dpz/85S7eu
	 i5GpXe5pXwalg==
Date: Tue, 27 Oct 2026 09:37:34 +0000
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
Subject: Re: [PATCH 21/46] mm/gup: fix out-of-bounds write for nr_pages == 0
 in GUP-fast
Message-ID: <auBwudfT22AZ82GB@gremlin>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-21-6f74bec9a5bb@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027-fixes_core-v1-21-6f74bec9a5bb@kernel.org>
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

On Tue, Oct 27, 2026 at 12:17:41AM +0100, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
>
> With nr_pages == 0, GUP-fast still enters its page table walk and can
> write past the caller's page array. The old end <= start check caught
> empty ranges, but was replaced with an overflow check.
>
> Users such as OrangeFS can pass a zero page count derived from a
> userspace-supplied length. So let's return zero for nr_pages == 0 before
> starting the walk, just like GUP-slow.
>
> Fix generated by an LLM and sent by Chris Mason in private.
>
> Fixes: c28b1fc70390 ("mm/gup: reorganize internal_get_user_pages_fast()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: simplify description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  mm/gup.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/gup.c b/mm/gup.c
> index 47e7ae152cdf1..9906965893431 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -3204,6 +3204,9 @@ static int gup_fast_fallback(unsigned long start, unsigned long nr_pages,
>  				       FOLL_PCI_P2PDMA | FOLL_HONOR_NUMA_FAULT)))
>  		return -EINVAL;
>
> +	if (unlikely(!nr_pages))
> +		return 0;
> +
>  	if (gup_flags & FOLL_PIN)
>  		mm_set_has_pinned_flag(current->mm);
>
>
> --
> 2.43.0
>

--
Cheers, Lorenzo

