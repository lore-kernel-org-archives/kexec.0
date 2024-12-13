Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F35E3E7717D
	for <kexec@archiver.kernel.org>; Fri, 13 Dec 2024 11:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3E5inui+/Uaht5Te51wP/9nA3zKpMlHtnK0zFj+UdQ4=; b=vbPUBKJ/MAU4mJURfulrK9ePug
	Y2AJd73rUBqTyYHJmVwLiU1eE8CN3jF5iNXPlE6lNkoHV7Jvh/ibKk8xKgnaYfE9walA5vFyJRYUx
	vAECGVBb7QDL02kcLkyCbB1B8gDvNtXf/1W5bnwaQr8YkRhgUIFBZABqj7xsOFoV/2fZFXDpH73k8
	7KzgcX1CFJEsxXPZ6olarDQJngbB2tXOeYdcG26fKXv5i4kSWGjxGsZpx4S/VqE9gj/RipvFtUb0E
	+D+qOBX+X8Pn0oTeNFMWQRdz0sqq8b/FKQ/08TqWZwgB2fdLxT3Dnxm5vgj8V45s0vCRcoRYRRBNp
	2uwatp2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tM3jN-00000003XbR-2zK4;
	Fri, 13 Dec 2024 11:21:13 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tM3ig-00000003XUL-3N9B
	for kexec@bombadil.infradead.org;
	Fri, 13 Dec 2024 11:20:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3E5inui+/Uaht5Te51wP/9nA3zKpMlHtnK0zFj+UdQ4=; b=cwbEbcwYkE8yAW/AuxrDbnSI7R
	tScVCTQss0nj07HYf8Qi5HzVfcREk8u81GASn9GBESjY0mvtrlOi7TN+WfN1iLA+GCjgp4SaMfIyw
	6/zFPqvLaqNKAyhTAD9hsdREjH+NnTxlylncMhXIgGLWC9fu48Oe3hQsC71wa5vJtYBOmMNm3ikkr
	5WZEp/vj5i/+uaCobXF12tEWfLmCkvlgPO5lu3F+UUleAQgpK3E8O0XPpFu+5PZtJ6PGGYq3FHIjk
	WQBWPeFKOFYP0QAjqX9NlpeFf0dGGs6opipZcXBHerEq840XSnCEBmatKM4j8UdOPF7ktaXpPaRD/
	XeA87Kmg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tM3if-0000000CTta-0ZKq;
	Fri, 13 Dec 2024 11:20:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 38AA830049D; Fri, 13 Dec 2024 12:20:28 +0100 (CET)
Date: Fri, 13 Dec 2024 12:20:28 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
	hpa <hpa@zytor.com>, dyoung <dyoung@redhat.com>,
	kexec <kexec@lists.infradead.org>,
	linux-ext4 <linux-ext4@vger.kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	eperezma <eperezma@redhat.com>, Paolo Bonzini <bonzini@redhat.com>,
	ming.lei@redhat.com, Petr Mladek <pmladek@suse.com>,
	John Ogness <jogness@linutronix.de>
Subject: Re: Lockdep warnings on kexec (virtio_blk, hrtimers)
Message-ID: <20241213112028.GE21636@noisy.programming.kicks-ass.net>
References: <1f631458c180c975c238d4d33d333f9fa9a4d2a3.camel@infradead.org>
 <CACGkMEtOdYorGPdSjxC1Lb1LJtZ+ZqHam3agHJ6JdpS-tE1qAQ@mail.gmail.com>
 <20241211124240.GA310916@fedora>
 <7717fe2ac0ce5f0a2c43fdab8b11f4483d54a2a4.camel@infradead.org>
 <87ldwl9g93.ffs@tglx>
 <10f5d22150b548ec271e0a847ba2eb91139e6f61.camel@infradead.org>
 <87a5d0aibc.ffs@tglx>
 <dd06cd643ee7fa0be08ac3082cff443b8bfbfb58.camel@infradead.org>
 <874j38a16p.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874j38a16p.ffs@tglx>
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

On Fri, Dec 13, 2024 at 01:14:54AM +0100, Thomas Gleixner wrote:

> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7276,7 +7276,7 @@ void rt_mutex_setprio(struct task_struct
>  #if !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC)
>  int __sched __cond_resched(void)
>  {
> -	if (should_resched(0)) {
> +	if (should_resched(0) && system_state != SYSTEM_SUSPEND) {
>  		preempt_schedule_common();
>  		return 1;
>  	}

Perhaps we should just do:

	if (should_resched(0) && !irqs_disabled())

That's more or less what preemptible() does too. Yes, mucking about with
IF is expensive, but it's only done if preempt_count is agreeing we
should schedule, which it shouldn't be most of the time.

