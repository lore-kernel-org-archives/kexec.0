Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A71C43458
	for <kexec@archiver.kernel.org>; Mon, 29 Jun 2026 15:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=npH4fN772K9PxkqSVNc4fUDZx7z0XTO2Pc24IeSXCqM=; b=Ze4Kc8YFMuRo3NTjzFjnL0ZYVN
	E/Vi72kq457xpB94QiR5ITSyVLTnYauB4chdPMtU/OHqsb2nB7ekG68ZuR8dXYl5psVrjeO23uhSJ
	MTtidw+ORggU4Wj4X4YgCag48pdP6csi0+uOkMV/sQ0B8YI1YkgAqJP+gJildA0eXYB6VPUKZodEn
	c2Pwq/K34iL2SFwRZKuQpxemDdCBUjXAqlI1MOGW1frEOGS3JRkEHjrtE0bFnt68BMtYDUUx4T7lY
	Z9To8GlRqZLgqOagbSMAgPNhjcwwIDs108/2Hk+8sN6Id0JGRV0ivGTWajO/bWC5L9YMrGqDRj80u
	WYiBAlRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weDa1-0000000F0xm-2P0s;
	Mon, 29 Jun 2026 15:07:25 +0000
Received: from fhigh-a8-smtp.messagingengine.com ([103.168.172.159])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weDZy-0000000F0wr-39n1;
	Mon, 29 Jun 2026 15:07:24 +0000
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 63A1014000E2;
	Mon, 29 Jun 2026 11:07:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 29 Jun 2026 11:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1782745641; x=1782832041; bh=npH4fN772K
	9PxkqSVNc4fUDZx7z0XTO2Pc24IeSXCqM=; b=1u47HggR31fJlLNFyVcxKL8TrV
	F7DAWSgyAgHDdQhweh7D1wbD3tzMJDs4co6kU56/iuw6yzaxPLHsMtkU4ViJvC8l
	gtWMfznY2fXzbSdd0ePZQ5pclTJElLYrJJMclYlG70CgAofbPfyGeaOKJh0abCOE
	mZHBGe9pasvRgoRqgEdSOy1lpol1LxYflGbGs4VAlIJ4vQymFofJolQG3k0mHkrg
	eToKm0EFb0Imm4Xadi7fdtdKJIYOolvD6/Nz1C1RqoqmO93fb2JQuKMqyA+ywLFp
	qfHk2I10qvRYd2VDx1KhFKxiri6887bMNJzXD52aCYWwcZhyIpCJEL1B7JYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782745641; x=1782832041; bh=npH4fN772K9PxkqSVNc4fUDZx7z0XTO2Pc2
	4IeSXCqM=; b=TAlCqEL3JphF0vA5mBSdLBHSSshz9Uk/gotF7veqW1vAbJ5Mkwn
	aq0tGKFbK+TFqVJv01eXpilL0UdXPdJtIjmNeRlMIrTjfq0ddDwdpRvEBMhkki+g
	N0ezk2dtUhRQcQw2Bbb4XRPtbJsYOYsiWTTGiw46rUcuuUo0VxtfYLbINPOzFOLq
	1xEYELVHcloZD3RsZ0ncosqa/CqbtOFx9es+3fa0KqQ278n0DhwHYWM5DpzNG4dK
	ZM5Xbh6iStU3DzLhfzWoIWOkPP+lNBH3GVGR5stBgUYllthO0T6fXicYXOT5Epz5
	pt4o4IeD4BqtpVW5mbVv2QtBN8SxBL3LOPg==
X-ME-Sender: <xms:KIpCaqa3rntQMgy_1rZ-wx_riwBZmiV0qsflNiPTDkkfvwKWQJzx6g>
    <xme:KIpCakfsxqPU6ULhUxCX6I_hQsJ3rxgxYVcdBGSoDG94t9N2Iee0_JEOP1hGNpJZX
    RZvXX_NTjKtIEji2QHpO0XNPu-fdbw3D-5kHAEDik4kdrSjBKMnDSk>
