Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7138CCD98C5
	for <kexec@archiver.kernel.org>; Wed, 10 Jun 2026 22:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JVD4DJVtoBrKvlbtSGq+TafFJcaizg8CU1ex4tJTqNc=; b=1UtciDKYoQm+WNhrO3xKelf7km
	+1tK4cAKMrIPhSR+/5TqP4Mh2tTZxwkvmYmi8MLYYmOLTeGbhLO2tKI3krVrI5KQTucr57o3ilMNo
	l2MBcWAqyVTyvzM//ccGiQ5f841xRQXtjIU69WVaeVgi+8NHcqaubnHBFCwamgiLpnOT1Titvny3g
	mcA/5edJq7dlpkRGMG0kwxshRtwuwgcswrORZBYopaDPsV1mngVVAXCECXic1T71V1/ZmhIiPIl+s
	I2x3ukHVUbF7EirM+Uwf2CZ/MROyj1gVaOg2TQKwli7hASiwxYO8n0vqrS1Ind7zmm/w0DWQDQ0pi
	OsNdDVqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXRl3-00000008Qhz-3vER;
	Wed, 10 Jun 2026 22:50:49 +0000
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXRl1-00000008QhB-3OY1
	for kexec@lists.infradead.org;
	Wed, 10 Jun 2026 22:50:49 +0000
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-8ccf7b7d188so77966666d6.1
        for <kexec@lists.infradead.org>; Wed, 10 Jun 2026 15:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781131845; x=1781736645; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVD4DJVtoBrKvlbtSGq+TafFJcaizg8CU1ex4tJTqNc=;
        b=Wu+p+chCN7lGfgmkQFGKkb2UGd1J9Q6lq8W2s5so6RSzu2cobe5SUeBNszSO7DjYnv
         4hgIF0POBXLiqzSWyMWA4Frt8J1GV+v4RWI6dSE2ILaRrVADGTKVwZjm8NDe1lw3QlzJ
         4t4aU1UxrmvNwEb9U2q4Sv1+iuLbay1YkU1ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781131845; x=1781736645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JVD4DJVtoBrKvlbtSGq+TafFJcaizg8CU1ex4tJTqNc=;
        b=GzZJEV73lhuAE4rgla+jhsZ5vXFExR4pDjd9SgkoaPhn0efXHYqvKU/GfjBw1YVbPb
         MFhKDw4TWuPe1V7SlGL88gDr+ww7QUcbng65Uteor4R9QT853RN4UOV9jElC3QUFi2yi
         fY6CHrNk/fZx4QIrP7qidTeu3aL/GRz0Oxlmr3gpPet2rq6DOikfZqhq7bnLkO2rVHSr
         PTdNPHnkcEV0O0dg1yBULLNQMKMW+mbJ1jQncvqBtJy2FlIOX9TkB2VREWvFuJ07PJAb
         NIP1I+pFPJAu8Cwci33u/iEsaHM8iJwUHOM851IvCMONrb0sOjnUqDfNhvoFMncwyItz
         n7sg==
X-Forwarded-Encrypted: i=1; AFNElJ+Tw6TJY9EpWMu3TqFeGUNZsFv8Uufcw/oiMBLRTrPPidaPsAxzf87tnqcqp7ZSBKaJnNcA4g==@lists.infradead.org
X-Gm-Message-State: AOJu0YwomGAxhL6l1MkyKtPA1M8bHwdfxv9HSkWQApAoSCrpkBAiVRmd
	BLRjn1Y8XsKTmnQKN9FJCIyjh16bcnEpqGwxpBQceCzfIV5mRYQ4DqI2hr+3OOH5k6GUNOLn3XK
	VT1M=
X-Gm-Gg: Acq92OHMI8MRXgBYOcz2r3PqL7emzm/7wfchlkTNE8zuNKAQZ/Cdvv6zIO/ctjvD8Fb
	b3axS5HIXQAD0f25htmnO+q1mizXszzZQmsmMatBRJkgwg7nHJ9jp35lohNOKvxULfm5MFqNwjV
	Fg4IooVd3YEhku2BQh0NEkJKor1G2twqXK6S7KZmP7q3lXIRJ/maVLX4rZ++QHcVQauC05w+gmL
	vEN5+qsjH+V2Csi7Ch1KyMI2swivAWC8nf9B3yMm+X0eXgPRb/gS7W3TVXDVy0olA3XfTyoqoMw
	LRfai+94hbXThoqPqEFHYZlxnn6uurSK8yyC7i9Vi2FFSeMUbznOmNuXo7PHhfGVb7RkU81X3Dp
	X83PBWybWaR+mXcmz+yohLlM/bqbF6xKUjwtkPK3PzBb/ZCDIQWOnlw+WsntFd8ZKKyH/08iFLL
	jb1PxWMVJUI6HU881EcfgiTR0/IKBvvctLzhXI1X+CloOBHDSNfz6dOmCtkoNkuTsGUngI50FR9
	dtV
