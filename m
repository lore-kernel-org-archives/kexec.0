Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E909ACD6E7B
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 20:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cho74LPPbfY4ufBiNs1OFbSMRQHOtbZk95CDddcuzRA=; b=0KoYleOccgXF9CGXQr6f9KlTPB
	xcOEm1r/gE6oakX2TaLyMmqXA+JE0wHM5QlQNIkdUJ6PHvkicX8qltGhfzrrTNGMW/xNCw7okPALU
	PmsDYbEMDkQENesrlWHA0FZXKFdilsb6n1h4FA7AOxbRPV7SkfyAtsrDakIlaWXB6kdKoV/aoGBqC
	iAWFKoAZKaheXl6a+3pKvEd3umjopfMKnyFThT5c7quhOiMiXKwpx/8juLW7xIwdVIKFV+KHGaww8
	/UdAi4RTnBqFcqFTkLbRj339ub+K0wAVMznjXu1qzZnTqfUSBzh4Ht+fLPQVQfbtT4lihtQ5Nwdq4
	ATiiWMuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVbNq-00000001AVs-1E7W;
	Fri, 05 Jun 2026 20:43:14 +0000
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVbNo-00000001AVO-1PrM
	for kexec@lists.infradead.org;
	Fri, 05 Jun 2026 20:43:13 +0000
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-59be89d310aso2401133e0c.0
        for <kexec@lists.infradead.org>; Fri, 05 Jun 2026 13:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1780692191; x=1781296991; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cho74LPPbfY4ufBiNs1OFbSMRQHOtbZk95CDddcuzRA=;
        b=ElSj/Nkle7FLKIwbv8FFcltnS8bj9IJSV9YEW/wgxNr3nXAGuKvihfsgR/mP9SVqbf
         E3UuBrMJhpt/IC205INNKMGg4SpjMm+F6DcZt1702F6G3kzbJJu/JzrjBcRu9rm+eTBK
         cG+7tWv0EdcKlqeLaWREDsdoqfi6And/gvjVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780692191; x=1781296991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cho74LPPbfY4ufBiNs1OFbSMRQHOtbZk95CDddcuzRA=;
        b=sUp2m8a/hNEhXFTxdsS2KJlRQ3sPfDA5T8ruHm/wRCEfprNPBbh5G9S8pZd+gHRRvA
         OfbHpseRO4FvTtquqSAMkUfa7uqd4c4Ae9mNA3t4rSERI99OPyvVGFdKqbEWsRpkUiv+
         JvI+jG6oFk+VZNnuSukYNB3F514FR8OvYpQQBQDQDvDSsq+lKKhiPXpcPrFZQUj380cD
         gbODAerZCFvkAdVSxB84KPQxmN8aY8/E9gEh5lD7Tu29A+MzCdLuQoSo+WVM/4cZ8gdQ
         7F1/k4QD4uid/BGDJ/eACdpl119jAPoazNyWnjd1Iyd9cSydnEbTT8Orz1k1KrYhdW46
         yMsg==
X-Forwarded-Encrypted: i=1; AFNElJ+NFqBlzus8de8c6hAbsX2qJ1+HvZaKUM4iNicEr3102Wh7NBjczAaJ9G3GPpV3CVIm9Pg2vQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz4Fnurvkr3EYaW56s9oTmahweM0/Od1Mk0NGnY9FYL/Y9QmXlH
	k2LF+UGxbpw/3RWIyfVTAVzK0TcRkmp+7DvB/BHjAId4Ms25QveP1wLJzcjbM1lzIlaNCizFOlW
	BRdM=
X-Gm-Gg: Acq92OFsNguXS6k69TSvvpH1lXwyKeAqwLurz18z4NhBlsEEnXUH+T7uu9AAwJCYVmC
	z5xfhtgx41+Eb7kMso/p9w4+mpPrtqo/CpPY8W+rlEU4rYhldlyVsZH8dJLXTzcVRd00K4OeWQX
	kiMOMguu7YjuGm3IkHcD5C6H3MZYrmnvSyr6SbYC789AeCmT+ABD+tNOJL4KxYMfYCbGm6BwnRr
	IMdy8t90RHHk0c4YYfvOMC+IDr327MNqBZDyUMdu7/yoBIIKwQyxEOxkVAnh56IuOgU69obA8mM
	2rin8mYRUE/8F1MBTpVo73qUIWXH04tZrG0yj+1dtskDXmknnrjxy9FSXs5jDmiPwcWUpDIr+co
	4+zvgiXvFZJeMQFjVOYdhkUx/DKOOQhJhA7EMJy2q1cxg6bWftz049iEyumLZVY7FJR6gZkiqRt
	hvVAaxnNBsP0x44kyF4RPrKiMZZ1Da60HpnW/COJUMExXU7b5OfrOFLwCD/HKlAYnRf+G1MAGC4
	5bQ
X-Received: by 2002:a05:6122:c8d:b0:56f:696a:4fec with SMTP id 71dfb90a1353d-5acd8b4ef1bmr1687976e0c.5.1780692190934;
        Fri, 05 Jun 2026 13:43:10 -0700 (PDT)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6dc44d233sm8561645e0c.10.2026.06.05.13.43.08
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 13:43:09 -0700 (PDT)
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-59be89d310aso2401111e0c.0
        for <kexec@lists.infradead.org>; Fri, 05 Jun 2026 13:43:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/HNbWRSr/6tYzmgOKuibRD6fWXFlurb7AjaT5dvMBB29dwKOWiO1O2WHzdmEUNUYNxWFNTMQ==@lists.infradead.org
