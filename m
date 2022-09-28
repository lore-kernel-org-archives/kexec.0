Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D8AC04A95
	for <kexec@archiver.kernel.org>; Wed, 28 Sep 2022 23:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cUHgQfx8728iq/HlJfmMNvYdsPOHwCa4tzqhhHX63C8=; b=nuj6VM5vxxde1U
	9FYfhUCeBHSpR5DbFhYvYsyU1CSqEofJjlJDnyT7Sfsp0B5SbKMP/e3ypmWFgzvsY7aOwCumPR/KR
	fkTLnK1IcqSSWJwx/iw6Krqx6SRK7sGrPCRizhY1+TCkjdE7obJ+yTaDPT7ZhxyK6Ak3BorB7xgjI
	qwx448P+vbCrogwGDFcdcnQPBLocJMjx1TqUTCUDoaWZhqaVKHUscKAZ0y6BreM1AvS9Mi+QWHvCn
	Gdt/GZQkVOpOJT0YcypmZ48DbIOOI74AQTV5JpRu5ymi0KokkxCFz525EwYYpkUen2kT3TuEGrOzk
	RMyztyoVNzm1u5TbXRdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odgI0-000cvR-5n; Wed, 28 Sep 2022 23:16:28 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odgHx-000cud-Fr
	for kexec@lists.infradead.org; Wed, 28 Sep 2022 23:16:26 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B30CA60EE7;
	Wed, 28 Sep 2022 23:16:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87663C433C1;
	Wed, 28 Sep 2022 23:16:23 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YgWBvx2l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1664406981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MFlE0ld6cGlbqEZR2H/NeL8tv8fttMveIrKcEOGDIZQ=;
	b=YgWBvx2lmOpqhou91IO07CApy6xxa4HTExwIYMDqcp73/boK3K1nragJmDzr6iQmVZQF5n
	b47J4/pQOcwzoESMt5+7YPwtBFzcPBdmwG6cw2xPik7rbBnjGYWSJTcqSUUiZzPozLUG4/
	RqDvZdvjvVgHULonVcjoruOfyJLYNhA=
Received: 	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 11fdc80f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 28 Sep 2022 23:16:21 +0000 (UTC)
Date: Thu, 29 Sep 2022 01:16:19 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org, kexec@lists.infradead.org,
	Simon Horman <horms@verge.net.au>,
	Laurent Vivier <Laurent@vivier.eu>
Subject: Re: [PATCH v2] m68k: pass rng seed via BI_RNG_SEED
Message-ID: <YzTVwzc3oxdWgHjt@zx2c4.com>
References: <CAHmME9ow+ivvQaCnPqRNiYRn4+fuGksKyRAEWtBa-6yhyg9OTA@mail.gmail.com>
 <20220923164152.4079868-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220923164152.4079868-1-Jason@zx2c4.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_161625_587650_2EA8AF35 
X-CRM114-Status: GOOD (  11.78  )
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

On Fri, Sep 23, 2022 at 06:41:52PM +0200, Jason A. Donenfeld wrote:
> In order to pass fresh entropy to kexec'd kernels, use BI_RNG_SEED
> for passing a seed, with the same semantics that kexec-tools currently
> uses for i386's setup_data.
> 
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> Geert - this hasn't been compile tested yet and also depends on changes
> that haven't yet landed upstream. Posting this preliminarily now. -Jason

With [1] having landed, does this patch here suffice for kexec-tools?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git/commit/?id=f1bb20c8be1929743fdb313b4770601afc39c1b7

Jason

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
