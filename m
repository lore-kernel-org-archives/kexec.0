Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2DBCD6E55
	for <kexec@archiver.kernel.org>; Mon,  1 Jun 2026 22:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dKPzH+TPpagHmXQ5tpUx95/DULoRSEM1RHR2mpVghr8=; b=aDg7tiqcvzKIyU1eIMps/o2Qfs
	flLeGG3fX/sHjvqIrd4RlYLdYqzhEiVFXG5smiKQEKcrrK2/YtXc2alZgtYG1FtDL1Q9wb2XHOYVd
	5k3sNZSVXCWs8hVEvOWuiEcOFvWJTKmtmGIsr1oyo/FZxu20d5pE+HqU9d9vcdKCPENY6x4RgkU42
	dM78D+JGYezUw8pP7VOyUJGLZ5hC0BWwNc6zNpwHSCEiVuw43bmfWWXqU/H/NvbitgbBkqsWjaJRl
	Unk4vYjEcSmLPda+B6eMu0Lbgp4ox0YYAtCxeMzkCDrIoWUFeMi3P9N19qIuF8Dgadksx6HSINZld
	B6nSDYaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUBY1-0000000C1mf-2MTz;
	Mon, 01 Jun 2026 22:55:53 +0000
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUBXy-0000000C1mG-3ZfO
	for kexec@lists.infradead.org;
	Mon, 01 Jun 2026 22:55:52 +0000
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-8cbe69b122bso108600336d6.2
        for <kexec@lists.infradead.org>; Mon, 01 Jun 2026 15:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780354549; x=1780959349; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dKPzH+TPpagHmXQ5tpUx95/DULoRSEM1RHR2mpVghr8=;
        b=focQhANsSFN7HZy+mAY/vGYGU/03jZ9lmp48Y9O54dre8n3dSTpOvn9LwsSS3OVgqf
         B0vKvaqPfqkoeVfknDbvNBXP7+1M5eXlcXfeE4D5uxGIJFc5PN9MP+lls5pMu57jCDd5
         srDu3PaoupKdaVdaX405dIFJ7OUMW8Wl0hFzRTU+8GjJw9ucl78BqXigR39D+FlAV5IM
         YB7ST2DTJ3cnLTx0Eh4nupTuOA07OqxTqvokG1gmqHySnJHLnc2nbOop4B7ennLxATGi
         IgoHifOBuM0RN/30/+ftUjRPT4EJETPW4ChdLvPOkFYnRV3TxN/PGOLSwiu/Pn0OFYuG
         uRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780354549; x=1780959349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKPzH+TPpagHmXQ5tpUx95/DULoRSEM1RHR2mpVghr8=;
        b=Thjl9KbtoDsqgoWP1+pld1Z08clo6nTe5gMFMQkl5dw/Dxh+Q+LP8g5yY9WUp0wUho
         eHHpCsOxGDx4UdWbS/iqDZ7HaonGu54h3yvh0Zfy0QcZqiwSVzmeSBHf8xJ1UILyRe8m
         FaQ/btt86yf9iVhPxSzKRWxcIJ0Nd1nF473hXcPlXQRAvszsJjRUURl5DJvImJTGfOMW
         YFwhTW34a0lSPRzvqQ1flOc9kV0XhYoAcX3te05nHB1QbO5oincRt/4URC/8sKQeIAzM
         jnscm96UCZ97H+J+6EeiHD4klgkYFnjYZF+Ld+urDqzzBmZex51lVQLpPtx85Ats/z1i
         58/g==
X-Forwarded-Encrypted: i=1; AFNElJ8qaHDDYlFLDd8iI10VIgLjPM6bcbBZkfEfmK60aU7Emd/UqxQlwht+1ChMyKHJuTnPOwkyow==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx078TXOlhW6JsoEC7qMtmD2mwfdU7nj/QCLJZU7Dv8QsXhyuv0
	/K5xILznCWBYhJ65fKb+c9NqRHYsfDQXXyprHit2xmSu7FIFMthtVSk2m7QzQjnb6fo=
