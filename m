Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3FA7CD8CAA
	for <kexec@archiver.kernel.org>; Tue,  9 Jun 2026 13:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jLo3KRveWhz8ftC6WRl4v/BswTZNARGwK5Gd1KwJ92Q=; b=UiHF5RpPmFYN4mxzyy6PVfFTfE
	d2cXjTF8Cdaq5YeX0ORXLD3dpretgrfq3GNM56oRV/5rTD5r3aig75XNsQntAb/i5SVZki6/v9hfR
	gvlhzJos6Ibxu1Ck4D26HUgMkPntHD0ryXW+blTXJCy2pM4s3WVmvqBbKPjhddBB2Pnv8MBbk1Oaz
	WlTne1TUzcrFtF9No2vqdVnWUwTTwvNbvMrA/UTAKG8uxzHnha8HlDfd54SRETPiOY0JMdGZcxTG5
	SrT7hTp8MDNiq/2VK3UjXOJvbuAZu9FoyNIgXIi0oc+9X5e5K+61c5ZgBPEis5QK6Iu7csqwaSz8p
	UZpaLnJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWwyb-00000005ioG-1BUt;
	Tue, 09 Jun 2026 13:58:45 +0000
Received: from fout-b3-smtp.messagingengine.com ([202.12.124.146])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWwyW-00000005inb-3dg9;
	Tue, 09 Jun 2026 13:58:43 +0000
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id CC5F21D00046;
	Tue,  9 Jun 2026 09:58:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 09 Jun 2026 09:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1781013518; x=
	1781099918; bh=jLo3KRveWhz8ftC6WRl4v/BswTZNARGwK5Gd1KwJ92Q=; b=Z
	VskEavTvkNhaIIb8EB6hZblqHgdlIyHcbQXv9bDZPEStGCeUnI3RuNYtlVKaaae0
	ENfY+1MPDlT5xeqxXoGQJl6asF7d/ttooK8SNxPjYehaPcZqZKp4q7k+UCFkJLcr
	lmgRWaEMZP01J1m878lyoWxFeZrOHyIuwDlUo8FkFd2RbY5LnZZw+HuqmnJ3Ey+7
	m9DYzkmIEHJGSAUKRzAW/JTD+vPw/ah8kWf9R5ZyQQGAvBMqw7U2MxFbAe+Wgake
	z2mktqarlC++8Nl5qwJT8BFs4RWw784E7IESZrpDK+5BZGUOOdob1neoqr9zDlRc
	m34s05gjvjVbj7MrTMAJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1781013518; x=1781099918; bh=j
	Lo3KRveWhz8ftC6WRl4v/BswTZNARGwK5Gd1KwJ92Q=; b=lGvU5zEeYauwEEP/P
	PcmsosAg12j5xvYLO4xLHRRC7DDKjDkI9WGBOzxNFlHiv3SN1hshxO5SYWvozmzn
	q35ixfg15ON9joqwVzLR/ePCAN6bGFpaY9fEEye0L17DQzCPTqamkP3Yn2T+p9yE
	mRd/Hc5QLtnMj+LzjYifyBV800VGdh7LnxbXFUTU4zFT9BlXF1IlfLK0j6ulIZ31
	6L+1G69NLaFweLA0kc3GnIbIgsLgPibaKdFp0ktnTifBNvxoC7OAvumhC34RsIog
	LR/qbqd6i4QA8tZI9PU9h1G9oV4oFJ0/4OyHEZ3toABqmxXCDGhTBEpAWe8BfrjM
	WrO/Q==
X-ME-Sender: <xms:Dhwoas6aTV4EvongLThFyCAo1jUStGIq6M6XVRwYPSiYU3gmnKmo7Q>
    <xme:DhwoauSxFgR0sGCQSuYYldxYXyqSmebWQllAK16Y_tHPtfQv8Vhm1pIlR4bIaGv22
    uhSmoJAmwRurWGNzfgS_yZaBA7ZdQj9NJYjTwx0O87vMl_32Oz4JWgL>
