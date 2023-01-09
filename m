Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F2C8C5479D
	for <kexec@archiver.kernel.org>; Mon,  9 Jan 2023 22:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BO+qXzDZ/5EDLZnJ5ag8gQLWvvtI8IygTz1B4LOSbkk=; b=hSds7ZUF/DzH3E
	0uCzonc7RoBNqGYpu/EfDRuSyChKt45DERF3DcSR2AQ3agdWDY+bX4rwzZIKxZY33vMOAV/fmmA31
	2dXmuHuPzJws4z2hdpxKePAEAbUUwaJISb9iZtXofqLQmOzlDfbrm82QnVw87EejL5MfQ1ZnufAe0
	1hb0WJ0lOnWevNI/26+olOv72RWUX1+LswRH5S76F2u/Lvd03T0AHy1S36kQB03bhIypvTaNpAHEu
	kS7yVLKbqGVWbeuXDh8985ImS9b3Crfs/BJezsR6g4o7Z4s+o3BWciG0YaJ48RxVd28UYiNfJ88pK
	E1MkCeg4At8gRJX9xoog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pF0DS-004Pg2-PH; Mon, 09 Jan 2023 22:02:02 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pF08s-004Nxq-66
	for kexec@lists.infradead.org; Mon, 09 Jan 2023 21:57:22 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1673301433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=crQggRCCTS9KBx/w5xi4+o+X/zIwoXHiy4Qxywl0rDY=;
	b=jlhroFq0hxX606/TPil8wehF7+JDsZOfxdrARjn596nzoPnZKntRgSd5B0I6u3D7LnEeWE
	GsagpDDtjim395PeSYkqvD58jgt5eBJYzDid2C0ySb7pMsrRFepGaMMJBAPQyHn8EVKseV
	yaJYjMvwfbwZrWewMiuj1sxZLTVKVyZZVXWNNck12KUaRQRozg76SeGCavZ6bwx3eLVe/1
	iqhIPM5BPejrIZFeQ9tqe2/sSHs1wAGJdbCqiT4kRgiuXV06sC/kqNBimwwXHua2WrijbV
	fx0g6XHKV5zv5s+VP1Ci/+tpROThGXTxQuqDBw7EI+SBjJ+VUX3xXaghq9H/fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1673301433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=crQggRCCTS9KBx/w5xi4+o+X/zIwoXHiy4Qxywl0rDY=;
	b=cjhakuEtujcCDmFY4QZr2I17y5uHf1FyH/jMBZ+npa0D1+5SUnwh4QUVQlJp9sYLneLi8l
	J/FInu9LD+UqeiAw==
To: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, kexec@lists.infradead.org
Subject: Re: kdump kernel randomly hang with tick_periodic call trace on
 bare metal system
In-Reply-To: <Y6FK++b4buO5EgjD@MiWiFi-R3L-srv>
References: <Y6FJgh3fOYoF0wSV@MiWiFi-R3L-srv> <Y6FK++b4buO5EgjD@MiWiFi-R3L-srv>
Date: Mon, 09 Jan 2023 22:57:13 +0100
Message-ID: <87mt6rjrra.ffs@tglx>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230109_135720_127226_2F8D69A6 
X-CRM114-Status: GOOD (  15.37  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Tue, Dec 20 2022 at 13:41, Baoquan He wrote:
> On one intel bare metal system, I can randomly reproduce the kdump hang
> as below with tick_periodic call trace. Attach the kernel config for
> reference.

This has absolutely nothing to do with x2apic IPI shorthands

> [    0.045980] Spurious LAPIC timer interrupt on cpu 0

So here the CPU receives a spurious Local APIC timer interrupt, but
that's a red herring.

> [    1.152690] BUG: kernel NULL pointer dereference, address: 0000000000000088
> [    1.159634] #PF: supervisor read access in kernel mode
> [    1.164757] #PF: error_code(0x0000) - not-present page
> [    1.169882] PGD 0 P4D 0 
> [    1.172407] Oops: 0000 [#1] PREEMPT SMP PTI
> [    1.176578] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.0.11-300.fc37.x86_64 #1
> [    1.183870] Hardware name: Dell Inc. PowerEdge R410/0N051F, BIOS 1.11.0 07/20/2012
> [    1.191420] RIP: 0010:tick_periodic+0x23/0x80

I'm willing to bet that this is caused by the following line in tick_periodic():

    update_process_times(user_mode(get_irq_regs()));

       user_mode() is invoked with a NULL pointer. user_mode() accesses
       regs->cs. CS is at offset 0x88....

The reason for this is here:

> [    1.280648]  tick_handle_periodic+0x1f/0x70
> [    1.284821]  timer_interrupt+0x14/0x20
> [    1.288561]  __handle_irq_event_percpu+0x46/0x190
> [    1.293253]  handle_irq_event+0x34/0x70
> [    1.297080]  handle_level_irq+0xa8/0x180
> [    1.300993]  resend_irqs+0x5d/0x70
> [    1.304386]  tasklet_action_common.constprop.0+0xab/0xe0
> [    1.309686]  __do_softirq+0xfb/0x319
> [    1.313254]  __irq_exit_rcu+0xd7/0x140
> [    1.316993]  common_interrupt+0xb9/0xd0

For some reason the timer interrupt is resent in software. I assume it is
the HPET interrupt because that's what just got initialized.

> [    1.143537] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns

and the callchain below just confirms that:

> [    1.393315]  _raw_spin_unlock_irqrestore+0x19/0x40
> [    1.398093]  __setup_irq+0x443/0x6d0
> [    1.401659]  request_threaded_irq+0x109/0x170
> [    1.406005]  hpet_time_init+0x2d/0x4b
> [    1.409661]  x86_late_time_init+0x17/0x34
> [    1.413658]  start_kernel+0x8cf/0x97f

The software resend code does not go through the regular interrupt entry
path which explains why get_irq_regs() returns NULL.

That software resend is bogus especially since the timer interrupt is
a level interrupt. As dmesg does not say anything about the APIC
delivery mode I assume this goes through i8259, which fails to set the
IRQ_LEVEL flag on all interrupt lines.

The below should fix this.

Thanks,

        tglx
---
--- a/arch/x86/kernel/i8259.c
+++ b/arch/x86/kernel/i8259.c
@@ -114,6 +114,7 @@ static void make_8259A_irq(unsigned int
 	disable_irq_nosync(irq);
 	io_apic_irqs &= ~(1<<irq);
 	irq_set_chip_and_handler(irq, &i8259A_chip, handle_level_irq);
+	irq_set_status_flags(irq, IRQ_LEVEL);
 	enable_irq(irq);
 	lapic_assign_legacy_vector(irq, true);
 }
--- a/arch/x86/kernel/irqinit.c
+++ b/arch/x86/kernel/irqinit.c
@@ -65,8 +65,10 @@ void __init init_ISA_irqs(void)
 
 	legacy_pic->init(0);
 
-	for (i = 0; i < nr_legacy_irqs(); i++)
+	for (i = 0; i < nr_legacy_irqs(); i++) {
 		irq_set_chip_and_handler(i, chip, handle_level_irq);
+		irq_set_status_flags(i, IRQ_LEVEL);
+	}
 }
 
 void __init init_IRQ(void)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
