Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7ABDC3DA78
	for <kexec@archiver.kernel.org>; Sat, 14 Jan 2023 02:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9jrw/AeaHsuhymT+rYBkTDpcumKzwYoJRduY3NZXnIY=; b=3H6TI0e9W/7EVO
	DlXK6Ls8P8kQmynfS06AiXMm+NKDwg8kRdX6lCHlKz0Jyh1aJ+8EPUs/1GgnM2c6OOP1tHrBP4xxB
	9h4eBDuxm7IWnNChdZRYitntOqr5d+GQVDUmuVZVsv/MBHCUttmqGbmN/9WDMXb0c7IgZSQqEP/aO
	YPDfQ5qlT6JoGgtdLmPEsCTjgu6LyehlbvNVjJZlg47NlMxvEPpQs/j18DYd9dG6/a+lsy+PQGcqu
	53cP/BiEb0Te6NDLt9zT1zz5tdO+nPfyF+CXJSfIf6TdI9ioJ2lyEYaBX9U+GifB+iZQVkaJLHvM0
	/eKexZkicqlp7cQGE4gA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGVyk-0053ZE-TC; Sat, 14 Jan 2023 02:09:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGVyh-0053Yf-GQ
	for kexec@lists.infradead.org; Sat, 14 Jan 2023 02:09:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1673662142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g8WiLAQd4MrQTQlOR2IKuo321XRp1L/d4bWTe2T6IDM=;
	b=QQ7JIfW/3bamzwRbWkDI9efRfLnIcXlfQVVEsb5oqu3w2+7kRPAmXh+evc/tXExfP5T50E
	cNig7dX6KAVD87YfzhK7pvBoTlXFJfhT41Dj6vqtJ7DdE0e2Ja3vuLLK8Ez7xNuzF9YGj+
	9bCLe5hIBEeoz9XRyLLVOzO00buS33w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-70-TKwmIIxSNEuMo0Ffe4OBxQ-1; Fri, 13 Jan 2023 21:08:58 -0500
X-MC-Unique: TKwmIIxSNEuMo0Ffe4OBxQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 01C7B811E6E;
	Sat, 14 Jan 2023 02:08:58 +0000 (UTC)
Received: from localhost (ovpn-12-229.pek2.redhat.com [10.72.12.229])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 44DDF4085720;
	Sat, 14 Jan 2023 02:08:56 +0000 (UTC)
Date: Sat, 14 Jan 2023 10:08:53 +0800
From: Baoquan He <bhe@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org
Subject: Re: kdump kernel randomly hang with tick_periodic call trace on bare
 metal system
Message-ID: <Y8IOtY2x8XQT+Owd@fedora>
References: <Y6FJgh3fOYoF0wSV@MiWiFi-R3L-srv>
 <Y6FK++b4buO5EgjD@MiWiFi-R3L-srv>
 <87mt6rjrra.ffs@tglx>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87mt6rjrra.ffs@tglx>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230113_180903_788122_5E9CFC9B 
X-CRM114-Status: GOOD (  27.47  )
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

On 01/09/23 at 10:57pm, Thomas Gleixner wrote:
> On Tue, Dec 20 2022 at 13:41, Baoquan He wrote:
> > On one intel bare metal system, I can randomly reproduce the kdump hang
> > as below with tick_periodic call trace. Attach the kernel config for
> > reference.
> 
> This has absolutely nothing to do with x2apic IPI shorthands
> 
> > [    0.045980] Spurious LAPIC timer interrupt on cpu 0
> 
> So here the CPU receives a spurious Local APIC timer interrupt, but
> that's a red herring.
> 
> > [    1.152690] BUG: kernel NULL pointer dereference, address: 0000000000000088
> > [    1.159634] #PF: supervisor read access in kernel mode
> > [    1.164757] #PF: error_code(0x0000) - not-present page
> > [    1.169882] PGD 0 P4D 0 
> > [    1.172407] Oops: 0000 [#1] PREEMPT SMP PTI
> > [    1.176578] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.0.11-300.fc37.x86_64 #1
> > [    1.183870] Hardware name: Dell Inc. PowerEdge R410/0N051F, BIOS 1.11.0 07/20/2012
> > [    1.191420] RIP: 0010:tick_periodic+0x23/0x80
> 
> I'm willing to bet that this is caused by the following line in tick_periodic():
> 
>     update_process_times(user_mode(get_irq_regs()));
> 
>        user_mode() is invoked with a NULL pointer. user_mode() accesses
>        regs->cs. CS is at offset 0x88....
> 
> The reason for this is here:
> 
> > [    1.280648]  tick_handle_periodic+0x1f/0x70
> > [    1.284821]  timer_interrupt+0x14/0x20
> > [    1.288561]  __handle_irq_event_percpu+0x46/0x190
> > [    1.293253]  handle_irq_event+0x34/0x70
> > [    1.297080]  handle_level_irq+0xa8/0x180
> > [    1.300993]  resend_irqs+0x5d/0x70
> > [    1.304386]  tasklet_action_common.constprop.0+0xab/0xe0
> > [    1.309686]  __do_softirq+0xfb/0x319
> > [    1.313254]  __irq_exit_rcu+0xd7/0x140
> > [    1.316993]  common_interrupt+0xb9/0xd0
> 
> For some reason the timer interrupt is resent in software. I assume it is
> the HPET interrupt because that's what just got initialized.
> 
> > [    1.143537] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
> 
> and the callchain below just confirms that:
> 
> > [    1.393315]  _raw_spin_unlock_irqrestore+0x19/0x40
> > [    1.398093]  __setup_irq+0x443/0x6d0
> > [    1.401659]  request_threaded_irq+0x109/0x170
> > [    1.406005]  hpet_time_init+0x2d/0x4b
> > [    1.409661]  x86_late_time_init+0x17/0x34
> > [    1.413658]  start_kernel+0x8cf/0x97f
> 
> The software resend code does not go through the regular interrupt entry
> path which explains why get_irq_regs() returns NULL.
> 
> That software resend is bogus especially since the timer interrupt is
> a level interrupt. As dmesg does not say anything about the APIC
> delivery mode I assume this goes through i8259, which fails to set the
> IRQ_LEVEL flag on all interrupt lines.
> 
> The below should fix this.

Sorry for late reply, just notice this mail.

Thanks a lot for checking this and providing a fix, I will reserve the
lab machine and give it a shot, will feedback once finished. 

> ---
> --- a/arch/x86/kernel/i8259.c
> +++ b/arch/x86/kernel/i8259.c
> @@ -114,6 +114,7 @@ static void make_8259A_irq(unsigned int
>  	disable_irq_nosync(irq);
>  	io_apic_irqs &= ~(1<<irq);
>  	irq_set_chip_and_handler(irq, &i8259A_chip, handle_level_irq);
> +	irq_set_status_flags(irq, IRQ_LEVEL);
>  	enable_irq(irq);
>  	lapic_assign_legacy_vector(irq, true);
>  }
> --- a/arch/x86/kernel/irqinit.c
> +++ b/arch/x86/kernel/irqinit.c
> @@ -65,8 +65,10 @@ void __init init_ISA_irqs(void)
>  
>  	legacy_pic->init(0);
>  
> -	for (i = 0; i < nr_legacy_irqs(); i++)
> +	for (i = 0; i < nr_legacy_irqs(); i++) {
>  		irq_set_chip_and_handler(i, chip, handle_level_irq);
> +		irq_set_status_flags(i, IRQ_LEVEL);
> +	}
>  }
>  
>  void __init init_IRQ(void)
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
