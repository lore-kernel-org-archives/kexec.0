Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E786F606A31D
	for <kexec@archiver.kernel.org>; Tue, 27 Oct 2026 09:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=0sgZXX0/;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z3V2ir1f
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=GyDf/T3A99e/UK5Tx0KKev7xPaxEfXMruyrCYj6de1U=; b=0sgZXX0/lWq84BytmHeYjLLH+e
	vSDg+sSo3y1Ws+mc5A/DVTLKbl8VAptozCKkEy8s3QPIIpMNe0BHNa0XESWvnbis254GOrhauPrWV
	Dr+kYKrGkE0l0E5dw2iWYXhEsJBJBiGbwIHURGlBAfdiW/JYoi3dJfuqLP+g+uOy6dAg216Ns0rVK
	KhpG80N/XaasWsc8QnRTWo3HgAMxw4Cq5XteI9peoM7pb9ShVTvqH/9/jfj1J6qtHYrPNncNbNKWZ
	FmZHyCtXdc8vZM4RsfBBwmL5wHB8lIoAuZlk57ZHaF/WnMlK3WFwrFh9DKoldsf0YcUivk3FlurXx
	VuQwI41A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLdaO-00000004Alq-2emi;
	Tue, 27 Oct 2026 09:35:16 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLdaN-00000004AlP-2IqL
	for kexec@lists.infradead.org;
	Tue, 27 Oct 2026 09:35:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2E4E460052;
	Tue, 27 Oct 2026 09:35:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD641F01825;
	Tue, 27 Oct 2026 09:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793093713;
	bh=GyDf/T3A99e/UK5Tx0KKev7xPaxEfXMruyrCYj6de1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z3V2ir1fhLjLEOG38tPqPyKd7K/FHGfPC09OfR7eOlE/pdqk+8s3kVa1i4DQbH+Qx
	 MZ32NLc7julvf25Egjxt2K1dVEewhL3Of9L8IHSEkMikSMuPsfkdtPqT3BAFRQIx4l
	 I2aocqwSNzVOB8HXoD0iEYYGXcOv8ZXfRuVth/j1TS6G/Q38VWONKl+4C7n5MEPxNA
	 MdDQY8Y20j6O/Wno2AqROjn/Br7ZnF59rm1EwFzdyTg2TjL0F8dx2lgZTIglHC5tyA
	 DHYvTnMV0DHzDPWwpSElNE8EW4/oPBEyMA8Gm39jeV4/zgUOyB58UgoLt0XQBoz9Do
	 0CxG7SV58ggfg==
Date: Tue, 27 Oct 2026 09:34:57 +0000
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
Subject: Re: [PATCH 22/46] mm/gup: check for overflow when converting
 nr_pages to bytes in GUP-fast
Message-ID: <auBwBYzcs-segDVk@gremlin>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-22-6f74bec9a5bb@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027-fixes_core-v1-22-6f74bec9a5bb@kernel.org>
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

On Tue, Oct 27, 2026 at 12:17:42AM +0100, David Hildenbrand (Arm) wrote:
> The overflow check in gup_fast_fallback() only covers the addition to
> start. The preceding nr_pages << PAGE_SHIFT can already have truncated
> the length on 32bit.

Insert rant about 32-bit kernels here :)

>
> Users such as RapidIO's rio_dma_transfer() can derive such page counts
> from a 64-bit userspace length.
>
> Let's just check_shl_overflow() to reject any such overflow with
> -EOVERFLOW early.
>
> Fixes: c28b1fc70390 ("mm/gup: reorganize internal_get_user_pages_fast()")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  mm/gup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/gup.c b/mm/gup.c
> index 9906965893431..48e1bfe5ab9a9 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -3214,8 +3214,8 @@ static int gup_fast_fallback(unsigned long start, unsigned long nr_pages,
>  		might_lock_read(&current->mm->mmap_lock);
>
>  	start = untagged_addr(start) & PAGE_MASK;
> -	len = nr_pages << PAGE_SHIFT;
> -	if (check_add_overflow(start, len, &end))
> +	if (check_shl_overflow(nr_pages, PAGE_SHIFT, &len) ||
> +	    check_add_overflow(start, len, &end))
>  		return -EOVERFLOW;
>  	if (end > TASK_SIZE_MAX)
>  		return -EFAULT;
>
> --
> 2.43.0
>

--
Cheers, Lorenzo

