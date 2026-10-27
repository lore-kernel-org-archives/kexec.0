Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD111606A322
	for <kexec@archiver.kernel.org>; Tue, 27 Oct 2026 08:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=pRmKLjGx;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oMCJcnkQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=2R51g1GKhJVpEHSsNmeCyBNO0baPm+a+p1RPH1MDDNw=; b=pRmKLjGxuyzFuzkaDEAkjRSTKX
	f2j6MLNMht1kOZOnvPHIY8On8c2LOcbrmtMeIBmV4AZyUfpbRkJigM6PoGHprDfnRZ9w0GfkNFHCD
	PC4pz5zlJ5wKmLB4mVeCu+b7riyrDgC/8SBK7bNhAqOrOzMlVPHpHpXe9s9ruwMJbAqrvpw7oHV8c
	kEHqTBh46BTZwV50STemeLGkA4rp5l2FSwSpmiUv11exAo1zhhH3XeKmmfQXfTqwJkXoDPBQuLsHo
	1Q70LJdDd7YRvtsqQ5YqxljNm0dpYgYlGQYvLLdM4SzCi4AseRmOopWRRWt24VbKithxwzDDRy3Ox
	KApwLu/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLcUV-000000041bL-1E0j;
	Tue, 27 Oct 2026 08:25:07 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLcUT-000000041bC-2CCb
	for kexec@lists.infradead.org;
	Tue, 27 Oct 2026 08:25:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A94E2601F9;
	Tue, 27 Oct 2026 08:25:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4511F01825;
	Tue, 27 Oct 2026 08:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793089504;
	bh=2R51g1GKhJVpEHSsNmeCyBNO0baPm+a+p1RPH1MDDNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oMCJcnkQ2ugmQRTH47VuoA3lVoRzsl34BDT2jKNZ7RUkFZzWRMbYSzo8WR8dK47mW
	 pqOc0eK72lDgDWD3QdHT/pBPnXi7ryj0yWTtmxBWUn+p5DRaD+1S+/Zz1qFJPw0jDt
	 lyPXK9okKJapfC2UEO49ON8OIAwvxBsXfw7kAXbJ0jwSXdgh4Nb8U2On849jV//cVT
	 XlO3MbW2lEPG9jGdLQoIYuXn+vfpx2LaaFHDs6IoRpEheK1ZpsFb3+BVmLglbhci3D
	 +YInIICeV3inpT7BSAzD/puAVkPVByrS2yMaytLjeB9oAMCCDWzd0u2d/tbYp4aR5g
	 N0rWUbD2viZ0Q==
Date: Tue, 27 Oct 2026 08:24:47 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
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
	Youngjun Park <youngjun.park@lge.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-cxl@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 25/46] mm/userfaultfd: wake waiters when registration
 modes are removed
Message-ID: <auBcES74Q5M3MWCW@gremlin>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-25-6f74bec9a5bb@kernel.org>
 <179307782442.2301705.17273288326330283268.b4-reply@b4>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179307782442.2301705.17273288326330283268.b4-reply@b4>
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

On Mon, Oct 26, 2026 at 10:10:24PM -0700, Gregory Price wrote:
> From: Gregory Price <gourry@gourry.net>
> Subject: [PATCH] mm/userfaultfd: compare exact registration modes before skipping
>
> Changing registration from MISSING|WP to WP returns success but leaves
> MISSING enabled. The no-op check sees that WP is already set and skips
> the update, so later accesses to missing pages still wait for userspace.
>
> Skip the update only when the current and requested UFFD modes match
> exactly.
>
> Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> ---
>  mm/userfaultfd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 669f71d485d02..0a28130cebc99 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -2299,7 +2299,7 @@ static int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
>  		 * userfaultfd and with the right tracking mode too.
>  		 */
>  		if (vma->vm_userfaultfd_ctx.ctx == ctx &&
> -		    vma_test_all_mask(vma, vma_flags))
> +		    (vma->vm_flags & __VM_UFFD_FLAGS) == vm_flags)

Would be better not to regress to the legacy API. I realise we don't use it for
backported fixes in general, but this patch obviously won't apply to older
versions anyway, so we should use the correct API now, and this for older
versions.

I'll add a better predicate probably to do this in one go, but for the fix,
I put the correct patch below.


>  			goto skip;
>
>  		/*
>
> --
> Gregory Price <gourry@gourry.net>

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 777bf122d32a..c71cb9179913 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -2288,6 +2288,9 @@ static int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
 		prev = vma;

 	for_each_vma_range(vmi, vma, end) {
+		const vma_flags_t curr_vma_flags =
+			vma_flags_and_mask(&vma->flags, __VMA_UFFD_FLAGS);
+
 		cond_resched();

 		VM_WARN_ON_ONCE(!vma_can_userfault(vma, vm_flags, wp_async));
@@ -2300,7 +2303,7 @@ static int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
 		 * userfaultfd and with the right tracking mode too.
 		 */
 		if (vma->vm_userfaultfd_ctx.ctx == ctx &&
-		    vma_test_all_mask(vma, vma_flags))
+		    vma_flags_same_pair(&curr_vma_flags, &vma_flags))
 			goto skip;

 		/*

--
Cheers, Lorenzo

