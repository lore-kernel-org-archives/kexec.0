Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0780ECAAD8
	for <kexec@archiver.kernel.org>; Fri, 23 Sep 2022 12:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=7RPzwDH1+fz7ji0dotcdz0qICkPup/xQU4RIvETdNgY=; b=2SzL/qlqIefSEzhPTR/cDZJYzI
	wNWJ2V3cS9aGmU90O45QFO2aAyQZCwBkL6Bim2lxQJx4+s93UhQVrz534w9AP5ZMGhNbvBx0zj6aF
	ABbfW/42NP5gnFGE3Q8TfXavGGKYTlejn7L1A1UgQp882dv8YJTzrs3Qk98fCIR5B2EKy1/Cp9TRR
	+nZcbsqwTdBL9oC0ETJpWUrJFbiCqhUj1U4BDYw68b6BKVTpgg9AU5HZS5AfSkYRrZe7VPRjuZiSi
	kRlFtP+gJt1DC5EtuD9488bCSM+8qFQ6HI6pFj/Ur1saetprU4ez29vyal1z7t3IklEfHgQRha6iV
	cXcVSABw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obiBd-004Kuy-3N; Fri, 23 Sep 2022 12:53:45 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obiBZ-004Ktd-VC
	for kexec@lists.infradead.org; Fri, 23 Sep 2022 12:53:43 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 341E6621AA
	for <kexec@lists.infradead.org>; Fri, 23 Sep 2022 12:53:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F384C433D6
	for <kexec@lists.infradead.org>; Fri, 23 Sep 2022 12:53:40 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="EnUv5rQf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1663937617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nLbY6ODoYVoZFTe6xNbVnO76pCYvWYbmh/vjo3Dz0B4=;
	b=EnUv5rQfpn7WazacqxuDct3GlGS4b5FZluX705VcyjZkuE8ujKHIkCYdiYA2FMwOb4igId
	PM7BWWzn6coiMEYKeE5QJ7vxm80iJ1O5ZPB0XS1YKEO+XqPxUxCdw1yp94OGWgOY6ro9H7
	hnVgwrsgvyP3XBdMdo+ebDy1Ytey1vU=
Received: 	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 18897a9c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <kexec@lists.infradead.org>;
	Fri, 23 Sep 2022 12:53:37 +0000 (UTC)
Received: by mail-vk1-f181.google.com with SMTP id b15so96612vkp.2
        for <kexec@lists.infradead.org>; Fri, 23 Sep 2022 05:53:36 -0700 (PDT)
X-Gm-Message-State: ACrzQf0vBtXVuUPdWAy9GwcejiHFnl7JbTw2zr2wu+DStf42kcZEX24j
	TFK3iNuu+uG3uDbSEtWjSc46zpQgPN+ACU0sqmc=
X-Google-Smtp-Source: AMsMyM49F2E1RfHUIS29gKKqtrhnKDF7bU4c1ATOUKbLDO4SdTHVfoTpPsFM6N9D7ksMiGb0DrIWFULscllGaTv7usU=
X-Received: by 2002:a1f:19cf:0:b0:375:6144:dc41 with SMTP id
 198-20020a1f19cf000000b003756144dc41mr3668869vkz.3.1663937615691; Fri, 23 Sep
 2022 05:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220923124642.3942806-1-Jason@zx2c4.com>
In-Reply-To: <20220923124642.3942806-1-Jason@zx2c4.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Fri, 23 Sep 2022 14:53:24 +0200
X-Gmail-Original-Message-ID: <CAHmME9rH5=JViW6dDyiaFZvuCaFpHZwXSC7xDNj6MEH6rb7+Tg@mail.gmail.com>
Message-ID: <CAHmME9rH5=JViW6dDyiaFZvuCaFpHZwXSC7xDNj6MEH6rb7+Tg@mail.gmail.com>
Subject: Re: [PATCH kexec-tools] m68k: pass rng seed via BI_VIRT_RNG_SEED
To: Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, 
	kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220923_055342_285064_9D696338 
X-CRM114-Status: GOOD (  15.48  )
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

On Fri, Sep 23, 2022 at 2:47 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Geert - I don't have a toolchain for testing this. Could you verify it
> works, if you have a chance? -Jason
>
>  kexec/arch/m68k/bootinfo.c       | 22 ++++++++++++++++++++++
>  kexec/arch/m68k/bootinfo.h       |  6 ++++++
>  kexec/arch/m68k/kexec-elf-m68k.c |  1 +
>  3 files changed, 29 insertions(+)
>
> diff --git a/kexec/arch/m68k/bootinfo.c b/kexec/arch/m68k/bootinfo.c
> index 18bf226..74e65a0 100644
> --- a/kexec/arch/m68k/bootinfo.c
> +++ b/kexec/arch/m68k/bootinfo.c

I forgot to add `#include <sys/random.h>` I suspect.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
