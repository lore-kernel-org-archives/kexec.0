Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA66CD6E7C
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 21:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GvUn30TBCS4Zm3lx2W+s/4iNVlrmIOOcdyF2l5T6bVw=; b=HgyzXsfrZIBEOTPQj/Z5iFx2Z2
	JLPGmjPzjU5tYIaw17vd1PTYp4TfxFxAVm+LPBHAy0yPM1TGJedWwV0KFWyubvSwpA4iOc8qlVD48
	BjJ8fYlxXtChk+Z05ZH8sku8b+tHelAYqpWsYntjlvVTxPazj7c9kyOHgMTJBkH6KxE7quJwG4pBq
	wzrNrZCji6QnGmW19vx8jaGyu9ei+FDEl/wM30sQlodPEnZTqSJUIhhoYPliRsxABM/5A2UVSaCN3
	HTnVvhZXDNvG43b3SMtHX38WS2UnR9L6VQ4OZzKS9TXvFzizheDLCNJcIVrtFZaxKbqsWtLBGMCTp
	8tH+GaGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVc7C-00000001CaI-3FpJ;
	Fri, 05 Jun 2026 21:30:06 +0000
Received: from fout-a8-smtp.messagingengine.com ([103.168.172.151])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVc79-00000001CZq-3dde;
	Fri, 05 Jun 2026 21:30:05 +0000
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 57255EC01F2;
	Fri,  5 Jun 2026 17:30:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 05 Jun 2026 17:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1780695002; x=1780781402; bh=GvUn30TBCS4Zm3lx2W+s/4iNVlrmIOOc
	dyF2l5T6bVw=; b=lsV4jnVMMml2Z5JVZZSb3QqYvP5fOhplJHutkEpZOC0P6eQw
	UUUURrnvSh41zAvkFxCHOtpAWjW3DwLne8okVnDcoyHmEiTqNVG6oYX+5/ZjqKrR
	4RaOu9nnl5WvNEUp+1wrafWjwT+3HLMQph+EGE8n1ClYbKuUnn2P7wQMVYe4/73a
	3CNKV98sD65duhm/xwZUvgXt25Ik6UDWB09MoB05YcoLeEXcEug4otb15eYY9WMs
	IA5gtP6iJPe2XAxb+gdjN34K9a1MShHJE6Z7OkSR0iUs+cHc+emp899ja5JVxzEa
	tXZZEPNS1M8d26+Upf0I3j0kL4yWZ/sm6NMGUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780695002; x=
	1780781402; bh=GvUn30TBCS4Zm3lx2W+s/4iNVlrmIOOcdyF2l5T6bVw=; b=E
	r1ZaO7Tzo+mBX7PCOSNme2T6Vt3IA9DsvVagP2Pnvsa/CJJdR8lXnb4vsx1e0jKu
	UHZxb1WdT1Cat7phtlQX7d9uRphkr4yIsvqTcB+hAflMcC+xK9PlFzFFS6kpYBvE
	Cwc2oah9/iI4SbhRoUmCf4FMUv+ULGaNb7Wx7JgWE5VJs+neI3Tdz7CtXTk/LTpS
	C747dgnNXrAH1ikREfr6U47wHpvz9pzMGoPn2VP1bLZK9kP9IgIbnCA5rqMHOKN2
	fJKtnh/CE8jgR9DBZR/H9/oQiJtgp+iRS6Vy/9VvmtkWgsHGdRedlUxxih7d8GIo
	9XSojEOt2XknQ007yeqvw==
X-ME-Sender: <xms:2T8jalssGXKnC9Cflirnc1-YLcAclPb8TE5gA6PgAQ2YmR0UsjRN7w>
    <xme:2T8jahmnmdPwin_UaJW4nVipwI_cqWyWu154MojMkwsU-lDcJZdmUzmaXqDQR9bbi
    yjp0nqeZS3EwBP-UQCqYbEM6XZjWCeLIdIZx83a4N5SqlfiUbMcU9Iq>
