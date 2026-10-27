Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D04606A31E
	for <kexec@archiver.kernel.org>; Tue, 27 Oct 2026 08:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=suskpTIW;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DqgW1ogH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=25JoUd0Ca4DSucyqp8VdpaHvYyD4L6ugc8HcJwXmagI=; b=suskpTIWDRE7wcx8ianG3cezWm
	8jHHYTZU2ZSWtKYQURjKCtV6fVwAlD5inGd03zq4sVGkcI+nrFREMztzIFEW6VyTzGg1dEDMrwRAt
	9CQKS/eksUpuz498FtORtXQekP14O84+cLCpDOjpWYBSidQHVdCNmJFbz9Lnd3G13ZV3SrPFylzLY
	lGdsI0hrhJ7eBsFDxRcYcY6nH5Hbz67/CJi+YFij9zJwt5A29S5/k6AttWEkfGC9ODTWcBniLJM/G
	Mm1atuIwD1cvTFGKygSjt33hF8RcsRy3SMq6vPRaHKUaUdGVsvn1q/lUTy7BnRJHtKJMv4PngMw9R
	sYxuGzfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLcMT-0000000415T-03zY;
	Tue, 27 Oct 2026 08:16:49 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLcMS-0000000415M-1uuK
	for kexec@lists.infradead.org;
	Tue, 27 Oct 2026 08:16:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 14E1740DBA;
	Tue, 27 Oct 2026 08:16:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6EE1F01825;
	Tue, 27 Oct 2026 08:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793089008;
	bh=25JoUd0Ca4DSucyqp8VdpaHvYyD4L6ugc8HcJwXmagI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DqgW1ogHskC3KjpnvkmfF/B2DYXhDZoPDNeziDRz5NYseOTPq/Bt3d/gR2uwOi5tt
	 l0FKm0+vSEXyriWPhPAPthXH1Up+UF+85+8a4DRAWSbZRYMnvjqZUBuxtSS9VhexcH
	 QjEToIVl39sflEhmYe9ziXX5NCu06RELjf5E7IRB4kHtHZXSvXfgKEoP26dOW1+9IE
	 ffVmPh+WFa/36AqcOLOz1lEuekRW0rjPES5+SXPWLU9gfjD0+35/LrvlH8duWv+GbJ
	 RuWAou4+YDgaZUIhlBwjRnVkYYWwTrj2jlqPucPxJ4gaehaWDjNNziTUjRRUgWOZSb
	 cgzDt4LnM1kJg==
Date: Tue, 27 Oct 2026 10:16:25 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>,
	Lance Yang <lance.yang@linux.dev>, Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry@kernel.org>, Alistair Popple <apopple@nvidia.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>,
	Minchan Kim <minchan@kernel.org>,
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Chris Li <chrisl@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Youngjun Park <youngjun.park@lge.com>,
	Gregory Price <gourry@gourry.net>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org, stable@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 23/46] mm/userfaultfd: write-lock the VMA before waking
 waiters when unregistering
Message-ID: <auBd2RS7buo-Aa5I@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-23-6f74bec9a5bb@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027-fixes_core-v1-23-6f74bec9a5bb@kernel.org>
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

On Tue, Oct 27, 2026 at 12:17:43AM +0100, David Hildenbrand (Arm) wrote:
> userfaultfd_unregister() wakes pending missing faults before clearing the
> VMA's userfaultfd registration. With per-VMA fault locking, holding
> mmap_lock for write does not prevent another fault from queuing after
> the wakeup but before userfaultfd_clear_vma() write-locks the VMA. That
> waiter can then remain asleep indefinitely.
> 
> Call vma_start_write() before waking waiters. Existing fault handlers
> queue themselves before dropping the VMA read lock, and new readers are
> excluded until mmap_write_unlock().
> 
> Fixes: 29a22b9e08d7 ("mm: handle userfaults under VMA lock")
> Cc: stable@vger.kernel.org
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/userfaultfd.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 669f71d485d02..7e30b5ff17be1 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -3991,6 +3991,9 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  			start = vma->vm_start;
>  		vma_end = min(end, vma->vm_end);
>  
> +		/* Prevent new userfaults from being queued after the wakeup. */
> +		vma_start_write(vma);
> +
>  		if (userfaultfd_missing(vma)) {
>  			/*
>  			 * Wake any concurrent pending userfault while
> 
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.

