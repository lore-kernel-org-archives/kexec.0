Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F413CD6E4A
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 13:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kWWOyRVkIQyqU9zRXKt0slwdKJEKJSUvWbXeFvGOZWI=; b=mgTpXIAXiHhsbsQL5LV+48FEc/
	gD8hLA413+DdNfzUcHEr7k8laD+E38MP41HHIMD8DpWjTWuASJgm0KyZTaPNPqlOMz/vOAaGe8Bqx
	86r+wBbZJNl0w4Xxr33PCAtzPoSQIy/TpX1vd2EkiJSwQNTi0WmidqF9TOOtEwT5aQMIht9Ourelw
	jaxW+yl8QEjCsU3A4c7KdPfYV4jWknTE2koBBq05U5fMbCEWZhAChFTOAQBOEI2SmCjZpkWNF0OJ5
	RvSI/7b2Xbih64gMLzOt757ThUgFqo2zjKMWyfeelE/E0syLu3g4TfUyWQNQ48FhXEb7Q2LAaaYcW
	KmtjrcBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUlQJ-0000000F9fW-2QQr;
	Wed, 03 Jun 2026 13:14:19 +0000
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUlQH-0000000F9ee-1pzy
	for kexec@lists.infradead.org;
	Wed, 03 Jun 2026 13:14:18 +0000
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-963a7e48493so3474829241.1
        for <kexec@lists.infradead.org>; Wed, 03 Jun 2026 06:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780492456; x=1781097256; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kWWOyRVkIQyqU9zRXKt0slwdKJEKJSUvWbXeFvGOZWI=;
        b=hjSW4F08wIGZ/ExBDy8TbvK2OiVxq2p3A/Rw/N8pJZBdttP4uwIva+QARVZBXGqTBD
         qzxX/OOvnnyE0gZoXnCGfrRGOOrDqOTVc47dFpEAwLt+l0lfVbhlr6MP0Bun5FpNIMQE
         oNe/ReDPNuQslZD4Lz/qeSaPlawYVjFN0MS+if30UlX9/emsid7QhWhzlqzHfQApUBar
         EeMKAmxiUhNZPNehNS3jX6YgKqxhzETUjAXfa6payXfcZjsIBMrhsM8lTC3V3CvvEO/F
         WnNgnPZ1K0cOLc/ZDJEXQwjDGa3tk6dnU4oXjTQ9GF9myac625/rLzn8IVoqSHp5ISVZ
         hZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780492456; x=1781097256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWWOyRVkIQyqU9zRXKt0slwdKJEKJSUvWbXeFvGOZWI=;
        b=EXpl92nw/Vh0PLz15d+ehys1+q5lHkqDZvEKYfjWCi6twOFXl33xIRo5lD0KBQBKzL
         riCMkUQlxzfXOY0pcknB6ULNjhBUP6LekJdQHolz1m6mfSyG3wYAu4Qu5KTfNf3dFRec
         /4ZnVyKP4Ywxh64bUP7uSs/7fmPfhZJuv6+PlhC7dpPtGNxw3+FBhfVeTXLYiR7VSeuV
         Ak5HHEouq5m6jSc3ZRWq6YVTvMgRu24EN1e1Q9NV6JjWMujne1h3qOZ+U4/tlY0iuXt2
         pLg5pY/qjTjHpFTk76zP47T/WEO8RVxS+ltkc+tTvFJ6hNxQYqLS6o5haw6WLuCDpV62
         8vEw==
X-Forwarded-Encrypted: i=1; AFNElJ8HJnEtOT16bmF5AjVPm4VVkq3P+3WCoePovpoc4+CYJHKcWdHo8rdrsfuMkX/ObfLD5HYkRA==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywaqe+WrogAeD0qZPi2zpQkypmhzJ4d/rRrV5FeH3RIBEzENyc6
	tL0KAvLdrDcQW/m8HgJCVDZ2/UWns961SVKZU1tzD6wyNmEK59Kmlq7im0pB4OgJhoQ=
