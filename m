Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E80E8CC6B38
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 18:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IZyVKQcVTMZmJowGXAGjBXmQ/4SHxcOiPIDUkDLgKCA=; b=zCtAJWyonuVQyO0Cg8yx8I7my8
	pqG37ovpK3xR9tGGAqu5XkeUU9lhOjT8iuSNMZ0/14B6xZKx+uQn+7zUyFkTHHx9i19n2P3zBL0RV
	vimkewfr6PT63pYXzsj1nIFwC1jrc6B3OMlkGbRuwvtVU75dQT4vEFHGw30OBR+kAkjA40C4HaR3f
	naoW5piHv5yfUi2iHldcHWZTehE9iarOiiLKrgBj1AgB+k2U8XizCZT5jKrgFiJQ4BpYDmchsS9Yq
	DbBzgp/V+yMkkwF94vCkdCVDvwFfVkQnmgjcWjEikQ3m10loG2MBOO1BZ18Yndt42MWm419KuHiVe
	0MB7a+wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHQYY-00000001CzT-0sTM;
	Thu, 15 Oct 2026 18:51:58 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHQYW-00000001CzE-3bop;
	Thu, 15 Oct 2026 18:51:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 830EE429CD;
	Thu, 15 Oct 2026 18:51:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D63CC2BCF4;
	Thu, 15 Oct 2026 18:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792090316;
	bh=1dzvgxln+eWwNsg9VVLAQoObHp1kZXAmcMPbWrIWUGI=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=BDtQ/H9240qHfpFhXPRul95ldjWLptYIs6WjJgpPhdaSF9HWvF+SPS2lXl3VEO5sc
	 znwXDqxFYdsomh0zh/Fz3yaANgn8UOocEkEziNgKdjqN2OKF3FXwOvo1VVlPPLSEwW
	 mQlcBqytx+Uo+6f4EKL8/fhIxrYR6G89V0i9P50rBxfQJTVCxobg/fe/b5SzaUy2cG
	 ZFh8oJsd0+QIUyB+GJEkQGzG1fEniam95t75cat8uUZPZKGKS+6X7pYrmQUUWV5piT
	 EaA+hUAIHRQDGQrAXUvIzZDPqcsclNxZ6zJ48NVfVq4Oo69Bkat+R+zlB1ro3m76aN
	 RZv8LWF1AGHJg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4EACCA465;
	Thu, 15 Oct 2026 18:51:56 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Thu, 15 Oct 2026 21:51:50 +0300
Subject: [PATCH v2] genirq/kexec: Do not take the bus lock of an interrupt
 chip on the crash path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-kexec-irq-bus-lock-v2-1-2af15f0757b6@iav.lv>
X-B4-Tracking: v=1; b=H4sIAMUg0WoC/32NQQ6CMBBFr0Jm7Zi2lEZceQ/DAuhUJhDAVhsM6
 d2tHMDle8l/f4dAninAtdjBU+TAy5xBnQroh3Z+ELLNDEooI4WocKSNemT/xO4dcFr6EZ2+2Ko
 2RuvSQh6unhxvR/TeZB44vBb/OT6i/Nm/uShRoqid6apSldqIG7fxPEVoUkpfIn/K67EAAAA=
To: Thomas Gleixner <tglx@kernel.org>
Cc: Radu Rendec <radu@rendec.net>, Marc Zyngier <maz@kernel.org>, 
 Eliav Farber <farbere@amazon.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Baoquan He <baoquan.he@linux.dev>, 
 Heiko Stuebner <heiko@sntech.de>, kexec@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4880; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=WElKsqp4WDpVY7lXmV1kTAIN6zD/+3FmBNHjKTykQeU=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFkXFY7N/8PFuXRta+C1bq24OsHXr/0+nHew+X7/qsvLB
 EXtxtX3OkpZGMS4GGTFFFkmHNK4lbHk6l9/D/MHMHNYmUCGMHBxCsBEQqIZGToOulXNq9tV/mnJ
 QY0v0l7PFZpXZJiyGopfF2P7qmNV58/wv1ppX4hiS4gID8/X27mvzI/9sGHfvFCtw3TZpd/aKp8
 WMwIA
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
started interrupt. That function takes the bus lock of the chip and
desc->lock, and syncs the chip when it drops them. On the crash path
interrupts are off and the other CPUs are stopped, so a chip whose bus
transfer is completed by an interrupt never returns from the sync.

On RK3399 boards with an RK808 PMIC the RTC alarm interrupt belongs to
the regmap-irq chip of the RK808, which sits on I2C. rk808_irq_chip sets
init_ack_masked, so regmap_irq_sync_unlock() writes the ack register on
every unlock, and the I2C controller needs its own interrupt to finish
the transfer. A panic with a crash kernel loaded prints

  SMP: stopping secondary CPUs

