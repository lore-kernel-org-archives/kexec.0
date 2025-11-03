Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCE3CCF9F8
	for <kexec@archiver.kernel.org>; Mon,  3 Nov 2025 16:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OKtfTX6p+YHeic6n4Wv3jNDv9OpjNDhge2Ceh/S4hIY=; b=cPbBeRGN6EC8SRl661JT8KMWE9
	V6r1LebCiWiCnfO8jZEZovK89KBQNieHVZVNNm6Ko3ZwxJtDAa8mMoXzSo+RjrptbA4rPgL6kYN3o
	WcY+klDhZRVTB+8GBWs9tedG8V+ZitpdrdOf7hCASPITqYVA/16rQLPQrBKz1yWUSTo3B2BcIUaT8
	XZV26KhVbzSvt5sL6uaOejx0MhtTJ8bFRcOPp8aeFKsJc8z2/HdCd3BNe6cWKDNqRk0uE/MAJqdfJ
	AMijoHPCbJrp3ctoGkWydvw5L/3JdQlolCCj03CVTOIS5CstZduLkdGST3xMrqG5S9ZUq5QgluQ08
	e9dEsceQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFxs5-0000000AMo8-1WXE;
	Mon, 03 Nov 2025 16:57:33 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFxs4-0000000AMnc-0WkA
	for kexec@lists.infradead.org;
	Mon, 03 Nov 2025 16:57:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 86A4460139;
	Mon,  3 Nov 2025 16:57:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564D7C4CEE7;
	Mon,  3 Nov 2025 16:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762189051;
	bh=UXbyL0c4gAKXyaDUG6J01Z7qz3xy2A7gPJAePIXHk4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b5oNCpeXpk2uZyGZqBHEsvT/hu0avc8wvFDKDf/GNIctuNY4LZzu7oKF3BcrtP152
	 krdL00sj+nAvuQJ7luVVgQZBHtZLG+ESOvSYRXYtd9okIy9M1kuE4DJ8+BtrrOcay0
	 hxJtbn+ZQSFnv5Dk4evrInz5BKWwCvw9qLMCNPM5TgR9adqRa0ua75zNlC15uhXUyq
	 arfewDLc70AnhMi5JT+O/G3ShaUUNkej4oHy9sxxYAunMtwrAlnlKxfiC9kME8LDXe
	 wpfQqZFeNAEnF+mJNTKDYKMtOdbaWXl14nGiYny7DOAMOLe9+1892E8GGaFEn7AtvV
	 C8V3fDWrEBf9g==
Date: Mon, 3 Nov 2025 18:57:24 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kho: fix out-of-bounds access of vmalloc chunk
Message-ID: <aQje9CFnTymbkUlM@kernel.org>
References: <20251103110159.8399-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103110159.8399-1-pratyush@kernel.org>
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

On Mon, Nov 03, 2025 at 12:01:57PM +0100, Pratyush Yadav wrote:
> The list of pages in a vmalloc chunk is NULL-terminated. So when looping
> through the pages in a vmalloc chunk, both kho_restore_vmalloc() and
> kho_vmalloc_unpreserve_chunk() rightly make sure to stop when
> encountering a NULL page. But when the chunk is full, the loops do not
> stop and go past the bounds of chunk->phys, resulting in out-of-bounds
> memory access, and possibly the restoration or unpreservation of an
> invalid page.
> 
> Fix this by making sure the processing of chunk stops at the end of the
> array.
> 
> Fixes: a667300bd53f2 ("kho: add support for preserving vmalloc allocations")
> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
> 
> Notes:
>     Commit 89a3ecca49ee8 ("kho: make sure page being restored is actually
>     from KHO") was quite helpful in catching this since kho_restore_page()
>     errored out due to missing magic number, instead of "restoring" a random
>     page and causing errors at other random places.
> 
>  kernel/kexec_handover.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> index 76f0940fb4856..cc5aaa738bc50 100644
> --- a/kernel/kexec_handover.c
> +++ b/kernel/kexec_handover.c
> @@ -869,7 +869,7 @@ static void kho_vmalloc_unpreserve_chunk(struct kho_vmalloc_chunk *chunk)
>  
>  	__kho_unpreserve(track, pfn, pfn + 1);
>  
> -	for (int i = 0; chunk->phys[i]; i++) {
> +	for (int i = 0; i < ARRAY_SIZE(chunk->phys) && chunk->phys[i]; i++) {
>  		pfn = PHYS_PFN(chunk->phys[i]);
>  		__kho_unpreserve(track, pfn, pfn + 1);
>  	}
> @@ -992,7 +992,7 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
>  	while (chunk) {
>  		struct page *page;
>  
> -		for (int i = 0; chunk->phys[i]; i++) {
> +		for (int i = 0; i < ARRAY_SIZE(chunk->phys) && chunk->phys[i]; i++) {
>  			phys_addr_t phys = chunk->phys[i];
>  
>  			if (idx + contig_pages > total_pages)
> 
> base-commit: dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
> -- 
> 2.47.3
> 

-- 
Sincerely yours,
Mike.

