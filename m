Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B09C4332F
	for <kexec@archiver.kernel.org>; Fri, 18 Nov 2022 15:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eYb0wZTJLxMXiI/lfEXovEAF3RP4UISUvmY/l6SEL0M=; b=mopq4krGZcadHC
	P0O3/2j/a9Hrtcmut8CpnKuKlikAM4t3fIlmyWqbRTBbr5Ttb5QV5qR9MjfNocJKNJfN+3/eXGs60
	CqIp+U0b2imVPvEH04WgWhE6XZh+atUIsvIqKTi4NIYDy629kxi0s0NiSb6w0GajndGRUHvT/v0Ov
	Lq5vyU57vQJqqupQ8zgZUYuFe+lzorqpP5sjHTV4hhzqtl4CBA7E1hs2f9mA0TGBTIpeDx94VumPC
	3n4rtMuIQ+0uHsfrYkj9h0iZMuToiTLVMCZHOhTHZ0VAGHNMYiwgg2tVpZPewufaMU0mDqH4MshLt
	+0/bOGUwqpK8mIB27Dyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ow36c-004qCy-B9; Fri, 18 Nov 2022 15:16:38 +0000
Received: from zeeaster.vergenet.net ([206.189.110.174])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ow36W-004q6t-0J
	for kexec@lists.infradead.org; Fri, 18 Nov 2022 15:16:33 +0000
Received: from momiji.horms.nl (86-93-216-223.fixed.kpn.net [86.93.216.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by zeeaster.vergenet.net (Postfix) with ESMTPSA id A5E022000E;
	Fri, 18 Nov 2022 15:15:52 +0000 (UTC)
Received: by momiji.horms.nl (Postfix, from userid 7100)
	id 4DC049402B6; Fri, 18 Nov 2022 16:15:52 +0100 (CET)
Date: Fri, 18 Nov 2022 16:15:52 +0100
From: Simon Horman <horms@kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: horms@kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org, kexec@lists.infradead.org
Subject: Re: [PATCH kexec-tools v3] m68k: pass rng seed via BI_RNG_SEED
Message-ID: <Y3ehqF20MWK1B+gO@vergenet.net>
References: <CAHmME9oMiDixKuC==sEHk3O5vfEV_67ouLjtUYQOnfSp9decxA@mail.gmail.com>
 <20221114154303.1176987-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221114154303.1176987-1-Jason@zx2c4.com>
Organisation: Horms Solutions BV
X-Virus-Scanned: clamav-milter 0.103.7 at zeeaster
X-Virus-Status: Clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221118_071632_235691_9746572E 
X-CRM114-Status: UNSURE (   9.11  )
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

On Mon, Nov 14, 2022 at 04:43:03PM +0100, Jason A. Donenfeld wrote:
> In order to pass fresh entropy to kexec'd kernels, use BI_RNG_SEED
> for passing a seed, with the same semantics that kexec-tools currently
> uses for i386's setup_data.
> 
> Link: https://git.kernel.org/torvalds/c/dc63a086daee92c63e3
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Thanks Jason,

applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
