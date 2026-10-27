Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95829606BA88
	for <kexec@archiver.kernel.org>; Tue, 27 Oct 2026 15:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Ql7Vbd6M;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UnXLdq3k
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=qp+fSXor3rJtw8hGRhqYEuRFppHYbzFfezBhq/ClTY8=; b=Ql7Vbd6MiT9CgRBHq4y46Ot6HB
	PfL/831vE9/7C8WfKhQu4Pr416QyDOQiweDWbtZHLAqoDQbhBNk5xg4cd2X9rTLpwXfMhKDeLSgwG
	Z5JDMQx7m/ta+mB85tRhBOPRwawOcSGFgeYRq4HTHPTSS4Bd4z4WXz05QSzQzvLZrabU//RINmcnJ
	r5XCOQdklapLIOCdktL8ChkrhGa5cARogSUugOmcIyq10Nme+rL2tysfyaJ3SUDicrUxGsvJyAo/w
	2xYZU/7goYzfv+QH5W8xbfPA2zxb3k4xskyOrAh7RlvNUfWS9Yqc/tNN0Cc0KT3rzKlqmO8GmUTub
	Bawe2feg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLiez-000000056AF-1NAc;
	Tue, 27 Oct 2026 15:00:21 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLiex-0000000569l-42xp
	for kexec@lists.infradead.org;
	Tue, 27 Oct 2026 15:00:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5EB4140AA7;
	Tue, 27 Oct 2026 15:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0151F01825;
	Tue, 27 Oct 2026 15:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793113219;
	bh=qp+fSXor3rJtw8hGRhqYEuRFppHYbzFfezBhq/ClTY8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=UnXLdq3klaC+tZ2+JX6PBI45P7W7nF48+f9ADm70UzXvPsh4+dY2WhOicztPbMw7F
	 SARjt9Oczq92TzB6tsLTcFdVUo5032qKNP4oINRE/Q8ajIBJ3KPA69x6ct5ZyaPihb
	 dzmgq7TcIx1PWaY/d5t1JPP1sQw/8RZHDucCg/R/QFCmyDP2NXPW+F6S6AUKz2W+3t
	 Dpk7PNOGHdNngY66tF6fRyZEMJsZsML0o3pMjD/NKndJzXXBZJwiuvk6Lr6JNZpq0X
	 Vrc6vg4zteKiAqZrKEoQENifIVt/YUhXNNs100l6gLc3ci49cX4el5JejC4ULazFv4
	 Ph+fkkfmpEbLw==
