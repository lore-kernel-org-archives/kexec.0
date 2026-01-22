Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A56D6CFA1
	for <kexec@archiver.kernel.org>; Thu, 22 Jan 2026 19:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7uFuZoZJrwPWm069b7Zxl5WdE9K+cZvS9QdYX8aCTtE=; b=KV3tmygslwPCuBsDe9/x++3Tji
	tS84Nd7AUPf3J8HBY1xWlJk2V4Ugb4ryE5M786o1aEMU1Q8M6hwuMExmd30bfZ/D+TvlePDHC4NFe
	XWYWg1H4WqEQ6HZdEMczBX+cfKjneaNJZbE70eNIwEEDo/f1j+gb7OHnqAqWCsc+WOdMCTXvSpbMw
	0+7CfGz0rzgrYgm5eVcuCOPo4ZUT7odq2XFzZQnrLSY+ddx8qk+30NYQQH6udszdnvTPKK3arKueO
	M/agWKabadkd6pmTX9yYhHXHX1cHx73jbcILDc1AjMNPMuj7kxqVI7kCGTjoMOrM8gfxmsVUoN7Si
	c4vfEyUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vj03g-00000007gPl-0aVi;
	Thu, 22 Jan 2026 19:09:32 +0000
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vj03d-00000007gPQ-3kOl
	for kexec@lists.infradead.org;
	Thu, 22 Jan 2026 19:09:31 +0000
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-6581234d208so2642310a12.3
        for <kexec@lists.infradead.org>; Thu, 22 Jan 2026 11:09:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769108968; cv=none;
        d=google.com; s=arc-20240605;
        b=YLdxQusaoLJZPvMUEYMdLO/BvInuCl5ThazJq6fmnCVWyxCSK2TowHqkim4cWxxRGz
         RjXnC9Hx06TnU20csRE5tKRB0ake4S124aJFL70gioeAR3Q3ZE2KhKmm+kdsxNjaIKse
         GhgyaktvlHO/L0Ay+oyrpqbWiaGmIHeKX++37Wz4a3vmJG4zDoxA/AgSXgkBkP65p6Eu
         W1f7Mr50q68AXnJpOYwoIK5HwlESmuRBBs8X1rZbuDgR/DCFwKpeWNZzMvUyyPcAO+Zx
         FolYx5OUhnnfKM3GwzUVrP8d9gCbnQYX/04+JsL+dPqvrNnGkU4axoWxKEOaXarKH9rt
         ccbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7uFuZoZJrwPWm069b7Zxl5WdE9K+cZvS9QdYX8aCTtE=;
        fh=0rBziEew2U7waN3XuclDEib+H4qf93svkeaxEJNN8s4=;
        b=KrwcWECIksB+sfsPJmUk3iPBM/WAC/SK7DmlRm/WxWG+p6MtL3oR5GNUSgGVdvviuq
         fSDyViJK5Z2XmOKj8IBpMVJLG0bcnmP9+xu5unZsH4NvYtd5zgL9f8ckzuTLYER7SPwm
         Bx5CTtUgY0GPZyyD02+UQ0lJWzoFeALDkl5Hfw+LTs/hRze0XaAe5ectPJL6K6TWh8Yw
         BFWpPMjaCmv4o/g29YCvqym7k6YGkmryzkw//JJCcwomea/EkrhNd+SbKk3trT4N0FXO
         1tTwO3gGBlYrDJDIVZUq2prnFHU3aAeaETOyP3Rovqe1F34PKLRoRO0YGEAFzx84EqhY
         rl+Q==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1769108968; x=1769713768; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7uFuZoZJrwPWm069b7Zxl5WdE9K+cZvS9QdYX8aCTtE=;
        b=WM1DvCGb9h0+kieuBpDvdnySGCDDL1RCSqiuLhmrO6W4qzcHYZt/q4cLK1rajfcJvF
         HqxzPYMF5VyJ8O9O88C0e57/g+vfqndyqA2G/3gZt0SAB1N7+wAr2GjFaX7CUSvfTNIP
         IT35BQFDst5/SUjrMnJyXuJEdjyhRex60yIuozJ1fMjvp8kOgSZdFUdBz1wCw4G06qCX
         DER2Vjz9zvgjSeQxxqPXJn+zk6Frac2dwacMQCfaimhH/Uyci3lDDa35pD7vtTdkIYFR
         iY16ioywszh0dtO4wlAabXrYFXZUKqyyn9QZlHklQ/PWYVcoBJYWLXfgkeUEJ7Uo9Rfi
         r1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769108968; x=1769713768;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7uFuZoZJrwPWm069b7Zxl5WdE9K+cZvS9QdYX8aCTtE=;
        b=vWQ+CZYTo/ltpByRuSJjuDotriUF0yGqvzDLZ/BdZacaGenZND/z3ujKWZiheb7HFh
         RJZXOGCodwis9qBzxz+2Ol0fnH4U4HcPXFTQDoC7vO4IiaXT8pBnUDm5gHkb0Tby0BHa
         crDdtr67NJ5/b2lsFNCgSdx4RnTfte/Cdx9zmQCO/QeLoI4nhmDDvFH7oJ8bbqXwJQjF
         FLBpOLIMfDvb3MYEk2MEHCdGJfr1HfFXVwXOk77PTIkBDZj+NsiDRvN0uxJZxLXwBY2T
         WFdyOep7DMe/PuGyywqXhsjdVdt/0Nplwm8RhjmFd4keM1axJw9atjCzS1NpTlWezsBS
         f5TA==
