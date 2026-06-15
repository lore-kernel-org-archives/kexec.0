Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68CE3CD98C5
	for <kexec@archiver.kernel.org>; Mon, 15 Jun 2026 10:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H154WjKnOWacRn9dY+PoLW7+gwbfJIBFioyIrEEICfc=; b=45+0Nx6urEC/+XUARxfsueZbBH
	3tXh8iXky83PYwOabGd2IprmYkgqBAzRwm3Oo9w0TiDGDPI6+5bgKO4mj6q/eIWzU0Z6K1+h+JM2Z
	atg9ZLWwK/nXFu7IIpgNPiz0zHFAUNKYwmNjb7IJgRM89bvMTZaO8xp1AMAnsGAM4J8fmAIJ8ytsk
	UCPfIHaZjOymHiaOL4Z8S/Q9RCnRef2LT3/jP2u+B+sFd5jLOJhl79vJ2PSlBjmJP4XovcDkwO00S
	EVtREG4Dw2I87XukdLkmVvDd/Po3v1fxyYBaTL8DwsO0cmkvRVgsc9c3Mki15UlilJhrOeibdpy42
	YEd1AN3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZ4Om-0000000E2gd-1e92;
	Mon, 15 Jun 2026 10:18:32 +0000
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZ4Of-0000000E2fQ-0Ylg
	for kexec@lists.infradead.org;
	Mon, 15 Jun 2026 10:18:27 +0000
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-c0115a3794bso204656866b.0
        for <kexec@lists.infradead.org>; Mon, 15 Jun 2026 03:18:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781518703; cv=none;
        d=google.com; s=arc-20240605;
        b=b0NO+v8SCNbb72+01N01Gbnh8p5BGhoQFsfTeAG2Nlm4cpyEcOXOC6Txp1KHjUxsxl
         4P+jPwTChSgCE7O6SygEvsefn+wm9UckAa5GMWdnufco08DJ2H8y+7vdyLViaV4c9dBN
         QxNgf9ikHI86DLVjuvK9aNGfiE0P2KAWca7PnI/yiyvdKddg4PSv/jhPxLsSsSHB8KKx
         PKvPFMQo/ybWzL+gR9tcnOIH9qvAQNOUITpyYOwTLZe5mBr0cCRwSd45Yzjrio9dQf47
         bfEAR4LGvvtJBdHPHCBVQQPjSdlCiIcfKP5zAbuqDVAMhAI6lW5n3mw1iIgFh9RjPw+v
         2cCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H154WjKnOWacRn9dY+PoLW7+gwbfJIBFioyIrEEICfc=;
        fh=EfLZDxlhZefmauDwyanLczAeaqQ/e/x2TVhYifVEjJk=;
        b=Tb5k4roQdH29j/8Axzg9jPuGZcj857C3E0XUCrdbscE+rBvTsl64UBlZsEKCZw+/5K
         qICtd9m8AgavMhEL5VQx6hwbdD6sCmDNuAyJ8fbtrKxGaYNOFdBISkyog/ZNt6VfwhWv
         dTWeYq+i7XeIY+NASoY4BDiHnKNL/sa1X2rR8AUVVjroIsYemlNK7pe8q/WtaIroxT7Q
         zR7UmQEUyBIDE+SFHWHeYBfqYfo/iFYYFhFaBmfwq4jLIudXAoYoFqNNRexUNpMjM32w
         sQ+ckUqdCtboPO3K8p+ixhIVREUxrEaxBneYP/9nobYLgI/WZ8s+Qv4skf0/0dLs8Cj0
         CeVg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781518703; x=1782123503; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H154WjKnOWacRn9dY+PoLW7+gwbfJIBFioyIrEEICfc=;
        b=MMH25yvcobJPN078wQPpA6mEF9sO5eEgp1Rp0vikIEtmMsFOBeIvC+4gvo/aEts59X
         n5TpehFBRV0ruozgrugksDN6WOpkj4KVJC3kz7Q/jCF6VfnbFfpOFOU3K/S4hu+d/Z7h
         SkGOTI5Q6LxaXUbjR7Rivo88OMcZg5dJjBGjpmXoBAZgJrnkxxareTgIVAF68Roj+gD+
         AigZFKl99ksc+XUevnfn8tM0tR6BLD6AzmqgBOiaFOhnI43HROrcwqOnJmvTCBkxljl3
         DbG7LgoVn2PlMbokwgPJWzf9LWRL5W/CPuY7rG4+/8JNUHXE9amkTjJ5UsvV5GagjewZ
         YDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781518703; x=1782123503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H154WjKnOWacRn9dY+PoLW7+gwbfJIBFioyIrEEICfc=;
        b=US6LjsSzQ+l6rT0+dJqBLfiwxhHGGOsnvgp5IfBspwaWpEqi/tZqW0X3slIGG1sVt/
         1gs6CMSqByz7QQObL8lx6wkUQ/xJhdFAo3mnCruEVg9NPau8bvZhd/eOsRedN8uBhgBY
         efXqtPFVJRsfNZT7dekHIgd666oNJRsyMz7Ay5u44BBMgi732Ndy9GQK7mzFT+AaRdRm
         RC8KARYFoWxzb2CVnakjE7tMSHZPMOtBhOh+YrnQgt5UEUb6tMEV3rp71os1nhBENiuL
         GqVFA+B8iRC4PSZFtf63ZgHDgj1yaq7QJ/LZgCNmWWy6elQJavLC/1SWf3N/HR69mMfG
         SQ2A==
