Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BB9606A322
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 08:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OALM5EuD;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=iEbujbYC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=k8apCcAMk8pZRsZxsH16Lc+5TIn4jIu/b15pYO6Z0Bs=; b=OALM5EuDyBQKUZ
	eaoenRH3CtAGFFhaZn0jA+ls5GUlg81KHqY0IwOBA/X08czSgtI8EmARfNDroW36jEiKH+XJ5WzQQ
	yDtpoQ25sIX5dP+RGvPk0p54+gZVwDlv3F2YiaO3XWim11msbc0vHupy5/s3TFlnnkGUYafhAtXgj
	lfJSXdj57Ngh/OuTiv7CV8De7ae5Q645tRfk6uk0UPOHap9g6cbpbw58klVAyZ8kSlcFODFhdj/iz
	JP0W7wEFXqs4xw7QcwiGhcrSjuHhKKVSZHbj+Vr4NtjGDETmbr6iFLZKBr6xkk/XH1fh2SyvGtGWU
	x6tMaKes5JFBwnLXWMMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xML67-00000008fhw-1Cd5;
	Thu, 29 Oct 2026 08:02:55 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xML63-00000008fhQ-0yWj
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 08:02:53 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30B8A1682;
	Thu, 29 Oct 2026 01:02:44 -0700 (PDT)
Received: from [10.163.164.4] (unknown [10.163.164.4])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 385A33F7B4;
	Thu, 29 Oct 2026 01:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793260967; bh=ef9Fg1J+efa9K0lYaHXATY0/T5dH7yrFdYQc0z2MAV0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iEbujbYCswZ8RFK2+bOqH9GrXNfdspdEyeLWvgWq16i/7q0yxHJyjSKh5wRDFg8sA
	 90j56I5hjCTLgfRploz8x7UQzuMKPs6udMHmkEokQ81ilxBQr2532zpMPLliV7ataQ
	 ekLC1vjHF7zTz0euRAfdkqhMPZF/1uaGmanjmQX8=
Message-ID: <720a50ae-5828-450f-a7ee-a7107b884225@arm.com>
Date: Thu, 29 Oct 2026 13:32:23 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 29/46] mm/mremap: use pudp_huge_get_and_clear() when
 moving huge PUDs
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
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, stable@vger.kernel.org
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-29-6f74bec9a5bb@kernel.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20261027-fixes_core-v1-29-6f74bec9a5bb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_010251_431550_16823A84 
X-CRM114-Status: GOOD (  14.73  )
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
> move_huge_pud() reads the old PUD and clears it in separate operations.
> Hardware accessed or dirty updates between those operations can be lost
> when the saved entry is installed at the new address.
> 
> The raw pud_clear() also bypasses page_table_check_pud_clear(), while
> set_pud_at() accounts for the destination mapping. This leaves the
> checker counts unbalanced for mappings tracked by page table checking.
> 
> To fix it, simply use pudp_huge_get_and_clear().
> 
> Fixes: 7d846db7d0e2 ("mm/mremap: convert huge PUD move to separate helper")
> Cc: stable@vger.kernel.org
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---

Reviewed-by: Dev Jain <dev.jain@arm.com>


>  mm/mremap.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 0d06d7f37f19a..16e736c72d9cb 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -509,8 +509,7 @@ static bool move_huge_pud(struct pagetable_move_control *pmc,
>  		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
>  
>  	/* Clear the pud */
> -	pud = *old_pud;
> -	pud_clear(old_pud);
> +	pud = pudp_huge_get_and_clear(mm, pmc->old_addr, old_pud);
>  
>  	VM_BUG_ON(!pud_none(*new_pud));
>  
> 


