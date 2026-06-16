Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62006CD98E1
	for <kexec@archiver.kernel.org>; Tue, 16 Jun 2026 21:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ku36PgmZ23d8x6k2ldFVCZ2r1RXJuytjTrS1Up4q2Vc=; b=ZA5n7KZa28r67/dPLVCLX1YMQ/
	cdBIvCo8ZkCCHoF35BNzCuazNXr6RJK7AnBsL24ooQ5MF3ULXI1+zREKcBYRIc6yjQexa+xmQ7tie
	Ck5avnFVDQN8N/Ow+RxXeVRTTvRsATzdYNypPDdBvYlZjF1KBV0UCmxn66U1EnTUt0dzpODA7DJ7d
	o67hJ5f1xO2qiAryzB6UcZ815EOVa3rQB82VZg8lRIDwSz++wfF9ukiZ7eaeEE7BzKsy7x9xNWu9D
	nFqBDrjPBIEC5opZjXSQebmtLDC/EZrDuxeW+UQXiiUnnc0BH8O/2KMEL+Q9PVod8yF+gWf0JQHv+
	VpPbqktA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZbUQ-0000000GLsr-1KzR;
	Tue, 16 Jun 2026 21:38:34 +0000
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZbUN-0000000GLsA-2PBa
	for kexec@lists.infradead.org;
	Tue, 16 Jun 2026 21:38:32 +0000
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-5a7c7e13b84so2971511e0c.0
        for <kexec@lists.infradead.org>; Tue, 16 Jun 2026 14:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781645910; x=1782250710; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ku36PgmZ23d8x6k2ldFVCZ2r1RXJuytjTrS1Up4q2Vc=;
        b=OxBIhyS57tR/n+OvwMLuzrruC2iZCzQ97VIOhxYBB7nbjPXjAZirqutgE7AADY05TA
         nMf1cRUPnI4mjlr2PKUUSzHZrhSy1puM7l4EyJkXNGsc/ZfJ5sB6kXKdHOg5zevD/Ay5
         T4hWt0maezGeP60KQqNG1sP7V/1owYRyLA4Ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781645910; x=1782250710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ku36PgmZ23d8x6k2ldFVCZ2r1RXJuytjTrS1Up4q2Vc=;
        b=btvcpBNONBpVf73AIEsGYuoWs2nF8zj0PKj1KruyZ/dL6qr2+88nuqdRLesEWr8kpZ
         YpCQtPGqEsoMHizEVJlHyIK/UGqG1w7jdlFMJsJHCKm+BvGEDgIgjryCoXnsqpKvqyW5
         4QVfrMG7Zh5moeeHMm9zO60iJheaeTUAJrE66dv6t3ZSZ98nzO1oxbz88sYL0Ax+awQy
         1IYyjiAWffXIAAy7AY1hVCOzOujMY2sSW0surftBSd1F4HRjI4EyPtjXENHrJKBOOuQY
         xOOdI92Z0bvIzs2u2CPGmtG/T9dJXn6vDfPSlAmFZMbEgxvymXHZKWztWTYk49/MMpky
         9h6w==
X-Forwarded-Encrypted: i=1; AFNElJ8NjJ5Q7thP4crkdRfAbWyqE2dkIYVzSWqPS9M+fDTeKU8oT9ZbINQ/a4aB2OdUVzp545pnHw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwPtZuLCQcPDm9dcC1vUpIV8V+nAYb/PI2xjhcX9viVvutwC6Yl
	kXR32z/kGMavALgbOH7ux3nUkvEmGLefa1FNn7qCb33Ni77om9Aqnce9tWNoOIpUUnHyynUgJaF
	WO64=
X-Gm-Gg: Acq92OE0/N9N/2l8MzX/sUc8aOZhN6r6EeEEY+uvwJIE9RKXGSGzkkyZF/5ori9Efxl
	Gb0LcNHm/2KFnSKTo2SDLUe1Wu5nagtJbH2pdUZKdAZJ+q0dmLHT3ry7CPfW42wmXzy7fdPHOkt
	h9Wj89VSwrn3/7ZSulQHwQXKuIRjQT5Z+/AN16vIJ6KZw/YqXk7MzEnFBkYW0ow2M7WWW8fMMkV
	MPGjwzQPH1mLTRb+jCrb9p0PKRXaHKkOW9kVNa9o74E+0RGS8rpp/GeR2uY72RurkpMxw+PQo33
	QUfFDOrFa3Ho2K/O18GOBA7b8ci9UfxWBBldpj55E4bOpRY6WRK53KAkLbRMAWvvsVC37Q58eeV
	y9TYVnwGc7nPxBVe09cT3/fvv9vBXQhEqB3MZpD1ws9BsBpJ4f6PfvmVMe2+6mNevwKAfoY7mE8
	huglyfJrxsFgaqHaVC4c3s6pblPk1okZo2+WXrlU8bxs/YdV0PqNy8S5QdMwtUcA==