X-Forwarded-Encrypted: i=1; AFNElJ/IyLAFkVrRvSlVEB1wpblqLHKoYLMtDPGP1ivnOrYvcwCGD6Uye8sy+NEwFm5lgDBzrmeR3A==@lists.infradead.org
X-Gm-Message-State: AOJu0YxnfMCEJsWJ4wcVGxUeRdVxLONYkvmm45ypYPGlzv0AunyFwVqB
	51X36DpbV6Ij30n4pdWfWeSZSbRUMHolxUbowyszuCEYZ/hIBEkbLL3y0wgnILcwEwPxnZ/MYt+
	MUNVxFgYocPJNajq9nSPLKfEEJTDo+IA=
X-Gm-Gg: Acq92OHMtF+8CBZonm1q5rOLQOIYcXs7WugWmklWQp8QSF8erWIb1gdAhSZLqHRp/pJ
	Uob4MLPCr/TNvBcHalTVQ/QvrCVjEiyvZcSJFdV6lAGgba3E3KQgG4610FShJJ9TCUlSJhBGFQ5
	bkcgfzvpPS7ZuyrWT0vjfWpl+ZIKAThI+hRHo9EfpleVEbgyLbAYheNHwv3x/sg3kwBFsgKDByr
	cFJ7c3TNQUe+SbmHhPU2NXttno04VCQ8rkuMqJpTRzzQSkM6PMj+b3skipPHWdghi3x7awe1Dcz
	tArxzIs=
X-Received: by 2002:a17:906:7312:b0:bec:929b:cee6 with SMTP id
 a640c23a62f3a-bff49d124aemr394065766b.20.1781518702267; Mon, 15 Jun 2026
 03:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1781490440.git.kas@kernel.org> <704b467d5b320da9cf49fc9bb4a6814063986f3b.1781490440.git.kas@kernel.org>
In-Reply-To: <704b467d5b320da9cf49fc9bb4a6814063986f3b.1781490440.git.kas@kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 15 Jun 2026 12:18:10 +0200
X-Gm-Features: AVVi8Cczau1OJ3xWVRH3rLpHJwqBhc67yl5eVw5PVUVifjULipKIqvnkXxShTPc
Message-ID: <CANk7y0iBTYuhzLTJAX0yf8Cp8cyThOVpAQYMTDN9LZUKGThqJQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] drivers/firmware: add SDEI cross-CPU NMI service
 for arm64
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
X-CRM114-CacheID: sfid-20260615_031825_353006_F994911B 
X-CRM114-Status: GOOD (  43.62  )
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

