Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68508CD8C9D
	for <kexec@archiver.kernel.org>; Thu, 11 Jun 2026 17:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mm880qLh/i3jX1tK5DCVsmZYJa6PWTuIk2/1vdIb1Ac=; b=dM2VqILdCyuePWKU3rPsEoTUpv
	3K4PNLAaL04TZTPKiqKslyYd8fXZeyEBF7a6CsxyufC4H7DmFAZXfAIZhloHUkg6EVWMj5MnkEzBc
	tzhZxwP1jOv9t1+a9ibL7WR0K/K4Urts5pBlZJOERBVqRWGgwtR+xX3aAkwBznk71FgULZylsep+U
	mMAC/tAT83TJINwHvDVzXMBXdvEKckIA5dTM9WP/iMLVAKh+3XTVheJw2g5opXXM/e266wA5o5R1w
	CHaZVkXVrfcY2zXAiYxIujJhkcaDXoaeHZGQQ+yWxgrbbtN1VTNFNYehmcbTqavFYuFvpjhkr8TVV
	d12kKzcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXjVW-00000009qcd-1Aaa;
	Thu, 11 Jun 2026 17:47:58 +0000
Received: from fhigh-a3-smtp.messagingengine.com ([103.168.172.154])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXjVN-00000009qbh-3Yjh;
	Thu, 11 Jun 2026 17:47:52 +0000
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A51071400129;
	Thu, 11 Jun 2026 13:47:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 11 Jun 2026 13:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1781200066; x=1781286466; bh=mm880qLh/i3jX1tK5DCVsmZYJa6PWTuI
	k2/1vdIb1Ac=; b=3XMCxLz8QCtnI3oWv2KvZ6li8yFYF7PH0D0l7n+Ib15Biosk
	lMyiulHDL+v2R2IasKniRG9+UdUwbS8ylblv4ZtOF/3c58tUvAxYjgu78pEfqahG
	YGdbnVt3nR2SzMSy9mj79+tLe5Jphcc8oUy88Y2fRfzua+vxcPumZovFTdun3Mhd
	BS6Z/SR0XYpqVJSFD7t1zOl4ZHLT9JnJlfLmi2VDoylU3598LrHbiYSKZvXAuXWm
	uKN6fJTA6+cMxgIR0V0fKDC2EcJyRlUygXjWUnKaIiHjMFqAFB7K9gNYOQeeB3iu
	92wufd34ihLOoitZRP/t+eDwM/GjACksaxAUag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781200066; x=
	1781286466; bh=mm880qLh/i3jX1tK5DCVsmZYJa6PWTuIk2/1vdIb1Ac=; b=C
	XnkmSFL6q92lu+i/bypv68C9dR+E49UUthtnrMrc1yid4+qhBiK5UTDNbZmgc2lx
	ROlT+1OBEtNeDPGrabyc63M+GxbRRUAc43Vg027ZPqrBHZcTkLlEvH4g4HQs02w5
	EQwoxsHICs3CgguLK89yXtb4HeZTRuCUOzh0MrdSE8/Pgm07cnwbRDv6xMyjCHce
	ohq6zQ5AD8SDNaMsju+KyX2INupYHv4k17o7sir7oybid9XrWaNDuEm6X6UAPdq9
	e03ATJAN9+MBwb4fs59clBtqUGHKw+VesGviVZGfAmayesyPLs2ZTuD5ppsUnf23
	TigSikiWAELBf5dMKEbmg==
X-ME-Sender: <xms:wfQqarfbuxGznhWRifaGX3QvaNZsezQX87bSg6ObC5mxv1dLLuEdDA>
    <xme:wfQqakX5OmbCnIAKpkWBt2NWwuz61zTU0b0r3TwK0jEEmw5ckwfDGz1p4x75X8ehz
    yMqRN-gf6jV2lAqThe0XLzdc8qAgZUQ8SH5zqwdoNqPzyyf8t44tQ>
