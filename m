Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0661ACD6E57
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 15:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aVwfuIF8XzrapwauUCEB2fp3FWLAi/e4fM+1gNagxHo=; b=TofIr4ZtR7s9mm60K/HJ1lijLL
	qOuI0vNBh2GWL1aIjk7zj/y+ur6bhcc99NE40Q4x8Q4mTbwjD/PAfvq2xjXxj3IuSI0s1/lFwzTSz
	2ZsURYBAdr64GT5dyJwa7ZDSJghUibgTOTa54wS149sUen+WIvCY8F9SamadTZaFrg12bC9aLuzK8
	iAiqPUxIls4SpeliPBbIUkTifW4vL6Wuq3y7FerRAhFjfha4p/WYTxhp2R9EBWPhsXeFFWaTHv+Hd
	jZ5yt817Fr8n+5vVfuFJ5PR16L7+h7OBEYCkmcZ28GsHzoxeqEXSUL3obNGTifAkNTqbfwMbZ4l/Y
	ghRYa7vA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUQqx-0000000DHzU-19fU;
	Tue, 02 Jun 2026 15:16:27 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUQqu-0000000DHyy-45Qr
	for kexec@lists.infradead.org;
	Tue, 02 Jun 2026 15:16:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 584A34420B;
	Tue,  2 Jun 2026 15:16:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EBA1F00893;
	Tue,  2 Jun 2026 15:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780413384;
	bh=aVwfuIF8XzrapwauUCEB2fp3FWLAi/e4fM+1gNagxHo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=dYNdQRf/t6+z4UqPKk5Bpi9o0wNX8u+CQPH7XlQaPprvPBDA3LuRDqogn8DXnRdzq
	 0DGglkcBIyoVJjYSFXd+UoA1LVPioxE/HfEQF44Zr5NNRNHshmb8EMMS7hGySYadwZ
	 aH0QJgFwUZ7ZI6IOIB2w7VAdcgTN74eS/adOeGNKKrEsiAh4AcwPB/MN+rdL402Nby
	 zpZPdik9yW+bMWl8RRHq1qWNMlnFGQOTrTglkZIVbybWRgPhmv6/5FvqROguN4iQ+t
	 e8SnzxVNRY7pCRrSJd1CxvHgXgCNKYygWO4utbnqq3iaCRMvwsuFK3SbiHrn5zXzjX
	 hYoRoh+ObenOg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Michal Clapinski <mclapinski@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Baoquan He <bhe@redhat.com>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Mike Rapoport
 <rppt@kernel.org>,  Pratyush Yadav <pratyush@kernel.org>,
  kexec@lists.infradead.org
