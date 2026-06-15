Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 091ADCD98C5
	for <kexec@archiver.kernel.org>; Mon, 15 Jun 2026 13:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jTtE9lrnx5uC8z75IcPqyJK9sU1cT8H25gmR36Q4LKw=; b=HtaOjiPtOokgo1ckpe2QoAnFT9
	BcObODNHgHcbrDagtOdii3azhLKcibpBThQgEu8mgBk3lGl9CkDTrhxHHji2msU6kOmBnBBPe4at0
	gQjYAQaQBjEojfZTTDY+aOLnt2Wv65/b/CUU6olJc/UaEdiJUuC3zBaUKgaIGsDsGXipM7habY+pw
	K8kYdWWF04KbhKkxr1TclSkJ6SbdCJ2N6Lj+ah8svANGAN04vo5E4bYJKBSDOPTNR/Xq29amPqkki
	dR/e7CZmTcSEAg+xcoJZGB2An+Q3Jnu14iwWMoEAT5X9O3vI9cg29hYe1GjJu0lrsyQs1SdUHw0EF
	AnnCcPTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZ7AT-0000000EH04-1jMJ;
	Mon, 15 Jun 2026 13:15:57 +0000
Received: from fout-b4-smtp.messagingengine.com ([202.12.124.147])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZ7AO-0000000EGzH-3iO4;
	Mon, 15 Jun 2026 13:15:55 +0000
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 5935E1D00161;
	Mon, 15 Jun 2026 09:15:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 15 Jun 2026 09:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1781529350; x=1781615750; bh=jTtE9lrnx5uC8z75IcPqyJK9sU1cT8H2
	5gmR36Q4LKw=; b=bh80GIKOD6TpGbAbFedvF+e1EjuiXmMsI3kDD27SUWIM6j4T
	TZOcPvqW/vCVSSzH+wR9LqeWaWAfFHFGQnqa8Kh1f+qrYh7d5fXBbMivQPCqIwN2
	gacXZz60snBirdGRvpgUl3inmlhoDnDQBCDEE51oHUsX5r/cUjKMyKDiRIlppxu+
	eyCMUCHbeNB2xtJ3cSHlGCHCOieebXL6z1u89UKcdL73Z3DAZhlP6dpBblf2ogLB
	a8dMiDcaSqa0UtjR6HNL7AwfSoEPnQlVp+G1AY8/S872IdO/RciMKEE4BwhP4Uar
	3QK0nWnyNQKzYTs5Vzegy47rsP0ziufutfzkkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781529350; x=
	1781615750; bh=jTtE9lrnx5uC8z75IcPqyJK9sU1cT8H25gmR36Q4LKw=; b=G
	Ca74JLks8TG82uXOK5P9tNJ/NcO372iarftNXObxcstVwaq/jQeQ8mM5lFKV50Xt
	Mam2mKIXlLtO1gbtFcZ8wfRGgQHW2bY+twnRdrPRbaS5UHi2RLhD2iTQdBVI5wGI
	wC3zR+OuLJvXZFpjjTjVQ9ALrbkCiUPpAx6CtE6rjRKfIW1Fjourwl2eQcO3W0y2
	F+NLdgqDdAtRA+NxeM5oR84vrmxWCpHc/YyQ6AoWzjiLGFeY3R26AA1TagoFi1H1
	fhOAn855blXKSIra9QCQqSlaIizQCLq+CWehk+QxNJpPLUZmDlEo0bA+KaI3T453
	xEivSc2xv8Ulo2Y0J8nwg==
X-ME-Sender: <xms:BfsvandY2K7udjXCzeDEFdpaK5Pkgk64faSzt_8pHRfY-5z9s3qETg>
    <xme:BfsvagWXcGSajf6tZnbqTWNEu3cmh59nj7VQoufSZde7MJG89p7E5WKETU4scjCSC
    Qs2o0isTtRxmTLuHzCtIF18p6YXkLqhqxDhqJ6VIUZCHl_0gjt4BA>
