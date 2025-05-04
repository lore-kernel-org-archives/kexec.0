Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450B4C369DC
	for <kexec@archiver.kernel.org>; Sun,  4 May 2025 09:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uc3Kn65NlGZx2VlgrWqWslranmq8/6fIBXmlcxFGFLU=; b=aditNu1XQTPdPAOpCuYplI4+xI
	C3Fk+Z35xcJw+5vLyXAhYkMKw3a20TPRKWLJTfjxjKoY9461SzxwdbB/w7+IZniraE2pZts83Q37e
	ve33LPy5x9DYfmjNFo4LoqK5Bq7pqHcEna9V4Fm/4jzO8iGGc6D+8Uu3cr6VRSG+SBjZpWS6/uBmg
	wEfyBFarWj2pFceMv+AoRkkrVAJFJxsCPIGrBYDRTmTYEggT3+blvxUUNf7NKU2KngzZWXJ7r5YfE
	TO+tub+aeaFOf67a9lMDr33WsE+qucivSvm1LtFa3y60GcXITA93gwPRprzBfrcqkZCIyIeCHsoxH
	xyQeQrFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBVXL-0000000560z-1few;
	Sun, 04 May 2025 09:21:27 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBVXI-0000000560K-2KXy
	for kexec@lists.infradead.org;
	Sun, 04 May 2025 09:21:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 538A649D9B;
	Sun,  4 May 2025 09:21:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B48C4CEE7;
	Sun,  4 May 2025 09:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746350483;
	bh=ax8+aRdxPyEaO+MlNJoulX1KawP6Rs1aBWyJrGcNdL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i+QS6DPY9q4fhLxirBHWrjszL2aPuk5iebh+Hj9bxIeszCWrtxnwRvbcrGsmvznX3
	 4kkFRyl+tREe3pUrNNsQmCU3zaTOwzw2wfKgHXe5b2pXlUTqHPSUsqAl7cPU3WGMxT
	 Qn9mKC4U4+q0YnPLAbth71mQdTCAu2kGlUwqxcE5OaWjUaiC0hih1QmzeQLNl5PpUe
	 bQhXPfrpFaPOTJEoPfRul+hdI/eT4ooYFWB4BpdngZeVM/6eZxTAsz4WkvBO3EXMlv
	 vqoKoUT0E/qdxT7d66pSTZpqPKCWoz+WXH59pV1ZKnbAPykVhjx9JYlutXWmk4HgVm
	 1pI9LATlp6LHw==
Date: Sun, 4 May 2025 11:21:18 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, bp@alien8.de, thomas.lendacky@amd.com,
	hpa@zytor.com, michael.roth@amd.com, nikunj@amd.com,
	seanjc@google.com, ardb@kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH v4] x86/sev: Fix making shared pages private during kdump
Message-ID: <aBcxjsdC4tsIgIf2@gmail.com>
References: <20250502212143.578866-1-Ashish.Kalra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502212143.578866-1-Ashish.Kalra@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250504_022124_606190_DACF2D3B 
X-CRM114-Status: GOOD (  13.88  )
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


* Ashish Kalra <Ashish.Kalra@amd.com> wrote:

>  
> -			if (addr <= ghcb && ghcb <= addr + size) {
> +			/* Handle the case of a huge page containing the GHCB page */
> +			if (addr <= ghcb && ghcb < addr + size) {
>  				skipped_addr = true;
>  				break;
>  			}
> @@ -1131,9 +1132,8 @@ static void shutdown_all_aps(void)
>  void snp_kexec_finish(void)
>  {
>  	struct sev_es_runtime_data *data;
> +	unsigned long size, mask, ghcb;
>  	unsigned int level, cpu;
> -	unsigned long size;
> -	struct ghcb *ghcb;

So this patch just morphs the type of 'ghcb' from a typed pointer to 
unsigned long, while most 'ghcb' uses in coco/ are typed pointers?

That's just sloppy and fragile. Please just keep 'ghcb' a typed 
pointer, and introduce *another* variable for the virtual address to 
the hugepage.

>  	pte_t *pte;
>  
>  	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
> @@ -1157,11 +1157,14 @@ void snp_kexec_finish(void)
>  
>  	for_each_possible_cpu(cpu) {
>  		data = per_cpu(runtime_data, cpu);
> -		ghcb = &data->ghcb_page;
> -		pte = lookup_address((unsigned long)ghcb, &level);
> +		ghcb = (unsigned long)&data->ghcb_page;

If 'ghcb' has the proper type then this ugly forced type-cast goes 
away.

> +		pte = lookup_address(ghcb, &level);
>  		size = page_level_size(level);
> +		mask = page_level_mask(level);
> +		/* Handle the case of a huge page containing the GHCB page */
> +		ghcb &= mask;

This too calls for using a separate variable for this, because after 
this masking 'ghcb' is very much *not* the location of a GHCB page 
anymore...

>  		set_pte_enc(pte, level, (void *)ghcb);
> -		snp_set_memory_private((unsigned long)ghcb, (size / PAGE_SIZE));
> +		snp_set_memory_private(ghcb, (size / PAGE_SIZE));

Do we know whether this is safe? Could the huge page around the GHCB 
page contain anything else? What is the structure of this memory area, 
is it all dedicated to the GHCB, or could it contain random other data?

Thanks,

	Ingo

