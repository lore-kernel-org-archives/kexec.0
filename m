Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386DECD98DE
	for <kexec@archiver.kernel.org>; Mon, 15 Jun 2026 12:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7BFd/C+LGzIrhHxcsQRAWbDvoNEQUDbCWwCmbSMMnP8=; b=VADPic39dGB3JkhEagTmQ63rAb
	lD0PNmxfuXA1HI7Vz14biE8ix44Xvek5H2o/GYf+GlV4lhRyuU8L0eXNRvpCQS4LYxTQMyAV9T44O
	KJDHiKFVzczbP3GsN1CvgNLd5T0kyoLzDSRNjj8GJ3m/LUHB38r7JzzOTcF/UIpKpZFe7V0DkSKMS
	eVweo4y+PQJokszbxiC+qfQhz3pZRtF/Dx1goOtU1wpBW9r4VTRDRYAH+0SCKJE2qAZROjSoajSBl
	L7Kye2b2RRLtrjD34RWHvkwlAjn/Iak9iRfCjVBZyjzA2mtkg0cwA7wS6XoccVkvZYBTt9ZbnxKPP
	DkwdACZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZ6hs-0000000EEKi-2nme;
	Mon, 15 Jun 2026 12:46:24 +0000
Received: from fhigh-b6-smtp.messagingengine.com ([202.12.124.157])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZ6ho-0000000EEK2-3qAb;
	Mon, 15 Jun 2026 12:46:22 +0000
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7766C7A0102;
	Mon, 15 Jun 2026 08:46:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 15 Jun 2026 08:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1781527578; x=1781613978; bh=7BFd/C+LGzIrhHxcsQRAWbDvoNEQUDbC
	WwCmbSMMnP8=; b=ehvkWgxo68n2mrDJB+tq9gZqoZQ1/uyVf/x4Ey/MEesgcOe0
	oc4Iv4RrNVV+l2aePqEHrjbF9O8T/Hxtc2Ao34JX4xmjVKhhLUpbKQIkRLQgsVkg
	SGo2/h7kPxwtBLnsppLLxAUp9t/6SHoFVY1li6WinW8slbtI0JsrnGiVcgi/eGSs
	nb9zYalRrR/Z2Z3HyGxiyOGe6oHXYRR3S9ypD4hiZ7rEKTctGUCfeh+iO7FWtcPG
	7omvgRcMLFtb5BQC7Bw6J0fPwuqtVNfpcXyflViloDtduF8beKvmzuBX0eBdJ6wU
	7aro8XS0KNIOgk7DMDEgLjLJHDTOXmRFnnFTPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781527578; x=
	1781613978; bh=7BFd/C+LGzIrhHxcsQRAWbDvoNEQUDbCWwCmbSMMnP8=; b=S
	XDXxUPmGhkZwjER/8+M8sXol0eV8VMX+OpZNTKn0AnK01OF2kjKZKtFs5pSDz7nc
	Cd4+aJpri37fQDZPQfpK+nTL0DyZGa6qvDtWOoo3i8DvIj7vs/aTEQQqop83TqyZ
	l0rASZHoU0mOmUY14jnOm3/uQXsKvFeaT/awyrPB1D/MqQ0fsOEoFFBb8ON/Xbwv
	GZliY3YCwzAq6HWl2RbYpi+qWW3JQ8Iu40i7UtC86fejQ77kNY7LNbp0bWtu5n+H
	lDnHHbe5487l3W6F8U0XuIAZKvnzBLusbwlvzhKbHccT3iIG9lXc0ZHBMFNxdQDh
	OLU3B2m49/QbRKLQHy5Kw==
X-ME-Sender: <xms:GfQvav7nPcrL59PbcxfP0NdGFjWRHfmqaqvM_3vJPkJ3cNMqy1UZmA>
    <xme:GfQvauSMMgF12YYOMEf9I3oAjfOFAzhkWK6ya0d7MyJINwyvZ5h3eDG9uvnVcncfV
    I6vla1HJhvD-llpQ78cGfy_o5Xm0X5C5tHYFDoDuhPaYelIKCz-L4M>
