Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5403CD5BAB
	for <kexec@archiver.kernel.org>; Thu, 21 May 2026 23:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ALlc+rSkkMdtbljNag13qxzB8Q5Vali1I2lgtUdeRqk=; b=uIA8ODdObvNfwT4FXRdF0etQcN
	R6szK0ugtMekQejPuu8X2rXszCXITmI3jGYX+BghQujURUAh1iDEDn4ly1kNNrjCiVOVQi5o7b/cq
	SHF/80jegTpwIYfDm/wCQK2Y91yL4fzVa/CrOPs6PPJSZqoldBWEcyz9ZMDUEezrCoyiZ8Z/jwvTc
	2MkzUbdN6ndSxIeIrkh/1XeKqlL4UVHKTGB7kQJuWgzWlz+Ba8q6Y0jO1LFc+RP4d3p+xHzIRCi26
	p4zb6pNPLx9YCi1WtUGmoIIrBCrjwdE3Ntrmz74BwzR9BazY/xo6mnMNCq7i/yrAI2RhtmCfuE2sx
	SNe9/ejQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQD5w-00000009LWQ-1NmZ;
	Thu, 21 May 2026 23:46:28 +0000
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQD5u-00000009LVx-1jAV
	for kexec@lists.infradead.org;
	Thu, 21 May 2026 23:46:27 +0000
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-51306c9f2a8so78919831cf.1
        for <kexec@lists.infradead.org>; Thu, 21 May 2026 16:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779407185; x=1780011985; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ALlc+rSkkMdtbljNag13qxzB8Q5Vali1I2lgtUdeRqk=;
        b=XO30vRb2bMJB7KOS+ufVgvkcAqtip8OZAm27BSrGYR4zIKNjtwfjwjgTvRVNzzTE6m
         3YDMnkt2phdZIyz2nx9WnuOZ8o6t84Fp+HaDuwntQRRvMIUD4U6IDPIE+iBetr6VPdSn
         eoR1z/63hmWgjBelT/HiTjgTjm6jNmhBFhCKiisnCHbbRUySwi4ahsm/8DA8XC4NBuPc
         /rMddUtBF60RbK+T7eDNNECuMf3m+AxbjbKTF++JEBa69LsBH+ZfXGGozXr8WdLTvY3H
         YNZNUbmsWxA7LK1R5uawUMEDTEcWFxKSsElfTU500lAs9ys9MY0wdx6TcblnMKdDGWAf
         rKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779407185; x=1780011985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALlc+rSkkMdtbljNag13qxzB8Q5Vali1I2lgtUdeRqk=;
        b=BJzSsWYswI7E3k0089mkfONK3LVnYYlgqUr7eOSsO607JpEw/0rVud8GG4UzTi1/54
         ZH6CZiseF7Aj+n9UguzxOzGaRflAc1/wtScaD/tLltQ3fE5Jv5tw0e2RrXgAbTWni/Fr
         9qv2ug/OtbZ+bawjsV/yHKzH8owO1FI3jkC29rNmgaJ1LCGN9/CjS5o65HigZnE9v09r
         gTTy4+V4xf5XsClySlmbNuuSwx0aF/1PiwTo88xi1geUpzAHSsVY0PZDPQOpQ6BNaaS/
         S1DGZMkx6nyCPfNCAkWL0pCuuR+mFjMGvaO0DpjN1FvJtld1dk3dJSGyEh20EyR9xfFk
         Y5bg==
X-Forwarded-Encrypted: i=1; AFNElJ8p8waUjOL/yBqsxnXfrBRoNMzIX/BXhwLrguaOYAAcGABR0JZiZ2DaP9suNcj2589VtC/G7A==@lists.infradead.org
X-Gm-Message-State: AOJu0YzEjGZNLJMZxPpEnXohMoaNtRxbKB3CAlUF3BlU2k+q0euw1v7x
	2+BUKtYhZbRNjjSEL08roiXjfslcFgHlYGvDstXXpry/R7kxWvlHQ6bYU3g02kn5inQ=
X-Gm-Gg: Acq92OFUkTxLPIBYQAfvkZIQc77scVM3FXJBEDENL3rWk6S3/1WyVJ+yUVYAOOUHI98
	FpYWuVyYZN/TSU3dYrbkqD1WdbP+/KVDD/Z9JBeaiTbOm13dPD0+nJtLmgZtTEPvmX59bjllyCV
	fXn3qmNBr9HbT+LXlU0j6DuOXn0VSpjJ0b0o/TcuWYAlTiR7YszgCnj17iTj2a/a3iocHqTejE8
	HTROWE7K1bSUYVR3N8whKCDYv7eok/ecyDF41X1QmPT92qvgNf2yHEe8sdrI3YaY7xRzMytZD0O
	Op+kvEBhkCcSyAHiP+OUXrlgwJC0L0MrYd6E4qiPLhcvkGhqIaeHiQTfpbFqEdNFiJpOf1JALAS
	YMzvghtpfEY36jf/0A2cCf7ssRtCzmMC7FEUTpBEcO7GODGQT+kVJHPByMacXDBSFkHeRFvxYPI
	1YzZafyvhrBmKnUaCJLGcjRXS3mcVL+UjUmL9kPvPtlH7JQw/yDVVJbq7UQz4l6w==
