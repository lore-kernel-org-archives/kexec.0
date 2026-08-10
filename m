Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B737C5B56A
	for <kexec@archiver.kernel.org>; Mon, 10 Aug 2026 17:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4yvXfUeulRUEmTF42XYsxj9IZ6IxSMv/Y/T9OemFD68=; b=PLc3QHXgCdLhylXqztnsLsJU4M
	GmI/n6HsU+8/2XtyCdB975YatVHIZys7+z11GVCJj3iE2C3I1i4BRYC4KYRHBjv3MwH8RPu7q13R/
	JXBVssAPmZKcze0epx3JABAjY5Y0gauEMYeStP8a4uRZPgdJP5NRY0de6sTttNSV/AkIBjwmNJeFI
	eAbsNhkN/KEPChTkASxUU9eiproYsyAgOXjOvl7sdKMP5VaOv5rw29HyWJUV6u5fmpY+zc6ahBWEf
	nuaLspStbqd+oX1QTHwqiCyHK5YSFJ1jpohD1CKplz60shyKfLbh2V7YzOODHtijRKCT54t3UU7Yp
	2ozDZnGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtUEy-0000000CZml-4B6N;
	Mon, 10 Aug 2026 17:56:48 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtUEx-0000000CZmX-1u62
	for kexec@lists.infradead.org;
	Mon, 10 Aug 2026 17:56:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A5428600C8;
	Mon, 10 Aug 2026 17:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35041F000E9;
	Mon, 10 Aug 2026 17:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786384606;
	bh=4yvXfUeulRUEmTF42XYsxj9IZ6IxSMv/Y/T9OemFD68=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=GfNCPqjIISgcgG/+twUpZHtMXxXS7jfzB7cxJs3nCp4ahhZswUZSnbJYaWecCiRWf
	 ff93HKBcIFo+iTMiUzBEUUAYwdTtuqlFYyKE8t1ifUbythVHJYTrVDD1G0/Hoo35U9
	 yXC3QwRUW7L4YIiIPKdqm+/GuUdjLwR/dSus1oEGbZj6O8pnezJpDdLwwoh7J36Bkf
	 1tajT0z240gUe9ZS5EjmxjOOLFyroqlsI4kJLpfnjAQX0K9JRKrTHmXwTXypL7ZoZ7
	 nmAy9+KMxo6xBaG+0zqEGOdzcfaS7AzyW2Sl1LEqEpV5cvEN8CaF1wCUVIVqL6qzQx
	 qB6YbUzxFHSLg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,  Mike Rapoport
 <rppt@kernel.org>,  Pratyush Yadav <pratyush@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  kexec@lists.infradead.org (open list:LIVE
 UPDATE),  linux-kernel@vger.kernel.org (open list:LIVE UPDATE),
  linux-mm@kvack.org (open list:MEMORY MANAGEMENT),  Giorgi Tchankvetadze
 <giorgi@tchankvetadze.com>
Subject: Re: [PATCH] mm/memfd_luo: use real folio index in retrieve error logs
In-Reply-To: <20260806100543.138902-3-giorgitchankvetadze1997@gmail.com>
	(Giorgi Tchankvetadze's message of "Thu, 6 Aug 2026 14:05:39 +0400")
References: <20260806100543.138902-3-giorgitchankvetadze1997@gmail.com>
Date: Mon, 10 Aug 2026 19:56:43 +0200
Message-ID: <2vxz5x1h6eqs.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Thu, Aug 06 2026, Giorgi Tchankvetadze wrote:

> From: Giorgi Tchankvetadze <giorgi@tchankvetadze.com>
>
> memfd_luo_retrieve_folios() logs "folio index %ld" on its error paths
> but passes the loop counter 'i' instead of the folio's actual index
> held in the local 'index' variable (pfolio->index).
>
> Pass 'index' to the three pr_err() calls so the logged index matches
> the folio that actually failed. Since the saved index is a u64, use %llu with an
> unsigned long long cast when printing it.
>
> Fixes: b3749f174d68 ("mm: memfd_luo: allow preserving memfd")
> Signed-off-by: Giorgi Tchankvetadze <giorgi@tchankvetadze.com>
> ---
>  mm/memfd_luo.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
> index 59de210bee5f..652dd21e6ef0 100644
> --- a/mm/memfd_luo.c
> +++ b/mm/memfd_luo.c
> @@ -451,16 +451,16 @@ static int memfd_luo_retrieve_folios(struct file *file,
>  
>  		err = mem_cgroup_charge(folio, NULL, mapping_gfp_mask(mapping));
>  		if (err) {
> -			pr_err("shmem: failed to charge folio index %ld: %d\n",
> -			       i, err);
> +			pr_err("shmem: failed to charge folio index %llu: %d\n",
> +			       (unsigned long long)index, err);

Why the cast here? u64 is always printed by %llu. See
Documentation/core-api/printk-formats.rst.

>  			goto unlock_folio;
>  		}
>  
>  		err = shmem_add_to_page_cache(folio, mapping, index, NULL,
>  					      mapping_gfp_mask(mapping));
>  		if (err) {
> -			pr_err("shmem: failed to add to page cache folio index %ld: %d\n",
> -			       i, err);
> +			pr_err("shmem: failed to add to page cache folio index %llu: %d\n",
> +			       (unsigned long long)index, err);
>  			goto unlock_folio;
>  		}
>  
> @@ -472,8 +472,8 @@ static int memfd_luo_retrieve_folios(struct file *file,
>  		npages = folio_nr_pages(folio);
>  		err = shmem_inode_acct_blocks(inode, npages);
>  		if (err) {
> -			pr_err("shmem: failed to account folio index %ld(%ld pages): %d\n",
> -			       i, npages, err);
> +			pr_err("shmem: failed to account folio index %llu(%ld pages): %d\n",
> +			       (unsigned long long)index, npages, err);
>  			goto remove_from_cache;
>  		}

-- 
Regards,
Pratyush Yadav