X-ME-Received: <xmr:GfQvavlTbZZnF70HCzshcDD4m2ahs3fi9gCUyCGSWBEwVneLyqjuXPYF-wRPVA>
X-ME-Proxy-Cause: dmFkZTFDAbCUEEpizoPFZmYJBZpsEOF27lKWinOZ6usqRYxhpuZNnJxuvwqf4rK9Xmk2fo
    koJtZ1bNfxhpJ/NhILPqaRECs6xlYFthYH9+FG0l+tI1a8U+x0PZLdOM+5vclETqQ+zOaK
    HECtWZ7lN7uA4lqSsYD7Wz524bCHzrBW85DkKw9d73yVFkcTCyE17jOX2HakuAvORJ2KwA
    1cNxaAOdpSCxk6ikhX38HuqHc9AHNI5Ox1DoGs4RTLRDR7Kp5PyqZm6LsPztovwFMNas3+
    mDYG9FfbxgJUUjmSeWCiOKQdwzRYw/GPIglMVI0NSMONERiy+z10jnjjunkwQTWnfafZNI
    lw6ohsvpHppU3Y16PG6ZHruk4BnoSyJlO05vu5BZAEJKw1iYCPEFGmR4yVbXrwJ87Q6N5O
    t9hpoqsTG0aIdjZGzL5QUdJHgLQOOrxWgma7soo4GH5Aee3cMiW9FpBvWEYXx3n9vrIJmH
    CHPIKtV7nv2f2QxkNIDr6V5l0Y52EjedPXG8pmQnoAVKyGufSYLZ5ww4444mLsz+CT+Nvh
    ZCPaSLyB5ykoQWaUAGLWAOGYpxZANl4Tz8ZTKvHVVVCsj4XyaJAaFPbEl84+jtsjozI+Qp
    QPQthYP67jcC682knBUr8347QF4CQerfMWbpK3oS2+v+YuzRPCcnDaMMYWxg
X-ME-Proxy: <xmx:GfQvajKlZ9g8FXQo6kkozGFjCS4q3QiHLiM1VkDkAocMktGbNmTeXA>
    <xmx:GfQvatQlL-awznEhuC9otmstl6flVm6WOWXWzKyfkeRDriRULkXMlw>
    <xmx:GfQvaiNFsd-_py_O8-OTpgD6Ev8F_725h13TbxIkksE4A356UiVg0g>
    <xmx:GfQvamZ3dGnOrYoYEFnnrZbVb7fWiroimjZ1YGZc8D_UUmR418dZYA>
    <xmx:GvQvat4sJPtdLsQst2lzrBxHA6yMEIwxS3ostJwGv0qlCZEHU25mDIIy>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 08:46:14 -0400 (EDT)
Date: Mon, 15 Jun 2026 13:46:07 +0100
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
Subject: Re: [PATCH v3 3/3] arm64: escalate smp_send_stop() to an SDEI NMI as
 a last resort
Message-ID: <ai_yEtDjI0e8sBBD@thinkstation>
References: <cover.1781490440.git.kas@kernel.org>
 <167493d30ef6c99a44291de14cddd41ced8149c4.1781490440.git.kas@kernel.org>
 <CANk7y0irTcfVrKXBd1L7tLRyDpNJ1cRhwKG7x42XbKgJy+ACeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANk7y0irTcfVrKXBd1L7tLRyDpNJ1cRhwKG7x42XbKgJy+ACeA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260615_054621_322952_716876AE 
X-CRM114-Status: GOOD (  49.64  )
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

