Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4065FC3ABD8
	for <kexec@archiver.kernel.org>; Sun, 18 May 2025 15:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0yx/i8jUhYkmUBOS7xikVrkU5+lN9H+1efAAb6qPyWk=; b=h2wSkrluIqj6FEhX5G6qfTZ2HT
	E/3IkUUu5pu2rruPmsPZ41tYvbFBbtmt6FHqUMcCDcMGO41FViWn9uvxE9pT/LIfMNIiPtJhCpNTU
	lIIsxV2O4k3uHQMyF2jzUIT8qD5YuGj7pytPuLxODLqI48IzfWSYbjgJsuG3KNkhPsqSLjOmAGAWE
	2Xl0CcdYRQSKBXwaKCxoq4VQT9monl5Ic56tzErQ7tfchRLZlSQ6TqPIqJVw0fN3xxZYv/ThPyn6N
	IvYyJS2UPFF5O046vs/41YF+uw+eEQExbxAOH2tlzfqwnT08HuviThI1p/m8QyFh5nk48nCmSy8uw
	G84g2MgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGgIM-00000007G2q-02oO;
	Sun, 18 May 2025 15:51:22 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGgIG-00000007G2A-22oi
	for kexec@lists.infradead.org;
	Sun, 18 May 2025 15:51:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 691AF5C12B3;
	Sun, 18 May 2025 15:48:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6993C4CEE7;
	Sun, 18 May 2025 15:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747583472;
	bh=f46ZYATqSlZQYJjPraHCnJoSA69zLQj8qTugXkfCsGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ims6q9M46Czd/XpLtif0k76dTRzbU76gkPqoaANZ1rGHB1B6yZhlQkR6laQnZJGxN
	 3yOFck4NqY3fpd36L8vxKDmHqbGKC0H+VBZMv5+xZBEnn30xNdjeCKGNDmnzRpge5y
	 X8IHYWj/a0UCymu9OjyhCpRSfu3ibDiDIsLNo1Dk6XPcbgyFwVwDiHZot0/orsql1O
	 sex6JIHSgIuNO6uEvr92py72e+obAPGrCTvJXrds4QQF5pVn2UK/1z7Gqfgk+Op80x
	 LyRBes2wRBOrLbp0LRFX7EZ3CZ900vXp2UgCvOGzAh14n4xXkGCHL45OVVQfv/9qMa
	 hio0UMUW6kvBw==
Date: Sun, 18 May 2025 18:51:04 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Changyuan Lyu <changyuanl@google.com>
Cc: akpm@linux-foundation.org, graf@amazon.com, bhe@redhat.com,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, chrisl@kernel.org, pasha.tatashin@soleen.com,
	jasonmiu@google.com
Subject: Re: [PATCH 2/2] KHO: init new_physxa->phys_bits to fix lockdep
Message-ID: <aCoB6KkQr4xFBlEu@kernel.org>
References: <20250518142315.241670-1-changyuanl@google.com>
 <20250518142315.241670-3-changyuanl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250518142315.241670-3-changyuanl@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250518_085116_617913_94A405B3 
X-CRM114-Status: GOOD (  25.21  )
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

