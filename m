Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CECDCAC592
	for <kexec@archiver.kernel.org>; Mon, 15 Sep 2025 22:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xJwMjB5ziP+zRxfq3AmWgiRqbJzPzaQyS9lUVq3ReSs=; b=jVI/gnHrwW+RS2X1gf5DVV0Bqc
	UT1P9MuTPedckj6fd77IlPQz+atmtAfHm+I7VX4ihpxV3oslWc7nFj+w4KUz305oLuF0Khjthp2IA
	DsBIirFmkmXCQr3F9yLdpG8ZZOypDwlzowQ06LylcKXTdidOfNYKuppF7fwdDM35OOzVs8T4wiJq8
	ZuvGe8Tk/FmSCJ+2HPS1bhqlOCOPYSyXUtTi7+tZF8VeAYj233s4imWL942nMebnh6xSeu/Hy+Y6h
	ODc5ncu9cL94+MhBq5xYtGjXWq7Rr49zuxgS1eYv2PabRh6zZnAcVJYp5CLUKX/6PzB3bnE1IQILo
	36ZXkYEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyHT9-00000005lpe-3Zw8;
	Mon, 15 Sep 2025 22:14:43 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyHT8-00000005loX-1bDb
	for kexec@lists.infradead.org;
	Mon, 15 Sep 2025 22:14:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C96FC600AC;
	Mon, 15 Sep 2025 22:14:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A2FC4CEF9;
	Mon, 15 Sep 2025 22:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757974481;
	bh=42PF0UhqIVstyAZvj9Oxhvu2NgizRC3FkzlZTmN8t2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YB4kjVRMGqWWTf5wx+xKc4Av/dO5yqwEAym1wFCSV/5nWHnbNo5Lld+08DaWnhr7x
	 9V3+gQGc8/EdEMv/AXCrXZMaL6yampUroqB8aArDG751VC+NlbtWXOKP2qaWOMKdpr
	 B5/Wi7CWNBdNHM6JvaKQ7lEPQ9wXwvFJJQNTzQLUhwHovt8/LAajy0/kqRGbP8Mc4a
	 RSqs8xBQwTTXpNMB1qMqjuTPXJxY7UmzvcoEOWizaWFp2/kRf8eL0PEC+fd0vHKzQ/
	 mzNgMyB7qF6OJeezzh65LYAxBFVzQbUwWAl78Pc9ls9Iui6l2lAd0wrOKu0m63EhQ6
	 4UXoVFJZKOu2Q==
Date: Mon, 15 Sep 2025 15:14:36 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] kexec: Remove unused code in
 kimage_load_cma_segment()
Message-ID: <20250915221436.GA925462@ax162>
References: <20250915155543.2912469-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915155543.2912469-1-andriy.shevchenko@linux.intel.com>
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

Hi Andy,

On Mon, Sep 15, 2025 at 05:55:43PM +0200, Andy Shevchenko wrote:
> clang is not happy about set but unused variable:
> 
> kernel/kexec_core.c:745:16: error: variable 'maddr' set but not used [-Werror,-Wunused-but-set-variable]
>   745 |         unsigned long maddr;
>       |                       ^
> 1 error generated.
> 
> Fix the compilation breakage (`make W=1` build) by removing unused variable.
> 
> Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")

I don't think this fixes tag is right. maddr definitely looks used in
that diff. I think it is a follow up simplification that introduces
this.

Fixes: f4fecb50d6e1 ("kexec_core: remove superfluous page offset handling in segment loading")

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Otherwise, this patch looks correct to me and GCC 16 will warn on this
as well.

  kernel/kexec_core.c: In function 'kimage_load_cma_segment':
  kernel/kexec_core.c:745:23: error: variable 'maddr' set but not used [-Werror=unused-but-set-variable=]
    745 |         unsigned long maddr;
        |                       ^~~~~

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

>  kernel/kexec_core.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 5357ed39e9d1..32722926bc7e 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -742,7 +742,6 @@ static int kimage_load_cma_segment(struct kimage *image, int idx)
>  	struct kexec_segment *segment = &image->segment[idx];
>  	struct page *cma = image->segment_cma[idx];
>  	char *ptr = page_address(cma);
> -	unsigned long maddr;
>  	size_t ubytes, mbytes;
>  	int result = 0;
>  	unsigned char __user *buf = NULL;
> @@ -754,7 +753,6 @@ static int kimage_load_cma_segment(struct kimage *image, int idx)
>  		buf = segment->buf;
>  	ubytes = segment->bufsz;
>  	mbytes = segment->memsz;
> -	maddr = segment->mem;
>  
>  	/* Then copy from source buffer to the CMA one */
>  	while (mbytes) {
> @@ -782,7 +780,6 @@ static int kimage_load_cma_segment(struct kimage *image, int idx)
>  		}
>  
>  		ptr    += mchunk;
> -		maddr  += mchunk;
>  		mbytes -= mchunk;
>  
>  		cond_resched();
> -- 
> 2.50.1
> 

