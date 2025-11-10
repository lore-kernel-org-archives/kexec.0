Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC6DCCFA13
	for <kexec@archiver.kernel.org>; Mon, 10 Nov 2025 18:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hifu5+XTv/PZagj/bNKiI2d8M6e9yZuwOXNQyt1l9bg=; b=ABbUYkK5Y2t+aEf6i0wS24ueEw
	Tw5jzET3dNWEN+7QdMm826laHy7hNIzUvS+TXOMpf7/rqRMh7v36addlBqUlgh4WZuHhrfxjJmILs
	gvAXDeOqfpG44AcxcWSg8OxotRRRUXia7Q7tIm10zjDRuFQWWAsptsZLVpxs+Wpmj2XRXanU48IFz
	nvmV4BYw7hrabPwP4Rg95GvobQtRZdDIFTmK1HelnCNrqZsJMZ7TpiNE13IRnzw+F15MuvVquXbX/
	7W7WpAhBulMpcyuF4UJHiEbYzP0+XMDUaaEYtlL5Fy5Hr9F0SI61dCLwZN4a2/anFn+czUFH6cnCv
	rOucaIDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIWjC-00000005yvo-0BQg;
	Mon, 10 Nov 2025 18:34:58 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIWjA-00000005yvh-2ADH
	for kexec@lists.infradead.org;
	Mon, 10 Nov 2025 18:34:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A282F6013F;
	Mon, 10 Nov 2025 18:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6488C116D0;
	Mon, 10 Nov 2025 18:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762799695;
	bh=FQjzy3ZKmgutMS5buIYRozIFCGNCd/pVylb5uaoZKQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CihK0FPjPD1VMDZ2iA5q9fLWUD+ajedl3qWXAK9vmc92x1+nvCH1jtiC04/W7BU1l
	 6ZRyz9Ve4iGH/jFMw08q3FJqmnZNhXFgpGkViU9Em2lvtFXqXf0lif6zzO9zpUEdvA
	 Tt6obIDeIlS7E8Ks32yfM3q4BaKp/e0PE2kArqXiTpEDM4laHWCyTq4MuH3AIq7FUd
	 pEtPkOFl57dB5ITtBYjz13stwHOhBr3cf7nRFw7w4VNaUQ3pBhPNoTqIEGV6kOWQHD
	 a81ehbRobuFJuPdZK1ZwuRCa4+w/6xZ4B1vPdsZrUWHBH/jde9mXFtcC3HEvy9zU0M
	 JwTPCO/DWYUlA==
Date: Mon, 10 Nov 2025 20:34:48 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, graf@amazon.com, pratyush@kernel.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] liveupdate: kho: Enable KHO by default
Message-ID: <aRIwSEF8Y0I6q8Cy@kernel.org>
References: <20251110180715.602807-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110180715.602807-1-pasha.tatashin@soleen.com>
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

On Mon, Nov 10, 2025 at 01:07:15PM -0500, Pasha Tatashin wrote:
>
> Subject: [PATCH] liveupdate: kho: Enable KHO by default

No need to put a directory (liveupdate) prefix here. "kho: " is enough.

With that fixed

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> Upcoming LUO requires KHO for its operations, the requirement to place
> both KHO=on and liveupdate=on becomes redundant. Set KHO to be enabled
> by default.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  kernel/liveupdate/kexec_handover.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index b54ca665e005..568cd9fe9aca 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -51,7 +51,7 @@ union kho_page_info {
>  
>  static_assert(sizeof(union kho_page_info) == sizeof(((struct page *)0)->private));
>  
> -static bool kho_enable __ro_after_init;
> +static bool kho_enable __ro_after_init = true;
>  
>  bool kho_is_enabled(void)
>  {
> 
> base-commit: ab40c92c74c6b0c611c89516794502b3a3173966
> -- 
> 2.51.2.1041.gc1ab5b90ca-goog
> 

-- 
Sincerely yours,
Mike.

