Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED62BE7717F
	for <kexec@archiver.kernel.org>; Mon, 16 Dec 2024 17:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ATnv+s1QuLqYt1l9NjHqZOiQjphfAro4ahyFQSrmFEo=; b=AYC//95E2OAhTv3Nq1uyRZa6mW
	+gh/qVHaHIGrZe/39ysjWastY+M9SSqKZXDqhcExfXkYM4IHKwfVeYHev5xMOoraQK6JknWjElMBP
	nuOw3ShV9G/zRxQZSH5Nfzv+BgVHlGJWiRMtXDPb+nBWSZ03yGFB+g6zkI4Kh//DzXC380Er9u6f9
	JExoEmfIcor/KFcX30yukXIhuo3cpmmrVOL1YWqkC7qwjzLQYyntGTzqx86w00rItOX78XVXCffAB
	62ZvFlvU/mYqtn1dX50pXhIqWSSZZiyNYZiFyxHe44d1MNmc7+g4hhCwTKReAqnoZv6xxTKaRbJKk
	3Sh7t7KQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNF61-0000000Anwv-2vd5;
	Mon, 16 Dec 2024 17:41:29 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNF60-0000000AnwQ-0Ekn
	for kexec@bombadil.infradead.org;
	Mon, 16 Dec 2024 17:41:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=ATnv+s1QuLqYt1l9NjHqZOiQjphfAro4ahyFQSrmFEo=; b=FgjQDjqjd9hDErMOJmiOK3hYLI
	PgAWLm8SklSl5yssBJGV/rz6J2nF6O78QNmIn+3QbVTMQCF5++tXeQneyFuVjxDCDlfjq13AJtVgt
	5e8/XcUjudYnuHVqx5UAahRNcrHHZJuEjc0I402qapjDyhyPeac2PRzrJn8ug0/Zi4oFlBBoDtBRG
	nvZvi2gJez9/WyvShMGH2mPdpNahy9iNnBlQ2K6UYnAalq3cXbw3kY9AJhCDuByvm0Dzr1WsM9Hhy
	LoYhrWU8AwSdZP6MDv1+1M5h+j28u4bQclnbQvDBmMnLwxtPIpf47HnaCkJonZNWCEacv8FEE6D1G
	jnGRWZbQ==;
Received: from [2a00:23ee:2908:bad:cd3a:995:e233:9fc1] (helo=[IPv6:::1])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNF5x-00000004uxN-4A2X;
	Mon, 16 Dec 2024 17:41:26 +0000
Date: Mon, 16 Dec 2024 17:41:27 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "x86@kernel.org" <x86@kernel.org>, hpa <hpa@zytor.com>,
 dyoung <dyoung@redhat.com>, kexec <kexec@lists.infradead.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, eperezma <eperezma@redhat.com>,
 Paolo Bonzini <bonzini@redhat.com>, ming.lei@redhat.com,
 Petr Mladek <pmladek@suse.com>, John Ogness <jogness@linutronix.de>
Subject: Re: [PATCH] sched: Prevent rescheduling when interrupts are disabled
User-Agent: K-9 Mail for Android
In-Reply-To: <87a5cv932f.ffs@tglx>
References: <1f631458c180c975c238d4d33d333f9fa9a4d2a3.camel@infradead.org> <CACGkMEtOdYorGPdSjxC1Lb1LJtZ+ZqHam3agHJ6JdpS-tE1qAQ@mail.gmail.com> <20241211124240.GA310916@fedora> <7717fe2ac0ce5f0a2c43fdab8b11f4483d54a2a4.camel@infradead.org> <87ldwl9g93.ffs@tglx> <10f5d22150b548ec271e0a847ba2eb91139e6f61.camel@infradead.org> <87a5d0aibc.ffs@tglx> <dd06cd643ee7fa0be08ac3082cff443b8bfbfb58.camel@infradead.org> <874j38a16p.ffs@tglx> <20241213112028.GE21636@noisy.programming.kicks-ass.net> <87seqr914v.ffs@tglx> <87a5cv932f.ffs@tglx>
Message-ID: <082A11A1-404B-4FFE-B6DC-64A543CA61AD@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html
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

