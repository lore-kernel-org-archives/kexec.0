Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E48B6CD98CC
	for <kexec@archiver.kernel.org>; Thu, 11 Jun 2026 12:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aM4CFsjAfrgDrQU/fs6TDRb0SV1bxnyirTxwHZhtIEM=; b=y80bM9VZKOFiTKvF/tC/icZoHv
	81HB05pLodAl+ERVsYFjE7EckmNqcFfYJPW2JYRVllwAJny9/DFv8adMGSgVmWR4yqZXdBF2iji27
	owvCSHKI6HMat0CVNSpW59SBzSnHywBgUx53/qbsyNGNACb68G0/DMlzWYDQJ4sH7v3GecAR5jHNu
	XTXrj8+p7M99Ue8q7XOWQ+fatR3nut8iqS5Hn60WxwrZS2Pp7gMIOHyZOctmGpZAaPujLL1lkQEtO
	6oy8xzNAc7OdVJ5ZJ+CYXqEBs2bnyfHl+NIRDqcx9vdFsUIKpfWe4ccbvt+Y5euAofxPWd+9kxptN
	Y+/bfosw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXehg-00000009QNj-1o0m;
	Thu, 11 Jun 2026 12:40:12 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXehf-00000009QNO-0Orf
	for kexec@lists.infradead.org;
	Thu, 11 Jun 2026 12:40:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A57D44064D;
	Thu, 11 Jun 2026 12:40:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54021F00893;
	Thu, 11 Jun 2026 12:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781181610;
	bh=aM4CFsjAfrgDrQU/fs6TDRb0SV1bxnyirTxwHZhtIEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EeN5KasIedx+VFynls428joJP2xO7wsQhXM+JE+dwrimD+izqGH64EN3R24ND7Bd8
	 WOsmQK2462wD4Nl6UUnx+TeQLe6jZmeJzCxGbJE9kCTym7Y7F2+lYe9uwBjylfGNin
	 fBshJXlf3l7DuGg/RQu28awc0CrVkW8mx2eOtPM1j+sJIYkq+hMiZHCS3DMgBFSKIh
	 UZ9jIkl1vc56xvDb60tgS/o8bQqCic4lJ6dXyW8gDjEs0YfzC+zxSu3nXvBUji9mvc
	 HY3ddRBs0PSon87+zIP8x9gb9rd2JQWVK/rCIWQIaAcpRpmkv4nvWaHSnfMrNYUoSb
	 khYH9VNVAPXKQ==
Date: Thu, 11 Jun 2026 15:40:03 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Tarun Sahu <tarunsahu@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/memfd_luo: validate serialized_data before conversion
Message-ID: <aiqso7rkpX6oMer7@kernel.org>
References: <c2478f79207b10a13282d917c961261d17b86a15.1781173768.git.tarunsahu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2478f79207b10a13282d917c961261d17b86a15.1781173768.git.tarunsahu@google.com>
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

On Thu, Jun 11, 2026 at 10:30:03AM +0000, Tarun Sahu wrote:
> In memfd_luo_finish() and memfd_luo_retrieve(), phys_to_virt() was called
> on args->serialized_data before checking if the physical address is valid.
> Since physical address 0 does not map to virtual NULL (due to direct
> mapping offsets), the subsequent check 'if (!ser)' was ineffective at
> catching a missing serialized_data, leading to unsafe dereferences later.
> 
> Validate that args->serialized_data is non-zero before calling
> phys_to_virt().
> 
> Fixes: b3749f174d68 ("mm: memfd_luo: allow preserving memfd")
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
> ---
>  mm/memfd_luo.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
> index 59de210bee5f..10f3983b0060 100644
> --- a/mm/memfd_luo.c
> +++ b/mm/memfd_luo.c
> @@ -397,10 +397,11 @@ static void memfd_luo_finish(struct liveupdate_file_op_args *args)
>  	if (args->retrieve_status)
>  		return;
>  
> -	ser = phys_to_virt(args->serialized_data);
> -	if (!ser)
> +	if (!args->serialized_data)

We really should make args->serialized_data a KHOSER_PTR

>  		return;
>  
> +	ser = phys_to_virt(args->serialized_data);
> +
>  	if (ser->nr_folios) {
>  		folios_ser = kho_restore_vmalloc(&ser->folios);
>  		if (!folios_ser)
> @@ -522,10 +523,11 @@ static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
>  	struct file *file;
>  	int err;
>  
> -	ser = phys_to_virt(args->serialized_data);
> -	if (!ser)
> +	if (!args->serialized_data)
>  		return -EINVAL;
>  
> +	ser = phys_to_virt(args->serialized_data);
> +
>  	/* Make sure the file only has seals supported by this version. */
>  	if (ser->seals & ~MEMFD_LUO_ALL_SEALS) {
>  		err = -EOPNOTSUPP;
> 
> base-commit: 9716c086c8e8b141d35aa61f2e96a2e83de212a7
> -- 
> 2.54.0.1099.g489fc7bff1-goog
> 

-- 
Sincerely yours,
Mike.

