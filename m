Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373C2606A324
	for <kexec@archiver.kernel.org>; Thu, 19 Nov 2026 21:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NVfEpOlr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=orn6ElUm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=jRzgudTO1qkSGuzOPfaR+Ba0Lwqyafb02x6YrJau0gQ=; b=NVfEpOlrLuOGZHMS8rdCZgcq+g
	C6mehoAgxBYmC7owVWUt0soPUNWHg7ZkZpXz2KAjkXg3awsy+RuU1YimgevNVzAx3FXeATWcNdPOF
	4zVjKc7ymB2gFa/1GpX4cb8Vsntp3pq1UmUpqr6/KFHqhD4deJF11+BaqS95GoLDoaUPgMVEYqQdd
	6Iy+sDqiPstcIBpF0qx7+Ne04VbYJkF0jUG05I2XkEv0L3nuYRAR8dMuMYR3v/uz+qL0umSpKoxI3
	oXaXE6AgJz+1WAG4QAVKzaNTZuo0aBEgVjp7DleDcsxcI3eqJfHZ2NULD9e3QBZVRULi+mb5eqsye
	DYIqeOlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU9FP-0000000DRgb-2gwG;
	Thu, 19 Nov 2026 21:00:47 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU9FO-0000000DRgT-2mbG
	for kexec@lists.infradead.org;
	Thu, 19 Nov 2026 21:00:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0E5B761F55;
	Thu, 19 Nov 2026 21:00:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A7F1F000C6;
	Thu, 19 Nov 2026 21:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795122045;
	bh=jRzgudTO1qkSGuzOPfaR+Ba0Lwqyafb02x6YrJau0gQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=orn6ElUmwk+wOC3TWMCK1D63fKBmQ66tvx/fNy/R1n50ZqHw1OpgnTw5sSOZkyaJG
	 f9qQu/IDo5aUE4eEs5j0qIIiK9CO727Ltm4ttNMYWC7BR8WTmLDhNjl6EjjRG7gADl
	 MMq9ZKC5M6XMbPTNjxCelZpzuwUG1uW0mRbrRpHm5GgDNYl4s/J+YfRjMRKk7uN1/o
	 Af9WF86DUIRObuR/qpoNARO65+rd318lrMb1OP5tbT25DR1rYP+FxCALKxN2tXCkHp
	 ZX0eaBUzRlkedL6sFRSqNvtScDw+qMyXF3wdCGDCOgep6jJ6Cyi9FQPJCCGeoOP6CD
	 Djtx2LjVYD2xw==
Date: Thu, 19 Nov 2026 15:00:43 -0600
From: Rob Herring <robh@kernel.org>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: saravanak@kernel.org, akpm@linux-foundation.org, david@kernel.org,
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	m.szyprowski@samsung.com, robin.murphy@arm.com,
	baoquan.he@linux.dev, pasha.tatashin@soleen.com,
	pratyush@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	iommu@lists.linux.dev, kexec@lists.infradead.org
Subject: Re: [PATCH 2/4] of: reserved_mem: keep the reservation when
 node_init returns -EBUSY
Message-ID: <20261119210043.GA532410-robh@kernel.org>
References: <20261103162429.2053989-1-radhey.shyam.pandey@amd.com>
 <20261103162429.2053989-3-radhey.shyam.pandey@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103162429.2053989-3-radhey.shyam.pandey@amd.com>
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 09:54:27PM +0530, Radhey Shyam Pandey wrote:
> fdt_init_reserved_mem_node() treats any error from a region's init function
> as "this node is unusable" and calls memblock_phys_free() on the whole
> range, although the range was reserved earlier during the FDT scan by code
> unrelated to that init function. Give -EBUSY the meaning "cannot be used as
> described, but must stay reserved" and skip the release for it. Nothing
> returns -EBUSY from node_init today. The next patch does, to refuse a CMA
> pool overlapping the kernel image, which without this would free
> [_text, _end) rather than protect it.
> 
> Suggested-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> ---
> Changes since RFC:
> - New patch
> ---
>  drivers/of/of_reserved_mem.c    | 14 ++++++++++++++
>  include/linux/of_reserved_mem.h |  5 +++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 0fd1683cba01..d67a2b3a4d44 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -621,6 +621,20 @@ static void __init fdt_init_reserved_mem_node(unsigned long node, const char *un
>  
>  	err = __reserved_mem_init_node(rmem, node);
>  	if (err != 0 && err != -ENODEV) {
> +		/*
> +		 * The region was reserved before its init function ran, so it
> +		 * is not ours to release. -EBUSY says the init function is
> +		 * declining it for a reason that outlives this node; freeing
> +		 * it would hand the range to the page allocator even though
> +		 * something else still owns it.
> +		 */
> +		if (err == -EBUSY) {
> +			pr_info("node %s init failed, keeping reservation\n",
> +				rmem->name);
> +			rmem->name = NULL;
> +			return;
> +		}

I would move this out of the outer 'if' and and make the outer if an 
'else if'.

Rob

