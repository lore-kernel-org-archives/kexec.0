Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF825CD98DA
	for <kexec@archiver.kernel.org>; Mon, 15 Jun 2026 10:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kb9VS7Ngmqt9OoI65+43kHI4tpRkdKn8JTleP0ceJUk=; b=vdScYxLZLZmkF9SyZ2aHfb5dZX
	G74jGo5OgpYqcQl/PA5tXrEZv1FW1kIzCp/C0LEPDcp7pbR5i58IhJk/kZ7/FFn9MxZnTVAp+EBcA
	XUyjBIRwtFGTtIrJ7PUOEFLmtVFPYoAK0be/sC0Bp5F4elKVzBdnzgDU32l3/tHLv2TF9dKzbfEw9
	5P5ZP1v1EWQlVhWGfct0tjhZFDs5NgydAfCITmh0B0t6UEfLcDNuLC6UsYp+VQJd12+LqO/t6ivQ4
	7pseqWXHZ5Sm4Y2yXvE4CHBBrrGK1wYov8AQ0uLPPDVbArAr85tXn1YtJsl2ybloYe6l+c1Ji5yOU
	83NF25cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZ4Ve-0000000E31t-1EmI;
	Mon, 15 Jun 2026 10:25:38 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZ4Vb-0000000E31B-1vLr
	for kexec@lists.infradead.org;
	Mon, 15 Jun 2026 10:25:36 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2bf1f074a12so31368665ad.0
        for <kexec@lists.infradead.org>; Mon, 15 Jun 2026 03:25:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781519134; cv=none;
        d=google.com; s=arc-20240605;
        b=QSVBbQJ/jb1UiNcl6mr773tqB9yTq21XI5w/2S5X3OdnJ0oS1KwzHPFhlkElWaYiGe
         mIPABLhxRLKRHk5ut8lBjbS4KC7RCmzgEHVrsxaQE5Hsbblu2LYUj+lBcrL7ZEc4RIO3
         iRwjwdxn3W7Jx71t23e2tegQZ+pek+ZWSJPj6IRwConyisorM2r4hd5Kpq3egLUNRzBB
         Kzw65qb0EjqRfeK0zItlIeZ2gFAvarndREEdQgHHT0tpCRVydFs2Lhmycb+QC3IE6yql
         vvVqzzUALmki2Lanock7GZmY5XpVHnDzbBeOMjojl0CVPpjY83BcaZwMz7mOZ99usaRp
         DjPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kb9VS7Ngmqt9OoI65+43kHI4tpRkdKn8JTleP0ceJUk=;
        fh=DjQA64BrlXiNxI405lTpmgfhVHlbS+KLXA2dpQPiOQU=;
        b=EvnOKh5cll9IDLB6MlZ/1evhBzlVFFcezfuCVen14yXgHgKH1Ojgmi0Vo3SaTkvBR4
         DyIw00A0IIzOZbo27Bl+JCKCJ2qpOzLPupZtMlytymd/JJexiVbjvAGuWtt9lwwcaDS4
         SN2GBLczW/+goQmn2xrnBIwcA2bh+Sgjue5bmvT62zBqjpl1GmMriJUkXGb74O5Guf78
         uvOv3YJcRtti3FZoRfNU8ZfWgmL34KMusq3ioR0M/hnjZrn5BFWSsBhq7uGINnPUsSnc
         rcWFdnGwYJFlvLVHQ8DuMbZlWMekhbJw4J9EQA29/uG/YXRUsCMDGDI+O8wj3xSqDmx+
         J+Lg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781519134; x=1782123934; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kb9VS7Ngmqt9OoI65+43kHI4tpRkdKn8JTleP0ceJUk=;
        b=c7IWj/zzeBMEjemYUjPmJ4W8qMtE+4O42RVs0sMpR0bjAe8rq697UkKQH7ismETITf
         s3fEtmDdyoE4It+bRtCAHGA7F0RfTuzMkFDNEqHPKBpLxdEh5cEG1CsXb4IoLHX0wij5
         CrbDoXZASXYFW1qRsyl9fZktbhfsrisT6YnTWqQEZlP6r5lidey8YeyG8C6lKPEGLnyx
         NrY9mxOkL8UzRfG+/jcLm+kSvHTm+tPZN5RMGqCb6hHkyzYLYf+N64TDyIRrSHJqWgud
         SQgd89D+G5Gb01nz042WlEFqne4WI/IY/JOOg/j3GFBiezK2rL6DPEja6Nz+KRM+MvhK
         JgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781519134; x=1782123934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kb9VS7Ngmqt9OoI65+43kHI4tpRkdKn8JTleP0ceJUk=;
        b=XoUKfSFUpO0Gtv9tOjteJI8VZ6tdw3LeGH/doH4ODrbXrbmerbiGLLxMPxwF9C2H1B
         zzsyIhosn0VpRCAwqrdqiGsPRS7w8baf7L6X8gbTZXgrsn8KLaNCdj09+CsNFFdZQSDZ
         rNTEUgFFSuJDgthQwcWhZWoSIn0OMzAaPwB1wUOuZH3zzQfBkZWp3TzA/gHWm5dHbvQS
         ik0rJx+BIWlMSDf4Ilz2jATLCAJTF24DYx4N9nf2xA9jNt85M0WReV5g5COLcjcahRxZ
         Gk1VvWob3mGuRV/yb9UDaCqHA+RNm074DgJnSri84mOKIJDMRbUgpSiRE4OryWTyTPSJ
         x0Dg==