X-ME-Received: <xmr:Bfsvat9ce56Be3GMy5mjMK9Jcp3XZo33QZuX5q-_6-JtuR6VrNs8BkL76xQrkQ>
X-ME-Proxy-Cause: dmFkZTGq9iF/E59Wrvbj3f2NyjHhNlVG9P3TNhxNGhjbPyje0c0j/bHfzdLLcj4Ikn3VrU
    IBXKWJGCZpVQuLasDktveERN2dmbTavlxxG0O7j9lHC/PUXZkTaMw1tRQG6Mbc1U1pMN07
    /R4zFfaauiyBHgvk9bGC+CzUtp4HbRluWT+h+odERTddFxjarMYl23f6DhnwTJb+anDY38
    apd4Loxk24kQ3pZ/6fZvkhQhI1faT6cRKv1CRlGDf87miOdhDoP+H+t2nw9tJQPGZkpH9L
    qna7VebVAF6H7dM96kjrjE1J9hqTA5/M3Tc+qDNua6bEZVbc33RHtqdBmunn/2z3PU40qY
    jaHwH/Kwsag/5BQlN7KZJcJMTClJNomr4tp0mdvyS4ncCCxh8YHEjVelAOwPyIZVE923dn
    FI7SYEBlB+XGeHANW0bx0tAO9Sz0NM+APDqj8SJLiBdGh48DCTgCww8+hu847LskxAeOhS
    JWFLkdFkCKOC/QjDxos2tDB6zvGQncaOyoUDyHxfL4q4ibImyLCphiNvGX8hWEABmah8g7
    5RGNVfQRlaGSgXj5Rok5XsebJFuAvIPQwSmKm6sUq361UEux6Bnu/C1WZ5HkoWDXzlgdf1
    wecal23kGbAFTT9B6p8RzVt6+gwVYK9n6KRMp1s3uNW7Se00YL9yvJ3LIIbg
X-ME-Proxy: <xmx:BfsvathjrV6XJQRlT7aGXI89mFwXAYHsS7IaTIQSp_d4SLz3aJikjA>
    <xmx:BfsvaiXBhK1RcD3Ls7YbII1sFQdy3Ilcz7AitvCCPMt0JMneK-cu3g>
    <xmx:BfsvaktetEgjU7_PVKIfuZ044ECzfH7qq8OGESKU_fqveS73HVEl9Q>
    <xmx:Bfsvas452cKH6I1pUQxFFpMVH0AiFwZlmm0Lrj_pMmtjURwCvlZ8_g>
    <xmx:Bvsvai0rG29oRb_Nd3ZzNOKekKxmyjOMyINjgZLKnwRNkaCkC-MtgWus>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 09:15:46 -0400 (EDT)
Date: Mon, 15 Jun 2026 14:15:40 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, 
	Doug Anderson <dianders@chromium.org>, Petr Mladek <pmladek@suse.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Usama Arif <usama.arif@linux.dev>, 
	Breno Leitao <leitao@debian.org>, Julien Thierry <julien.thierry.kdev@gmail.com>, 
	Lecopzer Chen <lecopzer@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, kernel-team@meta.com, 
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] drivers/firmware: add SDEI cross-CPU NMI service
 for arm64
Message-ID: <ai_6pkm7fA8MLuV1@thinkstation>
References: <cover.1781490440.git.kas@kernel.org>
 <704b467d5b320da9cf49fc9bb4a6814063986f3b.1781490440.git.kas@kernel.org>
 <CANk7y0iBTYuhzLTJAX0yf8Cp8cyThOVpAQYMTDN9LZUKGThqJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANk7y0iBTYuhzLTJAX0yf8Cp8cyThOVpAQYMTDN9LZUKGThqJQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260615_061553_016125_5A68655A 
X-CRM114-Status: GOOD (  47.70  )
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