X-ME-Received: <xmr:2T8jamMt2QHnbMt5gyZN2bWsPnn0WsathLEZ8kHu-jB33FHoUbc3r49sdKO7dw>
X-ME-Proxy-Cause: dmFkZTGT3vO/WGTlEyxfWXbodvnZRmgEDm1o9LlJ/+LRF68W8Z2nser0+LniSG+96nKb+H
    pOylecktyziBagvY49pxEJBjjkpQL8mgWF5v1uGd1s+h6I5zzlQbM7AHlbCH/iTWEAPmW6
    PSVh7KQ0UpCrZmv2ekvGKVSTBMc2xq77fqnB36j51Xf/btMi0DPvJiVEVJ113sswsm72zM
    c1Ob4ECtKaqLnjX8INndbIsjJj8TAReV3dVZrqx+gKmV/udgPeAOLBMtvJtf5Xi9z/fM4q
    zR3wvjNvuZLT+4A5ZR9Gslu7kzxa47KFBhqSuq1/K8gU/GNvl3Ruhc3zbNG7sLUDfGaJGq
    S+v+TTf2sRUv+yvDSjBcWsL/beNP5PcN8l6vkgxpLyoIgUkloXaV5tVsHfW5/HjFbM1h9H
    ++ReRsw/33SuNMrKvyLTaBLJ0Qp1NfUY6nhOKYg6hcvFMElvJ+RIQYH6e1x4wLXqK04P5M
    QywHw21Le7e0o7Kg15x0VvpUbbbWe6CIzAvq04cBt6emSLOwBrL2o5+itaggLzzHPm65kR
    zhsqtRFAP1ZPEHvwqTbxdjekEWiuZRNN6v+w/arDgJD9tjnHje7FvwH5if5ceAd36/H91q
    3Kz/hAFVuYEEhHohAIbtn6hndoyzzKUd9fSuUTZO1fnswAD5ykflsXC7qQhQ
X-ME-Proxy: <xmx:2T8jagzEpajFW89wSipzYjkpGI2BmCFv63JmyI5rY0u_-T2h6Yb8SA>
    <xmx:2T8jaklvpBpO4DpbRkwiUufbqrg-R28H64_6ZxIGwChkp2uTUBtfag>
    <xmx:2T8jap_b1fZPnGTtgaJPL4QMwfrti_bySBjS_uoKQ3n5R0cdeOpv7Q>
    <xmx:2T8japIOJV-XrUpotfmPO7MmJMRrgSpXQOElrHhYHW0KwPh5eIOi5Q>
    <xmx:2j8jatWKeiFLsQjzo8ma0SA-g4_EYoxp9yWPwI3dlr48nxe8GlP67eJ0>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 17:30:00 -0400 (EDT)
Date: Fri, 5 Jun 2026 22:29:59 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Doug Anderson <dianders@chromium.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, Breno Leitao <leitao@debian.org>, 
	Julien Thierry <julien.thierry.kdev@gmail.com>, Lecopzer Chen <lecopzer.chen@mediatek.com>, 
	Sumit Garg <sumit.garg@kernel.org>, kernel-team@meta.com, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] drivers/firmware: add SDEI cross-CPU NMI service for
 arm64
Message-ID: <aiM861HRKlrDqaXl@thinkstation>
References: <cover.1780496779.git.kas@kernel.org>
 <145b9e98b12a7d314fc4a203075f65c3a0c3a913.1780496779.git.kas@kernel.org>
 <CAD=FV=XMqFVnri1aVGbFJhN6Ts3SeJUzEZrfN0Pqp9WeOzE=OA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=XMqFVnri1aVGbFJhN6Ts3SeJUzEZrfN0Pqp9WeOzE=OA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260605_143004_005135_0091FD97 
