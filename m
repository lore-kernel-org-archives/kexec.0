Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D8D606A322
	for <kexec@archiver.kernel.org>; Wed, 28 Oct 2026 07:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=riQJWQmy;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=qAO7tgcE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=C2MebSDm+AGzraIelTihisR4wHMyVkbMMbZmgrZJ7WY=; b=riQJWQmylXlzRq
	2a/92kknk8qutdjH8F4qZwjjLBMkcBOMz/WdZuZ6ULkx8kPzRZ4xXFPFRU6h0gHKc8/JGXh8ZV+Re
	e5fVALXuw1A24YA6kmyyhzWSAT0KZTDGjQ4+/7mRbk+ERpE6491BP+Pnja4iTNUWeyf/mOcVR4h3O
	hC3QgmqmsmSt5SxFltizsyG+YsgUX4Qxx0b1T+6eIRIqKgthil49JoJ1K95KyjhzAsOkPPm/CW7Q2
	xsNI82F8OUv5LCDOu1lpnVmjF3U71MvCDV9P8uuZFxg8QMdWFKia0/XDL+NEUPqlcBTvXCt/+QV8t
	u7Aesrvq+JwTaIc1HwIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLySO-00000006UfY-42am;
	Wed, 28 Oct 2026 07:52:24 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLySM-00000006UeQ-1Wvu
	for kexec@lists.infradead.org;
	Wed, 28 Oct 2026 07:52:23 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 091D81756;
	Wed, 28 Oct 2026 00:52:16 -0700 (PDT)
Received: from [10.163.164.200] (unknown [10.163.164.200])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 046D23F673;
	Wed, 28 Oct 2026 00:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793173939; bh=wGe8fo0LsEeNmyXuE7t5RJoQX1lGKJltqCDxnR+anGM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qAO7tgcEvyo0Q3H3HaTM1nwzy8/QBeW1tnF4JOXa8qF71VXcIH8niSLEX8yBfM9DY
	 y3XuPsTISI5OiWjvg0v6LudaMoMHfe0T+fQRVNRKQDaWP3kjmosTINe/S2/q5eMvvF
	 XylgVFbGPVK2/y+rwaLieJ3EjGQdsqqHDKUNnM9o=
Message-ID: <e32a19c4-76c4-40ba-83a4-781333af7b0a@arm.com>
Date: Wed, 28 Oct 2026 13:21:55 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/46] mm/rmap: handle device-exclusive entries in
 folio_referenced_one()
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>,
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
 Baoquan He <baoquan.he@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>,
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>,
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>,
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>,
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org,
 stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-9-6f74bec9a5bb@kernel.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20261027-fixes_core-v1-9-6f74bec9a5bb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_005222_480629_510DE398 
X-CRM114-Status: GOOD (  21.88  )
X-Spam-Score: -4.4 (----)
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 27/10/26 4:47 am, David Hildenbrand (Arm) wrote:
> page_vma_mapped_walk() can return non-present device-exclusive entries,
> but folio_referenced_one() passes them to PTE young-bit accessors that
> require present PTEs.
> 
> We must neither call clear_flush_young_ptes_notify() nor
> folio_pte_batch() with non-present entries. For example, clearing the
> young bit on non-present PTEs can corrupt the entry: on arm64
> PTE_AF overlaps the swap type, so clearing it turns a device-exclusive
> entry into an ordinary swap entry.
> 
> folio_pte_batch() will VM_WARN_ON_FOLIO.
> 
> Apply the same approach as the previous fixes to e.g., damon_ptep_mkold():
> treat these entries as old from the CPU's perspective and obtain their
> young state through the MMU notifier.
> 
> Skip PTE batching and MGLRU look-around for non-present entries, and
> don't modify non-present PTEs.
> 
> Fixes: b756a3b5e7ea ("mm: device exclusive memory access")
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Cc: stable@vger.kernel.org
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---

Reviewed-by: Dev Jain <dev.jain@arm.com>

But nit below.


>  mm/rmap.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 1131b76bbbc28..0faef46806e5c 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -924,6 +924,7 @@ static bool folio_referenced_one(struct folio *folio,
>  	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, 0);
>  	int ptes = 0, referenced = 0;
>  	unsigned int nr;
> +	pte_t pteval;
>  
>  	while (page_vma_mapped_walk(&pvmw)) {
>  		address = pvmw.address;
> @@ -968,10 +969,12 @@ static bool folio_referenced_one(struct folio *folio,
>  			return false;
>  		}
>  
> -		if (pvmw.pte && folio_test_large(folio)) {
> +		if (pvmw.pte)
> +			pteval = ptep_get(pvmw.pte);
> +
> +		if (pvmw.pte && pte_present(pteval) && folio_test_large(folio)) {
>  			const unsigned long end_addr = pmd_addr_end(address, vma->vm_end);
>  			const unsigned int max_nr = (end_addr - address) >> PAGE_SHIFT;
> -			pte_t pteval = ptep_get(pvmw.pte);
>  
>  			nr = folio_pte_batch(folio, pvmw.pte, pteval, max_nr);
>  		}
> @@ -981,11 +984,23 @@ static bool folio_referenced_one(struct folio *folio,
>  		 * are. —they could be on active/inactive lists or on MGLRU. So the
>  		 * simplest approach is to disable this look-around optimization.
>  		 */
> -		if (lru_gen_enabled() && !lru_gen_switching() && pvmw.pte) {
> +		if (lru_gen_enabled() && !lru_gen_switching() && pvmw.pte &&
> +		    pte_present(pteval)) {
>  			if (lru_gen_look_around(&pvmw, nr))
>  				referenced++;
>  		} else if (pvmw.pte) {
> -			if (clear_flush_young_ptes_notify(vma, address, pvmw.pte, nr))
> +			bool young = false;
> +
> +			/*
> +			 * PFN swap PTEs, such as device-exclusive ones, that

You mean "PFN softleaf PTEs"? Better expressed as "softleaf PTEs embedding a PFN" ...


> +			 * actually map pages are "old" from a CPU perspective.
> +			 * The MMU notifier takes care of any device aspects.
> +			 */
> +			if (pte_present(pteval))
> +				young = clear_flush_young_ptes(vma, address, pvmw.pte, nr);
> +			young |= mmu_notifier_clear_flush_young(vma->vm_mm, address,
> +								address + nr * PAGE_SIZE);
> +			if (young)
>  				referenced++;
>  		} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
>  			if (pmdp_clear_flush_young_notify(vma, address,
> 


