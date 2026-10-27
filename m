Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF15606A324
	for <kexec@archiver.kernel.org>; Tue, 27 Oct 2026 08:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=DjAqp4jl;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NSyrEmFs
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=JYDAxb/IKfi0ONAEetWSuyzn9W1ajE3cX6VVYTxdndk=; b=DjAqp4jlO6R1HlGi32GqTwft1b
	nKVIIsFcvh0QM40VYLdAxBgSn+LjeKmk0QtiTkC+Lq2nSMmVjqCAt0HNDoJmp9y/aAoyJQ0Ny89Gr
	mBMw6VecROlUExOpIGXHnseZv6gNW98bBbrX/26ei9Ilwdnqv5ax3ugdGGEw//mtfiY6gvgcZiYIO
	TzoHyAkwRiVu/fFmY30LiL+0BFhrc3W4k5pzRKlvazvmczIfhpUTYPcZ+p2Se4z/0yZFpR81u6Slq
	Jd1H4k1RVxltF7ZYscYgwvGf0PXiHG1n277xIn+AKmtRJgBl4nxRSgXDaVOh6hPgKeiTuyYysx7P/
	o1+6ndhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLcb9-0000000420C-16tD;
	Tue, 27 Oct 2026 08:31:59 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLcb8-00000004205-1P6V
	for kexec@lists.infradead.org;
	Tue, 27 Oct 2026 08:31:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4547B601FB;
	Tue, 27 Oct 2026 08:31:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30FE51F01825;
	Tue, 27 Oct 2026 08:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793089917;
	bh=JYDAxb/IKfi0ONAEetWSuyzn9W1ajE3cX6VVYTxdndk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NSyrEmFsH2/8hgo8acOSrNLr9Hp/jrECdxCZNkIUtjazyxj1KHY2Z9xTuaK1Lx/+E
	 ZlmTVVItxriaq2TTVszlyqWoslkxBKunusBgrpEBtjqe+GL7/BhgMfvr0j6wiA++no
	 F2KtES+mT9pC9lUi/ceR10V31SP1W8sTkLdb8RXB5buLAYoTKBuslgPDKXcQC7fYaC
	 tmT15Bau5bPVbn3Z1pAmnKqeU5kgzDR3je5XpPQh+1wLiPoL+vicuxqnXgb7RRv82r
	 DFUEPhtPAu/EsK33zZwLXIqaPQ96HHeqGtj52+tHWqHJBcswjRzCsbgunsrigQ97JU
	 n0Iy4vbd890bA==
Date: Tue, 27 Oct 2026 08:31:40 +0000
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
Subject: Re: [PATCH 25/46] mm/userfaultfd: wake waiters when registration
 modes are removed
Message-ID: <auBgr8OO0UIJ5-in@gremlin>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-25-6f74bec9a5bb@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027-fixes_core-v1-25-6f74bec9a5bb@kernel.org>
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

On Tue, Oct 27, 2026 at 12:17:45AM +0100, David Hildenbrand (Arm) wrote:
> UFFDIO_REGISTER can replace MISSING or MINOR tracking without waking
> faults that are already queued. For example, switching an anonymous
> range from MISSING to WP leaves a missing-fault waiter asleep until
> userspace explicitly wakes it.

I assume this is something people basically never do because you'd think it'd be
a pretty obvious bug report right?

>
> When a registration change removes a UFFD mode, wake waiters in the
> affected interval after updating the VMA. The VMA is write-locked at
> this point, so no new faults can queue under the old modes and woken
> threads cannot retry until mmap_write_unlock(). Waiters for retained
> modes in the same interval may also wake and refault.

Oh good lord.

>
> The hang reproduces for MISSING-to-WP and MINOR-to-MISSING transitions,
> with both read and unread fault events.
>
> Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

In the words of Metallica, the more I see, the less, the less I believe...

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  mm/userfaultfd.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 2122676c4220f..710e913c73bfa 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -2270,6 +2270,9 @@ static struct vm_area_struct *userfaultfd_clear_vma(struct vma_iterator *vmi,
>  	return ret;
>  }
>
> +static void wake_userfault_range(struct userfaultfd_ctx *ctx,
> +		unsigned long start, unsigned long end);
> +
>  /* Assumes mmap write lock taken, and mm_struct pinned. */
>  static int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
>  			       struct vm_area_struct *vma,
> @@ -2287,6 +2290,8 @@ static int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
>  		prev = vma;
>
>  	for_each_vma_range(vmi, vma, end) {
> +		const bool any_mode_removed = vma->vm_flags & __VM_UFFD_FLAGS & ~vm_flags;
> +
>  		cond_resched();
>
>  		VM_WARN_ON_ONCE(!vma_can_userfault(vma, vm_flags, wp_async));
> @@ -2332,6 +2337,10 @@ static int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
>  		 */
>  		userfaultfd_set_ctx(vma, ctx, vm_flags);
>
> +		/* Retry faults for removed modes while the VMA is write-locked. */
> +		if (any_mode_removed)
> +			wake_userfault_range(ctx, start, vma_end);
> +
>  		if (vma_is_hugetlb(vma) && uffd_disable_huge_pmd_share(vma))
>  			hugetlb_unshare_all_pmds(vma);
>
> @@ -3648,6 +3657,17 @@ static __always_inline void wake_userfault(struct userfaultfd_ctx *ctx,
>  		__wake_userfault(ctx, range);
>  }
>
> +static void wake_userfault_range(struct userfaultfd_ctx *ctx,
> +		unsigned long start, unsigned long end)
> +{
> +	struct userfaultfd_wake_range range = {
> +		.start = start,
> +		.len = end - start,
> +	};
> +
> +	wake_userfault(ctx, &range);
> +}
> +
>  static __always_inline int validate_unaligned_range(
>  	struct mm_struct *mm, __u64 start, __u64 len)
>  {
>
> --
> 2.43.0
>

--
Cheers, Lorenzo

