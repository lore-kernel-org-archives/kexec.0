Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C0DEB1048
	for <kexec@archiver.kernel.org>; Tue, 10 Mar 2026 10:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eAiiRheaH2AeHI/DwDRcz8L/YNZeEcKvchS3XukuuHM=; b=0C7IQFtAUrdFakFJpB7Gp6S9iS
	XdO+xNMpVu4DZwNpdmk/xulbinry0JEmpaTu8FdOUW66YzA5yVcoCBvMsjp5ttHWoBv5RYn62rVem
	o4dFjaP+D9mOMUYd2QRbatjpda1RRPgTRqSb6PYLbNfJMcTzk4ntwKbB1np4eAtgsQwtHc73JZRUQ
	Fsks6TrzbQyGLLbBDaD0tXKGih5v2wKfQCny0XOOEA+p9xgTMoj+qyDBUQRBg5i/LEE5TyJCv4I8B
	FNMw2eWcUttOc8Iho7OLLIwGfKpgP4JMMLcFdfTDKY43amC8pXRw1S8nAXe4/8BhFYciqyg0qhxll
	i63b3j2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzuPM-00000009Cy9-1js2;
	Tue, 10 Mar 2026 10:33:48 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzuPJ-00000009CxI-1fQZ
	for kexec@lists.infradead.org;
	Tue, 10 Mar 2026 10:33:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0F041443FA;
	Tue, 10 Mar 2026 10:33:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C35C19423;
	Tue, 10 Mar 2026 10:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773138824;
	bh=ECE4xmh6kRZf/kIT7/6rB3iS7so/etotWxeKzoWbm+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PoBiWwP/Rm5yU49N/sDms4v+xmjkjdzd1To0opImrEbV59JC3YYemr/v4RJrp3yjP
	 LvvfPpnP8JK+d7w3Qr6jcO+BUL2mv4wTohbNyO07suKvUOJsdxTvjicOstulgBda+b
	 pB4ugJ/JE5RkftJfWPF9X2YMh0W/4atpTARAW/LTXbXjgua/kIMcTc5P/zQcMZrJ3k
	 wbCT2aTHtwB+kOGcsDhmLo+Q25U450SutGLnVZEKekCPRpP8hmtgr1QAPTMdzCm5gO
	 2c3y+56HcVJNEWpv5peHiGeIRWJVj+7NLfQlO5mOH9dTJuy84IBrizkcRc0fZM/cKs
	 uqnD7h5Spsaug==
Date: Tue, 10 Mar 2026 12:33:38 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] kho: drop restriction on maximum page order
Message-ID: <aa_zglmh3AU2_RA0@kernel.org>
References: <20260309123410.382308-1-pratyush@kernel.org>
 <20260309123410.382308-2-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309123410.382308-2-pratyush@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260310_033345_457227_2EA5F8EB 
X-CRM114-Status: GOOD (  22.72  )
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

On Mon, Mar 09, 2026 at 12:34:07PM +0000, Pratyush Yadav wrote:
> KHO currently restricts the maximum order of a restored page to the
> maximum order supported by the buddy allocator. While this works fine
> for much of the data passed across kexec, it is possible to have pages
> larger than MAX_PAGE_ORDER.
> 
> For one, it is possible to get a larger order when using
> kho_preserve_pages() if the number of pages is large enough, since it
> tries to combine multiple aligned 0-order preservations into one higher
> order preservation.
> 
> For another, upcoming support for hugepages can have gigantic hugepages
> being preserved over KHO.
> 
> There is no real reason for this limit. The KHO preservation machinery
> can handle any page order. Remove this artificial restriction on max
> page order.
> 
> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>

One SOB should be enough ;-)

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
> 
> Notes:
>     This patch was first sent with this RFC series [0]. I am sending it
>     separately since it is an independent patch that is useful even without
>     hugepage preservation. No changes since the RFC.
>     
>     [0] https://lore.kernel.org/linux-mm/20251206230222.853493-1-pratyush@kernel.org/T/#u
> 
>  kernel/liveupdate/kexec_handover.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index bc9bd18294ee..1038e41ff9f9 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -253,7 +253,7 @@ static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
>  	 * check also implicitly makes sure phys is order-aligned since for
>  	 * non-order-aligned phys addresses, magic will never be set.
>  	 */
> -	if (WARN_ON_ONCE(info.magic != KHO_PAGE_MAGIC || info.order > MAX_PAGE_ORDER))
> +	if (WARN_ON_ONCE(info.magic != KHO_PAGE_MAGIC))
>  		return NULL;
>  	nr_pages = (1 << info.order);
>  
> -- 
> 2.53.0.473.g4a7958ca14-goog
> 

-- 
Sincerely yours,
Mike.