X-Received: by 2002:ac8:5749:0:b0:516:d191:f006 with SMTP id d75a77b69052e-516d45c9215mr21944911cf.42.1779407184872;
        Thu, 21 May 2026 16:46:24 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d6438635sm4789871cf.17.2026.05.21.16.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 16:46:24 -0700 (PDT)
Date: Thu, 21 May 2026 23:46:23 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Alexander Graf <graf@amazon.com>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Jason Miu <jasonmiu@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/12] kho: allow destroying KHO radix tree
Message-ID: <ag-Xa-bDOouXAFXb@plex>
References: <20260429133928.850721-1-pratyush@kernel.org>
 <20260429133928.850721-8-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429133928.850721-8-pratyush@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_164626_464509_8258B83B 
X-CRM114-Status: GOOD (  21.07  )
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
> Add kho_radix_destroy_tree() which allows destroying the radix tree and
> freeing all its pages.
> 
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> ---
>  include/linux/kho_radix_tree.h     |  3 +++
>  kernel/liveupdate/kexec_handover.c | 34 ++++++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+)

Generally, in Linux, recursion is avoided due to statically sized kernel 
stacks. However, here we are bound by a relatively shallow KHO tree, and 
kho_radix_walk_tree() is already recursive, so I think it is alright. We 
just need to be mindful of local variable usage (frame sizes) within these 
recursive functions.

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com> 

> 
> diff --git a/include/linux/kho_radix_tree.h b/include/linux/kho_radix_tree.h
> index 6c0f7d82716b..617395a6647a 100644
> --- a/include/linux/kho_radix_tree.h
> +++ b/include/linux/kho_radix_tree.h
> @@ -54,6 +54,7 @@ int kho_radix_add_key(struct kho_radix_tree *tree, unsigned long key);
>  void kho_radix_del_key(struct kho_radix_tree *tree, unsigned long key);
>  int kho_radix_walk_tree(struct kho_radix_tree *tree,
>  			const struct kho_radix_walk_cb *cb, void *data);
> +void kho_radix_destroy_tree(struct kho_radix_tree *tree);
>  
>  #else  /* #ifdef CONFIG_KEXEC_HANDOVER */
>  
> @@ -71,6 +72,8 @@ static inline int kho_radix_walk_tree(struct kho_radix_tree *tree,
>  	return -EOPNOTSUPP;
>  }
>  
> +static inline void kho_radix_destroy_tree(struct kho_radix_tree *tree) { }
> +
>  #endif /* #ifdef CONFIG_KEXEC_HANDOVER */
>  
>  #endif	/* _LINUX_KHO_RADIX_TREE_H */
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 47f7c4a2865e..29479534f65d 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -286,6 +286,40 @@ void kho_radix_del_key(struct kho_radix_tree *tree, unsigned long key)
>  }
>  EXPORT_SYMBOL_GPL(kho_radix_del_key);
>  
> +static void __kho_radix_destroy_tree(struct kho_radix_node *root,
> +				     unsigned int level)
> +{
> +	unsigned long i;
> +
> +	if (level == 0) {
> +		kho_radix_free_node(root);
> +		return;
> +	}
> +
> +	for (i = 0; i < PAGE_SIZE / sizeof(phys_addr_t); i++) {
> +		if (root->table[i])
> +			__kho_radix_destroy_tree(phys_to_virt(root->table[i]),
> +						 level - 1);
> +	}
> +
> +	kho_radix_free_node(root);
> +}
> +
> +/**
> + * kho_radix_destroy_tree - Destroy the radix tree
> + * @tree: The radix tree to destroy
> + *
> + * Walk @tree and free all its nodes.
> + */
> +void kho_radix_destroy_tree(struct kho_radix_tree *tree)
> +{
> +	if (!tree->root)
> +		return;
> +
> +	__kho_radix_destroy_tree(tree->root, KHO_TREE_MAX_DEPTH - 1);
> +}
> +EXPORT_SYMBOL_GPL(kho_radix_destroy_tree);
> +
>  static int kho_radix_walk_leaf(struct kho_radix_leaf *leaf, unsigned long key,
>  			       const struct kho_radix_walk_cb *cb, void *data)
>  {
> -- 
> 2.54.0.545.g6539524ca2-goog
> 