X-Received: by 2002:a05:6122:e252:b0:59e:5bfa:e06c with SMTP id 71dfb90a1353d-5bbbe70b1dcmr785290e0c.13.1781645909777;
        Tue, 16 Jun 2026 14:38:29 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bb90015ef9sm7059193e0c.7.2026.06.16.14.38.28
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 14:38:28 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-6cb414a5d50so4042673137.3
        for <kexec@lists.infradead.org>; Tue, 16 Jun 2026 14:38:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ96pzEbM3J3FrPe58WxL0vF16zuiMxQs0pb0Zi9q3RZB9q8ZJajOMkUAdczXGEtcdfcYpa+VQ==@lists.infradead.org
X-Received: by 2002:a05:6102:3910:b0:631:ff40:22b2 with SMTP id
 ada2fe7eead31-7245d20641emr780692137.2.1781645907501; Tue, 16 Jun 2026
 14:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1781490440.git.kas@kernel.org> <167493d30ef6c99a44291de14cddd41ced8149c4.1781490440.git.kas@kernel.org>
In-Reply-To: <167493d30ef6c99a44291de14cddd41ced8149c4.1781490440.git.kas@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 16 Jun 2026 14:38:16 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WK0=xTZOWK+yDqEtGbbhkvoW50ekHKBBWhpoO9Zb8cBQ@mail.gmail.com>
X-Gm-Features: AVVi8Ce2TIVRIg1dSgVrmoNtDRnxocNt72MHs5ddjhzazA-47T8vaWkWcQhOaik
Message-ID: <CAD=FV=WK0=xTZOWK+yDqEtGbbhkvoW50ekHKBBWhpoO9Zb8cBQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] arm64: escalate smp_send_stop() to an SDEI NMI as
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
X-CRM114-CacheID: sfid-20260616_143831_666599_D7E0C91E 
X-CRM114-Status: GOOD (  25.40  )
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

On Sun, Jun 14, 2026 at 7:36=E2=80=AFPM Kiryl Shutsemau <kirill@shutemov.na=
me> wrote:
>
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

Nice to have all the details in the function comment. Any reason why
you didn't use kernel-doc format? Nothing else in this file does, I
guess, but it doesn't seem like it would be a problem to start the
trend... ;-)


> @@ -59,8 +64,51 @@ static bool sdei_nmi_available;
>
>  #define SDEI_NMI_EVENT                 0
>
> +/*
> + * Backtrace and stop both ride SDEI event 0. That is not a chosen econo=
my:
> + * event 0 is the only architecturally software-signalled event -- the s=
ole
> + * event SDEI_EVENT_SIGNAL can target at an arbitrary PE. Every other ev=
ent
> + * number is a firmware/platform interrupt-bound event, not something th=
e
> + * kernel can raise cross-CPU, so a dedicated "stop" event would need
> + * firmware to define and bind it -- exactly the firmware dependency thi=
s
> + * driver sets out to avoid.
> + *
> + * Sharing one event means the handler must tell a stop apart from a
> + * backtrace. A stop is terminal and system-wide -- sdei_nmi_stop_cpus()=
 is
> + * only reached from smp_send_stop() (reboot/halt/panic/kdump), which ne=
ver
> + * returns -- so once a stop is requested, every later event-0 fire is a
> + * stop too. A single write-once flag therefore carries as much as a
> + * per-CPU mask would: sdei_nmi_stop_cpus() sets it before signalling, a=
nd
> + * the handler reads a set flag as "stop this CPU" and a clear flag as
> + * "backtrace" (handled by nmi_cpu_backtrace(), which self-gates on the
> + * framework's backtrace mask). A backtrace fire that races in after a s=
top
> + * has begun just stops that CPU instead -- harmless, it is going down.
> + */
> +static bool sdei_nmi_stopping;
> +
>  static int sdei_nmi_handler(u32 event, struct pt_regs *regs, void *arg)
>  {
> +       if (READ_ONCE(sdei_nmi_stopping)) {

Don't you need a smp_rmb() before that, to match with the smp_wmb()?

-Doug