X-ME-Received: <xmr:wfQqah-y7EhI_UissrGNHkos1FaRhkc5HYD5gWOkgqXckx__nR64sDiENwzKXg>
X-ME-Proxy-Cause: dmFkZTEvLe78hHdX88S0Mxh8tcfWSX6AatqGmnXwxIKf6M0tOnj1KBexeeou86xB3VrSEF
    vm7PTSjFAhFVafztKFJNW+JPgO+n05NCz6HmOtnDJ459FslLMdc/Nscm2a51L52tmMekU6
    bZI2q9kNzc9gQcgrVe5BxfLgA65LlfNuW1JVEuduhhDTwXPSrkPwE8/OTTG8ZxRjMpAa3U
    uMCjkoUqv6pzG6nOhnDIRqAEkSj4on/xrUw4P/rkGZiVvy6MpMlHCX+s7bB+zzUFVBjkN3
    5tHDZyB2TJXgcyCtWEOjEbSisOsmLlkDsYNmqRo73M9BIZxP0AsbtKSXSc0ao6qniGk/Zq
    8HHRg/nwm4/CB3PSUIKeUDFmQpGBxMUH3HOcyu8m1jrjxx8yAfZlIbAULNe8NeKlrk2ntc
    Tvq0sfOQdVyEML0mUmGCUGHCLJng9jLb5WFTrPtbYewUXJhoMsxtoo51/+WNqddybOOTK+
    lh2bRXDvu4/LEL30TFAMJ6PhhRqS5fV4tKKJKDZjRKvPIHde7RoFhZE8FWgqSQfVj5uLwX
    3lHah2d8N6haH+/DyqYo+KXm2lB/ztUVoUQFezFX/aNS0w4CRs/XcayzKltyWYHih61glC
    JkiCE5oglR0GBUBSKLB02grObmVwJ7ZMYPtmLaaSXyszwiTOWol47FKF6ggw
X-ME-Proxy: <xmx:wfQqahgwhtrkps58aiIWhoYv3y7CTitB43euEyurC57Zzj_OrS78Cg>
    <xmx:wfQqamU4VfvmzfK1K0kQ1hwGOzSwM2KbYbD8Muodrw4tVCO6Fs_iMw>
    <xmx:wfQqaoukmiR29OuxH7AryP_pn6BRDjUqjvszSqGbIJI_jv0952E9ww>
    <xmx:wfQqag6jAor4DxeM98qvGoJCe5sdv2WTHJ5IS6pjIzYKnbvlhzOBPw>
    <xmx:wvQqajUK-XFaCAcL8Ao7o-OtvIoqtw5m8NWigQknXoNrlOL6dyOYhy8k>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 13:47:43 -0400 (EDT)
Date: Thu, 11 Jun 2026 18:47:37 +0100
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
Subject: Re: [PATCH v2 3/3] arm64: escalate smp_send_stop() to an SDEI NMI as
 a last resort
Message-ID: <airhxVP7vAVehIXQ@thinkstation>
References: <cover.1780496779.git.kas@kernel.org>
 <cover.1781013134.git.kas@kernel.org>
 <a7ed093b78e6966c049bacc7644a8a00a9a52720.1781013134.git.kas@kernel.org>
 <CAD=FV=VLoJBMhDjb=3XAOCZWDBACn_=KdnkL0J6-Ch4uKrHjNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=VLoJBMhDjb=3XAOCZWDBACn_=KdnkL0J6-Ch4uKrHjNA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260611_104750_185508_E1FBE0C2 
X-CRM114-Status: GOOD (  54.14  )
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