X-ME-Received: <xmr:DhwoasmjZlZ8qeMCNstSRBIDFn7wBhcRTAkyAPwinbsok854ZecrV8v-Tg6shQ>
X-ME-Proxy-Cause: dmFkZTFeFvcuttoLcNC9ZNbJtepxTJGkVgYI+Awi+aOXEH+ufNgVpUrVHExLAe7doe82mp
    kac7uOHqyO/9+QUPG5IUG/2puucCtcXDtT+r7+wBv0irj2rLyRFBJb+hCGpj4O77Opyv7o
    3sp1PyNzeZHjVdHuxc/K4uMKSDG5xJk8ypgrVLB49hLtcYrc091cxHcImvRPsDtB4Zqprt
    mLa7wIFR2UJcsaM7OerfOmdQ0+nhzdj8e/AD4V/e5T/i0IVklUolE1kLowmV8AIYtXqSYy
    zotD7BN0RWY0Pzxn0Ic3U8mO+D88Gwi7k2WiL6c6u7b9o+GDPLIBVjMbevunoqlNSBoEJ0
    LwwopAtRkJoZs7NAiKuHXMIHetASBBobAdFcfJDq65g7RfpZhgLiDAgFHSiMVXgx3n0pMj
    NsT/6Domi+KCfNYuLh2HbGmzJWppXnJ5N+iJeSc7QWVu68LR3BE8S2rqihEPKUdUf1lZ0M
    OZhA0r+9uZx7/oT94Lay2WDRgQz+JhdgWLD2lX4JTP851erqJHn6GlIPoJbPoyrOnFJLQm
    +tHi89A+BCr44FwqMw5AK9cQFGzVUHboiQSm1kUVFTh3Ond2naT0LO5tJi6SQeuBGGD53x
    xropB6tx4Zo5HtkBsQVEZx4rVv2J2R/3KB1cWB0sXAEgyXlsRkjjU0wH+tdw
X-ME-Proxy: <xmx:DhwoatID-OnrOaCPJXdJIMOxrC58cOBkas6NSAhKPS9yVI6-n5YOsA>
    <xmx:DhwoavRQz66oefX0clSqkkVfoNsVxDaeliG9FQqorkem9c6Fk4vilg>
    <xmx:DhwoarRXrJQVaK0puouXNUOMbcAIKX9GjmawfTqApgC0-e_qnoNbZw>
    <xmx:DhwoahytQlyyTTHAA5uTgPz6Hw5JDc4BYngoRZMTMUT-rp2q9tM3Gg>
    <xmx:DhwoalqpxbGhQac5OdCib0HpdV62yg3UMPVS4kwai6FfpZtH_lQ1B9gz>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 09:58:37 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	Petr Mladek <pmladek@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Usama Arif <usama.arif@linux.dev>,
	Breno Leitao <leitao@debian.org>,
	Julien Thierry <julien.thierry.kdev@gmail.com>,
	Lecopzer Chen <lecopzer@gmail.com>,
	Sumit Garg <sumit.garg@kernel.org>,
	kernel-team@meta.com,
	kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: [PATCH v2 0/3] arm64: cross-CPU NMI via SDEI
Date: Tue,  9 Jun 2026 14:58:32 +0100
Message-ID: <cover.1781013134.git.kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1780496779.git.kas@kernel.org>
References: <cover.1780496779.git.kas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260609_065842_218992_3A5A571A 
X-CRM114-Status: GOOD (  26.66  )
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

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

A class of debug/observability features needs to interrupt a CPU that has
its interrupts locally masked: the all-CPU backtrace behind sysrq-l /
RCU-stall / hung-task / hard-lockup dumps, and crash_smp_send_stop()
capturing a stuck CPU's state into the vmcore. On arm64 these need a
mechanism that reaches a CPU spinning with DAIF masked, which a normal IPI
cannot.

arm64 has two such mechanisms today:

  - GICv3 pseudo-NMI (interrupt priority masking). Its cost is on the
    interrupt mask/unmask hot path: local_irq_enable() becomes an
    ICC_PMR_EL1 write plus a synchronising barrier, and exception
    entry/exit save and restore the PMR, paid on every CPU whether or not
    an NMI is ever delivered. In our measurements, enabling pseudo-NMI
    costs up to ~5% on real workloads, and ~66% on a syscall-in-a-loop
    microbenchmark. A fleet-wide ~5% regression is not acceptable, so
    these systems run with pseudo-NMI disabled.

  - FEAT_NMI (Armv8.8) -- the architectural fix, but absent from deployed
    silicon and from most of the fleet for years to come.

For deployments that do not run pseudo-NMI, the backtrace and crash paths
are degraded: a plain IPI can't reach the masked CPU, so the backtrace of
the CPU you care about comes back empty and the kdump is missing the
culprit's registers. The hard-lockup detector on these systems is the
software buddy detector (HARDLOCKUP_DETECTOR_BUDDY): it detects a stall
from a neighbour CPU, but it cannot itself interrupt the wedged CPU, so
its report has no stack for the culprit and (with hardlockup_panic) the
panic runs on the bystander.

This series adds a third delivery backend that costs nothing on the hot
path: SDEI. Firmware delivers an SDEI event into a CPU regardless of its
DAIF state, so interrupt masking stays the cheap PSTATE.DAIF operation and
the firmware round-trip is paid only at the rare moment a CPU must be
interrupted.

It does not add a hard-lockup detector. Detection stays with the buddy
detector (CONFIG_HARDLOCKUP_DETECTOR_PREFER_BUDDY); this series gives the
backtrace and crash-stop paths -- including the buddy detector's
backtrace of the stalled CPU -- a way to actually reach a masked CPU.

Mechanism
=========