X-Gm-Gg: Acq92OHsaREpI04l3ZX8F/6p9hks2HFWTn9d09os0koYjbtVmXWl63xp8tix+Wf6S8b
	3xbDk23Vj7/NFsjizn7ttTS4E9u2C7qnq6lOlsi3N5+CgEvGo4RIuTLKETMxGs3mfvFTnItPSCB
	RJ/RV2HkBKeD/5cgtI2m06jIiELllfyv4b80IEM6L0kcyRoqS5UB5SXZ9QQmHd0kPBT8EKq+wrp
	9SegVzolIocwHS8E+EzePWi94svJ3sdY6LLyw2vSdLiwRtpvAmAt706Yy1VPUsk98d2Y2t9qgt0
	0T5m3lNMEYpHLO4I9/vUN6RvtEmNZbFX9xmbyMtvy4qTK7pIgNMSgvwHB84x3SVqhtibINTfzPq
	Fa8vGIb5Y6gafA+pk1ZojNC8z8y1/18n7p2gLzmbMgL5yPowziquozCxsiosITU/zkX4ae2bzW7
	MYEuSpmJqrinvNaaIRQXBt6fgsreBTy9iWZqgITRQ2KJ8RXe0zpO6v2IY8H4+mQw==
X-Received: by 2002:a05:6102:54a6:b0:643:80f1:350a with SMTP id ada2fe7eead31-6ec2b555e2emr1690019137.2.1780492453260;
        Wed, 03 Jun 2026 06:14:13 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a3bf5f9sm237499985a.35.2026.06.03.06.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 06:14:12 -0700 (PDT)
Date: Wed, 3 Jun 2026 13:14:11 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Michal Clapinski <mclapinski@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, kexec@lists.infradead.org
Subject: Re: [PATCH v2] kexec_file: skip checksum verification when safe
Message-ID: <aiAoiWIsVUz7Whnx@plex>
References: <20260602123311.1841746-1-mclapinski@google.com>
 <2vxzik81dlbu.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzik81dlbu.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260603_061417_500330_5DA7DF02 
X-CRM114-Status: GOOD (  54.41  )
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