X-Gm-Gg: Acq92OGiLpy5DBzlZ6ktD/IU/P00JtGGOt3ljaHSnW5BIe3bg3J0nQ240HWvBZv6jKl
	v2beIIbiFBbuAvXcYC9sEgC2MZeN/QgCVXDzyQ9ON/1fb+I3cac8qb1xhieFeipCFtV75v/1G6K
	Q9eTUGMdgx0Pb0Lu7pwq0a9i5qvcR/0E16Kf8UH9ODGfs5GY1t/Q5uN7u9BH6dwkeQo/HxqeQPD
	D80JB/qEdAorsQ2zJ4oda3WGOREkPDBNNOTXC1Xw5YazSo7u2GVnkTeX6iP81zViCQOObryWCFi
	IO0UsvlRC1dgo8+zIBZX0dnvhG13W5v0hl5mTaTcIKfcpsidKYq4f17FJWvgH9V+qHJ2VmhOl2x
	mNsinZ0/SLr26yMx3WETB3XEb7VuFExsRX00Uy6071ph9n7aQw/emylNt5iRrIlZvpTLUJdggz3
	u9O6tUrzdixQCd5/gfkv/hu8WtQRGKU1gBLUMT2BMZbdZSfNHPquRHYDwjBVWQ7g==
X-Received: by 2002:a05:6214:5092:b0:8ca:268b:13b2 with SMTP id 6a1803df08f44-8ccefda892fmr206605196d6.32.1780354549060;
        Mon, 01 Jun 2026 15:55:49 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cec1d7ebd4sm2424146d6.23.2026.06.01.15.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 15:55:48 -0700 (PDT)
Date: Mon, 1 Jun 2026 22:55:47 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Michal Clapinski <mclapinski@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Subject: Re: [PATCH] kexec_file: skip checksum verification when relocations
 aren't needed
Message-ID: <ah4MSSuiElD2fZMs@plex>
References: <20260601191136.799134-1-mclapinski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601191136.799134-1-mclapinski@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_155550_910396_EAD89675 
X-CRM114-Status: GOOD (  27.30  )
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

Nit: The crash kernel also does not perform relocations, yet a checksum 
is still required. The subject should be something like:
kexec_file: skip purgatory checksum if all segments are CMA allocated


On 06-01 21:11, Michal Clapinski wrote:
> Checksum verification is needed
> 1. for crash kernels. In a crash, we can't be sure the kernel is
>    intact.
> 2. if we're worried about relocating the kernel into a region used by
>    some DMA that wasn't properly cancelled.

Nit: Please add a little background information about CMA segments being 
recently added, as well as the necessity for a fast reboot due to the 
live update use case.

> 
> If we used CMA to allocate segments then
> 1. we're not working with a crash kernel.
> 2. relocations are not going to happen.
> 
> Therefore, we can safely disable checksum verification.
> 
> Instead of adding a new variable to purgatory, just skip adding regions
> and save the default value of SHA256 hash.
> 
> Saves ~250ms on my 4.0 GHz CPU.
> 
> Signed-off-by: Michal Clapinski <mclapinski@google.com>
> ---
>  kernel/kexec_file.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 2bfbb2d144e6..2dc8b0435fe6 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -808,6 +808,7 @@ static int kexec_calculate_store_digests(struct kimage *image)
>  	void *zero_buf;
>  	struct kexec_sha_region *sha_regions;
>  	struct purgatory_info *pi = &image->purgatory_info;
> +	bool can_skip_checksum = true;
>  
>  	if (!IS_ENABLED(CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY))
>  		return 0;
> @@ -822,6 +823,23 @@ static int kexec_calculate_store_digests(struct kimage *image)
>  
>  	sha256_init(&sctx);
>  
> +	/*
> +	 * If all segments were loaded into contiguous memory, there will be no
> +	 * relocations. In that case there is no risk of memory corruption by
> +	 * uncancelled DMA and we can skip checksum calculation.
> +	 */
> +	for (i = 0; i < image->nr_segments; i++) {
> +		if (!image->segment_cma[i]) {
> +			can_skip_checksum = false;
> +			break;
> +		}
> +	}
> +
> +	if (can_skip_checksum) {
> +		pr_info("disabling checksum verification in purgatory\n");
> +		goto skip_checksum;
> +	}
> +
>  	for (j = i = 0; i < image->nr_segments; i++) {
>  		struct kexec_segment *ksegment;
>  
> @@ -867,6 +885,7 @@ static int kexec_calculate_store_digests(struct kimage *image)
>  		j++;
>  	}
>  
> +skip_checksum:
>  	sha256_final(&sctx, digest);

With the few nits:

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com> 

>  
>  	ret = kexec_purgatory_get_set_symbol(image, "purgatory_sha_regions",
> -- 
> 2.54.0.929.g9b7fa37559-goog
> 

