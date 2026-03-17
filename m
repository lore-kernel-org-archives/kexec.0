Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E951FF6E9B
	for <kexec@archiver.kernel.org>; Tue, 17 Mar 2026 23:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XN/qOC5CJ/bhMlRJKWhmjAU6IJC68YMTmoD5LWl17yI=; b=liyq4KAY5eYMGK/BhkizLn0wUY
	7MhH/2K6UMSSgHdbo8zaTLbrli/TlAQDWF+FaV45A25UhXSkoQ9Eze2nCVawDuMfZkuMt7awhjzWY
	2MAidRFKBlyOMKFA7mxRHcwewh8itdaU2FEy8sWc/bQM9FMyK1IcYfGNjZnIH7xZKLkPlyl60p66f
	kcHdzv0yLtuf4HGRWM8MpiO4annIib7aTjrrz+EJku//N3CVU+6v+/1UM4D0l1Cddx19Ps39tY+bI
	i+tKL5YcZ0Gj5HGN2upSPW/VxgfHDCyebUSsTVpU6LHWrhvrZH9wepcBECXhdIdYYcgAIQy++fiks
	PO4GeUIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2dkn-00000007SMN-3JOn;
	Tue, 17 Mar 2026 23:23:13 +0000
Received: from mail-dy1-x1334.google.com ([2607:f8b0:4864:20::1334])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2dkl-00000007SLT-1GLt
	for kexec@lists.infradead.org;
	Tue, 17 Mar 2026 23:23:12 +0000
Received: by mail-dy1-x1334.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so1095108eec.1
        for <kexec@lists.infradead.org>; Tue, 17 Mar 2026 16:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773789790; x=1774394590; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XN/qOC5CJ/bhMlRJKWhmjAU6IJC68YMTmoD5LWl17yI=;
        b=XxCpL7abqMI7larTfX1VmhLUycsqnhtM2pBpzONmOXGc2Pvsy9LLhOisCvmwSEavGk
         WSEGkETWoqbxgF9yW3DNMK7Ksb95O6LmH6UW/4gaKYIJcpeW9vRrt+5BOmqCAUwYIJsv
         xZRyC5FrlD5/nrfYlunXsBzOeEXFZexAofncbgg7IUloQQeSdGtRmKM8EF6irmHaRtis
         KLWppLMW/7QbOqUQenshjXqzZbPo+6U2IxF5xLrZuvocAgXTWdR1mTyZD8cATwSTajhF
         /RG8P7cxysDR65Og2xGz7ijbDYpvWdvT9ahTVsxI6jFMR+l2fyX1IRLQaOpXhEBMPrBc
         +mWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773789790; x=1774394590;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XN/qOC5CJ/bhMlRJKWhmjAU6IJC68YMTmoD5LWl17yI=;
        b=DKayWVdTD5uKupkaycZEgc9TcKFONHfgfu1JXcnGmv9cFqG/2rv3YElt0a76J7bMUe
         eOMrqtdFiJm0Q9XMBd2YhI0sNUrPYQE4xRQn/mOWpDP3n3QrIMmqOg3jEWlFNzkzUQr4
         1YaE+pbCPRoO1YDjz+p3fy1e6EvvooZONCmHjWp9IK4BIZYve/K+PYj+usx1QKUDNREo
         Ler0rmOn6/08KG0XJCUT8uEptse76J3DQ1jWczMD6+/LqOf083k6DNYwlglvOyiaqBQx
         2+4oQ/A9P0goKFUfPD+7ED4wni2pqE/4Cbrsa0FQ48fSbKoIQMYn1uBcP7VHrDEpoDXZ
         zYig==
X-Forwarded-Encrypted: i=1; AJvYcCWu2oIp5XqIOhYULd7h2CJtv/SF1PcMj3wz1GvUotXdGPuqtFf7ijCvy4pNAihgnGvgQsKYng==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxhza6X6RI7PWgrHjCnO7Yo2VKIRAiMOlxuBkGHKGCkJl9O3kuG
	x1CH32va5uaEZRCE/qxOkwBobT3dF/NjwUbDe7+JwFmOtRxvC7WC9s9O
