Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B600C43458
	for <kexec@archiver.kernel.org>; Thu,  9 Jul 2026 16:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jF3qVdoEbsJ3VzaNGIP2qIoT+ymr1N9tdwI2e6ZvOkg=; b=1zFU4MM3R9KYJhr6Gu55VwGcoS
	QdcKpN8ajV91cFglvLaNxKqjNGJBSGYnIC22cL54bJXWty73HnyNGadh34oiYmDw1WCaAbHBY87qb
	xypz7TAux/fEwmOqL/iQ25HbO0GldKrFT5qPRCVWaKKBHNb+WSQqlDMM2luD5IA1NK/O9PRqQnSeU
	v0oOqjG+037IAp8jLN1QcHGmr/LNtlnLreRyti02LzR/RdV/L6e0QhxB91negsLaI/pOudZHIMfQq
	8jB/YCs8tiAUiS9ssqsL90k7E+qOSlIaJAxzNwl//0m1S8/N30omAZZg/1WaACz0JzqRshNKQPlMx
	VN9j4XnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whrQY-000000030qL-3ZVp;
	Thu, 09 Jul 2026 16:16:42 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whrQY-000000030pp-1KqV
	for kexec@lists.infradead.org;
	Thu, 09 Jul 2026 16:16:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6AAA7600C3;
	Thu,  9 Jul 2026 16:16:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9951F00A3A;
	Thu,  9 Jul 2026 16:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783613800;
	bh=jF3qVdoEbsJ3VzaNGIP2qIoT+ymr1N9tdwI2e6ZvOkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cwqDa2IxeR0ZYP/wu5gKBeyTyRvlGwRx7Rk1MI3pBXOKgl4hJpHOtOwOPfwza3mhp
	 cFRHLJdSMHDWrXbFplOpVLDBgVxJikMF+l/ENcjsgI+K3xCJuyQBYQ/t2GDborCExl
	 I2qysaFBQzMSMpsAo1CB5BLpZhkPF9NEMfNt6FoppGe1i+8D5GLoMuEHn17SOMMJ2o
	 YgnTJhtGtdSF88NJeMBYUfczAn8ONGhajyUYCT8edBCJmtyAh2aed8Y/eqhEpJpJLa
	 XsrInqpL+URkrBV7+hvirOI3IuvbegQ6XVj2C9JkwSLWL2G5UTmDdJSSei5RUnJ7ca
	 mC2vvZkI2l4QQ==
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 25189F40090;
	Thu,  9 Jul 2026 12:16:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 09 Jul 2026 12:16:39 -0400
X-ME-Sender: <xms:Z8lPajBCIhaWVHhyGYjzssIFraZFDoGwnPuxSHvVmU4wGZwluKq7HA>
    <xme:Z8lPai7gjfyE-PIKjtZnujbcBMmfjMGGYuyJhKGkB887nLyeD_33j_7jV3uB0ZVhg
    Voo0p0GecxMlXJI5I1sf9iPofgIzwOQWFQPZz_CkMeyijAsmwElBw>
X-ME-Received: <xmr:Z8lPantGXJ1-f0isSU2_l_epa1OxE2M5tKEMCbvEDQOVSeQDGNuJTqJmw_yXkQ>
X-ME-Proxy-Cause: dmFkZTGWKpMVRfOvlVssIt8V4+GvxgmrUAKUiXyQp/UngjyA1pSIcf5yG8LmtmhOSgjUSq
    a6qFev133morqnN+20kiSDmMcxuiGTjw74LonpIDBKD/tealNzs7h4fe//+qO6X/LEdcTh
    mQTChkxWkwC8iUstLPTvsDASJHxTKg1pJdqU388/AuVgOJhqerONrNAww4agu7IiipIZb1
    xSc5/cFZlRPwEgdZJ30QZhO0+2XElCXPwoK37BcBCsm9TUnSCqjnO+ZRbYMoF6ldnaQTDX
    XoB5k6HuHPNdtiP/PzhhnbVI4Qa0J0dCeopBse9ZparPe/OTvyFI6qCOgPhxSoAR2xsGFH
    akp5KNVf1nvr/ekmWN9zNXJCy+GCMidjd4CpQz/DEeLQNCoiW+Y85tBIXOJ8gERNQILE3k
    0P/aMv6zFBg3XFWjxRn7/NEL34re6KlmmooBI8B2a491iUKaAjZia0apSBz+Exl+2sDaYI
    SFVIFBshyD53XxHTnHhj1xt6wUhMlDMghw0XYe5bNt5Nio7DBvI/uy0f6HKnXdRuG2LbIs
    7RHcAH+NAc+oIG5ICT/Wu+B6hRx7YI5EHzyYnnngNESPlDcXPbgbMZevr+47APXx27IXp/
    +S5zzWfhTZOZBPNe14PeSwXOmkKHi6qLuundoWzZgMp0n1+9Z7Z90IBCaaOw
X-ME-Proxy: <xmx:Z8lPaoyy3cWTOeid9DgwhMvG79e4bLDJRNWPDlyuZQThm6QR7zkmrQ>
    <xmx:Z8lPaiaxaWyZjfDZ7jD45QdTqGhNOrZJ4ChCDqxth-YxNykIYF4xLg>
    <xmx:Z8lPag1DYivlkNh8v9y9ekC0xRIxfA-aAJUc1Kj1brz18wujVYiUyg>
    <xmx:Z8lPagjQqKeI_jwmebcrJ-b5h9UtrF4fzUdGXh15suyGlQfYgB0kzw>
    <xmx:Z8lPatriLphKSN_6mi0SwLDunm_XaHIqGlBnXzndAhwNfusecswPZe3f>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 12:16:38 -0400 (EDT)
Date: Thu, 9 Jul 2026 17:16:37 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, 
	Doug Anderson <dianders@chromium.org>, Petr Mladek <pmladek@suse.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, Breno Leitao <leitao@debian.org>, 
	Julien Thierry <julien.thierry.kdev@gmail.com>, Lecopzer Chen <lecopzer@gmail.com>, 
	Sumit Garg <sumit.garg@kernel.org>, kernel-team@meta.com, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/4] arm64: cross-CPU NMI via SDEI
Message-ID: <ak_IRHwd02EjWMf8@thinkstation>
References: <cover.1782744912.git.kas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1782744912.git.kas@kernel.org>
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

On Mon, Jun 29, 2026 at 04:07:14PM +0100, Kiryl Shutsemau wrote:
> From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> 
> A class of debug/observability features needs to interrupt a CPU that has
> its interrupts locally masked: the all-CPU backtrace behind sysrq-l /
> RCU-stall / hung-task / hard-lockup dumps, and crash_smp_send_stop()
> capturing a stuck CPU's state into the vmcore. On arm64 these need a
> mechanism that reaches a CPU spinning with DAIF masked, which a normal IPI
> cannot.

Gentle ping. Any feedback?

I'm looking forward to finding an upstreamable solution to the problem.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

