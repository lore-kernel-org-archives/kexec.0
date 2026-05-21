Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81FB6CD5BAF
	for <kexec@archiver.kernel.org>; Thu, 21 May 2026 23:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vARGoD5RNG/Ecz0OD6Sd5EbHpdRmJLMUv9Hfoq7eURQ=; b=k4qyrgCRIu9LRhfGedFN8oDd4R
	IAqhvVGKN73DOSnGEBE9ay62rgb5YWva/BT2OBCZUeyganH5mTKuyRlk5yqrt/+t0bTdEWghj0p8A
	CCIf+zJsKIS9ucdeLn9bkBbBB6wwIFcHBxTqvRvAZob11BtxpqzOb/KM8B5JB3FqFW3pvz5y8hAqb
	HamXiupuYcC0f189W9iQ4KNesmmdkGGyLHTMm+NQLVPn1avKypMdP6MTqFTtQFCeFwsAqMtBijpLH
	LpSoI40QAXJ5bngyt+oSsTG/+fYwIfHS5s19Gj+FsO1AuOwjTtamgPPmG3kl0RCvUAmCUuIqegfMN
	8dRlY3/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQCwu-00000009KpC-28X8;
	Thu, 21 May 2026 23:37:08 +0000
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQCws-00000009Koi-06va
	for kexec@lists.infradead.org;
	Thu, 21 May 2026 23:37:07 +0000
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-8bb09239328so52418636d6.3
        for <kexec@lists.infradead.org>; Thu, 21 May 2026 16:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779406624; x=1780011424; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vARGoD5RNG/Ecz0OD6Sd5EbHpdRmJLMUv9Hfoq7eURQ=;
        b=KYaaV2F+lg2dxjKgwTosOEyokY1rq6uPB7hwfOs8MTIYg19diOFp955UxOy/oB3MNW
         IOVymVz+n8uQDYSKTwu+pYGGBzhpV7Ti1wJ9d7qfO/KXcumzwCNin0K4rN4EpTe39XK+
         KNWNS2/Fh+dw8TmEd0DImzSoYApHGNG34v6R51Df9S4puorNVNMzy+aJtedW8FIevFwq
         q4nS+e5aybJH5vbDkIAgvCZrFRJO5B3w9KWCHb1WSVIN1JeT8Rlctz89XkzKYHV0sMAt
         RuPlSygsP2H7kAX80tK4/xG3pI/oFoELVLGY5CZF1hMem4Nd+9Zf0bOtoTy6+8+5dYLn
         sEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779406624; x=1780011424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vARGoD5RNG/Ecz0OD6Sd5EbHpdRmJLMUv9Hfoq7eURQ=;
        b=lqj26n44uBkXJcqCfZkYciKH6FWbIgx5r8IDVy7tweCY4/vlsxagntVv8ox95UWuqw
         473aHJy6Qc/GrYEhL+G5s3u+EXQ1q1fidUOBvj2fhUbUWkaVlRQDL+qMq/AHi4NkOJGA
         c6OIuvzyelo1Ad2OnCnwBow8Naarg2c+Pxz7icsjQyvw7XALWU1VQvSkshBYrZkMVo/0
         ZHpdXCOiwZ/yKlwjA5j2Ccgt3m1UtMb9kJ7CA5S+EO6ANxYKn5Xb7gsNeiAhlS7KS+6p
         O4hSCSSfpjrNelv6LqiOEBONshiLcPL8+nXsUrUtI68RHP/tl0iWH+ujS2PDBtKQkPhY
         V5cA==
X-Forwarded-Encrypted: i=1; AFNElJ91Db2oK/28NwxU3NihgYFqVH9sw4clkyUCqf+/58S1HJPgQ16tZVeaKUcQUyUt9EYPcAiNzg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzGuxdv5CuqHVQcpt5abtMMbJBKAsi49BbAqnt2cgeRyNOZj1jH
	PYlwbHrWjMZA665V2Bv5NMgmbMeOnwt2SKBbwL1c1D1Hbpm1FigZM2S9Tf4g6apPJzA=