On Wed, Jun 10, 2026 at 03:50:32PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Tue, Jun 9, 2026 at 6:58 AM Kiryl Shutsemau <kirill@shutemov.name> wrote:
> >
> > @@ -910,6 +911,35 @@ static void __noreturn ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs
> >  #endif
> >  }
> >
> > +#ifdef CONFIG_ARM_SDEI_NMI
> > +/*
> > + * Stop entry for the SDEI cross-CPU NMI service: its event-0 handler
> > + * lands here when this CPU was asked to stop. The bookkeeping mirrors
> > + * the IPI_CPU_STOP{,_NMI} handling; the park happens inside the SDEI
> > + * event, which is never completed -- completing it would have firmware
> > + * resume the interrupted (typically wedged) context. No PSCI CPU_OFF
> > + * either: powering off a PE that EL3 still considers mid-event invites
> > + * firmware trouble.
> > + */
> > +void __noreturn arm64_nmi_cpu_stop(struct pt_regs *regs)
> > +{
> > +       unsigned int cpu = smp_processor_id();
> > +
> > +       local_daif_mask();
> > +
> > +       if (IS_ENABLED(CONFIG_KEXEC_CORE) && crash_stop)
> > +               crash_save_cpu(regs, cpu);
> > +
> > +       /* the ack the stop requester polls for */
> > +       set_cpu_online(cpu, false);
> > +
> > +       sdei_mask_local_cpu();
> > +
> > +       cpu_park_loop();
> > +}
> > +NOKPROBE_SYMBOL(arm64_nmi_cpu_stop);
> > +#endif
> 
> Can we combine everything into one function so we don't have to keep
> all the different stop functionality in sync? Like this (untested):
> 

Okay. Look good to me. See the patch below.

void __noreturn arm64_nmi_cpu_stop(struct pt_regs *regs, bool die_on_crash)
The stop IPI handlers call it with die_on_crash=true, the SDEI handler
and panic_smp_self_stop() with false. Pretty much your sketch, with the
crash = IS_ENABLED(CONFIG_KEXEC_CORE) && crash_stop discriminator inside.

> FWIW, I'm not totally sure I followed the logic for why "die_on_crash"
> needs to be "false" for the SDEI case,

It's not about kexec mechanics, it's about the SDEI dispatch state.

The SDEI stop handler parks inside an SDEI event that it deliberately
never completes — completing it makes firmware resume the wedged
context, which is the opposite of what we want. PSCI CPU_OFF from inside
that not-yet-completed event silently wedges EL3 on at least one
production firmware (still root-causing on the firmware side), so the
SDEI path saves the crashed context and parks instead of powering off.

The only consequence is that an SMP capture kernel can't re-online that
CPU. The dump itself is complete. I've left "power the SDEI-stopped CPU
off too" as a follow-up and called it out in the cover letter. The IPI
crash path is unaffected and still does CPU_OFF, exactly as before.

> Perhaps when doing that you'd stop unconditionally getting the cpu in
> do_handle_IPI() and just call it for `IPI_KGDB_ROUNDUP` since it would
> now be the only consumer of that local variable.

I kept the local cpu — after the change it's still used by the
IPI_KGDB_ROUNDUP case and the default: pr_crit(), so it didn't become
single-use.

