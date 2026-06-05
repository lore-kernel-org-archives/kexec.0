Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C09CD6E7B
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 20:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/3kdr6qrmm7a2qwk5wi4DJkHk54J0i+2AKmaQ2WBomY=; b=n46unwu5PZXrp9Dfm9wl7Mqf6b
	SHwqrwPZ3SXHrQ6PCcLJKW/JY/kPehDVrVkE8gvIBgxEQND8Fw1lnifZpdETEKW2kYY/8S5Z0IbDk
	Rs3HFSPWmf+7GX152fr86uYen+6mtxXfFnKKKNRfdQRa+AeWbI8DxyICV7nQdBL92E1F9AeW5+lLI
	DVimI61FvCYlrKmRQRmsyc12p8XFi3ipMRELV2+d3/MPxy2xoiyRoSLmN7LbOoM0oCsZWUGysJifO
	WArIuynFKpjuAKvWZRVAFpLNMGGPtXwdvzr7Az1YySbf/BqJuGSOdbrVULsYemvWxvUfDdHSrHJFG
	D9LXiUZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVbYW-00000001B3V-32HE;
	Fri, 05 Jun 2026 20:54:16 +0000
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVbYU-00000001B2a-4BbU
	for kexec@lists.infradead.org;
	Fri, 05 Jun 2026 20:54:16 +0000
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-96358d0a024so1679988241.3
        for <kexec@lists.infradead.org>; Fri, 05 Jun 2026 13:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1780692854; x=1781297654; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3kdr6qrmm7a2qwk5wi4DJkHk54J0i+2AKmaQ2WBomY=;
        b=Lm/sz+m2PgR/zYNaBGVQL5iamOoqK7RdwFGdBjWAB5dJB4D241dhMA2Ow1VdOWjeod
         bi/tlysHIlUjaJrslJcorTop6Iiwm2FJ+UnfaGzLHPgXBCcUaAbw7Z02Q+EWnw91bYH5
         kolPkV0JSlTMV89O3cJ7OKAAkfUYcSXDxjktQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780692854; x=1781297654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/3kdr6qrmm7a2qwk5wi4DJkHk54J0i+2AKmaQ2WBomY=;
        b=aQo0CqpDkiJabg0DbdpJQohliKL490RVRzBoTAfGUccma42ympH2SWQ8dCjNVlfwUa
         gIFVD9Hkq9w6DmQAxmvtNrsFp8hfuNPWn2dMfedy3Csgksddw2VLbTpTB/Oko6+2m9qO
         4kFVobdkGSxdzmthiINmxiTCh/MyF49KivfMsoCzcXaHWdtdISRV8rWj+9RsA5DmjW4d
         EhlkTXXt2lBvutsa56KV86VtkPeJtapzvy55TkHU81mCMiaBFfJ9GITo6Um81agyFaoU
         AnMnFmPI0gzVL7ivuynpR/PryV2ZDvJ/v1zin2SjpxqPwCcZfvhvEDO+GTJ7Gu7hIVhb
         PyIQ==
X-Forwarded-Encrypted: i=1; AFNElJ8mMRovGc8+adw93ucHnWlED1OVgMs4CF+nMe6EBJ+ZpeY47vvtTOnMpAhJgWu7Si4rCtCELA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzjiU7622yOFcz6o8kLjMB30Lw9jN4lGuorki8nJxF1k6WWN8rG
	4D49VU/QS6x7dHhrSZHJUhDkR/Kh70hQV9NcEuBBM3aYoa5X2jV3qTNPX33aYlfv0QjfNsNHRGv
	co9A=
X-Gm-Gg: Acq92OG+cY3L9lZa+EQ17FkQk8bXuy7mD3EdR1bPDKXg71H+iywP/HxzzwqrGjIKkgR
	1UTqpIPxhY1Ma8INQvHU78z8o7zo8FGXr/KnFcJILITgJaDpJLDJ+KPOKvjX9akeLY4DfOQtLCr
	yDWDyl+7qjt5gW6JaqeXbF2UJNoq+IKhaCN0l0L2aT5RST7rhvA/prOEOrWkDrQK0Yy/9XLeGBi
	3JKDCgrekPaeMMo6JUXbqw5TIGGvOAx2mbb4cANgNQCHOJYjTW+j7Lfo7ws6KJzEEBvOy2Fl4kP
	ubvzgsLmdOK4+oAQVIdrTdEnJksfq5SbUoxx05w/Ewwam6JhPv5yZs3aH5AcB4LhzbSi5RPaVGI
	VsFOf/P1SjB8yUA/F5t80+Hg+G8ekwxuvehG0p7hwI1F9xahe/2HAHI4K2RI8jE89gbfOoQl2nA
	eiuW+YTbKKrUBOrhXhRvbPVj1ygrOGF+FdfJPLmEFdzsjOIKWYrlqf5PFhEDAzHkPWM+td2c8/
