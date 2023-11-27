Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C0FC4167B
	for <kexec@archiver.kernel.org>; Mon, 27 Nov 2023 13:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=h4NsBsiAk1JYgGqbvH0oDiZjiWRDqr0WBvEWOCKH0FQ=; b=VUT3Zak/a9MKg3
	wfTtrhHy+aV8Iw8Q9yA0MivdPc4MR38P08wUr4rpBpze9zDwF+83kTNip0ppQ8OQ0hxpJI33CSRxa
	c/nwXOV/srQXOt9N1DOMcIlEiARXNO8Jz/9cbs3u9Hio2mYd28l0w9oKxIFBaA40FLX5h2/Nv018w
	LDe2OQvpr5Fv8RQNcY8tTEL4FfgWhf0oB0Fiqk1dV7HcucyPl6Q3w1pqF5yZCGrN9YHSPgDScPI3B
	+IG8Uqvhz4eW3lX0BFLu+XVkm21WFca9yECjBnoHLi4UlNUXcoDPlSsjd3A4ZQ85UVoCbncFA+GEf
	ZhCXE6pGrlapcPDAT2LQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7bxK-002bdH-34;
	Mon, 27 Nov 2023 13:47:22 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7bxH-002bbW-1h
	for kexec@lists.infradead.org;
	Mon, 27 Nov 2023 13:47:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 87287CE1133;
	Mon, 27 Nov 2023 13:47:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9344EC433C8;
	Mon, 27 Nov 2023 13:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701092835;
	bh=rHyHOAaxNDiEjHeU1uOU5i7E42bCn+OxGbtuB6S5kSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ROrZEJFC0RgsM8KCdq/Eh2sh9FOG+5fwEcv1AAh2DOq57mSiSqGGpU+y72n6tnVqB
	 KzZD2aL232cIahe4WKG+JhxfVNxVypRDy6x+hMppKkBxDFAahShoMmk6MxftxWfoIp
	 JQa5dfFWXmqo9XLauNIJNNAp/zaA+9CeGMMGPEieF/yK0mBcsOstzQvkFTML94/+ii
	 NTpMZoHxXVc13jd+tb48jkGfk7EuPQIyxu/+Nv4OKIbVBQZHU/md39Oyv5D6IRL3uw
	 ekKqWF2/lk5c6zkfRsV5cV/Ja1/VVLv5HLBDzYSTtCMnU9AZsQJuXpqdlgHruLHmGX
	 um8qKsE1/7wGw==
Date: Mon, 27 Nov 2023 13:47:12 +0000
From: Simon Horman <horms@kernel.org>
To: WANG Rui <wangrui@loongson.cn>
Cc: kexec@lists.infradead.org, Florian Fainelli <florian@openwrt.org>,
	Huacai Chen <chenhuacai@kernel.org>, hev <r@hev.cc>
Subject: Re: [PATCH] lzma: Relax memory limit for lzma decompressor
Message-ID: <20231127134712.GD3354982@kernel.org>
References: <20231125072643.116681-1-wangrui@loongson.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231125072643.116681-1-wangrui@loongson.cn>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231127_054719_751587_C66B9F68 
X-CRM114-Status: UNSURE (   7.20  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Sat, Nov 25, 2023 at 03:26:43PM +0800, WANG Rui wrote:
> The kexec cannot load LZMA compressed vmlinuz.efi on LoongArch.
> 
>   Try LZMA decompression.
>   lzma_decompress_file: read on /tmp/Image4yyfhM of 65536 bytes failed
>   pez_prepare: decompressed size 8563960
>   pez_prepare: done
>   Cannot load vmlinuz.efi
> 
> The root cause is that lzma decompressor requires more memory usage,
> which exceeds the current 64M limit.
> 
> Reported-by: Huacai Chen <chenhuacai@kernel.org>
> Signed-off-by: WANG Rui <wangrui@loongson.cn>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