X-ME-Received: <xmr:KIpCasqFOOG0zuwNtvgGPeKuRmf5sHhBdi19_VOdcNisI0OeWpy6mO-cyMUtiA>
X-ME-Proxy-Cause: dmFkZTF4wzusa3GIwjXzrfbgaK8X9WtEYp6QCmDcutiV9UqOi9qDXpm1K68W5M3FmJqLcG
    82F8SaEUZzslfzqDQPHzkb76Vw7Hfkgy5BJocjQSwG3mHq1jo6M1SORrZBHT87lyWhxeWB
    Ro48+68at2VjjaUIDkCcqVxDHVQNXdUsYD4wwU1WdBu+2I+f6YNffOi3JtjieVhoA1sjvB
    54cMzeOI66zm2glQquEljf5/uyzPX1oVnTBN/4BtDMvKquKdhXm91u55EEdI0GsTT9+dif
    xFnYXcENSYO/HBx9aZt++OgKINMb/Dn6DoxLZD2VjqxEtohKxH+o2DP80wChY/fDTEt+Ml
    qp3sgN8FWx+lI7LG7UXTVd33q4I55SP1nNbr4e+Q1KNqRFpvPcxfloOFMU9EUAIOiND+OB
    4mm4Pt8mjI26h+1yqwCqLV6P9pupoSkIEB2W7UyKoHs3kL9DpW6oJoXlZK5hZRr2xVdLiV
    CSIf0yFRTA8YczYpTT+0ZOJs99ZytgmiOBV8EJGjEAB+PvRtTD/bVMNUJzJrRWmESm2+QQ
    mkz90zsNPivMdKxYXcU/g9raPLzkJS8RX2Rj/Ff3oQ+hyy40at/brUCWyi3THCRcNFthtF
    Fyu04PZO3keGbtRvb9Tf8GUVqmWnQop/n56T3u0Ln8YwEj7AIzWJwoqn38PQ
