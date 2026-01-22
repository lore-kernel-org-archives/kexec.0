Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3741FD6CFA2
	for <kexec@archiver.kernel.org>; Thu, 22 Jan 2026 19:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kfAqgxH1582WZq4I3423rt+lWJCsFYGPLOPu6I2/Cdk=; b=ALTvXgvylgwJTuVQOT4V2opMpO
	r5uXS/zGVuw+jNQHIBcntKYPjc0w3Y2ORzzdZroFRK1x4piVqpOJv2jOx4OUCVkyxo3EGauB9gCq6
	e/862aIj9E9MdsgevFptc6vUcRg2Fb4TWD1zxPqGpIckK0+1YfkkQLqNzDACXeRTHVt2yVIuupt7f
	BkDq8ohKtv6w6++h8KE1JRNKBBaUXgd1JLgvgw0lH7CLkRQP7eDnB6uFkhkr9MT9dgwOIk2CLWQ2H
	Z4bP7ay1ahbabT1SOhHrZ0tcfdiKm3ovdDV1Foot5yd7pmDwbnRw9QR5jrdJSGG27fmZ6iXhY9EF1
	nVmo9hJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vj0fy-00000007ii7-0Dvy;
	Thu, 22 Jan 2026 19:49:06 +0000
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vj0fq-00000007ihN-402z
	for kexec@lists.infradead.org;
	Thu, 22 Jan 2026 19:49:01 +0000
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-50299648ae9so48091cf.1
        for <kexec@lists.infradead.org>; Thu, 22 Jan 2026 11:48:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769111336; cv=none;
        d=google.com; s=arc-20240605;
        b=e0mwxoFabL1lGpDMw0KsK1Y8zF7ISWdbKzmf2shnoJCdOMns8o8MiEgalCsvaUyyRp
         tmWO4NsiJzLS54MBoFZ8Ujss2Y9yl8L3O5ijVFftHfJv43CaBSc1SbH9+DUPfx0O13so
         li663L5R3yyeEOjn8L0CDrCtxQPDXU5/sm9kzDF4A9z6876aYlKPHKcFxZ2/N0Ehk7yZ
         IsNfzBWMfbYlE0BEaIAdLiELBbQtZMArU4uvx4E/0AhZL1y0HC1dVpvRo5Mwa536q8BX
         5NMv6++oXMAHVCvfICOtf49nNP0ewCpSVD7ZxCydPdKt8K1wl1OJ8tbX2UELOn5SeQNB
         WqCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kfAqgxH1582WZq4I3423rt+lWJCsFYGPLOPu6I2/Cdk=;
        fh=8lv29zccvnVATGbCBm0bkbnnuMFvdq+eiu6u3GReB1k=;
        b=KxevzQQvepi51igRjS2DnBeXqsjrYBZ0b1qpSPyy/5ftcKSZar8zjiSwxNilfCIZNN
         JeTXD3XtuLot7QsL7+o4LmJ5SbyoQEga7hiF1P8tZNb13cpkGI8lKFHrODdGq3V4lFrE
         61vnL3fWCFmnrerD8Bwc1q5F7wgzoPYIXfv1A7akuUiLVkoBUlc0V2WwXTtwStj2Kicd
         LsRUZBNPRPqn0xZWaB/XsQGndmGbFnrDjylCQX6l6+SZ+Bb1NOX6WmFgFZkiQF3gPMXK
         ajSW7yEG3f6/TxQdQ7tBC1RAdHMzr1ug/3WKgC+kcLYm3Z6d2OkOy9x33Ui3mmxycbbr
         xatQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769111336; x=1769716136; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfAqgxH1582WZq4I3423rt+lWJCsFYGPLOPu6I2/Cdk=;
        b=OpP5w2hIyPWYt0I2Y6d4Qq8pBQz2CoMoePSMg0oqPvcYWqGeTvGZJaeIZNRnEHPITg
         y8gurv1FVlLkx7eqfMPamh/1AmAJHikJ7kF3WokKDI6CpjLldCMyR+jMdTlrTQvDH1Si
         F4XERnCw374/DIXmmCmdtIrCBxoQnHuUY2FWiZbrad1//m+DEcM2WX6anlKOxUQ18oRw
         +NvI7WJ3IqREd0kOKJHHwJJ5dlaDpRsSyap6ZvqemXjah3774+2r6uaeYwn4BlnADtzb
         KTfzXLFSiu0M8/aE71bw4ykW7lJkbze//MmNa1kNZRrKxhj/PkFhJ3y5UXVJ7sdVBUig
         KEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769111336; x=1769716136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kfAqgxH1582WZq4I3423rt+lWJCsFYGPLOPu6I2/Cdk=;
        b=Woi5ahETxeB2Y5djPH293AhJumx3+QQ+rt92PrXGrFCqxuGhqK3Pwk1g62bGDM85zK
         EO05g/v2bsyLqLEhwfp7OvOJQozDl+iGdkkRF7arP2duqaV7okakJ3hnzIdBJw6E9KYm
         ZfSbnEKH++qcYb/oTogJyb7cpbK5U4923xO6/cb4opmM/3untcxYDCfNt7Qc/b/CFWXT
         NWhbKIwhRoYerdAVZh6ZTgqUlz2Xlg94BAulbmTXbI5GEJrFynG16L9dtQ18p8RkDMcM
         jGlGegpYkXsKg5tFPd5aA+yr/F8G6IKY7wVBPOe2dC8rOa+ym7UPIhFOeY4/YxKttgnu
         uhPQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8P2fTGQjtGiX9D0DykUysIU8b1h4PtY53YA50QXrPnMTEmaldPZ4kUP5hXxNdltVHHmKo/g==@lists.infradead.org
