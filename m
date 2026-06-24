Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79954CDB479
	for <kexec@archiver.kernel.org>; Wed, 24 Jun 2026 19:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zeRIelXWCkeQ/dWoO1Ec0xhONeA3LFt7A97Ox2lp8yI=; b=zzhwpP6MbUx6Ebw50mNf+2E0lm
	d54vI9Hs9l27EEx9dWqAfv104TTN3ZNNzU7BnsjRFZhNdQgI6pNwivaAIL7MMKNFm/Kv0F22JoaBd
	Tbg7bXx0rYuqNBVWgusxlDz54mmcIQq1DD6frROZmbr1t76oI8fliC03Kt6m6Ej91yk3FyM60wcEB
	zPBPiq3kfJxHAUgGdIrO6t7t8NLAYFvGOooHRc3daIAukoNUbqT1yDnmTz4FURudJidigT382RC8g
	DsYHQZp/fgkiTO/oPkd0LPRrmYDts/YSM9qm7621HH/KclNUUMCq/FyEP2EHNM2kdptb2Xzc/aTtW
	cV/3XLnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcSzq-00000008FSq-0Bjd;
	Wed, 24 Jun 2026 19:10:50 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcSzl-00000008FSI-1KBc
	for kexec@lists.infradead.org;
	Wed, 24 Jun 2026 19:10:48 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2c73cefe192so8915ad.1
        for <kexec@lists.infradead.org>; Wed, 24 Jun 2026 12:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782328244; x=1782933044; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zeRIelXWCkeQ/dWoO1Ec0xhONeA3LFt7A97Ox2lp8yI=;
        b=TH3jypoWIP12MrY9e9xmkKiSb/6S+lp4MqIpiyvGnDIcY06MR0e52Asrmku19kEWAx
         Y+hLY8qQs1Doc0SLHzuzjyoN8gPyqAsPzJc8Krq+f6qkBH5CjMa4kwcNc+I27bLShyTO
         E70xh31wxOi2OvJjhO2xv39dhmR6Eo9synFXNDHSWcP9uHiwNKt2f/i9PYZMCaScKTQz
         BbbE0mPou4VKOWuQdflTLgYJ0bUfHNWkfYUR3OTwXncjbppvf9BbBP4r+G95vc9yebUO
         1fmfYvKx8nvS7RYs9tOHhOk8uBNYBj0AMFcVXv8LBianYk7EaWmTfP0qDlKVFcr59ZmR
         mcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782328244; x=1782933044;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zeRIelXWCkeQ/dWoO1Ec0xhONeA3LFt7A97Ox2lp8yI=;
        b=BzkZzFVX+7h3QZHJm8pq5qm2aVBXqxMHxBUTyJAHt9D39d5DAdomP8tuah1Ay0b/I8
         OTxQ3uXxurb82TjIgwxgUr8GuQ/58+gfBYesogRCE8ddQx+Z95lS1EXTtOxtO4ge9kWO
         vwaEDLXcwawW/OqMtN2KJ2CeUibXCRAtRWou4N5YE/e8slfAhdrrH3+J9jRwkdM8Z7F7
         Az/dlgCF5czraEd5TvfmoZk5LMVTjtdbEeBgCHZcoSlAkY26HjJnTQ2w4ee3a+95X/SC
         7ofjoAZWy9YwhNXVQeYKzga3G/AMP4HK3OLApCkfj+6sC6PxfeVofpirOlVCNZusSU43
         cokQ==
X-Forwarded-Encrypted: i=1; AHgh+RpPfXlSvHpGrceHeIIzx93JQIbRgG8PlCiCVywVtLVzLVoho3Tw8L9342E6fKk0ffSUxu9toQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzEwEuPmOgV6wHL4LNROUbq9gfgQDc+Xr6eSyL/uYWSZ7gWmq1k
	09+7caeQ92a28qEmjgL+mqPapeaLPPFPPIH6nyKdSY1M3n87doGZv0gkz+LLvVLapQ==