X-Received: by 2002:a05:6214:3f82:b0:8cc:e659:d212 with SMTP id 6a1803df08f44-8d1de79bb03mr1783656d6.26.1781131845431;
        Wed, 10 Jun 2026 15:50:45 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd077be8sm249628166d6.40.2026.06.10.15.50.44
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 15:50:45 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-517b1f2c668so45653601cf.2
        for <kexec@lists.infradead.org>; Wed, 10 Jun 2026 15:50:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+RGlCvX+K2wn6V+Q0/EyAi3luTm5DDWn5STqz52Ge8kDem7XFf8rU3v8MTLIIaOJfua+A4nA==@lists.infradead.org
X-Received: by 2002:a05:622a:6201:b0:517:906b:c043 with SMTP id
 d75a77b69052e-517ee1c5958mr4710171cf.36.1781131843959; Wed, 10 Jun 2026
 15:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1780496779.git.kas@kernel.org> <cover.1781013134.git.kas@kernel.org>
 <a7ed093b78e6966c049bacc7644a8a00a9a52720.1781013134.git.kas@kernel.org>
In-Reply-To: <a7ed093b78e6966c049bacc7644a8a00a9a52720.1781013134.git.kas@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 10 Jun 2026 15:50:32 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VLoJBMhDjb=3XAOCZWDBACn_=KdnkL0J6-Ch4uKrHjNA@mail.gmail.com>
X-Gm-Features: AVVi8CciGqVcpIhL2Q7MYd6G_uBvzThyYEUZAtEldfH-MO5pE6wmOHBhbivRT1s
Message-ID: <CAD=FV=VLoJBMhDjb=3XAOCZWDBACn_=KdnkL0J6-Ch4uKrHjNA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: escalate smp_send_stop() to an SDEI NMI as
 a last resort
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	James Morse <james.morse@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Petr Mladek <pmladek@suse.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Usama Arif <usama.arif@linux.dev>, 
	Breno Leitao <leitao@debian.org>, Julien Thierry <julien.thierry.kdev@gmail.com>, 
	Lecopzer Chen <lecopzer@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, kernel-team@meta.com, 
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_155047_898433_8F0B772D 
X-CRM114-Status: GOOD (  34.94  )
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

On Tue, Jun 9, 2026 at 6:58=E2=80=AFAM Kiryl Shutsemau <kirill@shutemov.nam=
e> wrote:
>
> @@ -910,6 +911,35 @@ static void __noreturn ipi_cpu_crash_stop(unsigned i=
nt cpu, struct pt_regs *regs
>  #endif
>  }
>
> +#ifdef CONFIG_ARM_SDEI_NMI
> +/*
> + * Stop entry for the SDEI cross-CPU NMI service: its event-0 handler
> + * lands here when this CPU was asked to stop. The bookkeeping mirrors
> + * the IPI_CPU_STOP{,_NMI} handling; the park happens inside the SDEI
> + * event, which is never completed -- completing it would have firmware
> + * resume the interrupted (typically wedged) context. No PSCI CPU_OFF
> + * either: powering off a PE that EL3 still considers mid-event invites
> + * firmware trouble.
> + */
> +void __noreturn arm64_nmi_cpu_stop(struct pt_regs *regs)
> +{
> +       unsigned int cpu =3D smp_processor_id();
> +
> +       local_daif_mask();
> +
> +       if (IS_ENABLED(CONFIG_KEXEC_CORE) && crash_stop)
> +               crash_save_cpu(regs, cpu);
> +
> +       /* the ack the stop requester polls for */
> +       set_cpu_online(cpu, false);
> +
> +       sdei_mask_local_cpu();
> +
> +       cpu_park_loop();
> +}
> +NOKPROBE_SYMBOL(arm64_nmi_cpu_stop);
> +#endif

Can we combine everything into one function so we don't have to keep
all the different stop functionality in sync? Like this (untested):

void __noreturn arm64_nmi_cpu_stop(struct pt_regs *regs, bool die_on_crash)
{
  unsigned int cpu =3D smp_processor_id();
  bool crash =3D IS_ENABLED(CONFIG_KEXEC_CORE) && crash_stop;

  /*
   * Use local_daif_mask() instead of local_irq_disable() to make sure
   * that pseudo-NMIs are disabled. The "stop" code starts with
   * an IRQ and falls back to NMI (which might be pseudo). If the IRQ
   * finally goes through right as we're timing out then the NMI could
   * interrupt us. It's better to prevent the NMI and let the IRQ
   * finish since the pt_regs will be better.
   */
  local_daif_mask();

  if (crash)
    crash_save_cpu(regs, cpu);

  set_cpu_online(cpu, false);

  sdei_mask_local_cpu();

  if (crash && die_on_crash)
    __cpu_try_die(cpu);

  /* just in case */
  cpu_park_loop();
}

