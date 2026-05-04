Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10800FF885A
	for <kexec@archiver.kernel.org>; Mon,  4 May 2026 13:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dyA/RJ4WV0ENXukLLJpS9okzJTBD0evXoIqu3rh0Shc=; b=1BWl7niaMJsZO6UB3ZmgXUAA/1
	SIhzE+oVD1OentTkXelWuNEbu0rSnI3Yv1vb5uUsMTmhgWN92g3REHbiZ9g0+HoLsh5exaZpX8gdh
	oEbj4vmmVwE+XCqdC9TPou1OapcsOpcR5zy2s3aHaH0UKoB5gvOTVD5bu3HbkOu1DGV/tF5SPw43i
	c213VnkdfbU9CQSIe0C565xUFPM0AZv5X1DjzpFLW+FoWm1c3+pNZHqqmEAa8erU0HhFHE3UnN873
	1pTwOGK9P1M/Dm+XL1ndX+NjxScrH+kza1Xzxg9Oi6tmkR8fZf9imJHn/B1jJsLUO/8UftQhwh2aT
	D6fOHJhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJtcf-0000000DLQO-2B5c;
	Mon, 04 May 2026 13:46:09 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJtcd-0000000DLQ6-2DaH
	for kexec@lists.infradead.org;
	Mon, 04 May 2026 13:46:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id EFF4960018;
	Mon,  4 May 2026 13:46:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F696C2BCB8;
	Mon,  4 May 2026 13:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777902366;
	bh=A2Kpz/bYRNMo3xwXI5Xybf+gUVzqTmb83C93LElGNyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UonJb0B1TRkrcXg6tizQ7VvGa/iQ5fa0HgkmFBizZEuYlV7Si6ldbqQSSPxuwVLgh
	 aXrT1fK9D1jC5Hui30t2I3Plnic1NIFcqpoHhRZcgZiNyeKoHD7doe0YOssaac/PZD
	 zXKd3gadcV3bhiCGXofh5LL8+tu+LqKZkhS2WTxwR+eAw6ySY8hJ2DKOs6Gni++9I7
	 Vb2SoKqV+Bwrp/2zPw9HQI/pI0pGrTXQEO6KaYov/0S8UvZMddi8fXQwp0RDkSFPC5
	 WhoKiQMSJ3rZGGbDiffZWQYC9u+YzUBEiRNT8TsKdias98u5QvSUhImK7PRydL6Fc4
	 5OoSxDmoiCVNg==
Date: Mon, 4 May 2026 15:46:01 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Michal Clapinski <mclapinski@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memblock tests: define MIGRATE_CMA
Message-ID: <afijGcl4xgpPwqAI@kernel.org>
References: <20260504102742.3833159-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260504102742.3833159-1-pratyush@kernel.org>
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

On Mon, May 04, 2026 at 12:27:40PM +0200, Pratyush Yadav wrote:
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> 
> kho_scratch_migratetype(), defined in include/linux/memblock.h uses enum
> migratetype. This breaks build for memblock tests with:
> 
> ./linux/memblock.h:634:73: error: parameter 2 (‘mt’) has incomplete type
>   634 |                                                        enum migratetype mt)
> 
> Fix it by defining enum migratetype and MIGRATE_CMA. As is the case with
> the other headers in tools/testing/memblock, do not bring in the whole 
> thing, only what is needed.
> 
> Reported-by: Mike Rapoport <rppt@kernel.org>
> Closes: https://lore.kernel.org/linux-mm/afcdDm4aAJvNaQqH@kernel.org/
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> ---
> 
> Notes:
>     I didn't add a Fixes here since the commit hash for the deferred series
>     isn't stable yet. Anyway, I think we should fold this into "kho: fix
>     deferred initialization of scratch areas". So random bisects don't land
>     on a broken test.

I applied it to next as a separate patch for now.
 
>  tools/testing/memblock/linux/mmzone.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/memblock/linux/mmzone.h b/tools/testing/memblock/linux/mmzone.h
> index bb682659a12d..8d934ff5b080 100644
> --- a/tools/testing/memblock/linux/mmzone.h
> +++ b/tools/testing/memblock/linux/mmzone.h
> @@ -35,4 +35,8 @@ typedef struct pglist_data {
>  
>  } pg_data_t;
>  
> +enum migratetype {
> +	MIGRATE_CMA,
> +};
> +
>  #endif
> 
> base-commit: 74d1099bb4edfca3ce6edc61dbacbed96720034c
> -- 
> 2.54.0.545.g6539524ca2-goog
> 

-- 
Sincerely yours,
Mike.

