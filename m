Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB6F7CA5FDD
	for <kexec@archiver.kernel.org>; Sat,  3 Oct 2026 07:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q9kqnwZJAXRfho77Yt6ZBil51mcAO7in4pebx6oB4fI=; b=m/v7viWYTaSq0Sc32/h75Ob9kh
	+vwrmdI0AkWHjX9JZ1+FlzchYq1Q59o27Rr7Dhs6BpjhYUZav+QPM22psOuKpl+3EQMCx+9wVUmxg
	jQjF3ijWtbxMe/f1Epk2hSCb2tuhIqtOYEB+SHzYxgxvDz+fdDDNqefT0LNU+ferNZ6hxERIYMfhJ
	Nr8KZiHbeE7JztX8Sk1vXd5/JuMvZ5+zvx8Or+glglwp2Ka1V6w5OT+NZqMV3dQOdDNV3HL7LoOUd
	2ZmoM9C1xggLYPXdeXh5ppFjLkA/6Kvm1mhrZ3AkNWkLqe66lKtwq4OS2lndmIirppcGr2vDOmdW3
	Skn+TAKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCuek-0000000D9KV-2Thf;
	Sat, 03 Oct 2026 07:59:42 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCuei-0000000D9Jn-2jIT
	for kexec@lists.infradead.org;
	Sat, 03 Oct 2026 07:59:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C501340454;
	Sat,  3 Oct 2026 07:59:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4E41F0089C;
	Sat,  3 Oct 2026 07:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791014379;
	bh=q9kqnwZJAXRfho77Yt6ZBil51mcAO7in4pebx6oB4fI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RxaGWxF3L4YTsdWVZArvggDDeEJeU5k2/xlxIc3gGpz9W2LTy5PnXLsH5+kmuA34l
	 k8k51YV/fJQ4zDkpUft0AkWeshphy5QyCqQfcNbiUSKgGpciheKBpVzcofbgs97eE+
	 wrOA+at67oZyPaecBMS1VaV3N/LOSsqgz2V6KBGkG3g4Ovu6kMPODYpET/eI9SE27J
	 qSflSFBiZUZIj5pjUMyuBrQaWTon+QBk3OhV4WDI/09aTJJ+EEuygjRW4EYljdZ278
	 U9nho+HEBe2izjuNJGGYvx0UqAnGrAKxpPaS9uwbTu330E801mo+wf4ghP1FOIUDDd
	 yf8LCtugigeuw==
Date: Sat, 3 Oct 2026 09:59:32 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, Aditya Gupta <adityag@linux.ibm.com>,
	Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shivang Upadhyay <shivangu@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v1 1/2] kho: check scratch vs CMA alignment at runtime
Message-ID: <asC15ISMMbHMwnHi@kernel.org>
References: <20260928083226.107807-1-sourabhjain@linux.ibm.com>
 <20260928083226.107807-2-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928083226.107807-2-sourabhjain@linux.ibm.com>
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi,

On Mon, Sep 28, 2026 at 02:02:25PM +0530, Sourabh Jain wrote:
> KHO requires the scratch alignment to be at least CMA_MIN_ALIGNMENT_BYTES,
> and this is currently enforced with a static_assert().
> 
> That assertion breaks the build on powerpc once CONFIG_KEXEC_HANDOVER is
> enabled together with CONFIG_TRANSPARENT_HUGEPAGE or CONFIG_HUGETLB_PAGE:
> 
>     kernel/liveupdate/kexec_handover.c:49:39: error: expression in static assertion is not constant
>        49 | static_assert(SCRATCH_ALIGNMENT_BYTES >= CMA_MIN_ALIGNMENT_BYTES);
>     ./include/linux/build_bug.h:80:56: note: in definition of macro '__static_assert'
>        80 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>           |                                                        ^~~~
>     kernel/liveupdate/kexec_handover.c:49:1: note: in expansion of macro 'static_assert'
>        49 | static_assert(SCRATCH_ALIGNMENT_BYTES >= CMA_MIN_ALIGNMENT_BYTES);
> 
> CMA_MIN_ALIGNMENT_BYTES depends on pageblock_order, which is not a
> compile-time constant with certain configs, such as
> CONFIG_HUGETLB_PAGE_SIZE_VARIABLE on powerpc. The next patch in this
> series enables KHO on powerpc, so the alignment must be checked at
> runtime instead.
> 
> Replace the static_assert() with a runtime check at the start of
> kho_reserve_scratch(), before any scratch memory is reserved. If the
> scratch alignment is smaller than the CMA minimum alignment, warn once
> and disable KHO rather than continue with a misaligned reservation.

Can we keep static_assert() for everything !powerpc please? 
Like something along these lines:

#ifndef CONFIG_HUGETLB_PAGE_SIZE_VARIABLE
#define check_scratch_alignment static_assert(...)
#else
static inline bool check_scratch_alignment()
{
...
}
#endif

 
> Cc: Aditya Gupta <adityag@linux.ibm.com>
> Cc: Alexander Graf <graf@amazon.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
> Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  kernel/liveupdate/kexec_handover.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 7c4d86daf86d..dc76dd6b74da 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -39,15 +39,7 @@
>  #include "../kexec_internal.h"
>  #include "kexec_handover_internal.h"
>  
> -/*
> - * This is the minimal alignment required by deferred struct page init.
> - * deferred_init_memmap_chunk frees memory to the buddy allocator, which looks
> - * at the neighboring pages (up to MAX_PAGE_ORDER) to merge them.
> - * If KHO scratch is not aligned to that value, buddy can access uninitialized
> - * struct pages, which can cause a crash.
> - */
>  #define SCRATCH_ALIGNMENT_BYTES (PAGE_SIZE * MAX_ORDER_NR_PAGES)
> -static_assert(SCRATCH_ALIGNMENT_BYTES >= CMA_MIN_ALIGNMENT_BYTES);
>  
>  /* The magic token for preserved pages */
>  #define KHO_PAGE_MAGIC 0x4b484f50U /* ASCII for 'KHOP' */
> @@ -836,6 +828,21 @@ static void __init kho_reserve_scratch(void)
>  	if (!kho_enable)
>  		return;
>  
> +	/*
> +	 * This is the minimal alignment required by deferred struct page init.
> +	 * deferred_init_memmap_chunk frees memory to the buddy allocator, which looks
> +	 * at the neighboring pages (up to MAX_PAGE_ORDER) to merge them.
> +	 * If KHO scratch is not aligned to that value, buddy can access uninitialized
> +	 * struct pages, which can cause a crash.
> +	 */
> +	if (WARN_ON_ONCE(SCRATCH_ALIGNMENT_BYTES < CMA_MIN_ALIGNMENT_BYTES)) {
> +		pr_err("scratch alignment %lu < CMA minimum %lu, disabling\n",
> +		       (unsigned long)SCRATCH_ALIGNMENT_BYTES,
> +		       (unsigned long)CMA_MIN_ALIGNMENT_BYTES);
> +		kho_enable = false;
> +		return;
> +	}
> +
>  	scratch_size_update();
>  
>  	/* FIXME: deal with node hot-plug/remove */
> -- 
> 2.55.0
> 

-- 
Sincerely yours,
Mike.

