Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3871CD4842
	for <kexec@archiver.kernel.org>; Mon, 11 May 2026 11:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vIIxopnv8C1lUGDURtYfvYK6BU81eY+4ThdK0hgccwA=; b=z5uHtTcmF4r2naMvbwxXg5iyF9
	tWDx81S6oFvCU3w0W118506FCPlhkToCNeLN2atr0o4CTfx3DxzYPUGChDoPeTNMwb4bW5zsD3ETk
	dM75CaMl9H/GUunKZNkdC11MzhXW4sdvN2SFwVqQKRvRno54Wkl37A0HJ55r6eY08Pfb1b9YPE94M
	sN4q0lVLHQISCUEb8+LB2D1wCTi39eiTwe0v/t2gLysYbX4gfQ0izYpa2OJBJzrH1OgonB3wBARVF
	taQpwnt7tN59hzBtv8XCwT4rJRMJTdRDD9OMqoXrcpNm4RnXa2lSygiJLl1+VX+EscYN3ECQaXK3I
	ouhydxqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMP7G-0000000DOBu-2DqZ;
	Mon, 11 May 2026 11:48:06 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMP7E-0000000DOBH-1Qxo
	for kexec@lists.infradead.org;
	Mon, 11 May 2026 11:48:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6F4FB6001A;
	Mon, 11 May 2026 11:48:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3223C2BCB0;
	Mon, 11 May 2026 11:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778500083;
	bh=a01/upDufgIp0Xjp/MMIPDmLlqZSzAcbtUi5lVWoWUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fe3xEr9AzWihxUV7USwOkIUobn90Uj3D56rO9BWkXhDrKfIyqOmm0JdMCPqImocM2
	 bSMxBsQ2CEs13+7MgRHrC9PvJroEkc9lTzgFUIOQnGmQE/d+a+Y2cc9dtQ2LtjYNqO
	 xUvVQFfwZxB8YLJDIy5vcdt+pnJ0M7kWsMOW+RXAtHf5m8KZgXFYUBJPXQPIb70kaZ
	 yP1baEh3GJ3HRLWtGgG4OIR1iBcC9AtA/5yY2/esmrs5SXiMKuw1mmfvvm3qQUqWWG
	 scRytITxa4q6GvG7pp3y1MvTMisYMf/NPl5QAUidcVOLRCa+B+QaLEWbrS5yYJjPXC
	 RzaNwP62qDUFQ==
Date: Mon, 11 May 2026 14:47:56 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Miu <jasonmiu@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] kho: add a struct for radix callbacks
Message-ID: <agHB7HB-p_vkLS7R@kernel.org>
References: <20260429133928.850721-1-pratyush@kernel.org>
 <20260429133928.850721-4-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429133928.850721-4-pratyush@kernel.org>
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

On Wed, Apr 29, 2026 at 03:39:05PM +0200, Pratyush Yadav wrote:
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> 
> A future commit will add more callbacks for the KHO radix tree. Add a
> struct for collecting the callbacks.
> 
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> ---
>  include/linux/kho_radix_tree.h     | 15 ++++++++++++---
>  kernel/liveupdate/kexec_handover.c | 29 ++++++++++++++++-------------
>  2 files changed, 28 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/kho_radix_tree.h b/include/linux/kho_radix_tree.h
> index f368f3b9f923..030da6399d28 100644
> --- a/include/linux/kho_radix_tree.h
> +++ b/include/linux/kho_radix_tree.h
> @@ -34,14 +34,23 @@ struct kho_radix_tree {
>  	struct mutex lock; /* protects the tree's structure and root pointer */
>  };
>  
> -typedef int (*kho_radix_tree_walk_callback_t)(unsigned long key);
> +/**
> + * struct kho_radix_walk_cb - Callbacks for KHO radix tree walk.
> + * @key:      Called on each present key in the radix tree.
> + *
> + * For each callback, a return value of 0 continues the walk and a non-zero
> + * return value is directly returned to the caller.
> + */
> +struct kho_radix_walk_cb {
> +	int (*key)(unsigned long key);
> +};
>  
>  #ifdef CONFIG_KEXEC_HANDOVER
>  
>  int kho_radix_add_key(struct kho_radix_tree *tree, unsigned long key);
>  void kho_radix_del_key(struct kho_radix_tree *tree, unsigned long key);
>  int kho_radix_walk_tree(struct kho_radix_tree *tree,
> -			kho_radix_tree_walk_callback_t cb);
> +			const struct kho_radix_walk_cb *cb);
>  
>  #else  /* #ifdef CONFIG_KEXEC_HANDOVER */
>  
> @@ -54,7 +63,7 @@ static inline void kho_radix_del_key(struct kho_radix_tree *tree,
>  				     unsigned long key) { }
>  
>  static inline int kho_radix_walk_tree(struct kho_radix_tree *tree,
> -				      kho_radix_tree_walk_callback_t cb)
> +				      const struct kho_radix_walk_cb *cb)
>  {
>  	return -EOPNOTSUPP;
>  }
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 5758dc6fab5d..4a5d1b47799c 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -266,16 +266,18 @@ void kho_radix_del_key(struct kho_radix_tree *tree, unsigned long key)
>  }
>  EXPORT_SYMBOL_GPL(kho_radix_del_key);
>  
> -static int kho_radix_walk_leaf(struct kho_radix_leaf *leaf,
> -			       unsigned long key,
> -			       kho_radix_tree_walk_callback_t cb)
> +static int kho_radix_walk_leaf(struct kho_radix_leaf *leaf, unsigned long key,
> +			       const struct kho_radix_walk_cb *cb)
>  {
>  	unsigned long *bitmap = (unsigned long *)leaf;
>  	unsigned int i;
>  	int err;
>  
> +	if (!cb->key)
> +		return 0;
> +
>  	for_each_set_bit(i, bitmap, PAGE_SIZE * BITS_PER_BYTE) {
> -		err = cb(key | i);
> +		err = cb->key(key | i);

key(key) reads weird :)
Can't say I have a good name, maybe key_action()?

>  		if (err)
>  			return err;
>  	}

-- 
Sincerely yours,
Mike.

