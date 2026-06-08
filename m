Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C73CCD8CA4
	for <kexec@archiver.kernel.org>; Mon,  8 Jun 2026 18:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xEllMNXAKazcdxTo09h79Zq4pXvu6XvS48U9FqZI2UI=; b=aohjOZJ3Q7XGxS7ft5l2Gj2o+x
	Ptd0mo9Q/bZpXAmJTUw60LJ1bp8eTwaVQJsHuIhkmvzSCt1JtPu1yYCPpPJbPM1FPHNOJdyl6Algq
	3OtGPkpUM8wd9UoFKl8BfVAr2+t1IBcjlULpKOYBmYaJUYjhPdUUn3ONVOEThLp1omCx74woUfM1p
	91yBsgBsbqjweZNXcTqVmt6qvl15GdLGG5nkRdZp6V47lUs19BHw995+txis1QUwWEqwYtmGl8Ngd
	WLG0php9PBwB9H/auIeNqz9aCt83jMBoAZjxMmyrlDkAfzQpVoRqmTXIqJh1cTVTMJm6CQP84oFWD
	ITw5AReQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWeQQ-00000004Fhm-3nrn;
	Mon, 08 Jun 2026 18:10:14 +0000
Received: from mail-dl1-x1234.google.com ([2607:f8b0:4864:20::1234])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWeQO-00000004FhI-2Ozf
	for kexec@lists.infradead.org;
	Mon, 08 Jun 2026 18:10:13 +0000
Received: by mail-dl1-x1234.google.com with SMTP id a92af1059eb24-1336742714fso34361c88.1
        for <kexec@lists.infradead.org>; Mon, 08 Jun 2026 11:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780942212; x=1781547012; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xEllMNXAKazcdxTo09h79Zq4pXvu6XvS48U9FqZI2UI=;
        b=qJJGl04mFo71FT1MJb50LfOi7iP4f4UZSk+x9XFVBj6j2s5jEFI+kUHqwqnOExQ2A9
         sRh8ndwGABtyXq1i/Wef8qLBn7U2uaI1zjJaaiffS1lEqkjeSvr+ZeYEJNqQfIrK3+5O
         oCP2ZSmdxxto8sEXLh9KotQT3sfmdCvl3h1aPtMIM0dCWq9Bvk7w1O/QdgMqqBqPDvnQ
         EwEQWtwL4KmmB/NSHaEGLu+3NYwA4uazxLKmp6/wHveP4T3wADa529t8AOapInFK+cOT
         TcbLKK6dMGf/3EvqhOMN+z5Kf/Xc6boyDQ+81UN+nrwD5ZLSTEgTZtuzl60Kui9HtSf2
         ql9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780942212; x=1781547012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEllMNXAKazcdxTo09h79Zq4pXvu6XvS48U9FqZI2UI=;
        b=Ary00htNFuTEp1aiGyqdERNonD4eGVncMsVTljxpIprISn86FfkjBKgpfciE79JoKw
         RTI/PxMpcbU6+B4r+0f83Av7uptJmHuG75kmYf7pmCUEE9Va4OIHW+ILMSqCWCwIUHuR
         xK2FpXEHoaFOjau3YNbDMqKm7KcWM/vzRtFTOBDN6tfZjubF0BdQAqn66F9xNiGUt51Q
         oDQUEEY0IbHL0GmrNQ4nq9siL7HzZ7ai/AjtRO/OrvGH3eC5LHGaofnflem17rg2+gDK
         4ira+4svsJ/oXu8lJCMVt4i6fuB8KTBSGP+Y2NqLO3VOqd9fyTHfoTlUZYQK69GheKCx
         AMwg==
X-Forwarded-Encrypted: i=1; AFNElJ+dQkiqv/qwpA5cRoE9jHhcAyQp0D+kIRCUSUn/zK8W5NNTw6C6FoNLdJs+6b1BAwUxqXtlEg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwDPT52NMvRBIU6eIMrVK4zNF9/ze4vuA0mD2qGHSjcGgJoLwRL
	It2SchsjZgTnsGUowtTLzGUpf0Zq8cG5bnATYzN2b2HYYoBYhfRTuYcNIx3jYLxZDg==
