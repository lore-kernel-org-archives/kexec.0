Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F331C98309
	for <kexec@archiver.kernel.org>; Wed, 23 Sep 2026 09:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rLKRb8Y4+nISCnQaxnX4ctxBf/lcPEd8M1PAoqnsICk=; b=olTwOafXUip+/wUiVXuHWlKCLY
	LJ5I/KY07+Ik4YYwOjHPon61jpEUjzxmMioOeirQExbrXHMZsZ6TZNoQzmfkiE1neBdI+ONtRX/gI
	idWhiA9hVj5SNJ3vIPYHCYExjoKXVPAZQRUtYCRyJBNYQxCCFOeNszvOI70JY76m1xJ9hHjYuOF43
	9uUY5FX2JyZdPcKl4J/0GGWSbMaRt1soQcBDNlyc3DV++ZjQUXwN4ow8hJrb1PRu0XwGdNqkXYGwR
	yuBiqGBu5MJuQvF5wNabQi48cDbKt/Uxu/4sX+vJhK3dyeEc4ZXFnUcwch7S/ad2WLi/sFVApEWAL
	CCRgDDww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9JDi-00000007iq4-0Zm8;
	Wed, 23 Sep 2026 09:24:54 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9JDg-00000007ipg-1lbT
	for kexec@lists.infradead.org;
	Wed, 23 Sep 2026 09:24:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D327242E13;
	Wed, 23 Sep 2026 09:24:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F05E1F000FF;
	Wed, 23 Sep 2026 09:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790155491;
	bh=rLKRb8Y4+nISCnQaxnX4ctxBf/lcPEd8M1PAoqnsICk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lf/HJYmS7UTiPzh9amAhYD2S1aZFVo3LNH5rJLGdyYuILAzd5aGZtD7Z+A88a9tmL
	 hHM6MECEikQkwhUsVWW9OiN+brnRisqJ9m4BU9synUw13IBOU89ZTDelvYTT+MbfCr
	 YHCOAWS4p2NquBk89ID0zbIa8fuQleDE9KqU4RAhKfHJPAKRRbVI/pQHilGVcicP07
	 EW/UgyDgmSBMmHsdSA0fJ+c0tZ/MA4+6VdDCVG/bt0KetNYvzUPxCl4XaT+mMKf/Jf
	 B1arbqfvaLL4O7tkudrCw1fmUe8fqQeMQ5Yhy/QP0Sg91jXC39kkSIBIAWf4RbKs6W
	 EnUBG7zakOYgg==
Date: Wed, 23 Sep 2026 12:24:43 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>, linux-mm@kvack.org,
	linux-s390@vger.kernel.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH] vmcore: convert mmap_vmcore_fault() to use folios
Message-ID: <arOa28u0tRZ-jGYi@kernel.org>
References: <20260915-vmcore-fault-folio-v1-1-a0cb6278670f@columbia.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915-vmcore-fault-folio-v1-1-a0cb6278670f@columbia.edu>
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

(cc s390 folks)

On Tue, Sep 15, 2026 at 07:42:15PM -0400, Tal Zussman wrote:
> Use a folio for the page cache page the s390 fault handler reads the

I tiny bit of context why is this only relevant for s390 would have been
nice :)

> old kernel's memory into. This removes four compound_head() calls and
> one of the last callers of find_or_create_page().
> 
> The vmcore mapping only has order-0 folios, so the logic is unchanged.
> 
> Compile tested for s390.
> 
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
> This is based on the kexec-next branch of the liveupdate tree.
> ---
>  fs/proc/vmcore.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 44d15436439f..2dc3803aa11d 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -474,29 +474,30 @@ static vm_fault_t mmap_vmcore_fault(struct vm_fault *vmf)
>  	pgoff_t index = vmf->pgoff;
>  	struct iov_iter iter;
>  	struct kvec kvec;
> -	struct page *page;
> +	struct folio *folio;
>  	loff_t offset;
>  	int rc;
>  
> -	page = find_or_create_page(mapping, index, GFP_KERNEL);
> -	if (!page)
> +	folio = __filemap_get_folio(mapping, index,
> +			FGP_LOCK | FGP_ACCESSED | FGP_CREAT, GFP_KERNEL);
> +	if (IS_ERR(folio))
>  		return VM_FAULT_OOM;
> -	if (!PageUptodate(page)) {
> -		offset = (loff_t) index << PAGE_SHIFT;
> -		kvec.iov_base = page_address(page);
> -		kvec.iov_len = PAGE_SIZE;
> -		iov_iter_kvec(&iter, ITER_DEST, &kvec, 1, PAGE_SIZE);
> +	if (!folio_test_uptodate(folio)) {
> +		offset = folio_pos(folio);
> +		kvec.iov_base = folio_address(folio);
> +		kvec.iov_len = folio_size(folio);
> +		iov_iter_kvec(&iter, ITER_DEST, &kvec, 1, folio_size(folio));
>  
>  		rc = __read_vmcore(&iter, &offset);
>  		if (rc < 0) {
> -			unlock_page(page);
> -			put_page(page);
> +			folio_unlock(folio);
> +			folio_put(folio);
>  			return vmf_error(rc);
>  		}
> -		SetPageUptodate(page);
> +		folio_mark_uptodate(folio);
>  	}
> -	unlock_page(page);
> -	vmf->page = page;
> +	folio_unlock(folio);
> +	vmf->page = folio_file_page(folio, index);
>  	return 0;
>  #else
>  	return VM_FAULT_SIGBUS;
> 
> ---
> base-commit: 4d17a004cfd5489f88ad0a7a151dea11a533338b
> change-id: 20260907-vmcore-fault-folio-4b382eeff262
> 
> Best regards,
> --  
> Tal Zussman <tz2294@columbia.edu>
> 

-- 
Sincerely yours,
Mike.

