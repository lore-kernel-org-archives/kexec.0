Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3DDFD5E136
	for <kexec@archiver.kernel.org>; Tue, 16 Dec 2025 11:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EO58j438GWnjkv3vbMcJ669DRDtPdBQzG5P7oj/6KS8=; b=Lu31x5oeY0pGQfJEJ79pzl6HdQ
	k9LmPEDwbwKYTgsIyECMVmpTCR/gRe+8bTtTsxWjB9s5eUOVGUU1XOr+q1HYcbje8JH9tCd9KRYY7
	oFk7QajSG0/U7LzF0qCrGuTOKqSqkFzd962JSYcSAQx9Nik/xwDPAxSwA7RXKAQxHd1gW+lbsSvqU
	8qGUfL0KmguPDqr70DUQjOKypd4Upr9/bVmP/rfk4oQlZCa2teeMlopxhGTlwQN1ifoONEBQjvQRT
	jiXgTP8QKpotVfrNwFEgSn8Kpz13OWfFTf3xoNqirFi1pBVGhyqtlF9GpP2FZ6O+/JaUtlWjZVWp2
	yjCtLtsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVTgH-000000059hX-3rmn;
	Tue, 16 Dec 2025 11:57:29 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVTgG-000000059hK-0od3
	for kexec@lists.infradead.org;
	Tue, 16 Dec 2025 11:57:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 202A0602C8;
	Tue, 16 Dec 2025 11:57:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6FCAC4CEF1;
	Tue, 16 Dec 2025 11:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765886246;
	bh=7ZFdnmw31SZNpKwCbTn3VwLXjfFQMOPztHlF9Mj4Qrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=levK1FBGpysdmLQOMdTo0qNcTtB0s7RX0y4zTPIEcUboIVYrPZOuGFhUa6bo1W/fU
	 Pkek4dlakV/QjzQcJYVYOoV/eRv457Rq1NkDVdejTSJwEFwt+UxkCc1PWpnmJO80LY
	 OL/lhVJqjN+0W60eOuJJgkdiDtXm+r/RhggI5M/bwpZsNd03GHw3XpSEsQwOWig4A3
	 gBVT33D3IxuFbVGr9FbnmTvRhBd1ELZKiTNHPGscDsPTuppGV24iZQyq64K8sk0rYj
	 SIdtnuzpZ8U/M8KggrJqRCjAmPMIXZl7O824bvxFkO6Vj/GpuSPgGhJSrKDsxcmuzD
	 JbumRAVzfWYHg==
Date: Tue, 16 Dec 2025 13:57:19 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Evangelos Petrongonas <epetron@amazon.de>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Miu <jasonmiu@google.com>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	nh-open-source@amazon.com
Subject: Re: [PATCH] kho: add support for deferred struct page init
Message-ID: <aUFJH9xzJXYOt_X8@kernel.org>
References: <20251216084913.86342-1-epetron@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216084913.86342-1-epetron@amazon.de>
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

Hi Evangelos,

On Tue, Dec 16, 2025 at 08:49:12AM +0000, Evangelos Petrongonas wrote:
> When `CONFIG_DEFERRED_STRUCT_PAGE_INIT` is enabled, struct page

No need for markup formatting in the changelog.

> initialization is deferred to parallel kthreads that run later
> in the boot process.
> 
> During KHO restoration, `deserialize_bitmap()` writes metadata for
> each preserved memory region. However, if the struct page has not been
> initialized, this write targets uninitialized memory, potentially
> leading to errors like:
> ```
> BUG: unable to handle page fault for address: ...
> ```
> 
> Fix this by introducing `kho_get_preserved_page()`,  which ensures
> all struct pages in a preserved region are initialized by calling
> `init_deferred_page()` which is a no-op when deferred init is disabled
> or when the struct page is already initialized.
> 
> Fixes: 8b66ed2c3f42 ("kho: mm: don't allow deferred struct page with KHO")
> Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
> ---

...

> +static struct page *__init kho_get_preserved_page(phys_addr_t phys,
> +						  unsigned int order)
> +{
> +	unsigned long pfn = PHYS_PFN(phys);
> +	int nid = early_pfn_to_nid(pfn);
> +
> +	for (int i = 0; i < (1 << order); i++)
> +		init_deferred_page(pfn + i, nid);

This will skip pages below node->first_deferred_pfn, we need to use
__init_page_from_nid() here.

> +
> +	return pfn_to_page(pfn);
> +}
> +
>  static void __init deserialize_bitmap(unsigned int order,
>  				      struct khoser_mem_bitmap_ptr *elm)
>  {
> @@ -449,7 +466,7 @@ static void __init deserialize_bitmap(unsigned int order,
>  		int sz = 1 << (order + PAGE_SHIFT);
>  		phys_addr_t phys =
>  			elm->phys_start + (bit << (order + PAGE_SHIFT));
> -		struct page *page = phys_to_page(phys);
> +		struct page *page = kho_get_preserved_page(phys, order);

I think it's better to initialize deferred struct pages later in
kho_restore_page. deserialize_bitmap() runs before SMP and it already does
heavy lifting of memblock_reserve()s. Delaying struct page initialization
until restore makes it at least run in parallel with other initialization
tasks.

I started to work on this just before plumbers and I have something
untested here:

https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=kho/deferred-page/v0.1

>  		union kho_page_info info;
>  
>  		memblock_reserve(phys, sz);
> -- 
> 2.43.0
> 
> 
> 
> 
> Amazon Web Services Development Center Germany GmbH
> Tamara-Danz-Str. 13
> 10243 Berlin
> Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
> Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
> Sitz: Berlin
> Ust-ID: DE 365 538 597
> 

-- 
Sincerely yours,
Mike.