X-Forwarded-Encrypted: i=1; AJvYcCVqZ953MofxUbZu2S+z6FqRaNY+rsr8bZuTfNEnnI0tkmDCDtw6PYiC1MD2eC4u+TuEzvs8pw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw+fhMkGP341PwZFpKL3eRYP9Y89YPigefzoRUDoIuYYdQIghqD
	7QYGZwriBj4Dio/cZmTRLi9FV2fInARHAO8Ay8GMj9ti1sPeuFhsZ/rMwRjCZW7B8WPUbFE04xU
	IpCm0vsT/D0ZGbGGFrUskt20+cyH9R64CkgScGb/wTg==
X-Gm-Gg: AZuq6aKXj8ic7VsJBci33bcYrIs2SJEur7P1vD+LYos7OK2AX0trvMe5tg5GTZD4KrY
	nX5mCxZF8Cgvx0yjw2JuYzEDDJz0bxllNmkLps8OVsT0WJ8e+se0DmTT6tbGLTn04ra/ml0PPPz
	zfPfapuWYMcwThSuwD+kMKZ9GAvsXKR8IjqcqgP5CfjmTBX+QcOPAnd0gkTScaSAYl4TAGQV3dT
	ccO05bRGhbrKzziZ8mzaLfVyzb5dN4P/rUPx2WaLoaxMuaBEBm0Q2m12AjtBAW75SxM60bT1B8K
	D+YQ1Ukr3DU9Js/pUyiv4AlMVA==
X-Received: by 2002:a05:6402:1e91:b0:64b:bb79:96a8 with SMTP id
 4fb4d7f45d1cf-6584874e5cdmr458412a12.3.1769108967947; Thu, 22 Jan 2026
 11:09:27 -0800 (PST)
MIME-Version: 1.0
References: <20260116112217.915803-1-pratyush@kernel.org> <20260116112217.915803-2-pratyush@kernel.org>
In-Reply-To: <20260116112217.915803-2-pratyush@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 22 Jan 2026 14:08:51 -0500
X-Gm-Features: AZwV_Qh1xgpWqyDuNv5Xd0XNYx9RNx5Okc3zvyw-nwyeS0nxuHtmcgoGkJDkvlo
Message-ID: <CA+CK2bAsGHDQGm7t43MPTS7jCSHVdfvyTZ3Oj2Qnx6G=8N-P-g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kho: use unsigned long for nr_pages
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Graf <graf@amazon.com>, 
	Mike Rapoport <rppt@kernel.org>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260122_110929_952991_63B402DB 
X-CRM114-Status: GOOD (  11.57  )
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

> @@ -222,7 +222,8 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
>  static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
>  {
>         struct page *page = pfn_to_online_page(PHYS_PFN(phys));
> -       unsigned int nr_pages, ref_cnt;
> +       unsigned long nr_pages;
> +       unsigned int ref_cnt;
>         union kho_page_info info;
>
>         if (!page)
> @@ -249,7 +250,7 @@ static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
>          * count of 1
>          */
>         ref_cnt = is_folio ? 0 : 1;
> -       for (unsigned int i = 1; i < nr_pages; i++)
> +       for (unsigned long i = 1; i < nr_pages; i++)
>                 set_page_count(page + i, ref_cnt);
>
>         if (is_folio && info.order)
> @@ -283,7 +284,7 @@ EXPORT_SYMBOL_GPL(kho_restore_folio);
>   *
>   * Return: 0 on success, error code on failure
>   */
> -struct page *kho_restore_pages(phys_addr_t phys, unsigned int nr_pages)
> +struct page *kho_restore_pages(phys_addr_t phys, unsigned long nr_pages)
>  {
>         const unsigned long start_pfn = PHYS_PFN(phys);
>         const unsigned long end_pfn = start_pfn + nr_pages;
> @@ -829,7 +830,7 @@ EXPORT_SYMBOL_GPL(kho_unpreserve_folio);
>   *
>   * Return: 0 on success, error code on failure
>   */
> -int kho_preserve_pages(struct page *page, unsigned int nr_pages)
> +int kho_preserve_pages(struct page *page, unsigned long nr_pages)
>  {
>         struct kho_mem_track *track = &kho_out.track;
>         const unsigned long start_pfn = page_to_pfn(page);
> @@ -873,7 +874,7 @@ EXPORT_SYMBOL_GPL(kho_preserve_pages);
>   * kho_preserve_pages() call. Unpreserving arbitrary sub-ranges of larger
>   * preserved blocks is not supported.
>   */
> -void kho_unpreserve_pages(struct page *page, unsigned int nr_pages)
> +void kho_unpreserve_pages(struct page *page, unsigned long nr_pages)

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

