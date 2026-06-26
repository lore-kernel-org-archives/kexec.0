Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F21E6C43458
	for <kexec@archiver.kernel.org>; Fri, 26 Jun 2026 19:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mQDS3FNwFL0olJLot7xWeYkpD2cNzX+ab2vKP1ejTJU=; b=MxwzhWsMoIsre8ESprsNVj2K8s
	4SzFOjkCzqOOoLrocbS382dXCRAY1vS0t59IU6hWXa7ZHkYvFsIgkOt/2nMI8WLovYIRX/ElD281O
	MOHEoZOIwdWtwnVpw0T0UXwwNpdC2nxbTSWNn2Y4tIPPBhLHi87CdvAmPLEZho/y0SJr0HaCLFB7l
	SDWa6tnW98UGtdR/JvZiMDzWO6UDRdA/gWGIc2xZhh4yTJm5KLh732Bz5kzyThVMPG6GwncP0s9QQ
	XTq88MAefxzO26k2/Fgs8fB7CEcHTTq59QZjbXRst20zF0o7aGgS8gAiGl6N8lf5toxt3SJPLIIZo
	kty8jsgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdCVK-0000000BnWY-1hLI;
	Fri, 26 Jun 2026 19:46:22 +0000
Received: from fout-a3-smtp.messagingengine.com ([103.168.172.146])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdCVH-0000000BnVz-1Yva;
	Fri, 26 Jun 2026 19:46:20 +0000
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id A130EEC01A0;
	Fri, 26 Jun 2026 15:46:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 26 Jun 2026 15:46:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1782503177; x=
	1782589577; bh=mQDS3FNwFL0olJLot7xWeYkpD2cNzX+ab2vKP1ejTJU=; b=t
	9ECNG12Gkha5phnwc9I7S2T1DyIPXeHMEcvsBweZlljW5+SXaTIOih4G5wZTJuzd
	PySi38CO2ScjpjP2gCLRUCdzG/d6MU6a9npchfk9QuwLA5zHMnjLS3Opq0Kw84vW
	vsUzyfzdc+qx7C+FJWYlU8k+RRWK6DLeXyofeAxfnahKFMx/at89oqDIWh5iTCHc
	Pg33NRQlEqK43CqC8mGNuFjMTt324ymR6Mj9waw9EXHczqRZWJcYXlXs51zo5iDb
	+DCOcMAAGYI8bcMX0q+9wU5JLr6s6+8USpgznd8xavTduI/cZmAnGVvcchu6r4VM
	g1Zsg5n7kZl9hNuxrv+mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782503177; x=1782589577; bh=mQDS3FNwFL0olJLot7xWeYkpD2cNzX+ab2v
	KP1ejTJU=; b=A1/J9OontUShtsY/KlqFFtFZxKJzafxjlZH+gb6hqFknhsqHc/0
	9yhzgoeBatbVSrtpNckERGcKcIQIjB+YWhNMXeYi8MwLnU3KMs9j2evA1pvgtxgC
	RyksHY95qNus9A7nP2H+6c5lhGOzzGsjotMxoHVfyNnkkfRDxDE2cvMCXBbudc8n
	NNC+a/hTEVfA8qcoO5IZzXOU9NWk+d/eyV0L2HZkCHtV2c0Jt5bfD+Y036twoDRD
	bUVexbbLOdf2YFos9SYS6Tuk03yw08s6JMX9Hd13Tm1sDcVEL5lyQJjk9YvIyEID
	nCV5UQ2P7YonzrQh8PfOmju0O3nqWK3icZA==
X-ME-Sender: <xms:CNc-aiAkuz4G1mV7Q0-ZP5SDpk7Mk5jsvMYjmzYiJUb7VqHX0gs_7A>
    <xme:CNc-avojx7jPvvp0TcS18sMAhoyfb7h5kano3PKpfQiEcF_l2cjk1OzRcZjVkXneZ
    QjnuvPe49hch4iZHAtj_wZOik9XZ7XMCYkouo3J0-xXu9lhu0kZpjk>