On Mon, Jun 15, 2026 at 12:18:10PM +0200, Puranjay Mohan wrote:
> On Mon, Jun 15, 2026 at 4:35 AM Kiryl Shutsemau <kirill@shutemov.name> wrote:
> >
> > From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> >
> > Deliver an NMI-like event to an interrupt-masked arm64 CPU via the
> > standard SDEI software-signalled event (event 0), without the pseudo-NMI
> > hot-path cost: register a handler for event 0 and poke a target with
> > sdei_event_signal(0, mpidr).
> >
> > First user is arch_trigger_cpumask_backtrace() (sysrq-l, RCU stalls,
> > hung-task/soft-lockup dumps), which otherwise rides an IPI that can't
> > reach a masked CPU. Falls back to the IPI path when SDEI is absent; no
> > watchdog backend yet, so the stock detector is untouched.
> >
> > Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >  MAINTAINERS                     |   2 +-
> >  arch/arm64/include/asm/nmi.h    |  24 +++++
> >  arch/arm64/kernel/smp.c         |  11 +++
> >  drivers/firmware/Kconfig        |  19 ++++
> >  drivers/firmware/Makefile       |   1 +
> >  drivers/firmware/arm_sdei_nmi.c | 149 ++++++++++++++++++++++++++++++++
> >  6 files changed, 205 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/arm64/include/asm/nmi.h
> >  create mode 100644 drivers/firmware/arm_sdei_nmi.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index c8d4b913f26c..b5ddfb85dce9 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -24797,7 +24797,7 @@ M:      James Morse <james.morse@arm.com>
> >  L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> >  S:     Maintained
> >  F:     Documentation/devicetree/bindings/arm/firmware/sdei.txt
> > -F:     drivers/firmware/arm_sdei.c
> > +F:     drivers/firmware/arm_sdei*
> >  F:     include/linux/arm_sdei.h
> >  F:     include/uapi/linux/arm_sdei.h
> >
> > diff --git a/arch/arm64/include/asm/nmi.h b/arch/arm64/include/asm/nmi.h
> > new file mode 100644
> > index 000000000000..9366be419d18
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/nmi.h
> > @@ -0,0 +1,24 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __ASM_NMI_H
> > +#define __ASM_NMI_H
> > +
> > +#include <linux/cpumask.h>
> > +
> > +/*
> > + * Cross-CPU NMI provider hooks, consulted by the arm64 arch code before
> > + * its regular-IRQ / pseudo-NMI IPI paths. The SDEI provider in
> > + * drivers/firmware/arm_sdei_nmi.c implements them when active; a future
> > + * FEAT_NMI provider could slot in here too. The stubs let callers stay
> > + * unconditional when ARM_SDEI_NMI is off.
> > + */
> > +#ifdef CONFIG_ARM_SDEI_NMI
> > +bool sdei_nmi_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu);
> > +#else
> > +static inline bool sdei_nmi_trigger_cpumask_backtrace(const cpumask_t *mask,
> > +                                                     int exclude_cpu)
> > +{
> > +       return false;
> > +}
> > +#endif
> > +
> > +#endif /* __ASM_NMI_H */
> > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> > index 1aa324104afb..a670434a8cae 100644
> > --- a/arch/arm64/kernel/smp.c
> > +++ b/arch/arm64/kernel/smp.c
> > @@ -45,6 +45,7 @@
> >  #include <asm/daifflags.h>
> >  #include <asm/kvm_mmu.h>
> >  #include <asm/mmu_context.h>
> > +#include <asm/nmi.h>
> >  #include <asm/numa.h>
> >  #include <asm/processor.h>
> >  #include <asm/smp_plat.h>
> > @@ -927,6 +928,16 @@ static void arm64_backtrace_ipi(cpumask_t *mask)
> >
> >  void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu)
> >  {
> > +       /*
> > +        * Prefer the SDEI cross-CPU NMI provider when active: firmware
> > +        * dispatches the event out of EL3 and reaches CPUs that have
> > +        * interrupts locally masked, without the per-IRQ-mask cost that
> > +        * pseudo-NMI pays for the same reach. The plain IPI path below
> > +        * can't reach such a CPU unless pseudo-NMI is enabled.
> > +        */
> > +       if (sdei_nmi_trigger_cpumask_backtrace(mask, exclude_cpu))
> > +               return;
> > +
> >         /*
> >          * NOTE: though nmi_trigger_cpumask_backtrace() has "nmi_" in the name,
> >          * nothing about it truly needs to be implemented using an NMI, it's
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
> > +
> >  config EDD
> >         tristate "BIOS Enhanced Disk Drive calls determine boot disk"
> >         depends on X86
> > diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
> > index 4ddec2820c96..be46f1e1dc77 100644
> > --- a/drivers/firmware/Makefile
> > +++ b/drivers/firmware/Makefile
> > @@ -4,6 +4,7 @@
> >  #
> >  obj-$(CONFIG_ARM_SCPI_PROTOCOL)        += arm_scpi.o
> >  obj-$(CONFIG_ARM_SDE_INTERFACE)        += arm_sdei.o
> > +obj-$(CONFIG_ARM_SDEI_NMI)     += arm_sdei_nmi.o
> >  obj-$(CONFIG_DMI)              += dmi_scan.o
> >  obj-$(CONFIG_DMI_SYSFS)                += dmi-sysfs.o
> >  obj-$(CONFIG_EDD)              += edd.o
> > diff --git a/drivers/firmware/arm_sdei_nmi.c b/drivers/firmware/arm_sdei_nmi.c
> > new file mode 100644
> > index 000000000000..a82776e7b55a
> > --- /dev/null
> > +++ b/drivers/firmware/arm_sdei_nmi.c
> > @@ -0,0 +1,149 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * arm64 SDEI-based cross-CPU NMI service.
> > + *
> > + * Delivering an "NMI-shaped" event to an EL1 context that has locally
> > + * masked interrupts, on silicon without FEAT_NMI, can be done two ways:
> > + *
> > + *   - pseudo-NMI: mask "interrupts" via the GIC priority register
> > + *     (ICC_PMR_EL1) instead of PSTATE.DAIF, leaving a high-priority band
> > + *     deliverable. Functionally this works -- but it reimplements every
> > + *     local_irq_disable()/enable() and exception entry/exit as a PMR
> > + *     write plus synchronisation, a cost paid on that hot path forever,
> > + *     whether or not an NMI is ever delivered.
> > + *
> > + *   - SDEI: leave interrupt masking as the cheap PSTATE.DAIF operation
> > + *     and have the firmware bounce an EL3-routed Group-0 SGI back to
> > + *     NS-EL1 as an event callback. The cost is a firmware round-trip,
> > + *     but only at the rare moment delivery is actually needed.
> > + *
> > + * This driver takes the second path: it keeps the IRQ-mask hot path
> > + * free and pays only when it fires, which is what makes cross-CPU NMI
> > + * affordable on hardware where the pseudo-NMI tax isn't, until FEAT_NMI
> > + * makes NMI masking cheap in the architecture itself.
> > + *
> > + * Capabilities provided:
> > + *
> > + *   - sdei_nmi_trigger_cpumask_backtrace() — override for arm64's
> > + *     arch_trigger_cpumask_backtrace(), so sysrq-l, RCU stall dumps,
> > + *     hardlockup_all_cpu_backtrace, soft-lockup/hung-task secondary
> > + *     dumps all reach interrupt-masked CPUs.
> > + *
> > + * Delivery uses the standard SDEI software-signalled event (event 0) and
> > + * SDEI_EVENT_SIGNAL. We register a handler for event 0, enable it, and
> > + * poke a target CPU with sdei_event_signal(0, mpidr): firmware makes
> > + * event 0 pending on that PE and dispatches the handler NMI-like,
> > + * regardless of the target's DAIF.
> > + * Availability is simply whether event 0 registers and enables -- if SDEI
> > + * and its software-signalled event are present we use it, otherwise the
> > + * driver stays inert.
> > + */
> > +
> > +#define pr_fmt(fmt) "sdei_nmi: " fmt
> > +
> > +#include <linux/arm_sdei.h>
> > +#include <linux/cpumask.h>
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/kprobes.h>
> > +#include <linux/nmi.h>
> > +#include <linux/printk.h>
> > +#include <linux/ptrace.h>
> > +#include <linux/smp.h>
> > +#include <linux/types.h>
> > +
> > +#include <asm/nmi.h>
> > +#include <asm/smp_plat.h>
> > +
> > +static bool sdei_nmi_available;
> > +
> > +#define SDEI_NMI_EVENT                 0
> > +
> > +static int sdei_nmi_handler(u32 event, struct pt_regs *regs, void *arg)
> > +{
> > +       /*
> > +        * nmi_cpu_backtrace() no-ops unless this CPU's bit is set in the
> > +        * global backtrace mask (driven by nmi_trigger_cpumask_backtrace()),
> > +        * so a fire that reaches a CPU not being backtraced is harmless.
> > +        */
> > +       nmi_cpu_backtrace(regs);
> > +       return SDEI_EV_HANDLED;
> > +}
> > +NOKPROBE_SYMBOL(sdei_nmi_handler);
> > +
> > +static void sdei_nmi_fire(unsigned int target_cpu)
> > +{
> > +       int err = sdei_event_signal(SDEI_NMI_EVENT, cpu_logical_map(target_cpu));
> > +
> > +       if (err)
> > +               pr_warn("SDEI_EVENT_SIGNAL to CPU %u failed: %d\n",
> > +                       target_cpu, err);
> > +}
> > +
> > +/*
> > + * Raise callback for nmi_trigger_cpumask_backtrace(): signal event 0
> > + * at every CPU still pending in @mask. The framework excludes the local
> > + * CPU from @mask before calling us.
> > + */
> > +static void sdei_nmi_raise_backtrace(cpumask_t *mask)
> > +{
> > +       unsigned int cpu;
> > +
> > +       for_each_cpu(cpu, mask)
> > +               sdei_nmi_fire(cpu);
> > +}
> > +
> > +/*
> > + * Override hook for arch_trigger_cpumask_backtrace() (see
> > + * arch/arm64/kernel/smp.c). Returns true when SDEI handled the request,
> > + * which is the case whenever SDEI is active; on a false return the arch
> > + * falls back to its regular-IRQ (or pseudo-NMI, if enabled) IPI.
> > + *
> > + * On a kernel built without paying the pseudo-NMI hot-path cost (the
> > + * usual case for this driver's target), the IPI can't reach a CPU that
> > + * has interrupts masked -- so the backtrace of the one CPU you care
> > + * about comes back empty. SDEI is dispatched out of EL3 and lands
> > + * regardless of the target's DAIF, without taxing the IRQ-mask path.
> > + */
> > +bool sdei_nmi_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu)
> > +{
> > +       if (!sdei_nmi_available)
> > +               return false;
> > +
> > +       nmi_trigger_cpumask_backtrace(mask, exclude_cpu,
> > +                                     sdei_nmi_raise_backtrace);
> > +       return true;
> > +}
> > +
> > +/*
> > + * device_initcall (after arch_initcall(sdei_init), so the SDEI subsystem
> > + * is up): probe the firmware, register the event, and turn on the
> > + * cross-CPU service. If the probe fails the driver stays inert and the
> > + * override hooks decline, leaving the arch's own paths in place.
> > + */
> > +static int __init sdei_nmi_init(void)
> > +{
> > +       int err;
> > +
> > +       err = sdei_event_register(SDEI_NMI_EVENT, sdei_nmi_handler, NULL);
> > +       if (err) {
> > +               pr_err("sdei_event_register(%u) failed: %d\n",
> > +                      SDEI_NMI_EVENT, err);
> > +               return 0;
> > +       }
> 
> This initcall runs unconditionally whenever ARM_SDEI_NMI is built in,
> which includes the many arm64 systems that have no SDEI at all. On
> those, sdei_event_register() -> sdei_event_create() ->
> invoke_sdei_fn() returns -EIO, and the core already complains:
>     pr_warn("Failed to create event %u: %d\n", event_num, err);

Fair enough. I will add sdei_is_present() and gate sdei_nmi_init() on
it.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