X-Forwarded-Encrypted: i=1; AFNElJ9VbnDO/ZnVenBRmbzxtk8PN93cEQap0L/He6p+m4GxZ4EV92omweIUUHch4Rk3bo58tcKTQg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwvDgLIsV+7wki4dFXk5s/bgcfjTc9HcHkv4HbRfDPzLpSlILZc
	BfD2l6/VSVYzbmV8c2XVybwJxpun5C8QULt7LQWr31pC4nfHFhDz+JkgMmuT/oQpKnxvthaqbd3
	/lNwGEpI2EGjnlzb4swGDQw2JKMXqE84=
X-Gm-Gg: Acq92OHWphRIIdOBIwIQ7Tj40eneHXA22r2OOoJzSX3w5ykw7As0rotO3KxLd2x+a47
	GOjhFwDcOFqfQ9OUTFxQVO8qT3mGzgLvglHVjdUO3L8XSKaDMnb/mo7FKvuAA9/rPgJOwlYUOZr
	2kj/Ob0ZmChSZmewFuz3yAL9SyBl4Z0Qv0AirZGXX48W7frA7nCqXs1NCI1xdZ+ifJ9NLAMpwm/
	LfJJTyx6O2s8yJf4n4X8P2cRN4xgEUHITCIN9U+ozXIMlChg0CaKcsxAbXtyNQIf68RxCKq7Ol/
	nOHx0oZSIfnAxAwtZQ==
X-Received: by 2002:a17:902:ebcb:b0:2c2:d910:db05 with SMTP id
 d9443c01a7336-2c412c27bd8mr132029655ad.29.1781519134327; Mon, 15 Jun 2026
 03:25:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1781490440.git.kas@kernel.org> <167493d30ef6c99a44291de14cddd41ced8149c4.1781490440.git.kas@kernel.org>
In-Reply-To: <167493d30ef6c99a44291de14cddd41ced8149c4.1781490440.git.kas@kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 15 Jun 2026 12:25:17 +0200
X-Gm-Features: AVVi8CfeKMj8OrTrgYlBz-LvPNnIvbxM3_VDB6weQyrVVViHqpiN__Ks8VAIKE4
Message-ID: <CANk7y0irTcfVrKXBd1L7tLRyDpNJ1cRhwKG7x42XbKgJy+ACeA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] arm64: escalate smp_send_stop() to an SDEI NMI as
 a last resort
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	James Morse <james.morse@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Doug Anderson <dianders@chromium.org>, Petr Mladek <pmladek@suse.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Usama Arif <usama.arif@linux.dev>, Breno Leitao <leitao@debian.org>, 
	Julien Thierry <julien.thierry.kdev@gmail.com>, Lecopzer Chen <lecopzer@gmail.com>, 
	Sumit Garg <sumit.garg@kernel.org>, kernel-team@meta.com, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260615_032535_514159_11D5ED7D 
X-CRM114-Status: GOOD (  42.66  )
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