X-Received: by 2002:a05:6122:6d0c:b0:56b:942f:b870 with SMTP id
 71dfb90a1353d-5acce97fa0bmr1782104e0c.0.1780692188106; Fri, 05 Jun 2026
 13:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1780496779.git.kas@kernel.org> <54cb99db3c981dc39eb3031aff5caeaadb09e8b9.1780496779.git.kas@kernel.org>
In-Reply-To: <54cb99db3c981dc39eb3031aff5caeaadb09e8b9.1780496779.git.kas@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 5 Jun 2026 13:42:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X5++c-6Wd6babajiPbn07cfPcG0uW3ZeepznXgSVO2+w@mail.gmail.com>
X-Gm-Features: AVVi8CflIYMiZRPhuoda88AFJmay5Li2jpcnqm8IPxUeStYcxSTeJUSPo89hfx4
Message-ID: <CAD=FV=X5++c-6Wd6babajiPbn07cfPcG0uW3ZeepznXgSVO2+w@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: route crash_smp_send_stop() last resort
 through SDEI
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
X-CRM114-CacheID: sfid-20260605_134312_384921_A1323805 
X-CRM114-Status: GOOD (  24.19  )
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
> @@ -1288,8 +1288,32 @@ void crash_smp_send_stop(void)
>                 return;
>         crash_stop =3D 1;
>
> +       /*
> +        * Stop the normal way first: IPI_CPU_STOP escalating to a pseudo=
-NMI
> +        * IPI. Every CPU that responds saves its state via crash_save_cp=
u()
> +        * and parks in cpu_park_loop() with its online bit cleared -- th=
e
> +        * standard kdump stop, identical to a kernel without SDEI. Cruci=
ally
> +        * those CPUs stay in a clean, potentially-reusable state.
> +        */
>         smp_send_stop();
>
> +       /*
> +        * Whatever is still online didn't respond -- typically a CPU wed=
ged
> +        * with interrupts masked. The plain IPI can't reach it, and a fl=
eet
> +        * that declines the pseudo-NMI hot-path cost has no NMI IPI to
> +        * escalate to. Hit only the survivors with the SDEI cross-CPU NM=
I
> +        * (no-op if SDEI isn't active, or if everything already stopped)=
:
> +        * firmware delivers out of EL3 regardless of PSTATE.DAIF, and th=
e
> +        * handler captures crash_save_cpu() state from the wedged contex=
t
> +        * before parking the CPU.
> +        *
> +        * SDEI is deliberately last: an SDEI-stopped CPU never completes=
 its
> +        * event (it parks inside the handler, so EL3 retains its dispatc=
h
> +        * slot until reset), which is strictly less recoverable than a n=
ormal
> +        * stop. We pay that only for CPUs that left no other way to reac=
h them.
> +        */
> +       sdei_nmi_crash_smp_send_stop();

It feels weird to me that you're adding SDEI for "crash stop" but not
for regular "stop". It feels like you should modify smp_send_stop() to
fall back to SDEI if sending the NMI failed, instead of adding this
separate path.


>  static int sdei_nmi_handler(u32 event, struct pt_regs *regs, void *arg)
>  {
> +       int cpu =3D smp_processor_id();
> +
> +       if (READ_ONCE(*this_cpu_ptr(&sdei_nmi_crash_stop_requested))) {
> +               WRITE_ONCE(*this_cpu_ptr(&sdei_nmi_crash_stop_requested),=
 0);
> +
> +               /*
> +                * Capture the wedged context for kdump while pt_regs sti=
ll
> +                * points at the interrupted PC. This is the main motivat=
ion
> +                * for using SDEI here: the plain IPI stop path can't rea=
ch an
> +                * interrupt-masked CPU (and the fleet declines pseudo-NM=
I to
> +                * keep the IRQ-mask hot path cheap), so crash_save_cpu()=
 for
> +                * that CPU would otherwise record nothing useful.
> +                */
> +               crash_save_cpu(regs, cpu);
> +               set_cpu_online(cpu, false);
> +
> +               /* publish the crash state/offline before the requester s=
ees the ack */
> +               smp_wmb();
> +               WRITE_ONCE(*this_cpu_ptr(&sdei_nmi_crash_stop_acked), 1);
> +
> +               /*
> +                * Park forever from within the SDEI handler. We delibera=
tely
> +                * do NOT issue SDEI_EVENT_COMPLETE: the framework's retu=
rn
> +                * path restores firmware's saved interrupted context, wh=
ich
> +                * would land the CPU back wherever it was running (often
> +                * do_idle, which then notices cpu_is_offline=3Dtrue and =
BUGs
> +                * at cpuhp_report_idle_dead). Returning the modified pt_=
regs
> +                * doesn't help -- arch/arm64/kernel/sdei.c::do_sdei_even=
t
> +                * only honours a PC override via its IRQ-state heuristic
> +                * and otherwise hands EL3 its own saved-context slot bac=
k.
> +                *
> +                * Trade-off: EL3 firmware retains ~one saved-context slo=
t
> +                * per parked CPU until the next hardware reset (~hundred=
s of
> +                * bytes per CPU). The CPU itself is parked in cpu_park_l=
oop
> +                * exactly as if IPI_CPU_STOP had stopped it; recoverabil=
ity
> +                * is unchanged versus the existing path (neither is
> +                * recoverable without hardware reset, since PSCI sees th=
e
> +                * CPU as ALREADY_ON in both cases).
> +                */
> +               cpu_park_loop();
> +               /* unreachable */

Any chance we could avoid duplicating stuff from ipi_cpu_crash_stop()?


> +bool sdei_nmi_crash_smp_send_stop(void)
> +{
> +       unsigned int this_cpu, cpu, remaining;
> +       unsigned long timeout;
> +       cpumask_t mask;

The above will probably get you a yell. Putting "cpumask_t" on the
stack is a no-no since it can be quite large under certain CONFIG
options. This is why it's nearly always defined as "static".

-Doug

