Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC0FCD5BB1
	for <kexec@archiver.kernel.org>; Thu, 21 May 2026 23:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2qvJumL5Uy9qaseIh6HBDqg5ydk4M44ynTEuc1EKrP8=; b=3oxl3wKPHmNpRNLuFg7cxB4eRY
	Ap2Fs/f5MX4xATZbw5U7PLXaiqHaIv/qSUFY/j3lt+5GBpPz4a6nEKjjxKV+wCZxTMgyFrxacR77W
	zuMgCO4TeQL0wvMNuzjaWsdJ1UkrsaTFlNp55/8D6u20OPnfU3rCVxJLqbPeRwnC848I059Q+I6QW
	Eh1lXOjNLcZuLXposAT/vH2k4De7bbOFx8FWQu8P3Qpt4YDhkQFEXiPUGx1v06KAPSskcqSFk902O
	ugIRg17CCjbcePwFYptJaF+Zb+XDgqwxZBdg+3mDFanBOeQysFmPtPvHmwYH43FI8hJYraEW1k33m
	xcqu6ghw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQCuN-00000009KZz-0Dia;
	Thu, 21 May 2026 23:34:31 +0000
Received: from mail-qv1-xf2a.google.com ([2607:f8b0:4864:20::f2a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQCuK-00000009KZR-1q1r
	for kexec@lists.infradead.org;
	Thu, 21 May 2026 23:34:29 +0000
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-8b1f2b7f1bcso101360136d6.1
        for <kexec@lists.infradead.org>; Thu, 21 May 2026 16:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779406467; x=1780011267; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2qvJumL5Uy9qaseIh6HBDqg5ydk4M44ynTEuc1EKrP8=;
        b=UjTP6xS4VQFfAVnqIqRUjiQvfxXFN4rFibi6mCo0DWJuD631haxeeQe1/9RTUGFNTT
         ynNMZryg6IMr4ScIzHN/MK4H9md+NAhWL7sb+jSxM4qrQwydl2LzUqs4MGBQTMjdDVGL
         RwwWvKk2R4CHVyS+1f8KtlaLzeySlRqRyxaX/mVfAAvwOzoiis7ljUcBQJZ4Lq90Q6Y7
         HJsu+i+avUvrb8PsymHIWP2cRU3nU7L3Mn7anvj9nXZ0/FHPKp6vfH4UlhsptSGJrrWl
         VjHbfDs3iNwH5wH5r+5z1G2pMEZcenDNIg5OuG0jgEDp0QPp8wczBzh6EHJ881wFnA2d
         glUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779406467; x=1780011267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2qvJumL5Uy9qaseIh6HBDqg5ydk4M44ynTEuc1EKrP8=;
        b=R/qMYuxpDgatxbN3uz8Bqvb9HEhuc90EdXdFR+3YJj7qJc2vVw8HFTmyVgI3T4NSHk
         Oa0A7ybcU1SjPfmlCwj9VOn+sZfbHFbdPZLZtEbC26txj8pqoeG6cKqu/UAYMVamFCOj
         9rH4B1Qy38c6vChLGbv7ioPiYEX2r7VTkp95J9Q8hO5QkUBKmZgkIpzci0UjYewhEPxY
         JEzddiN2PvtdoMQK7KKLvWjwQTI5Y/9/o4pd3LicialwclI7Cia8cNXsojxkRmF2wd59
         6gTPYSvsvIOKZT+oeZfBwep+z/Xw/c0EA+5y4gx3XSQIV9oqbGgMx9xbDgZFknKPsHdV
         gKDA==
X-Forwarded-Encrypted: i=1; AFNElJ+S/y/nUhWFVjpu5fAuyJmKKU9Ulo6wCGAP2j100TZUVLPaDPi339n118J7RvaFcI/Erk2j3g==@lists.infradead.org
X-Gm-Message-State: AOJu0YzE15OuQJRipbv+R92QIyfzfxWBtXJauO247RCjTEh7j72RYzKS
	UNoHOAPpdA9sBZTZyMMEpk0URFYf0z2Vb7HLwLWVMZVfIZW6K52Ez8lyZThnazBp584=
X-Gm-Gg: Acq92OFnSG431lvi8u80zVD578H4e9xBQZsmbzw21vVHOZnYoBSrg/eiklKXptRq93E
	oktPS/BHUdrh36Y59Q7ppB4mUNHdygXm88fn/JKSMJJ3aArygVPBr7YuVlNTzPIeiNA2F1JeymH
	05kOX5l6MrcGsxVvhbl4K4HtFh54OT3LrmanH61AJxGkyaStlQI0r1ueVYiVf1xiWpxAhSDmwfm
	Wz/j7UW2+i3lztHW8jfmUT+ciEPM4akC7Mn/AOTbG0lNkUOcbZ65zAfQcCmK/gUwMiM/wJJJN8P
	n4DDUMYiD5X6NYn5FOS84dMVPwdOnlHzX55VvpF2g5mlsS/2AJgtZPF5/B1U2YhkEA9yYcVfsu9
	dhYkEBUIFTFrxe6a+Kt61tPQSxAuTycHMF1OqkrG/V0hcWEdtvvWNbzNbHQwG2a8RIX2YAUmnK6
	nJdl2lXKLXTjL5p7RKNVETkDJpJ3ySvBXiERnVTnY4X7G0B3p0TeA=
X-Received: by 2002:a05:6214:5882:b0:8a7:164c:d5c8 with SMTP id 6a1803df08f44-8cc7bf194acmr13939606d6.24.1779406467102;
        Thu, 21 May 2026 16:34:27 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc8132429bsm1526136d6.47.2026.05.21.16.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 16:34:26 -0700 (PDT)
Date: Thu, 21 May 2026 23:34:25 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Alexander Graf <graf@amazon.com>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Jason Miu <jasonmiu@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/12] kho: add data argument to radix walk callback
Message-ID: <ag-WdmAZXjb905-X@plex>
References: <20260429133928.850721-1-pratyush@kernel.org>
 <20260429133928.850721-6-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429133928.850721-6-pratyush@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_163428_504950_27A268B4 
X-CRM114-Status: GOOD (  25.92  )
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

On 04-29 15:39, Pratyush Yadav wrote:
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> 
> Add an opaque data pointer argument to kho_radix_walk_cb_t. This can be
> used for callers to pass extra information to the callback.
> 
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> ---
>  include/linux/kho_radix_tree.h     |  8 ++++----
>  kernel/liveupdate/kexec_handover.c | 24 +++++++++++++-----------
>  2 files changed, 17 insertions(+), 15 deletions(-)

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com> 

> 
> diff --git a/include/linux/kho_radix_tree.h b/include/linux/kho_radix_tree.h
> index fe7151d89361..6c0f7d82716b 100644
> --- a/include/linux/kho_radix_tree.h
> +++ b/include/linux/kho_radix_tree.h
> @@ -44,8 +44,8 @@ struct kho_radix_tree {
>   * return value is directly returned to the caller.
>   */
>  struct kho_radix_walk_cb {
> -	int (*key)(unsigned long key);
> -	int (*table)(phys_addr_t phys);
> +	int (*key)(unsigned long key, void *data);
> +	int (*table)(phys_addr_t phys, void *data);
>  };
>  
>  #ifdef CONFIG_KEXEC_HANDOVER
> @@ -53,7 +53,7 @@ struct kho_radix_walk_cb {
>  int kho_radix_add_key(struct kho_radix_tree *tree, unsigned long key);
>  void kho_radix_del_key(struct kho_radix_tree *tree, unsigned long key);
>  int kho_radix_walk_tree(struct kho_radix_tree *tree,
> -			const struct kho_radix_walk_cb *cb);
> +			const struct kho_radix_walk_cb *cb, void *data);
>  
>  #else  /* #ifdef CONFIG_KEXEC_HANDOVER */
>  
> @@ -66,7 +66,7 @@ static inline void kho_radix_del_key(struct kho_radix_tree *tree,
>  				     unsigned long key) { }
>  
>  static inline int kho_radix_walk_tree(struct kho_radix_tree *tree,
> -				      const struct kho_radix_walk_cb *cb)
> +				      const struct kho_radix_walk_cb *cb, void *data)
>  {
>  	return -EOPNOTSUPP;
>  }
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 94ca831b41c9..d0a4f78eccfe 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -267,14 +267,14 @@ void kho_radix_del_key(struct kho_radix_tree *tree, unsigned long key)
>  EXPORT_SYMBOL_GPL(kho_radix_del_key);
>  
>  static int kho_radix_walk_leaf(struct kho_radix_leaf *leaf, unsigned long key,
> -			       const struct kho_radix_walk_cb *cb)
> +			       const struct kho_radix_walk_cb *cb, void *data)
>  {
>  	unsigned long *bitmap = (unsigned long *)leaf;
>  	unsigned int i;
>  	int err;
>  
>  	if (cb->table) {
> -		err = cb->table(virt_to_phys(leaf));
> +		err = cb->table(virt_to_phys(leaf), data);
>  		if (err)
>  			return err;
>  	}
> @@ -283,7 +283,7 @@ static int kho_radix_walk_leaf(struct kho_radix_leaf *leaf, unsigned long key,
>  		return 0;
>  
>  	for_each_set_bit(i, bitmap, PAGE_SIZE * BITS_PER_BYTE) {
> -		err = cb->key(key | i);
> +		err = cb->key(key | i, data);
>  		if (err)
>  			return err;
>  	}
> @@ -293,7 +293,7 @@ static int kho_radix_walk_leaf(struct kho_radix_leaf *leaf, unsigned long key,
>  
>  static int __kho_radix_walk_tree(struct kho_radix_node *root,
>  				 unsigned int level, unsigned long start,
> -				 const struct kho_radix_walk_cb *cb)
> +				 const struct kho_radix_walk_cb *cb, void *data)
>  {
>  	struct kho_radix_node *node;
>  	struct kho_radix_leaf *leaf;
> @@ -302,7 +302,7 @@ static int __kho_radix_walk_tree(struct kho_radix_node *root,
>  	int err;
>  
>  	if (cb->table) {
> -		err = cb->table(virt_to_phys(root));
> +		err = cb->table(virt_to_phys(root), data);
>  		if (err)
>  			return err;
>  	}
> @@ -323,10 +323,10 @@ static int __kho_radix_walk_tree(struct kho_radix_node *root,
>  			 * node is pointing to the level 0 bitmap.
>  			 */
>  			leaf = (struct kho_radix_leaf *)node;
> -			err = kho_radix_walk_leaf(leaf, key, cb);
> +			err = kho_radix_walk_leaf(leaf, key, cb, data);
>  		} else {
>  			err  = __kho_radix_walk_tree(node, level - 1,
> -						     key, cb);
> +						     key, cb, data);
>  		}
>  
>  		if (err)
> @@ -340,6 +340,7 @@ static int __kho_radix_walk_tree(struct kho_radix_node *root,
>   * kho_radix_walk_tree - Traverses the radix tree and calls a callback for each key.
>   * @tree: A pointer to the KHO radix tree to walk.
>   * @cb:   Set of callbacks to be invoked during the tree walk.
> + * @data: Opaque data pointer passed to each callback in @cb.
>   *
>   * This function walks the radix tree, searching from the top level down to the
>   * lowest level (level 0), invoking the appropriate callbacks.
> @@ -348,14 +349,15 @@ static int __kho_radix_walk_tree(struct kho_radix_node *root,
>   *         value from the callback that stopped the walk.
>   */
>  int kho_radix_walk_tree(struct kho_radix_tree *tree,
> -			const struct kho_radix_walk_cb *cb)
> +			const struct kho_radix_walk_cb *cb, void *data)
>  {
>  	if (WARN_ON_ONCE(!tree->root))
>  		return -EINVAL;
>  
>  	guard(mutex)(&tree->lock);
>  
> -	return __kho_radix_walk_tree(tree->root, KHO_TREE_MAX_DEPTH - 1, 0, cb);
> +	return __kho_radix_walk_tree(tree->root, KHO_TREE_MAX_DEPTH - 1, 0, cb,
> +				     data);
>  }
>  EXPORT_SYMBOL_GPL(kho_radix_walk_tree);
>  
> @@ -501,7 +503,7 @@ static struct page *__init kho_get_preserved_page(phys_addr_t phys,
>  	return pfn_to_page(pfn);
>  }
>  
> -static int __init kho_preserved_memory_reserve(unsigned long key)
> +static int __init kho_preserved_memory_reserve(unsigned long key, void *data)
>  {
>  	union kho_page_info info;
>  	struct page *page;
> @@ -1392,7 +1394,7 @@ static int __init kho_mem_retrieve(const void *fdt)
>  
>  	kho_in.radix_tree.root = phys_to_virt(kho_get_mem_map_phys(fdt));
>  	mutex_init(&kho_in.radix_tree.lock);
> -	return kho_radix_walk_tree(&kho_in.radix_tree, &cb);
> +	return kho_radix_walk_tree(&kho_in.radix_tree, &cb, NULL);
>  }
>  
>  static __init int kho_out_fdt_setup(void)
> -- 
> 2.54.0.545.g6539524ca2-goog
> 