X-ME-Proxy: <xmx:KIpCajAni_k-fZi8WE1-NT7COmFiNaLmEbeSJ569Yj2DfPcbU3Fc5Q>
    <xmx:KIpCaiXdboSFQKcfDnH6DWvNTJN1JEe4ezvsWDhad-Yrdm295da1FA>
    <xmx:KIpCav4X0Y-3RP5Rd5OdiEKS5DWNX9uytR6_hvukxdjOHpcwUGxldw>
    <xmx:KIpCarBv7BTMm8w4eA9WBxTreD6mHq1wj8ySUeTnygtj0mV2JyKHbw>
    <xmx:KYpCakHWNd0-ebVjIW3M7526L2hNxVLlRj9kO46Bza5VQSNR8v3hJNfW>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 11:07:19 -0400 (EDT)
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
Subject: [PATCH v5 0/4] arm64: cross-CPU NMI via SDEI
Date: Mon, 29 Jun 2026 16:07:14 +0100
Message-ID: <cover.1782744912.git.kas@kernel.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260629_080722_996093_69F76C20 
X-CRM114-Status: GOOD (  26.53  )
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

  - GICv3 pseudo-NMI (interrupt priority masking). The cost lands on the
    interrupt mask/unmask hot path: local_irq_enable() becomes an
    ICC_PMR_EL1 write, and exception entry/exit save and restore the PMR,
    paid on every CPU whether or not an NMI is ever delivered.

    Measured on Grace (Neoverse V2; ICC_CTLR_EL1.PMHE=0, so the PMR-sync
    DSB is already patched to a NOP), pseudo_nmi=0 vs pseudo_nmi=1:

        gettid() loop:              178 -> 253 ns/call  (+42%, ~74 ns)
        will-it-scale sched_yield:  0.705x throughput, flat from 1 to 72 cores
        will-it-scale page_fault1:  within ~5%

    The ~74 ns is a fixed per-syscall entry/exit tax -- it reproduces at
    +73.5 ns on Neoverse N2 -- so the hit tracks syscall/exception density
    and is unacceptable on syscall-bound fleet workloads, which therefore
    run with pseudo-NMI disabled.

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
    series -- works, and it matches the shared stop path's own park
    fallback when CPU_OFF is unavailable. The consequence is that an SMP
    crash-capture kernel cannot re-online such a CPU (it stays "already
    on"); the capture kernel boots and runs on the remaining CPUs.
    Powering the stopped CPU off so a capture kernel can reclaim it would
    need CPU_OFF from the SDEI stop context, which does not work in
    practice (see the v4 discussion); left as a follow-up and does not
    affect the dump's contents.

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
    captures the wedged CPU's registers in the vmcore;
  - with SDEI absent (plain QEMU 'virt', no firmware support) the driver
    stays inert: no event registration and no boot-time warning.

Changes since v4
================

  - Strengthen the publish barrier from smp_wmb() to dsb(ishst) on the
    stop path, and add the missing one on the backtrace path; the SMC is
    not a memory store, so ordering alone is not enough (Catalin Marinas).
  - Drop the redundant ARM64 Kconfig dependency, already implied by
    ARM_SDE_INTERFACE (Julian Braha).
  - Reviewed-by from Douglas Anderson now on all four patches.
  - Replaced the stale perf numbers in this cover with fresh, reproducible
    measurements (Catalin Marinas, Marc Zyngier).

Changes since v3
================

  - New sdei_is_present() patch; the NMI initcall now skips registration
    (and its boot warning) on non-SDEI systems (Puranjay Mohan).
  - Fixed a NULL deref on a parallel-panic crash stop and the
    CONFIG_KEXEC_CORE=n build (Puranjay Mohan).
  - kernel-doc + barrier comments on the stop path; reordered the two
    arm_sdei core patches (Doug Anderson).

Changes since v2
================

  - Unified the CPU-stop paths into one arm64_nmi_cpu_stop(regs,
    die_on_crash), dropping local_cpu_stop()/ipi_cpu_crash_stop().
  - SDEI rung tests sdei_nmi_active() first; sdei_nmi_stop_cpus() is void.
  - Replaced the per-CPU stop cpumask with a write-once flag.
  - Commented the SDEI-park / no-CPU_OFF rationale.

Changes since v1
================

  - Dropped the SDEI hard-lockup-detector patch; use the buddy detector.
  - Reworked crash-stop into a third rung of smp_send_stop().
  - Renamed the driver to arm_sdei_nmi.c; widened the MAINTAINERS glob.

v4: https://lore.kernel.org/all/cover.1781709543.git.kas@kernel.org
v3: https://lore.kernel.org/all/cover.1781490440.git.kas@kernel.org
v2: https://lore.kernel.org/all/cover.1781082212.git.kas@kernel.org
v1: https://lore.kernel.org/all/cover.1780496779.git.kas@kernel.org

Also available at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git sdei-nmi/v5

Kiryl Shutsemau (Meta) (4):
  firmware: arm_sdei: add sdei_is_present()
  firmware: arm_sdei: add SDEI_EVENT_SIGNAL support
  drivers/firmware: add SDEI cross-CPU NMI service for arm64
  arm64: escalate smp_send_stop() to an SDEI NMI as a last resort

 MAINTAINERS                     |   2 +-
 arch/arm64/include/asm/nmi.h    |  48 +++++++
 arch/arm64/kernel/smp.c         | 124 +++++++++++-----
 drivers/firmware/Kconfig        |  21 +++
 drivers/firmware/Makefile       |   1 +
 drivers/firmware/arm_sdei.c     |  22 +++
 drivers/firmware/arm_sdei_nmi.c | 246 ++++++++++++++++++++++++++++++++
 include/linux/arm_sdei.h        |   9 ++
 include/uapi/linux/arm_sdei.h   |   1 +
 9 files changed, 435 insertions(+), 39 deletions(-)
 create mode 100644 arch/arm64/include/asm/nmi.h
 create mode 100644 drivers/firmware/arm_sdei_nmi.c


base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
--
2.54.0