X-Gm-Gg: Acq92OGhqe0571+M+YMaYIuXsTyT11Grns5dYZTuE0WpQ3UbAt/hWxpGpl5yAPU+Uku
	RZpmTuxyvAZ1B/wG+jZtBXYT+6twhwf69DYY0HhYapp9oniklaQmMnQyFF7tQ607i4Yovb3z/Jt
	Bp3NgBbI8uYu7SzgUOwbXgY1G8zQhjOx468yt/m9zebRm/XvqrDlW0kWB4r6YZnNum16+Uwqj9L
	AGJBISsHxF/8vg6CIUThmG4fqA/Cabn4Eh6AzxutO6AIBYdSF4ArS3rzgle0TD+PBz6mq+WCVz2
	GSfIC8+jlbmICaWMU3gMeK8QGd+M0yL7T33NppPrLalTITWRxLXldpry8dnld+mG8cE/8dC0HSe
	GL1yf1k0aFSyDv03ScYiyOF3Xh/0f7JFEPRIgLX40i4aMxR0jYS9SqIQDF9LPcWVouQg2U1PrXy
	4HWBF3NNdPUJpAZ509odrjVumxxIO7/23+4IL4zM4/4KROKu9cmq66F19GIeCvow==
X-Received: by 2002:ad4:5dc6:0:b0:8ca:1f6b:a27d with SMTP id 6a1803df08f44-8cc7b61a17fmr24930256d6.20.1779406624423;
        Thu, 21 May 2026 16:37:04 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc812e657csm1873266d6.24.2026.05.21.16.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 16:37:04 -0700 (PDT)
Date: Thu, 21 May 2026 23:37:03 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Alexander Graf <graf@amazon.com>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Jason Miu <jasonmiu@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/12] kho: allow early-boot usage of the KHO radix tree
Message-ID: <ag-W3t7CSFHw4Wej@plex>
References: <20260429133928.850721-1-pratyush@kernel.org>
 <20260429133928.850721-7-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429133928.850721-7-pratyush@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_163706_076769_C8062D3A 
X-CRM114-Status: GOOD (  25.85  )
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
> The KHO radix tree allocates memory for table pages from the buddy
> allocator using get_zeroed_page(). This is not available in early boot
> when memblock is still active.
> 
> Using the radix tree in early boot is useful for KHO to track metadata
> about its memory. One such example is for tracking free blocks for
> memory allocation when scratch runs out of space. This feature will be
> added in the following commits.
> 
> Add kho_radix_{alloc,free}_node() which allocate and free the table
> pages. They use slab_is_available() to decide which allocator to use.
> While slab_is_available() indicates availability of the slab allocator,
> it gets initialized right before buddy so it serves the same practical
> purpose.
> 
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com> 

> ---
>  kernel/liveupdate/kexec_handover.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index d0a4f78eccfe..47f7c4a2865e 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -143,6 +143,26 @@ static unsigned long kho_radix_get_table_index(unsigned long key,
>  	return (key >> s) % (1 << KHO_TABLE_SIZE_LOG2);
>  }
>  
> +static void __ref *kho_radix_alloc_node(void)
> +{
> +	struct kho_radix_node *node;
> +
> +	if (slab_is_available())
> +		node = (struct kho_radix_node *)get_zeroed_page(GFP_KERNEL);
> +	else
> +		node = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> +
> +	return node;
> +}
> +
> +static void __ref kho_radix_free_node(struct kho_radix_node *node)
> +{
> +	if (slab_is_available())
> +		free_page((unsigned long)node);
> +	else
> +		memblock_free(node, PAGE_SIZE);
> +}
> +
>  /**
>   * kho_radix_add_key - Add a key to the radix tree.
>   * @tree: The KHO radix tree.
> @@ -183,7 +203,7 @@ int kho_radix_add_key(struct kho_radix_tree *tree, unsigned long key)
>  		}
>  
>  		/* Next node is empty, create a new node for it */
> -		new_node = (struct kho_radix_node *)get_zeroed_page(GFP_KERNEL);
> +		new_node = kho_radix_alloc_node();
>  		if (!new_node) {
>  			err = -ENOMEM;
>  			goto err_free_nodes;
> @@ -214,7 +234,7 @@ int kho_radix_add_key(struct kho_radix_tree *tree, unsigned long key)
>  err_free_nodes:
>  	for (i = KHO_TREE_MAX_DEPTH - 1; i > 0; i--) {
>  		if (intermediate_nodes[i])
> -			free_page((unsigned long)intermediate_nodes[i]);
> +			kho_radix_free_node(intermediate_nodes[i]);
>  	}
>  	if (anchor_node)
>  		anchor_node->table[anchor_idx] = 0;
> -- 
> 2.54.0.545.g6539524ca2-goog
> 