On 06-02 17:16, Pratyush Yadav wrote:
> On Tue, Jun 02 2026, Michal Clapinski wrote:
> 
> > Checksum verification is needed
> > 1. for crash kernels. In a crash, we can't be sure the kernel is
> >    intact.
> > 2. if we're worried about relocating the kernel into a region used by
> >    some DMA that wasn't properly cancelled.
> >
> > If KHO is enabled then relocations will happen to KHO scratch, which
> > is free from DMA regions.
> > If we used CMA to allocate segments then relocations are not going to
> > happen at all.
> > Therefore, we can safely disable checksum verification in both of those
> > cases.
> >
> > Instead of adding a new variable to purgatory, just skip adding regions
> > and save the default value of SHA256 hash.
> >
> > Saves ~250ms on my 4.0 GHz CPU. This is an important saving for the
> > live-update project.
> >
> > Signed-off-by: Michal Clapinski <mclapinski@google.com>
> > ---
> > v2:
> > - also skip checksum verification if KHO is enabled
> > - small fixes from reviews
> >
> > My original idea was to do 2 changes:
> > 1. Skip checksum if all segments are CMA.
> > 2. If KHO is enabled, allocate the kernel inside kho_scratch using CMA.
> >
> > This way we could skip both relocations and checksum verification when
> > KHO is enabled.
> > But I realized that step 2 might not be possible on warm boots.
> 
> AFAIU we only relocate into scratch since relocating anywhere else might
> over-write preserved memory. If there is no relocation, there is no need
> for the kernel image to be in scratch, since the image won't be
> preserved memory anyway.
> 
> So perhaps we can just use CMA directly, and only fall back to
> kho_locate_mem_hole() if that fails? This should be a simple enough
> change.
> 
> Do you know how much time we can save by skipping relocations? I would
> guess it is in the hundreds of milliseconds.
> 
> Can you try this (COMPLETELY UNTESTED) patch out and see if it works and
> if it further improves kexec time?
> 
> --- 8< ---
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 2bfbb2d144e6..0ccc7b6d67c1 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -720,14 +720,6 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
>  	if (kbuf->mem != KEXEC_BUF_MEM_UNKNOWN)
>  		return 0;
>  
> -	/*
> -	 * If KHO is active, only use KHO scratch memory. All other memory
> -	 * could potentially be handed over.
> -	 */
> -	ret = kho_locate_mem_hole(kbuf, locate_mem_hole_callback);
> -	if (ret <= 0)
> -		return ret;
> -
>  	/*
>  	 * Try to find a free physically contiguous block of memory first. With that, we
>  	 * can avoid any copying at kexec time.
> @@ -735,6 +727,14 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
>  	if (!kexec_alloc_contig(kbuf))
>  		return 0;
>  
> +	/*
> +	 * If KHO is active and relocations are to be done,, only use KHO
> +	 * scratch memory. All other memory could potentially be handed over.
> +	 */
> +	ret = kho_locate_mem_hole(kbuf, locate_mem_hole_callback);
> +	if (ret <= 0)
> +		return ret;
> +
>  	if (!IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK))
>  		ret = kexec_walk_resources(kbuf, locate_mem_hole_callback);
>  	else
> --- >8 ---
> 
> Of course this is not directly related to this patch so it shouldn't
> block it, but I reckon we might be able to squeeze a bit more
> performance out this way as a follow up.
> 
> > I have no idea how to fix that (except weird ideas like 2 kho_scratches
> > that we swap on every warm boot), so I decided to just skip checksum
> > verification when KHO is enabled. This unfortunately means relocations
> > will still happen.
> > ---
> >  kernel/kexec_file.c | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index 2bfbb2d144e6..db25a14692ab 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/syscalls.h>
> >  #include <linux/vmalloc.h>
> >  #include <linux/dma-map-ops.h>
> > +#include <linux/kexec_handover.h>
> >  #include "kexec_internal.h"
> >  
> >  #ifdef CONFIG_KEXEC_SIG
> > @@ -798,6 +799,16 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
> >  	return 0;
> >  }
> >  
> > +static bool kexec_only_cma_segments(struct kimage *image)
> > +{
> > +	for (int i = 0; i < image->nr_segments; i++) {
> > +		if (!image->segment_cma[i])
> > +			return false;
> > +	}
> > +
> > +	return true;
> > +}
> > +
> >  /* Calculate and store the digest of segments */
> >  static int kexec_calculate_store_digests(struct kimage *image)
> >  {
> > @@ -822,6 +833,21 @@ static int kexec_calculate_store_digests(struct kimage *image)
> >  
> >  	sha256_init(&sctx);
> >  
> > +	/*
> > +	 * If KHO is enabled, the destinations are located in KHO scratch.
> > +	 * KHO scratch can only contain early boot allocations and movable
> > +	 * allocations. That means there is no risk of memory corruption by
> > +	 * uncancelled DMA.
> > +	 *
> > +	 * If all segments were loaded into contiguous memory, there will be no
> > +	 * relocations at all, so also no risk no corruption.
> 
> Typo: "so also no risk *of* corruption".

Missed this fix when applied forced updated, to address this.

> 
> We can fix that up when applying I think, so no need for a v3 just for
> this.
> 
> Other than this,
> 
> Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> 
> > +	 */
> > +	if (image->type != KEXEC_TYPE_CRASH &&
> > +	    (kho_is_enabled() || kexec_only_cma_segments(image))) {
> > +		pr_debug("disabling checksum verification in purgatory\n");
> > +		goto skip_checksum;
> > +	}
> > +
> >  	for (j = i = 0; i < image->nr_segments; i++) {
> >  		struct kexec_segment *ksegment;
> >  
> > @@ -867,6 +893,7 @@ static int kexec_calculate_store_digests(struct kimage *image)
> >  		j++;
> >  	}
> >  
> > +skip_checksum:
> >  	sha256_final(&sctx, digest);
> >  
> >  	ret = kexec_purgatory_get_set_symbol(image, "purgatory_sha_regions",
> 
> -- 
> Regards,
> Pratyush Yadav