> > @@ -1263,6 +1293,29 @@ void smp_send_stop(void)
> >                         udelay(1);
> >         }
> >
> > +       /*
> > +        * If CPUs are *still* online, try the SDEI cross-CPU NMI. Firmware
> > +        * delivers it regardless of the target's DAIF state, so it reaches
> > +        * a CPU spinning with interrupts masked, which neither rung above
> > +        * could (without pseudo-NMI there is no NMI rung at all). Allow
> > +        * 100ms: a firmware round-trip per CPU, with headroom.
> > +        */
> > +       if (num_other_online_cpus()) {
> > +               /* re-snapshot after the rungs above took CPUs offline */
> > +               smp_rmb();
> > +               cpumask_copy(&mask, cpu_online_mask);
> > +               cpumask_clear_cpu(smp_processor_id(), &mask);
> > +
> > +               if (sdei_nmi_stop_cpus(&mask)) {
> > +                       pr_info("SMP: retry stop with SDEI NMI for CPUs %*pbl\n",
> > +                               cpumask_pr_args(&mask));
> 
> Perhaps it's being a bit pedantic, but it's a little weird that you're
> printing a message that sounds like "I'm going to retry with SDEI"
> after you've already done it. It feels like it would be nominally
> cleaner (and more parellel with the pseudo-NMI case) if you could
> separately test if SDEI is available. Then sdei_nmi_stop_cpus() would
> just return void?

Fixed. There's now a sdei_nmi_active() predicate; the rung tests it,
prints, then calls sdei_nmi_stop_cpus(), which is now void. It mirrors
the pseudo-NMI rung's check-then-act shape.

> 
> 
> > @@ -59,8 +64,45 @@ static bool sdei_nmi_available;
> >
> >  #define SDEI_NMI_EVENT                 0
> >
> > +/*
> > + * Stop-request dispatch lives on the same SDEI event 0 as everything
> > + * else. The requesting CPU sets each target's bit in sdei_nmi_stop_mask
> > + * before signalling event 0; the target's handler test-and-clears its
> > + * bit and hands the CPU to arm64_nmi_cpu_stop(), which saves crash
> > + * state when the stop is a kdump crash-stop, marks the CPU offline
> > + * (which is what the requester polls for) and parks it.
> > + *
> > + * This mirrors the cpumask the framework's nmi_cpu_backtrace() consults
> > + * just below, and a shared mask rather than a separate SDEI event avoids
> > + * extra registrations from firmware.
> > + */
> 
> Do you have any reasoning for why you don't pick a separate EVENT ID
> for "backtrace" vs. "stop". If you absolutely have to share an ID
> because they're a limited resource then I guess it's fine, but it
> would make the code easier to understand / reason about if they were
> separate IDs.
> 
> If you had a separate EVENT ID, then it seems like you could
> completely eliminate the (potentially large) `sdei_nmi_stop_mask`
> variable, right? Any time a "STOP" event fires you can unconditionally
> consider it to be a stop w/ no globals needed, right?

Separate event IDs aren't available: SDEI_EVENT_SIGNAL only ever signals
event 0 — it's the one architecturally software-signalled event. Every
other event number is an interrupt-bound event that firmware has to
define and bind, which is the firmware dependency this series is
specifically trying not to add. So backtrace and stop are stuck sharing
event 0.

But you're right that the mask should go — just not via a second event. A
stop is terminal and system-wide (sdei_nmi_stop_cpus() is only reached
from smp_send_stop(), which never returns), so once a stop is requested
every later event-0 fire is a stop too. I replaced the cpumask with a
single write-once flag the handler reads; a backtrace that races in
after a stop has begun just stops that CPU, which is fine. So the
(potentially large) variable is gone.

> > @@ -115,6 +157,35 @@ bool sdei_nmi_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu)
> >         return true;
> >  }
> >
> > +/*
> > + * Last rung of the stop escalation in smp_send_stop() (see
> > + * arch/arm64/kernel/smp.c). The caller runs the regular stop IPI (and
> > + * the pseudo-NMI stop IPI, where available) first; @mask holds whatever
> > + * stayed online through those -- typically CPUs wedged with interrupts
> > + * masked, unreachable by an IPI. Set each target's stop-request flag and
> > + * signal event 0 at it; a target acks by marking itself offline, which
> > + * the caller polls for.
> > + *
> > + * Returns false when SDEI isn't active, so the caller can skip the wait.
> > + */
> > +bool sdei_nmi_stop_cpus(const cpumask_t *mask)
> > +{
> > +       unsigned int cpu;
> > +
> > +       if (!sdei_nmi_available)
> > +               return false;
> > +
> > +       cpumask_or(&sdei_nmi_stop_mask, &sdei_nmi_stop_mask, mask);
> 
> As per above, hopefully we can get rid of `sdei_nmi_stop_mask`. ...but
> if we keep it, I'm curious why "or" and not "copy"?

It doesn't matter anymore. Mask is gone.

Thanks for the feedback! Any other comments?

--------------------------------8<-----------------------------------------------

From c25c32428c5f4fd896815acec5633240326e810c Mon Sep 17 00:00:00 2001
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Date: Tue, 2 Jun 2026 15:28:10 +0100
Subject: [PATCHv2.1 3/3] arm64: escalate smp_send_stop() to an SDEI NMI as a last
 resort

A CPU wedged with interrupts masked ignores the stop IPI, and without
pseudo-NMI there is no NMI IPI to escalate to: a reboot proceeds with
the CPU still running, and a kdump misses its registers.

Add a third rung to smp_send_stop(): once the IPI (and pseudo-NMI IPI,
if enabled) rungs have run, signal SDEI event 0 at whatever stayed
online. Firmware delivers it regardless of the target's DAIF, so it
reaches a CPU a plain IPI cannot; the target acks by going offline,
which the caller already polls for.

Fold the stop bookkeeping into one arm64_nmi_cpu_stop(regs,
die_on_crash), shared by the stop IPI handlers, panic_smp_self_stop()
and the SDEI handler, replacing the near-duplicate local_cpu_stop() and
ipi_cpu_crash_stop(). @die_on_crash is the only difference: the IPI
handlers pass true and PSCI CPU_OFF the CPU on a crash stop so a capture
kernel can reclaim it; the SDEI handler and self-stop pass false and
park. The SDEI park is required, not conservative -- its handler runs
inside an SDEI event that is never completed (completing it resumes the
wedged context), and a CPU_OFF from that unfinished-event context wedges
EL3 on some firmware (left as a follow-up). The dump is unaffected; only
re-onlining the CPU in an SMP capture kernel is lost.

Suggested-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 arch/arm64/include/asm/nmi.h    |  24 +++++++
 arch/arm64/kernel/smp.c         | 109 +++++++++++++++++++++-----------
 drivers/firmware/Kconfig        |   2 +
 drivers/firmware/arm_sdei_nmi.c |  75 ++++++++++++++++++++++
 4 files changed, 172 insertions(+), 38 deletions(-)

diff --git a/arch/arm64/include/asm/nmi.h b/arch/arm64/include/asm/nmi.h
index 9366be419d18..2e8974ff8d63 100644
--- a/arch/arm64/include/asm/nmi.h
+++ b/arch/arm64/include/asm/nmi.h
@@ -4,21 +4,45 @@
 
 #include <linux/cpumask.h>
 
+struct pt_regs;
+
 /*
  * Cross-CPU NMI provider hooks, consulted by the arm64 arch code before
  * its regular-IRQ / pseudo-NMI IPI paths. The SDEI provider in
  * drivers/firmware/arm_sdei_nmi.c implements them when active; a future
  * FEAT_NMI provider could slot in here too. The stubs let callers stay
  * unconditional when ARM_SDEI_NMI is off.
+ *
+ * sdei_nmi_active() lets a caller test for the service before committing
+ * to (and waiting on) the SDEI stop rung; sdei_nmi_stop_cpus() then signals
+ * the targets, which ack by going offline.
  */
 #ifdef CONFIG_ARM_SDEI_NMI
 bool sdei_nmi_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu);