X-ME-Received: <xmr:CNc-ajB_1bFxTCUH-xIElpzD-K1pwC5ecNwmMmE7c94ZeLI82jOswSXdiMibig>
X-ME-Proxy-Cause: dmFkZTGW1HqdjaJoFQUXHWjWh9D9hOSFIJsyccNvsLPRtGB9mH7fc1kAT7fHoGH3Hu85I9
    k/c3Z7Nb4r54bT5MEEkjmFGiJiu04ZC7NwEzcdsuQvf1CLqjpKYxBI27a6yWDq1/28x1RM
    8zsFgUAo5jkHgCzsB5V2Q5N6XYX2veo3WfywnhV2OHrN8xLBECodxM09aiaO1zN7R+k780
    Q9KUglIq75DgRugyZRP8YDl3KFlnOp8Qm3bbUE7ljJZEWPz9zlzS+4hWSMxULkCZ3gTwi8
    v2K1itOsX+A0jEIbKYds7EgZcectBAfujot9nNFh5LF86Pgk0OqsAih1iMEiHC0XosUeQ7
    PuOkBvDW40STYvSilMPRNVsCYmQrr1Au9DDXecePCmBRKm/KqmxmWKukPd4PSnsSKAbMIr
    fdadLtvJP0ePLeQLcMYSOlcoqCgwN4qCuUCKOeZw1c6LDmXCDZW2ekYDPB/+q90qk0SLSZ
    v98U7babEe6TZ2FR4s2HWtkCV34rrPQVbTjQ6k6IlUSPcIEblFHZU/UYcA8tO6Vk6/gakK
    zXaIA2MfsGrsVRc/cplgkqOCw6YyzV7mG/mrQdNRxZjFbJA7IDcgs6AaosY1AAJfS4cLjk
    LYrlNGBR1mc+LdE3UDantyHLOksU9Qt55yD5oaSlT7lUnzMy4KBXH1Rzbc1Q
X-ME-Proxy: <xmx:CNc-alXGjnfm_u02VgLqePLCGXFP14YfQMItgqg1R2_pDjBofRvi7w>
    <xmx:CNc-al7-M_VMezPz4E8_LCZp-vxPe_VCUGCB35Fs41YAbuyLqxjq-Q>
    <xmx:CNc-apCl3h2PVPMXDBYJHmpQaXoSHgrN7qhvl0WpoxraV2bgVgF00w>
    <xmx:CNc-ai-QfQuiWgAHJcB9qGIQDY0cXwppNXSPw9YhG_WfVPEpiRtyfA>
    <xmx:Cdc-atY_COfgXRkXIhVsF0XQNYsIZGCZMpVaTE_tPYqlH5d2KYekUwsk>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jun 2026 15:46:16 -0400 (EDT)
Date: Fri, 26 Jun 2026 20:46:15 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, 
	Doug Anderson <dianders@chromium.org>, Petr Mladek <pmladek@suse.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, Breno Leitao <leitao@debian.org>, 
	Julien Thierry <julien.thierry.kdev@gmail.com>, Lecopzer Chen <lecopzer@gmail.com>, 
	Sumit Garg <sumit.garg@kernel.org>, kernel-team@meta.com, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] arm64: escalate smp_send_stop() to an SDEI NMI as
 a last resort
Message-ID: <aj7WqoMneJjzbo9B@thinkstation>
References: <cover.1781709543.git.kas@kernel.org>
 <cover.1781709543.git.kas@kernel.org>
 <97a870d0670b7e1c2fb9f5142f6e36c594282017.1781709543.git.kas@kernel.org>
 <aj6yGbnPDjUpboFZ@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aj6yGbnPDjUpboFZ@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260626_124619_479260_B238CC72 
X-CRM114-Status: GOOD (  16.55  )
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

On Fri, Jun 26, 2026 at 06:08:41PM +0100, Catalin Marinas wrote:
> On Wed, Jun 17, 2026 at 08:20:05PM +0100, Kiryl Shutsemau wrote:
> > +void sdei_nmi_stop_cpus(const cpumask_t *mask)
> > +{
> > +	unsigned int cpu;
> > +
> > +	WRITE_ONCE(sdei_nmi_stopping, true);
> > +
> > +	/*
> > +	 * Publish the flag before signalling. The SMC is a context-sync
> > +	 * event, not a barrier, so WRITE_ONCE() alone could let the store be
> > +	 * observed after the event it triggers. The barrier is cumulative: a
> > +	 * target that sees the event is guaranteed to see the flag.
> > +	 */
> > +	smp_wmb();
> > +
> > +	for_each_cpu(cpu, mask)
> > +		sdei_nmi_fire(cpu);
> > +}
> 
> The smp_wmb() is not sufficient here. In the GIC IPI code we use a
> dsb(ishst). It should be similar here. I think TF-A does this already
> but it's unclear from the SDEI spec that it is mandated.

You're right, I'll switch it to dsb(ishst) to match gic_ipi_send_mask().

And as you pointed, the xame fix is needed in 3/4: the backtrace path
publishes backtrace_mask before signalling and currently has no barrier
at all (as the bot spotted), so it needs the dsb(ishst) there too.

I'll also drop the now-incorrect "cumulative wmb" comment.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