X-Gm-Gg: AfdE7clxxsq+9pCxSWPurl/gdjcxS5qNoFCKOPCI+U0caIdOxkIZ0E1jMZTpW9xrckB
	VQMuPbSXinM3pzdOE8FoPoSp9O+aG5gKZkf8kk8+Ta9F1Bg2h6IBf7nVUNkl/SIxFxDnV3wg9iR
	L7eM/fVMWGJwcpV9eu/TdTdEeAVUedgqCB9uZdKSZFyyIWyAIotJIKl8IJiJEeqjj/iN5AqpKzL
	ehX7IAz1DUNa575+Pg52HogMeqQuUBOjRngn38JTYjoVyrhj1fVfvMw9vWI4WbXjCUilArgzzQl
	ddac/xKnHDVD3/mOfSJSUAtVtde9zQsKIfLyaX4TnVokH5G4cyZfJ6Gkdkx6qKPW0kb0ij26C6q
	s9pr+LpqhYmmp/2wFrtrAYddHxp5spzQVgH6D1rxDwMQbsx+UqdkJM48mCZ1BocICo2QduByB6t
	Xc19FmrVoGMmvcOCFSrrHFipuvrVj8KPRQRYrG5C3GnDXOyfGlEBCo6zeF9Evd0YQjBaPCzIM6G
	J4JuvuS
X-Received: by 2002:a17:902:d50c:b0:2c1:ee6e:be1c with SMTP id d9443c01a7336-2c7f78d26e7mr319365ad.26.1782328243785;
        Wed, 24 Jun 2026 12:10:43 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a40ee417sm2715140b3a.40.2026.06.24.12.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 12:10:43 -0700 (PDT)
Date: Wed, 24 Jun 2026 19:10:39 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev, 
	kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [RFC PATCH 2/4] dma/pool: Add an API to check if DMA allocation
 is from pool
Message-ID: <ajwpcdIXEeFj-uUr@google.com>
References: <20260505002737.2213734-1-skhawaja@google.com>
 <20260505002737.2213734-3-skhawaja@google.com>
 <aicFes0uxUFQAduC@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aicFes0uxUFQAduC@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260624_121045_367089_AC7F846B 
X-CRM114-Status: GOOD (  19.34  )
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

On Mon, Jun 08, 2026 at 06:10:02PM +0000, Pranjal Shrivastava wrote:
>On Tue, May 05, 2026 at 12:27:35AM +0000, Samiullah Khawaja wrote:
>> DMA allocations can be done through DMA pools, add an API that can be
>> used to check if an allocation is done from a pool. This will be used in
>> the later commit during preservation of DMA allocation.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  include/linux/dma-map-ops.h |  1 +
>>  kernel/dma/pool.c           | 13 +++++++++++++
>>  2 files changed, 14 insertions(+)
>>
>> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
>> index 6a1832a73cad..6a0bc4ea2467 100644
>> --- a/include/linux/dma-map-ops.h
>> +++ b/include/linux/dma-map-ops.h
>> @@ -216,6 +216,7 @@ struct page *dma_alloc_from_pool(struct device *dev, size_t size,
>>  		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t));
>>  bool dma_free_from_pool(struct device *dev, void *start, size_t size);
>>
>> +bool dma_is_from_pool(struct device *dev, void *start, size_t size);
>>  int dma_direct_set_offset(struct device *dev, phys_addr_t cpu_start,
>>  		dma_addr_t dma_start, u64 size);
>>
>> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
>> index 2b2fbb709242..32ce4d6d7683 100644
>> --- a/kernel/dma/pool.c
>> +++ b/kernel/dma/pool.c
>> @@ -307,3 +307,16 @@ bool dma_free_from_pool(struct device *dev, void *start, size_t size)
>>
>>  	return false;
>>  }
>> +
>> +bool dma_is_from_pool(struct device *dev, void *start, size_t size)
>
>Do we need struct device here? It seems unused?
>
>Nit: we only ever pass 0 gfp_flags to dma_guess_pool, should we instead
>name it: dma_is_from_atomic_pool() to be more accurate?

dma_guess_pool() goes through all of them when passing 0, look at the
prev logic inside it and how it is used by the dma_free_from_pool(). But
you are right they are all atomic, but semantically we want to check
whether it is part of any pool so lets keep it as is. WDYT?
>
>> +{
>> +	struct gen_pool *pool = NULL;
>> +
>> +	while ((pool = dma_guess_pool(pool, 0))) {
>> +		if (!gen_pool_has_addr(pool, (unsigned long)start, size))
>> +			continue;
>> +		return true;
>> +	}
>
>Nit: The loop looks slightly ugly, can we have:
>
>struct gen_pool *pool;
>
>for (pool = dma_guess_pool(NULL, 0); pool != NULL; pool = dma_guess_pool(pool, 0)) {
>	if (gen_pool_has_addr(pool, (unsigned long)start, size))
>		return true;
>}

It is a basically a copy dma_free_from_pool() without the free part, so
keeping the style consistent.
>
>> +
>> +	return false;
>> +}
>> --
>> 2.54.0.545.g6539524ca2-goog
>>
>
>Thanks,
>Praan

Thanks,
Sami

