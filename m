Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A19AC531F9
	for <kexec@archiver.kernel.org>; Tue, 28 Jul 2026 10:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HyZO4cYoAtoBcOxiccZ98CUzDZNYu6JX078EzCBBAas=; b=RSL8Ubzyg2mBi1csi89+LfnlJM
	V0UQioi0uSaXe4wRtobsFcK0ZAjb4WhNgvpDZtK/FkahcbVAsUGxIzuAvXVXEBpR49GPf4symw80Z
	/tV+z/D5aMDrdW8Cz4oC0fQGQKGhtkkYOoxFf60wsuZfpdmsVJyl/emczJRX9syFQ00UXmDryTEXS
	6lAh84hTiD1hqCguPFYQNatZPfii9WcAn4Nq3RmogQ+QCua/ytLZcT88erWThogPfVuhZjq18tpqp
	y1bsMdFk4v8aHhWGYvwnmASKoMMCOYi4a5HsEIgzIN6VMy2utMhWH1qyMIaFU0jeiWLsky4OXgtby
	M5FW5suA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wof0L-00000004xR6-1jG9;
	Tue, 28 Jul 2026 10:25:45 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wof0K-00000004xQi-2cPz;
	Tue, 28 Jul 2026 10:25:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 62633410B4;
	Tue, 28 Jul 2026 10:25:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54871F000E9;
	Tue, 28 Jul 2026 10:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785234344;
	bh=HyZO4cYoAtoBcOxiccZ98CUzDZNYu6JX078EzCBBAas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cCn+S7eGwTX1IqnkX98nePTtxWir9NnzW9inTqAMSFyxmM7qu3e+OZltTR77Al23D
	 wwG2C0iiP08N1i94tjDpAewzVTmhASxQmjY3hXfEzYL/Yi+HQ7nNf/CqOwy2DVxE1/
	 OSgbQuyGKWwsR4oAOBiQt79RL1VdPCzpEjkKs5WgKbK5j1GUElQi36IYCHx0fwAfW2
	 cjXapwVCQIf/wXSFi6c9TLlhmJ2kbRb/2S4W3TNp+P9tTZRIXpNoiKjqKaFBrZIbfz
	 9JGOf9B1zblzW5ZKWXUhHnQn345joBuwSEEuHQiAvaUg+O9/RFLFFHOUQ/R0zZJZ6F
	 fR24P9e8dCdtQ==
Date: Tue, 28 Jul 2026 11:25:37 +0100
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
Message-ID: <amiDoZdszC1pB6Z2@willie-the-truck>
References: <cover.1782744912.git.kas@kernel.org>
 <ak_IRHwd02EjWMf8@thinkstation>
 <amYR5VWHWC1WdFXc@willie-the-truck>
 <amZRtS2Lu1epc0S4@thinkstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amZRtS2Lu1epc0S4@thinkstation>
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

On Sun, Jul 26, 2026 at 07:35:20PM +0100, Kiryl Shutsemau wrote:
> On Sun, Jul 26, 2026 at 02:55:49PM +0100, Will Deacon wrote:
> > On Thu, Jul 09, 2026 at 05:16:37PM +0100, Kiryl Shutsemau wrote:
> > > On Mon, Jun 29, 2026 at 04:07:14PM +0100, Kiryl Shutsemau wrote:
> > > > From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> > > > 
> > > > A class of debug/observability features needs to interrupt a CPU that has
> > > > its interrupts locally masked: the all-CPU backtrace behind sysrq-l /
> > > > RCU-stall / hung-task / hard-lockup dumps, and crash_smp_send_stop()
> > > > capturing a stuck CPU's state into the vmcore. On arm64 these need a
> > > > mechanism that reaches a CPU spinning with DAIF masked, which a normal IPI
> > > > cannot.
> > > 
> > > Gentle ping. Any feedback?
> > > 
> > > I'm looking forward to finding an upstreamable solution to the problem.
> > 
> > This is all pretty small, self-contained and it's useful to you, so I'm
> > inclined to merge it.
> 
> Thanks!
> 
> > However, the one vague concern I have is about the direction of SDEI in
> > the future. AFAIK, the TF-A implementation is known to have issues, it's
> > not supported at all by R-FA and I worry that the spec is going to fall
> > behind the architecture, particularly as FEAT_NMI becomes available.
> > 
> > So it would be good to understand what we're signing up to maintain here.
> > Kiryl, do you see an (eventual) migration over to FEAT_NMI, giving us a
> > path to deprecating SDEI altogether, or do you think the two will live
> > alongside each other for the forseeable future?
> 
> Realistically, the foreseeable future.
> 
> FEAT_NMI is the endgame and a machine that has it needs none of this,
> but non-FEAT_NMI parts stay in fleets for many years, so I can't
> honestly give you a date for dropping SDEI.

That's fair, I was really just trying to understand the direction. It
sounds like you will *eventually* move to FEAT_NMI, even if it's many
years away.

> While this change is pretty self-contained, I understand that SDEI infra
> maintenance can be a burden.
> 
> Is there anything on the wider SDEI infrastructure that would lower the
> maintenance burden or keep it more out of your way -- consolidation,
> tighter isolation, docs, help carrying it? If there's work there that
> makes SDEI more palatable to keep while non-FEAT_NMI parts are in
> service, I'm glad to take it on.

I'm somewhat trying to predict the future here, but I wouldn't be
shocked if some whizz-bang new architecture feature interacted badly
with SDEI, either due to outdated specs or because of a fundamental
incompatability. In this case, I would like the option of being able to
make new hardware support mutually exclusive with SDEI rather than try
to hack around the mess. It sounds like that would be ok for you?

Will