and then nothing until the watchdog resets the board.

machine_kexec_mask_interrupts() takes neither lock for the other
operations on the descriptor. Move the search for the chip that
implements irq_set_irqchip_state() into __irq_set_irqchip_state(), which
takes no locks, and call it from machine_kexec_mask_interrupts().

Fixes: 78fd584cdec0 ("arm64: kdump: implement machine_crash_shutdown()")
Suggested-by: Thomas Gleixner <tglx@kernel.org>
Assisted-by: LLM
Signed-off-by: Igor Velkov <iav@iav.lv>
---
Tested with sysrq-c and kdump-tools on Kobol Helios64 (RK3399, RK808),
7.3-rc7: the dump is saved 3 of 3. Without a fix it hangs 3 of 3 (7.3-rc5).
---
Changes in v2:
- Clear the active state through a lockless __irq_set_irqchip_state()
  instead of skipping chips with irq_bus_lock. The manage.c part is
  Thomas' proposal from the v1 thread.
- Link to v1: https://lore.kernel.org/r/20261005-kexec-irq-bus-lock-v1-1-09f6b5323460@iav.lv
---
 kernel/irq/internals.h |  1 +
 kernel/irq/kexec.c     |  2 +-
 kernel/irq/manage.c    | 43 ++++++++++++++++++++++++-------------------
 3 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 2c30e7537987..703a062be878 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -83,6 +83,7 @@ enum {
 #include "settings.h"
 
 extern int __irq_set_trigger(struct irq_desc *desc, unsigned long flags);
+extern int __irq_set_irqchip_state(struct irq_desc *desc, enum irqchip_irq_state which, bool val);
 extern void __disable_irq(struct irq_desc *desc);
 extern void __enable_irq(struct irq_desc *desc);
 
diff --git a/kernel/irq/kexec.c b/kernel/irq/kexec.c
index 1a3deffe6b5b..f245b9876422 100644
--- a/kernel/irq/kexec.c
+++ b/kernel/irq/kexec.c
@@ -25,7 +25,7 @@ void machine_kexec_mask_interrupts(void)
 			 * First try to remove the active state from an interrupt which is forwarded
 			 * to a VM. If the interrupt is not forwarded, try to EOI the interrupt.
 			 */
-			check_eoi = irq_set_irqchip_state(i, IRQCHIP_STATE_ACTIVE, false);
+			check_eoi = __irq_set_irqchip_state(desc, IRQCHIP_STATE_ACTIVE, false);
 		}
 
 		if (check_eoi && chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 4fbb8f960dbf..94c2e13ddf8d 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2747,6 +2747,28 @@ int irq_get_irqchip_state(unsigned int irq, enum irqchip_irq_state which, bool *
 }
 EXPORT_SYMBOL_GPL(irq_get_irqchip_state);
 
+int __irq_set_irqchip_state(struct irq_desc *desc, enum irqchip_irq_state which, bool val)
+{
+	struct irq_data *data = irq_desc_get_irq_data(desc);
+	struct irq_chip *chip;
+
+	do {
+		chip = irq_data_get_irq_chip(data);
+
+		if (WARN_ON_ONCE(!chip))
+			return -ENODEV;
+
+		if (chip->irq_set_irqchip_state)
+			break;
+
+		data = irqd_get_parent_data(data);
+	} while (data);
+
+	if (data)
+		return chip->irq_set_irqchip_state(data, which, val);
+	return -EINVAL;
+}
+
 /**
  * irq_set_irqchip_state - set the state of a forwarded interrupt.
  * @irq:	Interrupt line that is forwarded to a VM
@@ -2761,25 +2783,8 @@ EXPORT_SYMBOL_GPL(irq_get_irqchip_state);
  */
 int irq_set_irqchip_state(unsigned int irq, enum irqchip_irq_state which, bool val)
 {
-	scoped_irqdesc_get_and_buslock(irq, 0) {
-		struct irq_data *data = irq_desc_get_irq_data(scoped_irqdesc);
-		struct irq_chip *chip;
-
-		do {
-			chip = irq_data_get_irq_chip(data);
-
-			if (WARN_ON_ONCE(!chip))
-				return -ENODEV;
-
-			if (chip->irq_set_irqchip_state)
-				break;
-
-			data = irqd_get_parent_data(data);
-		} while (data);
-
-		if (data)
-			return chip->irq_set_irqchip_state(data, which, val);
-	}
+	scoped_irqdesc_get_and_buslock(irq, 0)
+		return __irq_set_irqchip_state(scoped_irqdesc, which, val);
 	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(irq_set_irqchip_state);

---
base-commit: 4351cc74202857f5b85b3573c477c9f798f5cd88
change-id: 20261005-kexec-irq-bus-lock-f48d5966443d

Best regards,
-- 
Igor Velkov <iav@iav.lv>