X-Gm-Gg: Acq92OFmzRFvLaMF1heJFd8tkple+t7VXgZzyZqCuHR6piOTfd6WqX0W2wh7OFYJWXa
	59ovcK6lGxfOrv6zV/PO0xlJ//bmQyA6Hlg4WvyMNyUf3M9wxBaTFIhTuE8kE5a/wTgxz6VjFf0
	2DAlJw6YycK7xYgOgqPwdaZvlDlSt7endk2vQGT55unfX/+GVv/MLg6pV2luJBpRtr7VWsk+1m9
	T1UqkWvE/2vQdes3o3iRgV7F6ZaXhHHbOcXl9c3Ahyuj32pgNJTy5BTMiIJebDO6UrUoW0GIua+
	BXclx3Dqauyhorwwo9q1wmDf4eZU4Q+bbWUbePArv/BVPLerSj1zFKCZvUy8/5ZUdvkHxbTMSdg
	BSNA6DtfsMagaXfPPcjL7itJejwvq8fR3KOQ36jdR8qaCkXZ5q5jRq5BVllYvfdAmkKvH4WSYZt
	0wK5Rk2jmuhqk7H8Y4zXuYWuSLY3uIpWBJdny0N3JIi+7npE1i/9+BRqL80BbPHW3+XIAZGq8=
X-Received: by 2002:a05:7022:38f:b0:11a:2c18:9e70 with SMTP id a92af1059eb24-13807c516c0mr439910c88.11.1780942210090;
        Mon, 08 Jun 2026 11:10:10 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f5550bcdsm13363034c88.14.2026.06.08.11.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 11:10:09 -0700 (PDT)
Date: Mon, 8 Jun 2026 18:10:02 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [RFC PATCH 2/4] dma/pool: Add an API to check if DMA allocation
 is from pool
Message-ID: <aicFes0uxUFQAduC@google.com>
References: <20260505002737.2213734-1-skhawaja@google.com>
 <20260505002737.2213734-3-skhawaja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505002737.2213734-3-skhawaja@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260608_111012_617155_159B097A 
X-CRM114-Status: GOOD (  19.45  )
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

On Tue, May 05, 2026 at 12:27:35AM +0000, Samiullah Khawaja wrote:
> DMA allocations can be done through DMA pools, add an API that can be
> used to check if an allocation is done from a pool. This will be used in
> the later commit during preservation of DMA allocation.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  include/linux/dma-map-ops.h |  1 +
>  kernel/dma/pool.c           | 13 +++++++++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> index 6a1832a73cad..6a0bc4ea2467 100644
> --- a/include/linux/dma-map-ops.h
> +++ b/include/linux/dma-map-ops.h
> @@ -216,6 +216,7 @@ struct page *dma_alloc_from_pool(struct device *dev, size_t size,
>  		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t));
>  bool dma_free_from_pool(struct device *dev, void *start, size_t size);
>  
> +bool dma_is_from_pool(struct device *dev, void *start, size_t size);
>  int dma_direct_set_offset(struct device *dev, phys_addr_t cpu_start,
>  		dma_addr_t dma_start, u64 size);
>  
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 2b2fbb709242..32ce4d6d7683 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -307,3 +307,16 @@ bool dma_free_from_pool(struct device *dev, void *start, size_t size)
>  
>  	return false;
>  }
> +
> +bool dma_is_from_pool(struct device *dev, void *start, size_t size)

Do we need struct device here? It seems unused?

Nit: we only ever pass 0 gfp_flags to dma_guess_pool, should we instead
name it: dma_is_from_atomic_pool() to be more accurate?

> +{
> +	struct gen_pool *pool = NULL;
> +
> +	while ((pool = dma_guess_pool(pool, 0))) {
> +		if (!gen_pool_has_addr(pool, (unsigned long)start, size))
> +			continue;
> +		return true;
> +	}

Nit: The loop looks slightly ugly, can we have:

struct gen_pool *pool;

for (pool = dma_guess_pool(NULL, 0); pool != NULL; pool = dma_guess_pool(pool, 0)) {
	if (gen_pool_has_addr(pool, (unsigned long)start, size))
		return true;
}

> +
> +	return false;
> +}
> -- 
> 2.54.0.545.g6539524ca2-goog
> 

Thanks,
Praan

