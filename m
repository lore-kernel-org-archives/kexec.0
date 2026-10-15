Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 998A9CCA465
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 18:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CEBo6d2c2A7OH80vQVg8gBnOOhmXTLf6OZgdkLtG3zQ=; b=yjAjjWadCxTa5pA0gFd0lOELTL
	FNh59ckcx/2ooqq+jPRt9VRqRcGs2GDZpjkA1rDHYJheO1mEUa2cihK6qQ2vRceOda/BB9QwCEdsY
	Tfr7kc0SkhMD8gz8yiLp/V4IaFtnnC78c5G36mbGQdi2Ey4Z7g68dFeMsC5o5+RKnCzIINnID/LR5
	WeCaZXwfWcJDEJBr1o+nj9GD8qZkkC+vE5bfOapvBJaHLvSDT7D+MzP1Su9IKAUC+aECuREpRpEl2
	qdN8ma6W9nb9Hr8zunh77J4AsHjWE4awy0VzNOSfuJNY9+COiD9KQND3f+2P7SyLd/DbaPCYnEOui
	f3NndmHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHQeU-00000001Dgf-46VO;
	Thu, 15 Oct 2026 18:58:06 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHQeT-00000001DgZ-3Eyd
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 18:58:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 30DD943CEF;
	Thu, 15 Oct 2026 18:58:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8285D1F000C4;
	Thu, 15 Oct 2026 18:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792090685;
	bh=CEBo6d2c2A7OH80vQVg8gBnOOhmXTLf6OZgdkLtG3zQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aLcy+96N/mRn+Mx8x/QmanlV0zPrRod73udibdG9AMnyreqJsILUFBzCWz7NqR+fa
	 tBI5sdhvx1Hkh23VCnQ2GoHtqTq0k7BMJoMYNRVJ6LLMdCmzVz5JPxNFGTlZJbWaF8
	 9aPP0T4cYXakVX8Bu3QQul9xOBeDTShXwQuP4GWe9du6DQZPnIvk8U1HgPmv4s3HkW
	 RQwcO5nfBO1n/ylqUj98N3qq8Gvtiq6jWaHeRSYhtIX07KeDkHQcZrc6orV6RSMrMz
	 jkocg7MsMwrJroCsAMh09hK4y7+1v//Jsc9tA5+fnUKAUvQ0C0W1SEQpG4rFYv3TyM
	 8eGtW7USr9wqA==
Message-ID: <sashiko-outbox-173342@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] genirq/kexec: Do not take the bus lock of an
 interrupt chip on the crash path
To: "Igor Velkov" <iav@iav.lv>, "Thomas Gleixner" <tglx@kernel.org>
Cc: "Radu Rendec" <radu@rendec.net>, "Marc Zyngier" <maz@kernel.org>, "Eliav
 Farber" <farbere@amazon.com>, "Catalin Marinas" <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, "Baoquan
 He" <baoquan.he@linux.dev>, "Heiko Stuebner" <heiko@sntech.de>, kexec@lists.infradead.org
In-Reply-To: <20261015-kexec-irq-bus-lock-v2-1-2af15f0757b6@iav.lv>
References: <20261015-kexec-irq-bus-lock-v2-1-2af15f0757b6@iav.lv>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 18:58:04 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

> From: Igor Velkov <iav@iav.lv>
>=20
> machine_kexec_mask_interrupts() calls irq_set_irqchip_state() for every
> started interrupt. That function takes the bus lock of the chip and
> desc->lock, and syncs the chip when it drops them. On the crash path
> interrupts are off and the other CPUs are stopped, so a chip whose bus
> transfer is completed by an interrupt never returns from the sync.
>=20
> On RK3399 boards with an RK808 PMIC the RTC alarm interrupt belongs to
> the regmap-irq chip of the RK808, which sits on I2C. rk808_irq_chip sets
> init_ack_masked, so regmap_irq_sync_unlock() writes the ack register on
> every unlock, and the I2C controller needs its own interrupt to finish
> the transfer. A panic with a crash kernel loaded prints
>=20
>   SMP: stopping secondary CPUs
>=20
> and then nothing until the watchdog resets the board.
>=20
> machine_kexec_mask_interrupts() takes neither lock for the other
> operations on the descriptor. Move the search for the chip that
> implements irq_set_irqchip_state() into __irq_set_irqchip_state(), which
> takes no locks, and call it from machine_kexec_mask_interrupts().
>=20
> Fixes: 78fd584cdec0 ("arm64: kdump: implement machine_crash_shutdown()")
> Suggested-by: Thomas Gleixner <tglx@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Igor Velkov <iav@iav.lv>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-kexec-irq-=
bus-lock-v2-1-2af15f0757b6@iav.lv?part=3D1


