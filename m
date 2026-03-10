Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C87C7EB1048
	for <kexec@archiver.kernel.org>; Tue, 10 Mar 2026 10:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fgTzzrmoxXkxxAU7wnjcLS0dqIIdLnXdz4estcKKu7M=; b=o0g8FOj2B6MgTV4wLgbniUn8+d
	QE2r57B0M4SXLZPrmXrTN8DoX37DO///UVIvD5GY+SPuHfwG2brSFQDmme5LrzflN37IKKqNkK3X8
	uv/9aB+Vw7EROh0I0qXGXard7uYSvW8R06r9iABqj5FC34GjEwo64hzKcPrH5Xbs2LNUDg1vtWqI1
	GLO4TpxHEV4U5pyVxmJOG6bzVBCNRpSKIUA3WGt33txVdXvWwqol4Acb0FqlHaZua0VZ/ubPoZWhG
	bHSv9AkXF5lArs8mwfi/pDlKFHEQSQulvfZU1+o59RpFOe9cDNvI5eQFDKw08lAoGdXd4nRRlcolz
	5sd3zLiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzuNv-00000009Cqh-2ada;
	Tue, 10 Mar 2026 10:32:19 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzuNt-00000009Cpd-2jsI
	for kexec@lists.infradead.org;
	Tue, 10 Mar 2026 10:32:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8B4F243A73;
	Tue, 10 Mar 2026 10:32:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01C4C19423;
	Tue, 10 Mar 2026 10:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773138735;
	bh=ZAajPCZBWnuyiHXT/HC/E7AWtxibfHeRxEoqFvx/SPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WLBubtiyvjjuzUzuIpOM/fjq+FTbtXBIm8ZoTRqrnLL49dgS29NGyxzfLRF9Rgt4H
	 fc2qPAsrsr9xDCUf2rMUjN4NeZJnOzz5ifzx7SKfHviwG033YS/VwBY21GWr2zpoy0
	 nNIrTb069ljo1jW6gaFoGlwakT0BR+PCuNAbh4YsvXIKV+ItLIdKNKL9dZ1awtRQle
	 L/eqipk8Mq0yUMMee0XueXnXiM1Efio6OHyzySi875QgfTeq1mvntAI7hA7m1jTxbr
	 EgjjC6OS6t0EpjGgn1DbWBJa4HW196mKxBPFsjPeMtN+Fa5mGlFqhQxtqfM/FqaF/F
	 7sl4bVYdv1TYQ==
Date: Tue, 10 Mar 2026 12:32:09 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kho: make sure preservations do not span multiple
 NUMA nodes
Message-ID: <aa_zKQr_yGKVJ7cF@kernel.org>
References: <20260309123410.382308-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309123410.382308-1-pratyush@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260310_033217_733883_25786FAD 
X-CRM114-Status: GOOD (  19.90  )
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

On Mon, Mar 09, 2026 at 12:34:06PM +0000, Pratyush Yadav wrote:
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> 
> The KHO restoration machinery is not capable of dealing with
> preservations that span multiple NUMA nodes. kho_preserve_folio()
> guarantees the preservation will only span one NUMA node since folios
> can't span multiple nodes.
> 
> This leaves kho_preserve_pages(). While semantically
> kho_preserve_pages() only deals with 0-order pages, so all preservations
> should be single page only, in practice it combines preservations to
> higher orders for efficiency. This can result in a preservation spanning
> multiple nodes. Break up the preservations into a smaller order if that
> happens.
> 
> Suggested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
> 
> Notes:
>     Ref: https://lore.kernel.org/linux-mm/CA+CK2bDvaGmfkCPCMWM6gPcd4FfUyD6e5yWE+kNcma1vT3Jw3g@mail.gmail.com/
> 
>  kernel/liveupdate/kexec_handover.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index cc68a3692905..bc9bd18294ee 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -869,9 +869,17 @@ int kho_preserve_pages(struct page *page, unsigned long nr_pages)
>  	}
>  
>  	while (pfn < end_pfn) {
> -		const unsigned int order =
> +		unsigned int order =
>  			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
>  
> +		/*
> +		 * Make sure all the pages in a single preservation are in the
> +		 * same NUMA node. The restore machinery can not cope with a
> +		 * preservation spanning multiple NUMA nodes.
> +		 */
> +		while (pfn_to_nid(pfn) != pfn_to_nid(pfn + (1UL << order) - 1))
> +			order--;
> +
>  		err = __kho_preserve_order(track, pfn, order);
>  		if (err) {
>  			failed_pfn = pfn;
> -- 
> 2.53.0.473.g4a7958ca14-goog
> 

-- 
Sincerely yours,
Mike.