+bool sdei_nmi_active(void);
+void sdei_nmi_stop_cpus(const cpumask_t *mask);
 #else
 static inline bool sdei_nmi_trigger_cpumask_backtrace(const cpumask_t *mask,
 						      int exclude_cpu)
 {
 	return false;
 }
+
+static inline bool sdei_nmi_active(void)
+{
+	return false;
+}
+
+static inline void sdei_nmi_stop_cpus(const cpumask_t *mask) { }
 #endif
 
+/*
+ * The common "stop this CPU" entry every arm64 stop path funnels through:
+ * the regular/pseudo-NMI stop IPI handlers, panic_smp_self_stop(), and the
+ * SDEI cross-CPU NMI handler. @die_on_crash powers the CPU off on the kdump
+ * crash path (IPI handlers) instead of parking it (SDEI / self-stop).
+ * Defined in arch/arm64/kernel/smp.c.
+ */
+void __noreturn arm64_nmi_cpu_stop(struct pt_regs *regs, bool die_on_crash);
+
 #endif /* __ASM_NMI_H */
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index a670434a8cae..e85a4ba18d5c 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -33,6 +33,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/kexec.h>
 #include <linux/kgdb.h>
+#include <linux/kprobes.h>
 #include <linux/kvm_host.h>
 #include <linux/nmi.h>
 