X-Received: by 2002:a05:6102:54ac:b0:6c5:d55d:c093 with SMTP id ada2fe7eead31-6feef48d084mr3393142137.8.1780692853598;
        Fri, 05 Jun 2026 13:54:13 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96413f5c578sm8568017241.1.2026.06.05.13.54.12
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 13:54:12 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-6c4db0bf752so1545087137.0
        for <kexec@lists.infradead.org>; Fri, 05 Jun 2026 13:54:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+Hsc04Km+106+FF2RDB9rkog9JPe4y0jAlIHRkedVHyarIgkyXdlv+V2TbDfMcrnXYXGCAcA==@lists.infradead.org
X-Received: by 2002:a05:6102:cc8:b0:62f:3abe:907f with SMTP id
 ada2fe7eead31-6feed1adbffmr3683635137.4.1780692851321; Fri, 05 Jun 2026
 13:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1780496779.git.kas@kernel.org> <145b9e98b12a7d314fc4a203075f65c3a0c3a913.1780496779.git.kas@kernel.org>
In-Reply-To: <145b9e98b12a7d314fc4a203075f65c3a0c3a913.1780496779.git.kas@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 5 Jun 2026 13:54:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XMqFVnri1aVGbFJhN6Ts3SeJUzEZrfN0Pqp9WeOzE=OA@mail.gmail.com>
X-Gm-Features: AVVi8Ce5lMqSEWZVqGZM1FY6-oeUDRbFaZ9laA85TwkYWEFSDqaKWmanEo0FJTk
Message-ID: <CAD=FV=XMqFVnri1aVGbFJhN6Ts3SeJUzEZrfN0Pqp9WeOzE=OA@mail.gmail.com>
Subject: Re: [PATCH 2/4] drivers/firmware: add SDEI cross-CPU NMI service for arm64
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	James Morse <james.morse@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Petr Mladek <pmladek@suse.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Usama Arif <usama.arif@linux.dev>, 
	Breno Leitao <leitao@debian.org>, Julien Thierry <julien.thierry.kdev@gmail.com>, 
	Lecopzer Chen <lecopzer.chen@mediatek.com>, Sumit Garg <sumit.garg@kernel.org>, kernel-team@meta.com, 
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260605_135415_091685_CD533C23 
X-CRM114-Status: GOOD (  24.35  )
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

Hi,

On Wed, Jun 3, 2026 at 7:36=E2=80=AFAM Kiryl Shutsemau <kirill@shutemov.nam=
e> wrote:
>
> @@ -928,11 +929,19 @@ static void arm64_backtrace_ipi(cpumask_t *mask)
>  void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_c=
pu)
>  {
>         /*
> +        * Prefer the SDEI cross-CPU NMI provider when active: firmware
> +        * dispatches the event out of EL3 and reaches CPUs that have
> +        * interrupts locally masked, without the per-IRQ-mask cost that
> +        * pseudo-NMI pays for the same reach. The plain IPI path below
> +        * can't reach such a CPU unless pseudo-NMI is enabled.
> +        *
>          * NOTE: though nmi_trigger_cpumask_backtrace() has "nmi_" in the=
 name,
>          * nothing about it truly needs to be implemented using an NMI, i=
t's
>          * just that it's _allowed_ to work with NMIs. If ipi_should_be_n=
mi()
>          * returned false our backtrace attempt will just use a regular I=
PI.
>          */
> +       if (sdei_nmi_trigger_cpumask_backtrace(mask, exclude_cpu))
> +               return;
>         nmi_trigger_cpumask_backtrace(mask, exclude_cpu, arm64_backtrace_=
ipi);

nit: instead of one comment block, I would have broken it up in two. Like:

/*
 * Prefer the SDEI ...
 */
if (sdei_nmi_trigger_cpumask_backtrace(mask, exclude_cpu))
  return;

/*
 * NOTE: though ...
 */
nmi_trigger_cpumask_backtrace(...);



>  }
>
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

Is there some downside to this? It seems like anyone who has the SDE
interface would want this. Not sure why you'd suggest people say "N".

Other than the nit, this looks reasoanble to me, though I'm a complete
noob when it comes to SDEI...

Reviewed-by: Douglas Anderson <dianders@chromium.org>

