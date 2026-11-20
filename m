Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D94B60A260C
	for <kexec@archiver.kernel.org>; Fri, 20 Nov 2026 08:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lzCuzNld;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LrXi9y8X
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=YrezAQ7e02vT8+Swx+rmAAedFzytCEs8zwyhSyPMrmg=; b=lzCuzNldjQzo2/
	EjPhLqlmTkl+R25d98ZudLCqbZnftYi1IVPEDZ40wGaVXvPbsqyWR0I2WDQTIopdI5vJd8lryBvQc
	cUt4lLEkTK41xgctRr5dOs6u9/seyOwStmRTI9AyG3faHuyrGZ1p/fq1xn+s8hpDyM/DlB4KqLtlc
	fm1VujjFpQoKEi1QZXyB68ggmyrJWpjokoG1G5JNgcgFlbhD3+ROfxG9MvuWcWdWEee2Bc4Bkuq7p
	LU0+7MycnbOupBR3p1GV0Blpkyz+9VAzbWsS9zYq1VCGIwq3t5ZCTsbV7JpDDFnk+tcqUmxfcGcGN
	TtzSHH1WSLH8S5XENmfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUJr0-0000000EJqc-43ud;
	Fri, 20 Nov 2026 08:20:18 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUJqz-0000000EJqU-1jxz
	for kexec@lists.infradead.org;
	Fri, 20 Nov 2026 08:20:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EC4E9410FF
	for <kexec@lists.infradead.org>; Fri, 20 Nov 2026 08:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2111F000C6
	for <kexec@lists.infradead.org>; Fri, 20 Nov 2026 08:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795162816;
	bh=YrezAQ7e02vT8+Swx+rmAAedFzytCEs8zwyhSyPMrmg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=LrXi9y8X8jjdE6yEgzJwcgu1p/UOdN7422Y+PduJ7Jxvv8AvYxo/zOir+iF8nLXpQ
	 Bkrxa51bADXUuwK97jo82FLdKcYZFq6ZEoQhKTFyk5X91tOkJVoTpv55aLahVARV2M
	 PntYTTvtYpKL5EuTFZcOPrcPN2rAAf4XaT9BkfVbTJYXcE8oizzpzG+3jxR4jK1OWq
	 4X7Lk5xyXAQpx2QJAsfnQ8EsjYD7UeZT3q0CAkm/gotPlAiEmkqkU0GWN2Y1e0sYSv
	 wF9XcfoLYPsKIXJ3jDeZpiAeQ0xvv0ZwDgkmv9diOYcxRviZNkwgSG3OmhFI7p30fC
	 pv7pwvkf3GnGQ==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6ba1e22ff4dso704388a12.2
        for <kexec@lists.infradead.org>; Fri, 20 Nov 2026 00:20:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGMRtgMCN9Ugav3unEPpPj6Fb8Sf7T5H2pCLcFSE3nycpl96S325gXJz2VazY8/3eWU8GJvvA==@lists.infradead.org
X-Gm-Message-State: APuU4Z82qslr0CyHITjh7RAQS6kGdqCBslaDTEYKFlD55oGoiAo7tr/H
	PiSdG+Sval8NsljVWm9102k+gikoBsLWO0TJpU6FlIyRkIgW1QbM1JHv8jBUdD2py1ayTy5rmuN
	HmcqpjyfLJuGz2g09xNhJt01pwgJ3YBo=
X-Received: by 2002:a05:6402:3608:b0:6b8:77ad:62e8 with SMTP id
 4fb4d7f45d1cf-6ba37ee17c3mr1286897a12.44.1795162815520; Fri, 20 Nov 2026
 00:20:15 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029172956.20791-1-dongtai.guo@linux.dev> <20261029172956.20791-4-dongtai.guo@linux.dev>
In-Reply-To: <20261029172956.20791-4-dongtai.guo@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 20 Nov 2026 16:20:06 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4A8gYGEMkbPk6MEkjLtdEe4OFwBUkERvdpXjiXfriuZw@mail.gmail.com>
X-Gm-Features: AclHuK-h6bybNetTU_MMXuMJwO3eew7bSt_laDSgKQt1od1cbyCQa8XfhqZT6Vs
Message-ID: <CAAhV-H4A8gYGEMkbPk6MEkjLtdEe4OFwBUkERvdpXjiXfriuZw@mail.gmail.com>
Subject: Re: [PATCH v6 3/8] kho: Include linux/mm.h in kho_block.c
To: George Guo <dongtai.guo@linux.dev>
Cc: rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, 
	ardb@kernel.org, shuah@kernel.org, ilias.apalodimas@linaro.org, 
	akpm@linux-foundation.org, baoquan.he@linux.dev, ruirui.yang@linux.dev, 
	guodongtai@kylinos.cn, kernel@xen0n.name, graf@amazon.com, 
	liukexin@kylinos.cn, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I have applied this one as a preparation for others.

Huacai

On Fri, Oct 30, 2026 at 1:30=E2=80=AFAM George Guo <dongtai.guo@linux.dev> =
wrote:
>
> From: George Guo <guodongtai@kylinos.cn>
>
> kho_block.c calls virt_to_phys() and phys_to_virt(). With CONFIG_KFENCE=
=3Dy,
> the LoongArch implementations use offset_in_page() and page_address(),
> which are provided by <linux/mm.h>.
>
> Include <linux/mm.h> explicitly to avoid implicit-declaration build
> errors for these helpers.
>
> Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
> Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---
>  kernel/liveupdate/kho_block.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/liveupdate/kho_block.c b/kernel/liveupdate/kho_block.=
c
> index 0d2a342ef422..0d56891b2f4c 100644
> --- a/kernel/liveupdate/kho_block.c
> +++ b/kernel/liveupdate/kho_block.c
> @@ -25,6 +25,7 @@
>  #include <linux/kho/abi/block.h>
>  #include <linux/kho_block.h>
>  #include <linux/slab.h>
> +#include <linux/mm.h>
>
>  /*
>   * Safeguard limit for the number of serialization blocks. This is used =
to
> --
> 2.53.0
>

