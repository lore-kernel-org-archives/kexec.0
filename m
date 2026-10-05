Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52320CA5FCE
	for <kexec@archiver.kernel.org>; Mon,  5 Oct 2026 01:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YMRdMPBRQIrUX61rqc5mlDXTRBhO1/an+eTx2/A0kFU=; b=I6+nU2o7mXapdyDramKlxataEs
	eIif9m1lB53eTKh5VdBhkI63qLh+zew8OxLalckTIHRCzUuhxMLRIZ3VBq6Pqoe7Bw01qZykJxZ2k
	wWWKbO6Jy4e5qRpbGPB6PyT45maOrJBIh6ZjF46A12Kh8i2hrMioHnCw3TgPtCRaUxXRJJdrm0Fpl
	V7pb34pMtUY9OOhJd4sIdPQlIhaQGqBkv2xQpr12QqYkDxqH/TIlMwo6hDnmFpj6ILYzsOQl8v/Us
	q80A3bOh3ObzljhiywE9QMHvDu4vYG13S/ySRZTX0dp6GYZYFzyMbF6jmtNhvPDr8hB4fHCtF3yNC
	CZfOXztg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDXiK-0000000FaFz-45WK;
	Mon, 05 Oct 2026 01:42:00 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDXiJ-0000000FaFf-28l1;
	Mon, 05 Oct 2026 01:41:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DCC9E60515;
	Mon,  5 Oct 2026 01:41:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD56B1F000FF;
	Mon,  5 Oct 2026 01:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791164516;
	bh=YMRdMPBRQIrUX61rqc5mlDXTRBhO1/an+eTx2/A0kFU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IDVHcEngx0Tjvw7z0pduHY8+I+Ev0IaX397LvhXDxAmF4HfroZIl3RbZ6k2LC/PJn
	 O8yt4kiShPFUmXnha4+IZDdmEG8sxUz8GV2AnI6Zo8OVrFybxPy5yrZ82ofe2hP/UX
	 xLo1IP7YNu2xFLTO+bqRKmdGkp/tMP8QTvfIQ+miXFC3h2QMUIiPscf3JFQc+k2o2x
	 5ULUmqCOLNZG9KfWvGAuQ9AyEdyUc1eSkcSg1CE9UBja0th+4/rgT6rQ3dro0fP6Jp
	 J4EOTbl5fMsKg5XDUUqSQCIfdqTk4zhB+92r17tELBDIB/vl2POaseI1dWmY5+WF2I
	 kp5/nP/1fYMHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC] genirq/kexec: Do not take the bus lock of an
 interrupt chip on the crash path
To: "Thomas Gleixner" <tglx@kernel.org>, "Igor Velkov" <iav@iav.lv>
Cc: "Will Deacon" <will@kernel.org>, "Marc Zyngier" <maz@kernel.org>, "Radu
 Rendec" <radu@rendec.net>, "Baoquan He" <baoquan.he@linux.dev>, "Heiko
 Stuebner" <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, "Eliav
 Farber" <farbere@amazon.com>, kexec@lists.infradead.org, "Catalin Marinas" <catalin.marinas@arm.com>, "Mark
 Rutland" <mark.rutland@arm.com>
In-Reply-To: <20261005-kexec-irq-bus-lock-v1-1-09f6b5323460@iav.lv>
References: <20261005-kexec-irq-bus-lock-v1-1-09f6b5323460@iav.lv>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 01:41:55 +0000
Message-Id: <20261005014155.BD56B1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] irq/kexec: incomplete slow bus check allows hang via irq_bus_syn=
c_unlock
--

commit a12343156827b9035af6e3982ac65b3437921502
Author: Igor Velkov <iav@iav.lv>

genirq/kexec: Do not take the bus lock of an interrupt chip on the crash pa=
th

machine_kexec_mask_interrupts() calls irq_set_irqchip_state() for every
started interrupt. That function takes the bus lock of the interrupt
chip and syncs the chip when it drops the lock. On the crash path
interrupts are off and the other CPUs are stopped, so a chip that needs
its bus for the sync never returns.

> diff --git a/kernel/irq/kexec.c b/kernel/irq/kexec.c
> index 1a3deffe6b5b6..c6c745cc76a25 100644
> --- a/kernel/irq/kexec.c
> +++ b/kernel/irq/kexec.c
> @@ -20,7 +20,11 @@ void machine_kexec_mask_interrupts(void)
>  		if (!chip || !irqd_is_started(&desc->irq_data))
>  			continue;
> =20
> -		if (IS_ENABLED(CONFIG_GENERIC_IRQ_KEXEC_CLEAR_VM_FORWARD)) {
> +		/*
> +		 * irq_set_irqchip_state() takes the bus lock, and a chip that
> +		 * has one may sleep or talk to its bus when the lock is dropped.
> +		 */
> +		if (IS_ENABLED(CONFIG_GENERIC_IRQ_KEXEC_CLEAR_VM_FORWARD) && !chip->ir=
q_bus_lock) {

[Severity: Medium]
Does this check comprehensively protect against slow bus chips?

If an irqchip implements irq_bus_sync_unlock but omits irq_bus_lock, this
condition evaluates to true and irq_set_irqchip_state() is called.
Since irq_set_irqchip_state() ultimately unlocks the descriptor via
__irq_put_desc_unlock(), it unconditionally invokes the sync callback:

kernel/irq/irqdesc.c:__irq_put_desc_unlock() {
    ...
    if (bus)
        chip_bus_sync_unlock(desc);
    ...
}

Executing the sync callback on the crash path without interrupts could hang=
 the
system, defeating the purpose of this patch.

Other places in the subsystem check for both callbacks to identify slow bus
locking/syncing, for instance:

kernel/irq/manage.c:irq_supports_nmi() {
    ...
    if (d->chip->irq_bus_lock || d->chip->irq_bus_sync_unlock)
        return false;
    ...
}

Should this check also ensure !chip->irq_bus_sync_unlock?

>  			/*
>  			 * First try to remove the active state from an interrupt which is fo=
rwarded
>  			 * to a VM. If the interrupt is not forwarded, try to EOI the interru=
pt.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-kexec-irq-=
bus-lock-v1-1-09f6b5323460@iav.lv?part=3D1

