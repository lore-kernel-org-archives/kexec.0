Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E89ACD98E2
	for <kexec@archiver.kernel.org>; Wed, 17 Jun 2026 15:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=329EFRDqzROnZ+um2EYZ/sgk7lK0yO4Of5gjiVQoqCY=; b=13khWO9vzjTIJ6P5PsiRgekn4L
	lqItVE8K7QmmBR4ctlc1B/cf6KHkkk3x+kGEwxNwbsMG5jb7KXQfcn8CNinjyQE44rZo7GwJ0moYU
	JAov1DWNb9hyKFu+bvaL5Hb+JNWjsJTvjd99p20MYrbVMv+Et6VnKcBKQEoLp6i/SKfGj78QE91RT
	7co62DvjKnj2Ff9Xcc3ZcIsN4f1tkQe//mQ623bGoF7rEnOfy5X/UKCLHlfrSGKjI9bGrAK5RX6g9
	P37kq078qq4JfqZd3+O50lRl2WIzPRNKIWQEaNVa4n1JBpPwqqHtO14wsne+sgHn0EUssxch/rpmc
	Vg9Kge3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZrrQ-0000000HWnn-2kUm;
	Wed, 17 Jun 2026 15:07:24 +0000
Received: from fhigh-b5-smtp.messagingengine.com ([202.12.124.156])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZrrN-0000000HWnJ-3dFW;
	Wed, 17 Jun 2026 15:07:23 +0000
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8ACBE7A0126;
	Wed, 17 Jun 2026 11:07:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 17 Jun 2026 11:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1781708837; x=1781795237; bh=329EFRDqzROnZ+um2EYZ/sgk7lK0yO4O
	f5gjiVQoqCY=; b=UQAJ2yL1P+ASFFm6ATRMzHKvl1utylIcRlpPxFAAqOjXU+RM
	3wgu6C6hue+SwMQk7KPxzDR+X2GtjaZR5QR4xRM3r+quDOVaPUDIU31qcevOVHXi
	+3TSzvcKT/3grnaKsWfubkjhqkNt9HBVfY0VXqF8lVO8paBiS7VnoGJydAAqfUEU
	xXQY2lmIdzuMU7q/T8/BezBNN4CvCdA7WQNdP+obdo8b3iFlckXc6XLRf78PYN0M
	OdsQG8oPn0oserExiIcgphaFHAMebeFl7rdFDu00sFYveAee2ndJCIGsb3Ani+r/
	SoN0OsISh/IztOnKwLJhy0SAOSKIBE8n+Uq05A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781708837; x=
	1781795237; bh=329EFRDqzROnZ+um2EYZ/sgk7lK0yO4Of5gjiVQoqCY=; b=D
	3Zr5o+vci0dehxi0qn5lRP+rzb8Wzz7gFxXL61FWmHui6MTwo9ynBBLEGRK/k+5T
	TnKlVXyy3C9PVk6/6bJipFeUPn4f01FqYstgVkUKqqQ4gJFq7BsHu9SNlt1rgwZL
	wTELvt/CCbWcRZe+5R6fNyiQlLF3VjwPdyekxYNnT+eae+V4UYn8nIBWMfCoWdT2
	yY3MF7/bQzDB4UoBQk3+i7kh5RqV9Ir0yEw98dzQU2yfntRY9rypqKrgGbTxIA3S
	kdmQERafK5DRglP6odFInRQRLxCvfrImhHCI1zdV34+x1exWsVkUgMMf9uxetjg+
	ZSJU+fUVvEGIEwBQ+p2RQ==
X-ME-Sender: <xms:JLgyaktfBHJwTo1l8Jep1iKyf4X5Zphytv-WiGHSoCOQ6UOZgGVxIA>
    <xme:JLgyakn3wS_GzRn6iFepMf-9Xd7lpWA2JMENZZM7P6c0CaY1BiqGg2u0LRDG7nV7k
    TSiiniil1lwG2A0yRh2VUlb_2bZGNb2CPw9HbH2RRWIQ715b5Qjjos5>
X-ME-Received: <xmr:JLgyatNxTgMrgg2YpzI0fck1K9z5BdDDM3TWPsUOm2D5pkOwHeS-KhTw-ArEfw>
X-ME-Proxy-Cause: dmFkZTEEu0tieGgjfSoFYH7SZTLMospZf0X29ieHf2Cms5WHFP9sCH2U6lygDU8tZTUi1D
    y7jdlijROYk9RiNv+PRHa/mwW8lqsO03PtCMfo1gv5Tz6Xao5z9yyG1zr0GjMjRdLyAP4+
    xZ8J2UOJpRihZmffAWvCVDECM3i6MxaxZ7jK8QNK94MQ0awHDRYP9V4vRDmirodEdFAeKK
    E/YjYui6fNSubEWL2LTlqZqDSCSXe772OC9pjFicyjp6CjoJ9Tfhl68TZ47J/41scSfO72
    HOX937aiUJaNPMEaFB/R9ZFHKSYJUZNoquCFDlyBsMlV6fGTqdaCfuowNj1Cv1shrZ8qBp
    QUDWVwqeO9/XINwi2IwvT6/e8CTTqpesOZlCoOj4Smm4DOJuaHL9dwSUAM7orxYswdKJ6Y
    zHNEreSxrgiAsnhG/ZKkj8CgnrD3gw6DU11n4u8ykwUB850TlmucJkr4koBbgwLzqszwXj
    Cc96dknw2AyFCUq0Bg5j3x5pN3HQ743L2xqMauwjLAHc92WOHJPBBpQk8wCT7jMtvO91jb
    20h7msK7uAvmBccexm/eBehdR0b3KSI8zVPTYkPHQfygryRjTqJfgpY23dvENTYabN/9bk
    wnS5kOD1jXpFg3RAqeKE8yeg8hsp07J8pZEovvZ5WjfQi2n/a1+TmR9CLNFA