On 16 December 2024 13:20:56 GMT, Thomas Gleixner <tglx@linutronix=2Ede> wr=
ote:
>David reported a warning observed while loop testing kexec jump:
>
>  Interrupts enabled after irqrouter_resume+0x0/0x50
>  WARNING: CPU: 0 PID: 560 at drivers/base/syscore=2Ec:103 syscore_resume=
+0x18a/0x220
>   kernel_kexec+0xf6/0x180
>   __do_sys_reboot+0x206/0x250
>   do_syscall_64+0x95/0x180
>
>The corresponding interrupt flag trace:
>
>  hardirqs last  enabled at (15573): [<ffffffffa8281b8e>] __up_console_se=
m+0x7e/0x90
>  hardirqs last disabled at (15580): [<ffffffffa8281b73>] __up_console_se=
m+0x63/0x90
>
>That means __up_console_sem() was invoked with interrupts enabled=2E Furt=
her
>instrumentation revealed that in the interrupt disabled section of kexec
>jump one of the syscore_suspend() callbacks woke up a task, which set the
>NEED_RESCHED flag=2E A later callback in the resume path invoked
>cond_resched() which in turn led to the invocation of the scheduler:
>
>  __cond_resched+0x21/0x60
>  down_timeout+0x18/0x60
>  acpi_os_wait_semaphore+0x4c/0x80
>  acpi_ut_acquire_mutex+0x3d/0x100
>  acpi_ns_get_node+0x27/0x60
>  acpi_ns_evaluate+0x1cb/0x2d0
>  acpi_rs_set_srs_method_data+0x156/0x190
>  acpi_pci_link_set+0x11c/0x290
>  irqrouter_resume+0x54/0x60
>  syscore_resume+0x6a/0x200
>  kernel_kexec+0x145/0x1c0
>  __do_sys_reboot+0xeb/0x240
>  do_syscall_64+0x95/0x180
>
>This is a long standing problem, which probably got more visible with
>the recent printk changes=2E Something does a task wakeup and the
>scheduler sets the NEED_RESCHED flag=2E cond_resched() sees it set and
>invokes schedule() from a completely bogus context=2E The scheduler
>enables interrupts after context switching, which causes the above
>warning at the end=2E
>
>Quite some of the code paths in syscore_suspend()/resume() can result in
>triggering a wakeup with the exactly same consequences=2E They might not
>have done so yet, but as they share a lot of code with normal operations
>it's just a question of time=2E
>
>The problem only affects the PREEMPT_NONE and PREEMPT_VOLUNTARY schedulin=
g
>models=2E Full preemption is not affected as cond_resched() is disabled a=
nd
>the preemption check preemptible() takes the interrupt disabled flag into
>account=2E
>
>Cure the problem by adding a corresponding check into cond_resched()=2E
>
>Reported-by: David Woodhouse <dwmw2@infradead=2Eorg>
>Signed-off-by: Thomas Gleixner <tglx@linutronix=2Ede>
>Tested-by: David Woodhouse <dwmw2@infradead=2Eorg>
>Cc: stable@vger=2Ekernel=2Eorg
>Closes: https://lore=2Ekernel=2Eorg/all/7717fe2ac0ce5f0a2c43fdab8b11f4483=
d54a2a4=2Ecamel@infradead=2Eorg
>---
> kernel/sched/core=2Ec |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>--- a/kernel/sched/core=2Ec
>+++ b/kernel/sched/core=2Ec
>@@ -7276,7 +7276,7 @@ void rt_mutex_setprio(struct task_struct
> #if !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC)
> int __sched __cond_resched(void)
> {
>-	if (should_resched(0)) {
>+	if (should_resched(0) && !irqs_disabled()) {
> 		preempt_schedule_common();
> 		return 1;
> 	}

Thank you=2E Slight preference for dwmw@amazon=2Eco=2Euk as the Reported-b=
y and Tested-by addresses if it's not too late=2E I'm assuming you will han=
dle this and don't want me to round it up with the kexec bits=2E