On Mon, Jun 15, 2026 at 4:35=E2=80=AFAM Kiryl Shutsemau <kirill@shutemov.na=
me> wrote:
>
> From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
>
> Deliver an NMI-like event to an interrupt-masked arm64 CPU via the
> standard SDEI software-signalled event (event 0), without the pseudo-NMI
> hot-path cost: register a handler for event 0 and poke a target with
> sdei_event_signal(0, mpidr).
>
> First user is arch_trigger_cpumask_backtrace() (sysrq-l, RCU stalls,
> hung-task/soft-lockup dumps), which otherwise rides an IPI that can't
> reach a masked CPU. Falls back to the IPI path when SDEI is absent; no
> watchdog backend yet, so the stock detector is untouched.
>
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
>  MAINTAINERS                     |   2 +-
>  arch/arm64/include/asm/nmi.h    |  24 +++++
>  arch/arm64/kernel/smp.c         |  11 +++
>  drivers/firmware/Kconfig        |  19 ++++
>  drivers/firmware/Makefile       |   1 +
>  drivers/firmware/arm_sdei_nmi.c | 149 ++++++++++++++++++++++++++++++++
>  6 files changed, 205 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/include/asm/nmi.h
>  create mode 100644 drivers/firmware/arm_sdei_nmi.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c8d4b913f26c..b5ddfb85dce9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24797,7 +24797,7 @@ M:      James Morse <james.morse@arm.com>
>  L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribe=
rs)
>  S:     Maintained
>  F:     Documentation/devicetree/bindings/arm/firmware/sdei.txt
> -F:     drivers/firmware/arm_sdei.c
> +F:     drivers/firmware/arm_sdei*
>  F:     include/linux/arm_sdei.h
>  F:     include/uapi/linux/arm_sdei.h
>
> diff --git a/arch/arm64/include/asm/nmi.h b/arch/arm64/include/asm/nmi.h
> new file mode 100644
> index 000000000000..9366be419d18
> --- /dev/null
> +++ b/arch/arm64/include/asm/nmi.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_NMI_H
> +#define __ASM_NMI_H
> +
> +#include <linux/cpumask.h>
> +
> +/*
> + * Cross-CPU NMI provider hooks, consulted by the arm64 arch code before
> + * its regular-IRQ / pseudo-NMI IPI paths. The SDEI provider in
> + * drivers/firmware/arm_sdei_nmi.c implements them when active; a future
> + * FEAT_NMI provider could slot in here too. The stubs let callers stay
> + * unconditional when ARM_SDEI_NMI is off.
> + */
> +#ifdef CONFIG_ARM_SDEI_NMI
> +bool sdei_nmi_trigger_cpumask_backtrace(const cpumask_t *mask, int exclu=
de_cpu);
> +#else
> +static inline bool sdei_nmi_trigger_cpumask_backtrace(const cpumask_t *m=
ask,
> +                                                     int exclude_cpu)
> +{
> +       return false;
> +}
> +#endif
> +
> +#endif /* __ASM_NMI_H */
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 1aa324104afb..a670434a8cae 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -45,6 +45,7 @@
>  #include <asm/daifflags.h>
>  #include <asm/kvm_mmu.h>
>  #include <asm/mmu_context.h>
> +#include <asm/nmi.h>
>  #include <asm/numa.h>
>  #include <asm/processor.h>
>  #include <asm/smp_plat.h>
> @@ -927,6 +928,16 @@ static void arm64_backtrace_ipi(cpumask_t *mask)
>
>  void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_c=
pu)
>  {
> +       /*
> +        * Prefer the SDEI cross-CPU NMI provider when active: firmware
> +        * dispatches the event out of EL3 and reaches CPUs that have
> +        * interrupts locally masked, without the per-IRQ-mask cost that
> +        * pseudo-NMI pays for the same reach. The plain IPI path below
> +        * can't reach such a CPU unless pseudo-NMI is enabled.
> +        */
> +       if (sdei_nmi_trigger_cpumask_backtrace(mask, exclude_cpu))
> +               return;
> +
>         /*
>          * NOTE: though nmi_trigger_cpumask_backtrace() has "nmi_" in the=
 name,
>          * nothing about it truly needs to be implemented using an NMI, i=
t's
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index bbd2155d8483..6501087ff90d 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -36,6 +36,25 @@ config ARM_SDE_INTERFACE
>           standard for registering callbacks from the platform firmware
>           into the OS. This is typically used to implement RAS notificati=
ons.
>
> +config ARM_SDEI_NMI
> +       bool "SDEI-based cross-CPU NMI service (arm64)"
> +       depends on ARM64 && ARM_SDE_INTERFACE
> +       help
> +         Provides SDEI-based cross-CPU NMI delivery for hooks that need
> +         to reach interrupt-masked CPUs on silicon that lacks FEAT_NMI:
> +
> +           - arch_trigger_cpumask_backtrace()  (sysrq-l, RCU stalls,
> +             hardlockup_all_cpu_backtrace, soft-lockup secondary dumps,
> +             hung-task auxiliary dumps)
> +
> +         The driver registers a handler for the SDEI software-signalled
> +         event (event 0) and reaches a target CPU by signalling it with
> +         SDEI_EVENT_SIGNAL. Firmware delivers the event out of EL3
> +         regardless of the target's PSTATE.DAIF -- forced delivery into =
a
> +         CPU wedged with interrupts locally masked.
> +
> +         If unsure, say N.
> +
>  config EDD
>         tristate "BIOS Enhanced Disk Drive calls determine boot disk"
>         depends on X86
> diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
> index 4ddec2820c96..be46f1e1dc77 100644
> --- a/drivers/firmware/Makefile
> +++ b/drivers/firmware/Makefile
> @@ -4,6 +4,7 @@
>  #
>  obj-$(CONFIG_ARM_SCPI_PROTOCOL)        +=3D arm_scpi.o
>  obj-$(CONFIG_ARM_SDE_INTERFACE)        +=3D arm_sdei.o
> +obj-$(CONFIG_ARM_SDEI_NMI)     +=3D arm_sdei_nmi.o
>  obj-$(CONFIG_DMI)              +=3D dmi_scan.o
>  obj-$(CONFIG_DMI_SYSFS)                +=3D dmi-sysfs.o
>  obj-$(CONFIG_EDD)              +=3D edd.o
> diff --git a/drivers/firmware/arm_sdei_nmi.c b/drivers/firmware/arm_sdei_=
nmi.c
> new file mode 100644
> index 000000000000..a82776e7b55a
> --- /dev/null
> +++ b/drivers/firmware/arm_sdei_nmi.c
> @@ -0,0 +1,149 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * arm64 SDEI-based cross-CPU NMI service.
> + *
> + * Delivering an "NMI-shaped" event to an EL1 context that has locally
> + * masked interrupts, on silicon without FEAT_NMI, can be done two ways:
> + *
> + *   - pseudo-NMI: mask "interrupts" via the GIC priority register
> + *     (ICC_PMR_EL1) instead of PSTATE.DAIF, leaving a high-priority ban=
d
> + *     deliverable. Functionally this works -- but it reimplements every
> + *     local_irq_disable()/enable() and exception entry/exit as a PMR
> + *     write plus synchronisation, a cost paid on that hot path forever,
> + *     whether or not an NMI is ever delivered.
> + *
> + *   - SDEI: leave interrupt masking as the cheap PSTATE.DAIF operation
> + *     and have the firmware bounce an EL3-routed Group-0 SGI back to
> + *     NS-EL1 as an event callback. The cost is a firmware round-trip,
> + *     but only at the rare moment delivery is actually needed.
> + *
> + * This driver takes the second path: it keeps the IRQ-mask hot path
> + * free and pays only when it fires, which is what makes cross-CPU NMI
> + * affordable on hardware where the pseudo-NMI tax isn't, until FEAT_NMI
> + * makes NMI masking cheap in the architecture itself.
> + *
> + * Capabilities provided:
> + *
> + *   - sdei_nmi_trigger_cpumask_backtrace() =E2=80=94 override for arm64=
's
> + *     arch_trigger_cpumask_backtrace(), so sysrq-l, RCU stall dumps,
> + *     hardlockup_all_cpu_backtrace, soft-lockup/hung-task secondary
> + *     dumps all reach interrupt-masked CPUs.
> + *
> + * Delivery uses the standard SDEI software-signalled event (event 0) an=
d
> + * SDEI_EVENT_SIGNAL. We register a handler for event 0, enable it, and
> + * poke a target CPU with sdei_event_signal(0, mpidr): firmware makes
> + * event 0 pending on that PE and dispatches the handler NMI-like,
> + * regardless of the target's DAIF.
> + * Availability is simply whether event 0 registers and enables -- if SD=
EI
> + * and its software-signalled event are present we use it, otherwise the
> + * driver stays inert.
> + */
> +
> +#define pr_fmt(fmt) "sdei_nmi: " fmt
> +
> +#include <linux/arm_sdei.h>
> +#include <linux/cpumask.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/kprobes.h>
> +#include <linux/nmi.h>
> +#include <linux/printk.h>
> +#include <linux/ptrace.h>
> +#include <linux/smp.h>
> +#include <linux/types.h>
> +
> +#include <asm/nmi.h>
> +#include <asm/smp_plat.h>
> +
> +static bool sdei_nmi_available;
> +
> +#define SDEI_NMI_EVENT                 0
> +
> +static int sdei_nmi_handler(u32 event, struct pt_regs *regs, void *arg)
> +{
> +       /*
> +        * nmi_cpu_backtrace() no-ops unless this CPU's bit is set in the
> +        * global backtrace mask (driven by nmi_trigger_cpumask_backtrace=
()),
> +        * so a fire that reaches a CPU not being backtraced is harmless.
> +        */
> +       nmi_cpu_backtrace(regs);
> +       return SDEI_EV_HANDLED;
> +}
> +NOKPROBE_SYMBOL(sdei_nmi_handler);
> +
> +static void sdei_nmi_fire(unsigned int target_cpu)
> +{
> +       int err =3D sdei_event_signal(SDEI_NMI_EVENT, cpu_logical_map(tar=
get_cpu));
> +
> +       if (err)
> +               pr_warn("SDEI_EVENT_SIGNAL to CPU %u failed: %d\n",
> +                       target_cpu, err);
> +}
> +
> +/*
> + * Raise callback for nmi_trigger_cpumask_backtrace(): signal event 0
> + * at every CPU still pending in @mask. The framework excludes the local
> + * CPU from @mask before calling us.
> + */
> +static void sdei_nmi_raise_backtrace(cpumask_t *mask)
> +{
> +       unsigned int cpu;
> +
> +       for_each_cpu(cpu, mask)
> +               sdei_nmi_fire(cpu);
> +}
> +
> +/*
> + * Override hook for arch_trigger_cpumask_backtrace() (see
> + * arch/arm64/kernel/smp.c). Returns true when SDEI handled the request,
> + * which is the case whenever SDEI is active; on a false return the arch
> + * falls back to its regular-IRQ (or pseudo-NMI, if enabled) IPI.
> + *
> + * On a kernel built without paying the pseudo-NMI hot-path cost (the
> + * usual case for this driver's target), the IPI can't reach a CPU that
> + * has interrupts masked -- so the backtrace of the one CPU you care
> + * about comes back empty. SDEI is dispatched out of EL3 and lands
> + * regardless of the target's DAIF, without taxing the IRQ-mask path.
> + */
> +bool sdei_nmi_trigger_cpumask_backtrace(const cpumask_t *mask, int exclu=
de_cpu)
> +{
> +       if (!sdei_nmi_available)
> +               return false;
> +
> +       nmi_trigger_cpumask_backtrace(mask, exclude_cpu,
> +                                     sdei_nmi_raise_backtrace);
> +       return true;
> +}
> +
> +/*
> + * device_initcall (after arch_initcall(sdei_init), so the SDEI subsyste=
m
> + * is up): probe the firmware, register the event, and turn on the
> + * cross-CPU service. If the probe fails the driver stays inert and the
> + * override hooks decline, leaving the arch's own paths in place.
> + */
> +static int __init sdei_nmi_init(void)
> +{
> +       int err;
> +
> +       err =3D sdei_event_register(SDEI_NMI_EVENT, sdei_nmi_handler, NUL=
L);
> +       if (err) {
> +               pr_err("sdei_event_register(%u) failed: %d\n",
> +                      SDEI_NMI_EVENT, err);
> +               return 0;
> +       }

This initcall runs unconditionally whenever ARM_SDEI_NMI is built in,
which includes the many arm64 systems that have no SDEI at all. On
those, sdei_event_register() -> sdei_event_create() ->
invoke_sdei_fn() returns -EIO, and the core already complains:
    pr_warn("Failed to create event %u: %d\n", event_num, err);

(that one isn't gated on err !=3D -EIO, unlike sdei_mask_local_cpu() & frie=
nds).
We then add a second pr_err() on top, so every boot on a non-SDEI box
with this config gets two alarming lines for what is just "no firmware
support". At minimum, don't shout for -EIO/-EOPNOTSUPP here. Better,
skip the probe when SDEI isn't present  there's no exported predicate
today, but -EIO is the de-facto one.

> +       err =3D sdei_event_enable(SDEI_NMI_EVENT);
> +       if (err) {
> +               pr_err("sdei_event_enable(%u) failed: %d\n",
> +                      SDEI_NMI_EVENT, err);
> +               sdei_event_unregister(SDEI_NMI_EVENT);
> +               return 0;
> +       }
> +
> +       sdei_nmi_available =3D true;
> +       pr_info("using SDEI cross-CPU NMI (SDEI_EVENT_SIGNAL, event %u)\n=
",
> +               SDEI_NMI_EVENT);
> +
> +       return 0;
> +}
> +device_initcall(sdei_nmi_init);
> --
> 2.54.0
>