On Mon, Jun 15, 2026 at 4:36=E2=80=AFAM Kiryl Shutsemau <kirill@shutemov.na=
me> wrote:
>
> From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
>
> A CPU wedged with interrupts masked ignores the stop IPI, and without
> pseudo-NMI there is no NMI IPI to escalate to: a reboot proceeds with
> the CPU still running, and a kdump misses its registers.
>
> Add a third rung to smp_send_stop(): once the IPI (and pseudo-NMI IPI,
> if enabled) rungs have run, signal SDEI event 0 at whatever stayed
> online. Firmware delivers it regardless of the target's DAIF, so it
> reaches a CPU a plain IPI cannot; the target acks by going offline,
> which the caller already polls for.
>
> Fold the stop bookkeeping into one arm64_nmi_cpu_stop(regs,
> die_on_crash), shared by the stop IPI handlers, panic_smp_self_stop()
> and the SDEI handler, replacing the near-duplicate local_cpu_stop() and
> ipi_cpu_crash_stop(). @die_on_crash is the only difference: the IPI
> handlers pass true and PSCI CPU_OFF the CPU on a crash stop so a capture
> kernel can reclaim it; the SDEI handler and self-stop pass false and
> park. The SDEI park is required, not conservative -- its handler runs
> inside an SDEI event that is never completed (completing it resumes the
> wedged context), and a CPU_OFF from that unfinished-event context wedges
> EL3 on some firmware (left as a follow-up). The dump is unaffected; only
> re-onlining the CPU in an SMP capture kernel is lost.
>
> Suggested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> ---
>  arch/arm64/include/asm/nmi.h    |  24 +++++++
>  arch/arm64/kernel/smp.c         | 109 +++++++++++++++++++++-----------
>  drivers/firmware/Kconfig        |   2 +
>  drivers/firmware/arm_sdei_nmi.c |  75 ++++++++++++++++++++++
>  4 files changed, 172 insertions(+), 38 deletions(-)
>
> diff --git a/arch/arm64/include/asm/nmi.h b/arch/arm64/include/asm/nmi.h
> index 9366be419d18..2e8974ff8d63 100644
> --- a/arch/arm64/include/asm/nmi.h
> +++ b/arch/arm64/include/asm/nmi.h
> @@ -4,21 +4,45 @@
>
>  #include <linux/cpumask.h>
>
> +struct pt_regs;
> +
>  /*
>   * Cross-CPU NMI provider hooks, consulted by the arm64 arch code before
>   * its regular-IRQ / pseudo-NMI IPI paths. The SDEI provider in
>   * drivers/firmware/arm_sdei_nmi.c implements them when active; a future
>   * FEAT_NMI provider could slot in here too. The stubs let callers stay
>   * unconditional when ARM_SDEI_NMI is off.
> + *
> + * sdei_nmi_active() lets a caller test for the service before committin=
g
> + * to (and waiting on) the SDEI stop rung; sdei_nmi_stop_cpus() then sig=
nals
> + * the targets, which ack by going offline.
>   */
>  #ifdef CONFIG_ARM_SDEI_NMI
>  bool sdei_nmi_trigger_cpumask_backtrace(const cpumask_t *mask, int exclu=
de_cpu);
> +bool sdei_nmi_active(void);
> +void sdei_nmi_stop_cpus(const cpumask_t *mask);
>  #else
>  static inline bool sdei_nmi_trigger_cpumask_backtrace(const cpumask_t *m=
ask,
>                                                       int exclude_cpu)
>  {
>         return false;
>  }
> +
> +static inline bool sdei_nmi_active(void)
> +{
> +       return false;
> +}
> +
> +static inline void sdei_nmi_stop_cpus(const cpumask_t *mask) { }
>  #endif
>
> +/*
> + * The common "stop this CPU" entry every arm64 stop path funnels throug=
h:
> + * the regular/pseudo-NMI stop IPI handlers, panic_smp_self_stop(), and =
the
> + * SDEI cross-CPU NMI handler. @die_on_crash powers the CPU off on the k=
dump
> + * crash path (IPI handlers) instead of parking it (SDEI / self-stop).
> + * Defined in arch/arm64/kernel/smp.c.
> + */
> +void __noreturn arm64_nmi_cpu_stop(struct pt_regs *regs, bool die_on_cra=
sh);
> +
>  #endif /* __ASM_NMI_H */
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index a670434a8cae..e85a4ba18d5c 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -33,6 +33,7 @@
>  #include <linux/kernel_stat.h>
>  #include <linux/kexec.h>
>  #include <linux/kgdb.h>
> +#include <linux/kprobes.h>
>  #include <linux/kvm_host.h>
>  #include <linux/nmi.h>
>
> @@ -862,14 +863,58 @@ void arch_irq_work_raise(void)
>  }
>  #endif
>
> -static void __noreturn local_cpu_stop(unsigned int cpu)
> +/*
> + * Bring the local CPU to a stop, saving its register state into the vmc=
ore
> + * on the kdump crash path first. The single point every arm64 stop path
> + * funnels through, so the bookkeeping (mask interrupts, mark offline, m=
ask
> + * SDEI, optionally power off) lives in one place:
> + *
> + *   - the regular IPI_CPU_STOP and pseudo-NMI IPI_CPU_STOP_NMI handlers=
;
> + *   - panic_smp_self_stop(), a CPU parking itself on a parallel panic()=
;
> + *   - the SDEI cross-CPU NMI handler (drivers/firmware/arm_sdei_nmi.c),
> + *     which reaches CPUs the stop IPIs could not.
> + *
> + * @regs is the register state to record in the vmcore on a crash stop; =
NULL
> + * means "capture the current context". @die_on_crash decides the kdump =
crash
> + * path: the IPI stop handlers pass true and power the CPU off (PSCI CPU=
_OFF,
> + * via __cpu_try_die()) so a capture kernel can reclaim it. The SDEI han=
dler
> + * and panic_smp_self_stop() pass false and only park. For SDEI that is
> + * required, not just conservative: it runs inside an SDEI event that is
> + * deliberately never completed (completing it has firmware resume the w=
edged
> + * context), and a CPU_OFF from that not-yet-completed context wedges EL=
3 on
> + * some firmware -- a documented follow-up. Parking also matches this pa=
th's
> + * own fallback when CPU_OFF is unavailable.
> + */
> +void __noreturn arm64_nmi_cpu_stop(struct pt_regs *regs, bool die_on_cra=
sh)
>  {
> +       unsigned int cpu =3D smp_processor_id();
> +       bool crash =3D IS_ENABLED(CONFIG_KEXEC_CORE) && crash_stop;
> +
> +       /*
> +        * Use local_daif_mask() instead of local_irq_disable() to make s=
ure
> +        * that pseudo-NMIs are disabled. The "stop" code starts with an =
IRQ
> +        * and falls back to NMI (which might be pseudo). If the IRQ fina=
lly
> +        * goes through right as we're timing out then the NMI could inte=
rrupt
> +        * us. It's better to prevent the NMI and let the IRQ finish sinc=
e the
> +        * pt_regs will be better.
> +        */
> +       local_daif_mask();
> +
> +       if (crash)
> +               crash_save_cpu(regs, cpu);
> +
> +       /* the ack a stop requester (e.g. smp_send_stop()) polls for */
>         set_cpu_online(cpu, false);
>
> -       local_daif_mask();
>         sdei_mask_local_cpu();
> +
> +       if (crash && die_on_crash)
> +               __cpu_try_die(cpu);
> +
> +       /* just in case */
>         cpu_park_loop();
>  }
> +NOKPROBE_SYMBOL(arm64_nmi_cpu_stop);
>
>  /*
>   * We need to implement panic_smp_self_stop() for parallel panic() calls=
, so
> @@ -878,36 +923,7 @@ static void __noreturn local_cpu_stop(unsigned int c=
pu)
>   */
>  void __noreturn panic_smp_self_stop(void)
>  {
> -       local_cpu_stop(smp_processor_id());
> -}
> -
> -static void __noreturn ipi_cpu_crash_stop(unsigned int cpu, struct pt_re=
gs *regs)
> -{
> -#ifdef CONFIG_KEXEC_CORE
> -       /*
> -        * Use local_daif_mask() instead of local_irq_disable() to make s=
ure
> -        * that pseudo-NMIs are disabled. The "crash stop" code starts wi=
th
> -        * an IRQ and falls back to NMI (which might be pseudo). If the I=
RQ
> -        * finally goes through right as we're timing out then the NMI co=
uld
> -        * interrupt us. It's better to prevent the NMI and let the IRQ
> -        * finish since the pt_regs will be better.
> -        */
> -       local_daif_mask();
> -
> -       crash_save_cpu(regs, cpu);
> -
> -       set_cpu_online(cpu, false);
> -
> -       sdei_mask_local_cpu();
> -
> -       if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
> -               __cpu_try_die(cpu);
> -
> -       /* just in case */
> -       cpu_park_loop();
> -#else
> -       BUG();
> -#endif
> +       arm64_nmi_cpu_stop(NULL, false);
>  }

panic_smp_self_stop() passes regs =3D=3D NULL. If a second CPU panics
after the primary has already set crash_stop, it loses the panic_cpu
cmpxchg and calls panic_smp_self_stop(); if it was running with
interrupts masked it never took the stop IPI, so it gets here with
crash_stop =3D=3D 1. crash is then true and we do crash_save_cpu(NULL,
cpu), which ends up in elf_core_copy_regs(), and on arm64 that is just

        *(struct user_pt_regs *)&(dest) =3D (regs)->user_regs;

so a straight NULL deref -> synchronous abort while we're in the
middle of crashing. The old local_cpu_stop() never called
crash_save_cpu(), so this is a new regression from the unification.

The comment above the function says NULL means "capture the current
context", but crash_save_cpu() doesn't do that, it just dereferences
regs. If that's the intent, materialise it:

        if (crash) {
                struct pt_regs local;

                if (!regs) {
                        crash_setup_regs(&local, NULL);
                        regs =3D &local;
                }
                crash_save_cpu(regs, cpu);
        }

  crash_setup_regs(..., NULL) is the existing "capture current" helper. Or =
just
  skip the save when regs is NULL if the self-stop registers aren't
worth having.