On Mon, Jun 15, 2026 at 12:25:17PM +0200, Puranjay Mohan wrote:
> On Mon, Jun 15, 2026 at 4:36 AM Kiryl Shutsemau <kirill@shutemov.name> wrote:
> >
> > From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> >
> > A CPU wedged with interrupts masked ignores the stop IPI, and without
> > pseudo-NMI there is no NMI IPI to escalate to: a reboot proceeds with
> > the CPU still running, and a kdump misses its registers.
> >
> > Add a third rung to smp_send_stop(): once the IPI (and pseudo-NMI IPI,
> > if enabled) rungs have run, signal SDEI event 0 at whatever stayed
> > online. Firmware delivers it regardless of the target's DAIF, so it
> > reaches a CPU a plain IPI cannot; the target acks by going offline,
> > which the caller already polls for.
> >
> > Fold the stop bookkeeping into one arm64_nmi_cpu_stop(regs,
> > die_on_crash), shared by the stop IPI handlers, panic_smp_self_stop()
> > and the SDEI handler, replacing the near-duplicate local_cpu_stop() and
> > ipi_cpu_crash_stop(). @die_on_crash is the only difference: the IPI
> > handlers pass true and PSCI CPU_OFF the CPU on a crash stop so a capture
> > kernel can reclaim it; the SDEI handler and self-stop pass false and
> > park. The SDEI park is required, not conservative -- its handler runs
> > inside an SDEI event that is never completed (completing it resumes the
> > wedged context), and a CPU_OFF from that unfinished-event context wedges
> > EL3 on some firmware (left as a follow-up). The dump is unaffected; only
> > re-onlining the CPU in an SMP capture kernel is lost.
> >
> > Suggested-by: Douglas Anderson <dianders@chromium.org>
> > Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> > ---
> >  arch/arm64/include/asm/nmi.h    |  24 +++++++
> >  arch/arm64/kernel/smp.c         | 109 +++++++++++++++++++++-----------
> >  drivers/firmware/Kconfig        |   2 +
> >  drivers/firmware/arm_sdei_nmi.c |  75 ++++++++++++++++++++++
> >  4 files changed, 172 insertions(+), 38 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/nmi.h b/arch/arm64/include/asm/nmi.h
> > index 9366be419d18..2e8974ff8d63 100644
> > --- a/arch/arm64/include/asm/nmi.h
> > +++ b/arch/arm64/include/asm/nmi.h
> > @@ -4,21 +4,45 @@
> >
> >  #include <linux/cpumask.h>
> >
> > +struct pt_regs;
> > +
> >  /*
> >   * Cross-CPU NMI provider hooks, consulted by the arm64 arch code before
> >   * its regular-IRQ / pseudo-NMI IPI paths. The SDEI provider in
> >   * drivers/firmware/arm_sdei_nmi.c implements them when active; a future
> >   * FEAT_NMI provider could slot in here too. The stubs let callers stay
> >   * unconditional when ARM_SDEI_NMI is off.
> > + *
> > + * sdei_nmi_active() lets a caller test for the service before committing
> > + * to (and waiting on) the SDEI stop rung; sdei_nmi_stop_cpus() then signals
> > + * the targets, which ack by going offline.
> >   */
> >  #ifdef CONFIG_ARM_SDEI_NMI
> >  bool sdei_nmi_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu);
> > +bool sdei_nmi_active(void);
> > +void sdei_nmi_stop_cpus(const cpumask_t *mask);
> >  #else
> >  static inline bool sdei_nmi_trigger_cpumask_backtrace(const cpumask_t *mask,
> >                                                       int exclude_cpu)
> >  {
> >         return false;
> >  }
> > +
> > +static inline bool sdei_nmi_active(void)
> > +{
> > +       return false;
> > +}
> > +
> > +static inline void sdei_nmi_stop_cpus(const cpumask_t *mask) { }
> >  #endif
> >
> > +/*
> > + * The common "stop this CPU" entry every arm64 stop path funnels through:
> > + * the regular/pseudo-NMI stop IPI handlers, panic_smp_self_stop(), and the
> > + * SDEI cross-CPU NMI handler. @die_on_crash powers the CPU off on the kdump
> > + * crash path (IPI handlers) instead of parking it (SDEI / self-stop).
> > + * Defined in arch/arm64/kernel/smp.c.
> > + */
> > +void __noreturn arm64_nmi_cpu_stop(struct pt_regs *regs, bool die_on_crash);
> > +
> >  #endif /* __ASM_NMI_H */
> > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> > index a670434a8cae..e85a4ba18d5c 100644
> > --- a/arch/arm64/kernel/smp.c
> > +++ b/arch/arm64/kernel/smp.c
> > @@ -33,6 +33,7 @@
> >  #include <linux/kernel_stat.h>
> >  #include <linux/kexec.h>
> >  #include <linux/kgdb.h>
> > +#include <linux/kprobes.h>
> >  #include <linux/kvm_host.h>
> >  #include <linux/nmi.h>
> >
> > @@ -862,14 +863,58 @@ void arch_irq_work_raise(void)
> >  }
> >  #endif
> >
> > -static void __noreturn local_cpu_stop(unsigned int cpu)
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
> > + */
> > +void __noreturn arm64_nmi_cpu_stop(struct pt_regs *regs, bool die_on_crash)
> >  {
> > +       unsigned int cpu = smp_processor_id();
> > +       bool crash = IS_ENABLED(CONFIG_KEXEC_CORE) && crash_stop;
> > +
> > +       /*
> > +        * Use local_daif_mask() instead of local_irq_disable() to make sure
> > +        * that pseudo-NMIs are disabled. The "stop" code starts with an IRQ
> > +        * and falls back to NMI (which might be pseudo). If the IRQ finally
> > +        * goes through right as we're timing out then the NMI could interrupt
> > +        * us. It's better to prevent the NMI and let the IRQ finish since the
> > +        * pt_regs will be better.
> > +        */
> > +       local_daif_mask();
> > +
> > +       if (crash)
> > +               crash_save_cpu(regs, cpu);
> > +
> > +       /* the ack a stop requester (e.g. smp_send_stop()) polls for */
> >         set_cpu_online(cpu, false);
> >
> > -       local_daif_mask();
> >         sdei_mask_local_cpu();
> > +
> > +       if (crash && die_on_crash)
> > +               __cpu_try_die(cpu);
> > +
> > +       /* just in case */
> >         cpu_park_loop();
> >  }
> > +NOKPROBE_SYMBOL(arm64_nmi_cpu_stop);
> >
> >  /*
> >   * We need to implement panic_smp_self_stop() for parallel panic() calls, so
> > @@ -878,36 +923,7 @@ static void __noreturn local_cpu_stop(unsigned int cpu)
> >   */
> >  void __noreturn panic_smp_self_stop(void)
> >  {
> > -       local_cpu_stop(smp_processor_id());
> > -}
> > -
> > -static void __noreturn ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
> > -{
> > -#ifdef CONFIG_KEXEC_CORE
> > -       /*
> > -        * Use local_daif_mask() instead of local_irq_disable() to make sure
> > -        * that pseudo-NMIs are disabled. The "crash stop" code starts with
> > -        * an IRQ and falls back to NMI (which might be pseudo). If the IRQ
> > -        * finally goes through right as we're timing out then the NMI could
> > -        * interrupt us. It's better to prevent the NMI and let the IRQ
> > -        * finish since the pt_regs will be better.
> > -        */
> > -       local_daif_mask();
> > -
> > -       crash_save_cpu(regs, cpu);
> > -
> > -       set_cpu_online(cpu, false);
> > -
> > -       sdei_mask_local_cpu();
> > -
> > -       if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
> > -               __cpu_try_die(cpu);
> > -
> > -       /* just in case */
> > -       cpu_park_loop();
> > -#else
> > -       BUG();
> > -#endif
> > +       arm64_nmi_cpu_stop(NULL, false);
> >  }
> 
> panic_smp_self_stop() passes regs == NULL. If a second CPU panics
> after the primary has already set crash_stop, it loses the panic_cpu
> cmpxchg and calls panic_smp_self_stop(); if it was running with
> interrupts masked it never took the stop IPI, so it gets here with
> crash_stop == 1. crash is then true and we do crash_save_cpu(NULL,
> cpu), which ends up in elf_core_copy_regs(), and on arm64 that is just
> 
>         *(struct user_pt_regs *)&(dest) = (regs)->user_regs;
> 
> so a straight NULL deref -> synchronous abort while we're in the
> middle of crashing. The old local_cpu_stop() never called
> crash_save_cpu(), so this is a new regression from the unification.