@@ -862,14 +863,58 @@ void arch_irq_work_raise(void)
 }
 #endif
 
-static void __noreturn local_cpu_stop(unsigned int cpu)
+/*
+ * Bring the local CPU to a stop, saving its register state into the vmcore
+ * on the kdump crash path first. The single point every arm64 stop path
+ * funnels through, so the bookkeeping (mask interrupts, mark offline, mask
+ * SDEI, optionally power off) lives in one place:
+ *
+ *   - the regular IPI_CPU_STOP and pseudo-NMI IPI_CPU_STOP_NMI handlers;
+ *   - panic_smp_self_stop(), a CPU parking itself on a parallel panic();
+ *   - the SDEI cross-CPU NMI handler (drivers/firmware/arm_sdei_nmi.c),
+ *     which reaches CPUs the stop IPIs could not.
+ *
+ * @regs is the register state to record in the vmcore on a crash stop; NULL
+ * means "capture the current context". @die_on_crash decides the kdump crash
+ * path: the IPI stop handlers pass true and power the CPU off (PSCI CPU_OFF,
+ * via __cpu_try_die()) so a capture kernel can reclaim it. The SDEI handler
+ * and panic_smp_self_stop() pass false and only park. For SDEI that is
+ * required, not just conservative: it runs inside an SDEI event that is
+ * deliberately never completed (completing it has firmware resume the wedged
+ * context), and a CPU_OFF from that not-yet-completed context wedges EL3 on
+ * some firmware -- a documented follow-up. Parking also matches this path's
+ * own fallback when CPU_OFF is unavailable.
+ */
+void __noreturn arm64_nmi_cpu_stop(struct pt_regs *regs, bool die_on_crash)
 {
+	unsigned int cpu = smp_processor_id();
+	bool crash = IS_ENABLED(CONFIG_KEXEC_CORE) && crash_stop;
+
+	/*
+	 * Use local_daif_mask() instead of local_irq_disable() to make sure
+	 * that pseudo-NMIs are disabled. The "stop" code starts with an IRQ
+	 * and falls back to NMI (which might be pseudo). If the IRQ finally
+	 * goes through right as we're timing out then the NMI could interrupt
+	 * us. It's better to prevent the NMI and let the IRQ finish since the
+	 * pt_regs will be better.
+	 */
+	local_daif_mask();
+
+	if (crash)
+		crash_save_cpu(regs, cpu);
+
+	/* the ack a stop requester (e.g. smp_send_stop()) polls for */
 	set_cpu_online(cpu, false);
 
-	local_daif_mask();
 	sdei_mask_local_cpu();
+
+	if (crash && die_on_crash)
+		__cpu_try_die(cpu);
+
+	/* just in case */
 	cpu_park_loop();
 }
+NOKPROBE_SYMBOL(arm64_nmi_cpu_stop);
 
 /*
  * We need to implement panic_smp_self_stop() for parallel panic() calls, so
@@ -878,36 +923,7 @@ static void __noreturn local_cpu_stop(unsigned int cpu)
  */
 void __noreturn panic_smp_self_stop(void)
 {
-	local_cpu_stop(smp_processor_id());
-}
-
-static void __noreturn ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
-{
-#ifdef CONFIG_KEXEC_CORE
-	/*
-	 * Use local_daif_mask() instead of local_irq_disable() to make sure
-	 * that pseudo-NMIs are disabled. The "crash stop" code starts with
-	 * an IRQ and falls back to NMI (which might be pseudo). If the IRQ
-	 * finally goes through right as we're timing out then the NMI could
-	 * interrupt us. It's better to prevent the NMI and let the IRQ
-	 * finish since the pt_regs will be better.
-	 */
-	local_daif_mask();
-
-	crash_save_cpu(regs, cpu);
-
-	set_cpu_online(cpu, false);
-
-	sdei_mask_local_cpu();
-
-	if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
-		__cpu_try_die(cpu);
-
-	/* just in case */
-	cpu_park_loop();
-#else
-	BUG();
-#endif
+	arm64_nmi_cpu_stop(NULL, false);
 }
 
 static void arm64_send_ipi(const cpumask_t *mask, unsigned int nr)
