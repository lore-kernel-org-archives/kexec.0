Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3716CD98C5
	for <kexec@archiver.kernel.org>; Mon, 15 Jun 2026 02:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=46tVIFj+zMOYVpb0tX7UsQ7a/BRx8tjvxB8nxgi8+Rs=; b=bu//MEC0RCSRvpRuQlw4YJMETx
	rdj2N0edDsAgYNx6ib5y64Dr0PfeHQGDjVhUs6OxqxOSo4dKI9JVRpY2daIazDZyhXOEAh+E1yq8K
	Xm5KUEqblAjfRqCIv0i6Ow2aCgdsS4dKok5bB7sEjuqs4SCNBcZuyyRKfg9lW1LtRLkF7DWe7PTo8
	9IKqBgRqPtYDsxMtCYBPfkc9UX71dINZphGX6C+2j1mvoim+P30ELP7fPM9QEp/4npYD67Rs1pquE
	DJa+3OgbVVj1f3WmabkYNIqClph+/9sD5NCNqp5bP/f4Vau3kDMVl9mNhwhvOjsxsv9eo4rjPQ1vJ
	jqCkwz3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYxB0-0000000DTRm-2NS8;
	Mon, 15 Jun 2026 02:35:50 +0000
Received: from fout-a5-smtp.messagingengine.com ([103.168.172.148])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYxAw-0000000DTR8-1jds;
	Mon, 15 Jun 2026 02:35:48 +0000
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 29430EC0090;
	Sun, 14 Jun 2026 22:35:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 14 Jun 2026 22:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1781490943; x=1781577343; bh=46tVIFj+zM
	OYVpb0tX7UsQ7a/BRx8tjvxB8nxgi8+Rs=; b=SAGsYKxUaxeg0B9gGepM5TYUoK
	7fZW7P741HC9SU4miCDucZwjhXz/1DK9bZTLnW894yrZqPvd3lV0/G1oTzsEOyjB
	JYWPQM3Jn6RwIjjLl9MC5f99JC9HE2uUsDB7p09v5rvfdfyZc8IR0ZA0oKIBjHI5
	8N6Bftpoz/b3q4PmTr4mV9VBvJVlRIXDZ1jbpU5+vGbPzubM7hlWoGcVN1+i0jPd
	9VC5daL+dB9smcgKe5OgPmvR5GIXtcHXsfy72xERQn2+dVxBgqOran7hO5BmIbNH
	8kb6E127UwTCvHsxeUjYt+JRNdnH4T1TkQaQ+eTOKRh7PZKrPV2Ndrqqf6YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781490943; x=1781577343; bh=46tVIFj+zMOYVpb0tX7UsQ7a/BRx8tjvxB8
	nxgi8+Rs=; b=JsWx3I4uVEuvF0zUyR78d3wELk42j+o5ndKUfIP43CfoZ6muu8/
	1/X2dVnDAQn03cO5eZxfIWbujmpilIu0yDtansHpYjsBNwKjMMUcXnmteU+Wb8Us
	80JCxDhO7v77K7AxdUXw0L/vE71rkB3LteZmR7ohxOllURZzxSTPcknAQShOu/Fm
	cxFtKurpqSrlQgHm2wYgygWXkxo1DCq80XodQa8gS+yiOV7Yw2V+5K/QU4Eekes8
	mQJoREYvKYoTJHiaSaI/d59B5EiDjkpYb0yPZD0Af0R20RcCKi1wwJA4XCziOAQZ
	nfb/e250O96opzImu+QjErW4Ae/VYJkdB/g==
X-ME-Sender: <xms:_mQvahWFez9DxkgyHLVz2wWLt7VKgQyZRRavr1RkMwQmJYxPOEiacg>
    <xme:_mQvaooe4KY7lWvp-3Hygnq1LRR8b-J2sX-599QIcfkT7p_rnMAfHs8vV_i_NAFsH
    pZjJJe6JQXqNkifYYzgGaLn55bQoRddeECPszls0glej8Uvf7CoMg>