On Sun, May 18, 2025 at 07:23:15AM -0700, Changyuan Lyu wrote:
> From: Pasha Tatashin <pasha.tatashin@soleen.com>
> 
> Lockdep shows the following warning:
> 
> INFO: trying to register non-static key.
> The code is fine but needs lockdep annotation, or maybe
> you didn't initialize this object before use?
> turning off the locking correctness validator.
> 
> [<ffffffff810133a6>] dump_stack_lvl+0x66/0xa0
> [<ffffffff8136012c>] assign_lock_key+0x10c/0x120
> [<ffffffff81358bb4>] register_lock_class+0xf4/0x2f0
> [<ffffffff813597ff>] __lock_acquire+0x7f/0x2c40
> [<ffffffff81360cb0>] ? __pfx_hlock_conflict+0x10/0x10
> [<ffffffff811707be>] ? native_flush_tlb_global+0x8e/0xa0
> [<ffffffff8117096e>] ? __flush_tlb_all+0x4e/0xa0
> [<ffffffff81172fc2>] ? __kernel_map_pages+0x112/0x140
> [<ffffffff813ec327>] ? xa_load_or_alloc+0x67/0xe0
> [<ffffffff81359556>] lock_acquire+0xe6/0x280
> [<ffffffff813ec327>] ? xa_load_or_alloc+0x67/0xe0
> [<ffffffff8100b9e0>] _raw_spin_lock+0x30/0x40
> [<ffffffff813ec327>] ? xa_load_or_alloc+0x67/0xe0
> [<ffffffff813ec327>] xa_load_or_alloc+0x67/0xe0
> [<ffffffff813eb4c0>] kho_preserve_folio+0x90/0x100
> [<ffffffff813ebb7f>] __kho_finalize+0xcf/0x400
> [<ffffffff813ebef4>] kho_finalize+0x34/0x70
> 
> This is becase xa has its own lock, that is not initialized in
> xa_load_or_alloc.
> 
> Modifiy __kho_preserve_order(), to properly call
> xa_init(&new_physxa->phys_bits);
> 
> Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation")
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Changyuan Lyu <changyuanl@google.com>
> ---
>  kernel/kexec_handover.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> index 69b953551677..f0ac6a9170f8 100644
> --- a/kernel/kexec_handover.c
> +++ b/kernel/kexec_handover.c
> @@ -144,14 +144,35 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
>  				unsigned int order)
>  {
>  	struct kho_mem_phys_bits *bits;
> -	struct kho_mem_phys *physxa;
> +	struct kho_mem_phys *physxa, *new_physxa;
>  	const unsigned long pfn_high = pfn >> order;
> 
>  	might_sleep();
> 
> -	physxa = xa_load_or_alloc(&track->orders, order, sizeof(*physxa));
> -	if (IS_ERR(physxa))
> -		return PTR_ERR(physxa);
> +	physxa = xa_load(&track->orders, order);
> +	if (!physxa) {
> +		new_physxa = kzalloc(sizeof(*physxa), GFP_KERNEL);
> +		if (!new_physxa)
> +			return -ENOMEM;
> +
> +		xa_init(&new_physxa->phys_bits);
> +		physxa = xa_cmpxchg(&track->orders, order, NULL, new_physxa,
> +				    GFP_KERNEL);
> +		if (xa_is_err(physxa)) {
> +			int err_ret = xa_err(physxa);
> +
> +			xa_destroy(&new_physxa->phys_bits);
> +			kfree(new_physxa);
> +
> +			return err_ret;
> +		}
> +		if (physxa) {
> +			xa_destroy(&new_physxa->phys_bits);
> +			kfree(new_physxa);
> +		} else {
> +			physxa = new_physxa;
> +		}
> +	}

You are nearly duplicating xa_load_or_alloc() here. 
Is xa_destroy() is really needed here? In the end we destroying an empty
xarray.

Unless xa_destroy() is a must something like this would be simpler IMHO:

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index ef21db6c59d5..4c8303fbf97a 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -91,10 +91,12 @@ struct kho_serialization {
 	struct khoser_mem_chunk *preserved_mem_map;
 };
 
-static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, size_t sz)
+static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, size_t sz,
+			      bool *new)
 {
 	void *elm, *res;
 
+	*new = false;
 	elm = xa_load(xa, index);
 	if (elm)
 		return elm;
@@ -112,6 +114,7 @@ static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, size_t sz)
 		return res;
 	}
 
+	*new = true;
 	return elm;
 }
 
@@ -146,15 +149,18 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
 	struct kho_mem_phys_bits *bits;
 	struct kho_mem_phys *physxa;
 	const unsigned long pfn_high = pfn >> order;
+	bool new;
 
 	might_sleep();
 
-	physxa = xa_load_or_alloc(&track->orders, order, sizeof(*physxa));
+	physxa = xa_load_or_alloc(&track->orders, order, sizeof(*physxa), &new);
 	if (IS_ERR(physxa))
 		return PTR_ERR(physxa);
+	if (new)
+		xa_init(&physxa->phys_bits);
 
 	bits = xa_load_or_alloc(&physxa->phys_bits, pfn_high / PRESERVE_BITS,
-				sizeof(*bits));
+				sizeof(*bits), &new);
 	if (IS_ERR(bits))
 		return PTR_ERR(bits);
 
And if xa_destroy() is actually required, the allocation of new xarray
should be a helper function.

>  	bits = xa_load_or_alloc(&physxa->phys_bits, pfn_high / PRESERVE_BITS,
>  				sizeof(*bits));
> --
> 2.49.0.1101.gccaa498523-goog

-- 
Sincerely yours,
Mike.

