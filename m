Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61751C531C9
	for <kexec@archiver.kernel.org>; Sun, 26 Jul 2026 13:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oAqk85PfaZIsBzhpoLVWf76ojRfZbMog0/3PXdHaiAw=; b=EtU8r5xvIh1P90AHmZu3Iq2/qj
	XEOHuXfqyrSmfuzt6xojJHfYP16OUkH4lLr51WWTXoSiM6dDSH+VyEsAqGieWRFdDfngjO0fw1HY8
	QaQfaIcopOv+apsJsPsB0z8+Ogt9Cq7HDcFRAeK+jt/t8nd61G9rI4gSISSDW3s9/QgAjBpK7EYu3
	ZWxmIBB2n9hqGc+Ka8RgXG71zYJfevpoQfjmBSlrxwlCLbdVtlLgvwSpURvYV2Qq8trHbi4/RHvLZ
	c+hgEJGdtitL3kxuaTjezIkPqvN2gigLLvntGVjrPRzdlWcY9yMIerH2nZu3LiORwmVs2hXaSNVvC
	8DxxY9uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnzKg-00000001DYR-2reA;
	Sun, 26 Jul 2026 13:55:58 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnzKe-00000001DYG-3fmx;
	Sun, 26 Jul 2026 13:55:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 131C0400C7;
	Sun, 26 Jul 2026 13:55:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA6F1F000E9;
	Sun, 26 Jul 2026 13:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785074155;
	bh=oAqk85PfaZIsBzhpoLVWf76ojRfZbMog0/3PXdHaiAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GaFtuCkngOK2YnYTN5/q1DxREdA9n0YxnFFD94dlpKPeV3syaV9BEWdXFYPnF4n5N
	 zGLMhdZFa28zts7sn8Bzmk0pHrqOb/+bDN7q7f3wObebhZqopz9XqGS+9/MEKSeYNl
	 niKRlm85gzOm0xGyRX9mG0FPZNK7UCeJwnVbFHkjokRX0yoJUn+8XGhNsCpW4eot6I
	 tnWFVx6uLM9kwbSLf0AtmgMP58VWEbC1iTdyyj0s2PQyOggZYk4JS0lXXVdmP/dP4G
	 tG2DtyTYxzy+vTTkuT+JuPligFgrrZC4fa4jHGI18KE1STuiFl/8zs32AvWKvilG3k
	 wBDslo24px5YA==
Date: Sun, 26 Jul 2026 14:55:49 +0100
From: Will Deacon <will@kernel.org>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	James Morse <james.morse@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	Petr Mladek <pmladek@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Puranjay Mohan <puranjay@kernel.org>,
	Usama Arif <usama.arif@linux.dev>, Breno Leitao <leitao@debian.org>,
	Julien Thierry <julien.thierry.kdev@gmail.com>,
	Lecopzer Chen <lecopzer@gmail.com>,
	Sumit Garg <sumit.garg@kernel.org>, kernel-team@meta.com,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/4] arm64: cross-CPU NMI via SDEI
Message-ID: <amYR5VWHWC1WdFXc@willie-the-truck>
References: <cover.1782744912.git.kas@kernel.org>
 <ak_IRHwd02EjWMf8@thinkstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak_IRHwd02EjWMf8@thinkstation>
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

On Thu, Jul 09, 2026 at 05:16:37PM +0100, Kiryl Shutsemau wrote:
> On Mon, Jun 29, 2026 at 04:07:14PM +0100, Kiryl Shutsemau wrote:
> > From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> > 
> > A class of debug/observability features needs to interrupt a CPU that has
> > its interrupts locally masked: the all-CPU backtrace behind sysrq-l /
> > RCU-stall / hung-task / hard-lockup dumps, and crash_smp_send_stop()
> > capturing a stuck CPU's state into the vmcore. On arm64 these need a
> > mechanism that reaches a CPU spinning with DAIF masked, which a normal IPI
> > cannot.
> 
> Gentle ping. Any feedback?
> 
> I'm looking forward to finding an upstreamable solution to the problem.

This is all pretty small, self-contained and it's useful to you, so I'm
inclined to merge it.

However, the one vague concern I have is about the direction of SDEI in
the future. AFAIK, the TF-A implementation is known to have issues, it's
not supported at all by R-FA and I worry that the spec is going to fall
behind the architecture, particularly as FEAT_NMI becomes available.

So it would be good to understand what we're signing up to maintain here.
Kiryl, do you see an (eventual) migration over to FEAT_NMI, giving us a
path to deprecating SDEI altogether, or do you think the two will live
alongside each other for the forseeable future?

Cheers,

Will

