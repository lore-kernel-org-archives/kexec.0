Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9EFCD5BA3
	for <kexec@archiver.kernel.org>; Tue, 19 May 2026 09:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=82a7qdPVs5Gd632/5g4LY7OgPlVC00agc3Fj1Sc0t9Y=; b=ZFLqvjDCParx7aH6AxuevIiHy9
	nkhMDnW1ycKo6PBzk49gpAj5+JYz0gAj2Hauy9MaNUbSurlxmi6t11sb11JXaKKSjECXEZ39rVtg5
	sFaSWrVyHCeL0ENUk1lvWDy4iCjks+gyUM6a9NWv38Cp5RblyKMGszTU/FZKSyT2s8IHS06gkJSMf
	weANq5FOmBrfjnyd/PA6yBCMoCQiiSc8jGiXQ9tavFqBf9sLpvC3cMbmw9PzO8pbiDi77+MAlZxcF
	tKn2/T+Cw/pik23ACj85vEz1Cf2G2MjM5Bilj2ljN0g0gjIgblOtDGg08djLI3ZWyOR6yy1Ec135b
	THxAS9sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPGxe-00000000yHm-0cRf;
	Tue, 19 May 2026 09:42:02 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPGxY-00000000yH4-42fB
	for kexec@lists.infradead.org;
	Tue, 19 May 2026 09:41:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5294F60210;
	Tue, 19 May 2026 09:41:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673F3C2BCC6;
	Tue, 19 May 2026 09:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779183716;
	bh=1GMVyqPtItYw+4ZYeMdSgc9+7flqn2nQUEy5yu+ZH88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hc/jrytA3Kkcsz7psqmycpl4umryx8z5FunI4h8w82UYRiJlgo8uUuQTrmLBHvFcG
	 1uzeZyy44PxAxS037pYRnkorLlzMaNHTK7jFR0R5m06pRY/FkNkA6TTiUdwTUvdpiH
	 fGEyXCTAueF/9CRDHYdRZlcE4wqJb+XWIFbDVZm8ewrtrOYRtqoABN6KLb19lI5ZTH
	 DEfE8jNVENxFwmGUaV1jEQ0C6KJNiaxZV2H/Moj/I89PciFPRcaKNRV4TjzsebLdFq
	 zV+uK4/FEfusNd2CwoOnMTvt+sO8BhzcNLR4RdAP5hMgfoTyVkHPOmr2QR66jSaAv+
	 uDKfOxgCoEg6A==
Date: Tue, 19 May 2026 10:41:53 +0100
From: Simon Horman <horms@kernel.org>
To: Alejandro Hernandez <alhe@linux.microsoft.com>
Cc: kexec@lists.infradead.org
Subject: Re: [PATCH] kexec: restore functionality to preserve fd xattrs for
 uncompressed kernel images
Message-ID: <20260519094153.GA227450@horms.kernel.org>
References: <20260507215417.2674568-1-alhe@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507215417.2674568-1-alhe@linux.microsoft.com>
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

On Thu, May 07, 2026 at 09:54:17PM +0000, Alejandro Hernandez wrote:
> Since commit 714fa115 xattrs attached to a kernel image file (such as IMA
> signatures) are not being preserved, do_kexec_file_load() was modified to use
> memfd_create() which now passes an anonymous file descriptor to
> kexec_file_load(). This change eliminated the filesystem inode identity of the
> original kernel file, hence attributes are no longer visible to the kernel IMA
> appraisal handler during kexec_file_load, causing IMA policy enforcement to fail
> even for validly signed kernel images.
> 
> This patch attempts to restore such behavior although, only does it for
> uncompressed kernel images. To do this, we first figure out if the image file is
> compressed or not and call each method accordingly.
> 
> Compressed images continue to use memfd and cannot carry forward the original fd
> security attributes, since their decompressed bytes do not match the signed
> artifact. Proper handling of compressed images with IMA would require either
> signing the decompressed artifact or kernel-side support for decompression
> within the kexec_file_load path.
> 
> Signed-off-by: Alejandro Hernandez Samaniego <alhe@linux.microsoft.com>

Hi Alejandro,

Thanks for the patch.

Overall this looks good to me. But I'm wondering if you could spin a v2
to address a minor code-style issue I have noted inline.

> ---
>  kexec/kexec.c | 42 +++++++++++++++++++++++++++++++++++-------
>  1 file changed, 35 insertions(+), 7 deletions(-)
> 
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index 08edfca..a388762 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -1328,17 +1328,41 @@ static int do_kexec_file_load(int fileind, int argc, char **argv,
>  
>  	kernel = argv[fileind];
>  
> -	/* slurp in the input kernel */
> +        /* Hold original fd with its xattrs */
> +	kernel_fd = open(kernel, O_RDONLY);
> +	if (kernel_fd == -1) {
> +		fprintf(stderr, "Failed to open file %s:%s\n", kernel,
> +				strerror(errno));
> +		return EFAILED;
> +	}
> +
> +	/* Compressed vs Uncompressed */
> +	struct stat kernel_stat;
> +	off_t kernel_file_size = -1;

I would prefer if we stuck to declaring local variables
at the top of this function.

> +	if (fstat(kernel_fd, &kernel_stat) == 0)
> +		kernel_file_size = kernel_stat.st_size;
> +
> +        /* slurp in the input kernel */
>  	kernel_buf = slurp_decompress_file(kernel, &kernel_size);
>  	if (!kernel_buf) {
>  		fprintf(stderr, "Failed to decompress file %s:%s\n", kernel,
>  				strerror(errno));
> +		close(kernel_fd);
>  		return EFAILED;
>  	}

...