X-ME-Received: <xmr:_mQvalEe30XeQQvjhMBC_B1YHhReJzi_HrPy35PYKCHCNWrveJRtLUIyKxDKig>
X-ME-Proxy-Cause: dmFkZTFFM7f0zQTJppp0QCprvC3+dzcNPH07PDZ1BL1EgYZDEi1AeIbpAyfv+bTt/gYbk4
    N/6GpS93hcHdPh+dH9WvlXAQjxn2pxwrYRtnD6QmpPuChzQ6p5iMGC/B5fwf4J3yaw9W/Y
    UgLiDxiEpt+6DGExfSFAA2eIabHXVpBqlU/AHQqdMOQQgVAEdn6ex/TBGR38GB8pk9GTbQ
    s+TX4/osrVi4q1h/0RGGEVQwDJRszyv2vSiiorjfNc7Nco4ywIXMoaD96gSMPPPvD7KUxf
    Fqg03fMj3oQRwl4gAIrIiujM+SDM4NqfjXxevnl1SZ1DldG8+TR0v4+El9pwl4O4I/y4GA
    AXZ/rZ+D6z2JthuBAMBUSkqKLFoiUP4F/Jz2x8266RLIyfE/4UJ21YavQrzfcUgPjyXqQW
    A3Gdj1hi44wImEI65nf8gJjxt+P8N2uPL9aQmXYYIOXEic35fTKJJ+gtqPsZDr9eP4r2v/
    PUt2UH5lONkCmJ9Rr5F3lzK3UYh1gB2Cfb1Uy2ZvMDxIdX2BtFtq8EYbmuqqtykj4XNMga
    YSwKSLH1I9NlFx0fVrUD/QJjCFW+uE5q3EF4AqrpFfm5tJJKrnP6Qux0B8B6+EfS+cobZI
    dY7JWX2UDhgRsaHxJfXhBz/g7lhi6GjOtzxVKeKOwQvQ6ZnX9sRrvEgHg+vg
X-ME-Proxy: <xmx:_mQvaqti9y-nweqWYKbLGFUPH5MyuG9wexK4Rx-v57sP5Q7szaIuoA>
    <xmx:_mQvaoSyWG11fHQLDD6lxeX-CgLSdIATsyKOqGENNjZ5NUqaFPprrA>
    <xmx:_mQvanFLqOZ_CYXoW3FD_0hqcOsVV3c26nVQzkfTCjUtnAKXTdV1OA>
    <xmx:_mQvaqepyo5khwAhHXnXEIfMdUxIVNpRUqg7kflpsLRggihxvPn2Vg>
    <xmx:_2QvanyyLuNlQywrN7YY6ZdVIHzvaS9cXHqutjKFe1KzFnCwlQSdTwb8>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Jun 2026 22:35:40 -0400 (EDT)
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
Subject: [PATCH v3 0/3] arm64: cross-CPU NMI via SDEI
Date: Mon, 15 Jun 2026 03:35:31 +0100
Message-ID: <cover.1781490440.git.kas@kernel.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260614_193546_637397_63CE3C5B 
X-CRM114-Status: GOOD (  25.18  )
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
    series -- works, and it matches the shared stop path's own park
    fallback when CPU_OFF is unavailable. The consequence is that an SMP
    crash-capture kernel cannot re-online such a CPU (it stays "already
    on"); the capture kernel boots and runs on the remaining CPUs.
    Powering the stopped CPU off so a capture kernel can reclaim it
    requires completing the SDEI event and then CPU_OFF, which hit a
    firmware-specific issue still under investigation; it is left as a
    follow-up and does not affect the dump's contents.

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

Changes since v2 (Doug Anderson's review)
=========================================

  - Unified the CPU-stop paths into one arm64_nmi_cpu_stop(regs,
    die_on_crash), dropping local_cpu_stop()/ipi_cpu_crash_stop().
  - SDEI rung tests sdei_nmi_active() first; sdei_nmi_stop_cpus() is void.
  - Replaced the per-CPU stop cpumask with a write-once flag.
  - Commented the SDEI-park / no-CPU_OFF rationale.
  - Rebased onto v7.1.

Changes since v1
================

  - Dropped the SDEI hard-lockup-detector patch; use the buddy detector.
  - Reworked crash-stop into a third rung of smp_send_stop().
  - Renamed the driver to arm_sdei_nmi.c; widened the MAINTAINERS glob.
  - Reviewed-by from Doug Anderson on 1/3 and 2/3.

v2: https://lore.kernel.org/all/cover.1781082212.git.kas@kernel.org
v1: https://lore.kernel.org/all/cover.1780496779.git.kas@kernel.org

Also available at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git sdei-nmi/v3

Kiryl Shutsemau (Meta) (3):
  firmware: arm_sdei: add SDEI_EVENT_SIGNAL support
  drivers/firmware: add SDEI cross-CPU NMI service for arm64
  arm64: escalate smp_send_stop() to an SDEI NMI as a last resort

 MAINTAINERS                     |   2 +-
 arch/arm64/include/asm/nmi.h    |  48 +++++++
 arch/arm64/kernel/smp.c         | 120 +++++++++++------
 drivers/firmware/Kconfig        |  21 +++
 drivers/firmware/Makefile       |   1 +
 drivers/firmware/arm_sdei.c     |  12 ++
 drivers/firmware/arm_sdei_nmi.c | 224 ++++++++++++++++++++++++++++++++
 include/linux/arm_sdei.h        |   6 +
 include/uapi/linux/arm_sdei.h   |   1 +
 9 files changed, 396 insertions(+), 39 deletions(-)
 create mode 100644 arch/arm64/include/asm/nmi.h
 create mode 100644 drivers/firmware/arm_sdei_nmi.c


base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
--
2.54.0

