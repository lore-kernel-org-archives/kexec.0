Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E17D6EC0A
	for <kexec@archiver.kernel.org>; Fri, 29 Nov 2024 13:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=icaSftmPoFs3oPqGohm7R/vQ0cSrUMEsdq65mpHvRVA=; b=CN+FXluNHhwvr9VWw6Hg+Pq0Q5
	xFjvREDF8poCjJ7M8ExKtMD0LM5K3sNZdsjkIBdKnN+jUQ7zQDSTI5TRagIAf99eYBdThvTK8Qft0
	I3l9ZYpShnYPzCORF1XRkxfyaex6CaRM3wwADuuslUoHD7wKe0FPA9j5t5oobf+kWYxNlwFLYg3HW
	38Cexabjn1/EDqGpWePxHivdmDtdO2XPhWZlVBiDBflPpIpcX6N7pXjYGBSl0pcywu0vc3uQulvpH
	FejsZ/qz32uSUdIoay6gwba/6iKy2C3Aoxd/oTq+IOefZMRZigtRMyeWhV1BGw+/1JDmSqz7oZx+L
	+60kC1cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tH155-00000000Cc1-1mhg;
	Fri, 29 Nov 2024 13:30:47 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tH152-00000000CbM-2rf8;
	Fri, 29 Nov 2024 13:30:45 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732887041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=icaSftmPoFs3oPqGohm7R/vQ0cSrUMEsdq65mpHvRVA=;
	b=YZd0bUlE0xZWKejtIH/8b1Xqio5SfbdWK/5fXWh1rcU+HTZHZqztwv5kJcUBmq52ppdrJy
	1Ep4+fruQcQWa6mXw/p8/wsLzsNObq5sVcv+kWT0aSkor/PqAIo/AF1SvX8kussOXip9jW
	H6sdGyfghjxb6Y3ZPxDxq2Zsq4wbPAx6Rg7A9IX3NMquMO61hFmKPU+wHyFSZHsGZB4706
	parfYH3VpxhtyxyRSUbXKOzFpsOPMQbyXJeDVpuYL/lQkIA/k1Nw2c5rfjJznTWNfjY1ca
	JSyIKNKyfdTbY8dtmOcn45qcazynk3AfLKl/TLDh1aj50MMzlJU/wBAxGVRaEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732887041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=icaSftmPoFs3oPqGohm7R/vQ0cSrUMEsdq65mpHvRVA=;
	b=wrWncmeLIabkTOlhwz7jViyBBp/tltQNLjqOmhFxdSu/hqrEOzPSlAZ4Wcir7LF0WMDQzx
	JiqHMj25fRo9EECQ==
To: Eliav Farber <farbere@amazon.com>, linux@armlinux.org.uk,
 catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au,
 npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org,
 maddy@linux.ibm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, ebiederm@xmission.com, akpm@linux-foundation.org,
 bhe@redhat.com, farbere@amazon.com, hbathini@linux.ibm.com,
 sourabhjain@linux.ibm.com, adityag@linux.ibm.com,
 songshuaishuai@tinylab.org, takakura@valinux.co.jp,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 kexec@lists.infradead.org, Marc Zyngier <maz@kernel.org>
Cc: jonnyc@amazon.com
Subject: Re: [PATCH v4 1/2] kexec: Consolidate
 machine_kexec_mask_interrupts() implementation
In-Reply-To: <20241129113119.26669-2-farbere@amazon.com>
References: <20241129113119.26669-1-farbere@amazon.com>
 <20241129113119.26669-2-farbere@amazon.com>
Date: Fri, 29 Nov 2024 14:30:41 +0100
Message-ID: <87zfliw4ji.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241129_053044_861266_48998742 
X-CRM114-Status: GOOD (  17.04  )
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

On Fri, Nov 29 2024 at 11:31, Eliav Farber wrote:
> Move the machine_kexec_mask_interrupts function to a common location in
> kernel/kexec_core.c, removing duplicate implementations from architecture
> specific files (arch/arm, arch/arm64, arch/powerpc, and arch/riscv).

Can you please move this into kernel/irq/kexec.c?

It's pure interrupt core internal code and there is no point to make
core internal functions visible to random other code just because.

> +void machine_kexec_mask_interrupts(void)
> +{
> +	unsigned int i;
> +	struct irq_desc *desc;

	struct irq_desc *desc;
        unsigned int i;

please

> +	for_each_irq_desc(i, desc) {
> +		struct irq_chip *chip;
> +		int check_eoi = 1;
> +
> +		chip = irq_desc_get_chip(desc);
> +		if (!chip)
> +			continue;
> +
> +		if (IS_ENABLED(CONFIG_ARM64)) {

This should not be CONFIG_ARM64. Add something like:

config GENERIC_IRQ_KEXEC_CLEAR_VM_FORWARD
	bool

and select this from ARM64?

> +			/*
> +			 * First try to remove the active state. If this fails, try to EOI the
> +			 * interrupt.

This comment does not really explain what this is about. I know you
copied it from the ARM64 implementation, but it should explain what this
actually means. Something like:

         First try to remove the active state from an interrupt which is
         forwarded to a VM. If the interrupt is not forwarded, try to
         EOI the interrupt.

or something like that.

> +			 */
> +			check_eoi = irq_set_irqchip_state(i, IRQCHIP_STATE_ACTIVE, false);

Looking deeper. This function actually cannot be called from this
context. It does:

          irq_get_desc_buslock(irq, &flags, 0);

which means for any interrupt which has an actual buslock implementation
it will end up in a sleepable function and deadlock in the worst case.

Marc?

> +		}
> +
> +		if (check_eoi && chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
> +			chip->irq_eoi(&desc->irq_data);

Thanks,

        tglx