X-CRM114-Status: GOOD (  31.48  )
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

On Fri, Jun 05, 2026 at 01:54:00PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Wed, Jun 3, 2026 at 7:36 AM Kiryl Shutsemau <kirill@shutemov.name> wrote:
> >
> > @@ -928,11 +929,19 @@ static void arm64_backtrace_ipi(cpumask_t *mask)
> >  void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu)
> >  {
> >         /*
> > +        * Prefer the SDEI cross-CPU NMI provider when active: firmware
> > +        * dispatches the event out of EL3 and reaches CPUs that have
> > +        * interrupts locally masked, without the per-IRQ-mask cost that
> > +        * pseudo-NMI pays for the same reach. The plain IPI path below
> > +        * can't reach such a CPU unless pseudo-NMI is enabled.
> > +        *
> >          * NOTE: though nmi_trigger_cpumask_backtrace() has "nmi_" in the name,
> >          * nothing about it truly needs to be implemented using an NMI, it's
> >          * just that it's _allowed_ to work with NMIs. If ipi_should_be_nmi()
> >          * returned false our backtrace attempt will just use a regular IPI.
> >          */
> > +       if (sdei_nmi_trigger_cpumask_backtrace(mask, exclude_cpu))
> > +               return;
> >         nmi_trigger_cpumask_backtrace(mask, exclude_cpu, arm64_backtrace_ipi);
> 
> nit: instead of one comment block, I would have broken it up in two. Like:
> 
> /*
>  * Prefer the SDEI ...
>  */
> if (sdei_nmi_trigger_cpumask_backtrace(mask, exclude_cpu))
>   return;
> 
> /*
>  * NOTE: though ...
>  */
> nmi_trigger_cpumask_backtrace(...);

Makes sense.

> >  }
> >
> > diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> > index bbd2155d8483..6501087ff90d 100644
> > --- a/drivers/firmware/Kconfig
> > +++ b/drivers/firmware/Kconfig
> > @@ -36,6 +36,25 @@ config ARM_SDE_INTERFACE
> >           standard for registering callbacks from the platform firmware
> >           into the OS. This is typically used to implement RAS notifications.
> >
> > +config ARM_SDEI_NMI
> > +       bool "SDEI-based cross-CPU NMI service (arm64)"
> > +       depends on ARM64 && ARM_SDE_INTERFACE
> > +       help
> > +         Provides SDEI-based cross-CPU NMI delivery for hooks that need
> > +         to reach interrupt-masked CPUs on silicon that lacks FEAT_NMI:
> > +
> > +           - arch_trigger_cpumask_backtrace()  (sysrq-l, RCU stalls,
> > +             hardlockup_all_cpu_backtrace, soft-lockup secondary dumps,
> > +             hung-task auxiliary dumps)
> > +
> > +         The driver registers a handler for the SDEI software-signalled
> > +         event (event 0) and reaches a target CPU by signalling it with
> > +         SDEI_EVENT_SIGNAL. Firmware delivers the event out of EL3
> > +         regardless of the target's PSTATE.DAIF -- forced delivery into a
> > +         CPU wedged with interrupts locally masked.
> > +
> > +         If unsure, say N.
> 
> Is there some downside to this? It seems like anyone who has the SDE
> interface would want this. Not sure why you'd suggest people say "N".

No real downside -- without the software-signalled event the driver
stays inert, and there is no cost until an event actually fires.

The "say N" is caution, not a technical limit: so far this has run on
QEMU (TF-A) and one hardware platform, and the interesting paths depend
on each vendor's SDEI implementation at EL3. I'm not sure vendors would
care to run SDEI_EVENT_SIGNAL validation. Maybe we want to see more
data points first?

But maybe I am too cautious. Happy to flip the recommendation (or add
default y) in v2 if that the consensus.

> Other than the nit, this looks reasoanble to me, though I'm a complete
> noob when it comes to SDEI...
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks!

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