X-Gm-Message-State: AOJu0YxOnZB61/BpgG++8/IL3Emgw9EX6X2HtnguK901RbSJGbS704SP
	S401FmlVFoavqw2kYme3H3UU+2pz6XgVOUY2CglKkRksk/YJ8oYciElWO4wFSZo2r7M4zM7IZVH
	ByiLGcfWdBNMhveCSFDR/btkbSMFPAgl4302lFyKW
X-Gm-Gg: AZuq6aJFdQ1RPVXjydGngupI3JVrQ+aB4sjNZXNwQtZgRfj2VVAJLkvr6cWv3t0rkZA
	LBRMYU5yAdQFN18cE7kM9T+xswseUZtkkzi0uEgCDOOP0qtN5BrqEnG9MtpUdhH1JjeaBhKfcqf
	OD5+psavH+9lzSGyyLrjBsuIkafNerpS1B7yjLi1ixcoDfBGFc3uUH9orDn3XzObqWt+VcYEwHK
	DgBGXP4x+E1mE4oYZNHww3KxLGMn8vxM0R4KV3l6D7qMjVDTiYEIV2KLDZHA1qR7KRu/PiwZLd6
	+0uiEDuOOKab3KLK+HdyY6gQAQk8SA==
X-Received: by 2002:a05:622a:52:b0:501:197d:32af with SMTP id
 d75a77b69052e-502f7f431afmr2017041cf.0.1769111335997; Thu, 22 Jan 2026
 11:48:55 -0800 (PST)
MIME-Version: 1.0
References: <20260116165416.1262531-1-pratyush@kernel.org>
In-Reply-To: <20260116165416.1262531-1-pratyush@kernel.org>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Thu, 22 Jan 2026 11:48:44 -0800
X-Gm-Features: AZwV_QgYYDLmHCzfY5_3eVms8MoiUtOZs2iFbsinPGV_5oYeZSyGGaB4IQhOzrs
Message-ID: <CAAywjhTfAU-NH7+Wevp_UxquuJdUNuKvnv_Hzh6GDcFFxC1Bpg@mail.gmail.com>
Subject: Re: [PATCH] kho: print which scratch buffer failed to be reserved
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Graf <graf@amazon.com>, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, kexec@lists.infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Jason Miu <jasonmiu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260122_114859_198262_2E4F3769 
X-CRM114-Status: GOOD (  18.39  )
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

On Fri, Jan 16, 2026 at 8:54=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>
> When scratch area fails to reserve, KHO prints a message indicating
> that. But it doesn't say which scratch failed to allocate. This can be
> useful information for debugging. Even more so when the failure is hard
> to reproduce.
>
> Along with the current message, also print which exact scratch area
> failed to be reserved.
>
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> ---
>  kernel/liveupdate/kexec_handover.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec=
_handover.c
> index 49bf2cecab12..636bd96780ae 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -651,8 +651,10 @@ static void __init kho_reserve_scratch(void)
>         kho_scratch_cnt =3D num_online_nodes() + 2;
>         size =3D kho_scratch_cnt * sizeof(*kho_scratch);
>         kho_scratch =3D memblock_alloc(size, PAGE_SIZE);
> -       if (!kho_scratch)
> +       if (!kho_scratch) {
> +               pr_err("Failed to reserve scratch array\n");
>                 goto err_disable_kho;
> +       }
>
>         /*
>          * reserve scratch area in low memory for lowmem allocations in t=
he
> @@ -661,8 +663,10 @@ static void __init kho_reserve_scratch(void)
>         size =3D scratch_size_lowmem;
>         addr =3D memblock_phys_alloc_range(size, CMA_MIN_ALIGNMENT_BYTES,=
 0,
>                                          ARCH_LOW_ADDRESS_LIMIT);
> -       if (!addr)
> +       if (!addr) {
> +               pr_err("Failed to reserve lowmem scratch buffer\n");
>                 goto err_free_scratch_desc;
> +       }
>
>         kho_scratch[i].addr =3D addr;
>         kho_scratch[i].size =3D size;
> @@ -671,8 +675,10 @@ static void __init kho_reserve_scratch(void)
>         /* reserve large contiguous area for allocations without nid */
>         size =3D scratch_size_global;
>         addr =3D memblock_phys_alloc(size, CMA_MIN_ALIGNMENT_BYTES);
> -       if (!addr)
> +       if (!addr) {
> +               pr_err("Failed to reserve global scratch buffer\n");
>                 goto err_free_scratch_areas;
> +       }
>
>         kho_scratch[i].addr =3D addr;
>         kho_scratch[i].size =3D size;
> @@ -683,8 +689,10 @@ static void __init kho_reserve_scratch(void)
>                 addr =3D memblock_alloc_range_nid(size, CMA_MIN_ALIGNMENT=
_BYTES,
>                                                 0, MEMBLOCK_ALLOC_ACCESSI=
BLE,
>                                                 nid, true);
> -               if (!addr)
> +               if (!addr) {
> +                       pr_err("Failed to reserve nid %d scratch buffer\n=
", nid);
>                         goto err_free_scratch_areas;
> +               }
>
>                 kho_scratch[i].addr =3D addr;
>                 kho_scratch[i].size =3D size;
>
> base-commit: c37fac0551448c68e36f14782acaf662c7a1775e
> --
> 2.52.0.457.g6b5491de43-goog
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Tested-by: Samiullah Khawaja <skhawaja@google.com>

Tested on my test machine while investigating the scratch space
allocation failure.

