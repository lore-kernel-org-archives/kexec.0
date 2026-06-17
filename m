Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733E2CD98F0
	for <kexec@archiver.kernel.org>; Wed, 17 Jun 2026 20:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+pKOtTzj1X1FPOhRSZV8T11hRcVBU23IcwkR+mYiKNk=; b=1CWhDDy+EPnAxXbPSQZZhKbTd4
	LywRJpHlYQyd7yHzy0sGkcCOiTCW2dSE20b2n+ZvEG9l7cLrfMIGW1oZzG9oC0rdaKHrlEVgzq4zF
	70JSpAXY/fDr6/2p7ZPeq7cVxwmYlyvBqfmiaTXbTQwxByWcyGWVBFzKzf+nGsYHURv7VJtOv7eOJ
	j84N0vHknhqFx1jO6Kime2Kt+DXhVAfeHjdah1hJdrNhLXRyNPyu/dqhsafCiXEdDve7KXIKEpFUo
	i85lt2EMYJHDRwcuxiBSfXxtlQNwTFpDlJBIDNH/o1huUs1Eac6HrLN13K/F/5IO25LYEkX8Rh7pa
	SurxBxmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZwSw-00000000IYP-2zXr;
	Wed, 17 Jun 2026 20:02:26 +0000
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZwSt-00000000IXi-3oZl
	for kexec@lists.infradead.org;
	Wed, 17 Jun 2026 20:02:24 +0000
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-5bbc717c52aso90245e0c.0
        for <kexec@lists.infradead.org>; Wed, 17 Jun 2026 13:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781726542; x=1782331342; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pKOtTzj1X1FPOhRSZV8T11hRcVBU23IcwkR+mYiKNk=;
        b=bcqCZ2YLgrX0WQWIfkNegTivNH3rzJpv8FYHelCt5yxGXcIKTQnOOr5dX2cRzrSnlZ
         kCe0rrePhCPCbIVvT17BnYfHvEILAvhUURPzNH4U12DP4H1PGeNmmeED/kR6Adg6GP6D
         +Pw+BjlpQtoXEt0Lgz+uj/4RevcGC+NF8W+WI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781726542; x=1782331342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+pKOtTzj1X1FPOhRSZV8T11hRcVBU23IcwkR+mYiKNk=;
        b=CmYim9PgXFBm4LI/yvlMgYw2ZatsN3Lfu/VDMeJzwSUpGUSfXq9ehSU09sI/pal/kK
         oOKmZfW/F4tbyFbH/F481kpdIC6GjimtdZAVY2e+5jSeHPcQXzLlDSRGc8BcDna/0s3W
         IMNX65XlC73crM9EJjHU7Gich1GHRSRixvtUY/kSuGFr5OIF/u3IaK/aUcZyxXfzgyGW
         uL0BX3FMXecPOWFdm/7EH9S9XSZZHzdMmeHBiIH07z0ZH0SY/Dw6nTSgKmDQN5mV4EWJ
         +xgKGw8oW8qbFhKfRJfip5Oi/1BlOZDREQqS5tvA+3WLN9WvmrRA+xelXl2yJcWl06Pk
         OC9g==
X-Forwarded-Encrypted: i=1; AFNElJ96OVswA82lmxlqE04yo/bm6plj/vbdTnzOlNK290i8PeQW7A7jRv3ub8KpI+S8EUXRyL8Izg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzxnc1V+hYywLbrLWeU9DKDwv4Cd24cdxX+O0WqrupAGXhHAFB1
	snQOVuoEXPodkWZTfVjLEzrpEwqMTcMuKkDw3/wDI3MnHTsRIxtwXrcm1yYy/Rrc45rOkRBQNvP
	XSBc=
X-Gm-Gg: AfdE7cmMLA1ymJw/+2bh1XZS1L9Sr2ag2Fj/M0ZaIqNwWUKGRV+ZHmc2UgG+aBVmWG5
	HiqECaOhzsJnk9T18jwy1T9RDkP5RbdASQmjgno/PC7SIgp7x/qhoK+xWE9jegaa33xoeyQdN2X
	j+84XdW1nnzKNHmHD0zZQHOMRta/DJtuHAocXp4KptuiRtJRDXey98Y1695HBlJ2tbHS7mxeKqF
	SPADitEJQsXw5nwtyKWMrA8GWJuCJgWytWU1CvSuAMuKZ7jtVkkASktH8DMGUPE+QGrFyT6xX+z
	sD8mtmZV+Kxb4V7oOyWw3GPkpfJxZuVqcgfmKrvwWDDIjyD7OqC1BZMAZDXxKPjEdu/T61PSBuO
	+Gs4wiYGAM4AtLWT36FoaYO8GwshzYi0jA/LSg3L1WffGWsM4tlhFNyp2HSXRbjtOJb1wq4xt8F
	aysYQ1juqeX9GP7IpdTzs5/sjcZdzjutDRumX2IxAwIWg6d6+qwwA=
X-Received: by 2002:a05:6122:e46b:b0:59c:b1f7:4df3 with SMTP id 71dfb90a1353d-5bbd433e370mr320027e0c.12.1781726542257;
        Wed, 17 Jun 2026 13:02:22 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bbd3542586sm416307e0c.15.2026.06.17.13.02.19
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 13:02:21 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-9639e91e773so31980241.3
        for <kexec@lists.infradead.org>; Wed, 17 Jun 2026 13:02:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+pktKyi6aURHyFuADh7CY5OY5+d5Lk6XvegGeGtx+47jxEetTK2wGaoYTo77EvWvNsIlu3Gg==@lists.infradead.org
X-Received: by 2002:a05:6102:50aa:b0:71f:6308:1b6e with SMTP id
 ada2fe7eead31-727c707f964mr857902137.25.1781726538567; Wed, 17 Jun 2026
 13:02:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1781709543.git.kas@kernel.org> <97a870d0670b7e1c2fb9f5142f6e36c594282017.1781709543.git.kas@kernel.org>
In-Reply-To: <97a870d0670b7e1c2fb9f5142f6e36c594282017.1781709543.git.kas@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 17 Jun 2026 13:02:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V-BkwjJhZFV0YknsJeC+4os9q9pbdU09GXYUeUSLMfiw@mail.gmail.com>
X-Gm-Features: AVVi8Cfu7OoRciBnSTCdzLSbFTkbcaIaPRIaPmeTdJFLs4aPJ5NHkqY4JPOoYVw
Message-ID: <CAD=FV=V-BkwjJhZFV0YknsJeC+4os9q9pbdU09GXYUeUSLMfiw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] arm64: escalate smp_send_stop() to an SDEI NMI as
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
X-CRM114-CacheID: sfid-20260617_130223_948979_9D18C5E5 
X-CRM114-Status: GOOD (  17.50  )
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

On Wed, Jun 17, 2026 at 12:20=E2=80=AFPM Kiryl Shutsemau <kirill@shutemov.n=
ame> wrote:
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
>  arch/arm64/kernel/smp.c         | 113 +++++++++++++++++++++-----------
>  drivers/firmware/Kconfig        |   2 +
>  drivers/firmware/arm_sdei_nmi.c |  86 ++++++++++++++++++++++++
>  4 files changed, 187 insertions(+), 38 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

