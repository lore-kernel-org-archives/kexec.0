Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C0D7FF886F
	for <kexec@archiver.kernel.org>; Tue, 28 Apr 2026 18:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R3M+7gJof61EOtWpKtFggB01XLLEKa7ExSlZp9Q9oOA=; b=jErURT381ZmfY/5aE8sss+1wCc
	MyvTbwl9YdaYEEiuiYDPQEIxnZwkU9Fz2JUqlADq1c1DRINpDBhP2ZqUvM7JvhreYMBHfzLyhx7VR
	TLUF4jngsG4wfmDJJ17gzryDTJhXcOwatpQrcmmaF3HHRqACGsO8GKHBF+LZrPOHWevfd36V1PxCj
	5G+ghwe2EXOdr+4tse1m3hHeAtQNmCbvJdXLRbjrZpy47jDgXXg6xWYBkTklW8OqDtGemHG8ZhxfP
	cKlu9cB068XXogZk4e8PfwUoDG2E8LqDLf9j5EGcQY9ecqQ9LVHtN0Rw0ErNi2u0rV64JYivYo4C/
	znWU7ohg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHmnU-000000023Rf-3UYx;
	Tue, 28 Apr 2026 18:04:36 +0000
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHmnS-000000023RB-1kY4
	for kexec@lists.infradead.org;
	Tue, 28 Apr 2026 18:04:35 +0000
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-8f231f3b130so394447085a.3
        for <kexec@lists.infradead.org>; Tue, 28 Apr 2026 11:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1777399473; x=1778004273; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R3M+7gJof61EOtWpKtFggB01XLLEKa7ExSlZp9Q9oOA=;
        b=jWVfE3zuYLzM0Z7bBBO2PLSJrvsVhQecu+6NpTRu1p6kn3jC3MrLn6dBg12h+a9pH4
         MxeEfx3D9GEn7jdASgBupxoPBuZSoI7nxvJyHb688aj+fsD3hGIan/7fy8RJ6IJiH/QN
         5PRsBUliAIWDMc/32fb7Ky2l4WrzL4rkTd+SOxcljoKgFMwISaLORAbexyWNLuJXfkvG
         JgSlzQDgU4lw3z00xQPIm/awjqpXNK66jFILsCc3wFne7095KUmvCn9mzmHF5SVFjG+b
         L6Vlz5/z+DXDg0JDE9k6HtRJ3cPPozG3nUGN8ooQbYCQ2LRPhz+R4cihIT8FMUaAdTDB
         +JaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777399473; x=1778004273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R3M+7gJof61EOtWpKtFggB01XLLEKa7ExSlZp9Q9oOA=;
        b=nO6GKzuTzvEHr1y6g9nb9WfngQvoQZfiSReKSoEXUFK26kPaAz9bVClerU4/k5Qvl9
         iGo5iLUy6geTyWvRGjTF0zzFtoYzRkV1+adppL7UvAvEWrHQUvXgyqlrgikoXa95AOur
         8aPiNQ1ZqrYwgyoMg1e00WnCJQ1Dx953boMh6lOl4c0X7pCC9YErN0AqyVwMuqAe5bgk
         9auKWmecI9C8FP4/faAieo2MfC9cqf2X+6o8HtIZVzpHkcJTTzvIHo8KfmTyxhInmZw5
         IsJ09XqjZUyN1Virof4npzAkrnfpHMdkU/HCrvdq+LzsEBg+6nrdRVltR3KlfXbnjnir
         UrWw==
X-Forwarded-Encrypted: i=1; AFNElJ8Pnto776UaUg4gHeUigjiYJomArLCg+6HcmosQ3pdOZ/IV0HmsZPMBZvWm8ENJIZwlIgB3EA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxkfOdVNOQSHhct1kH+4joJK1K+gBwBuDmy7Q9k6Ha9JpMng9aA
	crCPZG7ZGvleSMvfcE7c/MT74ewqldoWKnfllpEjuGhFgX9OIppJazFAM15H+PPIB6U=
X-Gm-Gg: AeBDietTaOqluUZAUQhTjWunR/BFNOk8jvYoo0aKQRfxBj4uCXh8f0hk7Jvwd61xZUs
	JsK79InoHCLAk+QKnikpGvE1M9SmoyWr6B2xnxqwvQghLegLXYFmfv3+p1iNOdkm1swRW4uKl8p
	5Kq5EP0oWom7BSrNhvr2IQ95z8YHe39fgraPoNMvbuxM5SWx6ekvfsxy05ydN0GRF2nC4pJG36d
	xXD6kutE7q/giSmldW3SD7nHVebSeB19X78WyhrGpTpmdFuiQV7dRiYw+XQE2v4N5q0ruEoeWtO
	JcV6al+jzgtHezUMA0eiJTAgL2r4O3KE60QNs5nZBo4rFUR+fEwwP8rRYDcUzb3cA9gq9NElEuO
	BoMgCQ6vfcjB0joXdf2hvVrF2KAf46ZvUEX8F1uhD/wqsud5A8SVlMsFx1BpvExodYnIFebQbE7
	eyPlzPVXy4JCTR8X3eGo7kjshuVlRdX7EsHWKgnqpEmLMGbLytd5yG42fEaL4xcA==
X-Received: by 2002:a05:620a:2a04:b0:8ed:e1d4:1641 with SMTP id af79cd13be357-8f8f3534105mr110001485a.11.1777399472714;
        Tue, 28 Apr 2026 11:04:32 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f7c49c3fefsm263324485a.10.2026.04.28.11.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 11:04:32 -0700 (PDT)
Date: Tue, 28 Apr 2026 18:04:31 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <baoquan.he@linux.dev>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Dave Young <ruirui.yang@linux.dev>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] MAINTAINERS: add tree for KDUMP and KEXEC
Message-ID: <afD2loFzcfAJODOw@plex>
References: <20260428124833.1903302-1-rppt@kernel.org>
 <20260428124833.1903302-2-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428124833.1903302-2-rppt@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260428_110434_457055_23CDE04E 
X-CRM114-Status: GOOD (  14.77  )
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

On 04-28 15:48, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> KHO and LiveUpdate team is going to pick kdump and kexec patches to
> their tree at
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
> 
> Update MAINTAINERS to reflect it.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com> 

> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2fb1c75afd16..2685cbf89b5e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13861,6 +13861,7 @@ R:	Dave Young <ruirui.yang@linux.dev>
>  L:	kexec@lists.infradead.org
>  S:	Maintained
>  W:	http://lse.sourceforge.net/kdump/
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
>  F:	Documentation/admin-guide/kdump/
>  F:	fs/proc/vmcore.c
>  F:	include/linux/crash_core.h
> @@ -14177,6 +14178,7 @@ M:	Pasha Tatashin <pasha.tatashin@soleen.com>
>  M:	Pratyush Yadav <pratyush@kernel.org>
>  L:	kexec@lists.infradead.org
>  W:	http://kernel.org/pub/linux/utils/kernel/kexec/
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
>  F:	include/linux/kexec.h
>  F:	include/uapi/linux/kexec.h
>  F:	kernel/kexec*
> -- 
> 2.53.0
> 