Subject: Re: [PATCH v2] kexec_file: skip checksum verification when safe
In-Reply-To: <20260602123311.1841746-1-mclapinski@google.com> (Michal
	Clapinski's message of "Tue, 2 Jun 2026 14:33:11 +0200")
References: <20260602123311.1841746-1-mclapinski@google.com>
Date: Tue, 02 Jun 2026 17:16:21 +0200
Message-ID: <2vxzik81dlbu.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_081625_110572_4F882AE2 
X-CRM114-Status: GOOD (  44.86  )
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

On Tue, Jun 02 2026, Michal Clapinski wrote:

> Checksum verification is needed
> 1. for crash kernels. In a crash, we can't be sure the kernel is
>    intact.
> 2. if we're worried about relocating the kernel into a region used by
>    some DMA that wasn't properly cancelled.
>
> If KHO is enabled then relocations will happen to KHO scratch, which
> is free from DMA regions.
> If we used CMA to allocate segments then relocations are not going to
> happen at all.
> Therefore, we can safely disable checksum verification in both of those
> cases.
>
> Instead of adding a new variable to purgatory, just skip adding regions
> and save the default value of SHA256 hash.
>
> Saves ~250ms on my 4.0 GHz CPU. This is an important saving for the
> live-update project.
>
> Signed-off-by: Michal Clapinski <mclapinski@google.com>
> ---
> v2:
> - also skip checksum verification if KHO is enabled
> - small fixes from reviews
>
> My original idea was to do 2 changes:
> 1. Skip checksum if all segments are CMA.
> 2. If KHO is enabled, allocate the kernel inside kho_scratch using CMA.
>
> This way we could skip both relocations and checksum verification when
> KHO is enabled.
> But I realized that step 2 might not be possible on warm boots.

AFAIU we only relocate into scratch since relocating anywhere else might
over-write preserved memory. If there is no relocation, there is no need
for the kernel image to be in scratch, since the image won't be
preserved memory anyway.

So perhaps we can just use CMA directly, and only fall back to
kho_locate_mem_hole() if that fails? This should be a simple enough
change.

Do you know how much time we can save by skipping relocations? I would
guess it is in the hundreds of milliseconds.

Can you try this (COMPLETELY UNTESTED) patch out and see if it works and
if it further improves kexec time?

--- 8< ---
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 2bfbb2d144e6..0ccc7b6d67c1 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -720,14 +720,6 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
 	if (kbuf->mem != KEXEC_BUF_MEM_UNKNOWN)
 		return 0;
 
-	/*
-	 * If KHO is active, only use KHO scratch memory. All other memory
-	 * could potentially be handed over.
-	 */
-	ret = kho_locate_mem_hole(kbuf, locate_mem_hole_callback);
-	if (ret <= 0)
-		return ret;
-
 	/*
 	 * Try to find a free physically contiguous block of memory first. With that, we
 	 * can avoid any copying at kexec time.
@@ -735,6 +727,14 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
 	if (!kexec_alloc_contig(kbuf))
 		return 0;
 
+	/*
+	 * If KHO is active and relocations are to be done,, only use KHO
+	 * scratch memory. All other memory could potentially be handed over.
+	 */
+	ret = kho_locate_mem_hole(kbuf, locate_mem_hole_callback);
+	if (ret <= 0)
+		return ret;
+
 	if (!IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK))
 		ret = kexec_walk_resources(kbuf, locate_mem_hole_callback);
 	else
--- >8 ---

Of course this is not directly related to this patch so it shouldn't
block it, but I reckon we might be able to squeeze a bit more
performance out this way as a follow up.

> I have no idea how to fix that (except weird ideas like 2 kho_scratches
> that we swap on every warm boot), so I decided to just skip checksum
> verification when KHO is enabled. This unfortunately means relocations
> will still happen.
> ---
>  kernel/kexec_file.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 2bfbb2d144e6..db25a14692ab 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -27,6 +27,7 @@
>  #include <linux/syscalls.h>
>  #include <linux/vmalloc.h>
>  #include <linux/dma-map-ops.h>
> +#include <linux/kexec_handover.h>
>  #include "kexec_internal.h"
>  
>  #ifdef CONFIG_KEXEC_SIG
> @@ -798,6 +799,16 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
>  	return 0;
>  }
>  
> +static bool kexec_only_cma_segments(struct kimage *image)
> +{
> +	for (int i = 0; i < image->nr_segments; i++) {
> +		if (!image->segment_cma[i])
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
>  /* Calculate and store the digest of segments */
>  static int kexec_calculate_store_digests(struct kimage *image)
>  {
> @@ -822,6 +833,21 @@ static int kexec_calculate_store_digests(struct kimage *image)
>  
>  	sha256_init(&sctx);
>  
> +	/*
> +	 * If KHO is enabled, the destinations are located in KHO scratch.
> +	 * KHO scratch can only contain early boot allocations and movable
> +	 * allocations. That means there is no risk of memory corruption by
> +	 * uncancelled DMA.
> +	 *
> +	 * If all segments were loaded into contiguous memory, there will be no
> +	 * relocations at all, so also no risk no corruption.

Typo: "so also no risk *of* corruption".

We can fix that up when applying I think, so no need for a v3 just for
this.

Other than this,

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

> +	 */
> +	if (image->type != KEXEC_TYPE_CRASH &&
> +	    (kho_is_enabled() || kexec_only_cma_segments(image))) {
> +		pr_debug("disabling checksum verification in purgatory\n");
> +		goto skip_checksum;
> +	}
> +
>  	for (j = i = 0; i < image->nr_segments; i++) {
>  		struct kexec_segment *ksegment;
>  
> @@ -867,6 +893,7 @@ static int kexec_calculate_store_digests(struct kimage *image)
>  		j++;
>  	}
>  
> +skip_checksum:
>  	sha256_final(&sctx, digest);
>  
>  	ret = kexec_purgatory_get_set_symbol(image, "purgatory_sha_regions",

-- 
Regards,
Pratyush Yadav