It uses the standard SDEI software-signalled event (event 0) and the
SDEI_EVENT_SIGNAL call (DEN0054) -- a spec-defined cross-PE signal, not a
vendor extension. The driver registers a handler for event 0 and pokes a
target CPU with sdei_event_signal(0, target_mpidr); firmware makes event 0
pending on that PE and dispatches the handler NMI-like.

No firmware change is required beyond SDEI being enabled, which
firmware-first RAS (APEI/GHES) deployments already have; the only
SDEI-core addition is a thin sdei_event_signal() wrapper over the standard
call.

Prior SDEI watchdog work
========================

Out-of-tree SDEI hard-lockup watchdogs exist (e.g. in the openEuler and
Anolis kernels). They bind the secure physical timer as an SDEI event, so
firmware delivers a periodic self-CPU tick that drives a detector. That
requires a new SDEI interrupt-binding API, pushes the watchdog period into
firmware, and adds secure-timer EOI handling on the kexec path. This
series instead uses only the standard software-signalled event 0, keeps
all timing in the kernel (the buddy detector), and the same delivery
primitive serves the backtrace and crash-stop users, not just lockup
reporting.

Not included / follow-ups
=========================

  - No SDEI hard-lockup-detector backend. v1 had one; it is dropped here.
    The buddy detector plus this series' backtrace already cover the
    no-pseudo-NMI case, and a dedicated SDEI backend duplicated the
    perf-NMI detector it had to compile-exclude. Run PREFER_BUDDY.

  - A CPU stopped by the SDEI rung is parked, not powered off via PSCI
    CPU_OFF. Reaching and dumping the wedged CPU -- the point of the
    series -- works, and this matches ipi_cpu_crash_stop()'s own park
    fallback. The consequence is that an SMP crash-capture kernel cannot
    re-online such a CPU (it stays "already on"); the capture kernel boots
    and runs on the remaining CPUs. Powering the stopped CPU off so a
    capture kernel can reclaim it requires completing the SDEI event and
    then CPU_OFF, which hit a firmware-specific issue still under
    investigation; it is left as a follow-up and does not affect the
    dump's contents.

Testing
=======

Developed on QEMU 'virt' (Trusted Firmware-A with SDEI enabled) and
validated on NVIDIA Grace (Neoverse V2) hardware, under
irqchip.gicv3_pseudo_nmi=0 with HARDLOCKUP_DETECTOR_PREFER_BUDDY=y:

  - sysrq-l backtrace of an interrupt-masked CPU returns its real stack,
    pstate showing DAIF set -- proof SDEI delivered into the masked CPU;
  - buddy detector catches a hard lockup (LKDTM) and the wedged CPU's
    stack is fetched via the SDEI backtrace;
  - reboot/halt and the panic/kdump crash stop reach a wedged CPU via the
    SDEI rung ("SMP: retry stop with SDEI NMI for CPUs N"), and the kdump
    captures the wedged CPU's registers in the vmcore.

Changes since v1
================

  - Dropped the SDEI hard-lockup-detector patch (v1 3/4); use the buddy
    detector instead (Doug Anderson).
  - Reworked the crash-stop patch (v1 4/4) into a third rung of
    smp_send_stop()'s escalation, shared with the IPI stop path and
    covering reboot/halt as well as crash; no on-stack cpumask
    (Doug Anderson).
  - 2/3: split the merged comment in arch_trigger_cpumask_backtrace()
    (Doug Anderson).
  - Renamed the driver to drivers/firmware/arm_sdei_nmi.c, to sit beside
    the SDEI core it builds on (drivers/firmware/arm_sdei.c), and widened
    that entry's MAINTAINERS glob (arm_sdei.c -> arm_sdei*) to cover it.
  - Picked up Reviewed-by from Doug Anderson on 1/3 and 2/3 (the changes
    above are mechanical / comment-only on those two).

v1: https://lore.kernel.org/all/cover.1780496779.git.kas@kernel.org

Also available at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git sdei-nmi/v2

Kiryl Shutsemau (Meta) (3):
  firmware: arm_sdei: add SDEI_EVENT_SIGNAL support
  drivers/firmware: add SDEI cross-CPU NMI service for arm64
  arm64: escalate smp_send_stop() to an SDEI NMI as a last resort

 MAINTAINERS                     |   2 +-
 arch/arm64/include/asm/nmi.h    |  38 ++++++
 arch/arm64/kernel/smp.c         |  64 ++++++++++
 drivers/firmware/Kconfig        |  21 +++
 drivers/firmware/Makefile       |   1 +
 drivers/firmware/arm_sdei.c     |  12 ++
 drivers/firmware/arm_sdei_nmi.c | 220 ++++++++++++++++++++++++++++++++
 include/linux/arm_sdei.h        |   6 +
 include/uapi/linux/arm_sdei.h   |   1 +
 9 files changed, 364 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/nmi.h
 create mode 100644 drivers/firmware/arm_sdei_nmi.c


base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
--
2.54.0