Then in do_handle_IPI(), it's just:

  case IPI_CPU_STOP:
  case IPI_CPU_STOP_NMI:
    arm64_nmi_cpu_stop(get_irq_regs(), true);
    break;

...and from the SDEI code you pass "false" for "die_on_crash".

Perhaps when doing that you'd stop unconditionally getting the cpu in
do_handle_IPI() and just call it for `IPI_KGDB_ROUNDUP` since it would
now be the only consumer of that local variable.

FWIW, I'm not totally sure I followed the logic for why "die_on_crash"
needs to be "false" for the SDEI case, but I also am not terribly
familiar with KEXEC and crash-dumping kernels, since I've never
attempted to get that feature to work.


> @@ -1263,6 +1293,29 @@ void smp_send_stop(void)
>                         udelay(1);
>         }
>
> +       /*
> +        * If CPUs are *still* online, try the SDEI cross-CPU NMI. Firmwa=
re
> +        * delivers it regardless of the target's DAIF state, so it reach=
es
> +        * a CPU spinning with interrupts masked, which neither rung abov=
e
> +        * could (without pseudo-NMI there is no NMI rung at all). Allow
> +        * 100ms: a firmware round-trip per CPU, with headroom.
> +        */
> +       if (num_other_online_cpus()) {
> +               /* re-snapshot after the rungs above took CPUs offline */
> +               smp_rmb();
> +               cpumask_copy(&mask, cpu_online_mask);
> +               cpumask_clear_cpu(smp_processor_id(), &mask);
> +
> +               if (sdei_nmi_stop_cpus(&mask)) {
> +                       pr_info("SMP: retry stop with SDEI NMI for CPUs %=
*pbl\n",
> +                               cpumask_pr_args(&mask));

Perhaps it's being a bit pedantic, but it's a little weird that you're
printing a message that sounds like "I'm going to retry with SDEI"
after you've already done it. It feels like it would be nominally
cleaner (and more parellel with the pseudo-NMI case) if you could
separately test if SDEI is available. Then sdei_nmi_stop_cpus() would
just return void?


> @@ -59,8 +64,45 @@ static bool sdei_nmi_available;
>
>  #define SDEI_NMI_EVENT                 0
>
> +/*
> + * Stop-request dispatch lives on the same SDEI event 0 as everything
> + * else. The requesting CPU sets each target's bit in sdei_nmi_stop_mask
> + * before signalling event 0; the target's handler test-and-clears its
> + * bit and hands the CPU to arm64_nmi_cpu_stop(), which saves crash
> + * state when the stop is a kdump crash-stop, marks the CPU offline
> + * (which is what the requester polls for) and parks it.
> + *
> + * This mirrors the cpumask the framework's nmi_cpu_backtrace() consults
> + * just below, and a shared mask rather than a separate SDEI event avoid=
s
> + * extra registrations from firmware.
> + */

Do you have any reasoning for why you don't pick a separate EVENT ID
for "backtrace" vs. "stop". If you absolutely have to share an ID
because they're a limited resource then I guess it's fine, but it
would make the code easier to understand / reason about if they were
separate IDs.

If you had a separate EVENT ID, then it seems like you could
completely eliminate the (potentially large) `sdei_nmi_stop_mask`
variable, right? Any time a "STOP" event fires you can unconditionally
consider it to be a stop w/ no globals needed, right?


> @@ -115,6 +157,35 @@ bool sdei_nmi_trigger_cpumask_backtrace(const cpumas=
k_t *mask, int exclude_cpu)
>         return true;
>  }
>
> +/*
> + * Last rung of the stop escalation in smp_send_stop() (see
> + * arch/arm64/kernel/smp.c). The caller runs the regular stop IPI (and
> + * the pseudo-NMI stop IPI, where available) first; @mask holds whatever
> + * stayed online through those -- typically CPUs wedged with interrupts
> + * masked, unreachable by an IPI. Set each target's stop-request flag an=
d
> + * signal event 0 at it; a target acks by marking itself offline, which
> + * the caller polls for.
> + *
> + * Returns false when SDEI isn't active, so the caller can skip the wait=
.
> + */
> +bool sdei_nmi_stop_cpus(const cpumask_t *mask)
> +{
> +       unsigned int cpu;
> +
> +       if (!sdei_nmi_available)
> +               return false;
> +
> +       cpumask_or(&sdei_nmi_stop_mask, &sdei_nmi_stop_mask, mask);

As per above, hopefully we can get rid of `sdei_nmi_stop_mask`. ...but
if we keep it, I'm curious why "or" and not "copy"?