X-Gm-Gg: ATEYQzz/Myl/N/Sc8gFaKYyHI0k9HT0YGEvhT382xU2yGe722jSbkLb/mvRpSxJPqgX
	ng/+jCDTGLkCrAKTDzLHLAVuWJGHygFjrCtasZG1iQ4Jk/1YOCfWma0JU0YBhNRI33l8j4Y5qWn
	EI0P8cwO+TiqaTTpGkMVSsdyXDFs4nAwpNSDURzdQAJiAciGZl7ckxjT6qRgQFaELc+ZiDJC5Bl
	Yvgz/Z3rjXu3/CsT5VUHjFeLg7BREOyU/UnZX4USk8wM8o3pDs2M3ndZWcdRMF37R3iKbCv25hc
	csQ+Cxu7L34L5NugIHRt+2A/xNkeZkF6+MJSJpsLxGtAuLwRHt0qUgtRR4o1CpdAla/m6X1oTT7
	UneElHmsg3zmGBFDsNBsqLHyiZluOTbXF9l7MvyrkGz/da/+1sz8zq292K2ZJU3VTIaVznnm/BS
	gk2xF3/Dy/SJt96P5QdrHYxuUjubXrohk5T+9C1jaJtHiGhM8wSwRm8phXVtj0s5HJspJ2n2QrB
	9ujoKlKmAVXlCg=
X-Received: by 2002:a05:7301:2e89:b0:2be:2f58:2ef5 with SMTP id 5a478bee46e88-2c0e4f5b103mr758591eec.1.1773789790054;
        Tue, 17 Mar 2026 16:23:10 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e55cd9cfsm1356744eec.26.2026.03.17.16.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 16:23:09 -0700 (PDT)
Date: Tue, 17 Mar 2026 16:23:07 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Michal Clapinski <mclapinski@google.com>
Cc: Evangelos Petrongonas <epetron@amazon.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v7 2/3] kho: fix deferred init of kho scratch
Message-ID: <abniW3D8wbGQcB5T@fedora>
References: <20260317141534.815634-1-mclapinski@google.com>
 <20260317141534.815634-3-mclapinski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260317141534.815634-3-mclapinski@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_162311_346312_C5B9B4D2 
X-CRM114-Status: GOOD (  18.52  )
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

On Tue, Mar 17, 2026 at 03:15:33PM +0100, Michal Clapinski wrote:
> Currently, if DEFERRED is enabled, kho_release_scratch will initialize
> the struct pages and set migratetype of kho scratch. Unless the whole
> scratch fit below first_deferred_pfn, some of that will be overwritten
> either by deferred_init_pages or memmap_init_reserved_pages.
> 
> To fix it, I modified kho_release_scratch to only set the migratetype
> on already initialized pages. Then, modified init_pageblock_migratetype
> to set the migratetype to CMA if the page is located inside scratch.
> 
> Signed-off-by: Michal Clapinski <mclapinski@google.com>
> ---
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index ee81f5c67c18..5ca078dde61d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -55,6 +55,7 @@
>  #include <linux/cacheinfo.h>
>  #include <linux/pgalloc_tag.h>
>  #include <linux/mmzone_lock.h>
> +#include <linux/kexec_handover.h>
>  #include <asm/div64.h>
>  #include "internal.h"
>  #include "shuffle.h"
> @@ -549,6 +550,12 @@ void __meminit init_pageblock_migratetype(struct page *page,
>  		     migratetype < MIGRATE_PCPTYPES))
>  		migratetype = MIGRATE_UNMOVABLE;
>  
> +	/*
> +	 * Mark KHO scratch as CMA so no unmovable allocations are made there.
> +	 */
> +	if (unlikely(kho_scratch_overlap(page_to_phys(page), PAGE_SIZE)))
> +		migratetype = MIGRATE_CMA;
> +
>  	flags = migratetype;
>  
>  #ifdef CONFIG_MEMORY_ISOLATION

I've just tried to build the current mm-new tree. I'm getting this
error:

 error: ‘MIGRATE_CMA’ undeclared (first use in this function); did you mean ‘MIGRATE_SYNC’?
  557 |                 migratetype = MIGRATE_CMA;
      |                               ^~~~~~~~~~~
      |                               MIGRATE_SYNC

From what I can tell, MIGRATE_CMA is only defined if CONFIG_CMA is
enabled (for x86 defconfig its disabled).