@@ -984,12 +1000,7 @@ static void do_handle_IPI(int ipinr)
 
 	case IPI_CPU_STOP:
 	case IPI_CPU_STOP_NMI:
-		if (IS_ENABLED(CONFIG_KEXEC_CORE) && crash_stop) {
-			ipi_cpu_crash_stop(cpu, get_irq_regs());
-			unreachable();
-		} else {
-			local_cpu_stop(cpu);
-		}
+		arm64_nmi_cpu_stop(get_irq_regs(), true);
 		break;
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
@@ -1263,6 +1274,28 @@ void smp_send_stop(void)
 			udelay(1);
 	}
 
+	/*
+	 * If CPUs are *still* online, try the SDEI cross-CPU NMI. Firmware
+	 * delivers it regardless of the target's DAIF state, so it reaches
+	 * a CPU spinning with interrupts masked, which neither rung above
+	 * could (without pseudo-NMI there is no NMI rung at all). Allow
+	 * 100ms: a firmware round-trip per CPU, with headroom.
+	 */
+	if (num_other_online_cpus() && sdei_nmi_active()) {
+		/* re-snapshot after the rungs above took CPUs offline */
+		smp_rmb();
+		cpumask_copy(&mask, cpu_online_mask);
+		cpumask_clear_cpu(smp_processor_id(), &mask);
+
+		pr_info("SMP: retry stop with SDEI NMI for CPUs %*pbl\n",
+			cpumask_pr_args(&mask));
+
+		sdei_nmi_stop_cpus(&mask);
+		timeout = USEC_PER_MSEC * 100;
+		while (num_other_online_cpus() && timeout--)
+			udelay(1);
+	}
+
 	if (num_other_online_cpus()) {
 		smp_rmb();
 		cpumask_copy(&mask, cpu_online_mask);
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 6501087ff90d..ab0ee36d46e7 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -46,6 +46,8 @@ config ARM_SDEI_NMI
 	    - arch_trigger_cpumask_backtrace()  (sysrq-l, RCU stalls,
 	      hardlockup_all_cpu_backtrace, soft-lockup secondary dumps,
 	      hung-task auxiliary dumps)
+	    - smp_send_stop() escalation         (reboot/halt and the
+	      panic / kdump crash stop)
 
 	  The driver registers a handler for the SDEI software-signalled
 	  event (event 0) and reaches a target CPU by signalling it with
diff --git a/drivers/firmware/arm_sdei_nmi.c b/drivers/firmware/arm_sdei_nmi.c
index a82776e7b55a..b2a69be6008f 100644
--- a/drivers/firmware/arm_sdei_nmi.c
+++ b/drivers/firmware/arm_sdei_nmi.c
@@ -29,6 +29,11 @@
  *     hardlockup_all_cpu_backtrace, soft-lockup/hung-task secondary
  *     dumps all reach interrupt-masked CPUs.
  *
+ *   - sdei_nmi_stop_cpus() — the last rung of smp_send_stop()'s
+ *     escalation (reboot/halt and the panic/kdump crash stop alike),
+ *     reaching CPUs that ignored the stop IPIs; on the kdump path the
+ *     wedged context is captured into the vmcore before the CPU parks.
+ *
  * Delivery uses the standard SDEI software-signalled event (event 0) and
  * SDEI_EVENT_SIGNAL. We register a handler for event 0, enable it, and
  * poke a target CPU with sdei_event_signal(0, mpidr): firmware makes
@@ -59,8 +64,51 @@ static bool sdei_nmi_available;
 
 #define SDEI_NMI_EVENT			0
 
+/*
+ * Backtrace and stop both ride SDEI event 0. That is not a chosen economy:
+ * event 0 is the only architecturally software-signalled event -- the sole
+ * event SDEI_EVENT_SIGNAL can target at an arbitrary PE. Every other event
+ * number is a firmware/platform interrupt-bound event, not something the
+ * kernel can raise cross-CPU, so a dedicated "stop" event would need
+ * firmware to define and bind it -- exactly the firmware dependency this
+ * driver sets out to avoid.
+ *
+ * Sharing one event means the handler must tell a stop apart from a
+ * backtrace. A stop is terminal and system-wide -- sdei_nmi_stop_cpus() is
+ * only reached from smp_send_stop() (reboot/halt/panic/kdump), which never
+ * returns -- so once a stop is requested, every later event-0 fire is a
+ * stop too. A single write-once flag therefore carries as much as a
+ * per-CPU mask would: sdei_nmi_stop_cpus() sets it before signalling, and
+ * the handler reads a set flag as "stop this CPU" and a clear flag as
+ * "backtrace" (handled by nmi_cpu_backtrace(), which self-gates on the
+ * framework's backtrace mask). A backtrace fire that races in after a stop
+ * has begun just stops that CPU instead -- harmless, it is going down.
+ */
+static bool sdei_nmi_stopping;
+
 static int sdei_nmi_handler(u32 event, struct pt_regs *regs, void *arg)
 {
+	if (READ_ONCE(sdei_nmi_stopping)) {
+		/*
+		 * Never returns, and deliberately never completes the SDEI
+		 * event: SDEI_EVENT_COMPLETE has firmware restore the
+		 * interrupted context, which would land the CPU back in
+		 * the wedged loop (or in do_idle, which BUGs at
+		 * cpuhp_report_idle_dead once it sees itself offline).
+		 * Returning a modified pt_regs doesn't help --
+		 * arch/arm64/kernel/sdei.c::do_sdei_event only honours a PC
+		 * override via its IRQ-state heuristic and otherwise hands
+		 * EL3 its own saved-context slot back.
+		 *
+		 * Trade-off: EL3 retains ~one saved-context slot per parked
+		 * CPU until the next hardware reset (~hundreds of bytes per
+		 * CPU). Recoverability is unchanged versus an IPI-stopped
+		 * CPU: neither comes back without a reset.
+		 */
+		arm64_nmi_cpu_stop(regs, false);
+		/* unreachable */
+	}
+
 	/*
 	 * nmi_cpu_backtrace() no-ops unless this CPU's bit is set in the
 	 * global backtrace mask (driven by nmi_trigger_cpumask_backtrace()),
@@ -115,6 +163,33 @@ bool sdei_nmi_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu)
 	return true;
 }
 
+bool sdei_nmi_active(void)
+{
+	return sdei_nmi_available;
+}
+
+/*
+ * Last rung of the stop escalation in smp_send_stop() (see
+ * arch/arm64/kernel/smp.c). The caller runs the regular stop IPI (and
+ * the pseudo-NMI stop IPI, where available) first; @mask holds whatever
+ * stayed online through those -- typically CPUs wedged with interrupts
+ * masked, unreachable by an IPI. Mark the stop in progress and signal
+ * event 0 at each target; a target acks by marking itself offline, which
+ * the caller polls for. The caller has already confirmed sdei_nmi_active().
+ */
+void sdei_nmi_stop_cpus(const cpumask_t *mask)
+{
+	unsigned int cpu;
+
+	WRITE_ONCE(sdei_nmi_stopping, true);
+
+	/* Publish the flag before the SMCs make targets read it */
+	smp_wmb();
+
+	for_each_cpu(cpu, mask)
+		sdei_nmi_fire(cpu);
+}
+
 /*
  * device_initcall (after arch_initcall(sdei_init), so the SDEI subsystem
  * is up): probe the firmware, register the event, and turn on the
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

