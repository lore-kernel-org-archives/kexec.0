Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B25C6FA82
	for <kexec@archiver.kernel.org>; Fri, 23 Sep 2022 16:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+7rT/cCMER6d3bgG4eDF9y7Qz+ATTmFlm5+It6y4gKQ=; b=KOxgtsbP32vC+3
	zku3/fW3+3M3IZFSumt0tDXd6JcRoTky0kG5EBuUAB8OzGTBwwufNjEjbmxNV1Lv+dYrxMsEbqeZj
	H2RdLXeQyUdD2rpoTqemN22UkTee0G/xPJksLoFPWCsGY/I70eLgF1Zw0wWFY+6oNCJN88S/hBPyY
	6+k9VnA/14+x4hz7Yqp7z28KVNRnfpOMSZawJInd9It9Ye7nPpCfewm3Ojd6MVw2IjtfPlkzg1dxg
	f/fAPiC4+9c0jrLMNU+3L4bqLQMxUvSqvYlCoengTwmZfb75nqOFxzDruQni69OFlWpOW9jljNzhl
	XPSJy5EEjebmVv2R/hOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oblgi-0050Xj-Q0; Fri, 23 Sep 2022 16:38:04 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oblgf-0050VV-LT
	for kexec@lists.infradead.org; Fri, 23 Sep 2022 16:38:03 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 70D6E60E1F
	for <kexec@lists.infradead.org>; Fri, 23 Sep 2022 16:37:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82768C433D7
	for <kexec@lists.infradead.org>; Fri, 23 Sep 2022 16:37:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jUpCTdkn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1663951072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5wP8/olBSLeZ3q606VAu09uERiOChlp35MnSGyQzTko=;
	b=jUpCTdkn6lFuOUG4Xm5w7INmLzpwBjSVWKcOMBM2J1C+WgQHx9mDCjm+5AeA0QRtdYi5o7
	bf9Gp7FRWMuYrtydUPWMOY/KCrBxX5tv6qub8aINXYelBvjvGs3cKlNah8k6y/RFoVHFvM
	RXiRlCRAMznIjovNbffQmFkNX6FXoOc=
Received: 	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 31784704 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <kexec@lists.infradead.org>;
	Fri, 23 Sep 2022 16:37:51 +0000 (UTC)
Received: by mail-vs1-f54.google.com with SMTP id p4so482792vsa.9
        for <kexec@lists.infradead.org>; Fri, 23 Sep 2022 09:37:51 -0700 (PDT)
X-Gm-Message-State: ACrzQf2/lN7E6JA3TpFgbBVgsMRawDvv+NzNE0SUVXhUzfyB+1E3HNkt
	8BKIuMN4hd/l4Ou8Tj9eet1Gz/XS4d5z17sBi9w=
X-Google-Smtp-Source: AMsMyM7eN2EDq1uQGB8dxgn+o1qMJqL3vgUJ+mhmpsliSYOasMapWuSBuPqh+9pW5XD74Nw7X3FXTP0jwu9GuyopkgE=
X-Received: by 2002:a67:c289:0:b0:398:cdc:c3ef with SMTP id
 k9-20020a67c289000000b003980cdcc3efmr4185299vsj.76.1663951070524; Fri, 23 Sep
 2022 09:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220923124642.3942806-1-Jason@zx2c4.com> <CAMuHMdU-KyOXg_nEa=gur-X5vjBimOM+zZ-g-xqYhAV-wBOfSA@mail.gmail.com>
In-Reply-To: <CAMuHMdU-KyOXg_nEa=gur-X5vjBimOM+zZ-g-xqYhAV-wBOfSA@mail.gmail.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Fri, 23 Sep 2022 18:37:39 +0200
X-Gmail-Original-Message-ID: <CAHmME9ow+ivvQaCnPqRNiYRn4+fuGksKyRAEWtBa-6yhyg9OTA@mail.gmail.com>
Message-ID: <CAHmME9ow+ivvQaCnPqRNiYRn4+fuGksKyRAEWtBa-6yhyg9OTA@mail.gmail.com>
Subject: Re: [PATCH kexec-tools] m68k: pass rng seed via BI_VIRT_RNG_SEED
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, kexec@lists.infradead.org, 
	Simon Horman <horms@verge.net.au>, Laurent Vivier <Laurent@vivier.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220923_093801_995679_21E9D1A0 
X-CRM114-Status: GOOD (  16.10  )
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

Hi Geert,

On Fri, Sep 23, 2022 at 3:07 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> This won't work as expected: BI_VIRT_* tags are only valid if the
> machine type is MACH_VIRT.
> Worse, this will trigger for other platform-specific tags using the same value:
> Likewise, this will destroy existing BI_AMIGA_CHIPSET and BI_MAC_SCCBASE
> tags, breaking Amiga and Mac.
> As random seeds can now be generic, I think it makes sense to introduce
> a machine-independent BI_RND_SEED.
> In hindsight, we should have done this from the beginning...

Yes, I agree. I thought that would be rejected, though, which is why I
didn't do that before. I'll send a patch switching over to that.
There's no point in keeping the old one around, I don't think, so I'll
just move everything over to the new.

Jason

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
