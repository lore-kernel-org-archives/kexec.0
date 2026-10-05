Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94232CA5FCE
	for <kexec@archiver.kernel.org>; Mon,  5 Oct 2026 01:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EeiQ70gbrLsT7AI+DPTKvW0oMLkENahuIzdfUVx6YWQ=; b=Y83TElU2pWBtoF0TwBsiGs2AvN
	ViD/sSKUugYUeXW0QQj6N5A94wFHSA2oY6kmK0/J54zx2bDPc8Q7kC+554c3WjyGPqN2Q5s9hqXL9
	7sDV+HBea2qS7vbGtd4k3yhWerxM87X/Vx+fz+n5n1iIL7/kxbo/Jyu4zcQXpFVqPxvCitnQMCjdq
	foqFwSCSMNYrsIaicwjuKLE721gfGid521jDeSBRP256YDs/iXjVELSufZG5ib6ySKK5Axr7V9UMH
	nbn4jUd9puUz+N+Yrj30XZ8yz7hpI0tEYlPIlk57OQvj+WW5OHZJqz9OJncQe+4ToJFWZoaVC3fsd
	H4dwamtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDXPe-0000000FZRf-1Fwl;
	Mon, 05 Oct 2026 01:22:42 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDXPc-0000000FZRR-07wH;
	Mon, 05 Oct 2026 01:22:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2E83043CB7;
	Mon,  5 Oct 2026 01:22:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6835C2BCB9;
	Mon,  5 Oct 2026 01:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791163359;
	bh=mSUGEIXHNZJ4rJhgsiWY1FXxcZvgmFQ+96Fc9nOaDx4=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=HGIxeyWX1aQX1FNM0nfEQ/1QppRaQMAwM9A1zo/JmDeP8W7/l8v9DM/XOR1WIMTsl
	 it/WhkuZpTTrdDuxmBdjwK1nHAFNWbVSgkuXDga6/aRQOfOye+KQ9wiIBct5SS2blg
	 ywpt49CYKdAFNduNxMGjDqoHe8zafy6kQhXsKl3NiMODbjf1NdSod/aN/h2rQN4lLa
	 FZxxzIfnG1SD1f01cos9+opQ9/Md8SG5k4O4ia5wQSfmAnkjc7ZQYIIoPUg7UoFqOH
	 utikZE6tsMwzNApiAKU+Oga2kuQz5/5AgVKG1cxB6aeqI7K+5YxbT6I2n7+MIRm/3Z
	 0kPX8J4xkt13Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05AECA5FCE;
	Mon,  5 Oct 2026 01:22:38 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Mon, 05 Oct 2026 01:22:28 +0000
Subject: [PATCH RFC] genirq/kexec: Do not take the bus lock of an interrupt
 chip on the crash path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-kexec-irq-bus-lock-v1-1-09f6b5323460@iav.lv>
X-B4-Tracking: v=1; b=H4sIANT7wmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAwNT3ezUitRk3cyiQt2k0mLdnPzkbN00E4sUU0szMxMT4xQloMaCotS
 0zAqwodFKQW7OSrG1tQD3QFHsaQAAAA==
To: Thomas Gleixner <tglx@kernel.org>
Cc: Radu Rendec <radu@rendec.net>, Marc Zyngier <maz@kernel.org>, 
 Eliav Farber <farbere@amazon.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Baoquan He <baoquan.he@linux.dev>, 
 Heiko Stuebner <heiko@sntech.de>, kexec@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3123; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=e1c53V//J8d8Mwma2hX4M3vyQP0i+wiZ0FJa3IT9WkA=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFmHft888uyX6/4fcu67LhbFuBwWzHplkm19V1pksoOQY
 raCqLVgRykLgxgXg6yYIsuEQxq3MpZc/evvYf4AZg4rE8gQBi5OAZjIKxWGf/qi000a7ix773vz
 9zdz5lSlvJl7HjGyPe9hCbmh8NP7jCEjw7ZjCw5d+B/Jw9JaXSrZUM+29ljLzp6stAPpBl+Pxuw
 zZAMA
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
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
Reply-To: iav@iav.lv
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: Igor Velkov <iav@iav.lv>

machine_kexec_mask_interrupts() calls irq_set_irqchip_state() for every
started interrupt. That function takes the bus lock of the interrupt
chip and syncs the chip when it drops the lock. On the crash path
interrupts are off and the other CPUs are stopped, so a chip that needs
its bus for the sync never returns.

On RK3399 boards with an RK808 PMIC the RTC alarm interrupt belongs to
the regmap-irq chip of the RK808, which sits on I2C. rk808_irq_chip sets
init_ack_masked, so regmap_irq_sync_unlock() writes the ack register on
every unlock, and the I2C controller needs its own interrupt to finish
the transfer. A panic with a crash kernel loaded prints

  SMP: stopping secondary CPUs

and then nothing until the watchdog resets the board. With a print
before and after the call, the last line is

  kexec-dbg: irq 54 chip rk808 buslock 1: set state

Skip the call for chips that have irq_bus_lock. It clears the active
state of an interrupt forwarded to a VM; the EOI and irq_shutdown() that
follow still run for these interrupts.

Fixes: 78fd584cdec0 ("arm64: kdump: implement machine_crash_shutdown()")
Assisted-by: LLM
Signed-off-by: Igor Velkov <iav@iav.lv>
---
RFC: the hang is real, but I am not sure this is the right place to fix
it. Two other places would also do:
- irq_set_irqchip_state() could look for a chip that implements the
  callback before it takes the bus lock;
- regmap-irq could stop writing the ack register on every sync.

Of the 57 drivers that set irq_bus_lock, plus regmap-irq, only
drivers/cdx/cdx_msi.c also has a parent chip that implements
irq_set_irqchip_state (the ITS); the others returned -EINVAL from the
call anyway. irq-imx-irqsteer.c uses irq_bus_lock for runtime PM rather
than a slow bus.

Tested with sysrq-c and kdump-tools on 7.3-rc5:
- Kobol Helios64 (RK3399, RK808): hangs 3 of 3 without the patch, saves
  the dump 3 of 3 with it, both kernels from one tree;
- Radxa ROCK Pi 4A (RK3399, RK808): hangs 2 of 2 without, saves the dump
  2 of 2 with it.
With the rk808-rtc driver unbound the unpatched kernel saves the dump.
---
 kernel/irq/kexec.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/kexec.c b/kernel/irq/kexec.c
index 1a3deffe6b5b..c6c745cc76a2 100644
--- a/kernel/irq/kexec.c
+++ b/kernel/irq/kexec.c
@@ -20,7 +20,11 @@ void machine_kexec_mask_interrupts(void)
 		if (!chip || !irqd_is_started(&desc->irq_data))
 			continue;
 
-		if (IS_ENABLED(CONFIG_GENERIC_IRQ_KEXEC_CLEAR_VM_FORWARD)) {
+		/*
+		 * irq_set_irqchip_state() takes the bus lock, and a chip that
+		 * has one may sleep or talk to its bus when the lock is dropped.
+		 */
+		if (IS_ENABLED(CONFIG_GENERIC_IRQ_KEXEC_CLEAR_VM_FORWARD) && !chip->irq_bus_lock) {
 			/*
 			 * First try to remove the active state from an interrupt which is forwarded
 			 * to a VM. If the interrupt is not forwarded, try to EOI the interrupt.

---
base-commit: a0e1fdb96578ea562a03c487f70673d228824d0a
change-id: 20261005-kexec-irq-bus-lock-f48d5966443d

Best regards,
-- 
Igor Velkov <iav@iav.lv>



