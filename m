Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CF6CAC59A
	for <kexec@archiver.kernel.org>; Fri, 19 Sep 2025 09:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=utj8GPGe9xQrwlm+Dp8WOy90lEVmz2edyt0hCd7KAeg=; b=UTjXY/VwBZnVCLk6gYZfBrlKOZ
	UghPa8HCB7SwvH0LkRcxKSLLfQaHCaj8/ETtGr6seYaYcaCF3T5fPdS+a2iYisHYYRoFGs6+0Kd7e
	LwxWLJt58ULJaQ/h0BSuVrmg6KwRoGQnrfAJKmXBVIYM8Ccl2bQkxgb730ivhF4IaXTXWyRQAcENj
	8pNqoedB9Q7/t6Lv8UxQB81oADvLAN2z4Pe5yJDwgBVUzT8l9USeMtLzU/ICZk069614lmf640y8w
	Zf8XcBvK2Vdr5kfoNi5rhiiG1O7qHxwoXm4cTJzA3stPCRsXryqCtlnFiDAqodGXfV4fcfeTiehF1
	elAKKhqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzXfw-00000002Qvf-3GRc;
	Fri, 19 Sep 2025 09:45:08 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzXfv-00000002QvR-1l3O
	for kexec@bombadil.infradead.org;
	Fri, 19 Sep 2025 09:45:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=utj8GPGe9xQrwlm+Dp8WOy90lEVmz2edyt0hCd7KAeg=; b=Fbz+HrAE8cdlrrcgD7V4hV9TKh
	hJJGOFnVM0RBjt5zj/4WjZqIpAObzFBnjPf3szszInkMG76i5JL0eh6wIRyGPf2x7LE5CHneK7TKJ
	f6/I5inAZwdwJ+//+vKCp5bNXA9PUBGIPEJrQ0I4Vi8Lyuz35ouGTi0F7GHKfmxCvf69Sx51IIWE2
	kvQ6L41MgkU4r7JFvj94tUSvMgsEl/VmInMu2Pa6/992vNtX9/I67TLqKpZUI3d4MmCpOzVsvAaui
	ofb3VVj5h9277ulFPF6VLXhUJzLPdZQJB8hM9Yd/wltACpxZraX6VR0smWN0PqC7Zn1cnWFtF27pH
	Siy0DmoQ==;
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzXfs-00000007og5-0KMI
	for kexec@lists.infradead.org;
	Fri, 19 Sep 2025 09:45:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E7D1A442D8;
	Fri, 19 Sep 2025 09:44:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADABC4CEF1;
	Fri, 19 Sep 2025 09:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758275099;
	bh=GevPAgZnxPiABiyE8TgVYJoyrxKHZP9YdLV2GloJTu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lhz40lt0SEu3HxgEYIqaeltRAt4aEBgazYuPF9b2ALx7MPrXRYZh7j4KBJAYjZ4Ab
	 PhrajEYLtN+XhORv3jeUevqKHzRSuZHfsqfmH9EgBXtCpe2gtbQdOcrRd5UJsyc46b
	 tFfY75K57McmOcZnLHImyV5Dv9LtW/GSpwXzxy2jZAovnc2lvPkPRezqGEDhD4l1sO
	 Oh7o8eWuoZ5F6RLqO/4487IB1qBqFdXUKxmxATUT5sPDlCVokiHWmWYxV/1qF9/pD2
	 ELNo7ibLVq3SzpiwEe2yb4CBGNo4N9NRP2IuIfBoXVJJE3/eIIGQXtNQv5jj26TxRe
	 dkNeFxtNu9B6w==
Date: Fri, 19 Sep 2025 12:44:52 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH] kho: only fill kimage if KHO is finalized
Message-ID: <aM0mFDdoQ4r1f9Mo@kernel.org>
References: <20250918170617.91413-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918170617.91413-1-pratyush@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250919_104504_430499_FF079953 
X-CRM114-Status: GOOD (  27.11  )
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

On Thu, Sep 18, 2025 at 07:06:15PM +0200, Pratyush Yadav wrote:
> kho_fill_kimage() only checks for KHO being enabled before filling in
> the FDT to the image. KHO being enabled does not mean that the kernel
> has data to hand over. That happens when KHO is finalized.
> 
> When a kexec is done with KHO enabled but not finalized, the FDT page is
> allocated but not initialized. FDT initialization happens after
> finalize. This means the KHO segment is filled in but the FDT contains
> garbage data.
> 
> This leads to the below error messages in the next kernel:
> 
>     [    0.000000] KHO: setup: handover FDT (0x10116b000) is invalid: -9
>     [    0.000000] KHO: disabling KHO revival: -22
> 
> There is no problem in practice, and the next kernel boots and works
> fine. But this still leads to misleading error messages and garbage
> being handed over.
> 
> Only fill in KHO segment when KHO is finalized. When KHO is not enabled,
> the debugfs interface is not created and there is no way to finalize it
> anyway. So the check for kho_enable is not needed, and kho_out.finalize
> alone is enough.
> 
> Fixes: 3bdecc3c93f9f ("kexec: add KHO support to kexec file loads")
> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>

Nice catch!

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  kernel/kexec_handover.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> index 8079fc4b9189..5ff959a90165 100644
> --- a/kernel/kexec_handover.c
> +++ b/kernel/kexec_handover.c
> @@ -1242,7 +1242,7 @@ int kho_fill_kimage(struct kimage *image)
>  	int err = 0;
>  	struct kexec_buf scratch;
>  
> -	if (!kho_enable)
> +	if (!kho_out.finalized)
>  		return 0;
>  
>  	image->kho.fdt = page_to_phys(kho_out.ser.fdt);
> -- 
> 2.47.3
> 

-- 
Sincerely yours,
Mike.