Good catch, you're right — that's a real NULL deref, and a regression
from folding ipi_cpu_crash_stop() in (the old code only ran on the IPI
path, which always has regs).

Will be fixed in v4.

> 
> The comment above the function says NULL means "capture the current
> context", but crash_save_cpu() doesn't do that, it just dereferences
> regs. If that's the intent, materialise it:
> 
>         if (crash) {
>                 struct pt_regs local;
> 
>                 if (!regs) {
>                         crash_setup_regs(&local, NULL);
>                         regs = &local;
>                 }
>                 crash_save_cpu(regs, cpu);
>         }
> 
>   crash_setup_regs(..., NULL) is the existing "capture current" helper. Or just
>   skip the save when regs is NULL if the self-stop registers aren't
> worth having.

I went with skipping it. No architecture saves registers for the
self-stopping CPU -- the generic, arm and powerpc panic_smp_self_stop()
all just mark offline and spin, and arm64 did the same via
local_cpu_stop() before this series. crash_save_cpu() is only ever fed
the interrupted context, from the crash shootdown or the crashing CPU
itself. So:

	if (crash && regs)
		crash_save_cpu(regs, cpu);

and I dropped the "NULL means capture current" wording from the comment
rather than make it true.

While fixing this I noticed the same block broke the CONFIG_KEXEC_CORE=n
build: the unification replaced the original ipi_cpu_crash_stop()'s
#ifdef CONFIG_KEXEC_CORE with an IS_ENABLED() check, but <linux/kexec.h>
only declares crash_save_cpu() under CONFIG_KEXEC_CORE (and pulling in
<linux/crash_core.h> directly collides with kexec.h's own stubs), so the
dead-but-compiled call was an implicit-declaration error. Restored the
#ifdef around the crash_save_cpu() call.

Thanks for the review!

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