From: Pratyush Yadav <pratyush@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Johannes Weiner
 <hannes@cmpxchg.org>,  Michal Hocko <mhocko@kernel.org>,  Qi Zheng
 <qi.zheng@linux.dev>,  Shakeel Butt <shakeel.butt@linux.dev>,  Lorenzo
 Stoakes <ljs@kernel.org>,  Kairui Song <kasong@tencent.com>,  Barry Song
 <baohua@kernel.org>,  Axel Rasmussen <axelrasmussen@google.com>,  Yuanchu
 Xie <yuanchu@google.com>,  Wei Xu <weixugc@google.com>,  Baoquan He
 <baoquan.he@linux.dev>,  Baolin Wang <baolin.wang@linux.alibaba.com>,
  "Liam R. Howlett" <liam@infradead.org>,  Vlastimil Babka
 <vbabka@kernel.org>,  Mike Rapoport <rppt@kernel.org>,  Suren Baghdasaryan
 <surenb@google.com>,  Michal Hocko <mhocko@suse.com>,  Kees Cook
 <kees@kernel.org>,  Peter Zijlstra <peterz@infradead.org>,  Jann Horn
 <jannh@google.com>,  Pedro Falcato <pfalcato@suse.de>,  Hugh Dickins
 <hughd@google.com>,  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush
 Yadav <pratyush@kernel.org>,  "Matthew Wilcox (Oracle)"
 <willy@infradead.org>,  Jan Kara <jack@suse.cz>,  Zi Yan <ziy@nvidia.com>,
  Lance Yang <lance.yang@linux.dev>,  Rik van Riel <riel@surriel.com>,
  Harry Yoo <harry@kernel.org>,  Alistair Popple <apopple@nvidia.com>,
  Nico Pache <nico.pache@linux.dev>,  Ryan Roberts <ryan.roberts@arm.com>,
  Dev Jain <dev.jain@arm.com>,  Usama Arif <usama.arif@linux.dev>,  Kiryl
 Shutsemau <kas@kernel.org>,  Matthew Brost <matthew.brost@intel.com>,
  John Hubbard <jhubbard@nvidia.com>,  Peter Xu <peterx@redhat.com>,  Will
 Deacon <will@kernel.org>,  "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
  Nick Piggin <npiggin@gmail.com>,  Oscar Salvador <osalvador@suse.de>,
  Minchan Kim <minchan@kernel.org>,  Muchun Song <muchun.song@linux.dev>,
  Xu Xin <xu.xin@linux.dev>,  Chengming Zhou <chengming.zhou@linux.dev>,
  Chris Li <chrisl@kernel.org>,  Kemeng Shi <shikemeng@huaweicloud.com>,
  Nhat Pham <nphamcs@gmail.com>,  Youngjun Park <youngjun.park@lge.com>,
  Gregory Price <gourry@gourry.net>,  Joshua Hahn
 <joshua.hahnjy@gmail.com>,  Rakie Kim <rakie.kim@sk.com>,  Ying Huang
 <ying.huang@linux.alibaba.com>,  Jason Gunthorpe <jgg@ziepe.ca>,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-fsdevel@vger.kernel.org,
  linux-arch@vger.kernel.org,  linux-cxl@vger.kernel.org,  Chris Mason
 <mason@kernel.org>,  stable@vger.kernel.org
Subject: Re: [PATCH 20/46] mm/gup: fix clearing folios in memfd_pin_folios()
In-Reply-To: <20261027-fixes_core-v1-20-6f74bec9a5bb@kernel.org> (David
	Hildenbrand's message of "Tue, 27 Oct 2026 00:17:40 +0100")
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
	<20261027-fixes_core-v1-20-6f74bec9a5bb@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Tue, 27 Oct 2026 16:00:08 +0100
Message-ID: <2vxzbj8fp4sn.fsf@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27 2026, David Hildenbrand (Arm) wrote:

> From: Chris Mason <mason@kernel.org>
>
> memfd_pin_folios() pins folios obtained directly from the page cache
> without checking whether they are uptodate. However, shmem fallocate()
> can leave newly allocated folios uncleared and not uptodate. Callers
> such as udmabuf can then expose uninitialized memory to userspace.
>
> Clear non-uptodate folios and mark them uptodate under the folio lock
> before returning them to the caller.
>
> Fix generated by an LLM and sent by Chris Mason in private.
>
> Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning memfd folios")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: simplify description and comment ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/gup.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/mm/gup.c b/mm/gup.c
> index efc9aa2654625..47e7ae152cdf1 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -3516,6 +3516,20 @@ long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
>  					goto err;
>  				}
>  
> +				/*
> +				 * fallocate() can leave folios in the
> +				 * page cache that were never cleared.
> +				 */
> +				if (!folio_test_uptodate(folio)) {
> +					folio_lock(folio);
> +					if (!folio_test_uptodate(folio)) {
> +						folio_zero_range(folio, 0, folio_size(folio));
> +						flush_dcache_folio(folio);
> +						folio_mark_uptodate(folio);
> +					}
> +					folio_unlock(folio);
> +				}
> +

Nit: this logic is repeated in a couple places in shmem.c and in
memfd_luo.c. Perhaps it deserves a helper?

Anyway, sounds like an important fix so don't make my nitpick stop you
from landing this if you don't want to bother.

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

>  				if (nr_folios == 0)
>  					*offset = offset_in_folio(folio, start);

-- 
Regards,
Pratyush Yadav