X-ME-Proxy: <xmx:JLgyaryHUNpie_Tw2OWniKLXSJp1rDL4U1zlc6hgk__THh0plo51iQ>
    <xmx:JLgyajnhabJ2-u_MrXXQxnubsUtN7CpM4xB5UTBqw_RqkY3MG9npuw>
    <xmx:JLgyas_-hCPG7o8lSKA_7ZTlF6GMFxriDWZx99t0ubjIdHB-QyZs1w>
    <xmx:JLgyagIqlM9kmaKxTSR05nzq6JD36d-nsWCviNXS3Eg1_2llTUJuVg>
    <xmx:JbgyailrJTy48XgJbCs8b_ytOBTcTBxT5GmTZ8BsYyJDdiGMe7XOjqjw>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 11:07:14 -0400 (EDT)
Date: Wed, 17 Jun 2026 16:07:08 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Doug Anderson <dianders@chromium.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, Breno Leitao <leitao@debian.org>, 
	Julien Thierry <julien.thierry.kdev@gmail.com>, Lecopzer Chen <lecopzer@gmail.com>, 
	Sumit Garg <sumit.garg@kernel.org>, kernel-team@meta.com, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] arm64: escalate smp_send_stop() to an SDEI NMI as
 a last resort
Message-ID: <ajK1fQlmgww1PY1a@thinkstation>
References: <cover.1781490440.git.kas@kernel.org>
 <167493d30ef6c99a44291de14cddd41ced8149c4.1781490440.git.kas@kernel.org>
 <CAD=FV=WK0=xTZOWK+yDqEtGbbhkvoW50ekHKBBWhpoO9Zb8cBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=WK0=xTZOWK+yDqEtGbbhkvoW50ekHKBBWhpoO9Zb8cBQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260617_080722_238811_8965AA5E 
X-CRM114-Status: GOOD (  28.16  )
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

On Tue, Jun 16, 2026 at 02:38:16PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Sun, Jun 14, 2026 at 7:36 PM Kiryl Shutsemau <kirill@shutemov.name> wrote:
> >
> > +/*
> > + * Bring the local CPU to a stop, saving its register state into the vmcore
> > + * on the kdump crash path first. The single point every arm64 stop path
> > + * funnels through, so the bookkeeping (mask interrupts, mark offline, mask
> > + * SDEI, optionally power off) lives in one place:
> > + *
> > + *   - the regular IPI_CPU_STOP and pseudo-NMI IPI_CPU_STOP_NMI handlers;
> > + *   - panic_smp_self_stop(), a CPU parking itself on a parallel panic();
> > + *   - the SDEI cross-CPU NMI handler (drivers/firmware/arm_sdei_nmi.c),
> > + *     which reaches CPUs the stop IPIs could not.
> > + *
> > + * @regs is the register state to record in the vmcore on a crash stop; NULL
> > + * means "capture the current context". @die_on_crash decides the kdump crash
> > + * path: the IPI stop handlers pass true and power the CPU off (PSCI CPU_OFF,
> > + * via __cpu_try_die()) so a capture kernel can reclaim it. The SDEI handler
> > + * and panic_smp_self_stop() pass false and only park. For SDEI that is
> > + * required, not just conservative: it runs inside an SDEI event that is
> > + * deliberately never completed (completing it has firmware resume the wedged
> > + * context), and a CPU_OFF from that not-yet-completed context wedges EL3 on
> > + * some firmware -- a documented follow-up. Parking also matches this path's
> > + * own fallback when CPU_OFF is unavailable.
> 
> Nice to have all the details in the function comment. Any reason why
> you didn't use kernel-doc format? Nothing else in this file does, I
> guess, but it doesn't seem like it would be a problem to start the
> trend... ;-)

No reason -- switched it to kernel-doc in v4.

> > +       if (READ_ONCE(sdei_nmi_stopping)) {
>
> Don't you need a smp_rmb() before that, to match with the smp_wmb()?

No -- there's nothing for it to pair against. An smp_rmb() orders a
flag-load before a later *data*-load (the message-passing pattern), but
the flag is the only value shared here: the handler reads
sdei_nmi_stopping and nothing else published through it. crash_stop,
which the stop path reads afterwards, was written before the flag, so
reordering the reads can't expose a stale value either.

And the handler isn't spinning on the flag: it runs only because firmware
delivered the SDEI event, which is a full round-trip (SMC -> EL3 -> GIC ->
exception entry) strictly after sdei_nmi_stop_cpus()'s
WRITE_ONCE() + smp_wmb() + signal. By the time the read executes the store
is already globally visible -- there's no window for a stale read. The
publish-before-signal barrier is the half that matters.

The IPI core does exactly this. gic_ipi_send_mask()
(drivers/irqchip/irq-gic-v3.c) issues dsb(ishst) -- "stores to Normal
memory ... visible to the other CPUs before issuing the IPI" -- before
sending the SGI, and no IPI handler takes a matching read-side barrier. I
use an explicit smp_wmb() only because the SDEI signal goes through an
SMC, which carries no such barrier, where gic_ipi_send_mask() bakes it
into the SGI send. The backtrace framework this driver plugs into is the
same shape: nmi_cpu_backtrace() reads backtrace_mask -- set by
nmi_trigger_cpumask_backtrace() before raise() -- with no smp_rmb().

A bare smp_rmb() with no second load to order would just be confusing, so
v4 adds a comment at the READ_ONCE() explaining why there isn't one.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

