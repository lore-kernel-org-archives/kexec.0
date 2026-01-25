Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C5CE63C9C
	for <kexec@archiver.kernel.org>; Sun, 25 Jan 2026 11:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hDou/1syS+JRCJ5qMonQA+5CbCcw+Ru367ifn0R2jUA=; b=fkd2+so5gCpAlnRj/Ll9gP0BhC
	w2BLyI7ndUv1Z30QIAbh1dnbYUMCVFPmRDBogopOarlhdUb4WrI77Hblc0IKQ04LrQxwjDivJrYs+
	1iIjPqoMguNcjOIHnqErSK/B9FTf4E2BBAc/ar5GSn0AYaN0JILFXwlDtVc4B640ZxlS0uqeUoayn
	GKPu6u1+6J/I1TfOpO6aZi1ZSzMsLi7Z9MzOo2YCfcY104DUUiYyLmaJpEpdUZf7miMGbK5wjIJTB
	us7IzbD7P2Gc/O78cL9youtlUVVBg2hBBpohsyd+VTr7nt68l5DqU5HJF/GdKSWjpZ5dzHzZnQUCU
	5UUo+9YQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vjyf5-0000000B8pu-1whp;
	Sun, 25 Jan 2026 11:52:11 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vjyf3-0000000B8pl-2hiW
	for kexec@lists.infradead.org;
	Sun, 25 Jan 2026 11:52:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A561C60018;
	Sun, 25 Jan 2026 11:52:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6121C4CEF1;
	Sun, 25 Jan 2026 11:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769341928;
	bh=iF5UwdbLx3lobfdhIsiNN5Ktf/ekLJHA9XetyqKlp6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RlinmGtCV5do+fZPL7nAszMQ8paDm3KutZYyue7aB8Ty5G9Kq3P0jh/Bo931S0z6M
	 pAzQQWRdVzR1dpH1Fx377PGCxDPleGB6dYACGOs7o2M2z5TjZrKHyaFR/pRSptAs2x
	 0BCrsz25RPCRvQoZZDnwfBkXN4jvuyuZN7dJEwddNn8a46eQX6TurhH47R9yLqDCR/
	 4qQ/ipykXjpLdk2+SvVorfeYfo0gxv/1YwFKgpnXx435jBPuSH4gxrzXj2MgJNkHUH
	 xtXJs9LQDzsV7iSlqNsqs3gbVIwdSqh/Sqv9Qc1/2bTAgg9FXhrI1NLqAENq1OAgR/
	 p6+5MS3tT1E/A==
Date: Sun, 25 Jan 2026 13:52:01 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] memfd: export memfd_{add,get}_seals()
Message-ID: <aXYD4b46LcwSodjX@kernel.org>
References: <20260123095854.535058-1-pratyush@kernel.org>
 <20260123095854.535058-2-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123095854.535058-2-pratyush@kernel.org>
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

On Fri, Jan 23, 2026 at 10:58:50AM +0100, Pratyush Yadav wrote:
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> 
> Support for preserving file seals will be added to memfd preservation
> using the Live Update Orchestrator (LUO). Export
> memfd_{add,get}_seals)() so memfd_luo can use them to manipulate the
> seals.
> 
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/linux/memfd.h | 12 ++++++++++++
>  mm/memfd.c            |  4 ++--
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/memfd.h b/include/linux/memfd.h
> index c328a7b356d0..b4fda09dab9f 100644
> --- a/include/linux/memfd.h
> +++ b/include/linux/memfd.h
> @@ -18,6 +18,8 @@ struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx);
>   */
>  int memfd_check_seals_mmap(struct file *file, vm_flags_t *vm_flags_ptr);
>  struct file *memfd_alloc_file(const char *name, unsigned int flags);
> +int memfd_get_seals(struct file *file);
> +int memfd_add_seals(struct file *file, unsigned int seals);
>  #else
>  static inline long memfd_fcntl(struct file *f, unsigned int c, unsigned int a)
>  {
> @@ -37,6 +39,16 @@ static inline struct file *memfd_alloc_file(const char *name, unsigned int flags
>  {
>  	return ERR_PTR(-EINVAL);
>  }
> +
> +static inline int memfd_get_seals(struct file *file)
> +{
> +	return -EINVAL;
> +}
> +
> +static inline int memfd_add_seals(struct file *file, unsigned int seals)
> +{
> +	return -EINVAL;
> +}
>  #endif
>  
>  #endif /* __LINUX_MEMFD_H */
> diff --git a/mm/memfd.c b/mm/memfd.c
> index f032c6052926..46c5508beea4 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -228,7 +228,7 @@ static unsigned int *memfd_file_seals_ptr(struct file *file)
>  		     F_SEAL_WRITE | \
>  		     F_SEAL_FUTURE_WRITE)
>  
> -static int memfd_add_seals(struct file *file, unsigned int seals)
> +int memfd_add_seals(struct file *file, unsigned int seals)
>  {
>  	struct inode *inode = file_inode(file);
>  	unsigned int *file_seals;
> @@ -310,7 +310,7 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
>  	return error;
>  }
>  
> -static int memfd_get_seals(struct file *file)
> +int memfd_get_seals(struct file *file)
>  {
>  	unsigned int *seals = memfd_file_seals_ptr(file);
>  
> -- 
> 2.52.0.457.g6b5491de43-goog
> 

-- 
Sincerely yours,
Mike.

